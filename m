Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F181D5E905C
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Sep 2022 00:56:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234057AbiIXW4f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 18:56:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230507AbiIXW4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 18:56:32 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54EC54A826
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 15:56:29 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id l1so2220057qvu.11
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 15:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date;
        bh=+bBzGWRrbeb6PKMM66gMyce24xKPjY6q7egXP2ZDNI8=;
        b=I2GNv8gV8LHI7ZhmOzbNCL+aFC+to4bhb6QvL992i+ey+8dzvsTdQgRD/1GG/cb/af
         uiU/KD7E/+6FlIB0Lc010k5fnyD8/qViWLM1rzavuxvCWeozhSgf6VsBHqDbQUQdN5NP
         etKCWQMzUBNHP4cOyMFblADNwf9l1D3U1Fags=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date;
        bh=+bBzGWRrbeb6PKMM66gMyce24xKPjY6q7egXP2ZDNI8=;
        b=p7DrFi4thE//xucL9juS5cAFv6euPEyLeUSNLaRPE4z5tp+D5PEMSqYC3w22Q4AtoD
         CUq/PiKj4AtiYipI5tX4jBF48OdJyoVUHkF3sh4Mn14sbViQSO6r5Ivyi8/+Z404uiQD
         cG3X4kGVJ9TMnZpsddqRd4Oy+Micbxh8vVaY4FdvKtIxRyyuw5Vg7uG3/+ZTCJ0vNBav
         GOJ6m3/JTp1WbPxU3jIlcYsoLyjn+a2BAu7fxXdIPypb6kBOKF/hPdFzAi0gsJS+HKh+
         eMUYhhmHr9sdcxW/EQ9sFzGE/ZuOleYB21E051jZiKDmF5U2hzdvo+xxXhs1uHa7OqGH
         eSuw==
X-Gm-Message-State: ACrzQf1UqvwkF1y/GqHqyDMoISqRakY+XF0fbJNG6nNay4E/8o/FpRDX
        kpipn+9TQzyEVIZVEcjHCJrWNLZMHdW4DrcJonU=
X-Google-Smtp-Source: AMsMyM5Lma1xvIM1tbNcCnUS5HttiLApnDn/c+uAWv0cQwgPWUGxlbRX7dXcIa2uP4JriPSJGDxcWA==
X-Received: by 2002:a05:6214:c4d:b0:4aa:b47f:98ce with SMTP id r13-20020a0562140c4d00b004aab47f98cemr12181468qvj.25.1664060187850;
        Sat, 24 Sep 2022 15:56:27 -0700 (PDT)
Received: from smtpclient.apple (c-73-148-104-166.hsd1.va.comcast.net. [73.148.104.166])
        by smtp.gmail.com with ESMTPSA id s4-20020a05620a254400b006cf43968db6sm8593959qko.76.2022.09.24.15.56.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Sep 2022 15:56:27 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Joel Fernandes <joel@joelfernandes.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v6 1/4] rcu: Make call_rcu() lazy to save power
Date:   Sat, 24 Sep 2022 18:56:26 -0400
Message-Id: <C9ACA2BD-3A8D-4474-8C9A-DEAEDE206FBC@joelfernandes.org>
References: <20220924211132.GE4196@paulmck-ThinkPad-P17-Gen-1>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        rushikesh.s.kadam@intel.com, urezki@gmail.com,
        neeraj.iitr10@gmail.com, frederic@kernel.org, rostedt@goodmis.org
In-Reply-To: <20220924211132.GE4196@paulmck-ThinkPad-P17-Gen-1>
To:     paulmck@kernel.org
X-Mailer: iPhone Mail (19G82)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Sep 24, 2022, at 5:11 PM, Paul E. McKenney <paulmck@kernel.org> wrote:
>=20
> =EF=BB=BFOn Sat, Sep 24, 2022 at 12:20:00PM -0400, Joel Fernandes wrote:
>> Hi Paul,
>> Let=E2=80=99s see whether my iPhone can handle replies ;-)
>=20
> Now let's see if it can handle replies to replies!  Are you using a
> keyboard, or small-screen finger gestures?

Haha here it comes. It=E2=80=99s the usual onscreen
keyboard which has finger gesture support
and is quite fast to type with ;-). It=E2=80=99s also
connected to my apple watch so I can reply
from there but I=E2=80=99ll take it one step a time ;-)

>> More below:
>>=20
>>>> On Sep 23, 2022, at 5:44 PM, Paul E. McKenney <paulmck@kernel.org> wrot=
e:
>>>=20
>>> =EF=BB=BFOn Thu, Sep 22, 2022 at 10:01:01PM +0000, Joel Fernandes (Googl=
e) wrote:
>>>> Implement timer-based RCU lazy callback batching. The batch is flushed
>>>> whenever a certain amount of time has passed, or the batch on a
>>>> particular CPU grows too big. Also memory pressure will flush it in a
>>>> future patch.
>>>>=20
>>>> To handle several corner cases automagically (such as rcu_barrier() and=

>>>> hotplug), we re-use bypass lists to handle lazy CBs. The bypass list
>>>> length has the lazy CB length included in it. A separate lazy CB length=

>>>> counter is also introduced to keep track of the number of lazy CBs.
>>>>=20
>>>> v5->v6:
>>>>=20
>>>> [ Frederic Weisbec: Program the lazy timer only if WAKE_NOT, since othe=
r
>>>> deferral levels wake much earlier so for those it is not needed. ]
>>>>=20
>>>> [ Frederic Weisbec: Use flush flags to keep bypass API code clean. ]
>>>>=20
>>>> [ Frederic Weisbec: Make rcu_barrier() wake up only if main list empty.=
 ]
>>>>=20
>>>> [ Frederic Weisbec: Remove extra 'else if' branch in rcu_nocb_try_bypas=
s(). ]
>>>>=20
>>>> [ Joel: Fix issue where I was not resetting lazy_len after moving it to=
 rdp ]
>>>>=20
>>>> [ Paul/Thomas/Joel: Make call_rcu() default lazy so users don't mess up=
. ]
>>>>=20
>>>> Suggested-by: Paul McKenney <paulmck@kernel.org>
>>>> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
>>>=20
>>> I am going to put these on a local branch for testing, but a few comment=
s
>>> and questions interspersed below.
>>>=20
>>>                           Thanx, Paul
>>=20
>> Ok I replied below, thank you!
>>=20
>>>> include/linux/rcupdate.h |   7 ++
>>>> kernel/rcu/Kconfig       |   8 ++
>>>> kernel/rcu/rcu.h         |   8 ++
>>>> kernel/rcu/tiny.c        |   2 +-
>>>> kernel/rcu/tree.c        | 133 ++++++++++++++++++----------
>>>> kernel/rcu/tree.h        |  17 +++-
>>>> kernel/rcu/tree_exp.h    |   2 +-
>>>> kernel/rcu/tree_nocb.h   | 184 ++++++++++++++++++++++++++++++++-------
>>>> 8 files changed, 277 insertions(+), 84 deletions(-)
>>>>=20
>>>> diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
>>>> index 08605ce7379d..40ae36904825 100644
>>>> --- a/include/linux/rcupdate.h
>>>> +++ b/include/linux/rcupdate.h
>>>> @@ -108,6 +108,13 @@ static inline int rcu_preempt_depth(void)
>>>>=20
>>>> #endif /* #else #ifdef CONFIG_PREEMPT_RCU */
>>>>=20
>>>> +#ifdef CONFIG_RCU_LAZY
>>>> +void call_rcu_flush(struct rcu_head *head, rcu_callback_t func);
>>>> +#else
>>>> +static inline void call_rcu_flush(struct rcu_head *head,
>>>> +        rcu_callback_t func) {  call_rcu(head, func); }
>>>> +#endif
>>>> +
>>>> /* Internal to kernel */
>>>> void rcu_init(void);
>>>> extern int rcu_scheduler_active;
>>>> diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
>>>> index f53ad63b2bc6..edd632e68497 100644
>>>> --- a/kernel/rcu/Kconfig
>>>> +++ b/kernel/rcu/Kconfig
>>>> @@ -314,4 +314,12 @@ config TASKS_TRACE_RCU_READ_MB
>>>>     Say N here if you hate read-side memory barriers.
>>>>     Take the default if you are unsure.
>>>>=20
>>>> +config RCU_LAZY
>>>> +    bool "RCU callback lazy invocation functionality"
>>>> +    depends on RCU_NOCB_CPU
>>>> +    default n
>>>> +    help
>>>> +      To save power, batch RCU callbacks and flush after delay, memory=

>>>> +      pressure or callback list growing too big.
>>>> +
>>>> endmenu # "RCU Subsystem"
>>>> diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
>>>> index be5979da07f5..65704cbc9df7 100644
>>>> --- a/kernel/rcu/rcu.h
>>>> +++ b/kernel/rcu/rcu.h
>>>> @@ -474,6 +474,14 @@ enum rcutorture_type {
>>>>   INVALID_RCU_FLAVOR
>>>> };
>>>>=20
>>>> +#if defined(CONFIG_RCU_LAZY)
>>>> +unsigned long rcu_lazy_get_jiffies_till_flush(void);
>>>> +void rcu_lazy_set_jiffies_till_flush(unsigned long j);
>>>> +#else
>>>> +static inline unsigned long rcu_lazy_get_jiffies_till_flush(void) { re=
turn 0; }
>>>> +static inline void rcu_lazy_set_jiffies_till_flush(unsigned long j) { }=

>>>> +#endif
>>>> +
>>>> #if defined(CONFIG_TREE_RCU)
>>>> void rcutorture_get_gp_data(enum rcutorture_type test_type, int *flags,=

>>>>               unsigned long *gp_seq);
>>>> diff --git a/kernel/rcu/tiny.c b/kernel/rcu/tiny.c
>>>> index a33a8d4942c3..810479cf17ba 100644
>>>> --- a/kernel/rcu/tiny.c
>>>> +++ b/kernel/rcu/tiny.c
>>>> @@ -44,7 +44,7 @@ static struct rcu_ctrlblk rcu_ctrlblk =3D {
>>>>=20
>>>> void rcu_barrier(void)
>>>> {
>>>> -    wait_rcu_gp(call_rcu);
>>>> +    wait_rcu_gp(call_rcu_flush);
>>>> }
>>>> EXPORT_SYMBOL(rcu_barrier);
>>>>=20
>>>> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
>>>> index 5ec97e3f7468..736d0d724207 100644
>>>> --- a/kernel/rcu/tree.c
>>>> +++ b/kernel/rcu/tree.c
>>>> @@ -2728,47 +2728,8 @@ static void check_cb_ovld(struct rcu_data *rdp)
>>>>   raw_spin_unlock_rcu_node(rnp);
>>>> }
>>>>=20
>>>> -/**
>>>> - * call_rcu() - Queue an RCU callback for invocation after a grace per=
iod.
>>>> - * @head: structure to be used for queueing the RCU updates.
>>>> - * @func: actual callback function to be invoked after the grace perio=
d
>>>> - *
>>>> - * The callback function will be invoked some time after a full grace
>>>> - * period elapses, in other words after all pre-existing RCU read-side=

>>>> - * critical sections have completed.  However, the callback function
>>>> - * might well execute concurrently with RCU read-side critical section=
s
>>>> - * that started after call_rcu() was invoked.
>>>> - *
>>>> - * RCU read-side critical sections are delimited by rcu_read_lock()
>>>> - * and rcu_read_unlock(), and may be nested.  In addition, but only in=

>>>> - * v5.0 and later, regions of code across which interrupts, preemption=
,
>>>> - * or softirqs have been disabled also serve as RCU read-side critical=

>>>> - * sections.  This includes hardware interrupt handlers, softirq handl=
ers,
>>>> - * and NMI handlers.
>>>> - *
>>>> - * Note that all CPUs must agree that the grace period extended beyond=

>>>> - * all pre-existing RCU read-side critical section.  On systems with m=
ore
>>>> - * than one CPU, this means that when "func()" is invoked, each CPU is=

>>>> - * guaranteed to have executed a full memory barrier since the end of i=
ts
>>>> - * last RCU read-side critical section whose beginning preceded the ca=
ll
>>>> - * to call_rcu().  It also means that each CPU executing an RCU read-s=
ide
>>>> - * critical section that continues beyond the start of "func()" must h=
ave
>>>> - * executed a memory barrier after the call_rcu() but before the begin=
ning
>>>> - * of that RCU read-side critical section.  Note that these guarantees=

>>>> - * include CPUs that are offline, idle, or executing in user mode, as
>>>> - * well as CPUs that are executing in the kernel.
>>>> - *
>>>> - * Furthermore, if CPU A invoked call_rcu() and CPU B invoked the
>>>> - * resulting RCU callback function "func()", then both CPU A and CPU B=
 are
>>>> - * guaranteed to execute a full memory barrier during the time interva=
l
>>>> - * between the call to call_rcu() and the invocation of "func()" -- ev=
en
>>>> - * if CPU A and CPU B are the same CPU (but again only if the system h=
as
>>>> - * more than one CPU).
>>>> - *
>>>> - * Implementation of these memory-ordering guarantees is described her=
e:
>>>> - * Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.r=
st.
>>>> - */
>>>> -void call_rcu(struct rcu_head *head, rcu_callback_t func)
>>>> +static void
>>>> +__call_rcu_common(struct rcu_head *head, rcu_callback_t func, bool laz=
y)
>>>> {
>>>>   static atomic_t doublefrees;
>>>>   unsigned long flags;
>>>> @@ -2809,7 +2770,7 @@ void call_rcu(struct rcu_head *head, rcu_callback=
_t func)
>>>>   }
>>>>=20
>>>>   check_cb_ovld(rdp);
>>>> -    if (rcu_nocb_try_bypass(rdp, head, &was_alldone, flags))
>>>> +    if (rcu_nocb_try_bypass(rdp, head, &was_alldone, flags, lazy))
>>>>       return; // Enqueued onto ->nocb_bypass, so just leave.
>>>>   // If no-CBs CPU gets here, rcu_nocb_try_bypass() acquired ->nocb_loc=
k.
>>>>   rcu_segcblist_enqueue(&rdp->cblist, head);
>>>> @@ -2831,8 +2792,84 @@ void call_rcu(struct rcu_head *head, rcu_callbac=
k_t func)
>>>>       local_irq_restore(flags);
>>>>   }
>>>> }
>>>> -EXPORT_SYMBOL_GPL(call_rcu);
>>>>=20
>>>> +#ifdef CONFIG_RCU_LAZY
>>>> +/**
>>>> + * call_rcu_flush() - Queue RCU callback for invocation after grace pe=
riod, and
>>>> + * flush all lazy callbacks (including the new one) to the main ->cbli=
st while
>>>> + * doing so.
>>>> + *
>>>> + * @head: structure to be used for queueing the RCU updates.
>>>> + * @func: actual callback function to be invoked after the grace perio=
d
>>>> + *
>>>> + * The callback function will be invoked some time after a full grace
>>>> + * period elapses, in other words after all pre-existing RCU read-side=

>>>> + * critical sections have completed.
>>>> + *
>>>> + * Use this API instead of call_rcu() if you don't mind the callback b=
eing
>>>> + * invoked after very long periods of time on systems without memory p=
ressure
>>>> + * and on systems which are lightly loaded or mostly idle.
>>>=20
>>> This comment is backwards, right?  Shouldn't it say something like "Use
>>> this API instead of call_rcu() if you don't mind burning extra power..."=
?
>>=20
>> Yes sorry my mistake :-(. It=E2=80=99s a stale comment from the rework an=
d I=E2=80=99ll update it.
>=20
> Very good, thank you!

Anything for you!

>=20
>>>> + *
>>>> + * Other than the extra delay in callbacks being invoked, this functio=
n is
>>>> + * identical to, and reuses call_rcu()'s logic. Refer to call_rcu() fo=
r more
>>>> + * details about memory ordering and other functionality.
>>>> + */
>>>> +void call_rcu_flush(struct rcu_head *head, rcu_callback_t func)
>>>> +{
>>>> +    return __call_rcu_common(head, func, false);
>>>> +}
>>>> +EXPORT_SYMBOL_GPL(call_rcu_flush);
>>>> +#endif
>>>> +
>>>> +/**
>>>> + * call_rcu() - Queue an RCU callback for invocation after a grace per=
iod.
>>>> + * By default the callbacks are 'lazy' and are kept hidden from the ma=
in
>>>> + * ->cblist to prevent starting of grace periods too soon.
>>>> + * If you desire grace periods to start very soon, use call_rcu_flush(=
).
>>>> + *
>>>> + * @head: structure to be used for queueing the RCU updates.
>>>> + * @func: actual callback function to be invoked after the grace perio=
d
>>>> + *
>>>> + * The callback function will be invoked some time after a full grace
>>>> + * period elapses, in other words after all pre-existing RCU read-side=

>>>> + * critical sections have completed.  However, the callback function
>>>> + * might well execute concurrently with RCU read-side critical section=
s
>>>> + * that started after call_rcu() was invoked.
>>>> + *
>>>> + * RCU read-side critical sections are delimited by rcu_read_lock()
>>>> + * and rcu_read_unlock(), and may be nested.  In addition, but only in=

>>>> + * v5.0 and later, regions of code across which interrupts, preemption=
,
>>>> + * or softirqs have been disabled also serve as RCU read-side critical=

>>>> + * sections.  This includes hardware interrupt handlers, softirq handl=
ers,
>>>> + * and NMI handlers.
>>>> + *
>>>> + * Note that all CPUs must agree that the grace period extended beyond=

>>>> + * all pre-existing RCU read-side critical section.  On systems with m=
ore
>>>> + * than one CPU, this means that when "func()" is invoked, each CPU is=

>>>> + * guaranteed to have executed a full memory barrier since the end of i=
ts
>>>> + * last RCU read-side critical section whose beginning preceded the ca=
ll
>>>> + * to call_rcu().  It also means that each CPU executing an RCU read-s=
ide
>>>> + * critical section that continues beyond the start of "func()" must h=
ave
>>>> + * executed a memory barrier after the call_rcu() but before the begin=
ning
>>>> + * of that RCU read-side critical section.  Note that these guarantees=

>>>> + * include CPUs that are offline, idle, or executing in user mode, as
>>>> + * well as CPUs that are executing in the kernel.
>>>> + *
>>>> + * Furthermore, if CPU A invoked call_rcu() and CPU B invoked the
>>>> + * resulting RCU callback function "func()", then both CPU A and CPU B=
 are
>>>> + * guaranteed to execute a full memory barrier during the time interva=
l
>>>> + * between the call to call_rcu() and the invocation of "func()" -- ev=
en
>>>> + * if CPU A and CPU B are the same CPU (but again only if the system h=
as
>>>> + * more than one CPU).
>>>> + *
>>>> + * Implementation of these memory-ordering guarantees is described her=
e:
>>>> + * Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.r=
st.
>>>> + */
>>>> +void call_rcu(struct rcu_head *head, rcu_callback_t func)
>>>> +{
>>>> +    return __call_rcu_common(head, func, true);
>>>> +}
>>>> +EXPORT_SYMBOL_GPL(call_rcu);
>>>>=20
>>>> /* Maximum number of jiffies to wait before draining a batch. */
>>>> #define KFREE_DRAIN_JIFFIES (5 * HZ)
>>>> @@ -3507,7 +3544,7 @@ void synchronize_rcu(void)
>>>>       if (rcu_gp_is_expedited())
>>>>           synchronize_rcu_expedited();
>>>>       else
>>>> -            wait_rcu_gp(call_rcu);
>>>> +            wait_rcu_gp(call_rcu_flush);
>>>>       return;
>>>>   }
>>>>=20
>>>> @@ -3902,7 +3939,11 @@ static void rcu_barrier_entrain(struct rcu_data *=
rdp)
>>>>   rdp->barrier_head.func =3D rcu_barrier_callback;
>>>>   debug_rcu_head_queue(&rdp->barrier_head);
>>>>   rcu_nocb_lock(rdp);
>>>> -    WARN_ON_ONCE(!rcu_nocb_flush_bypass(rdp, NULL, jiffies));
>>>> +    /*
>>>> +     * Flush the bypass list, but also wake up the GP thread as otherw=
ise
>>>> +     * bypass/lazy CBs maynot be noticed, and can cause real long dela=
ys!
>>>> +     */
>>>> +    WARN_ON_ONCE(!rcu_nocb_flush_bypass(rdp, NULL, jiffies, FLUSH_BP_W=
AKE));
>>>>   if (rcu_segcblist_entrain(&rdp->cblist, &rdp->barrier_head)) {
>>>>       atomic_inc(&rcu_state.barrier_cpu_count);
>>>>   } else {
>>>> @@ -4323,7 +4364,7 @@ void rcutree_migrate_callbacks(int cpu)
>>>>   my_rdp =3D this_cpu_ptr(&rcu_data);
>>>>   my_rnp =3D my_rdp->mynode;
>>>>   rcu_nocb_lock(my_rdp); /* irqs already disabled. */
>>>> -    WARN_ON_ONCE(!rcu_nocb_flush_bypass(my_rdp, NULL, jiffies));
>>>> +    WARN_ON_ONCE(!rcu_nocb_flush_bypass(my_rdp, NULL, jiffies, FLUSH_B=
P_NONE));
>>>>   raw_spin_lock_rcu_node(my_rnp); /* irqs already disabled. */
>>>>   /* Leverage recent GPs and set GP for new callbacks. */
>>>>   needwake =3D rcu_advance_cbs(my_rnp, rdp) ||
>>>> diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
>>>> index d4a97e40ea9c..361c41d642c7 100644
>>>> --- a/kernel/rcu/tree.h
>>>> +++ b/kernel/rcu/tree.h
>>>> @@ -263,14 +263,16 @@ struct rcu_data {
>>>>   unsigned long last_fqs_resched;    /* Time of last rcu_resched(). */
>>>>   unsigned long last_sched_clock;    /* Jiffies of last rcu_sched_clock=
_irq(). */
>>>>=20
>>>> +    long lazy_len;            /* Length of buffered lazy callbacks. */=

>>>=20
>>> Do we ever actually care about the length as opposed to whether or not a=
ll
>>> the bypass callbacks are lazy?  If not, a "some_nonlazy" boolean would b=
e
>>> initialed to zero and ORed with the non-laziness of the added callback.
>>> Or, if there was a test anyway, simply set to 1 in the presence of a
>>> non-lazy callback.  And as now, gets zeroed when the bypass is flushed.
>>=20
>> We had discussed this before, and my point was
>> we could use it for tracing and future extension
>> as well. If it=E2=80=99s ok with you, I prefer to keep it this
>> way than having to come back add the length later.
>>=20
>> On a minor point as well, if you really want it this
>> way,  I am afraid of changing this now since I tested
>> this way for last several iterations and it=E2=80=99s easy to
>> add a regression. So I prefer to keep it this way and
>> then I can add more patches later on top if that=E2=80=99s
>> Ok with you.
>=20
> No, you are right, the debug information might be helpful.
>=20
> But hey, at least I am consistent!

Haha ;-)

>=20
>>> This might shorten a few lines of code.
>>>=20
>>>>   int cpu;
>>>> };
>>>>=20
>>>> /* Values for nocb_defer_wakeup field in struct rcu_data. */
>>>> #define RCU_NOCB_WAKE_NOT    0
>>>> #define RCU_NOCB_WAKE_BYPASS    1
>>>> -#define RCU_NOCB_WAKE        2
>>>> -#define RCU_NOCB_WAKE_FORCE    3
>>>> +#define RCU_NOCB_WAKE_LAZY    2
>>>> +#define RCU_NOCB_WAKE        3
>>>> +#define RCU_NOCB_WAKE_FORCE    4
>>>>=20
>>>> #define RCU_JIFFIES_TILL_FORCE_QS (1 + (HZ > 250) + (HZ > 500))
>>>>                   /* For jiffies_till_first_fqs and */
>>>> @@ -439,10 +441,17 @@ static void zero_cpu_stall_ticks(struct rcu_data *=
rdp);
>>>> static struct swait_queue_head *rcu_nocb_gp_get(struct rcu_node *rnp);
>>>> static void rcu_nocb_gp_cleanup(struct swait_queue_head *sq);
>>>> static void rcu_init_one_nocb(struct rcu_node *rnp);
>>>> +
>>>> +#define FLUSH_BP_NONE 0
>>>> +/* Is the CB being enqueued after the flush, a lazy CB? */
>>>> +#define FLUSH_BP_LAZY BIT(0)
>>>> +/* Wake up nocb-GP thread after flush? */
>>>> +#define FLUSH_BP_WAKE BIT(1)
>>>> static bool rcu_nocb_flush_bypass(struct rcu_data *rdp, struct rcu_head=
 *rhp,
>>>> -                  unsigned long j);
>>>> +                  unsigned long j, unsigned long flush_flags);
>>>> static bool rcu_nocb_try_bypass(struct rcu_data *rdp, struct rcu_head *=
rhp,
>>>> -                bool *was_alldone, unsigned long flags);
>>>> +                bool *was_alldone, unsigned long flags,
>>>> +                bool lazy);
>>>> static void __call_rcu_nocb_wake(struct rcu_data *rdp, bool was_empty,
>>>>                unsigned long flags);
>>>> static int rcu_nocb_need_deferred_wakeup(struct rcu_data *rdp, int leve=
l);
>>>> diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
>>>> index 18e9b4cd78ef..5cac05600798 100644
>>>> --- a/kernel/rcu/tree_exp.h
>>>> +++ b/kernel/rcu/tree_exp.h
>>>> @@ -937,7 +937,7 @@ void synchronize_rcu_expedited(void)
>>>>=20
>>>>   /* If expedited grace periods are prohibited, fall back to normal. */=

>>>>   if (rcu_gp_is_normal()) {
>>>> -        wait_rcu_gp(call_rcu);
>>>> +        wait_rcu_gp(call_rcu_flush);
>>>>       return;
>>>>   }
>>>>=20
>>>> diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
>>>> index f77a6d7e1356..661c685aba3f 100644
>>>> --- a/kernel/rcu/tree_nocb.h
>>>> +++ b/kernel/rcu/tree_nocb.h
>>>> @@ -256,6 +256,31 @@ static bool wake_nocb_gp(struct rcu_data *rdp, boo=
l force)
>>>>   return __wake_nocb_gp(rdp_gp, rdp, force, flags);
>>>> }
>>>>=20
>>>> +/*
>>>> + * LAZY_FLUSH_JIFFIES decides the maximum amount of time that
>>>> + * can elapse before lazy callbacks are flushed. Lazy callbacks
>>>> + * could be flushed much earlier for a number of other reasons
>>>> + * however, LAZY_FLUSH_JIFFIES will ensure no lazy callbacks are
>>>> + * left unsubmitted to RCU after those many jiffies.
>>>> + */
>>>> +#define LAZY_FLUSH_JIFFIES (10 * HZ)
>>>> +static unsigned long jiffies_till_flush =3D LAZY_FLUSH_JIFFIES;
>>>> +
>>>> +#ifdef CONFIG_RCU_LAZY
>>>> +// To be called only from test code.
>>>> +void rcu_lazy_set_jiffies_till_flush(unsigned long jif)
>>>> +{
>>>> +    jiffies_till_flush =3D jif;
>>>> +}
>>>> +EXPORT_SYMBOL(rcu_lazy_set_jiffies_till_flush);
>>>> +
>>>> +unsigned long rcu_lazy_get_jiffies_till_flush(void)
>>>> +{
>>>> +    return jiffies_till_flush;
>>>> +}
>>>> +EXPORT_SYMBOL(rcu_lazy_get_jiffies_till_flush);
>>>> +#endif
>>>> +
>>>> /*
>>>> * Arrange to wake the GP kthread for this NOCB group at some future
>>>> * time when it is safe to do so.
>>>> @@ -269,10 +294,14 @@ static void wake_nocb_gp_defer(struct rcu_data *r=
dp, int waketype,
>>>>   raw_spin_lock_irqsave(&rdp_gp->nocb_gp_lock, flags);
>>>>=20
>>>>   /*
>>>> -     * Bypass wakeup overrides previous deferments. In case
>>>> -     * of callback storm, no need to wake up too early.
>>>> +     * Bypass wakeup overrides previous deferments. In case of
>>>> +     * callback storm, no need to wake up too early.
>>>>    */
>>>> -    if (waketype =3D=3D RCU_NOCB_WAKE_BYPASS) {
>>>> +    if (waketype =3D=3D RCU_NOCB_WAKE_LAZY
>>>> +        && READ_ONCE(rdp->nocb_defer_wakeup) =3D=3D RCU_NOCB_WAKE_NOT)=
 {
>>>=20
>>> Please leave the "&&" on the previous line and line up the "READ_ONCE("
>>> with the "waketype".  That makes it easier to tell the condition from
>>> the following code.
>>=20
>> Will do!
>>=20
>>>=20
>>>> +        mod_timer(&rdp_gp->nocb_timer, jiffies + jiffies_till_flush);
>>>> +        WRITE_ONCE(rdp_gp->nocb_defer_wakeup, waketype);
>>>> +    } else if (waketype =3D=3D RCU_NOCB_WAKE_BYPASS) {
>>>>       mod_timer(&rdp_gp->nocb_timer, jiffies + 2);
>>>>       WRITE_ONCE(rdp_gp->nocb_defer_wakeup, waketype);
>>>>   } else {
>>>> @@ -293,12 +322,16 @@ static void wake_nocb_gp_defer(struct rcu_data *r=
dp, int waketype,
>>>> * proves to be initially empty, just return false because the no-CB GP
>>>> * kthread may need to be awakened in this case.
>>>> *
>>>> + * Return true if there was something to be flushed and it succeeded, o=
therwise
>>>> + * false.
>>>> + *
>>>> * Note that this function always returns true if rhp is NULL.
>>>> */
>>>> static bool rcu_nocb_do_flush_bypass(struct rcu_data *rdp, struct rcu_h=
ead *rhp,
>>>> -                     unsigned long j)
>>>> +                     unsigned long j, unsigned long flush_flags)
>>>> {
>>>>   struct rcu_cblist rcl;
>>>> +    bool lazy =3D flush_flags & FLUSH_BP_LAZY;
>>>>=20
>>>>   WARN_ON_ONCE(!rcu_rdp_is_offloaded(rdp));
>>>>   rcu_lockdep_assert_cblist_protected(rdp);
>>>> @@ -310,7 +343,20 @@ static bool rcu_nocb_do_flush_bypass(struct rcu_da=
ta *rdp, struct rcu_head *rhp,
>>>>   /* Note: ->cblist.len already accounts for ->nocb_bypass contents. */=

>>>>   if (rhp)
>>>>       rcu_segcblist_inc_len(&rdp->cblist); /* Must precede enqueue. */
>>>> -    rcu_cblist_flush_enqueue(&rcl, &rdp->nocb_bypass, rhp);
>>>> +
>>>> +    /*
>>>> +     * If the new CB requested was a lazy one, queue it onto the main
>>>> +     * ->cblist so we can take advantage of a sooner grade period.
>>>=20
>>> "take advantage of a grace period that will happen regardless."?
>>=20
>> Sure will update.
>>=20
>>>=20
>>>> +     */
>>>> +    if (lazy && rhp) {
>>>> +        rcu_cblist_flush_enqueue(&rcl, &rdp->nocb_bypass, NULL);
>>>> +        rcu_cblist_enqueue(&rcl, rhp);
>>>=20
>>> Would it makes sense to enqueue rhp onto ->nocb_bypass first, NULL out
>>> rhp, then let the rcu_cblist_flush_enqueue() be common code?  Or did thi=
s
>>> function grow a later use of rhp that I missed?
>>=20
>> No that could be done, but it prefer to keep it this
>> way because rhp is a function parameter and I
>> prefer not to modify those since it could add a
>> bug in future where rhp passed by user is now
>> NULL for some reason, half way through the
>> function.
>=20
> I agree that changing a function parameter is bad practice.
>=20
> So the question becomes whether introducing a local would outweigh
> consolidating this code.  Could you please at least give it a shot?

Yes for sure I will try this. Was thinking the same.

>=20
>>>> +        WRITE_ONCE(rdp->lazy_len, 0);
>>>> +    } else {
>>>> +        rcu_cblist_flush_enqueue(&rcl, &rdp->nocb_bypass, rhp);
>>>> +        WRITE_ONCE(rdp->lazy_len, 0);
>>>=20
>>> This WRITE_ONCE() can be dropped out of the "if" statement, correct?
>>=20
>> Yes will update.
>=20
> Thank you!
>=20
>>> If so, this could be an "if" statement with two statements in its "then"=

>>> clause, no "else" clause, and two statements following the "if" statemen=
t.
>>=20
>> I don=E2=80=99t think we can get rid of the else part but I=E2=80=99ll se=
e what it looks like.
>=20
> In the function header, s/rhp/rhp_in/, then:
>=20
>    struct rcu_head *rhp =3D rhp_in;
>=20
> And then:
>=20
>    if (lazy && rhp) {
>        rcu_cblist_enqueue(&rdp->nocb_bypass, rhp);
>        rhp =3D NULL;
>    }
>    rcu_cblist_flush_enqueue(&rcl, &rdp->nocb_bypass, rhp);
>    WRITE_ONCE(rdp->lazy_len, 0);
>=20
> Or did I mess something up?

Yes you are spot on. It seems more shorter, I=E2=80=99ll do it this way!

>=20
>>>> +    }
>>>> +
>>>>   rcu_segcblist_insert_pend_cbs(&rdp->cblist, &rcl);
>>>>   WRITE_ONCE(rdp->nocb_bypass_first, j);
>>>>   rcu_nocb_bypass_unlock(rdp);
>>>> @@ -326,13 +372,33 @@ static bool rcu_nocb_do_flush_bypass(struct rcu_d=
ata *rdp, struct rcu_head *rhp,
>>>> * Note that this function always returns true if rhp is NULL.
>>>> */
>>>> static bool rcu_nocb_flush_bypass(struct rcu_data *rdp, struct rcu_head=
 *rhp,
>>>> -                  unsigned long j)
>>>> +                  unsigned long j, unsigned long flush_flags)
>>>> {
>>>> +    bool ret;
>>>> +    bool was_alldone =3D false;
>>>> +    bool bypass_all_lazy =3D false;
>>>> +    long bypass_ncbs;
>>>=20
>>> Alphabetical order by variable name, please.  (Yes, I know that this is
>>> strange, but what can I say?)
>>=20
>> Sure.
>=20
> Thank you!

My pleasure!

>=20
>>>> +
>>>>   if (!rcu_rdp_is_offloaded(rdp))
>>>>       return true;
>>>>   rcu_lockdep_assert_cblist_protected(rdp);
>>>>   rcu_nocb_bypass_lock(rdp);
>>>> -    return rcu_nocb_do_flush_bypass(rdp, rhp, j);
>>>> +
>>>> +    if (flush_flags & FLUSH_BP_WAKE) {
>>>> +        was_alldone =3D !rcu_segcblist_pend_cbs(&rdp->cblist);
>>>> +        bypass_ncbs =3D rcu_cblist_n_cbs(&rdp->nocb_bypass);
>>>> +        bypass_all_lazy =3D bypass_ncbs && (bypass_ncbs =3D=3D rdp->la=
zy_len);
>>>> +    }
>>>> +
>>>> +    ret =3D rcu_nocb_do_flush_bypass(rdp, rhp, j, flush_flags);
>>>> +
>>>> +    // Wake up the nocb GP thread if needed. GP thread could be sleepi=
ng
>>>> +    // while waiting for lazy timer to expire (otherwise rcu_barrier m=
ay
>>>> +    // end up waiting for the duration of the lazy timer).
>>>> +    if (flush_flags & FLUSH_BP_WAKE && was_alldone && bypass_all_lazy)=

>>>> +        wake_nocb_gp(rdp, false);
>>>> +
>>>> +    return ret;
>>>> }
>>>>=20
>>>> /*
>>>> @@ -345,7 +411,7 @@ static void rcu_nocb_try_flush_bypass(struct rcu_da=
ta *rdp, unsigned long j)
>>>>   if (!rcu_rdp_is_offloaded(rdp) ||
>>>>       !rcu_nocb_bypass_trylock(rdp))
>>>>       return;
>>>> -    WARN_ON_ONCE(!rcu_nocb_do_flush_bypass(rdp, NULL, j));
>>>> +    WARN_ON_ONCE(!rcu_nocb_do_flush_bypass(rdp, NULL, j, FLUSH_BP_NONE=
));
>>>> }
>>>>=20
>>>> /*
>>>> @@ -367,12 +433,14 @@ static void rcu_nocb_try_flush_bypass(struct rcu_=
data *rdp, unsigned long j)
>>>> * there is only one CPU in operation.
>>>> */
>>>> static bool rcu_nocb_try_bypass(struct rcu_data *rdp, struct rcu_head *=
rhp,
>>>> -                bool *was_alldone, unsigned long flags)
>>>> +                bool *was_alldone, unsigned long flags,
>>>> +                bool lazy)
>>>> {
>>>>   unsigned long c;
>>>>   unsigned long cur_gp_seq;
>>>>   unsigned long j =3D jiffies;
>>>>   long ncbs =3D rcu_cblist_n_cbs(&rdp->nocb_bypass);
>>>> +    bool bypass_is_lazy =3D (ncbs =3D=3D READ_ONCE(rdp->lazy_len));
>>>>=20
>>>>   lockdep_assert_irqs_disabled();
>>>>=20
>>>> @@ -417,25 +485,30 @@ static bool rcu_nocb_try_bypass(struct rcu_data *=
rdp, struct rcu_head *rhp,
>>>>   // If there hasn't yet been all that many ->cblist enqueues
>>>>   // this jiffy, tell the caller to enqueue onto ->cblist.  But flush
>>>>   // ->nocb_bypass first.
>>>> -    if (rdp->nocb_nobypass_count < nocb_nobypass_lim_per_jiffy) {
>>>> +    // Lazy CBs throttle this back and do immediate bypass queuing.
>>>> +    if (rdp->nocb_nobypass_count < nocb_nobypass_lim_per_jiffy && !laz=
y) {
>>>>       rcu_nocb_lock(rdp);
>>>>       *was_alldone =3D !rcu_segcblist_pend_cbs(&rdp->cblist);
>>>>       if (*was_alldone)
>>>>           trace_rcu_nocb_wake(rcu_state.name, rdp->cpu,
>>>>                       TPS("FirstQ"));
>>>> -        WARN_ON_ONCE(!rcu_nocb_flush_bypass(rdp, NULL, j));
>>>> +
>>>> +        WARN_ON_ONCE(!rcu_nocb_flush_bypass(rdp, NULL, j, FLUSH_BP_NON=
E));
>>>>       WARN_ON_ONCE(rcu_cblist_n_cbs(&rdp->nocb_bypass));
>>>>       return false; // Caller must enqueue the callback.
>>>>   }
>>>>=20
>>>>   // If ->nocb_bypass has been used too long or is too full,
>>>>   // flush ->nocb_bypass to ->cblist.
>>>> -    if ((ncbs && j !=3D READ_ONCE(rdp->nocb_bypass_first)) ||
>>>> +    if ((ncbs && !bypass_is_lazy && j !=3D READ_ONCE(rdp->nocb_bypass_=
first)) ||
>>>> +        (ncbs &&  bypass_is_lazy &&
>>>> +        (time_after(j, READ_ONCE(rdp->nocb_bypass_first) + jiffies_til=
l_flush))) ||
>>>>       ncbs >=3D qhimark) {
>>>>       rcu_nocb_lock(rdp);
>>>>       *was_alldone =3D !rcu_segcblist_pend_cbs(&rdp->cblist);
>>>>=20
>>>> -        if (!rcu_nocb_flush_bypass(rdp, rhp, j)) {
>>>> +        if (!rcu_nocb_flush_bypass(rdp, rhp, j,
>>>> +                       lazy ? FLUSH_BP_LAZY : FLUSH_BP_NONE)) {
>>>>           if (*was_alldone)
>>>>               trace_rcu_nocb_wake(rcu_state.name, rdp->cpu,
>>>>                           TPS("FirstQ"));
>>>> @@ -460,16 +533,29 @@ static bool rcu_nocb_try_bypass(struct rcu_data *=
rdp, struct rcu_head *rhp,
>>>>   // We need to use the bypass.
>>>>   rcu_nocb_wait_contended(rdp);
>>>>   rcu_nocb_bypass_lock(rdp);
>>>> +
>>>>   ncbs =3D rcu_cblist_n_cbs(&rdp->nocb_bypass);
>>>>   rcu_segcblist_inc_len(&rdp->cblist); /* Must precede enqueue. */
>>>>   rcu_cblist_enqueue(&rdp->nocb_bypass, rhp);
>>>> +
>>>> +    if (IS_ENABLED(CONFIG_RCU_LAZY) && lazy)
>>>=20
>>> Won't !IS_ENABLED(CONFIG_RCU_LAZY) mean that lazy cannot be set?
>>> Why do we need to check both?  Or are you going for dead code?  If so,
>>> shouldn't there be IS_ENABLED(CONFIG_RCU_LAZY) checks above as well?
>>>=20
>>> Me, I am not convinced that the dead code would buy you much.  In fact,
>>> the compiler might well be propagating the constants on its own.
>>>=20
>>> Ah!  The reason the compiler cannot figure this out is because you put
>>> the switch into rcu.h.  If you instead always export the call_rcu_flush(=
)
>>> definition, and check IS_ENABLED(CONFIG_RCU_LAZY) at the beginning of
>>> call_rcu(), the compiler should have the information that it needs to
>>> do this for you.
>>=20
>> Ah ok, I will try to do it this way.
>=20
> Very good, thank you, for this and for the rest below.

Glad we could do this review, thanks.

 - Joel=20


>=20
>                            Thanx, Paul
>=20
>>>> +        WRITE_ONCE(rdp->lazy_len, rdp->lazy_len + 1);
>>>> +
>>>>   if (!ncbs) {
>>>>       WRITE_ONCE(rdp->nocb_bypass_first, j);
>>>>       trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, TPS("FirstBQ"));
>>>>   }
>>>> +
>>>>   rcu_nocb_bypass_unlock(rdp);
>>>>   smp_mb(); /* Order enqueue before wake. */
>>>> -    if (ncbs) {
>>>> +
>>>> +    // A wake up of the grace period kthread or timer adjustment needs=
 to
>>>> +    // be done only if:
>>>> +    // 1. Bypass list was fully empty before (this is the first bypass=
 list entry).
>>>> +    //    Or, both the below conditions are met:
>>>> +    // 1. Bypass list had only lazy CBs before.
>>>> +    // 2. The new CB is non-lazy.
>>>> +    if (ncbs && (!bypass_is_lazy || lazy)) {
>>>>       local_irq_restore(flags);
>>>>   } else {
>>>>       // No-CBs GP kthread might be indefinitely asleep, if so, wake.
>>>> @@ -499,7 +585,7 @@ static void __call_rcu_nocb_wake(struct rcu_data *r=
dp, bool was_alldone,
>>>> {
>>>>   unsigned long cur_gp_seq;
>>>>   unsigned long j;
>>>> -    long len;
>>>> +    long len, lazy_len, bypass_len;
>>>>   struct task_struct *t;
>>>=20
>>> Again, alphabetical please, strange though that might seem.
>>=20
>> Yes sure
>>=20
>>>=20
>>>>   // If we are being polled or there is no kthread, just leave.
>>>> @@ -512,9 +598,16 @@ static void __call_rcu_nocb_wake(struct rcu_data *=
rdp, bool was_alldone,
>>>>   }
>>>>   // Need to actually to a wakeup.
>>>>   len =3D rcu_segcblist_n_cbs(&rdp->cblist);
>>>> +    bypass_len =3D rcu_cblist_n_cbs(&rdp->nocb_bypass);
>>>> +    lazy_len =3D READ_ONCE(rdp->lazy_len);
>>>>   if (was_alldone) {
>>>>       rdp->qlen_last_fqs_check =3D len;
>>>> -        if (!irqs_disabled_flags(flags)) {
>>>> +        // Only lazy CBs in bypass list
>>>> +        if (lazy_len && bypass_len =3D=3D lazy_len) {
>>>> +            rcu_nocb_unlock_irqrestore(rdp, flags);
>>>> +            wake_nocb_gp_defer(rdp, RCU_NOCB_WAKE_LAZY,
>>>> +                       TPS("WakeLazy"));
>>>> +        } else if (!irqs_disabled_flags(flags)) {
>>>>           /* ... if queue was empty ... */
>>>>           rcu_nocb_unlock_irqrestore(rdp, flags);
>>>>           wake_nocb_gp(rdp, false);
>>>> @@ -604,8 +697,8 @@ static void nocb_gp_sleep(struct rcu_data *my_rdp, i=
nt cpu)
>>>> */
>>>> static void nocb_gp_wait(struct rcu_data *my_rdp)
>>>> {
>>>> -    bool bypass =3D false;
>>>> -    long bypass_ncbs;
>>>> +    bool bypass =3D false, lazy =3D false;
>>>> +    long bypass_ncbs, lazy_ncbs;
>>>=20
>>> And ditto.
>>=20
>> Ok
>>=20
>>>=20
>>>>   int __maybe_unused cpu =3D my_rdp->cpu;
>>>>   unsigned long cur_gp_seq;
>>>>   unsigned long flags;
>>>> @@ -640,24 +733,41 @@ static void nocb_gp_wait(struct rcu_data *my_rdp)=

>>>>    * won't be ignored for long.
>>>>    */
>>>>   list_for_each_entry(rdp, &my_rdp->nocb_head_rdp, nocb_entry_rdp) {
>>>> +        bool flush_bypass =3D false;
>>>> +
>>>>       trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, TPS("Check"));
>>>>       rcu_nocb_lock_irqsave(rdp, flags);
>>>>       lockdep_assert_held(&rdp->nocb_lock);
>>>>       bypass_ncbs =3D rcu_cblist_n_cbs(&rdp->nocb_bypass);
>>>> -        if (bypass_ncbs &&
>>>> +        lazy_ncbs =3D READ_ONCE(rdp->lazy_len);
>>>> +
>>>> +        if (bypass_ncbs && (lazy_ncbs =3D=3D bypass_ncbs) &&
>>>> +            (time_after(j, READ_ONCE(rdp->nocb_bypass_first) + jiffies=
_till_flush) ||
>>>> +             bypass_ncbs > 2 * qhimark)) {
>>>> +            flush_bypass =3D true;
>>>> +        } else if (bypass_ncbs && (lazy_ncbs !=3D bypass_ncbs) &&
>>>>           (time_after(j, READ_ONCE(rdp->nocb_bypass_first) + 1) ||
>>>>            bypass_ncbs > 2 * qhimark)) {
>>>> -            // Bypass full or old, so flush it.
>>>> -            (void)rcu_nocb_try_flush_bypass(rdp, j);
>>>> -            bypass_ncbs =3D rcu_cblist_n_cbs(&rdp->nocb_bypass);
>>>> +            flush_bypass =3D true;
>>>>       } else if (!bypass_ncbs && rcu_segcblist_empty(&rdp->cblist)) {
>>>>           rcu_nocb_unlock_irqrestore(rdp, flags);
>>>>           continue; /* No callbacks here, try next. */
>>>>       }
>>>> +
>>>> +        if (flush_bypass) {
>>>> +            // Bypass full or old, so flush it.
>>>> +            (void)rcu_nocb_try_flush_bypass(rdp, j);
>>>> +            bypass_ncbs =3D rcu_cblist_n_cbs(&rdp->nocb_bypass);
>>>> +            lazy_ncbs =3D READ_ONCE(rdp->lazy_len);
>>>> +        }
>>>> +
>>>>       if (bypass_ncbs) {
>>>>           trace_rcu_nocb_wake(rcu_state.name, rdp->cpu,
>>>> -                        TPS("Bypass"));
>>>> -            bypass =3D true;
>>>> +                    bypass_ncbs =3D=3D lazy_ncbs ? TPS("Lazy") : TPS("=
Bypass"));
>>>> +            if (bypass_ncbs =3D=3D lazy_ncbs)
>>>> +                lazy =3D true;
>>>> +            else
>>>> +                bypass =3D true;
>>>>       }
>>>>       rnp =3D rdp->mynode;
>>>>=20
>>>> @@ -705,12 +815,21 @@ static void nocb_gp_wait(struct rcu_data *my_rdp)=

>>>>   my_rdp->nocb_gp_gp =3D needwait_gp;
>>>>   my_rdp->nocb_gp_seq =3D needwait_gp ? wait_gp_seq : 0;
>>>>=20
>>>> -    if (bypass && !rcu_nocb_poll) {
>>>> -        // At least one child with non-empty ->nocb_bypass, so set
>>>> -        // timer in order to avoid stranding its callbacks.
>>>> -        wake_nocb_gp_defer(my_rdp, RCU_NOCB_WAKE_BYPASS,
>>>> -                   TPS("WakeBypassIsDeferred"));
>>>> +    // At least one child with non-empty ->nocb_bypass, so set
>>>> +    // timer in order to avoid stranding its callbacks.
>>>> +    if (!rcu_nocb_poll) {
>>>> +        // If bypass list only has lazy CBs. Add a deferred
>>>> +        // lazy wake up.
>>>=20
>>> One sentence rather than two.
>>=20
>> Ok
>>=20
>>>=20
>>>> +        if (lazy && !bypass) {
>>>> +            wake_nocb_gp_defer(my_rdp, RCU_NOCB_WAKE_LAZY,
>>>> +                    TPS("WakeLazyIsDeferred"));
>>>> +        // Otherwise add a deferred bypass wake up.
>>>> +        } else if (bypass) {
>>>> +            wake_nocb_gp_defer(my_rdp, RCU_NOCB_WAKE_BYPASS,
>>>> +                    TPS("WakeBypassIsDeferred"));
>>>> +        }
>>>>   }
>>>> +
>>>>   if (rcu_nocb_poll) {
>>>>       /* Polling, so trace if first poll in the series. */
>>>>       if (gotcbs)
>>>> @@ -1036,7 +1155,7 @@ static long rcu_nocb_rdp_deoffload(void *arg)
>>>>    * return false, which means that future calls to rcu_nocb_try_bypass=
()
>>>>    * will refuse to put anything into the bypass.
>>>>    */
>>>> -    WARN_ON_ONCE(!rcu_nocb_flush_bypass(rdp, NULL, jiffies));
>>>> +    WARN_ON_ONCE(!rcu_nocb_flush_bypass(rdp, NULL, jiffies, FLUSH_BP_N=
ONE));
>>>>   /*
>>>>    * Start with invoking rcu_core() early. This way if the current thre=
ad
>>>>    * happens to preempt an ongoing call to rcu_core() in the middle,
>>>> @@ -1278,6 +1397,7 @@ static void __init rcu_boot_init_nocb_percpu_data=
(struct rcu_data *rdp)
>>>>   raw_spin_lock_init(&rdp->nocb_gp_lock);
>>>>   timer_setup(&rdp->nocb_timer, do_nocb_deferred_wakeup_timer, 0);
>>>>   rcu_cblist_init(&rdp->nocb_bypass);
>>>> +    WRITE_ONCE(rdp->lazy_len, 0);
>>>>   mutex_init(&rdp->nocb_gp_kthread_mutex);
>>>> }
>>>>=20
>>>> @@ -1559,13 +1679,13 @@ static void rcu_init_one_nocb(struct rcu_node *=
rnp)
>>>> }
>>>>=20
>>>> static bool rcu_nocb_flush_bypass(struct rcu_data *rdp, struct rcu_head=
 *rhp,
>>>> -                  unsigned long j)
>>>> +                  unsigned long j, unsigned long flush_flags)
>>>> {
>>>>   return true;
>>>> }
>>>>=20
>>>> static bool rcu_nocb_try_bypass(struct rcu_data *rdp, struct rcu_head *=
rhp,
>>>> -                bool *was_alldone, unsigned long flags)
>>>> +                bool *was_alldone, unsigned long flags, bool lazy)
>>>> {
>>>>   return false;
>>>> }
>>>> --=20
>>>> 2.37.3.998.g577e59143f-goog
>>>>=20
