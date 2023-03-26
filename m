Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B5B66C95CC
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Mar 2023 16:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230053AbjCZOs5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 10:48:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232083AbjCZOs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 10:48:26 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on20608.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe59::608])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47BA03A8E
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 07:48:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RbIJ0EdclACJ737HO61KoPikIlgx1CTHPRxG77mVtRoE6ufB5WdNH4osjAyxD99nGkDrsBylg5+vsDtCA/JsQz2IEpXhxfGLoEVqTmp6CFwdWNYHf2OKb5phrXsxzYjNOnr5bhIt0CbkKPy/ypvVnf4khidCm37YQkn6mrKjS5mcvKpPP3r6M7ulYxB762hia/rmnSm8lKA1SZV3MrvgJez/gbvzB09UlBlExmCIJ6ZzN3Jk2BsUYscS35Hr606580a6YIATLB6uak6rT0oUrem10nez/Kg662kA3ra6B6gzre4EiQSPPstoypyYjE7NsZR9Slhy8JVLQEgHieLrZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6y+5SDDPpRulwOlmXO3VSI8qEK9hnC3NPzAIDB6HvJw=;
 b=Q3YMgFbeM8HrHPlonEsoXUdzAuv07czZmWWY/5T335rnqmKYErTsrBHKlWT3KSSge27euFapSwyLlopSUio8zh1Tm6DdCmthwawxjHYV9FMg4aDsO5i5XG69/QI26fBYxIv+KT3cUg8nLY8nsRC1F1QJ6pDO0rPhbIxV0xNLjt63tnR0e67k8V5qPGCxft8pCGP3femcno5guDArbRlvKgBbqSDnM8CPJ30h+iT3QbdtxKwAgp8FWFDQa+MeWTuQuEn3tLytT6sa++SDr36LUHmJGnGcDFl2a0Z3G8DFEa4PKS5Hw19wtHvHtbYb0rC1AR5tanUhsAvnFYPHI9DBow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6y+5SDDPpRulwOlmXO3VSI8qEK9hnC3NPzAIDB6HvJw=;
 b=YYUlMbrDLcHE30HJ30/F9RNblwGHbTDe97D31Yk1UtY0Pm6/zbQgD/PfYYJzAJZv3rrer99KL38nhN2NNwSq3Dvh7HWuXYGZ0heBIV1zQRVZWX///qZGDHvxHFKCzWGYvpulF/nJtiaw1Q8upFWBD74TgYa4oRhEeu6oAY3cqms=
Received: from MN2PR02CA0003.namprd02.prod.outlook.com (2603:10b6:208:fc::16)
 by SJ0PR12MB5422.namprd12.prod.outlook.com (2603:10b6:a03:3ac::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41; Sun, 26 Mar
 2023 14:47:56 +0000
Received: from BL02EPF000100D3.namprd05.prod.outlook.com
 (2603:10b6:208:fc:cafe::96) by MN2PR02CA0003.outlook.office365.com
 (2603:10b6:208:fc::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38 via Frontend
 Transport; Sun, 26 Mar 2023 14:47:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF000100D3.mail.protection.outlook.com (10.167.241.207) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.30 via Frontend Transport; Sun, 26 Mar 2023 14:47:56 +0000
Received: from gomati.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Sun, 26 Mar
 2023 09:47:52 -0500
From:   Nikunj A Dadhania <nikunj@amd.com>
To:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>
CC:     <bp@alien8.de>, <thomas.lendacky@amd.com>,
        <dionnaglaze@google.com>, <pgonda@google.com>, <seanjc@google.com>,
        <pbonzini@redhat.com>, <nikunj@amd.com>, <michael.roth@amd.com>,
        <ketanch@iitk.ac.in>
Subject: [PATCH v2 10/11] x86/tsc: Mark Secure TSC as reliable clocksource
Date:   Sun, 26 Mar 2023 20:17:00 +0530
Message-ID: <20230326144701.3039598-11-nikunj@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230326144701.3039598-1-nikunj@amd.com>
References: <20230326144701.3039598-1-nikunj@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000100D3:EE_|SJ0PR12MB5422:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d6289bf-f5e9-4e79-c0bf-08db2e091617
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hDs5mVcPw5lzNOmwGrd8XYNC0eDInXRcv1iFnSEvwHNrgpYQcvax+5wDFZCDiAaBcKfqvu1JsN3Cax9M9wzEkcSlbZE5iQDjHFoFWKtIA0sKhaQ7aWvxwnFUeYFU6PcANnsPO3F0NY+w9lr9iByZyt4ExfNQ2Y67R2Sjd1HuKSP6nkOSTeOsKEgZkCorVD8I7FvpsVM1IUywfoHMa7XcrdorN/LZ7XVs+KNS2Q7uda/rK0GcDgxUZ7noISGsTbloQLS4xZgDgnHyExUZihz3GpViOaOwxpBFSr3+0yub0nxX7AoN1OFFLmvdJ2V8GlPT9bOCn6VWUZYE+fnwmgALQC6quzVQgZjVP8UA7oMcFNnydITnkrmCNVqRLPo+6wvWOXE90AHLOhpdap7FS7X7rWQHCfhoamvufE8Dzy293wXv5to49+3vZr1XZVmU58tBztIu2AaEyu4JjMJJS6DLk9yblUp1bnUjgENkrAqwfSa7mCEIEgaCTkjAnmqFzu2YgiyUz1N6dYwgceL1EnTd50p0MlZodk9ikMzrxg1K3x10eQYkvXcr+nvOY6QdfSC/kyCUEAYRgXrZV0HitlGY1TkCveKkOTlxnekR0omjOvkR1ZezsC3P1VTMZzSJpNcntPUv6dCtsWe3kqR42eaoUaN2gdbkNL0mDYJtG0yG3hLAhrDfN+T9PHUQxtcuXf1VYafzeFAJ6OcbopMgpAMiZ+nSXkq9LV4J4mlPZ7sp31g=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(39860400002)(376002)(136003)(451199021)(46966006)(40470700004)(36840700001)(336012)(16526019)(2616005)(186003)(4326008)(40480700001)(41300700001)(7696005)(47076005)(83380400001)(6666004)(1076003)(26005)(426003)(82740400003)(478600001)(316002)(110136005)(54906003)(36860700001)(40460700003)(2906002)(4744005)(8676002)(70206006)(70586007)(356005)(82310400005)(36756003)(81166007)(5660300002)(8936002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2023 14:47:56.2202
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d6289bf-f5e9-4e79-c0bf-08db2e091617
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000100D3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5422
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AMD SNP guests may have Secure TSC feature enabled. Secure TSC as
clocksource is wrongly marked as unstable, mark Secure TSC as
reliable.

Signed-off-by: Nikunj A Dadhania <nikunj@amd.com>
---
 arch/x86/kernel/tsc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 344698852146..5f1e2b51ae3b 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -1221,7 +1221,7 @@ static void __init check_system_tsc_reliable(void)
 			tsc_clocksource_reliable = 1;
 	}
 #endif
-	if (boot_cpu_has(X86_FEATURE_TSC_RELIABLE))
+	if (boot_cpu_has(X86_FEATURE_TSC_RELIABLE) || cc_platform_has(CC_ATTR_GUEST_SECURE_TSC))
 		tsc_clocksource_reliable = 1;
 
 	/*
-- 
2.34.1

