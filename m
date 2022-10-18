Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 977BB6029FA
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 13:14:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbiJRLOC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 07:14:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230198AbiJRLNp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 07:13:45 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2072.outbound.protection.outlook.com [40.107.223.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86B5BB7ED4
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 04:13:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MVPPtsbyVVsEfDc8nAuK3pf2+LAQ6gVuV0EGYYqD5Gnd6q96w5nfDRv3sjyXnEAaMozpzyMnPjG3eXDcoRj4aVIxbCHv73zNxTVFyBqQXmdfLPIavvlCcuvRraTZ+Dxa3FuPp/TJfpKyOkON2k4OkMfycebYXg7WdA7mMzKuEXRmU9zK76YxSd+TW9alcNFtLpis5tAUTGN3RTAlsPLohvWwVuNff5I/FBDiG8MaXeADH0oCtDYQmRBesrwrv3TnePZoPTX4MzRBIj0jYmK28eeDGBXxFE1TwPJ4BJAsx/iEKrGexRlUdNwRaKG152GsqaarB3KRSka2U5brdF/0Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UeeLze86q2FxnlzG/L+943BBAhWNKfXdUDu+jSAdu9Y=;
 b=UDDK+ZgofsRnNLEicOD/wOr0E/fNqOp5YUPx6EVjmDCYlgY6WUZZvC1ZWU87/RyObIaByRQ26qaxrpo9d5G4YV8xyfmGd13S4vPdy9apqS93nX+iFHWxRliG22GxpOdl195gXMv5wa+/Z8HJq9CgrLyNzrrsb0or52nTrxZdYXhM2ObNr/frVRm67FMYSWihrhX6sg8uq7yAdGqYgYH1dVXnfg9axMZ9jiRnyjoyzMRXXZw3exICZcf5b7pJpx+qFhndo9ft5rYX2dcPv7JUrOlw0TaqdfnbUck6wEZ5AdbhxemhSCnskYL73PJ4lRQDFP1jHIaBC2bF6kTmETjNyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UeeLze86q2FxnlzG/L+943BBAhWNKfXdUDu+jSAdu9Y=;
 b=rWR969YMDgSSSW2tD6rlzIMRpWbp4ZjlfkVHceKH9RNnHeT2r2/CMn+ePq5iB34p9ZkjzpiHMlOmTmRADyD+fP6MwbS2c9M2I8vJZ8muqLsloUovZhmxQIucIqULPNRqh1PY0nBjJbCp4ENQYg7qG8efc9eHvIbrzCZHUcWOMYxc2QQRJz0lQS9PynzMgJ4mmEtZZyPaJwQijUK2yCBJ8eMHk8XEHjb3lwDTn+IG8VPI+qnVfVav7HpFVgO6Kmr90WPktDhK4QLuxJpCwVoepoxOc/VGVxHUncHHlTgCYC8WI9fJi+HTndm8j2A8wMMnRFjD1TuVhE9wteBJfzNzdQ==
Received: from BN8PR04CA0059.namprd04.prod.outlook.com (2603:10b6:408:d4::33)
 by CO6PR12MB5396.namprd12.prod.outlook.com (2603:10b6:303:139::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.33; Tue, 18 Oct
 2022 11:13:03 +0000
Received: from BN8NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:d4:cafe::67) by BN8PR04CA0059.outlook.office365.com
 (2603:10b6:408:d4::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.29 via Frontend
 Transport; Tue, 18 Oct 2022 11:13:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN8NAM11FT005.mail.protection.outlook.com (10.13.176.69) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5723.20 via Frontend Transport; Tue, 18 Oct 2022 11:13:03 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Tue, 18 Oct
 2022 04:12:50 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 18 Oct
 2022 04:12:50 -0700
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.986.29 via Frontend Transport; Tue, 18 Oct
 2022 04:12:47 -0700
From:   Eli Cohen <elic@nvidia.com>
To:     <mst@redhat.com>, <jasowang@redhat.com>,
        <linux-kernel@vger.kernel.org>,
        <virtualization@lists.linux-foundation.org>
CC:     <si-wei.liu@oracle.com>, <eperezma@redhat.com>, <lulu@redhat.com>,
        "Eli Cohen" <elic@nvidia.com>
Subject: [PATCH 3/4] vdpa/mlx5: Add debugfs subtree
Date:   Tue, 18 Oct 2022 14:12:31 +0300
Message-ID: <20221018111232.4021-4-elic@nvidia.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221018111232.4021-1-elic@nvidia.com>
References: <20221018111232.4021-1-elic@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT005:EE_|CO6PR12MB5396:EE_
X-MS-Office365-Filtering-Correlation-Id: 997c95ac-2e83-45c7-9238-08dab0f9b999
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UdzBVtPcDX+Fj+Jp2yDqgxbf+9tSTkaXk+pz5WSRrpKioRCbnI/JtmOKhH8UHxCWHoQ0YNvVfSquHd/4c4ophhBXntHmbw5F6CYffMk5Kfjb7e1gYeOwxmgKAT24YNHnfxvaCY+ml7Vj4RdoL37Wr3Brk0g/zvGRQuBcan/uogmtOCMeytp4gMUD/+DONjYp34jtHvySa3srAxtLHKCyW87QHNeXeXhcZ7Wv7+DjSgNhFRao+BHnT2TLNOVKqKT+CCpce09rhmaphnTQOW2Pw4GX79lOP7joJJ8Pi1/ttX5IuNuJDBBWj9Kr39XYYvc3UKyrngHviZx0GeC3A1OhTLIj739egwzwDUb3H1doQfEtmDthCOlAuDQhO8ir/pGzxAocO8QdYj+0uGuD0kn74Wb+xAsOkyGVDuBAA5TdcmjtIDH9JWcI+rtMxywSB684u0/mzuv417a3j+UYKFJ2vKoCRT8RU9WlbEBWYrlANtaWTP5iE6QnBdjiuWroD/BYauiJS9NvTrLE4VGX18SKtfeXX64gLruA1hN5OG+4mVoISH3p3Nhv6ywPrxFdVhK2BE2zXVMTO0ZD4USzIFQ+ce2ilZIp0eozLsRjP1CygM/nOeqwgPCIRtipcciMy9XSCiudmTUlPyR/ktsJnmAirn5GPaxH5Fzezz1LDwgngnTvvJp3juIWBLdw9uSny0bm5JMWqkV43n/Kt+MrwLSZ59VgTNCpjdic9AzRF1HaUn53Pyhum1xuj9WjIp9JT9ZOOtK0jSgN8F86K1pjExKOyw==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(346002)(39860400002)(136003)(451199015)(46966006)(36840700001)(40470700004)(478600001)(26005)(2616005)(426003)(8936002)(5660300002)(47076005)(70586007)(316002)(70206006)(40480700001)(4326008)(36860700001)(6666004)(107886003)(336012)(40460700003)(8676002)(41300700001)(2906002)(186003)(110136005)(54906003)(86362001)(1076003)(7696005)(36756003)(82740400003)(82310400005)(7636003)(356005)(83380400001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2022 11:13:03.1041
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 997c95ac-2e83-45c7-9238-08dab0f9b999
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5396
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
index 64fdb940380f..ee50da33e25b 100644
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
 
@@ -1576,6 +1581,7 @@ static int setup_steering(struct mlx5_vdpa_net *ndev)
 		mlx5_vdpa_warn(&ndev->mvdev, "failed to create flow table\n");
 		return PTR_ERR(ndev->rxft);
 	}
+	mlx5_vdpa_add_rx_flow_table(ndev);
 
 	err = mac_vlan_add(ndev, ndev->config.mac, 0, false);
 	if (err)
@@ -1584,6 +1590,7 @@ static int setup_steering(struct mlx5_vdpa_net *ndev)
 	return 0;
 
 err_add:
+	mlx5_vdpa_remove_rx_flow_table(ndev);
 	mlx5_destroy_flow_table(ndev->rxft);
 	return err;
 }
@@ -1591,6 +1598,7 @@ static int setup_steering(struct mlx5_vdpa_net *ndev)
 static void teardown_steering(struct mlx5_vdpa_net *ndev)
 {
 	clear_mac_vlan_table(ndev);
+	mlx5_vdpa_remove_rx_flow_table(ndev);
 	mlx5_destroy_flow_table(ndev->rxft);
 }
 
@@ -3167,6 +3175,7 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
 	if (err)
 		goto err_reg;
 
+	mlx5_vdpa_add_debugfs(ndev);
 	mgtdev->ndev = ndev;
 	return 0;
 
@@ -3193,6 +3202,8 @@ static void mlx5_vdpa_dev_del(struct vdpa_mgmt_dev *v_mdev, struct vdpa_device *
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

