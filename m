Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A57B65623B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Dec 2022 12:43:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231840AbiLZLnV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Dec 2022 06:43:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbiLZLnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Dec 2022 06:43:19 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEAD7630F
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 03:43:16 -0800 (PST)
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 111874150C
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 11:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1672054995;
        bh=aRfghd24Gxy9oAEt3+RAeQ8YV+5xbmg27rAC6+YQkYs=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=SVjiPfNKLmnXagJ4gD/b7zb7Ftd14OZlchPczfX/57d49cgbhMej37MEf/C3/AyYi
         IKLOqj5fC7IP+rGVyQDonZt2uSGucGLqJh//YlELcmHEd/otHX11kb457J4KwlVuCZ
         5S+RzWYDYasYj6nENgcLslQmXXqpTkVs4GQDRvQZ62iFJqBZkSTy81jFwVLSKNR+mS
         uFNvNaflpBk7KmH4ESEVuYG1Wgfm3O2ykixdmcq2W1sCAVGYH8MFSpetBvVaZLVo0X
         iU+5sNdNCsXR7bBccSpw17iimUNcH3itOmw9f93vMM7vb84BEelfTa4+g2/+Tk5J3U
         pzEj0yVwtEWlA==
Received: by mail-pj1-f70.google.com with SMTP id me18-20020a17090b17d200b00219f8dc7cb3so9324242pjb.4
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 03:43:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aRfghd24Gxy9oAEt3+RAeQ8YV+5xbmg27rAC6+YQkYs=;
        b=MQCtF5FTD9zCnEm/7wawIHcTE6H4XrwhoTKITU1jzYRWCmDAZBtCNZCSyQM6iAYLrd
         XBVtq5JHa56AmPntjFsGTgWmmxXHH+B1P4xxbTUTHnBikYYagxuv1AHvVQzRScIDcXtB
         G2qgEYhomtexfk9CBnA7/08HiPhNUITDySTpg8XR2025kfFXU24JiJEt45+z1zU5eh5w
         sJvtyI7xH83veQnCmseJTa32mmlk0d+lXqHwWkcHi0J95F2Zied059q1kX65rizQqM5O
         +IDHNElhR8O0yJCOy5r39Pk29kpTLIrJUIul3pmA1UzFIjlVrvxiBT2zAxFsTIURR24+
         tb/Q==
X-Gm-Message-State: AFqh2kr1tC7EDKl9QZJwr2sV0XBZDpRlJI5r3JAOlf7r5cp92QPCabyY
        xpVY6jrdesRT3L8LEuEUu/iybvrIGB8Ro891JJ7oXnQlLh8NK/wjiQNhBWC1LXmvAza1FTwWsqt
        1oHTqyIO/7vWJtiepVCIrPlFIHIgR4/tamq+DHBnSSQ==
X-Received: by 2002:a62:5801:0:b0:574:a541:574a with SMTP id m1-20020a625801000000b00574a541574amr18945848pfb.0.1672054992244;
        Mon, 26 Dec 2022 03:43:12 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtUWSNiNVFkLMG6D3Z4UCGI5b6rucyXh1t6mqLduEu1ydiDkK2K8v2I//g7Qa7OLHyYXcwiew==
X-Received: by 2002:a62:5801:0:b0:574:a541:574a with SMTP id m1-20020a625801000000b00574a541574amr18945827pfb.0.1672054991803;
        Mon, 26 Dec 2022 03:43:11 -0800 (PST)
Received: from localhost.localdomain (220-136-203-167.dynamic-ip.hinet.net. [220.136.203.167])
        by smtp.gmail.com with ESMTPSA id t12-20020aa7946c000000b005769ccca18csm6739267pfq.85.2022.12.26.03.43.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Dec 2022 03:43:11 -0800 (PST)
From:   Chris Chiu <chris.chiu@canonical.com>
To:     tiwai@suse.com, perex@perex.cz
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Chris Chiu <chris.chiu@canonical.com>
Subject: [PATCH] ALSA: hda/realtek: Apply dual codec fixup for Dell Latitude laptops
Date:   Mon, 26 Dec 2022 19:43:03 +0800
Message-Id: <20221226114303.4027500-1-chris.chiu@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Dell Latiture 3340/3440/3540 laptops with Realtek ALC3204 have
dual codecs and need the ALC1220_FIXUP_GB_DUAL_CODECS to fix the
conflicts of Master controls. The existing headset mic fixup for
Dell is also required to enable the jack sense and the headset mic.

Introduce a new fixup to fix the dual codec and headset mic issues
for particular Dell laptops since other old Dell laptops with the
same codec configuration are already well handled by the fixup in
alc269_fallback_pin_fixup_tbl[].

Signed-off-by: Chris Chiu <chris.chiu@canonical.com>
---
 sound/pci/hda/patch_realtek.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index e443d88f627f..3794b522c222 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -7175,6 +7175,7 @@ enum {
 	ALC287_FIXUP_YOGA9_14IAP7_BASS_SPK,
 	ALC287_FIXUP_YOGA9_14IAP7_BASS_SPK_PIN,
 	ALC295_FIXUP_DELL_INSPIRON_TOP_SPEAKERS,
+	ALC236_FIXUP_DELL_DUAL_CODECS,
 };
 
 /* A special fixup for Lenovo C940 and Yoga Duet 7;
@@ -9130,6 +9131,12 @@ static const struct hda_fixup alc269_fixups[] = {
 		.chained = true,
 		.chain_id = ALC269_FIXUP_DELL4_MIC_NO_PRESENCE,
 	},
+	[ALC236_FIXUP_DELL_DUAL_CODECS] = {
+		.type = HDA_FIXUP_PINS,
+		.v.func = alc1220_fixup_gb_dual_codecs,
+		.chained = true,
+		.chain_id = ALC255_FIXUP_DELL1_MIC_NO_PRESENCE,
+	},
 };
 
 static const struct snd_pci_quirk alc269_fixup_tbl[] = {
@@ -9232,6 +9239,12 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1028, 0x0b1a, "Dell Precision 5570", ALC289_FIXUP_DUAL_SPK),
 	SND_PCI_QUIRK(0x1028, 0x0b37, "Dell Inspiron 16 Plus 7620 2-in-1", ALC295_FIXUP_DELL_INSPIRON_TOP_SPEAKERS),
 	SND_PCI_QUIRK(0x1028, 0x0b71, "Dell Inspiron 16 Plus 7620", ALC295_FIXUP_DELL_INSPIRON_TOP_SPEAKERS),
+	SND_PCI_QUIRK(0x1028, 0x0c19, "Dell Precision 3340", ALC236_FIXUP_DELL_DUAL_CODECS),
+	SND_PCI_QUIRK(0x1028, 0x0c1a, "Dell Precision 3340", ALC236_FIXUP_DELL_DUAL_CODECS),
+	SND_PCI_QUIRK(0x1028, 0x0c1b, "Dell Precision 3440", ALC236_FIXUP_DELL_DUAL_CODECS),
+	SND_PCI_QUIRK(0x1028, 0x0c1c, "Dell Precision 3540", ALC236_FIXUP_DELL_DUAL_CODECS),
+	SND_PCI_QUIRK(0x1028, 0x0c1d, "Dell Precision 3440", ALC236_FIXUP_DELL_DUAL_CODECS),
+	SND_PCI_QUIRK(0x1028, 0x0c1e, "Dell Precision 3540", ALC236_FIXUP_DELL_DUAL_CODECS),
 	SND_PCI_QUIRK(0x1028, 0x164a, "Dell", ALC293_FIXUP_DELL1_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1028, 0x164b, "Dell", ALC293_FIXUP_DELL1_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x103c, 0x1586, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC2),
-- 
2.25.1

