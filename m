Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 281D6663924
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 07:14:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbjAJGOA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 01:14:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbjAJGNW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 01:13:22 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4FF3485AC
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 22:12:32 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id h26so10162453qtu.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 22:12:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NBYes0zEiQA7Y7bWPYpE7CVG6wkXe4zIBkGmQ6rkHLs=;
        b=Xxki9XP4m9imnL0ev7/jcski0uldHjh9QRpjaIbLajKcXa8E3xIoAKbYWRH2ckF5gS
         dQkRv+T2etMQKQJQ8QjU8U78PAdy/C+LE0AKn+WHazvV93lfdhsJMHJJsWGUrF4WOk0y
         MmPLaG7pK4lvlkQdVXrQr2k2qSO5Xpwoq5FGw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NBYes0zEiQA7Y7bWPYpE7CVG6wkXe4zIBkGmQ6rkHLs=;
        b=J09YGvdsEtJvACLr62lz8uaSEeW7Nvd77MF8rI5dAAPCdnLJV7JvcSDjR9xeE+u4Ko
         nxoU1ZwbhLO8+8/oY6SxwkLvDuG/TSDDRHqPGiYnqMe0BipBBP71CjGe418En3owmTMy
         T3PZlT7dq00INtetViE1AYGDJjjr2XLdhhDKB1jDTM7na2a7/SZCV42Y2NA74novlyqV
         41T6t18+xw2fIPhZW68ov/AuR8tCviyj1Kk6awkQsiRuhyQZ1GG5aKYLz8FRr2FxmnvQ
         3XAIzvpx/EgRYFQcsjg0fHCtSfCqoc7+wnPjjyjm73jfIy13DcmDsWiYm43O0ELozzam
         u26Q==
X-Gm-Message-State: AFqh2kryZnBpPUPYyQfuIjNPIbXSqgSq4bVmo9PRNmw2XfexVkIz/+Sz
        7AFEso4tCGGmeUfnKnUoDbhkHA==
X-Google-Smtp-Source: AMrXdXu8wLgt4haXmdMpkDupddGrfBqJyTOCXn4NWOgpv6CjWbpRksuyS6CMLZUGzaesHXfUnchCwA==
X-Received: by 2002:ac8:4705:0:b0:3ab:5a62:453b with SMTP id f5-20020ac84705000000b003ab5a62453bmr85367702qtp.53.1673331151769;
        Mon, 09 Jan 2023 22:12:31 -0800 (PST)
Received: from smtpclient.apple ([2600:1003:b110:1f87:f047:ffed:9f93:3fb6])
        by smtp.gmail.com with ESMTPSA id j20-20020a05620a289400b006fed58fc1a3sm6665055qkp.119.2023.01.09.22.12.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Jan 2023 22:12:30 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Joel Fernandes <joel@joelfernandes.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 1/3] rcu: genericize RCU stall suppression functions
Date:   Tue, 10 Jan 2023 01:12:20 -0500
Message-Id: <8AE6FCC1-B8FD-492D-A8D9-4FCBEA3BC5BF@joelfernandes.org>
References: <8105AAEA-F018-4246-AA6F-AE8ED6A65433@joelfernandes.org>
Cc:     Robert Elliott <elliott@hpe.com>, herbert@gondor.apana.org.au,
        davem@davemloft.net, frederic@kernel.org, quic_neeraju@quicinc.com,
        josh@joshtriplett.org, linux-crypto@vger.kernel.org,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <8105AAEA-F018-4246-AA6F-AE8ED6A65433@joelfernandes.org>
To:     paulmck@kernel.org
X-Mailer: iPhone Mail (20B101)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jan 10, 2023, at 1:07 AM, Joel Fernandes <joel@joelfernandes.org> wrote=
:
>=20
> =EF=BB=BF
>=20
>>> On Dec 21, 2022, at 1:56 PM, Paul E. McKenney <paulmck@kernel.org> wrote=
:
>>>=20
>>> =EF=BB=BFOn Mon, Dec 19, 2022 at 02:29:08PM -0600, Robert Elliott wrote:=

>>> Convert the functions that temporarily suppress RCU CPU
>>> stall reporting:
>>>   rcu_sysrq_start()
>>>   rcu_sysrq_end()
>>>=20
>>> to more generic functions that may be called by functions
>>> other than the SysRq handler:
>>>   rcu_suppress_start()
>>>   rcu_suppress_end()
>>>=20
>>> Covert the underlying variable:
>>>   rcu_cpu_stall_suppress
>>>=20
>>> to an atomic variable so multiple threads can manipulate it at the
>>> same time, incrementing it in start() and decrementing in end().
>>>=20
>>> Expose that in sysfs in a read-only
>>>   /sys/module/rcupdate/parameters/rcu_cpu_stall_suppress_dyn
>=20
> Robert,
>=20
> What is the use of exposing this read-only node?
>=20
> I find it hard to believe anyone or any tool would be reading it during a s=
cenario where stalls are required to be dynamically suppressed.
>=20
> Or maybe I missed the point of this patch as I am late to the party.

I was hasty to not be clear =E2=80=94 I have no problem with the idea of dyn=
amic suppression, just missing the point about the read only infomercial via=
 sysfs node. More kernel memory wasted in sysfs however small :-).

Thanks,

 - J

>=20
> Thanks,
>=20
> - J
>=20
>=20
>>>=20
>>> Keep
>>>   /sys/module/rcupdate/parameters/rcu_cpu_stall_suppress
>>> as writeable by userspace, but OR that into the equations rather than
>>> directly manipulate the atomic value.
>>>=20
>>> Signed-off-by: Robert Elliott <elliott@hpe.com>
>>=20
>> I really like the idea of making the suppressing and unsuppressing of
>> RCU CPU stall warnings SMP-safe, thank you!  Yes, as far as I know,
>> there have been no problems due to this, but accidents waiting to happen
>> and all that.
>>=20
>> Some comments and questions below.
>>=20
>>> ---
>>> .../RCU/Design/Requirements/Requirements.rst  |  6 +++---
>>> Documentation/RCU/stallwarn.rst               | 19 +++++++++++++++----
>>> arch/parisc/kernel/process.c                  |  2 +-
>>> drivers/tty/sysrq.c                           |  4 ++--
>>> include/linux/rcupdate.h                      |  8 ++++----
>>> kernel/rcu/rcu.h                              | 11 ++++++-----
>>> kernel/rcu/tree_stall.h                       | 18 ++++++++++--------
>>> kernel/rcu/update.c                           | 11 ++++++++++-
>>> 8 files changed, 51 insertions(+), 28 deletions(-)
>>>=20
>>> diff --git a/Documentation/RCU/Design/Requirements/Requirements.rst b/Do=
cumentation/RCU/Design/Requirements/Requirements.rst
>>> index 49387d823619..5083490bb6fc 100644
>>> --- a/Documentation/RCU/Design/Requirements/Requirements.rst
>>> +++ b/Documentation/RCU/Design/Requirements/Requirements.rst
>>> @@ -1639,9 +1639,9 @@ against mishaps and misuse:
>>>   ``rcupdate.rcu_cpu_stall_suppress`` to suppress the splats. This
>>>   kernel parameter may also be set via ``sysfs``. Furthermore, RCU CPU
>>>   stall warnings are counter-productive during sysrq dumps and during
>>> -   panics. RCU therefore supplies the rcu_sysrq_start() and
>>> -   rcu_sysrq_end() API members to be called before and after long
>>> -   sysrq dumps. RCU also supplies the rcu_panic() notifier that is
>>> +   panics. RCU therefore supplies the rcu_suppress_start() and
>>> +   rcu_suppress_end() API members to be called before and after long
>>> +   CPU usage. RCU also supplies the rcu_panic() notifier that is
>>>   automatically invoked at the beginning of a panic to suppress further
>>>   RCU CPU stall warnings.
>>>=20
>>> diff --git a/Documentation/RCU/stallwarn.rst b/Documentation/RCU/stallwa=
rn.rst
>>> index e38c587067fc..9e6fba72f56d 100644
>>> --- a/Documentation/RCU/stallwarn.rst
>>> +++ b/Documentation/RCU/stallwarn.rst
>>> @@ -135,13 +135,24 @@ see include/trace/events/rcu.h.
>>> Fine-Tuning the RCU CPU Stall Detector
>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>>=20
>>> -The rcuupdate.rcu_cpu_stall_suppress module parameter disables RCU's
>>> -CPU stall detector, which detects conditions that unduly delay RCU grac=
e
>>> -periods.  This module parameter enables CPU stall detection by default,=

>>> -but may be overridden via boot-time parameter or at runtime via sysfs.
>>> +RCU's CPU stall detector detects conditions that unduly delay RCU grace=

>>> +periods.  CPU stall detection is enabled by default, but may be overrid=
den
>>> +via boot-time parameter or at runtime via sysfs (accessible via
>>> +/sys/module/rcupdate/parameters).
>>> +
>>> +The rcupdate.rcu_cpu_stall_suppress module parameter disables RCU's
>>> +CPU stall detector.
>>> +
>>> +/sys/module/rcu_cpu_stall_suppress_dyn reports an internal semaphore
>>=20
>> Actually an atomically updated variable as opposed to a semaphore,
>> correct?  Replacing "an internal semaphore" with something like "a
>> variable" would be fine from my viewpoint.
>>=20
>>> +used by the RCU's CPU stall detector. Functions holding a CPU for a
>>> +long time (e.g., sysrq printouts) increment this value before use
>>> +and decrement it when done, so the value reports the number of
>>> +functions currently disabling stalls.
>>> +
>>> The stall detector's idea of what constitutes "unduly delayed" is
>>> controlled by a set of kernel configuration variables and cpp macros:
>>>=20
>>> +
>>> CONFIG_RCU_CPU_STALL_TIMEOUT
>>> ----------------------------
>>=20
>> And thank you for updating the documentation!
>>=20
>>> diff --git a/arch/parisc/kernel/process.c b/arch/parisc/kernel/process.c=

>>> index c4f8374c7018..038378fe7bfa 100644
>>> --- a/arch/parisc/kernel/process.c
>>> +++ b/arch/parisc/kernel/process.c
>>> @@ -126,7 +126,7 @@ void machine_power_off(void)
>>>          "Please power this system off now.");
>>>=20
>>>   /* prevent soft lockup/stalled CPU messages for endless loop. */
>>> -    rcu_sysrq_start();
>>> +    rcu_suppress_start();
>>>   lockup_detector_soft_poweroff();
>>>   for (;;);
>>> }
>>> diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
>>> index d2b2720db6ca..81ab63a473a7 100644
>>> --- a/drivers/tty/sysrq.c
>>> +++ b/drivers/tty/sysrq.c
>>> @@ -579,7 +579,7 @@ void __handle_sysrq(int key, bool check_mask)
>>>   orig_suppress_printk =3D suppress_printk;
>>>   suppress_printk =3D 0;
>>>=20
>>> -    rcu_sysrq_start();
>>> +    rcu_suppress_start();
>>>   rcu_read_lock();
>>>   /*
>>>    * Raise the apparent loglevel to maximum so that the sysrq header
>>> @@ -623,7 +623,7 @@ void __handle_sysrq(int key, bool check_mask)
>>>       console_loglevel =3D orig_log_level;
>>>   }
>>>   rcu_read_unlock();
>>> -    rcu_sysrq_end();
>>> +    rcu_suppress_end();
>>>=20
>>>   suppress_printk =3D orig_suppress_printk;
>>> }
>>> diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
>>> index 03abf883a281..c0d8a4aae7ff 100644
>>> --- a/include/linux/rcupdate.h
>>> +++ b/include/linux/rcupdate.h
>>> @@ -131,11 +131,11 @@ static inline void rcu_init_tasks_generic(void) { }=

>>> #endif
>>>=20
>>> #ifdef CONFIG_RCU_STALL_COMMON
>>> -void rcu_sysrq_start(void);
>>> -void rcu_sysrq_end(void);
>>> +void rcu_suppress_start(void);
>>> +void rcu_suppress_end(void);
>>> #else /* #ifdef CONFIG_RCU_STALL_COMMON */
>>> -static inline void rcu_sysrq_start(void) { }
>>> -static inline void rcu_sysrq_end(void) { }
>>> +static inline void rcu_suppress_start(void) { }
>>> +static inline void rcu_suppress_end(void) { }
>>> #endif /* #else #ifdef CONFIG_RCU_STALL_COMMON */
>>>=20
>>> #if defined(CONFIG_NO_HZ_FULL) && (!defined(CONFIG_GENERIC_ENTRY) || !de=
fined(CONFIG_KVM_XFER_TO_GUEST_WORK))
>>> diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
>>> index c5aa934de59b..a658955a1174 100644
>>> --- a/kernel/rcu/rcu.h
>>> +++ b/kernel/rcu/rcu.h
>>> @@ -224,24 +224,25 @@ extern int rcu_cpu_stall_ftrace_dump;
>>> extern int rcu_cpu_stall_suppress;
>>> extern int rcu_cpu_stall_timeout;
>>> extern int rcu_exp_cpu_stall_timeout;
>>> +extern atomic_t rcu_cpu_stall_suppress_dyn;
>>> int rcu_jiffies_till_stall_check(void);
>>> int rcu_exp_jiffies_till_stall_check(void);
>>>=20
>>> static inline bool rcu_stall_is_suppressed(void)
>>> {
>>> -    return rcu_stall_is_suppressed_at_boot() || rcu_cpu_stall_suppress;=

>>> +    return rcu_stall_is_suppressed_at_boot() ||
>>> +           rcu_cpu_stall_suppress ||
>>> +           atomic_read(&rcu_cpu_stall_suppress_dyn);
>>> }
>>>=20
>>> #define rcu_ftrace_dump_stall_suppress() \
>>> do { \
>>> -    if (!rcu_cpu_stall_suppress) \
>>> -        rcu_cpu_stall_suppress =3D 3; \
>>=20
>> One thing we are losing here is the ability to see what is suppressing
>> the current stall, for example, from a crash dump.  Maybe that is OK,
>> as I haven't needed to debug that sort of thing.
>>=20
>> Thoughts from those who have had this debugging experience?
>>=20
>>> +    atomic_inc(&rcu_cpu_stall_suppress_dyn); \
>>> } while (0)
>>>=20
>>> #define rcu_ftrace_dump_stall_unsuppress() \
>>> do { \
>>> -    if (rcu_cpu_stall_suppress =3D=3D 3) \
>>> -        rcu_cpu_stall_suppress =3D 0; \
>>> +    atomic_dec(&rcu_cpu_stall_suppress_dyn); \
>>> } while (0)
>>>=20
>>> #else /* #endif #ifdef CONFIG_RCU_STALL_COMMON */
>>> diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
>>> index 5653560573e2..260748bc5bc8 100644
>>> --- a/kernel/rcu/tree_stall.h
>>> +++ b/kernel/rcu/tree_stall.h
>>> @@ -103,23 +103,25 @@ bool rcu_gp_might_be_stalled(void)
>>>   return !time_before(j, READ_ONCE(rcu_state.gp_start) + d);
>>> }
>>>=20
>>> -/* Don't do RCU CPU stall warnings during long sysrq printouts. */
>>> -void rcu_sysrq_start(void)
>>> +/* Don't do RCU CPU stall warnings during functions holding the CPU
>>> + * for a long period of time such as long sysrq printouts.
>>> + */
>>> +void rcu_suppress_start(void)
>>> {
>>> -    if (!rcu_cpu_stall_suppress)
>>> -        rcu_cpu_stall_suppress =3D 2;
>>=20
>> And the same point here.
>>=20
>>> +    atomic_inc(&rcu_cpu_stall_suppress_dyn);
>>> }
>>> +EXPORT_SYMBOL_GPL(rcu_suppress_start);
>>=20
>> If this is being exported to modules, the question of who suppressed
>> the CPU stalls might at some point become more urgent.
>>=20
>> If the problem was reproducible, I would simply attach a BPF program to
>> rcu_suppress_start() and rcu_suppress_end() counting the stack traces of
>> all callers to these functions.  This might or might not make everyone
>> happy, though.
>>=20
>>> -void rcu_sysrq_end(void)
>>> +void rcu_suppress_end(void)
>>> {
>>> -    if (rcu_cpu_stall_suppress =3D=3D 2)
>>> -        rcu_cpu_stall_suppress =3D 0;
>>> +    atomic_dec(&rcu_cpu_stall_suppress_dyn);
>>> }
>>> +EXPORT_SYMBOL_GPL(rcu_suppress_end);
>>>=20
>>> /* Don't print RCU CPU stall warnings during a kernel panic. */
>>> static int rcu_panic(struct notifier_block *this, unsigned long ev, void=
 *ptr)
>>> {
>>> -    rcu_cpu_stall_suppress =3D 1;
>>> +    atomic_inc(&rcu_cpu_stall_suppress_dyn);
>>>   return NOTIFY_DONE;
>>> }
>>>=20
>>> diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
>>> index f5e6a2f95a2a..ceee9d777384 100644
>>> --- a/kernel/rcu/update.c
>>> +++ b/kernel/rcu/update.c
>>> @@ -501,11 +501,18 @@ EXPORT_SYMBOL_GPL(rcutorture_sched_setaffinity);
>>> #ifdef CONFIG_RCU_STALL_COMMON
>>> int rcu_cpu_stall_ftrace_dump __read_mostly;
>>> module_param(rcu_cpu_stall_ftrace_dump, int, 0644);
>>> -int rcu_cpu_stall_suppress __read_mostly; // !0 =3D suppress stall warn=
ings.
>>> +
>>> +int rcu_cpu_stall_suppress __read_mostly; // !0 =3D suppress stall warn=
ings from sysfs
>>> EXPORT_SYMBOL_GPL(rcu_cpu_stall_suppress);
>>> module_param(rcu_cpu_stall_suppress, int, 0644);
>>> +
>>> +atomic_t rcu_cpu_stall_suppress_dyn __read_mostly; // !0 =3D suppress s=
tall warnings from functions
>>> +EXPORT_SYMBOL_GPL(rcu_cpu_stall_suppress_dyn);
>>> +module_param_named(rcu_cpu_stall_suppress_dyn, rcu_cpu_stall_suppress_d=
yn.counter, int, 0444);
>>=20
>> I am not seeing a valid use case for specifying an initial
>> value on the kernel command line.  Or does this somehow prevent
>> rcupdate.rcu_cpu_stall_suppress_dyn from being specified on the kernel
>> command line?
>>=20
>> If something like rcupdate.rcu_cpu_stall_suppress_dyn=3D3 can be specifie=
d
>> (incorrectly, in my current view) on the kernel command line, maybe
>> something as shown below would help?
>>=20
>>> +
>>> int rcu_cpu_stall_timeout __read_mostly =3D CONFIG_RCU_CPU_STALL_TIMEOUT=
;
>>> module_param(rcu_cpu_stall_timeout, int, 0644);
>>> +
>>> int rcu_exp_cpu_stall_timeout __read_mostly =3D CONFIG_RCU_EXP_CPU_STALL=
_TIMEOUT;
>>> module_param(rcu_exp_cpu_stall_timeout, int, 0644);
>>> #endif /* #ifdef CONFIG_RCU_STALL_COMMON */
>>> @@ -616,6 +623,8 @@ void __init rcupdate_announce_bootup_oddness(void)
>>>       pr_info("\tAll grace periods are expedited (rcu_expedited).\n");
>>>   if (rcu_cpu_stall_suppress)
>>>       pr_info("\tRCU CPU stall warnings suppressed (rcu_cpu_stall_suppre=
ss).\n");
>>> +    if (atomic_read(&rcu_cpu_stall_suppress_dyn))
>>> +        pr_info("\tDynamic RCU CPU stall warnings suppressed (rcu_cpu_s=
tall_suppress_dyn).\n");
>>=20
>> Should this instead be a WARN_ON() placed somewhere so that it won't
>> mess up the printing of the other parameters?
>>=20
>> Or maybe have this code set it to back to zero, with the message
>> indicating that this is being done?
>>=20
>>>   if (rcu_cpu_stall_timeout !=3D CONFIG_RCU_CPU_STALL_TIMEOUT)
>>>       pr_info("\tRCU CPU stall warnings timeout set to %d (rcu_cpu_stall=
_timeout).\n", rcu_cpu_stall_timeout);
>>>   rcu_tasks_bootup_oddness();
>>> --=20
>>> 2.38.1
>>>=20
