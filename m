Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E72263C844
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 20:24:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236839AbiK2TYU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 14:24:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236819AbiK2TYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 14:24:03 -0500
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E73D973BB9
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 11:21:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1669749649; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oLUKcEnShwNV7IAkx5+nlu/qzKUV03wm4WmwUoc45xY=;
        b=bp4LM/hnTnmmZksYmDtegnSOp+dpDcQqJ7cYWG0d53Kykd6HAnVsZIBEFE0th67GKJ4zgN
        1nk6AqSG6KFjCyww5de73wVkrFyIrEybywgwbMu6j1rRiGnyDoZKOWNmN749GNqib70kx9
        bxa4LwAoIGwlZEerL81uQJ6k549mQMw=
From:   Paul Cercueil <paul@crapouillou.net>
To:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>,
        Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v2 22/26] drm: vboxvideo: Remove #ifdef guards for PM related functions
Date:   Tue, 29 Nov 2022 19:19:38 +0000
Message-Id: <20221129191942.138244-9-paul@crapouillou.net>
In-Reply-To: <20221129191942.138244-1-paul@crapouillou.net>
References: <20221129191733.137897-1-paul@crapouillou.net>
 <20221129191942.138244-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the pm_sleep_ptr() macro to handle the .suspend / .resume callbacks.

This macro allows the suspend and resume functions to be automatically
dropped by the compiler when CONFIG_SUSPEND is disabled, without having
to use #ifdef guards.

This has the advantage of always compiling these functions in,
independently of any Kconfig option. Thanks to that, bugs and other
regressions are subsequently easier to catch.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
---
Cc: Hans de Goede <hdegoede@redhat.com>
---
 drivers/gpu/drm/vboxvideo/vbox_drv.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/vboxvideo/vbox_drv.c b/drivers/gpu/drm/vboxvideo/vbox_drv.c
index b450f449a3ab..12fee99dbfe8 100644
--- a/drivers/gpu/drm/vboxvideo/vbox_drv.c
+++ b/drivers/gpu/drm/vboxvideo/vbox_drv.c
@@ -102,7 +102,6 @@ static void vbox_pci_remove(struct pci_dev *pdev)
 	vbox_hw_fini(vbox);
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int vbox_pm_suspend(struct device *dev)
 {
 	struct vbox_private *vbox = dev_get_drvdata(dev);
@@ -160,16 +159,13 @@ static const struct dev_pm_ops vbox_pm_ops = {
 	.poweroff = vbox_pm_poweroff,
 	.restore = vbox_pm_resume,
 };
-#endif
 
 static struct pci_driver vbox_pci_driver = {
 	.name = DRIVER_NAME,
 	.id_table = pciidlist,
 	.probe = vbox_pci_probe,
 	.remove = vbox_pci_remove,
-#ifdef CONFIG_PM_SLEEP
-	.driver.pm = &vbox_pm_ops,
-#endif
+	.driver.pm = pm_sleep_ptr(&vbox_pm_ops),
 };
 
 DEFINE_DRM_GEM_FOPS(vbox_fops);
-- 
2.35.1

