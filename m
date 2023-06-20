Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A55A7737776
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 00:27:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbjFTW16 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 18:27:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbjFTW1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 18:27:54 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0C7D173F
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 15:27:52 -0700 (PDT)
Received: from localhost (unknown [188.27.34.213])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: cristicc)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 7DA8C6606F70;
        Tue, 20 Jun 2023 23:27:51 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1687300071;
        bh=ySaaRuf0YxKRdkILyJHmqoCwfptq1Xrue2J0JYrw0F4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CN+qrRhjql9jWIRKd6ej9ZbQuADjjef6nYEvuz6Z22k88O1AilgvwNIFabL+3juvI
         ui6V6/1DuMfeUZGhmRzN1Jek3XYMRfoiTiEqI3+pEPi9OhMnQmmTDGGapHKIKOQzWQ
         SK1s//MjeQaKKdw8x0gx7LlWPRhxXo0nugM2tYztiMXm7K5QRBxVTpuJekgVefSx6l
         zXlSwbtuRQAwbw/XtYBdVrwTAoLVVb+L7qjGJ+c8MnL0s/ehBIHgVu7AOZjddARfF3
         2oDrfGvk7d+DsOhc7HSMuai/Q01splYuhB1I7MliVeTe4nWSVYVozhQBNxWTH9riVy
         LI3bEklh+0orQ==
From:   Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Syed Saba Kareem <Syed.SabaKareem@amd.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Randy Dunlap <rdunlap@infradead.org>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Venkata Prasad Potturu <venkataprasad.potturu@amd.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Subject: [PATCH 1/2] ASoC: amd: vangogh: Add ACPI probe support
Date:   Wed, 21 Jun 2023 01:27:42 +0300
Message-ID: <20230620222743.274432-2-cristian.ciocaltea@collabora.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230620222743.274432-1-cristian.ciocaltea@collabora.com>
References: <20230620222743.274432-1-cristian.ciocaltea@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the acp5x machine driver from pci-acp5x child devices and enable
probing via ACPI match table.

Co-developed-by: Lucas Tanure <lucas.tanure@collabora.com>
Signed-off-by: Lucas Tanure <lucas.tanure@collabora.com>
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 sound/soc/amd/vangogh/acp5x-mach.c | 39 +++++++++---------------------
 sound/soc/amd/vangogh/acp5x.h      |  2 +-
 sound/soc/amd/vangogh/pci-acp5x.c  |  3 ---
 3 files changed, 12 insertions(+), 32 deletions(-)

diff --git a/sound/soc/amd/vangogh/acp5x-mach.c b/sound/soc/amd/vangogh/acp5x-mach.c
index e5bcd1e6eb73..1b54eadc4979 100644
--- a/sound/soc/amd/vangogh/acp5x-mach.c
+++ b/sound/soc/amd/vangogh/acp5x-mach.c
@@ -22,7 +22,6 @@
 
 #define DRV_NAME			"acp5x_mach"
 #define DUAL_CHANNEL			2
-#define VG_JUPITER			1
 #define ACP5X_NAU8821_BCLK		3072000
 #define ACP5X_NAU8821_FREQ_OUT		12288000
 #define ACP5X_NAU8821_COMP_NAME 	"i2c-NVTN2020:00"
@@ -31,7 +30,6 @@
 #define ACP5X_CS35L41_COMP_RNAME	"spi-VLV1776:01"
 #define ACP5X_CS35L41_DAI_NAME		"cs35l41-pcm"
 
-static unsigned long acp5x_machine_id;
 static struct snd_soc_jack vg_headset;
 
 SND_SOC_DAILINK_DEF(platform,  DAILINK_COMP_ARRAY(COMP_PLATFORM("acp5x_i2s_dma.0")));
@@ -331,24 +329,6 @@ static struct snd_soc_card acp5x_8821_35l41_card = {
 	.num_controls = ARRAY_SIZE(acp5x_8821_controls),
 };
 
-static int acp5x_vg_quirk_cb(const struct dmi_system_id *id)
-{
-	acp5x_machine_id = VG_JUPITER;
-
-	return 1;
-}
-
-static const struct dmi_system_id acp5x_vg_quirk_table[] = {
-	{
-		.callback = acp5x_vg_quirk_cb,
-		.matches = {
-			DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "Valve"),
-			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "Jupiter"),
-		}
-	},
-	{}
-};
-
 static int acp5x_probe(struct platform_device *pdev)
 {
 	struct acp5x_platform_info *machine;
@@ -356,18 +336,14 @@ static int acp5x_probe(struct platform_device *pdev)
 	struct snd_soc_card *card;
 	int ret;
 
+	card = (struct snd_soc_card *)device_get_match_data(dev);
+	if (!card)
+		return -EINVAL;
+
 	machine = devm_kzalloc(dev, sizeof(*machine), GFP_KERNEL);
 	if (!machine)
 		return -ENOMEM;
 
-	dmi_check_system(acp5x_vg_quirk_table);
-	switch (acp5x_machine_id) {
-	case VG_JUPITER:
-		card = &acp5x_8821_35l41_card;
-		break;
-	default:
-		return -ENODEV;
-	}
 	card->dev = dev;
 	platform_set_drvdata(pdev, card);
 	snd_soc_card_set_drvdata(card, machine);
@@ -379,10 +355,17 @@ static int acp5x_probe(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct acpi_device_id acp5x_acpi_match[] = {
+	{ "AMDI3541", (kernel_ulong_t)&acp5x_8821_35l41_card },
+	{},
+};
+MODULE_DEVICE_TABLE(acpi, acp5x_acpi_match);
+
 static struct platform_driver acp5x_mach_driver = {
 	.driver = {
 		.name = "acp5x_mach",
 		.pm = &snd_soc_pm_ops,
+		.acpi_match_table = acp5x_acpi_match,
 	},
 	.probe = acp5x_probe,
 };
diff --git a/sound/soc/amd/vangogh/acp5x.h b/sound/soc/amd/vangogh/acp5x.h
index ac1936a8c43f..2d9b182af109 100644
--- a/sound/soc/amd/vangogh/acp5x.h
+++ b/sound/soc/amd/vangogh/acp5x.h
@@ -23,7 +23,7 @@
 #define ACP_ERR_INTR_MASK	0x20000000
 #define ACP_EXT_INTR_STAT_CLEAR_MASK 0xFFFFFFFF
 
-#define ACP5x_DEVS 4
+#define ACP5x_DEVS 3
 #define	ACP5x_REG_START	0x1240000
 #define	ACP5x_REG_END	0x1250200
 #define ACP5x_I2STDM_REG_START	0x1242400
diff --git a/sound/soc/amd/vangogh/pci-acp5x.c b/sound/soc/amd/vangogh/pci-acp5x.c
index c4634a8a17cd..ab2fcb34518f 100644
--- a/sound/soc/amd/vangogh/pci-acp5x.c
+++ b/sound/soc/amd/vangogh/pci-acp5x.c
@@ -222,9 +222,6 @@ static int snd_acp5x_probe(struct pci_dev *pci,
 		pdevinfo[2].num_res = 1;
 		pdevinfo[2].res = &adata->res[2];
 
-		pdevinfo[3].name = "acp5x_mach";
-		pdevinfo[3].id = 0;
-		pdevinfo[3].parent = &pci->dev;
 		for (i = 0; i < ACP5x_DEVS; i++) {
 			adata->pdev[i] =
 				platform_device_register_full(&pdevinfo[i]);
-- 
2.41.0

