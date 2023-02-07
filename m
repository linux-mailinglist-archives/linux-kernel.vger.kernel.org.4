Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DC8D68DDC0
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 17:17:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232049AbjBGQRm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 11:17:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232008AbjBGQRk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 11:17:40 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 275FB1E296
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 08:17:39 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8BFA11EC068B;
        Tue,  7 Feb 2023 17:17:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1675786657;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=UETytlTOPd+ZYdvXlPzbxbLjnmIE0WEmRzl07+QluuU=;
        b=PBOPO8ZDxl4avWhgkB3SpFMtd7O9ai+og3b7H2lixGiMCDn5j7cq91npmiYyiRUQlPFmo4
        6hQyaYOmuhVxMCrPLwMuhodRDZK1svGRBT/IZDO9E6LHV8nC4ys00DDX7RwLzkUtPdfAZR
        KqWF0jAA88BGh/xq3fRmi4GUh/x+XXw=
Date:   Tue, 7 Feb 2023 17:17:33 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Feng Tang <feng.tang@intel.com>
Cc:     Terry Bowman <terry.bowman@amd.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org
Subject: Re: [PATCH 3/3] tools/x86/kcpuid: Dump the CPUID function in
 detailed view
Message-ID: <Y+J5jDfO4PMujuXD@zn.tnic>
References: <20230206141832.4162264-1-terry.bowman@amd.com>
 <20230206141832.4162264-4-terry.bowman@amd.com>
 <Y+HIkTzNh4SXgVEc@feng-clx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y+HIkTzNh4SXgVEc@feng-clx>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 07, 2023 at 11:42:09AM +0800, Feng Tang wrote:
> Maybe we can check the sum of subleaf->info.nr[EAX/EBX/ECX/EDX],
> and only print it out when it is not zero.

Considering how this is only a --detail output and I kinda find the
default output a bit too terse, yeah, I think we should dump all the
values with -d. Something like the below diff ontop.

I've added the output at the end and I think it makes perfect sense to
dump those raw values with -d. In time, we will start decoding them too
so that we can have a full, human readable dump of the CPUID leafs and
all the data needed.

---

diff --git a/tools/arch/x86/kcpuid/cpuid.csv b/tools/arch/x86/kcpuid/cpuid.csv
index 59ee3b53309a..baadf2cdd1c6 100644
--- a/tools/arch/x86/kcpuid/cpuid.csv
+++ b/tools/arch/x86/kcpuid/cpuid.csv
@@ -375,7 +375,7 @@
 0x80000001,    0,  ECX,     27, perftsc, Performance time-stamp counter supported
 0x80000001,    0,  ECX,     28, perfctrextllc, Indicates support for L3 performance counter extensions
 0x80000001,    0,  ECX,     29, mwaitextended, MWAITX and MONITORX capability is supported
-0x80000001,    0,  ECX,     30. admskextn, Indicates support for address mask extension (to 32 bits and to all 4 DRs) for instruction breakpoints
+0x80000001,    0,  ECX,     30, admskextn, Indicates support for address mask extension (to 32 bits and to all 4 DRs) for instruction breakpoints
 
 0x80000001,    0,  EDX,      0, fpu, x87 floating point unit on-chip
 0x80000001,    0,  EDX,      1, vme, Virtual-mode enhancements
diff --git a/tools/arch/x86/kcpuid/kcpuid.c b/tools/arch/x86/kcpuid/kcpuid.c
index 26fa5255c42b..1b1fa13a9921 100644
--- a/tools/arch/x86/kcpuid/kcpuid.c
+++ b/tools/arch/x86/kcpuid/kcpuid.c
@@ -33,7 +33,7 @@ struct reg_desc {
 	struct bits_desc descs[32];
 };
 
-enum {
+enum cpuid_reg {
 	R_EAX = 0,
 	R_EBX,
 	R_ECX,
@@ -41,6 +41,10 @@ enum {
 	NR_REGS
 };
 
+static const char * const reg_names[] = {
+	"EAX", "EBX", "ECX", "EDX",
+};
+
 struct subleaf {
 	u32 index;
 	u32 sub;
@@ -445,12 +449,18 @@ static void parse_text(void)
 
 
 /* Decode every eax/ebx/ecx/edx */
-static void decode_bits(u32 value, struct reg_desc *rdesc)
+static void decode_bits(u32 value, struct reg_desc *rdesc, enum cpuid_reg reg)
 {
 	struct bits_desc *bdesc;
 	int start, end, i;
 	u32 mask;
 
+	if (!rdesc->nr) {
+		if (show_details)
+			printf("\t %s: 0x%08x\n", reg_names[reg], value);
+		return;
+	}
+
 	for (i = 0; i < rdesc->nr; i++) {
 		bdesc = &rdesc->descs[i];
 
@@ -493,10 +503,10 @@ static void show_leaf(struct subleaf *leaf)
 				leaf->index, leaf->sub);
 	}
 
-	decode_bits(leaf->eax, &leaf->info[R_EAX]);
-	decode_bits(leaf->ebx, &leaf->info[R_EBX]);
-	decode_bits(leaf->ecx, &leaf->info[R_ECX]);
-	decode_bits(leaf->edx, &leaf->info[R_EDX]);
+	decode_bits(leaf->eax, &leaf->info[R_EAX], R_EAX);
+	decode_bits(leaf->ebx, &leaf->info[R_EBX], R_EBX);
+	decode_bits(leaf->ecx, &leaf->info[R_ECX], R_ECX);
+	decode_bits(leaf->edx, &leaf->info[R_EDX], R_EDX);
 
 	if (!show_raw && show_details)
 		printf("\n");

---

Output:

---

CPU features:
=============

CPUID_0x0_ECX[0x0]:
	 max_basic_leafs    	: 0xd       	- Max input value for supported subleafs
	 EBX: 0x68747541
	 ECX: 0x444d4163
	 EDX: 0x69746e65

CPUID_0x1_ECX[0x0]:
	 stepping           	: 0x2       	- Stepping ID
	 model              	: 0x8       	- Model
	 family             	: 0xf       	- Family ID
	 processor          	: 0x0       	- Processor Type
	 model_ext          	: 0x0       	- Extended Model ID
	 family_ext         	: 0x8       	- Extended Family ID
	 brand              	: 0x0       	- Brand Index
	 clflush_size       	: 0x8       	- CLFLUSH line size (value * 8) in bytes
	 max_cpu_id         	: 0x10      	- Maxim number of addressable logic cpu in this package
	 apic_id            	: 0xe       	- Initial APIC ID
	 sse3                - Streaming SIMD Extensions 3(SSE3)
	 pclmulqdq           - PCLMULQDQ instruction supported
	 mwait               - MONITOR/MWAIT supported
	 ssse3               - Supplemental Streaming SIMD Extensions 3 (SSSE3)
	 fma                 - FMA extensions using YMM state supported
	 cmpxchg16b          - 'CMPXCHG16B - Compare and Exchange Bytes' supported
	 sse4_1              - SSE4.1 feature present
	 sse4_2              - SSE4.2 feature present
	 movbe               - MOVBE instruction supported
	 popcnt              - POPCNT instruction supported
	 aesni               - AESNI instruction supported
	 xsave               - XSAVE/XRSTOR processor extended states (XSETBV/XGETBV/XCR0)
	 osxsave             - OS has set CR4.OSXSAVE bit to enable XSETBV/XGETBV/XCR0
	 avx                 - AVX instruction supported
	 f16c                - 16-bit floating-point conversion instruction supported
	 rdrand              - RDRAND instruction supported
	 fpu                 - x87 FPU on chip
	 vme                 - Virtual-8086 Mode Enhancement
	 de                  - Debugging Extensions
	 pse                 - Page Size Extensions
	 tsc                 - Time Stamp Counter
	 msr                 - RDMSR and WRMSR Support
	 pae                 - Physical Address Extensions
	 mce                 - Machine Check Exception
	 cx8                 - CMPXCHG8B instr
	 apic                - APIC on Chip
	 sep                 - SYSENTER and SYSEXIT instrs
	 mtrr                - Memory Type Range Registers
	 pge                 - Page Global Bit
	 mca                 - Machine Check Architecture
	 cmov                - Conditional Move Instrs
	 pat                 - Page Attribute Table
	 pse36               - 36-Bit Page Size Extension
	 clflush             - CLFLUSH instr
	 mmx                 - Intel MMX Technology
	 fxsr                - XSAVE and FXRSTOR Instrs
	 sse                 - SSE
	 sse2                - SSE2
	 hit                 - Max APIC IDs

CPUID_0x5_ECX[0x0]:
	 min_mon_size       	: 0x40      	- Smallest monitor line size in bytes
	 max_mon_size       	: 0x40      	- Largest monitor line size in bytes
	 mwait_ext           - Enum of Monitor-Mwait extensions supported
	 mwait_irq_break     - Largest monitor line size in bytes
	 c0_sub_stats       	: 0x1       	- Number of C0* sub C-states supported using MWAIT
	 c1_sub_stats       	: 0x1       	- Number of C1* sub C-states supported using MWAIT
	 c2_sub_stats       	: 0x0       	- Number of C2* sub C-states supported using MWAIT
	 c3_sub_stats       	: 0x0       	- Number of C3* sub C-states supported using MWAIT
	 c4_sub_stats       	: 0x0       	- Number of C4* sub C-states supported using MWAIT
	 c5_sub_stats       	: 0x0       	- Number of C5* sub C-states supported using MWAIT
	 c6_sub_stats       	: 0x0       	- Number of C6* sub C-states supported using MWAIT
	 c7_sub_stats       	: 0x0       	- Number of C7* sub C-states supported using MWAIT

CPUID_0x6_ECX[0x0]:
	 arat                - Always running APIC timer
	 therm_irq_thresh   	: 0x0       	- Number of Interrupt Thresholds in Digital Thermal Sensor
	 aperfmperf          - Presence of IA32_MPERF and IA32_APERF
	 EDX: 0x00000000

CPUID_0x7_ECX[0x0]:
	 EAX: 0x00000000
	 fsgsbase            - RDFSBASE/RDGSBASE/WRFSBASE/WRGSBASE supported
	 bmi1                - BMI1
	 avx2                - AVX2
	 smep                - Supervisor-Mode Execution Prevention
	 bmi2                - BMI2
	 rdseed              - RDSEED instr
	 adx                 - ADX instr
	 smap                - Supervisor Mode Access Prevention
	 clflushopt          - CLFLUSHOPT instr
	 sha                 - Intel Secure Hash Algorithm Extensions instr
	 mawau              	: 0x0       	- The value of MAWAU used by the BNDLDX and BNDSTX instructions in 64-bit mode
	 EDX: 0x00000000

CPUID_0xd_ECX[0x0]:
	 x87                 - X87 state
	 sse                 - SSE state
	 avx                 - AVX state
	 mpx                	: 0x0       	- MPX state
	 avx512             	: 0x0       	- AVX-512 state
	 max_sz_xcr0        	: 0x340     	- Maximum size (bytes) required by enabled features in XCR0
	 max_sz_xsave       	: 0x340     	- Maximum size (bytes) of the XSAVE/XRSTOR save area
	 EDX: 0x00000000

CPUID_0xd_ECX[0x1]:
	 xsaveopt            - XSAVEOPT available
	 xsavec              - XSAVEC and compacted form supported
	 xgetbv              - XGETBV supported
	 xsaves              - XSAVES/XRSTORS and IA32_XSS supported
	 max_sz_xcr0        	: 0x340     	- Maximum size (bytes) required by enabled features in XCR0
	 EDX: 0x00000000

CPUID_0xd_ECX[0x2]:
	 EAX: 0x00000100
	 EBX: 0x00000240
	 ECX: 0x00000000
	 EDX: 0x00000000

CPUID_0x80000000_ECX[0x0]:
	 EAX: 0x8000001f
	 EBX: 0x68747541
	 ECX: 0x444d4163
	 EDX: 0x69746e65

CPUID_0x80000001_ECX[0x0]:
	 extfamily          	: 0x8       	- Extended family
	 extmodel           	: 0x0       	- Extended model
	 basefamily         	: 0xf       	- Description of Family
	 basemodel          	: 0xf       	- Model numbers vary with product
	 stepping           	: 0x2       	- Processor stepping (revision) for a specific model
	 pkgtype            	: 0x2       	- Specifies the package type
	 lahf_lm             - LAHF/SAHF available in 64-bit mode
	 cmplegacy           - Core multi-processing legacy mode
	 svm                 - Indicates support for: VMRUN, VMLOAD, VMSAVE, CLGI, VMMCALL, and INVLPGA
	 extapicspace        - Extended APIC register space
	 altmovecr8          - Indicates support for LOCK MOV CR0 means MOV CR8
	 lzcnt               - LZCNT
	 sse4a               - EXTRQ, INSERTQ, MOVNTSS, and MOVNTSD instruction support
	 misalignsse         - Misaligned SSE Mode
	 prefetchw           - PREFETCHW
	 osvw                - OS Visible Work-around support
	 skinit              - SKINIT and STGI support
	 wdt                 - Watchdog timer support
	 tce                 - Translation cache extension
	 TopologyExtensions  - Indicates support for Core::X86::Cpuid::CachePropEax0 and Core::X86::Cpuid::ExtApicId
	 perfctrextcore      - Indicates support for Core::X86::Msr::PERF_CTL0 - 5 and Core::X86::Msr::PERF_CTR
	 perfctrextdf        - Indicates support for Core::X86::Msr::DF_PERF_CTL and Core::X86::Msr::DF_PERF_CTR
	 databreakpointextension - Indicates data breakpoint support for Core::X86::Msr::DR0_ADDR_MASK, Core::X86::Msr::DR1_ADDR_MASK, Core::X86::Msr::DR2_ADDR_MASK and Core::X86::Msr::DR3_ADDR_MASK
	 perfctrextllc       - Indicates support for L3 performance counter extensions
	 mwaitextended       - MWAITX and MONITORX capability is supported
	 fpu                 - x87 floating point unit on-chip
	 vme                 - Virtual-mode enhancements
	 de                  - Debugging extensions, IO breakpoints, CR4.DE
	 pse                 - Page-size extensions (4 MB pages)
	 tsc                 - Time stamp counter, RDTSC/RDTSCP instructions, CR4.TSD
	 msr                 - Model-specific registers (MSRs), with RDMSR and WRMSR instructions
	 pae                 - Physical-address extensions (PAE)
	 mce                 - Machine Check Exception, CR4.MCE
	 cmpxchg8b           - CMPXCHG8B instruction
	 apic                - advanced programmable interrupt controller (APIC) exists and is enabled
	 sysret              - SYSCALL/SYSRET supported
	 mtrr                - Memory-type range registers
	 pge                 - Page global extension, CR4.PGE
	 mca                 - Machine check architecture, MCG_CAP
	 cmov                - Conditional move instructions, CMOV, FCOMI, FCMOV
	 pat                 - Page attribute table
	 pse36               - Page-size extensions
	 exec_dis            - Execute Disable Bit available
	 mmxext              - AMD extensions to MMX instructions
	 mmx                 - MMX instructions
	 fxsr                - FXSAVE and FXRSTOR instructions
	 ffxsr               - FXSAVE and FXRSTOR instruction optimizations
	 1gb_page            - 1GB page supported
	 rdtscp              - RDTSCP and IA32_TSC_AUX are available
	 lm                  - 64b Architecture supported

CPUID_0x80000002_ECX[0x0]:
	 EAX: 0x20444d41
	 EBX: 0x657a7952
	 ECX: 0x2037206e
	 EDX: 0x30303732

CPUID_0x80000003_ECX[0x0]:
	 EAX: 0x69452058
	 EBX: 0x2d746867
	 ECX: 0x65726f43
	 EDX: 0x6f725020

CPUID_0x80000004_ECX[0x0]:
	 EAX: 0x73736563
	 EBX: 0x2020726f
	 ECX: 0x20202020
	 EDX: 0x00202020

CPUID_0x80000005_ECX[0x0]:
	 EAX: 0xff40ff40
	 EBX: 0xff40ff40
	 ECX: 0x20080140
	 EDX: 0x40040140

CPUID_0x80000006_ECX[0x0]:
	 EAX: 0x26006400
	 EBX: 0x66006400
	 clsize             	: 0x40      	- Cache Line size in bytes
	 l2c_assoc          	: 0x6       	- L2 Associativity
	 csize              	: 0x200     	- Cache size in 1K units
	 EDX: 0x00808140

CPUID_0x80000007_ECX[0x0]:
	 EAX: 0x00000000
	 ECX: 0x00000000
	 nonstop_tsc         - Invariant TSC available

CPUID_0x80000008_ECX[0x0]:
	 phy_adr_bits       	: 0x30      	- Physical Address Bits
	 lnr_adr_bits       	: 0x30      	- Linear Address Bits
	 EBX: 0x00001007
	 ECX: 0x0000400f
	 EDX: 0x00000000

CPUID_0x8000000a_ECX[0x0]:
	 EAX: 0x00000001
	 EBX: 0x00008000
	 ECX: 0x00000000
	 EDX: 0x0001bcff

CPUID_0x80000019_ECX[0x0]:
	 EAX: 0xf040f040
	 EBX: 0x00000000
	 ECX: 0x00000000
	 EDX: 0x00000000

CPUID_0x8000001a_ECX[0x0]:
	 EAX: 0x00000003
	 EBX: 0x00000000
	 ECX: 0x00000000
	 EDX: 0x00000000

CPUID_0x8000001b_ECX[0x0]:
	 EAX: 0x000003ff
	 EBX: 0x00000000
	 ECX: 0x00000000
	 EDX: 0x00000000

CPUID_0x8000001d_ECX[0x0]:
	 EAX: 0x00004121
	 EBX: 0x01c0003f
	 ECX: 0x0000003f
	 EDX: 0x00000000

CPUID_0x8000001d_ECX[0x1]:
	 EAX: 0x00004122
	 EBX: 0x00c0003f
	 ECX: 0x000000ff
	 EDX: 0x00000000

CPUID_0x8000001d_ECX[0x2]:
	 EAX: 0x00004143
	 EBX: 0x01c0003f
	 ECX: 0x000003ff
	 EDX: 0x00000002

CPUID_0x8000001d_ECX[0x3]:
	 EAX: 0x0001c163
	 EBX: 0x03c0003f
	 ECX: 0x00001fff
	 EDX: 0x00000001

CPUID_0x8000001e_ECX[0x0]:
	 extended_apic_id   	: 0xe       	- Extended APIC ID
	 core_id            	: 0x7       	- Identifies the logical core ID
	 threads_per_core   	: 0x1       	- The number of threads per core is threads_per_core + 1
	 node_id            	: 0x0       	- Node ID
	 nodes_per_processor	: 0x0       	- Nodes per processor { 0: 1 node, else reserved }
	 EDX: 0x00000000

CPUID_0x8000001f_ECX[0x0]:
	 sme                 -	Secure Memory Encryption
	 sev                 -	Secure Encrypted Virtualization
	 vmpgflush           - VM Page Flush MSR
	 seves               - SEV Encrypted State
	 c-bit              	: 0x2f      	- Page table bit number used to enable memory encryption
	 mem_encrypt_physaddr_width	: 0x5       	- Reduction of physical address space in bits with SME enabled
	 num_encrypted_guests	: 0xf       	- Maximum ASID value that may be used for an SEV-enabled guest
	 minimum_sev_asid   	: 0x0       	- Minimum ASID value that must be used for an SEV-enabled, SEV-ES-disabled guest


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
