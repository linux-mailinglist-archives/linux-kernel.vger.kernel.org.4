Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B474735DBE
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 21:07:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231322AbjFSTHq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 15:07:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbjFSTHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 15:07:43 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2082.outbound.protection.outlook.com [40.107.220.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 582581AE;
        Mon, 19 Jun 2023 12:07:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YQwJjY7ivxr5l0LR+o+JA+V2LoYqpXMEqM1Tw4G2XeYFmrIgt8jD/ejWnp4gt4oYmuB9dPE4SHqcc1beEE2mEctPBox/2zXsB+mi66OpUasV/w5LssJxKaTM4XJZ3osrobC9HgEdmsdpl2VFef5cH6EDEQD+CNV2dgtFUP6VLtgFKDta0Uc4bgM2q8hqP17Gq0It1y2AxWId93kDpejd+3Hc5YXRlJZGR3F6QIJ1uE7FSkml1eA7wf0BUedIdA2lmMRn0COfbfKhTc4h3Dzgn1rtgeLoH7GcHSSj4BA5EyjfBFfVgFi2iixrwFmdJUrXQKU2weaQGyoNK4ZJJAShag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lb61VrCRar2xVQyym63bNwofAPs7QOgKWrlNAW+Nw9k=;
 b=kkN/CR9H7ha40dlzJPnhKpgs0SbQjhEDfiEZmePFj/KJaTOJ9QSehKXu4HJ6wGu3E+ZQHawlzSGyvG7vjoPSQIpHTAEnP0jQrtLKHEu5huFPYRl5qBRTTMur+2jk+VM4HuyYeXtTgDvkv/OWyhvHg6lIh7N+g4FZ1S7oM3dqp+PrVENPmAGCX7xYYwCtNOt+t15jLkrKJgCrKjsypQ72QTDGayH9jiQCzttjc05tX1EVDdZYgA1Z3mIFVAnpcQxZP+g9Y1nCfb29wC6OLN3fiCklsUUn1X7BaJY6OHLh5cVgG6eulgFOzZytQ4/1DT0r9mXe4jyQTHyeVitx+w1/5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=suse.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lb61VrCRar2xVQyym63bNwofAPs7QOgKWrlNAW+Nw9k=;
 b=tchLXv/gWgjmaQBKpATu1SwGBsP4QKsRNTIatXJYMFnqB4vdHsCbrwXPbTrtxECwW72p5eKKX4rLxruJr09z7syniYqi58FgVtidNr66NoJJg3sXllEfp4qmc+L8IqWXy0oZcLipgvRstv+CZgyo5hR2YwMGLdPxAgnk0UCVArA=
Received: from DM6PR06CA0064.namprd06.prod.outlook.com (2603:10b6:5:54::41) by
 DS0PR12MB7746.namprd12.prod.outlook.com (2603:10b6:8:135::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6500.36; Mon, 19 Jun 2023 19:07:37 +0000
Received: from DM6NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:54:cafe::cc) by DM6PR06CA0064.outlook.office365.com
 (2603:10b6:5:54::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37 via Frontend
 Transport; Mon, 19 Jun 2023 19:07:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT046.mail.protection.outlook.com (10.13.172.121) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.35 via Frontend Transport; Mon, 19 Jun 2023 19:07:37 +0000
Received: from beas.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 19 Jun
 2023 14:07:33 -0500
From:   Wyes Karny <wyes.karny@amd.com>
To:     <trenn@suse.com>, <shuah@kernel.org>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <rafael@kernel.org>, <gautham.shenoy@amd.com>,
        <Mario.Limonciello@amd.com>, <Ray.Huang@amd.com>,
        <Perry.Yuan@amd.com>, Wyes Karny <wyes.karny@amd.com>,
        Huang Rui <ray.huang@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v3 5/5] cpupower: Add turbo-boost support in cpupower
Date:   Mon, 19 Jun 2023 19:05:03 +0000
Message-ID: <20230619190503.4061-6-wyes.karny@amd.com>
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
X-MS-TrafficTypeDiagnostic: DM6NAM11FT046:EE_|DS0PR12MB7746:EE_
X-MS-Office365-Filtering-Correlation-Id: 20071c42-e5fa-46b6-5449-08db70f87265
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fv+Z5rPbRVpjddwQat3RmQ96VbcK8rxTov9jdfsG2JNBJavd9lInDx3UAcGQ9tINJwAfdIUb66I81GAKPe1ixcQg/7TCAodMU28c2RWowy+RacRLYAB9iQEC9dwWpIstOik55VppFKgDi6T3K8aiMXw5roNBw5p6e/0/1y1k5XrduV45UqZGp459DnFf9tGtwaqBqLdbbQXZAZHig8D8pbiO8NSmHk5nQuXx+mNtDEGb0xuBBsU4l1kazem8EhdA8u98rLMuyI3tlH1eb8xfMJhrvrPlGS92tFflmo9i5frPjTTNbpIdTj0g/lN7i19BigmVf19fOtiu3IMb7HD/tRlJldjNxv9dKFF4X/zXcnJ8I4HkGI8GSQfmmnbU0c640YwVQp7fg1W6ZKd9Lt3BEj/mT4UztpctszggpKz1+tfEgP/ghTHSBeyu6lS3dB5rbItnWOeQZRIvxo4eMuWs4opuvPMC1NJrM7b1yuhqGflawCpARaqhezW5NCkrhCkvi+JarS6bc59XnZCAJbDuSkfBoib2kS9b+5AX22EwYV3Io8d8KXxOx307fezBZ+3PjdNeux3EjdKDe28wsC3T2ehoAT5QJi9fYwZXyBD6/dr3YjwqZNEWujX11TJK+2bvrPyZ7S7Pn6EdF5992GkrfmlzFkESzSPaevpUZxxAOHSA6L85tQy6O7wEsnAVU1kduvyKZsg5zWagKGO1TidulKMkytq7rrkC+ZK/Yvz9GI/Qrqwtlm9kvoKp0CahuMPTXQSrm2aVWCPpMbz+Sn8B/Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(346002)(376002)(39860400002)(451199021)(46966006)(36840700001)(40470700004)(41300700001)(5660300002)(44832011)(8936002)(8676002)(2906002)(40460700003)(82310400005)(36756003)(40480700001)(86362001)(1076003)(26005)(54906003)(186003)(110136005)(478600001)(16526019)(7696005)(6666004)(81166007)(70586007)(70206006)(356005)(47076005)(36860700001)(4326008)(316002)(336012)(426003)(2616005)(82740400003)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2023 19:07:37.5719
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 20071c42-e5fa-46b6-5449-08db70f87265
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7746
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If boost sysfs (/sys/devices/system/cpu/cpufreq/boost) file is present
turbo-boost is feature is supported in the hardware. By default this
feature should be enabled. But to disable/enable it write to the sysfs
file. Use the same to control this feature via cpupower.

To enable:
cpupower set --turbo-boost 1

To disable:
cpupower set --turbo-boost 0

Acked-by: Huang Rui <ray.huang@amd.com>
Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Wyes Karny <wyes.karny@amd.com>
---
 tools/power/cpupower/utils/cpupower-set.c    | 22 +++++++++++++++++++-
 tools/power/cpupower/utils/helpers/helpers.h |  3 +++
 tools/power/cpupower/utils/helpers/misc.c    | 18 ++++++++++++++++
 3 files changed, 42 insertions(+), 1 deletion(-)

diff --git a/tools/power/cpupower/utils/cpupower-set.c b/tools/power/cpupower/utils/cpupower-set.c
index c2ba69b7ea54..0677b58374ab 100644
--- a/tools/power/cpupower/utils/cpupower-set.c
+++ b/tools/power/cpupower/utils/cpupower-set.c
@@ -20,6 +20,7 @@ static struct option set_opts[] = {
 	{"perf-bias", required_argument, NULL, 'b'},
 	{"epp", required_argument, NULL, 'e'},
 	{"amd-pstate-mode", required_argument, NULL, 'm'},
+	{"turbo-boost", required_argument, NULL, 't'},
 	{ },
 };
 
@@ -41,10 +42,11 @@ int cmd_set(int argc, char **argv)
 			int perf_bias:1;
 			int epp:1;
 			int mode:1;
+			int turbo_boost:1;
 		};
 		int params;
 	} params;
-	int perf_bias = 0;
+	int perf_bias = 0, turbo_boost = 1;
 	int ret = 0;
 	char epp[30], mode[20];
 
@@ -94,6 +96,18 @@ int cmd_set(int argc, char **argv)
 			}
 			params.mode = 1;
 			break;
+		case 't':
+			if (params.turbo_boost)
+				print_wrong_arg_exit();
+			turbo_boost = atoi(optarg);
+			if (turbo_boost < 0 || turbo_boost > 1) {
+				printf("--turbo-boost param out of range [0-1]\n");
+				print_wrong_arg_exit();
+			}
+			params.turbo_boost = 1;
+			break;
+
+
 		default:
 			print_wrong_arg_exit();
 		}
@@ -108,6 +122,12 @@ int cmd_set(int argc, char **argv)
 			fprintf(stderr, "Error setting mode\n");
 	}
 
+	if (params.turbo_boost) {
+		ret = cpupower_set_turbo_boost(turbo_boost);
+		if (ret)
+			fprintf(stderr, "Error setting turbo-boost\n");
+	}
+
 	/* Default is: set all CPUs */
 	if (bitmask_isallclear(cpus_chosen))
 		bitmask_setall(cpus_chosen);
diff --git a/tools/power/cpupower/utils/helpers/helpers.h b/tools/power/cpupower/utils/helpers/helpers.h
index d35596631eef..95749b8ee475 100644
--- a/tools/power/cpupower/utils/helpers/helpers.h
+++ b/tools/power/cpupower/utils/helpers/helpers.h
@@ -118,6 +118,7 @@ extern unsigned long long msr_intel_get_turbo_ratio(unsigned int cpu);
 
 extern int cpupower_set_epp(unsigned int cpu, char *epp);
 extern int cpupower_set_amd_pstate_mode(char *mode);
+extern int cpupower_set_turbo_boost(int turbo_boost);
 
 /* Read/Write msr ****************************/
 
@@ -180,6 +181,8 @@ static inline int cpupower_set_epp(unsigned int cpu, char *epp)
 { return -1; };
 static inline int cpupower_set_amd_pstate_mode(char *mode)
 { return -1; };
+static inline int cpupower_set_turbo_boost(int turbo_boost)
+{ return -1; };
 
 /* Read/Write msr ****************************/
 
diff --git a/tools/power/cpupower/utils/helpers/misc.c b/tools/power/cpupower/utils/helpers/misc.c
index 075c136a100c..76e461ff4f74 100644
--- a/tools/power/cpupower/utils/helpers/misc.c
+++ b/tools/power/cpupower/utils/helpers/misc.c
@@ -124,6 +124,24 @@ int cpupower_set_amd_pstate_mode(char *mode)
 	return 0;
 }
 
+int cpupower_set_turbo_boost(int turbo_boost)
+{
+	char path[SYSFS_PATH_MAX];
+	char linebuf[2] = {};
+
+	snprintf(path, sizeof(path), PATH_TO_CPU "cpufreq/boost");
+
+	if (!is_valid_path(path))
+		return -1;
+
+	snprintf(linebuf, sizeof(linebuf), "%d", turbo_boost);
+
+	if (cpupower_write_sysfs(path, linebuf, 2) <= 0)
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

