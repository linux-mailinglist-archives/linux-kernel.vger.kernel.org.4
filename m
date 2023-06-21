Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D505738AAF
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 18:17:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbjFUQRZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 12:17:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbjFUQRX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 12:17:23 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 592CCE41
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 09:17:22 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-57067d70dbdso3950507b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 09:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687364241; x=1689956241;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KYwloKw/zbAlsa9lQrVpK5pQ/od6vSxRvyUVYTt/4jo=;
        b=KHtlbjYQ0Emeif6EIuQNzhCwOtyWtysACvGlhziOOIl384aWJTOrNamhlIXbh6GFFc
         SpnJSi83oRW8LUzGNWcCqG+WniBGksiag3LhCbkY8P97Q9KaDFtvJ4/q5F7MSQFZG+q1
         MRr7jFgbCVlBtIaVwuspkPIQD0hED4lEuTfR6RsmVladCkv7OVyx6KHSQWvDe828FHDy
         K+MCRqHt1zYRDfaSHk/9PEqYiUWiYplNP1oxGfwkr801ZFX3UOCz0sbSPez4MKSbj9Ua
         gl6v1F8W8hi8xKSE6d246eSzzQob+CjteCYcy57BGnDKbyz1ls9/gKhMZIJ+TkjljIec
         eo6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687364241; x=1689956241;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KYwloKw/zbAlsa9lQrVpK5pQ/od6vSxRvyUVYTt/4jo=;
        b=B/Ob7G4ssHbs5nsaWgvJX5myO0otPmGsCvPVgOShwbc34wXM+2vMPmCQLW1xafD4rI
         iNymGotBOchF0UcWsJNRsyQIZZ7vaCMOuXBH0Cp8yNA7qF8Gg8gm2QT6vDVoey//ScdG
         dx/bFh8ikMOO1xPnPdlco+Zqd1306doMy3EuchzaP6aFsIHr/OBFcJai83NbzyddZOYQ
         1sUPNUjkA3kLJ7fpSMqKn79bt1DsWRms5dUDoH3AclJUSqePrcdpD64OHyIlj4OBCuf/
         o3IBVxfCwuMwdutpipA+FxRtbOeIzIgJdbcz/JMkqKVNipuN4e2cQO6Fmqf3iT1IuzHZ
         yVPw==
X-Gm-Message-State: AC+VfDzGCagfCNA+9s4KKNzpWm7xOFLlwAkiH+KRjXTZIi7kGE9yrINt
        sAC7L/X9A8vqLExLYZS2HUk=
X-Google-Smtp-Source: ACHHUZ6H9dTC04NJhcZGhALZ1EVpUS5xuQh9w5HRkv1wevjbuobpZx/tQqmfepdwpw+HcwBL8hbKcw==
X-Received: by 2002:a81:7007:0:b0:56c:e6e9:6550 with SMTP id l7-20020a817007000000b0056ce6e96550mr8552187ywc.0.1687364241288;
        Wed, 21 Jun 2023 09:17:21 -0700 (PDT)
Received: from localhost.localdomain ([173.23.87.62])
        by smtp.gmail.com with ESMTPSA id u206-20020a8160d7000000b005668fcdaed8sm1218613ywb.74.2023.06.21.09.17.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 09:17:20 -0700 (PDT)
From:   Matthew Anderson <ruinairas1992@gmail.com>
To:     tiwai@suse.com
Cc:     perex@perex.cz, luke@ljones.dev, sbinding@opensource.cirrus.com,
        linux-kernel@vger.kernel.org,
        Matthew Anderson <ruinairas1992@gmail.com>
Subject: [PATCH v4] ALSA: hda/realtek: Add quirks for ROG ALLY CS35l41 audio
Date:   Wed, 21 Jun 2023 11:17:14 -0500
Message-ID: <20230621161714.9442-1-ruinairas1992@gmail.com>
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

Link: https://bugzilla.kernel.org/show_bug.cgi?id=217550

Signed-off-by: Matthew Anderson <ruinairas1992@gmail.com>
---
changes in v2:
  - Fixed indentation
changes in v3:
  - Adjusted code as advised
changes in v4:
  - Fold and resubmit
---
 sound/pci/hda/patch_realtek.c | 46 +++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 308ec7034cc9..75f64131b369 100644
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
+			{ 0x19, 0x03a11050 },
+			{ 0x1a, 0x03a11c30 },
+			{ 0x21, 0x03211420 },
+			{ }
+		},
+		.chained = true,
+		.chain_id = ALC294_FIXUP_ASUS_ALLY_VERBS
+	},
+	[ALC294_FIXUP_ASUS_ALLY_VERBS] = {
+		.type = HDA_FIXUP_VERBS,
+		.v.verbs = (const struct hda_verb[]) {
+			{ 0x20, AC_VERB_SET_COEF_INDEX, 0x45 },
+			{ 0x20, AC_VERB_SET_PROC_COEF, 0x5089 },
+			{ 0x20, AC_VERB_SET_COEF_INDEX, 0x46 },
+			{ 0x20, AC_VERB_SET_PROC_COEF, 0x0004 },
+			{ 0x20, AC_VERB_SET_COEF_INDEX, 0x47 },
+			{ 0x20, AC_VERB_SET_PROC_COEF, 0xa47a },
+			{ 0x20, AC_VERB_SET_COEF_INDEX, 0x49 },
+			{ 0x20, AC_VERB_SET_PROC_COEF, 0x0049},
+			{ 0x20, AC_VERB_SET_COEF_INDEX, 0x4a },
+			{ 0x20, AC_VERB_SET_PROC_COEF, 0x201b },
+			{ 0x20, AC_VERB_SET_COEF_INDEX, 0x6b },
+			{ 0x20, AC_VERB_SET_PROC_COEF, 0x4278},
+			{ }
+		},
+		.chained = true,
+		.chain_id = ALC294_FIXUP_ASUS_ALLY_SPEAKER
+	},
+	[ALC294_FIXUP_ASUS_ALLY_SPEAKER] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = alc285_fixup_speaker2_to_dac1,
+	},
 	[ALC285_FIXUP_THINKPAD_X1_GEN7] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = alc285_fixup_thinkpad_x1_gen7,
@@ -9534,6 +9579,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1043, 0x16e3, "ASUS UX50", ALC269_FIXUP_STEREO_DMIC),
 	SND_PCI_QUIRK(0x1043, 0x1740, "ASUS UX430UA", ALC295_FIXUP_ASUS_DACS),
 	SND_PCI_QUIRK(0x1043, 0x17d1, "ASUS UX431FL", ALC294_FIXUP_ASUS_DUAL_SPK),
+	SND_PCI_QUIRK(0x1043, 0x17f3, "ROG Ally RC71L_RC71L", ALC294_FIXUP_ASUS_ALLY),
 	SND_PCI_QUIRK(0x1043, 0x1881, "ASUS Zephyrus S/M", ALC294_FIXUP_ASUS_GX502_PINS),
 	SND_PCI_QUIRK(0x1043, 0x18b1, "Asus MJ401TA", ALC256_FIXUP_ASUS_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1043, 0x18f1, "Asus FX505DT", ALC256_FIXUP_ASUS_HEADSET_MIC),
-- 
2.41.0

