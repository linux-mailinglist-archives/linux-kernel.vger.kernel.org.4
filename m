Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2928E70D64B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 09:57:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235917AbjEWH5Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 03:57:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235950AbjEWH4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 03:56:36 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BD85E62
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 00:55:35 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 1A9282041C;
        Tue, 23 May 2023 07:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1684828453; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XrdrP+yuN0II5OmsQTVnDce1vkjWRPxSiCWtpTAImdg=;
        b=ANv1bQjXnsPP6hkBDMqHs/qa0Lc37QZWFnBG0dqiMXOK/J9QG8Zvfa27CrVg7EqpNspp0w
        GWQ35Q09+7Lhzmio82j731JBxOGdYfY4CTuPlAzWG7UPXvYd9Ow+uv/WJiBUWBfXOnkRxF
        YqBm+f2Kpj4fzEt9sNylDVxWQ4Gi8XY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1684828453;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XrdrP+yuN0II5OmsQTVnDce1vkjWRPxSiCWtpTAImdg=;
        b=G9/3BtnHol/dTW/u7vmcUZmt7iU38fZJ2MS5qBjlLRkBwvmA9KBVGk7T7TCPe8Y7+a1usb
        yxBqUGtAi89dBoBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CE3C413A1A;
        Tue, 23 May 2023 07:54:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id CP32MCRxbGT4KgAAMHmgww
        (envelope-from <tiwai@suse.de>); Tue, 23 May 2023 07:54:12 +0000
From:   Takashi Iwai <tiwai@suse.de>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v2 36/37] ALSA: seq: Add UMP group filter
Date:   Tue, 23 May 2023 09:53:57 +0200
Message-Id: <20230523075358.9672-37-tiwai@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230523075358.9672-1-tiwai@suse.de>
References: <20230523075358.9672-1-tiwai@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new filter bitmap for UMP groups for reducing the unnecessary
read/write when the client is connected to UMP EP seq port.

The new group_filter field contains the bitmap for the groups, i.e.
when the bit is set, the corresponding group is filtered out and
the messages to that group won't be delivered.

The filter bitmap consists of each bit of 1-based UMP Group number.
The bit 0 is reserved for the future use.

Reviewed-by: Jaroslav Kysela <perex@perex.cz>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/uapi/sound/asequencer.h  |  3 ++-
 sound/core/seq/seq_clientmgr.c   |  2 ++
 sound/core/seq/seq_clientmgr.h   |  1 +
 sound/core/seq/seq_ump_convert.c | 13 +++++++++++++
 4 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/include/uapi/sound/asequencer.h b/include/uapi/sound/asequencer.h
index c75f594f21e3..5e91243665d8 100644
--- a/include/uapi/sound/asequencer.h
+++ b/include/uapi/sound/asequencer.h
@@ -362,7 +362,8 @@ struct snd_seq_client_info {
 	int card;			/* RO: card number[kernel] */
 	int pid;			/* RO: pid[user] */
 	unsigned int midi_version;	/* MIDI version */
-	char reserved[52];		/* for future use */
+	unsigned int group_filter;	/* UMP group filter bitmap (for 1-based Group indices) */
+	char reserved[48];		/* for future use */
 };
 
 /* MIDI version numbers in client info */
diff --git a/sound/core/seq/seq_clientmgr.c b/sound/core/seq/seq_clientmgr.c
index 8cce8061ca55..948ae45e0cc3 100644
--- a/sound/core/seq/seq_clientmgr.c
+++ b/sound/core/seq/seq_clientmgr.c
@@ -1229,6 +1229,7 @@ static void get_client_info(struct snd_seq_client *cptr,
 	info->filter = cptr->filter;
 	info->event_lost = cptr->event_lost;
 	memcpy(info->event_filter, cptr->event_filter, 32);
+	info->group_filter = cptr->group_filter;
 	info->num_ports = cptr->num_ports;
 
 	if (cptr->type == USER_CLIENT)
@@ -1290,6 +1291,7 @@ static int snd_seq_ioctl_set_client_info(struct snd_seq_client *client,
 	if (client->user_pversion >= SNDRV_PROTOCOL_VERSION(1, 0, 3))
 		client->midi_version = client_info->midi_version;
 	memcpy(client->event_filter, client_info->event_filter, 32);
+	client->group_filter = client_info->group_filter;
 	return 0;
 }
 
diff --git a/sound/core/seq/seq_clientmgr.h b/sound/core/seq/seq_clientmgr.h
index be3fe555f233..915b1017286e 100644
--- a/sound/core/seq/seq_clientmgr.h
+++ b/sound/core/seq/seq_clientmgr.h
@@ -40,6 +40,7 @@ struct snd_seq_client {
 	int number;		/* client number */
 	unsigned int filter;	/* filter flags */
 	DECLARE_BITMAP(event_filter, 256);
+	unsigned short group_filter;
 	snd_use_lock_t use_lock;
 	int event_lost;
 	/* ports */
diff --git a/sound/core/seq/seq_ump_convert.c b/sound/core/seq/seq_ump_convert.c
index 433fe842947e..14ba6fed9dd1 100644
--- a/sound/core/seq/seq_ump_convert.c
+++ b/sound/core/seq/seq_ump_convert.c
@@ -527,6 +527,17 @@ static int deliver_with_group_convert(struct snd_seq_client *dest,
 					      atomic, hop);
 }
 
+/* apply the UMP event filter; return true to skip the event */
+static bool ump_event_filtered(struct snd_seq_client *dest,
+			       const struct snd_seq_ump_event *ev)
+{
+	unsigned char group;
+
+	group = ump_message_group(ev->ump[0]);
+	/* check the bitmap for 1-based group number */
+	return dest->group_filter & (1U << (group + 1));
+}
+
 /* Convert from UMP packet and deliver */
 int snd_seq_deliver_from_ump(struct snd_seq_client *source,
 			     struct snd_seq_client *dest,
@@ -539,6 +550,8 @@ int snd_seq_deliver_from_ump(struct snd_seq_client *source,
 
 	if (snd_seq_ev_is_variable(event))
 		return 0; // skip, no variable event for UMP, so far
+	if (ump_event_filtered(dest, ump_ev))
+		return 0; // skip if group filter is set and matching
 	type = ump_message_type(ump_ev->ump[0]);
 
 	if (snd_seq_client_is_ump(dest)) {
-- 
2.35.3

