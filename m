Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5084172C357
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 13:46:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231993AbjFLLqC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 07:46:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234148AbjFLLom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 07:44:42 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2046.outbound.protection.outlook.com [40.107.95.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 775035FDD;
        Mon, 12 Jun 2023 04:39:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QP+UUTi5UMQOqTLnDmcOKx3tyUTxJJXNAl9ym0639QAsLj1Xs5VvY29+C0xfFtfDZodPjDE2AbcwOO1LsfThjz7d6Mex1rzl59pbVAWBl+s5m5Tb7kXUO1Gzxgv9w6a00x2vXpC7gFhQWKbPC2K8giH98SbYURatFbtGs4hSAUzMpHpd58DNHsE1UG40N03CBFiP/xdRldZhsFiblY+vsziEqrwhKjc/IpBWyAV59UYJ4LeyTxqhqLaZRUHeKMoQ8tymEmc2dKW63rmT5+l/Pn+lpkX964ZjdqCCIUA5tAr5z4cLL6OiK21ppnk/isT4mWmwFbt/WaDSIz6YdZTbcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9TERMzjVqf1BUCKOG11qcP7PHls/ICBgjVODltQVQCE=;
 b=LHbZd3cysZPSE6ynNozHpobiMgNIdvKhw9Uw9EV6hwSLptpqqSomh81ayQN2fW55tP8g7CH6+7eTMf740pTAlrlN7m3KSmFgKc8ymmovPZf5EPZLNxDXi0l4eBJZgBH4j5l/YvX0gjv7NIHMQOxMeWD3qEQo+Hu56SiwVflr+jwAvLIy4mCgXGsWghTx2e0uMQRkgi8p+CZtrsF/f4sdPccN6PJc+9V5L0mI858Ya/UlKj0FkPpi271YV3M6uxWS4urszihpnf8vFVx0qBShGO/JGQ/4uV1tAWN44d1s3IhY4yPY6gKQNqBFEzu9isfneWqmPIWHtBuoalL9vRUPwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9TERMzjVqf1BUCKOG11qcP7PHls/ICBgjVODltQVQCE=;
 b=arMEY1yv788G/+/34OGdvSuekzQPOoBkVeyXCLspp63tNI0oH7/6wu1BcZwpxiaMy2X11iM7kdL+fa8/HLKK79Erdw4D3e76JnxiwgQyWILmWUXgCIIzTN6TlsxF4SzJXmIPUMRoxMalqq3+n4K8meQ6yNzF7DCzAV7dd8FcvoQ=
Received: from BN9PR03CA0110.namprd03.prod.outlook.com (2603:10b6:408:fd::25)
 by IA0PR12MB8896.namprd12.prod.outlook.com (2603:10b6:208:493::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Mon, 12 Jun
 2023 11:38:28 +0000
Received: from BN8NAM11FT098.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fd:cafe::db) by BN9PR03CA0110.outlook.office365.com
 (2603:10b6:408:fd::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.34 via Frontend
 Transport; Mon, 12 Jun 2023 11:38:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT098.mail.protection.outlook.com (10.13.177.196) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.21 via Frontend Transport; Mon, 12 Jun 2023 11:38:28 +0000
Received: from beas.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 12 Jun
 2023 06:38:25 -0500
From:   Wyes Karny <wyes.karny@amd.com>
To:     <rafael@kernel.org>, <ray.huang@amd.com>,
        <viresh.kumar@linaro.org>, <trenn@suse.com>, <shuah@kernel.org>
CC:     <gautham.shenoy@amd.com>, <Mario.Limonciello@amd.com>,
        <Perry.Yuan@amd.com>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Wyes Karny <wyes.karny@amd.com>
Subject: [PATCH 4/6] cpupower: Add EPP value change support
Date:   Mon, 12 Jun 2023 11:36:13 +0000
Message-ID: <20230612113615.205353-5-wyes.karny@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT098:EE_|IA0PR12MB8896:EE_
X-MS-Office365-Filtering-Correlation-Id: e50bde08-921a-46c3-d80f-08db6b398aae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bxl6wRZ4k5SHIGPUtEIBybX3wVOnuKj9oksd5IXmLCEg8cshU6lL3ytok6aMiTp0RmmKWMGm0sybbOPOUE6jSZim8BqtjMW0gobO7abdc5wqzTFU7eKX7rfiMvrd6j2lTzATcyUZFVkgsin1sVj1lodmCGALm0JLY11xgqWplVpblk9hSwm2iMtMv4zlo2PLtgnPRCjhkVUHgl/+RAZDE0Ome5iwJPKqRdkt2RAyRXPDWfcNGSv7HUiqa1KnI6APBx5quIQehrg+0WqaPbO8oqWlda+nd9Z4b7U+k8VCF0V073T++4BVEwXqdfH+NC/0C3e0tvHPxEIjFqGqzoiWnBPF0M48SwGOiF8jHKdw9zeMS9F2OXu9kviS/8kZ7Flo9Zmp6LSG4z/ijQiT0O8PXQ4IHnrJVJ9ZxIlnNTW/YM178IxQh2veOJqO5rJS24gd40hkPTC/17zKzz03f5q838nDQIRoG68FObMTWG9P2IeE8ePYNhTad5MAghaPz/gCpllteL8LwBxGHvV81FpxQHDokesq9NCJOtPC9HLioXzQR/zy+M32hAnm5EmqL+qhAo4KaFxbdvZGqZMZ0K8OCQcxf/9EdhjLSo5I/UvqLlGzUS1aBx0p8PVOzSTo18ggSi2ID0Af4OK6cS/bhJeok83owp7uYe4o/JEWwTSz4kvh8p3bg3wDsM3gWWToJx5vvQe/L2oU5LxV0EirQMwqaNULYWy2wYgKhyhk4wQ9mhsapzQN/DJbDcV+FojiCceQPvwMyi/ix40EK6GRikByoXUpPGyrSwbBqQwrmoMzVoM=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(136003)(346002)(376002)(451199021)(40470700004)(36840700001)(46966006)(83380400001)(40460700003)(336012)(426003)(47076005)(2906002)(2616005)(40480700001)(36860700001)(36756003)(86362001)(82310400005)(82740400003)(81166007)(356005)(316002)(41300700001)(5660300002)(6666004)(8936002)(186003)(8676002)(7696005)(478600001)(110136005)(54906003)(70206006)(4326008)(70586007)(26005)(16526019)(1076003)(44832011)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2023 11:38:28.6766
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e50bde08-921a-46c3-d80f-08db6b398aae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT098.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8896
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

