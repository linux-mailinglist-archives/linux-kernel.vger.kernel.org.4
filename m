Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A694A5B65F7
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 05:07:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230058AbiIMDHf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 23:07:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbiIMDH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 23:07:27 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D0F14F699;
        Mon, 12 Sep 2022 20:07:26 -0700 (PDT)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MRSwD6mzxzmVNc;
        Tue, 13 Sep 2022 11:03:40 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 13 Sep 2022 11:07:24 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 13 Sep
 2022 11:07:23 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <mturquette@baylibre.com>, <sboyd@kernel.org>
Subject: [PATCH -next] clk: clocking-wizard: Use dev_err_probe() helper
Date:   Tue, 13 Sep 2022 11:14:42 +0800
Message-ID: <20220913031442.980720-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dev_err() can be replace with dev_err_probe() which will check if error
code is -EPROBE_DEFER.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/clk/xilinx/clk-xlnx-clock-wizard.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/clk/xilinx/clk-xlnx-clock-wizard.c b/drivers/clk/xilinx/clk-xlnx-clock-wizard.c
index 5b8433468cc5..eb1dfe7ecc1b 100644
--- a/drivers/clk/xilinx/clk-xlnx-clock-wizard.c
+++ b/drivers/clk/xilinx/clk-xlnx-clock-wizard.c
@@ -448,18 +448,14 @@ static int clk_wzrd_probe(struct platform_device *pdev)
 	}
 
 	clk_wzrd->clk_in1 = devm_clk_get(&pdev->dev, "clk_in1");
-	if (IS_ERR(clk_wzrd->clk_in1)) {
-		if (clk_wzrd->clk_in1 != ERR_PTR(-EPROBE_DEFER))
-			dev_err(&pdev->dev, "clk_in1 not found\n");
-		return PTR_ERR(clk_wzrd->clk_in1);
-	}
+	if (IS_ERR(clk_wzrd->clk_in1))
+		return dev_err_probe(&pdev->dev, PTR_ERR(clk_wzrd->clk_in1),
+				     "clk_in1 not found\n");
 
 	clk_wzrd->axi_clk = devm_clk_get(&pdev->dev, "s_axi_aclk");
-	if (IS_ERR(clk_wzrd->axi_clk)) {
-		if (clk_wzrd->axi_clk != ERR_PTR(-EPROBE_DEFER))
-			dev_err(&pdev->dev, "s_axi_aclk not found\n");
-		return PTR_ERR(clk_wzrd->axi_clk);
-	}
+	if (IS_ERR(clk_wzrd->axi_clk))
+		return dev_err_probe(&pdev->dev, PTR_ERR(clk_wzrd->axi_clk),
+				     "s_axi_aclk not found\n");
 	ret = clk_prepare_enable(clk_wzrd->axi_clk);
 	if (ret) {
 		dev_err(&pdev->dev, "enabling s_axi_aclk failed\n");
-- 
2.25.1

