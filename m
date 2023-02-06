Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A19368BFE3
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 15:19:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231364AbjBFOTR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 09:19:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230449AbjBFOTM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 09:19:12 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2051.outbound.protection.outlook.com [40.107.223.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51A4B193F7
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 06:19:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TmneaMod6IjbA8c2ymLF+1fBxiVr1B/cD1IanVAbM0sQ4ghuTTlISvs01KsxiQrNUoYwytNG9K9uFbvYd+Ezc6XtIYGqDGoWo1zqQD1RuYUeRIO6+LfEDdwtGN6Fje43fBT0RRF1AsneMl1UHllC0R/YQKuPhOr2ztbDg06hRkpROTrisDbqOcxElD4za0CfvoG36T/sS+KiNROhGXzBoX9AaI6LT4+AUaiYBqnTcjGwolrBBXJRxWwlHB4FxYw3k2upEiGljl5080VrLkxqrXR3I5HZj+AEYCYcIk/b6KC4o4YmqRABvd2auslYOSSHiFxEf9a9d+/gYCjco1anng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gs4ObJmBRyipuIjMB1wLT5WB2xTlFePIQKW+YLQlJA4=;
 b=FTH7OATqZqfj9CBTqBLA25netMZfAGcCWlb3QIaulK05ZWxyP8oxBu+NTiiuZQvchPvISNAHGuxr/uAMU5JWnolV15PkoYEHi/DabvBKlEuCR8t5FDDKOZCGRMvuSnP6ldVMfnATzLr4FTULs6GDc3MHWSm9WMSSBB2whSh5QdjrpW1Q1uQNuftrkPCNjJpynXFybqDqXczY666OfSKwjAbUM3AU/AaTJm9ukRc3qGIfWv94qhUmT4FomG7aeuf/qDG8L9jLqGvjn0WzCEsfsqoJN1c8H874jocEt0j6O1Ey4O2PT++Hr3PD8TrvW/ihn/dIUvdUTbCqZSAdj802vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gs4ObJmBRyipuIjMB1wLT5WB2xTlFePIQKW+YLQlJA4=;
 b=s07rLSQExU6NAqfxBDs5V0ALGxBPzBhX5BCqJcM3R0LugmQk6EgJUeLYRy9mM3C82vs0j0LalTGItqRj4gUqZK2smFbY63rndQzBIEUddQUrgvx0U6/2wKjEHOK4gDLNQqgGaxQ17pmH9I1QXzhYQbNXc+Go+eewHJkFNcDoC2g=
Received: from MW4PR04CA0354.namprd04.prod.outlook.com (2603:10b6:303:8a::29)
 by SA1PR12MB5638.namprd12.prod.outlook.com (2603:10b6:806:229::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.31; Mon, 6 Feb
 2023 14:19:01 +0000
Received: from CO1NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8a:cafe::65) by MW4PR04CA0354.outlook.office365.com
 (2603:10b6:303:8a::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.35 via Frontend
 Transport; Mon, 6 Feb 2023 14:19:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT060.mail.protection.outlook.com (10.13.175.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6064.31 via Frontend Transport; Mon, 6 Feb 2023 14:19:00 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 6 Feb
 2023 08:18:59 -0600
From:   Terry Bowman <terry.bowman@amd.com>
To:     <terry.bowman@amd.com>, <linux-kernel@vger.kernel.org>,
        <bp@suse.de>, <feng.tang@intel.com>, <x86@kernel.org>
Subject: [PATCH 2/3] tools/x86/kcpuid: Update AMD leaf Fn80000001
Date:   Mon, 6 Feb 2023 08:18:31 -0600
Message-ID: <20230206141832.4162264-3-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230206141832.4162264-1-terry.bowman@amd.com>
References: <20230206141832.4162264-1-terry.bowman@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT060:EE_|SA1PR12MB5638:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a42c679-8461-44f7-ab32-08db084d17f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c4QFefqqS77PAYq53lcR8EjsAv7W0XqgS/YDa4/1w6zrMzVngVcOg8lPaJ4ZGibtXpff+JKxgkF/IFezb0wTewuMsdfQgb8gP0S6AHgV19thZqlRfKd81JYri8Mf6iQS57GcMOd3Y41x1P1ZQILJRA5ycdmHXkZfh3CzsgZnVeQ7Qg5fRMz2BfjwujX7y0ErsnGe5Y3yPjFZaAZDNdG8I6SNiGDcD5zQclphY9IsQ0AqJx19aVXRisRwjveQDHTK6zg+ClZlXbsbHXi2+/cWYMZP0oMvAEx8u+FFDHwV7GIyAZOfS/EkzqRLHinPIhfTg9BkmGzxkEWZ9PFO6VxBPh0k+g2HhZHYQ8yfsQMdQj8viGKRePvrTCKTUnPfGenT+ACNFOPGpwIFPbIOzVjms4ueaseHLzJVRWtnFG1uXOh/PIWh9eIl5ltTGmWdMoV78l+CT8qAH/Xv3+AiEvMoDFIKzHYgSijPY5AbRSyBSC4OOSk+e0HKurIC63BZN9mBFDWi/+RY1iTgKc6JqyIljRob0IrIJrvc3MBOBhdfD/rdyV2A5MNfXuPorWThQKWEOhZHbbrRkL1vI6LS1zReaSSxbqzvhWdnhUeJ080pxC9AdGmNd2pp9nSe40sssV2hk4orFJtjHcDM5JAqef6U3YvXJXYS7IqOHLLZLSzPwIahoe+ZGFual+nzyAGP4pglUg/zDoahw1gq3dMkEW656ZUGmTOtUnvuEr/OmEGlS7w=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(346002)(396003)(39860400002)(376002)(136003)(451199018)(40470700004)(36840700001)(46966006)(2906002)(316002)(478600001)(6666004)(44832011)(8936002)(7696005)(70206006)(41300700001)(40460700003)(70586007)(1076003)(110136005)(5660300002)(8676002)(82310400005)(40480700001)(336012)(82740400003)(36860700001)(426003)(83380400001)(16526019)(47076005)(356005)(36756003)(86362001)(2616005)(26005)(81166007)(186003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2023 14:19:00.8621
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a42c679-8461-44f7-ab32-08db084d17f2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5638
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing features to sub-leafs EAX, ECX, and EDX of 'Extended
Processor Signature and Feature Bits' leaf Fn80000001.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
---
 tools/arch/x86/kcpuid/cpuid.csv | 57 +++++++++++++++++++++++++++++++--
 1 file changed, 54 insertions(+), 3 deletions(-)

diff --git a/tools/arch/x86/kcpuid/cpuid.csv b/tools/arch/x86/kcpuid/cpuid.csv
index 9914bdf4fc9e..e0c25b75327e 100644
--- a/tools/arch/x86/kcpuid/cpuid.csv
+++ b/tools/arch/x86/kcpuid/cpuid.csv
@@ -340,19 +340,70 @@
 # According to SDM
 # 40000000H - 4FFFFFFFH is invalid range
 
-
 # Leaf 80000001H
 # Extended Processor Signature and Feature Bits
 
+0x80000001,    0,  EAX,  27:20, extfamily, Extended family
+0x80000001,    0,  EAX,  19:16, extmodel, Extended model
+0x80000001,    0,  EAX,   11:8, basefamily, Description of Family
+0x80000001,    0,  EAX,   11:8, basemodel, Model numbers vary with product
+0x80000001,    0,  EAX,    3:0, stepping, Processor stepping (revision) for a specific model
+
+0x80000001,    0,  EBX,  31:28, pkgtype, Specifies the package type
+
 0x80000001,    0,  ECX,      0, lahf_lm, LAHF/SAHF available in 64-bit mode
+0x80000001,    0,  ECX,      1, cmplegacy, Core multi-processing legacy mode
+0x80000001,    0,  ECX,      2, svm, Indicates support for: VMRUN, VMLOAD, VMSAVE, CLGI, VMMCALL, and INVLPGA
+0x80000001,    0,  ECX,      3, extapicspace, Extended APIC register space
+0x80000001,    0,  ECX,      4, altmovecr8, Indicates support for LOCK MOV CR0 means MOV CR8
 0x80000001,    0,  ECX,      5, lzcnt, LZCNT
+0x80000001,    0,  ECX,      6, sse4a, EXTRQ, INSERTQ, MOVNTSS, and MOVNTSD instruction support
+0x80000001,    0,  ECX,      7, misalignsse, Misaligned SSE Mode
 0x80000001,    0,  ECX,      8, prefetchw, PREFETCHW
-
+0x80000001,    0,  ECX,      9, osvw, OS Visible Work-around support
+0x80000001,    0,  ECX,     10, ibs, Instruction Based Sampling
+0x80000001,    0,  ECX,     11, xop, Extended operation support
+0x80000001,    0,  ECX,     12, skinit, SKINIT and STGI support
+0x80000001,    0,  ECX,     13, wdt, Watchdog timer support
+0x80000001,    0,  ECX,     15, lwp, Lightweight profiling support
+0x80000001,    0,  ECX,     16, fma4, Four-operand FMA instruction support
+0x80000001,    0,  ECX,     17, tce, Translation cache extension
+0x80000001,    0,  ECX,     22, TopologyExtensions, Indicates support for Core::X86::Cpuid::CachePropEax0 and Core::X86::Cpuid::ExtApicId
+0x80000001,    0,  ECX,     23, perfctrextcore, Indicates support for Core::X86::Msr::PERF_CTL0 - 5 and Core::X86::Msr::PERF_CTR
+0x80000001,    0,  ECX,     24, perfctrextdf, Indicates support for Core::X86::Msr::DF_PERF_CTL and Core::X86::Msr::DF_PERF_CTR
+0x80000001,    0,  ECX,     26, databreakpointextension, Indicates data breakpoint support for Core::X86::Msr::DR0_ADDR_MASK, Core::X86::Msr::DR1_ADDR_MASK, Core::X86::Msr::DR2_ADDR_MASK and Core::X86::Msr::DR3_ADDR_MASK
+0x80000001,    0,  ECX,     27, perftsc, Performance time-stamp counter supported
+0x80000001,    0,  ECX,     28, perfctrextllc, Indicates support for L3 performance counter extensions
+0x80000001,    0,  ECX,     29, mwaitextended, MWAITX and MONITORX capability is supported
+0x80000001,    0,  ECX,     30, admskextn, Indicates support for address mask extension (to 32 bits and to all 4 DRs) for instruction breakpoints
+
+0x80000001,    0,  EDX,      0, fpu, x87 floating point unit on-chip
+0x80000001,    0,  EDX,      1, vme, Virtual-mode enhancements
+0x80000001,    0,  EDX,      2, de, Debugging extensions, IO breakpoints, CR4.DE
+0x80000001,    0,  EDX,      3, pse, Page-size extensions (4 MB pages)
+0x80000001,    0,  EDX,      4, tsc, Time stamp counter, RDTSC/RDTSCP instructions, CR4.TSD
+0x80000001,    0,  EDX,      5, msr, Model-specific registers (MSRs), with RDMSR and WRMSR instructions
+0x80000001,    0,  EDX,      6, pae, Physical-address extensions (PAE)
+0x80000001,    0,  EDX,      7, mce, Machine Check Exception, CR4.MCE
+0x80000001,    0,  EDX,      8, cmpxchg8b, CMPXCHG8B instruction
+0x80000001,    0,  EDX,      9, apic, advanced programmable interrupt controller (APIC) exists and is enabled
 0x80000001,    0,  EDX,     11, sysret, SYSCALL/SYSRET supported
+0x80000001,    0,  EDX,     12, mtrr, Memory-type range registers
+0x80000001,    0,  EDX,     13, pge, Page global extension, CR4.PGE
+0x80000001,    0,  EDX,     14, mca, Machine check architecture, MCG_CAP
+0x80000001,    0,  EDX,     15, cmov, Conditional move instructions, CMOV, FCOMI, FCMOV
+0x80000001,    0,  EDX,     16, pat, Page attribute table
+0x80000001,    0,  EDX,     17, pse36, Page-size extensions
 0x80000001,    0,  EDX,     20, exec_dis, Execute Disable Bit available
+0x80000001,    0,  EDX,     22, mmxext, AMD extensions to MMX instructions
+0x80000001,    0,  EDX,     23, mmx, MMX instructions
+0x80000001,    0,  EDX,     24, fxsr, FXSAVE and FXRSTOR instructions
+0x80000001,    0,  EDX,     25, ffxsr, FXSAVE and FXRSTOR instruction optimizations
 0x80000001,    0,  EDX,     26, 1gb_page, 1GB page supported
 0x80000001,    0,  EDX,     27, rdtscp, RDTSCP and IA32_TSC_AUX are available
-#0x80000001,    0,  EDX,     29, 64b, 64b Architecture supported
+0x80000001,    0,  EDX,     29, lm, 64b Architecture supported
+0x80000001,    0,  EDX,     30, threednowext, AMD extensions to 3DNow! instructions
+0x80000001,    0,  EDX,     31, threednow, 3DNow! instructions
 
 # Leaf 80000002H/80000003H/80000004H
 # Processor Brand String
-- 
2.34.1

