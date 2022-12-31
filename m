Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B167265A394
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Dec 2022 11:48:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232020AbiLaKsU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 05:48:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiLaKsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 05:48:00 -0500
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08CC7D10D
        for <linux-kernel@vger.kernel.org>; Sat, 31 Dec 2022 02:47:58 -0800 (PST)
Received: by mail-ej1-x641.google.com with SMTP id gh17so56430377ejb.6
        for <linux-kernel@vger.kernel.org>; Sat, 31 Dec 2022 02:47:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d8WEj9/C0OhSqYwiG2nnUMjHUoH+KTqQswi/Eb48WWY=;
        b=faGsjlnuCzfCPHiRcZ1qw4oPmkoFMcCH2iMe8ETxugAl0liXMqMz8abSOkdc6/49Nv
         gEDEsi4REBwJBqOHMJx3vaV8ZZhwvU6/yv5aUqtSi3SE7p41uRui3q6yJeWVcq1TTzxs
         c3E86ljyETMwKYcAqklaVs17D/ctAHEzimSEA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d8WEj9/C0OhSqYwiG2nnUMjHUoH+KTqQswi/Eb48WWY=;
        b=O3VajqJkeSMz4mSTfMXKo3gBsvSrOTMA1uE86XkA8T//4II8PGUpqIkOZKIxu/79mE
         Vd1OB1wSssd7RJ9bH+pVjL0Lq+gNfkuql/EB3qMf3FV80I37rOfYQOiWmmGcL6x57CRI
         1VPQheG8Rta45Iv8JuF4yurzZl7tRG0jjqSKgVkjuxFzltqozkaPpJ2T0AU3sEaMasYJ
         dfAg8AcMJQ1sNRsheNikxhhIxuBY/QruXZJWwU+eh+KS9UkF396L8Nb8Ak+Xm4FPkbtW
         HOY0iU6hmGvIvyECoWtB60IBDZtvxdTi6x7dYMm1FOmk4xJ56HE8R/35Kify+fxzxwGt
         RuZw==
X-Gm-Message-State: AFqh2kp92gtWtRtsO1Cvh32+fA6fD5gFN/wkQPiQpSj0ExlzCt0XSAvd
        M5mYPHn0uutVnUjoCTLVZTDv4rOUub5CciTLMoU=
X-Google-Smtp-Source: AMrXdXtQZ5PYyji1oGUrR72dCgZDGXss/dvqbdGt9E4S2rg3dCbMe5ImjH9I9Rna7/6Ly7y+KyLLLA==
X-Received: by 2002:a17:907:80cb:b0:7c0:deb1:bb8a with SMTP id io11-20020a17090780cb00b007c0deb1bb8amr35195077ejc.28.1672483677349;
        Sat, 31 Dec 2022 02:47:57 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-80-180-23-57.retail.telecomitalia.it. [80.180.23.57])
        by smtp.gmail.com with ESMTPSA id z4-20020a17090655c400b0083ffb81f01esm10765438ejp.136.2022.12.31.02.47.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Dec 2022 02:47:57 -0800 (PST)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     tommaso.merciai@amarulasolutions.com,
        linux-amarula@amarulasolutions.com,
        Chen-Yu Tsai <wenst@chromium.org>, jagan@amarulasolutions.com,
        angelo@amarulasolutions.com, anthony@amarulasolutions.com,
        michael@amarulasolutions.com,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Abel Vesa <abelvesa@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
Subject: [RFC PATCH 05/11] clk: imx8mn: add divider driver
Date:   Sat, 31 Dec 2022 11:47:30 +0100
Message-Id: <20221231104736.12635-6-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20221231104736.12635-1-dario.binacchi@amarulasolutions.com>
References: <20221231104736.12635-1-dario.binacchi@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch adds support for imx8mn divider clocks to be initialized
directly from the device tree. Currently all i.MX divider clocks are
initialized by legacy code with hardwired parameters.

So, let's start with this specific clock driver and hope that other
variants can be handled in the future, causing the legacy code to be
removed.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

 drivers/clk/imx/Makefile      |   1 +
 drivers/clk/imx/clk-divider.c | 235 ++++++++++++++++++++++++++++++++++
 2 files changed, 236 insertions(+)
 create mode 100644 drivers/clk/imx/clk-divider.c

diff --git a/drivers/clk/imx/Makefile b/drivers/clk/imx/Makefile
index 1cffc5bebbe1..0e4337f0a020 100644
--- a/drivers/clk/imx/Makefile
+++ b/drivers/clk/imx/Makefile
@@ -7,6 +7,7 @@ mxc-clk-objs += clk-composite-8m.o
 mxc-clk-objs += clk-composite-93.o
 mxc-clk-objs += clk-fracn-gppll.o
 mxc-clk-objs += clk-cpu.o
+mxc-clk-objs += clk-divider.o
 mxc-clk-objs += clk-divider-gate.o
 mxc-clk-objs += clk-fixup-div.o
 mxc-clk-objs += clk-fixup-mux.o
diff --git a/drivers/clk/imx/clk-divider.c b/drivers/clk/imx/clk-divider.c
new file mode 100644
index 000000000000..4617aa906de4
--- /dev/null
+++ b/drivers/clk/imx/clk-divider.c
@@ -0,0 +1,235 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2022 Amarula Solutions
+ *
+ * Dario Binacchi <dario.binacchi@amarulasolutions.com>
+ */
+
+#include <linux/mfd/syscon.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/regmap.h>
+
+#include "clk.h"
+
+#undef pr_fmt
+#define pr_fmt(fmt) "%s: " fmt, __func__
+
+#define to_clk_imx_divider(_hw) container_of(_hw, struct clk_imx_divider, hw)
+
+struct clk_imx_divider {
+	struct clk_hw hw;
+	struct imx_clk_reg reg;
+	u8 shift;
+	u8 width;
+};
+
+static int imx_clk_divider_write(const struct imx_clk_reg *reg, u32 val)
+{
+	int ret = 0;
+
+	if (reg->base) {
+		writel(val, reg->base + reg->offset);
+	} else if (reg->regmap) {
+		ret = regmap_write(reg->regmap, reg->offset, val);
+	} else {
+		pr_err("memory address not set\n");
+		ret = -EIO;
+	}
+
+	return ret;
+}
+
+static int imx_clk_divider_read(const struct imx_clk_reg *reg, u32 *val)
+{
+	int ret = 0;
+
+	if (reg->base) {
+		*val = readl(reg->base + reg->offset);
+	} else if (reg->regmap) {
+		ret = regmap_read(reg->regmap, reg->offset, val);
+	} else {
+		pr_err("memory address not set\n");
+		ret = -EIO;
+	}
+
+	return ret;
+}
+
+static unsigned long imx_clk_divider_recalc_rate(struct clk_hw *hw,
+						 unsigned long parent_rate)
+{
+	struct clk_imx_divider *divider = to_clk_imx_divider(hw);
+	unsigned int val;
+	int ret;
+
+	ret = imx_clk_divider_read(&divider->reg, &val);
+	if (ret)
+		return 0;
+
+	val >>= divider->shift;
+	val &= clk_div_mask(divider->width);
+
+	return divider_recalc_rate(hw, parent_rate, val, NULL, 0,
+				   divider->width);
+}
+
+static long imx_clk_divider_round_rate(struct clk_hw *hw, unsigned long rate,
+				       unsigned long *prate)
+{
+	struct clk_imx_divider *divider = to_clk_imx_divider(hw);
+
+	return divider_round_rate(hw, rate, prate, NULL, divider->width, 0);
+}
+
+static int imx_clk_divider_determine_rate(struct clk_hw *hw,
+					  struct clk_rate_request *req)
+{
+	struct clk_imx_divider *divider = to_clk_imx_divider(hw);
+
+	return divider_determine_rate(hw, req, NULL, divider->width, 0);
+}
+
+static int imx_clk_divider_set_rate(struct clk_hw *hw, unsigned long rate,
+				    unsigned long parent_rate)
+{
+	struct clk_imx_divider *divider = to_clk_imx_divider(hw);
+	unsigned int val;
+	int div, ret;
+
+	div = divider_get_val(rate, parent_rate, NULL, divider->width, 0);
+	if (div < 0)
+		return div;
+
+	ret = imx_clk_divider_read(&divider->reg, &val);
+	if (ret)
+		return ret;
+
+	val &= ~(clk_div_mask(divider->width) << divider->shift);
+	val |= div << divider->shift;
+	return imx_clk_divider_write(&divider->reg, val);
+}
+
+const struct clk_ops imx_clk_divider_ops = {
+	.recalc_rate = imx_clk_divider_recalc_rate,
+	.round_rate = imx_clk_divider_round_rate,
+	.determine_rate = imx_clk_divider_determine_rate,
+	.set_rate = imx_clk_divider_set_rate,
+};
+
+static void imx_clk_hw_unregister_divider(struct clk_hw *hw)
+{
+	struct clk_imx_divider *divider = to_clk_imx_divider(hw);
+
+	clk_hw_unregister(hw);
+	kfree(divider);
+}
+
+static struct clk_hw *imx_clk_hw_register_divider(struct device_node *node,
+						  const char *name,
+						  unsigned long flags,
+						  struct imx_clk_reg *reg,
+						  u8 shift, u8 width)
+{
+	struct clk_parent_data pdata = { .index = 0 };
+	struct clk_init_data init = { NULL };
+	struct clk_imx_divider *divider;
+	struct clk_hw *hw;
+	int ret;
+
+	divider = kzalloc(sizeof(*divider), GFP_KERNEL);
+	if (!divider)
+		return ERR_PTR(-ENOMEM);
+
+	init.name = name;
+	init.flags = flags;
+	init.ops = &imx_clk_divider_ops;
+	init.parent_data = &pdata;
+	init.num_parents = 1;
+
+	memcpy(&divider->reg, reg, sizeof(*reg));
+	divider->shift = shift;
+	divider->width = width;
+	divider->hw.init = &init;
+
+	hw = &divider->hw;
+	ret = of_clk_hw_register(node, hw);
+	if (ret) {
+		kfree(divider);
+		return ERR_PTR(ret);
+	}
+
+	return hw;
+}
+
+/**
+ * of_imx_divider_clk_setup() - Setup function for imx gate clock
+ * @node:	device node for the clock
+ */
+static void __init of_imx_divider_clk_setup(struct device_node *node)
+{
+	struct clk_hw *hw;
+	struct imx_clk_reg reg = {};
+	const char *name = node->name;
+	u8 shift = 0;
+	u8 width;
+	u32 flags = 0;
+	u32 val;
+
+	reg.regmap = syscon_regmap_lookup_by_phandle(node, "fsl,anatop");
+	if (!IS_ERR(reg.regmap)) {
+		if (of_property_read_u32_index(node, "fsl,anatop", 1, &val)) {
+			pr_err("missing register offset for %pOFn\n", node);
+			return;
+		}
+
+		reg.offset = val;
+	} else {
+		reg.base = of_iomap(node, 0);
+		if (IS_ERR(reg.base)) {
+			pr_err("failed to get register address for %pOFn\n",
+			       node);
+			return;
+		}
+	}
+
+	if (!of_property_read_u32(node, "fsl,bit-shift", &val))
+		shift = val;
+
+	if (of_property_read_u32(node, "fsl,width", &val)) {
+		pr_err("missing width for %pOFn\n", node);
+		return;
+
+	}
+
+	width = val;
+
+	if (of_property_read_bool(node, "fsl,ops-parent-enable"))
+		flags |= CLK_OPS_PARENT_ENABLE;
+
+	if (of_property_read_bool(node, "fsl,set-rate-parent"))
+		flags |= CLK_SET_RATE_PARENT;
+
+	if (of_clk_get_parent_count(node) != 1) {
+		pr_err("%pOFn must have 1 parent clock\n", node);
+		return;
+	}
+
+	of_property_read_string(node, "clock-output-names", &name);
+
+	hw = imx_clk_hw_register_divider(node, name, flags, &reg, shift, width);
+	if (IS_ERR(hw))
+		return;
+
+	if (of_clk_add_hw_provider(node, of_clk_hw_simple_get, hw)) {
+		imx_clk_hw_unregister_divider(hw);
+		return;
+	}
+
+	pr_debug("name: %s, offset: 0x%x, shift: %d, width: %d\n", name,
+		 reg.offset, shift, width);
+}
+CLK_OF_DECLARE(fsl_imx8mn_divider_clk, "fsl,imx8mn-divider-clock",
+	       of_imx_divider_clk_setup);
-- 
2.32.0

