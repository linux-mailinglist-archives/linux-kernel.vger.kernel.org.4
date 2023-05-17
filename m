Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EDA770727D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 21:44:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbjEQToK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 15:44:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbjEQToH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 15:44:07 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75C48272B;
        Wed, 17 May 2023 12:44:06 -0700 (PDT)
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 341828622C;
        Wed, 17 May 2023 21:44:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1684352644;
        bh=Zf0VtO/aFzuK2UjFyjLWPAVSDmaeZQtOFlaAWvp95wk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f2pSaB1Q9qqTXx3TcfgPS25eghTfGr/TSXGRZTV/uQeuQJWTqimQOSLkl/ncgjmvZ
         vOgrbhyiDthjQ0AICVkDa5epsTwhPSRZ+0WTYsIJpilZSvGry98wq/ubuLkj9ciAVn
         RhAAcf25w6z5qnrxmsJdKBvafEoNMA8NCH6EhmPmX5cNIjfsbpBNpJTJzpz+PLZpP+
         BORkjTxltgA2Swzf7uRJ45htNUldj/FJ72ZsO7wtLu4o6Bgl+4dXEJAccRLz74HXuf
         OkG+/i9cVUvQXp1V8lnd2KRMpiaHgbPr0fCHNDn/79fx+aWqLEaoSWk6ZPxgj7F94r
         cPTZ71Buu3QrQ==
From:   Marek Vasut <marex@denx.de>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Marek Vasut <marex@denx.de>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Antonio Borneo <antonio.borneo@foss.st.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-watchdog@vger.kernel.org
Subject: [PATCH v2 2/3] watchdog: stm32_iwdg: Add pretimeout support
Date:   Wed, 17 May 2023 21:43:48 +0200
Message-Id: <20230517194349.105745-2-marex@denx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230517194349.105745-1-marex@denx.de>
References: <20230517194349.105745-1-marex@denx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The STM32MP15xx IWDG adds registers which permit this IP to generate
pretimeout interrupt. This interrupt can also be used to wake the CPU
from suspend. Implement support for generating this interrupt and let
userspace configure the pretimeout. In case the pretimeout is not
configured by user, set pretimeout to half of the WDT timeout cycle.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: Antonio Borneo <antonio.borneo@foss.st.com>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: Richard Cochran <richardcochran@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>
Cc: devicetree@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-stm32@st-md-mailman.stormreply.com
Cc: linux-watchdog@vger.kernel.org
---
V2: - Subtract the pretimeout value from timeout value before writing it
      into the IWDG pretimeout register, because the watchdog counter
      register is counting down, and the pretimeout interrupt triggers
      when watchdog counter register matches the pretimeout register
      content.
    - Set default pretimeout to 3/4 of timeout .
---
 drivers/watchdog/stm32_iwdg.c | 94 ++++++++++++++++++++++++++++++++++-
 1 file changed, 93 insertions(+), 1 deletion(-)

diff --git a/drivers/watchdog/stm32_iwdg.c b/drivers/watchdog/stm32_iwdg.c
index 570a71509d2a9..4c69d4026dd9c 100644
--- a/drivers/watchdog/stm32_iwdg.c
+++ b/drivers/watchdog/stm32_iwdg.c
@@ -19,6 +19,7 @@
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
+#include <linux/pm_wakeirq.h>
 #include <linux/watchdog.h>
 
 /* IWDG registers */
@@ -27,6 +28,7 @@
 #define IWDG_RLR	0x08 /* ReLoad Register */
 #define IWDG_SR		0x0C /* Status Register */
 #define IWDG_WINR	0x10 /* Windows Register */
+#define IWDG_EWCR	0x14 /* Early Wake-up Register */
 
 /* IWDG_KR register bit mask */
 #define KR_KEY_RELOAD	0xAAAA /* reload counter enable */
@@ -46,22 +48,29 @@
 #define SR_PVU	BIT(0) /* Watchdog prescaler value update */
 #define SR_RVU	BIT(1) /* Watchdog counter reload value update */
 
+#define EWCR_EWIT	GENMASK(11, 0) /* Watchdog counter window value */
+#define EWCR_EWIC	BIT(14) /* Watchdog early interrupt acknowledge */
+#define EWCR_EWIE	BIT(15) /* Watchdog early interrupt enable */
+
 /* set timeout to 100000 us */
 #define TIMEOUT_US	100000
 #define SLEEP_US	1000
 
 struct stm32_iwdg_data {
 	bool has_pclk;
+	bool has_early_wakeup;
 	u32 max_prescaler;
 };
 
 static const struct stm32_iwdg_data stm32_iwdg_data = {
 	.has_pclk = false,
+	.has_early_wakeup = false,
 	.max_prescaler = 256,
 };
 
 static const struct stm32_iwdg_data stm32mp1_iwdg_data = {
 	.has_pclk = true,
+	.has_early_wakeup = true,
 	.max_prescaler = 1024,
 };
 
@@ -87,13 +96,18 @@ static inline void reg_write(void __iomem *base, u32 reg, u32 val)
 static int stm32_iwdg_start(struct watchdog_device *wdd)
 {
 	struct stm32_iwdg *wdt = watchdog_get_drvdata(wdd);
-	u32 tout, presc, iwdg_rlr, iwdg_pr, iwdg_sr;
+	u32 tout, ptot, presc, iwdg_rlr, iwdg_ewcr, iwdg_pr, iwdg_sr;
 	int ret;
 
 	dev_dbg(wdd->parent, "%s\n", __func__);
 
+	if (!wdd->pretimeout)
+		wdd->pretimeout = 3 * wdd->timeout / 4;
+
 	tout = clamp_t(unsigned int, wdd->timeout,
 		       wdd->min_timeout, wdd->max_hw_heartbeat_ms / 1000);
+	ptot = clamp_t(unsigned int, tout - wdd->pretimeout,
+		       wdd->min_timeout, tout);
 
 	presc = DIV_ROUND_UP(tout * wdt->rate, RLR_MAX + 1);
 
@@ -101,6 +115,7 @@ static int stm32_iwdg_start(struct watchdog_device *wdd)
 	presc = roundup_pow_of_two(presc);
 	iwdg_pr = presc <= 1 << PR_SHIFT ? 0 : ilog2(presc) - PR_SHIFT;
 	iwdg_rlr = ((tout * wdt->rate) / presc) - 1;
+	iwdg_ewcr = ((ptot * wdt->rate) / presc) - 1;
 
 	/* enable write access */
 	reg_write(wdt->regs, IWDG_KR, KR_KEY_EWA);
@@ -108,6 +123,8 @@ static int stm32_iwdg_start(struct watchdog_device *wdd)
 	/* set prescaler & reload registers */
 	reg_write(wdt->regs, IWDG_PR, iwdg_pr);
 	reg_write(wdt->regs, IWDG_RLR, iwdg_rlr);
+	if (wdt->data->has_early_wakeup)
+		reg_write(wdt->regs, IWDG_EWCR, iwdg_ewcr | EWCR_EWIE);
 	reg_write(wdt->regs, IWDG_KR, KR_KEY_ENABLE);
 
 	/* wait for the registers to be updated (max 100ms) */
@@ -150,6 +167,34 @@ static int stm32_iwdg_set_timeout(struct watchdog_device *wdd,
 	return 0;
 }
 
+static int stm32_iwdg_set_pretimeout(struct watchdog_device *wdd,
+				     unsigned int pretimeout)
+{
+	dev_dbg(wdd->parent, "%s pretimeout: %d sec\n", __func__, pretimeout);
+
+	wdd->pretimeout = pretimeout;
+
+	if (watchdog_active(wdd))
+		return stm32_iwdg_start(wdd);
+
+	return 0;
+}
+
+static irqreturn_t stm32_iwdg_isr(int irq, void *wdog_arg)
+{
+	struct watchdog_device *wdd = wdog_arg;
+	struct stm32_iwdg *wdt = watchdog_get_drvdata(wdd);
+	u32 reg;
+
+	reg = reg_read(wdt->regs, IWDG_EWCR);
+	reg |= EWCR_EWIC;
+	reg_write(wdt->regs, IWDG_EWCR, reg);
+
+	watchdog_notify_pretimeout(wdd);
+
+	return IRQ_HANDLED;
+}
+
 static void stm32_clk_disable_unprepare(void *data)
 {
 	clk_disable_unprepare(data);
@@ -206,11 +251,20 @@ static const struct watchdog_info stm32_iwdg_info = {
 	.identity	= "STM32 Independent Watchdog",
 };
 
+static const struct watchdog_info stm32_iwdg_preinfo = {
+	.options	= WDIOF_SETTIMEOUT |
+			  WDIOF_MAGICCLOSE |
+			  WDIOF_KEEPALIVEPING |
+			  WDIOF_PRETIMEOUT,
+	.identity	= "STM32 Independent Watchdog",
+};
+
 static const struct watchdog_ops stm32_iwdg_ops = {
 	.owner		= THIS_MODULE,
 	.start		= stm32_iwdg_start,
 	.ping		= stm32_iwdg_ping,
 	.set_timeout	= stm32_iwdg_set_timeout,
+	.set_pretimeout	= stm32_iwdg_set_pretimeout,
 };
 
 static const struct of_device_id stm32_iwdg_of_match[] = {
@@ -220,6 +274,39 @@ static const struct of_device_id stm32_iwdg_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, stm32_iwdg_of_match);
 
+static int stm32_iwdg_irq_init(struct platform_device *pdev,
+			       struct stm32_iwdg *wdt)
+{
+	struct device_node *np = pdev->dev.of_node;
+	struct watchdog_device *wdd = &wdt->wdd;
+	struct device *dev = &pdev->dev;
+	int irq, ret;
+
+	if (!wdt->data->has_early_wakeup)
+		return 0;
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq <= 0)
+		return 0;
+
+	if (of_property_read_bool(np, "wakeup-source")) {
+		ret = device_init_wakeup(&pdev->dev, true);
+		if (ret)
+			return ret;
+
+		ret = dev_pm_set_wake_irq(&pdev->dev, irq);
+		if (ret)
+			return ret;
+	}
+
+	ret = devm_request_irq(dev, irq, stm32_iwdg_isr, 0,
+			       dev_name(dev), wdd);
+	if (!ret)
+		wdd->info = &stm32_iwdg_preinfo;
+
+	return ret;
+}
+
 static int stm32_iwdg_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -253,6 +340,11 @@ static int stm32_iwdg_probe(struct platform_device *pdev)
 	wdd->max_hw_heartbeat_ms = ((RLR_MAX + 1) * wdt->data->max_prescaler *
 				    1000) / wdt->rate;
 
+	/* Initialize IRQ, this might override wdd->info, hence it is here. */
+	ret = stm32_iwdg_irq_init(pdev, wdt);
+	if (ret)
+		return ret;
+
 	watchdog_set_drvdata(wdd, wdt);
 	watchdog_set_nowayout(wdd, WATCHDOG_NOWAYOUT);
 	watchdog_init_timeout(wdd, 0, dev);
-- 
2.39.2

