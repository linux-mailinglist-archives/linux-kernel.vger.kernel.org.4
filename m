Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25FF965A396
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Dec 2022 11:48:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235568AbiLaKs2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 05:48:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231903AbiLaKsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 05:48:07 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C05CFDECA
        for <linux-kernel@vger.kernel.org>; Sat, 31 Dec 2022 02:48:03 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id u9so56514081ejo.0
        for <linux-kernel@vger.kernel.org>; Sat, 31 Dec 2022 02:48:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2nmJF3bEeRxJYrFQdgL7c1Fy/VFwyyC/ez/jfHGKmTk=;
        b=EIHtuJl7Px5jzWvOr0qcRutxwgf6dnRNYLj1qy6cx/ApezQRL7YwyNkTmofDy153pm
         WUyMaeEYCyXqFkvC13Jq7KilR7OTFSYZqtQCj+EEoZUdG6tHVy8Gn/pzaZUiKv9CihUW
         tEAOczd8T+FnFe18k9Ndsdg31yarDkD8InlzQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2nmJF3bEeRxJYrFQdgL7c1Fy/VFwyyC/ez/jfHGKmTk=;
        b=zJyG5pKHZa8sqca8qCFh3mhuDIKpsPtdoketo1Fyrp9TIDLUeG63mwH7wo+M14uBD2
         dA5SV9gm0k0glj9SLiIqSFBh4kXhRTRBw7CUz+ECrV22cJNNSvhLZNxl35QeXTLI9gjN
         9srudeq79JNwmi7//UbvCJEWtKHaSmc+bjdZfl6t566+4ZGjcT/Up71UOqr5qTMGz7cK
         YIDLgR2lqyhq8Y2KbXN1h89bToX31o/E9KESWfoJDLRNHU/uBfh3KxypPh6G3ErmUW0g
         qx4fJSI3fxuBpjmfPVcMwqmr/Ws86mJUlAneUAgWTCdfbek1bko88RE8hIK4nWaFIM5T
         kxPA==
X-Gm-Message-State: AFqh2krDwjIBsm5yeqAuL4UR4KqNDph5FEBNb97zb6j6gqgDGrnGJPJ9
        v6KAwFLzk4GDkjnaoBmePuVgoovNRocc0SCzZk8=
X-Google-Smtp-Source: AMrXdXt6n3gAYNVwmlTeUuEyNQjyNuRze77+SuBFtaIQ4NFBo1ogkhxz0e9wcjVJCxQcH9XfPsY5nA==
X-Received: by 2002:a17:907:8c08:b0:7c1:65d1:c4ca with SMTP id ta8-20020a1709078c0800b007c165d1c4camr10045321ejc.33.1672483682160;
        Sat, 31 Dec 2022 02:48:02 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-80-180-23-57.retail.telecomitalia.it. [80.180.23.57])
        by smtp.gmail.com with ESMTPSA id z4-20020a17090655c400b0083ffb81f01esm10765438ejp.136.2022.12.31.02.48.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Dec 2022 02:48:01 -0800 (PST)
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
Subject: [RFC PATCH 08/11] clk: imx: gate2: add device tree support
Date:   Sat, 31 Dec 2022 11:47:33 +0100
Message-Id: <20221231104736.12635-9-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20221231104736.12635-1-dario.binacchi@amarulasolutions.com>
References: <20221231104736.12635-1-dario.binacchi@amarulasolutions.com>
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

