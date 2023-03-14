Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E166C6B8AB2
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 06:42:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230120AbjCNFma (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 01:42:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbjCNFm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 01:42:28 -0400
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31AAC76AA;
        Mon, 13 Mar 2023 22:42:27 -0700 (PDT)
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0VdqljY2_1678772543)
          by smtp.aliyun-inc.com;
          Tue, 14 Mar 2023 13:42:24 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     deller@gmx.de
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH -next 3/3] video: fbdev: xilinxfb: Use devm_platform_get_and_ioremap_resource()
Date:   Tue, 14 Mar 2023 13:42:19 +0800
Message-Id: <20230314054219.80441-3-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
In-Reply-To: <20230314054219.80441-1-yang.lee@linux.alibaba.com>
References: <20230314054219.80441-1-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
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
 drivers/video/fbdev/xilinxfb.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/xilinxfb.c b/drivers/video/fbdev/xilinxfb.c
index c17cfffd9a84..7911354827dc 100644
--- a/drivers/video/fbdev/xilinxfb.c
+++ b/drivers/video/fbdev/xilinxfb.c
@@ -273,8 +273,7 @@ static int xilinxfb_assign(struct platform_device *pdev,
 	if (drvdata->flags & BUS_ACCESS_FLAG) {
 		struct resource *res;
 
-		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-		drvdata->regs = devm_ioremap_resource(&pdev->dev, res);
+		drvdata->regs = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
 		if (IS_ERR(drvdata->regs))
 			return PTR_ERR(drvdata->regs);
 
-- 
2.20.1.7.g153144c

