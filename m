Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81EF865AAE4
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Jan 2023 18:58:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231686AbjAAR6S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Jan 2023 12:58:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjAAR6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jan 2023 12:58:02 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4EAF2DDC
        for <linux-kernel@vger.kernel.org>; Sun,  1 Jan 2023 09:57:58 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id jo4so62253194ejb.7
        for <linux-kernel@vger.kernel.org>; Sun, 01 Jan 2023 09:57:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S9smT0T74p/RoQNiIeBlvZXMl6kYsCsXSfs8qRvMbs0=;
        b=OYKuiBkOOwjN29tPh1/cWMs8cLG1wN2gp0u2wLLC0QTtDK5gbTk2HFLUf7vAZNygrn
         MzNeRUIkv5H3GMEoY2GSnne2ri+CNzGqq+W7e2d+T/6j+hrxmefHXrVCtdQIDCzgMN9l
         iwrDTX42EVaqJ+VwQgXF6NcoaEHCF78TMprDI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S9smT0T74p/RoQNiIeBlvZXMl6kYsCsXSfs8qRvMbs0=;
        b=T7vBEA4oUT9IB3xmQp07R36/ff44PWIdZ9xXv6801IqoMAlW7+h1FVR9EcwdvINO3h
         NdDOoud60KZI35lIVquJsiX8kwtkIXfXOWoOlt5DaINGwirpgau7K+or2dhMW0ppLj06
         lyhlLer6ggthXM4KKEL3gxY+tNvEjUg/8dGBW1k8oEG0vCApBsM9RpK34GtCXkX8t8aM
         U4MIKlILDeyZzos1S1ClcaIiQJxExIIS/prAF61Q/OEfiRCkpJwlhAniTwoxZmcXRx5H
         fkZ9cGA8PgDMvNdr0sXwRATnkU46EOZUtEkyb9i1jRrV/SvkiPO57d/pnUGkYQXxnHw/
         TSqA==
X-Gm-Message-State: AFqh2kok8vFSFk3cbFiF+/Gf+d9TzlR8D0JsUxOO0n+x5JpvTPUjgmZo
        DRB7mvco8tesVtsTETOMdckVE7C+KTXbT62Llps=
X-Google-Smtp-Source: AMrXdXuHoqCnHo3KBHalc3f6+5m+hbvP47YUUOAyw97jYPbQA9FCYU2t2y8nZ1vFHoHMESB8PSzqXg==
X-Received: by 2002:a17:906:910:b0:7c0:f71b:8b3 with SMTP id i16-20020a170906091000b007c0f71b08b3mr32097158ejd.57.1672595876863;
        Sun, 01 Jan 2023 09:57:56 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-80-180-23-57.retail.telecomitalia.it. [80.180.23.57])
        by smtp.gmail.com with ESMTPSA id q2-20020a1709063d4200b0082ddfb47d06sm12273018ejf.148.2023.01.01.09.57.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Jan 2023 09:57:56 -0800 (PST)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     angelo@amarulasolutions.com, michael@amarulasolutions.com,
        tommaso.merciai@amarulasolutions.com,
        Chen-Yu Tsai <wenst@chromium.org>,
        linux-amarula@amarulasolutions.com, anthony@amarulasolutions.com,
        jagan@amarulasolutions.com,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        kernel test robot <lkp@intel.com>,
        Abel Vesa <abelvesa@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
Subject: [RFC PATCH v2 07/11] clk: imx: composite-8m: add device tree support
Date:   Sun,  1 Jan 2023 18:57:36 +0100
Message-Id: <20230101175740.1010258-8-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20230101175740.1010258-1-dario.binacchi@amarulasolutions.com>
References: <20230101175740.1010258-1-dario.binacchi@amarulasolutions.com>
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

The patch, backwards compatible, extends the driver to initialize the
clock directly from the device tree.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Reported-by: kernel test robot <lkp@intel.com>

---

Changes in v2:
- Fix compiler warnings reported by kernel test robot.

 drivers/clk/imx/clk-composite-8m.c | 84 ++++++++++++++++++++++++++++++
 1 file changed, 84 insertions(+)

diff --git a/drivers/clk/imx/clk-composite-8m.c b/drivers/clk/imx/clk-composite-8m.c
index cbf0d7955a00..fa5fdfff0b2d 100644
--- a/drivers/clk/imx/clk-composite-8m.c
+++ b/drivers/clk/imx/clk-composite-8m.c
@@ -7,6 +7,8 @@
 #include <linux/errno.h>
 #include <linux/export.h>
 #include <linux/io.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
 #include <linux/slab.h>
 
 #include "clk.h"
@@ -25,6 +27,9 @@
 
 #define PCG_CGC_SHIFT		28
 
+#undef pr_fmt
+#define pr_fmt(fmt) "%s: " fmt, __func__
+
 static unsigned long imx8m_clk_composite_divider_recalc_rate(struct clk_hw *hw,
 						unsigned long parent_rate)
 {
@@ -250,3 +255,82 @@ struct clk_hw *__imx8m_clk_hw_composite(const char *name,
 	return ERR_CAST(hw);
 }
 EXPORT_SYMBOL_GPL(__imx8m_clk_hw_composite);
+
+static void __init _of_imx_composite_clk_setup(struct device_node *node,
+					       u32 type)
+{
+	void __iomem *reg;
+	struct clk_hw *hw;
+	const char *name = node->name;
+	unsigned int num_parents;
+	const char **parent_names;
+	unsigned long flags = IMX_COMPOSITE_CLK_FLAGS_DEFAULT;
+
+	reg = of_iomap(node, 0);
+	if (IS_ERR(reg)) {
+		pr_err("failed to get reg address for %pOFn\n", node);
+		return;
+	}
+
+	num_parents = of_clk_get_parent_count(node);
+	if (num_parents < 2) {
+		pr_err("%pOFn must have parents\n", node);
+		return;
+	}
+
+	parent_names = kzalloc((sizeof(char *) * num_parents), GFP_KERNEL);
+	if (!parent_names)
+		return;
+
+	of_clk_parent_fill(node, parent_names, num_parents);
+	of_property_read_string(node, "clock-output-names", &name);
+
+	if (of_property_read_bool(node, "fsl,get-rate-nocache"))
+		flags |= CLK_GET_RATE_NOCACHE;
+
+	if (of_property_read_bool(node, "fsl,is-critical"))
+		flags |= CLK_IS_CRITICAL;
+
+	hw = __imx8m_clk_hw_composite(name, parent_names, num_parents, reg,
+				      type, flags);
+	if (!IS_ERR(hw))
+		of_clk_add_hw_provider(node, of_clk_hw_simple_get, hw);
+
+	kfree(parent_names);
+}
+
+/**
+ * of_imx_composite_clk_setup() - Setup function for imx composite  clock
+ * @node:	device node for the clock
+ */
+static void __init of_imx_composite_clk_setup(struct device_node *node)
+{
+	_of_imx_composite_clk_setup(node, IMX_COMPOSITE_CORE);
+}
+CLK_OF_DECLARE(fsl_composite_8m_clk, "fsl,imx8m-composite-clock",
+	       of_imx_composite_clk_setup);
+
+/**
+ * of_imx_composite_bus_clk_setup() - Setup function for imx composite  clock
+ * @node:	device node for the clock
+ */
+static void __init of_imx_composite_bus_clk_setup(struct device_node *node)
+{
+	_of_imx_composite_clk_setup(node, IMX_COMPOSITE_BUS);
+}
+CLK_OF_DECLARE(fsl_composite_bus_8m_clk, "fsl,imx8m-composite-bus-clock",
+	       of_imx_composite_bus_clk_setup);
+
+/**
+ * of_imx_composite_fw_managed_clk_setup() - Setup function for imx
+ *		composite fw managed clock
+ * @node:	device node for the clock
+ */
+static void __init
+of_imx_composite_fw_managed_clk_setup(struct device_node *node)
+{
+	_of_imx_composite_clk_setup(node, IMX_COMPOSITE_FW_MANAGED);
+}
+CLK_OF_DECLARE(fsl_composite_fw_managed_8m_clk,
+	       "fsl,imx8m-composite-fw-managed-clock",
+	       of_imx_composite_fw_managed_clk_setup);
-- 
2.32.0

