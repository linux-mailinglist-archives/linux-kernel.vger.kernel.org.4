Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCAF16D5588
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 02:28:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231906AbjDDA2K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 20:28:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230263AbjDDA2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 20:28:07 -0400
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.215])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 011D7213F
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 17:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=dkwlJ
        rv/HwXOkWnbktnPm5QOg/s8D7WVohsVnr4l+Xg=; b=ZoMXU/ESqwVV5EXmWxmyC
        cIGeTFBe5OnOkQ8fqZM0Vz20Ubia7geC8A2pbp3VVYjr1DXAMn6EZIPWANVJBn1Y
        ONxtXmNpJMF8Od+qXWiUBmdhK3NpYlfqDV3g7OfPea3foyeM8kaag6smqAvJsT5x
        LEIb//a2WrUPpHZqgYWLg0=
Received: from yuq-Aspire-4738G.lan (unknown [116.225.76.16])
        by zwqz-smtp-mta-g3-0 (Coremail) with SMTP id _____wBHK4Tkbitk8woAAg--.8076S4;
        Tue, 04 Apr 2023 08:27:25 +0800 (CST)
From:   yq882255@163.com
To:     dri-devel@lists.freedesktop.org
Cc:     Erico Nunes <nunes.erico@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, lima@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Qiang Yu <yuq825@gmail.com>
Subject: [PATCH 2/3] Revert "drm/lima: allocate unique id per drm_file"
Date:   Tue,  4 Apr 2023 08:26:00 +0800
Message-Id: <20230404002601.24136-3-yq882255@163.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230404002601.24136-1-yq882255@163.com>
References: <20230404002601.24136-1-yq882255@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wBHK4Tkbitk8woAAg--.8076S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxWr48Zr47JF4fJw4Utw1UJrb_yoW5Cr4UpF
        s8AFW2yrW8JF42g34DAa4DZF1Yy3WDtayfuw1UGwna9rn0yryjgas5tryUZFy5tryxC3Wf
        tw4DGFy8ZF12kw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jTeHDUUUUU=
X-Originating-IP: [116.225.76.16]
X-CM-SenderInfo: d1tymjqsvvqiywtou0bp/1tbiGBJHGlv2lhcz+QAAsx
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qiang Yu <yuq825@gmail.com>

This reverts commit 87767de835edf527b879a363d518c33da68adb81.

This is due to the depend commit has been reverted on upstream:
baad10973fdb ("Revert "drm/scheduler: track GPU active time per entity"")

Signed-off-by: Qiang Yu <yuq825@gmail.com>
---
 drivers/gpu/drm/lima/lima_device.h |  3 ---
 drivers/gpu/drm/lima/lima_drv.c    | 12 ------------
 drivers/gpu/drm/lima/lima_drv.h    |  1 -
 3 files changed, 16 deletions(-)

diff --git a/drivers/gpu/drm/lima/lima_device.h b/drivers/gpu/drm/lima/lima_device.h
index 71b2db60d161..41b9d7b4bcc7 100644
--- a/drivers/gpu/drm/lima/lima_device.h
+++ b/drivers/gpu/drm/lima/lima_device.h
@@ -106,9 +106,6 @@ struct lima_device {
 	struct lima_dump_head dump;
 	struct list_head error_task_list;
 	struct mutex error_task_list_lock;
-
-	struct xarray active_contexts;
-	u32 next_context_id;
 };
 
 static inline struct lima_device *
diff --git a/drivers/gpu/drm/lima/lima_drv.c b/drivers/gpu/drm/lima/lima_drv.c
index f456a471216b..39cab4a55f57 100644
--- a/drivers/gpu/drm/lima/lima_drv.c
+++ b/drivers/gpu/drm/lima/lima_drv.c
@@ -218,11 +218,6 @@ static int lima_drm_driver_open(struct drm_device *dev, struct drm_file *file)
 	if (!priv)
 		return -ENOMEM;
 
-	err = xa_alloc_cyclic(&ldev->active_contexts, &priv->id, priv,
-			      xa_limit_32b, &ldev->next_context_id, GFP_KERNEL);
-	if (err < 0)
-		goto err_out0;
-
 	priv->vm = lima_vm_create(ldev);
 	if (!priv->vm) {
 		err = -ENOMEM;
@@ -242,9 +237,6 @@ static int lima_drm_driver_open(struct drm_device *dev, struct drm_file *file)
 static void lima_drm_driver_postclose(struct drm_device *dev, struct drm_file *file)
 {
 	struct lima_drm_priv *priv = file->driver_priv;
-	struct lima_device *ldev = to_lima_dev(dev);
-
-	xa_erase(&ldev->active_contexts, priv->id);
 
 	lima_ctx_mgr_fini(&priv->ctx_mgr);
 	lima_vm_put(priv->vm);
@@ -396,8 +388,6 @@ static int lima_pdev_probe(struct platform_device *pdev)
 	ldev->dev = &pdev->dev;
 	ldev->id = (enum lima_gpu_id)of_device_get_match_data(&pdev->dev);
 
-	xa_init_flags(&ldev->active_contexts, XA_FLAGS_ALLOC);
-
 	platform_set_drvdata(pdev, ldev);
 
 	/* Allocate and initialize the DRM device. */
@@ -456,8 +446,6 @@ static int lima_pdev_remove(struct platform_device *pdev)
 	struct lima_device *ldev = platform_get_drvdata(pdev);
 	struct drm_device *ddev = ldev->ddev;
 
-	xa_destroy(&ldev->active_contexts);
-
 	sysfs_remove_bin_file(&ldev->dev->kobj, &lima_error_state_attr);
 
 	drm_dev_unregister(ddev);
diff --git a/drivers/gpu/drm/lima/lima_drv.h b/drivers/gpu/drm/lima/lima_drv.h
index e49b7ab651d0..c738d288547b 100644
--- a/drivers/gpu/drm/lima/lima_drv.h
+++ b/drivers/gpu/drm/lima/lima_drv.h
@@ -20,7 +20,6 @@ struct lima_sched_task;
 struct drm_lima_gem_submit_bo;
 
 struct lima_drm_priv {
-	int id;
 	struct lima_vm *vm;
 	struct lima_ctx_mgr ctx_mgr;
 };
-- 
2.25.1

