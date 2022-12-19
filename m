Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECA386507B8
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 07:43:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231579AbiLSGnQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 01:43:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231459AbiLSGmd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 01:42:33 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2070.outbound.protection.outlook.com [40.107.92.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E78256157;
        Sun, 18 Dec 2022 22:41:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AVkS4IqKUlFPW9QSq/vAdYJxEHm/m9e282C4GgIvoJJJP428sRg6VnmJhWpp8SHOkgNUvywUAzMPVB6f+N1+OfY+holH9M9g4x5Og5PdpSmjhbByar2pwEUYeCxrI9lWD9qxMm+9yaO78CkgXgHyViL9AC7rgdh1itdjDLiaMj/b6S2U46uI+JTTqxB+fV2133b3ybBXcVWe9lrNhtA6BqJyQArtoWmcG06/8bxtSs8U0Fvk7xBfYQH1r+mo5o/w9izYXT8cijGM+r+CflP7an8dTR9CJbLhng322F7dEgK0TlSBItTEl/tfnlIRjkVWqfimo5L4ZwziPPNDhnE4Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W2ZqHGdaWG++QejFv0qF0mLadsspFPKdlGH9QjkoDS4=;
 b=nOBxDlS4zOWWesy7WtfuAOVhjO6xAQAyIfgyk5GxEk9f/fOJrsUZKlPOb57phVo2mNhpufEt6zE47/DAhxCO/xqOODANC69pnLbxVfaoFUQVuPsLTY1yxVubnsVwGG9vUqaUBxDpA5Qckv4i3vOe/CYYYYGCDdyyr19LB2QF13yJCTb8XZld3re69un/Nopgv8Db0TF7GfwekuS0sa1KUN/+gUgRJJO7t3LQyyWPafIoD8DmSXouuU1xqtZN1TX4rNtor5SaMuW8az3ZvdqgDyLzmcIQHB1lWQ2TuJD2luHtcXEZjjX7LzZ8fwR7TLrS/hMBjNJ18orpe0N7etoErg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W2ZqHGdaWG++QejFv0qF0mLadsspFPKdlGH9QjkoDS4=;
 b=kKL13/5Geff95ZPY1mreYPfnfVaQDeVMWjI1ttiiOuRBw/maELK0LVZvGxAKqap5Sch4Q2fMuk+8lwYHhfzaZr3/j0UhfmG3uz1zCznXbhTFl/mTT8OLNEbHZs7liezGlLK/9r4L69DDoLG4iduNPxArgAnbBdNZM7WXBKqpR58=
Received: from DS7P222CA0009.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::11) by
 SA1PR12MB7245.namprd12.prod.outlook.com (2603:10b6:806:2bf::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Mon, 19 Dec
 2022 06:41:52 +0000
Received: from DM6NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2e:cafe::1c) by DS7P222CA0009.outlook.office365.com
 (2603:10b6:8:2e::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.20 via Frontend
 Transport; Mon, 19 Dec 2022 06:41:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT050.mail.protection.outlook.com (10.13.173.111) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5924.16 via Frontend Transport; Mon, 19 Dec 2022 06:41:51 +0000
Received: from pyuan-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Mon, 19 Dec 2022 00:41:48 -0600
From:   Perry Yuan <perry.yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
        <ray.huang@amd.com>, <viresh.kumar@linaro.org>
CC:     <Deepak.Sharma@amd.com>, <Nathan.Fontenot@amd.com>,
        <Alexander.Deucher@amd.com>, <Shimmer.Huang@amd.com>,
        <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <wyes.karny@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v8 09/13] cpufreq: amd-pstate: add driver working mode switch support
Date:   Mon, 19 Dec 2022 14:40:38 +0800
Message-ID: <20221219064042.661122-10-perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221219064042.661122-1-perry.yuan@amd.com>
References: <20221219064042.661122-1-perry.yuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT050:EE_|SA1PR12MB7245:EE_
X-MS-Office365-Filtering-Correlation-Id: dfde6600-fa56-4c48-18f9-08dae18c1c7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r5clV4acaRKPaC3eabGYYwYkwOfU+ovsC9HSRf8m6YMqkm5ORLkZyi7fs1BSV6nPj1ALP3cXgdV2sFXPe6EkLjTNyv4J0g2pNKBlWSGH2xqVnF+ao0Rq4DC2mSo6LM+Q4Q5GnNGxyFieFlhS1J4QFa+bcCteqhIJcY+6UDH/+IIxYp8PGygAbpmb5lUthT5otzhPZ9JWQL33lKeHClUFkiWw4JPiCYjDTuxMzRkEp5Xq+AYJEZAeq/on6ZA9NvO04rAR/o9KvK8YAvB7oEObHKknMHISDBezyeShwCmLJaB86QcNrOV3Da0kHA/KZwgze5BCD+7nwmGL+Woy4P+Djc4r3CWajp5ikFkEE4FnkTCnHUscmCYdBeSn08b8bfv4+ralv7nxB3GumRAs1i+/+txrA5eT/1buStzHB123T5OYXGiDdRQ78f36rZAXhmoSf46dJ2T6oWpm3tMVO+qX9g8hG49KM2UOxWpqZyiQLVLNMHDHQ8QjSmnZsLWdrOkaIIP8kikJj7BxY/PEa7CVnHL674J0U96BnLTnwzQLk64UyjXc2RQD6p2vUCsHhs2ySjSKXNsdVWgCUJDXHZQVt5tEXympElLeoWwU+z0FqV1GZ02VSL27MWHEf+1fnaNupJXBiC9zadjtQA1kAIFpYY93aeGqoO+eoRkMUK7NPpUM0LmQIBGip6H1Sx09FxqC2lOtHxTjkR358RJYXw91l146m4Vxhv5gqUQOaUgx30w=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(136003)(376002)(396003)(451199015)(46966006)(40470700004)(36840700001)(70586007)(70206006)(40460700003)(86362001)(8676002)(4326008)(316002)(5660300002)(36756003)(8936002)(2616005)(41300700001)(1076003)(82310400005)(7696005)(16526019)(6666004)(186003)(36860700001)(26005)(83380400001)(426003)(336012)(47076005)(356005)(54906003)(40480700001)(82740400003)(81166007)(110136005)(478600001)(44832011)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2022 06:41:51.5196
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dfde6600-fa56-4c48-18f9-08dae18c1c7d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7245
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
 drivers/cpufreq/amd-pstate.c | 128 +++++++++++++++++++++++++++++++++++
 1 file changed, 128 insertions(+)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index fc12d35bc7bd..e8996e937e63 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -64,6 +64,7 @@ static struct cpufreq_driver amd_pstate_driver;
 static struct cpufreq_driver amd_pstate_epp_driver;
 static struct amd_cpudata **all_cpu_data;
 static int cppc_state = AMD_PSTATE_DISABLE;
+struct kobject *amd_pstate_kobj;
 
 static inline int get_mode_idx_from_str(const char *str, size_t size)
 {
@@ -90,6 +91,8 @@ static struct amd_pstate_params global_params;
 static DEFINE_MUTEX(amd_pstate_limits_lock);
 static DEFINE_MUTEX(amd_pstate_driver_lock);
 
+static DEFINE_SPINLOCK(cppc_notify_lock);
+
 static s16 amd_pstate_get_epp(struct amd_cpudata *cpudata, u64 cppc_req_cached)
 {
 	u64 epp;
@@ -644,6 +647,8 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
 	policy->driver_data = cpudata;
 
 	amd_pstate_boost_init(cpudata);
+	if (!default_pstate_driver->adjust_perf)
+		default_pstate_driver->adjust_perf = amd_pstate_adjust_perf;
 
 	return 0;
 
@@ -784,12 +789,106 @@ static ssize_t show_energy_performance_preference(
 	return sysfs_emit(buf, "%s\n", energy_perf_strings[preference]);
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
+static void amd_pstate_driver_cleanup(void)
+{
+	unsigned int cpu;
+
+	cpus_read_lock();
+	for_each_online_cpu(cpu) {
+		if (all_cpu_data[cpu]) {
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
+		if (cppc_state == AMD_PSTATE_ACTIVE)
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
+			cppc_state = AMD_PSTATE_ACTIVE;
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
+			cppc_state = AMD_PSTATE_PASSIVE;
+			default_pstate_driver = &amd_pstate_driver;
+		}
+
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
 
 cpufreq_freq_attr_ro(amd_pstate_highest_perf);
 cpufreq_freq_attr_rw(energy_performance_preference);
 cpufreq_freq_attr_ro(energy_performance_available_preferences);
+define_one_global_rw(status);
 
 static struct freq_attr *amd_pstate_attr[] = {
 	&amd_pstate_max_freq,
@@ -807,6 +906,15 @@ static struct freq_attr *amd_pstate_epp_attr[] = {
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
 static inline void update_boost_state(void)
 {
 	u64 misc_en;
@@ -1228,6 +1336,26 @@ static int __init amd_pstate_init(void)
 	if (ret)
 		pr_err("failed to register with return %d\n", ret);
 
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
+
+global_attr_free:
+	kobject_put(amd_pstate_kobj);
+kobject_free:
+	kfree(cpudata);
+	cpufreq_unregister_driver(default_pstate_driver);
 	return ret;
 }
 device_initcall(amd_pstate_init);
-- 
2.34.1

