Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D914F6DE2F7
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 19:45:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbjDKRpp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 13:45:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbjDKRp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 13:45:27 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DB3A6A7F;
        Tue, 11 Apr 2023 10:45:17 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id kh6so7013145plb.0;
        Tue, 11 Apr 2023 10:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681235116;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L4LZi4v8BP7uhMO1g5FIUEMzxer6nFR6wrcwU4BODNA=;
        b=Ouz4+jWxRuvDTrfEF1svWhRHh80kOnQ4u0D3IgEOC4bjIqV4MzM0d96SHrYLXCC7Bm
         F1tI4hkFM5eU3OJj/+MsPqyq+aTKwz6DbB0KxIzRUylzATrjVJio/dEHys82p+wVxf6V
         VLdBrtV5aZpWJUoXVrp0xVEo6/Z7ng7/zsIOwHhpDlI639yLIl/Q+DPXaTxEnsWgvSyZ
         kMQckIom+zU379ndpxaWtxOwy7osNfAcitM5Gs1PtSPP9wqc4/xU0GhpM2WBkavNPDPc
         oYn35BNGnmjvnc0EZlzELBsks5liGLDtJwynB+KDNfSy0Ig/fi4BMPIMGVyPStDoMxqP
         dE3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681235116;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L4LZi4v8BP7uhMO1g5FIUEMzxer6nFR6wrcwU4BODNA=;
        b=fS1vlMhBrpnqFg7Gt5R1cU5FtDwZZK+wBODv8ggfqP9Ps14dFXpNtN96lHivFTcRZP
         KcFewxoZoL7KaWM8s+uLAiZnyOE4698kO+dN5o+57EKiIMKLr+FaZsdy2ch/0hixBkMJ
         CX++d1DG0RNX8FWxBahlONK/VRidxVv8T5vWn7m7NXZRVc9JOMzPl+U2q3phi6IiOF13
         iTfnihSdEyupgHSxaMy9hhYDF+6Lha9voCrPdf8CgTUQMJNOIKZK8fxVHQXkpSK0bTVq
         bxXHaSPPyHgl/F2yXGGgidHxPD3uaWggYsfXoNHN4JvB596vl61nvBKh/AvzFMCnm0Su
         8uvA==
X-Gm-Message-State: AAQBX9cpjVLZEpeY3SLbSm+CqZsr9z82yhFLmzY9ehTVndZNwiAVTS3p
        eFq3u8VQAsewjiifAIY66OrPLE4OZpzhbwWV3PU=
X-Google-Smtp-Source: AKy350aMFqCyWXHosZ4fTM4QIBMUPOVY61hzj4vRLNsx5ZQ98SvPDN0eEH+Sbl9YEL9EGW2v/SJN/Q==
X-Received: by 2002:a17:90b:4ac6:b0:23e:f855:79ed with SMTP id mh6-20020a17090b4ac600b0023ef85579edmr5055638pjb.28.1681235116613;
        Tue, 11 Apr 2023 10:45:16 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([104.28.213.202])
        by smtp.gmail.com with ESMTPSA id w23-20020a1709027b9700b001a655738a42sm1900805pll.172.2023.04.11.10.45.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 10:45:16 -0700 (PDT)
From:   David Yang <mmyangfl@gmail.com>
To:     linux-clk@vger.kernel.org
Cc:     David Yang <mmyangfl@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v4 07/13] clk: hisilicon: hi3660: Convert into module
Date:   Wed, 12 Apr 2023 01:43:16 +0800
Message-Id: <20230411174329.424763-8-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230411174329.424763-1-mmyangfl@gmail.com>
References: <20230411174329.424763-1-mmyangfl@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use common helper functions and register clks with a single of_device_id
data.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/clk/hisilicon/clk-hi3660.c | 192 ++++++++---------------------
 1 file changed, 53 insertions(+), 139 deletions(-)

diff --git a/drivers/clk/hisilicon/clk-hi3660.c b/drivers/clk/hisilicon/clk-hi3660.c
index 41f61726ab19..ce911b35bf68 100644
--- a/drivers/clk/hisilicon/clk-hi3660.c
+++ b/drivers/clk/hisilicon/clk-hi3660.c
@@ -5,9 +5,13 @@
  */
 
 #include <dt-bindings/clock/hi3660-clock.h>
+
 #include <linux/clk-provider.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
+
 #include "clk.h"
 
 static const struct hisi_fixed_rate_clock hi3660_fixed_rate_clks[] = {
@@ -469,169 +473,79 @@ static const struct hisi_gate_clock hi3660_iomcu_gate_sep_clks[] = {
 	  CLK_SET_RATE_PARENT, 0x90, 0, 0, },
 };
 
-static struct hisi_clock_data *clk_crgctrl_data;
-
-static void hi3660_clk_iomcu_init(struct device_node *np)
-{
-	struct hisi_clock_data *clk_data;
-	int nr = ARRAY_SIZE(hi3660_iomcu_gate_sep_clks);
-
-	clk_data = hisi_clk_init(np, nr);
-	if (!clk_data)
-		return;
-
-	hisi_clk_register_gate_sep(hi3660_iomcu_gate_sep_clks,
-				   ARRAY_SIZE(hi3660_iomcu_gate_sep_clks),
-				   clk_data);
-}
-
-static void hi3660_clk_pmuctrl_init(struct device_node *np)
-{
-	struct hisi_clock_data *clk_data;
-	int nr = ARRAY_SIZE(hi3660_pmu_gate_clks);
-
-	clk_data = hisi_clk_init(np, nr);
-	if (!clk_data)
-		return;
-
-	hisi_clk_register_gate(hi3660_pmu_gate_clks,
-			       ARRAY_SIZE(hi3660_pmu_gate_clks), clk_data);
-}
+static const struct hisi_clocks hi3660_clk_iomcu_clks = {
+	.gate_sep_clks = hi3660_iomcu_gate_sep_clks,
+	.gate_sep_clks_num = ARRAY_SIZE(hi3660_iomcu_gate_sep_clks),
+};
 
-static void hi3660_clk_pctrl_init(struct device_node *np)
-{
-	struct hisi_clock_data *clk_data;
-	int nr = ARRAY_SIZE(hi3660_pctrl_gate_clks);
+static const struct hisi_clocks hi3660_clk_pmuctrl_clks = {
+	.gate_clks = hi3660_pmu_gate_clks,
+	.gate_clks_num = ARRAY_SIZE(hi3660_pmu_gate_clks),
+};
 
-	clk_data = hisi_clk_init(np, nr);
-	if (!clk_data)
-		return;
-	hisi_clk_register_gate(hi3660_pctrl_gate_clks,
-			       ARRAY_SIZE(hi3660_pctrl_gate_clks), clk_data);
-}
+static const struct hisi_clocks hi3660_clk_pctrl_clks = {
+	.gate_clks = hi3660_pctrl_gate_clks,
+	.gate_clks_num = ARRAY_SIZE(hi3660_pctrl_gate_clks),
+};
 
-static void hi3660_clk_sctrl_init(struct device_node *np)
-{
-	struct hisi_clock_data *clk_data;
-	int nr = ARRAY_SIZE(hi3660_sctrl_gate_clks) +
-		 ARRAY_SIZE(hi3660_sctrl_gate_sep_clks) +
-		 ARRAY_SIZE(hi3660_sctrl_mux_clks) +
-		 ARRAY_SIZE(hi3660_sctrl_divider_clks);
+static const struct hisi_clocks hi3660_clk_sctrl_clks = {
+	.mux_clks = hi3660_sctrl_mux_clks,
+	.mux_clks_num = ARRAY_SIZE(hi3660_sctrl_mux_clks),
+	.divider_clks = hi3660_sctrl_divider_clks,
+	.divider_clks_num = ARRAY_SIZE(hi3660_sctrl_divider_clks),
+	.gate_clks = hi3660_sctrl_gate_clks,
+	.gate_clks_num = ARRAY_SIZE(hi3660_sctrl_gate_clks),
+	.gate_sep_clks = hi3660_sctrl_gate_sep_clks,
+	.gate_sep_clks_num = ARRAY_SIZE(hi3660_sctrl_gate_sep_clks),
+};
 
-	clk_data = hisi_clk_init(np, nr);
-	if (!clk_data)
-		return;
-	hisi_clk_register_gate(hi3660_sctrl_gate_clks,
-			       ARRAY_SIZE(hi3660_sctrl_gate_clks), clk_data);
-	hisi_clk_register_gate_sep(hi3660_sctrl_gate_sep_clks,
-				   ARRAY_SIZE(hi3660_sctrl_gate_sep_clks),
-				   clk_data);
-	hisi_clk_register_mux(hi3660_sctrl_mux_clks,
-			      ARRAY_SIZE(hi3660_sctrl_mux_clks), clk_data);
-	hisi_clk_register_divider(hi3660_sctrl_divider_clks,
-				  ARRAY_SIZE(hi3660_sctrl_divider_clks),
-				  clk_data);
-}
+static const struct hisi_clocks hi3660_clk_crgctrl_clks = {
+	.fixed_rate_clks = hi3660_fixed_rate_clks,
+	.fixed_rate_clks_num = ARRAY_SIZE(hi3660_fixed_rate_clks),
+	.fixed_factor_clks = hi3660_crg_fixed_factor_clks,
+	.fixed_factor_clks_num = ARRAY_SIZE(hi3660_crg_fixed_factor_clks),
+	.mux_clks = hi3660_crgctrl_mux_clks,
+	.mux_clks_num = ARRAY_SIZE(hi3660_crgctrl_mux_clks),
+	.divider_clks = hi3660_crgctrl_divider_clks,
+	.divider_clks_num = ARRAY_SIZE(hi3660_crgctrl_divider_clks),
+	.gate_clks = hi3660_crgctrl_gate_clks,
+	.gate_clks_num = ARRAY_SIZE(hi3660_crgctrl_gate_clks),
+	.gate_sep_clks = hi3660_crgctrl_gate_sep_clks,
+	.gate_sep_clks_num = ARRAY_SIZE(hi3660_crgctrl_gate_sep_clks),
+};
 
 static void hi3660_clk_crgctrl_early_init(struct device_node *np)
 {
-	int nr = ARRAY_SIZE(hi3660_fixed_rate_clks) +
-		 ARRAY_SIZE(hi3660_crgctrl_gate_sep_clks) +
-		 ARRAY_SIZE(hi3660_crgctrl_gate_clks) +
-		 ARRAY_SIZE(hi3660_crgctrl_mux_clks) +
-		 ARRAY_SIZE(hi3660_crg_fixed_factor_clks) +
-		 ARRAY_SIZE(hi3660_crgctrl_divider_clks);
-	int i;
-
-	clk_crgctrl_data = hisi_clk_init(np, nr);
-	if (!clk_crgctrl_data)
-		return;
-
-	for (i = 0; i < nr; i++)
-		clk_crgctrl_data->clk_data.clks[i] = ERR_PTR(-EPROBE_DEFER);
-
-	hisi_clk_register_fixed_rate(hi3660_fixed_rate_clks,
-				     ARRAY_SIZE(hi3660_fixed_rate_clks),
-				     clk_crgctrl_data);
+	hisi_clk_early_init(np, &hi3660_clk_crgctrl_clks);
 }
 CLK_OF_DECLARE_DRIVER(hi3660_clk_crgctrl, "hisilicon,hi3660-crgctrl",
 		      hi3660_clk_crgctrl_early_init);
 
-static void hi3660_clk_crgctrl_init(struct device_node *np)
-{
-	struct clk **clks;
-	int i;
-
-	if (!clk_crgctrl_data)
-		hi3660_clk_crgctrl_early_init(np);
-
-	/* clk_crgctrl_data initialization failed */
-	if (!clk_crgctrl_data)
-		return;
-
-	hisi_clk_register_gate_sep(hi3660_crgctrl_gate_sep_clks,
-				   ARRAY_SIZE(hi3660_crgctrl_gate_sep_clks),
-				   clk_crgctrl_data);
-	hisi_clk_register_gate(hi3660_crgctrl_gate_clks,
-			       ARRAY_SIZE(hi3660_crgctrl_gate_clks),
-			       clk_crgctrl_data);
-	hisi_clk_register_mux(hi3660_crgctrl_mux_clks,
-			      ARRAY_SIZE(hi3660_crgctrl_mux_clks),
-			      clk_crgctrl_data);
-	hisi_clk_register_fixed_factor(hi3660_crg_fixed_factor_clks,
-				       ARRAY_SIZE(hi3660_crg_fixed_factor_clks),
-				       clk_crgctrl_data);
-	hisi_clk_register_divider(hi3660_crgctrl_divider_clks,
-				  ARRAY_SIZE(hi3660_crgctrl_divider_clks),
-				  clk_crgctrl_data);
-
-	clks = clk_crgctrl_data->clk_data.clks;
-	for (i = 0; i < clk_crgctrl_data->clk_data.clk_num; i++) {
-		if (IS_ERR(clks[i]) && PTR_ERR(clks[i]) != -EPROBE_DEFER)
-			pr_err("Failed to register crgctrl clock[%d] err=%ld\n",
-			       i, PTR_ERR(clks[i]));
-	}
-}
-
 static const struct of_device_id hi3660_clk_match_table[] = {
 	{ .compatible = "hisilicon,hi3660-crgctrl",
-	  .data = hi3660_clk_crgctrl_init },
+	  .data = &hi3660_clk_crgctrl_clks },
 	{ .compatible = "hisilicon,hi3660-pctrl",
-	  .data = hi3660_clk_pctrl_init },
+	  .data = &hi3660_clk_pctrl_clks },
 	{ .compatible = "hisilicon,hi3660-pmuctrl",
-	  .data = hi3660_clk_pmuctrl_init },
+	  .data = &hi3660_clk_pmuctrl_clks },
 	{ .compatible = "hisilicon,hi3660-sctrl",
-	  .data = hi3660_clk_sctrl_init },
+	  .data = &hi3660_clk_sctrl_clks },
 	{ .compatible = "hisilicon,hi3660-iomcu",
-	  .data = hi3660_clk_iomcu_init },
+	  .data = &hi3660_clk_iomcu_clks },
 	{ }
 };
-
-static int hi3660_clk_probe(struct platform_device *pdev)
-{
-	struct device *dev = &pdev->dev;
-	struct device_node *np = pdev->dev.of_node;
-	void (*init_func)(struct device_node *np);
-
-	init_func = of_device_get_match_data(dev);
-	if (!init_func)
-		return -ENODEV;
-
-	init_func(np);
-
-	return 0;
-}
+MODULE_DEVICE_TABLE(of, hi3660_clk_match_table);
 
 static struct platform_driver hi3660_clk_driver = {
-	.probe          = hi3660_clk_probe,
+	.probe = hisi_clk_probe,
+	.remove = hisi_clk_remove,
 	.driver         = {
 		.name   = "hi3660-clk",
 		.of_match_table = hi3660_clk_match_table,
 	},
 };
 
-static int __init hi3660_clk_init(void)
-{
-	return platform_driver_register(&hi3660_clk_driver);
-}
-core_initcall(hi3660_clk_init);
+module_platform_driver(hi3660_clk_driver);
+
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("HiSilicon Hi3660 Clock Driver");
-- 
2.39.2

