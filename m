Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 299E663C8E3
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 21:01:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237168AbiK2UBU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 15:01:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237158AbiK2UBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 15:01:16 -0500
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F118248FF
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 12:01:15 -0800 (PST)
Received: by mail-qv1-xf2a.google.com with SMTP id i12so10516497qvs.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 12:01:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D6vuecyZV0OYU8Jdj59glPeINOb6y500uXyommfVPBM=;
        b=oqbUWQUsao1y85I50ELNBr0qzaYhyf4F4mO78udW2am0fiYSWzycjtGJLHXPmL36MN
         4202hUNMyxrJeeZmI6iQfQHmFFYVrSXmeEog/3tEYsIhOTPmK24teuP04GONgnY1HqHi
         PTe1HbcK3hcUQVeewVSog9aqpGTPtPIa+1yY0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D6vuecyZV0OYU8Jdj59glPeINOb6y500uXyommfVPBM=;
        b=DSRnU2J3J6o7u0orAhJq81oCHtkcwhTyROWR6WWNuaAyyNj3LZX4qmZ3Nq//rzEZgJ
         e1BGenAAyu4u5iuCVkSY6UZXDYqQX5TvXt8S987JOnjuKtY4sBw/VCsam0824L+DgKfd
         0guOvLCxz3lGZ4XwhV3ES0x4IXw3nv29FPp0+j6+eve6dcAVo7hYc6tcP4Dxo3V9li/k
         SAk3T2W8MvFEXzqFRMQ0bIrOw0qmQSNwDFiF3dS+Ua0cYSHQDWRBvkTOwt4jPzYsb3SH
         6wk/zbwXdwX4JbPpoZ2eZNwajcIPCuI4ZZy+4hIXJ5hYmz3x5iujgigTLVGm/PdkWuVu
         2g4g==
X-Gm-Message-State: ANoB5pnpP4nY2muPIHg3uW13TVD88AkgvJnIA1WsFZK4q3+fTQnav8Mi
        NoxQqHCfyPv50lY32d7gUClozQ==
X-Google-Smtp-Source: AA0mqf4BTFpYB+3oONEED+nOmHpjjAhnxWLcDF6yGZ1TzmBIWnSRkzXMZTXtLU2oS7OHtLe5vQMrEA==
X-Received: by 2002:a05:6214:3513:b0:4bb:ddaf:b9e5 with SMTP id nk19-20020a056214351300b004bbddafb9e5mr35287625qvb.52.1669752074098;
        Tue, 29 Nov 2022 12:01:14 -0800 (PST)
Received: from smtpclient.apple ([2600:1003:b119:afa3:a9e4:85e0:b8e3:7797])
        by smtp.gmail.com with ESMTPSA id bw13-20020a05622a098d00b003a586888a20sm9234939qtb.79.2022.11.29.12.01.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Nov 2022 12:01:13 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Joel Fernandes <joel@joelfernandes.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2] rcu-tasks: Make rude RCU-Tasks work well with CPU hotplug
Date:   Tue, 29 Nov 2022 15:01:12 -0500
Message-Id: <99F22D19-1340-4F13-8159-5202603C4942@joelfernandes.org>
References: <20221129191816.GA388190@paulmck-ThinkPad-P17-Gen-1>
Cc:     "Zhang, Qiang1" <qiang1.zhang@intel.com>, frederic@kernel.org,
        quic_neeraju@quicinc.com, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221129191816.GA388190@paulmck-ThinkPad-P17-Gen-1>
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



> On Nov 29, 2022, at 2:18 PM, Paul E. McKenney <paulmck@kernel.org> wrote:
>=20
> =EF=BB=BFOn Tue, Nov 29, 2022 at 11:00:05AM -0500, Joel Fernandes wrote:
>>=20
>>=20
>>>> On Nov 29, 2022, at 10:18 AM, Paul E. McKenney <paulmck@kernel.org> wro=
te:
>>>=20
>>> =EF=BB=BFOn Tue, Nov 29, 2022 at 06:25:04AM +0000, Zhang, Qiang1 wrote:
>>>>>> On Nov 28, 2022, at 11:54 PM, Zhang, Qiang1 <qiang1.zhang@intel.com> w=
rote:
>>>>>=20
>>>>> =EF=BB=BFOn Mon, Nov 28, 2022 at 10:34:28PM +0800, Zqiang wrote:
>>>>>> Currently, invoke rcu_tasks_rude_wait_gp() to wait one rude
>>>>>> RCU-tasks grace period, if __num_online_cpus =3D=3D 1, will return
>>>>>> directly, indicates the end of the rude RCU-task grace period.
>>>>>> suppose the system has two cpus, consider the following scenario:
>>>>>>=20
>>>>>>  CPU0                                   CPU1 (going offline)
>>>>>>                        migration/1 task:
>>>>>>                                    cpu_stopper_thread
>>>>>>                                     -> take_cpu_down
>>>>>>                                        -> _cpu_disable
>>>>>>                             (dec __num_online_cpus)
>>>>>>                                        ->cpuhp_invoke_callback
>>>>>>                                              preempt_disable
>>>>>>                      access old_data0
>>>>>>         task1
>>>>>> del old_data0                                  .....
>>>>>> synchronize_rcu_tasks_rude()
>>>>>> task1 schedule out
>>>>>> ....
>>>>>> task2 schedule in
>>>>>> rcu_tasks_rude_wait_gp()
>>>>>>   ->__num_online_cpus =3D=3D 1
>>>>>>     ->return
>>>>>> ....
>>>>>> task1 schedule in
>>>>>> ->free old_data0
>>>>>>                                              preempt_enable
>>>>>>=20
>>>>>> when CPU1 dec __num_online_cpus and __num_online_cpus is equal one,
>>>>>> the CPU1 has not finished offline, stop_machine task(migration/1)
>>>>>> still running on CPU1, maybe still accessing 'old_data0', but the
>>>>>> 'old_data0' has freed on CPU0.
>>>>>>=20
>>>>>> This commit add cpus_read_lock/unlock() protection before accessing
>>>>>> __num_online_cpus variables, to ensure that the CPU in the offline
>>>>>> process has been completed offline.
>>>>>>=20
>>>>>> Signed-off-by: Zqiang <qiang1.zhang@intel.com>
>>>>>>=20
>>>>>> First, good eyes and good catch!!!
>>>>>>=20
>>>>>> The purpose of that check for num_online_cpus() is not performance
>>>>>> on single-CPU systems, but rather correct operation during early boot=
.
>>>>>> So a simpler way to make that work is to check for RCU_SCHEDULER_RUNN=
ING,
>>>>>> for example, as follows:
>>>>>>=20
>>>>>>  if (rcu_scheduler_active !=3D RCU_SCHEDULER_RUNNING &&
>>>>>>      num_online_cpus() <=3D 1)
>>>>>>      return;    // Early boot fastpath for only one CPU.
>>>>>=20
>>>>> Hi Paul
>>>>>=20
>>>>> During system startup, because the RCU_SCHEDULER_RUNNING is set after s=
tarting other CPUs,=20
>>>>>=20
>>>>>            CPU0                                                       =
                CPU1                                                        =
        =20
>>>>>=20
>>>>> if (rcu_scheduler_active !=3D                                   =20
>>>>>  RCU_SCHEDULER_RUNNING &&
>>>>>         __num_online_cpus  =3D=3D 1)                                  =
            =20
>>>>>  return;                                                              =
           inc  __num_online_cpus
>>>>>                          (__num_online_cpus =3D=3D 2)
>>>>>=20
>>>>> CPU0 didn't notice the update of the __num_online_cpus variable by CPU=
1 in time
>>>>> Can we move rcu_set_runtime_mode() before smp_init()
>>>>> any thoughts?
>>>>>=20
>>>>> Is anyone expected to do rcu-tasks operation before the scheduler is r=
unning?=20
>>>>=20
>>>> Not sure if such a scenario exists.
>>>>=20
>>>>> Typically this requires the tasks to context switch which is a schedul=
er operation.
>>>>>=20
>>>>> If the scheduler is not yet running, then I don=E2=80=99t think missin=
g an update the __num_online_cpus matters since no one does a tasks-RCU sync=
hronize.
>>>>=20
>>>> Hi Joel
>>>>=20
>>>> After the kernel_init task runs, before calling smp_init() to starting o=
ther CPUs,=20
>>>> the scheduler haven been initialization, task context switching can occ=
ur.
>>>=20
>>> Good catch, thank you both.  For some reason, I was thinking that the
>>> additional CPUs did not come online until later.
>>>=20
>>> So how about this?
>>>=20
>>>   if (rcu_scheduler_active =3D=3D RCU_SCHEDULER_INACTIVE)
>>>       return;    // Early boot fastpath.
>>>=20
>>> If this condition is true, there is only one CPU and no scheduler,
>>> thus no preemption.
>>=20
>> Agreed. I was going to suggest exactly this :)
>>=20
>> Ack.
>> (Replying by phone but feel free to add my reviewed by tag).
>=20
> I should add that the downside of this approach is that there is a short
> time between the scheduler initializing and workqueues fully initializing
> where a critical-path call to synchronize_rcu_tasks() will hang the
> system.  I do -not- consider this to be a real problem because RCU had
> some hundreds of calls to synchronize_rcu() before this became an issue.
>=20
> So this should be fine, but please recall this for when/if someone does
> stick a synchronize_rcu_tasks() into that short time.  ;-)

Thanks Paul, but why would anyone want to do sync rcu tasks, before the sche=
duler is fully initialized?=20
Maybe we can add a warning here in the if-early-return path, to make sure no=
 such usage slips. And then we can look into someone using it that way, if t=
hey ever start using it.

Thanks,

- Joel

>=20
>                            Thanx, Paul
>=20
>> - Joel
>>=20
>>=20
>>>=20
>>>                       Thanx, Paul
>>>=20
>>>> Thanks
>>>> Zqiang
>>>>=20
>>>>>=20
>>>>> Or did I miss something?
>>>>>=20
>>>>> Thanks.
>>>>>=20
>>>>>=20
>>>>>=20
>>>>>=20
>>>>> Thanks
>>>>> Zqiang
>>>>>=20
>>>>>>=20
>>>>>> This works because rcu_scheduler_active is set to RCU_SCHEDULER_RUNNI=
NG
>>>>>> long before it is possible to offline CPUs.
>>>>>>=20
>>>>>> Yes, schedule_on_each_cpu() does do cpus_read_lock(), again, good eye=
s,
>>>>>> and it also unnecessarily does the schedule_work_on() the current CPU=
,
>>>>>> but the code calling synchronize_rcu_tasks_rude() is on high-overhead=

>>>>>> code paths, so this overhead is down in the noise.
>>>>>>=20
>>>>>> Until further notice, anyway.
>>>>>>=20
>>>>>> So simplicity is much more important than performance in this code.
>>>>>> So just adding the check for RCU_SCHEDULER_RUNNING should fix this,
>>>>>> unless I am missing something (always possible!).
>>>>>>=20
>>>>>>                          Thanx, Paul
>>>>>>=20
>>>>>> ---
>>>>>> kernel/rcu/tasks.h | 20 ++++++++++++++++++--
>>>>>> 1 file changed, 18 insertions(+), 2 deletions(-)
>>>>>>=20
>>>>>> diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
>>>>>> index 4a991311be9b..08e72c6462d8 100644
>>>>>> --- a/kernel/rcu/tasks.h
>>>>>> +++ b/kernel/rcu/tasks.h
>>>>>> @@ -1033,14 +1033,30 @@ static void rcu_tasks_be_rude(struct work_str=
uct *work)
>>>>>> {
>>>>>> }
>>>>>>=20
>>>>>> +static DEFINE_PER_CPU(struct work_struct, rude_work);
>>>>>> +
>>>>>> // Wait for one rude RCU-tasks grace period.
>>>>>> static void rcu_tasks_rude_wait_gp(struct rcu_tasks *rtp)
>>>>>> {
>>>>>> +    int cpu;
>>>>>> +    struct work_struct *work;
>>>>>> +
>>>>>> +    cpus_read_lock();
>>>>>>  if (num_online_cpus() <=3D 1)
>>>>>> -        return;    // Fastpath for only one CPU.
>>>>>> +        goto end;// Fastpath for only one CPU.
>>>>>>=20
>>>>>>  rtp->n_ipis +=3D cpumask_weight(cpu_online_mask);
>>>>>> -    schedule_on_each_cpu(rcu_tasks_be_rude);
>>>>>> +    for_each_online_cpu(cpu) {
>>>>>> +        work =3D per_cpu_ptr(&rude_work, cpu);
>>>>>> +        INIT_WORK(work, rcu_tasks_be_rude);
>>>>>> +        schedule_work_on(cpu, work);
>>>>>> +    }
>>>>>> +
>>>>>> +    for_each_online_cpu(cpu)
>>>>>> +        flush_work(per_cpu_ptr(&rude_work, cpu));
>>>>>> +
>>>>>> +end:
>>>>>> +    cpus_read_unlock();
>>>>>> }
>>>>>>=20
>>>>>> void call_rcu_tasks_rude(struct rcu_head *rhp, rcu_callback_t func);
>>>>>> --=20
>>>>>> 2.25.1
>>>>>>=20
