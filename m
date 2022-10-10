Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C646E5FA1DC
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 18:24:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbiJJQYR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 12:24:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230007AbiJJQYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 12:24:10 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2071.outbound.protection.outlook.com [40.107.220.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BD5F753B5;
        Mon, 10 Oct 2022 09:23:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ob5QrLavjXDK9nR2+nWGkxWbTki5VcrCZ0Lw4yVGrF6Sue9SzHJcJgZGnl8DBzCw3DyCqM0wHqsY0JbcySjLHnyFTJ40iudSGB1i/6l79LXiuoCGR9EcV7CrLNGECAZ6H217k/kocAKlN9exqUMibXUGlPyhGRp2kyWjUVRNkE8uaOGJXK47RR2FmG1Toko6q1ZPPE8fAdEpRrCT+sK+VjLi0JfQ1zKV4cf5JELVlUrGvl/cbrX+4+HT65w9lenCjRS6yMDTDsCFCMGKrvN1Yqv+v87V1Wew4AONSXsuwtCwahkI3l7VPbatMWDYvQZRRPTQQU5Jr4noKNfS/nJXRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eyOdA0xgsn2S6ntfuGkWBS+LaNrHdTzhR45MQZboLBo=;
 b=Eqglwv7ezmEFgZqsCsf8ljkrWc+WgOO+cw3t0t5eJlA+GzPEJIFX9h3wjeCCZh1i8jIfieKBDeSAP864FLH4GApyAJER5eLLw7Ni69wtv8Gqe23XMCyyigjOzncq3/H1bM67jjYI7PsdZhd6br5ovggghsxArzDHuQyTIgG/RbUz7dfAGcQZ/aY6NsVrleHLU5yRAo5rBpg5ByQnMunfGYr6KogLIRvsN2Im4Ro4eGWvVwxn9B5sGM1psB/ZLVuPaoS/0e7MXq6KAAziIQGB1TlQ8GprHQaf9z8nmnb7Asv0zdAPH8DgTS2YOh2YHJCyQRlluApD3teHO0Guf6wd2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eyOdA0xgsn2S6ntfuGkWBS+LaNrHdTzhR45MQZboLBo=;
 b=mieel/BFUysHOVvLCEGmJCwozBWEAxGy0BHYFlh7wxWBpBegJK/+5GUfjkxM0+EBz3KHMUCfVrIg3pFSpCSFeXLn0aHajBla4n+N9QAfOGUChp7uriRKFmEr+VGMYUL6dfpLxQYQDBN5FtbW1deALwMqqStr4iHRvpawlTzkc+Y=
Received: from DM6PR07CA0041.namprd07.prod.outlook.com (2603:10b6:5:74::18) by
 IA1PR12MB6577.namprd12.prod.outlook.com (2603:10b6:208:3a3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24; Mon, 10 Oct
 2022 16:23:47 +0000
Received: from DM6NAM11FT103.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:74:cafe::f1) by DM6PR07CA0041.outlook.office365.com
 (2603:10b6:5:74::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.17 via Frontend
 Transport; Mon, 10 Oct 2022 16:23:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT103.mail.protection.outlook.com (10.13.172.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5709.10 via Frontend Transport; Mon, 10 Oct 2022 16:23:46 +0000
Received: from pyuan-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 10 Oct 2022 11:23:21 -0500
From:   Perry Yuan <Perry.Yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <ray.huang@amd.com>,
        <viresh.kumar@linaro.org>
CC:     <Deepak.Sharma@amd.com>, <Mario.Limonciello@amd.com>,
        <Nathan.Fontenot@amd.com>, <Alexander.Deucher@amd.com>,
        <Shimmer.Huang@amd.com>, <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Perry Yuan <Perry.Yuan@amd.com>
Subject: [RESEND PATCH V2 4/9] x86/msr: Add the MSR definition for AMD CPPC boost state
Date:   Tue, 11 Oct 2022 00:22:43 +0800
Message-ID: <20221010162248.348141-5-Perry.Yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221010162248.348141-1-Perry.Yuan@amd.com>
References: <20221010162248.348141-1-Perry.Yuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT103:EE_|IA1PR12MB6577:EE_
X-MS-Office365-Filtering-Correlation-Id: dec7b300-dcc3-4668-c576-08daaadbcebf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QjaqWKfsxfu7wjx5c8u3w6s9Rifs9JDyqNltEaaAAvoVegNCf2Fg8ZqK0xqXrimRzmSkAs4CpXMx/XqDUbwIlWSOGTWEhJUmZJFdNyYAuYxDaWQnrx9VAof6TgW4fOsmnn+OFl7r0zoBhaucrSy0PfOMda6zej5qWsA8SXmVZKXwDsFr+IvtI1cxexFi/37OT4W5CiU7rjLWdFgPuIfx4+B2TrUKaSAQ33/HJNZgBMLgKtSDhbkmHvV4Qu/wR/zckqxSicRpL6RJYMVsKoiH6tia/i0ADllRVQSP7HonGsPpyJxjxUH15oJPyjm98VqYgWvA8fnGe4wsCvphrp1vUCMOe/UAFey4ZCekwZ0sPs9fi4Tr8pOwRwkRq9rrLoPWnUjpJuHzEVnXt3J40mnGoz8g4tnV58TG1DQ5OG4o6u6/e4wlYMEBArrfgJf1XTbPbYWTFt/88lZvgIP5uYSYDKx3pM0nKopHgJdmlMVe5niFlanjZr8sc0X1HcF0z+hKE0N3UabR7y6OW99WGR/Bh5j/QHn6R8XnoPPRL00dtsJB4ZZoWw/zIs9nIKPU784yPT9+w1i8kX3pjmn3rETO/bAve1viL/j6O/XcDT9ffumzT4ST1gtqKQVg6kD4OgBax9OE0g/sWrsVTkw3Q9olUgnHW2LxIFXHrrItD13Fz2OnmZ4JFj9Ic47zHYQiZd95DgdClpiHg/LzbJWFU0YHBav/57k7INTKg0y8pn9MP6NXvB03rLlClBs6JKwy9pl1ZLnkOPm3Rj9YmlEBR+q2pzmNh1Oj9bO8S/L1y2kMqJ/NkjuW8x+R3eoaDGjS3KwFtrvwfbd0P/AQQrUnTCLEWSUQwLOzU/ClXl3ZzXhzzrF5ARozYTT3cSSXj5to2lvgalmmoQiL1aWWvrtQ9aPT9A==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(346002)(136003)(376002)(451199015)(46966006)(40470700004)(36840700001)(5660300002)(8936002)(336012)(426003)(110136005)(83380400001)(966005)(54906003)(4326008)(86362001)(316002)(16526019)(8676002)(478600001)(40460700003)(40480700001)(2906002)(6666004)(70206006)(186003)(81166007)(1076003)(26005)(47076005)(82310400005)(356005)(70586007)(2616005)(82740400003)(36860700001)(36756003)(7696005)(41300700001)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2022 16:23:46.8955
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dec7b300-dcc3-4668-c576-08daaadbcebf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT103.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6577
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This MSR can be used to check whether the CPU frequency boost state
is enabled in the hardware control. User can change the boost state in
the BIOS setting,amd_pstate driver will update the boost state according
to this msr value.

AMD Processor Programming Reference (PPR)
Link: https://www.amd.com/system/files/TechDocs/40332.pdf [p1095]
Link: https://www.amd.com/system/files/TechDocs/56569-A1-PUB.zip [p162]

Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
---
 arch/x86/include/asm/msr-index.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 6674bdb096f3..e5ea1c9f747b 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -569,6 +569,7 @@
 #define MSR_AMD_CPPC_CAP2		0xc00102b2
 #define MSR_AMD_CPPC_REQ		0xc00102b3
 #define MSR_AMD_CPPC_STATUS		0xc00102b4
+#define MSR_AMD_CPPC_HW_CTL		0xc0010015
 
 #define AMD_CPPC_LOWEST_PERF(x)		(((x) >> 0) & 0xff)
 #define AMD_CPPC_LOWNONLIN_PERF(x)	(((x) >> 8) & 0xff)
@@ -579,6 +580,8 @@
 #define AMD_CPPC_MIN_PERF(x)		(((x) & 0xff) << 8)
 #define AMD_CPPC_DES_PERF(x)		(((x) & 0xff) << 16)
 #define AMD_CPPC_ENERGY_PERF_PREF(x)	(((x) & 0xff) << 24)
+#define AMD_CPPC_PRECISION_BOOST_BIT   25
+#define AMD_CPPC_PRECISION_BOOST_ENABLED       BIT_ULL(AMD_CPPC_PRECISION_BOOST_BIT)
 
 /* AMD Performance Counter Global Status and Control MSRs */
 #define MSR_AMD64_PERF_CNTR_GLOBAL_STATUS	0xc0000300
-- 
2.34.1

