Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F150646E50
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 12:20:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbiLHLUa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 06:20:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbiLHLT7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 06:19:59 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2082.outbound.protection.outlook.com [40.107.94.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFDB048750;
        Thu,  8 Dec 2022 03:19:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fMmHVvi6mOYz4nxqrgox+W0sLp2kgYKNVM4jGagm8PHMZ0kWV/aix1jmutgBBI1NGapW7wZbykY+nU2mqxmNUhJLNnAUPgdFs9ve9YU5jpsG4o81Wwee4ZbkfZkEQPucd8aQ5v6NyScV9Gorc5O9yzxE36iF9nM1gDTBM5X0eC1iJbpS/AdTQ8zsZTqpSDgVbV4HfI0PldeBc3J1MFzUS5cNNK06/CBzodXCFg8m4eq43WFDG9V0WEfyNalsANuT/bi008Yj57EMKhuZj8uCogMRPEEjdABULPhaJz8wQgYI/rC3KdzT25QsVNHdumE6MoPGCzK3bO7vAdkesFojjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g0lwpZHYOSLcuXFU4J2O5L6ro8sIvaZOvLy4pJNMRbQ=;
 b=WHXIksrgsFyCSdlHwY7jjit4I9OGNtlTqnTp9hLG3CD2ANQBU0zRPH6qLGX8a0z40isLQ1TmoJ4ttDAx5t/SrdCVAwNYuNcoJwE7HyxaeoHYxaTgBJvXGrxsUXlJgT0ymRGboc8ZMOtEgsBKvBIS6bo/6H5KZnX/R24Pw71ck5CruXBfspXHZvro2rXTj9wD6/KjC1nMDshjP4jIHeAb5QZcBINRTctg1tPcR1JsTecNBzPOj/etrG6LrDbkTgpgDwjN0TgNbkJnymFfaET4fvaf92S1rFSOeEYkjLlQS9QKGGc9nHSfbxa9TYef7pTGEaHzcFmkZLu+WtM+obxSxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g0lwpZHYOSLcuXFU4J2O5L6ro8sIvaZOvLy4pJNMRbQ=;
 b=VJYliuLGz+hFhEaXQy6RcUWE3OFBSJUKKSxWttetx+YPZNXtWcGlF4u2bKiC3NffYfmBU77Y2LKn08gKAk5/pRjKCfKZcz13AlvyiITDegq8Rl76w8FKDoMvmRN53FEQz3Ao5FMplA+23Tn/bkWLf+gVFZIhaTfaT2CP37aETlg=
Received: from DM6PR12CA0032.namprd12.prod.outlook.com (2603:10b6:5:1c0::45)
 by CY8PR12MB7537.namprd12.prod.outlook.com (2603:10b6:930:94::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.13; Thu, 8 Dec
 2022 11:19:55 +0000
Received: from DM6NAM11FT025.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1c0:cafe::40) by DM6PR12CA0032.outlook.office365.com
 (2603:10b6:5:1c0::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14 via Frontend
 Transport; Thu, 8 Dec 2022 11:19:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT025.mail.protection.outlook.com (10.13.172.197) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5901.17 via Frontend Transport; Thu, 8 Dec 2022 11:19:55 +0000
Received: from pyuan-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Thu, 8 Dec 2022 05:19:51 -0600
From:   Perry Yuan <perry.yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
        <ray.huang@amd.com>, <viresh.kumar@linaro.org>
CC:     <Deepak.Sharma@amd.com>, <Nathan.Fontenot@amd.com>,
        <Alexander.Deucher@amd.com>, <Shimmer.Huang@amd.com>,
        <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <wyes.karny@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v7 08/13] cpufreq: amd-pstate: add frequency dynamic boost sysfs control
Date:   Thu, 8 Dec 2022 19:18:47 +0800
Message-ID: <20221208111852.386731-9-perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221208111852.386731-1-perry.yuan@amd.com>
References: <20221208111852.386731-1-perry.yuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT025:EE_|CY8PR12MB7537:EE_
X-MS-Office365-Filtering-Correlation-Id: 970822eb-326a-4a5f-731a-08dad90e222d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TpRFI6N6cHIYz9lBKI/iF2jkZwH03kBtkhs9ZCk0l/r7qN41l2pV4+xsSaE8cFmPUNAY067iXvK8EMf7XTSeCGvnbV6sxQ/HU0Wfj2IGCeOWMSe+euoJSozJfptlssibYvwrh3ttdz/HxEmLXGNZ/7XDb6GZ4AiiXW7glSrS8le0KSBlYqaW90yRsHOq3OhC08Eh+myn+bYoRVZyYMrVGM4HMw/rr4JAxSXFxhQLkh4C02ep4NZWChRJAQcBGiNcvYsG1hw09sktDaB8GLT3GIeMF+awnSLHN/Xs4iOqlSjCy3tfdoBKVD5KUB+PtWL0QJ69///FGPrY317ruXM/qopKpAQ5gZsl+rehqy6gsQj8ZhkMYk59Z2YmBI7fE3X5K/JTFycPKp4TxZDyCnsg4LdeXWyrp0sveUJ3fLmDXiBtEiy0uKU2tKOycutb2oOWt4sxLoG/KNWhGyIzw59Co//XXVzPtPWS/W4xSy3irLP5k3ytIPNtefaXz3GnL8c4TUMaM9t7brPKflFwr87teAQpLQQERmLNDsDMp32mRNoEPJ6+Vk8LIyL0FB3W4BFNS3fwzgGO6SG9QML8Mm44G39I/M4VeyqORQAEJV1oSZdKFCJqJwJ0Vd+cpJh8EARW/dZpQV3jlLZA8BFqS1Ma9IrP+xWIEI3wxEn1fTroXz+RzWpA/XdhrM2QvdfXebh0TYu0CsIxg5k2iSMIb1m8DoktM+OvcW76F2b0nip4goxwjNDO8RofDUaZVdquJ77I4oCYX3KthYroWiiFGBtGFg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(376002)(39860400002)(136003)(451199015)(46966006)(40470700004)(36840700001)(336012)(2906002)(426003)(86362001)(26005)(83380400001)(1076003)(8676002)(6666004)(110136005)(7696005)(54906003)(70206006)(47076005)(186003)(2616005)(40460700003)(41300700001)(478600001)(8936002)(82740400003)(5660300002)(44832011)(16526019)(81166007)(356005)(4326008)(70586007)(36860700001)(316002)(36756003)(40480700001)(82310400005)(36900700001)(309714004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2022 11:19:55.1582
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 970822eb-326a-4a5f-731a-08dad90e222d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT025.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7537
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Perry Yuan <Perry.Yuan@amd.com>

Add one sysfs entry to control the CPU cores frequency boost state
The attribute file can allow user to set max performance boosted or
keeping at normal perf level.

Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 67 ++++++++++++++++++++++++++++++++++--
 1 file changed, 65 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index ea9255bdc9ac..4cd53c010215 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -69,6 +69,7 @@ static struct amd_pstate_params global_params;
 
 static DEFINE_MUTEX(amd_pstate_limits_lock);
 static DEFINE_MUTEX(amd_pstate_driver_lock);
+struct kobject *amd_pstate_kobj;
 
 static bool cppc_boost __read_mostly;
 
@@ -768,12 +769,46 @@ static ssize_t show_energy_performance_preference(
 	return sysfs_emit(buf, "%s\n", energy_perf_strings[preference]);
 }
 
+static void amd_pstate_update_policies(void)
+{
+	int cpu;
+
+	for_each_possible_cpu(cpu)
+		cpufreq_update_policy(cpu);
+}
+
+static ssize_t show_cppc_dynamic_boost(struct kobject *kobj,
+				struct kobj_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%u\n", cppc_boost);
+}
+
+static ssize_t store_cppc_dynamic_boost(struct kobject *a,
+				       struct kobj_attribute *b,
+				       const char *buf, size_t count)
+{
+	bool new_state;
+	int ret;
+
+	ret = kstrtobool(buf, &new_state);
+	if (ret)
+		return -EINVAL;
+
+	mutex_lock(&amd_pstate_driver_lock);
+	cppc_boost = !!new_state;
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
+define_one_global_rw(cppc_dynamic_boost);
 
 static struct freq_attr *amd_pstate_attr[] = {
 	&amd_pstate_max_freq,
@@ -791,6 +826,15 @@ static struct freq_attr *amd_pstate_epp_attr[] = {
 	NULL,
 };
 
+static struct attribute *pstate_global_attributes[] = {
+	&cppc_dynamic_boost.attr,
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
@@ -1404,9 +1448,28 @@ static int __init amd_pstate_init(void)
 
 	ret = cpufreq_register_driver(default_pstate_driver);
 	if (ret)
-		pr_err("failed to register amd pstate driver with return %d\n",
-		       ret);
+		pr_err("failed to register driver with return %d\n", ret);
+
+	amd_pstate_kobj = kobject_create_and_add("amd-pstate", &cpu_subsys.dev_root->kobj);
+	if (!amd_pstate_kobj) {
+		ret = -EINVAL;
+		pr_err("global sysfs registration failed.\n");
+		goto kobject_free;
+	}
+
+	ret = sysfs_create_group(amd_pstate_kobj, &amd_pstate_global_attr_group);
+	if (ret) {
+		pr_err("sysfs attribute export failed with error %d.\n", ret);
+		goto global_attr_free;
+	}
+
+	return ret;
 
+global_attr_free:
+	kobject_put(amd_pstate_kobj);
+kobject_free:
+	cpufreq_unregister_driver(default_pstate_driver);
+	kfree(cpudata);
 	return ret;
 }
 device_initcall(amd_pstate_init);
-- 
2.34.1

