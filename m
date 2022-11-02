Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE602616C2D
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 19:31:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230433AbiKBSbv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 14:31:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230086AbiKBSbr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 14:31:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FCAD23BC7
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 11:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667413846;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=DOAMp7M3Dm3mqYAl0WmtrSxJ5fQ0T+HY063YNavNlMw=;
        b=g+KFPwmDLvKdiWtiHpKFOD9ydxTQkjPSoiuCAjNAoYGvBlkYU6+JXwjxJGyEN2pLFfm8mR
        /Q/wCMAMRSCtEzm40e/VI9a50PAvvOjYfv0vH4zFiOmJooQMHQXIQfEnYX2XPG+GjjTpVr
        j6V+wD1Q4a9kz6dCw1W5JLHJxUGKmSs=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-522-YyAGDR42MdmLCr38s9wslQ-1; Wed, 02 Nov 2022 14:30:46 -0400
X-MC-Unique: YyAGDR42MdmLCr38s9wslQ-1
Received: by mail-qv1-f69.google.com with SMTP id nh17-20020a056214391100b004bb6c16bd4dso10450528qvb.17
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 11:30:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DOAMp7M3Dm3mqYAl0WmtrSxJ5fQ0T+HY063YNavNlMw=;
        b=2SGvEdLmuNjSCrcSIF2HxVqI2QJBWI/qx4SI3UzxWS1zWShPsaUOcC5+Ev5QRwjG79
         iUWo4rxvaNnX4tvx69EMO0oeks6hCCAAxL33/Y4go0VArVZlA4NCknA5/hSLElZ4IqkA
         b78GW798JG4TrqZZmaS+8RCgcWYluj6VTNVQeWaJKxupxhimF16AVBhb3XYa6RUkcprw
         y4WGsWwFTJmhoLfZS+r8yux4ehK8AuEgf17tw77lTxb8Eg4Fx3nOm98tjcq+zFK3AvGR
         VGuBEBV/bs4+AxNV9qJS08Oe0z1bMYW/Y7RPENDHcPuCg1hjtbrKnXwro2qjsgA9rQJL
         gvpw==
X-Gm-Message-State: ACrzQf1qi3X9tIXXoIGuktRfbqRT+yJQryYBvp7H88sEuuyHOyLE5F8L
        OvxLpcHls/cJySLwFuhrTsdYd3fL4OIwQNupA88eS4N+T+ZaSJe8A6diynY2/iXYxFk//QYsxPv
        mYLTxMleLgaht+4rT03tczhZL
X-Received: by 2002:ac8:7d8c:0:b0:39c:f4b6:f02f with SMTP id c12-20020ac87d8c000000b0039cf4b6f02fmr20509029qtd.252.1667413840492;
        Wed, 02 Nov 2022 11:30:40 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4avLCdiC1e+YjDgGOUynVvkPGro1QBzGCbIXRErpBO4pdwyJNVuMKcAEHPTKixBfYKlupYaQ==
X-Received: by 2002:ac8:7d8c:0:b0:39c:f4b6:f02f with SMTP id c12-20020ac87d8c000000b0039cf4b6f02fmr20508984qtd.252.1667413840179;
        Wed, 02 Nov 2022 11:30:40 -0700 (PDT)
Received: from vschneid.remote.csb ([149.71.65.94])
        by smtp.gmail.com with ESMTPSA id s16-20020a05620a29d000b006cec8001bf4sm9133847qkp.26.2022.11.02.11.30.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 11:30:39 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
        openrisc@lists.librecores.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        x86@kernel.org
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Juri Lelli <juri.lelli@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Nicholas Piggin <npiggin@gmail.com>,
        Guo Ren <guoren@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: [RFC PATCH v2 0/8] Generic IPI sending tracepoint
Date:   Wed,  2 Nov 2022 18:29:41 +0000
Message-Id: <20221102182949.3119584-1-vschneid@redhat.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Background
==========

Detecting IPI *reception* is relatively easy, e.g. using
trace_irq_handler_{entry,exit} or even just function-trace
flush_smp_call_function_queue() for SMP calls.  

Figuring out their *origin*, is trickier as there is no generic tracepoint tied
to e.g. smp_call_function():

o AFAIA x86 has no tracepoint tied to sending IPIs, only receiving them
  (cf. trace_call_function{_single}_entry()).
o arm/arm64 do have trace_ipi_raise(), which gives us the target cpus but also a
  mostly useless string (smp_calls will all be "Function call interrupts").
o Other architectures don't seem to have any IPI-sending related tracepoint.  

I believe one reason those tracepoints used by arm/arm64 ended up as they were
is because these archs used to handle IPIs differently from regular interrupts
(the IRQ driver would directly invoke an IPI-handling routine), which meant they 
never showed up in trace_irq_handler_{entry, exit}. The trace_ipi_{entry,exit}
tracepoints gave a way to trace IPI reception but those have become redundant as
of: 

      56afcd3dbd19 ("ARM: Allow IPIs to be handled as normal interrupts")
      d3afc7f12987 ("arm64: Allow IPIs to be handled as normal interrupts")

which gave IPIs a "proper" handler function used through
generic_handle_domain_irq(), which makes them show up via
trace_irq_handler_{entry, exit}.

Changing stuff up
=================

Per the above, it would make sense to reshuffle trace_ipi_raise() and move it
into generic code. This also came up during Daniel's talk on Osnoise at the CPU
isolation MC of LPC 2022 [1]. 

Now, to be useful, such a tracepoint needs to export:
o targeted CPU(s)
o calling context

The only way to get the calling context with trace_ipi_raise() is to trigger a
stack dump, e.g. $(trace-cmd -e ipi* -T echo 42).

This is instead introducing a new tracepoint which exports the relevant context
(callsite, and requested callback for when the callsite isn't helpful), and is
usable by all architectures as it sits in generic code. 

Another thing worth mentioning is that depending on the callsite, the _RET_IP_
fed to the tracepoint is not always useful - generic_exec_single() doesn't tell
you much about the actual callback being sent via IPI, which is why the new
tracepoint also has a @callback argument.

Patches
=======

o Patch 1 is included for convenience and will most likely be merged
  independently. FYI I have libtraceevent patches [2] to improve the
  pretty-printing of cpumasks using the new type, which look like:
  <...>-3322  [021]   560.402583: ipi_send_cpumask:     cpumask=14,17,21 callsite=on_each_cpu_cond_mask+0x40 callback=flush_tlb_func+0x0
  <...>-187   [010]   562.590584: ipi_send_cpumask:     cpumask=0-23 callsite=on_each_cpu_cond_mask+0x40 callback=do_sync_core+0x0

o Patches 2-6 spread out the tracepoint accross relevant sites.
o Patch 8 is trying to be smart about tracing the callback associated with the
  IPI.

This results in having IPI trace events for:

o smp_call_function*()
o smp_send_reschedule()
o irq_work_queue*()
o standalone uses of __smp_call_single_queue()

This is incomplete, just looking at arm64 there's more IPI types that aren't
covered: 

  IPI_CPU_STOP,
  IPI_CPU_CRASH_STOP,
  IPI_TIMER,
  IPI_WAKEUP,

... But it feels like a good starting point.

Links
=====

[1]: https://youtu.be/5gT57y4OzBM?t=14234
[2]: https://lore.kernel.org/all/20221018151630.1513535-1-vschneid@redhat.com/

Revisions
=========

v1 -> v2
++++++++

o Ditched single-CPU tracepoint
o Changed tracepoint signature to include callback
o Changed tracepoint callsite field to void *; the parameter is still UL to save
  up on casts due to using _RET_IP_.
o Fixed linking failures due to not exporting smp_send_reschedule()

Steven Rostedt (Google) (1):
  tracing: Add __cpumask to denote a trace event field that is a
    cpumask_t

Valentin Schneider (7):
  trace: Add trace_ipi_send_cpumask()
  sched, smp: Trace IPIs sent via send_call_function_single_ipi()
  smp: Trace IPIs sent via arch_send_call_function_ipi_mask()
  irq_work: Trace self-IPIs sent via arch_irq_work_raise()
  treewide: Trace IPIs sent via smp_send_reschedule()
  smp: reword smp call IPI comment
  sched, smp: Trace smp callback causing an IPI

 arch/alpha/kernel/smp.c                      |  2 +-
 arch/arc/kernel/smp.c                        |  2 +-
 arch/arm/kernel/smp.c                        |  5 +-
 arch/arm64/kernel/smp.c                      |  3 +-
 arch/csky/kernel/smp.c                       |  2 +-
 arch/hexagon/kernel/smp.c                    |  2 +-
 arch/ia64/kernel/smp.c                       |  4 +-
 arch/loongarch/include/asm/smp.h             |  2 +-
 arch/mips/include/asm/smp.h                  |  2 +-
 arch/openrisc/kernel/smp.c                   |  2 +-
 arch/parisc/kernel/smp.c                     |  4 +-
 arch/powerpc/kernel/smp.c                    |  4 +-
 arch/powerpc/kvm/book3s_hv.c                 |  1 +
 arch/riscv/kernel/smp.c                      |  4 +-
 arch/s390/kernel/smp.c                       |  2 +-
 arch/sh/kernel/smp.c                         |  2 +-
 arch/sparc/kernel/smp_32.c                   |  2 +-
 arch/sparc/kernel/smp_64.c                   |  2 +-
 arch/x86/include/asm/smp.h                   |  2 +-
 arch/x86/kvm/svm/svm.c                       |  1 +
 arch/x86/kvm/x86.c                           |  1 +
 arch/xtensa/kernel/smp.c                     |  2 +-
 include/linux/smp.h                          |  2 +-
 include/trace/bpf_probe.h                    |  6 ++
 include/trace/events/ipi.h                   | 22 +++++++
 include/trace/perf.h                         |  6 ++
 include/trace/stages/stage1_struct_define.h  |  6 ++
 include/trace/stages/stage2_data_offsets.h   |  6 ++
 include/trace/stages/stage3_trace_output.h   |  6 ++
 include/trace/stages/stage4_event_fields.h   |  6 ++
 include/trace/stages/stage5_get_offsets.h    |  6 ++
 include/trace/stages/stage6_event_callback.h | 20 ++++++
 include/trace/stages/stage7_class_define.h   |  2 +
 kernel/irq_work.c                            | 16 ++++-
 kernel/sched/core.c                          | 34 +++++++---
 kernel/sched/smp.h                           |  1 +
 kernel/smp.c                                 | 66 ++++++++++++++++++--
 samples/trace_events/trace-events-sample.c   |  2 +-
 samples/trace_events/trace-events-sample.h   | 34 +++++++---
 39 files changed, 241 insertions(+), 53 deletions(-)

--
2.31.1

