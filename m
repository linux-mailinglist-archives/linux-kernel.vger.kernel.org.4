Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A8C96394EC
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 10:26:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbiKZJ0o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Nov 2022 04:26:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiKZJ0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Nov 2022 04:26:43 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBBA2275C8
        for <linux-kernel@vger.kernel.org>; Sat, 26 Nov 2022 01:26:41 -0800 (PST)
Received: from kwepemi500013.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NK5vJ4ZqvzmVxm;
        Sat, 26 Nov 2022 17:26:04 +0800 (CST)
Received: from huawei.com (10.175.112.208) by kwepemi500013.china.huawei.com
 (7.221.188.120) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Sat, 26 Nov
 2022 17:26:39 +0800
From:   Zheng Yongjun <zhengyongjun3@huawei.com>
To:     <shawnguo@kernel.org>, <s.hauer@pengutronix.de>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <kernel@pengutronix.de>, <festevam@gmail.com>, <linux-imx@nxp.com>
Subject: [PATCH] soc: imx8m: Fix return value check in imx8mq_soc_revision()
Date:   Sat, 26 Nov 2022 09:24:33 +0000
Message-ID: <20221126092433.91150-1-zhengyongjun3@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.208]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemi500013.china.huawei.com (7.221.188.120)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case of error, the function of_clk_get_by_name()
returns ERR_PTR() and never returns NULL. The NULL test in the
return value check should be replaced with IS_ERR().

Fixes: 836fb30949d9 ("soc: imx8m: Enable OCOTP clock before reading the register")
Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
---
 drivers/soc/imx/soc-imx8m.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/imx/soc-imx8m.c b/drivers/soc/imx/soc-imx8m.c
index 28144c699b0c..32ed9dc88e45 100644
--- a/drivers/soc/imx/soc-imx8m.c
+++ b/drivers/soc/imx/soc-imx8m.c
@@ -66,8 +66,8 @@ static u32 __init imx8mq_soc_revision(void)
 	ocotp_base = of_iomap(np, 0);
 	WARN_ON(!ocotp_base);
 	clk = of_clk_get_by_name(np, NULL);
-	if (!clk) {
-		WARN_ON(!clk);
+	if (IS_ERR(clk)) {
+		WARN_ON(IS_ERR(clk));
 		return 0;
 	}

--
2.17.1

