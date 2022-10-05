Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFE6A5F512F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 10:53:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbiJEIxR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 04:53:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbiJEIxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 04:53:13 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5FB45B79A;
        Wed,  5 Oct 2022 01:53:11 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id bu30so5010806wrb.8;
        Wed, 05 Oct 2022 01:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=mD6VQz9WFibdMEj3yNS/4C4w2+rLYFQZrNucxRHHEtY=;
        b=A6WLIwGWyAEhmxZDImz1iQ844kw150/x0h0r+1y7znBPW+BlHRJOuFNsrGgvEZTK6t
         p06pzqX++HbOUBlLM+ftH2FKTJvvl33oHiG8H+IrfqQ52rmTXWSKEKTCSs7Er4Pfy97K
         GoViwvHi4gAiAiX+fErCG4jxYfyDWT0KaeO63BxtMXlw+h0ila/yRBKEs58ZJ/ninAlb
         RWT5U8UeUmvNl3mATpMyw9RJiZT4WBYDOs9qahzosliGzqYqnTa+crKmEBsY2Ih34j4G
         AXilxEbMKHUEHIoA793CHFs50dUqTvLjUn3glC6h4fWnuXVxdb7YWpBNCw3exkwlH4PY
         WU4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=mD6VQz9WFibdMEj3yNS/4C4w2+rLYFQZrNucxRHHEtY=;
        b=qng5majokAsS9ZhVCTrsmapZWrcSz5Hu+PIHjggkIVuG4G/2gFJrKouSe9+0Gr7Ak3
         LwYnR713zfrkVUNXYjVkbulcxRsdSJgN6NNO8HMhyd62/Dg3riHR3vJVMwszBAXtB2iX
         AxfN64bXAYwxJX47HDndffP/xQSPNLkYGmc063feESbuw+O6zecHJJWcnESjMjl5yZFd
         EXhfIKkUlnzwHXGZjrcWQGAZI+kOYjKVJ63Bhxtotym7VJd9syuRcnoHDWkTceg56R+m
         6LjM0CMoCuJSGTxQcR4FoDk4oHhMYrOnD8bAHHSkabN7Xxud+fM+R6h0eStAhIXLOrco
         kEoQ==
X-Gm-Message-State: ACrzQf3bzywm5Myx2IODFFcD8rw6vR6sCyMs6hJ6ZS2Fn3UazHj6Na5d
        62MpRdFj/CaBdFYzvUpSgks=
X-Google-Smtp-Source: AMsMyM5hDGdEa/xKgl8AgOcKpbznzBkeBn9SKMOSOpOG9vkOeAuVudAIO2tnRJUJPwWaTAEN37ypNQ==
X-Received: by 2002:a5d:6e92:0:b0:22c:c09c:8f23 with SMTP id k18-20020a5d6e92000000b0022cc09c8f23mr18871016wrz.389.1664959990354;
        Wed, 05 Oct 2022 01:53:10 -0700 (PDT)
Received: from debby ([2a01:e0a:a6d:a8d0:7ff4:8f61:5574:9f95])
        by smtp.gmail.com with ESMTPSA id bg34-20020a05600c3ca200b003a6a3595edasm1322175wmb.27.2022.10.05.01.53.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 01:53:09 -0700 (PDT)
From:   Romain Perier <romain.perier@gmail.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        Daniel Palmer <daniel@0x0f.com>,
        Romain Perier <romain.perier@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Willy Tarreau <w@1wt.eu>
Subject: [PATCH RESEND v6 1/1] clk: mstar: msc313 cpupll clk driver
Date:   Wed,  5 Oct 2022 10:53:05 +0200
Message-Id: <20221005085305.42075-2-romain.perier@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221005085305.42075-1-romain.perier@gmail.com>
References: <20221005085305.42075-1-romain.perier@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Palmer <daniel@0x0f.com>

Add a driver for the CPU pll/ARM pll/MIPS pll that is present
in MStar SoCs.

Currently there is no documentation for this block so it's possible
this driver isn't entirely correct.

Only tested on the version of this IP in the MStar/SigmaStar
ARMv7 SoCs.

Signed-off-by: Daniel Palmer <daniel@0x0f.com>
Co-developed-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 drivers/clk/mstar/Kconfig             |   7 +
 drivers/clk/mstar/Makefile            |   1 +
 drivers/clk/mstar/clk-msc313-cpupll.c | 220 ++++++++++++++++++++++++++
 3 files changed, 228 insertions(+)
 create mode 100644 drivers/clk/mstar/clk-msc313-cpupll.c

diff --git a/drivers/clk/mstar/Kconfig b/drivers/clk/mstar/Kconfig
index de37e1bce2d2..b9bcb5e02814 100644
--- a/drivers/clk/mstar/Kconfig
+++ b/drivers/clk/mstar/Kconfig
@@ -1,4 +1,11 @@
 # SPDX-License-Identifier: GPL-2.0-only
+config MSTAR_MSC313_CPUPLL
+	bool "MStar CPUPLL driver"
+	depends on ARCH_MSTARV7 || COMPILE_TEST
+	default ARCH_MSTARV7
+	help
+	  Support for the CPU PLL present on MStar/Sigmastar SoCs.
+
 config MSTAR_MSC313_MPLL
 	bool "MStar MPLL driver"
 	depends on ARCH_MSTARV7 || COMPILE_TEST
diff --git a/drivers/clk/mstar/Makefile b/drivers/clk/mstar/Makefile
index f8dcd25ede1d..17d97eedcd36 100644
--- a/drivers/clk/mstar/Makefile
+++ b/drivers/clk/mstar/Makefile
@@ -3,4 +3,5 @@
 # Makefile for mstar specific clk
 #
 
+obj-$(CONFIG_MSTAR_MSC313_CPUPLL) += clk-msc313-cpupll.o
 obj-$(CONFIG_MSTAR_MSC313_MPLL) += clk-msc313-mpll.o
diff --git a/drivers/clk/mstar/clk-msc313-cpupll.c b/drivers/clk/mstar/clk-msc313-cpupll.c
new file mode 100644
index 000000000000..a93e2dba09d3
--- /dev/null
+++ b/drivers/clk/mstar/clk-msc313-cpupll.c
@@ -0,0 +1,220 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2019 Daniel Palmer <daniel@thingy.jp>
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/device.h>
+#include <linux/kernel.h>
+#include <linux/of_address.h>
+#include <linux/platform_device.h>
+
+/*
+ * This IP is not documented outside of the messy vendor driver.
+ * Below is what we think the registers look like based on looking at
+ * the vendor code and poking at the hardware:
+ *
+ * 0x140 -- LPF low. Seems to store one half of the clock transition
+ * 0x144 /
+ * 0x148 -- LPF high. Seems to store one half of the clock transition
+ * 0x14c /
+ * 0x150 -- vendor code says "toggle lpf enable"
+ * 0x154 -- mu?
+ * 0x15c -- lpf_update_count?
+ * 0x160 -- vendor code says "switch to LPF". Clock source config? Register bank?
+ * 0x164 -- vendor code says "from low to high" which seems to mean transition from LPF low to
+ * LPF high.
+ * 0x174 -- Seems to be the PLL lock status bit
+ * 0x180 -- Seems to be the current frequency, this might need to be populated by software?
+ * 0x184 /  The vendor driver uses these to set the initial value of LPF low
+ *
+ * Frequency seems to be calculated like this:
+ * (parent clock (432mhz) / register_magic_value) * 16 * 524288
+ * Only the lower 24 bits of the resulting value will be used. In addition, the
+ * PLL doesn't seem to be able to lock on frequencies lower than 220 MHz, as
+ * divisor 0xfb586f (220 MHz) works but 0xfb7fff locks up.
+ *
+ * Vendor values:
+ * frequency - register value
+ *
+ * 400000000  - 0x0067AE14
+ * 600000000  - 0x00451EB8,
+ * 800000000  - 0x0033D70A,
+ * 1000000000 - 0x002978d4,
+ */
+
+#define REG_LPF_LOW_L		0x140
+#define REG_LPF_LOW_H		0x144
+#define REG_LPF_HIGH_BOTTOM	0x148
+#define REG_LPF_HIGH_TOP	0x14c
+#define REG_LPF_TOGGLE		0x150
+#define REG_LPF_MYSTERYTWO	0x154
+#define REG_LPF_UPDATE_COUNT	0x15c
+#define REG_LPF_MYSTERYONE	0x160
+#define REG_LPF_TRANSITIONCTRL	0x164
+#define REG_LPF_LOCK		0x174
+#define REG_CURRENT		0x180
+
+#define LPF_LOCK_TIMEOUT	100000000
+
+#define MULTIPLIER_1		16
+#define MULTIPLIER_2		524288
+#define MULTIPLIER		(MULTIPLIER_1 * MULTIPLIER_2)
+
+struct msc313_cpupll {
+	void __iomem *base;
+	struct clk_hw clk_hw;
+};
+
+#define to_cpupll(_hw) container_of(_hw, struct msc313_cpupll, clk_hw)
+
+static u32 msc313_cpupll_reg_read32(struct msc313_cpupll *cpupll, unsigned int reg)
+{
+	u32 value;
+
+	value = ioread16(cpupll->base + reg + 4) << 16;
+	value |= ioread16(cpupll->base + reg);
+
+	return value;
+}
+
+static void msc313_cpupll_reg_write32(struct msc313_cpupll *cpupll, unsigned int reg, u32 value)
+{
+	u16 l = value & 0xffff, h = (value >> 16) & 0xffff;
+
+	iowrite16(l, cpupll->base + reg);
+	iowrite16(h, cpupll->base + reg + 4);
+}
+
+static void msc313_cpupll_setfreq(struct msc313_cpupll *cpupll, u32 regvalue)
+{
+	ktime_t timeout;
+
+	msc313_cpupll_reg_write32(cpupll, REG_LPF_HIGH_BOTTOM, regvalue);
+
+	iowrite16(0x1, cpupll->base + REG_LPF_MYSTERYONE);
+	iowrite16(0x6, cpupll->base + REG_LPF_MYSTERYTWO);
+	iowrite16(0x8, cpupll->base + REG_LPF_UPDATE_COUNT);
+	iowrite16(BIT(12), cpupll->base + REG_LPF_TRANSITIONCTRL);
+
+	iowrite16(0, cpupll->base + REG_LPF_TOGGLE);
+	iowrite16(1, cpupll->base + REG_LPF_TOGGLE);
+
+	timeout = ktime_add_ns(ktime_get(), LPF_LOCK_TIMEOUT);
+	while (!(ioread16(cpupll->base + REG_LPF_LOCK))) {
+		if (ktime_after(ktime_get(), timeout)) {
+			pr_err("timeout waiting for LPF_LOCK\n");
+			return;
+		}
+		cpu_relax();
+	}
+
+	iowrite16(0, cpupll->base + REG_LPF_TOGGLE);
+
+	msc313_cpupll_reg_write32(cpupll, REG_LPF_LOW_L, regvalue);
+}
+
+static unsigned long msc313_cpupll_frequencyforreg(u32 reg, unsigned long parent_rate)
+{
+	unsigned long long prescaled = ((unsigned long long)parent_rate) * MULTIPLIER;
+
+	if (prescaled == 0 || reg == 0)
+		return 0;
+	return DIV_ROUND_DOWN_ULL(prescaled, reg);
+}
+
+static u32 msc313_cpupll_regforfrequecy(unsigned long rate, unsigned long parent_rate)
+{
+	unsigned long long prescaled = ((unsigned long long)parent_rate) * MULTIPLIER;
+
+	if (prescaled == 0 || rate == 0)
+		return 0;
+	return DIV_ROUND_UP_ULL(prescaled, rate);
+}
+
+static unsigned long msc313_cpupll_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
+{
+	struct msc313_cpupll *cpupll = to_cpupll(hw);
+
+	return msc313_cpupll_frequencyforreg(msc313_cpupll_reg_read32(cpupll, REG_LPF_LOW_L),
+					     parent_rate);
+}
+
+static long msc313_cpupll_round_rate(struct clk_hw *hw, unsigned long rate,
+				     unsigned long *parent_rate)
+{
+	u32 reg = msc313_cpupll_regforfrequecy(rate, *parent_rate);
+	long rounded = msc313_cpupll_frequencyforreg(reg, *parent_rate);
+
+	/*
+	 * This is my poor attempt at making sure the resulting
+	 * rate doesn't overshoot the requested rate.
+	 */
+	for (; rounded >= rate && reg > 0; reg--)
+		rounded = msc313_cpupll_frequencyforreg(reg, *parent_rate);
+
+	return rounded;
+}
+
+static int msc313_cpupll_set_rate(struct clk_hw *hw, unsigned long rate, unsigned long parent_rate)
+{
+	struct msc313_cpupll *cpupll = to_cpupll(hw);
+	u32 reg = msc313_cpupll_regforfrequecy(rate, parent_rate);
+
+	msc313_cpupll_setfreq(cpupll, reg);
+
+	return 0;
+}
+
+static const struct clk_ops msc313_cpupll_ops = {
+	.recalc_rate	= msc313_cpupll_recalc_rate,
+	.round_rate	= msc313_cpupll_round_rate,
+	.set_rate	= msc313_cpupll_set_rate,
+};
+
+static const struct of_device_id msc313_cpupll_of_match[] = {
+	{ .compatible = "mstar,msc313-cpupll" },
+	{}
+};
+
+static int msc313_cpupll_probe(struct platform_device *pdev)
+{
+	struct clk_init_data clk_init = {};
+	struct clk_parent_data cpupll_parent = { .index	= 0 };
+	struct device *dev = &pdev->dev;
+	struct msc313_cpupll *cpupll;
+	int ret;
+
+	cpupll = devm_kzalloc(&pdev->dev, sizeof(*cpupll), GFP_KERNEL);
+	if (!cpupll)
+		return -ENOMEM;
+
+	cpupll->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(cpupll->base))
+		return PTR_ERR(cpupll->base);
+
+	/* LPF might not contain the current frequency so fix that up */
+	msc313_cpupll_reg_write32(cpupll, REG_LPF_LOW_L,
+				  msc313_cpupll_reg_read32(cpupll, REG_CURRENT));
+
+	clk_init.name = dev_name(dev);
+	clk_init.ops = &msc313_cpupll_ops;
+	clk_init.parent_data = &cpupll_parent;
+	clk_init.num_parents = 1;
+	cpupll->clk_hw.init = &clk_init;
+
+	ret = devm_clk_hw_register(dev, &cpupll->clk_hw);
+	if (ret)
+		return ret;
+
+	return devm_of_clk_add_hw_provider(&pdev->dev, of_clk_hw_simple_get, &cpupll->clk_hw);
+}
+
+static struct platform_driver msc313_cpupll_driver = {
+	.driver = {
+		.name = "mstar-msc313-cpupll",
+		.of_match_table = msc313_cpupll_of_match,
+	},
+	.probe = msc313_cpupll_probe,
+};
+builtin_platform_driver(msc313_cpupll_driver);
-- 
2.35.1

