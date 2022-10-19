Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF275604682
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 15:12:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232201AbiJSNME (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 09:12:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232029AbiJSNLm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 09:11:42 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2060.outbound.protection.outlook.com [40.107.223.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AC5A1CBAB1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 05:56:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N138YqDS4yi21fJbAPtO+vi2zjVhgdZHdjaM3LkNILWzE1vr1GxbuUWxNj1VoLfOBIHmFYXuoqNa41E3gh4iqJCuMgdGLC39aHRj79Ld8Ec4flw3yI/MutD9FI9SDF5/I1e7XNU0XThQwOpaZe6QELNPjGDUGF6AkShy4pV3T6Nywsq86r2YSmWhCY0QixKJ4ogdsq3LplxMmIKyIrLro5qqbRGmIvdK3+qQadvGom25D+/K5TlEETNc/sA/+nR2O0bAMKnqcD3IeefCabgzGG8hsMKpt6CGAYU3FmMGXgwwab1kCDTJYJueK+niZssX2LB4AL8opW7zxdXktICCtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oDOkZSa0/v0kkFguBysT+WRyNN/qW8l/UoHVSPHkuKw=;
 b=JM6SI0NCwLljyFMK0ld0hhOZGaWs0tS18+k0BjN6q9isP1G+Iq3+AKi5xlSVsJKNc/DspsaWlqv2sCMeNQQkzWSYbPUaj0Fntqcc4vUdwelJ+mqH7jzqZP7jSu0Y9OEBnb+D8kaQ3EXPjghZHE9+0G+4zq3bWyocTVtlkKF/0a4Jp1plkLksQjBsFy0D6FnO3hThRmGhWygXpYdFWF1pTvfZJn6ovxAh6c/p2FZBHQ7Ay8GQTgXTQbcJ2mvxtQaSO+/scCAMddBe9phQkOshoSF9ejH39IzvOe3mBbOYExblSgxbbtEXkgNkZN7I9oI9qsgzHGUzOef6YenbJB8+qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oDOkZSa0/v0kkFguBysT+WRyNN/qW8l/UoHVSPHkuKw=;
 b=eh/XbsAMJuq73RltDrl+zIjLeilERqt3IxgFYZnubJcxsjrIrOdY64TU0dvxT9uibwjS5BKB7ij8GZzX6dKH1sQXgZde1p5rT9v8GnKji2buN4YQ81Jpn12tL89vlcPWIhif0xto5IReHYZQJTuSjHVh2GpBuF+WH+jqp6CABYG2sJtRvgr2cLLAj1UAq0KkmCAMr4mQP3UeSKxmRRs4h5QmLdtN1+Ca8yqfszMAGUj2CF6F9SwbWtucf7PEnSN5cmWA/Furx2/FUtOBagV7hOUpu2K6Zt40Bq0bSxa3qj/k91k6eTMVS7K1tXArOCs+X9zPj79oAi3A3uioWV4PwA==
Received: from DS7PR03CA0293.namprd03.prod.outlook.com (2603:10b6:5:3ad::28)
 by BL0PR12MB5010.namprd12.prod.outlook.com (2603:10b6:208:17c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.32; Wed, 19 Oct
 2022 12:55:26 +0000
Received: from DM6NAM11FT035.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3ad:cafe::74) by DS7PR03CA0293.outlook.office365.com
 (2603:10b6:5:3ad::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.34 via Frontend
 Transport; Wed, 19 Oct 2022 12:55:26 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=nvidia.com;
Received-SPF: None (protection.outlook.com: nvidia.com does not designate
 permitted sender hosts)
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT035.mail.protection.outlook.com (10.13.172.100) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5746.16 via Frontend Transport; Wed, 19 Oct 2022 12:55:26 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Wed, 19 Oct
 2022 05:55:12 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Wed, 19 Oct
 2022 05:55:12 -0700
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.986.29 via Frontend Transport; Wed, 19 Oct
 2022 05:55:09 -0700
From:   Eli Cohen <elic@nvidia.com>
To:     <mst@redhat.com>, <jasowang@redhat.com>,
        <linux-kernel@vger.kernel.org>,
        <virtualization@lists.linux-foundation.org>
CC:     <si-wei.liu@oracle.com>, <eperezma@redhat.com>, <lulu@redhat.com>,
        "Eli Cohen" <elic@nvidia.com>
Subject: [PATCH v2 resend 2/4] vdpa/mlx5: Move some definitions to a new header file
Date:   Wed, 19 Oct 2022 15:54:58 +0300
Message-ID: <20221019125500.208841-3-elic@nvidia.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221019125500.208841-1-elic@nvidia.com>
References: <20221019125500.208841-1-elic@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT035:EE_|BL0PR12MB5010:EE_
X-MS-Office365-Filtering-Correlation-Id: d7c3fcc9-2d47-4d03-1f40-08dab1d131c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6YsMH1RIw8wbIIeF0CoFpzRf4r87XifhFsyVb3Juuei1SMmi6tTHxlgbO+U2kmifhuSs5SK5TqFz1ALDFtsOGvWITF6q2q+7YqPQzX6xlVtoUaRIFMzn3qk9pMyw34wbYFADBMOyL5lpDeGJ+ZWeUpUIKctK+asbk/3G0FYAAe1szlEl9/KHML39C2vkwmaIjs8tje0tgDuwkv9wpXBdLzttCASrO0+W5LphRX8YCKrD41TUee7rznjsa0kT4bnGx8BdboNQ9NDStgjWShScYFiNHegVp3qUl8JtqyVeoBx3VKvsP/df3zoq8nKqwiAbuw/0vrBVrBY71jQktQuvnb9KM92JwTiTCMG+xoMmpdKeHSBpcnDPbdsf5hVe3PvrR45/ppV99ug8NBa2UGQNMmgTJLv+5x2rymA/HCOSXoAu5MsjpoLSlCMlVaBn/z4O2PUkC74x4snlUiOXDJIPewPjnUJ0TVL6WUNzUyegkFconFJ8VDgGdu+b/WpD9+SnAqdHkDwBaRJLlMAGhNRvZxMlV+kbk2qq9gH9Ze6/yKiRbzE2i0dm2wDog21GarCujTJ+xvploTKGEgM3Q2nvG/qqu5+Ksn/8J1ARYBKq9VUYX/QYeH4nOIWAhJH+lBSIusSIJnMD3/ZTUPwOQpsNk3wdaH/+KLw78FH2k0zAagHGzA6ANk48dbQdSxpN+3d/Vp/P2SgWPOyUF9Oiqs88RgbmBgebQF0EiSiwuVhmau8M994VjlpnDoilYnevBVHQyjNv2/bdC0BMcT4/uIKmEA==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(376002)(396003)(39860400002)(451199015)(40470700004)(46966006)(36840700001)(47076005)(426003)(1076003)(186003)(2616005)(83380400001)(356005)(26005)(7636003)(86362001)(36860700001)(336012)(82740400003)(5660300002)(2906002)(8936002)(4326008)(40480700001)(82310400005)(107886003)(8676002)(40460700003)(478600001)(110136005)(7696005)(316002)(41300700001)(6666004)(70206006)(54906003)(70586007)(36756003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2022 12:55:26.5845
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d7c3fcc9-2d47-4d03-1f40-08dab1d131c4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT035.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5010
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
index 1bcd8dfa9b7e..acd95f2d0ba3 100644
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
2.35.1

