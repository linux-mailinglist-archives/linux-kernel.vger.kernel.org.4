Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39A60645DE6
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 16:49:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbiLGPtU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 10:49:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbiLGPtK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 10:49:10 -0500
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2089.outbound.protection.outlook.com [40.107.95.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A804263BAE;
        Wed,  7 Dec 2022 07:49:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fhiD8iP+PAcw7pAAcj0JsrAL2vx1Y04kQl0bYkMJJsvSN+p9BJEyc510Sr6AqLR8R4rBkl/osAQKt4wPKWzG1pz9tpIXEgXOjAwU6yuF/xUV/z2uVE4uhu1pREX3d2ASDaKzbR9UquV790p0yifd2HdazO4H6PGlnwQkaUxkWdtnekbh+rZiXRE55jta7K2YaCtlA7gjaKLCRrFDM4OdESvZmhDBJxaihuXE+a8HG2RaPg5HYuPHOwXfST4gKfWvenomFcCPSq1tsDZNXi7mPE2EemRFJvPno+uQ/UrxHAfO/FosW3buqNaPnhlMcXsoXOL/ZX3OSvYi7W9FgFsZzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MbU1xFoTsR7cw1bOECIU0HE1PRvSMpX49ZRk/kvkMZM=;
 b=hmUxvFCHeeJtdhz0RICFR6vuwPHeGzJVUrYHyhBcKEJ39ZJBXkDsV/qBOoEldHRf+Vgd6KHDGe/Ydhqv7uNXsgtACEiXV/bJaKCR+NBBPbRpqqhbnmlFaUGINBfo0TefQU+cb5h15FGW+DPciasWuDthKLHLvkgfFIgXTJoARqPuMZOp8V4XsXTwtBWGGGMxD9q6LAHPNYUtHz3cxxlli4Xf3Z02WuoWwxZrngO+3QZLwxkda8lbUYhpPwOZ6J2Izv134dE2reTvlQh9pvWgrvcpGuKOKSMKWUB1o2UNeRPowSTQJhz0USi9eQAxu00q3hjl5aVBnq0h9T6COLffnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MbU1xFoTsR7cw1bOECIU0HE1PRvSMpX49ZRk/kvkMZM=;
 b=jvc/4wULUUJhExjrFelUU567Ams6cWI4qQN17GcG0ce8RyKBMH5eZUaogLZy2iPdcd46Grq/9RtCX/KRFXAoJG1geB4hDDe5aWuat0j/rhRnzPvcVfnrmFkcMLTaPpm50YSW1IcZcQ7glGec6PrOKFHMAF4JpJS25F2aq2S4CTY=
Received: from BN9PR03CA0251.namprd03.prod.outlook.com (2603:10b6:408:ff::16)
 by DS7PR12MB8345.namprd12.prod.outlook.com (2603:10b6:8:e5::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5880.14; Wed, 7 Dec 2022 15:49:08 +0000
Received: from BN8NAM11FT088.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ff:cafe::dd) by BN9PR03CA0251.outlook.office365.com
 (2603:10b6:408:ff::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14 via Frontend
 Transport; Wed, 7 Dec 2022 15:49:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT088.mail.protection.outlook.com (10.13.177.81) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5901.16 via Frontend Transport; Wed, 7 Dec 2022 15:49:07 +0000
Received: from beas.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 7 Dec
 2022 09:49:03 -0600
From:   Wyes Karny <wyes.karny@amd.com>
To:     <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>
CC:     Jonathan Corbet <corbet@lwn.net>, Huang Rui <ray.huang@amd.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        <Mario.Limonciello@amd.com>, <Perry.Yuan@amd.com>,
        Ananth Narayan <ananth.narayan@amd.com>,
        <gautham.shenoy@amd.com>, Wyes Karny <wyes.karny@amd.com>
Subject: [PATCH 3/4] cpufreq: amd_pstate: Expose sysfs interface to control state
Date:   Wed, 7 Dec 2022 15:46:47 +0000
Message-ID: <20221207154648.233759-4-wyes.karny@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221207154648.233759-1-wyes.karny@amd.com>
References: <20221207154648.233759-1-wyes.karny@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT088:EE_|DS7PR12MB8345:EE_
X-MS-Office365-Filtering-Correlation-Id: f64d1e1a-2106-484d-bf9c-08dad86a937b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: axjqTzW7WbGdtk+d+Q1FUOPqS3ZlRn4AfvRejHuzbmsnYyj73LWvdrSzYOInyQpIB7s6FQYzc1OICOtqcmuPvDAQBJ5/edSTkClCTztvkvn2BrjiyG8ZqiUMAYXqskm6zWZbaqYv0wfpn8dGfLMT7We941aqN3EByDUey29Iti3N8Xnyb+hzdmLCmBntcMCrx1MmU1kl8mWv7pAFlIGbhjtJjLjdT2cCDnFFKSq7pWMJIbG806ZxD1FlByIuSwzSVR3+daM1DDjfGoHqffFa+4z2KD7FKvrOzXYOuHL8ht4XrY1suwnTZ/hFQhBMkCUrBrGRAddNA5NlKbVG8kWe5QpE3kdqQ84DqhY4PLrjZyhuIpQkVTQq8ajunZ5zakJ+yYX9EGS/QZ0G2ar3weVJCgju5YKIS7HgcYrf5HGMEAOLM2nf4WsxRawCSCMJb26fJWJ3CHixSOUfF8/mWb22BPEVZ9gW2WO6gtnvemfFt1svFuM8au/Ln1z7G5JzCvL+1F+FaESmk5iF/nUFm/PT5xKLmoaIJXD2m4heh9Flg3SQOj/zfCUPBWN3tDg15/+QCf0xsa6WVL2GvGEZ2uZaLoS8QDp6is0G9G4j/5w28lc2AZyp/2aDILxj3tyxrG/t5QSoecBJlGuT3kTVTjp5IcpUvWQgKVR7DzFDeZIhtHKMs+Ij8U8F0Q/oBDobHDK9E9Aa7imJbUKjF4znCQYC+m3oLq00zpRxWmurN6ZMN9w=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(346002)(376002)(39860400002)(451199015)(46966006)(36840700001)(40470700004)(82740400003)(54906003)(82310400005)(2906002)(83380400001)(6666004)(16526019)(40480700001)(2616005)(40460700003)(44832011)(316002)(8936002)(1076003)(186003)(41300700001)(478600001)(36756003)(336012)(5660300002)(81166007)(356005)(110136005)(47076005)(7696005)(426003)(70586007)(70206006)(86362001)(4326008)(8676002)(36860700001)(26005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2022 15:49:07.8371
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f64d1e1a-2106-484d-bf9c-08dad86a937b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT088.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8345
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As amd_pstate is a built-in driver (commit 456ca88d8a52 ("cpufreq:
amd-pstate: change amd-pstate driver to be built-in type")), it can't be
unloaded. However, it can be registered/unregistered from the
cpufreq-core at runtime.

Add a sysfs file to show the current amd_pstate status as well as add
register/un-register capability to amd_pstate through this file.

This sysfs interface can be used to change the driver mode dynamically.

To show current state:
 #cat /sys/devices/system/cpu/amd_pstate/state
 # disable [passive] guided

"[]" indicates current mode.

To disable amd_pstate driver:
 #echo disable > /sys/devices/system/cpu/amd_pstate/state

To enable passive mode:
 #echo passive > /sys/devices/system/cpu/amd_pstate/state

To change mode from passive to guided:
 #echo guided > /sys/devices/system/cpu/amd_pstate/state

Signed-off-by: Wyes Karny <wyes.karny@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 142 +++++++++++++++++++++++++++++++++++
 1 file changed, 142 insertions(+)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 8bffcb9f80cf..023c4384a46a 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -50,6 +50,8 @@
 #define AMD_PSTATE_TRANSITION_LATENCY	20000
 #define AMD_PSTATE_TRANSITION_DELAY	1000
 
+typedef int (*cppc_mode_transition_fn)(int);
+
 enum amd_pstate_mode {
 	CPPC_DISABLE = 0,
 	CPPC_PASSIVE,
@@ -87,6 +89,8 @@ static inline int get_mode_idx_from_str(const char *str, size_t size)
 	return -EINVAL;
 }
 
+static DEFINE_MUTEX(amd_pstate_driver_lock);
+
 static inline int pstate_enable(bool enable)
 {
 	return wrmsrl_safe(MSR_AMD_CPPC_ENABLE, enable);
@@ -623,6 +627,124 @@ static ssize_t show_amd_pstate_highest_perf(struct cpufreq_policy *policy,
 	return sprintf(&buf[0], "%u\n", perf);
 }
 
+static int amd_pstate_driver_cleanup(void)
+{
+	amd_pstate_enable(false);
+	cppc_state = CPPC_DISABLE;
+	return 0;
+}
+
+static int amd_pstate_register_driver(int mode)
+{
+	int ret;
+
+	ret = cpufreq_register_driver(&amd_pstate_driver);
+	if (ret) {
+		amd_pstate_driver_cleanup();
+		return ret;
+	}
+
+	cppc_state = mode;
+	return 0;
+}
+
+static int amd_pstate_unregister_driver(int dummy)
+{
+	int ret;
+
+	ret = cpufreq_unregister_driver(&amd_pstate_driver);
+
+	if (ret)
+		return ret;
+
+	amd_pstate_driver_cleanup();
+	return 0;
+}
+
+static int amd_pstate_change_driver_mode(int mode)
+{
+	cppc_state = mode;
+	return 0;
+}
+
+/* Mode transition table */
+cppc_mode_transition_fn mode_state_machine[CPPC_MODE_MAX][CPPC_MODE_MAX] = {
+	[CPPC_DISABLE]         = {
+		[CPPC_DISABLE]     = NULL,
+		[CPPC_PASSIVE]     = amd_pstate_register_driver,
+		[CPPC_GUIDED]      = amd_pstate_register_driver,
+	},
+	[CPPC_PASSIVE]         = {
+		[CPPC_DISABLE]     = amd_pstate_unregister_driver,
+		[CPPC_PASSIVE]     = NULL,
+		[CPPC_GUIDED]      = amd_pstate_change_driver_mode,
+	},
+	[CPPC_GUIDED]          = {
+		[CPPC_DISABLE]     = amd_pstate_unregister_driver,
+		[CPPC_PASSIVE]     = amd_pstate_change_driver_mode,
+		[CPPC_GUIDED]      = NULL,
+	},
+};
+
+static int amd_pstate_update_status(const char *buf, size_t size)
+{
+	int mode_req = 0;
+
+	mode_req = get_mode_idx_from_str(buf, size);
+
+	if (mode_req < 0 || mode_req >= CPPC_MODE_MAX)
+		return -EINVAL;
+
+	if (mode_state_machine[cppc_state][mode_req])
+		return mode_state_machine[cppc_state][mode_req](mode_req);
+	return -EBUSY;
+}
+
+static ssize_t amd_pstate_show_status(char *buf)
+{
+	int i, j = 0;
+
+	for (i = 0; i < CPPC_MODE_MAX; ++i) {
+		if (i == cppc_state)
+			j += sprintf(buf + j, "[%s] ", amd_pstate_mode_string[i]);
+		else
+			j += sprintf(buf + j, "%s ", amd_pstate_mode_string[i]);
+	}
+	j += sprintf(buf + j, "\n");
+	return j;
+}
+
+static ssize_t state_store(struct kobject *kobj,
+		struct kobj_attribute *attr, const char *buf, size_t count)
+{
+	ssize_t ret = 0;
+	char *p = memchr(buf, '\n', count);
+
+	mutex_lock(&amd_pstate_driver_lock);
+	ret = amd_pstate_update_status(buf, p ? p - buf : count);
+	mutex_unlock(&amd_pstate_driver_lock);
+
+	return ret < 0 ? ret : count;
+}
+static ssize_t state_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	int ret;
+
+	mutex_lock(&amd_pstate_driver_lock);
+	ret = amd_pstate_show_status(buf);
+	mutex_unlock(&amd_pstate_driver_lock);
+	return ret;
+}
+
+static struct kobj_attribute state_attr = __ATTR_RW(state);
+static struct attribute *amd_pstate_attrs[] = {
+	&state_attr.attr,
+	NULL,
+};
+
+ATTRIBUTE_GROUPS(amd_pstate);
+
 cpufreq_freq_attr_ro(amd_pstate_max_freq);
 cpufreq_freq_attr_ro(amd_pstate_lowest_nonlinear_freq);
 
@@ -648,6 +770,25 @@ static struct cpufreq_driver amd_pstate_driver = {
 	.attr		= amd_pstate_attr,
 };
 
+static struct kobject *amd_pstate_kobject;
+
+static void __init amd_pstate_sysfs_expose_param(void)
+{
+	int ret = 0;
+
+	amd_pstate_kobject = kobject_create_and_add("amd_pstate",
+		&cpu_subsys.dev_root->kobj);
+
+	if (WARN_ON(!amd_pstate_kobject))
+		return;
+
+	ret = sysfs_create_groups(amd_pstate_kobject, amd_pstate_groups);
+	if (ret) {
+		pr_err("sysfs group creation failed (%d)", ret);
+		return;
+	}
+}
+
 static int __init amd_pstate_init(void)
 {
 	int ret;
@@ -695,6 +836,7 @@ static int __init amd_pstate_init(void)
 	if (ret)
 		pr_err("failed to register amd_pstate_driver with return %d\n",
 		       ret);
+	amd_pstate_sysfs_expose_param();
 
 	return ret;
 }
-- 
2.34.1

