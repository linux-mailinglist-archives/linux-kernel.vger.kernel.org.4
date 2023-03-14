Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C36CB6B8AB0
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 06:42:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbjCNFm2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 01:42:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbjCNFm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 01:42:26 -0400
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E92976AA;
        Mon, 13 Mar 2023 22:42:25 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VdqmRdO_1678772542;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0VdqmRdO_1678772542)
          by smtp.aliyun-inc.com;
          Tue, 14 Mar 2023 13:42:23 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     deller@gmx.de
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH -next 2/3] video: fbdev: wm8505fb: Use devm_platform_ioremap_resource()
Date:   Tue, 14 Mar 2023 13:42:18 +0800
Message-Id: <20230314054219.80441-2-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
In-Reply-To: <20230314054219.80441-1-yang.lee@linux.alibaba.com>
References: <20230314054219.80441-1-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
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
 drivers/video/fbdev/wm8505fb.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/wm8505fb.c b/drivers/video/fbdev/wm8505fb.c
index 8f4d674fa0d0..96a6f7623e19 100644
--- a/drivers/video/fbdev/wm8505fb.c
+++ b/drivers/video/fbdev/wm8505fb.c
@@ -261,7 +261,6 @@ static const struct fb_ops wm8505fb_ops = {
 static int wm8505fb_probe(struct platform_device *pdev)
 {
 	struct wm8505fb_info	*fbi;
-	struct resource	*res;
 	struct display_timings *disp_timing;
 	void			*addr;
 	int ret;
@@ -299,8 +298,7 @@ static int wm8505fb_probe(struct platform_device *pdev)
 	addr = addr + sizeof(struct wm8505fb_info);
 	fbi->fb.pseudo_palette	= addr;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	fbi->regbase = devm_ioremap_resource(&pdev->dev, res);
+	fbi->regbase = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(fbi->regbase))
 		return PTR_ERR(fbi->regbase);
 
-- 
2.20.1.7.g153144c

