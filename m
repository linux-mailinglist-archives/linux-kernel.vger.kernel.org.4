Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3A0C65244A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 17:06:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233985AbiLTQGw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 11:06:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234037AbiLTQGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 11:06:05 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2060.outbound.protection.outlook.com [40.107.244.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04351218F;
        Tue, 20 Dec 2022 08:05:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oO1Fk6I8olRhW/qxD6uS/Em4TwgH1mglADoTQ6tMEWS+LrwWK7KQGzq1YLgsM57CHF1RLTLMvoUQFc8y35EwQDq4HI8A4D1EmV0uoukFCYJR/8v9RznRFCtIVtsEuHpJDLBsMuJnguEpwxQmPRpiZtCc2zz7v8trwwA4zBHnj6eoT4V3thagS70dURomr+DuybuM8+eNHbIaTBqhDDW83H4SioD2p3ZiPKcnupcXwdr0E2yrdiAoNlTbNiiq/dS6D1ePnrx9Q5E3/BSbvj69YkicUO/Rs6c/5dFicLidJBwvUj2yjACR7e9bY0e125sYp0uxAt+Pve1ohVmdXVgjsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f7+QXpWUFrLpq09T95bIRvlU8/tN8LUwtOHD15PgyQk=;
 b=ZPwU/dah3D9ugr4Fv6c7cIYHW3kzEerPjbOhS7X9Ka/SZb48JOjVGCKasRBZFc+2FO8pkFZCl15CoF+itc5QjHrhGOCEL7F5kAGdzLAJIS71DlwONolV0YHx3H1UFk85vfYEfdpD/X2CCVuROJF7F9Fdrjw2Ej0BJZB1I82jPtZqGpms7DBmIDPNErcjBzk8ghgh13ub9NkhWdcYZrZMei8SOFc3daz/3tJN+m7LsS2PwMydM/KqYI6PMOCicn6URKYHPI2rZHUB1+vGEV5elXdeea8RWYlKWlbf82IP1Lj0yo8HjVhyd8bXxdRiYOEcn6xf/mSun8TKh4lcA6JnVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=linaro.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f7+QXpWUFrLpq09T95bIRvlU8/tN8LUwtOHD15PgyQk=;
 b=dZD0b0iVB453LjOmuZrZt31c+O4rFw9qaD+iBT0vnGc0SADhnBcEpTHA5rcXAcsYxc/cjN9mbvaCTerbx82JsrBDDPLNdQDMLISq+IbhV71MMEwnpTK8pG+/0f1FASleJcoZvq2fBrdMilbGSzl4KY+aVweNurmrswr6DOQhOrA21SNqcFBbxUBEMYI9c1X1cdMmhAfg4DEi2KjOfxdl0VoQjmQrukO4o4oyxb8qCm3sptg+E5AvZnJhUi2ZfdaS5DfHbx9RayebJfr0m3a8MWW0k4NCAtf/YR9TuvwqdpubaEoRVW114VELw6ITR/d/1lcCf/mYuCAZnKgQMQMxvA==
Received: from BN8PR15CA0008.namprd15.prod.outlook.com (2603:10b6:408:c0::21)
 by MN2PR12MB4487.namprd12.prod.outlook.com (2603:10b6:208:264::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Tue, 20 Dec
 2022 16:05:41 +0000
Received: from BN8NAM11FT106.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:c0:cafe::c2) by BN8PR15CA0008.outlook.office365.com
 (2603:10b6:408:c0::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.21 via Frontend
 Transport; Tue, 20 Dec 2022 16:05:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN8NAM11FT106.mail.protection.outlook.com (10.13.177.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5944.6 via Frontend Transport; Tue, 20 Dec 2022 16:05:41 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 20 Dec
 2022 08:05:25 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Tue, 20 Dec 2022 08:05:25 -0800
Received: from sumitg-l4t.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.36 via Frontend
 Transport; Tue, 20 Dec 2022 08:05:21 -0800
From:   Sumit Gupta <sumitg@nvidia.com>
To:     <treding@nvidia.com>, <krzysztof.kozlowski@linaro.org>,
        <dmitry.osipenko@collabora.com>, <viresh.kumar@linaro.org>,
        <rafael@kernel.org>, <jonathanh@nvidia.com>, <robh+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     <sanjayc@nvidia.com>, <ksitaraman@nvidia.com>, <ishah@nvidia.com>,
        <bbasu@nvidia.com>, <sumitg@nvidia.com>
Subject: [Patch v1 10/10] memory: tegra: make cluster bw request a multiple of mc_channels
Date:   Tue, 20 Dec 2022 21:32:40 +0530
Message-ID: <20221220160240.27494-11-sumitg@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221220160240.27494-1-sumitg@nvidia.com>
References: <20221220160240.27494-1-sumitg@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT106:EE_|MN2PR12MB4487:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ccb5cd1-3ef7-4100-85dc-08dae2a40b23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E39BhzSpKJNVoaClfWttTnsavOwGqxI0Xc4jCYvANKu6WYQ4PaRKVj7s9TOlqby9SZXb0B4SJMSa6E2Sys0A4ZMOd+Pz4r3h799i5v3VtJF/vEblCq49jETe0neASogTyXMoXibbpDWggBcQWnTC58uW7CuLPk6gjeqQHijU8Ca9SFDqFVmxc5wNKetRnzgpMlPnW5/Yzh8e+NLj4iqHu5SOPzgogskqkkCAvIfGQvNTxYTAC9m5kQQeqeCfWyTbYFzDCKUAQYoSb3zhJiDiKeWFz2tN7HFkFhzVOLp0e9mgiV6pda7RgplKC+04j9sLMahFesiPQcrEpshyZsQp4qmuiO0o4rfTJRuq+6dCgtJ1GjS/38EpcFURHsrPPupPMj83G9C0wU509mKd3uPtZu3pxeY6irmJ8FOgl6P6IUpZIPEX5KqXGbiJXeZh4C06lW3q6NnFMzcGRaO9Sjai+0LW2YIXG9T2K/iNP19MT6sGutrMWMdUDHTji47eOpDoRcFmvpUCVui5jIU8gB1bfDIXzQVM5/XJ0yFcgs1JbeApf8qXmXqdmg2Rr1cp5CfO5OE0la0rRNX8qme3auYUZ+tu4QfigOwORqwAyJQGnuGGOXXf0ip+durzwvQ8AH/ujDbWlv4C+Kr6cbNt+TFS6Acq6YXjBbdbyOHIzA9z+i0VsQbrX3QEvRIzfPeqQPtmcJHndvg1uGRFCBvJkQZEPDwne3rPvOXYcXrMjJmOmbk=
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(376002)(346002)(136003)(451199015)(46966006)(40470700004)(36840700001)(86362001)(82740400003)(36756003)(8936002)(921005)(356005)(7636003)(36860700001)(107886003)(82310400005)(5660300002)(47076005)(40460700003)(83380400001)(2906002)(8676002)(1076003)(70586007)(41300700001)(70206006)(4326008)(2616005)(336012)(426003)(7696005)(186003)(478600001)(110136005)(6666004)(54906003)(316002)(40480700001)(26005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2022 16:05:41.3706
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ccb5cd1-3ef7-4100-85dc-08dae2a40b23
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT106.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4487
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CPU opp table have bandwidth data per MC channel. The actual bandwidth
depends on number of MC channels which can change as per the boot config
for a board. So, multiply the bandwidth request for CPU clusters with
number of enabled MC channels. This is not required to be done for other
MC clients.

Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
 drivers/memory/tegra/tegra234.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/memory/tegra/tegra234.c b/drivers/memory/tegra/tegra234.c
index 82ce6c3c3eb0..a45fc99b9c82 100644
--- a/drivers/memory/tegra/tegra234.c
+++ b/drivers/memory/tegra/tegra234.c
@@ -834,6 +834,29 @@ static int tegra234_mc_icc_set(struct icc_node *src, struct icc_node *dst)
 	return 0;
 }
 
+static int tegra234_mc_icc_aggregate(struct icc_node *node, u32 tag, u32 avg_bw,
+				     u32 peak_bw, u32 *agg_avg, u32 *agg_peak)
+{
+	struct tegra_icc_node *tnode = NULL;
+	struct tegra_mc *mc = NULL;
+
+	if (node->id == TEGRA_ICC_MC_CPU_CLUSTER0 ||
+	    node->id == TEGRA_ICC_MC_CPU_CLUSTER1 ||
+	    node->id == TEGRA_ICC_MC_CPU_CLUSTER2) {
+		if (node->data) {
+			tnode = node->data;
+			mc = tnode->mc;
+			if (mc)
+				peak_bw = peak_bw * mc->num_channels;
+		}
+	}
+
+	*agg_avg += avg_bw;
+	*agg_peak = max(*agg_peak, peak_bw);
+
+	return 0;
+}
+
 static struct icc_node*
 tegra234_mc_of_icc_xlate(struct of_phandle_args *spec, void *data)
 {
@@ -866,7 +889,7 @@ static int tegra234_mc_icc_get_init_bw(struct icc_node *node, u32 *avg, u32 *pea
 static const struct tegra_mc_icc_ops tegra234_mc_icc_ops = {
 	.xlate = tegra234_mc_of_icc_xlate,
 	.get_bw = tegra234_mc_icc_get_init_bw,
-	.aggregate = icc_std_aggregate,
+	.aggregate = tegra234_mc_icc_aggregate,
 	.set = tegra234_mc_icc_set,
 };
 
-- 
2.17.1

