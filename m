Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5975B65FB13
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 06:51:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231712AbjAFFvO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 00:51:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231463AbjAFFuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 00:50:51 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2076.outbound.protection.outlook.com [40.107.243.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3887C6C7E0;
        Thu,  5 Jan 2023 21:50:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UaM40+uuvcfyTnyFLPhnEkCkb+aR6HPU3BaofMh9dEK3vA1E3Uk5gBzpyldT/Bd9TwzD+wB97b5aptT0uhPYO8GtDySdlO7rAcvdDi9eHk5EAXebCP6Q/6h8NPuuJly/62yc67XU6ugNdShpWT9bMLv5/HP3TDQRtyOHpAc5uAjJXCTizz3wmpyWOszvpavwYDFEaBhLB5hbe9z6lIDUI2HI6pJi1SXm9woHhSDTwuqlRrIxMXfNtS80nHP0iABXuSmjWJmEhBQhxhrk5ytrShczMs9bKYWR4NEJ8Qfz7S3uPDCbVovWXy0yNHANcguF47szDei//X7wZxJwYcD/pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BKXpjY9aYWFFLNIkFsMgRO96SSIU4dgItG3vbJMFxj8=;
 b=m0b6rytiPrGYQ9wCBUdMQ4++1InJr+HI8IlrC8oDf1Gr0n26Tx6JHEPpRY9I37HbPCZeoS+2WWRnZBWIi539wzz5EPi9Fr9MYMviWpRGM0nHjSAsgfOajJdu2PwyFrR6HWBFkmaxcsD1DbJcGu+2+BNpXL31MwmZtfx9mG16dMjXdXLvdXRbQNkA9lGMHgefFwN7B9OrlUt71izoNdMbnLeUTn//9PfYu4USQalal2yeMGpg4z4MNaNRtNisesyi5uGAEJlM/5Q/JtXitCUi390jkEYPzUM1A74EqGM8LuSiiiPax6ghkwjbV7X3qTVVKsyoWXKi7jE6dLDKTxIwNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BKXpjY9aYWFFLNIkFsMgRO96SSIU4dgItG3vbJMFxj8=;
 b=J3eUoe/8EaYyyppkTV/KV/8laNs2c4ZqmnyJiY0iFwsywc7b52XAWLw0U/ubXypX7/qT8rAxO6ggK5xkG1F/6MiHKwSrEvPf6oa3sUW4m1BZf3+k8JjmX+94tOTlepsDXxzg1wPBvm7LY7zcwK0i/vcsbV6DopUZEL2MfH7aMlA=
Received: from MW4PR04CA0305.namprd04.prod.outlook.com (2603:10b6:303:82::10)
 by MW4PR12MB6731.namprd12.prod.outlook.com (2603:10b6:303:1eb::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Fri, 6 Jan
 2023 05:50:32 +0000
Received: from CO1PEPF00001A64.namprd05.prod.outlook.com
 (2603:10b6:303:82:cafe::63) by MW4PR04CA0305.outlook.office365.com
 (2603:10b6:303:82::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.15 via Frontend
 Transport; Fri, 6 Jan 2023 05:50:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF00001A64.mail.protection.outlook.com (10.167.241.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5986.15 via Frontend Transport; Fri, 6 Jan 2023 05:49:44 +0000
Received: from pyuan-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Thu, 5 Jan 2023 23:49:38 -0600
From:   Perry Yuan <perry.yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
        <ray.huang@amd.com>, <viresh.kumar@linaro.org>
CC:     <Deepak.Sharma@amd.com>, <Nathan.Fontenot@amd.com>,
        <Alexander.Deucher@amd.com>, <Shimmer.Huang@amd.com>,
        <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <wyes.karny@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] cpufreq: amd-pstate: fix kernel hang issue while amd-pstate unregistering
Date:   Fri, 6 Jan 2023 13:48:56 +0800
Message-ID: <20230106054856.37403-1-perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00001A64:EE_|MW4PR12MB6731:EE_
X-MS-Office365-Filtering-Correlation-Id: e61445e7-a669-4056-a54d-08daefa9ec71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gQNgwI8vUdgirNxN9K8QNRlrnCexw1K8Ta+IIIG87yFoijkTE7Fo+o2PjZwCQ8uU0Osmp4ct6DeAgCVkHeMqS7y0Zmg+sl4Rpkk99ZAUOEAXZr6rLN7usc11hQyPBEj/xmnAF7SyyCKT0WDLum2EgmRtnWNxt9EtlhTHnUPHgATYjlWdj3lrDxrylO1ir9bVsILIEvvqdP6OU14b5e3cd03oempZQdACN5V0jdLMffxYn3Ry5r+zM+EWRojAdMMR3Wfd4ZYF9S7emH+gw6ftT0uIywN9sNA+NiJMPvjGUZlYNPyOwgtwAOaOHJ9nRHNYcNfgpwSLsxJ8KSnZCcYLKap4kZ4c47TbRMgMC1WNx1FEDzcL/K1auny6Fh1FYcADHYBBwQIPqME3nc56KkmHaWrXBZjIBbvLDTey3dZeHvUr2bKpDhKHgbcaqCEltQ/p5FYwCCm+o983XF+oXc/voP7AFjs+rLc9xP63hTB6boN5piRg2ycmfON/sbKIF9GZCZwqsEHZ5x0brGM5hqHlsF74MxkvGGfMUZoglN3q8QQs27KsUqKwXKNOJHMx9AkEUNoACED6DIhhRc3JAa2VvayMSlUjsjGJ8LkfhYMTHWEhr86674E9dT39nHevw9qm6jPaTj2LsBXOL6DbLIFwX3DfuAiTNe4fki10b7VRPZgYleW03ixIsUl4HrGMuzthtTc+tgOrwM9s6dZGDAjlHPuCjvVu+zql9EYbCVakIHw=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(39860400002)(396003)(136003)(451199015)(46966006)(40470700004)(36840700001)(36860700001)(82740400003)(36756003)(2616005)(40460700003)(40480700001)(2906002)(316002)(70586007)(110136005)(16526019)(82310400005)(356005)(81166007)(54906003)(86362001)(426003)(47076005)(41300700001)(83380400001)(1076003)(5660300002)(8676002)(4326008)(336012)(7696005)(8936002)(186003)(44832011)(70206006)(26005)(6666004)(478600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2023 05:49:44.6717
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e61445e7-a669-4056-a54d-08daefa9ec71
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00001A64.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6731
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the amd_pstate_adjust_perf(), there is one cpufreq_cpu_get() call to
increase increments the kobject reference count of policy and make it as
busy. Therefore, a corresponding call to cpufreq_cpu_put() is needed to
decrement the kobject reference count back, it will resolve the kernel
hang issue when unregistering the amd-pstate driver and register the
`amd_pstate_epp` driver instance.

Acked-by: Huang Rui <ray.huang@amd.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Perry Yuan <perry.yuan@amd.com>
Cc: stable@vger.kernel.org
---
 drivers/cpufreq/amd-pstate.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 204e39006dda..c17bd845f5fc 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -307,6 +307,7 @@ static void amd_pstate_adjust_perf(unsigned int cpu,
 		max_perf = min_perf;
 
 	amd_pstate_update(cpudata, min_perf, des_perf, max_perf, true);
+	cpufreq_cpu_put(policy);
 }
 
 static int amd_get_min_freq(struct amd_cpudata *cpudata)
-- 
2.34.1

