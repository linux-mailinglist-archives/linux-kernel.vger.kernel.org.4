Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC134626FD1
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Nov 2022 14:45:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235373AbiKMNpP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 08:45:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235370AbiKMNpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 08:45:10 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2086.outbound.protection.outlook.com [40.107.93.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B0F512081
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 05:45:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HNU6+FMjdew1sCD+XILGgIqrJQI3aDXASQPPNZ5s8eizJaLcePuFfahhwiLNG0qvGc0WF2S7a5n8tvbff7vw2Znd67DF0RLkZZ+tOmGDK1awBodknWn6FLF77Dp0UBSGEngkD7jZhmeDLdz+OdRmCkHdF7p45vVQdXZSFxGunnAARGUxQl3UMxJuA1Gw3kjJdLRuYp+nyGcaNJkzpRBq97AFwiSO6OiWZ8T7YEvu3+AXII2ghckRmDtQEhJ8gQytelUhqugRoCG7MyaTQkna4YDzgFjULNwi54Y7A/bWcF7CzZnOhPzTWVzF4+9ho1XC1qmRTuZ8E4JM0C4g3W1kyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vYigdZsLhTrnmCtcVUVkA0cuYfoVK5svzmDlqf2pu2M=;
 b=hSudeSjyrcdH478p0jegmA0xK28PnETkH8giLMHwte+CFLjco71gjB38+nClLAj5COI/0OdLg6zyqrLcX028L/zMek7bVjd3FqqzyzodI9AM9A2y7W9twMypn48xv46S5Q49vjkDZmlMXYIEqv6YlYugddpWlTPDGORjbeg1VW2HEJK585t4FYyN6dXaWU9YS1Idwc5YQnW/bqHFwvAancf98qq0kzwFzx4u/mzHEoMCqj0sMOPUPhj07p09ARwz51MR47W9MaehnYG4737rkyJ+33oxbNSjzw5K6EGk9FpPF8+kYvOxkRSRTeJII6oAyz8dvQ0cArq4K0NJ5ZidEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vYigdZsLhTrnmCtcVUVkA0cuYfoVK5svzmDlqf2pu2M=;
 b=pMAM8ZmXUJlXO6ML6qgWxDw8HgU0Otc67wZjQLkyGxIR/WMVM3Q2RDtasMIYK6o6H4Lcu7TH4z1IDK0eugqZmDWID6DmZNw9OIwxAQXvo4g1MRIM8ekT/D1TsMlqWRKU5wLUuBqmI5JNVSlaEmQBfaA5V3CMMgqJ2u1F95AgDLMXRTDOfkXAXQD/+F+gd0BVoS8G/8zah6JQZojLzyC5KG98k4+bY6ccqazAPaahqoDwNsyfrnWSpen+g/dZPUiMnj3lUHYmIlw6bLOfdhe3Yy3x7yz7bTTCD+17UCCysRW/rcHXULCTWcmprX3hOs5dcYlpMorYCcEyTCo58yZABA==
Received: from MN2PR19CA0011.namprd19.prod.outlook.com (2603:10b6:208:178::24)
 by DS7PR12MB6070.namprd12.prod.outlook.com (2603:10b6:8:9e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.16; Sun, 13 Nov
 2022 13:45:07 +0000
Received: from BL02EPF0000C408.namprd05.prod.outlook.com
 (2603:10b6:208:178:cafe::b8) by MN2PR19CA0011.outlook.office365.com
 (2603:10b6:208:178::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.14 via Frontend
 Transport; Sun, 13 Nov 2022 13:45:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0000C408.mail.protection.outlook.com (10.167.241.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5813.11 via Frontend Transport; Sun, 13 Nov 2022 13:45:07 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Sun, 13 Nov
 2022 05:44:56 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Sun, 13 Nov
 2022 05:44:56 -0800
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.986.36 via Frontend Transport; Sun, 13 Nov
 2022 05:44:53 -0800
From:   Eli Cohen <elic@nvidia.com>
To:     <mst@redhat.com>, <jasowang@redhat.com>,
        <linux-kernel@vger.kernel.org>,
        <virtualization@lists.linux-foundation.org>
CC:     <si-wei.liu@oracle.com>, <eperezma@redhat.com>, <lulu@redhat.com>,
        "Eli Cohen" <elic@nvidia.com>
Subject: [PATCH 3/7] vdpa/mlx5: Move some definitions to a new header file
Date:   Sun, 13 Nov 2022 15:44:38 +0200
Message-ID: <20221113134442.152695-4-elic@nvidia.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221113134442.152695-1-elic@nvidia.com>
References: <20221113134442.152695-1-elic@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0000C408:EE_|DS7PR12MB6070:EE_
X-MS-Office365-Filtering-Correlation-Id: a0f4a6c4-1fe5-415d-9ad9-08dac57d46d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qWH8Br+HbUNGHii6kA9HH38Soa1IbzHlrz4/EMGAMwXW3FYSgVRnY1ybQSKfoRBzukd6MUMahFsCQ9vf0Fk4rsExHrJUaFZGuAyzM462d7U/zYN4Xud0sA5g/DHwSOSkt2Qn7wMfyUztwpECOSGM3oF5cwZuqYl0qXBF7kAXVffcUlRmCJtM74C4PciYAwZiSQsib+LIVvUc52giN5XGUaVjkxh206bilOZ5lTi1Z543f3ieS1cz3EtivxYgmtN2/n17pBr12Vo7jCkr5LH25ml1yz/K5rhNdlzC6XmjVX87qeyg87xMu9hwKk90wo7gbz8j5KsmND0ySSG4shgAjSzYpgA8iRmfJHOisJ1uXARwlgQlCVXElluOWxBbeDsrDbS1XihWZOqHZY5BBIppwVEzX6rAhYylsRKazDeqcK5iEvIFxYDFfnWz7znYxeBU2mMVP1G05gZnYNbsb/199bah4vVKTbH+h93H5sDY5WafY89Bm7nK0WxooFdGHzSKp7sN+BFl9Kq/3PJXHbiB6TlJGhpftNfgbuhHT0Ly79LKfJMz5DpiRXMrnIzhdQFPDBEjK1LRV4Aujb4XY77Ii5zfoYYTr7Lt80ijEdx8/uQpM3iaKiqAMMZZFkCoWuSM/wpMTskM1HgrM0cr0R4c097OeCxrHZSVqUsWqu5bhwfJtVAA8IcBnvMx/tugxzfzp+N9d1bis/q8Qa3EudopRoZCoBuLEx68v42YveZ3Pi2N2hYAU6rBGC01HBGawAcxspyVCy3ftehABArgGKMbug==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(136003)(39860400002)(396003)(451199015)(36840700001)(46966006)(40470700004)(41300700001)(47076005)(5660300002)(426003)(336012)(2616005)(1076003)(186003)(8936002)(26005)(7696005)(6666004)(110136005)(478600001)(82740400003)(36756003)(40460700003)(356005)(8676002)(70586007)(7636003)(70206006)(4326008)(107886003)(40480700001)(316002)(54906003)(36860700001)(2906002)(86362001)(82310400005)(83380400001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2022 13:45:07.3974
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a0f4a6c4-1fe5-415d-9ad9-08dac57d46d0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0000C408.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6070
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
Signed-off-by: Eli Cohen <elic@nvidia.com>
---
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 45 +------------------------
 drivers/vdpa/mlx5/net/mlx5_vnet.h | 55 +++++++++++++++++++++++++++++++
 2 files changed, 56 insertions(+), 44 deletions(-)
 create mode 100644 drivers/vdpa/mlx5/net/mlx5_vnet.h

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index c54d5088ed4f..e45b83527b41 100644
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

