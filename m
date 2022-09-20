Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EEB85BDACF
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 05:21:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbiITDVf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 23:21:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbiITDVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 23:21:24 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BA76564CF;
        Mon, 19 Sep 2022 20:21:23 -0700 (PDT)
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MWmth1N0gzlW4N;
        Tue, 20 Sep 2022 11:17:16 +0800 (CST)
Received: from localhost (10.174.179.215) by canpemm500007.china.huawei.com
 (7.192.104.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 20 Sep
 2022 11:21:21 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <neal_liu@aspeedtech.com>, <herbert@gondor.apana.org.au>,
        <davem@davemloft.net>, <joel@jms.id.au>, <andrew@aj.id.au>,
        <johnny_huang@aspeedtech.com>, <dphadke@linux.microsoft.com>
CC:     <linux-aspeed@lists.ozlabs.org>, <linux-crypto@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] crypto: aspeed - Fix check for platform_get_irq() errors
Date:   Tue, 20 Sep 2022 11:21:18 +0800
Message-ID: <20220920032118.6440-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500007.china.huawei.com (7.192.104.62)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The platform_get_irq() function returns negative on error and
positive non-zero values on success. It never returns zero, but if it
did then treat that as a success.

Also remove redundant dev_err() print as platform_get_irq() already
prints an error.

Fixes: 108713a713c7 ("crypto: aspeed - Add HACE hash driver")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/crypto/aspeed/aspeed-hace.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/crypto/aspeed/aspeed-hace.c b/drivers/crypto/aspeed/aspeed-hace.c
index 3f880aafb6a2..f7f1d33defb1 100644
--- a/drivers/crypto/aspeed/aspeed-hace.c
+++ b/drivers/crypto/aspeed/aspeed-hace.c
@@ -130,10 +130,8 @@ static int aspeed_hace_probe(struct platform_device *pdev)
 
 	/* Get irq number and register it */
 	hace_dev->irq = platform_get_irq(pdev, 0);
-	if (!hace_dev->irq) {
-		dev_err(&pdev->dev, "Failed to get interrupt\n");
+	if (hace_dev->irq < 0)
 		return -ENXIO;
-	}
 
 	rc = devm_request_irq(&pdev->dev, hace_dev->irq, aspeed_hace_irq, 0,
 			      dev_name(&pdev->dev), hace_dev);
-- 
2.17.1

