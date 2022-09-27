Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 354555EBBEB
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 09:49:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231195AbiI0Hte (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 03:49:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231181AbiI0Hso (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 03:48:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 770E09DDB4
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 00:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664264916;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Wi5wP3zH25kbd28RgXoJk9MwKJRKYg+ePUIgv70dp6k=;
        b=EUuSNcuBiskhliuaQFOPdZtunRuhWz8QwG5VbVTrX7i1MzpKBJFS5xqMUGQc2NP1iW/5Eq
        glzc/rjy6n/KcOWzqLklWAUihbF1k26/wzi+dahReaiR5UgA4/X0jpcTWCyn0gvHHGjPAB
        dyZRc6Q2q+uLhjHifo0hF+Koxbc8YLM=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-551--rbsFOUsMWGMWc0zL0wVog-1; Tue, 27 Sep 2022 03:48:31 -0400
X-MC-Unique: -rbsFOUsMWGMWc0zL0wVog-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E178A1C0CE6B;
        Tue, 27 Sep 2022 07:48:30 +0000 (UTC)
Received: from localhost.localdomain (ovpn-13-192.pek2.redhat.com [10.72.13.192])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1BB2E140EBF3;
        Tue, 27 Sep 2022 07:48:24 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     mst@redhat.com, jasowang@redhat.com
Cc:     elic@nvidia.com, si-wei.liu@oracle.com, parav@nvidia.com,
        wuzongyong@linux.alibaba.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, eperezma@redhat.com,
        lingshan.zhu@intel.com, gdawar@xilinx.com, lulu@redhat.com,
        xieyongji@bytedance.com, sgarzare@redhat.com
Subject: [PATCH V3 2/3] vdpa_sim_net: support feature provisioning
Date:   Tue, 27 Sep 2022 15:48:09 +0800
Message-Id: <20220927074810.28627-3-jasowang@redhat.com>
In-Reply-To: <20220927074810.28627-1-jasowang@redhat.com>
References: <20220927074810.28627-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch implements features provisioning for vdpa_sim_net.

1) validating the provisioned features to be a subset of the parent
   features.
2) clearing the features that is not wanted by the userspace

For example:

# vdpa mgmtdev show
vdpasim_net:
  supported_classes net
  max_supported_vqs 3
  dev_features MTU MAC CTRL_VQ CTRL_MAC_ADDR ANY_LAYOUT VERSION_1 ACCESS_PLATFORM

1) provision vDPA device with all features that are supported by the
   net simulator

# vdpa dev add name dev1 mgmtdev vdpasim_net
# vdpa dev config show
dev1: mac 00:00:00:00:00:00 link up link_announce false mtu 1500
  negotiated_features MTU MAC CTRL_VQ CTRL_MAC_ADDR VERSION_1 ACCESS_PLATFORM

2) provision vDPA device with a subset of the features

# vdpa dev add name dev1 mgmtdev vdpasim_net device_features 0x300020000
# vdpa dev config show
dev1: mac 00:00:00:00:00:00 link up link_announce false mtu 1500
  negotiated_features CTRL_VQ VERSION_1 ACCESS_PLATFORM

Reviewed-by: Eli Cohen <elic@nvidia.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vdpa/vdpa_sim/vdpa_sim.c     | 12 +++++++++++-
 drivers/vdpa/vdpa_sim/vdpa_sim.h     |  3 ++-
 drivers/vdpa/vdpa_sim/vdpa_sim_blk.c |  2 +-
 drivers/vdpa/vdpa_sim/vdpa_sim_net.c |  5 +++--
 4 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
index 225b7f5d8be3..b071f0d842fb 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
@@ -18,6 +18,7 @@
 #include <linux/vdpa.h>
 #include <linux/vhost_iotlb.h>
 #include <linux/iova.h>
+#include <uapi/linux/vdpa.h>
 
 #include "vdpa_sim.h"
 
@@ -245,13 +246,22 @@ static const struct dma_map_ops vdpasim_dma_ops = {
 static const struct vdpa_config_ops vdpasim_config_ops;
 static const struct vdpa_config_ops vdpasim_batch_config_ops;
 
-struct vdpasim *vdpasim_create(struct vdpasim_dev_attr *dev_attr)
+struct vdpasim *vdpasim_create(struct vdpasim_dev_attr *dev_attr,
+			       const struct vdpa_dev_set_config *config)
 {
 	const struct vdpa_config_ops *ops;
 	struct vdpasim *vdpasim;
 	struct device *dev;
 	int i, ret = -ENOMEM;
 
+	if (config->mask & BIT_ULL(VDPA_ATTR_DEV_FEATURES)) {
+		if (config->device_features &
+		    ~dev_attr->supported_features)
+			return ERR_PTR(-EINVAL);
+		dev_attr->supported_features =
+			config->device_features;
+	}
+
 	if (batch_mapping)
 		ops = &vdpasim_batch_config_ops;
 	else
diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.h b/drivers/vdpa/vdpa_sim/vdpa_sim.h
index 061986f30911..0e78737dcc16 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim.h
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.h
@@ -71,7 +71,8 @@ struct vdpasim {
 	spinlock_t iommu_lock;
 };
 
-struct vdpasim *vdpasim_create(struct vdpasim_dev_attr *attr);
+struct vdpasim *vdpasim_create(struct vdpasim_dev_attr *attr,
+			       const struct vdpa_dev_set_config *config);
 
 /* TODO: cross-endian support */
 static inline bool vdpasim_is_little_endian(struct vdpasim *vdpasim)
diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
index c8bfea3b7db2..c6db1a1baf76 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
@@ -383,7 +383,7 @@ static int vdpasim_blk_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
 	dev_attr.work_fn = vdpasim_blk_work;
 	dev_attr.buffer_size = VDPASIM_BLK_CAPACITY << SECTOR_SHIFT;
 
-	simdev = vdpasim_create(&dev_attr);
+	simdev = vdpasim_create(&dev_attr, config);
 	if (IS_ERR(simdev))
 		return PTR_ERR(simdev);
 
diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
index 886449e88502..c3cb225ea469 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
@@ -254,7 +254,7 @@ static int vdpasim_net_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
 	dev_attr.work_fn = vdpasim_net_work;
 	dev_attr.buffer_size = PAGE_SIZE;
 
-	simdev = vdpasim_create(&dev_attr);
+	simdev = vdpasim_create(&dev_attr, config);
 	if (IS_ERR(simdev))
 		return PTR_ERR(simdev);
 
@@ -294,7 +294,8 @@ static struct vdpa_mgmt_dev mgmt_dev = {
 	.id_table = id_table,
 	.ops = &vdpasim_net_mgmtdev_ops,
 	.config_attr_mask = (1 << VDPA_ATTR_DEV_NET_CFG_MACADDR |
-			     1 << VDPA_ATTR_DEV_NET_CFG_MTU),
+			     1 << VDPA_ATTR_DEV_NET_CFG_MTU |
+		             1 << VDPA_ATTR_DEV_FEATURES),
 	.max_supported_vqs = VDPASIM_NET_VQ_NUM,
 	.supported_features = VDPASIM_NET_FEATURES,
 };
-- 
2.25.1

