Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECA2F6FF6E1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 18:15:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238622AbjEKQPY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 12:15:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238150AbjEKQPW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 12:15:22 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FC5F1FCC
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 09:15:21 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-50bc22805d3so13464086a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 09:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683821719; x=1686413719;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1aLFylek1nRr29niLBba+aU+lTWwRvz+crv9/jvyTVY=;
        b=b0fgib3Qb+R9WwiEGKsu02MNyBz6T+MDKV6ZV63it1tjIu1KnS9h+5d2xNZqksCS/h
         cs5nhOwLa6NSx9eAFg1c7dmYuCiUWCT+vfM68V/caR1QgVeKBOMqBcumjDSWkd8+dXit
         1ypmtiFeZB82MHs07GJcUC+2w3TWLo7erI562o7sOOiaOQG3EmJlZH0UPBtGpHeXwjUD
         jtVXmxo3RqeXxGtT6oPFMiWCfUyHbqBbpowoo9XxDnonXox7AApqCSDIHThc2pKmFQka
         MCUMQwTi5azkOq2shk5pQH9g8+w96SSI0ht73pjyw0yw6xhJNDEN1ltpaS0jkDOKtBeR
         eiHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683821719; x=1686413719;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1aLFylek1nRr29niLBba+aU+lTWwRvz+crv9/jvyTVY=;
        b=SZmwNDY5ucYtCshIuUP8eG+WyIqJFWY+LABa5dx0xGRPyot6nI99k8mrI93E2dpvtb
         IGmCNJRBMrwWZ3/DbzDU8FjUs4U8//ffMf5Zg/OyqOuexfMtGH7TBWTZAcjK2v0HMGhP
         aJsQaXbjZl8TGI7UmateBfpZZF3eYDaiV9XRCMBqmjB0M/F7Zi/Gp34qHzijGV9KfDvR
         XHYrFEhLUJ0zNBrjBQggTOBov9+pjJO1ZLJUZAerE+UdLLRou5e6CDC6Un4qO0NQkgSV
         T2Cjb0PIk8T1HKYSa/5GXqIOK/w3SlJPmz4S3zfnywX71XzcJ/I8yRxx0j/S1npxCp7w
         loog==
X-Gm-Message-State: AC+VfDwVm2c3m+Ii3mp5fdor9kyjbKzLQriOEftf2UVshuLifDUyourZ
        wpyfHPHPVORPC3oYg5TO0to=
X-Google-Smtp-Source: ACHHUZ4MBTYqjmy2urC4b8enhRmflW2Lb0rqrX1C351MXcWfwV8pjGIzhlDmFzNtlq8JbF4XeZ4+vg==
X-Received: by 2002:a50:ed99:0:b0:504:8929:71ca with SMTP id h25-20020a50ed99000000b00504892971camr18032424edr.6.1683821719398;
        Thu, 11 May 2023 09:15:19 -0700 (PDT)
Received: from localhost.localdomain ([2a02:2f0a:b207:af00::b5e])
        by smtp.gmail.com with ESMTPSA id f8-20020a056402068800b0050bc9c38fb4sm2992219edy.69.2023.05.11.09.15.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 09:15:18 -0700 (PDT)
From:   Alexandru Sorodoc <ealex95@gmail.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     Stefan Binding <sbinding@opensource.cirrus.com>,
        Tim Crawford <tcrawford@system76.com>,
        Andy Chi <andy.chi@canonical.com>,
        Meng Tang <tangmeng@uniontech.com>,
        "Luke D. Jones" <luke@ljones.dev>,
        Philipp Jungkamp <p.jungkamp@gmx.net>,
        =?UTF-8?q?Kacper=20Michaj=C5=82ow?= <kasper93@gmail.com>,
        Yuchi Yang <yangyuchi66@gmail.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Alexandru Sorodoc <ealex95@gmail.com>
Subject: [PATCH v2] ALSA: hda/realtek: Add quirks for ASUS GU604V and GU603V
Date:   Thu, 11 May 2023 19:15:10 +0300
Message-Id: <20230511161510.315170-1-ealex95@gmail.com>
X-Mailer: git-send-email 2.40.1
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

These models use 2 CS35L41 amplifiers using SPI for down-facing
speakers.

alc285_fixup_speaker2_to_dac1 is needed to fix volume control of the
down-facing speakers.

Pin configs are needed to enable headset mic detection.

Note that these models lack the ACPI _DSD properties needed to
initialize the amplifiers. They can be added during boot to get working
sound out of the speakers:
  https://gist.github.com/lamperez/862763881c0e1c812392b5574727f6ff

Signed-off-by: Alexandru Sorodoc <ealex95@gmail.com>
---
v2:
    Fixed position of quirk entries in table

 sound/pci/hda/patch_realtek.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index bc062c0a1916..4c87a95c5d3d 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -7063,6 +7063,8 @@ enum {
 	ALC225_FIXUP_DELL1_MIC_NO_PRESENCE,
 	ALC295_FIXUP_DISABLE_DAC3,
 	ALC285_FIXUP_SPEAKER2_TO_DAC1,
+	ALC285_FIXUP_ASUS_SPEAKER2_TO_DAC1,
+	ALC285_FIXUP_ASUS_HEADSET_MIC,
 	ALC280_FIXUP_HP_HEADSET_MIC,
 	ALC221_FIXUP_HP_FRONT_MIC,
 	ALC292_FIXUP_TPT460,
@@ -8033,6 +8035,22 @@ static const struct hda_fixup alc269_fixups[] = {
 		.chained = true,
 		.chain_id = ALC269_FIXUP_THINKPAD_ACPI
 	},
+	[ALC285_FIXUP_ASUS_SPEAKER2_TO_DAC1] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = alc285_fixup_speaker2_to_dac1,
+		.chained = true,
+		.chain_id = ALC245_FIXUP_CS35L41_SPI_2
+	},
+	[ALC285_FIXUP_ASUS_HEADSET_MIC] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = (const struct hda_pintbl[]) {
+			{ 0x19, 0x03a11050 },
+			{ 0x1b, 0x03a11c30 },
+			{ }
+		},
+		.chained = true,
+		.chain_id = ALC285_FIXUP_ASUS_SPEAKER2_TO_DAC1
+	},
 	[ALC256_FIXUP_DELL_INSPIRON_7559_SUBWOOFER] = {
 		.type = HDA_FIXUP_PINS,
 		.v.pins = (const struct hda_pintbl[]) {
@@ -9500,6 +9518,8 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1043, 0x1313, "Asus K42JZ", ALC269VB_FIXUP_ASUS_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1043, 0x13b0, "ASUS Z550SA", ALC256_FIXUP_ASUS_MIC),
 	SND_PCI_QUIRK(0x1043, 0x1427, "Asus Zenbook UX31E", ALC269VB_FIXUP_ASUS_ZENBOOK),
+	SND_PCI_QUIRK(0x1043, 0x1473, "ASUS GU604V", ALC285_FIXUP_ASUS_HEADSET_MIC),
+	SND_PCI_QUIRK(0x1043, 0x1483, "ASUS GU603V", ALC285_FIXUP_ASUS_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1043, 0x1517, "Asus Zenbook UX31A", ALC269VB_FIXUP_ASUS_ZENBOOK_UX31A),
 	SND_PCI_QUIRK(0x1043, 0x1662, "ASUS GV301QH", ALC294_FIXUP_ASUS_DUAL_SPK),
 	SND_PCI_QUIRK(0x1043, 0x1683, "ASUS UM3402YAR", ALC287_FIXUP_CS35L41_I2C_2),
-- 
2.40.1

