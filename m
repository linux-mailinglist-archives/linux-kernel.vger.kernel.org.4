Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53936737D79
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 10:39:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230297AbjFUIi3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 04:38:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjFUIi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 04:38:28 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FE3D10E6
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 01:38:26 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id ca18e2360f4ac-7748ca56133so45230439f.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 01:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687336706; x=1689928706;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IHtjxAmb7B7SArMbO/Kvh4i1mid7QPAVHxWWvv4k3+E=;
        b=W9v3g5jUjBMy691gY+wM3sf1dUWu7Mld1lCobuFZna8Vb2kB6Ur+iN5jNNvCZrbdB8
         yqQMm53PP1gunHIXs2utZyekTplRS8i7IeUEMgnQhha9IQ7TiYTK0r/+q4Ot98510Hz0
         rmJrYPsh1bJxeH7oCtvpwF5QyrjIia64puFVUd9XGhUveCXOQ1az6+2li7ZFlh6z6N/1
         leDb8MVIuTEiQRHQ8fuucYOHAOJ2P/ssU8zhgH7dOSt9qvMFm+77Ncb6dddnYFB0OodK
         2ubtqYp3NpBLzgFj8zwlqnonzOehDpxO0dVKbwk5uVtn4tdEU+tSOwzYroNpS4eN1y3Y
         fS0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687336706; x=1689928706;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IHtjxAmb7B7SArMbO/Kvh4i1mid7QPAVHxWWvv4k3+E=;
        b=br7RChBJ3I1o65p1EfMivpidRP1URoYh27C09Ihefdi39Oog1Bp2PkjcI3KlyKkayl
         lIVfy1KnsBpFgN5oLDigUeoVjyl0oTqTK83adV9D8Euv3jTpb9heLKXuKTuKYJG7HlYy
         CtdOUsH7PZ9unpgpvG1WQGoOhiOpUmMttgvfylpjiOOL1caVT9gkuBFiE7fwEXinOd+d
         bqN3BU8pu5XfYWE0FVmtK95fPhiga3jIK9rWUas71MUIuMfb4+aO03aGXmsSY1jt9kte
         XRR1xvORTZ/+W6FWM2YqLh4bzvZtFuGV13fAP8XtQLq3ZhwfwTakTeasyaWmCuJnC/mm
         v2ag==
X-Gm-Message-State: AC+VfDzAT2VHl8P88LtKeYay5gq99GeXq9N5mj+QB0mQw0ld5GL0Negt
        Xfa9LeFZIcz0gEEDfg0+aM4=
X-Google-Smtp-Source: ACHHUZ40yNj6e0bMA8yt1Uilvns4XS/HDvKUVeba5qgqeUj2010RrurjLjkflir640BHHiIxn5X7jw==
X-Received: by 2002:a05:6e02:349f:b0:342:26c7:1708 with SMTP id bp31-20020a056e02349f00b0034226c71708mr10117972ilb.3.1687336705839;
        Wed, 21 Jun 2023 01:38:25 -0700 (PDT)
Received: from localhost.localdomain (63.sub-174-255-1.myvzw.com. [174.255.1.63])
        by smtp.gmail.com with ESMTPSA id z12-20020a92cecc000000b003428aca64bdsm1177348ilq.84.2023.06.21.01.38.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 01:38:25 -0700 (PDT)
From:   Matthew Anderson <ruinairas1992@gmail.com>
To:     tiwai@suse.com
Cc:     perex@perex.cz, luke@ljones.dev, sbinding@opensource.cirrus.com,
        linux-kernel@vger.kernel.org,
        Matthew Anderson <ruinairas1992@gmail.com>
Subject: [PATCH v3] ALSA: hda/realtek: Add quirks for ROG ALLY CS35l41 audio
Date:   Wed, 21 Jun 2023 03:38:14 -0500
Message-ID: <20230621083814.76334-1-ruinairas1992@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed the nitputs as requested

Signed-off-by: Matthew Anderson <ruinairas1992@gmail.com>
---
 sound/pci/hda/patch_realtek.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index a3981160b745..75f64131b369 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -8446,7 +8446,7 @@ static const struct hda_fixup alc269_fixups[] = {
 		.type = HDA_FIXUP_PINS,
 		.v.pins = (const struct hda_pintbl[]) {
 			{ 0x19, 0x03a11050 },
-			{ 0x1a, 0x03a11C30 },
+			{ 0x1a, 0x03a11c30 },
 			{ 0x21, 0x03211420 },
 			{ }
 		},
@@ -8461,12 +8461,12 @@ static const struct hda_fixup alc269_fixups[] = {
 			{ 0x20, AC_VERB_SET_COEF_INDEX, 0x46 },
 			{ 0x20, AC_VERB_SET_PROC_COEF, 0x0004 },
 			{ 0x20, AC_VERB_SET_COEF_INDEX, 0x47 },
-			{ 0x20, AC_VERB_SET_PROC_COEF, 0xA47A },
+			{ 0x20, AC_VERB_SET_PROC_COEF, 0xa47a },
 			{ 0x20, AC_VERB_SET_COEF_INDEX, 0x49 },
 			{ 0x20, AC_VERB_SET_PROC_COEF, 0x0049},
-			{ 0x20, AC_VERB_SET_COEF_INDEX, 0x4A },
-			{ 0x20, AC_VERB_SET_PROC_COEF, 0x201B },
-			{ 0x20, AC_VERB_SET_COEF_INDEX, 0x6B },
+			{ 0x20, AC_VERB_SET_COEF_INDEX, 0x4a },
+			{ 0x20, AC_VERB_SET_PROC_COEF, 0x201b },
+			{ 0x20, AC_VERB_SET_COEF_INDEX, 0x6b },
 			{ 0x20, AC_VERB_SET_PROC_COEF, 0x4278},
 			{ }
 		},
@@ -9579,6 +9579,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1043, 0x16e3, "ASUS UX50", ALC269_FIXUP_STEREO_DMIC),
 	SND_PCI_QUIRK(0x1043, 0x1740, "ASUS UX430UA", ALC295_FIXUP_ASUS_DACS),
 	SND_PCI_QUIRK(0x1043, 0x17d1, "ASUS UX431FL", ALC294_FIXUP_ASUS_DUAL_SPK),
+	SND_PCI_QUIRK(0x1043, 0x17f3, "ROG Ally RC71L_RC71L", ALC294_FIXUP_ASUS_ALLY),
 	SND_PCI_QUIRK(0x1043, 0x1881, "ASUS Zephyrus S/M", ALC294_FIXUP_ASUS_GX502_PINS),
 	SND_PCI_QUIRK(0x1043, 0x18b1, "Asus MJ401TA", ALC256_FIXUP_ASUS_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1043, 0x18f1, "Asus FX505DT", ALC256_FIXUP_ASUS_HEADSET_MIC),
@@ -9641,7 +9642,6 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x10ec, 0x1254, "Intel Reference board", ALC295_FIXUP_CHROME_BOOK),
 	SND_PCI_QUIRK(0x10ec, 0x12cc, "Intel Reference board", ALC225_FIXUP_HEADSET_JACK),
 	SND_PCI_QUIRK(0x10f7, 0x8338, "Panasonic CF-SZ6", ALC269_FIXUP_HEADSET_MODE),
-	SND_PCI_QUIRK(0x1043, 0x17F3, "ROG Ally RC71L_RC71L", ALC294_FIXUP_ASUS_ALLY),
 	SND_PCI_QUIRK(0x144d, 0xc109, "Samsung Ativ book 9 (NP900X3G)", ALC269_FIXUP_INV_DMIC),
 	SND_PCI_QUIRK(0x144d, 0xc169, "Samsung Notebook 9 Pen (NP930SBE-K01US)", ALC298_FIXUP_SAMSUNG_AMP),
 	SND_PCI_QUIRK(0x144d, 0xc176, "Samsung Notebook 9 Pro (NP930MBE-K04US)", ALC298_FIXUP_SAMSUNG_AMP),
-- 
2.41.0

