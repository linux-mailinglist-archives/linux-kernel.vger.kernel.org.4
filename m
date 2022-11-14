Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5507628121
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 14:19:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236525AbiKNNTD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 08:19:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237598AbiKNNSb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 08:18:31 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2050.outbound.protection.outlook.com [40.107.243.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D6262BF6
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 05:18:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gD5dUasCC3Kzm8hL3TT8K41OZ41UxmeDEXU6g1ewCH6ltAE8lbzv1ozzRyeH78MTIc1PUKIzCq1MgjgCrK3rnRLzG4uoRisZ0wEDhCtA4gvYWQK/2Ek7ofZwCXuTD0BoKfGGbQ0USz3ylfVtLzitkA9imqXc6b4+XfWgais1UIzu6y2oUvGKzsidbtkzdEQRb/R/EtLwc6xRgXY0zBTsmlphVR96G/gZC0SF1Sa0qWqvnolCMMaRM7qQTdc15oeE92LVFLwgvK8jXf9Cu472SW7C1Xi35WERUcOeQ7upas3DrirouhwKWdFjW6CJ0x0fqfBiVSlMuJvOdMuZRQE52A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BQO7N62TbSgGDFzRVqbZ/fjSQmCq2j5uGvweKCC16L4=;
 b=b4rc77ym+ItroNQYCpqHiIkzILK0m1YSl+Tm9LklwdUDkYNOYwSrRa2qY3CuNJPG2CBfTDym02dN2460h7BVuHdjEF+YKRZsfeQZFobwZb2s5p+rt7I17m8Y/dL3Pmy/WEfmpEg/Nri40MMC2+Ujvu6CEVwzXJtg7qkyIrgkwGXgLOANchHUyOtMq3Q9tB1aFFbaWYMaLhgjEaRPeN96fDoOI21KFmzlAyErnj2mO8kKZSIBAgck5cm/E4C+T1PzFLxvTZyaP1E4+7fRzdhAOHoHiCNeJZrJG8QiXxEpw1ZHnrtr244aiTITvhEk+tPAHrIwAOTbHwMEqWTDv5k+lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BQO7N62TbSgGDFzRVqbZ/fjSQmCq2j5uGvweKCC16L4=;
 b=uFfgrjazdjbpENuMPnRxReB0xU5/udrv+emfUK7ZyuUgc9xLSyYWZaA/Q0PIXFw/1jEB2ONIME/19klSRi7Oc8T7UqCCOF7oXpCLA+KHWoPiqFt4uuMLAjNM4M6FxjtVCtDwm9Y1lR5bfk6fmptLWc9n4OCdub5qQyFuJiP3qutea2UgfEJ7AwQMe36WgzRIycLWxHmRW359DCH3YZWISyba/7Y61vMsTZ+ALs7ai2q+vd7bOVVbtrB22REsjSWm1a4wbMb8mZXagPheHw09ez/+O23uVgKFy7GkxoYqh7DSwybe5tRO2jZQOBDpT4YSRbEoSyQKdPv+yZ49cw6hfw==
Received: from DM6PR06CA0013.namprd06.prod.outlook.com (2603:10b6:5:120::26)
 by DM4PR12MB5136.namprd12.prod.outlook.com (2603:10b6:5:393::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Mon, 14 Nov
 2022 13:18:28 +0000
Received: from DM6NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:120:cafe::ca) by DM6PR06CA0013.outlook.office365.com
 (2603:10b6:5:120::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17 via Frontend
 Transport; Mon, 14 Nov 2022 13:18:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DM6NAM11FT009.mail.protection.outlook.com (10.13.173.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5813.12 via Frontend Transport; Mon, 14 Nov 2022 13:18:28 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 14 Nov
 2022 05:18:20 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Mon, 14 Nov 2022 05:18:20 -0800
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.36 via Frontend
 Transport; Mon, 14 Nov 2022 05:18:18 -0800
From:   Eli Cohen <elic@nvidia.com>
To:     <mst@redhat.com>, <jasowang@redhat.com>,
        <linux-kernel@vger.kernel.org>,
        <virtualization@lists.linux-foundation.org>
CC:     <si-wei.liu@oracle.com>, <eperezma@redhat.com>, <lulu@redhat.com>,
        "Eli Cohen" <elic@nvidia.com>
Subject: [PATH v2 6/8] vdpa/mlx5: Move some definitions to a new header file
Date:   Mon, 14 Nov 2022 15:17:57 +0200
Message-ID: <20221114131759.57883-7-elic@nvidia.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221114131759.57883-1-elic@nvidia.com>
References: <20221114131759.57883-1-elic@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT009:EE_|DM4PR12MB5136:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a43e812-7506-4929-9d90-08dac642b7e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VkMQlrCLM771n7FDFFqw2HmIa7yC6uCQehPihE904ZHj0sQgpou4iFbdoHDDgs7VIYWIA2CBv89474kn8b7vGyAhUVjvL5NrU/wT8a6f1VP+yEvfnQnpFLBPmQdcK8FN55P93ZPv/ph223zoHYFLYcqv4f5Vcg79ZeCWlo1NAluioz9prQUQzF1EMu8/zHO6YUAB4blOteDOg6MSYi+5ozbujbIetsZIPHCoarOqyaOk8696aJJ53mwho9SYprtDhwXnI29+t30t7mza6+PUpU4bcWK0skzVYUY5zFO4f7MIebi5wE7Zl5keNqIKeg+Ms2LwC8qE8zaeIPnDH4bNWbjZXgM5L/k9qtUIztywCJdLFVTzlkrnp6D9sgXiSSdiKoSsKhwOsx1v5FJrOpJkKkHrGnpYCHkWYP43nz+GL5i35xHPsND8CGLpUObI1QrEllpbNb+AqAx3yEBA4PXKRf8rF3LamnwBu3ktThgDmAGiUspkdQnhSEREh+oij+0/orl47m6DfbX+QGn8sFpowKv8BUisyISTVNzZcSQDt09Vy473ihtiBhaK8rOZPpsEP9EHe8b0a61xxuh+IWygY+EW9mpuoaJDnSDQNcG2H2tVvuGKTbvwHq9/tKsivNdfro0ugpAXKOtoYdlsFrefHPLoljZIyHuzubnjaalXpgijonLVByIS5bHqKqRVuGPsf9oysb+0RxRkmlPH9yaaOVGSp41JMMeGCOWPcqdgjBlhm3kIt2sdSQvQ6pIYotSqqaxkzBSEK4MNDDY3nEaVrA==
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(346002)(39860400002)(376002)(451199015)(40470700004)(36840700001)(46966006)(41300700001)(6666004)(7696005)(26005)(70586007)(2906002)(1076003)(54906003)(336012)(186003)(110136005)(316002)(426003)(86362001)(36860700001)(478600001)(47076005)(82740400003)(83380400001)(4326008)(40460700003)(5660300002)(8936002)(8676002)(7636003)(356005)(70206006)(2616005)(82310400005)(40480700001)(36756003)(107886003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2022 13:18:28.0229
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a43e812-7506-4929-9d90-08dac642b7e3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5136
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move some definitions from mlx5_vnet.c to newly added header file
mlx5_vnet.h. We need these definitions for the following patches that
add debugfs tree to expose information vital for debug.

Reviewed-by: Si-Wei Liu <si-wei.liu@oracle.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Eli Cohen <elic@nvidia.com>
---
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 45 +------------------------
 drivers/vdpa/mlx5/net/mlx5_vnet.h | 55 +++++++++++++++++++++++++++++++
 2 files changed, 56 insertions(+), 44 deletions(-)
 create mode 100644 drivers/vdpa/mlx5/net/mlx5_vnet.h

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index 3a6dbbc6440d..da54a188077d 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -18,15 +18,12 @@
 #include <linux/mlx5/mlx5_ifc_vdpa.h>
 #include <linux/mlx5/mpfs.h>
 #include "mlx5_vdpa.h"
+#include "mlx5_vnet.h"
 
 MODULE_AUTHOR("Eli Cohen <eli@mellanox.com>");
 MODULE_DESCRIPTION("Mellanox VDPA driver");
 MODULE_LICENSE("Dual BSD/GPL");
 
-#define to_mlx5_vdpa_ndev(__mvdev)                                             \
-	container_of(__mvdev, struct mlx5_vdpa_net, mvdev)
-#define to_mvdev(__vdev) container_of((__vdev), struct mlx5_vdpa_dev, vdev)
-
 #define VALID_FEATURES_MASK                                                                        \
 	(BIT_ULL(VIRTIO_NET_F_CSUM) | BIT_ULL(VIRTIO_NET_F_GUEST_CSUM) |                                   \
 	 BIT_ULL(VIRTIO_NET_F_CTRL_GUEST_OFFLOADS) | BIT_ULL(VIRTIO_NET_F_MTU) | BIT_ULL(VIRTIO_NET_F_MAC) |   \
@@ -50,14 +47,6 @@ MODULE_LICENSE("Dual BSD/GPL");
 
 #define MLX5V_UNTAGGED 0x1000
 
-struct mlx5_vdpa_net_resources {
-	u32 tisn;
-	u32 tdn;
-	u32 tirn;
-	u32 rqtn;
-	bool valid;
-};
-
 struct mlx5_vdpa_cq_buf {
 	struct mlx5_frag_buf_ctrl fbc;
 	struct mlx5_frag_buf frag_buf;
@@ -146,38 +135,6 @@ static bool is_index_valid(struct mlx5_vdpa_dev *mvdev, u16 idx)
 	return idx <= mvdev->max_idx;
 }
 
-#define MLX5V_MACVLAN_SIZE 256
-
-struct mlx5_vdpa_net {
-	struct mlx5_vdpa_dev mvdev;
-	struct mlx5_vdpa_net_resources res;
-	struct virtio_net_config config;
-	struct mlx5_vdpa_virtqueue *vqs;
-	struct vdpa_callback *event_cbs;
-
-	/* Serialize vq resources creation and destruction. This is required
-	 * since memory map might change and we need to destroy and create
-	 * resources while driver in operational.
-	 */
-	struct rw_semaphore reslock;
-	struct mlx5_flow_table *rxft;
-	bool setup;
-	u32 cur_num_vqs;
-	u32 rqt_size;
-	bool nb_registered;
-	struct notifier_block nb;
-	struct vdpa_callback config_cb;
-	struct mlx5_vdpa_wq_ent cvq_ent;
-	struct hlist_head macvlan_hash[MLX5V_MACVLAN_SIZE];
-};
-
-struct macvlan_node {
-	struct hlist_node hlist;
-	struct mlx5_flow_handle *ucast_rule;
-	struct mlx5_flow_handle *mcast_rule;
-	u64 macvlan;
-};
-
 static void free_resources(struct mlx5_vdpa_net *ndev);
 static void init_mvqs(struct mlx5_vdpa_net *ndev);
 static int setup_driver(struct mlx5_vdpa_dev *mvdev);
diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.h b/drivers/vdpa/mlx5/net/mlx5_vnet.h
new file mode 100644
index 000000000000..6691c879a6ca
--- /dev/null
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.h
@@ -0,0 +1,55 @@
+/* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
+/* Copyright (c) 2022, NVIDIA CORPORATION & AFFILIATES. All rights reserved. */
+
+#ifndef __MLX5_VNET_H__
+#define __MLX5_VNET_H__
+
+#include "mlx5_vdpa.h"
+
+#define to_mlx5_vdpa_ndev(__mvdev)                                             \
+	container_of(__mvdev, struct mlx5_vdpa_net, mvdev)
+#define to_mvdev(__vdev) container_of((__vdev), struct mlx5_vdpa_dev, vdev)
+
+struct mlx5_vdpa_net_resources {
+	u32 tisn;
+	u32 tdn;
+	u32 tirn;
+	u32 rqtn;
+	bool valid;
+};
+
+#define MLX5V_MACVLAN_SIZE 256
+
+struct mlx5_vdpa_net {
+	struct mlx5_vdpa_dev mvdev;
+	struct mlx5_vdpa_net_resources res;
+	struct virtio_net_config config;
+	struct mlx5_vdpa_virtqueue *vqs;
+	struct vdpa_callback *event_cbs;
+
+	/* Serialize vq resources creation and destruction. This is required
+	 * since memory map might change and we need to destroy and create
+	 * resources while driver in operational.
+	 */
+	struct rw_semaphore reslock;
+	struct mlx5_flow_table *rxft;
+	struct dentry *rx_dent;
+	struct dentry *rx_table_dent;
+	bool setup;
+	u32 cur_num_vqs;
+	u32 rqt_size;
+	bool nb_registered;
+	struct notifier_block nb;
+	struct vdpa_callback config_cb;
+	struct mlx5_vdpa_wq_ent cvq_ent;
+	struct hlist_head macvlan_hash[MLX5V_MACVLAN_SIZE];
+};
+
+struct macvlan_node {
+	struct hlist_node hlist;
+	struct mlx5_flow_handle *ucast_rule;
+	struct mlx5_flow_handle *mcast_rule;
+	u64 macvlan;
+};
+
+#endif /* __MLX5_VNET_H__ */
-- 
2.38.1

