Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E5356B8C5D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 09:02:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbjCNICm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 04:02:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230287AbjCNICj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 04:02:39 -0400
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 299ED58C33
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 01:02:37 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VdrLTsb_1678780954;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0VdrLTsb_1678780954)
          by smtp.aliyun-inc.com;
          Tue, 14 Mar 2023 16:02:35 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     airlied@gmail.com
Cc:     daniel@ffwll.ch, liviu.dudau@arm.com, brian.starkey@arm.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH -next 1/2] drm/arm/malidp: Use devm_platform_get_and_ioremap_resource()
Date:   Tue, 14 Mar 2023 16:02:31 +0800
Message-Id: <20230314080231.20212-2-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
In-Reply-To: <20230314080231.20212-1-yang.lee@linux.alibaba.com>
References: <20230314080231.20212-1-yang.lee@linux.alibaba.com>
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

Since 'struct platform_device *pdev = to_platform_device(dev)',
'pdev->dev' is equivalent to 'dev'.

Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/gpu/drm/arm/malidp_drv.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/arm/malidp_drv.c b/drivers/gpu/drm/arm/malidp_drv.c
index cf040e2e9efe..e220bfc85b2e 100644
--- a/drivers/gpu/drm/arm/malidp_drv.c
+++ b/drivers/gpu/drm/arm/malidp_drv.c
@@ -724,8 +724,7 @@ static int malidp_bind(struct device *dev)
 	hwdev->hw = (struct malidp_hw *)of_device_get_match_data(dev);
 	malidp->dev = hwdev;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	hwdev->regs = devm_ioremap_resource(dev, res);
+	hwdev->regs = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
 	if (IS_ERR(hwdev->regs))
 		return PTR_ERR(hwdev->regs);
 
-- 
2.20.1.7.g153144c

