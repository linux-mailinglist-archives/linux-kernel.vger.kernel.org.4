Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB521745E80
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 16:27:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230162AbjGCO0d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 10:26:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbjGCO0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 10:26:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30176B3
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 07:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688394323;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=ZHqn83Z4nuY+pmIfzFaoPwoFjguWWUwYIDMm/eINnuY=;
        b=Mv/FYPczBDOKFYEX90k9g6S6XSFSOgNw+bg9VXeaj1/1d8WdwMJVQi1GbUVGGe4WDW1byo
        ims2MGJgSiqQvTyzlLtbapMtJ7gXHFjCJ8dhLxbkjgZgeGfEeCBFf5bY3s3tAwbXKjggeV
        7o2yZeY+8JzYJAe1liTNus37BuLYxYU=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-204-lyG-mLyyMWCT9OVj9mlS3Q-1; Mon, 03 Jul 2023 10:25:18 -0400
X-MC-Unique: lyG-mLyyMWCT9OVj9mlS3Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D43BB3813F2C;
        Mon,  3 Jul 2023 14:25:17 +0000 (UTC)
Received: from eperezma.remote.csb (unknown [10.39.192.105])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6F7F32014E17;
        Mon,  3 Jul 2023 14:25:16 +0000 (UTC)
From:   =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To:     mst@redhat.com
Cc:     linux-kernel@vger.kernel.org, Dragos Tatulea <dtatulea@nvidia.com>,
        virtualization@lists.linux-foundation.org, leiyang@redhat.com,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Si-Wei Liu <si-wei.liu@oracle.com>,
        Jason Wang <jasowang@redhat.com>
Subject: [PATCH] mlx5_vdpa: offer VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK
Date:   Mon,  3 Jul 2023 16:25:14 +0200
Message-Id: <20230703142514.363256-1-eperezma@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Offer this backend feature as mlx5 is compatible with it. It allows it
to do live migration with CVQ, dynamically switching between passthrough
and shadow virtqueue.

Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
---
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index 9138ef2fb2c8..5f309a16b9dc 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -7,6 +7,7 @@
 #include <uapi/linux/virtio_net.h>
 #include <uapi/linux/virtio_ids.h>
 #include <uapi/linux/vdpa.h>
+#include <uapi/linux/vhost_types.h>
 #include <linux/virtio_config.h>
 #include <linux/auxiliary_bus.h>
 #include <linux/mlx5/cq.h>
@@ -2499,6 +2500,11 @@ static void unregister_link_notifier(struct mlx5_vdpa_net *ndev)
 		flush_workqueue(ndev->mvdev.wq);
 }
 
+static u64 mlx5_vdpa_get_backend_features(const struct vdpa_device *vdpa)
+{
+	return BIT_ULL(VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK);
+}
+
 static int mlx5_vdpa_set_driver_features(struct vdpa_device *vdev, u64 features)
 {
 	struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
@@ -3140,6 +3146,7 @@ static const struct vdpa_config_ops mlx5_vdpa_ops = {
 	.get_vq_align = mlx5_vdpa_get_vq_align,
 	.get_vq_group = mlx5_vdpa_get_vq_group,
 	.get_device_features = mlx5_vdpa_get_device_features,
+	.get_backend_features = mlx5_vdpa_get_backend_features,
 	.set_driver_features = mlx5_vdpa_set_driver_features,
 	.get_driver_features = mlx5_vdpa_get_driver_features,
 	.set_config_cb = mlx5_vdpa_set_config_cb,
-- 
2.39.3

