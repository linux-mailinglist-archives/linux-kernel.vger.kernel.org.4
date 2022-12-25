Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D26D655DB7
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Dec 2022 17:36:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231479AbiLYQg0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Dec 2022 11:36:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231470AbiLYQf5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Dec 2022 11:35:57 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2040.outbound.protection.outlook.com [40.107.220.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91683614C;
        Sun, 25 Dec 2022 08:35:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dEJBWA9j5FKwYw0vofFU6MrrDOx8s/HnlIFzmBUJdhjcAht5timyBtQrgltD5mD5QlUkmtIVks+/Nf2GKFAb5fIKQB4gVtJqWXHJNj0PDy7qLzcA1m/gkDg+g7hRu4qVy8kZDFsHT1cHcFEiI0KuFxrY155M8GGAk0JMbUlKLhdJSQBYjD1b4ehFZfpWWru0rXjcBR0nLsfQ6BAPnhytb21AqFhkuWmXQz1mes5DodvPWUplIJiSfED0hzyTQ9sUIzFFxCStaqrEf5HTna5nHKBihwnJHKKw2vrg+2VUQ2Hv2182e3O6ZydfUjEVPGVGhxUZ4vUnar9vZBd3KMZjHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DXc71Af5VP24THl2DnWkU0svquWahTh/H1XNW2L8BS8=;
 b=MAxzOEBWofMgECRVV9b21QiJtdw8A/yf1yiCvHcWBqNZoaNqtKlbcV8f3ciYuiagTjlUhxz7Jxv5K6RmM4q8nlUMYvOoug8M0DWsascCiuXrj+L0PhcO/8kR+WRk5/YsmjV0uzm/nnCM/nEFV1hGfgT4UmduRTz2rHx24AMpRxcgTIMeIhcndEbXTNGi7MKKczYdDhIBzAopqGm9OFive99VbRIO4AMJLK1cRtDheSH8wTNLoIi5O/cceIjIxs3JZ5Tofj2DvxA35T7nKPrEFiw12MYnLqmH8C/BuA+qoptaAEh19/BMuhdf9c2jQOoJTHOV/iM0lBAgwMY1vOGlrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DXc71Af5VP24THl2DnWkU0svquWahTh/H1XNW2L8BS8=;
 b=qv+c8L7bIZO0q1gkRsxeG6ZAEdHD9h+i6svtQWRgdNslV4M8UQAbaUx/EHQuyWY403MyvRkNAWdp9Te+gJh6M/aYf+rDP3exmyX/CQOSlciY1mC4CpIMwr76rV1joBDhycHd1uWTnoxpAiVdzQOcSeGA+KxlSD771drcs2wc2AI=
Received: from MW4PR04CA0134.namprd04.prod.outlook.com (2603:10b6:303:84::19)
 by LV2PR12MB5942.namprd12.prod.outlook.com (2603:10b6:408:171::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.12; Sun, 25 Dec
 2022 16:35:31 +0000
Received: from CO1NAM11FT023.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:84:cafe::e3) by MW4PR04CA0134.outlook.office365.com
 (2603:10b6:303:84::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.16 via Frontend
 Transport; Sun, 25 Dec 2022 16:35:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT023.mail.protection.outlook.com (10.13.175.35) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5944.16 via Frontend Transport; Sun, 25 Dec 2022 16:35:31 +0000
Received: from pyuan-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Sun, 25 Dec 2022 10:35:27 -0600
From:   Perry Yuan <perry.yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
        <ray.huang@amd.com>, <viresh.kumar@linaro.org>
CC:     <Deepak.Sharma@amd.com>, <Nathan.Fontenot@amd.com>,
        <Alexander.Deucher@amd.com>, <Shimmer.Huang@amd.com>,
        <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <wyes.karny@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v9 09/13] cpufreq: amd-pstate: add driver working mode switch support
Date:   Mon, 26 Dec 2022 00:34:38 +0800
Message-ID: <20221225163442.2205660-10-perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221225163442.2205660-1-perry.yuan@amd.com>
References: <20221225163442.2205660-1-perry.yuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT023:EE_|LV2PR12MB5942:EE_
X-MS-Office365-Filtering-Correlation-Id: a9ce22dc-1f17-4cf3-e817-08dae69609fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: svueFrAm1y1v+q5J0TNut+fR3YC9S+wu/z/1Qn2Mdmkfs0Rr5iU/kzB3LaN4Y3X+o/+0K4BI56+65uUJcwnPOp+yA3yTsAUYBr3yqiCUDi3jJ/hnS+GENlPGBkco9jYpyD3VqJG1iJCpLYf1FyMUvTSS+TIt5WsTJUtiUTUVyPPXzJURDENtSYfKOcareAk79ABapoxF6AdeWfEhy1a7etI+fGNkkMIwn1NW6JIT/aksHjZ30Xml3gg6XAC8IzOI6VCkmmG8anOTnmMq7hwUTuD+mtQ6isrhNcpAxbyqThZpk1mMIsQLb5tD8xSqBCL7k6ulW7uFCS6A6Yw2TwXbnzaSXPmUtfSjafT00wO+uvckShjdQb7QDC1jmeUAinV/EI3LZA2u0V79cvJSaXA46Pt2nOZ1XMR0RX8QT+VgInUZ6alx97oIN8gbVOGdPBZma0aIcI5A5VlulfX04/fy4b3LICcpWokCl7GCZ/+tuWUSHHNC64w4uYb+pz4l/HqPn5rTT6AFi7Lx7rGeA7FJ2w/F7m2pDi33ruoligZg2nhio/3osUNTa1JMGxUph3nBe3AyAAvjZZRM8ihkHjHyfNRL4z3RfWOMQXYBhe0EvF+ZopWkx9cGajspcp9osXX8mJUC4C6aTGD6OeRXUceI6YJd8VKP8Exl59g/wwTforcNcIq+4jMHbK78tz0iOUroPq/VsaUCWeyLSDrtu2qAjm71ta9X4yYdaZdqjxrrcmA=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(346002)(39860400002)(396003)(451199015)(40470700004)(36840700001)(46966006)(316002)(54906003)(110136005)(2906002)(82740400003)(426003)(16526019)(82310400005)(41300700001)(40460700003)(83380400001)(5660300002)(44832011)(47076005)(336012)(40480700001)(8936002)(36756003)(2616005)(186003)(70206006)(4326008)(1076003)(70586007)(8676002)(81166007)(7696005)(478600001)(356005)(6666004)(36860700001)(86362001)(26005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Dec 2022 16:35:31.1614
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a9ce22dc-1f17-4cf3-e817-08dae69609fb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT023.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5942
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
 drivers/cpufreq/amd-pstate.c | 118 +++++++++++++++++++++++++++++++++++
 1 file changed, 118 insertions(+)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index e3676d1a85c7..8ceca4524fc1 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -63,6 +63,7 @@ static struct cpufreq_driver *default_pstate_driver;
 static struct cpufreq_driver amd_pstate_driver;
 static struct cpufreq_driver amd_pstate_epp_driver;
 static int cppc_state = AMD_PSTATE_DISABLE;
+struct kobject *amd_pstate_kobj;
 
 static inline int get_mode_idx_from_str(const char *str, size_t size)
 {
@@ -632,6 +633,8 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
 	policy->driver_data = cpudata;
 
 	amd_pstate_boost_init(cpudata);
+	if (!default_pstate_driver->adjust_perf)
+		default_pstate_driver->adjust_perf = amd_pstate_adjust_perf;
 
 	return 0;
 
@@ -772,12 +775,99 @@ static ssize_t show_energy_performance_preference(
 	return sysfs_emit(buf, "%s\n", energy_perf_strings[preference]);
 }
 
+static ssize_t amd_pstate_show_status(char *buf)
+{
+	if (!default_pstate_driver)
+		return sysfs_emit(buf, "off\n");
+
+	return sysfs_emit(buf, "%s\n", amd_pstate_mode_string[cppc_state]);
+}
+
+static void amd_pstate_driver_cleanup(void)
+{
+	default_pstate_driver = NULL;
+}
+
+static int amd_pstate_update_status(const char *buf, size_t size)
+{
+	int ret;
+	int mode_idx;
+
+	if (size > 7 || size < 3)
+		return -EINVAL;
+	mode_idx = get_mode_idx_from_str(buf, size);
+
+	switch(mode_idx) {
+	case AMD_PSTATE_DISABLE:
+		if (!default_pstate_driver)
+			return -EINVAL;
+		if (cppc_state == AMD_PSTATE_ACTIVE)
+			return -EBUSY;
+		ret = cpufreq_unregister_driver(default_pstate_driver);
+		amd_pstate_driver_cleanup();
+		break;
+	case AMD_PSTATE_PASSIVE:
+		if (default_pstate_driver) {
+			if (default_pstate_driver == &amd_pstate_driver)
+				return 0;
+			cpufreq_unregister_driver(default_pstate_driver);
+			cppc_state = AMD_PSTATE_PASSIVE;
+			default_pstate_driver = &amd_pstate_driver;
+		}
+
+		ret = cpufreq_register_driver(default_pstate_driver);
+		break;
+	case AMD_PSTATE_ACTIVE:
+		if (default_pstate_driver) {
+			if (default_pstate_driver == &amd_pstate_epp_driver)
+				return 0;
+			cpufreq_unregister_driver(default_pstate_driver);
+			default_pstate_driver = &amd_pstate_epp_driver;
+			cppc_state = AMD_PSTATE_ACTIVE;
+		}
+
+		ret = cpufreq_register_driver(default_pstate_driver);
+		break;
+	default:
+		break;
+		ret = -EINVAL;
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
@@ -795,6 +885,15 @@ static struct freq_attr *amd_pstate_epp_attr[] = {
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
@@ -1154,6 +1253,25 @@ static int __init amd_pstate_init(void)
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
+	cpufreq_unregister_driver(default_pstate_driver);
 	return ret;
 }
 device_initcall(amd_pstate_init);
-- 
2.34.1

