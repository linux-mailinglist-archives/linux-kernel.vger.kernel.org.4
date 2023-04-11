Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 383A86DE2F9
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 19:46:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbjDKRp6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 13:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230208AbjDKRpj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 13:45:39 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C72A6A7C;
        Tue, 11 Apr 2023 10:45:31 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id 21so406938plg.12;
        Tue, 11 Apr 2023 10:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681235130;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qwqE0RY+d2Z3fW8hobJjBV2lhIcDbGGn7/wlLPI8IMA=;
        b=Ri5DgEcxcwQvNXqHc76CANxWc1chVwBV4LzLsKrIoAxWS15m1DtZ+H53Y6yBbZk3hb
         lK+7rGow/XP4YXpWO0LQ8Gyx3iQq7GLQbWT5D6mNA2xgv9QV4eilrS/uQmLKmTzXziln
         MsJBXalrVmD8DzYUVwY7H9dNOMDjaYaMK5FnqkcwfOyf7dziyFGZVhu4Hl9jqNEYj1ZS
         hFCSSUhJfEh4uonzK0OzMcztQOyWsoHUffNJzmn24SDUUG61LbwnRAHXgstq9zdAwU3l
         FJ2+7DpYou/C0I2902y0ydC/2Wj10UeC7ZE78qjOKXo8WJ1cdbOx/iqyorSpn7ZUq0ez
         A4aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681235130;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qwqE0RY+d2Z3fW8hobJjBV2lhIcDbGGn7/wlLPI8IMA=;
        b=T/ysCuzUPh7OB7RkGnwwsLMSXgA2aNtS3ccCgSATAYn3LR4ncBVPxIlOrIf9z/SF8/
         XahUW/A4HB98u3FUKEG/znjQqi9oalgeuIFPIl20GZ1LYLxzdTTNjwxuVmWFAZfw/9xC
         TRBM81Mr23RWR+O0ZAnTS+pvOJylWvBFr3h6Y3TmX9AFIDZKFEYZOrNzCJCJ7jtPk2se
         gQDVUvyQ3gzsfTLITaWERk+1iopeAkdF3ejZKefIbhloXY9FgqBunx3Lvd8mgMMxd93o
         veZpsKmrmf7ulyDzlehKf2D5bPmBRIvuB6/m9rH+/F17wU6ghsTu+PKnuZcbFgKt8Hx+
         inpA==
X-Gm-Message-State: AAQBX9eVazPnuqNQx+yEwtgq5c+e0p6oq2i9E0FyKC71C+ow5+iT/BTo
        LwaUIRFPqOf2XTKR2lkRUUvvToiRzVgnkb295iM=
X-Google-Smtp-Source: AKy350bsW40oP5piZX7GuCW03OdiT2hXMsI41djqvAkAns2RIDPV3cK8CpVa5jmuKd2GFjeQJxl8CA==
X-Received: by 2002:a17:903:4304:b0:1a0:4ebd:15d5 with SMTP id jz4-20020a170903430400b001a04ebd15d5mr14354818plb.67.1681235130318;
        Tue, 11 Apr 2023 10:45:30 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([104.28.213.202])
        by smtp.gmail.com with ESMTPSA id w23-20020a1709027b9700b001a655738a42sm1900805pll.172.2023.04.11.10.45.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 10:45:30 -0700 (PDT)
From:   David Yang <mmyangfl@gmail.com>
To:     linux-clk@vger.kernel.org
Cc:     David Yang <mmyangfl@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v4 08/13] clk: hisilicon: hi3670: Convert into module
Date:   Wed, 12 Apr 2023 01:43:17 +0800
Message-Id: <20230411174329.424763-9-mmyangfl@gmail.com>
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
 drivers/clk/hisilicon/clk-hi3670.c | 248 +++++++++--------------------
 1 file changed, 75 insertions(+), 173 deletions(-)

diff --git a/drivers/clk/hisilicon/clk-hi3670.c b/drivers/clk/hisilicon/clk-hi3670.c
index 4d05a71683a5..2677c0f16586 100644
--- a/drivers/clk/hisilicon/clk-hi3670.c
+++ b/drivers/clk/hisilicon/clk-hi3670.c
@@ -9,8 +9,11 @@
 
 #include <dt-bindings/clock/hi3670-clock.h>
 #include <linux/clk-provider.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
+
 #include "clk.h"
 
 static const struct hisi_fixed_rate_clock hi3670_fixed_rate_clks[] = {
@@ -822,195 +825,94 @@ static const struct hisi_gate_clock hi3670_media2_gate_sep_clks[] = {
 	  CLK_SET_RATE_PARENT, 0x00, 2, 0, },
 };
 
-static void hi3670_clk_crgctrl_init(struct device_node *np)
-{
-	struct hisi_clock_data *clk_data;
-
-	int nr = ARRAY_SIZE(hi3670_fixed_rate_clks) +
-		 ARRAY_SIZE(hi3670_crgctrl_gate_sep_clks) +
-		 ARRAY_SIZE(hi3670_crgctrl_gate_clks) +
-		 ARRAY_SIZE(hi3670_crgctrl_mux_clks) +
-		 ARRAY_SIZE(hi3670_crg_fixed_factor_clks) +
-		 ARRAY_SIZE(hi3670_crgctrl_divider_clks);
-
-	clk_data = hisi_clk_init(np, nr);
-	if (!clk_data)
-		return;
-
-	hisi_clk_register_fixed_rate(hi3670_fixed_rate_clks,
-				     ARRAY_SIZE(hi3670_fixed_rate_clks),
-				     clk_data);
-	hisi_clk_register_gate_sep(hi3670_crgctrl_gate_sep_clks,
-				   ARRAY_SIZE(hi3670_crgctrl_gate_sep_clks),
-				   clk_data);
-	hisi_clk_register_gate(hi3670_crgctrl_gate_clks,
-			       ARRAY_SIZE(hi3670_crgctrl_gate_clks),
-			       clk_data);
-	hisi_clk_register_mux(hi3670_crgctrl_mux_clks,
-			      ARRAY_SIZE(hi3670_crgctrl_mux_clks),
-			      clk_data);
-	hisi_clk_register_fixed_factor(hi3670_crg_fixed_factor_clks,
-				       ARRAY_SIZE(hi3670_crg_fixed_factor_clks),
-				       clk_data);
-	hisi_clk_register_divider(hi3670_crgctrl_divider_clks,
-				  ARRAY_SIZE(hi3670_crgctrl_divider_clks),
-				  clk_data);
-}
-
-static void hi3670_clk_pctrl_init(struct device_node *np)
-{
-	struct hisi_clock_data *clk_data;
-	int nr = ARRAY_SIZE(hi3670_pctrl_gate_clks);
-
-	clk_data = hisi_clk_init(np, nr);
-	if (!clk_data)
-		return;
-	hisi_clk_register_gate(hi3670_pctrl_gate_clks,
-			       ARRAY_SIZE(hi3670_pctrl_gate_clks), clk_data);
-}
-
-static void hi3670_clk_pmuctrl_init(struct device_node *np)
-{
-	struct hisi_clock_data *clk_data;
-	int nr = ARRAY_SIZE(hi3670_pmu_gate_clks);
-
-	clk_data = hisi_clk_init(np, nr);
-	if (!clk_data)
-		return;
-
-	hisi_clk_register_gate(hi3670_pmu_gate_clks,
-			       ARRAY_SIZE(hi3670_pmu_gate_clks), clk_data);
-}
-
-static void hi3670_clk_sctrl_init(struct device_node *np)
-{
-	struct hisi_clock_data *clk_data;
-	int nr = ARRAY_SIZE(hi3670_sctrl_gate_sep_clks) +
-		 ARRAY_SIZE(hi3670_sctrl_gate_clks) +
-		 ARRAY_SIZE(hi3670_sctrl_mux_clks) +
-		 ARRAY_SIZE(hi3670_sctrl_divider_clks);
-
-	clk_data = hisi_clk_init(np, nr);
-	if (!clk_data)
-		return;
-
-	hisi_clk_register_gate_sep(hi3670_sctrl_gate_sep_clks,
-				   ARRAY_SIZE(hi3670_sctrl_gate_sep_clks),
-				   clk_data);
-	hisi_clk_register_gate(hi3670_sctrl_gate_clks,
-			       ARRAY_SIZE(hi3670_sctrl_gate_clks),
-			       clk_data);
-	hisi_clk_register_mux(hi3670_sctrl_mux_clks,
-			      ARRAY_SIZE(hi3670_sctrl_mux_clks),
-			      clk_data);
-	hisi_clk_register_divider(hi3670_sctrl_divider_clks,
-				  ARRAY_SIZE(hi3670_sctrl_divider_clks),
-				  clk_data);
-}
-
-static void hi3670_clk_iomcu_init(struct device_node *np)
-{
-	struct hisi_clock_data *clk_data;
-	int nr = ARRAY_SIZE(hi3670_iomcu_gate_sep_clks) +
-			ARRAY_SIZE(hi3670_iomcu_fixed_factor_clks);
-
-	clk_data = hisi_clk_init(np, nr);
-	if (!clk_data)
-		return;
-
-	hisi_clk_register_gate(hi3670_iomcu_gate_sep_clks,
-			       ARRAY_SIZE(hi3670_iomcu_gate_sep_clks), clk_data);
-
-	hisi_clk_register_fixed_factor(hi3670_iomcu_fixed_factor_clks,
-				       ARRAY_SIZE(hi3670_iomcu_fixed_factor_clks),
-				       clk_data);
-}
-
-static void hi3670_clk_media1_init(struct device_node *np)
-{
-	struct hisi_clock_data *clk_data;
-
-	int nr = ARRAY_SIZE(hi3670_media1_gate_sep_clks) +
-		 ARRAY_SIZE(hi3670_media1_gate_clks) +
-		 ARRAY_SIZE(hi3670_media1_mux_clks) +
-		 ARRAY_SIZE(hi3670_media1_divider_clks);
-
-	clk_data = hisi_clk_init(np, nr);
-	if (!clk_data)
-		return;
-
-	hisi_clk_register_gate_sep(hi3670_media1_gate_sep_clks,
-				   ARRAY_SIZE(hi3670_media1_gate_sep_clks),
-				   clk_data);
-	hisi_clk_register_gate(hi3670_media1_gate_clks,
-			       ARRAY_SIZE(hi3670_media1_gate_clks),
-			       clk_data);
-	hisi_clk_register_mux(hi3670_media1_mux_clks,
-			      ARRAY_SIZE(hi3670_media1_mux_clks),
-			      clk_data);
-	hisi_clk_register_divider(hi3670_media1_divider_clks,
-				  ARRAY_SIZE(hi3670_media1_divider_clks),
-				  clk_data);
-}
-
-static void hi3670_clk_media2_init(struct device_node *np)
-{
-	struct hisi_clock_data *clk_data;
-
-	int nr = ARRAY_SIZE(hi3670_media2_gate_sep_clks);
-
-	clk_data = hisi_clk_init(np, nr);
-	if (!clk_data)
-		return;
-
-	hisi_clk_register_gate_sep(hi3670_media2_gate_sep_clks,
-				   ARRAY_SIZE(hi3670_media2_gate_sep_clks),
-				   clk_data);
-}
+static const struct hisi_clocks hi3670_clk_crgctrl_clks = {
+	.fixed_rate_clks = hi3670_fixed_rate_clks,
+	.fixed_rate_clks_num = ARRAY_SIZE(hi3670_fixed_rate_clks),
+	.fixed_factor_clks = hi3670_crg_fixed_factor_clks,
+	.fixed_factor_clks_num = ARRAY_SIZE(hi3670_crg_fixed_factor_clks),
+	.mux_clks = hi3670_crgctrl_mux_clks,
+	.mux_clks_num = ARRAY_SIZE(hi3670_crgctrl_mux_clks),
+	.divider_clks = hi3670_crgctrl_divider_clks,
+	.divider_clks_num = ARRAY_SIZE(hi3670_crgctrl_divider_clks),
+	.gate_clks = hi3670_crgctrl_gate_clks,
+	.gate_clks_num = ARRAY_SIZE(hi3670_crgctrl_gate_clks),
+	.gate_sep_clks = hi3670_crgctrl_gate_sep_clks,
+	.gate_sep_clks_num = ARRAY_SIZE(hi3670_crgctrl_gate_sep_clks),
+};
+
+static const struct hisi_clocks hi3670_clk_pctrl_clks = {
+	.gate_clks = hi3670_pctrl_gate_clks,
+	.gate_clks_num = ARRAY_SIZE(hi3670_pctrl_gate_clks),
+};
+
+static const struct hisi_clocks hi3670_clk_pmuctrl_clks = {
+	.gate_clks = hi3670_pmu_gate_clks,
+	.gate_clks_num = ARRAY_SIZE(hi3670_pmu_gate_clks),
+};
+
+static const struct hisi_clocks hi3670_clk_sctrl_clks = {
+	.mux_clks = hi3670_sctrl_mux_clks,
+	.mux_clks_num = ARRAY_SIZE(hi3670_sctrl_mux_clks),
+	.divider_clks = hi3670_sctrl_divider_clks,
+	.divider_clks_num = ARRAY_SIZE(hi3670_sctrl_divider_clks),
+	.gate_clks = hi3670_sctrl_gate_clks,
+	.gate_clks_num = ARRAY_SIZE(hi3670_sctrl_gate_clks),
+	.gate_sep_clks = hi3670_sctrl_gate_sep_clks,
+	.gate_sep_clks_num = ARRAY_SIZE(hi3670_sctrl_gate_sep_clks),
+};
+
+static const struct hisi_clocks hi3670_clk_iomcu_clks = {
+	.fixed_factor_clks = hi3670_iomcu_fixed_factor_clks,
+	.fixed_factor_clks_num = ARRAY_SIZE(hi3670_iomcu_fixed_factor_clks),
+	.gate_clks = hi3670_iomcu_gate_sep_clks,
+	.gate_clks_num = ARRAY_SIZE(hi3670_iomcu_gate_sep_clks),
+};
+
+static const struct hisi_clocks hi3670_clk_media1_clks = {
+	.mux_clks = hi3670_media1_mux_clks,
+	.mux_clks_num = ARRAY_SIZE(hi3670_media1_mux_clks),
+	.divider_clks = hi3670_media1_divider_clks,
+	.divider_clks_num = ARRAY_SIZE(hi3670_media1_divider_clks),
+	.gate_clks = hi3670_media1_gate_clks,
+	.gate_clks_num = ARRAY_SIZE(hi3670_media1_gate_clks),
+	.gate_sep_clks = hi3670_media1_gate_sep_clks,
+	.gate_sep_clks_num = ARRAY_SIZE(hi3670_media1_gate_sep_clks),
+};
+
+static const struct hisi_clocks hi3670_clk_media2_clks = {
+	.gate_sep_clks = hi3670_media2_gate_sep_clks,
+	.gate_sep_clks_num = ARRAY_SIZE(hi3670_media2_gate_sep_clks),
+};
 
 static const struct of_device_id hi3670_clk_match_table[] = {
 	{ .compatible = "hisilicon,hi3670-crgctrl",
-	  .data = hi3670_clk_crgctrl_init },
+	  .data = &hi3670_clk_crgctrl_clks },
 	{ .compatible = "hisilicon,hi3670-pctrl",
-	  .data = hi3670_clk_pctrl_init },
+	  .data = &hi3670_clk_pctrl_clks },
 	{ .compatible = "hisilicon,hi3670-pmuctrl",
-	  .data = hi3670_clk_pmuctrl_init },
+	  .data = &hi3670_clk_pmuctrl_clks },
 	{ .compatible = "hisilicon,hi3670-sctrl",
-	  .data = hi3670_clk_sctrl_init },
+	  .data = &hi3670_clk_sctrl_clks },
 	{ .compatible = "hisilicon,hi3670-iomcu",
-	  .data = hi3670_clk_iomcu_init },
+	  .data = &hi3670_clk_iomcu_clks },
 	{ .compatible = "hisilicon,hi3670-media1-crg",
-	  .data = hi3670_clk_media1_init },
+	  .data = &hi3670_clk_media1_clks },
 	{ .compatible = "hisilicon,hi3670-media2-crg",
-	  .data = hi3670_clk_media2_init },
+	  .data = &hi3670_clk_media2_clks },
 	{ }
 };
-
-static int hi3670_clk_probe(struct platform_device *pdev)
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
+MODULE_DEVICE_TABLE(of, hi3670_clk_match_table);
 
 static struct platform_driver hi3670_clk_driver = {
-	.probe          = hi3670_clk_probe,
+	.probe = hisi_clk_probe,
+	.remove = hisi_clk_remove,
 	.driver         = {
 		.name   = "hi3670-clk",
 		.of_match_table = hi3670_clk_match_table,
 	},
 };
 
-static int __init hi3670_clk_init(void)
-{
-	return platform_driver_register(&hi3670_clk_driver);
-}
-core_initcall(hi3670_clk_init);
+module_platform_driver(hi3670_clk_driver);
+
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("HiSilicon Hi3670 Clock Driver");
-- 
2.39.2

