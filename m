Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A971716E26
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 21:52:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232734AbjE3Twc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 15:52:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233456AbjE3Tw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 15:52:28 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D529B136;
        Tue, 30 May 2023 12:52:03 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1685476320;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LJ3pwe5VO2kqAY2WBljz3EqXfTvvu+3J346IL0PSsq8=;
        b=xpL4T8aPYWldl3m+QrLxN+At2fc+ZjAC6pEU4MuUjTSaZuj6IDFe6UakfjWnmmW8hKClix
        t7yS6D3ihlSEIf30gGCLXhg08YwOKfQvUQI3IgIl2aHuedpFPvjibaFkiCGXlhLxeGBGkW
        dGEwWvRoq2mQEzRs8oh56PiUJi2/s5QyH4qWIPL9JI/tQVBvtD0plLFK4LpxUmoH0fO1+H
        nGl/daQybL4Usq3PzahflEHPTKXjDjpOAZxUsLIwJWvToU8rpo8vLXAXsklySZIyOPhZMU
        EowGzZyfscIPTe6Qwpi0Biu3nomQmhobdOQI00py4ZRFq1Ph0F82SiNDS5umEg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1685476320;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LJ3pwe5VO2kqAY2WBljz3EqXfTvvu+3J346IL0PSsq8=;
        b=lIHbo7YKz61HDwNtVfFSrVm0Wqi8uCKfx3OWvRqPS+VwOS/NPYknS3d/X/ObIVAcsa60Eq
        QcFAHQnns6at8LBA==
To:     Sean Christopherson <seanjc@google.com>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        David Woodhouse <dwmw2@infradead.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Brian Gerst <brgerst@gmail.com>,
        Arjan van de Veen <arjan@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Paul McKenney <paulmck@kernel.org>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Piotr Gorski <lucjan.lucjanov@gmail.com>,
        Usama Arif <usama.arif@bytedance.com>,
        Juergen Gross <jgross@suse.com>,
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
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Sabin Rapan <sabrapan@amazon.com>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [patch] x86/smpboot: Disable parallel bootup if cc_vendor != NONE
In-Reply-To: <ZHYqwsCURnrFdsVm@google.com>
References: <87sfbhlwp9.ffs@tglx>
 <20230529023939.mc2akptpxcg3eh2f@box.shutemov.name> <87bki3kkfi.ffs@tglx>
 <20230529203129.sthnhzgds7ynddxd@box.shutemov.name>
 <20230530005428.jyrc2ezx5raohlrt@box.shutemov.name> <87mt1mjhk3.ffs@tglx>
 <87jzwqjeey.ffs@tglx> <87cz2ija1e.ffs@tglx>
 <20230530122951.2wu5rwcu26ofov6f@box.shutemov.name> <87wn0pizbl.ffs@tglx>
 <ZHYqwsCURnrFdsVm@google.com>
Date:   Tue, 30 May 2023 21:51:59 +0200
Message-ID: <87leh5iom8.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 30 2023 at 09:56, Sean Christopherson wrote:
> On Tue, May 30, 2023, Thomas Gleixner wrote:
>> On Tue, May 30 2023 at 15:29, Kirill A. Shutemov wrote:
>> > On Tue, May 30, 2023 at 02:09:17PM +0200, Thomas Gleixner wrote:
>> >> The decision to allow parallel bringup of secondary CPUs checks
>> >> CC_ATTR_GUEST_STATE_ENCRYPT to detect encrypted guests. Those cannot use
>> >> parallel bootup because accessing the local APIC is intercepted and raises
>> >> a #VC or #VE, which cannot be handled at that point.
>> >> 
>> >> The check works correctly, but only for AMD encrypted guests. TDX does not
>> >> set that flag.
>> >> 
>> >> Check for cc_vendor != CC_VENDOR_NONE instead. That might be overbroad, but
>> >> definitely works for both AMD and Intel.
>> >
>> > It boots fine with TDX, but I think it is wrong. cc_get_vendor() will
>> > report CC_VENDOR_AMD even on bare metal if SME is enabled. I don't think
>> > we want it.
>> 
>> Right. Did not think about that.
>> 
>> But the same way is CC_ATTR_GUEST_MEM_ENCRYPT overbroad for AMD. Only
>> SEV-ES traps RDMSR if I'm understandig that maze correctly.
>
> Ya, regular SEV doesn't encrypt register state.

That aside. From a semantical POV making this decision about parallel
bootup based on some magic CC encryption attribute is questionable.

I'm tending to just do the below and make this CC agnostic (except that
I couldn't find the right spot for SEV-ES to clear that flag.)

Thanks,

        tglx
---
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -871,5 +871,7 @@ void __init tdx_early_init(void)
 	x86_platform.guest.enc_tlb_flush_required   = tdx_tlb_flush_required;
 	x86_platform.guest.enc_status_change_finish = tdx_enc_status_changed;
 
+	x86_cpuinit.parallel_bringup = false;
+
 	pr_info("Guest detected\n");
 }
--- a/arch/x86/include/asm/x86_init.h
+++ b/arch/x86/include/asm/x86_init.h
@@ -2,6 +2,7 @@
 #ifndef _ASM_X86_PLATFORM_H
 #define _ASM_X86_PLATFORM_H
 
+#include <linux/bits.h>
 #include <asm/bootparam.h>
 
 struct ghcb;
@@ -177,11 +178,14 @@ struct x86_init_ops {
  * struct x86_cpuinit_ops - platform specific cpu hotplug setups
  * @setup_percpu_clockev:	set up the per cpu clock event device
  * @early_percpu_clock_init:	early init of the per cpu clock event device
+ * @fixup_cpu_id:		fixup function for cpuinfo_x86::phys_proc_id
+ * @parallel_bringup:		Parallel bringup control
  */
 struct x86_cpuinit_ops {
 	void (*setup_percpu_clockev)(void);
 	void (*early_percpu_clock_init)(void);
 	void (*fixup_cpu_id)(struct cpuinfo_x86 *c, int node);
+	bool parallel_bringup;
 };
 
 struct timespec64;
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1287,6 +1287,11 @@ bool __init arch_cpuhp_init_parallel_bri
 		return false;
 	}
 
+	if (!x86_cpuinit.parallel_bringup) {
+		pr_info("Parallel CPU startup disabled by the platform\n");
+		return false;
+	}
+
 	smpboot_control = STARTUP_READ_APICID;
 	pr_debug("Parallel CPU startup enabled: 0x%08x\n", smpboot_control);
 	return true;
--- a/arch/x86/kernel/x86_init.c
+++ b/arch/x86/kernel/x86_init.c
@@ -126,6 +126,7 @@ struct x86_init_ops x86_init __initdata
 struct x86_cpuinit_ops x86_cpuinit = {
 	.early_percpu_clock_init	= x86_init_noop,
 	.setup_percpu_clockev		= setup_secondary_APIC_clock,
+	.parallel_bringup		= true,
 };
 
 static void default_nmi_init(void) { };
