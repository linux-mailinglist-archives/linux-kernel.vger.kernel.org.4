Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85CFD741D5E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 02:50:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231204AbjF2AuO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 20:50:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjF2AuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 20:50:10 -0400
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 33CB01BD1;
        Wed, 28 Jun 2023 17:50:07 -0700 (PDT)
Received: from unknown (HELO iyokan2-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 29 Jun 2023 09:50:05 +0900
Received: from mail.mfilter.local (mail-arc02.css.socionext.com [10.213.46.40])
        by iyokan2-ex.css.socionext.com (Postfix) with ESMTP id D700A2245572;
        Thu, 29 Jun 2023 09:50:05 +0900 (JST)
Received: from kinkan2.css.socionext.com ([172.31.9.51]) by m-FILTER with ESMTP; Thu, 29 Jun 2023 09:50:05 +0900
Received: from plum.e01.socionext.com (unknown [10.212.243.119])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id 56CACE6050;
        Thu, 29 Jun 2023 09:50:05 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH] mmc: sdhci-f-sdh30: Replace with sdhci_pltfm
Date:   Thu, 29 Jun 2023 09:49:59 +0900
Message-Id: <20230629004959.22825-1-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Even if sdhci_pltfm_pmops is specified for PM, this driver doesn't apply
sdhci_pltfm, so the structure is not correctly referenced in PM functions.
This applies sdhci_pltfm to this driver to fix this issue.

- Call sdhci_pltfm_init() instead of sdhci_alloc_host() and
  other functions that covered by sdhci_pltfm.
- Move ops and quirks to sdhci_pltfm_data
- Replace sdhci_priv() with own private function sdhci_f_sdh30_priv().

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 drivers/mmc/host/sdhci_f_sdh30.c | 60 ++++++++++++++------------------
 1 file changed, 27 insertions(+), 33 deletions(-)

diff --git a/drivers/mmc/host/sdhci_f_sdh30.c b/drivers/mmc/host/sdhci_f_sdh30.c
index a202a69a4b08..b01ffb4d0973 100644
--- a/drivers/mmc/host/sdhci_f_sdh30.c
+++ b/drivers/mmc/host/sdhci_f_sdh30.c
@@ -29,9 +29,16 @@ struct f_sdhost_priv {
 	bool enable_cmd_dat_delay;
 };
 
+static void *sdhci_f_sdhost_priv(struct sdhci_host *host)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+
+	return sdhci_pltfm_priv(pltfm_host);
+}
+
 static void sdhci_f_sdh30_soft_voltage_switch(struct sdhci_host *host)
 {
-	struct f_sdhost_priv *priv = sdhci_priv(host);
+	struct f_sdhost_priv *priv = sdhci_f_sdhost_priv(host);
 	u32 ctrl = 0;
 
 	usleep_range(2500, 3000);
@@ -64,7 +71,7 @@ static unsigned int sdhci_f_sdh30_get_min_clock(struct sdhci_host *host)
 
 static void sdhci_f_sdh30_reset(struct sdhci_host *host, u8 mask)
 {
-	struct f_sdhost_priv *priv = sdhci_priv(host);
+	struct f_sdhost_priv *priv = sdhci_f_sdhost_priv(host);
 	u32 ctl;
 
 	if (sdhci_readw(host, SDHCI_CLOCK_CONTROL) == 0)
@@ -95,30 +102,32 @@ static const struct sdhci_ops sdhci_f_sdh30_ops = {
 	.set_uhs_signaling = sdhci_set_uhs_signaling,
 };
 
+static const struct sdhci_pltfm_data sdhci_f_sdh30_pltfm_data = {
+	.ops = &sdhci_f_sdh30_ops,
+	.quirks = SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC
+		| SDHCI_QUIRK_INVERTED_WRITE_PROTECT,
+	.quirks2 = SDHCI_QUIRK2_SUPPORT_SINGLE
+		|  SDHCI_QUIRK2_TUNING_WORK_AROUND,
+};
+
 static int sdhci_f_sdh30_probe(struct platform_device *pdev)
 {
 	struct sdhci_host *host;
 	struct device *dev = &pdev->dev;
-	int irq, ctrl = 0, ret = 0;
+	int ctrl = 0, ret = 0;
 	struct f_sdhost_priv *priv;
+	struct sdhci_pltfm_host *pltfm_host;
 	u32 reg = 0;
 
-	irq = platform_get_irq(pdev, 0);
-	if (irq < 0)
-		return irq;
-
-	host = sdhci_alloc_host(dev, sizeof(struct f_sdhost_priv));
+	host = sdhci_pltfm_init(pdev, &sdhci_f_sdh30_pltfm_data,
+				sizeof(struct f_sdhost_priv));
 	if (IS_ERR(host))
 		return PTR_ERR(host);
 
-	priv = sdhci_priv(host);
+	pltfm_host = sdhci_priv(host);
+	priv = sdhci_pltfm_priv(pltfm_host);
 	priv->dev = dev;
 
-	host->quirks = SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC |
-		       SDHCI_QUIRK_INVERTED_WRITE_PROTECT;
-	host->quirks2 = SDHCI_QUIRK2_SUPPORT_SINGLE |
-			SDHCI_QUIRK2_TUNING_WORK_AROUND;
-
 	priv->enable_cmd_dat_delay = device_property_read_bool(dev,
 						"fujitsu,cmd-dat-delay-select");
 
@@ -126,18 +135,6 @@ static int sdhci_f_sdh30_probe(struct platform_device *pdev)
 	if (ret)
 		goto err;
 
-	platform_set_drvdata(pdev, host);
-
-	host->hw_name = "f_sdh30";
-	host->ops = &sdhci_f_sdh30_ops;
-	host->irq = irq;
-
-	host->ioaddr = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(host->ioaddr)) {
-		ret = PTR_ERR(host->ioaddr);
-		goto err;
-	}
-
 	if (dev_of_node(dev)) {
 		sdhci_get_of_property(pdev);
 
@@ -204,24 +201,21 @@ static int sdhci_f_sdh30_probe(struct platform_device *pdev)
 err_clk:
 	clk_disable_unprepare(priv->clk_iface);
 err:
-	sdhci_free_host(host);
+	sdhci_pltfm_free(pdev);
+
 	return ret;
 }
 
 static int sdhci_f_sdh30_remove(struct platform_device *pdev)
 {
 	struct sdhci_host *host = platform_get_drvdata(pdev);
-	struct f_sdhost_priv *priv = sdhci_priv(host);
-
-	sdhci_remove_host(host, readl(host->ioaddr + SDHCI_INT_STATUS) ==
-			  0xffffffff);
+	struct f_sdhost_priv *priv = sdhci_f_sdhost_priv(host);
 
 	reset_control_assert(priv->rst);
 	clk_disable_unprepare(priv->clk);
 	clk_disable_unprepare(priv->clk_iface);
 
-	sdhci_free_host(host);
-	platform_set_drvdata(pdev, NULL);
+	sdhci_pltfm_unregister(pdev);
 
 	return 0;
 }
-- 
2.25.1

