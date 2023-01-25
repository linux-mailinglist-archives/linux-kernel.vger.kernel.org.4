Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D17C67A832
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 02:02:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234385AbjAYBCe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 20:02:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234311AbjAYBCY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 20:02:24 -0500
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 703402412E;
        Tue, 24 Jan 2023 17:02:16 -0800 (PST)
Received: from unknown (HELO kinkan2-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 25 Jan 2023 10:02:15 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by kinkan2-ex.css.socionext.com (Postfix) with ESMTP id C45752059054;
        Wed, 25 Jan 2023 10:02:15 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Wed, 25 Jan 2023 10:02:14 +0900
Received: from plum.e01.socionext.com (unknown [10.212.243.119])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id 538A33D53;
        Wed, 25 Jan 2023 10:02:15 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH 2/5] mmc: uniphier-sd: Add control of UHS mode using SD interface logic
Date:   Wed, 25 Jan 2023 10:01:58 +0900
Message-Id: <20230125010201.28246-3-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230125010201.28246-1-hayashi.kunihiko@socionext.com>
References: <20230125010201.28246-1-hayashi.kunihiko@socionext.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Transition of UHS mode needs to control the register in SD interface
logic. Add access to the register in the logic using the regmap from
"socionext,syscon-uhs-mode" property.

Define the start_signal_voltage_switch function only if UHS mode is
available.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 drivers/mmc/host/uniphier-sd.c | 61 +++++++++++++++++++++++++++++++---
 1 file changed, 56 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/uniphier-sd.c b/drivers/mmc/host/uniphier-sd.c
index 3a8defdcca77..c9766d6a690f 100644
--- a/drivers/mmc/host/uniphier-sd.c
+++ b/drivers/mmc/host/uniphier-sd.c
@@ -8,6 +8,7 @@
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/dma-mapping.h>
+#include <linux/mfd/syscon.h>
 #include <linux/mfd/tmio.h>
 #include <linux/mmc/host.h>
 #include <linux/module.h>
@@ -15,6 +16,7 @@
 #include <linux/of_device.h>
 #include <linux/pinctrl/consumer.h>
 #include <linux/platform_device.h>
+#include <linux/regmap.h>
 #include <linux/reset.h>
 
 #include "tmio_mmc.h"
@@ -48,6 +50,11 @@
 #define UNIPHIER_SD_DMA_ADDR_L		0x440
 #define UNIPHIER_SD_DMA_ADDR_H		0x444
 
+/* SD control */
+#define UNIPHIER_SDCTRL_CHOFFSET	0x200
+#define UNIPHIER_SDCTRL_MODE		0x30
+#define   UNIPHIER_SDCTRL_MODE_UHS1MOD		BIT(15)
+
 /*
  * IP is extended to support various features: built-in DMA engine,
  * 1/1024 divisor, etc.
@@ -66,6 +73,8 @@ struct uniphier_sd_priv {
 	struct reset_control *rst_hw;
 	struct dma_chan *chan;
 	enum dma_data_direction dma_dir;
+	struct regmap *sdctrl_regmap;
+	u32 sdctrl_ch;
 	unsigned long clk_rate;
 	unsigned long caps;
 };
@@ -420,6 +429,23 @@ static void uniphier_sd_hw_reset(struct mmc_host *mmc)
 	usleep_range(300, 1000);
 }
 
+static void uniphier_sd_uhs_enable(struct tmio_mmc_host *host, bool uhs_en)
+{
+	struct uniphier_sd_priv *priv = uniphier_sd_priv(host);
+	unsigned int offset;
+	u32 val;
+
+	if (!(host->mmc->caps & MMC_CAP_UHS))
+		return;
+
+	val = (uhs_en) ? UNIPHIER_SDCTRL_MODE_UHS1MOD : 0;
+
+	offset = UNIPHIER_SDCTRL_CHOFFSET * priv->sdctrl_ch
+		+ UNIPHIER_SDCTRL_MODE;
+	regmap_write_bits(priv->sdctrl_regmap, offset,
+			  UNIPHIER_SDCTRL_MODE_UHS1MOD, val);
+}
+
 static void uniphier_sd_set_clock(struct tmio_mmc_host *host,
 				  unsigned int clock)
 {
@@ -500,14 +526,17 @@ static int uniphier_sd_start_signal_voltage_switch(struct mmc_host *mmc,
 	struct uniphier_sd_priv *priv = uniphier_sd_priv(host);
 	struct pinctrl_state *pinstate = NULL;
 	u32 val, tmp;
+	bool uhs_en;
 
 	switch (ios->signal_voltage) {
 	case MMC_SIGNAL_VOLTAGE_330:
 		val = UNIPHIER_SD_VOLT_330;
+		uhs_en = false;
 		break;
 	case MMC_SIGNAL_VOLTAGE_180:
 		val = UNIPHIER_SD_VOLT_180;
 		pinstate = priv->pinstate_uhs;
+		uhs_en = true;
 		break;
 	default:
 		return -ENOTSUPP;
@@ -523,12 +552,19 @@ static int uniphier_sd_start_signal_voltage_switch(struct mmc_host *mmc,
 	else
 		pinctrl_select_default_state(mmc_dev(mmc));
 
+	uniphier_sd_uhs_enable(host, uhs_en);
+
 	return 0;
 }
 
-static int uniphier_sd_uhs_init(struct tmio_mmc_host *host,
-				struct uniphier_sd_priv *priv)
+static int uniphier_sd_uhs_init(struct tmio_mmc_host *host)
 {
+	struct uniphier_sd_priv *priv = uniphier_sd_priv(host);
+	struct device *dev = &host->pdev->dev;
+	struct device_node *np = dev->of_node;
+	struct of_phandle_args args;
+	int ret;
+
 	priv->pinctrl = devm_pinctrl_get(mmc_dev(host->mmc));
 	if (IS_ERR(priv->pinctrl))
 		return PTR_ERR(priv->pinctrl);
@@ -537,8 +573,20 @@ static int uniphier_sd_uhs_init(struct tmio_mmc_host *host,
 	if (IS_ERR(priv->pinstate_uhs))
 		return PTR_ERR(priv->pinstate_uhs);
 
-	host->ops.start_signal_voltage_switch =
-					uniphier_sd_start_signal_voltage_switch;
+	ret = of_parse_phandle_with_fixed_args(np,
+					       "socionext,syscon-uhs-mode",
+					       1, 0, &args);
+	if (ret) {
+		dev_err(dev, "Can't get syscon-uhs-mode property\n");
+		return ret;
+	}
+	priv->sdctrl_regmap = syscon_node_to_regmap(args.np);
+	of_node_put(args.np);
+	if (IS_ERR(priv->sdctrl_regmap)) {
+		dev_err(dev, "Can't map syscon-uhs-mode\n");
+		return PTR_ERR(priv->sdctrl_regmap);
+	}
+	priv->sdctrl_ch = args.args[0];
 
 	return 0;
 }
@@ -601,12 +649,15 @@ static int uniphier_sd_probe(struct platform_device *pdev)
 	}
 
 	if (host->mmc->caps & MMC_CAP_UHS) {
-		ret = uniphier_sd_uhs_init(host, priv);
+		ret = uniphier_sd_uhs_init(host);
 		if (ret) {
 			dev_warn(dev,
 				 "failed to setup UHS (error %d).  Disabling UHS.",
 				 ret);
 			host->mmc->caps &= ~MMC_CAP_UHS;
+		} else {
+			host->ops.start_signal_voltage_switch =
+				uniphier_sd_start_signal_voltage_switch;
 		}
 	}
 
-- 
2.25.1

