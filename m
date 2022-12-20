Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53919652431
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 17:05:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233438AbiLTQE5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 11:04:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233966AbiLTQEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 11:04:25 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2066.outbound.protection.outlook.com [40.107.237.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB47318B1A;
        Tue, 20 Dec 2022 08:04:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dIIvfYblJTJhS/shXwMitM+NAP5+T/97Uyc3Hx5p6CEnI0vbVCxzKd0cVuKdIdWD6WNo23lOSPzDBxLN5gXwR9dihggioKZyvKRAUdhdExkf2Pk1+yr8KVNsnmmhs8akUeYSMtlhmTC06Sc4gAQts2Y02mXpWtprmGkGNOOzyAWEZlGnu4rlB0xrSmq7kL3MadlTuNaLK7Sw4J/RiU8Tmmdb0MjQ7BKMYFUn5Al6NDtLjdEHBu3UFThNUXc3Cus157m+gKEW1S5rF4wQQYc5/PzUfX08FX8Fu3eZ63ujx51otsJqxjgBvELOF1CFRt0U/KqQEVFEONQobzBwQipTmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aMBze2lUDGe49y9mBsS0lygtGppQEuGNK7Eq20IEFGI=;
 b=e8n9hsMCEEmoVV5K0ay6zLfcqwhbQDyA06F9vlxKUtp6M2MY2hnXDnWZQhthsdGFS2ioyi5Kx751j0HQWZaTPr5m7O8AloOHhGR6uOxKmUyQ4lsIYP733GPo/Kth8Y9T3Ra0CEoWF6r6H+208YxvJmX6FN0Fzz/iybuutEKUAJLDPkZjzL6LToB27odP/N+3RJN6/khrv6bZsGd7JbKH3wWhS9WkZqDERdRbRAjE4lW44umX/lzyjvz+0TQQAos76kOjB6FkC907P3znhIMLc6GWeFsXPUfPV8V4Un0aEwNuNICRTRWAaVj1FFEPFq7P2Z6WqDYotfo6cillyzAXug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=linaro.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aMBze2lUDGe49y9mBsS0lygtGppQEuGNK7Eq20IEFGI=;
 b=lidHEl+9SNNVMv2E7oFKz+0Al/SMEsb5sO930X9P30Mxzp3jmmtgSf2LIRaq5L7KbRZIRubjIhi06rwaQ3W5c22DZK0et+4CcmhsRRLW8TXvuGjHNhJK8qCBsu8PCS+Jg9OGvxlLiDJCxU4yAVZWZVGmBoe4BWP+pwKVQ+MNFZvKl6EbkM9qhdYKv2CpABFTV3JF4qYpriFwiMJFv2tTof51u1JyCnI58SFeteJqJD+Bfm3ZyopYnQLLIFVaML1Fg+1chbGO6cPbZRt/5ib2Pi7a7MXPGkuzsNsQaVIeDz40kvQQns+WHTSxVU25lb6nL8RybIGlDT0fGGv31PrfAQ==
Received: from MW4PR03CA0274.namprd03.prod.outlook.com (2603:10b6:303:b5::9)
 by SN7PR12MB8147.namprd12.prod.outlook.com (2603:10b6:806:32e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Tue, 20 Dec
 2022 16:04:16 +0000
Received: from CO1NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b5:cafe::f9) by MW4PR03CA0274.outlook.office365.com
 (2603:10b6:303:b5::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.21 via Frontend
 Transport; Tue, 20 Dec 2022 16:04:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1NAM11FT046.mail.protection.outlook.com (10.13.174.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5944.6 via Frontend Transport; Tue, 20 Dec 2022 16:04:15 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 20 Dec
 2022 08:04:08 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Tue, 20 Dec 2022 08:04:08 -0800
Received: from sumitg-l4t.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.36 via Frontend
 Transport; Tue, 20 Dec 2022 08:04:04 -0800
From:   Sumit Gupta <sumitg@nvidia.com>
To:     <treding@nvidia.com>, <krzysztof.kozlowski@linaro.org>,
        <dmitry.osipenko@collabora.com>, <viresh.kumar@linaro.org>,
        <rafael@kernel.org>, <jonathanh@nvidia.com>, <robh+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     <sanjayc@nvidia.com>, <ksitaraman@nvidia.com>, <ishah@nvidia.com>,
        <bbasu@nvidia.com>, <sumitg@nvidia.com>
Subject: [Patch v1 04/10] memory: tegra: add support for software mc clients in Tegra234
Date:   Tue, 20 Dec 2022 21:32:34 +0530
Message-ID: <20221220160240.27494-5-sumitg@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221220160240.27494-1-sumitg@nvidia.com>
References: <20221220160240.27494-1-sumitg@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT046:EE_|SN7PR12MB8147:EE_
X-MS-Office365-Filtering-Correlation-Id: 62112302-1bcf-4901-e266-08dae2a3d7f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: coa9nE2R5ivQDAkHn0A1gM9l3WX0x+gBWcYe1pFwoZOngQz3Ucbx94BP/xxDgtVHgnaCwGt77QC/sCG2Kbpm5tmeluvCvINq24tzL/HVCc+HXNQzKR81mwgoZ2zXpTbV9hU1bjaueRFre5fcXYFv69XcUVuN6nCxuiKfaWuJWpzVNVDrnDohyA0NidtGgNpjc9MQz4rVYjzEO12wPE0YzXKZP4GfKz9wmcOoyx6hq31cXurEuLpaUpUwomiuHLW/5o+QEq/ny1RRBNGBShtHu4L5/aGeXJ+1Obv4h3OHK9imSbgnQAAJhWlcn4iF3Mn4NZ+7ZQHmm2TZlVwyDVqcrVHFvNNd5JR8ohfNQ2XKJOsZaxJOY9+X22NQvw62uJyl8016lbgrBTJnSJxeanZL3e2DEYxo9fuJVQkuBLK7ovQz47NinCwLuadMEPkiNLa9oQP86XcRcEUJSCTU7ga9d9d/xcnDSMMKecyokzp/UWKeZHg5mm8R5clm8Y/oqPs0BKDg60Ytkf8M3IuPDI68XFXgBSUV30T0eJMOe53/9xqQ6FkLyyhWEY0mdgMidwtCZlTvg7auIq/8anpEgNqC5qO+10jkkZxk9xBxIxsPmLi6JeB1R/fvxvmcmSkoenCUZyWjOYpe2cQwMqNAYDoGZSa9GnWWrox7xtvTGCjlGn6O4Ay1/BhkvVTVJmlTbHsR+IFIvwLPAFcGfVjmjIfBYg8zKtOBiC6In3sa3xjyPY4=
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(396003)(136003)(346002)(451199015)(40470700004)(46966006)(36840700001)(107886003)(6666004)(478600001)(2616005)(7696005)(70206006)(40480700001)(70586007)(186003)(26005)(110136005)(316002)(1076003)(86362001)(54906003)(40460700003)(36860700001)(41300700001)(36756003)(47076005)(336012)(356005)(921005)(4326008)(8936002)(426003)(8676002)(2906002)(5660300002)(82740400003)(7636003)(82310400005)(83380400001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2022 16:04:15.6040
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 62112302-1bcf-4901-e266-08dae2a3d7f3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8147
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding support for dummy memory controller clients for use by
software.
---
 drivers/memory/tegra/mc.c       | 65 +++++++++++++++++++++++----------
 drivers/memory/tegra/tegra234.c | 21 +++++++++++
 include/soc/tegra/mc.h          |  3 ++
 include/soc/tegra/tegra-icc.h   |  7 ++++
 4 files changed, 76 insertions(+), 20 deletions(-)

diff --git a/drivers/memory/tegra/mc.c b/drivers/memory/tegra/mc.c
index ff887fb03bce..4ddf9808fe6b 100644
--- a/drivers/memory/tegra/mc.c
+++ b/drivers/memory/tegra/mc.c
@@ -755,6 +755,39 @@ const char *const tegra_mc_error_names[8] = {
 	[6] = "SMMU translation error",
 };
 
+static int tegra_mc_add_icc_node(struct tegra_mc *mc, unsigned int id, const char *name,
+				 unsigned int bpmp_id, unsigned int type)
+{
+	struct tegra_icc_node *tnode;
+	struct icc_node *node;
+	int err;
+
+	tnode = kzalloc(sizeof(*tnode), GFP_KERNEL);
+	if (!tnode)
+		return -ENOMEM;
+
+	/* create MC client node */
+	node = icc_node_create(id);
+	if (IS_ERR(node))
+		return -EINVAL;
+
+	node->name = name;
+	icc_node_add(node, &mc->provider);
+
+	/* link Memory Client to Memory Controller */
+	err = icc_link_create(node, TEGRA_ICC_MC);
+	if (err)
+		return err;
+
+	node->data = tnode;
+	tnode->node = node;
+	tnode->bpmp_id = bpmp_id;
+	tnode->type = type;
+	tnode->mc = mc;
+
+	return 0;
+}
+
 /*
  * Memory Controller (MC) has few Memory Clients that are issuing memory
  * bandwidth allocation requests to the MC interconnect provider. The MC
@@ -780,7 +813,6 @@ const char *const tegra_mc_error_names[8] = {
  */
 static int tegra_mc_interconnect_setup(struct tegra_mc *mc)
 {
-	struct tegra_icc_node *tnode;
 	struct icc_node *node;
 	unsigned int i;
 	int err;
@@ -820,30 +852,23 @@ static int tegra_mc_interconnect_setup(struct tegra_mc *mc)
 		goto remove_nodes;
 
 	for (i = 0; i < mc->soc->num_clients; i++) {
-		tnode = kzalloc(sizeof(*tnode), GFP_KERNEL);
-		if (!tnode)
-			return -ENOMEM;
-
-		/* create MC client node */
-		node = icc_node_create(mc->soc->clients[i].id);
-		if (IS_ERR(node)) {
-			err = PTR_ERR(node);
+		err = tegra_mc_add_icc_node(mc, mc->soc->clients[i].id,
+					    mc->soc->clients[i].name,
+					    mc->soc->clients[i].bpmp_id,
+					    mc->soc->clients[i].type);
+		if (err)
 			goto remove_nodes;
-		}
 
-		node->name = mc->soc->clients[i].name;
-		icc_node_add(node, &mc->provider);
+	}
+
+	for (i = 0; i < mc->soc->num_sw_clients; i++) {
+		err =  tegra_mc_add_icc_node(mc, mc->soc->sw_clients[i].id,
+					     mc->soc->sw_clients[i].name,
+					     mc->soc->sw_clients[i].bpmp_id,
+					     mc->soc->sw_clients[i].type);
 
-		/* link Memory Client to Memory Controller */
-		err = icc_link_create(node, TEGRA_ICC_MC);
 		if (err)
 			goto remove_nodes;
-
-		node->data = tnode;
-		tnode->node = node;
-		tnode->type = mc->soc->clients[i].type;
-		tnode->bpmp_id = mc->soc->clients[i].bpmp_id;
-		tnode->mc = mc;
 	}
 
 	return 0;
diff --git a/drivers/memory/tegra/tegra234.c b/drivers/memory/tegra/tegra234.c
index 420546270c8b..82ce6c3c3eb0 100644
--- a/drivers/memory/tegra/tegra234.c
+++ b/drivers/memory/tegra/tegra234.c
@@ -780,6 +780,25 @@ static const struct tegra_mc_client tegra234_mc_clients[] = {
 	}
 };
 
+static const struct tegra_mc_sw_client tegra234_mc_sw_clients[] = {
+	{
+		.id = TEGRA_ICC_MC_CPU_CLUSTER0,
+		.name = "sw_cluster0",
+		.bpmp_id = TEGRA_ICC_BPMP_CPU_CLUSTER0,
+		.type = TEGRA_ICC_NISO,
+	}, {
+		.id = TEGRA_ICC_MC_CPU_CLUSTER1,
+		.name = "sw_cluster1",
+		.bpmp_id = TEGRA_ICC_BPMP_CPU_CLUSTER1,
+		.type = TEGRA_ICC_NISO,
+	}, {
+		.id = TEGRA_ICC_MC_CPU_CLUSTER2,
+		.name = "sw_cluster2",
+		.bpmp_id = TEGRA_ICC_BPMP_CPU_CLUSTER2,
+		.type = TEGRA_ICC_NISO,
+	},
+};
+
 /*
  * tegra234_mc_icc_set() - Pass MC client info to External Memory Controller (EMC)
  * @src: ICC node for Memory Controller's (MC) Client
@@ -854,6 +873,8 @@ static const struct tegra_mc_icc_ops tegra234_mc_icc_ops = {
 const struct tegra_mc_soc tegra234_mc_soc = {
 	.num_clients = ARRAY_SIZE(tegra234_mc_clients),
 	.clients = tegra234_mc_clients,
+	.num_sw_clients = ARRAY_SIZE(tegra234_mc_sw_clients),
+	.sw_clients = tegra234_mc_sw_clients,
 	.num_address_bits = 40,
 	.num_channels = 16,
 	.client_id_mask = 0x1ff,
diff --git a/include/soc/tegra/mc.h b/include/soc/tegra/mc.h
index 0a32a9eb12a4..6a94e88b6100 100644
--- a/include/soc/tegra/mc.h
+++ b/include/soc/tegra/mc.h
@@ -192,6 +192,9 @@ struct tegra_mc_soc {
 	const struct tegra_mc_client *clients;
 	unsigned int num_clients;
 
+	const struct tegra_mc_sw_client *sw_clients;
+	unsigned int num_sw_clients;
+
 	const unsigned long *emem_regs;
 	unsigned int num_emem_regs;
 
diff --git a/include/soc/tegra/tegra-icc.h b/include/soc/tegra/tegra-icc.h
index 3855d8571281..f9bcaae8ffee 100644
--- a/include/soc/tegra/tegra-icc.h
+++ b/include/soc/tegra/tegra-icc.h
@@ -22,6 +22,13 @@ struct tegra_icc_node {
 	u32 type;
 };
 
+struct tegra_mc_sw_client {
+	unsigned int id;
+	unsigned int bpmp_id;
+	unsigned int type;
+	const char *name;
+};
+
 /* ICC ID's for MC client's used in BPMP */
 #define TEGRA_ICC_BPMP_DEBUG		1
 #define TEGRA_ICC_BPMP_CPU_CLUSTER0	2
-- 
2.17.1

