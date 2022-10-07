Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 710CD5F7E72
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 22:03:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbiJGUDu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 16:03:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230053AbiJGUDn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 16:03:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A8D112C8B0
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 13:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665173019;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jaDcObpjcx0whPL96jk38beBrOuRKo+eqX0wqNpM3Cc=;
        b=P+lIyk+e0CPKAEcXbbQsDGytM3pSE2HiXWeW7NP38w5yUSHLYGCuSuucP33CsCkagHA0Xl
        151o2pP9yjDQ1PeDz0xhPVbLkmo8lCO3ZH7OMrITtTWxWfWY5mkXbEVSe9xPFuqCCFlhIl
        3Pk9fHEL2zLDpOzOjIrrd39Z4gNTtAk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-264-kStNREYhN0OL2iSIbHz80Q-1; Fri, 07 Oct 2022 16:03:36 -0400
X-MC-Unique: kStNREYhN0OL2iSIbHz80Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 67B08882826;
        Fri,  7 Oct 2022 20:03:34 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-2.gru2.redhat.com [10.97.112.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 29A1A2166B4D;
        Fri,  7 Oct 2022 20:03:32 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id 258DA416CE48; Fri,  7 Oct 2022 17:01:33 -0300 (-03)
Date:   Fri, 7 Oct 2022 17:01:33 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Valentin Schneider <vschneid@redhat.com>
Cc:     linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
        openrisc@lists.librecores.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        x86@kernel.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Juri Lelli <juri.lelli@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Nicholas Piggin <npiggin@gmail.com>,
        Guo Ren <guoren@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [RFC PATCH 0/5] Generic IPI sending tracepoint
Message-ID: <Y0CFnWDpMNGajIRD@fuller.cnet>
References: <20221007154145.1877054-1-vschneid@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221007154145.1877054-1-vschneid@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Valentin,

On Fri, Oct 07, 2022 at 04:41:40PM +0100, Valentin Schneider wrote:
> Background
> ==========
> 
> Detecting IPI *reception* is relatively easy, e.g. using
> trace_irq_handler_{entry,exit} or even just function-trace
> flush_smp_call_function_queue() for SMP calls.  
> 
> Figuring out their *origin*, is trickier as there is no generic tracepoint tied
> to e.g. smp_call_function():
> 
> o AFAIA x86 has no tracepoint tied to sending IPIs, only receiving them
>   (cf. trace_call_function{_single}_entry()).
> o arm/arm64 do have trace_ipi_raise(), which gives us the target cpus but also a
>   mostly useless string (smp_calls will all be "Function call interrupts").
> o Other architectures don't seem to have any IPI-sending related tracepoint.  
> 
> I believe one reason those tracepoints used by arm/arm64 ended up as they were
> is because these archs used to handle IPIs differently from regular interrupts
> (the IRQ driver would directly invoke an IPI-handling routine), which meant they 
> never showed up in trace_irq_handler_{entry, exit}. The trace_ipi_{entry,exit}
> tracepoints gave a way to trace IPI reception but those have become redundant as
> of: 
> 
>       56afcd3dbd19 ("ARM: Allow IPIs to be handled as normal interrupts")
>       d3afc7f12987 ("arm64: Allow IPIs to be handled as normal interrupts")
> 
> which gave IPIs a "proper" handler function used through
> generic_handle_domain_irq(), which makes them show up via
> trace_irq_handler_{entry, exit}.
> 
> Changing stuff up
> =================
> 
> Per the above, it would make sense to reshuffle trace_ipi_raise() and move it
> into generic code. This also came up during Daniel's talk on Osnoise at the CPU
> isolation MC of LPC 2022 [1]. 
> 
> Now, to be useful, such a tracepoint needs to export:
> o targeted CPU(s)
> o calling context
> 
> The only way to get the calling context with trace_ipi_raise() is to trigger a
> stack dump, e.g. $(trace-cmd -e ipi* -T echo 42).
> 
> As for the targeted CPUs, the existing tracepoint does export them, albeit in
> cpumask form, which is quite inconvenient from a tooling perspective. For
> instance, as far as I'm aware, it's not possible to do event filtering on a
> cpumask via trace-cmd.

https://man7.org/linux/man-pages/man1/trace-cmd-set.1.html

       -f filter
           Specify a filter for the previous event. This must come after
           a -e. This will filter what events get recorded based on the
           content of the event. Filtering is passed to the kernel
           directly so what filtering is allowed may depend on what
           version of the kernel you have. Basically, it will let you
           use C notation to check if an event should be processed or
           not.

               ==, >=, <=, >, <, &, |, && and ||

           The above are usually safe to use to compare fields.

This looks overkill to me (consider large number of bits set in mask).

+#define trace_ipi_send_cpumask(callsite, mask) do {            \
+	if (static_key_false(&__tracepoint_ipi_send_cpu.key)) { \
+               int cpu;                                        \
+               for_each_cpu(cpu, mask)                         \
+                       trace_ipi_send_cpu(callsite, cpu);	\
+	}                                                       \
+} while (0)


> 
> Because of the above points, this is introducing a new tracepoint.
> 
> Patches
> =======
> 
> This results in having trace events for:
> 
> o smp_call_function*()
> o smp_send_reschedule()
> o irq_work_queue*()
> 
> This is incomplete, just looking at arm64 there's more IPI types that aren't covered:
> 
>   IPI_CPU_STOP,
>   IPI_CPU_CRASH_STOP,
>   IPI_TIMER,
>   IPI_WAKEUP,
> 
> ... But it feels like a good starting point.

Can't you have a single tracepoint (or variant with cpumask) that would
cover such cases as well?

Maybe (as parameters for tracepoint):

	* type (reschedule, smp_call_function, timer, wakeup, ...).

	* function address: valid for smp_call_function, irq_work_queue
	  types.

> Another thing worth mentioning is that depending on the callsite, the _RET_IP_
> fed to the tracepoint is not always useful - generic_exec_single() doesn't tell
> you much about the actual callback being sent via IPI, so there might be value
> in exploding the single tracepoint into at least one variant for smp_calls.

Not sure i grasp what you mean by "exploding the single tracepoint...",
but yes knowing the function or irq work function is very useful.

> 
> Links
> =====
> 
> [1]: https://youtu.be/5gT57y4OzBM?t=14234
> 
> Valentin Schneider (5):
>   trace: Add trace_ipi_send_{cpu, cpumask}
>   sched, smp: Trace send_call_function_single_ipi()
>   smp: Add a multi-CPU variant to send_call_function_single_ipi()
>   irq_work: Trace calls to arch_irq_work_raise()
>   treewide: Rename and trace arch-definitions of smp_send_reschedule()
> 
>  arch/alpha/kernel/smp.c          |  2 +-
>  arch/arc/kernel/smp.c            |  2 +-
>  arch/arm/kernel/smp.c            |  5 +----
>  arch/arm64/kernel/smp.c          |  3 +--
>  arch/csky/kernel/smp.c           |  2 +-
>  arch/hexagon/kernel/smp.c        |  2 +-
>  arch/ia64/kernel/smp.c           |  4 ++--
>  arch/loongarch/include/asm/smp.h |  2 +-
>  arch/mips/include/asm/smp.h      |  2 +-
>  arch/openrisc/kernel/smp.c       |  2 +-
>  arch/parisc/kernel/smp.c         |  4 ++--
>  arch/powerpc/kernel/smp.c        |  4 ++--
>  arch/riscv/kernel/smp.c          |  4 ++--
>  arch/s390/kernel/smp.c           |  2 +-
>  arch/sh/kernel/smp.c             |  2 +-
>  arch/sparc/kernel/smp_32.c       |  2 +-
>  arch/sparc/kernel/smp_64.c       |  2 +-
>  arch/x86/include/asm/smp.h       |  2 +-
>  arch/xtensa/kernel/smp.c         |  2 +-
>  include/linux/smp.h              |  1 +
>  include/trace/events/ipi.h       | 27 +++++++++++++++++++++++++++
>  kernel/irq_work.c                | 12 +++++++++++-
>  kernel/sched/core.c              |  7 +++++--
>  kernel/smp.c                     | 18 +++++++++++++++++-
>  24 files changed, 84 insertions(+), 31 deletions(-)
> 
> --
> 2.31.1
> 
> 

