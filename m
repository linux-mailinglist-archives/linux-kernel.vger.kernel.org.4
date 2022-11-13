Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F1FA626FD6
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Nov 2022 14:46:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235423AbiKMNqH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 08:46:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235418AbiKMNpp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 08:45:45 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2087.outbound.protection.outlook.com [40.107.244.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE1F411C2F
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 05:45:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vhf63zD5UTYFwzLMInP8E3aicbpkki227970nEBvOFPdX0eWtD46Rwfsp9XqITUwJTyiYhUptnPyPiS0IDxKKDlji9WpM7/8a+/XV1EJAPBismARgZ9wrMj8g5EtYlOYnGk3R1HVQRAQawvV6nbN7pMvZkvILChxdd3nsHT/nrIDMbi9BxeeGWwMZoS0D8AF12ZaQ9MxakdLACTSnxAelbeROu5cFKM2pLotsos5xOoyhHoHHEOS1ZvYdADcXXkqz5Zvt5LJGUZeAyQgb7zb49MIf/+Decpj5qfpYar+lYriP2j3djub9x2WzL9D5m4iN1NGWhgLMYvv9Lj5VvFpIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yCKTa8sf3HmP8m8UwYFV1AyaAU6GY+3vj6gQhujZFsE=;
 b=KhOeVDMEJOjN14k93XnqQEgmB68Y/qwZUiLWI4VAaCzDM/8I0reY2c1nR1L3vRA/cHasPVIN24ZsTsRL3fueghhpUtYoccWsldpHXAOB2LOH3w1XDNujSbSefSFUDJlJggODgvMeQwDduu+/xwjUOJRr5C0qDY9OPXVu+6OSsyAUMxV54PDJyDcFcyo4wnDRpZuMcNGXAYt3moSOu5DyEfnprhx3Q/8v4JpOElh4Q0z46UswPCqGMjghwYAquU/cg3kHIHkyMWVy5JLsHQq3anISB0gfsGXn2WiazHbJX9uYaJXPNuRS4Ts1415pHeoQ+kfqwEQ7st94x5OJTS28Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yCKTa8sf3HmP8m8UwYFV1AyaAU6GY+3vj6gQhujZFsE=;
 b=Y2Q5EX+xuJm8epsjR4SyDBYlVUuiUo/DAyozHc8vSo2tWhz4ShEhl1iwuenBXBAQMD4Mgij+8ekd08sSakdJTKsOv2o5DBpji3F1CutlqrCfr0sWRLOSXLChI3IwLzTFzjEa8SY00cl+4yBbv3cmOtK/WezKLKkXID5DkbnOLuYDb0N2GfJf3xtEFQXIKQ6bwcjqTuI27nuAa1AO5eDtCvU/sEb7vO8SXzO1Spa1R5p8OFlVODbEXakfY32BbcN2B/k6otVBZBGwJZjiUadfKhOAK19qkyXPJlQJNrgszp6nZYFNAEO4Tz58RoBR52n7C/7YdSKHTPmsQhc/yU0qTA==
Received: from BL1PR13CA0443.namprd13.prod.outlook.com (2603:10b6:208:2c3::28)
 by DS7PR12MB5935.namprd12.prod.outlook.com (2603:10b6:8:7e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Sun, 13 Nov
 2022 13:45:30 +0000
Received: from BL02EPF0000C405.namprd05.prod.outlook.com
 (2603:10b6:208:2c3:cafe::2d) by BL1PR13CA0443.outlook.office365.com
 (2603:10b6:208:2c3::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17 via Frontend
 Transport; Sun, 13 Nov 2022 13:45:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0000C405.mail.protection.outlook.com (10.167.241.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5813.11 via Frontend Transport; Sun, 13 Nov 2022 13:45:30 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Sun, 13 Nov
 2022 05:45:09 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Sun, 13 Nov
 2022 05:45:07 -0800
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.986.36 via Frontend Transport; Sun, 13 Nov
 2022 05:45:04 -0800
From:   Eli Cohen <elic@nvidia.com>
To:     <mst@redhat.com>, <jasowang@redhat.com>,
        <linux-kernel@vger.kernel.org>,
        <virtualization@lists.linux-foundation.org>
CC:     <si-wei.liu@oracle.com>, <eperezma@redhat.com>, <lulu@redhat.com>,
        "Eli Cohen" <elic@nvidia.com>
Subject: [PATCH 7/7] vdpa/mlx5: Avoid overwriting CVQ iotlb
Date:   Sun, 13 Nov 2022 15:44:42 +0200
Message-ID: <20221113134442.152695-8-elic@nvidia.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221113134442.152695-1-elic@nvidia.com>
References: <20221113134442.152695-1-elic@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0000C405:EE_|DS7PR12MB5935:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e2de4d0-294a-4cc1-aecc-08dac57d5496
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Hm6Niqhj05U7b2D4lIdhtTUwRr5/IdWKIRTcuKgeasZow2diBH/nZRf0W+7E10S9TThdmJGPbpsM9iUF9ada1P2r1INXgeTohwP+mYLBflsL1B0q0sxNLv35KNirf0W3GT42KR5x//ZzWx0hH4vqC9zBgWlncz5OikMbHeoP8xZUWtZekluI4hEuaCoT/O6wjvEAvMabq9i2RY70DAVjvl3fOLpB4DK2T9GXs1majPgMAp1/54Nn40BrUshWPRSo/BoYZT9oBPCVniSMYBRqGeeAZ8lphp+gpNCOFqk2itifzxCXDanRvh8YaHL3wgsGxQjw5QKjzOcSZx/mgpTLEawKQxMV6JbUQFVc8s0IyiuJmecO38wQaVHkWlbRdfdpkY09P/ajXztOeioPlHR/GFjoL46UR93JRLzYRnr2xEyyCh6bcOP+902ZHJ+mT6kGs+Im0BMCFSFJb1FeXTjX8iwntDTMXox0h3YH8Wmw2Xk2OpxxbITd5vB+oJxCziHGDypjkIlRNMWaS6cRyniqtWITLjjTa0wBWkDgEyNRxC01poSDCyHvJ6A8JOsk0HQ//60ZWGlt8jLUILyzI+Qxn4IQB+kljlTIzyjq14ZqoSgxU2l6jDYOx+eA1SE/EWWM9D7k6LJxQ7krIF4zBR8UfMm8ez75xDzyvi/gp+hBH4/XJ0Zayuf/7XrB5kwpRX9LoWPiFDVuXVtLIb4dV7BXmaW6GZ9Eq3BxO6QFGxqLqyIQWD7W4F7sq10vr/q4saKAem90PQGkAtYvx+1hmMOMUg==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(396003)(39860400002)(136003)(451199015)(40470700004)(46966006)(36840700001)(7696005)(40480700001)(26005)(6666004)(478600001)(107886003)(54906003)(110136005)(36756003)(4326008)(70206006)(70586007)(8676002)(41300700001)(186003)(336012)(426003)(2616005)(1076003)(316002)(40460700003)(83380400001)(47076005)(66574015)(8936002)(356005)(5660300002)(36860700001)(82740400003)(86362001)(82310400005)(2906002)(7636003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2022 13:45:30.5061
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e2de4d0-294a-4cc1-aecc-08dac57d5496
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0000C405.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5935
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
index bebfba530247..fc825958ab0c 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -2421,7 +2421,8 @@ static void restore_channels_info(struct mlx5_vdpa_net *ndev)
 	}
 }
 
-static int mlx5_vdpa_change_map(struct mlx5_vdpa_dev *mvdev, struct vhost_iotlb *iotlb)
+static int mlx5_vdpa_change_map(struct mlx5_vdpa_dev *mvdev,
+				struct vhost_iotlb *iotlb, unsigned int asid)
 {
 	struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
 	int err;
@@ -2433,7 +2434,7 @@ static int mlx5_vdpa_change_map(struct mlx5_vdpa_dev *mvdev, struct vhost_iotlb
 
 	teardown_driver(ndev);
 	mlx5_vdpa_destroy_mr(mvdev);
-	err = mlx5_vdpa_create_mr(mvdev, iotlb);
+	err = mlx5_vdpa_create_mr(mvdev, iotlb, asid);
 	if (err)
 		goto err_mr;
 
@@ -2614,7 +2615,7 @@ static int mlx5_vdpa_reset(struct vdpa_device *vdev)
 	++mvdev->generation;
 
 	if (MLX5_CAP_GEN(mvdev->mdev, umem_uid_0)) {
-		if (mlx5_vdpa_create_mr(mvdev, NULL))
+		if (mlx5_vdpa_create_mr(mvdev, NULL, 0))
 			mlx5_vdpa_warn(mvdev, "create MR failed\n");
 	}
 	up_write(&ndev->reslock);
@@ -2650,41 +2651,20 @@ static u32 mlx5_vdpa_get_generation(struct vdpa_device *vdev)
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
@@ -2697,16 +2677,7 @@ static int mlx5_vdpa_set_map(struct vdpa_device *vdev, unsigned int asid,
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
@@ -3209,7 +3180,7 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
 		goto err_mpfs;
 
 	if (MLX5_CAP_GEN(mvdev->mdev, umem_uid_0)) {
-		err = mlx5_vdpa_create_mr(mvdev, NULL);
+		err = mlx5_vdpa_create_mr(mvdev, NULL, 0);
 		if (err)
 			goto err_res;
 	}
-- 
2.38.1

