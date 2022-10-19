Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 803F96052C9
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 00:09:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230520AbiJSWJg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 18:09:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231328AbiJSWJc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 18:09:32 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81B4919289
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 15:09:30 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id by36so23948612ljb.4
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 15:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6pDjAbnGdS8XDtn4tfTx6Ke5EcI6/PEnPZIXA1s5SF0=;
        b=C7dR+OI7oZALDxCFrYaC2tDm9sLZzStqcPGKxYJ7a2GRz3F00j1byYtN7656coauHN
         6zVYKAujIspBeE8rGPaGYoxTrlvkWRL9QxW2FJdMjZFL22XhshrwL2Z7659Lx3kEROcP
         CJ3gurYa4x0wYStwqn9cIu6nigNKMfIKes9ztF3T9bOjOjE91IDfzPyhH6Cet99w82/6
         zZZsJyyGdnktVuoHZMenmUW/JctV1dSGFgq+In2I/5q9MlTCMZqp+bdBHVTo7M37JPuj
         VfmPZ8Tekzq1SE4Rn3NL0XoBUHrZQhvYVuGCjwsZ2uEUOLOl3EI1K5nJ+wpcEjEv+mm0
         Bi1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6pDjAbnGdS8XDtn4tfTx6Ke5EcI6/PEnPZIXA1s5SF0=;
        b=iGmAgmUIG3oLrgn1AYMZ9V8EICBkDC8O7cj2zR/erWkzVYoSGpjMV/RhQTEiG0YRaQ
         FNl6978EwfcYq59FdHk6F8Rl8VO96u4SWoXnxiXoHTSuhm0wVw/768WXeJgNfn49Z2PQ
         q45WQ/CtjAfVlVEyipv1upwo5G5LO0Sj9qFIGA/7olR/Uho5DBq74aaxXgOIHiWr6XWI
         3+qi3UBUona1/rL28zjXBIi3H5kwV7vgmjZO6K9NW0Ieb1swBELD6kWBb5ZjcT+nrc/3
         AELY+BNhAEumok/z0dEP8a1nNhqykAO/6NC/G4WskDC6hEdhFn/wowBUsGLANumLXseJ
         q/Nw==
X-Gm-Message-State: ACrzQf0mESDhDo+gJ/kUBTY4RFCbBPMWmNXie0d6APFOCLrtvyTUrvRK
        LtpzhRLN6oIvV+lkpQKYe2STVZnFDIlSTdAoAAvCdjjt5Q==
X-Google-Smtp-Source: AMsMyM7jhcLY7OUMlc5ivapYvC3B/1T72IkmVXE/3NLs0/ZvrGjBQEfi1e+55wKHjQYHGQfN3b3Sx3csiWBkp+nGA6o=
X-Received: by 2002:a2e:a28d:0:b0:26f:b4e9:4dda with SMTP id
 k13-20020a2ea28d000000b0026fb4e94ddamr3428858lja.13.1666217368520; Wed, 19
 Oct 2022 15:09:28 -0700 (PDT)
MIME-Version: 1.0
References: <20221003232033.3404802-1-jstultz@google.com> <20221003232033.3404802-3-jstultz@google.com>
 <Y01NPB4sa8Z98ntK@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
 <CANDhNCoTGNANDnOQ6touhreG_UEn1-N4T4BktWFxpLPSWVfrdA@mail.gmail.com> <Y0+/SAWUNRnhIW9b@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
In-Reply-To: <Y0+/SAWUNRnhIW9b@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
From:   John Stultz <jstultz@google.com>
Date:   Wed, 19 Oct 2022 15:09:15 -0700
Message-ID: <CANDhNCpQuQn_84yqErF2noAYDwdwNJQF-pr4JKVp1eZzH=+f9w@mail.gmail.com>
Subject: Re: [PATCH RFC v4 2/3] sched: Avoid placing RT threads on cores
 handling long softirqs
To:     Alexander Gordeev <agordeev@linux.ibm.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "Connor O'Brien" <connoro@google.com>,
        John Dias <joaodias@google.com>, Rick Yiu <rickyiu@google.com>,
        John Kacur <jkacur@redhat.com>,
        Qais Yousef <qais.yousef@arm.com>,
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
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 19, 2022 at 2:11 AM Alexander Gordeev
<agordeev@linux.ibm.com> wrote:
>
> On Mon, Oct 17, 2022 at 08:42:53PM -0700, John Stultz wrote:
> > Hrm. Suggestions? As select_task_rq_rt() is only one of the callers.
> > Trying to pass curr into cpu_busy_with_softirqs() would mean
> > cpupri_find_fitness() would need to read the cpu_rq(cpu)->curr for the
> > specified cpu and pass that in.
>
> May be you could have a lightweight checker that accepts rq and curr
> and gets called from select_task_rq_rt(). Then you could call that
> same checker from cpu_busy_with_softirqs().

Fair enough. Though your other questions are making me wonder if this
is necessary.

> > Just to expand what it should be in detail:
> > 1:  (softirqs & LONG_SOFTIRQ_MASK) &&
> > 2:  (curr == cpu_ksoftirqd ||
> > 3:  task_thread_info(curr)->preempt_count & SOFTIRQ_MASK)
> >
> > Where we're checking
> > 1) that  the active_softirqs and __cpu_softirq_pending() values on the
> > target cpu are running a long softirq.
> > AND (
> > 2) The current task on the target cpu is ksoftirqd
> > OR
> > 3) The preempt_count of the current task on the target cpu has SOFTIRQ entries
> > )
>
> 2) When the target CPU is handling or about to handle long softirqs
> already what is the difference if it is also running ksoftirqd or not?

Again, a good question! From my understanding, the original patch was
basically checking just #2 and #3 above, then additional logic was
added to narrow it to only the LONG_SOFTIRQ_MASK values, so that may
make the older part of the check redundant.

I fret there are some edge cases where on the target cpu softirqs
might be pending but ksoftirqd isn't running yet maybe due to a
lowish-prio rt task - such that the cpu could still be considered a
good target. But this seems a bit of a stretch.

> 3) What is the point of this check when 1) is true already?

Yeah, the more I think about this, the more duplicative it seems.
Again, there's some edge details about the preempt_count being set
before the active_softirq accounting is set, but the whole decision
here about the target cpus is a bit racy to begin with, so I'm not
sure if that is significant.

So I'll go ahead and simplify the check to just the LONG_SOFTIRQ_MASK
& (active | pending softirqs) check. This should avoid the need to
pull the cpu_rq(cpu)->curr value and simplify things.

Will send out a new version once I've been able to validate that
similification doesn't introduce a regression.

Thanks so much for the feedback and suggestions!
-john
