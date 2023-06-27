Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7818B73F8DB
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 11:38:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231213AbjF0Jiq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 05:38:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230179AbjF0Jim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 05:38:42 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 602C51BFF;
        Tue, 27 Jun 2023 02:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=R4bsPd5TDwVP6VZpwDh0pJ+z3F6SCbi1gN0b38ql1Sc=; b=BB2MmbjeFpFwF6NTfzSJPbo18L
        umbiOKKOzgtmxQwzj13hr/AvYG5yaQt1YQ9oB+toT0laa4GjwAlNT5wFELlKhVSjmtlxEShjRb8XZ
        b5I/Q9B9D47KqaENBq8pDNVLdRSXZL/u76LG9PtodKkWScs7BrmNOrTWCRMSa/9rPK904M/0O1kOz
        71qTYv8aP9ZmXKDa+pXkELI7el6a+p37g/8Fb2ID0+SrMrDkiVDezYy9Ix9IWbuwbUQVfViMFr6Q0
        b8bq6QApRry55fYvb+vYGoBmtIpPhZ4hX65UA1ms0lqqjgvrqkvmB+xwiVOy1YXt8wTP1UUfrwATf
        /4QU6neg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qE59U-004dLC-1M;
        Tue, 27 Jun 2023 09:38:24 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 95774300023;
        Tue, 27 Jun 2023 11:38:23 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7427D24A3B973; Tue, 27 Jun 2023 11:38:23 +0200 (CEST)
Date:   Tue, 27 Jun 2023 11:38:23 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Eric Lin <eric.lin@sifive.com>
Cc:     Stephane Eranian <eranian@google.com>, mingo@redhat.com,
        acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, irogers@google.com, adrian.hunter@intel.com,
        palmer@dabbelt.com, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        greentime.hu@sifive.com, vincent.chen@sifive.com
Subject: Re: [PATCH] perf/core: Add pmu stop before unthrottling to prevent
 WARNING
Message-ID: <20230627093823.GV83892@hirez.programming.kicks-ass.net>
References: <20230602094841.1225-1-eric.lin@sifive.com>
 <CAPqJEFpamQSbCcD0QJ16u7ctRf1=NYihod6gdZJfxFpE0YUVHQ@mail.gmail.com>
 <CABPqkBRyqsMnNbokBKepkWq1DtzfB0npXySGbKS1T3nQTwmaAw@mail.gmail.com>
 <20230621115811.GD2053369@hirez.programming.kicks-ass.net>
 <CAPqJEFpV8a8D7eA0sspjvThvBxdZhSLPTEbEzN7WiGCAzSnYYg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPqJEFpV8a8D7eA0sspjvThvBxdZhSLPTEbEzN7WiGCAzSnYYg@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 27, 2023 at 05:08:07PM +0800, Eric Lin wrote:

> > Yeah, Changelog fails to explain how we got to the faulty state -- and
> > without that we can't judge if the proposed solution actually fixes the
> > problem or not.
> >
> 
> Hi Stephane, Peter,
> 
> Most of the pmu driver will call *_pmu_stop(event,0) in the
> *_pmu_handle_irq() function and update the hwc->state with
> PERF_HES_STOPPED flag as below:
> 
> arch/alpha/kernel/perf_event.c:856:             if
> (perf_event_overflow(event, &data, regs)) {
> arch/alpha/kernel/perf_event.c-857-                     /* Interrupts
> coming too quickly; "throttle" the
> arch/alpha/kernel/perf_event.c-858-                      * counter,
> i.e., disable it for a little while.
> arch/alpha/kernel/perf_event.c-859-                      */
> arch/alpha/kernel/perf_event.c-860-
> alpha_pmu_stop(event, 0);
> arch/alpha/kernel/perf_event.c-861-             }
> -----
> arch/arc/kernel/perf_event.c:603:                       if
> (perf_event_overflow(event, &data, regs))
> arch/arc/kernel/perf_event.c-604-
> arc_pmu_stop(event, 0);
> arch/arc/kernel/perf_event.c-605-               }
> -----
> arch/x86/events/amd/core.c:935:         if (perf_event_overflow(event,
> &data, regs))
> arch/x86/events/amd/core.c-936-                 x86_pmu_stop(event, 0);
> arch/x86/events/amd/core.c-937- }
> -----
> 
> However, some of the pmu drivers stop the event in the
> *_pmu_handle_irq() without updating the hwc->state with
> PERF_HES_STOPPED flag as below:
> 
> arch/arm/kernel/perf_event_v7.c:994:            if
> (perf_event_overflow(event, &data, regs))
> arch/arm/kernel/perf_event_v7.c-995-
> cpu_pmu->disable(event); // <== not update with PERF_HES_STOPPED
> arch/arm/kernel/perf_event_v7.c-996-    }
> ------
> arch/csky/kernel/perf_event.c:1142:             if
> (perf_event_overflow(event, &data, regs))
> arch/csky/kernel/perf_event.c-1143-
> csky_pmu_stop_event(event); // <== not update with PERF_HES_STOPPED
> arch/csky/kernel/perf_event.c-1144-     }
> -------
> arch/loongarch/kernel/perf_event.c:492: if (perf_event_overflow(event,
> data, regs))
> arch/loongarch/kernel/perf_event.c-493-
> loongarch_pmu_disable_event(idx);    // <== not update with
> PERF_HES_STOPPED
> arch/loongarch/kernel/perf_event.c-494-}
> -------
> arch/mips/kernel/perf_event_mipsxx.c:794:       if
> (perf_event_overflow(event, data, regs))
> arch/mips/kernel/perf_event_mipsxx.c-795-
> mipsxx_pmu_disable_event(idx); // <== not update with PERF_HES_STOPPED
> arch/mips/kernel/perf_event_mipsxx.c-796-}
> ....
> 
> Furthermore, these drivers did not add event->hw.state checking in
> *_pmu_start() before starting the event like x86 does:
> 
> 1497 static void x86_pmu_start(struct perf_event *event, int flags)
> 1498 {
> 1499     struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
> 1500     int idx = event->hw.idx;
> 1501
> 1502     if (WARN_ON_ONCE(!(event->hw.state & PERF_HES_STOPPED)))
> 1503         return;
> 1504
> 
> As a result, these drivers won't trigger the WARN_ON_ONCE warning as
> shown in this patch.
> 
> However, if a pmu driver like RISC-V pmu which didn't call
> *_pmu_stop(event,0) without updating the hwc->state with
> PERF_HES_STOPPED flag in the *_pmu_handle_irq() function
> but has event->hw.state checking in *_pmu_start(), it could trigger
> the WARN_ON_ONCE warning as shown in this patch.
> 
> Therefore, I think we need to call pmu->stop() before unthrottling the
> event to prevent this warning.

How is that not a pmu driver problem ? I'd think we should be fixing
those drivers. Mark, do you have have any memories of how the ARM driver
came to be this way?
