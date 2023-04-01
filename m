Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E55C6D3343
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 20:57:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbjDAS5e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Apr 2023 14:57:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbjDAS5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Apr 2023 14:57:32 -0400
Received: from hust.edu.cn (mail.hust.edu.cn [202.114.0.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A439B766
        for <linux-kernel@vger.kernel.org>; Sat,  1 Apr 2023 11:57:31 -0700 (PDT)
Received: from liber-MS-7D42.. ([10.12.190.56])
        (user=gangecen@hust.edu.cn mech=LOGIN bits=0)
        by mx1.hust.edu.cn  with ESMTP id 331ItuHl030779-331ItuHm030779
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 2 Apr 2023 02:56:01 +0800
From:   Gencen Gan <gangecen@hust.edu.cn>
To:     Gerd Hoffmann <kraxel@redhat.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Gan Gecen <gangecen@hust.edu.cn>,
        virtualization@lists.linux-foundation.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] drm/bochs: fix ioremap leak of mmio in bochs
Date:   Sun,  2 Apr 2023 02:55:43 +0800
Message-Id: <20230401185544.3027703-1-gangecen@hust.edu.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-FEAS-AUTH-USER: gangecen@hust.edu.cn
X-Spam-Status: No, score=-0.0 required=5.0 tests=SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gan Gecen <gangecen@hust.edu.cn>

Smatch reports:

	drivers/gpu/drm/tiny/bochs.c:290 bochs_hw_init()
	warn: 'bochs->mmio' from ioremap() not released on
	lines: 246,250,254.

In the function bochs_load() that calls bochs_hw_init()
only, if bochs_hw_init(dev) returns -ENODEV(-19), it
will jumps to err_free_dev instead of err_hw_fini, so
bochs->mmio won't be freed.

We just need to release mmio in the corresponding error
handling.

Signed-off-by: Gan Gecen <gangecen@hust.edu.cn>
---
v1->v2: Change the strategy for fixing this
issue to manually release mmio by iounmap 
instead of changing ioremap to devm_ioremap.
 drivers/gpu/drm/tiny/bochs.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/tiny/bochs.c b/drivers/gpu/drm/tiny/bochs.c
index 024346054c70..46abed11c163 100644
--- a/drivers/gpu/drm/tiny/bochs.c
+++ b/drivers/gpu/drm/tiny/bochs.c
@@ -243,15 +243,20 @@ static int bochs_hw_init(struct drm_device *dev)
 		* 64 * 1024;
 	if ((id & 0xfff0) != VBE_DISPI_ID0) {
 		DRM_ERROR("ID mismatch\n");
+		iounmap(bochs->mmio);
 		return -ENODEV;
 	}
 
-	if ((pdev->resource[0].flags & IORESOURCE_MEM) == 0)
+	if ((pdev->resource[0].flags & IORESOURCE_MEM) == 0) {
+		iounmap(bochs->mmio);
 		return -ENODEV;
+	}
 	addr = pci_resource_start(pdev, 0);
 	size = pci_resource_len(pdev, 0);
-	if (addr == 0)
+	if (addr == 0) {
+		iounmap(bochs->mmio);
 		return -ENODEV;
+	}
 	if (size != mem) {
 		DRM_ERROR("Size mismatch: pci=%ld, bochs=%ld\n",
 			size, mem);
-- 
2.34.1

