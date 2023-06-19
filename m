Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2470735DBA
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 21:06:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232289AbjFSTGl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 15:06:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231698AbjFSTGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 15:06:39 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2057.outbound.protection.outlook.com [40.107.243.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A906101;
        Mon, 19 Jun 2023 12:06:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TVgpebMkyxGpZKHvZdv7z0kIvxPcKSYMP6YZgG7AOL9olikRtNv/GQzuC1SpTOwP+fPk+6x6vM2HGSZTSWI5MmwKUQ1JjVcX+rFro+gH76939reFwHi4079MfTEKidQ82Tm1lKBwetUbDhoNQom9w599VedEBJpB0RKm5v9WsOnnDCmU2p6ZG2Ie/vLN5h8n4JhqZBc0hP3XusqghXr0LnYDDleDg+W3GlpiO2LZAH653huHvFIu7b9n3VbsM0h2j5rBtL8zrawCtSx3iweGhj2U+RyNrAYhGiyZ+jAqrh07yAqxha6gTUWPSGE3dVXQLLTf6iHOPjQ7y7amzr6tYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VGBYuDo8QdbLUjo7rbf9sUcTMSouuHaPzszn/tX4Fhs=;
 b=dsgYIzkxLpjk69/JT14Q8nH8t9PzG3xCYt1hzji/mFQkjfYvbq1X+IR1jvpaoYP93ckMzobOmxzLuECeKN8yt/+Bsa5zyAfOHIGKpNfICUnYXRsxfjfutwEbEW31/LFMcYtnESjjKoWFrwNRXvqAOOeG/J9jN/1XUiIJbzQTj+58jHj+aRDV6372iCmflV4/nQX7JbLONGIqrOaZjqR+HN1JHaQFF37ilaD89zk6aD3oBLNSzyzOA7A/aRqqHcxFUQPRrqByCwmwuMrdE5XmXDOYOo3KxsYX3zunuNIvBygYbQRJsbEy6AjqWIZiCqCj+MlCbSJTF/AudKWtxMK4EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=suse.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VGBYuDo8QdbLUjo7rbf9sUcTMSouuHaPzszn/tX4Fhs=;
 b=pX8OYU3VYHRWSgMnPV3e5iru4hPSrOI691yK1QIWMLYacXjFhiZpA1NfLV+fJdP+cUukvFqesdxjmSRCFfBLQeh+q5+F+Ro8RD47qhDqTSv6OamMqgRZGSKCkIcxTLF65v1c6NZ41C1hcsbOZtI8F4UmtlGdYL39jQKipeBdX4k=
Received: from DM6PR07CA0055.namprd07.prod.outlook.com (2603:10b6:5:74::32) by
 DM4PR12MB8571.namprd12.prod.outlook.com (2603:10b6:8:187::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6500.36; Mon, 19 Jun 2023 19:06:31 +0000
Received: from DM6NAM11FT091.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:74:cafe::d7) by DM6PR07CA0055.outlook.office365.com
 (2603:10b6:5:74::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37 via Frontend
 Transport; Mon, 19 Jun 2023 19:06:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT091.mail.protection.outlook.com (10.13.173.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.37 via Frontend Transport; Mon, 19 Jun 2023 19:06:30 +0000
Received: from beas.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 19 Jun
 2023 14:06:27 -0500
From:   Wyes Karny <wyes.karny@amd.com>
To:     <trenn@suse.com>, <shuah@kernel.org>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <rafael@kernel.org>, <gautham.shenoy@amd.com>,
        <Mario.Limonciello@amd.com>, <Ray.Huang@amd.com>,
        <Perry.Yuan@amd.com>, Wyes Karny <wyes.karny@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v3 3/5] cpupower: Add EPP value change support
Date:   Mon, 19 Jun 2023 19:05:01 +0000
Message-ID: <20230619190503.4061-4-wyes.karny@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230619190503.4061-1-wyes.karny@amd.com>
References: <20230619190503.4061-1-wyes.karny@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT091:EE_|DM4PR12MB8571:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c39d282-5eac-468a-8b7e-08db70f84aad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3h67hhOZy1FUk9XZUEud82Ub1KnPLbXLRbjbuFuY+472DXaxPiU6jop68tAhmJld35cvBqieJSI3ZMtfc8ZYcF1GLWyJnWNv+tEZAjusf8KT3SN1Yav2ueFRMHVCs+Wi70RcXH2MoM8kguwE2iPLai5xf3S11gXOew8YgJXS+DTHKnDHobnYH8pwpcpMb4B9baLHFP2LTN71PZkiXx+AVKypryalTBuvpqTvwC7+vT5VSh8E9AUuN2x1b+U2I8GlIxlcD/mjlH8W8tbwSp+hzx/mKAJ6O9Zn/MBgZOwMSiiI0xE0Xncst49dBUtJnlW0bHNkEm1ewlvZNNlZF6TeKETp0Gvqu7Nras3OFRrwP4DLChvAj4i16T8UoWMVcqX2eVz2mXrNJvOBjzxCTFT+tPIqfugkpvDlDKXrtnGGgo/Y1B0K6slZF3PL8DBolL2HRBRfMqknXCwNJkuocF4UvCMWd1sFuad7WNEEIcte8ov/+bp5TuNSbV7ktlaDKblGKQcC9QyTPcPcg3eULPwd7MXXFRq7flxQsAx5EoZLZlJl4lCFryQ5K7Z4UYdfDuGXkIA2OYThJ+DFxvjCZKPcKv4OKechM1NtsTw/0EhvCKvNimm+w7dRaPYa1o7zprmmxIcE5zWGQD2O2UdoNfdr8399Y9vD+Ymb4e0c9dSvvfoILQO2YKOZkBInKOZ/D80D/NhStGoe1v0eXjOSjNupBlS24PA1iRtucNngo13roQRBeqTY46F+U5GZaNCNlaS3d9evOEIXu7BcKNK2AKIzEQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(136003)(396003)(39860400002)(451199021)(46966006)(36840700001)(40470700004)(5660300002)(44832011)(8676002)(8936002)(70586007)(82310400005)(4326008)(70206006)(316002)(41300700001)(40480700001)(86362001)(40460700003)(2906002)(36756003)(7696005)(6666004)(336012)(426003)(186003)(16526019)(1076003)(26005)(2616005)(356005)(81166007)(36860700001)(83380400001)(478600001)(54906003)(110136005)(47076005)(82740400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2023 19:06:30.9207
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c39d282-5eac-468a-8b7e-08db70f84aad
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT091.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8571
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

amd_pstate and intel_pstate active mode drivers support energy
performance preference feature. Through this user can convey it's
energy/performance preference to platform. Add this value change
capability to cpupower.

To change the EPP value use below command:
cpupower set --epp performance

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Wyes Karny <wyes.karny@amd.com>
---
 tools/power/cpupower/utils/cpupower-set.c    | 23 +++++++++++++++++++-
 tools/power/cpupower/utils/helpers/helpers.h |  5 +++++
 tools/power/cpupower/utils/helpers/misc.c    | 19 ++++++++++++++++
 3 files changed, 46 insertions(+), 1 deletion(-)

diff --git a/tools/power/cpupower/utils/cpupower-set.c b/tools/power/cpupower/utils/cpupower-set.c
index 180d5ba877e6..a789b123dbd4 100644
--- a/tools/power/cpupower/utils/cpupower-set.c
+++ b/tools/power/cpupower/utils/cpupower-set.c
@@ -18,6 +18,7 @@
 
 static struct option set_opts[] = {
 	{"perf-bias", required_argument, NULL, 'b'},
+	{"epp", required_argument, NULL, 'e'},
 	{ },
 };
 
@@ -37,11 +38,13 @@ int cmd_set(int argc, char **argv)
 	union {
 		struct {
 			int perf_bias:1;
+			int epp:1;
 		};
 		int params;
 	} params;
 	int perf_bias = 0;
 	int ret = 0;
+	char epp[30];
 
 	ret = uname(&uts);
 	if (!ret && (!strcmp(uts.machine, "ppc64le") ||
@@ -55,7 +58,7 @@ int cmd_set(int argc, char **argv)
 
 	params.params = 0;
 	/* parameter parsing */
-	while ((ret = getopt_long(argc, argv, "b:",
+	while ((ret = getopt_long(argc, argv, "b:e:",
 						set_opts, NULL)) != -1) {
 		switch (ret) {
 		case 'b':
@@ -69,6 +72,15 @@ int cmd_set(int argc, char **argv)
 			}
 			params.perf_bias = 1;
 			break;
+		case 'e':
+			if (params.epp)
+				print_wrong_arg_exit();
+			if (sscanf(optarg, "%29s", epp) != 1) {
+				print_wrong_arg_exit();
+				return -EINVAL;
+			}
+			params.epp = 1;
+			break;
 		default:
 			print_wrong_arg_exit();
 		}
@@ -102,6 +114,15 @@ int cmd_set(int argc, char **argv)
 				break;
 			}
 		}
+
+		if (params.epp) {
+			ret = cpupower_set_epp(cpu, epp);
+			if (ret) {
+				fprintf(stderr,
+					"Error setting epp value on CPU %d\n", cpu);
+				break;
+			}
+		}
 	}
 	return ret;
 }
diff --git a/tools/power/cpupower/utils/helpers/helpers.h b/tools/power/cpupower/utils/helpers/helpers.h
index 96e4bede078b..5d998de2d291 100644
--- a/tools/power/cpupower/utils/helpers/helpers.h
+++ b/tools/power/cpupower/utils/helpers/helpers.h
@@ -116,6 +116,8 @@ extern int cpupower_intel_set_perf_bias(unsigned int cpu, unsigned int val);
 extern int cpupower_intel_get_perf_bias(unsigned int cpu);
 extern unsigned long long msr_intel_get_turbo_ratio(unsigned int cpu);
 
+extern int cpupower_set_epp(unsigned int cpu, char *epp);
+
 /* Read/Write msr ****************************/
 
 /* PCI stuff ****************************/
@@ -173,6 +175,9 @@ static inline int cpupower_intel_get_perf_bias(unsigned int cpu)
 static inline unsigned long long msr_intel_get_turbo_ratio(unsigned int cpu)
 { return 0; };
 
+static inline int cpupower_set_epp(unsigned int cpu, char *epp)
+{ return -1; };
+
 /* Read/Write msr ****************************/
 
 static inline int cpufreq_has_boost_support(unsigned int cpu, int *support,
diff --git a/tools/power/cpupower/utils/helpers/misc.c b/tools/power/cpupower/utils/helpers/misc.c
index 0c56fc77f93b..583df38ab13c 100644
--- a/tools/power/cpupower/utils/helpers/misc.c
+++ b/tools/power/cpupower/utils/helpers/misc.c
@@ -87,6 +87,25 @@ int cpupower_intel_set_perf_bias(unsigned int cpu, unsigned int val)
 	return 0;
 }
 
+int cpupower_set_epp(unsigned int cpu, char *epp)
+{
+	char path[SYSFS_PATH_MAX];
+	char linebuf[30] = {};
+
+	snprintf(path, sizeof(path),
+		PATH_TO_CPU "cpu%u/cpufreq/energy_performance_preference", cpu);
+
+	if (!is_valid_path(path))
+		return -1;
+
+	snprintf(linebuf, sizeof(linebuf), "%s", epp);
+
+	if (cpupower_write_sysfs(path, linebuf, 30) <= 0)
+		return -1;
+
+	return 0;
+}
+
 bool cpupower_amd_pstate_enabled(void)
 {
 	char *driver = cpufreq_get_driver(0);
-- 
2.34.1

