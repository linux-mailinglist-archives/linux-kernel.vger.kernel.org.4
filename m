Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 979C97410A9
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 14:03:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231464AbjF1MD1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 08:03:27 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:53662 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjF1MDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 08:03:24 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1687953803;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zOOSj0ZmVINPINrjbtNgl9V20Fv+s0m3sMfb5W+T5hc=;
        b=rzggrGiwTdn0fKLMm+dgElQXxwykYUw5aNZXfuDPjo58b2vaoakHZLSm1/co44jAyNZSab
        ZHz9fDHn7EFwhn9DV1BjipdAass6N1sB4umjQlqvhqkD/sgsh+sJbc3fi/5yhli/nr6FvU
        gd5dLDhnDFySpO8w2I3X5X53XmkPMy7Dpqtl2sBbRtGodrNLv7NCc3iHqSWX5TKkMrQ5ov
        /ze5b3L4ZtyjEu2puHwmuhMB6jStXAqQduOxYmvvHoQXMz+FLqo+fLpoOrhIuK2BzUH/Fq
        mzEAf7Zsce5D7pgNFcp+ppaz0W+P5OMETYB4L5LrBZE7+CgBPp1LWVo9w9DqGg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1687953803;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zOOSj0ZmVINPINrjbtNgl9V20Fv+s0m3sMfb5W+T5hc=;
        b=1Z81BeaXMl0zcEDkIOZx24EirSyt+X1Q1XmRGcV0tC/VFYcrD6RfOaGjECIpkau2T9P8ed
        UqeMziIGJdolGZCg==
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
In-Reply-To: <CAKfTPtBoe_jRn-EMsQxssQ4BcveT+Qcd+GmsRbQEXQDGfzFOMg@mail.gmail.com>
References: <8e785777-03aa-99e1-d20e-e956f5685be6@huawei.com>
 <87mt18it1y.ffs@tglx> <68baeac9-9fa7-5594-b5e7-4baf8ac86b77@huawei.com>
 <ba352e83-b8b1-d900-9c1f-56b8c8a8b8fb@huawei.com>
 <CAKfTPtBoe_jRn-EMsQxssQ4BcveT+Qcd+GmsRbQEXQDGfzFOMg@mail.gmail.com>
Date:   Wed, 28 Jun 2023 14:03:22 +0200
Message-ID: <875y774wvp.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 27 2023 at 18:46, Vincent Guittot wrote:
> On Mon, 26 Jun 2023 at 10:23, Xiongfeng Wang <wangxiongfeng2@huawei.com> wrote:
>> > diff --cc kernel/sched/fair.c
>> > index d9d6519fae01,bd6624353608..000000000000
>> > --- a/kernel/sched/fair.c
>> > +++ b/kernel/sched/fair.c
>> > @@@ -5411,10 -5411,16 +5411,15 @@@ void start_cfs_bandwidth(struct cfs_ban
>> >   {
>> >         lockdep_assert_held(&cfs_b->lock);
>> >
>> > -       if (cfs_b->period_active)
>> > +       if (cfs_b->period_active) {
>> > +               struct hrtimer_clock_base *clock_base = cfs_b->period_timer.base;
>> > +               int cpu = clock_base->cpu_base->cpu;
>> > +               if (!cpu_active(cpu) && cpu != smp_processor_id())
>> > +                       hrtimer_start_expires(&cfs_b->period_timer,
>> > HRTIMER_MODE_ABS_PINNED);
>> >                 return;
>> > +       }
>
> I have been able to reproduce your problem and run your fix on top. I
> still wonder if there is a
> Could we have a helper from hrtimer to get the cpu of the clock_base ?

No, because this is fundamentally wrong.

If the CPU is on the way out, then the scheduler hotplug machinery
has to handle the period timer so that the problem Xiongfeng analyzed
does not happen in the first place.

sched_cpu_wait_empty() would be the obvious place to cleanup armed CFS
timers, but let me look into whether we can migrate hrtimers early in
general.

Aside of that the above is wrong by itself.

	if (cfs_b->period_active)
        	hrtimer_start_expires(&cfs_b->period_timer, HRTIMER_MODE_ABS_PINNED);

This only ends up on the outgoing CPU if either:

   1) The code runs on the outgoing CPU

or

   2) The hrtimer is concurrently executing the hrtimer callback on the
      outgoing CPU.

So this:

	if (cfs_b->period_active) {
		struct hrtimer_clock_base *clock_base = cfs_b->period_timer.base;
		int cpu = clock_base->cpu_base->cpu;

		if (!cpu_active(cpu) && cpu != smp_processor_id())
			hrtimer_start_expires(&cfs_b->period_timer, HRTIMER_MODE_ABS_PINNED);
              return;
      }

only works, if

  1) The code runs _not_ on the outgoing CPU

and

  2) The hrtimer is _not_ concurrently executing the hrtimer callback on
     the outgoing CPU.

     If the callback is executing (it spins on cfs_b->lock), then the
     timer is requeued on the outgoing CPU. Not what you want, right?

Plus accessing hrtimer->clock_base->cpu_base->cpu lockless is fragile at
best.

Thanks,

        tglx
