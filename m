Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B97A5BF4C2
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 05:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231546AbiIUD3A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 23:29:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231404AbiIUD2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 23:28:05 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2B207EFD7;
        Tue, 20 Sep 2022 20:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663730881; x=1695266881;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MuLOR6tGRzdttt+GlwHEN55tZn+NnVFw8Pxpxnc4FmA=;
  b=nSQY3sziBjju0eDJH1cPgR8HnVPYzungi+huSza7BgXK5fvqRKPoBNzv
   SEYNSr/MBMtPutnU1/4l3Oc+IOQKr6613rcQNlqDnmKqIm4c9bdBdzNlq
   K9TFU2GfA+Hb73QWIsfNTzpnl4eJpijooKfWW4Jl8RKNinVkgV+yx5qO7
   CwdGkWLj9VWj1MUjOqPu1aF9P4lpIKgt8pDWCLYZnAEUN65WrX4N+DRTy
   ifxKvhLp56cIhIyHiHcAp+V1TCq/T1QcnVYdsyhneSW5hmn95SDuj8NUM
   N36shlzGRlHe0QtfgnaLdWRiH2pEHjh2L+lG3xWnS1ZVW0i2pvEIN7MIu
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10476"; a="386173047"
X-IronPort-AV: E=Sophos;i="5.93,332,1654585200"; 
   d="scan'208";a="386173047"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2022 20:28:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,332,1654585200"; 
   d="scan'208";a="761574471"
Received: from sqa-gate.sh.intel.com (HELO michael.clx.dev.tsp.org) ([10.239.48.212])
  by fmsmga001.fm.intel.com with ESMTP; 20 Sep 2022 20:27:53 -0700
From:   Kevin Tian <kevin.tian@intel.com>
To:     Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Eric Farman <farman@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Tony Krowiak <akrowiak@linux.ibm.com>,
        Jason Herne <jjherne@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Diana Craciun <diana.craciun@oss.nxp.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Longfang Liu <liulongfang@huawei.com>,
        Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Yishai Hadas <yishaih@nvidia.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Eric Auger <eric.auger@redhat.com>,
        Kirti Wankhede <kwankhede@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        Abhishek Sahu <abhsahu@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH v4 12/15] vfio/amba: Use the new device life cycle helpers
Date:   Wed, 21 Sep 2022 18:43:58 +0800
Message-Id: <20220921104401.38898-13-kevin.tian@intel.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20220921104401.38898-1-kevin.tian@intel.com>
References: <20220921104401.38898-1-kevin.tian@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement amba's own vfio_device_ops.

Remove vfio_platform_probe/remove_common() given no user now.

Signed-off-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
---
 drivers/vfio/platform/vfio_amba.c             | 72 ++++++++++++++-----
 drivers/vfio/platform/vfio_platform_common.c  | 60 ----------------
 drivers/vfio/platform/vfio_platform_private.h |  3 -
 3 files changed, 55 insertions(+), 80 deletions(-)

diff --git a/drivers/vfio/platform/vfio_amba.c b/drivers/vfio/platform/vfio_amba.c
index 1aaa4f721bd2..eaea63e5294c 100644
--- a/drivers/vfio/platform/vfio_amba.c
+++ b/drivers/vfio/platform/vfio_amba.c
@@ -7,6 +7,7 @@
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/vfio.h>
+#include <linux/pm_runtime.h>
 #include <linux/amba/bus.h>
 
 #include "vfio_platform_private.h"
@@ -40,20 +41,16 @@ static int get_amba_irq(struct vfio_platform_device *vdev, int i)
 	return ret ? ret : -ENXIO;
 }
 
-static int vfio_amba_probe(struct amba_device *adev, const struct amba_id *id)
+static int vfio_amba_init_dev(struct vfio_device *core_vdev)
 {
-	struct vfio_platform_device *vdev;
+	struct vfio_platform_device *vdev =
+		container_of(core_vdev, struct vfio_platform_device, vdev);
+	struct amba_device *adev = to_amba_device(core_vdev->dev);
 	int ret;
 
-	vdev = kzalloc(sizeof(*vdev), GFP_KERNEL);
-	if (!vdev)
-		return -ENOMEM;
-
 	vdev->name = kasprintf(GFP_KERNEL, "vfio-amba-%08x", adev->periphid);
-	if (!vdev->name) {
-		kfree(vdev);
+	if (!vdev->name)
 		return -ENOMEM;
-	}
 
 	vdev->opaque = (void *) adev;
 	vdev->flags = VFIO_DEVICE_FLAGS_AMBA;
@@ -61,26 +58,67 @@ static int vfio_amba_probe(struct amba_device *adev, const struct amba_id *id)
 	vdev->get_irq = get_amba_irq;
 	vdev->reset_required = false;
 
-	ret = vfio_platform_probe_common(vdev, &adev->dev);
-	if (ret) {
+	ret = vfio_platform_init_common(vdev);
+	if (ret)
 		kfree(vdev->name);
-		kfree(vdev);
-		return ret;
-	}
+	return ret;
+}
+
+static const struct vfio_device_ops vfio_amba_ops;
+static int vfio_amba_probe(struct amba_device *adev, const struct amba_id *id)
+{
+	struct vfio_platform_device *vdev;
+	int ret;
+
+	vdev = vfio_alloc_device(vfio_platform_device, vdev, &adev->dev,
+				 &vfio_amba_ops);
+	if (IS_ERR(vdev))
+		return PTR_ERR(vdev);
 
+	ret = vfio_register_group_dev(&vdev->vdev);
+	if (ret)
+		goto out_put_vdev;
+
+	pm_runtime_enable(&adev->dev);
 	dev_set_drvdata(&adev->dev, vdev);
 	return 0;
+
+out_put_vdev:
+	vfio_put_device(&vdev->vdev);
+	return ret;
+}
+
+static void vfio_amba_release_dev(struct vfio_device *core_vdev)
+{
+	struct vfio_platform_device *vdev =
+		container_of(core_vdev, struct vfio_platform_device, vdev);
+
+	vfio_platform_release_common(vdev);
+	kfree(vdev->name);
+	vfio_free_device(core_vdev);
 }
 
 static void vfio_amba_remove(struct amba_device *adev)
 {
 	struct vfio_platform_device *vdev = dev_get_drvdata(&adev->dev);
 
-	vfio_platform_remove_common(vdev);
-	kfree(vdev->name);
-	kfree(vdev);
+	vfio_unregister_group_dev(&vdev->vdev);
+	pm_runtime_disable(vdev->device);
+	vfio_put_device(&vdev->vdev);
 }
 
+static const struct vfio_device_ops vfio_amba_ops = {
+	.name		= "vfio-amba",
+	.init		= vfio_amba_init_dev,
+	.release	= vfio_amba_release_dev,
+	.open_device	= vfio_platform_open_device,
+	.close_device	= vfio_platform_close_device,
+	.ioctl		= vfio_platform_ioctl,
+	.read		= vfio_platform_read,
+	.write		= vfio_platform_write,
+	.mmap		= vfio_platform_mmap,
+};
+
 static const struct amba_id pl330_ids[] = {
 	{ 0, 0 },
 };
diff --git a/drivers/vfio/platform/vfio_platform_common.c b/drivers/vfio/platform/vfio_platform_common.c
index 4c01bf0adebb..55dc4f43c31e 100644
--- a/drivers/vfio/platform/vfio_platform_common.c
+++ b/drivers/vfio/platform/vfio_platform_common.c
@@ -605,16 +605,6 @@ int vfio_platform_mmap(struct vfio_device *core_vdev, struct vm_area_struct *vma
 }
 EXPORT_SYMBOL_GPL(vfio_platform_mmap);
 
-static const struct vfio_device_ops vfio_platform_ops = {
-	.name		= "vfio-platform",
-	.open_device	= vfio_platform_open_device,
-	.close_device	= vfio_platform_close_device,
-	.ioctl		= vfio_platform_ioctl,
-	.read		= vfio_platform_read,
-	.write		= vfio_platform_write,
-	.mmap		= vfio_platform_mmap,
-};
-
 static int vfio_platform_of_probe(struct vfio_platform_device *vdev,
 			   struct device *dev)
 {
@@ -674,56 +664,6 @@ void vfio_platform_release_common(struct vfio_platform_device *vdev)
 }
 EXPORT_SYMBOL_GPL(vfio_platform_release_common);
 
-int vfio_platform_probe_common(struct vfio_platform_device *vdev,
-			       struct device *dev)
-{
-	int ret;
-
-	vfio_init_group_dev(&vdev->vdev, dev, &vfio_platform_ops);
-
-	ret = vfio_platform_acpi_probe(vdev, dev);
-	if (ret)
-		ret = vfio_platform_of_probe(vdev, dev);
-
-	if (ret)
-		goto out_uninit;
-
-	vdev->device = dev;
-
-	ret = vfio_platform_get_reset(vdev);
-	if (ret && vdev->reset_required) {
-		dev_err(dev, "No reset function found for device %s\n",
-			vdev->name);
-		goto out_uninit;
-	}
-
-	ret = vfio_register_group_dev(&vdev->vdev);
-	if (ret)
-		goto put_reset;
-
-	mutex_init(&vdev->igate);
-
-	pm_runtime_enable(dev);
-	return 0;
-
-put_reset:
-	vfio_platform_put_reset(vdev);
-out_uninit:
-	vfio_uninit_group_dev(&vdev->vdev);
-	return ret;
-}
-EXPORT_SYMBOL_GPL(vfio_platform_probe_common);
-
-void vfio_platform_remove_common(struct vfio_platform_device *vdev)
-{
-	vfio_unregister_group_dev(&vdev->vdev);
-
-	pm_runtime_disable(vdev->device);
-	vfio_platform_put_reset(vdev);
-	vfio_uninit_group_dev(&vdev->vdev);
-}
-EXPORT_SYMBOL_GPL(vfio_platform_remove_common);
-
 void __vfio_platform_register_reset(struct vfio_platform_reset_node *node)
 {
 	mutex_lock(&driver_lock);
diff --git a/drivers/vfio/platform/vfio_platform_private.h b/drivers/vfio/platform/vfio_platform_private.h
index a769d649fb97..8d8fab516849 100644
--- a/drivers/vfio/platform/vfio_platform_private.h
+++ b/drivers/vfio/platform/vfio_platform_private.h
@@ -78,9 +78,6 @@ struct vfio_platform_reset_node {
 	vfio_platform_reset_fn_t of_reset;
 };
 
-int vfio_platform_probe_common(struct vfio_platform_device *vdev,
-			       struct device *dev);
-void vfio_platform_remove_common(struct vfio_platform_device *vdev);
 int vfio_platform_init_common(struct vfio_platform_device *vdev);
 void vfio_platform_release_common(struct vfio_platform_device *vdev);
 
-- 
2.21.3

