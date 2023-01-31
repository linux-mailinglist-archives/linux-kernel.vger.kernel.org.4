Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D430D68383F
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 22:02:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231527AbjAaVCx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 16:02:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231932AbjAaVCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 16:02:49 -0500
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E91717EE7;
        Tue, 31 Jan 2023 13:02:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1675198956; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pTB/5ibjHKW2X7UZeS7Tcf9Oq/nbjX1Dx/72F1/KHz4=;
        b=2PhimR52P1QRmXzxXOkrgO2hnI+46M09JfZ//TwpNtjgjJgGEmQuQb/JyCokV6UzchP1C7
        7GEGJ2DEaUCSrji9K1qK3egUnUKUZWew3h0Styiw0zkAwPhgyHtqlmbQo8g/bMUIzqm6Em
        JMU1rXaoXPul/jOGjZ0oGodHOH2wdkY=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mips@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, list@opendingux.net,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 2/2] mmc: jz4740: Add support for vqmmc power supply
Date:   Tue, 31 Jan 2023 21:02:29 +0000
Message-Id: <20230131210229.68129-2-paul@crapouillou.net>
In-Reply-To: <20230131210229.68129-1-paul@crapouillou.net>
References: <20230131210229.68129-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support enabling / disabling the vqmmc power supply if it was provided
by the firmware.

Provide the .start_signal_voltage_switch callback to change the voltage
of the external vqmmc power supply.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/mmc/host/jz4740_mmc.c | 38 ++++++++++++++++++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/jz4740_mmc.c b/drivers/mmc/host/jz4740_mmc.c
index eb8e9607b086..ccd2c3aed0f0 100644
--- a/drivers/mmc/host/jz4740_mmc.c
+++ b/drivers/mmc/host/jz4740_mmc.c
@@ -21,6 +21,7 @@
 #include <linux/of_device.h>
 #include <linux/pinctrl/consumer.h>
 #include <linux/platform_device.h>
+#include <linux/regulator/consumer.h>
 #include <linux/rwsem.h>
 #include <linux/scatterlist.h>
 
@@ -162,6 +163,8 @@ struct jz4740_mmc_host {
 	struct mmc_request *req;
 	struct mmc_command *cmd;
 
+	bool vqmmc_enabled;
+
 	unsigned long waiting;
 
 	uint32_t cmdat;
@@ -943,6 +946,8 @@ static void jz4740_mmc_request(struct mmc_host *mmc, struct mmc_request *req)
 static void jz4740_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 {
 	struct jz4740_mmc_host *host = mmc_priv(mmc);
+	int ret;
+
 	if (ios->clock)
 		jz4740_mmc_set_clock_rate(host, ios->clock);
 
@@ -955,12 +960,25 @@ static void jz4740_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 		clk_prepare_enable(host->clk);
 		break;
 	case MMC_POWER_ON:
+		if (!IS_ERR(mmc->supply.vqmmc) && !host->vqmmc_enabled) {
+			ret = regulator_enable(mmc->supply.vqmmc);
+			if (ret)
+				dev_err(&host->pdev->dev, "Failed to set vqmmc power!\n");
+			else
+				host->vqmmc_enabled = true;
+		}
 		break;
-	default:
+	case MMC_POWER_OFF:
 		if (!IS_ERR(mmc->supply.vmmc))
 			mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, 0);
+		if (!IS_ERR(mmc->supply.vqmmc) && host->vqmmc_enabled) {
+			regulator_disable(mmc->supply.vqmmc);
+			host->vqmmc_enabled = false;
+		}
 		clk_disable_unprepare(host->clk);
 		break;
+	default:
+		break;
 	}
 
 	switch (ios->bus_width) {
@@ -986,6 +1004,23 @@ static void jz4740_mmc_enable_sdio_irq(struct mmc_host *mmc, int enable)
 	jz4740_mmc_set_irq_enabled(host, JZ_MMC_IRQ_SDIO, enable);
 }
 
+static int jz4740_voltage_switch(struct mmc_host *mmc, struct mmc_ios *ios)
+{
+	int ret;
+
+	/* vqmmc regulator is available */
+	if (!IS_ERR(mmc->supply.vqmmc)) {
+		ret = mmc_regulator_set_vqmmc(mmc, ios);
+		return ret < 0 ? ret : 0;
+	}
+
+	/* no vqmmc regulator, assume fixed regulator at 3/3.3V */
+	if (ios->signal_voltage == MMC_SIGNAL_VOLTAGE_330)
+		return 0;
+
+	return -EINVAL;
+}
+
 static const struct mmc_host_ops jz4740_mmc_ops = {
 	.request	= jz4740_mmc_request,
 	.pre_req	= jz4740_mmc_pre_request,
@@ -994,6 +1029,7 @@ static const struct mmc_host_ops jz4740_mmc_ops = {
 	.get_ro		= mmc_gpio_get_ro,
 	.get_cd		= mmc_gpio_get_cd,
 	.enable_sdio_irq = jz4740_mmc_enable_sdio_irq,
+	.start_signal_voltage_switch = jz4740_voltage_switch,
 };
 
 static inline struct jz4740_mmc_host *
-- 
2.39.1

