Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1910F6D54FF
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 00:56:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233742AbjDCW40 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 18:56:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbjDCW4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 18:56:24 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 790EDA8;
        Mon,  3 Apr 2023 15:56:21 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id br6so40012251lfb.11;
        Mon, 03 Apr 2023 15:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680562580;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=w29PTw7vHa3KuKIiVf86IL9HO22btbcPZLZt0ooIpTs=;
        b=kDyt9HwhLXczsm4zXGxsFhrzJ3lgbONR408B8OqNeTwDLQn/+6+u+eNkyQ/aAjDSul
         qE25bzEKo6VjAON56SBzCsd7rtFpCDLkp3aXFizqfGJquj9zHA+gMwjn7f2KY1XK/E5H
         vbTeiKXoLvCWzJwMggkvtqbV5xKBG0TRwwbBmfRJr4p0BWVoLkHRdnU7JW8jKzCq3QCc
         Y50PWi2i7eCd1uRT84z8ft2M8XGrjI/iND2iVfkPFmYM4felgEvM+wHZZCTxcKospdSv
         YWDGukGzvvaBhP1guKAFhm7DalEpTU1LQVY+NMXyY/n7sgD8TdpLi/vnv6SLGM7piduS
         zg3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680562580;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w29PTw7vHa3KuKIiVf86IL9HO22btbcPZLZt0ooIpTs=;
        b=2JxMPXpX7eMYePb1LNj+LVeZofpNDpno7TGPXvr2BrOAqHG+yJ34y04CsC0GC/UdhR
         6jbiWzpc2nvg7ccadtAAnbJhFZCkTkIH7vJ/uI9zLhb32zu7EymwjWZHsJrI0QHqnzlU
         DKk+9u16qkKyYbB0idPVdjxnjBqDGvkrHMXZ8biyuSIqzy/RENCwDIbLJhhjWmZ+5zCN
         TbO3HO1hsOQupJvo9Tm1/heUu1yHRvTpSnnrQs2c4ZehpOCmggqM8KI5sP2fhATql6on
         rvARi3qsHZCcYmC09KgpKhTHAEQMNu4ntDt9CIfKBgGD3Uw/YbQRYn5RY5JIzQdZ6vXN
         4niw==
X-Gm-Message-State: AAQBX9dhd4/t/FTd0vu18Swm/CTiO2+ftVmWB4+mPFuh9FQwQ5HrlT1V
        GM/a4QpIq7jPLpQiP9Cdt2k=
X-Google-Smtp-Source: AKy350ZRUCFYFPdRzK/GpkNqgtO9Ys9HehG/eegPHamEScfJ0Cs9km35wF3hJlhKE8aWkxbZihD6KA==
X-Received: by 2002:ac2:5541:0:b0:4dd:af71:a5c3 with SMTP id l1-20020ac25541000000b004ddaf71a5c3mr48589lfk.58.1680562579536;
        Mon, 03 Apr 2023 15:56:19 -0700 (PDT)
Received: from localhost.lan (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.gmail.com with ESMTPSA id q5-20020ac25145000000b004e95f1c9e7dsm1972853lfd.78.2023.04.03.15.56.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 15:56:19 -0700 (PDT)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Vincent Shih <vincent.sunplus@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Evgeniy Polyakov <zbr@ioremap.net>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-sunxi@lists.linux.dev, linux-rtc@vger.kernel.org,
        Michael Walle <michael@walle.cc>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH V4] nvmem: add explicit config option to read old syntax fixed OF cells
Date:   Tue,  4 Apr 2023 00:55:40 +0200
Message-Id: <20230403225540.1931-1-zajec5@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafał Miłecki <rafal@milecki.pl>

Binding for fixed NVMEM cells defined directly as NVMEM device subnodes
has been deprecated. It has been replaced by the "fixed-layout" NVMEM
layout binding.

New syntax is meant to be clearer and should help avoiding imprecise
bindings.

NVMEM subsystem already supports the new binding. It should be a good
idea to limit support for old syntax to existing drivers that actually
support & use it (we can't break backward compatibility!). That way we
additionally encourage new bindings & drivers to ignore deprecated
binding.

It wasn't clear (to me) if rtc and w1 code actually uses old syntax
fixed cells. I enabled them to don't risk any breakage.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
[for meson-{efuse,mx-efuse}.c]
Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
[for mtk-efuse.c, nvmem/core.c, nvmem-provider.h]
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
[MT8192, MT8195 Chromebooks]
Tested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
[for microchip-otpc.c]
Reviewed-by: Claudiu Beznea <claudiu.beznea@microchip.com>
[SAMA7G5-EK]
Tested-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
This is based on top of them
[PATCH V6 3/3] nvmem: core: add support for fixed cells *layout*

V2: Fix stm32-romem.c typo breaking its compilation
    Pick Martin's Acked-by
    Add paragraph about layouts deprecating add_legacy_fixed_of_cells
V3: Update commit description:
    1. Make it clear we're NOT dropping fixed cells support
    2. Use nicer words (s/made sense/was totally safe/)
    3. Explain fixed cells layout thing
    4. Add paragraph with purpose of this commit
V4: Completely rewrite commit message.
    Rename config option to "add_legacy_fixed_of_cells".
---
 drivers/mtd/mtdcore.c          | 2 ++
 drivers/nvmem/apple-efuses.c   | 1 +
 drivers/nvmem/core.c           | 8 +++++---
 drivers/nvmem/imx-ocotp-scu.c  | 1 +
 drivers/nvmem/imx-ocotp.c      | 1 +
 drivers/nvmem/meson-efuse.c    | 1 +
 drivers/nvmem/meson-mx-efuse.c | 1 +
 drivers/nvmem/microchip-otpc.c | 1 +
 drivers/nvmem/mtk-efuse.c      | 1 +
 drivers/nvmem/qcom-spmi-sdam.c | 1 +
 drivers/nvmem/qfprom.c         | 1 +
 drivers/nvmem/rave-sp-eeprom.c | 1 +
 drivers/nvmem/rockchip-efuse.c | 1 +
 drivers/nvmem/sc27xx-efuse.c   | 1 +
 drivers/nvmem/sprd-efuse.c     | 1 +
 drivers/nvmem/stm32-romem.c    | 1 +
 drivers/nvmem/sunplus-ocotp.c  | 1 +
 drivers/nvmem/sunxi_sid.c      | 1 +
 drivers/nvmem/uniphier-efuse.c | 1 +
 drivers/nvmem/zynqmp_nvmem.c   | 1 +
 drivers/rtc/nvmem.c            | 1 +
 drivers/w1/slaves/w1_ds250x.c  | 1 +
 include/linux/nvmem-provider.h | 2 ++
 23 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
index 60670b2f70b9..334adbae3690 100644
--- a/drivers/mtd/mtdcore.c
+++ b/drivers/mtd/mtdcore.c
@@ -522,6 +522,7 @@ static int mtd_nvmem_add(struct mtd_info *mtd)
 	config.dev = &mtd->dev;
 	config.name = dev_name(&mtd->dev);
 	config.owner = THIS_MODULE;
+	config.add_legacy_fixed_of_cells = of_device_is_compatible(node, "nvmem-cells");
 	config.reg_read = mtd_nvmem_reg_read;
 	config.size = mtd->size;
 	config.word_size = 1;
@@ -889,6 +890,7 @@ static struct nvmem_device *mtd_otp_nvmem_register(struct mtd_info *mtd,
 	config.name = compatible;
 	config.id = NVMEM_DEVID_AUTO;
 	config.owner = THIS_MODULE;
+	config.add_legacy_fixed_of_cells = true;
 	config.type = NVMEM_TYPE_OTP;
 	config.root_only = true;
 	config.ignore_wp = true;
diff --git a/drivers/nvmem/apple-efuses.c b/drivers/nvmem/apple-efuses.c
index 9b7c87102104..d3d49d22338b 100644
--- a/drivers/nvmem/apple-efuses.c
+++ b/drivers/nvmem/apple-efuses.c
@@ -36,6 +36,7 @@ static int apple_efuses_probe(struct platform_device *pdev)
 	struct resource *res;
 	struct nvmem_config config = {
 		.dev = &pdev->dev,
+		.add_legacy_fixed_of_cells = true,
 		.read_only = true,
 		.reg_read = apple_efuses_read,
 		.stride = sizeof(u32),
diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index b3d5a29477f9..80c1d0a30a26 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -994,9 +994,11 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
 	if (rval)
 		goto err_remove_cells;
 
-	rval = nvmem_add_cells_from_legacy_of(nvmem);
-	if (rval)
-		goto err_remove_cells;
+	if (config->add_legacy_fixed_of_cells) {
+		rval = nvmem_add_cells_from_legacy_of(nvmem);
+		if (rval)
+			goto err_remove_cells;
+	}
 
 	dev_dbg(&nvmem->dev, "Registering nvmem device %s\n", config->name);
 
diff --git a/drivers/nvmem/imx-ocotp-scu.c b/drivers/nvmem/imx-ocotp-scu.c
index 399e1eb8b4c1..899e9108a521 100644
--- a/drivers/nvmem/imx-ocotp-scu.c
+++ b/drivers/nvmem/imx-ocotp-scu.c
@@ -220,6 +220,7 @@ static int imx_scu_ocotp_write(void *context, unsigned int offset,
 
 static struct nvmem_config imx_scu_ocotp_nvmem_config = {
 	.name = "imx-scu-ocotp",
+	.add_legacy_fixed_of_cells = true,
 	.read_only = false,
 	.word_size = 4,
 	.stride = 1,
diff --git a/drivers/nvmem/imx-ocotp.c b/drivers/nvmem/imx-ocotp.c
index ac0edb6398f1..0f7531a7e15d 100644
--- a/drivers/nvmem/imx-ocotp.c
+++ b/drivers/nvmem/imx-ocotp.c
@@ -621,6 +621,7 @@ static int imx_ocotp_probe(struct platform_device *pdev)
 		return PTR_ERR(priv->clk);
 
 	priv->params = of_device_get_match_data(&pdev->dev);
+	imx_ocotp_nvmem_config.add_legacy_fixed_of_cells = true;
 	imx_ocotp_nvmem_config.size = 4 * priv->params->nregs;
 	imx_ocotp_nvmem_config.dev = dev;
 	imx_ocotp_nvmem_config.priv = priv;
diff --git a/drivers/nvmem/meson-efuse.c b/drivers/nvmem/meson-efuse.c
index d6b533497ce1..b922df99f9bc 100644
--- a/drivers/nvmem/meson-efuse.c
+++ b/drivers/nvmem/meson-efuse.c
@@ -93,6 +93,7 @@ static int meson_efuse_probe(struct platform_device *pdev)
 
 	econfig->dev = dev;
 	econfig->name = dev_name(dev);
+	econfig->add_legacy_fixed_of_cells = true;
 	econfig->stride = 1;
 	econfig->word_size = 1;
 	econfig->reg_read = meson_efuse_read;
diff --git a/drivers/nvmem/meson-mx-efuse.c b/drivers/nvmem/meson-mx-efuse.c
index 13eb14316f46..34a911696155 100644
--- a/drivers/nvmem/meson-mx-efuse.c
+++ b/drivers/nvmem/meson-mx-efuse.c
@@ -213,6 +213,7 @@ static int meson_mx_efuse_probe(struct platform_device *pdev)
 	efuse->config.owner = THIS_MODULE;
 	efuse->config.dev = &pdev->dev;
 	efuse->config.priv = efuse;
+	efuse->config.add_legacy_fixed_of_cells = true;
 	efuse->config.stride = drvdata->word_size;
 	efuse->config.word_size = drvdata->word_size;
 	efuse->config.size = SZ_512;
diff --git a/drivers/nvmem/microchip-otpc.c b/drivers/nvmem/microchip-otpc.c
index 436e0dc4f337..7cf81738a3e0 100644
--- a/drivers/nvmem/microchip-otpc.c
+++ b/drivers/nvmem/microchip-otpc.c
@@ -261,6 +261,7 @@ static int mchp_otpc_probe(struct platform_device *pdev)
 		return ret;
 
 	mchp_nvmem_config.dev = otpc->dev;
+	mchp_nvmem_config.add_legacy_fixed_of_cells = true;
 	mchp_nvmem_config.size = size;
 	mchp_nvmem_config.priv = otpc;
 	nvmem = devm_nvmem_register(&pdev->dev, &mchp_nvmem_config);
diff --git a/drivers/nvmem/mtk-efuse.c b/drivers/nvmem/mtk-efuse.c
index b36cd0dcc8c7..87c94686cfd2 100644
--- a/drivers/nvmem/mtk-efuse.c
+++ b/drivers/nvmem/mtk-efuse.c
@@ -83,6 +83,7 @@ static int mtk_efuse_probe(struct platform_device *pdev)
 		return PTR_ERR(priv->base);
 
 	pdata = device_get_match_data(dev);
+	econfig.add_legacy_fixed_of_cells = true;
 	econfig.stride = 1;
 	econfig.word_size = 1;
 	econfig.reg_read = mtk_reg_read;
diff --git a/drivers/nvmem/qcom-spmi-sdam.c b/drivers/nvmem/qcom-spmi-sdam.c
index f822790db49e..be618ba8b550 100644
--- a/drivers/nvmem/qcom-spmi-sdam.c
+++ b/drivers/nvmem/qcom-spmi-sdam.c
@@ -142,6 +142,7 @@ static int sdam_probe(struct platform_device *pdev)
 	sdam->sdam_config.name = "spmi_sdam";
 	sdam->sdam_config.id = NVMEM_DEVID_AUTO;
 	sdam->sdam_config.owner = THIS_MODULE;
+	sdam->sdam_config.add_legacy_fixed_of_cells = true;
 	sdam->sdam_config.stride = 1;
 	sdam->sdam_config.word_size = 1;
 	sdam->sdam_config.reg_read = sdam_read;
diff --git a/drivers/nvmem/qfprom.c b/drivers/nvmem/qfprom.c
index c1e893c8a247..e4dacde70fdd 100644
--- a/drivers/nvmem/qfprom.c
+++ b/drivers/nvmem/qfprom.c
@@ -357,6 +357,7 @@ static int qfprom_probe(struct platform_device *pdev)
 {
 	struct nvmem_config econfig = {
 		.name = "qfprom",
+		.add_legacy_fixed_of_cells = true,
 		.stride = 1,
 		.word_size = 1,
 		.id = NVMEM_DEVID_AUTO,
diff --git a/drivers/nvmem/rave-sp-eeprom.c b/drivers/nvmem/rave-sp-eeprom.c
index c456011b75e8..75d98fd25cb6 100644
--- a/drivers/nvmem/rave-sp-eeprom.c
+++ b/drivers/nvmem/rave-sp-eeprom.c
@@ -328,6 +328,7 @@ static int rave_sp_eeprom_probe(struct platform_device *pdev)
 	of_property_read_string(np, "zii,eeprom-name", &config.name);
 	config.priv		= eeprom;
 	config.dev		= dev;
+	config.add_legacy_fixed_of_cells	= true;
 	config.size		= size;
 	config.reg_read		= rave_sp_eeprom_reg_read;
 	config.reg_write	= rave_sp_eeprom_reg_write;
diff --git a/drivers/nvmem/rockchip-efuse.c b/drivers/nvmem/rockchip-efuse.c
index e4579de5d014..adc8bc70cffa 100644
--- a/drivers/nvmem/rockchip-efuse.c
+++ b/drivers/nvmem/rockchip-efuse.c
@@ -205,6 +205,7 @@ static int rockchip_rk3399_efuse_read(void *context, unsigned int offset,
 
 static struct nvmem_config econfig = {
 	.name = "rockchip-efuse",
+	.add_legacy_fixed_of_cells = true,
 	.stride = 1,
 	.word_size = 1,
 	.read_only = true,
diff --git a/drivers/nvmem/sc27xx-efuse.c b/drivers/nvmem/sc27xx-efuse.c
index c825fc902d10..8d13b81d5250 100644
--- a/drivers/nvmem/sc27xx-efuse.c
+++ b/drivers/nvmem/sc27xx-efuse.c
@@ -248,6 +248,7 @@ static int sc27xx_efuse_probe(struct platform_device *pdev)
 	econfig.reg_read = sc27xx_efuse_read;
 	econfig.priv = efuse;
 	econfig.dev = &pdev->dev;
+	econfig.add_legacy_fixed_of_cells = true;
 	nvmem = devm_nvmem_register(&pdev->dev, &econfig);
 	if (IS_ERR(nvmem)) {
 		dev_err(&pdev->dev, "failed to register nvmem config\n");
diff --git a/drivers/nvmem/sprd-efuse.c b/drivers/nvmem/sprd-efuse.c
index 4f1fcbfec394..ffc0cbfe87b3 100644
--- a/drivers/nvmem/sprd-efuse.c
+++ b/drivers/nvmem/sprd-efuse.c
@@ -408,6 +408,7 @@ static int sprd_efuse_probe(struct platform_device *pdev)
 	econfig.read_only = false;
 	econfig.name = "sprd-efuse";
 	econfig.size = efuse->data->blk_nums * SPRD_EFUSE_BLOCK_WIDTH;
+	econfig.add_legacy_fixed_of_cells = true;
 	econfig.reg_read = sprd_efuse_read;
 	econfig.reg_write = sprd_efuse_write;
 	econfig.priv = efuse;
diff --git a/drivers/nvmem/stm32-romem.c b/drivers/nvmem/stm32-romem.c
index 38d0bf557129..a44c2d6c20f9 100644
--- a/drivers/nvmem/stm32-romem.c
+++ b/drivers/nvmem/stm32-romem.c
@@ -208,6 +208,7 @@ static int stm32_romem_probe(struct platform_device *pdev)
 	priv->cfg.priv = priv;
 	priv->cfg.owner = THIS_MODULE;
 	priv->cfg.type = NVMEM_TYPE_OTP;
+	priv->cfg.add_legacy_fixed_of_cells = true;
 
 	priv->lower = 0;
 
diff --git a/drivers/nvmem/sunplus-ocotp.c b/drivers/nvmem/sunplus-ocotp.c
index 52b928a7a6d5..1b6632fb81ea 100644
--- a/drivers/nvmem/sunplus-ocotp.c
+++ b/drivers/nvmem/sunplus-ocotp.c
@@ -145,6 +145,7 @@ static int sp_ocotp_read(void *priv, unsigned int offset, void *value, size_t by
 
 static struct nvmem_config sp_ocotp_nvmem_config = {
 	.name = "sp-ocotp",
+	.add_legacy_fixed_of_cells = true,
 	.read_only = true,
 	.word_size = 1,
 	.size = QAC628_OTP_SIZE,
diff --git a/drivers/nvmem/sunxi_sid.c b/drivers/nvmem/sunxi_sid.c
index a970f1741cc6..155f07afd9cc 100644
--- a/drivers/nvmem/sunxi_sid.c
+++ b/drivers/nvmem/sunxi_sid.c
@@ -156,6 +156,7 @@ static int sunxi_sid_probe(struct platform_device *pdev)
 	nvmem_cfg->dev = dev;
 	nvmem_cfg->name = "sunxi-sid";
 	nvmem_cfg->type = NVMEM_TYPE_OTP;
+	nvmem_cfg->add_legacy_fixed_of_cells = true;
 	nvmem_cfg->read_only = true;
 	nvmem_cfg->size = cfg->size;
 	nvmem_cfg->word_size = 1;
diff --git a/drivers/nvmem/uniphier-efuse.c b/drivers/nvmem/uniphier-efuse.c
index aca910b3b6f8..d16ed22d105c 100644
--- a/drivers/nvmem/uniphier-efuse.c
+++ b/drivers/nvmem/uniphier-efuse.c
@@ -53,6 +53,7 @@ static int uniphier_efuse_probe(struct platform_device *pdev)
 	econfig.size = resource_size(res);
 	econfig.priv = priv;
 	econfig.dev = dev;
+	econfig.add_legacy_fixed_of_cells = true;
 	nvmem = devm_nvmem_register(dev, &econfig);
 
 	return PTR_ERR_OR_ZERO(nvmem);
diff --git a/drivers/nvmem/zynqmp_nvmem.c b/drivers/nvmem/zynqmp_nvmem.c
index e28d7b133e11..23cceb823cd0 100644
--- a/drivers/nvmem/zynqmp_nvmem.c
+++ b/drivers/nvmem/zynqmp_nvmem.c
@@ -58,6 +58,7 @@ static int zynqmp_nvmem_probe(struct platform_device *pdev)
 
 	priv->dev = dev;
 	econfig.dev = dev;
+	econfig.add_legacy_fixed_of_cells = true;
 	econfig.reg_read = zynqmp_nvmem_read;
 	econfig.priv = priv;
 
diff --git a/drivers/rtc/nvmem.c b/drivers/rtc/nvmem.c
index 07ede21cee34..37df7e80525b 100644
--- a/drivers/rtc/nvmem.c
+++ b/drivers/rtc/nvmem.c
@@ -21,6 +21,7 @@ int devm_rtc_nvmem_register(struct rtc_device *rtc,
 
 	nvmem_config->dev = dev;
 	nvmem_config->owner = rtc->owner;
+	nvmem_config->add_legacy_fixed_of_cells = true;
 	nvmem = devm_nvmem_register(dev, nvmem_config);
 	if (IS_ERR(nvmem))
 		dev_err(dev, "failed to register nvmem device for RTC\n");
diff --git a/drivers/w1/slaves/w1_ds250x.c b/drivers/w1/slaves/w1_ds250x.c
index 7592c7050d1d..cb426f7dd23d 100644
--- a/drivers/w1/slaves/w1_ds250x.c
+++ b/drivers/w1/slaves/w1_ds250x.c
@@ -168,6 +168,7 @@ static int w1_eprom_add_slave(struct w1_slave *sl)
 	struct nvmem_device *nvmem;
 	struct nvmem_config nvmem_cfg = {
 		.dev = &sl->dev,
+		.add_legacy_fixed_of_cells = true,
 		.reg_read = w1_nvmem_read,
 		.type = NVMEM_TYPE_OTP,
 		.read_only = true,
diff --git a/include/linux/nvmem-provider.h b/include/linux/nvmem-provider.h
index dae26295e6be..1b81adebdb8b 100644
--- a/include/linux/nvmem-provider.h
+++ b/include/linux/nvmem-provider.h
@@ -82,6 +82,7 @@ struct nvmem_cell_info {
  * @owner:	Pointer to exporter module. Used for refcounting.
  * @cells:	Optional array of pre-defined NVMEM cells.
  * @ncells:	Number of elements in cells.
+ * @add_legacy_fixed_of_cells:	Read fixed NVMEM cells from old OF syntax.
  * @keepout:	Optional array of keepout ranges (sorted ascending by start).
  * @nkeepout:	Number of elements in the keepout array.
  * @type:	Type of the nvmem storage
@@ -112,6 +113,7 @@ struct nvmem_config {
 	struct module		*owner;
 	const struct nvmem_cell_info	*cells;
 	int			ncells;
+	bool			add_legacy_fixed_of_cells;
 	const struct nvmem_keepout *keepout;
 	unsigned int		nkeepout;
 	enum nvmem_type		type;
-- 
2.34.1

