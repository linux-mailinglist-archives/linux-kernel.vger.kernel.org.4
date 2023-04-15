Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 840456E3192
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Apr 2023 15:22:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbjDONWu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Apr 2023 09:22:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbjDONWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Apr 2023 09:22:48 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F79B210A;
        Sat, 15 Apr 2023 06:22:46 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id r184so5580152ybc.1;
        Sat, 15 Apr 2023 06:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681564965; x=1684156965;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FVzmiHK64lr1yWOA/+XrXfsMmSyuvLawYPiT7JCvob8=;
        b=kzN6Qldowb67XS8W5yIr9TKg8Wd1DqCY2ePREiBWY/NtxgAgDeDo2TRyur9nar8C++
         HnTU0sGESuNQrLXZCmp3MbPSMe1ctHBcEzOeudm0xjlT82JqM37TyyV1w921MOnZOt6Z
         Yl7JLD1auTWmNaBAqeCDaHjO1FCRr0N1PCoLWMJkB962BgyPgRGiSnVZP/zKM+Wii/Z6
         avk+V5z1zf7aKn7zz8tC7iPNYYczHe6njW5BJijHx4bRAJcJmA1C+2uvle8w9h0679Xe
         I+RvsIyQOxeJGPvDgiUZDzz/5uSuqAkakw1Oh0ISxsKLLZT6a+aMlHFulUbAlWle21kk
         M3lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681564965; x=1684156965;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FVzmiHK64lr1yWOA/+XrXfsMmSyuvLawYPiT7JCvob8=;
        b=MDFxrTfx4EvQE0lsiOq+4tArUsKMJnOZStqOIR/xbwSw7aQe4Z9+CLcxeIbhqX3ERk
         hDTeahFdYbeMhU5Gb+Aewm64dNEravWy8hjRq0daG+C7jeTfGXy2pop65j/mnyMoIdMu
         wy49erxgsPlY3XqyUcYBZkPsxCJzc2ZvZSMGjrpP8pHa1xj2KsTB0DOdbs0QpIx4AXUE
         arDWaydXNfDjA+VRs0oTkF4lqkL/WIheSxGPxt8VzVBR6L20IYrZNp1wxWKyXjkzuqRe
         96QOtelINvdwd67d0h3NDgyunTakFi3Jj5sWY3jP2WI+r9TTUDxjs3gRxd98vnP6HkOe
         vgWw==
X-Gm-Message-State: AAQBX9dJ0m2Zpn918znsC7TQ2Nf5HLBd1ERHIqxxejuOruAHWE83FUj3
        n6MTwsxbfqr3vYCUXs8eGPwuItDTikbVXWZYGg==
X-Google-Smtp-Source: AKy350ZOA4eLsjA57UfjGyPrbRouS5+i8hiU4IROzy4HMM/uTm55VtPGAF6abh2Q+UqEwUzS/wn5tzSKLFF9guCfVhM=
X-Received: by 2002:a25:df94:0:b0:b8b:f5fb:5986 with SMTP id
 w142-20020a25df94000000b00b8bf5fb5986mr5819247ybg.10.1681564965560; Sat, 15
 Apr 2023 06:22:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230414225551.858160935@linutronix.de> <20230414232311.379210081@linutronix.de>
In-Reply-To: <20230414232311.379210081@linutronix.de>
From:   Brian Gerst <brgerst@gmail.com>
Date:   Sat, 15 Apr 2023 09:22:34 -0400
Message-ID: <CAMzpN2hUbYpYrqDL1ViXUWGKGa7mDEG6iHtWEZg9GvrAoRgvKQ@mail.gmail.com>
Subject: Re: [patch 35/37] x86/smpboot: Support parallel startup of secondary CPUs
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        David Woodhouse <dwmw@infradead.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Arjan van de Veen <arjan@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Paul McKenney <paulmck@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Piotr Gorski <lucjan.lucjanov@gmail.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
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
        Sabin Rapan <sabrapan@amazon.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 14, 2023 at 7:45=E2=80=AFPM Thomas Gleixner <tglx@linutronix.de=
> wrote:
>
> From: David Woodhouse <dwmw@amazon.co.uk>
>
> Rework the real-mode startup code to allow for APs to be brought up in
> parallel. This is in two parts:
>
>  1. Introduce a bit-spinlock to prevent them from all using the real
>     mode stack at the same time.
>
>  2. Avoid needing to use the global smpboot_control variable to pass
>     each AP its CPU number.
>
> To achieve the latter, export the cpuid_to_apicid[] array so that each
> AP can find its own CPU number by searching therein based on its APIC ID.
>
> Introduce flags in the top bits of smpboot_control which indicate methods
> by which an AP should find its CPU number. For a serialized bringup, the
> CPU number is explicitly passed in the low bits of smpboot_control as
> before. For parallel mode there are flags directing the AP to find its AP=
IC
> ID in CPUID leaf 0x0b or 1x1f (for X2APIC mode) or CPUID leaf 0x01 where =
8
> bits are sufficient, then perform the cpuid_to_apicid[] lookup with that.
>
> Aside from the fact that APs will now look up their CPU number via the
> newly-exported cpuid_to_apicid[] table, there is no behavioural change
> intended, since the parallel bootup has not yet been enabled.
>
> [ tglx: Initial proof of concept patch with bitlock and APIC ID lookup ]
> [ dwmw2: Rework and testing, commit message, CPUID 0x1 and CPU0 support ]
> [ seanc: Fix stray override of initial_gs in common_cpu_up() ]
> [ Oleksandr Natalenko: reported suspend/resume issue fixed in
>   x86_acpi_suspend_lowlevel ]
>
> Co-developed-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Co-developed-by: Brian Gerst <brgerst@gmail.com>
> Signed-off-by: Brian Gerst <brgerst@gmail.com>
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> Signed-off-by: Usama Arif <usama.arif@bytedance.com>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  arch/x86/include/asm/apic.h          |    2
>  arch/x86/include/asm/realmode.h      |    3 +
>  arch/x86/include/asm/smp.h           |    8 +++
>  arch/x86/kernel/acpi/sleep.c         |    9 +++
>  arch/x86/kernel/apic/apic.c          |    2
>  arch/x86/kernel/head_64.S            |   79 ++++++++++++++++++++++++++++=
++++++-
>  arch/x86/kernel/smpboot.c            |    5 --
>  arch/x86/realmode/init.c             |    3 +
>  arch/x86/realmode/rm/trampoline_64.S |   27 +++++++++--
>  9 files changed, 125 insertions(+), 13 deletions(-)
>
> --- a/arch/x86/include/asm/apic.h
> +++ b/arch/x86/include/asm/apic.h
> @@ -55,6 +55,8 @@ extern int local_apic_timer_c2_ok;
>  extern int disable_apic;
>  extern unsigned int lapic_timer_period;
>
> +extern int cpuid_to_apicid[];
> +
>  extern enum apic_intr_mode_id apic_intr_mode;
>  enum apic_intr_mode_id {
>         APIC_PIC,
> --- a/arch/x86/include/asm/realmode.h
> +++ b/arch/x86/include/asm/realmode.h
> @@ -52,6 +52,7 @@ struct trampoline_header {
>         u64 efer;
>         u32 cr4;
>         u32 flags;
> +       u32 lock;
>  #endif
>  };
>
> @@ -64,6 +65,8 @@ extern unsigned long initial_stack;
>  extern unsigned long initial_vc_handler;
>  #endif
>
> +extern u32 *trampoline_lock;
> +
>  extern unsigned char real_mode_blob[];
>  extern unsigned char real_mode_relocs[];
>
> --- a/arch/x86/include/asm/smp.h
> +++ b/arch/x86/include/asm/smp.h
> @@ -198,4 +198,12 @@ extern unsigned int smpboot_control;
>
>  #endif /* !__ASSEMBLY__ */
>
> +/* Control bits for startup_64 */
> +#define STARTUP_APICID_CPUID_1F 0x80000000
> +#define STARTUP_APICID_CPUID_0B 0x40000000
> +#define STARTUP_APICID_CPUID_01 0x20000000
> +
> +/* Top 8 bits are reserved for control */
> +#define STARTUP_PARALLEL_MASK  0xFF000000
> +
>  #endif /* _ASM_X86_SMP_H */
> --- a/arch/x86/kernel/acpi/sleep.c
> +++ b/arch/x86/kernel/acpi/sleep.c
> @@ -16,6 +16,7 @@
>  #include <asm/cacheflush.h>
>  #include <asm/realmode.h>
>  #include <asm/hypervisor.h>
> +#include <asm/smp.h>
>
>  #include <linux/ftrace.h>
>  #include "../../realmode/rm/wakeup.h"
> @@ -127,7 +128,13 @@ int x86_acpi_suspend_lowlevel(void)
>          * value is in the actual %rsp register.
>          */
>         current->thread.sp =3D (unsigned long)temp_stack + sizeof(temp_st=
ack);
> -       smpboot_control =3D smp_processor_id();
> +       /*
> +        * Ensure the CPU knows which one it is when it comes back, if
> +        * it isn't in parallel mode and expected to work that out for
> +        * itself.
> +        */
> +       if (!(smpboot_control & STARTUP_PARALLEL_MASK))
> +               smpboot_control =3D smp_processor_id();
>  #endif
>         initial_code =3D (unsigned long)wakeup_long64;
>         saved_magic =3D 0x123456789abcdef0L;
> --- a/arch/x86/kernel/apic/apic.c
> +++ b/arch/x86/kernel/apic/apic.c
> @@ -2377,7 +2377,7 @@ static int nr_logical_cpuids =3D 1;
>  /*
>   * Used to store mapping between logical CPU IDs and APIC IDs.
>   */
> -static int cpuid_to_apicid[] =3D {
> +int cpuid_to_apicid[] =3D {
>         [0 ... NR_CPUS - 1] =3D -1,
>  };
>
> --- a/arch/x86/kernel/head_64.S
> +++ b/arch/x86/kernel/head_64.S
> @@ -25,6 +25,7 @@
>  #include <asm/export.h>
>  #include <asm/nospec-branch.h>
>  #include <asm/fixmap.h>
> +#include <asm/smp.h>
>
>  /*
>   * We are not able to switch in one step to the final KERNEL ADDRESS SPA=
CE
> @@ -234,8 +235,70 @@ SYM_INNER_LABEL(secondary_startup_64_no_
>         ANNOTATE_NOENDBR // above
>
>  #ifdef CONFIG_SMP
> +       /*
> +        * For parallel boot, the APIC ID is retrieved from CPUID, and th=
en
> +        * used to look up the CPU number.  For booting a single CPU, the
> +        * CPU number is encoded in smpboot_control.
> +        *
> +        * Bit 31       STARTUP_APICID_CPUID_1F flag (use CPUID 0x1f)
> +        * Bit 30       STARTUP_APICID_CPUID_0B flag (use CPUID 0x0b)
> +        * Bit 29       STARTUP_APICID_CPUID_01 flag (use CPUID 0x01)
> +        * Bit 0-23     CPU# if STARTUP_APICID_CPUID_xx flags are not set
> +        */
>         movl    smpboot_control(%rip), %ecx
> +       testl   $STARTUP_APICID_CPUID_1F, %ecx
> +       jnz     .Luse_cpuid_1f
> +       testl   $STARTUP_APICID_CPUID_0B, %ecx
> +       jnz     .Luse_cpuid_0b
> +       testl   $STARTUP_APICID_CPUID_01, %ecx
> +       jnz     .Luse_cpuid_01
> +       andl    $(~STARTUP_PARALLEL_MASK), %ecx
> +       jmp     .Lsetup_cpu
> +
> +.Luse_cpuid_01:
> +       mov     $0x01, %eax
> +       cpuid
> +       mov     %ebx, %edx
> +       shr     $24, %edx
> +       jmp     .Lsetup_AP
> +
> +.Luse_cpuid_0b:
> +       mov     $0x0B, %eax
> +       xorl    %ecx, %ecx
> +       cpuid
> +       jmp     .Lsetup_AP
> +
> +.Luse_cpuid_1f:
> +       mov     $0x1f, %eax
> +       xorl    %ecx, %ecx
> +       cpuid
>
> +.Lsetup_AP:
> +       /* EDX contains the APIC ID of the current CPU */
> +       xorq    %rcx, %rcx
> +       leaq    cpuid_to_apicid(%rip), %rbx
> +
> +.Lfind_cpunr:
> +       cmpl    (%rbx,%rcx,4), %edx
> +       jz      .Lsetup_cpu
> +       inc     %ecx
> +#ifdef CONFIG_FORCE_NR_CPUS
> +       cmpl    $NR_CPUS, %ecx
> +#else
> +       cmpl    nr_cpu_ids(%rip), %ecx
> +#endif
> +       jb      .Lfind_cpunr
> +
> +       /*  APIC ID not found in the table. Drop the trampoline lock and =
bail. */
> +       movq    trampoline_lock(%rip), %rax
> +       lock
> +       btrl    $0, (%rax)
> +
> +1:     cli
> +       hlt
> +       jmp     1b
> +
> +.Lsetup_cpu:
>         /* Get the per cpu offset for the given CPU# which is in ECX */
>         movq    __per_cpu_offset(,%rcx,8), %rdx
>  #else
> @@ -248,10 +311,20 @@ SYM_INNER_LABEL(secondary_startup_64_no_
>          *
>          * RDX contains the per-cpu offset
>          */
> -       movq    pcpu_hot + X86_current_task(%rdx), %rax
> -       movq    TASK_threadsp(%rax), %rsp
> +       movq    pcpu_hot + X86_top_of_stack(%rdx), %rsp

Switching to using pcpu_hot.top_of_stack is ok, but it's not
completely equivalent.  top_of_stack points to the end of the pt_regs
structure, while the kernel stack starts below pt_regs even for kernel
threads.  So you need to subtract PTREGS_SIZE from the stack pointer
after this.

This change should also be a separate patch.

--
Brian Gerst
