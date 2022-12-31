Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED00065A399
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Dec 2022 11:49:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235631AbiLaKtB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 05:49:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231922AbiLaKsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 05:48:09 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 557F1DFCA
        for <linux-kernel@vger.kernel.org>; Sat, 31 Dec 2022 02:48:06 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id t17so56349660eju.1
        for <linux-kernel@vger.kernel.org>; Sat, 31 Dec 2022 02:48:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UYCjumJKIVpNgaprHBc6yiaBNx3uDiRwwnz6NjNAOKQ=;
        b=d5Oo3F4xNBaZibu3GdHQEpk4dkNY4Pe366qqIdofJdaLCS+j6pM2KVNUMIuD5drl9r
         K8X2cHKHQQ+AiqT3GelAdpGQuM+r19m0Sjwswemw88PZ1BvN/N5IqaS2xTE9ynUfvZXZ
         c2joIXIGAeXGqiD24N+PjjWBoTshwF/8Q85Q8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UYCjumJKIVpNgaprHBc6yiaBNx3uDiRwwnz6NjNAOKQ=;
        b=y/LvylplgyHzjdFlnHcvXtgtepqXfUHqtMEdQDVCiq75Phr9LtpM3pwSJwW3VgP4os
         yfRgg3ZhJm5ta2SfLOh0HXlcQD8MRk2ptF3YVWtY80y58MOy+LLcwAcBGKfCyWRD1pGR
         Lv6QNiY3c32YgWjwj6Gt3FcGZMNP1eHohVAMvo+bN3SZjMKTLfF+I8DRuCKWKs/Tqxpi
         909OCrYbp4l2eGQCC6wO5Qjhqrhp7cYN/+B9nEd0Sgga5NbpfrYf95W88yzhnHxUJjtu
         GrpUrhchbC5tjOICSG3KuvoWr3Orux38zIINdk8E0o1gyvhfLog4jH6JxFTuHi4fQe79
         I0aw==
X-Gm-Message-State: AFqh2koWpNbJOcBbAHMOPFkkQc5Kx6D2MSn6QRQ9gVb7SymTJIs9mzHk
        gVr+KHplgn/dliL3l1n1kVB88JcPMN5zoxYA4+A=
X-Google-Smtp-Source: AMrXdXtFkf58R6L2JoTSx+H966u4VmYCHQHiNSic8sWnTUPLX+LR1HTP5V2dYJh1wIFNGVun0uh00g==
X-Received: by 2002:a17:907:6f19:b0:818:3ef8:f2fc with SMTP id sy25-20020a1709076f1900b008183ef8f2fcmr28135996ejc.5.1672483684723;
        Sat, 31 Dec 2022 02:48:04 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-80-180-23-57.retail.telecomitalia.it. [80.180.23.57])
        by smtp.gmail.com with ESMTPSA id z4-20020a17090655c400b0083ffb81f01esm10765438ejp.136.2022.12.31.02.48.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Dec 2022 02:48:04 -0800 (PST)
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
Subject: [RFC PATCH 09/11] clk: imx: cpu: add device tree support
Date:   Sat, 31 Dec 2022 11:47:34 +0100
Message-Id: <20221231104736.12635-10-dario.binacchi@amarulasolutions.com>
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

 drivers/clk/imx/clk-cpu.c | 54 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/drivers/clk/imx/clk-cpu.c b/drivers/clk/imx/clk-cpu.c
index cb6ca4cf0535..28fb75c6ecea 100644
--- a/drivers/clk/imx/clk-cpu.c
+++ b/drivers/clk/imx/clk-cpu.c
@@ -106,3 +106,57 @@ struct clk_hw *imx_clk_hw_cpu(const char *name, const char *parent_name,
 	return hw;
 }
 EXPORT_SYMBOL_GPL(imx_clk_hw_cpu);
+
+/**
+ * of_imx_cpu_clk_setup - Setup function for imx low power gate
+ *                            clock
+ * @node:	device node for the clock
+ */
+static void __init of_imx_cpu_clk_setup(struct device_node *node)
+{
+	struct clk_hw *hw;
+	struct clk *parent_clk, *div, *mux, *pll, *step;
+	const char *name = node->name, *parent_name;
+
+	parent_clk = of_clk_get_by_name(node, "fck");
+	if (IS_ERR(parent_clk)) {
+		pr_err("failed to get parent clock for %pOFn\n", node);
+		return;
+	}
+
+	div = of_clk_get_by_name(node, "div-clk");
+	if (IS_ERR(div)) {
+		pr_err("failed to get div clock for %pOFn\n", node);
+		return;
+	}
+
+	mux = of_clk_get_by_name(node, "mux-clk");
+	if (IS_ERR(div)) {
+		pr_err("failed to get mux clock for %pOFn\n", node);
+		return;
+	}
+
+	pll = of_clk_get_by_name(node, "pll-clk");
+	if (IS_ERR(div)) {
+		pr_err("failed to get pll clock for %pOFn\n", node);
+		return;
+	}
+
+	step = of_clk_get_by_name(node, "step-clk");
+	if (IS_ERR(div)) {
+		pr_err("failed to get step clock for %pOFn\n", node);
+		return;
+	}
+
+	parent_name = __clk_get_name(parent_clk);
+	of_property_read_string(node, "clock-output-names", &name);
+
+	hw = imx_clk_hw_cpu(name, parent_name, div, mux, pll, step);
+	if (!IS_ERR(hw))
+		of_clk_add_hw_provider(node, of_clk_hw_simple_get, hw);
+
+	pr_debug("name: %s, parent: %s, div: %s, mux: %s, pll: %s, step: %s\n",
+		 name, parent_name, __clk_get_name(div), __clk_get_name(mux),
+		 __clk_get_name(pll), __clk_get_name(step));
+}
+CLK_OF_DECLARE(fsl_cpu_clk, "fsl,cpu-clock", of_imx_cpu_clk_setup);
-- 
2.32.0

