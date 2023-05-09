Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D2426FC4FF
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 13:28:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235521AbjEIL2j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 07:28:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235429AbjEIL2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 07:28:37 -0400
Received: from hust.edu.cn (unknown [202.114.0.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B256E2D78;
        Tue,  9 May 2023 04:28:36 -0700 (PDT)
Received: from dd-virtual-machine.localdomain ([183.202.113.128])
        (user=u202112089@hust.edu.cn mech=LOGIN bits=0)
        by mx1.hust.edu.cn  with ESMTP id 349BRnLs027222-349BRnLt027222
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Tue, 9 May 2023 19:27:54 +0800
From:   Zongjie Li <u202112089@hust.edu.cn>
To:     Jaya Kumar <jayalk@intworks.biz>, Helge Deller <deller@gmx.de>,
        Andrew Morton <akpm@osdl.org>
Cc:     hust-os-kernel-patches@googlegroups.com,
        Zongjie Li <u202112089@hust.edu.cn>,
        Dongliang Mu <dzm91@hust.edu.cn>, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drivers: fbdev: arcfb: Fix error handling in arcfb_probe()
Date:   Tue,  9 May 2023 19:27:26 +0800
Message-Id: <20230509112727.3899-1-u202112089@hust.edu.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-FEAS-AUTH-USER: u202112089@hust.edu.cn
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Smatch complains that:
arcfb_probe() warn: 'irq' from request_irq() not released on lines: 587.

Fix error handling in the arcfb_probe() function. If IO addresses are 
not provided or framebuffer registration fails, the code will jump to 
the err_addr or err_register_fb label to release resources. 
If IRQ request fails, previously allocated resources will be freed.

Fixes: 1154ea7dcd8e ("[PATCH] Framebuffer driver for Arc LCD board")
Signed-off-by: Zongjie Li <u202112089@hust.edu.cn>
Reviewed-by: Dongliang Mu <dzm91@hust.edu.cn>
---
 drivers/video/fbdev/arcfb.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/video/fbdev/arcfb.c b/drivers/video/fbdev/arcfb.c
index 45e64016db32..024d0ee4f04f 100644
--- a/drivers/video/fbdev/arcfb.c
+++ b/drivers/video/fbdev/arcfb.c
@@ -523,7 +523,7 @@ static int arcfb_probe(struct platform_device *dev)
 
 	info = framebuffer_alloc(sizeof(struct arcfb_par), &dev->dev);
 	if (!info)
-		goto err;
+		goto err_fb_alloc;
 
 	info->screen_base = (char __iomem *)videomemory;
 	info->fbops = &arcfb_ops;
@@ -535,7 +535,7 @@ static int arcfb_probe(struct platform_device *dev)
 
 	if (!dio_addr || !cio_addr || !c2io_addr) {
 		printk(KERN_WARNING "no IO addresses supplied\n");
-		goto err1;
+		goto err_addr;
 	}
 	par->dio_addr = dio_addr;
 	par->cio_addr = cio_addr;
@@ -551,12 +551,12 @@ static int arcfb_probe(struct platform_device *dev)
 			printk(KERN_INFO
 				"arcfb: Failed req IRQ %d\n", par->irq);
 			retval = -EBUSY;
-			goto err1;
+			goto err_addr;
 		}
 	}
 	retval = register_framebuffer(info);
 	if (retval < 0)
-		goto err1;
+		goto err_register_fb;
 	platform_set_drvdata(dev, info);
 	fb_info(info, "Arc frame buffer device, using %dK of video memory\n",
 		videomemorysize >> 10);
@@ -580,9 +580,12 @@ static int arcfb_probe(struct platform_device *dev)
 	}
 
 	return 0;
-err1:
+
+err_register_fb:
+	free_irq(par->irq, info);
+err_addr:
 	framebuffer_release(info);
-err:
+err_fb_alloc:
 	vfree(videomemory);
 	return retval;
 }
-- 
2.25.1

