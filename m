Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1155646E51
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 12:20:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbiLHLUd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 06:20:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbiLHLUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 06:20:02 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2081.outbound.protection.outlook.com [40.107.243.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92B8A53EC0;
        Thu,  8 Dec 2022 03:20:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mfkZuS32D5AmlvzWexZ0jGk5V4oB0P7zyWsK7UIeRDNficjr/JA4QBCrIxj6uC4yC0P9gWcG1a5jE9/9IZjaYzStO1z+33ZsFG4nhaBb7qyNkNagThS+beKvKjFXZGiEMVgSX9IumbnQ7T5Ezn4hFEmLcnPdsxWlC7EOqXFoW6yK0+r/SdXzyIAs8rEvpR08z/AVcaLtNr0UFm11vUcKiGZGlWujbqXcbbSd5Y0saz56w+rU9jPgeI0m9/iRWvXHFEY9SL9y0RUx3JI/puR3iVVK8bO8tIedCK2BJNzkr0iPhqVuhLr0GHcg2E0UxToOIoYR3BjYTeVtt6tqWNUkiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ca9pfUmcPytt39zB7h6P63d3JQnB2bnK2cKTQZTnm4Y=;
 b=mWw++XwbKJkCL4M4EuAWwD5VXyraNEoFGYa9HYIPM7DkdC9YNQ29+CWanwTYyjMweaPh3Few4495DPXKlnzblAf/K5Dn5LsKQsGUx1NY6MHKt7oOLk1rpmPpvfjx3mD1heJLvwCp89zkRicJyJpIiNZjxVf9FE2w1stUQDzMJW3nMRPhGe9sFlUMYd1szJM4sKqKb9UYKBQTAUPFRlhMgNCqJabAASr2pKhxGLrKiDxlRunA9GDFM17BHK8TTB91yHc1xXf1oFOkeo0VD0fESE1pEbBzG+G9GpsFDK+BhTvh3L3Vachb/RVWCBh4aZP+Sol6v9Zdvq1L233fSspg/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ca9pfUmcPytt39zB7h6P63d3JQnB2bnK2cKTQZTnm4Y=;
 b=f3nTrclCRZT4M2bkkl75QITNAiP+dzS2MWyJXrVB4NA8o5CI59Sbnw9Ls0qO+MYYIvFl9rZdjZXQ2Wnl1oQAOAXxs6np0XAz5axbw5gIwV7ZlPN1MPcDBwkgEHa2ZxltFcEvBmvMDX7Vvgsv/Jc1DjcjOkWX4QOuzCDU9lo1+5I=
Received: from DM6PR07CA0124.namprd07.prod.outlook.com (2603:10b6:5:330::34)
 by MN0PR12MB6320.namprd12.prod.outlook.com (2603:10b6:208:3d3::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Thu, 8 Dec
 2022 11:19:58 +0000
Received: from DM6NAM11FT084.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:330:cafe::73) by DM6PR07CA0124.outlook.office365.com
 (2603:10b6:5:330::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14 via Frontend
 Transport; Thu, 8 Dec 2022 11:19:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT084.mail.protection.outlook.com (10.13.172.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5901.16 via Frontend Transport; Thu, 8 Dec 2022 11:19:58 +0000
Received: from pyuan-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Thu, 8 Dec 2022 05:19:54 -0600
From:   Perry Yuan <perry.yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
        <ray.huang@amd.com>, <viresh.kumar@linaro.org>
CC:     <Deepak.Sharma@amd.com>, <Nathan.Fontenot@amd.com>,
        <Alexander.Deucher@amd.com>, <Shimmer.Huang@amd.com>,
        <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <wyes.karny@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v7 09/13] cpufreq: amd-pstate: add driver working mode status sysfs entry
Date:   Thu, 8 Dec 2022 19:18:48 +0800
Message-ID: <20221208111852.386731-10-perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: DM6NAM11FT084:EE_|MN0PR12MB6320:EE_
X-MS-Office365-Filtering-Correlation-Id: cb385d86-2d0e-4b5b-3ed5-08dad90e242b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xLvTfXKAn3ydk734rxPLXXliHzXVAW2PPHxURrmnOSlbF3JBpKVeTpOPsB+jUUnuzT87Q4w2NemXSInMwBkXkqxQ+xwwd4rfQRALn3VZcm+KxmemKgJZeBWNnrQ9MokMKES3Ltj9oZJWiVU5GlA/t200f7cM15etOlaReGUYLXYBvyeYWgP1NvBCiQwvAui+LB4zh9a1rKCLcvVrhDnC5RGh81J17QIIbck/fprwScxO2WboSunRmV8gi/RyGljD5q7vg/nlmA8lau7tU20XCOFBYEmgcljmsBFB4q/tbgnB31gt4aIk/Q3qtZXPhyTvqag87dOASDpQfJu6y2YjxluxJKGeQt3bct7lOjHXOccyWb7k/CO19pNlOYXnskquu1O5rXKNxdE59HcmmLzRE/EjaKHNGm2vLEuGuCP0Bdu+UQYWENKjO+dumpQmFYJd6kblvvVflIohsIpRlGo+q07HFFwgEtgpqVx2GOtcXYJUexLWpjiyRyAmkZmFbI56o3Db+ItHIOYat4zJW6KNqq46PsTXCiWbs+gX+2j5vTHEdrw04y7WVBypJJZ960HC7Lj/HSMVMj5A5n7jNInBRLFKIwYduhmIdRSy5m7V7RW7yS35Uf4JCtLQCDwhjx9KrsmhfcTXveUOOmwI7lPhAx2uMYMLv/7Dj3n3sNROiijDAdFHDXfHaTjNWA3VLRmH+NJ3QdQHhRC65b/S037oRM+mVlKUvF2rm11x/cy78Dg=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(39860400002)(346002)(136003)(451199015)(40470700004)(46966006)(36840700001)(36756003)(2906002)(82740400003)(36860700001)(40460700003)(86362001)(8936002)(44832011)(5660300002)(426003)(47076005)(83380400001)(16526019)(336012)(186003)(2616005)(1076003)(356005)(40480700001)(81166007)(82310400005)(316002)(54906003)(26005)(478600001)(41300700001)(4326008)(8676002)(110136005)(7696005)(70586007)(70206006)(6666004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2022 11:19:58.5148
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb385d86-2d0e-4b5b-3ed5-08dad90e242b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT084.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6320
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

Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 101 +++++++++++++++++++++++++++++++++++
 1 file changed, 101 insertions(+)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 4cd53c010215..c90aee3ee42d 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -64,6 +64,8 @@ static bool cppc_active;
 static int cppc_load __initdata;
 
 static struct cpufreq_driver *default_pstate_driver;
+static struct cpufreq_driver amd_pstate_epp_driver;
+static struct cpufreq_driver amd_pstate_driver;
 static struct amd_cpudata **all_cpu_data;
 static struct amd_pstate_params global_params;
 
@@ -72,6 +74,7 @@ static DEFINE_MUTEX(amd_pstate_driver_lock);
 struct kobject *amd_pstate_kobj;
 
 static bool cppc_boost __read_mostly;
+static DEFINE_SPINLOCK(cppc_notify_lock);
 
 static s16 amd_pstate_get_epp(struct amd_cpudata *cpudata, u64 cppc_req_cached)
 {
@@ -629,6 +632,8 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
 	policy->driver_data = cpudata;
 
 	amd_pstate_boost_init(cpudata);
+	if (!default_pstate_driver->adjust_perf)
+		default_pstate_driver->adjust_perf = amd_pstate_adjust_perf;
 
 	return 0;
 
@@ -802,6 +807,100 @@ static ssize_t store_cppc_dynamic_boost(struct kobject *a,
 	return count;
 }
 
+static ssize_t amd_pstate_show_status(char *buf)
+{
+	if (!default_pstate_driver)
+		return sysfs_emit(buf, "off\n");
+
+	return sysfs_emit(buf, "%s\n", default_pstate_driver == &amd_pstate_epp_driver ?
+					"active" : "passive");
+}
+
+static void amd_pstate_clear_update_util_hook(unsigned int cpu);
+static void amd_pstate_driver_cleanup(void)
+{
+	unsigned int cpu;
+
+	cpus_read_lock();
+	for_each_online_cpu(cpu) {
+		if (all_cpu_data[cpu]) {
+			if (default_pstate_driver == &amd_pstate_epp_driver)
+				amd_pstate_clear_update_util_hook(cpu);
+
+			spin_lock(&cppc_notify_lock);
+			kfree(all_cpu_data[cpu]);
+			WRITE_ONCE(all_cpu_data[cpu], NULL);
+			spin_unlock(&cppc_notify_lock);
+		}
+	}
+	cpus_read_unlock();
+
+	default_pstate_driver = NULL;
+}
+
+static int amd_pstate_update_status(const char *buf, size_t size)
+{
+	if (size == 3 && !strncmp(buf, "off", size)) {
+		if (!default_pstate_driver)
+			return -EINVAL;
+
+		if (cppc_active)
+			return -EBUSY;
+
+		cpufreq_unregister_driver(default_pstate_driver);
+		amd_pstate_driver_cleanup();
+		return 0;
+	}
+
+	if (size == 6 && !strncmp(buf, "active", size)) {
+		if (default_pstate_driver) {
+			if (default_pstate_driver == &amd_pstate_epp_driver)
+				return 0;
+			cpufreq_unregister_driver(default_pstate_driver);
+			default_pstate_driver = &amd_pstate_epp_driver;
+		}
+
+		return cpufreq_register_driver(default_pstate_driver);
+	}
+
+	if (size == 7 && !strncmp(buf, "passive", size)) {
+		if (default_pstate_driver) {
+			if (default_pstate_driver == &amd_pstate_driver)
+				return 0;
+			cpufreq_unregister_driver(default_pstate_driver);
+		}
+		default_pstate_driver = &amd_pstate_driver;
+		return cpufreq_register_driver(default_pstate_driver);
+	}
+
+	return -EINVAL;
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
 
@@ -809,6 +908,7 @@ cpufreq_freq_attr_ro(amd_pstate_highest_perf);
 cpufreq_freq_attr_rw(energy_performance_preference);
 cpufreq_freq_attr_ro(energy_performance_available_preferences);
 define_one_global_rw(cppc_dynamic_boost);
+define_one_global_rw(status);
 
 static struct freq_attr *amd_pstate_attr[] = {
 	&amd_pstate_max_freq,
@@ -828,6 +928,7 @@ static struct freq_attr *amd_pstate_epp_attr[] = {
 
 static struct attribute *pstate_global_attributes[] = {
 	&cppc_dynamic_boost.attr,
+	&status.attr,
 	NULL
 };
 
-- 
2.34.1

