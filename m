Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E976F70A998
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 20:18:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbjETSR6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 May 2023 14:17:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjETSR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 May 2023 14:17:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0E8F107;
        Sat, 20 May 2023 11:17:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 34E2D60AE1;
        Sat, 20 May 2023 18:17:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6BA7C433EF;
        Sat, 20 May 2023 18:17:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684606673;
        bh=XkrStt+XTSNlIOWptd0KbvocsSnYfjWumDVc6JiRCAU=;
        h=From:To:Cc:Subject:Date:From;
        b=Nci20z23QjxYN5NeYOHiU7tzC7Ehva2LGNmk3BSw8Ou0htcLl2+UOGu7p7DGcsn86
         uboU7tCy9APxBWc9H9IkPhSo5qAXtOs2xXHc2TDlqc80HAhsYUjoiNM6nX9s3tdy8m
         T/y08eQe+uGgKkgmWah9lzQnU79UT8lqZ/F6uRJQ2774LQQe6+16WyClkvTDJQcrf0
         VRie6c+gR/K8gDUi8y6dPDjNEcGSqMzT6HyoGr90f9GAE2DNRD6Be5wsMP/3jf81To
         I9TQbJqInz/jYpdsIJiBNlHp4pOs89KtCIut7nIU0yBHCy2ymsBqbV59PGw9G3XXdn
         0Sk+v5PwvOaug==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jammy Huang <jammy_huang@aspeedtech.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Sasha Levin <sashal@kernel.org>, airlied@redhat.com,
        airlied@gmail.com, daniel@ffwll.ch, dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.3 01/18] drm/ast: Fix ARM compatibility
Date:   Sat, 20 May 2023 14:17:33 -0400
Message-Id: <20230520181750.823365-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jammy Huang <jammy_huang@aspeedtech.com>

[ Upstream commit 4327a6137ed43a091d900b1ac833345d60f32228 ]

ARM architecture only has 'memory', so all devices are accessed by
MMIO if possible.

Signed-off-by: Jammy Huang <jammy_huang@aspeedtech.com>
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Link: https://patchwork.freedesktop.org/patch/msgid/20230421003354.27767-1-jammy_huang@aspeedtech.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/ast/ast_main.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/ast/ast_main.c b/drivers/gpu/drm/ast/ast_main.c
index f83ce77127cb4..a6d0ee4da2b88 100644
--- a/drivers/gpu/drm/ast/ast_main.c
+++ b/drivers/gpu/drm/ast/ast_main.c
@@ -425,11 +425,12 @@ struct ast_private *ast_device_create(const struct drm_driver *drv,
 		return ERR_PTR(-EIO);
 
 	/*
-	 * If we don't have IO space at all, use MMIO now and
-	 * assume the chip has MMIO enabled by default (rev 0x20
-	 * and higher).
+	 * After AST2500, MMIO is enabled by default, and it should be adopted
+	 * to be compatible with Arm.
 	 */
-	if (!(pci_resource_flags(pdev, 2) & IORESOURCE_IO)) {
+	if (pdev->revision >= 0x40) {
+		ast->ioregs = ast->regs + AST_IO_MM_OFFSET;
+	} else if (!(pci_resource_flags(pdev, 2) & IORESOURCE_IO)) {
 		drm_info(dev, "platform has no IO space, trying MMIO\n");
 		ast->ioregs = ast->regs + AST_IO_MM_OFFSET;
 	}
-- 
2.39.2

