Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1660C667675
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 15:32:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238190AbjALOcF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 09:32:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238056AbjALObV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 09:31:21 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79D545933A
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 06:22:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673533350;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LuOhWcvMHZUxEhlH6k+bJeMOhO9553Adrn/Panfxguk=;
        b=VdhL75XuOaaFToRZ+WCRPqCNHhSAXUoUltsD0RC2IFRQbM1K+4QbBIc38iOnt8aQJv5/yr
        vk2fAwieC8o2GW+rOhI2OaaXRWaWKsQe+0yC9JaUB0N0kgd/Xc3VgzR7YFIcZfNymtCPw2
        ScKmWZiYT6/Nn0SE4ypD6RLhLMjHpHc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-55-z_941EakMCm6hFbNtIPxgg-1; Thu, 12 Jan 2023 09:22:26 -0500
X-MC-Unique: z_941EakMCm6hFbNtIPxgg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 00080100F902;
        Thu, 12 Jan 2023 14:22:25 +0000 (UTC)
Received: from eperezma.remote.csb (unknown [10.39.192.72])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5C7162166B26;
        Thu, 12 Jan 2023 14:22:24 +0000 (UTC)
From:   =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To:     mst@redhat.com, elic@nvidia.com
Cc:     linux-kernel@vger.kernel.org, parav@nvidia.com, lulu@redhat.com,
        jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        sgarzare@redhat.com, si-wei.liu@oracle.com
Subject: [RFC 2/3] vdpa/mlx5: conditionally delete cvq iotlb in destroy_mr
Date:   Thu, 12 Jan 2023 15:22:17 +0100
Message-Id: <20230112142218.725622-3-eperezma@redhat.com>
In-Reply-To: <20230112142218.725622-1-eperezma@redhat.com>
References: <20230112142218.725622-1-eperezma@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mlx5_vdpa_destroy_mr can be called by setting a map to data ASID after
populating control virtqueue ASID iotlb.  Control vq iotlb must not be
cleared, since it will not be populated again.

Adding a conditional in the function so the caller specifies if it is
resetting, cleaning, or just changing data memory.

Fixes: 8fcd20c30704 ("vdpa/mlx5: Support different address spaces for control and data")
Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
---
 drivers/vdpa/mlx5/core/mlx5_vdpa.h |  2 +-
 drivers/vdpa/mlx5/core/mr.c        |  5 +++--
 drivers/vdpa/mlx5/net/mlx5_vnet.c  | 12 ++++++------
 3 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/vdpa/mlx5/core/mlx5_vdpa.h b/drivers/vdpa/mlx5/core/mlx5_vdpa.h
index 058fbe28107e..000b144019ec 100644
--- a/drivers/vdpa/mlx5/core/mlx5_vdpa.h
+++ b/drivers/vdpa/mlx5/core/mlx5_vdpa.h
@@ -119,7 +119,7 @@ int mlx5_vdpa_handle_set_map(struct mlx5_vdpa_dev *mvdev, struct vhost_iotlb *io
 			     bool *change_map, unsigned int asid);
 int mlx5_vdpa_create_mr(struct mlx5_vdpa_dev *mvdev, struct vhost_iotlb *iotlb,
 			unsigned int asid);
-void mlx5_vdpa_destroy_mr(struct mlx5_vdpa_dev *mvdev);
+void mlx5_vdpa_destroy_mr(struct mlx5_vdpa_dev *mvdev, bool delete_cvq_iotlb);
 
 #define mlx5_vdpa_warn(__dev, format, ...)                                                         \
 	dev_warn((__dev)->mdev->device, "%s:%d:(pid %d) warning: " format, __func__, __LINE__,     \
diff --git a/drivers/vdpa/mlx5/core/mr.c b/drivers/vdpa/mlx5/core/mr.c
index ae34dcac9a3f..878ee94efa78 100644
--- a/drivers/vdpa/mlx5/core/mr.c
+++ b/drivers/vdpa/mlx5/core/mr.c
@@ -491,7 +491,7 @@ static void destroy_user_mr(struct mlx5_vdpa_dev *mvdev, struct mlx5_vdpa_mr *mr
 	}
 }
 
-void mlx5_vdpa_destroy_mr(struct mlx5_vdpa_dev *mvdev)
+void mlx5_vdpa_destroy_mr(struct mlx5_vdpa_dev *mvdev, bool delete_cvq_iotlb)
 {
 	struct mlx5_vdpa_mr *mr = &mvdev->mr;
 
@@ -499,7 +499,8 @@ void mlx5_vdpa_destroy_mr(struct mlx5_vdpa_dev *mvdev)
 	if (!mr->initialized)
 		goto out;
 
-	prune_iotlb(mvdev);
+	if (delete_cvq_iotlb)
+		prune_iotlb(mvdev);
 	if (mr->user_mr)
 		destroy_user_mr(mvdev, mr);
 	else
diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index 6632651b1e54..1f1f341f602b 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -2433,7 +2433,7 @@ static int mlx5_vdpa_change_map(struct mlx5_vdpa_dev *mvdev,
 		goto err_mr;
 
 	teardown_driver(ndev);
-	mlx5_vdpa_destroy_mr(mvdev);
+	mlx5_vdpa_destroy_mr(mvdev, mvdev->group2asid[MLX5_VDPA_CVQ_GROUP] == asid);
 	err = mlx5_vdpa_create_mr(mvdev, iotlb, asid);
 	if (err)
 		goto err_mr;
@@ -2449,7 +2449,7 @@ static int mlx5_vdpa_change_map(struct mlx5_vdpa_dev *mvdev,
 	return 0;
 
 err_setup:
-	mlx5_vdpa_destroy_mr(mvdev);
+	mlx5_vdpa_destroy_mr(mvdev, mvdev->group2asid[MLX5_VDPA_CVQ_GROUP] == asid);
 err_mr:
 	return err;
 }
@@ -2578,7 +2578,7 @@ static void mlx5_vdpa_set_status(struct vdpa_device *vdev, u8 status)
 	return;
 
 err_setup:
-	mlx5_vdpa_destroy_mr(&ndev->mvdev);
+	mlx5_vdpa_destroy_mr(&ndev->mvdev, true);
 	ndev->mvdev.status |= VIRTIO_CONFIG_S_FAILED;
 err_clear:
 	up_write(&ndev->reslock);
@@ -2604,7 +2604,7 @@ static int mlx5_vdpa_reset(struct vdpa_device *vdev)
 	down_write(&ndev->reslock);
 	teardown_driver(ndev);
 	clear_vqs_ready(ndev);
-	mlx5_vdpa_destroy_mr(&ndev->mvdev);
+	mlx5_vdpa_destroy_mr(&ndev->mvdev, true);
 	ndev->mvdev.status = 0;
 	ndev->cur_num_vqs = 0;
 	ndev->mvdev.cvq.received_desc = 0;
@@ -2691,7 +2691,7 @@ static void mlx5_vdpa_free(struct vdpa_device *vdev)
 	ndev = to_mlx5_vdpa_ndev(mvdev);
 
 	free_resources(ndev);
-	mlx5_vdpa_destroy_mr(mvdev);
+	mlx5_vdpa_destroy_mr(mvdev, true);
 	if (!is_zero_ether_addr(ndev->config.mac)) {
 		pfmdev = pci_get_drvdata(pci_physfn(mvdev->mdev->pdev));
 		mlx5_mpfs_del_mac(pfmdev, ndev->config.mac);
@@ -3214,7 +3214,7 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
 err_res2:
 	free_resources(ndev);
 err_mr:
-	mlx5_vdpa_destroy_mr(mvdev);
+	mlx5_vdpa_destroy_mr(mvdev, true);
 err_res:
 	mlx5_vdpa_free_resources(&ndev->mvdev);
 err_mpfs:
-- 
2.31.1

