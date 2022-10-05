Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5B9B5F5793
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 17:31:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbiJEPbe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 11:31:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbiJEPbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 11:31:31 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 48F201A078
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 08:31:30 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 913D9113E;
        Wed,  5 Oct 2022 08:31:36 -0700 (PDT)
Received: from wubuntu (unknown [10.57.32.122])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 89D5F3F67D;
        Wed,  5 Oct 2022 08:31:27 -0700 (PDT)
Date:   Wed, 5 Oct 2022 16:31:25 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     John Stultz <jstultz@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Connor O'Brien <connoro@google.com>,
        John Dias <joaodias@google.com>, Rick Yiu <rickyiu@google.com>,
        John Kacur <jkacur@redhat.com>,
        Chris Redpath <chris.redpath@arm.com>,
        Abhijeet Dharmapurikar <adharmap@quicinc.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>, kernel-team@android.com,
        "J . Avila" <elavila@google.com>
Subject: Re: [RFC PATCH v3 2/3] sched: Avoid placing RT threads on cores
 handling long softirqs
Message-ID: <20221005153125.3apfpzhqs3mx6deg@wubuntu>
References: <20220921012550.3288570-1-jstultz@google.com>
 <20220921012550.3288570-3-jstultz@google.com>
 <20220928125517.ei64pxfucaem55cr@wubuntu>
 <CANDhNCpLp+St4U_fjs+W8HXT-2ff4gpkx0P6vDnrX0CcesiQfA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CANDhNCpLp+St4U_fjs+W8HXT-2ff4gpkx0P6vDnrX0CcesiQfA@mail.gmail.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/03/22 09:55, John Stultz wrote:

[...]

> > >               int target = find_lowest_rq(p);
> > > @@ -1656,11 +1699,14 @@ select_task_rq_rt(struct task_struct *p, int cpu, int flags)
> > >                       goto out_unlock;
> > >
> > >               /*
> > > -              * Don't bother moving it if the destination CPU is
> > > +              * If cpu is non-preemptible, prefer remote cpu
> > > +              * even if it's running a higher-prio task.
> > > +              * Otherwise: Don't bother moving it if the destination CPU is
> > >                * not running a lower priority task.
> > >                */
> > >               if (target != -1 &&
> > > -                 p->prio < cpu_rq(target)->rt.highest_prio.curr)
> > > +                 (may_not_preempt ||
> > > +                  p->prio < cpu_rq(target)->rt.highest_prio.curr))
> > >                       cpu = target;
> >
> > I'm not sure this makes sense. You assume a higher priority task will cause
> > less delay than softirqs. Which I think is an optimistic assumption?
> >
> > I think we should just mimic the same fallback behavior when we fail to find
> > a CPU that fits the capacity requirement. Keeps things more consistent IMO.
> 
> This sounds reasonable.  I do fret that long-running rt tasks are less
> common then the long running softirqs, so this may have an impact to
> the effectiveness of the patch, but I also suspect it's even more rare
> to have all the other cpus busy with rt tasks, so its probably very
> unlikely.

Yes. I think it is a hard problem to hit as all these other RT tasks must be
higher priority. So if this ever happens, then one should question if the
priority is set correctly for the audio threads first. Or why there are so many
higher priority tasks running for so long.


Thanks!

--
Qais Yousef
