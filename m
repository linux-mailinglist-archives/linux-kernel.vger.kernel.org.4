Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B6BC70D62F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 09:56:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235310AbjEWH4L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 03:56:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236022AbjEWHzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 03:55:10 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4F73E46
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 00:54:47 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 54D5E21899;
        Tue, 23 May 2023 07:54:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1684828444; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6ktXHEJwRtSCCBPJ4QDB5v/NoMHF3eNfNjpM8JZRdSA=;
        b=wG/pLiU0OcYlgFzM6QRLr+INpJvf0m4Hz2GMDUZ23jkPN2DGYViq3c7pfiuDiTTWf4C5jp
        PKIuq/GvgVXqPKSbsXtMXMtz0k6eo/NtpNm3m+cMMRm6ewLEZbP6Hep6WL3Tw0dBN8y6kc
        pWQMefdPxRLLA6Gf0Skw9fiHSxNqiRQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1684828444;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6ktXHEJwRtSCCBPJ4QDB5v/NoMHF3eNfNjpM8JZRdSA=;
        b=DjW414mYwn4rBb2KkFpafnCmgs9VHPabazpjcceVa0rlAjGheDlavBsNoHm6ApXEUo6OB7
        uS0v3nxo3u116cAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F159613588;
        Tue, 23 May 2023 07:54:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 6P4GOhtxbGT4KgAAMHmgww
        (envelope-from <tiwai@suse.de>); Tue, 23 May 2023 07:54:03 +0000
From:   Takashi Iwai <tiwai@suse.de>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v2 06/37] ALSA: ump: Additional proc output
Date:   Tue, 23 May 2023 09:53:27 +0200
Message-Id: <20230523075358.9672-7-tiwai@suse.de>
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

UMP devices may have more interesting information than the traditional
rawmidi.  Extend the rawmidi_global_ops to allow the optional proc
info output and show some more bits in the proc file for UMP.

Note that the "Groups" field shows the first and the last UMP Groups,
and both numbers are 1-based (i.e. the first group is 1).

Reviewed-by: Jaroslav Kysela <perex@perex.cz>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/sound/rawmidi.h |  3 +++
 sound/core/rawmidi.c    |  2 ++
 sound/core/ump.c        | 49 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 54 insertions(+)

diff --git a/include/sound/rawmidi.h b/include/sound/rawmidi.h
index b8a230a7583b..b0197b1d1fe4 100644
--- a/include/sound/rawmidi.h
+++ b/include/sound/rawmidi.h
@@ -18,6 +18,7 @@
 #if IS_ENABLED(CONFIG_SND_SEQUENCER)
 #include <sound/seq_device.h>
 #endif
+#include <sound/info.h>
 
 /*
  *  Raw MIDI interface
@@ -49,6 +50,8 @@ struct snd_rawmidi_global_ops {
 			      struct snd_seq_port_info *info);
 	long (*ioctl)(struct snd_rawmidi *rmidi, unsigned int cmd,
 		      void __user *argp);
+	void (*proc_read)(struct snd_info_entry *entry,
+			  struct snd_info_buffer *buf);
 };
 
 struct snd_rawmidi_runtime {
diff --git a/sound/core/rawmidi.c b/sound/core/rawmidi.c
index ffb5b58105f4..2d3cec908154 100644
--- a/sound/core/rawmidi.c
+++ b/sound/core/rawmidi.c
@@ -1770,6 +1770,8 @@ static void snd_rawmidi_proc_info_read(struct snd_info_entry *entry,
 	if (IS_ENABLED(CONFIG_SND_UMP))
 		snd_iprintf(buffer, "Type: %s\n",
 			    rawmidi_is_ump(rmidi) ? "UMP" : "Legacy");
+	if (rmidi->ops->proc_read)
+		rmidi->ops->proc_read(entry, buffer);
 	mutex_lock(&rmidi->open_mutex);
 	if (rmidi->info_flags & SNDRV_RAWMIDI_INFO_OUTPUT) {
 		list_for_each_entry(substream,
diff --git a/sound/core/ump.c b/sound/core/ump.c
index ee57ba1ee989..651cd3752719 100644
--- a/sound/core/ump.c
+++ b/sound/core/ump.c
@@ -21,11 +21,14 @@ static int snd_ump_dev_register(struct snd_rawmidi *rmidi);
 static int snd_ump_dev_unregister(struct snd_rawmidi *rmidi);
 static long snd_ump_ioctl(struct snd_rawmidi *rmidi, unsigned int cmd,
 			  void __user *argp);
+static void snd_ump_proc_read(struct snd_info_entry *entry,
+			      struct snd_info_buffer *buffer);
 
 static const struct snd_rawmidi_global_ops snd_ump_rawmidi_ops = {
 	.dev_register = snd_ump_dev_register,
 	.dev_unregister = snd_ump_dev_unregister,
 	.ioctl = snd_ump_ioctl,
+	.proc_read = snd_ump_proc_read,
 };
 
 static void snd_ump_endpoint_free(struct snd_rawmidi *rmidi)
@@ -226,5 +229,51 @@ static long snd_ump_ioctl(struct snd_rawmidi *rmidi, unsigned int cmd,
 	}
 }
 
+static const char *ump_direction_string(int dir)
+{
+	switch (dir) {
+	case SNDRV_UMP_DIR_INPUT:
+		return "input";
+	case SNDRV_UMP_DIR_OUTPUT:
+		return "output";
+	case SNDRV_UMP_DIR_BIDIRECTION:
+		return "bidirection";
+	default:
+		return "unknown";
+	}
+}
+
+/* Additional proc file output */
+static void snd_ump_proc_read(struct snd_info_entry *entry,
+			      struct snd_info_buffer *buffer)
+{
+	struct snd_rawmidi *rmidi = entry->private_data;
+	struct snd_ump_endpoint *ump = rawmidi_to_ump(rmidi);
+	struct snd_ump_block *fb;
+
+	snd_iprintf(buffer, "EP Name: %s\n", ump->info.name);
+	snd_iprintf(buffer, "EP Product ID: %s\n", ump->info.product_id);
+	snd_iprintf(buffer, "UMP Version: 0x%04x\n", ump->info.version);
+	snd_iprintf(buffer, "Protocol Caps: 0x%08x\n", ump->info.protocol_caps);
+	snd_iprintf(buffer, "Protocol: 0x%08x\n", ump->info.protocol);
+	snd_iprintf(buffer, "Num Blocks: %d\n\n", ump->info.num_blocks);
+
+	list_for_each_entry(fb, &ump->block_list, list) {
+		snd_iprintf(buffer, "Block %d (%s)\n", fb->info.block_id,
+			    fb->info.name);
+		snd_iprintf(buffer, "  Direction: %s\n",
+			    ump_direction_string(fb->info.direction));
+		snd_iprintf(buffer, "  Active: %s\n",
+			    fb->info.active ? "Yes" : "No");
+		snd_iprintf(buffer, "  Groups: %d-%d\n",
+			    fb->info.first_group + 1,
+			    fb->info.first_group + fb->info.num_groups);
+		snd_iprintf(buffer, "  Is MIDI1: %s%s\n",
+			    (fb->info.flags & SNDRV_UMP_BLOCK_IS_MIDI1) ? "Yes" : "No",
+			    (fb->info.flags & SNDRV_UMP_BLOCK_IS_LOWSPEED) ? " (Low Speed)" : "");
+		snd_iprintf(buffer, "\n");
+	}
+}
+
 MODULE_DESCRIPTION("Universal MIDI Packet (UMP) Core Driver");
 MODULE_LICENSE("GPL");
-- 
2.35.3

