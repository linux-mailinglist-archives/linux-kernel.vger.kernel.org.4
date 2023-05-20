Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2CAB70A9F9
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 20:22:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231972AbjETSWo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 May 2023 14:22:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231949AbjETSWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 May 2023 14:22:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 063A4E7E;
        Sat, 20 May 2023 11:21:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C20AF60F1A;
        Sat, 20 May 2023 18:21:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38303C433EF;
        Sat, 20 May 2023 18:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684606917;
        bh=YidXSXZuVQGVC88iQewwQq9ZpUUZJBtypV01GQdCanc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ugaG6ZgyUdn+ITrCUqHkwsInqZDRgv5Dn1MvptHYmnB/H86jKhDK5U+28jT0eYGza
         pVgzeCAn6jqtqzsJAhRRcvXDrTFIXbvWLRyZWsCF7Ot8sMFA856AptGt1VhgXhR6a2
         t3ZZzSxMJbDdUT7GA8+aKuuGo7ROtRoyyG2HLXq89fwP/M6lhtcbgIrsMJDl4om0sQ
         +zc96ICxXfIZFertJ+CTpZ24ZlmLcXUUQr5tdV30iNuat4hN9Y2Ws2nHOTV11XGZFA
         94Jc2NXmpmZmo+aF7Msp3APh64ODwRdBBadNMiGkTcZkvo4bFj+k3J8lJEODS2+sdO
         6ZxNiua326PTg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Zheng Wang <zyytlz.wz@163.com>, Helge Deller <deller@gmx.de>,
        Sasha Levin <sashal@kernel.org>, javierm@redhat.com,
        tzimmermann@suse.de, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.1 10/14] fbdev: imsttfb: Fix use after free bug in imsttfb_probe
Date:   Sat, 20 May 2023 14:20:38 -0400
Message-Id: <20230520182044.836702-10-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230520182044.836702-1-sashal@kernel.org>
References: <20230520182044.836702-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zheng Wang <zyytlz.wz@163.com>

[ Upstream commit c75f5a55061091030a13fef71b9995b89bc86213 ]

A use-after-free bug may occur if init_imstt invokes framebuffer_release
and free the info ptr. The caller, imsttfb_probe didn't notice that and
still keep the ptr as private data in pdev.

If we remove the driver which will call imsttfb_remove to make cleanup,
UAF happens.

Fix it by return error code if bad case happens in init_imstt.

Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
Signed-off-by: Helge Deller <deller@gmx.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/video/fbdev/imsttfb.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/video/fbdev/imsttfb.c b/drivers/video/fbdev/imsttfb.c
index d7edb9c5d3a3f..e6adb2890ecfe 100644
--- a/drivers/video/fbdev/imsttfb.c
+++ b/drivers/video/fbdev/imsttfb.c
@@ -1347,7 +1347,7 @@ static const struct fb_ops imsttfb_ops = {
 	.fb_ioctl 	= imsttfb_ioctl,
 };
 
-static void init_imstt(struct fb_info *info)
+static int init_imstt(struct fb_info *info)
 {
 	struct imstt_par *par = info->par;
 	__u32 i, tmp, *ip, *end;
@@ -1420,7 +1420,7 @@ static void init_imstt(struct fb_info *info)
 	    || !(compute_imstt_regvals(par, info->var.xres, info->var.yres))) {
 		printk("imsttfb: %ux%ux%u not supported\n", info->var.xres, info->var.yres, info->var.bits_per_pixel);
 		framebuffer_release(info);
-		return;
+		return -ENODEV;
 	}
 
 	sprintf(info->fix.id, "IMS TT (%s)", par->ramdac == IBM ? "IBM" : "TVP");
@@ -1456,12 +1456,13 @@ static void init_imstt(struct fb_info *info)
 
 	if (register_framebuffer(info) < 0) {
 		framebuffer_release(info);
-		return;
+		return -ENODEV;
 	}
 
 	tmp = (read_reg_le32(par->dc_regs, SSTATUS) & 0x0f00) >> 8;
 	fb_info(info, "%s frame buffer; %uMB vram; chip version %u\n",
 		info->fix.id, info->fix.smem_len >> 20, tmp);
+	return 0;
 }
 
 static int imsttfb_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
@@ -1529,10 +1530,10 @@ static int imsttfb_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (!par->cmap_regs)
 		goto error;
 	info->pseudo_palette = par->palette;
-	init_imstt(info);
-
-	pci_set_drvdata(pdev, info);
-	return 0;
+	ret = init_imstt(info);
+	if (!ret)
+		pci_set_drvdata(pdev, info);
+	return ret;
 
 error:
 	if (par->dc_regs)
-- 
2.39.2

