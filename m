Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14F61741272
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 15:32:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232168AbjF1N3q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 09:29:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231571AbjF1N2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 09:28:37 -0400
X-Greylist: delayed 109 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 28 Jun 2023 06:28:35 PDT
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5721294E;
        Wed, 28 Jun 2023 06:28:35 -0700 (PDT)
Received: from dslb-178-004-201-159.178.004.pools.vodafone-ip.de ([178.4.201.159] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1qEVDl-00033Q-Gw; Wed, 28 Jun 2023 15:28:33 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Helge Deller <deller@gmx.de>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-fbdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH] fbdev: imxfb: switch to DEFINE_SIMPLE_DEV_PM_OPS
Date:   Wed, 28 Jun 2023 15:26:52 +0200
Message-Id: <20230628132652.87202-1-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SIMPLE_DEV_PM_OPS is deprecated, replace it with DEFINE_SIMPLE_DEV_PM_OPS
and use pm_sleep_ptr for setting the driver's pm routines. We can now
remove the __maybe_unused qualifier in the suspend and resume functions.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/video/fbdev/imxfb.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/video/fbdev/imxfb.c b/drivers/video/fbdev/imxfb.c
index 5fbcb78a9cae..04f3bf30a529 100644
--- a/drivers/video/fbdev/imxfb.c
+++ b/drivers/video/fbdev/imxfb.c
@@ -1066,7 +1066,7 @@ static void imxfb_remove(struct platform_device *pdev)
 	framebuffer_release(info);
 }
 
-static int __maybe_unused imxfb_suspend(struct device *dev)
+static int imxfb_suspend(struct device *dev)
 {
 	struct fb_info *info = dev_get_drvdata(dev);
 	struct imxfb_info *fbi = info->par;
@@ -1076,7 +1076,7 @@ static int __maybe_unused imxfb_suspend(struct device *dev)
 	return 0;
 }
 
-static int __maybe_unused imxfb_resume(struct device *dev)
+static int imxfb_resume(struct device *dev)
 {
 	struct fb_info *info = dev_get_drvdata(dev);
 	struct imxfb_info *fbi = info->par;
@@ -1086,13 +1086,13 @@ static int __maybe_unused imxfb_resume(struct device *dev)
 	return 0;
 }
 
-static SIMPLE_DEV_PM_OPS(imxfb_pm_ops, imxfb_suspend, imxfb_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(imxfb_pm_ops, imxfb_suspend, imxfb_resume);
 
 static struct platform_driver imxfb_driver = {
 	.driver		= {
 		.name	= DRIVER_NAME,
 		.of_match_table = imxfb_of_dev_id,
-		.pm	= &imxfb_pm_ops,
+		.pm	= pm_sleep_ptr(&imxfb_pm_ops),
 	},
 	.probe		= imxfb_probe,
 	.remove_new	= imxfb_remove,
-- 
2.30.2

