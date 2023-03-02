Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 932886A796D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 03:19:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbjCBCTw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 21:19:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjCBCTu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 21:19:50 -0500
Received: from twspam01.aspeedtech.com (twspam01.aspeedtech.com [211.20.114.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2087C22794
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 18:19:44 -0800 (PST)
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 32225huK008905;
        Thu, 2 Mar 2023 10:05:43 +0800 (GMT-8)
        (envelope-from jammy_huang@aspeedtech.com)
Received: from JammyHuang-PC.aspeed.com (192.168.2.115) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 2 Mar
 2023 10:19:08 +0800
From:   Jammy Huang <jammy_huang@aspeedtech.com>
To:     <airlied@redhat.com>, <tzimmermann@suse.de>, <airlied@gmail.com>,
        <daniel@ffwll.ch>
CC:     <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] drm/ast: Fix ARM compatibility
Date:   Thu, 2 Mar 2023 10:19:05 +0800
Message-ID: <20230302021905.2777-1-jammy_huang@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [192.168.2.115]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com 32225huK008905
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ARM architecture only has 'memory', so all devices are accessed by MMIO.

Signed-off-by: Jammy Huang <jammy_huang@aspeedtech.com>
---
 drivers/gpu/drm/ast/ast_main.c | 17 +----------------
 1 file changed, 1 insertion(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/ast/ast_main.c b/drivers/gpu/drm/ast/ast_main.c
index 794ffd4a29c5..f86d01e9f024 100644
--- a/drivers/gpu/drm/ast/ast_main.c
+++ b/drivers/gpu/drm/ast/ast_main.c
@@ -424,22 +424,7 @@ struct ast_device *ast_device_create(const struct drm_driver *drv,
 	if (!ast->regs)
 		return ERR_PTR(-EIO);
 
-	/*
-	 * If we don't have IO space at all, use MMIO now and
-	 * assume the chip has MMIO enabled by default (rev 0x20
-	 * and higher).
-	 */
-	if (!(pci_resource_flags(pdev, 2) & IORESOURCE_IO)) {
-		drm_info(dev, "platform has no IO space, trying MMIO\n");
-		ast->ioregs = ast->regs + AST_IO_MM_OFFSET;
-	}
-
-	/* "map" IO regs if the above hasn't done so already */
-	if (!ast->ioregs) {
-		ast->ioregs = pcim_iomap(pdev, 2, 0);
-		if (!ast->ioregs)
-			return ERR_PTR(-EIO);
-	}
+	ast->ioregs = ast->regs + AST_IO_MM_OFFSET;
 
 	ast_detect_chip(dev, &need_post);
 

base-commit: 254986e324add8a30d0019c6da59f81adc8b565f
-- 
2.25.1

