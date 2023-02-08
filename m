Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B98268E91C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 08:36:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231205AbjBHHgq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 02:36:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231195AbjBHHgk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 02:36:40 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2047.outbound.protection.outlook.com [40.107.94.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5494545893
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 23:36:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HBSPo9JHpVMYszezfhlJ96kG38TJDgblnmVJB0bAzqc7K1We5c0wtYwL0rQ85EsAoij0PupzZuihvdKxcluZGSFoFEdcYBx3PUdIwzvKgLSVd73vVGtEmrG+/mIS8AmzGOlH2BtGsmrK+cExNl2op9uHMK2//2Z6dUZjJroGThdN3t0DV4cGHWWsn5wV19UCLwBFWuKhUPf9f/ymYF5B+WOSBeJsACa9LwQee96ERuIH8aKswfU7G+WZKZFxZRCL7LfUtUiqZUOuTAbb1jNvIZ76M6Rtyw0+1ZFRWkvzOTjicSRK+Ugqodt00mUNlBUCGRuwdVtDryC6QVsr+R4f/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dFT8GmvQmeiy03Y13HF23aln8UNuD5lUUb3DZDujpbg=;
 b=OoS46GgIqIe0ssaEvWKothbSVB1HvtH0YqGB2+4ApxJ8NXewnXK4WuUzNp9wExC2/vjRMnlLHpx2JODvfQBOrwLg5D8DDLlLmzFPylbxTI6sRGpxF1tTu4S5lPifM4918lLhuZh2UmoHMTCbNQiBqpxrg4Bdxphph3N8HIFOxKKIF6etvnf5caV7bn71p8fxyed+S1iJEoesa5PpTDgQBpt1VMGBcS8YLxfx+Rf8hJPcCu1n7h2Ogl8TzkMO1AkaLfgruosykorqPZB8GRIAKqYytF3+F6yQrdXBWwziei0lRDspq/ZjPoo8VPHUjnLVJr8KiXvps2XY7Ayu7gXHlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dFT8GmvQmeiy03Y13HF23aln8UNuD5lUUb3DZDujpbg=;
 b=JzRVy5KR2SH7TfRUK4X3jpGlJI+KdceYJxW8qtF+Mv1vu6yEEcFSfwOaz4FYOBk7rxw/ZQ+G06yz5PSPtnAgI3b5EevJMnpIpZFc4fBeolyKbCHGRziDqGmba9y1cS8Mmsa2bNz/T2JbShswKOFmfEBNJV6G1OqaRdOKNcz7Si4=
Received: from BN0PR02CA0057.namprd02.prod.outlook.com (2603:10b6:408:e5::32)
 by CH0PR12MB5252.namprd12.prod.outlook.com (2603:10b6:610:d3::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.17; Wed, 8 Feb
 2023 07:36:33 +0000
Received: from BN8NAM11FT112.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e5:cafe::c4) by BN0PR02CA0057.outlook.office365.com
 (2603:10b6:408:e5::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.36 via Frontend
 Transport; Wed, 8 Feb 2023 07:36:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT112.mail.protection.outlook.com (10.13.176.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6086.17 via Frontend Transport; Wed, 8 Feb 2023 07:36:32 +0000
Received: from BLR-5CG1133937.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 8 Feb
 2023 01:36:28 -0600
From:   Bharata B Rao <bharata@amd.com>
To:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
CC:     <mgorman@suse.de>, <peterz@infradead.org>, <mingo@redhat.com>,
        <bp@alien8.de>, <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        <akpm@linux-foundation.org>, <luto@kernel.org>,
        <tglx@linutronix.de>, <yue.li@memverge.com>,
        <Ravikumar.Bangoria@amd.com>, Bharata B Rao <bharata@amd.com>
Subject: [RFC PATCH 1/5] x86/ibs: In-kernel IBS driver for page access profiling
Date:   Wed, 8 Feb 2023 13:05:29 +0530
Message-ID: <20230208073533.715-2-bharata@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230208073533.715-1-bharata@amd.com>
References: <20230208073533.715-1-bharata@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT112:EE_|CH0PR12MB5252:EE_
X-MS-Office365-Filtering-Correlation-Id: aac0a47c-063a-4ed3-3bd1-08db09a73364
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SBYK1lOWWJjQh79+FWgTdBqK9l3T9YWuVQ6SnuMeTcovWCPNTk175ShmVZuN/LFuBcB39nW+HRsn0D1xxR78+5Y6v61gJxakXCbNUoZCnNa9J4qWh36WR5dvf87GjtqAgBEfTMxo9EIkj9cDmOCWl15xL1gua1bdM4uVC5BwXCUaphPVq0cz9dFdakApzsrizMEBLErys5yCCah+DqX3LV6SMFa80Lk0uNpnWezB8NdHnAXPExHY8gIAfJtf3G3dGmeTPe4VN4Yic8PGjVeieA4eriGaAFOtFMV1CrXnJCLuu69/hieIBgGHJzRp6qlYJEh71Z2k0OpefCSxvAdbPpTWp0FC/utdFS8RBDvjhwul6i4/kL6d7NJmxfNAbHMSNTivkGsM5+DcF5a8Y4hobuODOg4um770a2b1cgTD+zILMTEPVCgmna0YWnHZwJ/QUGVkono23TwQE80ItCi1fw7xrs6sluHGuSzeqyFjRs0aTxaHYXtXekAWn9Rw7W6lT3xNQV6gQ2swXup68PaYn/1TRaybEJOWChmrVZNgDS7bZ2EhW2SoBY3/nmhTeoyggw/ImI37PExA+q/t5cB+nqDIUfnYIlST/KpT/wmjiDEOAAnxGu+g6q62N9YJI5TuRJK9NiCvwwrelQjJzQ8g70jOZ0weANAuDv83m6z+/ywpJcx2vxB/WahCY7Qz2m90FoGauwMzFNfWpTCbn38pY1JZSfS4ME7sTpK5Go5U+NsmvEfLozNbgZXOQlPz4WDgc9BoO185BhCJzcBPwBea4o567O5zZOknTwS+TjJySlbBoh8ZQqmQzr7dqg+EgdXQ
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(136003)(396003)(376002)(346002)(39860400002)(451199018)(46966006)(36840700001)(40470700004)(40480700001)(36756003)(82740400003)(8676002)(1076003)(4326008)(7696005)(86362001)(478600001)(47076005)(110136005)(54906003)(316002)(40460700003)(966005)(70586007)(26005)(70206006)(186003)(16526019)(7416002)(5660300002)(426003)(36860700001)(336012)(83380400001)(2906002)(81166007)(8936002)(82310400005)(356005)(41300700001)(2616005)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2023 07:36:32.8983
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aac0a47c-063a-4ed3-3bd1-08db09a73364
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT112.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5252
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use IBS (Instruction Based Sampling) feature present
in AMD processors for memory access tracking. The access
information obtained from IBS will be used in subsequent
patches to drive NUMA balancing.

An NMI handler is registered to obtain the IBS data. The
handler does nothing much yet. It just filters out the
non-useful samples and collects some stats. This patch
just builds the framework and IBS execution sampling is
enabled only in a subsequent patch.

TODOs
-----
1. Perf also uses IBS. For the purpose of this prototype
   just disable the use of IBS in perf. This needs to be
   done cleanly.
2. Only the required MSR bits are defined here.

About IBS
---------
IBS can be programmed to provide data about instruction
execution periodically. This is done by programming a desired
sample count (number of ops) in a control register. When the
programmed number of ops are dispatched, a micro-op gets tagged,
various information about the tagged micro-op's execution is
populated in IBS execution MSRs and an interrupt is raised.
While IBS provides a lot of data for each sample, for the
purpose of  memory access profiling, we are interested in
linear and physical address of the memory access that reached
DRAM. Recent AMD processors provide further filtering where
it is possible to limit the sampling to those ops that had
an L3 miss which greately reduces the non-useful samples.

While IBS provides capability to sample instruction fetch
and execution, only IBS execution sampling is used here
to collect data about memory accesses that occur during
the instruction execution.

More information about IBS is available in Sec 13.3 of
AMD64 Architecture Programmer's Manual, Volume 2:System
Programming which is present at:
https://bugzilla.kernel.org/attachment.cgi?id=288923

Information about MSRs used for programming IBS can be
found in Sec 2.1.14.4 of PPR Vol 1 for AMD Family 19h
Model 11h B1 which is currently present at:
https://www.amd.com/system/files/TechDocs/55901_0.25.zip

Signed-off-by: Bharata B Rao <bharata@amd.com>
---
 arch/x86/events/amd/ibs.c        |   6 ++
 arch/x86/include/asm/msr-index.h |  12 +++
 arch/x86/mm/Makefile             |   1 +
 arch/x86/mm/ibs.c                | 169 +++++++++++++++++++++++++++++++
 include/linux/vm_event_item.h    |  11 ++
 mm/vmstat.c                      |  11 ++
 6 files changed, 210 insertions(+)
 create mode 100644 arch/x86/mm/ibs.c

diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index da3f5ebac4e1..290e6d221844 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -1512,6 +1512,12 @@ static __init int amd_ibs_init(void)
 {
 	u32 caps;
 
+	/*
+	 * TODO: Find a clean way to disable perf IBS so that IBS
+	 * can be used for NUMA balancing.
+	 */
+	return 0;
+
 	caps = __get_ibs_caps();
 	if (!caps)
 		return -ENODEV;	/* ibs not supported by the cpu */
diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 37ff47552bcb..443d4cf73366 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -593,6 +593,18 @@
 /* AMD Last Branch Record MSRs */
 #define MSR_AMD64_LBR_SELECT			0xc000010e
 
+/* AMD IBS MSR bits */
+#define MSR_AMD64_IBSOPDATA2_DATASRC			0x7
+#define MSR_AMD64_IBSOPDATA2_DATASRC_DRAM		0x3
+#define MSR_AMD64_IBSOPDATA2_DATASRC_FAR_CCX_CACHE	0x5
+
+#define MSR_AMD64_IBSOPDATA3_LDOP		BIT_ULL(0)
+#define MSR_AMD64_IBSOPDATA3_STOP		BIT_ULL(1)
+#define MSR_AMD64_IBSOPDATA3_DCMISS		BIT_ULL(7)
+#define MSR_AMD64_IBSOPDATA3_LADDR_VALID	BIT_ULL(17)
+#define MSR_AMD64_IBSOPDATA3_PADDR_VALID	BIT_ULL(18)
+#define MSR_AMD64_IBSOPDATA3_L2MISS		BIT_ULL(20)
+
 /* Fam 17h MSRs */
 #define MSR_F17H_IRPERF			0xc00000e9
 
diff --git a/arch/x86/mm/Makefile b/arch/x86/mm/Makefile
index c80febc44cd2..e74b95a57d86 100644
--- a/arch/x86/mm/Makefile
+++ b/arch/x86/mm/Makefile
@@ -27,6 +27,7 @@ endif
 obj-y				:=  init.o init_$(BITS).o fault.o ioremap.o extable.o mmap.o \
 				    pgtable.o physaddr.o tlb.o cpu_entry_area.o maccess.o pgprot.o
 
+obj-$(CONFIG_NUMA_BALANCING)	+= ibs.o
 obj-y				+= pat/
 
 # Make sure __phys_addr has no stackprotector
diff --git a/arch/x86/mm/ibs.c b/arch/x86/mm/ibs.c
new file mode 100644
index 000000000000..411dba2a88d1
--- /dev/null
+++ b/arch/x86/mm/ibs.c
@@ -0,0 +1,169 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/init.h>
+
+#include <asm/nmi.h>
+#include <asm/perf_event.h> /* TODO: Move defns like IBS_OP_ENABLE into non-perf header */
+#include <asm/apic.h>
+
+static u64 ibs_config __read_mostly;
+
+static int ibs_overflow_handler(unsigned int cmd, struct pt_regs *regs)
+{
+	u64 ops_ctl, ops_data3, ops_data2;
+	u64 remote_access;
+	u64 laddr = -1, paddr = -1;
+	struct mm_struct *mm = current->mm;
+
+	rdmsrl(MSR_AMD64_IBSOPCTL, ops_ctl);
+
+	/*
+	 * When IBS sampling period is reprogrammed via read-modify-update
+	 * of MSR_AMD64_IBSOPCTL, overflow NMIs could be generated with
+	 * IBS_OP_ENABLE not set. For such cases, return as HANDLED.
+	 *
+	 * With this, the handler will say "handled" for all NMIs that
+	 * aren't related to this NMI.  This stems from the limitation of
+	 * having both status and control bits in one MSR.
+	 */
+	if (!(ops_ctl & IBS_OP_VAL))
+		goto handled;
+
+	wrmsrl(MSR_AMD64_IBSOPCTL, ops_ctl & ~IBS_OP_VAL);
+
+	count_vm_event(IBS_NR_EVENTS);
+
+	if (!mm) {
+		count_vm_event(IBS_KTHREAD);
+		goto handled;
+	}
+
+	rdmsrl(MSR_AMD64_IBSOPDATA3, ops_data3);
+
+	/* Load/Store ops only */
+	if (!(ops_data3 & (MSR_AMD64_IBSOPDATA3_LDOP |
+			   MSR_AMD64_IBSOPDATA3_STOP))) {
+		count_vm_event(IBS_NON_LOAD_STORES);
+		goto handled;
+	}
+
+	/* Discard the sample if it was L1 or L2 hit */
+	if (!(ops_data3 & (MSR_AMD64_IBSOPDATA3_DCMISS |
+			   MSR_AMD64_IBSOPDATA3_L2MISS))) {
+		count_vm_event(IBS_DC_L2_HITS);
+		goto handled;
+	}
+
+	rdmsrl(MSR_AMD64_IBSOPDATA2, ops_data2);
+	remote_access = ops_data2 & MSR_AMD64_IBSOPDATA2_DATASRC;
+
+	/* Consider only DRAM accesses, exclude cache accesses from near ccx */
+	if (remote_access < MSR_AMD64_IBSOPDATA2_DATASRC_DRAM) {
+		count_vm_event(IBS_NEAR_CACHE_HITS);
+		goto handled;
+	}
+
+	/* Exclude hits from peer cache in far ccx */
+	if (remote_access == MSR_AMD64_IBSOPDATA2_DATASRC_FAR_CCX_CACHE) {
+		count_vm_event(IBS_FAR_CACHE_HITS);
+		goto handled;
+	}
+
+	/* Is linear addr valid? */
+	if (ops_data3 & MSR_AMD64_IBSOPDATA3_LADDR_VALID)
+		rdmsrl(MSR_AMD64_IBSDCLINAD, laddr);
+	else {
+		count_vm_event(IBS_LADDR_INVALID);
+		goto handled;
+	}
+
+	/* Discard kernel address accesses */
+	if (laddr & (1UL << 63)) {
+		count_vm_event(IBS_KERNEL_ADDR);
+		goto handled;
+	}
+
+	/* Is phys addr valid? */
+	if (ops_data3 & MSR_AMD64_IBSOPDATA3_PADDR_VALID)
+		rdmsrl(MSR_AMD64_IBSDCPHYSAD, paddr);
+	else
+		count_vm_event(IBS_PADDR_INVALID);
+
+handled:
+	return NMI_HANDLED;
+}
+
+static inline int get_ibs_lvt_offset(void)
+{
+	u64 val;
+
+	rdmsrl(MSR_AMD64_IBSCTL, val);
+	if (!(val & IBSCTL_LVT_OFFSET_VALID))
+		return -EINVAL;
+
+	return val & IBSCTL_LVT_OFFSET_MASK;
+}
+
+static void setup_APIC_ibs(void)
+{
+	int offset;
+
+	offset = get_ibs_lvt_offset();
+	if (offset < 0)
+		goto failed;
+
+	if (!setup_APIC_eilvt(offset, 0, APIC_EILVT_MSG_NMI, 0))
+		return;
+failed:
+	pr_warn("IBS APIC setup failed on cpu #%d\n",
+		smp_processor_id());
+}
+
+static void clear_APIC_ibs(void)
+{
+	int offset;
+
+	offset = get_ibs_lvt_offset();
+	if (offset >= 0)
+		setup_APIC_eilvt(offset, 0, APIC_EILVT_MSG_FIX, 1);
+}
+
+static int x86_amd_ibs_access_profile_startup(unsigned int cpu)
+{
+	setup_APIC_ibs();
+	return 0;
+}
+
+static int x86_amd_ibs_access_profile_teardown(unsigned int cpu)
+{
+	clear_APIC_ibs();
+	return 0;
+}
+
+int __init ibs_access_profiling_init(void)
+{
+	u32 caps;
+
+	ibs_config = IBS_OP_CNT_CTL | IBS_OP_ENABLE;
+
+	if (!boot_cpu_has(X86_FEATURE_IBS)) {
+		pr_info("IBS capability is unavailable for access profiling\n");
+		return 0;
+	}
+
+	caps = cpuid_eax(IBS_CPUID_FEATURES);
+	if (caps & IBS_CAPS_ZEN4)
+		ibs_config |= IBS_OP_L3MISSONLY;
+
+	register_nmi_handler(NMI_LOCAL, ibs_overflow_handler, 0, "ibs");
+
+	cpuhp_setup_state(CPUHP_AP_PERF_X86_AMD_IBS_STARTING,
+			  "x86/amd/ibs_access_profile:starting",
+			  x86_amd_ibs_access_profile_startup,
+			  x86_amd_ibs_access_profile_teardown);
+
+	pr_info("IBS access profiling setup for NUMA Balancing\n");
+	return 0;
+}
+
+arch_initcall(ibs_access_profiling_init);
diff --git a/include/linux/vm_event_item.h b/include/linux/vm_event_item.h
index 7f5d1caf5890..1d55e347d16c 100644
--- a/include/linux/vm_event_item.h
+++ b/include/linux/vm_event_item.h
@@ -149,6 +149,17 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOUT,
 #ifdef CONFIG_X86
 		DIRECT_MAP_LEVEL2_SPLIT,
 		DIRECT_MAP_LEVEL3_SPLIT,
+#ifdef CONFIG_NUMA_BALANCING
+		IBS_NR_EVENTS,
+		IBS_KTHREAD,
+		IBS_NON_LOAD_STORES,
+		IBS_DC_L2_HITS,
+		IBS_NEAR_CACHE_HITS,
+		IBS_FAR_CACHE_HITS,
+		IBS_LADDR_INVALID,
+		IBS_KERNEL_ADDR,
+		IBS_PADDR_INVALID,
+#endif
 #endif
 		NR_VM_EVENT_ITEMS
 };
diff --git a/mm/vmstat.c b/mm/vmstat.c
index 1ea6a5ce1c41..c7a9d0d9ade8 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1398,6 +1398,17 @@ const char * const vmstat_text[] = {
 #ifdef CONFIG_X86
 	"direct_map_level2_splits",
 	"direct_map_level3_splits",
+#ifdef CONFIG_NUMA_BALANCING
+	"ibs_nr_events",
+	"ibs_kthread",
+	"ibs_non_load_stores",
+	"ibs_dc_l2_hits",
+	"ibs_near_cache_hits",
+	"ibs_far_cache_hits",
+	"ibs_invalid_laddr",
+	"ibs_kernel_addr",
+	"ibs_invalid_paddr",
+#endif
 #endif
 #endif /* CONFIG_VM_EVENT_COUNTERS || CONFIG_MEMCG */
 };
-- 
2.25.1

