Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C8F07382CD
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 14:13:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231551AbjFUL6t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 07:58:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231442AbjFUL6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 07:58:45 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DAAB1703;
        Wed, 21 Jun 2023 04:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=kl6nUkWuWRJmNI9AJnTnKYdYaqy5k7lvmEkgCwhBU2Y=; b=iBd7t2e4KtP1yDrPCNpHpNxGZt
        oV1d+5sNoJjk7V8slb3vOPXe163K5GQmlw/Hsc4JLGye1z6NOy9y+rwashq7ENtu+UNVBaVxTQPhr
        xvgFvhSEhFTRKBc5ivvnCF22WzSijIuypa5Wy6FEyEcMEDNGPjeg3+K2Ev1fxcm7mfEpdHqztz6r3
        NQCk1FxIIzO7MfUywTjdujiN1SvxB82Em9eAAmRANCEgd6xiMlfikcOdLDXlLfZwlmKGuj+AJFf4a
        ep6Y8AwETUyGkIzv23ZxfOdvK0jeuyRl+wwBXU6UhrLPFUj/f9BGBIdnG83bZUwIOQumJB4h1wTK8
        +TCgpIow==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qBwTV-00HQ3X-1Y;
        Wed, 21 Jun 2023 11:58:14 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 237223002A9;
        Wed, 21 Jun 2023 13:58:12 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0421220825AF9; Wed, 21 Jun 2023 13:58:11 +0200 (CEST)
Date:   Wed, 21 Jun 2023 13:58:11 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Stephane Eranian <eranian@google.com>
Cc:     Eric Lin <eric.lin@sifive.com>, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, irogers@google.com,
        adrian.hunter@intel.com, palmer@dabbelt.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, greentime.hu@sifive.com,
        vincent.chen@sifive.com
Subject: Re: [PATCH] perf/core: Add pmu stop before unthrottling to prevent
 WARNING
Message-ID: <20230621115811.GD2053369@hirez.programming.kicks-ass.net>
References: <20230602094841.1225-1-eric.lin@sifive.com>
 <CAPqJEFpamQSbCcD0QJ16u7ctRf1=NYihod6gdZJfxFpE0YUVHQ@mail.gmail.com>
 <CABPqkBRyqsMnNbokBKepkWq1DtzfB0npXySGbKS1T3nQTwmaAw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABPqkBRyqsMnNbokBKepkWq1DtzfB0npXySGbKS1T3nQTwmaAw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 20, 2023 at 11:18:05PM -0700, Stephane Eranian wrote:
> On Tue, Jun 20, 2023 at 9:25 PM Eric Lin <eric.lin@sifive.com> wrote:
> >
> > CC: Stephane Eranian
> >
> > On Fri, Jun 2, 2023 at 5:49 PM Eric Lin <eric.lin@sifive.com> wrote:
> > >
> > > Currently, during the perf sampling, if the perf interrupt takes too long,
> > > perf framework will lower the perf_event_max_sample_rate. This will limit
> > > the number of samples per timer tick (max_samples_per_tick) and set hwc->interrupts
> > > to MAX_INTERRUPTS within the __perf_event_account_interrupt() function.
> > >
> > > Afterward, the perf framework will unthrottle the event in the timer interrupt
> > > handler, which triggers the driver's *_pmu_start() function. Most of the driver's
> > > *_pmu_start() functions will check the event->hw.state to determine whether this
> > > event has stopped. If the event has not stopped, a WARN_ON_ONCE() warning
> > > will be triggered as shown below:
> > >
> > > [ 2110.224723] ------------[ cut here ]------------
> > > [ 2110.224851] WARNING: CPU: 0 PID: 240 at drivers/perf/riscv_pmu.c:184 riscv_pmu_start+0x7c/0x8e
> > > [ 2110.225242] Modules linked in:
> > > [ 2110.225380] CPU: 0 PID: 240 Comm: ls Not tainted 6.4-rc4-g19d0788e9ef2 #1
> > > [ 2110.225574] Hardware name: SiFive (DT)
> > > [ 2110.225657] epc : riscv_pmu_start+0x7c/0x8e
> > > [ 2110.225834]  ra : riscv_pmu_start+0x28/0x8e
> > > [ 2110.225998] epc : ffffffff80aef864 ra : ffffffff80aef810 sp : ffff8f80004db6f0
> > > [ 2110.226135]  gp : ffffffff81c83750 tp : ffffaf80069f9bc0 t0 : ffff8f80004db6c0
> > > [ 2110.226245]  t1 : 0000000000000000 t2 : 000000000000001f s0 : ffff8f80004db720
> > > [ 2110.226367]  s1 : ffffaf8008ca1068 a0 : 0000ffffffffffff a1 : 0000000000000000
> > > [ 2110.226488]  a2 : 0000000000000001 a3 : 0000000000000870 a4 : 0000000000000000
> > > [ 2110.226605]  a5 : 0000000000000000 a6 : 0000000000000840 a7 : 0000000000000030
> > > [ 2110.226721]  s2 : 0000000000000000 s3 : ffffaf8005165800 s4 : ffffaf800424da00
> > > [ 2110.226838]  s5 : ffffffffffffffff s6 : ffffffff81cc7590 s7 : 0000000000000000
> > > [ 2110.226955]  s8 : 0000000000000006 s9 : 0000000000000001 s10: ffffaf807efbc340
> > > [ 2110.227064]  s11: ffffaf807efbbf00 t3 : ffffaf8006a16028 t4 : 00000000dbfbb796
> > > [ 2110.227180]  t5 : 0000000700000000 t6 : ffffaf8005269870
> > > [ 2110.227277] status: 0000000200000100 badaddr: 0000000000000000 cause: 0000000000000003
> > > [ 2110.227407] [<ffffffff80aef864>] riscv_pmu_start+0x7c/0x8e
> > > [ 2110.227622] [<ffffffff80185b56>] perf_adjust_freq_unthr_context+0x15e/0x174
> > > [ 2110.227961] [<ffffffff80188642>] perf_event_task_tick+0x88/0x9c
> > > [ 2110.228235] [<ffffffff800626a8>] scheduler_tick+0xfe/0x27c
> > > [ 2110.228463] [<ffffffff800b5640>] update_process_times+0x9a/0xba
> > > [ 2110.228690] [<ffffffff800c5bd4>] tick_sched_handle+0x32/0x66
> > > [ 2110.229007] [<ffffffff800c5e0c>] tick_sched_timer+0x64/0xb0
> > > [ 2110.229253] [<ffffffff800b5e50>] __hrtimer_run_queues+0x156/0x2f4
> > > [ 2110.229446] [<ffffffff800b6bdc>] hrtimer_interrupt+0xe2/0x1fe
> > > [ 2110.229637] [<ffffffff80acc9e8>] riscv_timer_interrupt+0x38/0x42
> > > [ 2110.229984] [<ffffffff80090a16>] handle_percpu_devid_irq+0x90/0x1d2
> > > [ 2110.230162] [<ffffffff8008a9f4>] generic_handle_domain_irq+0x28/0x36
> > >
> > > To prevent this warning, we should call the driver's *_pmu_stop() function before unthrottling
> > >
> > > Signed-off-by: Eric Lin <eric.lin@sifive.com>
> > > ---
> > >  kernel/events/core.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/kernel/events/core.c b/kernel/events/core.c
> > > index db016e418931..098c875abe88 100644
> > > --- a/kernel/events/core.c
> > > +++ b/kernel/events/core.c
> > > @@ -4128,6 +4128,7 @@ perf_adjust_freq_unthr_context(struct perf_event_context *ctx, bool unthrottle)
> > >
> > >                 if (hwc->interrupts == MAX_INTERRUPTS) {
> > >                         hwc->interrupts = 0;
> > > +                       event->pmu->stop(event, 0);
> 
> But how could the event have been stopped with a call to pmu->stop()
> during throttling?

Yeah, Changelog fails to explain how we got to the faulty state -- and
without that we can't judge if the proposed solution actually fixes the
problem or not.

> >
> > >                         perf_log_throttle(event, 1);
> > >                         event->pmu->start(event, 0);
> > >                 }
> > > --
> > > 2.17.1
> > >
