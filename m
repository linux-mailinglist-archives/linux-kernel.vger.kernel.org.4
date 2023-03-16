Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C18E46BC644
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 07:46:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbjCPGqU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 02:46:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbjCPGqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 02:46:15 -0400
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D299F7EDB
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 23:46:12 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R831e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0Vdz.xIg_1678949168;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0Vdz.xIg_1678949168)
          by smtp.aliyun-inc.com;
          Thu, 16 Mar 2023 14:46:09 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     srinivas.kandagatla@linaro.org
Cc:     linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH -next 2/2] nvmem: nintendo-otp: Use devm_platform_ioremap_resource()
Date:   Thu, 16 Mar 2023 14:46:06 +0800
Message-Id: <20230316064606.67858-2-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
In-Reply-To: <20230316064606.67858-1-yang.lee@linux.alibaba.com>
References: <20230316064606.67858-1-yang.lee@linux.alibaba.com>
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

According to commit 7945f929f1a7 ("drivers: provide
devm_platform_ioremap_resource()"), convert platform_get_resource(),
devm_ioremap_resource() to a single call to use
devm_platform_ioremap_resource(), as this is exactly what this function
does.

Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/nvmem/nintendo-otp.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/nvmem/nintendo-otp.c b/drivers/nvmem/nintendo-otp.c
index 33961b17f9f1..355e7f1fc6d5 100644
--- a/drivers/nvmem/nintendo-otp.c
+++ b/drivers/nvmem/nintendo-otp.c
@@ -76,7 +76,6 @@ static int nintendo_otp_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	const struct of_device_id *of_id =
 		of_match_device(nintendo_otp_of_table, dev);
-	struct resource *res;
 	struct nvmem_device *nvmem;
 	struct nintendo_otp_priv *priv;
 
@@ -92,8 +91,7 @@ static int nintendo_otp_probe(struct platform_device *pdev)
 	if (!priv)
 		return -ENOMEM;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	priv->regs = devm_ioremap_resource(dev, res);
+	priv->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(priv->regs))
 		return PTR_ERR(priv->regs);
 
-- 
2.20.1.7.g153144c

