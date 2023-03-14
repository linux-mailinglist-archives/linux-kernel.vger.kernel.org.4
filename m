Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1C906B8C5C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 09:02:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230309AbjCNICk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 04:02:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbjCNICh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 04:02:37 -0400
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26E085941B
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 01:02:35 -0700 (PDT)
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0VdrL7AH_1678780952)
          by smtp.aliyun-inc.com;
          Tue, 14 Mar 2023 16:02:33 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     airlied@gmail.com
Cc:     daniel@ffwll.ch, liviu.dudau@arm.com, brian.starkey@arm.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH -next 2/2] drm/arm/hdlcd: Use devm_platform_ioremap_resource()
Date:   Tue, 14 Mar 2023 16:02:30 +0800
Message-Id: <20230314080231.20212-1-yang.lee@linux.alibaba.com>
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

Since 'struct platform_device *pdev = to_platform_device(drm->dev)',
'drm->dev' is equivalent to 'pdev->deva'.

Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/gpu/drm/arm/hdlcd_drv.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/arm/hdlcd_drv.c b/drivers/gpu/drm/arm/hdlcd_drv.c
index e3507dd6f82a..a86b317c1312 100644
--- a/drivers/gpu/drm/arm/hdlcd_drv.c
+++ b/drivers/gpu/drm/arm/hdlcd_drv.c
@@ -100,7 +100,6 @@ static int hdlcd_load(struct drm_device *drm, unsigned long flags)
 {
 	struct hdlcd_drm_private *hdlcd = drm_to_hdlcd_priv(drm);
 	struct platform_device *pdev = to_platform_device(drm->dev);
-	struct resource *res;
 	u32 version;
 	int ret;
 
@@ -115,8 +114,7 @@ static int hdlcd_load(struct drm_device *drm, unsigned long flags)
 	atomic_set(&hdlcd->dma_end_count, 0);
 #endif
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	hdlcd->mmio = devm_ioremap_resource(drm->dev, res);
+	hdlcd->mmio = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(hdlcd->mmio)) {
 		DRM_ERROR("failed to map control registers area\n");
 		ret = PTR_ERR(hdlcd->mmio);
-- 
2.20.1.7.g153144c

