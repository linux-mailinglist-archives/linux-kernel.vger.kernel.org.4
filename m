Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A40A9629437
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 10:22:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232672AbiKOJW4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 04:22:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232629AbiKOJWt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 04:22:49 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E94AB2628
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 01:22:48 -0800 (PST)
Received: from kwepemi500023.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4NBLLC05kJz15Mb6;
        Tue, 15 Nov 2022 17:22:26 +0800 (CST)
Received: from huawei.com (10.175.112.208) by kwepemi500023.china.huawei.com
 (7.221.188.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 15 Nov
 2022 17:11:13 +0800
From:   Peng Wu <wupeng58@huawei.com>
To:     <sboyd@kernel.org>, <vkoul@kernel.org>, <collinsd@codeaurora.org>,
        <andersson@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <liwei391@huawei.com>,
        Peng Wu <wupeng58@huawei.com>
Subject: [PATCH -next] spmi: pmic-arb: fix a NULL vs IS_ERR() check in spmi_pmic_arb_probe()
Date:   Tue, 15 Nov 2022 09:09:27 +0000
Message-ID: <20221115090927.47143-1-wupeng58@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.208]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemi500023.china.huawei.com (7.221.188.76)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The devm_ioremap() function returns NULL on error, it doesn't return
error pointers.

Fixes: 231601cd22bd ("spmi: pmic-arb: Add support for PMIC v7")
Signed-off-by: Peng Wu <wupeng58@huawei.com>
---
 drivers/spmi/spmi-pmic-arb.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/spmi/spmi-pmic-arb.c b/drivers/spmi/spmi-pmic-arb.c
index 8b6a42ab816f..c5b5ea0519c1 100644
--- a/drivers/spmi/spmi-pmic-arb.c
+++ b/drivers/spmi/spmi-pmic-arb.c
@@ -1462,8 +1462,8 @@ static int spmi_pmic_arb_probe(struct platform_device *pdev)
 	 */
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "core");
 	core = devm_ioremap(&ctrl->dev, res->start, resource_size(res));
-	if (IS_ERR(core)) {
-		err = PTR_ERR(core);
+	if (!core) {
+		err = -ENOMEM;
 		goto err_put_ctrl;
 	}
 
@@ -1499,8 +1499,8 @@ static int spmi_pmic_arb_probe(struct platform_device *pdev)
 						   "obsrvr");
 		pmic_arb->rd_base = devm_ioremap(&ctrl->dev, res->start,
 						 resource_size(res));
-		if (IS_ERR(pmic_arb->rd_base)) {
-			err = PTR_ERR(pmic_arb->rd_base);
+		if (!pmic_arb->rd_base) {
+			err = -ENOMEM;
 			goto err_put_ctrl;
 		}
 
@@ -1508,8 +1508,8 @@ static int spmi_pmic_arb_probe(struct platform_device *pdev)
 						   "chnls");
 		pmic_arb->wr_base = devm_ioremap(&ctrl->dev, res->start,
 						 resource_size(res));
-		if (IS_ERR(pmic_arb->wr_base)) {
-			err = PTR_ERR(pmic_arb->wr_base);
+		if (!pmic_arb->wr_base) {
+			err = -ENOMEM;
 			goto err_put_ctrl;
 		}
 	}
-- 
2.17.1

