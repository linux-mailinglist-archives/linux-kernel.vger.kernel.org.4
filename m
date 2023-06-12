Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11D6472B9E5
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 10:12:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231451AbjFLIMR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 04:12:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230470AbjFLILz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 04:11:55 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3879127
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 01:11:28 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A9E7D2285A;
        Mon, 12 Jun 2023 08:11:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1686557466; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I6KYr/u9celHNicMRls6ca6HBb8F6AOw22BA86mBwCE=;
        b=CIHSVh8eZSkkMgg/EriCJCFO5abJAhOwEGYM24ucaA7/QgOBsUke7cPisM+oeg0lzDmXxN
        9EMDjU2grtLIbzx2VWBHfxEEpeQ9kru71nV0CjD6dCdtpqCX3RNBp0KN3AZlgy5vlqT9uf
        7zxfLDqLroiBPcU+fAgAVPTamHfyTs0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1686557466;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I6KYr/u9celHNicMRls6ca6HBb8F6AOw22BA86mBwCE=;
        b=S0kG8c+MftfduGRlYuAOEIZcg+PFxz+IWxwx5TPoWI1fnkDVbF32kX3JcFavZ3jRWK36zb
        qRSWQ4vAGEF7dpDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8A82A138EC;
        Mon, 12 Jun 2023 08:11:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id wDdqIBrThmSLcAAAMHmgww
        (envelope-from <tiwai@suse.de>); Mon, 12 Jun 2023 08:11:06 +0000
From:   Takashi Iwai <tiwai@suse.de>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 05/10] ALSA: seq: ump: Handle groupless messages
Date:   Mon, 12 Jun 2023 10:10:49 +0200
Message-Id: <20230612081054.17200-6-tiwai@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230612081054.17200-1-tiwai@suse.de>
References: <20230612081054.17200-1-tiwai@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The UMP Utility and Stream messages are "groupless", i.e. an incoming
groupless packet should be sent only to the UMP EP port, and the event
with the groupless message is sent to UMP EP as is without the group
translation per port.

Also, the former reserved bit 0 for the client group filter is now
used for groupless events.  When the bit 0 is set, the groupless
events are filtered out and skipped.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/sound/ump.h              | 3 +++
 include/uapi/sound/asequencer.h  | 5 ++++-
 sound/core/seq/seq_ump_client.c  | 5 ++++-
 sound/core/seq/seq_ump_convert.c | 3 +++
 4 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/include/sound/ump.h b/include/sound/ump.h
index aef4748842d0..5b50a2fc0d79 100644
--- a/include/sound/ump.h
+++ b/include/sound/ump.h
@@ -255,4 +255,7 @@ static inline u32 ump_stream_compose(unsigned char status, unsigned short form)
 		((u32)status << 16);
 }
 
+#define ump_is_groupless_msg(type) \
+	((type) == UMP_MSG_TYPE_UTILITY || (type) == UMP_MSG_TYPE_STREAM)
+
 #endif /* __SOUND_UMP_H */
diff --git a/include/uapi/sound/asequencer.h b/include/uapi/sound/asequencer.h
index 5e91243665d8..b5bc8604efe8 100644
--- a/include/uapi/sound/asequencer.h
+++ b/include/uapi/sound/asequencer.h
@@ -362,7 +362,10 @@ struct snd_seq_client_info {
 	int card;			/* RO: card number[kernel] */
 	int pid;			/* RO: pid[user] */
 	unsigned int midi_version;	/* MIDI version */
-	unsigned int group_filter;	/* UMP group filter bitmap (for 1-based Group indices) */
+	unsigned int group_filter;	/* UMP group filter bitmap
+					 * (bit 0 = groupless messages,
+					 *  bit 1-16 = messages for groups 1-16)
+					 */
 	char reserved[48];		/* for future use */
 };
 
diff --git a/sound/core/seq/seq_ump_client.c b/sound/core/seq/seq_ump_client.c
index e24833804094..7739fb3ebf34 100644
--- a/sound/core/seq/seq_ump_client.c
+++ b/sound/core/seq/seq_ump_client.c
@@ -73,7 +73,10 @@ static void seq_ump_input_receive(struct snd_ump_endpoint *ump,
 	if (!client->opened[STR_IN])
 		return;
 
-	ev.source.port = ump_group_to_seq_port(ump_message_group(*val));
+	if (ump_is_groupless_msg(ump_message_type(*val)))
+		ev.source.port = 0; /* UMP EP port */
+	else
+		ev.source.port = ump_group_to_seq_port(ump_message_group(*val));
 	ev.dest.client = SNDRV_SEQ_ADDRESS_SUBSCRIBERS;
 	ev.flags = SNDRV_SEQ_EVENT_UMP;
 	memcpy(ev.ump, val, words << 2);
diff --git a/sound/core/seq/seq_ump_convert.c b/sound/core/seq/seq_ump_convert.c
index 14ba6fed9dd1..eb1d86ff6166 100644
--- a/sound/core/seq/seq_ump_convert.c
+++ b/sound/core/seq/seq_ump_convert.c
@@ -534,6 +534,8 @@ static bool ump_event_filtered(struct snd_seq_client *dest,
 	unsigned char group;
 
 	group = ump_message_group(ev->ump[0]);
+	if (ump_is_groupless_msg(ump_message_type(ev->ump[0])))
+		return dest->group_filter & (1U << 0);
 	/* check the bitmap for 1-based group number */
 	return dest->group_filter & (1U << (group + 1));
 }
@@ -565,6 +567,7 @@ int snd_seq_deliver_from_ump(struct snd_seq_client *source,
 						      event, atomic, hop);
 		/* non-EP port and different group is set? */
 		if (dest_port->ump_group &&
+		    !ump_is_groupless_msg(type) &&
 		    ump_message_group(*ump_ev->ump) + 1 != dest_port->ump_group)
 			return deliver_with_group_convert(dest, dest_port,
 							  ump_ev, atomic, hop);
-- 
2.35.3

