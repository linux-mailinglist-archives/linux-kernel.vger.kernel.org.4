Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAB987330E4
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 14:11:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345246AbjFPMLU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 08:11:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbjFPMLS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 08:11:18 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2044.outbound.protection.outlook.com [40.107.93.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00C2430C6;
        Fri, 16 Jun 2023 05:11:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cmkoNB0j5FwzR9sJX2YTDc9Lm36nMLtdBMctDC1Ob9R1OPJWWTQ67JXKLe0AIOltOYRougC1MOoOY0ZK/D96tWDCYSxQeDPvcVjugA9oczQMPHajYvor6/f8MhoAPX5Rm+q1l49rgi6E8QiUbDT7BCOpC5wDsnz4XMru+m+fIG5Yf3bFh84oWaszYdyzkcum0gcojgNI+QbueoH0EymYYtmvFCEjsOlt58wIg5cnUxZTasv2QBG2Qt8O3iXE/KrgQ0xYajhrj3beH70WqtHgLoJDbvoZ7LhqMJo6TirSW95thuE6IQIp2NkQg8iQv+bmbe+GZKPL8ZjesJel6MsZpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9TERMzjVqf1BUCKOG11qcP7PHls/ICBgjVODltQVQCE=;
 b=MkjIjoQF+YRPaFh1pyrveR3Wx9NQA6e3Y60anQsoWg6yStvcL6cJbVpJMSXjBJMfMYBFJ/xYgpnPanFtjm3Bgq5ZwM2XFiIegn869GyI2cTFGxNt78f5j0aNp/fy71CS6v0a5VbaOiPN+12aL1+aR+0BXbmt+DrQHh3gC44EO1/JFHFVmnNkphSWJ3Ar+OoQZkl9J67LKeOkS+cDu6fQubaV14TERM9xRWCN6yKjrkLteZhnGDPRd8nh2/utj6ImOz8BbpDaZzaUn1l1WbietJlG3Tk66lJVRpMpgnZC+R1rZV74znO8cRDShE2Ala6BIvsIUelijEHWiyagvI/pTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=suse.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9TERMzjVqf1BUCKOG11qcP7PHls/ICBgjVODltQVQCE=;
 b=HdtAGgK2nto+DaAU5tGCJPRqepUDmhhgtEo/9de0OQ+N/OhHY68xtT5KtLBEKAr47TRi3/hji9ScIuHmlyXPO4+nVyjSln+TmjThC6YLSyXCA1gRf+FRqXW8GcXm35tF5FHMtOndCViGDsj8oNQ6NkYs5z542yS4tvcTgI0t6lU=
Received: from BN8PR04CA0043.namprd04.prod.outlook.com (2603:10b6:408:d4::17)
 by SA1PR12MB7344.namprd12.prod.outlook.com (2603:10b6:806:2b7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37; Fri, 16 Jun
 2023 12:11:13 +0000
Received: from BN8NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:d4:cafe::9) by BN8PR04CA0043.outlook.office365.com
 (2603:10b6:408:d4::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.25 via Frontend
 Transport; Fri, 16 Jun 2023 12:11:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT020.mail.protection.outlook.com (10.13.176.223) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.29 via Frontend Transport; Fri, 16 Jun 2023 12:11:12 +0000
Received: from beas.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 16 Jun
 2023 07:10:12 -0500
From:   Wyes Karny <wyes.karny@amd.com>
To:     <trenn@suse.com>, <shuah@kernel.org>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <rafael@kernel.org>, <gautham.shenoy@amd.com>,
        <Mario.Limonciello@amd.com>, <Ray.Huang@amd.com>,
        <Perry.Yuan@amd.com>, Wyes Karny <wyes.karny@amd.com>
Subject: [PATCH v2 3/5] cpupower: Add EPP value change support
Date:   Fri, 16 Jun 2023 12:09:53 +0000
Message-ID: <20230616120953.147676-1-wyes.karny@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230616120620.147643-1-wyes.karny@amd.com>
References: <20230616120620.147643-1-wyes.karny@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT020:EE_|SA1PR12MB7344:EE_
X-MS-Office365-Filtering-Correlation-Id: 0697563b-3836-4cd0-b763-08db6e62c726
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TfktDpHnsJWdVuIaRlzKxflkGzGhpYdk4n+JZXihjwovuwPV7Md6qYzkJrW/qr9gJHHE2H/SA8mL+kbJpqE75W77mDt6C+/MANtCfwj5FZZrzfS+uiBsJ7Ew8Yp+d+VJZKjMKvRG0jnl1yl9hQXXDh5L13N6zTnUhmoNrwqBia7n30xzdAxeLXWzE0RFGX2vu+z17a25fVqItryZw0cIbI/Cv2nFy0Rx1InVGOppUmUGpAEImn7fMQkosbCOLtSh0fR15w7pKAQNy6q6NlQpv8idjzyTg8PM3Kfen/YuHAxUEOVhTcwTUo+pvNQhPUW6tyjCIXKKZ3RWNsC37YqWAPqFoTgRjDNvHU4C4I1wb5aLk6dBwq+BeFv8ml1wR0abqlQGK5OW0FhMRgidlkebcZljou/orBDHi/VwABGYlYlV1lRtLgpJoSj3kXRyr4xDvH89kDO+Hr4n3y3ENXCOHqmjtCA8rOPy77vcd2hGoM55Q0FqeH11bwVe9dKTuCbM80nqQ2uxxwOrRz456PlubLk/f68uj/28ZmdyJv6sKWVCRvsc7+oQZteGOS/3sqEYlcpkE/RDyVxIs0dGMoR26y+at5+6QqWhOod2op+/MQRwwICuhR10wEuaSv83vZRXHECA9Gm/2dmd3Efsp6G8ezFKkD0YcwRuXJNdqm3pQsiRAfXySEa4vGyMLxCg5xIIkU0ZhrMKCa716hZWYRtN3o8GkRSjvN9tXVPP1TklJ4AYMZ3O8jC6sM1hT3jIYh9D2IKpvU6XMOQlwE2aRDKgaA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(136003)(39860400002)(376002)(451199021)(46966006)(40470700004)(36840700001)(186003)(16526019)(36860700001)(336012)(1076003)(83380400001)(4326008)(70206006)(2906002)(70586007)(26005)(82310400005)(47076005)(426003)(2616005)(86362001)(36756003)(40460700003)(356005)(82740400003)(81166007)(7696005)(41300700001)(5660300002)(8936002)(8676002)(316002)(44832011)(40480700001)(54906003)(110136005)(6666004)(478600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2023 12:11:12.9642
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0697563b-3836-4cd0-b763-08db6e62c726
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7344
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
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
index 21f653cd472c..63c3f26ef874 100644
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

