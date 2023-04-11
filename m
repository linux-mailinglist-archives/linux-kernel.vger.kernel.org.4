Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E51A6DE301
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 19:46:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbjDKRqn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 13:46:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230208AbjDKRq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 13:46:29 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BA695BB5;
        Tue, 11 Apr 2023 10:46:13 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id mn5-20020a17090b188500b00246eddf34f6so1053059pjb.0;
        Tue, 11 Apr 2023 10:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681235172;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IrGWkObbHZex0RD5jh5ZL+1MH7Eazo5YGcbtvBP2RIo=;
        b=BFAxvmKmVmXtTLTig5HNi06mFqu5WR553v7mLHdCnhyAAM7HjQp9yhC34oJlofsvqA
         nuC3I5NzojVxLh832HXzMyElPG/Na250RG7LPLIHSwCBNUSCH0nSVm45Hv69NeDDybfC
         PuE8g3WRxHqKl667DWrkLApltNIW71ZFGX7JZ1j1AAoKW4R5/gxvt8ZHsWBzkssj00tA
         XTjOzkmh3ibfV5udvbV/iJcavnpCql+EsjhdnwBSDEMNzIHoosMyQx54Jxuc8DEqnw7J
         pGlmHq/QyphYDTqPsMPUEjAfgHSqAFRyoNUC9yzo4VPRfsflZwCsTx8YLV9Xa49pCrdi
         0ttg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681235172;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IrGWkObbHZex0RD5jh5ZL+1MH7Eazo5YGcbtvBP2RIo=;
        b=QMsVKjrfvMOpFSppw5oIL0NeSMK45418grY5Q1IhzGhRhtnsDx3PmpJ8/TpdDb5vrN
         fp8pDwWUR7rq4QmgNlcYASfS5pfww1VlP61ET5DppzBRuUovoD/XIOdfDzB+RyAIWyLS
         qFa5DhkelWwVaSLNM0wO4cE3gKLbzO1xZvmKoDM2ME7nIWzrRAUk4c8V3/LX7MgLusXn
         Yz0I1zwyyZk3yLYJqRO+FobbIoy+JRbwDaXuXIaKHCs4Xiv5obR6Ahmx0WyyoTm042r4
         rS9Vgk5wUceFXsaSOaqW2AVAQai7MHHfNVXM1xeoZP9tjAoAhvedURsO02OHUKKDzRyU
         x3Wg==
X-Gm-Message-State: AAQBX9e9syueLCvF2CD9zJBpzSipGZ5kQZ/N7gqbBO1kWvJSEpbp0NJo
        qwL4lt9PVJrbp//0doauUl16hefffgLaC0++YF8=
X-Google-Smtp-Source: AKy350abfUmMX3U9JEeodX/azfsn9Staklp1r6LgPtB9eX1FaKZ+O3oSQcFeO33/E4ulLQQUgx5o8g==
X-Received: by 2002:a17:903:1111:b0:1a4:f295:32fa with SMTP id n17-20020a170903111100b001a4f29532famr19906920plh.15.1681235172465;
        Tue, 11 Apr 2023 10:46:12 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([104.28.213.202])
        by smtp.gmail.com with ESMTPSA id w23-20020a1709027b9700b001a655738a42sm1900805pll.172.2023.04.11.10.46.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 10:46:12 -0700 (PDT)
From:   David Yang <mmyangfl@gmail.com>
To:     linux-clk@vger.kernel.org
Cc:     David Yang <mmyangfl@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v4 11/13] clk: hisilicon: hip04: Convert into platform driver module
Date:   Wed, 12 Apr 2023 01:43:20 +0800
Message-Id: <20230411174329.424763-12-mmyangfl@gmail.com>
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
 drivers/clk/hisilicon/clk-hip04.c | 39 +++++++++++++++++++------------
 1 file changed, 24 insertions(+), 15 deletions(-)

diff --git a/drivers/clk/hisilicon/clk-hip04.c b/drivers/clk/hisilicon/clk-hip04.c
index 785b9faf3ea5..230702057e3b 100644
--- a/drivers/clk/hisilicon/clk-hip04.c
+++ b/drivers/clk/hisilicon/clk-hip04.c
@@ -10,11 +10,8 @@
 
 #include <linux/kernel.h>
 #include <linux/clk-provider.h>
-#include <linux/io.h>
-#include <linux/of.h>
-#include <linux/of_address.h>
+#include <linux/module.h>
 #include <linux/of_device.h>
-#include <linux/slab.h>
 
 #include <dt-bindings/clock/hip04-clock.h>
 
@@ -27,16 +24,28 @@ static struct hisi_fixed_rate_clock hip04_fixed_rate_clks[] __initdata = {
 	{ HIP04_CLK_168M, "clk168m",  NULL, 0, 168750000, },
 };
 
-static void __init hip04_clk_init(struct device_node *np)
-{
-	struct hisi_clock_data *clk_data;
+static const struct hisi_clocks hip04_clks = {
+	.fixed_rate_clks = hip04_fixed_rate_clks,
+	.fixed_factor_clks_num = ARRAY_SIZE(hip04_fixed_rate_clks),
+};
+
+static const struct of_device_id hip04_clk_match_table[] = {
+	{ .compatible = "hisilicon,hip04-clock",
+	  .data = &hip04_clks },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, hip04_clk_match_table);
+
+static struct platform_driver hip04_clk_driver = {
+	.probe = hisi_clk_probe,
+	.remove = hisi_clk_remove,
+	.driver		= {
+		.name	= "hip04-clock",
+		.of_match_table = hip04_clk_match_table,
+	},
+};
 
-	clk_data = hisi_clk_init(np, HIP04_NR_CLKS);
-	if (!clk_data)
-		return;
+module_platform_driver(hip04_clk_driver);
 
-	hisi_clk_register_fixed_rate(hip04_fixed_rate_clks,
-				     ARRAY_SIZE(hip04_fixed_rate_clks),
-				     clk_data);
-}
-CLK_OF_DECLARE(hip04_clk, "hisilicon,hip04-clock", hip04_clk_init);
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("HiSilicon HiP04 Clock Driver");
-- 
2.39.2

