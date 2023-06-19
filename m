Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24DAD735DBC
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 21:07:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231739AbjFSTHQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 15:07:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231247AbjFSTHO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 15:07:14 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2085.outbound.protection.outlook.com [40.107.95.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 314B2B7;
        Mon, 19 Jun 2023 12:07:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B9N3oYt8/a4HuHmpYr6hjFHI5HAYgSdZmlX1pRPkQcfyFWZlnpCTYJURcUr/QjTZs5hzqlqrjnItgXDvVkcbNFpD7O2w32FU718Aeuds0Cl3B34wxuL67AmN2O1N47jvgo2cGlPjYbk09EJ4KASZoxbMRzCiJi0mpi7WyUnHBFDy6XgjVPomIZDK/XpwKIf97gXYV3qPBupcD2C9dxVuN4fCNdr4Wzwtoa8fy4omh2eHmZSio7mLOkjCRYVghV+DgRVZGMklCWID4rnKTfVkKj0I5lLYvV0ASAcR7V9y5T6fP12efrBvC/e1mFbya10kWgD7U/Uf0tuwtaYVmg0xjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k97+rv59nQ+x+6738TZ/YVw5sNsK1eeN0TXOGfd8xic=;
 b=By0WV96gOxQl0xRWjVueBr+cdB0KLX0cKo3o6p47c4byWLF8ouTSJ2BRW/uFEheFGzDbkMnPXELwdHagzbZzsQ6AxfBxVo07MekYfH0k3SXdYQRoNpmP4saC7ZZk/fWPP+p3NBL+A/HPXsrS0gzYmYP+qX0zM6cSST3M7qnuN6IR0l+n/3cCG6OPQQQcs1p//hIuoegJIVzHczMPxOEFyAXBBsHVMNDLBEgO8kLg/bYvdHI3m5Y1PE02/o9PgJHrrKcmjryQU5YsoifT013xhrS1qCbWsW8WyJ9z9yXWvJK9z89tKQeve8jGt0w4Opqb7UVgw8I1uSglWcOiZQM3qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=suse.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k97+rv59nQ+x+6738TZ/YVw5sNsK1eeN0TXOGfd8xic=;
 b=SS4XhM8bK5jzn0Vz7PW+UFRYMalGJK5pGJ5Kv3cGP2d9zxQNt+VQQi/QcWx+QftFPI0mvkyLAMaGIGfLs4TvnqVu4r8exT7+JdnizY7R/UWgXAjFFVQb+q6cKy7qGfwq6Y6RNSSf6i10KaMj51XT264MeEfUmji+CT6n39H8u0M=
Received: from DM6PR03CA0097.namprd03.prod.outlook.com (2603:10b6:5:333::30)
 by CH3PR12MB9098.namprd12.prod.outlook.com (2603:10b6:610:19e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Mon, 19 Jun
 2023 19:07:11 +0000
Received: from DM6NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:333:cafe::14) by DM6PR03CA0097.outlook.office365.com
 (2603:10b6:5:333::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37 via Frontend
 Transport; Mon, 19 Jun 2023 19:07:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT048.mail.protection.outlook.com (10.13.173.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.37 via Frontend Transport; Mon, 19 Jun 2023 19:07:10 +0000
Received: from beas.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 19 Jun
 2023 14:07:04 -0500
From:   Wyes Karny <wyes.karny@amd.com>
To:     <trenn@suse.com>, <shuah@kernel.org>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <rafael@kernel.org>, <gautham.shenoy@amd.com>,
        <Mario.Limonciello@amd.com>, <Ray.Huang@amd.com>,
        <Perry.Yuan@amd.com>, Wyes Karny <wyes.karny@amd.com>,
        Huang Rui <ray.huang@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v3 4/5] cpupower: Add support for amd_pstate mode change
Date:   Mon, 19 Jun 2023 19:05:02 +0000
Message-ID: <20230619190503.4061-5-wyes.karny@amd.com>
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
X-MS-TrafficTypeDiagnostic: DM6NAM11FT048:EE_|CH3PR12MB9098:EE_
X-MS-Office365-Filtering-Correlation-Id: 61fac32d-d12c-4f75-dd34-08db70f86231
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D+yYFnbmuAJ63Xu4fDK/QCy3F35fIBWuPRp1Ja53V1UNMoQjB4G2qpJ1QEN9fHwM558Az/gD7iGow4MtVjZF/rVOm6/crI5igQFBcq9LQQ4UqHiOhZkZbOSmCT036VCICSKoDV835hiYVLhHx/B3czcG+vj6ygMxmfRdOZeMKghVtfI5IDUQKmst/IYJ0FbEwTCmQIiCfbqYxM5OQ4Tmu4/UsYN2yddWr3k576kiIOhiiEHLpSUGMTVTGJLjB0Pi+CPliZpaW4Tb+r47xcjBhMGVcqpa5Bvgxd7JnsVCM8+XAWUkeCB6+IdrqLpOeLaDPTTa6Du0nOdgGtV7FV+YhPLcpSf1bTNyvRn0htl1neWkOlStAobRx8XJZcitN/JKaQyUgAFMrE9RZXGPbgrq53mWPBdFf2yD7hk9AqUU3gxDLEYqMJ+89+uGvkvVUlw/F4LO7OVmXAuugSbx4dRRIBUyuGyFQ1pPRIJxm4gtu1TmNV1/fLZ3F3harXKTnJqjHuJ9AAlZiyjyFQbUmOHOt1+Y3ei4gjhiHjKWi+pI9OVyiDlIdDtR+faaQh0L8Pe+o3gpu8S3JlF5IghMXi4owXu9tgYUeY+VV5k9aqFMf7QGQX6ynjWbCy9ZsQzUZ7iyB5T45h2wqk7kq5MhzOy8nWvmJP7RUmIOh0UW6HTdjwKckRc4gJOSM9MRr4CAXfUAZ7KmK9Qz07S4YUvyZQfy2pzNHvSqEZ0osXGKvrLjTPNZk/OH7ljvBHmRXCyijxBjNfzaMV2pvaiXo82UOIA1oA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(346002)(376002)(39860400002)(451199021)(36840700001)(40470700004)(46966006)(40460700003)(70586007)(4326008)(70206006)(86362001)(36860700001)(82310400005)(47076005)(81166007)(83380400001)(336012)(356005)(82740400003)(2616005)(426003)(7696005)(26005)(186003)(1076003)(16526019)(36756003)(110136005)(54906003)(478600001)(40480700001)(41300700001)(8936002)(8676002)(2906002)(44832011)(316002)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2023 19:07:10.4067
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 61fac32d-d12c-4f75-dd34-08db70f86231
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9098
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

amd_pstate supports changing of its mode dynamically via `status` sysfs
file. Add the same capability in cpupower. To change the mode to active
mode use below command:

cpupower set --amd-pstate-mode active

Acked-by: Huang Rui <ray.huang@amd.com>
Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
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
index 583df38ab13c..075c136a100c 100644
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

