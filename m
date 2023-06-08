Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 466427286AA
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 19:54:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236024AbjFHRyr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 13:54:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231336AbjFHRyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 13:54:45 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2071.outbound.protection.outlook.com [40.107.100.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B04982D6A;
        Thu,  8 Jun 2023 10:54:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FQ/pMA7c3/Mi+7Xp/E6OdvN0hswgnlVEtUgGilgI6YA22gHvIutp6IrIADllg9VE633cijDd8Q632kV8baZArcU+1VIriU1o4/8eC/flhTQIMlTTiU8A4HJcNmnELSgdWs+uoAd7emMxRzw1Zve8tratsyDhs51gvbzMf9Dj5kFMeCbk/Wc72OBDkJYBKIVzpyL8iQ+pviuC7WARDO9BTokVNC/YGAJEOBb+1dLrjbqxHA+CjY0GSZ2khlvsrVXLNGOISOTj/0+LD1lJMAB0ZGJx3eIKqFwALFRnS00I77oVqQTl5T83Z3SkoX87mlPKRqwlQtBsvBscAXWvmf/vDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d7sD+ORmXuDzPDkIJLGJ/J8tSBiUuS6MFTbvVMoF0Ng=;
 b=VLKCG9nXEr9ZAkxkcYtzmxrezEVor1eEVTIoIMg63HXuh1yVqtlvrKkidXK2m4o2fKJ4nym8nVr7ZIhkvhW8Sb52sPFtAK8TlyXQXK5m9bcGOOA2VnDjft0bC3Shy8f7QKPXVuXlqUtI+VWi36WxoZ9+iY5OEqy2+ktXggBSVLo5V4bNWkuSsAgfcbgEYfHhp8a2btS8shJv0De1cnMXo3E7kL/aYRUwnCmqiOTzbOa3PnULTMOWTqRnRhONGfU+O7QkWyctoewqGa1+Ku19d60aibZUE+WlG+a5GKulzQVsNhavX13Kpmd7bVNgkeLaHd3+kAH7eRll+8/HtAL/Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d7sD+ORmXuDzPDkIJLGJ/J8tSBiUuS6MFTbvVMoF0Ng=;
 b=ZBJD6gbmWrMC69KodwSDoL1MbknCO0SuyawViWeukZ/IUYTwv7rB2PTEnlIIVtCFgnuAbjhi/7ufEceOP2X3/fpOs1yIMtheg7/9N941ynzoESB3Sne6m0WB6jihHB9ZK5uvn2x0kH9NAoL64FOJB0MeM7C1Py7Pdso4RsC7sdY=
Received: from MW3PR05CA0003.namprd05.prod.outlook.com (2603:10b6:303:2b::8)
 by CH3PR12MB9148.namprd12.prod.outlook.com (2603:10b6:610:19d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Thu, 8 Jun
 2023 17:54:39 +0000
Received: from CO1NAM11FT073.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:2b:cafe::f5) by MW3PR05CA0003.outlook.office365.com
 (2603:10b6:303:2b::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.25 via Frontend
 Transport; Thu, 8 Jun 2023 17:54:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT073.mail.protection.outlook.com (10.13.174.196) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6477.24 via Frontend Transport; Thu, 8 Jun 2023 17:54:38 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 8 Jun
 2023 12:54:37 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <rafael@kernel.org>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <perry.yuan@amd.com>, <Ray.Huang@amd.com>, <Wyes.Karny@amd.com>,
        <gautham.shenoy@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        "Sun Peng Li" <sunpeng.li@amd.com>
Subject: [PATCH] cpufreq: amd-pstate: Set default governor to schedutil
Date:   Thu, 8 Jun 2023 04:53:58 -0500
Message-ID: <20230608095358.30548-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT073:EE_|CH3PR12MB9148:EE_
X-MS-Office365-Filtering-Correlation-Id: 1560cdee-c71a-4410-79cb-08db68496dc7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: puGc0q1FcbiLU/MY7KsZd7haGnHmJ/i5ubpRtzS7qg9iBe+SNYZWFlbwKee8LwNvicmjfaKuZEn0a5zxIH57RSEbnd9wNd+5bmx/S7QiVex1YOykUbPvOJXhBiYGWL7j4jxnJn+6yuYrZ/NaqKzP7TVcrKw+mPv4TSMr9LW9CDoyVLjxFt+IXQd8rTMg6ZtKnok53yfQ0Ot7HawPOtFEmIaVhxQmS6ESccpFIuMud26z5zgncMlvbYl20/zQQ9/jX5b/HAo3P3MxqcxLudaOKTZrq4y7vPPhBWQCLYbngPG3tVrbNh7NOiSk3e9CCHV1S2kdQCZcH1lUpzM0gzQhnIaL40coT6YLA7rCI1ebt0Pz5Ls3e4RDPpj5ZfovH/Ri7lq8eNz2oBJK7mZnwX0e/JkYyCgBbFjc+vAwNwTVw7q/NPp27liKKM4l93isoy/dUxrPPKpcVgnRWEOBTLNczXgiuV6FktZT0ZlL1O2LSlTfg3jaP0gqNcAmNBiqUsFSKfPKpk6icxDAalru+Xe/C380u+lLBy4U9X1tpyB5LK8anXgtoFGYSeO3YiCROaxAFlfrsAGspd7+8Gkk5uEgAAUZYekmxO6kshXn8roTyIKYOAyswPokPoq4x1dyweDYosRQSqAa7qgMmdp+FXzOAoK5WD5ylBsNhPtbmPWUPZweTq2C+kTm6G/SFn/LfcB9D4CBaj7jTqxVhTC+FEkZNBMOWRs3WKQZMh4wSoq/X405eehfCBVJdSwDP2tw78I4t3eLN5KqL/V9Ok62Wa9gag==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(396003)(39860400002)(346002)(451199021)(46966006)(36840700001)(40470700004)(40460700003)(70586007)(70206006)(316002)(6916009)(4326008)(54906003)(478600001)(86362001)(36756003)(6666004)(47076005)(83380400001)(36860700001)(1076003)(26005)(426003)(336012)(16526019)(186003)(41300700001)(8936002)(82310400005)(8676002)(5660300002)(44832011)(2906002)(7696005)(40480700001)(356005)(81166007)(82740400003)(2616005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2023 17:54:38.5185
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1560cdee-c71a-4410-79cb-08db68496dc7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT073.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9148
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Kconfig currently defaults the governor to schedutil on x86_64
only when intel-pstate and SMP have been selected.

If the kernel is built only with amd-pstate, the default governor
should also be schedutil.

Cc: Sun Peng (Leo) Li <sunpeng.li@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/cpufreq/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
index 2c839bd2b051..a1c51abddbc5 100644
--- a/drivers/cpufreq/Kconfig
+++ b/drivers/cpufreq/Kconfig
@@ -38,7 +38,7 @@ choice
 	prompt "Default CPUFreq governor"
 	default CPU_FREQ_DEFAULT_GOV_USERSPACE if ARM_SA1110_CPUFREQ
 	default CPU_FREQ_DEFAULT_GOV_SCHEDUTIL if ARM64 || ARM
-	default CPU_FREQ_DEFAULT_GOV_SCHEDUTIL if X86_INTEL_PSTATE && SMP
+	default CPU_FREQ_DEFAULT_GOV_SCHEDUTIL if (X86_INTEL_PSTATE || X86_AMD_PSTATE) && SMP
 	default CPU_FREQ_DEFAULT_GOV_PERFORMANCE
 	help
 	  This option sets which CPUFreq governor shall be loaded at
-- 
2.34.1

