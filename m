Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA4766B8AAE
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 06:42:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbjCNFm1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 01:42:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbjCNFmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 01:42:25 -0400
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A9CC134;
        Mon, 13 Mar 2023 22:42:23 -0700 (PDT)
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0VdqljXD_1678772540)
          by smtp.aliyun-inc.com;
          Tue, 14 Mar 2023 13:42:21 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     deller@gmx.de
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH -next 1/3] video: fbdev: pxa3xx-gcu: Use devm_platform_get_and_ioremap_resource()
Date:   Tue, 14 Mar 2023 13:42:17 +0800
Message-Id: <20230314054219.80441-1-yang.lee@linux.alibaba.com>
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

According to commit 890cc39a8799 ("drivers: provide
devm_platform_get_and_ioremap_resource()"), convert
platform_get_resource(), devm_ioremap_resource() to a single
call to devm_platform_get_and_ioremap_resource(), as this is exactly
what this function does.

Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/video/fbdev/pxa3xx-gcu.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/pxa3xx-gcu.c b/drivers/video/fbdev/pxa3xx-gcu.c
index c3cd1e1cc01b..d16729215423 100644
--- a/drivers/video/fbdev/pxa3xx-gcu.c
+++ b/drivers/video/fbdev/pxa3xx-gcu.c
@@ -599,8 +599,7 @@ static int pxa3xx_gcu_probe(struct platform_device *pdev)
 	priv->misc_dev.fops	= &pxa3xx_gcu_miscdev_fops;
 
 	/* handle IO resources */
-	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	priv->mmio_base = devm_ioremap_resource(dev, r);
+	priv->mmio_base = devm_platform_get_and_ioremap_resource(pdev, 0, &r);
 	if (IS_ERR(priv->mmio_base))
 		return PTR_ERR(priv->mmio_base);
 
-- 
2.20.1.7.g153144c

