Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CF4263C484
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 17:02:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235408AbiK2QCJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 11:02:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235781AbiK2QBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 11:01:40 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC63569DFE
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 08:00:07 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id cg5so9179468qtb.12
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 08:00:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jAz1Ii4kT4Ngt667oDc7ntxW3NYMICg18xLmFs7pDgo=;
        b=iyxsgOvqCKFI9D5kcXLYHmby5ob2Lm6YBojPejD5DthvIM/d68rImFKeiygpC/sCrQ
         MP1nC7cwemdpY2EkYY91F/3TilZa/uXu3Cqa9AwHzOLPbJe5g6jhpv08C9Jr7v8msYjn
         vfD5MMEmhogoEiyU5ZBwCIXVeWGakq9YSbfoA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jAz1Ii4kT4Ngt667oDc7ntxW3NYMICg18xLmFs7pDgo=;
        b=JddqpX46oI2cvikPPWDddCYTZpdGCqknzlACtz0NS5VViWF8U2umOB8O3zKovZ73MU
         D9QAq1S7qMFKxf0zebVOOoAmYOGAl0XALrQVJBFGWgfgMrfr6IupKW8Nqk44ajwBEBHi
         nxAT2RSeS2nnuHlWNGc5WWaNNRCHlDzIAr/O0X5tx1ZhlSSM0wg2/OOk445ne1NuZ6s2
         PQHmtUKyOJSeawpGG6Wimys+UJ0VkB6E1bSuRMAfisvqpoAPWVqbNjCNda7RHWHN0Put
         yQKi+IFJ7FJfof9GpTL7zz9hJDVgnaEFfb2376vcoU7cg0mkQfV+s9JeuZHoNFVMkk5K
         j4tA==
X-Gm-Message-State: ANoB5pkVIDAJSRT6b4LYx6j49FOE494QshWKARxgAXwzaREivHSnQPgX
        mrfdlxt0H7Rh0V8SJpHWzXxqcA==
X-Google-Smtp-Source: AA0mqf6Ug5CEsHWzAhVwaNbtOKNWfpkkkw0mwGtud8HrmEf8pX9NjLWrAGhnGZXzJR6MQkbi+VBvCw==
X-Received: by 2002:ac8:7183:0:b0:3a5:1dcb:d22d with SMTP id w3-20020ac87183000000b003a51dcbd22dmr34343541qto.489.1669737606790;
        Tue, 29 Nov 2022 08:00:06 -0800 (PST)
Received: from smtpclient.apple ([2600:1003:b10f:9e5b:184c:2f74:27ec:e005])
        by smtp.gmail.com with ESMTPSA id bq10-20020a05622a1c0a00b003a582090530sm8795322qtb.83.2022.11.29.08.00.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Nov 2022 08:00:06 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Joel Fernandes <joel@joelfernandes.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2] rcu-tasks: Make rude RCU-Tasks work well with CPU hotplug
Date:   Tue, 29 Nov 2022 11:00:05 -0500
Message-Id: <9299CE62-C7B6-45F5-BD07-C1CB02F0D08C@joelfernandes.org>
References: <20221129151810.GY4001@paulmck-ThinkPad-P17-Gen-1>
Cc:     "Zhang, Qiang1" <qiang1.zhang@intel.com>, frederic@kernel.org,
        quic_neeraju@quicinc.com, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221129151810.GY4001@paulmck-ThinkPad-P17-Gen-1>
To:     paulmck@kernel.org
X-Mailer: iPhone Mail (19G82)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Nov 29, 2022, at 10:18 AM, Paul E. McKenney <paulmck@kernel.org> wrote:=

>=20
> =EF=BB=BFOn Tue, Nov 29, 2022 at 06:25:04AM +0000, Zhang, Qiang1 wrote:
>>>> On Nov 28, 2022, at 11:54 PM, Zhang, Qiang1 <qiang1.zhang@intel.com> wr=
ote:
>>>=20
>>> =EF=BB=BFOn Mon, Nov 28, 2022 at 10:34:28PM +0800, Zqiang wrote:
>>>> Currently, invoke rcu_tasks_rude_wait_gp() to wait one rude
>>>> RCU-tasks grace period, if __num_online_cpus =3D=3D 1, will return
>>>> directly, indicates the end of the rude RCU-task grace period.
>>>> suppose the system has two cpus, consider the following scenario:
>>>>=20
>>>>   CPU0                                   CPU1 (going offline)
>>>>                         migration/1 task:
>>>>                                     cpu_stopper_thread
>>>>                                      -> take_cpu_down
>>>>                                         -> _cpu_disable
>>>>                              (dec __num_online_cpus)
>>>>                                         ->cpuhp_invoke_callback
>>>>                                               preempt_disable
>>>>                       access old_data0
>>>>          task1
>>>> del old_data0                                  .....
>>>> synchronize_rcu_tasks_rude()
>>>> task1 schedule out
>>>> ....
>>>> task2 schedule in
>>>> rcu_tasks_rude_wait_gp()
>>>>    ->__num_online_cpus =3D=3D 1
>>>>      ->return
>>>> ....
>>>> task1 schedule in
>>>> ->free old_data0
>>>>                                               preempt_enable
>>>>=20
>>>> when CPU1 dec __num_online_cpus and __num_online_cpus is equal one,
>>>> the CPU1 has not finished offline, stop_machine task(migration/1)
>>>> still running on CPU1, maybe still accessing 'old_data0', but the
>>>> 'old_data0' has freed on CPU0.
>>>>=20
>>>> This commit add cpus_read_lock/unlock() protection before accessing
>>>> __num_online_cpus variables, to ensure that the CPU in the offline
>>>> process has been completed offline.
>>>>=20
>>>> Signed-off-by: Zqiang <qiang1.zhang@intel.com>
>>>>=20
>>>> First, good eyes and good catch!!!
>>>>=20
>>>> The purpose of that check for num_online_cpus() is not performance
>>>> on single-CPU systems, but rather correct operation during early boot.
>>>> So a simpler way to make that work is to check for RCU_SCHEDULER_RUNNIN=
G,
>>>> for example, as follows:
>>>>=20
>>>>   if (rcu_scheduler_active !=3D RCU_SCHEDULER_RUNNING &&
>>>>       num_online_cpus() <=3D 1)
>>>>       return;    // Early boot fastpath for only one CPU.
>>>=20
>>> Hi Paul
>>>=20
>>> During system startup, because the RCU_SCHEDULER_RUNNING is set after st=
arting other CPUs,=20
>>>=20
>>>             CPU0                                                        =
               CPU1                                                         =
       =20
>>>=20
>>> if (rcu_scheduler_active !=3D                                   =20
>>>   RCU_SCHEDULER_RUNNING &&
>>>          __num_online_cpus  =3D=3D 1)                                   =
           =20
>>>   return;                                                               =
          inc  __num_online_cpus
>>>                           (__num_online_cpus =3D=3D 2)
>>>=20
>>> CPU0 didn't notice the update of the __num_online_cpus variable by CPU1 i=
n time
>>> Can we move rcu_set_runtime_mode() before smp_init()
>>> any thoughts?
>>>=20
>>> Is anyone expected to do rcu-tasks operation before the scheduler is run=
ning?=20
>>=20
>> Not sure if such a scenario exists.
>>=20
>>> Typically this requires the tasks to context switch which is a scheduler=
 operation.
>>>=20
>>> If the scheduler is not yet running, then I don=E2=80=99t think missing a=
n update the __num_online_cpus matters since no one does a tasks-RCU synchro=
nize.
>>=20
>> Hi Joel
>>=20
>> After the kernel_init task runs, before calling smp_init() to starting ot=
her CPUs,=20
>> the scheduler haven been initialization, task context switching can occur=
.
>=20
> Good catch, thank you both.  For some reason, I was thinking that the
> additional CPUs did not come online until later.
>=20
> So how about this?
>=20
>    if (rcu_scheduler_active =3D=3D RCU_SCHEDULER_INACTIVE)
>        return;    // Early boot fastpath.
>=20
> If this condition is true, there is only one CPU and no scheduler,
> thus no preemption.

Agreed. I was going to suggest exactly this :)

Ack.
(Replying by phone but feel free to add my reviewed by tag).

- Joel


>=20
>                        Thanx, Paul
>=20
>> Thanks
>> Zqiang
>>=20
>>>=20
>>> Or did I miss something?
>>>=20
>>> Thanks.
>>>=20
>>>=20
>>>=20
>>>=20
>>> Thanks
>>> Zqiang
>>>=20
>>>>=20
>>>> This works because rcu_scheduler_active is set to RCU_SCHEDULER_RUNNING=

>>>> long before it is possible to offline CPUs.
>>>>=20
>>>> Yes, schedule_on_each_cpu() does do cpus_read_lock(), again, good eyes,=

>>>> and it also unnecessarily does the schedule_work_on() the current CPU,
>>>> but the code calling synchronize_rcu_tasks_rude() is on high-overhead
>>>> code paths, so this overhead is down in the noise.
>>>>=20
>>>> Until further notice, anyway.
>>>>=20
>>>> So simplicity is much more important than performance in this code.
>>>> So just adding the check for RCU_SCHEDULER_RUNNING should fix this,
>>>> unless I am missing something (always possible!).
>>>>=20
>>>>                           Thanx, Paul
>>>>=20
>>>> ---
>>>> kernel/rcu/tasks.h | 20 ++++++++++++++++++--
>>>> 1 file changed, 18 insertions(+), 2 deletions(-)
>>>>=20
>>>> diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
>>>> index 4a991311be9b..08e72c6462d8 100644
>>>> --- a/kernel/rcu/tasks.h
>>>> +++ b/kernel/rcu/tasks.h
>>>> @@ -1033,14 +1033,30 @@ static void rcu_tasks_be_rude(struct work_struc=
t *work)
>>>> {
>>>> }
>>>>=20
>>>> +static DEFINE_PER_CPU(struct work_struct, rude_work);
>>>> +
>>>> // Wait for one rude RCU-tasks grace period.
>>>> static void rcu_tasks_rude_wait_gp(struct rcu_tasks *rtp)
>>>> {
>>>> +    int cpu;
>>>> +    struct work_struct *work;
>>>> +
>>>> +    cpus_read_lock();
>>>>   if (num_online_cpus() <=3D 1)
>>>> -        return;    // Fastpath for only one CPU.
>>>> +        goto end;// Fastpath for only one CPU.
>>>>=20
>>>>   rtp->n_ipis +=3D cpumask_weight(cpu_online_mask);
>>>> -    schedule_on_each_cpu(rcu_tasks_be_rude);
>>>> +    for_each_online_cpu(cpu) {
>>>> +        work =3D per_cpu_ptr(&rude_work, cpu);
>>>> +        INIT_WORK(work, rcu_tasks_be_rude);
>>>> +        schedule_work_on(cpu, work);
>>>> +    }
>>>> +
>>>> +    for_each_online_cpu(cpu)
>>>> +        flush_work(per_cpu_ptr(&rude_work, cpu));
>>>> +
>>>> +end:
>>>> +    cpus_read_unlock();
>>>> }
>>>>=20
>>>> void call_rcu_tasks_rude(struct rcu_head *rhp, rcu_callback_t func);
>>>> --=20
>>>> 2.25.1
>>>>=20
