Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5A795BE419
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 13:07:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbiITLHM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 07:07:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiITLHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 07:07:09 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2050.outbound.protection.outlook.com [40.107.94.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85E5320BC8;
        Tue, 20 Sep 2022 04:07:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X9B8v4CUXCJEPZPHHGH5/zF8S9G8WfCdmPyMoMvdIQgFmesQgbHDIpMnfvhP2cOXkPTghxLUa2XP6inXJTmbSqr9DHXKwuGbAla+ASxTG6U7bA8y9Ed2m3glSsd6kJXR3SrNET+spdbWzWJE0KGxiwQJbL5UtzSWZgSCHlvBKB19fAcuKqQzd1CJkLQVLlsV2lVxVYgNDU1l4hQEcjeRqkDF98mbiHKMCFhvPWtdk/xJqveDwhRwcIOJtH/P0qC/Qy2YVKGkTbnJlJeS2klIhHY+Xg9TOjUi0ySAaX4DOLInLZHqtXtmnNEURahmO0cjTQpmweBBpungzLRMJkKRxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lA5KRDw8Wm6+H34RvmigfhKi+UymKkqI2iaa+HqYvXM=;
 b=Rl8VWkfA/qxYJKV7QDT62/CgdTk2TUaiOAPfFv3/gE5ydFbM4FJCjCJapmDG9hIJa4oZEzY29B7NPL9tJfAiquRwPAFjQh/bjd5JS9iMPORWyAUcTDnJhQj8MfN5sab3/aD94ek4JPX1EMslyr46t4Y/HPKOPP1YmC2a6s344gCKhfS/0vrA3NwDVoHZ+RT5TceJcxMOvbpYuKOQj+YGS3En5OujTg/P92lWsexW/Y23zzvYtmcd2zVsEcHg5Jru2/FWkgbrXwDV1CT3pbeTEg8c0GpsWQS++dw6JrUUWgWKoS9e03dF9lzaGeHk2hrou4qI7I2owk1wy3oiOY8v9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linaro.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lA5KRDw8Wm6+H34RvmigfhKi+UymKkqI2iaa+HqYvXM=;
 b=G6rnICEgBsTRoy8wRqr1Lrf5eF+KQxKYJLw/RaxgL4PSyr+30admpAoSiDf4uEqwhdFP2SsDcmRp2d7qTTn0FS/4FIO7KV/ST2ibPo4SjuliJqggE8z+yMlGqPyDTqBG286inQLZRhM4zN2FLjDDnevYW4jzQJX+7j8SbUCyNuVJXF7aI6E7Psi6Pwx5H8rKFInHx2xcv//EyHLrOeycPfU8eCLJuPX7SC4UY3b+g8Po6rJX4nUVX9tcQPHw8AKZhu9M8erMQgjtG13Etw2rbTCWTgEZ+onsF5CRSGnlHqNNrCsc5G/UIt0qRQJ2makL4Ywn8GxxQXIPbU0HkuVHPQ==
Received: from DM6PR13CA0047.namprd13.prod.outlook.com (2603:10b6:5:134::24)
 by CH0PR12MB5027.namprd12.prod.outlook.com (2603:10b6:610:e2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21; Tue, 20 Sep
 2022 11:07:06 +0000
Received: from DM6NAM11FT047.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:134:cafe::a7) by DM6PR13CA0047.outlook.office365.com
 (2603:10b6:5:134::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.14 via Frontend
 Transport; Tue, 20 Sep 2022 11:07:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT047.mail.protection.outlook.com (10.13.172.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5632.12 via Frontend Transport; Tue, 20 Sep 2022 11:07:05 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Tue, 20 Sep
 2022 04:06:54 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 rnnvmail205.nvidia.com (10.129.68.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Tue, 20 Sep 2022 04:06:54 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Tue, 20 Sep 2022 04:06:53 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Tue, 20 Sep 2022 04:06:50 -0700
From:   Sumit Gupta <sumitg@nvidia.com>
To:     <viresh.kumar@linaro.org>, <rafael@kernel.org>,
        <treding@nvidia.com>, <jonathanh@nvidia.com>,
        <linux-pm@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <bbasu@nvidia.com>, <sumitg@nvidia.com>, <sanjayc@nvidia.com>,
        <ksitaraman@nvidia.com>
Subject: [Patch v2] cpufreq: tegra194: Add support for Tegra239
Date:   Tue, 20 Sep 2022 16:36:46 +0530
Message-ID: <20220920110646.27837-1-sumitg@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT047:EE_|CH0PR12MB5027:EE_
X-MS-Office365-Filtering-Correlation-Id: b36c8afb-471c-4f1a-d950-08da9af840f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cb6CGpKRJ56MC2NXwMNYu7TxS2ufjKP1lnkIgh42jUofGGH4JJlUhm8NTLWaaOHQ9b/QCi1cDGibzuDToBVvxFACE97WsjK2QjXOX1DZPNWrbIXuYtmVy8+eVGw+0NB+q2cUoHLYd+7u8V2BNzg8+/gsnlGVTwTE3ue7JcBqbidwChnEZUBCYpDbOScZ3pncjAo9lji202E7xPPbO3YyEnFCqt87CgGnIrfZ8z3ocOvM7BJj7bWe7IgGs2QNT09O5rL5tyvCJIgwgAPS+16qEMtz957oJ77dK/BIX9PxutjRvKPVfQM/N14LtfmkWrIooZjHtMkWx3MBnrWANGFvLOXIf58AXnbkvTSo6XuoQRFp0S8abMZIStF1yYqvnPZ7oopOLzc1gOeFk/5kqmd9gQ5+oaDamC6ebgtxND9PQ3mnxsA7+i5x6rOBkOMOLSng+9xXVz356BXsj4RyV8j1HT3IxR/w7ZEDas3oqvnRKYT8AQYrBA2qsFTvDG0E/cRfjs6yR2yqU5EaCcVGyGjK71OhyG18ZUyukyYK8AWzmpFZ838ozdIs+F11ZAe7l0EWKx3TvVWiCwO4uX3YQ2tddArUqO4+mniBEvf45iOI2Ex7m+UDQJGPv5i7SXS7BNdKVsDPdvEObvjoeoNn4Oa1r100dkV9eW3yT7EjRM8g9t5tf5bflhOjIjP09Y776awLSZz94Qv4bNJkURes3h7UmknTIn1QmoSyxc3Fdz+WmcwPvb1qpZnN0eNUNVn1kJfQHSoIAEPRqLd0qi0qdrygQA==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(136003)(39860400002)(376002)(451199015)(36840700001)(46966006)(40470700004)(5660300002)(36860700001)(8936002)(82310400005)(83380400001)(86362001)(40460700003)(26005)(54906003)(2616005)(316002)(336012)(110136005)(1076003)(82740400003)(7696005)(107886003)(426003)(47076005)(40480700001)(2906002)(356005)(7636003)(186003)(70206006)(478600001)(4326008)(8676002)(41300700001)(36756003)(6666004)(70586007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2022 11:07:05.7623
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b36c8afb-471c-4f1a-d950-08da9af840f9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT047.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5027
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding support for Tegra239 SoC which has eight cores in
a single cluster. Also, moving num_clusters to SoC data
to avoid over allocating memory for four clusters always.

Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
Acked-by: Thierry Reding <treding@nvidia.com>
---
v1 -> v2:
- updated subject line and commit message.
- changed type for 'num_clusters' from 'size_t' to 'unsigned int'.

 drivers/cpufreq/tegra194-cpufreq.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/cpufreq/tegra194-cpufreq.c b/drivers/cpufreq/tegra194-cpufreq.c
index 7e143c06972e..cfc1b225f811 100644
--- a/drivers/cpufreq/tegra194-cpufreq.c
+++ b/drivers/cpufreq/tegra194-cpufreq.c
@@ -38,14 +38,6 @@
 /* cpufreq transisition latency */
 #define TEGRA_CPUFREQ_TRANSITION_LATENCY (300 * 1000) /* unit in nanoseconds */
 
-enum cluster {
-	CLUSTER0,
-	CLUSTER1,
-	CLUSTER2,
-	CLUSTER3,
-	MAX_CLUSTERS,
-};
-
 struct tegra_cpu_ctr {
 	u32 cpu;
 	u32 coreclk_cnt, last_coreclk_cnt;
@@ -67,12 +59,12 @@ struct tegra_cpufreq_ops {
 struct tegra_cpufreq_soc {
 	struct tegra_cpufreq_ops *ops;
 	int maxcpus_per_cluster;
+	unsigned int num_clusters;
 	phys_addr_t actmon_cntr_base;
 };
 
 struct tegra194_cpufreq_data {
 	void __iomem *regs;
-	size_t num_clusters;
 	struct cpufreq_frequency_table **tables;
 	const struct tegra_cpufreq_soc *soc;
 };
@@ -166,6 +158,14 @@ static const struct tegra_cpufreq_soc tegra234_cpufreq_soc = {
 	.ops = &tegra234_cpufreq_ops,
 	.actmon_cntr_base = 0x9000,
 	.maxcpus_per_cluster = 4,
+	.num_clusters = 3,
+};
+
+const struct tegra_cpufreq_soc tegra239_cpufreq_soc = {
+	.ops = &tegra234_cpufreq_ops,
+	.actmon_cntr_base = 0x4000,
+	.maxcpus_per_cluster = 8,
+	.num_clusters = 1,
 };
 
 static void tegra194_get_cpu_cluster_id(u32 cpu, u32 *cpuid, u32 *clusterid)
@@ -378,7 +378,7 @@ static int tegra194_cpufreq_init(struct cpufreq_policy *policy)
 
 	data->soc->ops->get_cpu_cluster_id(policy->cpu, NULL, &clusterid);
 
-	if (clusterid >= data->num_clusters || !data->tables[clusterid])
+	if (clusterid >= data->soc->num_clusters || !data->tables[clusterid])
 		return -EINVAL;
 
 	start_cpu = rounddown(policy->cpu, maxcpus_per_cluster);
@@ -429,6 +429,7 @@ static struct tegra_cpufreq_ops tegra194_cpufreq_ops = {
 static const struct tegra_cpufreq_soc tegra194_cpufreq_soc = {
 	.ops = &tegra194_cpufreq_ops,
 	.maxcpus_per_cluster = 2,
+	.num_clusters = 4,
 };
 
 static void tegra194_cpufreq_free_resources(void)
@@ -521,15 +522,14 @@ static int tegra194_cpufreq_probe(struct platform_device *pdev)
 
 	soc = of_device_get_match_data(&pdev->dev);
 
-	if (soc->ops && soc->maxcpus_per_cluster) {
+	if (soc->ops && soc->maxcpus_per_cluster && soc->num_clusters) {
 		data->soc = soc;
 	} else {
 		dev_err(&pdev->dev, "soc data missing\n");
 		return -EINVAL;
 	}
 
-	data->num_clusters = MAX_CLUSTERS;
-	data->tables = devm_kcalloc(&pdev->dev, data->num_clusters,
+	data->tables = devm_kcalloc(&pdev->dev, data->soc->num_clusters,
 				    sizeof(*data->tables), GFP_KERNEL);
 	if (!data->tables)
 		return -ENOMEM;
@@ -554,7 +554,7 @@ static int tegra194_cpufreq_probe(struct platform_device *pdev)
 		goto put_bpmp;
 	}
 
-	for (i = 0; i < data->num_clusters; i++) {
+	for (i = 0; i < data->soc->num_clusters; i++) {
 		data->tables[i] = init_freq_table(pdev, bpmp, i);
 		if (IS_ERR(data->tables[i])) {
 			err = PTR_ERR(data->tables[i]);
@@ -586,6 +586,7 @@ static int tegra194_cpufreq_remove(struct platform_device *pdev)
 static const struct of_device_id tegra194_cpufreq_of_match[] = {
 	{ .compatible = "nvidia,tegra194-ccplex", .data = &tegra194_cpufreq_soc },
 	{ .compatible = "nvidia,tegra234-ccplex-cluster", .data = &tegra234_cpufreq_soc },
+	{ .compatible = "nvidia,tegra239-ccplex-cluster", .data = &tegra239_cpufreq_soc },
 	{ /* sentinel */ }
 };
 
-- 
2.17.1

