Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A51B5E82A2
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 21:47:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231906AbiIWTrM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 15:47:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbiIWTrJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 15:47:09 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8805712E421
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 12:47:08 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id c11so717096qtw.8
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 12:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=to:cc:date:message-id:subject:mime-version:from
         :content-transfer-encoding:from:to:cc:subject:date;
        bh=gssu5AavvoPnaSXyF0rB3Bfp1mKA3bQ7n/COcSe8MiM=;
        b=iuOCVD5tyo3Nm1hfWhy5jtpqRhcR/I6PlYCKnU/1oej9zTbjYF6uZr0JthWmus3Cty
         B9UojjTgRAOe66ZeDCLmN3NbVvK+lbPQGQmlXwbjHpwghEAbRofs1SnTA/gG+0qh7kIK
         0Ypnnruj65x65wIEPr7FCfHsTrxl45e/5AbU4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:cc:date:message-id:subject:mime-version:from
         :content-transfer-encoding:x-gm-message-state:from:to:cc:subject
         :date;
        bh=gssu5AavvoPnaSXyF0rB3Bfp1mKA3bQ7n/COcSe8MiM=;
        b=owQGCFY3y2wfsjS0lUC5XqVcRiyhI9XqMbF2+/AWQaicpzQzzBax6FklCYwlF227lh
         XfVXB+S7tGLYjQjbCOqPqv+aijrSxQZpAn/dcoU0l/HC6ILvxzmppvW9AsklfY1VNESQ
         zLGIeMByR7ZpWXUBuFl3xnzaakaXurCCJK3y4feh5myJ62705kzlUvwuYxQSwl6FDdZe
         tTdJb4jaqKhm3opeTBhcUozIVMicFJStcJxseQVufatoGQMtykA7EqGJ51kgfOGEumYA
         C53pVaGMM+00b84j2ifWA+dF194q2iBe+Uoa/kVg730fL3QbxT4SERGPgy/WZga1KHBq
         +uSA==
X-Gm-Message-State: ACrzQf1NxBOlB/UkG/C9jOQRVOPsgSyLsku0aSRk19lvnqjQmdT8N1a1
        gkgc0ll5EwzpTXgK9Njbl3VvMg==
X-Google-Smtp-Source: AMsMyM5tOjo3SIp+isa8DdjfLe+9kqoZe4A2c+5GhJQ57bNooKx8wAnmYy21FtbtcgH6N/uoPNQpsg==
X-Received: by 2002:a05:622a:509:b0:35d:55c:be0 with SMTP id l9-20020a05622a050900b0035d055c0be0mr8746303qtx.249.1663962427529;
        Fri, 23 Sep 2022 12:47:07 -0700 (PDT)
Received: from smtpclient.apple (c-73-148-104-166.hsd1.va.comcast.net. [73.148.104.166])
        by smtp.gmail.com with ESMTPSA id l27-20020a37f91b000000b006ce580c2663sm6389934qkj.35.2022.09.23.12.47.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Sep 2022 12:47:07 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Joel Fernandes <joel@joelfernandes.org>
Mime-Version: 1.0 (1.0)
Subject: Re: RCU vs NOHZ
Message-Id: <9BE889A7-C196-47A5-9C10-9409C0FD3DE2@joelfernandes.org>
Date:   Fri, 23 Sep 2022 15:47:06 -0400
Cc:     Boqun Feng <boqun.feng@gmail.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Thomas Gleixner <tglx@linutronix.de>
To:     "Paul E. McKenney" <paulmck@kernel.org>
X-Mailer: iPhone Mail (19G82)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi  Paul,=EF=BB=BF

On Fri, Sep 23, 2022 at 2:15 PM Paul E. McKenney <paulmck@kernel.org> wrote:=

>=20
> On Fri, Sep 23, 2022 at 01:47:40PM -0400, Joel Fernandes wrote:
>> On Fri, Sep 23, 2022 at 12:01 PM Paul E. McKenney <paulmck@kernel.org> wr=
ote:
>> [...]
>>>>> And here is an untested patch that in theory might allow much of the
>>>>> reduction in power with minimal complexity/overhead for kernels withou=
t
>>>>> rcu_nocbs CPUs.  On the off-chance you know of someone who would be
>>>>> willing to do a realistic evaluation of it.
>>>>>                                                    Thanx, Paul
>>>>> ----------------------------------------------------------------------=
--
>>>>> commit 80fc02e80a2dfb6c7468217cff2d4494a1c4b58d
>>>>> Author: Paul E. McKenney <paulmck@kernel.org>
>>>>> Date:   Wed Sep 21 13:30:24 2022 -0700
>>>>>    rcu: Let non-offloaded idle CPUs with callbacks defer tick
>>>>>    When a CPU goes idle, rcu_needs_cpu() is invoked to determine wheth=
er or
>>>>>    not RCU needs the scheduler-clock tick to keep interrupting.  Right=
 now,
>>>>>    RCU keeps the tick on for a given idle CPU if there are any non-off=
loaded
>>>>>    callbacks queued on that CPU.
>>>>>    But if all of these callbacks are waiting for a grace period to fin=
ish,
>>>>>    there is no point in scheduling a tick before that grace period has=
 any
>>>>>    reasonable chance of completing.  This commit therefore delays the t=
ick
>>>>>    in the case where all the callbacks are waiting for a specific grac=
e
>>>>>    period to elapse.  In theory, this should result in a 50-70% reduct=
ion in
>>>>>    RCU-induced scheduling-clock ticks on mostly-idle CPUs.  In practic=
e, TBD.
>>>>>    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
>>>>>    Cc: Peter Zijlstra <peterz@infradead.org>
>>>>> diff --git a/include/linux/rcutiny.h b/include/linux/rcutiny.h
>>>>> index 9bc025aa79a3..84e930c11065 100644
>>>>> --- a/include/linux/rcutiny.h
>>>>> +++ b/include/linux/rcutiny.h
>>>>> @@ -133,7 +133,7 @@ static inline void rcu_softirq_qs(void)
>>>>>            rcu_tasks_qs(current, (preempt)); \
>>>>>    } while (0)
>>>>> -static inline int rcu_needs_cpu(void)
>>>>> +static inline int rcu_needs_cpu(u64 basemono, u64 *nextevt)
>>>>> {
>>>>>    return 0;
>>>>> }
>>>>> diff --git a/include/linux/rcutree.h b/include/linux/rcutree.h
>>>>> index 70795386b9ff..3066e0975022 100644
>>>>> --- a/include/linux/rcutree.h
>>>>> +++ b/include/linux/rcutree.h
>>>>> @@ -19,7 +19,7 @@
>>>>> void rcu_softirq_qs(void);
>>>>> void rcu_note_context_switch(bool preempt);
>>>>> -int rcu_needs_cpu(void);
>>>>> +int rcu_needs_cpu(u64 basemono, u64 *nextevt);
>>>>> void rcu_cpu_stall_reset(void);
>>>>> /*
>>>>> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
>>>>> index 5ec97e3f7468..47cd3b0d2a07 100644
>>>>> --- a/kernel/rcu/tree.c
>>>>> +++ b/kernel/rcu/tree.c
>>>>> @@ -676,12 +676,33 @@ void __rcu_irq_enter_check_tick(void)
>>>>>  * scheduler-clock interrupt.
>>>>>  *
>>>>>  * Just check whether or not this CPU has non-offloaded RCU callbacks
>>>>> - * queued.
>>>>> + * queued that need immediate attention.
>>>>>  */
>>>>> -int rcu_needs_cpu(void)
>>>>> +int rcu_needs_cpu(u64 basemono, u64 *nextevt)
>>>>> {
>>>>> -   return !rcu_segcblist_empty(&this_cpu_ptr(&rcu_data)->cblist) &&
>>>>> -           !rcu_rdp_is_offloaded(this_cpu_ptr(&rcu_data));
>>>>> +   struct rcu_data *rdp =3D this_cpu_ptr(&rcu_data);
>>>>> +   struct rcu_segcblist *rsclp =3D &rdp->cblist;
>>>>> +
>>>>> +   // Disabled, empty, or offloaded means nothing to do.
>>>>> +   if (!rcu_segcblist_is_enabled(rsclp) ||
>>>>> +       rcu_segcblist_empty(rsclp) || rcu_rdp_is_offloaded(rdp)) {
>>>>> +           *nextevt =3D KTIME_MAX;
>>>>> +           return 0;
>>>>> +   }
>>>>> +
>>>>> +   // Callbacks ready to invoke or that have not already been
>>>>> +   // assigned a grace period need immediate attention.
>>>>> +   if (!rcu_segcblist_segempty(rsclp, RCU_DONE_TAIL) ||
>>>>> +       !rcu_segcblist_segempty(rsclp, RCU_NEXT_TAIL))
>>>>> +           return 1;> +
>>>>> +   // There are callbacks waiting for some later grace period.
>>>>> +   // Wait for about a grace period or two for the next tick, at whic=
h
>>>>> +   // point there is high probability that this CPU will need to do s=
ome
>>>>> +   // work for RCU.
>>>>> +   *nextevt =3D basemono + TICK_NSEC * (READ_ONCE(jiffies_till_first_=
fqs) > +                                           READ_ONCE(jiffies_till_ne=
xt_fqs) + 1);
>>>> Looks like nice idea. Could this race with the main GP thread on anothe=
r CPU
>>>> completing the grace period, then on this CPU there is actually some wo=
rk to do
>>>> but rcu_needs_cpu() returns 0.
>>>> I think it is plausible but not common, in which case the extra delay i=
s
>>>> probably Ok.
>>> Glad you like it!
>>> Yes, that race can happen, but it can also happen today.
>>> A scheduling-clock interrupt might arrive at a CPU just as a grace
>>> period finishes.  Yes, the delay is longer with this patch.  If this
>>> proves to be a problem, then the delay heuristic might expanded to
>>> include the age of the current grace period.
>>> But keeping it simple to start with.
>> Sure sounds good and yes I agree to the point of the existing issue
>> but the error is just 1 jiffie there as you pointed.
>=20
> One jiffy currently, but it would typically be about seven jiffies with
> the patch

Yes exactly, that=E2=80=99s what I meant.

> .  Systems with smaller values of HZ would have fewer jiffies,
> and systems with more than 128 CPUs would have more jiffies.  Systems
> booted with explicit values for the rcutree.jiffies_till_first_fqs and
> rcutree.jiffies_till_next_fqs kernel boot parameters could have whatever
> the administrator wanted.  ;-)


Makes sense, thanks for clarifying.

> But the key point is that the grace period itself can be extended by
> that value just due to timing and distribution of idle CPUs.
>=20
>>>> Also, if the RCU readers take a long time, then we'd still wake up the s=
ystem
>>>> periodically although with the above change, much fewer times, which is=
 a good
>>>> thing.
>>> And the delay heuristic could also be expanded to include a digitally
>>> filtered estimate of grace-period duration.  But again, keeping it simpl=
e
>>> to start with.  ;-)
>>> My guess is that offloading gets you more power savings, but I don't
>>> have a good way of testing this guess.
>> I could try to run turbostat on Monday on our Intel SoCs, and see how
>> it reacts, but I was thinking of tracing this first to see the
>> behavior. Another thing I was thinking of was updating (the future)
>> rcutop to see how many 'idle ticks' are RCU related, vs others; and
>> then see how this patch effects that.
>=20
> Such testing would be very welcome, thank you!
>=20
> This patch might also need to keep track of the last tick on a given
> CPU in order to prevent frequent short idle periods from indefinitely
> delaying the tick.

I know what you mean! I had the exact same issue with the lazy timer initial=
ly, now the behavior is any lazy enqueue which happened will piggy back onto=
 the existing timer already running.

- Joel


>=20
>=20
>                                                        Thanx, Paul
>=20
>> thanks,
>> - Joel
>>>>>    unsigned long basejiff;
>>>>>    unsigned int seq;
>>>>> @@ -807,7 +807,7 @@ static ktime_t tick_nohz_next_event(struct tick_sc=
hed *ts, int cpu)
>>>>>     * minimal delta which brings us back to this place
>>>>>     * immediately. Lather, rinse and repeat...
>>>>>     */
>>>>> -   if (rcu_needs_cpu() || arch_needs_cpu() ||
>>>>> +   if (rcu_needs_cpu(basemono, &next_rcu) || arch_needs_cpu() ||
>>>>>        irq_work_needs_cpu() || local_timer_softirq_pending()) {
>>>>>            next_tick =3D basemono + TICK_NSEC;
>>>>>    } else {
>>>>> @@ -818,8 +818,10 @@ static ktime_t tick_nohz_next_event(struct tick_s=
ched *ts, int cpu)
>>>>>             * disabled this also looks at the next expiring
>>>>>             * hrtimer.
>>>>>             */
>>>>> -           next_tick =3D get_next_timer_interrupt(basejiff, basemono)=
;
>>>>> -           ts->next_timer =3D next_tick;
>>>>> +           next_tmr =3D get_next_timer_interrupt(basejiff, basemono);=

>>>>> +           ts->next_timer =3D next_tmr;
>>>>> +           /* Take the next rcu event into account */
>>>>> +           next_tick =3D next_rcu < next_tmr ? next_rcu : next_tmr;
>>>>>    }
>>>>>    /*
