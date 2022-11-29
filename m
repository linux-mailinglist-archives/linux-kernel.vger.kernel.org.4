Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B53A163CBE4
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 00:31:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbiK2XbN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 18:31:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbiK2Xav (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 18:30:51 -0500
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAD6B73438
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 15:30:21 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id z17so11072044qki.11
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 15:30:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u+yn6xGp5XjuJHAn882JMtjlQ1B8ZFr7+3a30VM2uE8=;
        b=C4wgeKAFeFGAqIklhdubMVF9T3a/FD43iU1oRmyq6tRBr6Gj9rCEAQTFlPtJXTjtLZ
         120YC0/zoLoxA30hz9+NxERJf8HizG6NgG2BZGj/JaEdTvK9z+kSWcLd2azf6aSTUqow
         uesQGxBkokyJtm6FxdyaSn1o/43niTxgXcg88=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u+yn6xGp5XjuJHAn882JMtjlQ1B8ZFr7+3a30VM2uE8=;
        b=SSU8TVVdpyYSMV3DSTIUiUGMWF3noRu8/yFVHynHCx2rELZAN4c5GER9fj/d58SBEs
         wwvooxZpESdOU3VhKnKKOop0/G2JPWvwbUs6JTQthpM/+yAQi+Y6w0e4IvR+2oz+dT3g
         Cq3A2/FSI9AeSAJmWVIEujoCjPm37QIcS8NtSj6DYeSDAGo3PZAxvUpe6t1V5loWTPC+
         el5pGXOhuNZjocda+hHwcP+t1vluhkzdiAbJ5g001ZJOQnmKvDNNe0fnIdfz6eWlmb3c
         UZnJ5QxWC10ooljmuw9sHNu4AZtZS5NJEXQ3a2x1NG8K30MlEy636IQ7DhKM4IhcYNql
         uwqQ==
X-Gm-Message-State: ANoB5plqiQQ53/Bet4YpH8SgINmpvsjOnSPy6R1hMNW1nOvUmX/sGBow
        NBo2m4l9Hd0/0lHOV24T8jloYg==
X-Google-Smtp-Source: AA0mqf5r42nD4Xo+baiZ5BcCDIOSja5rAarDvGJ8N+Z+z/VSrC4pjjWAg4KcXTb1jM6RawcBMDu1Pw==
X-Received: by 2002:a05:620a:b9a:b0:6fa:432f:298a with SMTP id k26-20020a05620a0b9a00b006fa432f298amr39021875qkh.159.1669764620935;
        Tue, 29 Nov 2022 15:30:20 -0800 (PST)
Received: from smtpclient.apple (c-73-148-104-166.hsd1.va.comcast.net. [73.148.104.166])
        by smtp.gmail.com with ESMTPSA id e22-20020ac85996000000b003a4f22c6507sm9618681qte.48.2022.11.29.15.30.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Nov 2022 15:30:20 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Joel Fernandes <joel@joelfernandes.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2] rcu-tasks: Make rude RCU-Tasks work well with CPU hotplug
Date:   Tue, 29 Nov 2022 18:30:19 -0500
Message-Id: <0E3DA71D-8C94-4FE9-BBF9-83AC28993485@joelfernandes.org>
References: <20221129201349.GE4001@paulmck-ThinkPad-P17-Gen-1>
Cc:     "Zhang, Qiang1" <qiang1.zhang@intel.com>, frederic@kernel.org,
        quic_neeraju@quicinc.com, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221129201349.GE4001@paulmck-ThinkPad-P17-Gen-1>
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



> On Nov 29, 2022, at 3:13 PM, Paul E. McKenney <paulmck@kernel.org> wrote:
>=20
> =EF=BB=BFOn Tue, Nov 29, 2022 at 03:01:12PM -0500, Joel Fernandes wrote:
>>>> On Nov 29, 2022, at 2:18 PM, Paul E. McKenney <paulmck@kernel.org> wrot=
e:
>>> =EF=BB=BFOn Tue, Nov 29, 2022 at 11:00:05AM -0500, Joel Fernandes wrote:=

>>>>>> On Nov 29, 2022, at 10:18 AM, Paul E. McKenney <paulmck@kernel.org> w=
rote:
>>>>> =EF=BB=BFOn Tue, Nov 29, 2022 at 06:25:04AM +0000, Zhang, Qiang1 wrote=
:
>>>>>>>> On Nov 28, 2022, at 11:54 PM, Zhang, Qiang1 <qiang1.zhang@intel.com=
> wrote:
>>>>>>>=20
>>>>>>> =EF=BB=BFOn Mon, Nov 28, 2022 at 10:34:28PM +0800, Zqiang wrote:
>>>>>>>> Currently, invoke rcu_tasks_rude_wait_gp() to wait one rude
>>>>>>>> RCU-tasks grace period, if __num_online_cpus =3D=3D 1, will return
>>>>>>>> directly, indicates the end of the rude RCU-task grace period.
>>>>>>>> suppose the system has two cpus, consider the following scenario:
>>>>>>>>=20
>>>>>>>> CPU0                                   CPU1 (going offline)
>>>>>>>>                       migration/1 task:
>>>>>>>>                                   cpu_stopper_thread
>>>>>>>>                                    -> take_cpu_down
>>>>>>>>                                       -> _cpu_disable
>>>>>>>>                            (dec __num_online_cpus)
>>>>>>>>                                       ->cpuhp_invoke_callback
>>>>>>>>                                             preempt_disable
>>>>>>>>                     access old_data0
>>>>>>>>        task1
>>>>>>>> del old_data0                                  .....
>>>>>>>> synchronize_rcu_tasks_rude()
>>>>>>>> task1 schedule out
>>>>>>>> ....
>>>>>>>> task2 schedule in
>>>>>>>> rcu_tasks_rude_wait_gp()
>>>>>>>>  ->__num_online_cpus =3D=3D 1
>>>>>>>>    ->return
>>>>>>>> ....
>>>>>>>> task1 schedule in
>>>>>>>> ->free old_data0
>>>>>>>>                                             preempt_enable
>>>>>>>>=20
>>>>>>>> when CPU1 dec __num_online_cpus and __num_online_cpus is equal one,=

>>>>>>>> the CPU1 has not finished offline, stop_machine task(migration/1)
>>>>>>>> still running on CPU1, maybe still accessing 'old_data0', but the
>>>>>>>> 'old_data0' has freed on CPU0.
>>>>>>>>=20
>>>>>>>> This commit add cpus_read_lock/unlock() protection before accessing=

>>>>>>>> __num_online_cpus variables, to ensure that the CPU in the offline
>>>>>>>> process has been completed offline.
>>>>>>>>=20
>>>>>>>> Signed-off-by: Zqiang <qiang1.zhang@intel.com>
>>>>>>>>=20
>>>>>>>> First, good eyes and good catch!!!
>>>>>>>>=20
>>>>>>>> The purpose of that check for num_online_cpus() is not performance
>>>>>>>> on single-CPU systems, but rather correct operation during early bo=
ot.
>>>>>>>> So a simpler way to make that work is to check for RCU_SCHEDULER_RU=
NNING,
>>>>>>>> for example, as follows:
>>>>>>>>=20
>>>>>>>> if (rcu_scheduler_active !=3D RCU_SCHEDULER_RUNNING &&
>>>>>>>>     num_online_cpus() <=3D 1)
>>>>>>>>     return;    // Early boot fastpath for only one CPU.
>>>>>>>=20
>>>>>>> Hi Paul
>>>>>>>=20
>>>>>>> During system startup, because the RCU_SCHEDULER_RUNNING is set afte=
r starting other CPUs,=20
>>>>>>>=20
>>>>>>>           CPU0                                                      =
                 CPU1                                                       =
         =20
>>>>>>>=20
>>>>>>> if (rcu_scheduler_active !=3D                                   =20
>>>>>>> RCU_SCHEDULER_RUNNING &&
>>>>>>>        __num_online_cpus  =3D=3D 1)                                 =
             =20
>>>>>>> return;                                                             =
            inc  __num_online_cpus
>>>>>>>                         (__num_online_cpus =3D=3D 2)
>>>>>>>=20
>>>>>>> CPU0 didn't notice the update of the __num_online_cpus variable by C=
PU1 in time
>>>>>>> Can we move rcu_set_runtime_mode() before smp_init()
>>>>>>> any thoughts?
>>>>>>>=20
>>>>>>> Is anyone expected to do rcu-tasks operation before the scheduler is=
 running?=20
>>>>>>=20
>>>>>> Not sure if such a scenario exists.
>>>>>>=20
>>>>>>> Typically this requires the tasks to context switch which is a sched=
uler operation.
>>>>>>>=20
>>>>>>> If the scheduler is not yet running, then I don=E2=80=99t think miss=
ing an update the __num_online_cpus matters since no one does a tasks-RCU sy=
nchronize.
>>>>>>=20
>>>>>> Hi Joel
>>>>>>=20
>>>>>> After the kernel_init task runs, before calling smp_init() to startin=
g other CPUs,=20
>>>>>> the scheduler haven been initialization, task context switching can o=
ccur.
>>>>>=20
>>>>> Good catch, thank you both.  For some reason, I was thinking that the
>>>>> additional CPUs did not come online until later.
>>>>>=20
>>>>> So how about this?
>>>>>=20
>>>>>  if (rcu_scheduler_active =3D=3D RCU_SCHEDULER_INACTIVE)
>>>>>      return;    // Early boot fastpath.
>>>>>=20
>>>>> If this condition is true, there is only one CPU and no scheduler,
>>>>> thus no preemption.
>>>>=20
>>>> Agreed. I was going to suggest exactly this :)
>>>>=20
>>>> Ack.
>>>> (Replying by phone but feel free to add my reviewed by tag).
>>>=20
>>> I should add that the downside of this approach is that there is a short=

>>> time between the scheduler initializing and workqueues fully initializin=
g
>>> where a critical-path call to synchronize_rcu_tasks() will hang the
>>> system.  I do -not- consider this to be a real problem because RCU had
>>> some hundreds of calls to synchronize_rcu() before this became an issue.=

>>>=20
>>> So this should be fine, but please recall this for when/if someone does
>>> stick a synchronize_rcu_tasks() into that short time.  ;-)
>>=20
>> Thanks Paul, but why would anyone want to do sync rcu tasks, before
>> the scheduler is fully initialized?
>=20
> I could ask that same question of a number of other RCU API members.  ;-)
>=20
>> Maybe we can add a warning here in the if-early-return path, to make
>> sure no such usage slips. And then we can look into someone using it
>> that way, if they ever start using it.
>=20
> I expect that it would be more work to code and maintain any such warning
> than it would to diagnose the hang, so let's leave it as is.

Makes sense.  Works for me and you over to you Qiang! ;-)

Thanks,

  - Joel=20

>=20
>                            Thanx, Paul
>=20
>> Thanks,
>>=20
>> - Joel
>>=20
>>>=20
>>>                           Thanx, Paul
>>>=20
>>>> - Joel
>>>>=20
>>>>=20
>>>>>=20
>>>>>                      Thanx, Paul
>>>>>=20
>>>>>> Thanks
>>>>>> Zqiang
>>>>>>=20
>>>>>>>=20
>>>>>>> Or did I miss something?
>>>>>>>=20
>>>>>>> Thanks.
>>>>>>>=20
>>>>>>>=20
>>>>>>>=20
>>>>>>>=20
>>>>>>> Thanks
>>>>>>> Zqiang
>>>>>>>=20
>>>>>>>>=20
>>>>>>>> This works because rcu_scheduler_active is set to RCU_SCHEDULER_RUN=
NING
>>>>>>>> long before it is possible to offline CPUs.
>>>>>>>>=20
>>>>>>>> Yes, schedule_on_each_cpu() does do cpus_read_lock(), again, good e=
yes,
>>>>>>>> and it also unnecessarily does the schedule_work_on() the current C=
PU,
>>>>>>>> but the code calling synchronize_rcu_tasks_rude() is on high-overhe=
ad
>>>>>>>> code paths, so this overhead is down in the noise.
>>>>>>>>=20
>>>>>>>> Until further notice, anyway.
>>>>>>>>=20
>>>>>>>> So simplicity is much more important than performance in this code.=

>>>>>>>> So just adding the check for RCU_SCHEDULER_RUNNING should fix this,=

>>>>>>>> unless I am missing something (always possible!).
>>>>>>>>=20
>>>>>>>>                         Thanx, Paul
>>>>>>>>=20
>>>>>>>> ---
>>>>>>>> kernel/rcu/tasks.h | 20 ++++++++++++++++++--
>>>>>>>> 1 file changed, 18 insertions(+), 2 deletions(-)
>>>>>>>>=20
>>>>>>>> diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
>>>>>>>> index 4a991311be9b..08e72c6462d8 100644
>>>>>>>> --- a/kernel/rcu/tasks.h
>>>>>>>> +++ b/kernel/rcu/tasks.h
>>>>>>>> @@ -1033,14 +1033,30 @@ static void rcu_tasks_be_rude(struct work_s=
truct *work)
>>>>>>>> {
>>>>>>>> }
>>>>>>>>=20
>>>>>>>> +static DEFINE_PER_CPU(struct work_struct, rude_work);
>>>>>>>> +
>>>>>>>> // Wait for one rude RCU-tasks grace period.
>>>>>>>> static void rcu_tasks_rude_wait_gp(struct rcu_tasks *rtp)
>>>>>>>> {
>>>>>>>> +    int cpu;
>>>>>>>> +    struct work_struct *work;
>>>>>>>> +
>>>>>>>> +    cpus_read_lock();
>>>>>>>> if (num_online_cpus() <=3D 1)
>>>>>>>> -        return;    // Fastpath for only one CPU.
>>>>>>>> +        goto end;// Fastpath for only one CPU.
>>>>>>>>=20
>>>>>>>> rtp->n_ipis +=3D cpumask_weight(cpu_online_mask);
>>>>>>>> -    schedule_on_each_cpu(rcu_tasks_be_rude);
>>>>>>>> +    for_each_online_cpu(cpu) {
>>>>>>>> +        work =3D per_cpu_ptr(&rude_work, cpu);
>>>>>>>> +        INIT_WORK(work, rcu_tasks_be_rude);
>>>>>>>> +        schedule_work_on(cpu, work);
>>>>>>>> +    }
>>>>>>>> +
>>>>>>>> +    for_each_online_cpu(cpu)
>>>>>>>> +        flush_work(per_cpu_ptr(&rude_work, cpu));
>>>>>>>> +
>>>>>>>> +end:
>>>>>>>> +    cpus_read_unlock();
>>>>>>>> }
>>>>>>>>=20
>>>>>>>> void call_rcu_tasks_rude(struct rcu_head *rhp, rcu_callback_t func)=
;
>>>>>>>> --=20
>>>>>>>> 2.25.1
>>>>>>>>=20
