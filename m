Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CBC6628122
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 14:19:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237365AbiKNNTS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 08:19:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237317AbiKNNSh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 08:18:37 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D95EFE18
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 05:18:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QzzOuxbuXGQZfSzzsen76RiHndeDfUkc7/GV5RvxU0k4+1tU0ookiZ//oomQWhKvlSA4hVhodcA36VkgMeKWak68JmmxL5YyS3zL3DQ2S6Vn6H2VIP66kvpZag/fVjH/CLsKHtJiFoc2k8cVgKGsUBb3XoTU8+fKbVP4xaMY0mzJqoRuaESCUvGXtSh5CG9Uty9YbHpFjTNZ418hfBdCxd9yTyTXWy/+OYg1cXxmW7I2WZ6yRwxjDknoERZfjgdjf8vfgFfxrvk6CWO4dfp2dGZVH81rHjNu0b/dY3Lrcm/2pDWEpH6T8Z3+hcpYawiSntbVfKspjFLeeKWp7nvzsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2HuEBS6YZ1fJlswcDZL2OomEd9iZZrSxsPT7XHaH4wc=;
 b=Z3kQHSRYlVo6ozeKCdRqXTfhO9D/evRJH884++ZLYwcvgn8/hEOxqZHzDwZmW4ZdUywP8bdqDFOTYh3oXOSQv3AVjnDZo5I6fuZFDsbaq+FVO+R2Wj8Z61xaLVw3RJjB/BFz/hG/WbbLXSQEHhmECDPWg+Mg65vK0MksQeAcwJmT2VFa7METciZkJNgh2QTWx/xY9nzu1R7ehHgCelOtC3JSGOu8FTfQ02YUs+RCQlB/wmYc879+INQ2/MNYcZLqe8nWSifpSbl+Jxg4VN7hi+e2to4QgUWjJr/s2oeTVX4UnHdg4pkLNLh0Agb5omLYTRMrfJdkxJzw/6ZFQCAlYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2HuEBS6YZ1fJlswcDZL2OomEd9iZZrSxsPT7XHaH4wc=;
 b=nM8ynCBlex33wGw1s0MSxybzRD4HjY2frnV7CVzmb/chTGwpwWRS1tGvjDw/RacZRq7mP+BXLedRyvwNFd6ea6eJHrinuqjArjzwMFKzz3tAaIQzgZSZC9t1ZUcF+m+72Er0gGr8TEGwdpsRtGVQ1JoMps734IW7I8id8ZEMgjx5PIQwovU21IU897V8QMV7EH1ISoPUDZUklglEEzIbjHJQ2m0dJR54KqgSO89byb2Eurb4iMCGj+BdoDpAWSm+oIXQgCOu0MZGpbsEN++fo8cCEBTVXI42SnqvuQUeDgZs08x0qGoG6/7V+FuHnSC9VXHwYk0JxvIqzWymbzMyag==
Received: from DM6PR08CA0022.namprd08.prod.outlook.com (2603:10b6:5:80::35) by
 SN7PR12MB7276.namprd12.prod.outlook.com (2603:10b6:806:2af::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5813.17; Mon, 14 Nov 2022 13:18:32 +0000
Received: from DS1PEPF0000E65A.namprd02.prod.outlook.com
 (2603:10b6:5:80:cafe::1) by DM6PR08CA0022.outlook.office365.com
 (2603:10b6:5:80::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17 via Frontend
 Transport; Mon, 14 Nov 2022 13:18:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DS1PEPF0000E65A.mail.protection.outlook.com (10.167.18.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5813.11 via Frontend Transport; Mon, 14 Nov 2022 13:18:32 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 14 Nov
 2022 05:18:23 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Mon, 14 Nov 2022 05:18:23 -0800
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.36 via Frontend
 Transport; Mon, 14 Nov 2022 05:18:21 -0800
From:   Eli Cohen <elic@nvidia.com>
To:     <mst@redhat.com>, <jasowang@redhat.com>,
        <linux-kernel@vger.kernel.org>,
        <virtualization@lists.linux-foundation.org>
CC:     <si-wei.liu@oracle.com>, <eperezma@redhat.com>, <lulu@redhat.com>,
        "Eli Cohen" <elic@nvidia.com>
Subject: [PATH v2 7/8] vdpa/mlx5: Add debugfs subtree
Date:   Mon, 14 Nov 2022 15:17:58 +0200
Message-ID: <20221114131759.57883-8-elic@nvidia.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221114131759.57883-1-elic@nvidia.com>
References: <20221114131759.57883-1-elic@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E65A:EE_|SN7PR12MB7276:EE_
X-MS-Office365-Filtering-Correlation-Id: 7482836f-459f-4300-d6a5-08dac642ba87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TuspzEZcsgITibLtTV5RcxgrmS84iM+qA6/oqEP/PWBVSb7ZXNX8uIxUWsHcGPkc8oXVSNvqcFyhMkZyvyrZpKfm35l/pmjv2iMLoEIvaUjSgtouG3Wz5P/MBgPSFTdWkKTOKNxhNIPG4T8KtgWie9MXaUkLy8tSU5POkRUVSU3hRW6Anf4D6ZVYegrOrUEq7ktJ+5Q7CqrtpMttf0TYRhBAYqsOoQoy3Se2N8l5hLh29gLlgSvsj3pR6hydH/jd2Iql5i3c7Ibj50AtiS+z5P6+DNxileMQf2qxthDm8iRvFE5WxwGpEVPpcxJqO0Xc1DLt10G9xuJ/fUcMZ7iERd+4s7F1nlYTJcw59IFEP/W8nUPhFCiU1kp1V1XR1D5qHex++slxDH1IexE9JGLdJGw1ze/1WLjlPVi/yyV3cymbKvCnd56QXFhJ+Xe8ponJxla+O2hnxs7cTjNF3aayjoT1zSklp+NbPLR4lXoYjJLbm11od5+WRGlkMfe1JhQOLsf3RoDUlBRUr2OApBhQ7hD5vBPHAzaosO5OImJI3Eh9tVQYZS66axbJmXtXPV2q8cNNse/O0BoGDyQcOu/uUIrfTMK2mQkBp4AVEF0fqQI5e9yvuivw5qd9R2Tms4EsA0/xYv80GJkS+E4Ak1tvFq/iWASjLwyh/U2t5XIm6cOZxlwlS5NQu9Ut7UkxJYAxJQHE8ALOOYRZsKIB6Dq1K+CXzQpGikl84eOjGMG1fRA6Fp8fg3nr3sAfmfCyJladNjoDzHBRPisTow9qbFxvLw==
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(346002)(396003)(39860400002)(451199015)(40470700004)(46966006)(36840700001)(478600001)(86362001)(6666004)(107886003)(82740400003)(36860700001)(7636003)(40480700001)(186003)(2616005)(1076003)(26005)(426003)(40460700003)(7696005)(5660300002)(82310400005)(316002)(36756003)(336012)(54906003)(8936002)(41300700001)(110136005)(47076005)(4326008)(70586007)(70206006)(8676002)(356005)(83380400001)(2906002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2022 13:18:32.4545
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7482836f-459f-4300-d6a5-08dac642ba87
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E65A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7276
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add debugfs subtree and expose flow table ID and TIR number. This
information can be used by external tools to do extended
troubleshooting.

The information can be retrieved like so:
$ cat /sys/kernel/debug/mlx5/mlx5_core.sf.1/vdpa-0/rx/table_id
$ cat /sys/kernel/debug/mlx5/mlx5_core.sf.1/vdpa-0/rx/tirn

Reviewed-by: Si-Wei Liu <si-wei.liu@oracle.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Eli Cohen <elic@nvidia.com>
---
 drivers/vdpa/mlx5/Makefile        |  2 +-
 drivers/vdpa/mlx5/net/debug.c     | 66 +++++++++++++++++++++++++++++++
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 11 ++++++
 drivers/vdpa/mlx5/net/mlx5_vnet.h |  9 +++++
 4 files changed, 87 insertions(+), 1 deletion(-)
 create mode 100644 drivers/vdpa/mlx5/net/debug.c

diff --git a/drivers/vdpa/mlx5/Makefile b/drivers/vdpa/mlx5/Makefile
index f717978c83bf..e791394c33e3 100644
--- a/drivers/vdpa/mlx5/Makefile
+++ b/drivers/vdpa/mlx5/Makefile
@@ -1,4 +1,4 @@
 subdir-ccflags-y += -I$(srctree)/drivers/vdpa/mlx5/core
 
 obj-$(CONFIG_MLX5_VDPA_NET) += mlx5_vdpa.o
-mlx5_vdpa-$(CONFIG_MLX5_VDPA_NET) += net/mlx5_vnet.o core/resources.o core/mr.o
+mlx5_vdpa-$(CONFIG_MLX5_VDPA_NET) += net/mlx5_vnet.o core/resources.o core/mr.o net/debug.o
diff --git a/drivers/vdpa/mlx5/net/debug.c b/drivers/vdpa/mlx5/net/debug.c
new file mode 100644
index 000000000000..95e4801df211
--- /dev/null
+++ b/drivers/vdpa/mlx5/net/debug.c
@@ -0,0 +1,66 @@
+// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
+/* Copyright (c) 2022, NVIDIA CORPORATION & AFFILIATES. All rights reserved. */
+
+#include <linux/debugfs.h>
+#include <linux/mlx5/fs.h>
+#include "mlx5_vnet.h"
+
+static int tirn_show(struct seq_file *file, void *priv)
+{
+	struct mlx5_vdpa_net *ndev = file->private;
+
+	seq_printf(file, "0x%x\n", ndev->res.tirn);
+	return 0;
+}
+
+DEFINE_SHOW_ATTRIBUTE(tirn);
+
+void mlx5_vdpa_remove_tirn(struct mlx5_vdpa_net *ndev)
+{
+	if (ndev->debugfs)
+		debugfs_remove(ndev->res.tirn_dent);
+}
+
+void mlx5_vdpa_add_tirn(struct mlx5_vdpa_net *ndev)
+{
+	ndev->res.tirn_dent = debugfs_create_file("tirn", 0444, ndev->rx_dent,
+						  ndev, &tirn_fops);
+}
+
+static int rx_flow_table_show(struct seq_file *file, void *priv)
+{
+	struct mlx5_vdpa_net *ndev = file->private;
+
+	seq_printf(file, "0x%x\n", mlx5_flow_table_id(ndev->rxft));
+	return 0;
+}
+
+DEFINE_SHOW_ATTRIBUTE(rx_flow_table);
+
+void mlx5_vdpa_remove_rx_flow_table(struct mlx5_vdpa_net *ndev)
+{
+	if (ndev->debugfs)
+		debugfs_remove(ndev->rx_table_dent);
+}
+
+void mlx5_vdpa_add_rx_flow_table(struct mlx5_vdpa_net *ndev)
+{
+	ndev->rx_table_dent = debugfs_create_file("table_id", 0444, ndev->rx_dent,
+						  ndev, &rx_flow_table_fops);
+}
+
+void mlx5_vdpa_add_debugfs(struct mlx5_vdpa_net *ndev)
+{
+	struct mlx5_core_dev *mdev;
+
+	mdev = ndev->mvdev.mdev;
+	ndev->debugfs = debugfs_create_dir(dev_name(&ndev->mvdev.vdev.dev),
+					   mlx5_debugfs_get_dev_root(mdev));
+	if (!IS_ERR(ndev->debugfs))
+		ndev->rx_dent = debugfs_create_dir("rx", ndev->debugfs);
+}
+
+void mlx5_vdpa_remove_debugfs(struct dentry *dbg)
+{
+	debugfs_remove_recursive(dbg);
+}
diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index da54a188077d..4b097e6ddba0 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -1388,11 +1388,16 @@ static int create_tir(struct mlx5_vdpa_net *ndev)
 
 	err = mlx5_vdpa_create_tir(&ndev->mvdev, in, &ndev->res.tirn);
 	kfree(in);
+	if (err)
+		return err;
+
+	mlx5_vdpa_add_tirn(ndev);
 	return err;
 }
 
 static void destroy_tir(struct mlx5_vdpa_net *ndev)
 {
+	mlx5_vdpa_remove_tirn(ndev);
 	mlx5_vdpa_destroy_tir(&ndev->mvdev, ndev->res.tirn);
 }
 
@@ -1578,6 +1583,7 @@ static int setup_steering(struct mlx5_vdpa_net *ndev)
 		mlx5_vdpa_warn(&ndev->mvdev, "failed to create flow table\n");
 		return PTR_ERR(ndev->rxft);
 	}
+	mlx5_vdpa_add_rx_flow_table(ndev);
 
 	err = mac_vlan_add(ndev, ndev->config.mac, 0, false);
 	if (err)
@@ -1586,6 +1592,7 @@ static int setup_steering(struct mlx5_vdpa_net *ndev)
 	return 0;
 
 err_add:
+	mlx5_vdpa_remove_rx_flow_table(ndev);
 	mlx5_destroy_flow_table(ndev->rxft);
 	return err;
 }
@@ -1593,6 +1600,7 @@ static int setup_steering(struct mlx5_vdpa_net *ndev)
 static void teardown_steering(struct mlx5_vdpa_net *ndev)
 {
 	clear_mac_vlan_table(ndev);
+	mlx5_vdpa_remove_rx_flow_table(ndev);
 	mlx5_destroy_flow_table(ndev->rxft);
 }
 
@@ -3135,6 +3143,7 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
 	if (err)
 		goto err_reg;
 
+	mlx5_vdpa_add_debugfs(ndev);
 	mgtdev->ndev = ndev;
 	return 0;
 
@@ -3161,6 +3170,8 @@ static void mlx5_vdpa_dev_del(struct vdpa_mgmt_dev *v_mdev, struct vdpa_device *
 	struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
 	struct workqueue_struct *wq;
 
+	mlx5_vdpa_remove_debugfs(ndev->debugfs);
+	ndev->debugfs = NULL;
 	if (ndev->nb_registered) {
 		ndev->nb_registered = false;
 		mlx5_notifier_unregister(mvdev->mdev, &ndev->nb);
diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.h b/drivers/vdpa/mlx5/net/mlx5_vnet.h
index 6691c879a6ca..f2cef3925e5b 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.h
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.h
@@ -16,6 +16,7 @@ struct mlx5_vdpa_net_resources {
 	u32 tirn;
 	u32 rqtn;
 	bool valid;
+	struct dentry *tirn_dent;
 };
 
 #define MLX5V_MACVLAN_SIZE 256
@@ -43,6 +44,7 @@ struct mlx5_vdpa_net {
 	struct vdpa_callback config_cb;
 	struct mlx5_vdpa_wq_ent cvq_ent;
 	struct hlist_head macvlan_hash[MLX5V_MACVLAN_SIZE];
+	struct dentry *debugfs;
 };
 
 struct macvlan_node {
@@ -52,4 +54,11 @@ struct macvlan_node {
 	u64 macvlan;
 };
 
+void mlx5_vdpa_add_debugfs(struct mlx5_vdpa_net *ndev);
+void mlx5_vdpa_remove_debugfs(struct dentry *dbg);
+void mlx5_vdpa_add_rx_flow_table(struct mlx5_vdpa_net *ndev);
+void mlx5_vdpa_remove_rx_flow_table(struct mlx5_vdpa_net *ndev);
+void mlx5_vdpa_add_tirn(struct mlx5_vdpa_net *ndev);
+void mlx5_vdpa_remove_tirn(struct mlx5_vdpa_net *ndev);
+
 #endif /* __MLX5_VNET_H__ */
-- 
2.38.1

