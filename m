Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF51168B148
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Feb 2023 19:56:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229490AbjBES4Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Feb 2023 13:56:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjBES4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Feb 2023 13:56:22 -0500
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15D6D14217
        for <linux-kernel@vger.kernel.org>; Sun,  5 Feb 2023 10:56:21 -0800 (PST)
Received: by mail-ed1-f44.google.com with SMTP id z11so9725071ede.1
        for <linux-kernel@vger.kernel.org>; Sun, 05 Feb 2023 10:56:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:organization:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2p1SoJMwlbMz8Nrd0d87nSFdZ7wcSJ8N1G//ABEtsDs=;
        b=F11S8SEzURHNAS0voZtQdTnLvZAPnGbGcKfGR0E+W8xuA50up0Y3uGNpUF/X58x37+
         IdNiFpj/V6xIJhtOoH9R4CGEARsqUvAhqm6B5SzpYPwCKQZ51ZB7OKizM3etcL+jTxaf
         VOoELPNROCiZ0ovvj3i7GmTZ/vj391J3YJD9MbactNsq8zZbIKbCm7EiCSk0iTsXG1B7
         MQD/67Lsdl6Wkb1GcZUP4uoCHEsa0UKPchR2RJhOpvL0EgqxP8ZA+yG5trj6mJLZuuoI
         FlByXWEZsih6ZVLcw/fG1Lcd1IEE/+o/CI3Et6QBcP3i+/ZN6UIsnXz3Wac8Xgoq20Lb
         oV2g==
X-Gm-Message-State: AO0yUKV+e0PTWLBrSfFPBbIxHD4OqBKdDR5F4AqDam60pRcqyA1panPJ
        Ux7lVwpgcU/cMVuiZLmu3RoFAybeOSIaIQ==
X-Google-Smtp-Source: AK7set9Y50d08GaUn9w3KlxV2cDDiJpab4I/f61f23gmKWO9ga898vqsu+HRrC8YG9c+nHuwAafTVQ==
X-Received: by 2002:a50:cd9e:0:b0:4aa:a4f3:49cc with SMTP id p30-20020a50cd9e000000b004aaa4f349ccmr4929042edi.13.1675623379582;
        Sun, 05 Feb 2023 10:56:19 -0800 (PST)
Received: from [192.168.3.157] ([81.56.10.57])
        by smtp.gmail.com with ESMTPSA id b11-20020aa7c6cb000000b004a986403dc1sm3682453eds.1.2023.02.05.10.56.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Feb 2023 10:56:19 -0800 (PST)
Message-ID: <4055cb48-e228-8a13-524d-afbb7aaafebe@kde.org>
Date:   Sun, 5 Feb 2023 19:56:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Content-Language: en-US
To:     tiwai@suse.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
From:   Elvis Angelaccio <elvis.angelaccio@kde.org>
Subject: [PATCH] ALSA: hda/realtek: Enable mute/micmute LEDs on HP Elitebook,
 645 G9
Organization: KDE
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The HP Elitebook 645 G9 laptop (with motherboard model 89D2) uses the
ALC236 codec and requires the alc236_fixup_hp_mute_led_micmute_vref
fixup in order to enable mute/micmute LEDs.

Note: the alc236_fixup_hp_gpio_led fixup, which is used by the Elitebook
640 G9, does not work with the 645 G9.

Signed-off-by: Elvis Angelaccio <elvis.angelaccio@kde.org>
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 4055a8f5880a..11bc71b152ff 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -9427,6 +9427,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x8aa0, "HP ProBook 440 G9 (MB 8A9E)", ALC236_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8aa3, "HP ProBook 450 G9 (MB 8AA1)", ALC236_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8aa8, "HP EliteBook 640 G9 (MB 8AA6)", ALC236_FIXUP_HP_GPIO_LED),
+	SND_PCI_QUIRK(0x103c, 0x89d3, "HP EliteBook 645 G9 (MB 89D2)", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
 	SND_PCI_QUIRK(0x103c, 0x8aab, "HP EliteBook 650 G9 (MB 8AA9)", ALC236_FIXUP_HP_GPIO_LED),
 	 SND_PCI_QUIRK(0x103c, 0x8abb, "HP ZBook Firefly 14 G9", ALC245_FIXUP_CS35L41_SPI_2_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8ad1, "HP EliteBook 840 14 inch G9 Notebook PC", ALC245_FIXUP_CS35L41_SPI_2_HP_GPIO_LED),
-- 
2.39.1
