Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9159461A36D
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 22:37:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbiKDVh1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 17:37:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbiKDVhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 17:37:19 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56ACD4C256;
        Fri,  4 Nov 2022 14:37:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hOzTKykyDpvw5lGelvg4O8ePoLEw0KUBPfvdQ3gtfrCNOsm29Mg4d+8t+ron/vnrNmLXz+NIHoh8eoybAmm+Yf5p44pg+L7tdhObSVQVc8XAFKvMw+6U7v5GP+1kog5K3HwwuqbPofEA8etxtN63ZhKYM7qGBrwZnrIbi48KWZeRS2kZuzOxmYw/vQJ2wqjpB/Eg/25ynaWkEpxTcyIRKlUz4APfnJX6x1y0322fffTZdREYHK71agASHN5nLmiYLhkJmYtOGluZknNegiZYlfwiQjPOjfsTkpAh3KOtPKTLD/PViMUWhPsw/r/A8HgsoNu0ytuRS3NVNuQj8S7geQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rm7f7A1Jscu+AFisKyVt+RNyu+7sc/UoBD4L/M5QmlU=;
 b=RtxbBa/Kr9auNZd17WtgYIHt4h94RNhzDDj5le8SiM/3oZBaSMw1JZhc8/VKvb1QJWJZKDuCguOkKSFcsiGz+wsEsbrPMwgZ4fYWprtne2nCFNgMYa+ycD9b5Z6gOnuCFrC8vv61yazJZgEPK/MuDOvAKgxwe68br/qfzEO6OntRgn6vgCwXkvkF5mJbOp14cuFYnyQcyXyCpyq1E9j5du5QnWkUTOfmoOHnC9U//rrbWp2ECdAiwiPdlmOXXaE2EFfk2B0kgq+13ER0n/UQji4VpMSvg5bcByfPYtdytEYMjVkLUe25o+J0uHAFM518htrHpPZf0fHTqcPj0afbHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rm7f7A1Jscu+AFisKyVt+RNyu+7sc/UoBD4L/M5QmlU=;
 b=d1aQCTpyR4BcU4P/3soKyCFlYTFkZM0zN8kgEGjpgMMSixuI6UdVuDKpkel0gKvCxKxWFzrwyPoarntFKp0BrABYQpOX2e4irym1fHvzSrU92xyryCFeMTsenMDdbOsWXzpOvPe6qhpZ0/1BRduwp1y96tlGIfyJFcbaBbINMoQ=
Received: from DM6PR02CA0042.namprd02.prod.outlook.com (2603:10b6:5:177::19)
 by MN2PR12MB4391.namprd12.prod.outlook.com (2603:10b6:208:269::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Fri, 4 Nov
 2022 21:37:15 +0000
Received: from DM6NAM11FT107.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:177:cafe::1a) by DM6PR02CA0042.outlook.office365.com
 (2603:10b6:5:177::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22 via Frontend
 Transport; Fri, 4 Nov 2022 21:37:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT107.mail.protection.outlook.com (10.13.172.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5791.20 via Frontend Transport; Fri, 4 Nov 2022 21:37:15 +0000
Received: from fritz.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 4 Nov
 2022 16:37:14 -0500
From:   Kim Phillips <kim.phillips@amd.com>
To:     <x86@kernel.org>
CC:     Kim Phillips <kim.phillips@amd.com>,
        Borislav Petkov <bp@alien8.de>,
        "Boris Ostrovsky" <boris.ostrovsky@oracle.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        "Paolo Bonzini" <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Juergen Gross <jgross@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tony Luck <tony.luck@intel.com>,
        Babu Moger <Babu.Moger@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>, <kvm@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/3] x86/cpufeatures: Add support for cpuid leaf 80000021/EAX (FeatureExt2Eax)
Date:   Fri, 4 Nov 2022 16:36:49 -0500
Message-ID: <20221104213651.141057-2-kim.phillips@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221104213651.141057-1-kim.phillips@amd.com>
References: <20221104213651.141057-1-kim.phillips@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT107:EE_|MN2PR12MB4391:EE_
X-MS-Office365-Filtering-Correlation-Id: 859a2db1-5652-4834-558a-08dabeacbde3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LbT0uMpGTdzAcksglWz+4tAVhscPpoDK2q5H++s2ilpHACFJao6T+ZcbHAmdihYJBiVdQvgDLzNtUfLy1BHM4LqQb8Ja8YGlsI46wSDl3dgfDW8qQbbzkrZtPzkcp/p/rr5nYFHomb3bMTmEnx7rARATn+ACB8Bb582CbJhW934PzDu5pz1yOcxyfJxTGavaRRoBvypKv/L3diIPmhTMbu8JLGV3ABPVa/5ut4w6pXQNyQpl0PABKmINlhgfuAAAJZ5R66p0SrdRmMFTeZGPBQv1jUu2a/pnR1R+uCYzv9wSADPMhveGrQpyzFrhmvdzvDOlaFe0RKWqJIC3xbKxlxgHFA3Hm/RpCa4Lsj6qPl+4Q8rJbJLhzQZqOJl9Odq3WZsPVBTFMjSjVubTUaY7bYRJOT0HrVwPsntJ1gBcXFbOPqBxFxNg9sKXV0Dy1+ToAAmzE/7d5ou0DL1HbRDDUMvnyEnIQah0sIh8iijtbF7fAOw7+fuP9glIlZWPsOv7xTauUyqfZzqZhv9V5gnIXjz6TS1HtLE2Ul2Kd5fjP1vreGYZpcio1BWOxmJ15z3uc8c+BAQ8sk7b2+cIhaL9Rpp6NWE3hzyX4uKMiIM3Jzb6GhAfETOaZ7dSeTpPY3gBDWXNdzYZFvihip27rhH/9WOJbAJZ/sTzukOBVGOdDSCj3IypMi5zEno5iTPeqZn0ghBQWFwy85ep/IcPicEh9HKR7hq876peFm3h62nS2rtE1gUZBkXC4Yw8H0kXsR076C0x29nTXGZ67k1V1yew8OztvTFfXcSMmkSH/WjjFKZc2U4MBjqecrA4cRaJDP1b
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(39860400002)(396003)(136003)(451199015)(46966006)(40470700004)(36840700001)(6916009)(41300700001)(8936002)(5660300002)(26005)(478600001)(2616005)(44832011)(7416002)(336012)(1076003)(16526019)(186003)(83380400001)(4326008)(40480700001)(8676002)(70206006)(426003)(70586007)(6666004)(2906002)(36756003)(47076005)(356005)(7696005)(81166007)(82740400003)(36860700001)(82310400005)(40460700003)(54906003)(316002)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2022 21:37:15.5166
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 859a2db1-5652-4834-558a-08dabeacbde3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT107.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4391
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AMD Zen4 processors advertise features in this leaf.
Add the leaf and its Automatic IBRS feature bit.

Note: New whole leaf (vs a bit) due to propagation via KVM
later in this series.

Signed-off-by: Kim Phillips <kim.phillips@amd.com>
---
 arch/x86/include/asm/cpufeature.h        | 7 +++++--
 arch/x86/include/asm/cpufeatures.h       | 5 ++++-
 arch/x86/include/asm/disabled-features.h | 3 ++-
 arch/x86/include/asm/required-features.h | 3 ++-
 arch/x86/kernel/cpu/common.c             | 3 +++
 5 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/cpufeature.h b/arch/x86/include/asm/cpufeature.h
index 1a85e1fb0922..ce0c8f7d3218 100644
--- a/arch/x86/include/asm/cpufeature.h
+++ b/arch/x86/include/asm/cpufeature.h
@@ -32,6 +32,7 @@ enum cpuid_leafs
 	CPUID_8000_0007_EBX,
 	CPUID_7_EDX,
 	CPUID_8000_001F_EAX,
+	CPUID_8000_0021_EAX,
 };
 
 #define X86_CAP_FMT_NUM "%d:%d"
@@ -94,8 +95,9 @@ extern const char * const x86_bug_flags[NBUGINTS*32];
 	   CHECK_BIT_IN_MASK_WORD(REQUIRED_MASK, 17, feature_bit) ||	\
 	   CHECK_BIT_IN_MASK_WORD(REQUIRED_MASK, 18, feature_bit) ||	\
 	   CHECK_BIT_IN_MASK_WORD(REQUIRED_MASK, 19, feature_bit) ||	\
+	   CHECK_BIT_IN_MASK_WORD(REQUIRED_MASK, 20, feature_bit) ||	\
 	   REQUIRED_MASK_CHECK					  ||	\
-	   BUILD_BUG_ON_ZERO(NCAPINTS != 20))
+	   BUILD_BUG_ON_ZERO(NCAPINTS != 21))
 
 #define DISABLED_MASK_BIT_SET(feature_bit)				\
 	 ( CHECK_BIT_IN_MASK_WORD(DISABLED_MASK,  0, feature_bit) ||	\
@@ -118,8 +120,9 @@ extern const char * const x86_bug_flags[NBUGINTS*32];
 	   CHECK_BIT_IN_MASK_WORD(DISABLED_MASK, 17, feature_bit) ||	\
 	   CHECK_BIT_IN_MASK_WORD(DISABLED_MASK, 18, feature_bit) ||	\
 	   CHECK_BIT_IN_MASK_WORD(DISABLED_MASK, 19, feature_bit) ||	\
+	   CHECK_BIT_IN_MASK_WORD(DISABLED_MASK, 20, feature_bit) ||	\
 	   DISABLED_MASK_CHECK					  ||	\
-	   BUILD_BUG_ON_ZERO(NCAPINTS != 20))
+	   BUILD_BUG_ON_ZERO(NCAPINTS != 21))
 
 #define cpu_has(c, bit)							\
 	(__builtin_constant_p(bit) && REQUIRED_MASK_BIT_SET(bit) ? 1 :	\
diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index aefd0816a333..45ea992716b8 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -13,7 +13,7 @@
 /*
  * Defines x86 CPU feature bits
  */
-#define NCAPINTS			20	   /* N 32-bit words worth of info */
+#define NCAPINTS			21	   /* N 32-bit words worth of info */
 #define NBUGINTS			1	   /* N 32-bit bug flags */
 
 /*
@@ -421,6 +421,9 @@
 #define X86_FEATURE_V_TSC_AUX		(19*32+ 9) /* "" Virtual TSC_AUX */
 #define X86_FEATURE_SME_COHERENT	(19*32+10) /* "" AMD hardware-enforced cache coherency */
 
+/* AMD-defined Extended Feature 2 EAX, CPUID level 0x80000021 (EAX), word 20 */
+#define X86_FEATURE_AUTOIBRS		(20*32+ 8) /* AMD Automatic IBRS */
+
 /*
  * BUG word(s)
  */
diff --git a/arch/x86/include/asm/disabled-features.h b/arch/x86/include/asm/disabled-features.h
index bbb03b25263e..9be4e0b01b9c 100644
--- a/arch/x86/include/asm/disabled-features.h
+++ b/arch/x86/include/asm/disabled-features.h
@@ -118,6 +118,7 @@
 #define DISABLED_MASK17	0
 #define DISABLED_MASK18	0
 #define DISABLED_MASK19	0
-#define DISABLED_MASK_CHECK BUILD_BUG_ON_ZERO(NCAPINTS != 20)
+#define DISABLED_MASK20	0
+#define DISABLED_MASK_CHECK BUILD_BUG_ON_ZERO(NCAPINTS != 21)
 
 #endif /* _ASM_X86_DISABLED_FEATURES_H */
diff --git a/arch/x86/include/asm/required-features.h b/arch/x86/include/asm/required-features.h
index aff774775c67..7ba1726b71c7 100644
--- a/arch/x86/include/asm/required-features.h
+++ b/arch/x86/include/asm/required-features.h
@@ -98,6 +98,7 @@
 #define REQUIRED_MASK17	0
 #define REQUIRED_MASK18	0
 #define REQUIRED_MASK19	0
-#define REQUIRED_MASK_CHECK BUILD_BUG_ON_ZERO(NCAPINTS != 20)
+#define REQUIRED_MASK20	0
+#define REQUIRED_MASK_CHECK BUILD_BUG_ON_ZERO(NCAPINTS != 21)
 
 #endif /* _ASM_X86_REQUIRED_FEATURES_H */
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 2bec4b4b2c50..070350c2c514 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1091,6 +1091,9 @@ void get_cpu_cap(struct cpuinfo_x86 *c)
 	if (c->extended_cpuid_level >= 0x8000001f)
 		c->x86_capability[CPUID_8000_001F_EAX] = cpuid_eax(0x8000001f);
 
+	if (c->extended_cpuid_level >= 0x80000021)
+		c->x86_capability[CPUID_8000_0021_EAX] = cpuid_eax(0x80000021);
+
 	init_scattered_cpuid_features(c);
 	init_speculation_control(c);
 
-- 
2.34.1

