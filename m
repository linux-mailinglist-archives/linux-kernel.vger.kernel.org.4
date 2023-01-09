Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAA95662BCA
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 17:55:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235244AbjAIQyc convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 9 Jan 2023 11:54:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237393AbjAIQxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 11:53:41 -0500
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FCD5BF57;
        Mon,  9 Jan 2023 08:53:27 -0800 (PST)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id A8B4224DBD3;
        Tue, 10 Jan 2023 00:53:20 +0800 (CST)
Received: from EXMBX168.cuchost.com (172.16.6.78) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 10 Jan
 2023 00:53:20 +0800
Received: from ubuntu.localdomain (202.190.108.220) by EXMBX168.cuchost.com
 (172.16.6.78) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 10 Jan
 2023 00:53:08 +0800
From:   Jia Jie Ho <jiajie.ho@starfivetech.com>
To:     Olivia Mackall <olivia@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Conor Dooley <conor.dooley@microchip.com>
CC:     <linux-crypto@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>
Subject: [PATCH v3 2/3] hwrng: starfive - Add TRNG driver for StarFive SoC
Date:   Tue, 10 Jan 2023 00:52:48 +0800
Message-ID: <20230109165249.110279-3-jiajie.ho@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230109165249.110279-1-jiajie.ho@starfivetech.com>
References: <20230109165249.110279-1-jiajie.ho@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [202.190.108.220]
X-ClientProxiedBy: EXCAS064.cuchost.com (172.16.6.24) To EXMBX168.cuchost.com
 (172.16.6.78)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds driver support for the hardware random number generator in
Starfive SoCs and adds StarFive TRNG entry to MAINTAINERS.

Co-developed-by: Jenny Zhang <jenny.zhang@starfivetech.com>
Signed-off-by: Jenny Zhang <jenny.zhang@starfivetech.com>
Signed-off-by: Jia Jie Ho <jiajie.ho@starfivetech.com>
---
 MAINTAINERS                            |   6 +
 drivers/char/hw_random/Kconfig         |  11 +
 drivers/char/hw_random/Makefile        |   1 +
 drivers/char/hw_random/starfive-trng.c | 395 +++++++++++++++++++++++++
 4 files changed, 413 insertions(+)
 create mode 100644 drivers/char/hw_random/starfive-trng.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 65140500d9f8..b91e3fc11fc6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19626,6 +19626,12 @@ F:	drivers/reset/reset-starfive.c
 F:	include/linux/reset/starfive.h
 F:	include/dt-bindings/reset/starfive*
 
+STARFIVE TRNG DRIVER
+M:	Jia Jie Ho <jiajie.ho@starfivetech.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/rng/starfive*
+F:	drivers/char/hw_random/starfive-trng.c
+
 STATIC BRANCH/CALL
 M:	Peter Zijlstra <peterz@infradead.org>
 M:	Josh Poimboeuf <jpoimboe@kernel.org>
diff --git a/drivers/char/hw_random/Kconfig b/drivers/char/hw_random/Kconfig
index 3da8e85f8aae..ddd7ada7f877 100644
--- a/drivers/char/hw_random/Kconfig
+++ b/drivers/char/hw_random/Kconfig
@@ -549,6 +549,17 @@ config HW_RANDOM_CN10K
 	 To compile this driver as a module, choose M here.
 	 The module will be called cn10k_rng. If unsure, say Y.
 
+config HW_RANDOM_STARFIVE
+	tristate "StarFive HW Random Number Generator support"
+	depends on SOC_STARFIVE
+	depends on HW_RANDOM
+	help
+	  This driver provides support for the Hardware Random Number
+	  Generator in StarFive SoCs.
+
+	  To compile this driver as a module, choose M here.
+	  The module will be called starfive-trng.
+
 endif # HW_RANDOM
 
 config UML_RANDOM
diff --git a/drivers/char/hw_random/Makefile b/drivers/char/hw_random/Makefile
index 3e948cf04476..f68ac370847f 100644
--- a/drivers/char/hw_random/Makefile
+++ b/drivers/char/hw_random/Makefile
@@ -47,3 +47,4 @@ obj-$(CONFIG_HW_RANDOM_XIPHERA) += xiphera-trng.o
 obj-$(CONFIG_HW_RANDOM_ARM_SMCCC_TRNG) += arm_smccc_trng.o
 obj-$(CONFIG_HW_RANDOM_CN10K) += cn10k-rng.o
 obj-$(CONFIG_HW_RANDOM_POLARFIRE_SOC) += mpfs-rng.o
+obj-$(CONFIG_HW_RANDOM_STARFIVE) += starfive-trng.o
diff --git a/drivers/char/hw_random/starfive-trng.c b/drivers/char/hw_random/starfive-trng.c
new file mode 100644
index 000000000000..17012785f282
--- /dev/null
+++ b/drivers/char/hw_random/starfive-trng.c
@@ -0,0 +1,395 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * TRNG driver for the StarFive SoC
+ *
+ * Copyright (C) 2022 StarFive Technology Co.
+ */
+
+#include <linux/clk.h>
+#include <linux/completion.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/hw_random.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/iopoll.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/random.h>
+#include <linux/reset.h>
+
+/* trng register offset */
+#define STARFIVE_CTRL			0x00
+#define STARFIVE_STAT			0x04
+#define STARFIVE_MODE			0x08
+#define STARFIVE_SMODE			0x0C
+#define STARFIVE_IE			0x10
+#define STARFIVE_ISTAT			0x14
+#define STARFIVE_RAND0			0x20
+#define STARFIVE_RAND1			0x24
+#define STARFIVE_RAND2			0x28
+#define STARFIVE_RAND3			0x2C
+#define STARFIVE_RAND4			0x30
+#define STARFIVE_RAND5			0x34
+#define STARFIVE_RAND6			0x38
+#define STARFIVE_RAND7			0x3C
+#define STARFIVE_AUTO_RQSTS		0x60
+#define STARFIVE_AUTO_AGE		0x64
+
+/* CTRL CMD */
+#define STARFIVE_CTRL_EXEC_NOP		0x0
+#define STARFIVE_CTRL_GENE_RANDNUM	0x1
+#define STARFIVE_CTRL_EXEC_RANDRESEED	0x2
+
+/* STAT */
+#define STARFIVE_STAT_NONCE_MODE	BIT(2)
+#define STARFIVE_STAT_R256		BIT(3)
+#define STARFIVE_STAT_MISSION_MODE	BIT(8)
+#define STARFIVE_STAT_SEEDED		BIT(9)
+#define STARFIVE_STAT_LAST_RESEED(x)	((x) << 16)
+#define STARFIVE_STAT_SRVC_RQST		BIT(27)
+#define STARFIVE_STAT_RAND_GENERATING	BIT(30)
+#define STARFIVE_STAT_RAND_SEEDING	BIT(31)
+
+/* MODE */
+#define STARFIVE_MODE_R256		BIT(3)
+
+/* SMODE */
+#define STARFIVE_SMODE_NONCE_MODE	BIT(2)
+#define STARFIVE_SMODE_MISSION_MODE	BIT(8)
+#define STARFIVE_SMODE_MAX_REJECTS(x)	((x) << 16)
+
+/* IE */
+#define STARFIVE_IE_RAND_RDY_EN		BIT(0)
+#define STARFIVE_IE_SEED_DONE_EN	BIT(1)
+#define STARFIVE_IE_LFSR_LOCKUP_EN	BIT(4)
+#define STARFIVE_IE_GLBL_EN		BIT(31)
+
+#define STARFIVE_IE_ALL			(STARFIVE_IE_GLBL_EN | \
+					 STARFIVE_IE_RAND_RDY_EN | \
+					 STARFIVE_IE_SEED_DONE_EN | \
+					 STARFIVE_IE_LFSR_LOCKUP_EN)
+
+/* ISTAT */
+#define STARFIVE_ISTAT_RAND_RDY		BIT(0)
+#define STARFIVE_ISTAT_SEED_DONE	BIT(1)
+#define STARFIVE_ISTAT_LFSR_LOCKUP	BIT(4)
+
+#define STARFIVE_RAND_LEN		sizeof(u32)
+
+#define to_trng(p)			container_of(p, struct starfive_trng, rng)
+
+enum reseed {
+	RANDOM_RESEED,
+	NONCE_RESEED,
+};
+
+enum mode {
+	PRNG_128BIT,
+	PRNG_256BIT,
+};
+
+struct starfive_trng {
+	struct device		*dev;
+	void __iomem		*base;
+	struct clk		*hclk;
+	struct clk		*ahb;
+	struct reset_control	*rst;
+	struct hwrng		rng;
+	struct completion	random_done;
+	struct completion	reseed_done;
+	u32			mode;
+	u32			mission;
+	u32			reseed;
+};
+
+static u16 autoreq;
+module_param(autoreq, ushort, 0);
+MODULE_PARM_DESC(autoreq, "Auto-reseeding after random number requests by host reaches specified counter:\n"
+				" 0 - disable counter\n"
+				" other - reload value for internal counter");
+
+static u16 autoage;
+module_param(autoage, ushort, 0);
+MODULE_PARM_DESC(autoage, "Auto-reseeding after specified timer countdowns to 0:\n"
+				" 0 - disable timer\n"
+				" other - reload value for internal timer");
+
+static inline int starfive_trng_wait_idle(struct starfive_trng *trng)
+{
+	u32 stat;
+
+	return readl_relaxed_poll_timeout(trng->base + STARFIVE_STAT, stat,
+					  !(stat & (STARFIVE_STAT_RAND_GENERATING |
+						    STARFIVE_STAT_RAND_SEEDING)),
+					  10, 100000);
+}
+
+static inline void starfive_trng_irq_mask_clear(struct starfive_trng *trng)
+{
+	/* clear register: ISTAT */
+	u32 data = readl(trng->base + STARFIVE_ISTAT);
+
+	writel(data, trng->base + STARFIVE_ISTAT);
+}
+
+static int starfive_trng_cmd(struct starfive_trng *trng, u32 cmd, bool wait)
+{
+	int wait_time = 1000;
+
+	/* allow up to 40 us for wait == 0 */
+	if (!wait)
+		wait_time = 40;
+
+	switch (cmd) {
+	case STARFIVE_CTRL_GENE_RANDNUM:
+		reinit_completion(&trng->random_done);
+		writel(cmd, trng->base + STARFIVE_CTRL);
+		if (!wait_for_completion_timeout(&trng->random_done, usecs_to_jiffies(wait_time)))
+			return -ETIMEDOUT;
+		break;
+	case STARFIVE_CTRL_EXEC_RANDRESEED:
+		reinit_completion(&trng->reseed_done);
+		writel(cmd, trng->base + STARFIVE_CTRL);
+		if (!wait_for_completion_timeout(&trng->reseed_done, usecs_to_jiffies(wait_time)))
+			return -ETIMEDOUT;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int starfive_trng_init(struct hwrng *rng)
+{
+	struct starfive_trng *trng = to_trng(rng);
+	u32 mode, intr = 0;
+	int ret;
+
+	/* setup Auto Request/Age register */
+	writel(autoage, trng->base + STARFIVE_AUTO_AGE);
+	writel(autoreq, trng->base + STARFIVE_AUTO_RQSTS);
+
+	/* clear register: ISTAT */
+	starfive_trng_irq_mask_clear(trng);
+
+	intr |= STARFIVE_IE_ALL;
+	writel(intr, trng->base + STARFIVE_IE);
+
+	mode  = readl(trng->base + STARFIVE_MODE);
+
+	switch (trng->mode) {
+	case PRNG_128BIT:
+		mode &= ~STARFIVE_MODE_R256;
+		break;
+	case PRNG_256BIT:
+		mode |= STARFIVE_MODE_R256;
+		break;
+	default:
+		mode |= STARFIVE_MODE_R256;
+		break;
+	}
+
+	writel(mode, trng->base + STARFIVE_MODE);
+
+	writel(STARFIVE_CTRL_EXEC_NOP, trng->base + STARFIVE_CTRL);
+
+	ret = starfive_trng_wait_idle(trng);
+	if (ret)
+		return -ETIMEDOUT;
+
+	return starfive_trng_cmd(trng, STARFIVE_CTRL_EXEC_RANDRESEED, 1);
+}
+
+static irqreturn_t starfive_trng_irq(int irq, void *priv)
+{
+	u32 status;
+	struct starfive_trng *trng = (struct starfive_trng *)priv;
+
+	status = readl(trng->base + STARFIVE_ISTAT);
+	if (status & STARFIVE_ISTAT_RAND_RDY) {
+		writel(STARFIVE_ISTAT_RAND_RDY, trng->base + STARFIVE_ISTAT);
+		complete(&trng->random_done);
+	}
+
+	if (status & STARFIVE_ISTAT_SEED_DONE) {
+		writel(STARFIVE_ISTAT_SEED_DONE, trng->base + STARFIVE_ISTAT);
+		complete(&trng->reseed_done);
+	}
+
+	if (status & STARFIVE_ISTAT_LFSR_LOCKUP) {
+		writel(STARFIVE_ISTAT_LFSR_LOCKUP, trng->base + STARFIVE_ISTAT);
+		/* SEU occurred, reseeding required*/
+		writel(STARFIVE_CTRL_EXEC_RANDRESEED, trng->base + STARFIVE_CTRL);
+	}
+
+	return IRQ_HANDLED;
+}
+
+static void starfive_trng_cleanup(struct hwrng *rng)
+{
+	struct starfive_trng *trng = to_trng(rng);
+
+	writel(0, trng->base + STARFIVE_CTRL);
+
+	reset_control_assert(trng->rst);
+	clk_disable_unprepare(trng->hclk);
+	clk_disable_unprepare(trng->ahb);
+}
+
+static int starfive_trng_read(struct hwrng *rng, void *buf, size_t max, bool wait)
+{
+	struct starfive_trng *trng = to_trng(rng);
+	int ret;
+
+	pm_runtime_get_sync(trng->dev);
+
+	if (trng->mode == PRNG_256BIT)
+		max = min_t(size_t, max, (STARFIVE_RAND_LEN * 8));
+	else
+		max = min_t(size_t, max, (STARFIVE_RAND_LEN * 4));
+
+	if (wait) {
+		ret = starfive_trng_wait_idle(trng);
+		if (ret)
+			return -ETIMEDOUT;
+	}
+
+	ret = starfive_trng_cmd(trng, STARFIVE_CTRL_GENE_RANDNUM, wait);
+	if (ret)
+		return ret;
+
+	memcpy_fromio(buf, trng->base + STARFIVE_RAND0, max);
+
+	pm_runtime_put_sync_autosuspend(trng->dev);
+
+	return max;
+}
+
+static int starfive_trng_probe(struct platform_device *pdev)
+{
+	int ret;
+	int irq;
+	struct starfive_trng *trng;
+
+	trng = devm_kzalloc(&pdev->dev, sizeof(*trng), GFP_KERNEL);
+	if (!trng)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, trng);
+	trng->dev = &pdev->dev;
+
+	trng->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(trng->base))
+		return dev_err_probe(&pdev->dev, PTR_ERR(trng->base),
+				     "Error remapping memory for platform device.\n");
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return irq;
+
+	ret = devm_request_irq(&pdev->dev, irq, starfive_trng_irq, 0, pdev->name,
+			       (void *)trng);
+	if (ret)
+		return dev_err_probe(&pdev->dev, irq,
+				     "Failed to register interrupt handler\n");
+
+	trng->hclk = devm_clk_get(&pdev->dev, "hclk");
+	if (IS_ERR(trng->hclk))
+		return dev_err_probe(&pdev->dev, PTR_ERR(trng->hclk),
+				     "Error getting hardware reference clock\n");
+
+	trng->ahb = devm_clk_get(&pdev->dev, "ahb");
+	if (IS_ERR(trng->ahb))
+		return dev_err_probe(&pdev->dev, PTR_ERR(trng->ahb),
+				     "Error getting ahb reference clock\n");
+
+	trng->rst = devm_reset_control_get_shared(&pdev->dev, NULL);
+	if (IS_ERR(trng->rst))
+		return dev_err_probe(&pdev->dev, PTR_ERR(trng->rst),
+				     "Error getting hardware reset line\n");
+
+	clk_prepare_enable(trng->hclk);
+	clk_prepare_enable(trng->ahb);
+	reset_control_deassert(trng->rst);
+
+	init_completion(&trng->random_done);
+	init_completion(&trng->reseed_done);
+
+	trng->rng.name = dev_driver_string(&pdev->dev);
+	trng->rng.init = starfive_trng_init;
+	trng->rng.cleanup = starfive_trng_cleanup;
+	trng->rng.read = starfive_trng_read;
+
+	trng->mode = PRNG_256BIT;
+	trng->mission = 1;
+	trng->reseed = RANDOM_RESEED;
+
+	ret = devm_hwrng_register(&pdev->dev, &trng->rng);
+	if (ret) {
+		dev_err_probe(&pdev->dev, ret, "Failed to register hwrng\n");
+		goto err_fail_register;
+	}
+
+	pm_runtime_use_autosuspend(&pdev->dev);
+	pm_runtime_set_autosuspend_delay(&pdev->dev, 100);
+	pm_runtime_enable(&pdev->dev);
+
+	return 0;
+
+err_fail_register:
+	pm_runtime_disable(&pdev->dev);
+
+	reset_control_assert(trng->rst);
+	clk_disable_unprepare(trng->ahb);
+	clk_disable_unprepare(trng->hclk);
+
+	return ret;
+}
+
+static int __maybe_unused starfive_trng_suspend(struct device *dev)
+{
+	struct starfive_trng *trng = dev_get_drvdata(dev);
+
+	clk_disable_unprepare(trng->hclk);
+	clk_disable_unprepare(trng->ahb);
+
+	return 0;
+}
+
+static int __maybe_unused starfive_trng_resume(struct device *dev)
+{
+	struct starfive_trng *trng = dev_get_drvdata(dev);
+
+	clk_prepare_enable(trng->hclk);
+	clk_prepare_enable(trng->ahb);
+
+	return 0;
+}
+
+static DEFINE_SIMPLE_DEV_PM_OPS(starfive_trng_pm_ops, starfive_trng_suspend,
+				starfive_trng_resume);
+
+static const struct of_device_id trng_dt_ids[] __maybe_unused = {
+	{ .compatible = "starfive,jh7110-trng" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, trng_dt_ids);
+
+static struct platform_driver starfive_trng_driver = {
+	.probe	= starfive_trng_probe,
+	.driver	= {
+		.name		= "starfive-trng",
+		.pm		= &starfive_trng_pm_ops,
+		.of_match_table	= of_match_ptr(trng_dt_ids),
+	},
+};
+
+module_platform_driver(starfive_trng_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("StarFive True Random Number Generator");
-- 
2.25.1

