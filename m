Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9EE06C307F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 12:36:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbjCULgX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 07:36:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbjCULgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 07:36:21 -0400
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1E9748E1E
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 04:36:18 -0700 (PDT)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4PgqLS3w08z6FK2R;
        Tue, 21 Mar 2023 19:36:16 +0800 (CST)
Received: from xaxapp03.zte.com.cn ([10.88.97.17])
        by mse-fl1.zte.com.cn with SMTP id 32LBa860083657;
        Tue, 21 Mar 2023 19:36:08 +0800 (+08)
        (envelope-from ye.xingchen@zte.com.cn)
Received: from mapi (xaxapp02[null])
        by mapi (Zmail) with MAPI id mid31;
        Tue, 21 Mar 2023 19:36:11 +0800 (CST)
Date:   Tue, 21 Mar 2023 19:36:11 +0800 (CST)
X-Zmail-TransId: 2afa641996ab7b8-d8e42
X-Mailer: Zmail v1.0
Message-ID: <202303211936116261105@zte.com.cn>
Mime-Version: 1.0
From:   <ye.xingchen@zte.com.cn>
To:     <tomba@kernel.org>
Cc:     <airlied@gmail.com>, <daniel@ffwll.ch>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIXSBkcm06IG9tYXBkcm06IHVzZSBkZXZtX3BsYXRmb3JtX2lvcmVtYXBfcmVzb3VyY2VfYnluYW1lKCk=?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 32LBa860083657
X-Fangmail-Gw-Spam-Type: 0
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 641996B0.000/4PgqLS3w08z6FK2R
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ye Xingchen <ye.xingchen@zte.com.cn>

Convert platform_get_resource_byname(),devm_ioremap_resource() to a single
call to devm_platform_ioremap_resource_byname(), as this is exactly what
this function does.

Signed-off-by: Ye Xingchen <ye.xingchen@zte.com.cn>
---
 drivers/gpu/drm/omapdrm/dss/hdmi_wp.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/omapdrm/dss/hdmi_wp.c b/drivers/gpu/drm/omapdrm/dss/hdmi_wp.c
index 9d830584a762..77a7aa797ad0 100644
--- a/drivers/gpu/drm/omapdrm/dss/hdmi_wp.c
+++ b/drivers/gpu/drm/omapdrm/dss/hdmi_wp.c
@@ -280,8 +280,7 @@ int hdmi_wp_init(struct platform_device *pdev, struct hdmi_wp_data *wp,
 {
 	struct resource *res;

-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "wp");
-	wp->base = devm_ioremap_resource(&pdev->dev, res);
+	wp->base = devm_platform_ioremap_resource_byname(pdev, "wp");
 	if (IS_ERR(wp->base))
 		return PTR_ERR(wp->base);

-- 
2.25.1
