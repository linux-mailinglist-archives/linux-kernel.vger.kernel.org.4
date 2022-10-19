Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CA2D604681
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 15:12:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233333AbiJSNL7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 09:11:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231523AbiJSNLj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 09:11:39 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2052.outbound.protection.outlook.com [40.107.94.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 794C31CC761
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 05:56:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fYJEy43uRpbGG9ztgzwQg/KvYJKR6+l9FfazZApg2XVECvlthqbhpD3/k1BxIkD6sQbVOuH8MnBj2xwXPf1naR7BPInpWmnSkBujkyiT4Nk5lXVtqSddgVRKjjN5hWhHUCCQDlJaEOQSLCNgQ+lP5wcm8SRxbolplJVfOMROWnzuTkzBnsnUXsu7u/OaN91gRDCSXFXdTLgebs4Hn/frSC0Wyz5jr/EFd2bvtjVyhTKNazum6lTYvqtu2/IMcEjKIu9fa3gITNdsLif9nNaNdZ9oMvoLJlvuiHWhDVvMOJhCqplVb2vSaOR5/kMsBJyw10PZv9EoSzeD6jkTrZ4iRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2xjSw/J7v1abqK+2JOTWDLp2G5ropTA9j/01cHayi3I=;
 b=AgPiyCDUdROfb2feX030/f9cvJ3ll2vbpm8pU4MwWLGLuITpN+l2KM5XWkuQHEs0R9CpuXZ41g91RdBW/m1pS/hbq3vCwXJWpg6ai3/rBvfZP8st0kQZ0SLxVTssOorM/IziZLskJ10+XDK9Q1M493A3QShcmfvhe7vEEf9bqthNezoMkOYGn02/T43hYw0DAILKkNorNvClLn0l898hLfMR/9VqBHoU6uxj/jGcoDoiQYsTQt5lefAga/Ug+MP9BB/rXctRut1izu4PmF8pgQF9wioz9+G7HIUEuY+WEG1Tm5z+oja0DhKc8bBBsrCRB6fMO6XTuhZgH9d4xd4siQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2xjSw/J7v1abqK+2JOTWDLp2G5ropTA9j/01cHayi3I=;
 b=awB7l0M7HNhNgPwq0TeqFl/tSjpqavwUIcjdQrRL0xdHnlYCfqvhwzhm63ft0PZ/BtGNoEWG3aKgPrCS1byhH8yVsZBaHazCeuVdLpvXrqDL4gdpm6/pBZ8NfpthAyg7/ehvRsm48yX28oOyPKt02kczQRMw3+QE9+uorUdtg+gn5Xlh8+mflVIbjPgnvPdwhVm3uby5znmb0NDKV+/Imse0k3uBqZ5rJPg63HhcqKtpjPmRf0mLnUGq57xx2kSW9xZIzC2M1cjQhHushh9vnrMjp6VwR+nCe3AxjePodlqScZHdVVLaJ/ZITLVJySMUFVkJ/yxFEsmW64+yozY/IQ==
Received: from DS7PR03CA0279.namprd03.prod.outlook.com (2603:10b6:5:3ad::14)
 by MN2PR12MB4581.namprd12.prod.outlook.com (2603:10b6:208:260::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.34; Wed, 19 Oct
 2022 12:55:31 +0000
Received: from DM6NAM11FT035.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3ad:cafe::21) by DS7PR03CA0279.outlook.office365.com
 (2603:10b6:5:3ad::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.32 via Frontend
 Transport; Wed, 19 Oct 2022 12:55:31 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=nvidia.com;
Received-SPF: None (protection.outlook.com: nvidia.com does not designate
 permitted sender hosts)
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT035.mail.protection.outlook.com (10.13.172.100) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5746.16 via Frontend Transport; Wed, 19 Oct 2022 12:55:31 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Wed, 19 Oct
 2022 05:55:15 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Wed, 19 Oct
 2022 05:55:15 -0700
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.986.29 via Frontend Transport; Wed, 19 Oct
 2022 05:55:12 -0700
From:   Eli Cohen <elic@nvidia.com>
To:     <mst@redhat.com>, <jasowang@redhat.com>,
        <linux-kernel@vger.kernel.org>,
        <virtualization@lists.linux-foundation.org>
CC:     <si-wei.liu@oracle.com>, <eperezma@redhat.com>, <lulu@redhat.com>,
        "Eli Cohen" <elic@nvidia.com>
Subject: [PATCH v2 resend 3/4] vdpa/mlx5: Add debugfs subtree
Date:   Wed, 19 Oct 2022 15:54:59 +0300
Message-ID: <20221019125500.208841-4-elic@nvidia.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221019125500.208841-1-elic@nvidia.com>
References: <20221019125500.208841-1-elic@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT035:EE_|MN2PR12MB4581:EE_
X-MS-Office365-Filtering-Correlation-Id: 48df3b8c-696b-4717-2d89-08dab1d13488
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4OV3lmCW8qQVN/tylGWJsnE+NYxxdnzAaI7wUryw+FTWGHjrjHpnveT5NqmbuQBCOnB71xshib7XD/a8FM6M9RhMRhzsuE/EGPcg8xnvY0EDF9epOTtpLm5KeanuQkoxCdBySMjiwKXjwm2PJIGUytzpH7UYUEoPnW67VBiBQnNiJlJZLYz7E2C6e5eLWteTuk50Z2qRlqk+EfZKkwS7ZAhjdOq7eWIXHJTO5gr9or/AoIoRqm8pAFqnJpXY9Dh1nj0GvWHGzLpzG1R9Dc/kdOIhlwec+1Nao4vbBCFz7z0gMk9hBuoHeIa/RMIjrcHJHuvvsQshQ8dV8K+w2is5xP8e+HEKKdIcMIFjahKUVYefxOyngF74DsOASafSqv4r7C6ao2tu2DrRrbpFgZF8htIBPSa3RQy2JNCF/m2noSHNzAlTcxgIDxj6/sRals6/PJF7/7hAcMAeV1LV3QyAMwhebNVs1VweFZG31ZdUzvJOxeLtuG587zkQHndCvsRkrPT1LERWIuTrlp0k6+JEXlGPOgL+4RIVxWhDPVXjbjnL8Qwmyw+OrMBPIEVSxADjhWJLkXNPlp5mmeW6UVfiW4bToABK4/pc7SPLeTtj7ouiO0glG9EeK5mNZPKXuBIUFgabkB58OxgiLb3RWdYS557fCIJfEFk3r07L/7HAtkBar4Z9Cu+s4uYeZ05/ltO7By8IUCj8Lxkr+oZR0uFBhllweoIc2E10TKENtg65BB3Rirw9f3HUu+xDm3Cby3ixP/h2c2+yhJYVorM1tlhG7w==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(346002)(396003)(39860400002)(451199015)(36840700001)(40470700004)(46966006)(186003)(26005)(7696005)(107886003)(6666004)(1076003)(2616005)(47076005)(426003)(83380400001)(336012)(2906002)(40480700001)(5660300002)(40460700003)(36860700001)(82310400005)(110136005)(54906003)(41300700001)(478600001)(316002)(8936002)(4326008)(8676002)(70206006)(70586007)(36756003)(86362001)(7636003)(356005)(82740400003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2022 12:55:31.2248
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 48df3b8c-696b-4717-2d89-08dab1d13488
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT035.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4581
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
index acd95f2d0ba3..b9353c642b85 100644
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
 
@@ -3172,6 +3180,7 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
 	if (err)
 		goto err_reg;
 
+	mlx5_vdpa_add_debugfs(ndev);
 	mgtdev->ndev = ndev;
 	return 0;
 
@@ -3198,6 +3207,8 @@ static void mlx5_vdpa_dev_del(struct vdpa_mgmt_dev *v_mdev, struct vdpa_device *
 	struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
 	struct workqueue_struct *wq;
 
+	mlx5_vdpa_remove_debugfs(ndev->debugfs);
+	ndev->debugfs = NULL;
 	if (ndev->nb_registered) {
 		mlx5_notifier_unregister(mvdev->mdev, &ndev->nb);
 		ndev->nb_registered = false;
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
2.35.1

