Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA02C72B9E4
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 10:12:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231211AbjFLIL6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 04:11:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbjFLILo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 04:11:44 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5127F1710
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 01:11:17 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 48D862048A;
        Mon, 12 Jun 2023 08:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1686557467; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xV4SYDmBiLCrlA8jMqllOC2PAvpxHr16PxJlMbYYLgI=;
        b=zsIQ71rq6LIK8ESY0YiBFkDyypDrEO93ia1tdZfWVf6gwbLPLjGeR5d4dvKN4KX+fPHZbC
        /A/7Yjl+ZvOmGM+7uRnRFAhuzZ9NfyZHqsCIxUVPRBymq9u0ZRMNWqlnPsxPbnOIJv2HPY
        Hhjl8+OdLlV8JDUTwfW+HRoyQuXldZw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1686557467;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xV4SYDmBiLCrlA8jMqllOC2PAvpxHr16PxJlMbYYLgI=;
        b=eA9CuDzbO3W4/iQSsJF75R8BNkI0A65OXL1ZeM/+/PkSJ9O/O0bg+dWqw+MRu1uwM0Zqgq
        x+Z1uWZZB7a9A0Cg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2B3AC138EC;
        Mon, 12 Jun 2023 08:11:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 0PKICRvThmSLcAAAMHmgww
        (envelope-from <tiwai@suse.de>); Mon, 12 Jun 2023 08:11:07 +0000
From:   Takashi Iwai <tiwai@suse.de>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 09/10] ALSA: ump: Add info flag bit for static blocks
Date:   Mon, 12 Jun 2023 10:10:53 +0200
Message-Id: <20230612081054.17200-10-tiwai@suse.de>
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

UMP v1.1 spec allows to inform whether the function blocks are static
and not dynamically updated.  Add a new flag bit to
snd_ump_endpoint_info to reflect that attribute, too.

The flag is set when a USB MIDI device is still in the old MIDI 2.0
without UMP 1.1 support.  Then the driver falls back to GTBs, and they
are supposed to be static-only.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/uapi/sound/asound.h |  3 +++
 sound/core/ump.c            | 11 +++++++++++
 sound/usb/midi2.c           |  2 ++
 3 files changed, 16 insertions(+)

diff --git a/include/uapi/sound/asound.h b/include/uapi/sound/asound.h
index 79ee48b2ed6d..4d1ac0797d56 100644
--- a/include/uapi/sound/asound.h
+++ b/include/uapi/sound/asound.h
@@ -780,6 +780,9 @@ struct snd_rawmidi_status {
 };
 #endif
 
+/* UMP EP info flags */
+#define SNDRV_UMP_EP_INFO_STATIC_BLOCKS		0x01
+
 /* UMP EP Protocol / JRTS capability bits */
 #define SNDRV_UMP_EP_INFO_PROTO_MIDI_MASK	0x0300
 #define SNDRV_UMP_EP_INFO_PROTO_MIDI1		0x0100 /* MIDI 1.0 */
diff --git a/sound/core/ump.c b/sound/core/ump.c
index f364bb290d3a..a64dc2d8a129 100644
--- a/sound/core/ump.c
+++ b/sound/core/ump.c
@@ -490,6 +490,8 @@ static void snd_ump_proc_read(struct snd_info_entry *entry,
 			    ump->info.sw_revision[2],
 			    ump->info.sw_revision[3]);
 	}
+	snd_iprintf(buffer, "Static Blocks: %s\n",
+		    (ump->info.flags & SNDRV_UMP_EP_INFO_STATIC_BLOCKS) ? "Yes" : "No");
 	snd_iprintf(buffer, "Num Blocks: %d\n\n", ump->info.num_blocks);
 
 	list_for_each_entry(fb, &ump->block_list, list) {
@@ -608,6 +610,9 @@ static int ump_handle_ep_info_msg(struct snd_ump_endpoint *ump,
 		ump->info.num_blocks = 1;
 	}
 
+	if (buf->ep_info.static_function_block)
+		ump->info.flags |= SNDRV_UMP_EP_INFO_STATIC_BLOCKS;
+
 	ump->info.protocol_caps = (buf->ep_info.protocol << 8) |
 		buf->ep_info.jrts;
 
@@ -708,6 +713,12 @@ static bool is_fb_info_updated(struct snd_ump_endpoint *ump,
 {
 	char tmpbuf[offsetof(struct snd_ump_block_info, name)];
 
+	if (ump->info.flags & SNDRV_UMP_EP_INFO_STATIC_BLOCKS) {
+		ump_info(ump, "Skipping static FB info update (blk#%d)\n",
+			 fb->info.block_id);
+		return 0;
+	}
+
 	memcpy(tmpbuf, &fb->info, sizeof(tmpbuf));
 	fill_fb_info(ump, (struct snd_ump_block_info *)tmpbuf, buf);
 	return memcmp(&fb->info, tmpbuf, sizeof(tmpbuf)) != 0;
diff --git a/sound/usb/midi2.c b/sound/usb/midi2.c
index 13fa1978267a..ee2835741479 100644
--- a/sound/usb/midi2.c
+++ b/sound/usb/midi2.c
@@ -888,6 +888,8 @@ static int create_blocks_from_gtb(struct snd_usb_midi2_interface *umidi)
 		/* Blocks have been already created? */
 		if (rmidi->ump_parsed || rmidi->ump->info.num_blocks)
 			continue;
+		/* GTB is static-only */
+		rmidi->ump->info.flags |= SNDRV_UMP_EP_INFO_STATIC_BLOCKS;
 		/* loop over GTBs */
 		for (dir = 0; dir < 2; dir++) {
 			if (!rmidi->eps[dir])
-- 
2.35.3

