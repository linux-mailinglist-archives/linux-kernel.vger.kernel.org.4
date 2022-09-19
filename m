Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86BAF5BD609
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 23:01:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbiISVBt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 17:01:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbiISVBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 17:01:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 152874CA39;
        Mon, 19 Sep 2022 14:01:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DD925B82076;
        Mon, 19 Sep 2022 21:01:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D175C433D6;
        Mon, 19 Sep 2022 21:00:59 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="JKJ8HNnd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1663621257;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=P8nsYcfw0906oLqr46l4KFRxvKDrSDE9ZAD2yOL1xrQ=;
        b=JKJ8HNnd91vSARdQudqALPbUN2a8AveZ390vDMzNmAE9QNRvEhjHQyMNY/Ldi3ydw+PAde
        oQMm0M614o8gFGj/M7J7uvoR8WdHhPmNHkLw0xkc6xbnSHEvcab+Dui/5k+ZQUy0XJwIP4
        LDDyx7A9E8MSV4+25/QWuM0UcKZopMU=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id a611b30a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 19 Sep 2022 21:00:56 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Lin Jinhan <troy.lin@rock-chips.com>, wevsty <ty@wevs.org>,
        Mikhail Rudenko <mike.rudenko@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Lin Huang <hl@rock-chips.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        linux-rockchip@lists.infradead.org
Subject: [PATCH] hw_random: rockchip: import driver from vendor tree
Date:   Mon, 19 Sep 2022 23:00:25 +0200
Message-Id: <20220919210025.2376254-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Rockchip driver has long existed out of tree, but not upstream.
There is support for it upstream in u-boot, but not in Linux proper.
This commit imports the GPLv2 driver written by Lin Jinhan, together
with the DTS and config blobs from Wevsty.

Co-authored-by: Lin Jinhan <troy.lin@rock-chips.com>
Co-authored-by: wevsty <ty@wevs.org>
Tested-by: Mikhail Rudenko <mike.rudenko@gmail.com>
Cc: Heiko Stuebner <heiko@sntech.de>
Cc: Lin Huang <hl@rock-chips.com>
Cc: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: linux-rockchip@lists.infradead.org
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 arch/arm64/boot/dts/rockchip/rk3328.dtsi |  11 +
 arch/arm64/boot/dts/rockchip/rk3399.dtsi |  10 +
 drivers/char/hw_random/Kconfig           |  13 +
 drivers/char/hw_random/Makefile          |   1 +
 drivers/char/hw_random/rockchip-rng.c    | 330 +++++++++++++++++++++++
 5 files changed, 365 insertions(+)
 create mode 100644 drivers/char/hw_random/rockchip-rng.c

diff --git a/arch/arm64/boot/dts/rockchip/rk3328.dtsi b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
index 49ae15708a0b..f52589f5aa59 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
@@ -279,6 +279,17 @@ &pdmm0_sdi2_sleep
 		status = "disabled";
 	};
 
+	rng: rng@ff060000 {
+		compatible = "rockchip,cryptov1-rng";
+		reg = <0x0 0xff060000 0x0 0x4000>;
+
+		clocks = <&cru SCLK_CRYPTO>, <&cru HCLK_CRYPTO_SLV>;
+		clock-names = "clk_crypto", "hclk_crypto";
+		assigned-clocks = <&cru SCLK_CRYPTO>, <&cru HCLK_CRYPTO_SLV>;
+		assigned-clock-rates = <150000000>, <100000000>;
+		status = "disabled";
+	};
+
 	grf: syscon@ff100000 {
 		compatible = "rockchip,rk3328-grf", "syscon", "simple-mfd";
 		reg = <0x0 0xff100000 0x0 0x1000>;
diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index 9d5b0e8c9cca..bd5ce85a063a 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -2042,6 +2042,16 @@ edp_in_vopl: endpoint@1 {
 		};
 	};
 
+	rng: rng@ff8b8000 {
+		compatible = "rockchip,cryptov1-rng";
+		reg = <0x0 0xff8b8000 0x0 0x1000>;
+		clocks = <&cru SCLK_CRYPTO1>, <&cru HCLK_S_CRYPTO1>;
+		clock-names = "clk_crypto", "hclk_crypto";
+		assigned-clocks = <&cru SCLK_CRYPTO1>, <&cru HCLK_S_CRYPTO1>;
+		assigned-clock-rates = <150000000>, <100000000>;
+		status = "okay";
+	};
+
 	gpu: gpu@ff9a0000 {
 		compatible = "rockchip,rk3399-mali", "arm,mali-t860";
 		reg = <0x0 0xff9a0000 0x0 0x10000>;
diff --git a/drivers/char/hw_random/Kconfig b/drivers/char/hw_random/Kconfig
index 3da8e85f8aae..1dbe9a9b2944 100644
--- a/drivers/char/hw_random/Kconfig
+++ b/drivers/char/hw_random/Kconfig
@@ -372,6 +372,19 @@ config HW_RANDOM_STM32
 
 	  If unsure, say N.
 
+config HW_RANDOM_ROCKCHIP
+	tristate "Rockchip Random Number Generator support"
+	depends on ARCH_ROCKCHIP
+	default HW_RANDOM
+	help
+	  This driver provides kernel-side support for the Random Number
+	  Generator hardware found on Rockchip cpus.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called rockchip-rng.
+
+	  If unsure, say Y.
+
 config HW_RANDOM_PIC32
 	tristate "Microchip PIC32 Random Number Generator support"
 	depends on HW_RANDOM && MACH_PIC32
diff --git a/drivers/char/hw_random/Makefile b/drivers/char/hw_random/Makefile
index 3e948cf04476..852fb42e225b 100644
--- a/drivers/char/hw_random/Makefile
+++ b/drivers/char/hw_random/Makefile
@@ -34,6 +34,7 @@ obj-$(CONFIG_HW_RANDOM_IPROC_RNG200) += iproc-rng200.o
 obj-$(CONFIG_HW_RANDOM_ST) += st-rng.o
 obj-$(CONFIG_HW_RANDOM_XGENE) += xgene-rng.o
 obj-$(CONFIG_HW_RANDOM_STM32) += stm32-rng.o
+obj-$(CONFIG_HW_RANDOM_ROCKCHIP) += rockchip-rng.o
 obj-$(CONFIG_HW_RANDOM_PIC32) += pic32-rng.o
 obj-$(CONFIG_HW_RANDOM_MESON) += meson-rng.o
 obj-$(CONFIG_HW_RANDOM_CAVIUM) += cavium-rng.o cavium-rng-vf.o
diff --git a/drivers/char/hw_random/rockchip-rng.c b/drivers/char/hw_random/rockchip-rng.c
new file mode 100644
index 000000000000..c0121f1f542e
--- /dev/null
+++ b/drivers/char/hw_random/rockchip-rng.c
@@ -0,0 +1,330 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * rockchip-rng.c Random Number Generator driver for the Rockchip
+ *
+ * Copyright (c) 2018, Fuzhou Rockchip Electronics Co., Ltd.
+ * Author: Lin Jinhan <troy.lin@rock-chips.com>
+ *
+ */
+#include <linux/clk.h>
+#include <linux/hw_random.h>
+#include <linux/iopoll.h>
+#include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+
+#define _SBF(s, v)	((v) << (s))
+#define HIWORD_UPDATE(val, mask, shift) \
+			((val) << (shift) | (mask) << ((shift) + 16))
+
+#define ROCKCHIP_AUTOSUSPEND_DELAY		100
+#define ROCKCHIP_POLL_PERIOD_US			100
+#define ROCKCHIP_POLL_TIMEOUT_US		10000
+#define RK_MAX_RNG_BYTE				(32)
+
+#define CRYPTO_V1_CTRL				0x0008
+#define CRYPTO_V1_RNG_START			BIT(8)
+#define CRYPTO_V1_RNG_FLUSH			BIT(9)
+#define CRYPTO_V1_TRNG_CTRL			0x0200
+#define CRYPTO_V1_OSC_ENABLE			BIT(16)
+#define CRYPTO_V1_TRNG_SAMPLE_PERIOD(x)		(x)
+#define CRYPTO_V1_TRNG_DOUT_0			0x0204
+
+#define CRYPTO_V2_RNG_CTL			0x0400
+#define CRYPTO_V2_RNG_64_BIT_LEN		_SBF(4, 0x00)
+#define CRYPTO_V2_RNG_128_BIT_LEN		_SBF(4, 0x01)
+#define CRYPTO_V2_RNG_192_BIT_LEN		_SBF(4, 0x02)
+#define CRYPTO_V2_RNG_256_BIT_LEN		_SBF(4, 0x03)
+#define CRYPTO_V2_RNG_FATESY_SOC_RING		_SBF(2, 0x00)
+#define CRYPTO_V2_RNG_SLOWER_SOC_RING_0		_SBF(2, 0x01)
+#define CRYPTO_V2_RNG_SLOWER_SOC_RING_1		_SBF(2, 0x02)
+#define CRYPTO_V2_RNG_SLOWEST_SOC_RING		_SBF(2, 0x03)
+#define CRYPTO_V2_RNG_ENABLE			BIT(1)
+#define CRYPTO_V2_RNG_START			BIT(0)
+#define CRYPTO_V2_RNG_SAMPLE_CNT		0x0404
+#define CRYPTO_V2_RNG_DOUT_0			0x0410
+
+struct rk_rng_soc_data {
+	const char * const *clks;
+	int clks_num;
+	int (*rk_rng_read)(struct hwrng *rng, void *buf, size_t max, bool wait);
+};
+
+struct rk_rng {
+	struct device		*dev;
+	struct hwrng		rng;
+	void __iomem		*mem;
+	struct rk_rng_soc_data	*soc_data;
+	u32			clk_num;
+	struct clk_bulk_data	*clk_bulks;
+};
+
+static const char * const rk_rng_v1_clks[] = {
+	"hclk_crypto",
+	"clk_crypto",
+};
+
+static const char * const rk_rng_v2_clks[] = {
+	"hclk_crypto",
+	"aclk_crypto",
+	"clk_crypto",
+	"clk_crypto_apk",
+};
+
+static void rk_rng_writel(struct rk_rng *rng, u32 val, u32 offset)
+{
+	__raw_writel(val, rng->mem + offset);
+}
+
+static u32 rk_rng_readl(struct rk_rng *rng, u32 offset)
+{
+	return __raw_readl(rng->mem + offset);
+}
+
+static int rk_rng_init(struct hwrng *rng)
+{
+	int ret;
+	struct rk_rng *rk_rng = container_of(rng, struct rk_rng, rng);
+
+	ret = clk_bulk_prepare_enable(rk_rng->clk_num, rk_rng->clk_bulks);
+	if (ret < 0) {
+		dev_err(rk_rng->dev, "failed to enable clks %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static void rk_rng_cleanup(struct hwrng *rng)
+{
+	struct rk_rng *rk_rng = container_of(rng, struct rk_rng, rng);
+
+	clk_bulk_disable_unprepare(rk_rng->clk_num, rk_rng->clk_bulks);
+}
+
+static void rk_rng_read_regs(struct rk_rng *rng, u32 offset, void *buf,
+			     size_t size)
+{
+	u32 i, sample;
+
+	for (i = 0; i < size; i += 4) {
+		sample = rk_rng_readl(rng, offset + i);
+		memcpy(buf + i, &sample, sizeof(sample));
+	}
+}
+
+static int rk_rng_v1_read(struct hwrng *rng, void *buf, size_t max, bool wait)
+{
+	int ret = 0;
+	u32 reg_ctrl = 0;
+	struct rk_rng *rk_rng = container_of(rng, struct rk_rng, rng);
+
+	ret = pm_runtime_get_sync(rk_rng->dev);
+	if (ret < 0) {
+		pm_runtime_put_noidle(rk_rng->dev);
+		return ret;
+	}
+
+	/* enable osc_ring to get entropy, sample period is set as 100 */
+	reg_ctrl = CRYPTO_V1_OSC_ENABLE | CRYPTO_V1_TRNG_SAMPLE_PERIOD(100);
+	rk_rng_writel(rk_rng, reg_ctrl, CRYPTO_V1_TRNG_CTRL);
+
+	reg_ctrl = HIWORD_UPDATE(CRYPTO_V1_RNG_START, CRYPTO_V1_RNG_START, 0);
+
+	rk_rng_writel(rk_rng, reg_ctrl, CRYPTO_V1_CTRL);
+
+	ret = readl_poll_timeout(rk_rng->mem + CRYPTO_V1_CTRL, reg_ctrl,
+				 !(reg_ctrl & CRYPTO_V1_RNG_START),
+				 ROCKCHIP_POLL_PERIOD_US,
+				 ROCKCHIP_POLL_TIMEOUT_US);
+	if (ret < 0)
+		goto out;
+
+	ret = min_t(size_t, max, RK_MAX_RNG_BYTE);
+
+	rk_rng_read_regs(rk_rng, CRYPTO_V1_TRNG_DOUT_0, buf, ret);
+
+out:
+	/* close TRNG */
+	rk_rng_writel(rk_rng, HIWORD_UPDATE(0, CRYPTO_V1_RNG_START, 0),
+		      CRYPTO_V1_CTRL);
+
+	pm_runtime_mark_last_busy(rk_rng->dev);
+	pm_runtime_put_sync_autosuspend(rk_rng->dev);
+
+	return ret;
+}
+
+static int rk_rng_v2_read(struct hwrng *rng, void *buf, size_t max, bool wait)
+{
+	int ret = 0;
+	u32 reg_ctrl = 0;
+	struct rk_rng *rk_rng = container_of(rng, struct rk_rng, rng);
+
+	ret = pm_runtime_get_sync(rk_rng->dev);
+	if (ret < 0) {
+		pm_runtime_put_noidle(rk_rng->dev);
+		return ret;
+	}
+
+	/* enable osc_ring to get entropy, sample period is set as 100 */
+	rk_rng_writel(rk_rng, 100, CRYPTO_V2_RNG_SAMPLE_CNT);
+
+	reg_ctrl |= CRYPTO_V2_RNG_256_BIT_LEN;
+	reg_ctrl |= CRYPTO_V2_RNG_SLOWER_SOC_RING_0;
+	reg_ctrl |= CRYPTO_V2_RNG_ENABLE;
+	reg_ctrl |= CRYPTO_V2_RNG_START;
+
+	rk_rng_writel(rk_rng, HIWORD_UPDATE(reg_ctrl, 0xffff, 0),
+			CRYPTO_V2_RNG_CTL);
+
+	ret = readl_poll_timeout(rk_rng->mem + CRYPTO_V2_RNG_CTL, reg_ctrl,
+				 !(reg_ctrl & CRYPTO_V2_RNG_START),
+				 ROCKCHIP_POLL_PERIOD_US,
+				 ROCKCHIP_POLL_TIMEOUT_US);
+	if (ret < 0)
+		goto out;
+
+	ret = min_t(size_t, max, RK_MAX_RNG_BYTE);
+
+	rk_rng_read_regs(rk_rng, CRYPTO_V2_RNG_DOUT_0, buf, ret);
+
+out:
+	/* close TRNG */
+	rk_rng_writel(rk_rng, HIWORD_UPDATE(0, 0xffff, 0), CRYPTO_V2_RNG_CTL);
+
+	pm_runtime_mark_last_busy(rk_rng->dev);
+	pm_runtime_put_sync_autosuspend(rk_rng->dev);
+
+	return ret;
+}
+
+static const struct rk_rng_soc_data rk_rng_v1_soc_data = {
+	.clks_num = ARRAY_SIZE(rk_rng_v1_clks),
+	.clks = rk_rng_v1_clks,
+	.rk_rng_read = rk_rng_v1_read,
+};
+
+static const struct rk_rng_soc_data rk_rng_v2_soc_data = {
+	.clks_num = ARRAY_SIZE(rk_rng_v2_clks),
+	.clks = rk_rng_v2_clks,
+	.rk_rng_read = rk_rng_v2_read,
+};
+
+static const struct of_device_id rk_rng_dt_match[] = {
+	{
+		.compatible = "rockchip,cryptov1-rng",
+		.data = (void *)&rk_rng_v1_soc_data,
+	},
+	{
+		.compatible = "rockchip,cryptov2-rng",
+		.data = (void *)&rk_rng_v2_soc_data,
+	},
+	{ },
+};
+
+MODULE_DEVICE_TABLE(of, rk_rng_dt_match);
+
+static int rk_rng_probe(struct platform_device *pdev)
+{
+	int i;
+	int ret;
+	struct rk_rng *rk_rng;
+	struct device_node *np = pdev->dev.of_node;
+	const struct of_device_id *match;
+
+	rk_rng = devm_kzalloc(&pdev->dev, sizeof(struct rk_rng), GFP_KERNEL);
+	if (!rk_rng)
+		return -ENOMEM;
+
+	match = of_match_node(rk_rng_dt_match, np);
+	rk_rng->soc_data = (struct rk_rng_soc_data *)match->data;
+
+	rk_rng->dev = &pdev->dev;
+	rk_rng->rng.name    = "rockchip";
+#ifndef CONFIG_PM
+	rk_rng->rng.init    = rk_rng_init;
+	rk_rng->rng.cleanup = rk_rng_cleanup,
+#endif
+	rk_rng->rng.read    = rk_rng->soc_data->rk_rng_read;
+	rk_rng->rng.quality = 1024;
+
+	rk_rng->clk_bulks =
+		devm_kzalloc(&pdev->dev, sizeof(*rk_rng->clk_bulks) *
+			     rk_rng->soc_data->clks_num, GFP_KERNEL);
+
+	rk_rng->clk_num = rk_rng->soc_data->clks_num;
+
+	for (i = 0; i < rk_rng->soc_data->clks_num; i++)
+		rk_rng->clk_bulks[i].id = rk_rng->soc_data->clks[i];
+
+	rk_rng->mem = devm_of_iomap(&pdev->dev, pdev->dev.of_node, 0, NULL);
+	if (IS_ERR(rk_rng->mem))
+		return PTR_ERR(rk_rng->mem);
+
+	ret = devm_clk_bulk_get(&pdev->dev, rk_rng->clk_num,
+				rk_rng->clk_bulks);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to get clks property\n");
+		return ret;
+	}
+
+	platform_set_drvdata(pdev, rk_rng);
+
+	pm_runtime_set_autosuspend_delay(&pdev->dev,
+					ROCKCHIP_AUTOSUSPEND_DELAY);
+	pm_runtime_use_autosuspend(&pdev->dev);
+	pm_runtime_enable(&pdev->dev);
+
+	ret = devm_hwrng_register(&pdev->dev, &rk_rng->rng);
+	if (ret) {
+		pm_runtime_dont_use_autosuspend(&pdev->dev);
+		pm_runtime_disable(&pdev->dev);
+	}
+
+	return ret;
+}
+
+#ifdef CONFIG_PM
+static int rk_rng_runtime_suspend(struct device *dev)
+{
+	struct rk_rng *rk_rng = dev_get_drvdata(dev);
+
+	rk_rng_cleanup(&rk_rng->rng);
+
+	return 0;
+}
+
+static int rk_rng_runtime_resume(struct device *dev)
+{
+	struct rk_rng *rk_rng = dev_get_drvdata(dev);
+
+	return rk_rng_init(&rk_rng->rng);
+}
+
+static const struct dev_pm_ops rk_rng_pm_ops = {
+	SET_RUNTIME_PM_OPS(rk_rng_runtime_suspend,
+				rk_rng_runtime_resume, NULL)
+	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
+				pm_runtime_force_resume)
+};
+#endif
+
+static struct platform_driver rk_rng_driver = {
+	.driver	= {
+		.name	= "rockchip-rng",
+#ifdef CONFIG_PM
+		.pm	= &rk_rng_pm_ops,
+#endif
+		.of_match_table = rk_rng_dt_match,
+	},
+	.probe	= rk_rng_probe,
+};
+
+module_platform_driver(rk_rng_driver);
+
+MODULE_DESCRIPTION("ROCKCHIP H/W Random Number Generator driver");
+MODULE_AUTHOR("Lin Jinhan <troy.lin@rock-chips.com>");
+MODULE_LICENSE("GPL v2");
-- 
2.37.3

