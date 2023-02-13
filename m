Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47BC46942EA
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 11:34:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbjBMKee (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 05:34:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjBMKe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 05:34:28 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 62345DBF6;
        Mon, 13 Feb 2023 02:34:27 -0800 (PST)
Received: from vm02.corp.microsoft.com (unknown [167.220.196.155])
        by linux.microsoft.com (Postfix) with ESMTPSA id 5A68D20C8B73;
        Mon, 13 Feb 2023 02:34:24 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5A68D20C8B73
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1676284466;
        bh=lmISFNCs5b2fQLI1ZzQ/46EgrntcRajyJvLUq4mleho=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CV8UDLpDdqXV5p+nQMHZS0Ds0q6sH7YjOVfBHa0HG1/scso9bLsOLrFLCheysXzIE
         2yo4E27ZpgTnN1n94az+FQgr12PJJTs0/FCSVjcafao+20R6J1q5oBhrWxpLbzAA9P
         6np8HrV9fL1cPgMq4z5m/CpDQ2fWcMNRIGcitUyM=
From:   Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-hyperv@vger.kernel.org,
        Brijesh Singh <brijesh.singh@amd.com>,
        Michael Roth <michael.roth@amd.com>,
        Ashish Kalra <ashish.kalra@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
Subject: [RFC PATCH v2 1/7] x86/hyperv: Allocate RMP table during boot
Date:   Mon, 13 Feb 2023 10:33:56 +0000
Message-Id: <20230213103402.1189285-2-jpiotrowski@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230213103402.1189285-1-jpiotrowski@linux.microsoft.com>
References: <20230213103402.1189285-1-jpiotrowski@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hyper-V VMs can be capable of hosting SNP isolated nested VMs on AMD
CPUs. One of the pieces of SNP is the RMP (Reverse Map) table which
tracks page assignment to firmware, hypervisor or guest. On bare-metal
this table is allocated by UEFI, but on Hyper-V it is the responsibility
of the OS to allocate one if necessary. The nested_feature
'HV_X64_NESTED_NO_RMP_TABLE' will be set to communicate that no rmp is
available. The actual RMP table is exclusively controlled by the Hyper-V
hypervisor and is not virtualized to the VM. The SNP code in the kernel
uses the RMP table for its own tracking and so it is necessary for init
code to allocate one.

While not strictly necessary, follow the requirements defined by "SEV
Secure Nested Paging Firmware ABI Specification" Rev 1.54, section 8.8.2
when allocating the RMP:

- RMP_BASE and RMP_END must be set identically across all cores.
- RMP_BASE must be 1 MB aligned
- RMP_END – RMP_BASE + 1 must be a multiple of 1 MB
- RMP is large enough to protect itself

The allocation is done in the init_mem_mapping() hook, which is the
earliest hook I found that has both max_pfn and memblock initialized. At
this point we are still under the
memblock_set_current_limit(ISA_END_ADDRESS) condition, but explicitly
passing the end to memblock_phys_alloc_range() allows us to allocate
past that value.

The RMP table is needed when the hypervisor has access to SNP, which can
be determined using X86_FEATURE_SEV_SNP, but we need to exclude SNP
guests themselves (since SNP guests are not capable of virtualization).
This is why we check for cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT).

Signed-off-by: Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
---
 arch/x86/hyperv/hv_init.c          |  5 ++++
 arch/x86/include/asm/hyperv-tlfs.h |  3 ++
 arch/x86/include/asm/mshyperv.h    |  3 ++
 arch/x86/include/asm/sev.h         |  2 ++
 arch/x86/kernel/cpu/mshyperv.c     | 45 ++++++++++++++++++++++++++++++
 arch/x86/kernel/sev.c              |  1 -
 6 files changed, 58 insertions(+), 1 deletion(-)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index 29774126e931..0c540fff1a20 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -117,6 +117,11 @@ static int hv_cpu_init(unsigned int cpu)
 		}
 	}
 
+	if (hv_needs_snp_rmp()) {
+		wrmsrl(MSR_AMD64_RMP_BASE, rmp_res.start);
+		wrmsrl(MSR_AMD64_RMP_END, rmp_res.end);
+	}
+
 	return hyperv_init_ghcb();
 }
 
diff --git a/arch/x86/include/asm/hyperv-tlfs.h b/arch/x86/include/asm/hyperv-tlfs.h
index e3efaf6e6b62..01cc2c3f9f20 100644
--- a/arch/x86/include/asm/hyperv-tlfs.h
+++ b/arch/x86/include/asm/hyperv-tlfs.h
@@ -152,6 +152,9 @@
  */
 #define HV_X64_NESTED_ENLIGHTENED_TLB			BIT(22)
 
+/* Nested SNP on Hyper-V */
+#define HV_X64_NESTED_NO_RMP_TABLE			BIT(23)
+
 /* HYPERV_CPUID_ISOLATION_CONFIG.EAX bits. */
 #define HV_PARAVISOR_PRESENT				BIT(0)
 
diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index 61f0c206bff0..3533b002cede 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -190,6 +190,9 @@ static inline void hv_ghcb_terminate(unsigned int set, unsigned int reason) {}
 
 extern bool hv_isolation_type_snp(void);
 
+extern struct resource rmp_res;
+bool hv_needs_snp_rmp(void);
+
 static inline bool hv_is_synic_reg(unsigned int reg)
 {
 	if ((reg >= HV_REGISTER_SCONTROL) &&
diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index 2916f4150ac7..db5438663229 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -83,6 +83,8 @@ extern bool handle_vc_boot_ghcb(struct pt_regs *regs);
 /* RMUPDATE detected 4K page and 2MB page overlap. */
 #define RMPUPDATE_FAIL_OVERLAP		7
 
+#define RMPTABLE_CPU_BOOKKEEPING_SZ     0x4000
+
 /* RMP page size */
 #define RMP_PG_SIZE_4K			0
 #define RMP_PG_SIZE_2M			1
diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index 831613959a92..777c9d812dfa 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -17,6 +17,7 @@
 #include <linux/irq.h>
 #include <linux/kexec.h>
 #include <linux/i8253.h>
+#include <linux/memblock.h>
 #include <linux/random.h>
 #include <linux/swiotlb.h>
 #include <asm/processor.h>
@@ -31,6 +32,7 @@
 #include <asm/timer.h>
 #include <asm/reboot.h>
 #include <asm/nmi.h>
+#include <asm/sev.h>
 #include <clocksource/hyperv_timer.h>
 #include <asm/numa.h>
 #include <asm/coco.h>
@@ -488,6 +490,48 @@ static bool __init ms_hyperv_msi_ext_dest_id(void)
 	return eax & HYPERV_VS_PROPERTIES_EAX_EXTENDED_IOAPIC_RTE;
 }
 
+struct resource rmp_res = {
+	.name  = "RMP",
+	.start = 0,
+	.end   = 0,
+	.flags = IORESOURCE_SYSTEM_RAM,
+};
+
+/*
+ * HV_X64_NESTED_NO_RMP_TABLE indicates to the nested hypervisor that no RMP
+ * table is provided/necessary, but kernel code requires access to one so we
+ * use that bit as an indication that we need to allocate one ourselves.
+ */
+bool hv_needs_snp_rmp(void)
+{
+	return IS_ENABLED(CONFIG_KVM_AMD_SEV) &&
+		boot_cpu_has(X86_FEATURE_SEV_SNP) &&
+		!cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT) &&
+		(ms_hyperv.nested_features & HV_X64_NESTED_NO_RMP_TABLE);
+}
+
+static void __init ms_hyperv_init_mem_mapping(void)
+{
+	phys_addr_t addr;
+	u64 calc_rmp_sz;
+
+	if (!hv_needs_snp_rmp())
+		return;
+
+	calc_rmp_sz = (max_pfn << 4) + RMPTABLE_CPU_BOOKKEEPING_SZ;
+	calc_rmp_sz = round_up(calc_rmp_sz, SZ_1M);
+	addr = memblock_phys_alloc_range(calc_rmp_sz, SZ_1M, 0, max_pfn << PAGE_SHIFT);
+	if (!addr) {
+		pr_warn("Unable to allocate RMP table\n");
+		return;
+	}
+	rmp_res.start = addr;
+	rmp_res.end = addr + calc_rmp_sz - 1;
+	wrmsrl(MSR_AMD64_RMP_BASE, rmp_res.start);
+	wrmsrl(MSR_AMD64_RMP_END, rmp_res.end);
+	insert_resource(&iomem_resource, &rmp_res);
+}
+
 const __initconst struct hypervisor_x86 x86_hyper_ms_hyperv = {
 	.name			= "Microsoft Hyper-V",
 	.detect			= ms_hyperv_platform,
@@ -495,4 +539,5 @@ const __initconst struct hypervisor_x86 x86_hyper_ms_hyperv = {
 	.init.x2apic_available	= ms_hyperv_x2apic_available,
 	.init.msi_ext_dest_id	= ms_hyperv_msi_ext_dest_id,
 	.init.init_platform	= ms_hyperv_init_platform,
+	.init.init_mem_mapping  = ms_hyperv_init_mem_mapping,
 };
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index 1dd1b36bdfea..7fa39dc17edd 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -87,7 +87,6 @@ struct rmpentry {
  * The first 16KB from the RMP_BASE is used by the processor for the
  * bookkeeping, the range needs to be added during the RMP entry lookup.
  */
-#define RMPTABLE_CPU_BOOKKEEPING_SZ	0x4000
 #define RMPENTRY_SHIFT			8
 #define rmptable_page_offset(x)	(RMPTABLE_CPU_BOOKKEEPING_SZ + (((unsigned long)x) >> RMPENTRY_SHIFT))
 
-- 
2.25.1

