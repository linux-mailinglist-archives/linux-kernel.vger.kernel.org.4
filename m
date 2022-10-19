Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F26D604648
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 15:04:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbiJSNEb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 09:04:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbiJSNDr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 09:03:47 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5DFB4BA5F
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 05:47:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BeJ5IBoPl0RO9AgXht9S9t97V1UzLuLwupppQ5ZNTUHC5vw1EcrdOIq3vDq0OX4SnrVWNW/in+2xG9YIfwVBq0WSaB4Y8o8rMsfQzg4A5/en6daop2vjMM9s0eUuVA8Vu7LN5WX/9El0zTYbRp7S9o4khtI1Xq/fK9rjvaIwIoK6M2tNLD1Vj8GOCFwnCc+KlemH12UHI9bZOLuJMWcjyWqVvC1TUqFq7Q8EFjZqs9AXuc2ED9sAb2ikgVdwBhEtmumjG9euVsbm0pyaoFnCn40m+U4ETQjorYIB1ZB67WyLnPRe09gj5ZcvpXaAk6sUGnErwEdIhPfrttm2Yks41Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ai2nL4dPdc8YZ6r7al96+NkgKRDkcZM/8yTgdWXhclI=;
 b=dL/KpcY9CaPI04r0y8MhCfNmyUICzrdaKtcpWQK62veGduBO+PxXpz/tUhZjql+j82GSxRGjIVzPvhpiR/O+KxOKB0PKHgLvmvFEFWweBPPZCvYk1YsROjVAl8BMo+6ncXoAUqzCIfKDXRiJiUm0q7X35ujlyqd4NUCQSnoOApjnF0GREyqCwvsyXTlGZ+JLCQuinKRbocvZlBZbjHI2tnyb340Qvs8FkIIJ2Shcq1AQo2pd/l9vn9bj4LXsf0XjWoMJtvgrEs6CiHdvs2VjE/ffQg5Q+qDSOQiCHOXel5JOTb1biDAaJbwD9OwHSWPN/H5BxkGhGyWVa/pnYdt4kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 216.228.118.233) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ai2nL4dPdc8YZ6r7al96+NkgKRDkcZM/8yTgdWXhclI=;
 b=SKyA5tDZ90ylfYQiiX+jRouX7d/xBriwF7EVI62LcMUhnjYJb9aZyCr+YAmGzZkS+yyKVS89FH/xbxPVe56fOYyJJhtu9V9rFtoDHyt6e5DLuHUYJifJhLYBlxwzyguaCXxfyLbZkK2FRiJo5JmC9kSWdoGdvF2sDbxnE8Y1ROxExy6RDLD8B1dzgxHmXaIJgOu+7KvZMQvOW8lVyXSsmm+6TK2xrBIOxlwTcasBg5yLcw+TTeeEj4+EnAZzH4WlWd7qFlcYCeY/0MJiUTPZm//OLmYOkXur9cfpBNY3GYoHmdWcuvMHqyVPFD3EBdmD7IKC9eHbvYFFGqjfJzdeSQ==
Received: from MW3PR06CA0008.namprd06.prod.outlook.com (2603:10b6:303:2a::13)
 by MW3PR12MB4507.namprd12.prod.outlook.com (2603:10b6:303:2c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.34; Wed, 19 Oct
 2022 12:46:36 +0000
Received: from CO1NAM11FT071.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:2a:cafe::8f) by MW3PR06CA0008.outlook.office365.com
 (2603:10b6:303:2a::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.34 via Frontend
 Transport; Wed, 19 Oct 2022 12:46:36 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=nvidia.com;
Received-SPF: None (protection.outlook.com: nvidia.com does not designate
 permitted sender hosts)
Received: from mail.nvidia.com (216.228.118.233) by
 CO1NAM11FT071.mail.protection.outlook.com (10.13.175.56) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5746.16 via Frontend Transport; Wed, 19 Oct 2022 12:46:36 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Wed, 19 Oct
 2022 05:46:23 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Wed, 19 Oct 2022 05:46:22 -0700
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Wed, 19 Oct 2022 05:46:20 -0700
From:   Eli Cohen <elic@nvidia.com>
To:     <mst@redhat.com>, <jasowang@redhat.com>,
        <linux-kernel@vger.kernel.org>,
        <virtualization@lists.linux-foundation.org>
CC:     <si-wei.liu@oracle.com>, <eperezma@redhat.com>, <lulu@redhat.com>,
        "Eli Cohen" <elic@nvidia.com>
Subject: [PATCH v2 3/4] vdpa/mlx5: Add debugfs subtree
Date:   Wed, 19 Oct 2022 15:46:09 +0300
Message-ID: <20221019124610.208113-4-elic@nvidia.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221019124610.208113-1-elic@nvidia.com>
References: <20221019124610.208113-1-elic@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT071:EE_|MW3PR12MB4507:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b584d52-13be-43cc-383f-08dab1cff57f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Yj4HwhhdNVHEjJDe4GVl0yaG63G1cymy7/isHA0+c3UMcwhIdTG3jcIg4y5VKuqLG7nLXHUFukIiFmAFeAp2ewss9xgfD4DZXjtGyP3L3zCGHm5L8aKPf+VzEXNIhMiGrBIsaYDEb/qFo7BJHxT3DK9gLopkcD6SWmfFPajcQYyNuAB3vQ9ZDNWzsofRodWt+jRN1sKgtAWpCnzdCeMpG2yROEpGtqzghc+ouQafqQvB62q7Qj2Q+4OqUimaZj1LZqFV+R5QT4hBNWaV0TFbPyd+SLob66gWP9TkMRJgw4hu/E7MXtdEoNWpPyu9/O5xAawjpNRnyPN9HAELVScpLHQf28ASZUmvanNugg0U9g9I6VVc68Mf1b1u9NywOu9obRuShpDVeqGTNflHetpOX7624ExbmdZK1q/hnpc1bTvvKnPXEiolmUoFQxy0ulUncrxAuVbCwyX/oMcUkz1Onz4gXGrLngcb4SjERc3pQi0dXm9oJPBOIEzye65NYHwnvcVWlCa92szZPPVCv1TxbdiW85DhkwpM4iwRXXMC3rlgGUzD7kLSEzXxqInlg+iiSvso2PXegqdndHxulrIYo7EwjMT1QfGYNWyJZ5A+ClOEFKPeKyPdOn77MtIByekxmX8+AsyM/f9M+I75oJXzeQ78DS7WwBIznqmzCB3/4DcHi+zTCpqT4VjGPH53i3T154FIayr2932z8LbP8PKbsJdV59RSq7xs8jZaTQF5iNhHVHeWs3ki4QTz0cu3MIksjWbMIM7Mmp9BxqUCDMH2VA==
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(136003)(39860400002)(346002)(451199015)(46966006)(40470700004)(36840700001)(186003)(2616005)(26005)(107886003)(7696005)(1076003)(36860700001)(426003)(47076005)(83380400001)(336012)(2906002)(6666004)(40460700003)(5660300002)(40480700001)(41300700001)(110136005)(316002)(82310400005)(478600001)(8936002)(54906003)(70586007)(4326008)(70206006)(8676002)(36756003)(86362001)(7636003)(356005)(82740400003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2022 12:46:36.0354
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b584d52-13be-43cc-383f-08dab1cff57f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT071.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4507
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

Issue: 3214718
Change-Id: Ibd798d18ed02df34d0b461c1aeb0b500fd908d69
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

