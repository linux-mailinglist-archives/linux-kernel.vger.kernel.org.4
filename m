Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3787626FD3
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Nov 2022 14:45:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235388AbiKMNpg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 08:45:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235405AbiKMNp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 08:45:27 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2075.outbound.protection.outlook.com [40.107.244.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A825812ACF
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 05:45:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oMeRTjHD3dw7KqZrms/JBm/UEO51U5DFqfQ6HR2BMPkC302J0kTohv/l5InVpOnilZXahWIW39FUSSNiczRamz4T5w63FQ8AAMyYrsmDfVNREWTzJxuh67jMGMKtWHTbBPVpwyUlVJuii6h/THtYDEFpL+jSYNL3nnnw0mXfGoo56X+cH379lnDBjlXSAt303t5LYmpeN/nPAiZBDyFGNdz+LCIOV0I5QpPf+Nj8f44rEorCaFUYh0WWVYKkjZ3fl15ib3eMxlbCSF5Dw8P4VWDXjLXvi9eOgC23F0KWRKkyJYH1Wg6yws0qq7Vh6ZsYrOH/Q7s/IKqQYSia1ffumw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VwGJsXFTQHXSvdkXGXxGIfBK/nbeylSdILWJjYlVRys=;
 b=dqn3fOxK6uqknXWEVNGeckbj3Hi1h5OkkMKh72i0d7wDesmzx5b9kZuXahXHfX60pJ/S4XQduGNF/4bnwuXHyCw/AMoXdRVmQfqK3vYEyABYmh2+d6N623NwfHixxErWGUWg74HxnDOkfRiVPZ16E7dprbvzD95Lp0y3bgQIGBfvlouBhORhti8B6k74M3fLT60pAvbEjL2KmsepX0bKWxfh9f/tgE264fIU8p6DsIbiH66LV2G+nrTZlQ7sJoso6r6qetXejn4ChDcBpj5FjdhYew17+7PouCIaJh315O/cvd/aAqYWZqiNForXRpUH8to87VRGsuBrSVKxp+69rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VwGJsXFTQHXSvdkXGXxGIfBK/nbeylSdILWJjYlVRys=;
 b=UUeYeZEJbiUwKTT4N8jGDkrmNFmuLG3fuq/OOc5Rl2W8um8B62h2I2VC1xYvf2ZXb8cPAO/mocdcOmstNYgK2n1ClNP7U6pdTOZqHGoArAUnWjsazMdG0V04Ua5/SDq/tgc+fWwsyiiqheavjEUqKuW0bJu1prcl2H//WfaHQb3BjnquaT3ZH7NZFNP3b+Cz5Gk+KztvgEK5r4LNdme6G9yzAv7SLCWcSFrmAqP7QWzv3eAouq282HaovpJfhKK+VbjzldFNJk7ixofEoI6FakvOWfqhYxlX9uenyum7vHk4WOT9SaIEeXzl8tljjoBgWEtkijT5GIyvJfEBuavwDg==
Received: from BN9PR03CA0905.namprd03.prod.outlook.com (2603:10b6:408:107::10)
 by MW3PR12MB4554.namprd12.prod.outlook.com (2603:10b6:303:55::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Sun, 13 Nov
 2022 13:45:15 +0000
Received: from BL02EPF0000C407.namprd05.prod.outlook.com
 (2603:10b6:408:107:cafe::58) by BN9PR03CA0905.outlook.office365.com
 (2603:10b6:408:107::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17 via Frontend
 Transport; Sun, 13 Nov 2022 13:45:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0000C407.mail.protection.outlook.com (10.167.241.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5813.11 via Frontend Transport; Sun, 13 Nov 2022 13:45:14 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Sun, 13 Nov
 2022 05:45:02 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Sun, 13 Nov
 2022 05:45:01 -0800
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.986.36 via Frontend Transport; Sun, 13 Nov
 2022 05:44:59 -0800
From:   Eli Cohen <elic@nvidia.com>
To:     <mst@redhat.com>, <jasowang@redhat.com>,
        <linux-kernel@vger.kernel.org>,
        <virtualization@lists.linux-foundation.org>
CC:     <si-wei.liu@oracle.com>, <eperezma@redhat.com>, <lulu@redhat.com>,
        "Eli Cohen" <elic@nvidia.com>
Subject: [PATCH 5/7] vdpa/mlx5: Add RX counters to debugfs
Date:   Sun, 13 Nov 2022 15:44:40 +0200
Message-ID: <20221113134442.152695-6-elic@nvidia.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221113134442.152695-1-elic@nvidia.com>
References: <20221113134442.152695-1-elic@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0000C407:EE_|MW3PR12MB4554:EE_
X-MS-Office365-Filtering-Correlation-Id: 8984d7f4-aefa-414c-b16d-08dac57d4b44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s1WQatFwR/fGQjoVMfJ+AWgO3Neqo7g+c83egskQ+9Gz4EA51AWNPUE860npzrqAOy/xJldlynNq357bJcj+FZljg0JtkWpwgNHvZ8+zMd5kP36mE7QVmxijBzaGwsTebQYwCdfbsRsYzbGesCiOwLqqxJjWy1pMtswN93jKiENkLPO6TSQztBuRIhzB2dff72EpHws59+BkfLGq0voLaRLQeAZ3aI0poE6vPjFIQFq8vwXJtSNXrspJDv0ow8biv6Bu3XziminZp0VnzHPy/L5QYbHLE5GKbiezb4mLN/n42VSUHYShV8oh5u+APVmJGP7cB81kE3TiLHr+RUxGFr0nt9L4UimlikKnAi3YMVz3wHobQMICAcGh4RaGIggpzNgBmeFqo0mHADVyhEJOTdhvZ0SGCzocCDBdjG+65z9euB3DDkxAbeAqTwvcQ649buFd8L8aNpC54w9Ozn/etTXZe8nLRxHo/UDhBcAlwxdZkjLonkJyp5PpeeeqPMN7oaWETuJYPAyTbl4Q7bqHUSWHV5+DyiQpdqnbj2JRbRwIHsICY3MKKK3VuU1hSMManf2udGXuu+sJyxT9K7krY9kBAku7noMNYY/xddmNEkkAkt+M84Tb8mmHokiLKhCVyGlqBqhdicdlSkB+C54qEU3yxsXc0Vbvwm2mp6j9e4R5KiuaOt6wnXLEaeCxZgpm0JU386FJ12R85Qedm1p1ZB9ZibAdIoPdfJH49kG0vd7KHPMAmpJL8hQJ/BxbUotyHH+oKm4APofpDnrWbUH7PKq7NBNU8PPw8XfHBEmxY8Q=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(376002)(39860400002)(396003)(451199015)(40470700004)(46966006)(36840700001)(7696005)(86362001)(6666004)(107886003)(2906002)(478600001)(26005)(5660300002)(30864003)(82310400005)(41300700001)(40480700001)(36860700001)(70206006)(4326008)(8676002)(70586007)(336012)(1076003)(2616005)(426003)(47076005)(186003)(110136005)(40460700003)(356005)(7636003)(83380400001)(82740400003)(8936002)(54906003)(316002)(36756003)(290074003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2022 13:45:14.8692
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8984d7f4-aefa-414c-b16d-08dac57d4b44
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0000C407.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4554
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
 drivers/vdpa/Kconfig              |  12 +++
 drivers/vdpa/mlx5/net/debug.c     |  86 ++++++++++++++++++++++
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 118 +++++++++++++++++++++++-------
 drivers/vdpa/mlx5/net/mlx5_vnet.h |  30 ++++++++
 4 files changed, 218 insertions(+), 28 deletions(-)

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
index ce2f478a93f5..6e6490c85be2 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -1404,12 +1404,55 @@ static void destroy_tir(struct mlx5_vdpa_net *ndev)
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
@@ -1418,11 +1461,13 @@ static int mlx5_vdpa_add_mac_vlan_rules(struct mlx5_vdpa_net *ndev, u8 *mac,
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
@@ -1430,48 +1475,62 @@ static int mlx5_vdpa_add_mac_vlan_rules(struct mlx5_vdpa_net *ndev, u8 *mac,
 	dmac_v = MLX5_ADDR_OF(fte_match_param, headers_v, outer_headers.dmac_47_16);
 	eth_broadcast_addr(dmac_c);
 	ether_addr_copy(dmac_v, mac);
-	if (ndev->mvdev.actual_features & VIRTIO_NET_F_CTRL_VLAN) {
+	if (ndev->mvdev.actual_features & BIT_ULL(VIRTIO_NET_F_CTRL_VLAN)) {
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
+#if defined(CONFIG_MLX5_VDPA_STEERING_DEBUG)
+	dests[1].counter_id = mlx5_fc_id(node->ucast_counter.counter);
+#endif
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
@@ -1505,14 +1564,14 @@ static struct macvlan_node *mac_vlan_lookup(struct mlx5_vdpa_net *ndev, u64 valu
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
 
@@ -1520,12 +1579,13 @@ static int mac_vlan_add(struct mlx5_vdpa_net *ndev, u8 *mac, u16 vlan, bool tagg
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
@@ -1544,7 +1604,8 @@ static void mac_vlan_del(struct mlx5_vdpa_net *ndev, u8 *mac, u16 vlan, bool tag
 		return;
 
 	hlist_del(&ptr->hlist);
-	mlx5_vdpa_del_mac_vlan_rules(ndev, ptr->ucast_rule, ptr->mcast_rule);
+	mlx5_vdpa_del_mac_vlan_rules(ndev, ptr);
+	remove_steering_counters(ndev, ptr);
 	kfree(ptr);
 }
 
@@ -1557,7 +1618,8 @@ static void clear_mac_vlan_table(struct mlx5_vdpa_net *ndev)
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
index f2cef3925e5b..c90a89e1de4d 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.h
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.h
@@ -21,6 +21,11 @@ struct mlx5_vdpa_net_resources {
 
 #define MLX5V_MACVLAN_SIZE 256
 
+static inline u16 key2vid(u64 key)
+{
+	return (u16)(key >> 48) & 0xfff;
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
2.38.1

