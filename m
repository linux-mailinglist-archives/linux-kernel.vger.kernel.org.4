Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A78A69CB24
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 13:39:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231797AbjBTMjf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 07:39:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231265AbjBTMj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 07:39:29 -0500
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87DBCDBC5;
        Mon, 20 Feb 2023 04:39:27 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0Vc6Ws8T_1676896763;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0Vc6Ws8T_1676896763)
          by smtp.aliyun-inc.com;
          Mon, 20 Feb 2023 20:39:23 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     davem@davemloft.net
Cc:     joel@jms.id.au, andrew@aj.id.au, neal_liu@aspeedtech.com,
        herbert@gondor.apana.org.au, linux-aspeed@lists.ozlabs.org,
        linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH -next] crypto: Use devm_platform_ioremap_resource()
Date:   Mon, 20 Feb 2023 20:39:21 +0800
Message-Id: <20230220123921.7191-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert platform_get_resource(), devm_ioremap_resource() to a single
call to Use devm_platform_ioremap_resource(), as this is exactly
what this function does.

Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/crypto/aspeed/aspeed-acry.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/crypto/aspeed/aspeed-acry.c b/drivers/crypto/aspeed/aspeed-acry.c
index 1f77ebd73489..857a7a222922 100644
--- a/drivers/crypto/aspeed/aspeed-acry.c
+++ b/drivers/crypto/aspeed/aspeed-acry.c
@@ -712,7 +712,6 @@ static int aspeed_acry_probe(struct platform_device *pdev)
 {
 	struct aspeed_acry_dev *acry_dev;
 	struct device *dev = &pdev->dev;
-	struct resource *res;
 	int rc;
 
 	acry_dev = devm_kzalloc(dev, sizeof(struct aspeed_acry_dev),
@@ -724,13 +723,11 @@ static int aspeed_acry_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, acry_dev);
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	acry_dev->regs = devm_ioremap_resource(dev, res);
+	acry_dev->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(acry_dev->regs))
 		return PTR_ERR(acry_dev->regs);
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-	acry_dev->acry_sram = devm_ioremap_resource(dev, res);
+	acry_dev->acry_sram = devm_platform_ioremap_resource(pdev, 1);
 	if (IS_ERR(acry_dev->acry_sram))
 		return PTR_ERR(acry_dev->acry_sram);
 
-- 
2.20.1.7.g153144c

