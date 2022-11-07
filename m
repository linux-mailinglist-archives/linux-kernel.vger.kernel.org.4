Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC6B061FCA5
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 19:03:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231734AbiKGSDf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 13:03:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233276AbiKGSCR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 13:02:17 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2083.outbound.protection.outlook.com [40.107.237.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01387252B5;
        Mon,  7 Nov 2022 09:59:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RuQeUxyAkPXPzVAKemkhI8L9V7qUj2T69I2SowNcJ1/UifIIBGzFkDz5SmVeoU+7r5fgKG4UZ98oNlur6S2+oTYfQQhw8KSWQ7SU7TGTnyrP4fbWPt/u6r4Bms7W+9vo9ucaH8APAnp77A+VMUyhT1kArhjQwlF693fCbOivfDnUMIzk9gbiXztV3NSmHp+UeYbInzzCt/4hPQVRDZoVdEcrshtXlfSkteGHdR5QXMqmuyEvL4wvq+Apo3IHasZl8Q/d+TkICHrhV7YVT+MnaZW35w5ywX/F92zuxLlhREZH805thSFURITy83u3gksgt5EsZOlqCwvMAoEf4Zy5Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g1Nf18yDHNox+tTcvp4PQMEAJuGUnh+8c5j9n7dq4B8=;
 b=AinzXEeVhzUwVBPJ8E6QxVG7plG/JjZKqpEWr3p3XN+Ewwh2CH5VXNwco2KPzuVIa2NJWPrMaYNy9YJF58MtZUd3jMi/cb+t0Y4cRrnN8cY/ZAXSiI4gzfmP075hdj0tETwrB35dz8+gKL2sJfk1wGvH3Khx+WS6FRTXvp8HsTWidSLbe/8FmlVFy/i7kS2z5i0McZXklXotrULet+/A6gQtHPSuQnVFlZG6aCvFkOknJlYTUWr+aouAf+WKhaA/lxdcE6RG2jlj7cibztLaONl6aRsVqdKqhTho2/S9c5UBpsMYZvHxabsAj+37bcqeHnlF0VhFQC/U6ok8GPfS3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g1Nf18yDHNox+tTcvp4PQMEAJuGUnh+8c5j9n7dq4B8=;
 b=Q6lQrOL/NUi762XluGnx0j3PyHiHjeblqtjt8axHu3ZzO9XUpIQJMTz6bd6uMIELN6RmtqIH8DZT8mU18Nvb4i2mmSZ4D+IflFlSIRrGB32Vt+TM9/ymrlFjOH+gZTDeZzNNFaswZ/xS+nztBOJ6lVN/CgzN5vZERoO7mctIZXI=
Received: from DS7PR03CA0171.namprd03.prod.outlook.com (2603:10b6:5:3b2::26)
 by PH7PR12MB6907.namprd12.prod.outlook.com (2603:10b6:510:1b9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.25; Mon, 7 Nov
 2022 17:58:58 +0000
Received: from DM6NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b2:cafe::f) by DS7PR03CA0171.outlook.office365.com
 (2603:10b6:5:3b2::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26 via Frontend
 Transport; Mon, 7 Nov 2022 17:58:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT037.mail.protection.outlook.com (10.13.172.122) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5791.20 via Frontend Transport; Mon, 7 Nov 2022 17:58:58 +0000
Received: from pyuan-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 7 Nov 2022 11:58:42 -0600
From:   Perry Yuan <Perry.Yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <ray.huang@amd.com>,
        <viresh.kumar@linaro.org>
CC:     <Deepak.Sharma@amd.com>, <Mario.Limonciello@amd.com>,
        <Nathan.Fontenot@amd.com>, <Alexander.Deucher@amd.com>,
        <Shimmer.Huang@amd.com>, <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Perry Yuan <Perry.Yuan@amd.com>
Subject: [PATCH v3 7/8] cpufreq: amd-pstate: add frequency dynamic boost sysfs control
Date:   Tue, 8 Nov 2022 01:57:04 +0800
Message-ID: <20221107175705.2207842-8-Perry.Yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221107175705.2207842-1-Perry.Yuan@amd.com>
References: <20221107175705.2207842-1-Perry.Yuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT037:EE_|PH7PR12MB6907:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c598324-b526-45a6-b465-08dac0e9bed3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g+nC3y0X7czgDXKJl+5yZHSPbvxcp5Pj5c7WEoYpIkkQL70XqUUJfo04sr7cZ31zNcnw6af5recbdpEaV0SUsVvCbDJNcFgVfhy+zptaWH9v4DeIMe7R37DFnr+XvWUtpE0T34IwFIo2lwRGSggjU5YAFVphO5pXIzUciPxab2VI3H0nHIedWzAVyGB87TPWYYMuflSTombL7mjpoJ9r6kAYcWOkg9ixyta/0HF1gUBD3/okL0/Ahmyq/tyTwzsTUZIfoqMcdrOKNsRD0GdD1WLYzmo+HVDiq8q8nk926F7QXq1Pk0Uuao7LYeFioOgJQ1X1sdv4DUtXgQz+3oVuY9d2VI33cWx9ufdczBDPwJeSV53iHPELn299juxQRAygkrp3hMxy3MDRXtjwkVuwEhz955Oq7fQN3HtD0qDnMoYSqoczVNdPtenlX6ywJ4IfoxG58nQvhozFQIHGpBAbDd0Xabxs2wSURMdXuwN9Pg3NMb/nBCdCD2DtLfoCI4360NL1hezC9NJ5RQO9FSrBRzpw+/lof1a96PpS/3b27C+SDWTfxDydv34DrePGyf8LWz6MqZLsQkQ/PYjreCVJARdaKKN50AQRilXG2KxV4Pp523Y+wH4RpGOG2BoJwxPv+I4kOB/qg0UbWPE/PmTrQpX3eEgc1L2aSuR0kicZMgQTjJW1sPxI3joeS+UtHxMhrvCH/8WAv+NJEXgskI2KlcBsad2fpVHUw3K5gYBhNpMb78OAkohwyVTHI/SxksAcZAzPTf66EAy3EfDzlpT+ZXyAEPir2O4MZ+iaKSJGIjFJhwRTqcqhRhHiFNP4HZwbrKVv/Hipd8eilMfI+1wjY71cizh87EnLtUG8a8qeVcA=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(39860400002)(136003)(346002)(451199015)(46966006)(40470700004)(36840700001)(82310400005)(36756003)(7696005)(82740400003)(41300700001)(2906002)(6666004)(5660300002)(40480700001)(36860700001)(70206006)(4326008)(70586007)(8676002)(316002)(54906003)(110136005)(8936002)(356005)(86362001)(81166007)(336012)(40460700003)(26005)(83380400001)(16526019)(186003)(1076003)(2616005)(478600001)(47076005)(426003)(2101003)(36900700001)(309714004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2022 17:58:58.7023
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c598324-b526-45a6-b465-08dac0e9bed3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6907
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add one sysfs entry to control the CPU cores frequency boost state
The attribute file can allow user to set max performance boosted or
keeping at normal perf level.

Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 53 ++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 841b1e2383b8..6958c5fd9e1c 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -786,12 +786,46 @@ static ssize_t show_energy_performance_preference(
 		return  sprintf(buf, "%s\n", energy_perf_strings[preference]);
 }
 
+static void amd_pstate_update_policies(void)
+{
+	int cpu;
+
+	for_each_possible_cpu(cpu)
+		cpufreq_update_policy(cpu);
+}
+
+static ssize_t show_pstate_dynamic_boost(struct kobject *kobj,
+				struct kobj_attribute *attr, char *buf)
+{
+	return sprintf(buf, "%u\n", cppc_boost);
+}
+
+static ssize_t store_pstate_dynamic_boost(struct kobject *a,
+				       struct kobj_attribute *b,
+				       const char *buf, size_t count)
+{
+	unsigned int input;
+	int ret;
+
+	ret = kstrtouint(buf, 10, &input);
+	if (ret)
+		return ret;
+
+	mutex_lock(&amd_pstate_driver_lock);
+	cppc_boost = !!input;
+	amd_pstate_update_policies();
+	mutex_unlock(&amd_pstate_driver_lock);
+
+	return count;
+}
+
 cpufreq_freq_attr_ro(amd_pstate_max_freq);
 cpufreq_freq_attr_ro(amd_pstate_lowest_nonlinear_freq);
 
 cpufreq_freq_attr_ro(amd_pstate_highest_perf);
 cpufreq_freq_attr_rw(energy_performance_preference);
 cpufreq_freq_attr_ro(energy_performance_available_preferences);
+define_one_global_rw(pstate_dynamic_boost);
 
 static struct freq_attr *amd_pstate_attr[] = {
 	&amd_pstate_max_freq,
@@ -809,6 +843,15 @@ static struct freq_attr *amd_pstate_epp_attr[] = {
 	NULL,
 };
 
+static struct attribute *pstate_global_attributes[] = {
+	&pstate_dynamic_boost.attr,
+	NULL
+};
+
+static const struct attribute_group amd_pstate_global_attr_group = {
+	.attrs = pstate_global_attributes,
+};
+
 static inline void update_boost_state(void)
 {
 	u64 misc_en;
@@ -1416,6 +1459,16 @@ static int __init amd_pstate_init(void)
 		pr_err("failed to register amd pstate driver with return %d\n",
 		       ret);
 
+	amd_pstate_kobj = kobject_create_and_add("amd-pstate", &cpu_subsys.dev_root->kobj);
+	if (!amd_pstate_kobj)
+		pr_err("amd-pstate: Global sysfs registration failed.\n");
+
+	ret = sysfs_create_group(amd_pstate_kobj, &amd_pstate_global_attr_group);
+	if (ret) {
+		pr_err("amd-pstate: Sysfs attribute export failed with error %d.\n",
+		       ret);
+	}
+
 	return ret;
 }
 device_initcall(amd_pstate_init);
-- 
2.34.1

