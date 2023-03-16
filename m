Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB2EE6BC3D9
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 03:37:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbjCPChQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 22:37:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjCPChN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 22:37:13 -0400
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA1F596F38;
        Wed, 15 Mar 2023 19:37:08 -0700 (PDT)
Received: from SHSend.spreadtrum.com (bjmbx02.spreadtrum.com [10.0.64.8])
        by SHSQR01.spreadtrum.com with ESMTP id 32G2aanJ017410;
        Thu, 16 Mar 2023 10:36:36 +0800 (+08)
        (envelope-from Chunyan.Zhang@unisoc.com)
Received: from ubt.spreadtrum.com (10.0.74.87) by BJMBX02.spreadtrum.com
 (10.0.64.8) with Microsoft SMTP Server (TLS) id 15.0.1497.23; Thu, 16 Mar
 2023 10:36:34 +0800
From:   Chunyan Zhang <chunyan.zhang@unisoc.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
CC:     <linux-clk@vger.kernel.org>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH V2] clk: sprd: set max_register according to mapping range
Date:   Thu, 16 Mar 2023 10:36:24 +0800
Message-ID: <20230316023624.758204-1-chunyan.zhang@unisoc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.0.74.87]
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX02.spreadtrum.com (10.0.64.8)
X-MAIL: SHSQR01.spreadtrum.com 32G2aanJ017410
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In sprd clock driver, regmap_config.max_register was set to a fixed value
which is likely larger than the address range configured in device tree,
when reading registers through debugfs it would cause access violation.

Fixes: d41f59fd92f2 (clk: sprd: Add common infrastructure)
Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
---
V2:
- Added Fixes tag.
---
 drivers/clk/sprd/common.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/sprd/common.c b/drivers/clk/sprd/common.c
index ce81e4087a8f..2bfbab8db94b 100644
--- a/drivers/clk/sprd/common.c
+++ b/drivers/clk/sprd/common.c
@@ -17,7 +17,6 @@ static const struct regmap_config sprdclk_regmap_config = {
 	.reg_bits	= 32,
 	.reg_stride	= 4,
 	.val_bits	= 32,
-	.max_register	= 0xffff,
 	.fast_io	= true,
 };
 
@@ -43,6 +42,8 @@ int sprd_clk_regmap_init(struct platform_device *pdev,
 	struct device *dev = &pdev->dev;
 	struct device_node *node = dev->of_node, *np;
 	struct regmap *regmap;
+	struct resource *res;
+	struct regmap_config reg_config = sprdclk_regmap_config;
 
 	if (of_find_property(node, "sprd,syscon", NULL)) {
 		regmap = syscon_regmap_lookup_by_phandle(node, "sprd,syscon");
@@ -59,12 +60,14 @@ int sprd_clk_regmap_init(struct platform_device *pdev,
 			return PTR_ERR(regmap);
 		}
 	} else {
-		base = devm_platform_ioremap_resource(pdev, 0);
+		base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
 		if (IS_ERR(base))
 			return PTR_ERR(base);
 
+		reg_config.max_register = resource_size(res) - reg_config.reg_stride;
+
 		regmap = devm_regmap_init_mmio(&pdev->dev, base,
-					       &sprdclk_regmap_config);
+					       &reg_config);
 		if (IS_ERR(regmap)) {
 			pr_err("failed to init regmap\n");
 			return PTR_ERR(regmap);
-- 
2.25.1

