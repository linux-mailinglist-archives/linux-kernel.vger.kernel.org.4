Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0F80611DCB
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 00:56:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230265AbiJ1W4T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 18:56:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbiJ1W4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 18:56:01 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4661622BADF;
        Fri, 28 Oct 2022 15:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1666997729; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mlXqJG8CZMGS3pje+4PkrK1pUmHZdP2M9X8uDTfAoIQ=;
        b=RtnGwrKZMc+tnMe5uAD+C9HHgeKLBPZIy1pTQCSxP0cQgrFmG/C0PqnBoQQWN6BF38TEaf
        1LOEo1c3kcWNoi3iFS0Y4cr7SUUkxmOUK+G+3iwj/vfZThvIAiFWSk2LNwVYHBVuMbyCUQ
        /ZHis+/+zUs7gJiOjYn5CJXpXoY9hf4=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        od@opendingux.net, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v2 3/4] rtc: jz4740: Register clock provider for the CLK32K pin
Date:   Fri, 28 Oct 2022 23:55:18 +0100
Message-Id: <20221028225519.89210-4-paul@crapouillou.net>
In-Reply-To: <20221028225519.89210-1-paul@crapouillou.net>
References: <20221028225519.89210-1-paul@crapouillou.net>
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

On JZ4770 and JZ4780, the CLK32K pin is configurable. By default, it is
configured as a GPIO in input mode, and its value can be read through
GPIO PD14.

With this change, clients can now request the 32 kHz clock on the CLK32K
pin, through Device Tree. This clock is simply a pass-through of the
input oscillator's clock with enable/disable operations.

This will permit the WiFi/Bluetooth chip to work on the MIPS CI20 board,
which does source one of its clocks from the CLK32K pin.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/rtc/rtc-jz4740.c | 50 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 48 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-jz4740.c b/drivers/rtc/rtc-jz4740.c
index 4ee6e5ee09b1..1602e8a4283a 100644
--- a/drivers/rtc/rtc-jz4740.c
+++ b/drivers/rtc/rtc-jz4740.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/clk.h>
+#include <linux/clk-provider.h>
 #include <linux/io.h>
 #include <linux/iopoll.h>
 #include <linux/kernel.h>
@@ -26,6 +27,7 @@
 #define JZ_REG_RTC_WAKEUP_FILTER	0x24
 #define JZ_REG_RTC_RESET_COUNTER	0x28
 #define JZ_REG_RTC_SCRATCHPAD	0x34
+#define JZ_REG_RTC_CKPCR	0x40
 
 /* The following are present on the jz4780 */
 #define JZ_REG_RTC_WENR	0x3C
@@ -45,10 +47,13 @@
 #define JZ_RTC_WAKEUP_FILTER_MASK	0x0000FFE0
 #define JZ_RTC_RESET_COUNTER_MASK	0x00000FE0
 
+#define JZ_RTC_CKPCR_CK32PULL_DIS	BIT(4)
+#define JZ_RTC_CKPCR_CK32CTL_EN		(BIT(2) | BIT(1))
+
 enum jz4740_rtc_type {
 	ID_JZ4740,
 	ID_JZ4760,
-	ID_JZ4780,
+	ID_JZ4770,
 };
 
 struct jz4740_rtc {
@@ -57,6 +62,8 @@ struct jz4740_rtc {
 
 	struct rtc_device *rtc;
 
+	struct clk_hw clk32k;
+
 	spinlock_t lock;
 };
 
@@ -254,7 +261,8 @@ static void jz4740_rtc_power_off(void)
 static const struct of_device_id jz4740_rtc_of_match[] = {
 	{ .compatible = "ingenic,jz4740-rtc", .data = (void *)ID_JZ4740 },
 	{ .compatible = "ingenic,jz4760-rtc", .data = (void *)ID_JZ4760 },
-	{ .compatible = "ingenic,jz4780-rtc", .data = (void *)ID_JZ4780 },
+	{ .compatible = "ingenic,jz4770-rtc", .data = (void *)ID_JZ4770 },
+	{ .compatible = "ingenic,jz4780-rtc", .data = (void *)ID_JZ4770 },
 	{},
 };
 MODULE_DEVICE_TABLE(of, jz4740_rtc_of_match);
@@ -295,6 +303,27 @@ static void jz4740_rtc_set_wakeup_params(struct jz4740_rtc *rtc,
 	jz4740_rtc_reg_write(rtc, JZ_REG_RTC_RESET_COUNTER, reset_ticks);
 }
 
+static int jz4740_rtc_clk32k_enable(struct clk_hw *hw)
+{
+	struct jz4740_rtc *rtc = container_of(hw, struct jz4740_rtc, clk32k);
+
+	return jz4740_rtc_reg_write(rtc, JZ_REG_RTC_CKPCR,
+				    JZ_RTC_CKPCR_CK32PULL_DIS |
+				    JZ_RTC_CKPCR_CK32CTL_EN);
+}
+
+static void jz4740_rtc_clk32k_disable(struct clk_hw *hw)
+{
+	struct jz4740_rtc *rtc = container_of(hw, struct jz4740_rtc, clk32k);
+
+	jz4740_rtc_reg_write(rtc, JZ_REG_RTC_CKPCR, 0);
+}
+
+static const struct clk_ops jz4740_rtc_clk32k_ops = {
+	.enable = jz4740_rtc_clk32k_enable,
+	.disable = jz4740_rtc_clk32k_disable,
+};
+
 static int jz4740_rtc_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -370,6 +399,23 @@ static int jz4740_rtc_probe(struct platform_device *pdev)
 			dev_warn(dev, "Poweroff handler already present!\n");
 	}
 
+	if (rtc->type == ID_JZ4770) {
+		rtc->clk32k.init = CLK_HW_INIT("clk32k", "rtc",
+					       &jz4740_rtc_clk32k_ops, 0);
+
+		ret = devm_clk_hw_register(dev, &rtc->clk32k);
+		if (ret) {
+			dev_err(dev, "Unable to register clk32k clock: %d\n", ret);
+			return ret;
+		}
+
+		ret = of_clk_add_hw_provider(np, of_clk_hw_simple_get, &rtc->clk32k);
+		if (ret) {
+			dev_err(dev, "Unable to register clk32k clock provider: %d\n", ret);
+			return ret;
+		}
+	}
+
 	return 0;
 }
 
-- 
2.35.1

