Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D36BE646E47
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 12:19:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbiLHLTo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 06:19:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbiLHLTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 06:19:38 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2061.outbound.protection.outlook.com [40.107.100.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 121A75802D;
        Thu,  8 Dec 2022 03:19:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hAGYeryx57Lb/lDQJJg0j0oxdCxzWf2qUGXad1CLA6vmlwxrRpgQCbophWjNTI1tdyeXchcNWGiV1LbB1JAA00HDLniyrbvGRbcekL68AOR8PHe+HAlWVOt7/LF+RphixRDWydF4y1HZiyNf7Uy2ID9iRSiV3sV7bazVpDxSmwnImueP1s//dnSWw5fAnUEBcMmlqCouembJv7++LdRX3vI2QaTdeJMOH4b9BdzioMgW5/WFNerb9C+tUF+9R4AU8griVIOxpq+1pV0jETpymNal44H9ieMAsGyNwplMCxCrpUIpmN5G4/iPT+BEMLGwjwqWfg94NcR4SF1p3gn9+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cQLRE1UudFyiuXv3WyY/aE+vOBvMptCqvkvJir3SeaI=;
 b=HnWYW3cbI7+SpJw53RbOwztteNohFQX7cwhfCuqC0ya40xyGXwJVkJHC2pBjbsMu5zjRmvsXpU8I5UvR3Yq4PzI4alAFXe9Xm2RLCO8aZPwIurwpfdBKD+9DHBksETdyz+f+xXXXmVd5silT/+UKH2INYwdwvtYU9KrZqWxqERV0sfOtlUe6KsPp6TjbXx7Zkg7pqYf446hUW7BLqGuluIt7QycU0rGDJLWDOnBNzxHZoYxXZRD/WzBRQMwxq0eXC4rbPE3hgUkor/B6oABja1FvWZz+daLMLgtYX/4z0771GGuxSXI6NyOm4n+ApcxuuKYxemD9pPZIaeAL67ejqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cQLRE1UudFyiuXv3WyY/aE+vOBvMptCqvkvJir3SeaI=;
 b=uyCHWyhppYgPcJTtwp3tQhy75iSJBD96YcNxPTfbDcPzPzd3n/ub8KZXUmvY9wYUNGFIJvykl5C8fJCxNK9oDsxApZqZV5JfDuOA/agsh5XZ0UFN81Xg0NUueb0vHuQ6tbTnzEyFdjou6Rk+RMhpgGbXY59CpLDTrcBOlLPSfAw=
Received: from DM6PR10CA0004.namprd10.prod.outlook.com (2603:10b6:5:60::17) by
 MW4PR12MB7000.namprd12.prod.outlook.com (2603:10b6:303:20a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Thu, 8 Dec
 2022 11:19:24 +0000
Received: from DM6NAM11FT071.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:60:cafe::2) by DM6PR10CA0004.outlook.office365.com
 (2603:10b6:5:60::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14 via Frontend
 Transport; Thu, 8 Dec 2022 11:19:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT071.mail.protection.outlook.com (10.13.173.48) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5901.17 via Frontend Transport; Thu, 8 Dec 2022 11:19:24 +0000
Received: from pyuan-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Thu, 8 Dec 2022 05:19:21 -0600
From:   Perry Yuan <perry.yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
        <ray.huang@amd.com>, <viresh.kumar@linaro.org>
CC:     <Deepak.Sharma@amd.com>, <Nathan.Fontenot@amd.com>,
        <Alexander.Deucher@amd.com>, <Shimmer.Huang@amd.com>,
        <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <wyes.karny@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v7 04/13] cpufreq: amd-pstate: fix kernel hang issue while amd-pstate unregistering
Date:   Thu, 8 Dec 2022 19:18:43 +0800
Message-ID: <20221208111852.386731-5-perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221208111852.386731-1-perry.yuan@amd.com>
References: <20221208111852.386731-1-perry.yuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT071:EE_|MW4PR12MB7000:EE_
X-MS-Office365-Filtering-Correlation-Id: ee107c24-2338-4cf5-5457-08dad90e100a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Kzzd56z6F6cfCpPNAk4nMeZQnH0Pt3usG5PjbqZr7Q2eNqhuBA9K+Xl9Jm4YRv7rq0WzoDt9tV3HhdTZOJImpk9eTQ1en62BF4kc7OsWvHjc66v22wrJvhJKcil3mfgDJW/j+5Er9xl86zYKvz+fPaLZuN/TwwEr/akRd+QcjYx5q3onIxMsKQfZTuhEgQ4hstqXZITnXQgsNxpEwr+f9h7hAQhjVRp/J5Lm+BeAn6njpQ1XHhC/dTXIs8S26Mz9/xqcErkJFNblnMaYNVVZEqNIWzc3Sz3bhls2kmzBZhS1v9Rv3XJrlL+TIL8TayfvwE3FkBQITJfYSil2b5C/Wmmn/TQY62mgBKVrg+7wCV3OW/EJWXpEqcXoiTBEB7mx9HDIdpC8s4Bo2lhsXz57QySFJ3Ve+/FfomQ3lqxPi/kUTyjrdjIrE0G/SF0GUbVmnN1Ztx7thHmJP6080rWx4aLt1lkFlKiyH6OxVXXWO2WVJJ0EUk9xt+sjIDOOInvd+hNePabIZxXHJ/QBb5bRNMccCl8Y5SIqR5vxBE3n/+Wqu/L0f2j06JGTPVs0HpuoLsAfxUh9jKkKKFNs2uv8T2+CzlBizDso1GTH9iJ+qsmP8rFgwKUihkWNQqBbp36X1kyACsJJnSVaikYQp2KPUpqTU9WAV6dd8gQkfVreexMFmDti6AQXopRpiPLzv8zXqQkcAjqLUsW0IN/5D/cFlrX99Tf/HSeFULJ60WNo9LQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(396003)(39860400002)(136003)(451199015)(36840700001)(46966006)(40470700004)(16526019)(356005)(2616005)(41300700001)(336012)(186003)(1076003)(82740400003)(81166007)(47076005)(83380400001)(36860700001)(82310400005)(426003)(36756003)(5660300002)(6666004)(40460700003)(8936002)(4744005)(44832011)(2906002)(7696005)(40480700001)(478600001)(26005)(8676002)(86362001)(70206006)(4326008)(70586007)(316002)(54906003)(110136005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2022 11:19:24.7447
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee107c24-2338-4cf5-5457-08dad90e100a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT071.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7000
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

Signed-off-by: Perry Yuan <perry.yuan@amd.com>
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

