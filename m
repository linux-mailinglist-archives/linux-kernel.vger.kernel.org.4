Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 456B2626FD2
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Nov 2022 14:45:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235393AbiKMNpT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 08:45:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235375AbiKMNpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 08:45:12 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2073.outbound.protection.outlook.com [40.107.223.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEAAD1260C
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 05:45:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RRbq9+OrNPi/1JeCAVTxLwUwrmEhdVjasWZJyJOg0fX1AHGaruY4eVPMokVY3jFFDif9qfS7/Jpme6H9j6lFONFR/xkFQGFKhdXDwsJLrguLiBeWf4512oBFLHH2j/jcrOb1DsJ9IhGL7vRvf/80Pbfc76iJH5QTLi85odkvDa8Dcxcxara2XyNeUQXELAq8r/lzKnNZpKLXy6Fb7FQFG1DiNz9Ed9aSA5bWEp20pkuXNPvObS/snnABuREMZ6BtfvnBWvaVMcJob/+doWQ7Z0c54/Gs8nh2fpDd2AfGYzZztGghiMxOq7qpTzWFsRMCNQZUdgpM3WTVFPhCUKOJ8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iFPdbLXbxd8Pb0dLS+9Lv/xtvji5z8KdziOO5mlzAPM=;
 b=J1gWWQplDrVXff8lNpSbiuj9ZFwzLviYNsW6X8S6adEeFdOMoMtYukZTkvMWK24JqHdYHlBz0q8cHrnWX4PY+RikXER2MSvkO3ZRj6PDaaxkt3qtpJuwvMiqnQs7ErGNmVoApofNlqjgvm/dl+1qGdSnii+KDL76yP/cJ1nwFQZxzZ2NHPqAaDI2gTDOY19RIILDnBKnLhtP20bLkY0BJTocACnOPRSN5PilArOPcefwlwkFcSgy4h6hOq0UqZROUEQsGPCRVn10fuGxIkUbku91OJPnOuJYcMYyarL/pajqZrQONNFTmDEMCxZAStySDYhrjjmeR4Jpz9iT+rvtuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iFPdbLXbxd8Pb0dLS+9Lv/xtvji5z8KdziOO5mlzAPM=;
 b=p/QidDbkfGC3hTudaYeC2d7EqKoL4R8dC9lpLFd9sGqQbSs2eeyGH9Ge9/E6CFSQjyCp6BMcSmZO3GUvOYL8c5I2jmuAQ3sLcbc5DT032q8e61zAlSyOMJcHfVkoiNk8aSlBvW7r5EkLrSLPOb7zgS37YDa6LyulnEIV9eC0epv6OSbKpjmuiSkAZi1C9x4RgJasDBjTPNORfqmIP+Fp6/0WUuJuQ0Lmi162kCyUxKG1ywkboowfods+suqHrDpg2GZJvnbE5FgqycDuuNtFGyydnAbH+M7abtHbY3DTPrlXIHIXClN8D+JdeydGtKwzJW/CyRGjk5Yi2sG9jKmkTA==
Received: from MN2PR19CA0011.namprd19.prod.outlook.com (2603:10b6:208:178::24)
 by MN2PR12MB4047.namprd12.prod.outlook.com (2603:10b6:208:1de::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Sun, 13 Nov
 2022 13:45:09 +0000
Received: from BL02EPF0000C408.namprd05.prod.outlook.com
 (2603:10b6:208:178:cafe::b8) by MN2PR19CA0011.outlook.office365.com
 (2603:10b6:208:178::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.14 via Frontend
 Transport; Sun, 13 Nov 2022 13:45:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0000C408.mail.protection.outlook.com (10.167.241.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5813.11 via Frontend Transport; Sun, 13 Nov 2022 13:45:09 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Sun, 13 Nov
 2022 05:44:59 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Sun, 13 Nov
 2022 05:44:58 -0800
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.986.36 via Frontend Transport; Sun, 13 Nov
 2022 05:44:56 -0800
From:   Eli Cohen <elic@nvidia.com>
To:     <mst@redhat.com>, <jasowang@redhat.com>,
        <linux-kernel@vger.kernel.org>,
        <virtualization@lists.linux-foundation.org>
CC:     <si-wei.liu@oracle.com>, <eperezma@redhat.com>, <lulu@redhat.com>,
        "Eli Cohen" <elic@nvidia.com>
Subject: [PATCH 4/7] vdpa/mlx5: Add debugfs subtree
Date:   Sun, 13 Nov 2022 15:44:39 +0200
Message-ID: <20221113134442.152695-5-elic@nvidia.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221113134442.152695-1-elic@nvidia.com>
References: <20221113134442.152695-1-elic@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0000C408:EE_|MN2PR12MB4047:EE_
X-MS-Office365-Filtering-Correlation-Id: bf120d14-d24a-4a8a-d772-08dac57d4814
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xx2VRwxHKx/0zlKocaruNnPEkUi/7WG8wnd2mH8M4GBE0Qym45WqjPK8gPfep35WbVolp4kbmd45cTXw3GkUzgZMv2Z8xBV7vPcQO6WTh1qohqxDNxOApllbQ2SdgGjvUppzm4an1CfApwTlfTCdA5p4UhJSeecUsxif9E0T1zkytsHjyhWrciUR7X4J16MNSnJPtztYS8br6BEDrLJyWwWJYuC55FpGhLQ7nkeAez3BxnjEG4TYEmi6xKf+x8HmhEtTd3ZnzxnAAe8komH4RhuX04VlSjVKRqrvGsVSS8DppLLEXwSQnlrhp0m5VOzxiPN6v2gIuUNDi3s6VlHKvtOW+A3yxnGOK6hGQGX1zmK3jOrYq0cuEmyC3d6amGX8OpJJnj2i57zRHg5YxkB4MTQHcavdqBZVZhHqHlInvBY3OwpMmNDPLt0PMgjmn2AhL3HY28OPPz3uhRiMu9jdlIISzmpcgJCPdUVWXRz63ekAbI7NblS4B6TKFk+XXKUvPNeE8kAzHcpDLNq+Fw+fejzvg7mVdcNYVfpSfjmlSMYiQFJbhVsPXdkWAJATRv8ldYf+5GTKd4JyuA24zJASJVhxem2mP1GAr7aqSMXs4R4aABNoHRnQT40SEfLklwYx5lb5ucMbzMpJSqlnx1Veu816OWVM7TTSttSFHocZZ5kRbw29Wh24szD/Z46pl5yfqRorTgiFmySfTrfrX8W9tDZhHE6W8SYr78hLz4vy9hh5FwbZwsFR0y8Lw1QB+Xz1e5hZNwT7FNf+IqxJ7Nkyhg==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(136003)(39860400002)(346002)(451199015)(36840700001)(46966006)(40470700004)(82310400005)(40480700001)(36756003)(1076003)(186003)(82740400003)(2616005)(336012)(83380400001)(26005)(86362001)(8936002)(41300700001)(5660300002)(2906002)(478600001)(356005)(7636003)(36860700001)(40460700003)(110136005)(426003)(47076005)(316002)(107886003)(6666004)(7696005)(4326008)(8676002)(54906003)(70586007)(70206006);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2022 13:45:09.5225
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf120d14-d24a-4a8a-d772-08dac57d4814
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0000C408.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4047
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
index e45b83527b41..ce2f478a93f5 100644
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
2.38.1

