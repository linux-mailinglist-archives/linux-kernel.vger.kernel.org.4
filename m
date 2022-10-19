Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB2E9604683
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 15:12:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232613AbiJSNMV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 09:12:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232951AbiJSNLo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 09:11:44 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2060d.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe5b::60d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C5AE165536
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 05:56:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QAEBDJOLkteS9mcqB5AgZOlFshcr+BjTl/TnQx1PW7EaWfZEgh2KD+buzdQsP00J4lhVtPHiYFAJswtsQnnNU7tS2UP7XGtWIibku0flCyNCAdLNMapujLKgbqcKUm8M+nXgosZkZbJ361VP9nl3FwGTrGxPS3TtzD+VmPth80ECWzTxdfX4psFeEOb3nPLMdG0SDK7D5rjO+ERwSzPdMTaItjT+QvujECmQMLa7PQ97usqzBByg0Hm8rxLr2S5L04qS6VCAiQOR2GbVKBaZDn9uENQTTbK1COf8pLR3dfRoRsdBi8YRLnDhKI6YRu8hi56RUDcc6ancojWOTlXOIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vTlXZdFKIOJirBykCmjvd0FxmMiiqOioLW0EZJ0TXtM=;
 b=mxA7OVFBbwF7B1hHEgxMoZN93BHFg9rntmP2K+ctSo69yukOnUAdgvj/R38/FIDFDozTAmSTj/WSv3puJS686CjfbEj5zQelUhw4/ObcKYpd98Xw1VozrqIRe5nDzFedmYLujJ+PR9VaEdMlO9x0iyPVoPttUUxnKZ5I7q5HcOnmiHi7fRarEcIdJl+U2rD97UTN/gFjIiNY8hupNOMJg6MYDGlQFsHasQxoSrwSZUECRNsU9uC31eHlX3z7rYYNewg53KPLDiJ+FG/Z5RCwDXZQE9MawR3YssHZhvl3h1X0H0ziQHbQBT1BtIfyujAizwrwPSMeHHB+wn6omreM4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vTlXZdFKIOJirBykCmjvd0FxmMiiqOioLW0EZJ0TXtM=;
 b=i5atNfcuFKLb+rcXLw3Jpi2Aixuqa9l8pEDdiy0b9Fm4s9cnHZ8NakfKmsb6HYOKoc4t43ZcXarXgmZuT/L/0+AJrGHbcGEGU+jrTOkaSRy+/frJxAvm0R9RYKN7/qRaaw9lSWyJOpwJ66P2tl5lFvMDoRjrxEOu+gIBAypl9yaJJUFN/n81ojkoeaGg7MJhy426R/8MXh/8aRdks6LquSweLkLDmUTwWzZz/R9gmNaku1CDd70MInzUF+466dWiOVAOyPodEwZ46YZtyJ67qBSqdDzK44HyAISL+EFNAlpqQVfd9edmtYqBMfdEj08pAEVnDZD/ZemSh2Ty5OkjEQ==
Received: from BN8PR16CA0036.namprd16.prod.outlook.com (2603:10b6:408:4c::49)
 by CH2PR12MB4085.namprd12.prod.outlook.com (2603:10b6:610:79::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.34; Wed, 19 Oct
 2022 12:55:36 +0000
Received: from BN8NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:4c:cafe::ee) by BN8PR16CA0036.outlook.office365.com
 (2603:10b6:408:4c::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26 via Frontend
 Transport; Wed, 19 Oct 2022 12:55:36 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=nvidia.com;
Received-SPF: None (protection.outlook.com: nvidia.com does not designate
 permitted sender hosts)
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT018.mail.protection.outlook.com (10.13.176.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5746.16 via Frontend Transport; Wed, 19 Oct 2022 12:55:36 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Wed, 19 Oct
 2022 05:55:18 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Wed, 19 Oct
 2022 05:55:18 -0700
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.986.29 via Frontend Transport; Wed, 19 Oct
 2022 05:55:15 -0700
From:   Eli Cohen <elic@nvidia.com>
To:     <mst@redhat.com>, <jasowang@redhat.com>,
        <linux-kernel@vger.kernel.org>,
        <virtualization@lists.linux-foundation.org>
CC:     <si-wei.liu@oracle.com>, <eperezma@redhat.com>, <lulu@redhat.com>,
        "Eli Cohen" <elic@nvidia.com>
Subject: [PATCH v2 resend 4/4] vdpa/mlx5: Add RX counters to debugfs
Date:   Wed, 19 Oct 2022 15:55:00 +0300
Message-ID: <20221019125500.208841-5-elic@nvidia.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221019125500.208841-1-elic@nvidia.com>
References: <20221019125500.208841-1-elic@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT018:EE_|CH2PR12MB4085:EE_
X-MS-Office365-Filtering-Correlation-Id: ef7891f1-b785-4ccb-f9bb-08dab1d137a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qGTp0QERgKQ30QTnjolrOq0hB75Ct9xd+yYylvOxSnAfDE59LWyqGf/uz761U0NQ1F4bmp/OkMcI+AuqjUjEIjR5/BxHDO1O3Mk0aazif0ue5E0bBe3Ibjnvxb+kz/OxadfB/JHLI5NqdImGGXUfIFU0UFIynW3kC5VlnBZB1FBrQcZvjT5eLgC08ZhqM3SVdMtNkbjL8jDjVSBuvhFVxZBU1I32WlY0vmfAyi62Qd1i471FfT7mc7uavpTn0uBC4DxFqXV3OopDSNwLrhRjinwUu03oAcA+No+XHK9cFcfehLzyypHrn4cNq8tgDvHjubhb3BAAbF2CAc1Zmg6gCgu6a+Fm2obcQdJSWeCovsZvs9uFVcMMfMuv+jNFaXnQoi9cDiMXoBnN5RZui4lCxGRMulhGAvAWzGobfqr8eLaO3b8ENNsUsY49qvx2kk1B86YYVHGIeDDe4+054xuYrGycte/iUt9kBvMZaLTyq26ibarM3CrliEo3+W5E/hNHOfDFyJLfOIv0rjIW/tVrQOZW6TdKBuO+B48fDM3M6O8oAdLNLsKAqFab+Fv3Xe/lr9dzQ/LJvd9FRJ7dGVnKF/H1sn7wmq3Fzj/7ByN6W6aG6fVUzlFfP/PG7SPx3AlY1Alc9uYcRsx4kb4uUyfBexyPhfHNYSjzS7ppZimw4NqHI+MKDo4fy8CHH4xMXBOs2qLAAt1Q8G94ZbIGI+MPXsBJgQ16m//0kCvjrPp/0f5vgKRvpViMBJs/Qtt1+5U7kILPapVbvGFsVDPAkw6QhxbCNFe0ObxUGfDKXXp/Ksg=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(346002)(396003)(39860400002)(451199015)(36840700001)(40470700004)(46966006)(186003)(26005)(7696005)(107886003)(6666004)(1076003)(2616005)(47076005)(426003)(83380400001)(336012)(30864003)(2906002)(40480700001)(5660300002)(40460700003)(36860700001)(82310400005)(110136005)(54906003)(41300700001)(478600001)(316002)(8936002)(4326008)(8676002)(70206006)(70586007)(36756003)(86362001)(7636003)(356005)(82740400003)(290074003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2022 12:55:36.4286
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef7891f1-b785-4ccb-f9bb-08dab1d137a6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4085
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
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
 drivers/vdpa/Kconfig              |  12 ++++
 drivers/vdpa/mlx5/net/debug.c     |  86 ++++++++++++++++++++++
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 114 +++++++++++++++++++++++-------
 drivers/vdpa/mlx5/net/mlx5_vnet.h |  30 ++++++++
 4 files changed, 215 insertions(+), 27 deletions(-)

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
index 95e4801df211..60d6ac68cdc4 100644
--- a/drivers/vdpa/mlx5/net/debug.c
+++ b/drivers/vdpa/mlx5/net/debug.c
@@ -49,6 +49,92 @@ void mlx5_vdpa_add_rx_flow_table(struct mlx5_vdpa_net *ndev)
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
+	node->ucast_counter.mdev = ndev->mvdev.mdev;
+	node->mcast_counter.mdev = ndev->mvdev.mdev;
+	if (node->tagged) {
+		vid = key2vid(node->macvlan);
+		snprintf(vidstr, sizeof(vidstr), "0x%x", vid);
+	} else {
+		strcpy(vidstr, ut);
+	}
+
+	node->dent = debugfs_create_dir(vidstr, ndev->rx_dent);
+	if (IS_ERR(node->dent)) {
+		node->dent = NULL;
+		return;
+	}
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
+	if (node->dent && ndev->debugfs)
+		debugfs_remove_recursive(node->dent);
+}
+#endif
+
 void mlx5_vdpa_add_debugfs(struct mlx5_vdpa_net *ndev)
 {
 	struct mlx5_core_dev *mdev;
diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index b9353c642b85..4cc674a84c3c 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -1404,12 +1404,56 @@ static void destroy_tir(struct mlx5_vdpa_net *ndev)
 #define MAX_STEERING_ENT 0x8000
 #define MAX_STEERING_GROUPS 2
 
+#if defined(CONFIG_MLX5_VDPA_STEERING_DEBUG)
+       #define NUM_DESTS 2
+#else
+       #define NUM_DESTS 1
+#endif
+
+static int add_steering_counters(struct mlx5_vdpa_net *ndev,
+				 struct macvlan_node *node,
+				 struct mlx5_flow_act *flow_act,
+				 struct mlx5_flow_destination *dests)
+{
+#if defined(CONFIG_MLX5_VDPA_STEERING_DEBUG)
+	int err;
+
+	node->ucast_counter.counter = mlx5_fc_create(ndev->mvdev.mdev, false);
+	if (IS_ERR(node->ucast_counter.counter))
+		return PTR_ERR(node->ucast_counter.counter);
+
+	node->mcast_counter.counter = mlx5_fc_create(ndev->mvdev.mdev, false);
+	if (IS_ERR(node->mcast_counter.counter)) {
+		err = PTR_ERR(node->mcast_counter.counter);
+		goto err_mcast_counter;
+	}
+
+	dests[1].type = MLX5_FLOW_DESTINATION_TYPE_COUNTER;
+	dests[1].counter_id = mlx5_fc_id(node->ucast_counter.counter);
+	flow_act->action |= MLX5_FLOW_CONTEXT_ACTION_COUNT;
+	return 0;
+
+err_mcast_counter:
+	mlx5_fc_destroy(ndev->mvdev.mdev, node->ucast_counter.counter);
+	return err;
+#else
+	return 0;
+#endif
+}
+
+static void remove_steering_counters(struct mlx5_vdpa_net *ndev,
+				     struct macvlan_node *node)
+{
+#if defined(CONFIG_MLX5_VDPA_STEERING_DEBUG)
+	mlx5_fc_destroy(ndev->mvdev.mdev, node->mcast_counter.counter);
+	mlx5_fc_destroy(ndev->mvdev.mdev, node->ucast_counter.counter);
+#endif
+}
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
@@ -1418,11 +1462,13 @@ static int mlx5_vdpa_add_mac_vlan_rules(struct mlx5_vdpa_net *ndev, u8 *mac,
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
@@ -1434,44 +1480,55 @@ static int mlx5_vdpa_add_mac_vlan_rules(struct mlx5_vdpa_net *ndev, u8 *mac,
 		MLX5_SET(fte_match_set_lyr_2_4, headers_c, cvlan_tag, 1);
 		MLX5_SET_TO_ONES(fte_match_set_lyr_2_4, headers_c, first_vid);
 	}
-	if (tagged) {
+	if (node->tagged) {
 		MLX5_SET(fte_match_set_lyr_2_4, headers_v, cvlan_tag, 1);
 		MLX5_SET(fte_match_set_lyr_2_4, headers_v, first_vid, vid);
 	}
 	flow_act.action = MLX5_FLOW_CONTEXT_ACTION_FWD_DEST;
-	dest.type = MLX5_FLOW_DESTINATION_TYPE_TIR;
-	dest.tir_num = ndev->res.tirn;
-	rule = mlx5_add_flow_rules(ndev->rxft, spec, &flow_act, &dest, 1);
-	if (IS_ERR(rule))
-		return PTR_ERR(rule);
+	dests[0].type = MLX5_FLOW_DESTINATION_TYPE_TIR;
+	dests[0].tir_num = ndev->res.tirn;
+	err = add_steering_counters(ndev, node, &flow_act, dests);
+	if (err)
+		goto out_free;
+
+	node->ucast_rule = mlx5_add_flow_rules(ndev->rxft, spec, &flow_act, dests, NUM_DESTS);
+	if (IS_ERR(rule)) {
+		err = PTR_ERR(rule);
+		goto err_ucast;
+	}
 
-	*ucast = rule;
+#if defined(CONFIG_MLX5_VDPA_STEERING_DEBUG)
+	dests[1].counter_id = mlx5_fc_id(node->mcast_counter.counter);
+#endif
 
 	memset(dmac_c, 0, ETH_ALEN);
 	memset(dmac_v, 0, ETH_ALEN);
 	dmac_c[0] = 1;
 	dmac_v[0] = 1;
-	rule = mlx5_add_flow_rules(ndev->rxft, spec, &flow_act, &dest, 1);
-	kvfree(spec);
+	node->mcast_rule = mlx5_add_flow_rules(ndev->rxft, spec, &flow_act, dests, NUM_DESTS);
 	if (IS_ERR(rule)) {
 		err = PTR_ERR(rule);
 		goto err_mcast;
 	}
-
-	*mcast = rule;
+	kvfree(spec);
+	mlx5_vdpa_add_rx_counters(ndev, node);
 	return 0;
 
 err_mcast:
-	mlx5_del_flow_rules(*ucast);
+	mlx5_del_flow_rules(node->ucast_rule);
+err_ucast:
+	remove_steering_counters(ndev, node);
+out_free:
+	kvfree(spec);
 	return err;
 }
 
 static void mlx5_vdpa_del_mac_vlan_rules(struct mlx5_vdpa_net *ndev,
-					 struct mlx5_flow_handle *ucast,
-					 struct mlx5_flow_handle *mcast)
+					 struct macvlan_node *node)
 {
-	mlx5_del_flow_rules(ucast);
-	mlx5_del_flow_rules(mcast);
+	mlx5_vdpa_remove_rx_counters(ndev, node);
+	mlx5_del_flow_rules(node->ucast_rule);
+	mlx5_del_flow_rules(node->mcast_rule);
 }
 
 static u64 search_val(u8 *mac, u16 vlan, bool tagged)
@@ -1505,14 +1562,14 @@ static struct macvlan_node *mac_vlan_lookup(struct mlx5_vdpa_net *ndev, u64 valu
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
 
@@ -1520,12 +1577,13 @@ static int mac_vlan_add(struct mlx5_vdpa_net *ndev, u8 *mac, u16 vlan, bool tagg
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
@@ -1544,7 +1602,8 @@ static void mac_vlan_del(struct mlx5_vdpa_net *ndev, u8 *mac, u16 vlan, bool tag
 		return;
 
 	hlist_del(&ptr->hlist);
-	mlx5_vdpa_del_mac_vlan_rules(ndev, ptr->ucast_rule, ptr->mcast_rule);
+	mlx5_vdpa_del_mac_vlan_rules(ndev, ptr);
+	remove_steering_counters(ndev, ptr);
 	kfree(ptr);
 }
 
@@ -1557,7 +1616,8 @@ static void clear_mac_vlan_table(struct mlx5_vdpa_net *ndev)
 	for (i = 0; i < MLX5V_MACVLAN_SIZE; i++) {
 		hlist_for_each_entry_safe(pos, n, &ndev->macvlan_hash[i], hlist) {
 			hlist_del(&pos->hlist);
-			mlx5_vdpa_del_mac_vlan_rules(ndev, pos->ucast_rule, pos->mcast_rule);
+			mlx5_vdpa_del_mac_vlan_rules(ndev, pos);
+			remove_steering_counters(ndev, pos);
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

