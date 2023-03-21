Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EEA66C2E45
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 10:54:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbjCUJye (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 05:54:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjCUJyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 05:54:32 -0400
Received: from hust.edu.cn (unknown [202.114.0.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1A8C23126
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 02:54:29 -0700 (PDT)
Received: from liber-MS-7D42.. ([10.12.190.56])
        (user=gangecen@hust.edu.cn mech=LOGIN bits=0)
        by mx1.hust.edu.cn  with ESMTP id 32L9rEfp018165-32L9rEfq018165
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 21 Mar 2023 17:53:19 +0800
From:   Gencen Gan <gangecen@hust.edu.cn>
To:     Gerd Hoffmann <kraxel@redhat.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Gan Gecen <gangecen@hust.edu.cn>, Dongliang Mu <dzm91@hust.edu.cn>,
        virtualization@lists.linux-foundation.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/bochs: replace ioremap with devm_ioremap to avoid immo leak
Date:   Tue, 21 Mar 2023 17:52:16 +0800
Message-Id: <20230321095216.1306555-1-gangecen@hust.edu.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-FEAS-AUTH-USER: gangecen@hust.edu.cn
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
bochs->immo won't be freed.

We would prefer to replace ioremap with devm_ioremap
to avoid adding lengthy error handling. The function 
`devm_ioremap` will automatically release the allocated
resources after use.

Signed-off-by: Gan Gecen <gangecen@hust.edu.cn>
Reviewed-by: Dongliang Mu <dzm91@hust.edu.cn>
---
 drivers/gpu/drm/tiny/bochs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tiny/bochs.c b/drivers/gpu/drm/tiny/bochs.c
index 024346054c70..0d7e119a732f 100644
--- a/drivers/gpu/drm/tiny/bochs.c
+++ b/drivers/gpu/drm/tiny/bochs.c
@@ -223,7 +223,7 @@ static int bochs_hw_init(struct drm_device *dev)
 		}
 		ioaddr = pci_resource_start(pdev, 2);
 		iosize = pci_resource_len(pdev, 2);
-		bochs->mmio = ioremap(ioaddr, iosize);
+		bochs->mmio = devm_ioremap(&pdev->dev, ioaddr, iosize);
 		if (bochs->mmio == NULL) {
 			DRM_ERROR("Cannot map mmio region\n");
 			return -ENOMEM;
-- 
2.34.1

