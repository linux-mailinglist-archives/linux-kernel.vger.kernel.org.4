Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 620FB72C35C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 13:46:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236915AbjFLLqt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 07:46:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233212AbjFLLqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 07:46:31 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on20624.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe5b::624])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF5EF4210;
        Mon, 12 Jun 2023 04:41:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L0ugB7WKvRebMEpx3s+94brAplwclReg4EsJiQCCdAYqCR9SRC8yKtWOoUpvD+iDSKtOwftDKIeAvVa78e24apmlFFdl8fmgCtVLNYsgPWWbUBOqc0oUCPp7qttZjvOqQs8CPLwBjzQ9Ecz4tCl788hDsc5hlgHudKlutylueNIDCNRVD3qscf8veviB8o3hy55a5oC6w1UKRnKCXZq2dMQ3mmdvgdzA9QONlWfmooRczopZO3I1ZF3/U0rdfLPIatwcFBELbXubOeS6dlwLqm8I9GTUmGFAB3fr77puxi3IHGKOk+MVGq1A/lpKSIiKSOYzH59jxi34zKsr99kyug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S/OfkqtXHGtnTQ41FrSv3qvkmd08vd5RMmzrq1BhSY0=;
 b=C+QVFCF0ZdQ+/aZjaujXpHIjXAAbpyAv/U+jxZW0q+GYN1VAc4g2VwS6WRGAfENfIsqQtRMGUzhRsM9aHtYPKYkrHP3SuKUB9N8N56d25tTlK01rPYjobV8xx2mMLVmuH5qJ9JrqYVaDyOVxBPtV3d+ERSiFMv5fodrJv4/aiwNsGkY0P7eh3ghjD5BvXixX4nwzxF4cCvh13Yhkd3gtLNm9jv2HGWQvQwlyBhgmmGDR7CIz5RjhodW8Pt8+swCoYrQVYwU5DYtHIPJGShXfb/wpIQytJj5bBBMk2D6oZRSTVFjy07Kenp2ozPZmDyHUZ8JMJsoNr7A6orhyr6sQ0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S/OfkqtXHGtnTQ41FrSv3qvkmd08vd5RMmzrq1BhSY0=;
 b=uPBxP9rWT5bG6JFNQflLk1ZEFule1JVJ38G7TkumLyKVNSf4sStnzosgot46ascrUUl0yf84wJ4C4+DY4mXYnq7/ukbTI+YEGB9WvmLH5j1xryh6dbk1X/i0wXnPSD8cMrzzWqyZ1DVZpyIcSdaHcBECQOli47fp7PhQ1pQ51M0=
Received: from BN7PR06CA0046.namprd06.prod.outlook.com (2603:10b6:408:34::23)
 by CO6PR12MB5443.namprd12.prod.outlook.com (2603:10b6:303:13a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.46; Mon, 12 Jun
 2023 11:39:26 +0000
Received: from BN8NAM11FT079.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:34:cafe::1b) by BN7PR06CA0046.outlook.office365.com
 (2603:10b6:408:34::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.34 via Frontend
 Transport; Mon, 12 Jun 2023 11:39:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT079.mail.protection.outlook.com (10.13.177.61) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6477.29 via Frontend Transport; Mon, 12 Jun 2023 11:39:25 +0000
Received: from beas.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 12 Jun
 2023 06:39:22 -0500
From:   Wyes Karny <wyes.karny@amd.com>
To:     <rafael@kernel.org>, <ray.huang@amd.com>,
        <viresh.kumar@linaro.org>, <trenn@suse.com>, <shuah@kernel.org>
CC:     <gautham.shenoy@amd.com>, <Mario.Limonciello@amd.com>,
        <Perry.Yuan@amd.com>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Wyes Karny <wyes.karny@amd.com>
Subject: [PATCH 6/6] cpupower: Add turbo-boost support in cpupower
Date:   Mon, 12 Jun 2023 11:36:15 +0000
Message-ID: <20230612113615.205353-7-wyes.karny@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT079:EE_|CO6PR12MB5443:EE_
X-MS-Office365-Filtering-Correlation-Id: 7728e7c0-0bf4-4f0f-2cb1-08db6b39acd5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9dYneIIAK8dfcz+p24E0U2eseAkQuJG0CuSGYal+CKCd2sOtFFtHLnZJrDXGh/b3cE5qnSSZuMDIkXPMYhsbdgrucdVdCWb+tyVqkZd7/sGQt5ivyWmeWnr3DDt5wR7Tehwr2BtdepoaOzYKHtTCTV749/VZGEiY/ugQkYXGhb42Dfw9d6rDDj26luf1itE0642okP7K4BjU2TZSP5n1D/3eZDuA0FqfNGWM9H+YjtuY2nYemgE4YmOiFR9fEHf4IkxR9GSKHjx2KS9qdcZqnFvjoWWTfMeWZs2j3MeDPzXa56Ld8057Pr9lq14ouTqjNGiPNBPOe0iaJM1HTcjFkGLItkWmSEM6wmsKVxntnhCnLZ0I/SVPSQIbbqkyEMusKjqJeXFZTwEJGhK/ia0VtaxbEn198zqmNo5oT3dj0LQN2mMvCA5leK4IRXBi54alS5AMNcAjqV9q1a4VSZ3Y1dZeJGKqhZU3QxzCX8byEsCHWlcpSdmJApq+ff3y46ZsPbaD3E4eEHePxE/gxQqdPS7D9kkkEO6mYBk/DY1QkWU53QSX/BAtt1nUtreAixt60eZLYBYIGRgn4ezjR5vS/F0+QZ/sX6xfezeIaL93/R+ktU3ZtgeWwtN/G1CB8bDQY8Um5MqdYaloU2sl6Q6rXcoD9EAgEGg5/n1l1/VWMO8Lf+U017sn8wuFM+4sTeOvquIj7X4VBdU7+yijGa3rDyEaEwpUwYzf/AXehaPflAzA+uiZ1KolKe1GLfT3ylSEUSRtZS4czmmGAghijLXe9oqoEs0grA29PTfaLmgk+/E=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(39860400002)(396003)(376002)(451199021)(46966006)(36840700001)(40470700004)(44832011)(4326008)(70586007)(70206006)(41300700001)(316002)(5660300002)(110136005)(54906003)(8676002)(8936002)(2906002)(6666004)(40460700003)(478600001)(7696005)(82740400003)(40480700001)(1076003)(26005)(16526019)(186003)(426003)(2616005)(336012)(83380400001)(36860700001)(47076005)(356005)(81166007)(36756003)(86362001)(82310400005)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2023 11:39:25.9548
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7728e7c0-0bf4-4f0f-2cb1-08db6b39acd5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT079.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5443
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
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

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
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
index 9df9af8a969e..fc822a0e6b7b 100644
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

