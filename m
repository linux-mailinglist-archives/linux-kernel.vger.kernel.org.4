Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 077F5709329
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 11:32:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231614AbjESJcT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 05:32:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231486AbjESJbm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 05:31:42 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F6ABE75
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 02:31:40 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 9B7C41FE3D;
        Fri, 19 May 2023 09:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1684488698; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/xY1PXIKgQoKZfhDbEDsNHHq6OQlJxBtxfki3i8O/8I=;
        b=JE9gSUd/2Z0GCV3yULP+OP35bx1YeVcmky1+aocFqxQi4Rp84z6uoETDMbnlxXflqGpI4D
        tXhnfjfU1TIu/0MYsIVxOGZHBugPlmwcpSVy2AENcZ/yJ4B22HZCcwMj/RVVYqjgCXWCL7
        Hsd9qRGhXHBofvnjfSwjFllZ9sr6CgE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1684488698;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/xY1PXIKgQoKZfhDbEDsNHHq6OQlJxBtxfki3i8O/8I=;
        b=WmJIhMPZgi2CKwleYTaKJlxX0lv706rEobLQTKShNbtzZ8lU1rkGwdE5zJcp7vbmubwYIL
        u38d9bL5Jg+gjfDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7BADE13A12;
        Fri, 19 May 2023 09:31:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id EEtGHfpBZ2RXJAAAMHmgww
        (envelope-from <tiwai@suse.de>); Fri, 19 May 2023 09:31:38 +0000
From:   Takashi Iwai <tiwai@suse.de>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 14/36] ALSA: usb-audio: Enable the legacy raw MIDI support
Date:   Fri, 19 May 2023 11:30:52 +0200
Message-Id: <20230519093114.28813-15-tiwai@suse.de>
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

Attach the legacy rawmidi devices when enabled in Kconfig accordingly.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/midi2.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/sound/usb/midi2.c b/sound/usb/midi2.c
index 3502a4b7fa41..f005de9f9b8a 100644
--- a/sound/usb/midi2.c
+++ b/sound/usb/midi2.c
@@ -856,6 +856,25 @@ static int create_blocks_from_gtb(struct snd_usb_midi2_interface *umidi)
 	return 0;
 }
 
+/* attach legacy rawmidis */
+static int attach_legacy_rawmidi(struct snd_usb_midi2_interface *umidi)
+{
+#if IS_ENABLED(CONFIG_SND_UMP_LEGACY_RAWMIDI)
+	struct snd_usb_midi2_ump *rmidi;
+	int err;
+
+	list_for_each_entry(rmidi, &umidi->rawmidi_list, list) {
+		err = snd_ump_attach_legacy_rawmidi(rmidi->ump,
+						    "Legacy MIDI",
+						    umidi->chip->num_rawmidis);
+		if (err < 0)
+			return err;
+		umidi->chip->num_rawmidis++;
+	}
+#endif
+	return 0;
+}
+
 static void snd_usb_midi_v2_free(struct snd_usb_midi2_interface *umidi)
 {
 	free_all_midi2_endpoints(umidi);
@@ -921,7 +940,7 @@ static int parse_midi_2_0(struct snd_usb_midi2_interface *umidi)
 		}
 	}
 
-	return 0;
+	return attach_legacy_rawmidi(umidi);
 }
 
 /* is the given interface for MIDI 2.0? */
@@ -990,6 +1009,12 @@ static void set_fallback_rawmidi_names(struct snd_usb_midi2_interface *umidi)
 			usb_string(dev, dev->descriptor.iSerialNumber,
 				   ump->info.product_id,
 				   sizeof(ump->info.product_id));
+#if IS_ENABLED(CONFIG_SND_UMP_LEGACY_RAWMIDI)
+		if (ump->legacy_rmidi && !*ump->legacy_rmidi->name)
+			snprintf(ump->legacy_rmidi->name,
+				 sizeof(ump->legacy_rmidi->name),
+				 "%s (MIDI 1.0)", ump->info.name);
+#endif
 	}
 }
 
-- 
2.35.3

