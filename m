Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 318D16F119D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 08:09:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345349AbjD1GJr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 02:09:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjD1GJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 02:09:45 -0400
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5732D2737;
        Thu, 27 Apr 2023 23:09:43 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VhAHMxk_1682662179;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0VhAHMxk_1682662179)
          by smtp.aliyun-inc.com;
          Fri, 28 Apr 2023 14:09:40 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     linusw@kernel.org
Cc:     kaloz@openwrt.org, khalasa@piap.pl, brgl@bgdev.pl,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH -next] gpio: ixp4xx: Use devm_platform_ioremap_resource()
Date:   Fri, 28 Apr 2023 14:09:38 +0800
Message-Id: <20230428060938.98198-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert platform_get_resource(),devm_ioremap_resource() to a single
call to devm_platform_ioremap_resource(), as this is exactly what this
function does.

Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/gpio/gpio-ixp4xx.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpio/gpio-ixp4xx.c b/drivers/gpio/gpio-ixp4xx.c
index 56656fb519f8..1e29de1671d4 100644
--- a/drivers/gpio/gpio-ixp4xx.c
+++ b/drivers/gpio/gpio-ixp4xx.c
@@ -199,7 +199,6 @@ static int ixp4xx_gpio_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev->of_node;
 	struct irq_domain *parent;
-	struct resource *res;
 	struct ixp4xx_gpio *g;
 	struct gpio_irq_chip *girq;
 	struct device_node *irq_parent;
@@ -210,8 +209,7 @@ static int ixp4xx_gpio_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	g->dev = dev;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	g->base = devm_ioremap_resource(dev, res);
+	g->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(g->base))
 		return PTR_ERR(g->base);
 
-- 
2.20.1.7.g153144c

