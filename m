Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01651722AA2
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 17:13:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234544AbjFEPNq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 11:13:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234177AbjFEPNN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 11:13:13 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 175FEE56;
        Mon,  5 Jun 2023 08:12:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NqrqNhXvlFuO99NdwWgEYLaHFWQQjSlEK/PFFpMoGGuthQp78Z5CWTLyhG606ybdShmbd6EKWsNT0W1G9d9RAmetkiIlAw4dG0lvG8zbh7V9ZYzIDCu1xtn7n7H2UCpDlZRME0gut09wVvoiqW+elYFvlRY9m/XGnPkoFWMIazQJGzVn0pTTWGOadJlMst19brryhJz19Cc3tLXWtJezTy6lC0ow8fcZAKZBM4BwBpuv3c3jQknii2zNTn6xyCvKbotjh7OEcw5pcTQpiFRZvHWfh7AAr38MRhP25N0aQgWR20Xf9OBTNsM/SmGYJdseohRmyeetLfCpQfgZWx6AAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iH6Y3AwplmndhbWiF/4vPmKuIQ0dTJEF/RNe1z7wNcY=;
 b=ObB0u1OiGUXDlNxyfaFHIPPD72Decrg7jaQYcE2aIb4W7EijVSDBZwCoXyZxcFaNTOIeDY793d+0/Nwe9KzfUC34vRj2bOHGA46mwLvoVWwNZGSU3xeiMgvqW+y7em7mZSF4QkPi/GfjyC9/gvz4OddXa+vowddIBkDvxgzfz3G/dwC7oJMDJJn2rgK4LlEOGC7UEtvqPjRj3i24D7YDcqyVY5HUqKakBvYBhLMiy89/8Ygr9c3EBYDu1pEe/RTyNuAgkD9XTUx4SiPLDQpeNYhSQL7cdzjTauYoGsehbFCInckDUYx16jq+5OZm9a1TXKPeAHEiEBreKvDQ2Q+ewA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iH6Y3AwplmndhbWiF/4vPmKuIQ0dTJEF/RNe1z7wNcY=;
 b=D6SdUA3FXXtxDwXsayeJWxhemzYKd00iGdMpYQQ9pJwC1ztuPJKilsFffOPBK61a0uq51RQEBG3niLu34csvYbORHzsQsifMBvwF/SfQNl3ClwX2l2XSOoivia1ndS9o5xOHkHVTnLmLEpdGUAPqTDLG+INGR1uPHYSfICSqolY=
Received: from BN9PR03CA0955.namprd03.prod.outlook.com (2603:10b6:408:108::30)
 by IA0PR12MB7508.namprd12.prod.outlook.com (2603:10b6:208:440::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Mon, 5 Jun
 2023 15:12:09 +0000
Received: from BN8NAM11FT076.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:108:cafe::6c) by BN9PR03CA0955.outlook.office365.com
 (2603:10b6:408:108::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32 via Frontend
 Transport; Mon, 5 Jun 2023 15:12:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT076.mail.protection.outlook.com (10.13.176.174) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.33 via Frontend Transport; Mon, 5 Jun 2023 15:12:08 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 5 Jun
 2023 10:12:07 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Huang Rui <ray.huang@amd.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
CC:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Robert Moore <robert.moore@intel.com>,
        <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <devel@acpica.org>,
        Gautham Ranjal Shenoy <gautham.shenoy@amd.com>,
        "Wyes Karny" <Wyes.Karny@amd.com>, Perry Yuan <perry.yuan@amd.com>,
        "Mario Limonciello" <mario.limonciello@amd.com>
Subject: [PATCH 4/4] cpufreq: intel_pstate: Use the acpi_pm_profile_server() symbol
Date:   Mon, 5 Jun 2023 10:11:33 -0500
Message-ID: <20230605151133.2615-5-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230605151133.2615-1-mario.limonciello@amd.com>
References: <20230605151133.2615-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT076:EE_|IA0PR12MB7508:EE_
X-MS-Office365-Filtering-Correlation-Id: 56d1ae03-fdf0-40ee-6282-08db65d73b06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: baq6J5a2bmcp4jh3GdqrrIRJ7RqWSP93apXIpEZ3k5XQl4IS7N8GHiYEjuWUrWNZwaECVXSzbqBoGKs5bMpSgJYUp3n8VhhUh+H1y6OZxIhLqS7lPeug7bPVt0WU/UjxP/4F7WhlYckHLqkRLnx+brOZ8p7QtGPRPGvCls3YEwl9gUqHITQQr3jXqL2QeWVLHfg1UGcH78X5aAPSKJmhtadAAejNQyQ0RMonIzSgRT90BNOVJoBXGPje8BZr2wTyrS69zD6Fh/T+0msBFDGG8jlLTYGAvVvUdxejtvrscA9MDQ2h+fNf2V+6Vn9N1Z7M+L1r8ePovG3vELgDD7zdqGCQ2T00yf7g77aO3Zp4b4x1xj4lwm0eZMeLNh4aUQHWoFCy7Hb6cl/QrQoWmuXrOzm5xh4n0qSEGuUCakOdK/LPmsd0XYO0kUMfhOOgEXlD5+jxVL3H1Jh6d3cx5AqFk1cos+sDbmHGKHKXniMSiesF+rVh8Qczcg0JRfpFcFQsIKeroLeY0lqZpJ4YydnupLWnG2vSiMXiHlbrBDitbj5MOTBRhdw/FH86FYHfm2IXGX7oz7ejniGeP+opln0NwEBR4lCRranqqQ1zbeFayyTQmCR9oCjs1MFaFXqHsyQz7I4xxj1IDw+HFaOsrDhNiyjS6sRqNpIa+HpWUQsv0s1AGE9G7JlC5AChvuicxlbo8vj0s3QGX9aCYLN/AtO9EnsWxw8oMvKZMpDO3cd8hIiB8pDLxV12oPJnbu4O/7VnimyD3pqb054+uT5QJooEVQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(136003)(396003)(346002)(451199021)(40470700004)(46966006)(36840700001)(70586007)(70206006)(2906002)(478600001)(316002)(4326008)(8936002)(8676002)(41300700001)(54906003)(110136005)(44832011)(6666004)(5660300002)(7696005)(40460700003)(1076003)(26005)(16526019)(82740400003)(356005)(2616005)(40480700001)(186003)(47076005)(83380400001)(426003)(336012)(81166007)(36860700001)(36756003)(82310400005)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2023 15:12:08.5236
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 56d1ae03-fdf0-40ee-6282-08db65d73b06
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT076.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7508
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid duplication of functionality by using the generic symbol.
This does have a functional change that intel-pstate will now
match "SOHO server" as well.

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/cpufreq/intel_pstate.c | 17 ++---------------
 1 file changed, 2 insertions(+), 15 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 2548ec92faa2..3a36c0169d82 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -313,18 +313,9 @@ static DEFINE_MUTEX(intel_pstate_limits_lock);
 
 #ifdef CONFIG_ACPI
 
-static bool intel_pstate_acpi_pm_profile_server(void)
-{
-	if (acpi_gbl_FADT.preferred_profile == PM_ENTERPRISE_SERVER ||
-	    acpi_gbl_FADT.preferred_profile == PM_PERFORMANCE_SERVER)
-		return true;
-
-	return false;
-}
-
 static bool intel_pstate_get_ppc_enable_status(void)
 {
-	if (intel_pstate_acpi_pm_profile_server())
+	if (acpi_pm_profile_server())
 		return true;
 
 	return acpi_ppc;
@@ -481,10 +472,6 @@ static inline void intel_pstate_exit_perf_limits(struct cpufreq_policy *policy)
 {
 }
 
-static inline bool intel_pstate_acpi_pm_profile_server(void)
-{
-	return false;
-}
 #endif /* CONFIG_ACPI */
 
 #ifndef CONFIG_ACPI_CPPC_LIB
@@ -2407,7 +2394,7 @@ static int intel_pstate_init_cpu(unsigned int cpunum)
 		if (hwp_active) {
 			intel_pstate_hwp_enable(cpu);
 
-			if (intel_pstate_acpi_pm_profile_server())
+			if (acpi_pm_profile_server())
 				hwp_boost = true;
 		}
 	} else if (hwp_active) {
-- 
2.34.1

