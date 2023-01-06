Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9494965FB4D
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 07:16:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232058AbjAFGQQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 01:16:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231827AbjAFGPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 01:15:48 -0500
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2044.outbound.protection.outlook.com [40.107.102.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 636E26CFDD;
        Thu,  5 Jan 2023 22:15:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LKjVZ5QdrrT14as0USWt06+po2iXRaXKENkJxkXbarDRZ+WqzLz+wHPH0IvX+PMHcAEs0lHt8xlVtbBZLXEvhRZTDstIT7EsecEGqmKYZxrs7pUCEk9vOZWHruQ9hOe4GHPwWlLEgPk+XoueR21RJvEuBIeGgMVSpkgeaSNUHct1DwP7k4fbdWROGK8wlRparzHqIVZfkBWC4rs6PPZhWYXeKcLeqpYekAfclUjuyTdeOzyDJuxQez0SUVloo8BJbrX9W4m+DA2EJPYhH82krL6296m1Smlb/DLoAxoW1IHABed7NNEpm+XP/31lU0oCbanDn7Ihg1rc7ZwahgYHuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QXuMlKZVbEOxFGnVLZv8F2ZmQwVfBTRRHqvG1ikrJVE=;
 b=nngui7ScQvcEXjuBNOKjOHSCcFAPlCFxkmVNACQe8+KH+ut5hrYop9E11IcFMcH0OqzIvNDaJBExhgxT2/Ijpv2Nk/nkRpv27ACyz+ykVHbE+r+SSqVVtxlWbMzVsEjQHuisgfsb/1Es3cqiydgJolhyLLFnOgJhn/PwoCqwksa/xZ+OdSu7i/z5lm/tTiO8M8kmjMmtLyrRFG6i7JFGM0+cZL3vVCfDfAvhMnYRKDF3vXC9/csiG4Hx5l49DA+AHTHTsj3CDWQn+hMKRDdtLMLm6AtpWLQGawaZE/506vuFpDRTJ2wtLqUPaPcnyGI6rZFHGH5A3PE92I0YXz/OFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QXuMlKZVbEOxFGnVLZv8F2ZmQwVfBTRRHqvG1ikrJVE=;
 b=2qrkZC3/aScWWFbp4gi6NACdrNRE3WHyKwXstXQNH6q8NaxGoMzyyBnW0aw8HKVds4praJwKOFsgR+wV/DJdm1Oinmnd6gQYXjRRBQg2i1goSit+E+f8CPN2lB5I5A1xmzfZJny0NC8gc6IS+fJKD8ukBNDCkHWx1kR9+fDdr10=
Received: from CY5PR03CA0031.namprd03.prod.outlook.com (2603:10b6:930:8::28)
 by DM4PR12MB5937.namprd12.prod.outlook.com (2603:10b6:8:68::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Fri, 6 Jan
 2023 06:15:43 +0000
Received: from CY4PEPF0000C968.namprd02.prod.outlook.com
 (2603:10b6:930:8:cafe::a2) by CY5PR03CA0031.outlook.office365.com
 (2603:10b6:930:8::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.15 via Frontend
 Transport; Fri, 6 Jan 2023 06:15:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000C968.mail.protection.outlook.com (10.167.241.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5986.15 via Frontend Transport; Fri, 6 Jan 2023 06:15:41 +0000
Received: from pyuan-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Fri, 6 Jan 2023 00:15:36 -0600
From:   Perry Yuan <perry.yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
        <ray.huang@amd.com>, <viresh.kumar@linaro.org>
CC:     <Deepak.Sharma@amd.com>, <Nathan.Fontenot@amd.com>,
        <Alexander.Deucher@amd.com>, <Shimmer.Huang@amd.com>,
        <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <wyes.karny@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v10 08/12] cpufreq: amd-pstate: add driver working mode switch support
Date:   Fri, 6 Jan 2023 14:14:16 +0800
Message-ID: <20230106061420.95715-9-perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230106061420.95715-1-perry.yuan@amd.com>
References: <20230106061420.95715-1-perry.yuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000C968:EE_|DM4PR12MB5937:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a7e40ac-133d-4f28-b3d0-08daefad705d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZAMRcyjx1TfiBj7YSy9SPYDDWc7EyWFy1wBi3gWh1o09W9QSHqt6xsJnAsJUqjdzDBZU83uyDCXa+MZJDKfsgRG5xLgS03386Ur0fU+c0geNSUEj5CZvYZLTjQD4d0FaCt2WWXIr5TE5XyHcXZpInfQnXVz3JU2RQJTZZWcXRzMfvFgZpUBIdvn6ECwkxh/Vp5j09jpvsqfY2exddtzYAPnmFU5XTARATBTMlJgJ9UQ5jmEqoz/c0jEmDa7am/URCSz/MWGCaXzL1dj9RdtGHnm/gdNExNJho3ZgqMpggJG9M0wugCJR7j4HdOR0yRiQLCQuNb6a0B6rVrounZTwxcZ9VgSrGEK9sa7VCV1z31ihU+d+yfae8LKPGwMh2dQ4478QugbDa2KTsvEVboRD7L8E3HR6yTXfF8KXEkP5PiMBI7Zehs/LpC7nGrHkDYeFBRhmmAT2i9xxn/ykuUnrj5uKYBHY29FBROcryASAcDQy+na3poRvZ76q4xBr5hO3kznQTe+55r2Yqu78mZ57TEdwv3nyoYhCKh10I86Qurzg+aJifkSF7rsiteD5cIufZH4iO72DbOH4lcPcJcWoWAIEQRFpBa+2jLEFNmgyHuRB6/3bTPBGlFxkuhT9SSC9wmzgJpDiSK+G5D5YSh8KdSqLgick3W+KCSf0LW9iQV2l8ZKWTEO76e0pdx7/cxcjmizZSHtXyWuaukyTCfHzi6BTInQ7qNoffLNmsuYn00g=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(376002)(136003)(396003)(451199015)(46966006)(36840700001)(40470700004)(44832011)(70586007)(5660300002)(54906003)(8676002)(70206006)(316002)(2906002)(41300700001)(4326008)(8936002)(478600001)(36756003)(36860700001)(82310400005)(7696005)(110136005)(6666004)(426003)(2616005)(81166007)(186003)(47076005)(16526019)(1076003)(83380400001)(336012)(86362001)(356005)(40480700001)(40460700003)(82740400003)(26005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2023 06:15:41.8822
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a7e40ac-133d-4f28-b3d0-08daefad705d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000C968.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5937
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

While amd-pstate driver was loaded with specific driver mode, it will
need to check which mode is enabled for the pstate driver,add this sysfs
entry to show the current status

$ cat /sys/devices/system/cpu/amd-pstate/status
active

Meanwhile, user can switch the pstate driver mode with writing mode
string to sysfs entry as below.

Enable passive mode:
$ sudo bash -c "echo passive >  /sys/devices/system/cpu/amd-pstate/status"

Enable active mode (EPP driver mode):
$ sudo bash -c "echo active > /sys/devices/system/cpu/amd-pstate/status"

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 118 +++++++++++++++++++++++++++++++++++
 1 file changed, 118 insertions(+)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 2c8b126cec5a..d3f4cdd803f3 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -63,6 +63,7 @@ static struct cpufreq_driver *current_pstate_driver;
 static struct cpufreq_driver amd_pstate_driver;
 static struct cpufreq_driver amd_pstate_epp_driver;
 static int cppc_state = AMD_PSTATE_DISABLE;
+struct kobject *amd_pstate_kobj;
 
 static inline int get_mode_idx_from_str(const char *str, size_t size)
 {
@@ -631,6 +632,8 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
 	policy->driver_data = cpudata;
 
 	amd_pstate_boost_init(cpudata);
+	if (!current_pstate_driver->adjust_perf)
+		current_pstate_driver->adjust_perf = amd_pstate_adjust_perf;
 
 	return 0;
 
@@ -771,12 +774,99 @@ static ssize_t show_energy_performance_preference(
 	return sysfs_emit(buf, "%s\n", energy_perf_strings[preference]);
 }
 
+static ssize_t amd_pstate_show_status(char *buf)
+{
+	if (!current_pstate_driver)
+		return sysfs_emit(buf, "disable\n");
+
+	return sysfs_emit(buf, "%s\n", amd_pstate_mode_string[cppc_state]);
+}
+
+static void amd_pstate_driver_cleanup(void)
+{
+	current_pstate_driver = NULL;
+}
+
+static int amd_pstate_update_status(const char *buf, size_t size)
+{
+	int ret;
+	int mode_idx;
+
+	if (size > 7 || size < 6)
+		return -EINVAL;
+	mode_idx = get_mode_idx_from_str(buf, size);
+
+	switch(mode_idx) {
+	case AMD_PSTATE_DISABLE:
+		if (!current_pstate_driver)
+			return -EINVAL;
+		if (cppc_state == AMD_PSTATE_ACTIVE)
+			return -EBUSY;
+		ret = cpufreq_unregister_driver(current_pstate_driver);
+		amd_pstate_driver_cleanup();
+		break;
+	case AMD_PSTATE_PASSIVE:
+		if (current_pstate_driver) {
+			if (current_pstate_driver == &amd_pstate_driver)
+				return 0;
+			cpufreq_unregister_driver(current_pstate_driver);
+			cppc_state = AMD_PSTATE_PASSIVE;
+			current_pstate_driver = &amd_pstate_driver;
+		}
+
+		ret = cpufreq_register_driver(current_pstate_driver);
+		break;
+	case AMD_PSTATE_ACTIVE:
+		if (current_pstate_driver) {
+			if (current_pstate_driver == &amd_pstate_epp_driver)
+				return 0;
+			cpufreq_unregister_driver(current_pstate_driver);
+			current_pstate_driver = &amd_pstate_epp_driver;
+			cppc_state = AMD_PSTATE_ACTIVE;
+		}
+
+		ret = cpufreq_register_driver(current_pstate_driver);
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	return ret;
+}
+
+static ssize_t show_status(struct kobject *kobj,
+			   struct kobj_attribute *attr, char *buf)
+{
+	ssize_t ret;
+
+	mutex_lock(&amd_pstate_driver_lock);
+	ret = amd_pstate_show_status(buf);
+	mutex_unlock(&amd_pstate_driver_lock);
+
+	return ret;
+}
+
+static ssize_t store_status(struct kobject *a, struct kobj_attribute *b,
+			    const char *buf, size_t count)
+{
+	char *p = memchr(buf, '\n', count);
+	int ret;
+
+	mutex_lock(&amd_pstate_driver_lock);
+	ret = amd_pstate_update_status(buf, p ? p - buf : count);
+	mutex_unlock(&amd_pstate_driver_lock);
+
+	return ret < 0 ? ret : count;
+}
+
 cpufreq_freq_attr_ro(amd_pstate_max_freq);
 cpufreq_freq_attr_ro(amd_pstate_lowest_nonlinear_freq);
 
 cpufreq_freq_attr_ro(amd_pstate_highest_perf);
 cpufreq_freq_attr_rw(energy_performance_preference);
 cpufreq_freq_attr_ro(energy_performance_available_preferences);
+define_one_global_rw(status);
 
 static struct freq_attr *amd_pstate_attr[] = {
 	&amd_pstate_max_freq,
@@ -794,6 +884,15 @@ static struct freq_attr *amd_pstate_epp_attr[] = {
 	NULL,
 };
 
+static struct attribute *pstate_global_attributes[] = {
+	&status.attr,
+	NULL
+};
+
+static const struct attribute_group amd_pstate_global_attr_group = {
+	.attrs = pstate_global_attributes,
+};
+
 static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
 {
 	int min_freq, max_freq, nominal_freq, lowest_nonlinear_freq, ret;
@@ -1153,6 +1252,25 @@ static int __init amd_pstate_init(void)
 	if (ret)
 		pr_err("failed to register with return %d\n", ret);
 
+	amd_pstate_kobj = kobject_create_and_add("amd_pstate", &cpu_subsys.dev_root->kobj);
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
+
+global_attr_free:
+	kobject_put(amd_pstate_kobj);
+kobject_free:
+	cpufreq_unregister_driver(current_pstate_driver);
 	return ret;
 }
 device_initcall(amd_pstate_init);
-- 
2.34.1

