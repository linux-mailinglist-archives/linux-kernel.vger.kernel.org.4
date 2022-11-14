Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32ADC62811F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 14:19:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237981AbiKNNS5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 08:18:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237501AbiKNNS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 08:18:28 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2071.outbound.protection.outlook.com [40.107.94.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17729DFD
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 05:18:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HSQLruxwDXnI9B8PJzp6ljAoHcMVVsy8nXzS9eYsqvFRZxGs5k8PrSpwIILFmz1IqRDo+52O2qDDNZFu3OydVwU734j/nJa5c33KeSfk/e5H+9+isGx4V+P44ZddCOneSORAQpn9e6SiCZNReh2gmsltlcH79u3W+QDTkLS6KwltdED/OCP9k82dycBEvWzN6iyzI65d+yobNmWPoZ9ShXyU/792Bt0plWVBKZz8nWk0NqFB920wxiHdafossQH0J0YCcS9CHZUwGHz7PadywoO+k8uRPcApJSy7/ovOvmlJhvtjfiNbZANE3JF2gvKCYoEQW+ZHoDrD4p6H7rGkuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OtMQ29h7Lk9QzHwCmJLYeJ799q5fNEMHc8rySqMW+Ac=;
 b=nWq1hsuH+W1wJAiajLLhabUsE5yW9rw3JgogqYc9RZfrxGGlCsC20Vhts7/n/R8qrY5wq4Nw45POGwyNjLhsjPP0b2Ywr4gzS9EMsGmLAW9Ue7B+Xc4zDeikLyqxoP7sPokS9gUwxXFVRfXqpb1jVmTJw46sIcXO22ULj290q7HKOTMgWa7Ek8X+mcLDYRwsyGtwSM9q82tQxmE1Kb+4lkMFezRrNL9k/ktLHEjbywXgy/8wtKfMG7OcWOCEJa8ZfS22fWlqfad3B6U86aI5XD3L6VQmtOjdNLiDXWZC31TDnDmmms7E3GsCFja0z9ZP0nMXmFtsRYvsVoQxJJDsNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OtMQ29h7Lk9QzHwCmJLYeJ799q5fNEMHc8rySqMW+Ac=;
 b=Zb/qEBETTCSUIkkPV9FQk8DpFzgIIoI598uBAZ06TOmITLtMKSOtOd8fcR/v4WE05cbZgF3BC88TvB/tNEGW+Ii+Zt/P9D2Q0nfCkNJVhFuu8DuOeeOUR/qyzDiosWtgk+Cdp7/aejM4qMHzx5ID/XdBMCSz/Tj5y/lIvI7f6l1b3/Cw4L6+l6QgxotAhOs5hTcqStDLgSb+8Rdn+lnubEUDy6+uUnwFkoPbFL560iEQBsaD1B0DoL7dBtvCIhwuaPf5NVkwcM1ofeU+UZSGr4KXCN7g0Xe0REZgpEthWFgwAIXWg5UpiVj1xZQgPCeuYg9AijQS3fYzqSnhgMkr3A==
Received: from DM6PR06CA0004.namprd06.prod.outlook.com (2603:10b6:5:120::17)
 by DM4PR12MB6615.namprd12.prod.outlook.com (2603:10b6:8:8d::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5813.13; Mon, 14 Nov 2022 13:18:25 +0000
Received: from DM6NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:120:cafe::a0) by DM6PR06CA0004.outlook.office365.com
 (2603:10b6:5:120::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17 via Frontend
 Transport; Mon, 14 Nov 2022 13:18:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DM6NAM11FT009.mail.protection.outlook.com (10.13.173.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5813.12 via Frontend Transport; Mon, 14 Nov 2022 13:18:25 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 14 Nov
 2022 05:18:18 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Mon, 14 Nov 2022 05:18:17 -0800
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.36 via Frontend
 Transport; Mon, 14 Nov 2022 05:18:15 -0800
From:   Eli Cohen <elic@nvidia.com>
To:     <mst@redhat.com>, <jasowang@redhat.com>,
        <linux-kernel@vger.kernel.org>,
        <virtualization@lists.linux-foundation.org>
CC:     <si-wei.liu@oracle.com>, <eperezma@redhat.com>, <lulu@redhat.com>,
        "Eli Cohen" <elic@nvidia.com>
Subject: [PATH v2 5/8] vdpa/mlx5: Avoid overwriting CVQ iotlb
Date:   Mon, 14 Nov 2022 15:17:56 +0200
Message-ID: <20221114131759.57883-6-elic@nvidia.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221114131759.57883-1-elic@nvidia.com>
References: <20221114131759.57883-1-elic@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT009:EE_|DM4PR12MB6615:EE_
X-MS-Office365-Filtering-Correlation-Id: 72a29b43-bd70-4481-79a6-08dac642b674
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A1AP4VzRd+1BQzCfrxMTwd23/tWR1iOYlj3/zBBhj9hO9rcwiOgwvLZl5YQZLk/PPJkdbTMc4L+zfE6LJDIbeMyJWeJPLCCxZaTEHEOfv5/TE7tJGhV496tXRxT0mMB/l26GkDIL3ZhSvNqa5Fj+Dj9WKJYiHyKqASCTXPzsKqxYSA5jKNAJN0IhEsxSGoMmZ2eqlekKewP/EhFHqfQicHlzTpDbLP7OULFWqAgKGa9dkx0vn4vBRzl7hQB9AhYZWl3oVwd1KoaJ2HmfjFHEb2oMgbUIEsPPykM4ssCca93kJ5eluVUBS8EMpYU4urfiFRK/yoNhVqWbRA65k4/YfASnFUyN6IzNgYehcPKaOAxu56CSgnZP2sgyl2KpNXhvqDJu7ncIDRsmn8ExEUIOK1weuwq43W+jRDSBIve+0/+Evj4+wbkUtK85DmJtC1nXGYSAgYMx72OoP0tp7Dzy7VtUCx1korDQpX7KsXXLGt5IXX2IwXFl0+5BBTBkBepRVNq037KlUjbI9R0AOCamyJdX7nvwc3SokGRs9PmFqxz3buU0lUX+jmfqD6+9cfSyb9BGqdnYb4YyF8TMPXU0xYJvPTRyeJvxzgUAxobCI+x++qgUzBWOrqGunv8kInrVIpL2UAI9iK0Er8l1JwGiR0HVl85rWOjwNK2tFsIVF926nP65UqfaghGbViwjFXJFeJXINzjzeULzSaN1gMfETspr76gGG3lrZF5N6xl0XGn1+6hpouRgClfVWHa4CpaVC5gConXxXqMWZy4afg94Rg==
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(39860400002)(136003)(396003)(451199015)(46966006)(36840700001)(40470700004)(41300700001)(478600001)(8936002)(107886003)(356005)(7696005)(6666004)(83380400001)(26005)(82740400003)(5660300002)(36756003)(86362001)(36860700001)(110136005)(316002)(54906003)(336012)(70206006)(7636003)(2906002)(8676002)(4326008)(70586007)(186003)(1076003)(2616005)(40480700001)(426003)(66574015)(82310400005)(47076005)(40460700003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2022 13:18:25.6011
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 72a29b43-bd70-4481-79a6-08dac642b674
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6615
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When qemu uses different address spaces for data and control virtqueues,
the current code would overwrite the control virtqueue iotlb through the
dup_iotlb call. Fix this by referring to the address space identifier
and the group to asid mapping to determine which mapping needs to be
updated. We also move the address space logic from mlx5 net to core
directory.

Reported-by: Eugenio Pérez <eperezma@redhat.com>
Signed-off-by: Eli Cohen <elic@nvidia.com>
---
 drivers/vdpa/mlx5/core/mlx5_vdpa.h |  5 +--
 drivers/vdpa/mlx5/core/mr.c        | 44 ++++++++++++++++-----------
 drivers/vdpa/mlx5/net/mlx5_vnet.c  | 49 ++++++------------------------
 3 files changed, 39 insertions(+), 59 deletions(-)

diff --git a/drivers/vdpa/mlx5/core/mlx5_vdpa.h b/drivers/vdpa/mlx5/core/mlx5_vdpa.h
index 6af9fdbb86b7..058fbe28107e 100644
--- a/drivers/vdpa/mlx5/core/mlx5_vdpa.h
+++ b/drivers/vdpa/mlx5/core/mlx5_vdpa.h
@@ -116,8 +116,9 @@ int mlx5_vdpa_create_mkey(struct mlx5_vdpa_dev *mvdev, u32 *mkey, u32 *in,
 			  int inlen);
 int mlx5_vdpa_destroy_mkey(struct mlx5_vdpa_dev *mvdev, u32 mkey);
 int mlx5_vdpa_handle_set_map(struct mlx5_vdpa_dev *mvdev, struct vhost_iotlb *iotlb,
-			     bool *change_map);
-int mlx5_vdpa_create_mr(struct mlx5_vdpa_dev *mvdev, struct vhost_iotlb *iotlb);
+			     bool *change_map, unsigned int asid);
+int mlx5_vdpa_create_mr(struct mlx5_vdpa_dev *mvdev, struct vhost_iotlb *iotlb,
+			unsigned int asid);
 void mlx5_vdpa_destroy_mr(struct mlx5_vdpa_dev *mvdev);
 
 #define mlx5_vdpa_warn(__dev, format, ...)                                                         \
diff --git a/drivers/vdpa/mlx5/core/mr.c b/drivers/vdpa/mlx5/core/mr.c
index a639b9208d41..a4d7ee2339fa 100644
--- a/drivers/vdpa/mlx5/core/mr.c
+++ b/drivers/vdpa/mlx5/core/mr.c
@@ -511,7 +511,8 @@ void mlx5_vdpa_destroy_mr(struct mlx5_vdpa_dev *mvdev)
 	mutex_unlock(&mr->mkey_mtx);
 }
 
-static int _mlx5_vdpa_create_mr(struct mlx5_vdpa_dev *mvdev, struct vhost_iotlb *iotlb)
+static int _mlx5_vdpa_create_mr(struct mlx5_vdpa_dev *mvdev,
+				struct vhost_iotlb *iotlb, unsigned int asid)
 {
 	struct mlx5_vdpa_mr *mr = &mvdev->mr;
 	int err;
@@ -519,42 +520,49 @@ static int _mlx5_vdpa_create_mr(struct mlx5_vdpa_dev *mvdev, struct vhost_iotlb
 	if (mr->initialized)
 		return 0;
 
-	if (iotlb)
-		err = create_user_mr(mvdev, iotlb);
-	else
-		err = create_dma_mr(mvdev, mr);
+	if (mvdev->group2asid[MLX5_VDPA_DATAVQ_GROUP] == asid) {
+		if (iotlb)
+			err = create_user_mr(mvdev, iotlb);
+		else
+			err = create_dma_mr(mvdev, mr);
 
-	if (err)
-		return err;
+		if (err)
+			return err;
+	}
 
-	err = dup_iotlb(mvdev, iotlb);
-	if (err)
-		goto out_err;
+	if (mvdev->group2asid[MLX5_VDPA_CVQ_GROUP] == asid) {
+		err = dup_iotlb(mvdev, iotlb);
+		if (err)
+			goto out_err;
+	}
 
 	mr->initialized = true;
 	return 0;
 
 out_err:
-	if (iotlb)
-		destroy_user_mr(mvdev, mr);
-	else
-		destroy_dma_mr(mvdev, mr);
+	if (mvdev->group2asid[MLX5_VDPA_DATAVQ_GROUP] == asid) {
+		if (iotlb)
+			destroy_user_mr(mvdev, mr);
+		else
+			destroy_dma_mr(mvdev, mr);
+	}
 
 	return err;
 }
 
-int mlx5_vdpa_create_mr(struct mlx5_vdpa_dev *mvdev, struct vhost_iotlb *iotlb)
+int mlx5_vdpa_create_mr(struct mlx5_vdpa_dev *mvdev, struct vhost_iotlb *iotlb,
+			unsigned int asid)
 {
 	int err;
 
 	mutex_lock(&mvdev->mr.mkey_mtx);
-	err = _mlx5_vdpa_create_mr(mvdev, iotlb);
+	err = _mlx5_vdpa_create_mr(mvdev, iotlb, asid);
 	mutex_unlock(&mvdev->mr.mkey_mtx);
 	return err;
 }
 
 int mlx5_vdpa_handle_set_map(struct mlx5_vdpa_dev *mvdev, struct vhost_iotlb *iotlb,
-			     bool *change_map)
+			     bool *change_map, unsigned int asid)
 {
 	struct mlx5_vdpa_mr *mr = &mvdev->mr;
 	int err = 0;
@@ -566,7 +574,7 @@ int mlx5_vdpa_handle_set_map(struct mlx5_vdpa_dev *mvdev, struct vhost_iotlb *io
 		*change_map = true;
 	}
 	if (!*change_map)
-		err = _mlx5_vdpa_create_mr(mvdev, iotlb);
+		err = _mlx5_vdpa_create_mr(mvdev, iotlb, asid);
 	mutex_unlock(&mr->mkey_mtx);
 
 	return err;
diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index 98dd8ce8af26..3a6dbbc6440d 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -2394,7 +2394,8 @@ static void restore_channels_info(struct mlx5_vdpa_net *ndev)
 	}
 }
 
-static int mlx5_vdpa_change_map(struct mlx5_vdpa_dev *mvdev, struct vhost_iotlb *iotlb)
+static int mlx5_vdpa_change_map(struct mlx5_vdpa_dev *mvdev,
+				struct vhost_iotlb *iotlb, unsigned int asid)
 {
 	struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
 	int err;
@@ -2406,7 +2407,7 @@ static int mlx5_vdpa_change_map(struct mlx5_vdpa_dev *mvdev, struct vhost_iotlb
 
 	teardown_driver(ndev);
 	mlx5_vdpa_destroy_mr(mvdev);
-	err = mlx5_vdpa_create_mr(mvdev, iotlb);
+	err = mlx5_vdpa_create_mr(mvdev, iotlb, asid);
 	if (err)
 		goto err_mr;
 
@@ -2587,7 +2588,7 @@ static int mlx5_vdpa_reset(struct vdpa_device *vdev)
 	++mvdev->generation;
 
 	if (MLX5_CAP_GEN(mvdev->mdev, umem_uid_0)) {
-		if (mlx5_vdpa_create_mr(mvdev, NULL))
+		if (mlx5_vdpa_create_mr(mvdev, NULL, 0))
 			mlx5_vdpa_warn(mvdev, "create MR failed\n");
 	}
 	up_write(&ndev->reslock);
@@ -2623,41 +2624,20 @@ static u32 mlx5_vdpa_get_generation(struct vdpa_device *vdev)
 	return mvdev->generation;
 }
 
-static int set_map_control(struct mlx5_vdpa_dev *mvdev, struct vhost_iotlb *iotlb)
-{
-	u64 start = 0ULL, last = 0ULL - 1;
-	struct vhost_iotlb_map *map;
-	int err = 0;
-
-	spin_lock(&mvdev->cvq.iommu_lock);
-	vhost_iotlb_reset(mvdev->cvq.iotlb);
-
-	for (map = vhost_iotlb_itree_first(iotlb, start, last); map;
-	     map = vhost_iotlb_itree_next(map, start, last)) {
-		err = vhost_iotlb_add_range(mvdev->cvq.iotlb, map->start,
-					    map->last, map->addr, map->perm);
-		if (err)
-			goto out;
-	}
-
-out:
-	spin_unlock(&mvdev->cvq.iommu_lock);
-	return err;
-}
-
-static int set_map_data(struct mlx5_vdpa_dev *mvdev, struct vhost_iotlb *iotlb)
+static int set_map_data(struct mlx5_vdpa_dev *mvdev, struct vhost_iotlb *iotlb,
+			unsigned int asid)
 {
 	bool change_map;
 	int err;
 
-	err = mlx5_vdpa_handle_set_map(mvdev, iotlb, &change_map);
+	err = mlx5_vdpa_handle_set_map(mvdev, iotlb, &change_map, asid);
 	if (err) {
 		mlx5_vdpa_warn(mvdev, "set map failed(%d)\n", err);
 		return err;
 	}
 
 	if (change_map)
-		err = mlx5_vdpa_change_map(mvdev, iotlb);
+		err = mlx5_vdpa_change_map(mvdev, iotlb, asid);
 
 	return err;
 }
@@ -2670,16 +2650,7 @@ static int mlx5_vdpa_set_map(struct vdpa_device *vdev, unsigned int asid,
 	int err = -EINVAL;
 
 	down_write(&ndev->reslock);
-	if (mvdev->group2asid[MLX5_VDPA_DATAVQ_GROUP] == asid) {
-		err = set_map_data(mvdev, iotlb);
-		if (err)
-			goto out;
-	}
-
-	if (mvdev->group2asid[MLX5_VDPA_CVQ_GROUP] == asid)
-		err = set_map_control(mvdev, iotlb);
-
-out:
+	err = set_map_data(mvdev, iotlb, asid);
 	up_write(&ndev->reslock);
 	return err;
 }
@@ -3182,7 +3153,7 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
 		goto err_mpfs;
 
 	if (MLX5_CAP_GEN(mvdev->mdev, umem_uid_0)) {
-		err = mlx5_vdpa_create_mr(mvdev, NULL);
+		err = mlx5_vdpa_create_mr(mvdev, NULL, 0);
 		if (err)
 			goto err_res;
 	}
-- 
2.38.1

