Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADBB06DE305
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 19:46:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbjDKRq4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 13:46:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230238AbjDKRqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 13:46:43 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91C8672AB;
        Tue, 11 Apr 2023 10:46:26 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id pc4-20020a17090b3b8400b0024676052044so8840480pjb.1;
        Tue, 11 Apr 2023 10:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681235186;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eAEODm1kNNhfhQehFrRwXlq3FhwRoxU54wQDsxuZLBY=;
        b=R1JCt4ia3L6lHszjsCPRDiNNGQG0XIoUV0NtJTEUHiZzMMv9GxapwbhCBdxcuM/g+G
         C+4Iz/sQNO9blQN79pjZXEzYHYr4S6u370OeqRBvzXIjSkV4K21Ek6QoKt5TDIgabRmK
         WW7+Xt0fdLGwjofwnUnCcaI7y+m5hrBO3m8oq577MN9wX5DOf+15nGyQxOebz+C6Ub2y
         sJrS3VVIAPWy8kyydRgyoM3rPnqEEXJRq1c/WI98ix+wCI+eRTKtU2igPxvIVlEkqkfI
         uqedjWCfSP3qp3MPpmTaQXp8DGjUuY8V+CwOB3wfJvqAuJJfBYnSe1H1ZUeLNAWI/kaO
         Y8Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681235186;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eAEODm1kNNhfhQehFrRwXlq3FhwRoxU54wQDsxuZLBY=;
        b=xAx3iwqoYrS7JY6S92QkAitlfhkU+ZJB4U2q4Kz9MuQQWKP2LGPj5/EN2+hHCXorxt
         uERh74t4y1kE1nJF5MoDrs/ZtnwQto3rKKhlz96zO7CyPvhVhTLT2vPUSJLNaIr6Bq8e
         detya0VFe7Ed0J8FPc6u9vxthC87cLJIzJBsMc6sMpO0U/wRHmMo2otiT11Oaq8/Y/mU
         GGysrPecpnZQT3U2fF/J/JNGuFF8KsQZOoKeIAMkOzEoAXj0Rj0qfSgTQNpodMax15R2
         HI0oSwE9IbRK3QxqLVp4e5TbZvAsPzLat9d6ma9GDNpjBfdczwt6WABnEElFCNjQ/jXi
         iFLA==
X-Gm-Message-State: AAQBX9eE/1BGltRVafqvgVLklT3iRF4bhnsGbnaOdOKf6F/9uBIXckkR
        FSkFwnr7/6QDmsX7JhWFB9vcJ4lTcov7lluwmhM=
X-Google-Smtp-Source: AKy350ZkaRErlfVGaZ5nH3iIpvwJO/BQXL312gtmxtySZpUg1GvpJ6+8u/apdEjNUZI63S92JxbWVg==
X-Received: by 2002:a17:90b:4b05:b0:246:6a51:241c with SMTP id lx5-20020a17090b4b0500b002466a51241cmr17891872pjb.22.1681235185880;
        Tue, 11 Apr 2023 10:46:25 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([104.28.213.202])
        by smtp.gmail.com with ESMTPSA id w23-20020a1709027b9700b001a655738a42sm1900805pll.172.2023.04.11.10.46.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 10:46:25 -0700 (PDT)
From:   David Yang <mmyangfl@gmail.com>
To:     linux-clk@vger.kernel.org
Cc:     David Yang <mmyangfl@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v4 12/13] clk: hisilicon: hix5hd2: Convert into platform driver module
Date:   Wed, 12 Apr 2023 01:43:21 +0800
Message-Id: <20230411174329.424763-13-mmyangfl@gmail.com>
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
 drivers/clk/hisilicon/clk-hix5hd2.c | 85 ++++++++++++++++++-----------
 1 file changed, 52 insertions(+), 33 deletions(-)

diff --git a/drivers/clk/hisilicon/clk-hix5hd2.c b/drivers/clk/hisilicon/clk-hix5hd2.c
index 64bdd3f05725..fb0f5d2745b2 100644
--- a/drivers/clk/hisilicon/clk-hix5hd2.c
+++ b/drivers/clk/hisilicon/clk-hix5hd2.c
@@ -4,13 +4,17 @@
  * Copyright (c) 2014 Hisilicon Limited.
  */
 
-#include <linux/of_address.h>
 #include <dt-bindings/clock/hix5hd2-clock.h>
+
 #include <linux/slab.h>
 #include <linux/delay.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+
 #include "clk.h"
 
-static struct hisi_fixed_rate_clock hix5hd2_fixed_rate_clks[] __initdata = {
+static struct hisi_fixed_rate_clock hix5hd2_fixed_rate_clks[] = {
 	{ HIX5HD2_FIXED_1200M, "1200m", NULL, 0, 1200000000, },
 	{ HIX5HD2_FIXED_400M, "400m", NULL, 0, 400000000, },
 	{ HIX5HD2_FIXED_48M, "48m", NULL, 0, 48000000, },
@@ -43,19 +47,19 @@ static struct hisi_fixed_rate_clock hix5hd2_fixed_rate_clks[] __initdata = {
 	{ HIX5HD2_FIXED_83M, "83m", NULL, 0, 83333333, },
 };
 
-static const char *const sfc_mux_p[] __initconst = {
+static const char *const sfc_mux_p[] = {
 		"24m", "150m", "200m", "100m", "75m", };
 static u32 sfc_mux_table[] = {0, 4, 5, 6, 7};
 
-static const char *const sdio_mux_p[] __initconst = {
+static const char *const sdio_mux_p[] = {
 		"75m", "100m", "50m", "15m", };
 static u32 sdio_mux_table[] = {0, 1, 2, 3};
 
-static const char *const fephy_mux_p[] __initconst = { "25m", "125m"};
+static const char *const fephy_mux_p[] = { "25m", "125m"};
 static u32 fephy_mux_table[] = {0, 1};
 
 
-static struct hisi_mux_clock hix5hd2_mux_clks[] __initdata = {
+static struct hisi_mux_clock hix5hd2_mux_clks[] = {
 	{ HIX5HD2_SFC_MUX, "sfc_mux", sfc_mux_p, ARRAY_SIZE(sfc_mux_p),
 		CLK_SET_RATE_PARENT, 0x5c, 8, 3, 0, sfc_mux_table, },
 	{ HIX5HD2_MMC_MUX, "mmc_mux", sdio_mux_p, ARRAY_SIZE(sdio_mux_p),
@@ -67,7 +71,7 @@ static struct hisi_mux_clock hix5hd2_mux_clks[] __initdata = {
 		CLK_SET_RATE_PARENT, 0x120, 8, 2, 0, fephy_mux_table, },
 };
 
-static struct hisi_gate_clock hix5hd2_gate_clks[] __initdata = {
+static struct hisi_gate_clock hix5hd2_gate_clks[] = {
 	/* sfc */
 	{ HIX5HD2_SFC_CLK, "clk_sfc", "sfc_mux",
 		CLK_SET_RATE_PARENT, 0x5c, 0, 0, },
@@ -153,7 +157,7 @@ struct hix5hd2_clk_complex {
 	u32		phy_rst_mask;
 };
 
-static struct hix5hd2_complex_clock hix5hd2_complex_clks[] __initdata = {
+static struct hix5hd2_complex_clock hix5hd2_complex_clks[] = {
 	{"clk_mac0", "clk_fephy", HIX5HD2_MAC0_CLK,
 		0xcc, 0xa, 0x500, 0x120, 0, 0x10, TYPE_ETHER},
 	{"clk_mac1", "clk_fwd_sys", HIX5HD2_MAC1_CLK,
@@ -249,21 +253,22 @@ static const struct clk_ops clk_complex_ops = {
 	.disable = clk_complex_disable,
 };
 
-static void __init
-hix5hd2_clk_register_complex(struct hix5hd2_complex_clock *clks, int nums,
+static int
+hix5hd2_clk_register_complex(struct device *dev, const void *clocks, size_t num,
 			     struct hisi_clock_data *data)
 {
+	const struct hix5hd2_complex_clock *clks = clocks;
 	void __iomem *base = data->base;
 	int i;
 
-	for (i = 0; i < nums; i++) {
+	for (i = 0; i < num; i++) {
 		struct hix5hd2_clk_complex *p_clk;
 		struct clk *clk;
 		struct clk_init_data init;
 
 		p_clk = kzalloc(sizeof(*p_clk), GFP_KERNEL);
 		if (!p_clk)
-			return;
+			return -ENOMEM;
 
 		init.name = clks[i].name;
 		if (clks[i].type == TYPE_ETHER)
@@ -289,31 +294,45 @@ hix5hd2_clk_register_complex(struct hix5hd2_complex_clock *clks, int nums,
 			kfree(p_clk);
 			pr_err("%s: failed to register clock %s\n",
 			       __func__, clks[i].name);
-			continue;
+			return PTR_ERR(p_clk);
 		}
 
 		data->clk_data.clks[clks[i].id] = clk;
 	}
-}
 
-static void __init hix5hd2_clk_init(struct device_node *np)
-{
-	struct hisi_clock_data *clk_data;
-
-	clk_data = hisi_clk_init(np, HIX5HD2_NR_CLKS);
-	if (!clk_data)
-		return;
-
-	hisi_clk_register_fixed_rate(hix5hd2_fixed_rate_clks,
-				     ARRAY_SIZE(hix5hd2_fixed_rate_clks),
-				     clk_data);
-	hisi_clk_register_mux(hix5hd2_mux_clks, ARRAY_SIZE(hix5hd2_mux_clks),
-					clk_data);
-	hisi_clk_register_gate(hix5hd2_gate_clks,
-			ARRAY_SIZE(hix5hd2_gate_clks), clk_data);
-	hix5hd2_clk_register_complex(hix5hd2_complex_clks,
-				     ARRAY_SIZE(hix5hd2_complex_clks),
-				     clk_data);
+	return 0;
 }
 
-CLK_OF_DECLARE(hix5hd2_clk, "hisilicon,hix5hd2-clock", hix5hd2_clk_init);
+static const struct hisi_clocks hix5hd2_clks = {
+	.nr = HIX5HD2_NR_CLKS,
+	.fixed_rate_clks = hix5hd2_fixed_rate_clks,
+	.fixed_factor_clks_num = ARRAY_SIZE(hix5hd2_fixed_rate_clks),
+	.mux_clks = hix5hd2_mux_clks,
+	.mux_clks_num = ARRAY_SIZE(hix5hd2_mux_clks),
+	.gate_clks = hix5hd2_gate_clks,
+	.gate_clks_num = ARRAY_SIZE(hix5hd2_gate_clks),
+	.customized_clks = hix5hd2_complex_clks,
+	.customized_clks_num = ARRAY_SIZE(hix5hd2_complex_clks),
+	.clk_register_customized = hix5hd2_clk_register_complex,
+};
+
+static const struct of_device_id hix5hd2_clk_match_table[] = {
+	{ .compatible = "hisilicon,hix5hd2-clock",
+	  .data = &hix5hd2_clks },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, hix5hd2_clk_match_table);
+
+static struct platform_driver hix5hd2_clk_driver = {
+	.probe = hisi_clk_probe,
+	.remove = hisi_clk_remove,
+	.driver		= {
+		.name	= "hix5hd2-clock",
+		.of_match_table = hix5hd2_clk_match_table,
+	},
+};
+
+module_platform_driver(hix5hd2_clk_driver);
+
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("HiSilicon Hix5hd2 Clock Driver");
-- 
2.39.2

