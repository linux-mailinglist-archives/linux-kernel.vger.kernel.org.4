Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E759B67FECB
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 13:06:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbjA2MF7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 07:05:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234913AbjA2MF4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 07:05:56 -0500
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7DA623647;
        Sun, 29 Jan 2023 04:05:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1674993893; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yR258zPvf0vX2EOy31knRww44w8mPVrFUXCg6iYmgXQ=;
        b=bJ2JWZrwbRM6k6sF2xEwFcNaxI+xfs0me9P4SYjPztYSJB13ERuqOAOeQvQAZOkjFid//x
        gLBzJcp73MpZRJV9/UAlQ1ga7gLsidJ6DOWgbHGfnaZ3VjD0cE7Gh9J7hQoRWMJA5c7+Tl
        jr4Z5tovxaVH3brO3Hrxx/v2uO2ORAc=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        list@opendingux.net, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v3 4/4] rtc: jz4740: Register clock provider for the CLK32K pin
Date:   Sun, 29 Jan 2023 12:04:42 +0000
Message-Id: <20230129120442.22858-5-paul@crapouillou.net>
In-Reply-To: <20230129120442.22858-1-paul@crapouillou.net>
References: <20230129120442.22858-1-paul@crapouillou.net>
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
v3: - Use dev_err_probe()
    - Use __clk_hw_get() to get a pointer to the parent clock, instead
      of doing it by name.
    - Add Kconfig dependency on CONFIG_COMMON_CLK
    - Register CLK32K clock if the #clock-cells device property is
      present, instead of doing it based on the compatible string
---
 drivers/rtc/Kconfig      |  2 +-
 drivers/rtc/rtc-jz4740.c | 56 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 57 insertions(+), 1 deletion(-)

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 677d2601d305..d2b6d20a6745 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -1690,7 +1690,7 @@ config RTC_DRV_MPC5121
 config RTC_DRV_JZ4740
 	tristate "Ingenic JZ4740 SoC"
 	depends on MIPS || COMPILE_TEST
-	depends on OF
+	depends on OF && COMMON_CLK
 	help
 	  If you say yes here you get support for the Ingenic JZ47xx SoCs RTC
 	  controllers.
diff --git a/drivers/rtc/rtc-jz4740.c b/drivers/rtc/rtc-jz4740.c
index 9ffa764aa71e..59d279e3e6f5 100644
--- a/drivers/rtc/rtc-jz4740.c
+++ b/drivers/rtc/rtc-jz4740.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/clk.h>
+#include <linux/clk-provider.h>
 #include <linux/io.h>
 #include <linux/iopoll.h>
 #include <linux/kernel.h>
@@ -13,6 +14,7 @@
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/pm_wakeirq.h>
+#include <linux/property.h>
 #include <linux/reboot.h>
 #include <linux/rtc.h>
 #include <linux/slab.h>
@@ -26,6 +28,7 @@
 #define JZ_REG_RTC_WAKEUP_FILTER	0x24
 #define JZ_REG_RTC_RESET_COUNTER	0x28
 #define JZ_REG_RTC_SCRATCHPAD	0x34
+#define JZ_REG_RTC_CKPCR	0x40
 
 /* The following are present on the jz4780 */
 #define JZ_REG_RTC_WENR	0x3C
@@ -45,6 +48,9 @@
 #define JZ_RTC_WAKEUP_FILTER_MASK	0x0000FFE0
 #define JZ_RTC_RESET_COUNTER_MASK	0x00000FE0
 
+#define JZ_RTC_CKPCR_CK32PULL_DIS	BIT(4)
+#define JZ_RTC_CKPCR_CK32CTL_EN		(BIT(2) | BIT(1))
+
 enum jz4740_rtc_type {
 	ID_JZ4740,
 	ID_JZ4760,
@@ -57,6 +63,8 @@ struct jz4740_rtc {
 
 	struct rtc_device *rtc;
 
+	struct clk_hw clk32k;
+
 	spinlock_t lock;
 };
 
@@ -254,6 +262,7 @@ static void jz4740_rtc_power_off(void)
 static const struct of_device_id jz4740_rtc_of_match[] = {
 	{ .compatible = "ingenic,jz4740-rtc", .data = (void *)ID_JZ4740 },
 	{ .compatible = "ingenic,jz4760-rtc", .data = (void *)ID_JZ4760 },
+	{ .compatible = "ingenic,jz4770-rtc", .data = (void *)ID_JZ4780 },
 	{ .compatible = "ingenic,jz4780-rtc", .data = (void *)ID_JZ4780 },
 	{},
 };
@@ -295,6 +304,38 @@ static void jz4740_rtc_set_wakeup_params(struct jz4740_rtc *rtc,
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
+static int jz4740_rtc_clk32k_is_enabled(struct clk_hw *hw)
+{
+	struct jz4740_rtc *rtc = container_of(hw, struct jz4740_rtc, clk32k);
+	u32 ckpcr;
+
+	ckpcr = jz4740_rtc_reg_read(rtc, JZ_REG_RTC_CKPCR);
+
+	return !!(ckpcr & JZ_RTC_CKPCR_CK32CTL_EN);
+}
+
+static const struct clk_ops jz4740_rtc_clk32k_ops = {
+	.enable = jz4740_rtc_clk32k_enable,
+	.disable = jz4740_rtc_clk32k_disable,
+	.is_enabled = jz4740_rtc_clk32k_is_enabled,
+};
+
 static int jz4740_rtc_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -364,6 +405,21 @@ static int jz4740_rtc_probe(struct platform_device *pdev)
 			dev_warn(dev, "Poweroff handler already present!\n");
 	}
 
+	if (device_property_present(dev, "#clock-cells")) {
+		rtc->clk32k.init = CLK_HW_INIT_HW("clk32k", __clk_get_hw(clk),
+						  &jz4740_rtc_clk32k_ops, 0);
+
+		ret = devm_clk_hw_register(dev, &rtc->clk32k);
+		if (ret)
+			return dev_err_probe(dev, ret,
+					     "Unable to register clk32k clock\n");
+
+		ret = of_clk_add_hw_provider(np, of_clk_hw_simple_get, &rtc->clk32k);
+		if (ret)
+			return dev_err_probe(dev, ret,
+					     "Unable to register clk32k clock provider\n");
+	}
+
 	return 0;
 }
 
-- 
2.39.0

