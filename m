Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15E39741A7F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 23:17:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233097AbjF1VMM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 17:12:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232634AbjF1VKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 17:10:01 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 268771FDC
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 14:10:00 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1687986597;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NfWivBbB9CVFPmfW5ghsqhRiOMsMXKFj03Bb7yAbSp8=;
        b=iwxulBDyqoxoYc67idxuGHptPiqIEcYN4K6VgcWFrLzinJoQIJoCWiXwyq66wOOiMhsBYw
        WjneLK8b51+VPCbFxPTAlLDZcwTP6naRW6BDbmbQwptP4uqGbvZFvSbSWLIjLOAouRxw8b
        nldD2D2+NKBGvHs+59birCNOA7tnchadsquq8EXPBGbDXqt7ram36aY5UiaGnzgpXKjTt9
        xQaTwhT5tFQy9J8vQYiEpH2rT5Bm6iZwCpaLpeAhyEd994p27rhYhUrU4EPmFzmnQAQAiW
        X9t5p+MX0dPsFgORQUvYC+TaFsSz5ROA5P8DFwh54tItqws7rM3nOk4XzpbIgA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1687986597;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NfWivBbB9CVFPmfW5ghsqhRiOMsMXKFj03Bb7yAbSp8=;
        b=Prt+vhMvrIzR39qAU+NqSLzDhp4jinRyajpUKYGx0SKEFvHWr0cIwcutxl4oMRAv3Sek1P
        6fV/yVMOFsdXZ5Aw==
To:     Vincent Guittot <vincent.guittot@linaro.org>,
        Xiongfeng Wang <wangxiongfeng2@huawei.com>
Cc:     vschneid@redhat.com, Phil Auld <pauld@redhat.com>,
        vdonnefort@google.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Wei Li <liwei391@huawei.com>,
        "liaoyu (E)" <liaoyu15@huawei.com>, zhangqiao22@huawei.com,
        Peter Zijlstra <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [Question] report a race condition between CPU hotplug state
 machine and hrtimer 'sched_cfs_period_timer' for cfs bandwidth throttling
In-Reply-To: <CAKfTPtDZN1gVgr0AqgtVe3arVWEtA35PA3PL99hT_WAR1D9S9g@mail.gmail.com>
References: <8e785777-03aa-99e1-d20e-e956f5685be6@huawei.com>
 <87mt18it1y.ffs@tglx> <68baeac9-9fa7-5594-b5e7-4baf8ac86b77@huawei.com>
 <ba352e83-b8b1-d900-9c1f-56b8c8a8b8fb@huawei.com>
 <CAKfTPtBoe_jRn-EMsQxssQ4BcveT+Qcd+GmsRbQEXQDGfzFOMg@mail.gmail.com>
 <CAKfTPtDZN1gVgr0AqgtVe3arVWEtA35PA3PL99hT_WAR1D9S9g@mail.gmail.com>
Date:   Wed, 28 Jun 2023 23:09:56 +0200
Message-ID: <87zg4j2t0b.ffs@tglx>
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

On Wed, Jun 28 2023 at 15:30, Vincent Guittot wrote:
> On Tue, 27 Jun 2023 at 18:46, Vincent Guittot
>> > > +               struct hrtimer_clock_base *clock_base = cfs_b->period_timer.base;
>> > > +               int cpu = clock_base->cpu_base->cpu;
>> > > +               if (!cpu_active(cpu) && cpu != smp_processor_id())
>> > > +                       hrtimer_start_expires(&cfs_b->period_timer,
>> > > HRTIMER_MODE_ABS_PINNED);
>> > >                 return;
>> > > +       }

Can you please trim your replies?

>> I have been able to reproduce your problem and run your fix on top. I
>> still wonder if there is a
>
> Looks like I have been preempted and never finished the sentence. The
> full sentence is:
> I still wonder if there is a race condition where the hang can still
> happen but i haven't been able to find one so far

As I explained before. Assume the timer fires on the outgoing CPU and
the other CPU tries to rearm it concurrently. It will stay on the
outgoing CPU and not move over.

Thanks,

        tglx
