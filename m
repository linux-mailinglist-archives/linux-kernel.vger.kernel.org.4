Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19D6368281D
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 10:07:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232112AbjAaJFq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 04:05:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231980AbjAaJFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 04:05:10 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2083.outbound.protection.outlook.com [40.107.96.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEC85171F;
        Tue, 31 Jan 2023 01:01:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mDJ/P9cVoR02CApcg2D+KAXHSGvHc/A9ay/10Rd1LUMtktBgU+MfFPDEyZ6QGgIky7T3AB/l/03cN6wT8UJBd6H2O9T5VwNbzmOLS/ekXrCuyIAUg5Evthlrj2P+Yds1+UfFxTZIvWpQ+q+0f9VBigEfVua1UcO+mC7WNhBmOt6Mi258dhMo4xhvQLWr6vGVsoymbgKBTeU9f7ZsY/Tu51o4T5wO6LhwdmwNhfHYvNt+a5VSrRJJdLFbRnFejqSg/RcHsTvvv1H3HprzWQfak3yZziUPAHzTjPOGNIOLP7n7zjKH5hd3jfL5ReGasgvYDQApYNzs5JjRZh3jxG5HvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3871KFawko0KvCpa0KSo2eJ/IRBojqzV4lWPHRpSgVU=;
 b=h5ev2lIhCdF6LIE6PlAvWYVuB61lzF0o25Qzn0Ewh+5oH/8zIHj1Rg3+seGS5fI7Uo1sMuPD+xVeMoZ3VNEy73bV5QFZGl8TeGWhKaZS09j8dRVXX2crvUy45O8Lj7mUFzrQ3DUluhx736FIIixn9yuhKd987swsANI0gyf+rMx0osJaHh0NTWk+/3SdRzQkf2SMZMiXKIP2NJWbfFk09OkDO7D8XZd4cgd8CsMKd0+vJ65KHI3tN1oBFvuEQa29z5obdQMO1t2i0TiM/Uahlr1XHXuBXcT60SA2dCmlDa+i4rkNFBMCO83rsTVVeXlFHatY1aCFoHblrS362qq4+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3871KFawko0KvCpa0KSo2eJ/IRBojqzV4lWPHRpSgVU=;
 b=hV0xct9Vc+w0bhL0LUCArLIqW2Ak6oxAI7yNDHsqKUc2J+vCuFx7TWZMNxcu26LfIkiWR7vVYW7VEJuL2U1qbh3FxxbEd0fc8OstriSPRHywRaj4F0mS8Goy25OzkLpXeXOiD60KvX6uCAEBhmeUNkD4hwsqrvYvQejdQJSWCd8=
Received: from MW4PR03CA0251.namprd03.prod.outlook.com (2603:10b6:303:b4::16)
 by CY8PR12MB7266.namprd12.prod.outlook.com (2603:10b6:930:56::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38; Tue, 31 Jan
 2023 09:01:10 +0000
Received: from CO1NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b4:cafe::55) by MW4PR03CA0251.outlook.office365.com
 (2603:10b6:303:b4::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36 via Frontend
 Transport; Tue, 31 Jan 2023 09:01:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT046.mail.protection.outlook.com (10.13.174.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6043.23 via Frontend Transport; Tue, 31 Jan 2023 09:01:09 +0000
Received: from pyuan-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Tue, 31 Jan 2023 03:01:05 -0600
From:   Perry Yuan <perry.yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
        <ray.huang@amd.com>, <viresh.kumar@linaro.org>
CC:     <Deepak.Sharma@amd.com>, <Nathan.Fontenot@amd.com>,
        <Alexander.Deucher@amd.com>, <Shimmer.Huang@amd.com>,
        <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <wyes.karny@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v12 07/11] cpufreq: amd-pstate: add driver working mode switch support
Date:   Tue, 31 Jan 2023 17:00:12 +0800
Message-ID: <20230131090016.3970625-8-perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230131090016.3970625-1-perry.yuan@amd.com>
References: <20230131090016.3970625-1-perry.yuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT046:EE_|CY8PR12MB7266:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ac5e5af-ef2c-4682-6134-08db0369b22e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M5f+LSQn5GB/IEUyo/Pei0DkyQ/XuDNfUvC9fJ+TDAMGgUOUPnJQiwE2yP6ykCjIyvU7e9f0wl9dz+VCi6shtR6nLq1iN1Iaz9aCFFVT+T+cdtBF2jTwt4FroVzixSk+QA/gznL9oms05JK2YntmCxCJIpNLc8cfC7+eMaOcdDCNSkMUDSK5u6/ELOnfgwLqyB9YBtH62iAqm1F6bzCCd9RK6wPr6SZ3402rEmrKcMP1eO3jslWPj4Zpbn/HHUrHap5E9Pu0IcduYjluGGsQbRAAWRi1mKB8Zm7vuZ5XMKZdNfM2X8QMmYM/ryUj0O8tzdkKajVmeOVacfugxm/wEjNxZGlWcnWRCaOGMSZVqzn15uyDVc8dPjpycf1yBGDIngcVVnDDayWvqb4hYyTroemsMtASs9WARHdOEaTSyC2RxBjIUVgHvLwwKgn2IZiqRa5KfHZOaDB+ToRI5QFXBgFFIJU0lZxfo+ftzK0SL7KO2LnOWCEa+FlrGW/ZZ3HzLh3a4LpCtL14yKk9gRuv1R32TxcZTLRbUaJDGFyGXoVuPeM+tfxYbLcdF+klYVxkB8c2fJag5ho5/pFSrHUdDmenEwqW3FB5x8jmmbDw74WQOTmC9sGiIZ/2zJun4uRrx6YOeYvBgT48y8FEWEH+rIVx+zFJSF7lgcRVkNlPUYjVPzUT0U8ET4lQjM1tU/H6CJSk37UQbPpzwmYzeZarEFnAlBtiGGM3Bt3F7OIEq+U=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(396003)(136003)(346002)(376002)(451199018)(40470700004)(46966006)(36840700001)(7696005)(2616005)(82310400005)(47076005)(426003)(6666004)(54906003)(316002)(110136005)(336012)(83380400001)(36756003)(2906002)(44832011)(82740400003)(81166007)(36860700001)(1076003)(40460700003)(70206006)(8676002)(4326008)(70586007)(26005)(16526019)(186003)(478600001)(41300700001)(86362001)(5660300002)(356005)(40480700001)(8936002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2023 09:01:09.7171
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ac5e5af-ef2c-4682-6134-08db0369b22e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7266
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
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
index 4e3770e0d4d3..1ae2e0d56ed1 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -63,6 +63,7 @@ static struct cpufreq_driver *current_pstate_driver;
 static struct cpufreq_driver amd_pstate_driver;
 static struct cpufreq_driver amd_pstate_epp_driver;
 static int cppc_state = AMD_PSTATE_DISABLE;
+struct kobject *amd_pstate_kobj;
 
 /*
  * AMD Energy Preference Performance (EPP)
@@ -673,6 +674,8 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
 	policy->driver_data = cpudata;
 
 	amd_pstate_boost_init(cpudata);
+	if (!current_pstate_driver->adjust_perf)
+		current_pstate_driver->adjust_perf = amd_pstate_adjust_perf;
 
 	return 0;
 
@@ -813,12 +816,99 @@ static ssize_t show_energy_performance_preference(
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
@@ -836,6 +926,15 @@ static struct freq_attr *amd_pstate_epp_attr[] = {
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
@@ -1200,6 +1299,25 @@ static int __init amd_pstate_init(void)
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

