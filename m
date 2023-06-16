Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AACC87330E5
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 14:11:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345255AbjFPMLW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 08:11:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230505AbjFPMLT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 08:11:19 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2070.outbound.protection.outlook.com [40.107.96.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A4552D73;
        Fri, 16 Jun 2023 05:11:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LXsyCo/iOusLAwA4ayQYSxPSxvmrq3aaWkfqSmvPH/OpMDvJm+DJ9MThxKuPnU8+bMmvr6hN572wWn+oqTRPmKy0y2NKN/ooQhw0Q8ezxQxXs3fpawCOa8bA2yDVVPXY00lj3B1QWPb15bhpnSPy1BWumVpkuhSsYqKBCXs9erPGFFOaSj/RDWQ9bMvDdma+CXATRflWHxw9Le7T5iYoQKmtqtsOla0ZasrCYlRdxUL/o5LOEw0TqSUR9U6E7Th5qGq0cvujOqliJfFEVgMVHGGfOWGyPUUsN6w4BtqaT/HRrzR9XmiHZ0X3S/6Qf0zrcRaHuQw0zIGBfA7puqjItw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rcYkWBmz9+0nsPHn+lwN7BOkQmpVnmdo4nPnKWX/c0w=;
 b=BquAvGPEQ3dqp8cfzC0IojpuyJWOZAZxg7Z+MYg/YJjmB9ktGG7mYurAdGjSXCl4En5Eeh4RRQWrK4qgdQNQx0FgotAnrj7xnFhOvJLbfGk5ToU2QTZMiV8fJq2Qt53F92cQmrl/mkPaoWsCLbYe2l+JuYedmrXZIhWvQkrXJYjG0m8Jh/4E5R8mDYhjDj+Dxu156Aj769TifbYCaPQvo4I2n57efxGDz+2sKH0K4P58Pkji2T8FLQwE+g3ZNemaKH57hwYyIlN9a5Vwr5mynVuSOAPdBGkFXvCXD7He54eMD+Q16M+L1eJspfVVbYEbWaaPJKN52KS75RT6WDdJVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=suse.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rcYkWBmz9+0nsPHn+lwN7BOkQmpVnmdo4nPnKWX/c0w=;
 b=Xmw5cKqTFKGz0SPYyph2YwehpLn74fHAFxlViKfBqCug1H2I6XmF3tfwdD6/TLESkpkhLlxjvTGR5Rqk2Vv9uECKCUo4znWJ4fny8kPRmd/w7mV5eiJtL074ZLbzFux91xp9BoAIMCjSyv7Qe1yCZJF3tLCqeavSYP8KJeZLHCQ=
Received: from BN9PR03CA0634.namprd03.prod.outlook.com (2603:10b6:408:13b::9)
 by IA1PR12MB6411.namprd12.prod.outlook.com (2603:10b6:208:388::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37; Fri, 16 Jun
 2023 12:11:14 +0000
Received: from BN8NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13b:cafe::19) by BN9PR03CA0634.outlook.office365.com
 (2603:10b6:408:13b::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.25 via Frontend
 Transport; Fri, 16 Jun 2023 12:11:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT048.mail.protection.outlook.com (10.13.177.117) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.29 via Frontend Transport; Fri, 16 Jun 2023 12:11:14 +0000
Received: from beas.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 16 Jun
 2023 07:10:44 -0500
From:   Wyes Karny <wyes.karny@amd.com>
To:     <trenn@suse.com>, <shuah@kernel.org>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <rafael@kernel.org>, <gautham.shenoy@amd.com>,
        <Mario.Limonciello@amd.com>, <Ray.Huang@amd.com>,
        <Perry.Yuan@amd.com>, Wyes Karny <wyes.karny@amd.com>,
        Huang Rui <ray.huang@amd.com>
Subject: [PATCH v2 4/5] cpupower: Add support for amd_pstate mode change
Date:   Fri, 16 Jun 2023 12:10:26 +0000
Message-ID: <20230616121026.147691-1-wyes.karny@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT048:EE_|IA1PR12MB6411:EE_
X-MS-Office365-Filtering-Correlation-Id: dda589c2-52e2-4c74-319c-08db6e62c82b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RlKc/OODGPM1LREbwXqQTZzM9sylVyt6Vdz4WZwCLjMil57CsImICR2YJoaxLJRBvVXr06k5em6RzAkTX2cbDxUlxaZ1CZraIfBwOaDprRGgPCUEJilUWb41fxq4JjNFrUEWNqW34SgYEGgb4NvgrKE1yGO/Q7mRvFR6Gc66bnETGcmK8/WUrQrRFXR4dDNiitgHejQJG++n7/EGoriW7IsZztWCkyph7d308UkXe8hEX1GY8UtN6Q1CEXJv7cy3UEmXOYmNwQbwZP9dA2drniqYeBACy/x4s6VA483xNufxwBlNliokyZ2HT6EnMx7hNh6+GASi9zJea8Z+ULH0Hef58T1ExHCq/Lh+HjqEJUy/euIncGtFppvdVHSyWM8/XI4IbfV2Kb3nwln3uYilV9yMqYYl8gSC9fyIrK9Jx8fHKMWmAWcfxrd/z6/u/1acRtd5tBZnG9398Li6buqs1I8nw2CRHbgTNexL4D8exwD+6oCVI527KFZQCmkXcYSOBkG0cBlxDxuNtm4mm+xEXl6ICevj5YWmYk40vNRnYXjfWKO31zBqOfqpxQdZV3y0J0qR4EExSdAV5jAXr808Ujb8J7oNWwdwBviG/d9GSlXMYNW7VvJTxy0tNNLdWi8sKikuIYQiIXi04EDenLqKRWuyr4OBD/pM2jdMj1HTD7tt7kycEwq2RcM8OTcTrtNCXOixww4oXV8G1aJO1531buuVHSoUffHIR4lupro8hFiCFvR7X7H1gOzqLc+TZ64pwvruQOupexkAQb58BBt0eQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(376002)(346002)(136003)(451199021)(36840700001)(46966006)(40470700004)(26005)(7696005)(8936002)(40460700003)(8676002)(41300700001)(36860700001)(36756003)(81166007)(478600001)(356005)(82740400003)(82310400005)(1076003)(70206006)(4326008)(86362001)(70586007)(54906003)(316002)(110136005)(6666004)(40480700001)(44832011)(83380400001)(5660300002)(186003)(336012)(426003)(2616005)(47076005)(16526019)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2023 12:11:14.6712
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dda589c2-52e2-4c74-319c-08db6e62c82b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6411
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

amd_pstate supports changing of its mode dynamically via `status` sysfs
file. Add the same capability in cpupower. To change the mode to active
mode use below command:

cpupower set --amd-pstate-mode active

Acked-by: Huang Rui <ray.huang@amd.com>
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

