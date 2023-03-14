Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E1286B8AE2
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 06:58:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbjCNF6e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 01:58:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjCNF6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 01:58:33 -0400
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06A7BDBCE;
        Mon, 13 Mar 2023 22:58:30 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0VdqmYya_1678773506;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0VdqmYya_1678773506)
          by smtp.aliyun-inc.com;
          Tue, 14 Mar 2023 13:58:27 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     mchehab@kernel.org
Cc:     eugen.hristev@collabora.com, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, claudiu.beznea@microchip.com,
        gregkh@linuxfoundation.org, linux-media@vger.kernel.org,
        linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH -next] media: atmel: atmel-isc: Use devm_platform_ioremap_resource()
Date:   Tue, 14 Mar 2023 13:58:26 +0800
Message-Id: <20230314055826.103682-1-yang.lee@linux.alibaba.com>
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

According to commit 7945f929f1a7 ("drivers: provide
devm_platform_ioremap_resource()"), convert platform_get_resource(),
devm_ioremap_resource() to a single call to Use
devm_platform_ioremap_resource(), as this is exactly what this function
does.

Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/staging/media/deprecated/atmel/atmel-sama5d2-isc.c | 4 +---
 drivers/staging/media/deprecated/atmel/atmel-sama7g5-isc.c | 4 +---
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/media/deprecated/atmel/atmel-sama5d2-isc.c b/drivers/staging/media/deprecated/atmel/atmel-sama5d2-isc.c
index ba0614f981a2..eebb336efce7 100644
--- a/drivers/staging/media/deprecated/atmel/atmel-sama5d2-isc.c
+++ b/drivers/staging/media/deprecated/atmel/atmel-sama5d2-isc.c
@@ -389,7 +389,6 @@ static int atmel_isc_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct isc_device *isc;
-	struct resource *res;
 	void __iomem *io_base;
 	struct isc_subdev_entity *subdev_entity;
 	int irq;
@@ -403,8 +402,7 @@ static int atmel_isc_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, isc);
 	isc->dev = dev;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	io_base = devm_ioremap_resource(dev, res);
+	io_base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(io_base))
 		return PTR_ERR(io_base);
 
diff --git a/drivers/staging/media/deprecated/atmel/atmel-sama7g5-isc.c b/drivers/staging/media/deprecated/atmel/atmel-sama7g5-isc.c
index 01ababdfcbd9..beed40fe3f91 100644
--- a/drivers/staging/media/deprecated/atmel/atmel-sama7g5-isc.c
+++ b/drivers/staging/media/deprecated/atmel/atmel-sama7g5-isc.c
@@ -378,7 +378,6 @@ static int microchip_xisc_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct isc_device *isc;
-	struct resource *res;
 	void __iomem *io_base;
 	struct isc_subdev_entity *subdev_entity;
 	int irq;
@@ -392,8 +391,7 @@ static int microchip_xisc_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, isc);
 	isc->dev = dev;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	io_base = devm_ioremap_resource(dev, res);
+	io_base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(io_base))
 		return PTR_ERR(io_base);
 
-- 
2.20.1.7.g153144c

