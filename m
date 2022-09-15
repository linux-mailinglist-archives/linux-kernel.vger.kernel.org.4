Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00E325B96AD
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 10:51:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbiIOIvb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 04:51:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbiIOIvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 04:51:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E53E68C46E
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 01:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663231879;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LsSelknX6THRoDMT4JVzqL+8FJL3Dn3j4efuY9sh5qA=;
        b=BniLdMr3yAbPCyHUvhhS8vpa84kSLT+sE06nm/k+3l1M5m7q1DjSL7Cm1nyy+HjfiZ0rZb
        LuWMdIfOGDeNLWQT/FEuLWhxJoViIz9Mky46dRU/cLDLk0MAhLIYoTlz3oOiZO/zPEd2Ou
        n6fZde2Hcin9Q/G35a/hHiaUWXx3NHo=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-436-Hijl4VYnMV-lBqcVpA2XRg-1; Thu, 15 Sep 2022 04:51:15 -0400
X-MC-Unique: Hijl4VYnMV-lBqcVpA2XRg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 823B82932498;
        Thu, 15 Sep 2022 08:51:14 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-201.pek2.redhat.com [10.72.12.201])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8258E1759E;
        Thu, 15 Sep 2022 08:51:09 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     mst@redhat.com, jasowang@redhat.com
Cc:     elic@nvidia.com, si-wei.liu@oracle.com, parav@nvidia.com,
        wuzongyong@linux.alibaba.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, eperezma@redhat.com,
        lingshan.zhu@intel.com, gdawar@xilinx.com, lulu@redhat.com,
        xieyongji@bytedance.com
Subject: [PATCH 3/3] vp_vdpa: support feature provisioning
Date:   Thu, 15 Sep 2022 16:50:48 +0800
Message-Id: <20220915085048.12840-4-jasowang@redhat.com>
In-Reply-To: <20220915085048.12840-1-jasowang@redhat.com>
References: <20220915085048.12840-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch allows the device features to be provisioned via
netlink. This is done by:

1) validating the provisioned features to be a subset of the parent
   features.
2) clearing the features that is not wanted by the userspace

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vdpa/virtio_pci/vp_vdpa.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/vdpa/virtio_pci/vp_vdpa.c b/drivers/vdpa/virtio_pci/vp_vdpa.c
index 04522077735b..4b28e0c95ba2 100644
--- a/drivers/vdpa/virtio_pci/vp_vdpa.c
+++ b/drivers/vdpa/virtio_pci/vp_vdpa.c
@@ -17,6 +17,7 @@
 #include <linux/virtio_ring.h>
 #include <linux/virtio_pci.h>
 #include <linux/virtio_pci_modern.h>
+#include <uapi/linux/vdpa.h>
 
 #define VP_VDPA_QUEUE_MAX 256
 #define VP_VDPA_DRIVER_NAME "vp_vdpa"
@@ -35,6 +36,7 @@ struct vp_vdpa {
 	struct virtio_pci_modern_device *mdev;
 	struct vp_vring *vring;
 	struct vdpa_callback config_cb;
+	u64 device_features;
 	char msix_name[VP_VDPA_NAME_SIZE];
 	int config_irq;
 	int queues;
@@ -66,9 +68,9 @@ static struct virtio_pci_modern_device *vp_vdpa_to_mdev(struct vp_vdpa *vp_vdpa)
 
 static u64 vp_vdpa_get_device_features(struct vdpa_device *vdpa)
 {
-	struct virtio_pci_modern_device *mdev = vdpa_to_mdev(vdpa);
+	struct vp_vdpa *vp_vdpa = vdpa_to_vp(vdpa);
 
-	return vp_modern_get_features(mdev);
+	return vp_vdpa->device_features;
 }
 
 static int vp_vdpa_set_driver_features(struct vdpa_device *vdpa, u64 features)
@@ -475,6 +477,7 @@ static int vp_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
 	struct pci_dev *pdev = mdev->pci_dev;
 	struct device *dev = &pdev->dev;
 	struct vp_vdpa *vp_vdpa = NULL;
+	u64 device_features;
 	int ret, i;
 
 	vp_vdpa = vdpa_alloc_device(struct vp_vdpa, vdpa,
@@ -491,6 +494,14 @@ static int vp_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
 	vp_vdpa->queues = vp_modern_get_num_queues(mdev);
 	vp_vdpa->mdev = mdev;
 
+	device_features = vp_modern_get_features(mdev);
+	if (add_config->mask & BIT_ULL(VDPA_ATTR_DEV_FEATURES)) {
+		if (add_config->device_features & ~device_features)
+			return -EINVAL;
+		device_features &= add_config->device_features;
+	}
+	vp_vdpa->device_features = device_features;
+
 	ret = devm_add_action_or_reset(dev, vp_vdpa_free_irq_vectors, pdev);
 	if (ret) {
 		dev_err(&pdev->dev,
@@ -599,6 +610,7 @@ static int vp_vdpa_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	mgtdev->id_table = mdev_id;
 	mgtdev->max_supported_vqs = vp_modern_get_num_queues(mdev);
 	mgtdev->supported_features = vp_modern_get_features(mdev);
+	mgtdev->config_attr_mask = (1 << VDPA_ATTR_DEV_FEATURES);
 	pci_set_master(pdev);
 	pci_set_drvdata(pdev, vp_vdpa_mgtdev);
 
-- 
2.25.1

