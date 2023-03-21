Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF7446C3B27
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 21:02:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbjCUUB5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 16:01:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbjCUUBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 16:01:51 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A59550993;
        Tue, 21 Mar 2023 13:01:29 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id iw3so17243720plb.6;
        Tue, 21 Mar 2023 13:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679428885;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9ud6HDkJTBQVoMV1SMRF9b3rhFeQyq+gEcodqgZy62U=;
        b=ICQ/7lQCydF7QT6jKW1IJUSV5Fxi40vl2W33V0zif+kiPqZKeOjxIR5ExsC4oEH+3h
         UGHRAv1Om+pPr6vQUkhDvjjx22RMb7nKSPvx8z1QyRjdDXYVlXj6dzPitVSuXEHq1zSx
         wmmUNgKam364dQd+Ty2lOLM6we/6rMWp8kDkEOGa4WPpkfLgmj8hBY9UYFBGAN0rqVpH
         t4Dbndv3kqIxhojfwKRdD4aC4Z6saWi/akXirZ54pfxC6Z0ta7bF3TiLuy3XZqZO9nsk
         4aUWPIu9/+qiiY2a6kj4Cv5mdygW806mGHwJCEydPh8vdh/syWHxcyDB5eL34VzagZp1
         t52A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679428885;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9ud6HDkJTBQVoMV1SMRF9b3rhFeQyq+gEcodqgZy62U=;
        b=if7y4WM0wB29ZdeH/RHPdhWbKrBbv4oWs2wjc4CW15vRgtoreV26Hm9TYTWUo2IxI2
         pig/X1p2LOWS9I20hlq6/hNmQXhOpLCD2tXpx0MLe4XzfcxiFrNqn5b+V7eSCLKIKBWw
         bFu3S07JMV1xSstnSRktb039CifafeT7Eoo4k1iksq5++AMPljDabuawMagrBDb6lBMr
         jaTT7eVUUyaYPn2wsjOfUVOfYPBV/ADLWDLnKnIiHhbiadhl2g5MRVcmKalmZ0rhaz/h
         aCWgxojGlu7hnejmNkPewRc2+nHl5tm1T2NZj4S1E0cSGFeW6H/Q4DtwA5/GW4pF44S1
         d9HQ==
X-Gm-Message-State: AO0yUKV+xBm2LPKLYWqAWJmZK5f3DY5ho8vcKxBvtN+4UGqxUFIYATQN
        BMPoajEf7mh9ZpA4ZBt/gF8=
X-Google-Smtp-Source: AK7set8Dp2E29z8EP30SuKC13abJYxDn4bDr93PGLpVZSOKaq0K/2l+WQhr0wpFNcS++kFmy1dBsiw==
X-Received: by 2002:a17:90b:1bc7:b0:23f:6d4e:72b3 with SMTP id oa7-20020a17090b1bc700b0023f6d4e72b3mr826459pjb.25.1679428885497;
        Tue, 21 Mar 2023 13:01:25 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([104.28.245.199])
        by smtp.gmail.com with ESMTPSA id mt19-20020a17090b231300b0023b5528b8d4sm930557pjb.19.2023.03.21.13.01.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 13:01:25 -0700 (PDT)
From:   David Yang <mmyangfl@gmail.com>
Cc:     David Yang <mmyangfl@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 4/6] clk: hisilicon: Add complex clock for Hi3798
Date:   Wed, 22 Mar 2023 04:00:25 +0800
Message-Id: <20230321200031.1812026-5-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230321200031.1812026-1-mmyangfl@gmail.com>
References: <20230321200031.1812026-1-mmyangfl@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
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
 drivers/clk/hisilicon/crg-hi3798.c | 126 +++++++++++++++++++++++++++++
 1 file changed, 126 insertions(+)

diff --git a/drivers/clk/hisilicon/crg-hi3798.c b/drivers/clk/hisilicon/crg-hi3798.c
index d05151d0e..78915bd26 100644
--- a/drivers/clk/hisilicon/crg-hi3798.c
+++ b/drivers/clk/hisilicon/crg-hi3798.c
@@ -7,9 +7,13 @@
 
 #include <dt-bindings/clock/histb-clock.h>
 #include <linux/clk-provider.h>
+#include <linux/clkdev.h>
+#include <linux/device.h>
+#include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
+#include <linux/slab.h>
 #include "clk.h"
 #include "crg.h"
 #include "reset.h"
@@ -59,6 +63,121 @@ static const struct hisi_fixed_rate_clock hi3798_fixed_rate_clks[] = {
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
+static int hi3798_clk_register_complex(struct device *dev,
+				       const struct hi3798_complex_clock *clks, int nums,
+				       struct hisi_clock_data *data)
+{
+	void __iomem *base = data->base;
+	int i;
+	int ret;
+
+	for (i = 0; i < nums; i++) {
+		struct hi3798_clk_complex *p_clk;
+		struct clk_init_data init;
+
+		p_clk = devm_kzalloc(dev, sizeof(*p_clk), GFP_KERNEL);
+		if (!p_clk)
+			return -ENOMEM;
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
+		ret = devm_clk_hw_register(dev, &p_clk->hw);
+		if (ret) {
+			pr_err("%s: failed to register clock %s\n",
+			       __func__, clks[i].name);
+			return ret;
+		}
+
+		if (clks[i].alias)
+			clk_register_clkdev(clk, clks[i].alias, NULL);
+
+		data->clk_data->hws[clks[i].id] = &p_clk->hw;
+	}
+
+	return 0;
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
@@ -66,6 +185,8 @@ struct hi3798_clks {
 	int mux_clks_nums;
 	const struct hisi_phase_clock *phase_clks;
 	int phase_clks_nums;
+	const struct hi3798_complex_clock *complex_clks;
+	int complex_clks_nums;
 };
 
 static struct hisi_clock_data *
@@ -100,6 +221,11 @@ hi3798_clk_register(struct platform_device *pdev,
 	if (ret)
 		return ERR_PTR(ret);
 
+	ret = hi3798_clk_register_complex(dev, clks->complex_clks,
+					  clks->complex_clks_nums, clk_data);
+	if (ret)
+		return ERR_PTR(ret);
+
 	ret = devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get,
 					  clk_data->clk_data);
 	if (ret)
-- 
2.39.2

