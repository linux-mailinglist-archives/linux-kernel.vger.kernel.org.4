Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D47D6C2307
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 21:41:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229458AbjCTUls (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 16:41:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbjCTUll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 16:41:41 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F05338475;
        Mon, 20 Mar 2023 13:41:22 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id x15so3136887pjk.2;
        Mon, 20 Mar 2023 13:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679344881;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Glp/G+tr1mPfDBJEHiZ14zAl4MCfL3gDlRqKOfGi5w8=;
        b=BXRaRRBQXCXbQMPiuRzNLUEpSAMijPSy9JMoUzAT1pH8e23NJs8vw/XkODDGoo8l2G
         RV7wgtV5uRSWAg+SVwUFUQuu6r7KZxZDnKkjD7XKUzWwIjvtzCLv2nlmabdY3duACrND
         v9M6n+zKEgwxTcBmucggUFacjPwdTaHlVj2VBub4JvbrbAmc7jkxtWvia1FZ31Hh0pf9
         y9N7lHimfpeKXsWOdj9O24ZHiM/KipN08wCrl2lKTFYm2Wqlo4ttdbE7ysCiOpd4UCOm
         /h2iU/WiX1uqrFvUnO5avmsjSKwi+vgqYE3XxdAuJLXnCOK3TOslRIx38qzUUGevkHLi
         34Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679344881;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Glp/G+tr1mPfDBJEHiZ14zAl4MCfL3gDlRqKOfGi5w8=;
        b=WjFI04OKYwR6xhVBmb05bZ5LDIbLWQjcN1SowsCXhsT19UIKeqsyD94yAxkFpY4+ga
         5eQ1LzPceJ2s7RAts0sts59dGaNb16B5Wr2HMKbuonPR75WdqFAXSu9Yn3wZb4CBaXvu
         E6/13NCoF8n1hACHnRskFJCgEZkzlVthChRV9UtasNmht/kzyGQ0xCle9afLsfIhM1s9
         pZdls7cB3pYkmzGPlTLiuztq6vmFrYhHoV/5hYH/0Oy5RXWcfjptTA2OfYU7zvkCm8JS
         pLDx2YROUQ9JdW7RsS19MkAp1Q0yW7LCTuM6ItKo8Boh2LGcdd1D2QoQwPEac0H8jp6I
         AQWg==
X-Gm-Message-State: AO0yUKUKORwZnaGeTtx+v2jrWwQzegXG+DDlk/thkZbbqqos/HJqehxw
        C0HULS10ay2qZX8oVgzP3Gc=
X-Google-Smtp-Source: AK7set+sNN4Ttpic5J7HpSPnkZodxr68UgoarTv29kxtu9SnBR5Yl0OcDzpPN7cp/avUPGQctZDcQA==
X-Received: by 2002:a17:90b:4b86:b0:23d:19c6:84b7 with SMTP id lr6-20020a17090b4b8600b0023d19c684b7mr453957pjb.16.1679344881485;
        Mon, 20 Mar 2023 13:41:21 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([104.28.213.202])
        by smtp.gmail.com with ESMTPSA id c3-20020a17090aa60300b0023b29b464f9sm6580943pjq.27.2023.03.20.13.41.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 13:41:21 -0700 (PDT)
From:   David Yang <mmyangfl@gmail.com>
Cc:     David Yang <mmyangfl@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 3/5] clk: hisilicon: Add complex clock for Hi3798
Date:   Tue, 21 Mar 2023 04:40:36 +0800
Message-Id: <20230320204042.980708-4-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230320204042.980708-1-mmyangfl@gmail.com>
References: <20230320204042.980708-1-mmyangfl@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Complex clock allows manipulating multiple bits simultaneously.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/clk/hisilicon/crg-hi3798.c | 138 ++++++++++++++++++++++++++++-
 1 file changed, 137 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/hisilicon/crg-hi3798.c b/drivers/clk/hisilicon/crg-hi3798.c
index 2f8f14e73..0b29c01c6 100644
--- a/drivers/clk/hisilicon/crg-hi3798.c
+++ b/drivers/clk/hisilicon/crg-hi3798.c
@@ -7,9 +7,11 @@
 
 #include <dt-bindings/clock/histb-clock.h>
 #include <linux/clk-provider.h>
+#include <linux/clkdev.h>
 #include <linux/module.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
+#include <linux/slab.h>
 #include "clk.h"
 #include "crg.h"
 #include "reset.h"
@@ -59,6 +61,131 @@ static const struct hisi_fixed_rate_clock hi3798_fixed_rate_clks[] = {
 	{ HI3798_FIXED_250M, "250m", NULL, 0, 250000000, },
 };
 
+struct hi3798_complex_clock {
+	unsigned int	id;
+	const char	*name;
+	const char	*parent_name;
+	unsigned long	flags;
+	unsigned long	offset;
+	u32		mask;
+	u32		value;
+	const char	*alias;
+};
+
+struct hi3798_clk_complex {
+	struct clk_hw	hw;
+	void __iomem	*reg;
+	u32		mask;
+	u32		value;
+};
+
+#define to_complex_clk(_hw) container_of(_hw, struct hi3798_clk_complex, hw)
+
+static int hi3798_clk_complex_prepare(struct clk_hw *hw)
+{
+	struct hi3798_clk_complex *clk = to_complex_clk(hw);
+	u32 val;
+
+	val = readl_relaxed(clk->reg);
+	val &= ~(clk->mask);
+	val |= clk->value;
+	writel_relaxed(val, clk->reg);
+
+	return 0;
+}
+
+static void hi3798_clk_complex_unprepare(struct clk_hw *hw)
+{
+	struct hi3798_clk_complex *clk = to_complex_clk(hw);
+	u32 val;
+
+	val = readl_relaxed(clk->reg);
+	val &= ~(clk->mask);
+	writel_relaxed(val, clk->reg);
+}
+
+static int hi3798_clk_complex_is_prepared(struct clk_hw *hw)
+{
+	struct hi3798_clk_complex *clk = to_complex_clk(hw);
+	u32 val;
+
+	val = readl_relaxed(clk->reg);
+	return (val & clk->mask) == clk->value;
+}
+
+static const struct clk_ops hi3798_clk_complex_ops = {
+	.prepare = hi3798_clk_complex_prepare,
+	.unprepare = hi3798_clk_complex_unprepare,
+	.is_prepared = hi3798_clk_complex_is_prepared,
+};
+
+static int hi3798_clk_register_complex(const struct hi3798_complex_clock *clks, int nums,
+				       struct hisi_clock_data *data)
+{
+	void __iomem *base = data->base;
+	int i;
+	int ret;
+
+	for (i = 0; i < nums; i++) {
+		struct hi3798_clk_complex *p_clk;
+		struct clk *clk;
+		struct clk_init_data init;
+
+		p_clk = kzalloc(sizeof(*p_clk), GFP_KERNEL);
+		if (!p_clk) {
+			ret = -ENOMEM;
+			goto err_kzalloc;
+		}
+
+		init.name = clks[i].name;
+		init.ops = &hi3798_clk_complex_ops;
+
+		init.flags = 0;
+		init.parent_names =
+			(clks[i].parent_name ? &clks[i].parent_name : NULL);
+		init.num_parents = (clks[i].parent_name ? 1 : 0);
+
+		p_clk->reg = base + clks[i].offset;
+		p_clk->mask = clks[i].mask;
+		p_clk->value = clks[i].value;
+		p_clk->hw.init = &init;
+
+		clk = clk_register(NULL, &p_clk->hw);
+		if (IS_ERR(clk)) {
+			kfree(p_clk);
+err_kzalloc:
+			pr_err("%s: failed to register clock %s\n",
+			       __func__, clks[i].name);
+			goto err;
+		}
+
+		if (clks[i].alias)
+			clk_register_clkdev(clk, clks[i].alias, NULL);
+
+		data->clk_data.clks[clks[i].id] = clk;
+	}
+
+	return 0;
+
+err:
+	while (i--)
+		clk_unregister(data->clk_data.clks[clks[i].id]);
+
+	return ret;
+}
+
+static void hi3798_clk_unregister_complex(const struct hi3798_complex_clock *clks, int nums,
+					  struct hisi_clock_data *data)
+{
+	struct clk **clocks = data->clk_data.clks;
+	int i;
+
+	for (i = 0; i < nums; i++) {
+		if (clocks[clks[i].id])
+			clk_unregister(clocks[clks[i].id]);
+	}
+}
+
 struct hi3798_clks {
 	const struct hisi_gate_clock *gate_clks;
 	int gate_clks_nums;
@@ -66,6 +193,8 @@ struct hi3798_clks {
 	int mux_clks_nums;
 	const struct hisi_phase_clock *phase_clks;
 	int phase_clks_nums;
+	const struct hi3798_complex_clock *complex_clks;
+	int complex_clks_nums;
 };
 
 static struct hisi_clock_data *hi3798_clk_register(
@@ -98,13 +227,19 @@ static struct hisi_clock_data *hi3798_clk_register(
 	if (ret)
 		goto unregister_mux;
 
+	ret = hi3798_clk_register_complex(clks->complex_clks, clks->complex_clks_nums, clk_data);
+	if (ret)
+		goto unregister_gate;
+
 	ret = of_clk_add_provider(pdev->dev.of_node,
 			of_clk_src_onecell_get, &clk_data->clk_data);
 	if (ret)
-		goto unregister_gate;
+		goto unregister_complex;
 
 	return clk_data;
 
+unregister_complex:
+	hi3798_clk_unregister_complex(clks->complex_clks, clks->complex_clks_nums, clk_data);
 unregister_gate:
 	hisi_clk_unregister_gate(clks->gate_clks, clks->gate_clks_nums, clk_data);
 unregister_mux:
@@ -123,6 +258,7 @@ static void hi3798_clk_unregister(
 
 	of_clk_del_provider(pdev->dev.of_node);
 
+	hi3798_clk_unregister_complex(clks->complex_clks, clks->complex_clks_nums, crg->clk_data);
 	hisi_clk_unregister_gate(clks->gate_clks, clks->gate_clks_nums, crg->clk_data);
 	hisi_clk_unregister_mux(clks->mux_clks, clks->mux_clks_nums, crg->clk_data);
 	hisi_clk_unregister_fixed_rate(hi3798_fixed_rate_clks,
-- 
2.39.2

