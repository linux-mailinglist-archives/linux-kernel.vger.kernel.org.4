Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11B6873780C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 01:55:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbjFTXzV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 19:55:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbjFTXzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 19:55:18 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA9D91720
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 16:55:17 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id af79cd13be357-76252a14c3aso48052085a.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 16:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687305317; x=1689897317;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qvYBTiphPPRPT5+hO9jZpKNPWRDv1tR24AaBUI4OCGk=;
        b=EoNzEKcfuajMaWketmFLMrGuE5EFlsy8C8mV3BIChxc8rJH2NVAvoFZgzb6WZN5ujG
         8NU4ZW6xpFmI+BnoqWlg/IEljocC7Yhc74xUwbfIYtBhh9xzY3XP+K9lrnGVSdv8dEJi
         JVLly1QgonZDSOxOZPygDueZZM7fHfC+pIP4YEhbkY4VXvIyW+/hQwthJaGMsrhm1soL
         9DTAnLnXckRssehi1hzJvVAUztXG9/mA/byJHxJ119AOLTQE9eOMoBH53mHmNtcwn4hL
         NLB/h2qYITSw5zZkg0j3XjFxQtmvISkdOSuhGoFayLbuAf5Mk0Fic7IObfVCW49AXEtC
         Vl1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687305317; x=1689897317;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qvYBTiphPPRPT5+hO9jZpKNPWRDv1tR24AaBUI4OCGk=;
        b=ge6UaOf0gX0Hutihyapny81QXpaE9whrzeakdzIiP391JENHgXtz4tmUeywVad6kkp
         AMDb+EHEx1NU3BjVdMzr//u9QDEDk3JAMZbx+2yrrnBHhJThFVLpyNRtQIU7HMWTNEnc
         aUDT8xXneiz7lHIDeyROZN6MXwiE5p3pFTSpepwfwDkHh5g8c0g1TY9eRYFyKIxQ6gxJ
         0KO86pFqIok1/k6rZPQ1ATZISyEXAkxCVz5oRTlCbXCFItLjVNBZAPUnbYHckFz/v1ol
         t6tcws6DX45PvFt+S4LLu/bvWJdvZUha/hP/Xv8q2+cHkvjXEmD61ZZyb/kKBKmtGuih
         wPlA==
X-Gm-Message-State: AC+VfDxUPriEjuKyy9eQXBsrWpxlYcnd6rsO2AJorE3bl6++7eTiwXEZ
        e6UbHrjUvDu2ELZi1ZO6itE14OfZhcE=
X-Google-Smtp-Source: ACHHUZ7+9hKYkH1JObUrjbFJ3bjNTQ8VbHWRH6P8+yF15Ygw8Jiquq7ZBX2XWSIWuYLmxi84dx3xug==
X-Received: by 2002:a05:620a:4901:b0:75b:23a1:82a3 with SMTP id ed1-20020a05620a490100b0075b23a182a3mr15869997qkb.4.1687305316747;
        Tue, 20 Jun 2023 16:55:16 -0700 (PDT)
Received: from localhost.localdomain ([173.23.87.62])
        by smtp.gmail.com with ESMTPSA id x7-20020a056902102700b00be8e8772025sm621009ybt.45.2023.06.20.16.55.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 16:55:16 -0700 (PDT)
From:   Matthew Anderson <ruinairas1992@gmail.com>
To:     tiwai@suse.com
Cc:     perex@perex.cz, luke@ljones.dev, sbinding@opensource.cirrus.com,
        linux-kernel@vger.kernel.org,
        Matthew Anderson <ruinairas1992@gmail.com>
Subject: [PATCH] ALSA: hda/realtek: Add quirks for Asus ROG Ally handheld using CS35L41
Date:   Tue, 20 Jun 2023 18:55:09 -0500
Message-ID: <20230620235509.35608-1-ruinairas1992@gmail.com>
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

This requires a patched ACPI table or a firmware from ASUS to work because
the system does not come with the _DSD field for the CSC3551.

Signed-off-by: Matthew Anderson <ruinairas1992@gmail.com>
---
 sound/pci/hda/patch_realtek.c | 46 +++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 308ec7034cc9..b918b0046144 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -7120,6 +7120,10 @@ enum {
 	ALC294_FIXUP_ASUS_DUAL_SPK,
 	ALC285_FIXUP_THINKPAD_X1_GEN7,
 	ALC285_FIXUP_THINKPAD_HEADSET_JACK,
+	ALC294_FIXUP_ASUS_ALLY,
+	ALC294_FIXUP_ASUS_ALLY_PINS,
+	ALC294_FIXUP_ASUS_ALLY_VERBS,
+	ALC294_FIXUP_ASUS_ALLY_SPEAKER,
 	ALC294_FIXUP_ASUS_HPE,
 	ALC294_FIXUP_ASUS_COEF_1B,
 	ALC294_FIXUP_ASUS_GX502_HP,
@@ -8432,6 +8436,47 @@ static const struct hda_fixup alc269_fixups[] = {
 		.chained = true,
 		.chain_id = ALC294_FIXUP_SPK2_TO_DAC1
 	},
+	[ALC294_FIXUP_ASUS_ALLY] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = cs35l41_fixup_i2c_two,
+		.chained = true,
+		.chain_id = ALC294_FIXUP_ASUS_ALLY_PINS
+	},
+	[ALC294_FIXUP_ASUS_ALLY_PINS] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = (const struct hda_pintbl[]) {
+						{ 0x19, 0x03a11050 },
+						{ 0x1a, 0x03a11C30 },
+						{ 0x21, 0x03211420 },
+						{ }
+				},
+		.chained = true,
+		.chain_id = ALC294_FIXUP_ASUS_ALLY_VERBS
+	},
+	[ALC294_FIXUP_ASUS_ALLY_VERBS] = {
+		.type = HDA_FIXUP_VERBS,
+		.v.verbs = (const struct hda_verb[]) {
+						{ 0x20, AC_VERB_SET_COEF_INDEX, 0x45 },
+						{ 0x20, AC_VERB_SET_PROC_COEF, 0x5089 },
+						{ 0x20, AC_VERB_SET_COEF_INDEX, 0x46 },
+						{ 0x20, AC_VERB_SET_PROC_COEF, 0x0004 },
+						{ 0x20, AC_VERB_SET_COEF_INDEX, 0x47 },
+						{ 0x20, AC_VERB_SET_PROC_COEF, 0xA47A },
+						{ 0x20, AC_VERB_SET_COEF_INDEX, 0x49 },
+						{ 0x20, AC_VERB_SET_PROC_COEF, 0x0049},
+						{ 0x20, AC_VERB_SET_COEF_INDEX, 0x4A },
+						{ 0x20, AC_VERB_SET_PROC_COEF, 0x201B },
+						{ 0x20, AC_VERB_SET_COEF_INDEX, 0x6B },
+						{ 0x20, AC_VERB_SET_PROC_COEF, 0x4278},
+						{ }
+				},
+				.chained = true,
+				.chain_id = ALC294_FIXUP_ASUS_ALLY_SPEAKER
+		},
+	[ALC294_FIXUP_ASUS_ALLY_SPEAKER] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = alc285_fixup_speaker2_to_dac1,
+	},
 	[ALC285_FIXUP_THINKPAD_X1_GEN7] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = alc285_fixup_thinkpad_x1_gen7,
@@ -9596,6 +9641,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x10ec, 0x1254, "Intel Reference board", ALC295_FIXUP_CHROME_BOOK),
 	SND_PCI_QUIRK(0x10ec, 0x12cc, "Intel Reference board", ALC225_FIXUP_HEADSET_JACK),
 	SND_PCI_QUIRK(0x10f7, 0x8338, "Panasonic CF-SZ6", ALC269_FIXUP_HEADSET_MODE),
+	SND_PCI_QUIRK(0x1043, 0x17F3, "ROG Ally RC71L_RC71L", ALC294_FIXUP_ASUS_ALLY),
 	SND_PCI_QUIRK(0x144d, 0xc109, "Samsung Ativ book 9 (NP900X3G)", ALC269_FIXUP_INV_DMIC),
 	SND_PCI_QUIRK(0x144d, 0xc169, "Samsung Notebook 9 Pen (NP930SBE-K01US)", ALC298_FIXUP_SAMSUNG_AMP),
 	SND_PCI_QUIRK(0x144d, 0xc176, "Samsung Notebook 9 Pro (NP930MBE-K04US)", ALC298_FIXUP_SAMSUNG_AMP),
-- 
2.41.0

