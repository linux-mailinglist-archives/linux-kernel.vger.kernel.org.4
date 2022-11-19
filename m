Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C0EB630C4A
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 06:52:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231961AbiKSFwP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Nov 2022 00:52:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbiKSFwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Nov 2022 00:52:11 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CD348FE4E;
        Fri, 18 Nov 2022 21:52:10 -0800 (PST)
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NDjPF3JfKzqSVS;
        Sat, 19 Nov 2022 13:48:17 +0800 (CST)
Received: from kwepemm600005.china.huawei.com (7.193.23.191) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 19 Nov 2022 13:52:08 +0800
Received: from ubuntu1804.huawei.com (10.67.175.30) by
 kwepemm600005.china.huawei.com (7.193.23.191) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 19 Nov 2022 13:52:07 +0800
From:   Hui Tang <tanghui20@huawei.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>
CC:     <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yusongping@huawei.com>, <claudiu.beznea@microchip.com>,
        <conor.dooley@microchip.com>
Subject: [PATCH] clk: microchip: check for null return of devm_kzalloc()
Date:   Sat, 19 Nov 2022 13:48:58 +0800
Message-ID: <20221119054858.178629-1-tanghui20@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.175.30]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600005.china.huawei.com (7.193.23.191)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because of the possilble failure of devm_kzalloc(), name might be NULL and
will cause null pointer derefrence later.

Therefore, it might be better to check it and directly return -ENOMEM.

Fixes: d39fb172760e ("clk: microchip: add PolarFire SoC fabric clock support")
Signed-off-by: Hui Tang <tanghui20@huawei.com>
---
 drivers/clk/microchip/clk-mpfs-ccc.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/clk/microchip/clk-mpfs-ccc.c b/drivers/clk/microchip/clk-mpfs-ccc.c
index 7be028dced63..32aae880a14f 100644
--- a/drivers/clk/microchip/clk-mpfs-ccc.c
+++ b/drivers/clk/microchip/clk-mpfs-ccc.c
@@ -166,6 +166,9 @@ static int mpfs_ccc_register_outputs(struct device *dev, struct mpfs_ccc_out_hw_
 		struct mpfs_ccc_out_hw_clock *out_hw = &out_hws[i];
 		char *name = devm_kzalloc(dev, 23, GFP_KERNEL);
 
+		if (!name)
+			return -ENOMEM;
+
 		snprintf(name, 23, "%s_out%u", parent->name, i);
 		out_hw->divider.hw.init = CLK_HW_INIT_HW(name, &parent->hw, &clk_divider_ops, 0);
 		out_hw->divider.reg = data->pll_base[i / MPFS_CCC_OUTPUTS_PER_PLL] +
@@ -200,6 +203,9 @@ static int mpfs_ccc_register_plls(struct device *dev, struct mpfs_ccc_pll_hw_clo
 		struct mpfs_ccc_pll_hw_clock *pll_hw = &pll_hws[i];
 		char *name = devm_kzalloc(dev, 18, GFP_KERNEL);
 
+		if (!name)
+			return -ENOMEM;
+
 		pll_hw->base = data->pll_base[i];
 		snprintf(name, 18, "ccc%s_pll%u", strchrnul(dev->of_node->full_name, '@'), i);
 		pll_hw->name = (const char *)name;
-- 
2.17.1

