Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CD515B6602
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 05:11:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbiIMDLF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 23:11:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbiIMDKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 23:10:55 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF1CE21815;
        Mon, 12 Sep 2022 20:10:54 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MRT0053MJzlVqP;
        Tue, 13 Sep 2022 11:06:56 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 13 Sep 2022 11:10:52 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 13 Sep
 2022 11:10:52 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <agross@kernel.org>, <andersson@kernel.org>, <sboyd@kernel.org>
Subject: [PATCH -next 2/2] clk: qcom: clk-spmi-pmic-div: Use dev_err_probe() helper
Date:   Tue, 13 Sep 2022 11:17:56 +0800
Message-ID: <20220913031756.983224-2-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220913031756.983224-1-yangyingliang@huawei.com>
References: <20220913031756.983224-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
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
 drivers/clk/qcom/clk-spmi-pmic-div.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/qcom/clk-spmi-pmic-div.c b/drivers/clk/qcom/clk-spmi-pmic-div.c
index f2cf55cee2fd..10b8d19d0662 100644
--- a/drivers/clk/qcom/clk-spmi-pmic-div.c
+++ b/drivers/clk/qcom/clk-spmi-pmic-div.c
@@ -237,12 +237,9 @@ static int spmi_pmic_clkdiv_probe(struct platform_device *pdev)
 	cc->nclks = nclks;
 
 	cxo = clk_get(dev, "xo");
-	if (IS_ERR(cxo)) {
-		ret = PTR_ERR(cxo);
-		if (ret != -EPROBE_DEFER)
-			dev_err(dev, "failed to get xo clock\n");
-		return ret;
-	}
+	if (IS_ERR(cxo))
+		return dev_err_probe(dev, PTR_ERR(cxo),
+				     "failed to get xo clock\n");
 	cxo_hz = clk_get_rate(cxo);
 	clk_put(cxo);
 
-- 
2.25.1

