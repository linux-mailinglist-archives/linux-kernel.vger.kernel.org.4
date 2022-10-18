Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B50A26029F8
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 13:13:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbiJRLNT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 07:13:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230099AbiJRLNM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 07:13:12 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2047.outbound.protection.outlook.com [40.107.237.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFD3EB7EE3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 04:12:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ps8zGk+huHonQLEqw5FGkwWdKaumw75dwSY8Y82uDsQLaTh6QDDWnI49V6RwFAQNuxYB2HF02+rARdO/gLjDxwqc1Nse6fBNSJbt3XfsCffV7hJ1SyzP2dMUy/+rO3ciqTLDKIetLond8AfjGy8+DZkxHLnumijarJOquKXXDrTEn7qKEKVan1zWX+OnB2RBQl16NmYwXahzyikOi4YkQcKjn/bPcz9jK8Yyx9WTQvHWmdqg7pkHUp7fkPIcFDBXNa3KhCtG9y6C+kalHo2fSVs72Dt/kpYjTA4/llEqBHJ1vF+lXoHANV434ZFVedYKp19dkfAuK/XA9Ksy7UYPbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=njaC4xSe7MwINosfRo5PG25DOaWmb+qQPh2qasDsgGI=;
 b=mVHk2I6MAO5y6+SL4ec6HdUOy+XZQZB0L51s62UGJfKg/xtoDP71vkUJQDEvM+QQ8VS7Bca2qgQMfdh/3geyqioRx+9/hg/QS2c/sPL1CI8bocjRve+z8x1wJZnHW09XwCJbB6933ki3aXmQFEkr+pHFZfDWQwK5DyuiVNyWIlHKJ9yVplFx2auohm490EcmwuARVXzOlLRvHuhqbnc80iquTFxzO9LB0if9T378qCzlm8Ijm4GGsR91T55OW/hguAY5bcYeZsyUmT7iZENGmK91mw260PVdluCrSHSjmC6hAWDRhhLNi4ubHUzZfsaUpYRnpuB5akuH4OQbMzdRNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=njaC4xSe7MwINosfRo5PG25DOaWmb+qQPh2qasDsgGI=;
 b=h0AP+bHFKZL7icy7DeBu4PLZkQFzxooqHSPq2WPsWXDKtP7YdgQyhxB6Z59TfakPz9tzY97OxvPNaldcqUsgjWEKBNebKt4GlDWkNzy7dboc5wW0wQU+ZJnikFrON5+uvM8Qze+9zjXiY7hSl3WLZ9iqAJds9yeccXc1GWp46/habVnEiw0Q+YTcIbhWcY0yJvy+iPIxExszm7h4OWs7shZ1v0bQVyuxHm3OXHPDIceyxw8mHMd7MA1FEQlMSXuWtjw74mEcDlLc8YCHGrYtOtr07WwyAfh9/lwGctI/bG3inUGLaIePiLWgFwm45P4j0glcfXPHIS0vBYJaCyMTbw==
Received: from MW4PR02CA0005.namprd02.prod.outlook.com (2603:10b6:303:16d::14)
 by SA1PR12MB5613.namprd12.prod.outlook.com (2603:10b6:806:23e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.33; Tue, 18 Oct
 2022 11:12:56 +0000
Received: from CO1NAM11FT061.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:16d:cafe::de) by MW4PR02CA0005.outlook.office365.com
 (2603:10b6:303:16d::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.34 via Frontend
 Transport; Tue, 18 Oct 2022 11:12:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1NAM11FT061.mail.protection.outlook.com (10.13.175.200) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5723.20 via Frontend Transport; Tue, 18 Oct 2022 11:12:56 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Tue, 18 Oct
 2022 04:12:47 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 18 Oct
 2022 04:12:47 -0700
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.986.29 via Frontend Transport; Tue, 18 Oct
 2022 04:12:44 -0700
From:   Eli Cohen <elic@nvidia.com>
To:     <mst@redhat.com>, <jasowang@redhat.com>,
        <linux-kernel@vger.kernel.org>,
        <virtualization@lists.linux-foundation.org>
CC:     <si-wei.liu@oracle.com>, <eperezma@redhat.com>, <lulu@redhat.com>,
        "Eli Cohen" <elic@nvidia.com>
Subject: [PATCH 2/4] vdpa/mlx5: Move some definitions to a new header file
Date:   Tue, 18 Oct 2022 14:12:30 +0300
Message-ID: <20221018111232.4021-3-elic@nvidia.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221018111232.4021-1-elic@nvidia.com>
References: <20221018111232.4021-1-elic@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT061:EE_|SA1PR12MB5613:EE_
X-MS-Office365-Filtering-Correlation-Id: 167d6632-c02b-47bf-48ec-08dab0f9b592
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c+ot3ua6bvi7gdHdb+Nsuzl14aPyW6UV39mcIs4U1QiqPkgu/erC0Wu/WIK8go4A3gEiutLOxzYuWz9Z7qxMDJXyADyCqWICyPiw5H59O54TS5AvCtRKaJQm5q0z2GuNGIbCc1Up4Sw+WLkBIZGtAqhvtfatBcQBS6l2WSiAOWv/FZGzYcTITIqlT7pgqtwSYOYT0xjwiDXkc+7ANGIs+VjkATBponh+fJKgR//7RDyG3QmpOGqz8iJ5pno3aOELUuO+tTKkI0g6jqINSGb5r1hTqQkUxnmXXVwUOFizckaTFbs6JDT5H0tTT/9thYcKMHwOzxpmd/JPo0jdCliSNHZ6N3q9AoYPi8RZyGmn83nBQaxHOHhghhfG9cXU0vNbGqcp0L9jiF2dp/E7WYH4UyVjIvoSbL/gIXGpiFoVM71p16SPTnqkOP8DuTw5HcN5/MO1Bx6KA3tCW0pniE14nqfhxMzWB9wEaTH/xeFEcqIu3h5lsQHmrPFADzH+RvUJOFzyuLZ27qWyUbG5BJFkmTMSG8xnLAIvJOH+YPxnsLaAAn/2lIBZy8dNYWxFsGJepJB8f1VcLSPP3Ib9iuEcqAlEW9lCM6J/lB8N6r909LGmnoeNgKKfkPzi+iGs364hmQZVgVK3GL2Dr75XX8el9nGzkEIkFnYKAwnxLm+buIe7TPuIswQvaG2ZxBDIGRFA1/+HqqeMekFUgAjyUMukWeYW/WyAbD0KWvGBzvm821nk2Hm31bOCQNosvN3Q59Z3kClu6iPPhHVuInRmpvB8yA==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(39860400002)(136003)(376002)(451199015)(46966006)(40470700004)(36840700001)(316002)(36860700001)(8936002)(26005)(86362001)(2616005)(5660300002)(40480700001)(36756003)(4326008)(8676002)(70206006)(70586007)(336012)(107886003)(6666004)(41300700001)(186003)(2906002)(1076003)(7696005)(426003)(47076005)(82740400003)(54906003)(110136005)(83380400001)(356005)(478600001)(82310400005)(40460700003)(7636003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2022 11:12:56.5017
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 167d6632-c02b-47bf-48ec-08dab0f9b592
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT061.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5613
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

Signed-off-by: Eli Cohen <elic@nvidia.com>
---
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 45 +------------------------
 drivers/vdpa/mlx5/net/mlx5_vnet.h | 55 +++++++++++++++++++++++++++++++
 2 files changed, 56 insertions(+), 44 deletions(-)
 create mode 100644 drivers/vdpa/mlx5/net/mlx5_vnet.h

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index dd29fdfc24ed..64fdb940380f 100644
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

