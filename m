Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C00C688EBE
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 06:03:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231779AbjBCFDG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 00:03:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbjBCFCg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 00:02:36 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1975975198
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 21:02:32 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3130NouX028457;
        Fri, 3 Feb 2023 05:02:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2022-7-12;
 bh=bzsrikSqzLTTwIke+OEYxq9wDoMZGz3PJ1oVwfZNlY8=;
 b=mrQPzX4C57ipC/iqNHmn+oxbYELZO+vw/8K7RVN/Sit/vFJdMMW+RzPKXWJDOELQVz2Q
 perC+istTVuAy87UGlPqskEs6KfsO/me7etUTi1Cg/raEN4mYHom1fcwY+HrSSgEBvwn
 n/vYCajpbOTxxXsThC1Pk4njzvb/6DbqbtVU1a4JP1mfaMytQB/Eny21V9VGawCU3BW6
 qbiX0RGRwdSC3yyxPgtIEnGAvYOvBYNJYZPF/KNozZ5qWYCWyz0BKgwnLGhgN2W9YJYw
 DXCOt1PI2yGd9Qrt8YjXpKMftoHyRiZsAYIR3RZd7TK+/XFC75cRiy1bUh1irvi2vEhc nQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nfn9ymrqv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Feb 2023 05:02:28 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31340RuS006053;
        Fri, 3 Feb 2023 05:02:27 GMT
Received: from ban25x6uut24.us.oracle.com (ban25x6uut24.us.oracle.com [10.153.73.24])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3nct5a2tm8-7;
        Fri, 03 Feb 2023 05:02:27 +0000
From:   Si-Wei Liu <si-wei.liu@oracle.com>
To:     mst@redhat.com, jasowang@redhat.com, parav@nvidia.com,
        elic@nvidia.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 6/6] vdpa/mlx5: support device features provisioning
Date:   Thu,  2 Feb 2023 21:02:03 -0800
Message-Id: <1675400523-12519-7-git-send-email-si-wei.liu@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1675400523-12519-1-git-send-email-si-wei.liu@oracle.com>
References: <1675400523-12519-1-git-send-email-si-wei.liu@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-03_02,2023-02-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 suspectscore=0 mlxscore=0 spamscore=0 phishscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302030044
X-Proofpoint-ORIG-GUID: yu7w6tjNpRwxa1xpimgSykgZOpVcw94Q
X-Proofpoint-GUID: yu7w6tjNpRwxa1xpimgSykgZOpVcw94Q
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch implements features provisioning for mlx5_vdpa.

1) Validate the provisioned features are a subset of the parent
    features.
2) Clearing features that are not wanted by userspace.

For example:

    # vdpa mgmtdev show
    pci/0000:41:04.2:
      supported_classes net
      max_supported_vqs 65
      dev_features CSUM GUEST_CSUM MTU MAC HOST_TSO4 HOST_TSO6 STATUS CTRL_VQ CTRL_VLAN MQ CTRL_MAC_ADDR VERSION_1 ACCESS_PLATFORM

1) Provision vDPA device with all features derived from the parent

    # vdpa dev add name vdpa1 mgmtdev pci/0000:41:04.2
    # vdpa dev config show
    vdpa1: mac e4:11:c6:d3:45:f0 link up link_announce false max_vq_pairs 1 mtu 1500
      negotiated_features CSUM GUEST_CSUM MTU HOST_TSO4 HOST_TSO6 STATUS CTRL_VQ CTRL_VLAN MQ CTRL_MAC_ADDR VERSION_1 ACCESS_PLATFORM

2) Provision vDPA device with a subset of parent features

    # vdpa dev add name vdpa1 mgmtdev pci/0000:41:04.2 device_features 0x300020000
    # vdpa dev config show
    vdpa1:
      negotiated_features CTRL_VQ VERSION_1 ACCESS_PLATFORM

Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
---
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 53 +++++++++++++++++++++++++++++++++------
 1 file changed, 45 insertions(+), 8 deletions(-)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index 867ac18..b40dd1a 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -2183,6 +2183,7 @@ static u64 get_supported_features(struct mlx5_core_dev *mdev)
 	mlx_vdpa_features |= BIT_ULL(VIRTIO_NET_F_STATUS);
 	mlx_vdpa_features |= BIT_ULL(VIRTIO_NET_F_MTU);
 	mlx_vdpa_features |= BIT_ULL(VIRTIO_NET_F_CTRL_VLAN);
+	mlx_vdpa_features |= BIT_ULL(VIRTIO_NET_F_MAC);
 
 	return mlx_vdpa_features;
 }
@@ -3062,6 +3063,7 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
 	struct mlx5_vdpa_dev *mvdev;
 	struct mlx5_vdpa_net *ndev;
 	struct mlx5_core_dev *mdev;
+	u64 device_features;
 	u32 max_vqs;
 	u16 mtu;
 	int err;
@@ -3070,6 +3072,24 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
 		return -ENOSPC;
 
 	mdev = mgtdev->madev->mdev;
+	device_features = mgtdev->mgtdev.supported_features;
+	if (add_config->mask & BIT_ULL(VDPA_ATTR_DEV_FEATURES)) {
+		if (add_config->device_features & ~device_features) {
+			dev_warn(mdev->device,
+				 "The provisioned features 0x%llx are not supported by this device with features 0x%llx\n",
+				 add_config->device_features, device_features);
+			return -EINVAL;
+		}
+		device_features &= add_config->device_features;
+	}
+	if (!(device_features & BIT_ULL(VIRTIO_F_VERSION_1) &&
+	      device_features & BIT_ULL(VIRTIO_F_ACCESS_PLATFORM))) {
+		dev_warn(mdev->device,
+			 "Must provision minimum features 0x%llx for this device",
+			 BIT_ULL(VIRTIO_F_VERSION_1) | BIT_ULL(VIRTIO_F_ACCESS_PLATFORM));
+		return -EOPNOTSUPP;
+	}
+
 	if (!(MLX5_CAP_DEV_VDPA_EMULATION(mdev, virtio_queue_type) &
 	    MLX5_VIRTIO_EMULATION_CAP_VIRTIO_QUEUE_TYPE_SPLIT)) {
 		dev_warn(mdev->device, "missing support for split virtqueues\n");
@@ -3098,7 +3118,6 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
 	if (IS_ERR(ndev))
 		return PTR_ERR(ndev);
 
-	ndev->mvdev.mlx_features = mgtdev->mgtdev.supported_features;
 	ndev->mvdev.max_vqs = max_vqs;
 	mvdev = &ndev->mvdev;
 	mvdev->mdev = mdev;
@@ -3120,7 +3139,7 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
 			goto err_alloc;
 	}
 
-	if (ndev->mvdev.mlx_features & BIT_ULL(VIRTIO_NET_F_MTU)) {
+	if (device_features & BIT_ULL(VIRTIO_NET_F_MTU)) {
 		err = query_mtu(mdev, &mtu);
 		if (err)
 			goto err_alloc;
@@ -3128,7 +3147,7 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
 		ndev->config.mtu = cpu_to_mlx5vdpa16(mvdev, mtu);
 	}
 
-	if (ndev->mvdev.mlx_features & BIT_ULL(VIRTIO_NET_F_STATUS)) {
+	if (device_features & BIT_ULL(VIRTIO_NET_F_STATUS)) {
 		if (get_link_state(mvdev))
 			ndev->config.status |= cpu_to_mlx5vdpa16(mvdev, VIRTIO_NET_S_LINK_UP);
 		else
@@ -3137,7 +3156,9 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
 
 	if (add_config->mask & (1 << VDPA_ATTR_DEV_NET_CFG_MACADDR)) {
 		memcpy(ndev->config.mac, add_config->net.mac, ETH_ALEN);
-	} else {
+	/* No bother setting mac address in config if not going to provision _F_MAC */
+	} else if ((add_config->mask & BIT_ULL(VDPA_ATTR_DEV_FEATURES)) == 0 ||
+		   device_features & BIT_ULL(VIRTIO_NET_F_MAC)) {
 		err = mlx5_query_nic_vport_mac_address(mdev, 0, 0, config->mac);
 		if (err)
 			goto err_alloc;
@@ -3148,11 +3169,26 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
 		err = mlx5_mpfs_add_mac(pfmdev, config->mac);
 		if (err)
 			goto err_alloc;
-
-		ndev->mvdev.mlx_features |= BIT_ULL(VIRTIO_NET_F_MAC);
+	} else if ((add_config->mask & BIT_ULL(VDPA_ATTR_DEV_FEATURES)) == 0) {
+		/*
+		 * We used to clear _F_MAC feature bit if seeing
+		 * zero mac address when device features are not
+		 * specifically provisioned. Keep the behaviour
+		 * so old scripts do not break.
+		 */
+		device_features &= ~BIT_ULL(VIRTIO_NET_F_MAC);
+	} else if (device_features & BIT_ULL(VIRTIO_NET_F_MAC)) {
+		/* Don't provision zero mac address for _F_MAC */
+		mlx5_vdpa_warn(&ndev->mvdev,
+			       "No mac address provisioned?\n");
+		err = -EINVAL;
+		goto err_alloc;
 	}
 
-	config->max_virtqueue_pairs = cpu_to_mlx5vdpa16(mvdev, max_vqs / 2);
+	if (device_features & BIT_ULL(VIRTIO_NET_F_MQ))
+		config->max_virtqueue_pairs = cpu_to_mlx5vdpa16(mvdev, max_vqs / 2);
+
+	ndev->mvdev.mlx_features = device_features;
 	mvdev->vdev.dma_dev = &mdev->pdev->dev;
 	err = mlx5_vdpa_alloc_resources(&ndev->mvdev);
 	if (err)
@@ -3249,7 +3285,8 @@ static int mlx5v_probe(struct auxiliary_device *adev,
 	mgtdev->mgtdev.id_table = id_table;
 	mgtdev->mgtdev.config_attr_mask = BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MACADDR) |
 					  BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MAX_VQP) |
-					  BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MTU);
+					  BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MTU) |
+					  BIT_ULL(VDPA_ATTR_DEV_FEATURES);
 	mgtdev->mgtdev.max_supported_vqs =
 		MLX5_CAP_DEV_VDPA_EMULATION(mdev, max_num_virtio_queues) + 1;
 	mgtdev->mgtdev.supported_features = get_supported_features(mdev);
-- 
1.8.3.1

