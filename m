Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC2EA5E5831
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 03:41:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230525AbiIVBlG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 21:41:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231179AbiIVBk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 21:40:59 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85C67AB079;
        Wed, 21 Sep 2022 18:40:57 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MXybL1CvzzpTgW;
        Thu, 22 Sep 2022 09:38:06 +0800 (CST)
Received: from huawei.com (10.67.175.83) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 22 Sep
 2022 09:40:55 +0800
From:   ruanjinjie <ruanjinjie@huawei.com>
To:     <deller@gmx.de>, <zheyuma97@gmail.com>, <javierm@redhat.com>,
        <wsa+renesas@sang-engineering.com>, <tzimmermann@suse.de>,
        <linux-fbdev@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>
CC:     <ruanjinjie@huawei.com>
Subject: [PATCH -next] video: fbdev: tridentfb: Fix missing pci_disable_device() in probe and remove
Date:   Thu, 22 Sep 2022 09:37:09 +0800
Message-ID: <20220922013709.3324521-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.175.83]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace pci_enable_device() with pcim_enable_device(),
pci_disable_device() and pci_release_regions() will be
called in release automatically.

Signed-off-by: ruanjinjie <ruanjinjie@huawei.com>
---
 drivers/video/fbdev/tridentfb.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/video/fbdev/tridentfb.c b/drivers/video/fbdev/tridentfb.c
index f9c3b1d38fc2..7933e01aacc5 100644
--- a/drivers/video/fbdev/tridentfb.c
+++ b/drivers/video/fbdev/tridentfb.c
@@ -1475,7 +1475,7 @@ static int trident_pci_probe(struct pci_dev *dev,
 	if (err)
 		return err;
 
-	err = pci_enable_device(dev);
+	err = pcim_enable_device(dev);
 	if (err)
 		return err;
 
@@ -1715,12 +1715,10 @@ static int trident_pci_probe(struct pci_dev *dev,
 	kfree(info->pixmap.addr);
 	if (info->screen_base)
 		iounmap(info->screen_base);
-	release_mem_region(tridentfb_fix.smem_start, tridentfb_fix.smem_len);
 	disable_mmio(info->par);
 out_unmap1:
 	if (default_par->io_virt)
 		iounmap(default_par->io_virt);
-	release_mem_region(tridentfb_fix.mmio_start, tridentfb_fix.mmio_len);
 	framebuffer_release(info);
 	return err;
 }
@@ -1735,8 +1733,6 @@ static void trident_pci_remove(struct pci_dev *dev)
 		i2c_del_adapter(&par->ddc_adapter);
 	iounmap(par->io_virt);
 	iounmap(info->screen_base);
-	release_mem_region(tridentfb_fix.smem_start, tridentfb_fix.smem_len);
-	release_mem_region(tridentfb_fix.mmio_start, tridentfb_fix.mmio_len);
 	kfree(info->pixmap.addr);
 	fb_dealloc_cmap(&info->cmap);
 	framebuffer_release(info);
-- 
2.25.1

