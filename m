Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8706C6C793C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 08:54:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231301AbjCXHyR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 03:54:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjCXHyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 03:54:16 -0400
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 292A755A9
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 00:54:13 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R721e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0VeX.zCU_1679644450;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0VeX.zCU_1679644450)
          by smtp.aliyun-inc.com;
          Fri, 24 Mar 2023 15:54:11 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     srinivas.kandagatla@linaro.org
Cc:     linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH -next] nvmem: qfprom: Use devm_platform_get_and_ioremap_resource()
Date:   Fri, 24 Mar 2023 15:54:09 +0800
Message-Id: <20230324075409.80168-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.0 required=5.0 tests=ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to commit 890cc39a8799 ("drivers: provide
devm_platform_get_and_ioremap_resource()"), convert
platform_get_resource(), devm_ioremap_resource() to a single
call to devm_platform_get_and_ioremap_resource(), as this is exactly
what this function does.

Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/nvmem/qfprom.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/nvmem/qfprom.c b/drivers/nvmem/qfprom.c
index c1e893c8a247..cdeaa93e80db 100644
--- a/drivers/nvmem/qfprom.c
+++ b/drivers/nvmem/qfprom.c
@@ -374,8 +374,7 @@ static int qfprom_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	/* The corrected section is always provided */
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	priv->qfpcorrected = devm_ioremap_resource(dev, res);
+	priv->qfpcorrected = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
 	if (IS_ERR(priv->qfpcorrected))
 		return PTR_ERR(priv->qfpcorrected);
 
@@ -402,12 +401,10 @@ static int qfprom_probe(struct platform_device *pdev)
 		priv->qfpraw = devm_ioremap_resource(dev, res);
 		if (IS_ERR(priv->qfpraw))
 			return PTR_ERR(priv->qfpraw);
-		res = platform_get_resource(pdev, IORESOURCE_MEM, 2);
-		priv->qfpconf = devm_ioremap_resource(dev, res);
+		priv->qfpconf = devm_platform_get_and_ioremap_resource(pdev, 2, &res);
 		if (IS_ERR(priv->qfpconf))
 			return PTR_ERR(priv->qfpconf);
-		res = platform_get_resource(pdev, IORESOURCE_MEM, 3);
-		priv->qfpsecurity = devm_ioremap_resource(dev, res);
+		priv->qfpsecurity = devm_platform_get_and_ioremap_resource(pdev, 3, &res);
 		if (IS_ERR(priv->qfpsecurity))
 			return PTR_ERR(priv->qfpsecurity);
 
-- 
2.20.1.7.g153144c

