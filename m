Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D29D16C7866
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 08:05:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbjCXHFG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 03:05:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjCXHFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 03:05:04 -0400
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42863133
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 00:05:02 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VeWmRtS_1679641498;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0VeWmRtS_1679641498)
          by smtp.aliyun-inc.com;
          Fri, 24 Mar 2023 15:04:58 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     srinivas.kandagatla@linaro.org
Cc:     wens@csie.org, jernej.skrabec@gmail.com, samuel@sholland.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH -next] nvmem: sunxi_sid: Use devm_platform_ioremap_resource()
Date:   Fri, 24 Mar 2023 15:04:49 +0800
Message-Id: <20230324070449.8182-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.0 required=5.0 tests=ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
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
 drivers/nvmem/sunxi_sid.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/nvmem/sunxi_sid.c b/drivers/nvmem/sunxi_sid.c
index a970f1741cc6..6bfe02ab169a 100644
--- a/drivers/nvmem/sunxi_sid.c
+++ b/drivers/nvmem/sunxi_sid.c
@@ -125,7 +125,6 @@ static int sun8i_sid_read_by_reg(void *context, unsigned int offset,
 static int sunxi_sid_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	struct resource *res;
 	struct nvmem_config *nvmem_cfg;
 	struct nvmem_device *nvmem;
 	struct sunxi_sid *sid;
@@ -142,8 +141,7 @@ static int sunxi_sid_probe(struct platform_device *pdev)
 		return -EINVAL;
 	sid->value_offset = cfg->value_offset;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	sid->base = devm_ioremap_resource(dev, res);
+	sid->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(sid->base))
 		return PTR_ERR(sid->base);
 
-- 
2.20.1.7.g153144c

