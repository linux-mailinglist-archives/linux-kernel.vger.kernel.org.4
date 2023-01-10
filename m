Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86ED3664439
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 16:11:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238898AbjAJPLx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 10:11:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238889AbjAJPK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 10:10:58 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2077.outbound.protection.outlook.com [40.107.237.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 651E3E18;
        Tue, 10 Jan 2023 07:10:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VB8GGIrbDIABFzfl6ksOhONh0cWwIIAtU2GpvujIzlIxa4qKv3JfyM4t9DgGBH7IIOU/Iv1h4rjFKBr+eDJ/SeCn5gpuzbc6Q2GMlS2KryiKs80l4vflric6iSV82Hw4BvpRkfSgOy1cDldR8xjqs4xPlHAyL/GbVhwOdmAocCrvdSzyikLD9zxiIqIulr4e2VX7SzM4OjBicaK+anew72xV51JMgbWqItgEboeHpJFisROJadLF0/fC3qNz7eTJtB62vyjwUdHBdv9mYn72oHisb85rnmPWURBcwgjHZmBLHhhc57PU3oz2UFQIgVVwkw84QT/odzSeDI0UhNtO8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RQBqq/IWdXVMnd4axM7QRZ2j7pYu/Do9vcdTqVz5xTs=;
 b=nbXwiBdIwiEbn/7VoBX1qeJ2tdxx22t/q7E9Phdo4Lqw7GjjxDmz8w/BB1hS4wZChnQ/V4uEPws2sCHdKre0uCE1HuNa/72hoPLN5rjf5V+E7ch/zkjZDPcERvgZ1exWaUlcFmKBmZOYMUGmvrSYD/aKP6Nams26uB0wZgv4x+OCTr4XPE7qb/9LssX4TDSiNsD7cKe2/V8ftaAQ42DhWW2RX+j4hBZF6Hqh463sp67MSGBy6w29d+q5EdUaWu4j1xYaZCNCV+/RYxY0v0DYK147JtoKLWyjaIyixBuDWKa29C/o/02k+V4qQhLMnkh24rhehIO8Wt190U8cX+m64g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RQBqq/IWdXVMnd4axM7QRZ2j7pYu/Do9vcdTqVz5xTs=;
 b=fuG8/iXCkfurU7yPMCad9429pBgDNCkOC4WLR/JIeAmdV1tPNzPpp5kO8mKq7t558iWOVLBNpwlroE5FYccENqACvk5ER01zVI7QvtxPMfZrUgzXeXQ6kXomxjg7T8QPQGdmPPbeShblvjqzU5RdsktiKvFkc7/PBIKLDaX8kdo=
Received: from BY3PR05CA0023.namprd05.prod.outlook.com (2603:10b6:a03:254::28)
 by MW4PR12MB6754.namprd12.prod.outlook.com (2603:10b6:303:1eb::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Tue, 10 Jan
 2023 15:10:49 +0000
Received: from CO1PEPF00001A5D.namprd05.prod.outlook.com
 (2603:10b6:a03:254:cafe::3a) by BY3PR05CA0023.outlook.office365.com
 (2603:10b6:a03:254::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.12 via Frontend
 Transport; Tue, 10 Jan 2023 15:10:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF00001A5D.mail.protection.outlook.com (10.167.241.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6002.11 via Frontend Transport; Tue, 10 Jan 2023 15:10:48 +0000
Received: from pyuan-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Tue, 10 Jan 2023 09:10:42 -0600
From:   Perry Yuan <perry.yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
        <ray.huang@amd.com>, <viresh.kumar@linaro.org>
CC:     <Deepak.Sharma@amd.com>, <Nathan.Fontenot@amd.com>,
        <Alexander.Deucher@amd.com>, <Shimmer.Huang@amd.com>,
        <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <wyes.karny@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3] cpufreq: amd-pstate: fix kernel hang issue while amd-pstate unregistering
Date:   Tue, 10 Jan 2023 23:10:29 +0800
Message-ID: <20230110151029.1945544-1-perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00001A5D:EE_|MW4PR12MB6754:EE_
X-MS-Office365-Filtering-Correlation-Id: e6b328eb-0472-4c4c-c463-08daf31cdb4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MIDb9WFnv0Z+yAfBGOZojHM+Yl2O0qyQF+gddZLb3vEk4LMEy1WWA4U2DUsmLn8/ikshLTFNMiP8ky+4i1BesjiNe9dOX3CPysnRo+r6gzwmlr7E4MuFXQidPvy4oID73Rnzyde6Q2zPOfZMzUBxWEb0QU6YpplcDo7rD+JxCrHFeor0NbWINq4XMNePqN/YfpWzin5GDic0xhGGIzm5SHesnWTeqHUJfC7pW3Z8K8mj+/Nu7Jboy97VrZCCvPU8yWqSrcX2fo8lVYNTv/pmYfp07YzhbaW4YgRWTsYexw0WGvEBbRaiNL01RKT1+5gi3it3+IUMWEBiUTn/3dXI+aPospQ3v1PAIh/9wd4XVlffP1zKzkya3Dw2OXuaoHvglmsrqrDwACS41GzvHTdnBUWRg7CNUsNuAc+iOTGcaMs5LwgnrBavrLPchpOxWFlOC68IKrywlbqfVPxrg+rpzcVCzm9qCift6HlTHUzwGvHfNKdnc4p1zZr4P7PTrnE8mFyzzBpIgRGLM4Rb1HwpvfgzvP1KIdL/2I7mgSh/rVnyFXzSL44bqazxsl6s9uz1sczGMlGZAFp7ajX3hmfbj4zwTSGtsl5ZBQSVXsMT8Bee/dT0DkwNlHpvv5wknmS8Pd8/x+emv+l9glDJ/Wzpz1rLYXtlVOvCDOnzNpHAhpUsudBm5QEWIxSTmttRxMaYDqaJgJfyEsmLJIjcPECh8WNh/quZdGzeJFh2bNhuaUM=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(39860400002)(346002)(396003)(451199015)(46966006)(36840700001)(40470700004)(110136005)(54906003)(2906002)(5660300002)(40460700003)(336012)(47076005)(426003)(86362001)(44832011)(36756003)(8936002)(40480700001)(41300700001)(4326008)(70586007)(8676002)(70206006)(82740400003)(356005)(81166007)(316002)(36860700001)(82310400005)(83380400001)(7696005)(26005)(186003)(2616005)(16526019)(6666004)(478600001)(1076003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2023 15:10:48.8634
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e6b328eb-0472-4c4c-c463-08daf31cdb4e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00001A5D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6754
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

Fixes: 1d215f0319 ("cpufreq: amd-pstate: Add fast switch function for AMD P-State")
Acked-by: Huang Rui <ray.huang@amd.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Tested-by: Wyes Karny <wyes.karny@amd.com>
Signed-off-by: Perry Yuan <perry.yuan@amd.com>
Cc: stable@vger.kernel.org

v3: add Fixes tag
v2: add test-by flag from Wyes.
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

