Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE9F1652438
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 17:06:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233665AbiLTQGJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 11:06:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233977AbiLTQFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 11:05:17 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2052.outbound.protection.outlook.com [40.107.94.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BC481D66F;
        Tue, 20 Dec 2022 08:04:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aT9u0fsUyxsAzcFHp9lZj4dZqU/mR5mVbEPsBclI472xibvqMmWYFKRIbQSXxR0lklO1+UHmYJH8qBhMv4P5IKwmWrCDn+b5xiwsCJW3ADINwi3uNVBuEjHU87umoo0DZEMQk1uOWgcYaP2tbmtjvoHPs7ZseXpVgUfyrTAK2zvHzXYGzmjQxX2hWFKrguJefAqt0zHS8nemFL1c7ssc2qPM4vDvDV536YoAj0ldNI2/Y+CqO/8unLvoYqlfeVi3nwnLwIu6fmBV2SGGuuv0tl7HBWR3pSVDvF3oKKWHfFZBZiWbgefgRB8+lfctjIGaF/iXqAseKSdoKWDxnQLKPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SFg0B30anC8a79IQjW3OgeBVuprYW6M3vbPauAj2kWY=;
 b=LAecjMvRlxWC2uASJh2dAQ4ScNgqbvLwApANNOfEeqjVKGyHD5KtUNv7XXGwStDP8Gl52WBFXDw5Brx6M3J52amXI33nJTuGnpM/sJO4TSxxRn3iZiaVrp+JcVAh6gHGP8x0bGyRKjDSO4L1HeQfmHGx3HPTa403i8jUVjhfeBK4flXvdA7ViBBbGNb4GV8yrOExP5XLQFG9iRGBsi5qukGOtofkd7Pkj6WO8NyZPhodSLw6XHVTnKQAGymCGdebB7zXWiNLZDYa4Rjiua+Y99r8ZH151Pp5B8rO3V2d3ZlUs36o5SUgBPyPS8F9OlO+WcvTqaj2FRQmgJknH9uDpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=linaro.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SFg0B30anC8a79IQjW3OgeBVuprYW6M3vbPauAj2kWY=;
 b=EBVIT15SLO7wxgdF2d71m4tOQCCNIkhcfRG935uiHrqT4v4U1FiMGmP1DMNTrrgGgmTkmMWmZ0BavY6c2xjsimL9SUWXMbo+Qom6wD4wD9WDKFe6MCGn39gSCDUPfX2mtvx/TtwXVVG8gWBXIRDIFqGPa17np1C9n01jnUCB6VXBu4m4auTz+AMdAxkHNtkQIjiUpuaoT8SMXPl6In3VBY1QyXTzzSY/fn2BomCxT+dqPFjliVM706ZN2quKreiwod+q1L9ODaKmHE0Iy+wmcJVLqcnayMCuPW9E/9Y+XdH4nvGZw8U2S/MSI2tTyezuTbBtcpA5sj4N03hcjcvNcg==
Received: from MW4PR03CA0233.namprd03.prod.outlook.com (2603:10b6:303:b9::28)
 by BY5PR12MB4856.namprd12.prod.outlook.com (2603:10b6:a03:1d5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Tue, 20 Dec
 2022 16:04:56 +0000
Received: from CO1NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b9:cafe::a0) by MW4PR03CA0233.outlook.office365.com
 (2603:10b6:303:b9::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.21 via Frontend
 Transport; Tue, 20 Dec 2022 16:04:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1NAM11FT014.mail.protection.outlook.com (10.13.175.99) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5944.6 via Frontend Transport; Tue, 20 Dec 2022 16:04:56 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 20 Dec
 2022 08:04:51 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Tue, 20 Dec 2022 08:04:50 -0800
Received: from sumitg-l4t.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.36 via Frontend
 Transport; Tue, 20 Dec 2022 08:04:47 -0800
From:   Sumit Gupta <sumitg@nvidia.com>
To:     <treding@nvidia.com>, <krzysztof.kozlowski@linaro.org>,
        <dmitry.osipenko@collabora.com>, <viresh.kumar@linaro.org>,
        <rafael@kernel.org>, <jonathanh@nvidia.com>, <robh+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     <sanjayc@nvidia.com>, <ksitaraman@nvidia.com>, <ishah@nvidia.com>,
        <bbasu@nvidia.com>, <sumitg@nvidia.com>
Subject: [Patch v1 08/10] cpufreq: tegra194: add OPP support and set bandwidth
Date:   Tue, 20 Dec 2022 21:32:38 +0530
Message-ID: <20221220160240.27494-9-sumitg@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221220160240.27494-1-sumitg@nvidia.com>
References: <20221220160240.27494-1-sumitg@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT014:EE_|BY5PR12MB4856:EE_
X-MS-Office365-Filtering-Correlation-Id: f9279096-3166-4cf3-63ba-08dae2a3f023
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b8Lsy9xSyEbrrneGrjK8uoWTgBjiWGbLs0pcIkElCf7+p9/8aEJVvyLeIECy43qIzidB9dto8/ESXyH6aFzE7SHfZHKBR02dbLoaH3FVKiFqJNetKJNoO+IGUkKcnWNIHTz5H1BJr11kX1cUv/8RhjukgEztzUAcGb7t1KctGSJV0gEUbIO+LSq5oR7w1jVi2gdOsgkO7JQrR2odosqKaKN+ujGbTFH2UGaXfbYxOMxpQ5xW+IYyx7bjBQWx2d7t3e8G5x4mCp4oWYqd/2t6+qUcQvM+FwcfI/aRIyHIfQ95Y3YTDaY8aNLU9nI3UAHTWRoCZsZVh7ngbOo/2LuUN0LdBLZ4KoS0CdQXWwF7S26R+zv5hY7vXxkXEhisHDYw6bVj4d4Mo0/WDQaE4Gp8v68dQCWOLsVDbKaPHQ5Y7ZXYcjbrCbRaIb4qugizpLYJdl6JWAF4lgH7+wu3ltFnaY+Y432AKUbTlJUFbEG2SRlyh42Cf6h02mEb3yIqycTQO6SdON3+DNR4ENKMnNYgMtugygkKX/8ZHKjiaCDBczqFlmPVxlCtsuRXcNopSti/uegnSRM5DJX1M28gD6njzcgOwar69oXFa/7EGe3FwBDVCDV4r6IRs6uRkEgkYvgWqtRilJGVY/0YNx6eGLQsXKZOee07hXllH7193ULC9PuVGmqNrgFQbtt5+FPna56h
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(346002)(376002)(39860400002)(451199015)(36840700001)(46966006)(54906003)(36860700001)(83380400001)(110136005)(41300700001)(70206006)(336012)(426003)(316002)(47076005)(8936002)(36756003)(5660300002)(40480700001)(2616005)(70586007)(2906002)(86362001)(4326008)(1076003)(8676002)(82310400005)(6666004)(107886003)(26005)(82740400003)(7636003)(478600001)(7696005)(186003)(356005)(921005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2022 16:04:56.1963
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f9279096-3166-4cf3-63ba-08dae2a3f023
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT014.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4856
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support to use OPP table from DT in Tegra194 cpufreq driver.
Tegra SoC's receive the frequency lookup table (LUT) from BPMP-FW.
Cross check the OPP's present in DT against the LUT from BPMP-FW
and enable only those DT OPP's which are present in LUT also.

The OPP table in DT has CPU Frequency to bandwidth mapping where
the bandwidth value is per MC channel. DRAM bandwidth depends on the
number of MC channels which can vary as per the boot configuration.
This per channel bandwidth from OPP table will be later converted by
MC driver to final bandwidth value by multiplying with number of
channels before sending the request to BPMP-FW.

If OPP table is not present in DT, then use the LUT from BPMP-FW directy
as the frequency table and not do the DRAM frequency scaling which is
same as the current behavior.

Now, as the CPU Frequency table is being controlling through OPP table
in DT. Keeping fewer entries in the table will create less frequency
steps and scale fast to high frequencies if required.

Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
 drivers/cpufreq/tegra194-cpufreq.c | 152 ++++++++++++++++++++++++++---
 1 file changed, 139 insertions(+), 13 deletions(-)

diff --git a/drivers/cpufreq/tegra194-cpufreq.c b/drivers/cpufreq/tegra194-cpufreq.c
index 4596c3e323aa..8155a9ea0815 100644
--- a/drivers/cpufreq/tegra194-cpufreq.c
+++ b/drivers/cpufreq/tegra194-cpufreq.c
@@ -12,6 +12,7 @@
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
+#include <linux/units.h>
 
 #include <asm/smp_plat.h>
 
@@ -65,12 +66,32 @@ struct tegra_cpufreq_soc {
 
 struct tegra194_cpufreq_data {
 	void __iomem *regs;
-	struct cpufreq_frequency_table **tables;
+	struct cpufreq_frequency_table **bpmp_luts;
 	const struct tegra_cpufreq_soc *soc;
+	bool icc_dram_bw_scaling;
 };
 
 static struct workqueue_struct *read_counters_wq;
 
+static int tegra_cpufreq_set_bw(struct cpufreq_policy *policy, unsigned long freq_khz)
+{
+	struct dev_pm_opp *opp;
+	struct device *dev;
+	int ret;
+
+	dev = get_cpu_device(policy->cpu);
+	if (!dev)
+		return -ENODEV;
+
+	opp = dev_pm_opp_find_freq_exact(dev, freq_khz * KHZ, true);
+	if (IS_ERR(opp))
+		return PTR_ERR(opp);
+
+	ret = dev_pm_opp_set_opp(dev, opp);
+	dev_pm_opp_put(opp);
+	return ret;
+}
+
 static void tegra_get_cpu_mpidr(void *mpidr)
 {
 	*((u64 *)mpidr) = read_cpuid_mpidr() & MPIDR_HWID_BITMASK;
@@ -354,7 +375,7 @@ static unsigned int tegra194_get_speed(u32 cpu)
 	 * to the last written ndiv value from freq_table. This is
 	 * done to return consistent value.
 	 */
-	cpufreq_for_each_valid_entry(pos, data->tables[clusterid]) {
+	cpufreq_for_each_valid_entry(pos, data->bpmp_luts[clusterid]) {
 		if (pos->driver_data != ndiv)
 			continue;
 
@@ -369,16 +390,93 @@ static unsigned int tegra194_get_speed(u32 cpu)
 	return rate;
 }
 
+int tegra_cpufreq_init_cpufreq_table(struct cpufreq_policy *policy,
+				     struct cpufreq_frequency_table *bpmp_lut,
+				     struct cpufreq_frequency_table **opp_table)
+{
+	struct tegra194_cpufreq_data *data = cpufreq_get_driver_data();
+	struct cpufreq_frequency_table *freq_table = NULL;
+	struct cpufreq_frequency_table *pos;
+	int ret = 0, max_opps = 0;
+	struct device *cpu_dev;
+	struct dev_pm_opp *opp;
+	unsigned long rate;
+	int j = 0;
+
+	cpu_dev = get_cpu_device(policy->cpu);
+	if (!cpu_dev) {
+		pr_err("%s: failed to get cpu%d device\n", __func__, policy->cpu);
+		return -ENODEV;
+	}
+
+	/* Initialize OPP table mentioned in operating-points-v2 property in DT */
+	ret = dev_pm_opp_of_add_table_indexed(cpu_dev, 0);
+	if (!ret) {
+		max_opps = dev_pm_opp_get_opp_count(cpu_dev);
+		if (max_opps <= 0) {
+			dev_err(cpu_dev, "Failed to add OPPs\n");
+			return max_opps;
+		}
+
+		/* Disable all opps and cross-validate against LUT later */
+		for (rate = 0; ; rate++) {
+			opp = dev_pm_opp_find_freq_ceil(cpu_dev, &rate);
+			if (IS_ERR(opp))
+				break;
+
+			dev_pm_opp_put(opp);
+			dev_pm_opp_disable(cpu_dev, rate);
+		}
+	} else {
+		dev_err(cpu_dev, "Invalid or empty opp table in device tree\n");
+		data->icc_dram_bw_scaling = false;
+		return ret;
+	}
+
+	freq_table = kcalloc((max_opps + 1), sizeof(*freq_table), GFP_KERNEL);
+	if (!freq_table)
+		return -ENOMEM;
+
+	/*
+	 * Cross check the frequencies from BPMP-FW LUT against the OPP's present in DT.
+	 * Enable only those DT OPP's which are present in LUT also.
+	 */
+	cpufreq_for_each_valid_entry(pos, bpmp_lut) {
+		opp = dev_pm_opp_find_freq_exact(cpu_dev, pos->frequency * KHZ, false);
+		if (IS_ERR(opp))
+			continue;
+
+		ret = dev_pm_opp_enable(cpu_dev, pos->frequency * KHZ);
+		if (ret < 0)
+			return ret;
+
+		freq_table[j].driver_data = pos->driver_data;
+		freq_table[j].frequency = pos->frequency;
+		j++;
+	}
+
+	freq_table[j].driver_data = pos->driver_data;
+	freq_table[j].frequency = CPUFREQ_TABLE_END;
+
+	*opp_table = &freq_table[0];
+
+	dev_pm_opp_set_sharing_cpus(cpu_dev, policy->cpus);
+
+	return ret;
+}
+
 static int tegra194_cpufreq_init(struct cpufreq_policy *policy)
 {
 	struct tegra194_cpufreq_data *data = cpufreq_get_driver_data();
 	int maxcpus_per_cluster = data->soc->maxcpus_per_cluster;
+	struct cpufreq_frequency_table *freq_table;
+	struct cpufreq_frequency_table *bpmp_lut;
 	u32 start_cpu, cpu;
 	u32 clusterid;
+	int ret;
 
 	data->soc->ops->get_cpu_cluster_id(policy->cpu, NULL, &clusterid);
-
-	if (clusterid >= data->soc->num_clusters || !data->tables[clusterid])
+	if (clusterid >= data->soc->num_clusters || !data->bpmp_luts[clusterid])
 		return -EINVAL;
 
 	start_cpu = rounddown(policy->cpu, maxcpus_per_cluster);
@@ -387,9 +485,22 @@ static int tegra194_cpufreq_init(struct cpufreq_policy *policy)
 		if (cpu_possible(cpu))
 			cpumask_set_cpu(cpu, policy->cpus);
 	}
-	policy->freq_table = data->tables[clusterid];
 	policy->cpuinfo.transition_latency = TEGRA_CPUFREQ_TRANSITION_LATENCY;
 
+	bpmp_lut = data->bpmp_luts[clusterid];
+
+	if (data->icc_dram_bw_scaling) {
+		ret = tegra_cpufreq_init_cpufreq_table(policy, bpmp_lut, &freq_table);
+		if (!ret) {
+			policy->freq_table = freq_table;
+			return 0;
+		}
+	}
+
+	data->icc_dram_bw_scaling = false;
+	policy->freq_table = bpmp_lut;
+	pr_info("OPP tables missing from DT, EMC frequency scaling disabled\n");
+
 	return 0;
 }
 
@@ -406,6 +517,9 @@ static int tegra194_cpufreq_set_target(struct cpufreq_policy *policy,
 	 */
 	data->soc->ops->set_cpu_ndiv(policy, (u64)tbl->driver_data);
 
+	if (data->icc_dram_bw_scaling)
+		tegra_cpufreq_set_bw(policy, tbl->frequency);
+
 	return 0;
 }
 
@@ -438,8 +552,8 @@ static void tegra194_cpufreq_free_resources(void)
 }
 
 static struct cpufreq_frequency_table *
-init_freq_table(struct platform_device *pdev, struct tegra_bpmp *bpmp,
-		unsigned int cluster_id)
+tegra_cpufreq_bpmp_read_lut(struct platform_device *pdev, struct tegra_bpmp *bpmp,
+			    unsigned int cluster_id)
 {
 	struct cpufreq_frequency_table *freq_table;
 	struct mrq_cpu_ndiv_limits_response resp;
@@ -514,6 +628,7 @@ static int tegra194_cpufreq_probe(struct platform_device *pdev)
 	const struct tegra_cpufreq_soc *soc;
 	struct tegra194_cpufreq_data *data;
 	struct tegra_bpmp *bpmp;
+	struct device *cpu_dev;
 	int err, i;
 
 	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
@@ -529,9 +644,9 @@ static int tegra194_cpufreq_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	data->tables = devm_kcalloc(&pdev->dev, data->soc->num_clusters,
-				    sizeof(*data->tables), GFP_KERNEL);
-	if (!data->tables)
+	data->bpmp_luts = devm_kcalloc(&pdev->dev, data->soc->num_clusters,
+				       sizeof(*data->bpmp_luts), GFP_KERNEL);
+	if (!data->bpmp_luts)
 		return -ENOMEM;
 
 	if (soc->actmon_cntr_base) {
@@ -555,15 +670,26 @@ static int tegra194_cpufreq_probe(struct platform_device *pdev)
 	}
 
 	for (i = 0; i < data->soc->num_clusters; i++) {
-		data->tables[i] = init_freq_table(pdev, bpmp, i);
-		if (IS_ERR(data->tables[i])) {
-			err = PTR_ERR(data->tables[i]);
+		data->bpmp_luts[i] = tegra_cpufreq_bpmp_read_lut(pdev, bpmp, i);
+		if (IS_ERR(data->bpmp_luts[i])) {
+			err = PTR_ERR(data->bpmp_luts[i]);
 			goto err_free_res;
 		}
 	}
 
 	tegra194_cpufreq_driver.driver_data = data;
 
+	/* Check for optional OPPv2 and interconnect paths on CPU0 to enable ICC scaling */
+	cpu_dev = get_cpu_device(0);
+	if (!cpu_dev)
+		return -EPROBE_DEFER;
+
+	if (dev_pm_opp_of_get_opp_desc_node(cpu_dev)) {
+		err = dev_pm_opp_of_find_icc_paths(cpu_dev, NULL);
+		if (!err)
+			data->icc_dram_bw_scaling = true;
+	}
+
 	err = cpufreq_register_driver(&tegra194_cpufreq_driver);
 	if (!err)
 		goto put_bpmp;
-- 
2.17.1

