Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B23272C358
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 13:46:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234542AbjFLLqF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 07:46:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238738AbjFLLpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 07:45:09 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on20622.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e83::622])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FD6C6591;
        Mon, 12 Jun 2023 04:39:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jJGZPzmL7NwoiOETrFhQKjnjgBkFP+/ESbliz30W3to4g8xMuJmiLSyDFfVt3VVvlqAsEmiqXnplyPDRErDaMljUxO9kd0f+MW+ku05Eq/iuHbNPS7wMtCPcvqvkVrTLmvphcHP3iMVr4PDUmveuKXIXgtXhY10pgRs2AKVzdjF9qjggIaR1sd4kaMJJqVymO3U7DQ1D9Q458CE/mxaM0EjR73KqwnrGEkWNpk2YCP2ON8IHsmC+X+uguBXc5+UuppaVwKiAQ2FNO/eDS+hGCAuzhpL8tHczykMu5n86sVhK/vC0OjJNhxDI42sG0plXP1nHbE1feiaLXdYhRUPC8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZyPTI9OCW2bMoA0WggyKjaLJ33NMPH+RNdjMWE3lWx4=;
 b=ElLdsnteCdGJImGu6O3+XDEXeDss56QqHI7CwOCtESYwPCimZ9sA3fqCSmET3ReSwQG3Sw6PY3C7ONJaRw+b9E53mExzSmAQGitW3IKXza6Sj/SP3tMSadPNdb22pWYxJNZ1osSBNdgtaM+EkefXuEDm0+On4PPOUL4uyRld1zMHFIFnu9fY9Bsh1Oox1NVUkZl1s0CwiOE6as/dRbpzc4DDQoigU+M8O3wjJz3aNN/TirqBsRWYdn6kliz14qrusWkZCqfbW1PnTcAsC0PljY6My7aa/qf30ZD13xSUw5wtdiNhVburTsn/zIgY4YOh7FB2oHjNdsKndt534S/s+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZyPTI9OCW2bMoA0WggyKjaLJ33NMPH+RNdjMWE3lWx4=;
 b=n/nUTaykKUIllTc5WwAiDr/vWWZySpeiwzrfLCqfhZeTB6GWC1o/zM4OiG1tS7KAk5cZbCzk8v2AD0yhc9MHzyCiKmcP9vvUmfU7r28nNKbJv1uOwcLhI6VOFPzTK9lBrpiG1kTL5/3C05kw9o58dt6xi36QmwZ2J2eBp4fNu5o=
Received: from BN9PR03CA0032.namprd03.prod.outlook.com (2603:10b6:408:fb::7)
 by PH7PR12MB6740.namprd12.prod.outlook.com (2603:10b6:510:1ab::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.44; Mon, 12 Jun
 2023 11:38:56 +0000
Received: from BN8NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fb:cafe::be) by BN9PR03CA0032.outlook.office365.com
 (2603:10b6:408:fb::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.33 via Frontend
 Transport; Mon, 12 Jun 2023 11:38:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT024.mail.protection.outlook.com (10.13.177.38) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.21 via Frontend Transport; Mon, 12 Jun 2023 11:38:56 +0000
Received: from beas.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 12 Jun
 2023 06:38:52 -0500
From:   Wyes Karny <wyes.karny@amd.com>
To:     <rafael@kernel.org>, <ray.huang@amd.com>,
        <viresh.kumar@linaro.org>, <trenn@suse.com>, <shuah@kernel.org>
CC:     <gautham.shenoy@amd.com>, <Mario.Limonciello@amd.com>,
        <Perry.Yuan@amd.com>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Wyes Karny <wyes.karny@amd.com>
Subject: [PATCH 5/6] cpupower: Add support for amd_pstate mode change
Date:   Mon, 12 Jun 2023 11:36:14 +0000
Message-ID: <20230612113615.205353-6-wyes.karny@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230612113615.205353-1-wyes.karny@amd.com>
References: <20230612113615.205353-1-wyes.karny@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT024:EE_|PH7PR12MB6740:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f882063-9418-4a50-f0e6-08db6b399b47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TtnfbBegS0ONiub/WQrW2GyJo5UWF88gqrejCAYRgFgISTavoNrqbRdhb/sj+k3iCxEMT4gQcJrzD/KYyQ60E2D0UI11fpHUiBtKyk8cWQsgd43EFEV/Z4HJJ73O3qLtIsWG4EB/Pkj2yA1tsDTLmSNOfCyTtmJroht6BjD8jfCbgV2ve1/iY7i4vZ55B6xsfg0VtzSkcOJMdg/jzem2kWnspNIXze1jee9mEDe/0Feuw1jqClZKKx2PW2S7BHuSwm8gRsWit5kCmH9jk9PB3vcchns0mPdLv/NHyESHP7yprjprFwEO+tJ4dQH4me7DvH24EVemQrjOnYkd4LBkxcmO2ZjPK1y/krwsS44+yOfKgJewAPOyK8UnhzZ7N0ru4ZgI0RgsMcRPjPg1tsloJLUMOq7ZE1/I56AF6doF9bGR6/EterHoCX6KzJ4usQvLUZ4d4yV8N8EYpXebmNH/JsZFLlJFDCIXkAOYtKxYPjObYpi3EENrScvVuc33xiiGQ0+0IyYsP1GmCOrYmyNEnC8eQa/tuTrk2O8hVn9dUFLVhTCOW7mbYnt4KrqBd7IKbXtQ1B53RjUF3hyJRLl9xK8P1a8GSx3v+mKkXyLWZOB1jOVch9lZXi7fM95VpeucsyU45ooA/n2TJdEZGqBBZtkaHKe9Z7XxT0AM1vaHhAqnseE2MrjYoJ/F3zdlBjCPLCIAjVrMFFZW5sH+W0s++5ZWM+tuws403wHaaQVaGaYlauBOh+guo/4AvaebSOsmfgpFbg4D26AX4w30kKGfwmJNVgZv8rr0TWKSyWtBW+M=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(396003)(376002)(346002)(451199021)(40470700004)(36840700001)(46966006)(40460700003)(7696005)(6666004)(47076005)(36756003)(426003)(336012)(83380400001)(2616005)(86362001)(82310400005)(82740400003)(356005)(81166007)(1076003)(26005)(40480700001)(36860700001)(186003)(16526019)(2906002)(110136005)(54906003)(316002)(4326008)(44832011)(70586007)(70206006)(41300700001)(5660300002)(478600001)(8936002)(8676002)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2023 11:38:56.5079
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f882063-9418-4a50-f0e6-08db6b399b47
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT024.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6740
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

amd_pstate supports changing of its mode dynamically via `status` sysfs
file. Add the same capability in cpupower. To change the mode to active
mode use below command:

cpupower set --amd-pstate-mode active

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Signed-off-by: Wyes Karny <wyes.karny@amd.com>
---
 tools/power/cpupower/utils/cpupower-set.c    | 24 ++++++++++++++++++--
 tools/power/cpupower/utils/helpers/helpers.h |  3 +++
 tools/power/cpupower/utils/helpers/misc.c    | 18 +++++++++++++++
 3 files changed, 43 insertions(+), 2 deletions(-)

diff --git a/tools/power/cpupower/utils/cpupower-set.c b/tools/power/cpupower/utils/cpupower-set.c
index a789b123dbd4..c2ba69b7ea54 100644
--- a/tools/power/cpupower/utils/cpupower-set.c
+++ b/tools/power/cpupower/utils/cpupower-set.c
@@ -19,6 +19,7 @@
 static struct option set_opts[] = {
 	{"perf-bias", required_argument, NULL, 'b'},
 	{"epp", required_argument, NULL, 'e'},
+	{"amd-pstate-mode", required_argument, NULL, 'm'},
 	{ },
 };
 
@@ -39,12 +40,13 @@ int cmd_set(int argc, char **argv)
 		struct {
 			int perf_bias:1;
 			int epp:1;
+			int mode:1;
 		};
 		int params;
 	} params;
 	int perf_bias = 0;
 	int ret = 0;
-	char epp[30];
+	char epp[30], mode[20];
 
 	ret = uname(&uts);
 	if (!ret && (!strcmp(uts.machine, "ppc64le") ||
@@ -58,7 +60,7 @@ int cmd_set(int argc, char **argv)
 
 	params.params = 0;
 	/* parameter parsing */
-	while ((ret = getopt_long(argc, argv, "b:e:",
+	while ((ret = getopt_long(argc, argv, "b:e:m:",
 						set_opts, NULL)) != -1) {
 		switch (ret) {
 		case 'b':
@@ -81,6 +83,17 @@ int cmd_set(int argc, char **argv)
 			}
 			params.epp = 1;
 			break;
+		case 'm':
+			if (cpupower_cpu_info.vendor != X86_VENDOR_AMD)
+				print_wrong_arg_exit();
+			if (params.mode)
+				print_wrong_arg_exit();
+			if (sscanf(optarg, "%19s", mode) != 1) {
+				print_wrong_arg_exit();
+				return -EINVAL;
+			}
+			params.mode = 1;
+			break;
 		default:
 			print_wrong_arg_exit();
 		}
@@ -89,6 +102,12 @@ int cmd_set(int argc, char **argv)
 	if (!params.params)
 		print_wrong_arg_exit();
 
+	if (params.mode) {
+		ret = cpupower_set_amd_pstate_mode(mode);
+		if (ret)
+			fprintf(stderr, "Error setting mode\n");
+	}
+
 	/* Default is: set all CPUs */
 	if (bitmask_isallclear(cpus_chosen))
 		bitmask_setall(cpus_chosen);
@@ -123,6 +142,7 @@ int cmd_set(int argc, char **argv)
 				break;
 			}
 		}
+
 	}
 	return ret;
 }
diff --git a/tools/power/cpupower/utils/helpers/helpers.h b/tools/power/cpupower/utils/helpers/helpers.h
index 5d998de2d291..d35596631eef 100644
--- a/tools/power/cpupower/utils/helpers/helpers.h
+++ b/tools/power/cpupower/utils/helpers/helpers.h
@@ -117,6 +117,7 @@ extern int cpupower_intel_get_perf_bias(unsigned int cpu);
 extern unsigned long long msr_intel_get_turbo_ratio(unsigned int cpu);
 
 extern int cpupower_set_epp(unsigned int cpu, char *epp);
+extern int cpupower_set_amd_pstate_mode(char *mode);
 
 /* Read/Write msr ****************************/
 
@@ -177,6 +178,8 @@ static inline unsigned long long msr_intel_get_turbo_ratio(unsigned int cpu)
 
 static inline int cpupower_set_epp(unsigned int cpu, char *epp)
 { return -1; };
+static inline int cpupower_set_amd_pstate_mode(char *mode)
+{ return -1; };
 
 /* Read/Write msr ****************************/
 
diff --git a/tools/power/cpupower/utils/helpers/misc.c b/tools/power/cpupower/utils/helpers/misc.c
index 63c3f26ef874..9df9af8a969e 100644
--- a/tools/power/cpupower/utils/helpers/misc.c
+++ b/tools/power/cpupower/utils/helpers/misc.c
@@ -106,6 +106,24 @@ int cpupower_set_epp(unsigned int cpu, char *epp)
 	return 0;
 }
 
+int cpupower_set_amd_pstate_mode(char *mode)
+{
+	char path[SYSFS_PATH_MAX];
+	char linebuf[20] = {};
+
+	snprintf(path, sizeof(path), PATH_TO_CPU "amd_pstate/status");
+
+	if (!is_valid_path(path))
+		return -1;
+
+	snprintf(linebuf, sizeof(linebuf), "%s\n", mode);
+
+	if (cpupower_write_sysfs(path, linebuf, 20) <= 0)
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

