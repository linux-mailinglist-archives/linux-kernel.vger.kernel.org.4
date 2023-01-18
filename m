Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 568A4671648
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 09:29:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbjARI2n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 03:28:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbjARI0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 03:26:04 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2069.outbound.protection.outlook.com [40.107.93.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64F315B46C;
        Tue, 17 Jan 2023 23:53:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C00y96yIwMGpozpxCgddDfeSFjQnk1DBN+nLDtQrIAdI5z/xaBeKJYMfQ8rXH5JCnlpHlNBFH2mu6e05XFKixq6TlbI3WAuJn6oyWyzjmdGWnXl3X8a/szUPSMmpBg1EB6RWp33ksxlnLq42upmCoCvYaDS5UQ76kVchYNobG1nUgBncViXJ0ot2QM/8wWCMFPFsTMq0m/fVKoe32P+hJlFyORYiXPMZIboirxjd8eBT+Y1Y9+Rr4Yri140uuWYqTiMwAZnqfYp2iEKu9a4I9PY2kOZi/1jUzNqj+s0eOxKhPvaeHkEFZAFYGjoOdEae/F1bFkEhzulSxH7RHZaNsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tlXvVHSTLtImk5AB2+ykPocLIEDOZel8yKjj0tTiuOs=;
 b=SyG0A+8e3Cc9BTRgsofvqGWztnp6+pTyDlCT0OXLXPqLc8XbS1CODLT5MKLmpzGYtyno9ZTIaCt46D+7AFrTgeDpSAU1lNQCzM+TRPo3x5VsQa1JmFV9vutOxaYqFEjOabPWmM74cVKYi/avKe28vlt7FMO3IsZ0o40oFesHEXOPjXHT994ahE2cNuacVZQuiULkhsrISEXjBUABGOTpgzxyUA8MYWgvxoR9hVBV4IPF3TZLypCfvuI4UH35QMrE9oGADRvLZSe9Vx4zvIIxn7iOMJ9F4wIs/9BIgF7LgD5Uea3glTetX+wEVhnBehSY+DLbUqMlqGvjd2aanrC2YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tlXvVHSTLtImk5AB2+ykPocLIEDOZel8yKjj0tTiuOs=;
 b=Rn7ZZBrzKwL7I7ldS2dupriohSWROim33AoujPSp/tCjN4C7Gej/g4ECfXxy3ttLyMJmGAoKaf0uyoB03CT6osP/2V+VC6YcACi/U6gEl5gDzVpcRGsOxK0bEdv3BNNdQgIldhPgTnDnY+5InWVyGTa2Wa4G9PNq77QUoG2lZMY=
Received: from MW4PR03CA0122.namprd03.prod.outlook.com (2603:10b6:303:8c::7)
 by SA1PR12MB6798.namprd12.prod.outlook.com (2603:10b6:806:25a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.19; Wed, 18 Jan
 2023 07:53:11 +0000
Received: from CO1NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8c:cafe::51) by MW4PR03CA0122.outlook.office365.com
 (2603:10b6:303:8c::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.19 via Frontend
 Transport; Wed, 18 Jan 2023 07:53:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT033.mail.protection.outlook.com (10.13.174.247) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6002.13 via Frontend Transport; Wed, 18 Jan 2023 07:53:10 +0000
Received: from pyuan-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Wed, 18 Jan 2023 01:53:06 -0600
From:   Perry Yuan <perry.yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
        <ray.huang@amd.com>, <viresh.kumar@linaro.org>
CC:     <Deepak.Sharma@amd.com>, <Nathan.Fontenot@amd.com>,
        <Alexander.Deucher@amd.com>, <Shimmer.Huang@amd.com>,
        <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <wyes.karny@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v11 07/11] cpufreq: amd-pstate: add driver working mode switch support
Date:   Wed, 18 Jan 2023 15:52:06 +0800
Message-ID: <20230118075210.447418-8-perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230118075210.447418-1-perry.yuan@amd.com>
References: <20230118075210.447418-1-perry.yuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT033:EE_|SA1PR12MB6798:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cf09d70-8d0c-44ad-b2a9-08daf9290b6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fxc+FQR0ijDu55uPi/Spo2MIz27apwgAGaA5oKa0+uD1Pq8KDEDzJ3yqMy9G9DNwc+tZtcypYlzrdJEncZvF7EVsoUy8YsbHSME8Q70JtwVgKKyLGQQmbKkCsZfq2r0pedsBuoH1+a9/KWALGzxPrEJX73MwB1SPqN4x9M7H5hvnjTycpctitpaGOTGVaiwnYLt0yRU3brgDCJsXXhMAp67buqgcPaaV8nNO8UX+n9m8HQVIWChSvGYMWQaNQzuz/kxx2A7uHrklgSrtyJpHhyZiOvCsYwcYJ+eWfnio917Pt4Z32jQp+Plh9SIkccz+fV6xvr5m0iFZ9QgNKlLhLHvjzA50xPn0+9lRn5tAqP2asB9dsj7BcSFkLvZcv0SJzMcr1Cua7MZxWqzZYZVyk+5sQhTw/BKAL1XijFpjQM+VW8DS2c1gaNNwySa3brzhOJyE4a1jo5boYnsfGad5g0794HwYYtsm2Khy0hqgJLUwBwb2rZfrRG12B6okT689GfqdxPJKB5PL7os/uNKHUKHTJ4iNwB6ZHe2/F0zb2f9IF9C0P/OpwYT5RxSxXEOKLOdAzZmK4JH9RgvuSQ4CoAjMU7S319aMJWXeGA8J6Lfm6kIcl94W+xIuCVMvKygdZE2/CkRqsIXqQZ/+dEW6ZIF8yS+HpWRp+p4jWSgixItMFjskgYIG6DZn5kEdJxw6lyTIEn5uIiLecZWCM2BtF1Wao4K/C3sETvQUOT/NtRI=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(136003)(376002)(39860400002)(451199015)(46966006)(36840700001)(40470700004)(83380400001)(426003)(47076005)(36860700001)(2906002)(356005)(44832011)(86362001)(5660300002)(41300700001)(82310400005)(8936002)(40460700003)(40480700001)(54906003)(186003)(478600001)(1076003)(7696005)(70586007)(16526019)(26005)(8676002)(316002)(336012)(4326008)(70206006)(2616005)(81166007)(82740400003)(110136005)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2023 07:53:10.5301
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cf09d70-8d0c-44ad-b2a9-08daf9290b6a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6798
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

Acked-by: Huang Rui <ray.huang@amd.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Reviewed-by: Wyes Karny <wyes.karny@amd.com>
Tested-by: Wyes Karny <wyes.karny@amd.com>
Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 118 +++++++++++++++++++++++++++++++++++
 1 file changed, 118 insertions(+)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 9e1bee060597..2e5e594dc41e 100644
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
@@ -1158,6 +1257,25 @@ static int __init amd_pstate_init(void)
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

