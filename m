Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AD9665AAE5
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Jan 2023 18:58:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231712AbjAAR6W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Jan 2023 12:58:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231582AbjAAR6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jan 2023 12:58:03 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C06262DEC
        for <linux-kernel@vger.kernel.org>; Sun,  1 Jan 2023 09:57:59 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id kw15so62160609ejc.10
        for <linux-kernel@vger.kernel.org>; Sun, 01 Jan 2023 09:57:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MLDPwIRHLBEzFrNMDd85lbKLR9rlsRWR9lQbk5mvRTo=;
        b=JLVKvue/o9CAWRLa18rsHSmXIkadbvT+YQGR3dNfCfvq5dx4I+8c8agfGLlEr8vIEC
         76cWrvxHMef/pUeG5BaKehESuTaiyevWPgW+ZNR02UgVR0vnxBxtRNI9tCLdSTDHC3xe
         AwKqE/HGDcFshTZOEsELJXcsrJi5HElEv4+t4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MLDPwIRHLBEzFrNMDd85lbKLR9rlsRWR9lQbk5mvRTo=;
        b=IKLR9h8HrNwPnuFDsy5stzwFinjl8v2Am2U+6xRcqkgySWWohXKK7z/fFzzuSbSih3
         mgj8O6IGTJ1ijf4qFxXiTJayK+rGgCd/+u9uZJfJnHnPzjN9AXo7zUVJku8qo7agOFrK
         qYcTFXydqUGtXl9iK+PbsaHvdHOsS2W1MvNmKKb8ZJAMgs3C3G0aITFk5FSQKLFu1KXg
         XGfSytunxrrY9+qbNzjurqEX0mEGlGcWIrfM4al7hWHGaE1SVYLHET6+94Q4gmnRuYFy
         gjwr10kZyNOaj0predQHzHdet5U5NUY/a4bXz/Viuj5WluNqpsZkd4MCfwdakGnbRwsg
         Onrg==
X-Gm-Message-State: AFqh2kpDc+TxMmvOAm/Jy8fAFCN1AVhiMP7Y8P7BwC83/4e8GbAeOgNy
        6AtIwhTTSQCtduzAwyN/dwl4Az1uVKs2uUvHbfY=
X-Google-Smtp-Source: AMrXdXue59OOyc4Qus3KY0gCjjRGY6RHTdubhxNnBOUVsir2bJHxWwxXxVuRbK3jjaem8N4N6NyKHA==
X-Received: by 2002:a17:906:f854:b0:849:7688:3e3e with SMTP id ks20-20020a170906f85400b0084976883e3emr24437974ejb.44.1672595878202;
        Sun, 01 Jan 2023 09:57:58 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-80-180-23-57.retail.telecomitalia.it. [80.180.23.57])
        by smtp.gmail.com with ESMTPSA id q2-20020a1709063d4200b0082ddfb47d06sm12273018ejf.148.2023.01.01.09.57.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Jan 2023 09:57:57 -0800 (PST)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     angelo@amarulasolutions.com, michael@amarulasolutions.com,
        tommaso.merciai@amarulasolutions.com,
        Chen-Yu Tsai <wenst@chromium.org>,
        linux-amarula@amarulasolutions.com, anthony@amarulasolutions.com,
        jagan@amarulasolutions.com,
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
Subject: [RFC PATCH v2 08/11] clk: imx: gate2: add device tree support
Date:   Sun,  1 Jan 2023 18:57:37 +0100
Message-Id: <20230101175740.1010258-9-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20230101175740.1010258-1-dario.binacchi@amarulasolutions.com>
References: <20230101175740.1010258-1-dario.binacchi@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch, backwards compatible, extends the driver to initialize the
clock directly from the device tree.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

(no changes since v1)

 drivers/clk/imx/clk-gate2.c | 86 +++++++++++++++++++++++++++++++++++++
 1 file changed, 86 insertions(+)

diff --git a/drivers/clk/imx/clk-gate2.c b/drivers/clk/imx/clk-gate2.c
index f16c4019f402..b28150bf1ff6 100644
--- a/drivers/clk/imx/clk-gate2.c
+++ b/drivers/clk/imx/clk-gate2.c
@@ -12,9 +12,26 @@
 #include <linux/slab.h>
 #include <linux/io.h>
 #include <linux/err.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
 #include <linux/string.h>
 #include "clk.h"
 
+#define CLK_GATE2_CGR_DISABLED 0
+#define CLK_GATE2_CGR_RUN 1
+#define CLK_GATE2_CGR_RUN_WAIT 2
+#define CLK_GATE2_CGR_RUN_WAIT_STOP 3
+#define CLK_GATE2_CGR_MASK 3
+
+#define CLK_GATE2_MAX_GROUPS    16
+
+struct clk_gate2_group {
+	const char *name;
+	unsigned int share_count;
+};
+
+static struct clk_gate2_group clk_gate2_groups[CLK_GATE2_MAX_GROUPS];
+
 /**
  * DOC: basic gateable clock which can gate and ungate its output
  *
@@ -175,3 +192,72 @@ struct clk_hw *clk_hw_register_gate2(struct device *dev, const char *name,
 	return hw;
 }
 EXPORT_SYMBOL_GPL(clk_hw_register_gate2);
+
+/**
+ * of_imx_gate2_clk_setup() - Setup function for imx low power gate
+ *                            clock
+ * @node:	device node for the clock
+ */
+static void __init of_imx_gate2_clk_setup(struct device_node *node)
+{
+	void __iomem *reg;
+	u8 i, bit_idx = 0;
+	u8 cgr_val = CLK_GATE2_CGR_RUN_WAIT_STOP;
+	u8 cgr_mask = CLK_GATE2_CGR_MASK;
+	unsigned long flags = CLK_OPS_PARENT_ENABLE | CLK_SET_RATE_PARENT;
+	u8 gate2_flags = 0;
+	unsigned int *share_count = NULL;
+	const char *name = node->name, *parent_name;
+	const char *str;
+	struct clk_hw *hw;
+	u32 val;
+
+	reg = of_iomap(node, 0);
+	if (IS_ERR(reg)) {
+		pr_err("failed to get reg address for %pOFn\n", node);
+		return;
+	}
+
+	if (!of_property_read_u32(node, "fsl,bit-shift", &val))
+		bit_idx = val;
+
+	if (of_clk_get_parent_count(node) != 1) {
+		pr_err("%pOFn must have 1 parent clock\n", node);
+		return;
+	}
+
+	if (!of_property_read_string(node, "sharing-group", &str)) {
+		for (i = 0; clk_gate2_groups[i].name &&
+			     i < ARRAY_SIZE(clk_gate2_groups); i++) {
+			if (!strcmp(clk_gate2_groups[i].name, str)) {
+				share_count = &clk_gate2_groups[i].share_count;
+				break;
+			}
+		}
+
+		if (i == ARRAY_SIZE(clk_gate2_groups)) {
+			pr_err("failed to get shared count for %pOFn\n", node);
+			return;
+		}
+
+		if (!share_count) {
+			clk_gate2_groups[i].name =
+				kstrdup_const(str, GFP_KERNEL);
+			share_count = &clk_gate2_groups[i].share_count;
+		}
+	}
+
+	parent_name = of_clk_get_parent_name(node, 0);
+	of_property_read_string(node, "clock-output-names", &name);
+
+	hw = clk_hw_register_gate2(NULL, name, parent_name, flags, reg, bit_idx,
+				   cgr_val, cgr_mask, gate2_flags,
+				   &imx_ccm_lock, share_count);
+	if (!IS_ERR(hw))
+		of_clk_add_hw_provider(node, of_clk_hw_simple_get, hw);
+
+	pr_debug("name: %s, parent: %s, enable-bit: %d, flags: 0x%lx, gate2_flags: 0x%x\n",
+		 name, parent_name, bit_idx, flags, gate2_flags);
+}
+CLK_OF_DECLARE(fsl_imx8mn_gate2_clk, "fsl,imx8mn-low-power-gate-clock",
+	       of_imx_gate2_clk_setup);
-- 
2.32.0

