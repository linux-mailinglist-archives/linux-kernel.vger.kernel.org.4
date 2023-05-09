Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D34346FCB7A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 18:39:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233530AbjEIQjD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 12:39:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233852AbjEIQiu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 12:38:50 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7A323AAE
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 09:38:48 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3f315712406so216627955e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 May 2023 09:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683650327; x=1686242327;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9PRwJ7afnhvG5N+v0cvD49y4wNVJ1gg0C5EbsfgsL+c=;
        b=IMMiCUBPTkIyKRnJ5FicSbkEMs32j4pjYtKqPIy85vw3TbM2OajKwDxFRae6bhkxJV
         GOTeLU7kgJMyVHcRGrjbDWLumZ+d17fhV9pc9gp6Erk4A4xnfnGsA6gAYHthgxCZsOHG
         xzIoFH68+/sz2zNfN8qhXHK+KIKBtGKFpuguBsXfIP3S+l+nAQ/0XE++rhWNbjrGqQqy
         XXIx25riM1OHU8A6WLMv0xp6QaM2XCNTFBk1V1kdwBRoRWLjiGyaxZxAH+MKNQiSRHiw
         Dkm/Vx6ZqknWBLScEJr3v1w3OUZvaYo1pVR9FsrcUQwEcodyk6KfARlNRb+4Z9jgMuNv
         s+RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683650327; x=1686242327;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9PRwJ7afnhvG5N+v0cvD49y4wNVJ1gg0C5EbsfgsL+c=;
        b=SMIReYppPCY1JStDRWgkbokR4IfergQQBLTqQjgtas+jQIdwUnseNIGo794huG1Xje
         cqotMKAuMklIf4o9mj/2lmw5h9u9eGWK2N7BImRXJsQfkx501q/ljo4OcJ97oHsiAzXs
         QqZXOS9eJJ4rDjt0TLpCS9BT6po7Yp0/ZlGAv/QSR+LdKn3YJjpKetAyqxIOFkYzZ7gR
         ypSiqOkUwuoaA6KwqK8T1UlVz8+hIw4/FGsiXbVnnP4lQjRW7Gr8WLakX0Kx3kWawXKs
         EMGo5SlQt8txlT2Q2z/RB6IgwqyMI5AsYZ6N+kOaw7TyJ3zwpGC28FyXMch72jIx3tC3
         Ibqg==
X-Gm-Message-State: AC+VfDxGzYEcvrk+AL7Mf+SJIsGWedKQq0D9y0SD6uXHqZwTNChqZHFF
        7cS2J/22YGtu/2vfSO03rJE=
X-Google-Smtp-Source: ACHHUZ6szIfcwpjYTBix40H57HaQDeT+mI/3tygZHWaU1auRMOIJo9upz3bX1rW7I8QsDRlowSeUpw==
X-Received: by 2002:a5d:680e:0:b0:307:9693:efe1 with SMTP id w14-20020a5d680e000000b003079693efe1mr5272677wru.18.1683650327277;
        Tue, 09 May 2023 09:38:47 -0700 (PDT)
Received: from localhost.localdomain ([2a02:2f0a:b207:af00::b5e])
        by smtp.gmail.com with ESMTPSA id u1-20020a5d4681000000b003062f894b64sm15097952wrq.22.2023.05.09.09.38.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 09:38:46 -0700 (PDT)
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
Subject: [PATCH 1/1] ALSA: hda/realtek: Add quirks for ASUS GU604V and GU603V
Date:   Tue,  9 May 2023 19:37:46 +0300
Message-Id: <20230509163746.6949-1-ealex95@gmail.com>
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
 sound/pci/hda/patch_realtek.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index bc062c0a1916..3689c0fca328 100644
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
@@ -9543,6 +9561,8 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1043, 0x8398, "ASUS P1005", ALC269_FIXUP_STEREO_DMIC),
 	SND_PCI_QUIRK(0x1043, 0x83ce, "ASUS P1005", ALC269_FIXUP_STEREO_DMIC),
 	SND_PCI_QUIRK(0x1043, 0x8516, "ASUS X101CH", ALC269_FIXUP_ASUS_X101),
+	SND_PCI_QUIRK(0x1043, 0x1473, "ASUS GU604V", ALC285_FIXUP_ASUS_HEADSET_MIC),
+	SND_PCI_QUIRK(0x1043, 0x1483, "ASUS GU603V", ALC285_FIXUP_ASUS_HEADSET_MIC),
 	SND_PCI_QUIRK(0x104d, 0x9073, "Sony VAIO", ALC275_FIXUP_SONY_VAIO_GPIO2),
 	SND_PCI_QUIRK(0x104d, 0x907b, "Sony VAIO", ALC275_FIXUP_SONY_HWEQ),
 	SND_PCI_QUIRK(0x104d, 0x9084, "Sony VAIO", ALC275_FIXUP_SONY_HWEQ),
-- 
2.40.1

