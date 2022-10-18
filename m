Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3D326029F9
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 13:13:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbiJRLNg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 07:13:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230074AbiJRLNX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 07:13:23 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2048.outbound.protection.outlook.com [40.107.220.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48E9EB7F44
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 04:13:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KJvC/SuruslWpSBV8yMuOVIwAItRYG/4dTfkSdHXmSkUGaG1OjpNILrTjRGxe6HTRWqo4diEzYduxSPZwv7O0xKAHQ+lhVh02CNdlAB+UIV/j2q6srJ9+Jm3lofgnFSG1c6XGM7RJ8DOP2yWVL58pyeyNw4FVeARoH50fhPaELcuMzKdjq66CVPGXqSCuVtohfVFqoAZZkqnceEdXLc3nXysL5HJgcmE43/Ox0yYsZN2z+5IMNACLuBWzyMbnpw+Su/v4ThQFrfYnC3LHZM3KEe4xW5uzoRx4hN1TTNzQmDGyKFAUXUxgCwEp6WIj1BX1EzHgTDEegLDwj8oPMAEOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sec6yJWfGN4sUqUGqJmE5wePIrUcnWUlMh3tejt0kiY=;
 b=FmIiUe1sQAylQuC/G/cIFAYwnfZyoR5lHvXkVf58FZk+eSRmfzOyUfb7KGdqMuYQ4TTdEihYaDW9y2l++rLagpd/ARtVDnTdl6JSWqP0PaUgn4r2NODQJM1prmr1QhnsN771+y7FiS2bV+u7h/7o/Z6a6JFE8VTdz9H+7FLTrPuTSBIhwo7LTOUwOT13oE25AyDcATm7Y06574xcHfoX/9KTcJ8osd4wGrO5mxXOnPbDn7aqudW/7KcSnKpubM/uoDzckOeLFKlwIb1BXMSTJipbsFoHCwpB3f4QuFDwrNfS8qcEynqNv0yJm31ni/ou6ofZ3ABtyCrLYIX1KmXOWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sec6yJWfGN4sUqUGqJmE5wePIrUcnWUlMh3tejt0kiY=;
 b=aRdgHWmPM0wUc1qzmSjpd4Wb05wwYALA2OMBPSpP5ODw9LezBUxlMCHyHN+YMksmDFuf7L5Z3SRNjhDSOIfJL6D00d/JQZN4Ig/KJ0lGiIAjGAo7xS+lZnq5f6T4fKhW8XUE+yUZt/Rb/0jBJeKVroYthS0H4Xn01EFeQduD6ZPNUz0JK3hhyPAqDZRG5QKBuJSh4NuwxbqTBoY/Bovq1qY+NtETxOIMXOgIo8lXjcgx/yIkBCuVcKPExO0y8wERYais/1HwzMW6wpWE1VLBxemgPiPTr/8lQtRlQIrFOKfmyH3zmEhTa0mvU2cpIUjX6tim3V8YfJOLUIDKTcqdzQ==
Received: from MW4PR04CA0240.namprd04.prod.outlook.com (2603:10b6:303:87::35)
 by SA0PR12MB4400.namprd12.prod.outlook.com (2603:10b6:806:95::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.34; Tue, 18 Oct
 2022 11:13:01 +0000
Received: from CO1NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:87:cafe::a5) by MW4PR04CA0240.outlook.office365.com
 (2603:10b6:303:87::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.31 via Frontend
 Transport; Tue, 18 Oct 2022 11:13:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1NAM11FT063.mail.protection.outlook.com (10.13.175.37) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5723.20 via Frontend Transport; Tue, 18 Oct 2022 11:13:01 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Tue, 18 Oct
 2022 04:12:53 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 18 Oct
 2022 04:12:53 -0700
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.986.29 via Frontend Transport; Tue, 18 Oct
 2022 04:12:50 -0700
From:   Eli Cohen <elic@nvidia.com>
To:     <mst@redhat.com>, <jasowang@redhat.com>,
        <linux-kernel@vger.kernel.org>,
        <virtualization@lists.linux-foundation.org>
CC:     <si-wei.liu@oracle.com>, <eperezma@redhat.com>, <lulu@redhat.com>,
        "Eli Cohen" <elic@nvidia.com>
Subject: [PATCH 4/4] vdpa/mlx5: Add RX counters to debugfs
Date:   Tue, 18 Oct 2022 14:12:32 +0300
Message-ID: <20221018111232.4021-5-elic@nvidia.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221018111232.4021-1-elic@nvidia.com>
References: <20221018111232.4021-1-elic@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT063:EE_|SA0PR12MB4400:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bfbe015-bce2-4829-ba9b-08dab0f9b8a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lSQ111y6G85WUoXlS+jodxNHAJ2RAGpX4jmIJHpS2cyhubZzXkEL2PO+b7VzKrzXIFv4D7PVVKu/pgIVErC43hTu21SWZxRsQKkuDPhh68l8sHmbqStC19KcbQ+XvgNZxMjNtTB2wc8I8Rni7J9WJyOmr/81dRJixNm+Wi/D2P84oy7U0EKr043c9hkCF7+b0wFFffmePO9k4Y1odFfWRnq/fCaMv6mlnD1Bd1Y3iMR9alkYMP/2tlmPvk6abg9vcaAEWVnG3VNFNmXCzshfB+S8HPAsfclaqbQus7JGQZv0r/VzuK3flnASko4FnfZqrJqI3lINSx0QXv/Wk7NCZ1PG9zZd+ZfRG0SIXiv4c+Mb79HLp5iy8DlxwpdWC6RqVYuc8qq1B85L/kN13V80/z+pTCHWtsqMmj6PELiA3T+IvYkbBzaSRMo/7lCRLTIJBSXKR2vo1hPkru4nSQLQruF7DPGL6bPrQx0S7ROD7t0A7v/jfkg8w+flOX4uuKoIDqhlKFx/DQY0HKPUWiKgdK6d8bWjHdPQ7gu8Slet0VhRqxoMPhiR/gMekIFFzJJoUVcH/e7BfUJ7sbCmU2rIyFqTeZwZ7zA3K0GwXBRGVwZ4IC1f1HRvwa4eti6ZCYkxS6G9MQqCcN26WfVFdqLQ1iSVWe1ly/pWEHxaLtBEGuPhadqSHMIf+ATFKK/mMg3OwKoEqVBnOW7q77FmjyicQiHnyDmfPKrD+vNWLZR1HpFgEU9o3jXfSfM7Jt7q/w1ukGfl/TiDutBDRIeGKusQcU49tSkVq973/cb6PY3vdFc=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(396003)(39860400002)(346002)(451199015)(40470700004)(36840700001)(46966006)(186003)(1076003)(2616005)(107886003)(7696005)(6666004)(26005)(36860700001)(83380400001)(426003)(47076005)(336012)(2906002)(5660300002)(30864003)(40480700001)(40460700003)(82310400005)(110136005)(54906003)(478600001)(316002)(41300700001)(8936002)(4326008)(8676002)(70206006)(70586007)(86362001)(36756003)(7636003)(356005)(82740400003)(290074003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2022 11:13:01.6492
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bfbe015-bce2-4829-ba9b-08dab0f9b8a3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4400
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For each interface, either VLAN tagged or untagged, add two hardware
counters: one for unicast and another for multicast. The counters count
RX packets and bytes and can be read through debugfs:

$ cat /sys/kernel/debug/mlx5/mlx5_core.sf.1/vdpa-0/rx/untagged/mcast/packets
$ cat /sys/kernel/debug/mlx5/mlx5_core.sf.1/vdpa-0/rx/untagged/ucast/bytes

This feature is controlled via the config option
MLX5_VDPA_STEERING_DEBUG. It is off by default as it may have some
impact on performance.

Signed-off-by: Eli Cohen <elic@nvidia.com>
---
 drivers/vdpa/Kconfig              | 12 ++++
 drivers/vdpa/mlx5/net/debug.c     | 82 +++++++++++++++++++++++++++
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 94 +++++++++++++++++++++++--------
 drivers/vdpa/mlx5/net/mlx5_vnet.h | 30 ++++++++++
 4 files changed, 195 insertions(+), 23 deletions(-)

diff --git a/drivers/vdpa/Kconfig b/drivers/vdpa/Kconfig
index 50f45d037611..43b716ec2d18 100644
--- a/drivers/vdpa/Kconfig
+++ b/drivers/vdpa/Kconfig
@@ -71,6 +71,18 @@ config MLX5_VDPA_NET
 	  be executed by the hardware. It also supports a variety of stateless
 	  offloads depending on the actual device used and firmware version.
 
+config MLX5_VDPA_STEERING_DEBUG
+	bool "expose steering counters on debugfs"
+	select MLX5_VDPA
+	help
+	  Expose RX steering counters in debugfs to aid in debugging. For each VLAN
+	  or non VLAN interface, two hardware counters are added to the RX flow
+	  table: one for unicast and one for multicast.
+	  The counters counts the number of packets and bytes and exposes them in
+	  debugfs. Once can read the counters using, e.g.:
+	  cat /sys/kernel/debug/mlx5/mlx5_core.sf.1/vdpa-0/rx/untagged/ucast/packets
+	  cat /sys/kernel/debug/mlx5/mlx5_core.sf.1/vdpa-0/rx/untagged/mcast/bytes
+
 config VP_VDPA
 	tristate "Virtio PCI bridge vDPA driver"
 	select VIRTIO_PCI_LIB
diff --git a/drivers/vdpa/mlx5/net/debug.c b/drivers/vdpa/mlx5/net/debug.c
index 95e4801df211..35137a36433a 100644
--- a/drivers/vdpa/mlx5/net/debug.c
+++ b/drivers/vdpa/mlx5/net/debug.c
@@ -49,6 +49,88 @@ void mlx5_vdpa_add_rx_flow_table(struct mlx5_vdpa_net *ndev)
 						  ndev, &rx_flow_table_fops);
 }
 
+#if defined(CONFIG_MLX5_VDPA_STEERING_DEBUG)
+static int packets_show(struct seq_file *file, void *priv)
+{
+	struct mlx5_vdpa_counter *counter = file->private;
+	u64 packets;
+	u64 bytes;
+	int err;
+
+	err = mlx5_fc_query(counter->mdev, counter->counter, &packets, &bytes);
+	if (err)
+		return err;
+
+	seq_printf(file, "0x%llx\n", packets);
+	return 0;
+}
+
+static int bytes_show(struct seq_file *file, void *priv)
+{
+	struct mlx5_vdpa_counter *counter = file->private;
+	u64 packets;
+	u64 bytes;
+	int err;
+
+	err = mlx5_fc_query(counter->mdev, counter->counter, &packets, &bytes);
+	if (err)
+		return err;
+
+	seq_printf(file, "0x%llx\n", bytes);
+	return 0;
+}
+
+DEFINE_SHOW_ATTRIBUTE(packets);
+DEFINE_SHOW_ATTRIBUTE(bytes);
+
+static void add_counter_node(struct mlx5_vdpa_counter *counter,
+			     struct dentry *parent)
+{
+	debugfs_create_file("packets", 0444, parent, counter,
+			    &packets_fops);
+	debugfs_create_file("bytes", 0444, parent, counter,
+			    &bytes_fops);
+}
+
+void mlx5_vdpa_add_rx_counters(struct mlx5_vdpa_net *ndev,
+			       struct macvlan_node *node)
+{
+	static const char *ut = "untagged";
+	char vidstr[9];
+	u16 vid;
+
+	if (node->tagged) {
+		vid = key2vid(node->macvlan);
+		snprintf(vidstr, sizeof(vidstr), "0x%x", vid);
+	} else {
+		strcpy(vidstr, ut);
+	}
+
+	node->dent = debugfs_create_dir(vidstr, ndev->rx_dent);
+	if (IS_ERR(node->dent))
+		return;
+
+	node->ucast_counter.dent = debugfs_create_dir("ucast", node->dent);
+	if (IS_ERR(node->ucast_counter.dent))
+		return;
+
+	add_counter_node(&node->ucast_counter, node->ucast_counter.dent);
+
+	node->mcast_counter.dent = debugfs_create_dir("mcast", node->dent);
+	if (IS_ERR(node->mcast_counter.dent))
+		return;
+
+	add_counter_node(&node->mcast_counter, node->mcast_counter.dent);
+}
+
+void mlx5_vdpa_remove_rx_counters(struct mlx5_vdpa_net *ndev,
+				  struct macvlan_node *node)
+{
+	if (ndev->debugfs)
+		debugfs_remove_recursive(node->dent);
+}
+#endif
+
 void mlx5_vdpa_add_debugfs(struct mlx5_vdpa_net *ndev)
 {
 	struct mlx5_core_dev *mdev;
diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index ee50da33e25b..1b850d0aee99 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -1404,12 +1404,16 @@ static void destroy_tir(struct mlx5_vdpa_net *ndev)
 #define MAX_STEERING_ENT 0x8000
 #define MAX_STEERING_GROUPS 2
 
+#if defined(CONFIG_MLX5_VDPA_STEERING_DEBUG)
+       #define NUM_DESTS 2
+#else
+       #define NUM_DESTS 1
+#endif
+
 static int mlx5_vdpa_add_mac_vlan_rules(struct mlx5_vdpa_net *ndev, u8 *mac,
-					u16 vid, bool tagged,
-					struct mlx5_flow_handle **ucast,
-					struct mlx5_flow_handle **mcast)
+					struct macvlan_node *node)
 {
-	struct mlx5_flow_destination dest = {};
+	struct mlx5_flow_destination dests[NUM_DESTS] = {};
 	struct mlx5_flow_act flow_act = {};
 	struct mlx5_flow_handle *rule;
 	struct mlx5_flow_spec *spec;
@@ -1418,11 +1422,13 @@ static int mlx5_vdpa_add_mac_vlan_rules(struct mlx5_vdpa_net *ndev, u8 *mac,
 	u8 *dmac_c;
 	u8 *dmac_v;
 	int err;
+	u16 vid;
 
 	spec = kvzalloc(sizeof(*spec), GFP_KERNEL);
 	if (!spec)
 		return -ENOMEM;
 
+	vid = key2vid(node->macvlan);
 	spec->match_criteria_enable = MLX5_MATCH_OUTER_HEADERS;
 	headers_c = MLX5_ADDR_OF(fte_match_param, spec->match_criteria, outer_headers);
 	headers_v = MLX5_ADDR_OF(fte_match_param, spec->match_value, outer_headers);
@@ -1431,45 +1437,78 @@ static int mlx5_vdpa_add_mac_vlan_rules(struct mlx5_vdpa_net *ndev, u8 *mac,
 	eth_broadcast_addr(dmac_c);
 	ether_addr_copy(dmac_v, mac);
 	MLX5_SET(fte_match_set_lyr_2_4, headers_c, cvlan_tag, 1);
-	if (tagged) {
+	if (node->tagged) {
 		MLX5_SET(fte_match_set_lyr_2_4, headers_v, cvlan_tag, 1);
 		MLX5_SET_TO_ONES(fte_match_set_lyr_2_4, headers_c, first_vid);
 		MLX5_SET(fte_match_set_lyr_2_4, headers_v, first_vid, vid);
 	}
 	flow_act.action = MLX5_FLOW_CONTEXT_ACTION_FWD_DEST;
-	dest.type = MLX5_FLOW_DESTINATION_TYPE_TIR;
-	dest.tir_num = ndev->res.tirn;
-	rule = mlx5_add_flow_rules(ndev->rxft, spec, &flow_act, &dest, 1);
+	dests[0].type = MLX5_FLOW_DESTINATION_TYPE_TIR;
+	dests[0].tir_num = ndev->res.tirn;
+#if defined(CONFIG_MLX5_VDPA_STEERING_DEBUG)
+	node->ucast_counter.counter = mlx5_fc_create(ndev->mvdev.mdev, false);
+	if (IS_ERR(node->ucast_counter.counter)) {
+		err = PTR_ERR(node->ucast_counter.counter);
+		goto err_ucast_counter;
+	}
+	node->mcast_counter.counter = mlx5_fc_create(ndev->mvdev.mdev, false);
+	if (IS_ERR(node->mcast_counter.counter)) {
+		err = PTR_ERR(node->mcast_counter.counter);
+		goto err_mcast_counter;
+	}
+
+	dests[1].type = MLX5_FLOW_DESTINATION_TYPE_COUNTER;
+	dests[1].counter_id = mlx5_fc_id(node->ucast_counter.counter);
+	flow_act.action |= MLX5_FLOW_CONTEXT_ACTION_COUNT;
+#endif
+	node->ucast_rule = mlx5_add_flow_rules(ndev->rxft, spec, &flow_act, dests, NUM_DESTS);
 	if (IS_ERR(rule))
 		return PTR_ERR(rule);
 
-	*ucast = rule;
+#if defined(CONFIG_MLX5_VDPA_STEERING_DEBUG)
+	dests[1].counter_id = mlx5_fc_id(node->mcast_counter.counter);
+#endif
 
 	memset(dmac_c, 0, ETH_ALEN);
 	memset(dmac_v, 0, ETH_ALEN);
 	dmac_c[0] = 1;
 	dmac_v[0] = 1;
-	rule = mlx5_add_flow_rules(ndev->rxft, spec, &flow_act, &dest, 1);
+	node->mcast_rule = mlx5_add_flow_rules(ndev->rxft, spec, &flow_act, dests, NUM_DESTS);
 	kvfree(spec);
 	if (IS_ERR(rule)) {
 		err = PTR_ERR(rule);
 		goto err_mcast;
 	}
 
-	*mcast = rule;
+#if defined(CONFIG_MLX5_VDPA_STEERING_DEBUG)
+	node->ucast_counter.mdev = ndev->mvdev.mdev;
+	node->mcast_counter.mdev = ndev->mvdev.mdev;
+#endif
+	mlx5_vdpa_add_rx_counters(ndev, node);
+
 	return 0;
 
 err_mcast:
-	mlx5_del_flow_rules(*ucast);
+	mlx5_del_flow_rules(node->ucast_rule);
+#if defined(CONFIG_MLX5_VDPA_STEERING_DEBUG)
+err_mcast_counter:
+	mlx5_fc_destroy(ndev->mvdev.mdev, node->ucast_counter.counter);
+err_ucast_counter:
+	kfree(spec);
+#endif
 	return err;
 }
 
 static void mlx5_vdpa_del_mac_vlan_rules(struct mlx5_vdpa_net *ndev,
-					 struct mlx5_flow_handle *ucast,
-					 struct mlx5_flow_handle *mcast)
+					 struct macvlan_node *node)
 {
-	mlx5_del_flow_rules(ucast);
-	mlx5_del_flow_rules(mcast);
+#if defined(CONFIG_MLX5_VDPA_STEERING_DEBUG)
+	if (node->dent && !IS_ERR(node->dent))
+		mlx5_vdpa_remove_rx_counters(ndev, node);
+#endif
+
+	mlx5_del_flow_rules(node->ucast_rule);
+	mlx5_del_flow_rules(node->mcast_rule);
 }
 
 static u64 search_val(u8 *mac, u16 vlan, bool tagged)
@@ -1503,14 +1542,14 @@ static struct macvlan_node *mac_vlan_lookup(struct mlx5_vdpa_net *ndev, u64 valu
 	return NULL;
 }
 
-static int mac_vlan_add(struct mlx5_vdpa_net *ndev, u8 *mac, u16 vlan, bool tagged) // vlan -> vid
+static int mac_vlan_add(struct mlx5_vdpa_net *ndev, u8 *mac, u16 vid, bool tagged)
 {
 	struct macvlan_node *ptr;
 	u64 val;
 	u32 idx;
 	int err;
 
-	val = search_val(mac, vlan, tagged);
+	val = search_val(mac, vid, tagged);
 	if (mac_vlan_lookup(ndev, val))
 		return -EEXIST;
 
@@ -1518,12 +1557,13 @@ static int mac_vlan_add(struct mlx5_vdpa_net *ndev, u8 *mac, u16 vlan, bool tagg
 	if (!ptr)
 		return -ENOMEM;
 
-	err = mlx5_vdpa_add_mac_vlan_rules(ndev, ndev->config.mac, vlan, tagged,
-					   &ptr->ucast_rule, &ptr->mcast_rule);
+	ptr->tagged = tagged;
+	ptr->macvlan = val;
+	ptr->ndev = ndev;
+	err = mlx5_vdpa_add_mac_vlan_rules(ndev, ndev->config.mac, ptr);
 	if (err)
 		goto err_add;
 
-	ptr->macvlan = val;
 	idx = hash_64(val, 8);
 	hlist_add_head(&ptr->hlist, &ndev->macvlan_hash[idx]);
 	return 0;
@@ -1542,7 +1582,11 @@ static void mac_vlan_del(struct mlx5_vdpa_net *ndev, u8 *mac, u16 vlan, bool tag
 		return;
 
 	hlist_del(&ptr->hlist);
-	mlx5_vdpa_del_mac_vlan_rules(ndev, ptr->ucast_rule, ptr->mcast_rule);
+	mlx5_vdpa_del_mac_vlan_rules(ndev, ptr);
+#if defined(CONFIG_MLX5_VDPA_STEERING_DEBUG)
+			mlx5_fc_destroy(ndev->mvdev.mdev, ptr->mcast_counter.counter);
+			mlx5_fc_destroy(ndev->mvdev.mdev, ptr->ucast_counter.counter);
+#endif
 	kfree(ptr);
 }
 
@@ -1555,7 +1599,11 @@ static void clear_mac_vlan_table(struct mlx5_vdpa_net *ndev)
 	for (i = 0; i < MLX5V_MACVLAN_SIZE; i++) {
 		hlist_for_each_entry_safe(pos, n, &ndev->macvlan_hash[i], hlist) {
 			hlist_del(&pos->hlist);
-			mlx5_vdpa_del_mac_vlan_rules(ndev, pos->ucast_rule, pos->mcast_rule);
+			mlx5_vdpa_del_mac_vlan_rules(ndev, pos);
+#if defined(CONFIG_MLX5_VDPA_STEERING_DEBUG)
+			mlx5_fc_destroy(ndev->mvdev.mdev, pos->mcast_counter.counter);
+			mlx5_fc_destroy(ndev->mvdev.mdev, pos->ucast_counter.counter);
+#endif
 			kfree(pos);
 		}
 	}
diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.h b/drivers/vdpa/mlx5/net/mlx5_vnet.h
index f2cef3925e5b..706c83016b71 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.h
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.h
@@ -21,6 +21,11 @@ struct mlx5_vdpa_net_resources {
 
 #define MLX5V_MACVLAN_SIZE 256
 
+static inline u16 key2vid(u64 key)
+{
+	return (u16)(key >> 48);
+}
+
 struct mlx5_vdpa_net {
 	struct mlx5_vdpa_dev mvdev;
 	struct mlx5_vdpa_net_resources res;
@@ -47,11 +52,24 @@ struct mlx5_vdpa_net {
 	struct dentry *debugfs;
 };
 
+struct mlx5_vdpa_counter {
+	struct mlx5_fc *counter;
+	struct dentry *dent;
+	struct mlx5_core_dev *mdev;
+};
+
 struct macvlan_node {
 	struct hlist_node hlist;
 	struct mlx5_flow_handle *ucast_rule;
 	struct mlx5_flow_handle *mcast_rule;
 	u64 macvlan;
+	struct mlx5_vdpa_net *ndev;
+	bool tagged;
+#if defined(CONFIG_MLX5_VDPA_STEERING_DEBUG)
+	struct dentry *dent;
+	struct mlx5_vdpa_counter ucast_counter;
+	struct mlx5_vdpa_counter mcast_counter;
+#endif
 };
 
 void mlx5_vdpa_add_debugfs(struct mlx5_vdpa_net *ndev);
@@ -60,5 +78,17 @@ void mlx5_vdpa_add_rx_flow_table(struct mlx5_vdpa_net *ndev);
 void mlx5_vdpa_remove_rx_flow_table(struct mlx5_vdpa_net *ndev);
 void mlx5_vdpa_add_tirn(struct mlx5_vdpa_net *ndev);
 void mlx5_vdpa_remove_tirn(struct mlx5_vdpa_net *ndev);
+#if defined(CONFIG_MLX5_VDPA_STEERING_DEBUG)
+void mlx5_vdpa_add_rx_counters(struct mlx5_vdpa_net *ndev,
+			       struct macvlan_node *node);
+void mlx5_vdpa_remove_rx_counters(struct mlx5_vdpa_net *ndev,
+				  struct macvlan_node *node);
+#else
+static inline void mlx5_vdpa_add_rx_counters(struct mlx5_vdpa_net *ndev,
+					     struct macvlan_node *node) {}
+static inline void mlx5_vdpa_remove_rx_counters(struct mlx5_vdpa_net *ndev,
+						struct macvlan_node *node) {}
+#endif
+
 
 #endif /* __MLX5_VNET_H__ */
-- 
2.35.1

