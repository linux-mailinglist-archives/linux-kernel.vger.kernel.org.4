Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F596706E2C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 18:30:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbjEQQal (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 12:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjEQQaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 12:30:39 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2081.outbound.protection.outlook.com [40.107.92.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AD4EE45;
        Wed, 17 May 2023 09:30:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CbpqAAOZ+scgKbhMuI/1RMV2/eWhDjYkCzBaeqKZecxAy5vUdCGLAX2hLNMnF8PhPu2XdxbBm4pM3yeQqHGd1t6HwxslvxAlAr/0Evml01HwtC1/lwkjXcp0dzr3/EWE40Camm00yALUOfdGGZKlHwis824KH47S8Q4MMLQiOHwBeMmFAPt2/bZ/Brp/3z96U9kx0Tc+fao6kI5oeVzHSTcLJqSw6XweeCe9U/iV/jlg5q+wSRDzv6CYo8ScGabb1MJDZ+J0OtDSPCqBuQMkQJfN+HKJgtvbV5rUMh3oy73bMPs8uyhncOT7j0cd00pMj8LssiCA3gTQSvHkSL5Ztg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/4b09leER36s5g2t8mNZPHivLrhBHuZySAZB9obu22A=;
 b=DoGiYYL02o7VCqHzoRmRAuM89ldEp+6dSdYwj9ASq5GwAPCIXHlvfFndnFtP//P4LdvaiSzGGS8sqXn/ZjZEVR04dhcjMaPUQkwpa83Adg/iMvNzfVFtAiKH4OxAWos83vvYmSgQzPBbzCydidQySjwvig5zN1ohVdxt6rJCDHSah+LTvsAZiNenzoS7tL3rxxGKFt5lxgw0J3RnGGrXgIG465P8a+Z4gubEJBin7huz1ErgshRRMpkmCSaF6esUvafKUb5THApLpB4VzN3DMgaUIGW9Jf8Mz3FojU7SyPFaqfUs5aHzJfpgwYyAK2gqSdU75t0Rmy7BsaYuIbAs3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/4b09leER36s5g2t8mNZPHivLrhBHuZySAZB9obu22A=;
 b=wF+a8r/t2zyZuOCgu0mtNmnHyvLKXEfg3mf8T7Z8TxBSekPKB4zY4YNKryinzhbXv+riM5xPhski3BG8lWeNzCcvkxvUg04UKHbd/z9pr6G/fo93ZgNJlsGL4hefwFXxdPqHSuHzToFC9MPJHSszpgi3ZHytyiV5lLdFk11ffug=
Received: from BN1PR13CA0016.namprd13.prod.outlook.com (2603:10b6:408:e2::21)
 by CY8PR12MB8410.namprd12.prod.outlook.com (2603:10b6:930:6d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Wed, 17 May
 2023 16:30:33 +0000
Received: from BN8NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e2:cafe::5c) by BN1PR13CA0016.outlook.office365.com
 (2603:10b6:408:e2::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.5 via Frontend
 Transport; Wed, 17 May 2023 16:30:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT008.mail.protection.outlook.com (10.13.177.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.18 via Frontend Transport; Wed, 17 May 2023 16:30:33 +0000
Received: from beas.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 17 May
 2023 11:30:06 -0500
From:   Wyes Karny <wyes.karny@amd.com>
To:     <ray.huang@amd.com>, <rafael@kernel.org>, <viresh.kumar@linaro.org>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <gautham.shenoy@amd.com>, Wyes Karny <wyes.karny@amd.com>
Subject: [PATCH v4 2/3] cpufreq/amd-pstate: Remove fast_switch_possible flag from active driver
Date:   Wed, 17 May 2023 16:28:16 +0000
Message-ID: <20230517162817.8538-3-wyes.karny@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230517162817.8538-1-wyes.karny@amd.com>
References: <20230517162817.8538-1-wyes.karny@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT008:EE_|CY8PR12MB8410:EE_
X-MS-Office365-Filtering-Correlation-Id: dd91b11a-8683-4759-5c68-08db56f4094d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +nN++Sk5z7ND5Gz08aPHDt5UdJGp5VLF/Zc6jRfSDKRhRMdRgCtA5RQxlZkjEcebLkFdfuPkM/RATL6TOBor3tiqs5f6cIirxo37IMZLW4ZJS/7KeZQDXS2nRHHVSiiNfak3TIp3S4AthanSdObeulO+p8FVOOaGL8uWTHWVqXV8TPbSm1Y+7kqLSTZc7Jt6jkTMCkVs2+Q3Boia285fTZU3USfdW2jsl5jmvLG4f3LNjZvJupWjIUSoPFF9xV6jZIECZA7z7GGH8qvTO+r0RrePdCPps28p2Q0YnV6dQx+iM1MDcTGZ1USFyjVYiOSq9dsQetw3xHaVhIJAM3w0soHkbr4qxS88UBs6S9PEM4dsfgXtlg+kfJPvm7nIemBi1fjPfrv4F4A/GDMw1KDov/weog1P6iiU2TAVxfbhkKQcjkNPOL68VzkqQiNqoKYZ1RzefKJfz+HWTI2ySU8zaWxJi0BYgJYR3Min+8oN5uapcFZ8uctd/jWazSWp4bX8pFsiBVYjUTfdWFXUROiSmqWu9LYY4vOCQvEbUId4ZVkOWmfoZIohJAs/UA6rdie/8BL/5VhUl3PKzsE0Wy/DSxCCipoE3Cs18J4sHxYG/BkGxdN9Sy2CUWfZm0erbdRpYOBw+O45k6mCqWwA8C2IUmdsXLhTvIhM/qDQeSAhzbW+Uc83sv6bh686hv48BLR6iw1PwVQdbkfC6cVL/tPGXl6R5cGekvKEjLEYT7CI/5R/dSpL7zvW3cAODRfjTS1/B1ACfUBItUWv9IgIAtaJUiTfwOEPPGoypZ4i9u0qVDs=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(346002)(396003)(136003)(451199021)(40470700004)(46966006)(36840700001)(5660300002)(8676002)(8936002)(44832011)(336012)(426003)(2616005)(82310400005)(81166007)(47076005)(186003)(82740400003)(83380400001)(1076003)(36860700001)(356005)(26005)(16526019)(40460700003)(7696005)(478600001)(6666004)(110136005)(316002)(40480700001)(86362001)(41300700001)(70206006)(54906003)(70586007)(36756003)(4326008)(2906002)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 16:30:33.0662
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd91b11a-8683-4759-5c68-08db56f4094d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8410
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

amd_pstate active mode driver is only compatible with static governors.
Therefore it doesn't need fast_switch functionality. Remove
fast_switch_possible flag from amd_pstate active mode driver.

Fixes: ffa5096a7c33 ("cpufreq: amd-pstate: implement Pstate EPP support for the AMD processors")
Signed-off-by: Wyes Karny <wyes.karny@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 45711fc0a856..ac54779f5a49 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -1102,7 +1102,6 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
 	policy->policy = CPUFREQ_POLICY_POWERSAVE;
 
 	if (boot_cpu_has(X86_FEATURE_CPPC)) {
-		policy->fast_switch_possible = true;
 		ret = rdmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ, &value);
 		if (ret)
 			return ret;
@@ -1125,7 +1124,6 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
 static int amd_pstate_epp_cpu_exit(struct cpufreq_policy *policy)
 {
 	pr_debug("CPU %d exiting\n", policy->cpu);
-	policy->fast_switch_possible = false;
 	return 0;
 }
 
-- 
2.34.1

