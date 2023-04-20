Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0BC86E9C48
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 21:10:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231935AbjDTTKu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 15:10:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231823AbjDTTKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 15:10:44 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD731199C;
        Thu, 20 Apr 2023 12:10:42 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1682017840;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IP9ZNUD6L+xj0tXvEDGg3l5TK/5q2SwHvuD7zakyePA=;
        b=WXvOBhQnrav0UZqBuiQZWizGndl7UnBGE4WEv/h2i7ST7IiAdxEZfLwucan2JIMhkBg01P
        uUN5BsPKTBLEdYA1FDN0qfXk7vkFGDhn+EN/Y4xhpGnXkq59aXs2yqe6OA0c/kkflNeB8x
        M4nW29KgQHanGvT8ypy6QbmjFrkppakOwQhJdF3RPgMsYdigf/wmMjAH+ekKBmfSsv83A6
        DDtyepjU24kHPMCyp6lGMu4+T30tWy2hYs4fFm0so009cR1Vp4crko8h7h67DD72woi9E/
        GajaPaudI4kAd8QwWs3G+B9IQjYV5JonnXf/f2veHQIrSFHnCbuSwV7BCC/AwQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1682017840;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IP9ZNUD6L+xj0tXvEDGg3l5TK/5q2SwHvuD7zakyePA=;
        b=N6gei/2hTKux/sJnPsYCf5fnEl3UCTMBtgBN8A/utlew7zJA7EnlFuMmSWaMDFGbNzCBtQ
        2LmnohpRtSqZ1yAQ==
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     Sean Christopherson <seanjc@google.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Gerst <brgerst@gmail.com>,
        Arjan van de Veen <arjan@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Paul McKenney <paulmck@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Piotr Gorski <lucjan.lucjanov@gmail.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Usama Arif <usama.arif@bytedance.com>,
        =?utf-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        xen-devel@lists.xenproject.org,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
        linux-csky@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org,
        "James E. J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Sabin Rapan <sabrapan@amazon.com>
Subject: Re: [patch 00/37] cpu/hotplug, x86: Reworked parallel CPU bringup
In-Reply-To: <56e59a4d-a47f-4bfe-7db5-5f921062ad69@molgen.mpg.de>
References: <87r0sh4m7a.ffs@tglx>
 <8592a301-9933-1cad-bd61-8d97e7c7493b@molgen.mpg.de> <87a5z443g2.ffs@tglx>
 <877cu83v45.ffs@tglx> <874jpc3s3r.ffs@tglx>
 <0f5463fd-9c4a-6361-adbb-dd89dbb9138d@citrix.com>
 <c2aaa4fb-a5ba-d5bf-634a-dcf4fd8ad246@citrix.com> <871qkf3qek.ffs@tglx>
 <26d385da-2ede-5d73-2959-84c8f7d89e03@citrix.com> <87y1mm3iqz.ffs@tglx>
 <ZEFRhXua6Jxvit1R@google.com> <87v8hq35sk.ffs@tglx>
 <56e59a4d-a47f-4bfe-7db5-5f921062ad69@molgen.mpg.de>
Date:   Thu, 20 Apr 2023 21:10:38 +0200
Message-ID: <87sfcu2wup.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 20 2023 at 18:47, Paul Menzel wrote:
> Am 20.04.23 um 17:57 schrieb Thomas Gleixner:
> I quickly applied it on top of your branch, but I am getting:

As I said it was untested. I was traveling and did not have access to a
machine to even build it completely. Fixed up and tested version below.

Thanks,

        tglx
---
--- a/arch/x86/include/asm/apicdef.h
+++ b/arch/x86/include/asm/apicdef.h
@@ -138,7 +138,8 @@
 #define		APIC_EILVT_MASKED	(1 << 16)
 
 #define APIC_BASE (fix_to_virt(FIX_APIC_BASE))
-#define APIC_BASE_MSR	0x800
+#define APIC_BASE_MSR		0x800
+#define APIC_X2APIC_ID_MSR	0x802
 #define XAPIC_ENABLE	(1UL << 11)
 #define X2APIC_ENABLE	(1UL << 10)
 
@@ -162,6 +163,7 @@
 #define APIC_CPUID(apicid)	((apicid) & XAPIC_DEST_CPUS_MASK)
 #define NUM_APIC_CLUSTERS	((BAD_APICID + 1) >> XAPIC_DEST_CPUS_SHIFT)
 
+#ifndef __ASSEMBLY__
 /*
  * the local APIC register structure, memory mapped. Not terribly well
  * tested, but we might eventually use this one in the future - the
@@ -435,4 +437,5 @@ enum apic_delivery_modes {
 	APIC_DELIVERY_MODE_EXTINT	= 7,
 };
 
+#endif /* !__ASSEMBLY__ */
 #endif /* _ASM_X86_APICDEF_H */
--- a/arch/x86/include/asm/smp.h
+++ b/arch/x86/include/asm/smp.h
@@ -195,14 +195,13 @@ extern void nmi_selftest(void);
 #endif
 
 extern unsigned int smpboot_control;
+extern unsigned long apic_mmio_base;
 
 #endif /* !__ASSEMBLY__ */
 
 /* Control bits for startup_64 */
-#define STARTUP_APICID_CPUID_1F 0x80000000
-#define STARTUP_APICID_CPUID_0B 0x40000000
-#define STARTUP_APICID_CPUID_01 0x20000000
-#define STARTUP_APICID_SEV_ES	0x10000000
+#define STARTUP_READ_APICID	0x80000000
+#define STARTUP_APICID_SEV_ES	0x40000000
 
 /* Top 8 bits are reserved for control */
 #define STARTUP_PARALLEL_MASK	0xFF000000
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -101,6 +101,8 @@ static int apic_extnmi __ro_after_init =
  */
 static bool virt_ext_dest_id __ro_after_init;
 
+unsigned long apic_mmio_base __ro_after_init;
+
 /*
  * Map cpu index to physical APIC ID
  */
@@ -2164,6 +2166,7 @@ void __init register_lapic_address(unsig
 
 	if (!x2apic_mode) {
 		set_fixmap_nocache(FIX_APIC_BASE, address);
+		apic_mmio_base = APIC_BASE;
 		apic_printk(APIC_VERBOSE, "mapped APIC to %16lx (%16lx)\n",
 			    APIC_BASE, address);
 	}
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -24,8 +24,10 @@
 #include "../entry/calling.h"
 #include <asm/export.h>
 #include <asm/nospec-branch.h>
+#include <asm/apicdef.h>
 #include <asm/fixmap.h>
 #include <asm/smp.h>
+
 #include <asm/sev-common.h>
 
 /*
@@ -237,37 +239,25 @@ SYM_INNER_LABEL(secondary_startup_64_no_
 
 #ifdef CONFIG_SMP
 	/*
-	 * For parallel boot, the APIC ID is retrieved from CPUID, and then
-	 * used to look up the CPU number.  For booting a single CPU, the
-	 * CPU number is encoded in smpboot_control.
+	 * For parallel boot, the APIC ID is either retrieved the APIC or
+	 * from CPUID, and then used to look up the CPU number.
+	 * For booting a single CPU, the CPU number is encoded in
+	 * smpboot_control.
 	 *
-	 * Bit 31	STARTUP_APICID_CPUID_1F flag (use CPUID 0x1f)
-	 * Bit 30	STARTUP_APICID_CPUID_0B flag (use CPUID 0x0b)
-	 * Bit 29	STARTUP_APICID_CPUID_01 flag (use CPUID 0x01)
-	 * Bit 28	STARTUP_APICID_SEV_ES flag (CPUID 0x0b via GHCB MSR)
+	 * Bit 31	STARTUP_APICID_READ (Read APICID from APIC)
+	 * Bit 30	STARTUP_APICID_SEV_ES flag (CPUID 0x0b via GHCB MSR)
 	 * Bit 0-23	CPU# if STARTUP_APICID_CPUID_xx flags are not set
 	 */
 	movl	smpboot_control(%rip), %ecx
+	testl	$STARTUP_READ_APICID, %ecx
+	jnz	.Lread_apicid
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 	testl	$STARTUP_APICID_SEV_ES, %ecx
 	jnz	.Luse_sev_cpuid_0b
 #endif
-	testl	$STARTUP_APICID_CPUID_1F, %ecx
-	jnz	.Luse_cpuid_1f
-	testl	$STARTUP_APICID_CPUID_0B, %ecx
-	jnz	.Luse_cpuid_0b
-	testl	$STARTUP_APICID_CPUID_01, %ecx
-	jnz	.Luse_cpuid_01
 	andl	$(~STARTUP_PARALLEL_MASK), %ecx
 	jmp	.Lsetup_cpu
 
-.Luse_cpuid_01:
-	mov	$0x01, %eax
-	cpuid
-	mov	%ebx, %edx
-	shr	$24, %edx
-	jmp	.Lsetup_AP
-
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 .Luse_sev_cpuid_0b:
 	/* Set the GHCB MSR to request CPUID 0x0B_EDX */
@@ -292,24 +282,30 @@ SYM_INNER_LABEL(secondary_startup_64_no_
 	jmp	.Lsetup_AP
 #endif
 
-.Luse_cpuid_0b:
-	mov	$0x0B, %eax
-	xorl	%ecx, %ecx
-	cpuid
+.Lread_apicid:
+	mov	$MSR_IA32_APICBASE, %ecx
+	rdmsr
+	testl	$X2APIC_ENABLE, %eax
+	jnz	.Lread_apicid_msr
+
+	/* Read the APIC ID from the fix-mapped MMIO space. */
+	movq	apic_mmio_base(%rip), %rcx
+	addq	$APIC_ID, %rcx
+	movl	(%rcx), %eax
+	shr	$24, %eax
 	jmp	.Lsetup_AP
 
-.Luse_cpuid_1f:
-	mov	$0x1f, %eax
-	xorl	%ecx, %ecx
-	cpuid
+.Lread_apicid_msr:
+	mov	$APIC_X2APIC_ID_MSR, %ecx
+	rdmsr
 
 .Lsetup_AP:
-	/* EDX contains the APIC ID of the current CPU */
+	/* EAX contains the APIC ID of the current CPU */
 	xorq	%rcx, %rcx
 	leaq	cpuid_to_apicid(%rip), %rbx
 
 .Lfind_cpunr:
-	cmpl	(%rbx,%rcx,4), %edx
+	cmpl	(%rbx,%rcx,4), %eax
 	jz	.Lsetup_cpu
 	inc	%ecx
 #ifdef CONFIG_FORCE_NR_CPUS
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1253,41 +1253,22 @@ bool __init arch_cpuhp_init_parallel_bri
 		return false;
 	}
 
-	/* Encrypted guests require special CPUID handling. */
+	/* Encrypted guests require special handling. */
 	if (cc_platform_has(CC_ATTR_GUEST_STATE_ENCRYPT)) {
 		switch (cc_get_vendor()) {
 		case CC_VENDOR_AMD:
 			ctrl = STARTUP_APICID_SEV_ES;
 			if (topology_extended_leaf == 0x0b)
-				goto setup;
+				break;
 			fallthrough;
 		default:
 			pr_info("Parallel CPU startup disabled due to guest state encryption\n");
 			return false;
 		}
+	} else {
+		ctrl = STARTUP_READ_APICID;
 	}
 
-	switch (topology_extended_leaf) {
-	case 0x0b:
-		ctrl = STARTUP_APICID_CPUID_0B;
-		break;
-	case 0x1f:
-		ctrl = STARTUP_APICID_CPUID_1F;
-		break;
-	case 0x00:
-		/* For !x2APIC mode 8 bits from leaf 0x01 are sufficient. */
-		if (!x2apic_mode) {
-			ctrl = STARTUP_APICID_CPUID_01;
-			break;
-		}
-		fallthrough;
-	default:
-		pr_info("Parallel CPU startup disabled. Unsupported topology leaf %u\n",
-			topology_extended_leaf);
-		return false;
-	}
-
-setup:
 	pr_debug("Parallel CPU startup enabled: 0x%08x\n", ctrl);
 	smpboot_control = ctrl;
 	return true;
