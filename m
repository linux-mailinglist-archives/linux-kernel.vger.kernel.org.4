Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78053709348
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 11:33:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231601AbjESJds (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 05:33:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231702AbjESJct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 05:32:49 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CF191BDA
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 02:31:53 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 495BC222AD;
        Fri, 19 May 2023 09:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1684488711; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RcWIeXWrYBHUEIxqRpzZGAcu6j9C5y95HK021lDlBG0=;
        b=IYwIW0F7nOSpvIa4GEhqGQgB1Dnwi8elbLFjWOBZyV5rwifXv3iiSMDzlzYum2EOXRSPVk
        L37yDq7AAiayeOQtwHrLUddnD8CTddSmTIqwIMjcM3FT5qvbVvMfDt0sZfSReNSbLkWIpR
        I9bjcCs4bgcYBTgL/jyP+PW+QKWCVc4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1684488711;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RcWIeXWrYBHUEIxqRpzZGAcu6j9C5y95HK021lDlBG0=;
        b=BQyqlF6d/CWma7X25oT/D/xKQo4Sf3KNbM4ZCunRmN2o159vewkh7R0JOFJ7SzHNths6nn
        ty74E3nQqL8HgeDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2203013A12;
        Fri, 19 May 2023 09:31:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id uIJUBwdCZ2RXJAAAMHmgww
        (envelope-from <tiwai@suse.de>); Fri, 19 May 2023 09:31:51 +0000
From:   Takashi Iwai <tiwai@suse.de>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 35/36] ALSA: seq: Add UMP group filter
Date:   Fri, 19 May 2023 11:31:13 +0200
Message-Id: <20230519093114.28813-36-tiwai@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230519093114.28813-1-tiwai@suse.de>
References: <20230519093114.28813-1-tiwai@suse.de>
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
index 8f416f5d0b4d..f6ee0fb62561 100644
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

