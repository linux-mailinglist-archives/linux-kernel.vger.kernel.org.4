Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F6497330E9
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 14:11:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345285AbjFPMLb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 08:11:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345271AbjFPMLZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 08:11:25 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2043.outbound.protection.outlook.com [40.107.92.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A05730DD;
        Fri, 16 Jun 2023 05:11:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fwxAE6GQJBAv/x9mSuFpZq0YdMGkVt8g+JBJzqlIO48dpZePTSy1h2aTOCsSTNSKptbm71/CCV+5qe8ebzStRjx+/sSK8SInpIz6Wycn+Qr2iVj/IHALpQJBm1QI+fNKHJ89ul5gFjn9mbhNc+bLN6Px+EjLYBHoFpJ+R0Reh/chKjhxxG7BLT3jOaX1cN8I5dw5HPp5ussnKal1AcxVza/RXtqUFhk2xQZMUTyJeAFPybcl0I3+cA9QAzzqVcMLFfi1swBxliNoqhmldoGtyqQEKZ9/ORS4JeZC+saHzoz3Z8XVkAiu/86tqRf3aORQXoI2XcY0rANqJl8MOvUMkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gdjX15518sDy6igKp2883S0MJ5+0SWanq+D+82aCDX4=;
 b=C3G8gdkOgpS5N4Si+c3QhBHj+bLhX3bUvd+1rLOVx7HwVYbaHpQU7vp3ApLJaU7RXdjz5dPEAylUX3I3ZWgAj/5PD/lcpmVwp4a5dF9E6FVg1pfEpQQ867zDuCEiMP9K+ZJxAJkxr9tqrclAW9/PYzqfb7vVk0zhtegY04UGnIwou+noZkxLP4mdfEKgbJ+QR9R5DiUu8St3Zh+BT9Qj3iZFv+Ip9vcSHuC8WZbF/wGPaFFb/NwwuYdq2BnQH3KEDdQQuwhhT+MHrRspL5DjUHh5NA3Yb1S8b0HrjSIr0l4AQ8geHqhFkvAv+/Cd9YtvmtnIY4CRHrbHkcBxRbJGVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=suse.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gdjX15518sDy6igKp2883S0MJ5+0SWanq+D+82aCDX4=;
 b=d2XiITTsrCeN3Ku7lOiRvlwZhszOHsTB9StL81rvpVyioU40op6VswgWyyvW1toBJGQc/RE8a8gNqe4snwt4JfFAweMSf8+YewBt2KkYdzH208iukXK09B8puHapA/15iUmQseqFlR7d+CFVdzE4+P6BMLHrTdBCfCHEzYGAh2U=
Received: from BN1PR14CA0009.namprd14.prod.outlook.com (2603:10b6:408:e3::14)
 by MW4PR12MB5665.namprd12.prod.outlook.com (2603:10b6:303:187::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.29; Fri, 16 Jun
 2023 12:11:21 +0000
Received: from BN8NAM11FT035.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e3:cafe::4f) by BN1PR14CA0009.outlook.office365.com
 (2603:10b6:408:e3::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.27 via Frontend
 Transport; Fri, 16 Jun 2023 12:11:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT035.mail.protection.outlook.com (10.13.177.116) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.25 via Frontend Transport; Fri, 16 Jun 2023 12:11:20 +0000
Received: from beas.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 16 Jun
 2023 07:11:16 -0500
From:   Wyes Karny <wyes.karny@amd.com>
To:     <trenn@suse.com>, <shuah@kernel.org>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <rafael@kernel.org>, <gautham.shenoy@amd.com>,
        <Mario.Limonciello@amd.com>, <Ray.Huang@amd.com>,
        <Perry.Yuan@amd.com>, Wyes Karny <wyes.karny@amd.com>,
        Huang Rui <ray.huang@amd.com>
Subject: [PATCH v2 5/5] cpupower: Add turbo-boost support in cpupower
Date:   Fri, 16 Jun 2023 12:11:01 +0000
Message-ID: <20230616121101.147706-1-wyes.karny@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT035:EE_|MW4PR12MB5665:EE_
X-MS-Office365-Filtering-Correlation-Id: fec781fe-c496-4af2-5942-08db6e62cb8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: koI8eecrAvHanNVWfG8FK+Dc8wnfGjzPPslS+KNNWmhCyNX4jpedCk+1BlQ2naHI9O2ADlujJ3HsvrHUQVkpjUyCZ0sxSnR76dI08NGcAIrjbgk5WGnbYHH94x8T8FfiHi1khVfD7yGb+Pyu4NtyY+NoEr3bw/tJGaWU/evLBb6TtfucOpXafuPpE85JPnzPSKBDTng+MGD9/h6IdaZJYRAdAhhRXAf07uxm4gfxBmS9kYLiIgoLNzR5r5YFsf3zGyvIi1FFDfe1TqXKYJYPyQRaOwrxDmHlFpElPgC9J1A0cyQoWFtMXApcw2I5wdbQrVEfIlLXVBMo0UeGJZu0UEYHGBa7ghQebkdVgqP/x7TbhxH9vceEF0hoB1Bcm8qoYNJUBoAnh7cZIAJsaFNA1sf5nq2r7KQFJsZJ8LETwiV9FVlXmYKkVdA3aO4Sms55ZBrvtEnwDDLvyj+lr6tLIC7H/8DV7BzOWiFV2LxD/+x6S0SgddsFVwN+hMI8YphZ6/Y/m+/9Vh66wyBTvWdxztd2+T2J/l+W+1ZI5JfhWdJCD4Swuo+jtIpoa8I9x+VIOGEzz5KynoejbjwsgkfIXViUm45wgJtAGeX4xAYFAgW7JjOhju5xt8X2tHe7CLpto3/2dG7NVqJ1L04IhTwU2rT2yu4Hyz0ipBMgvvUUJL8O3VnmwnkbWTCbFQ4GQ/3NLkRVorvfRpMVUk09lQ5Tq+pGbVWRKaQyY+qsvnF8Ly4XweS+nDmqpHvjAq5Tu4Zr9sbCgDNetU8e32+Z9SynCQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(376002)(346002)(396003)(451199021)(36840700001)(46966006)(40470700004)(26005)(1076003)(36756003)(186003)(16526019)(478600001)(40460700003)(7696005)(6666004)(40480700001)(2906002)(316002)(41300700001)(44832011)(86362001)(5660300002)(356005)(82740400003)(81166007)(8936002)(8676002)(82310400005)(83380400001)(426003)(54906003)(336012)(47076005)(2616005)(110136005)(70586007)(70206006)(4326008)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2023 12:11:20.3608
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fec781fe-c496-4af2-5942-08db6e62cb8f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT035.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5665
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

