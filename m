Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCBC863B9A2
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 06:59:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235650AbiK2F7u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 00:59:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235642AbiK2F7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 00:59:48 -0500
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB8BA4FFA3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 21:59:47 -0800 (PST)
Received: by mail-qv1-xf2a.google.com with SMTP id d2so4078204qvp.12
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 21:59:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P2ERg4ZTTEgUi5D5NoUNK3spv5awQcT9Ib2d0Yu1QLY=;
        b=XBgv9WOtixgCM8/SjMLSGd5P9sZzXxplABTV0WKVCa1wjAtyoNfXMTqkJJZ+brfAEJ
         wuASw/0T62Cf4+2eWruh6lFMx4gta/s4K1gIYYL3Vj1qoo7YvKS2U7b4u9phvLII9vIA
         58LDKkql9JvrY2hvDhWlONVNbrL5B/t9Rm5LQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P2ERg4ZTTEgUi5D5NoUNK3spv5awQcT9Ib2d0Yu1QLY=;
        b=fEKwUnmt3gcd58PKZlHTTdkv0nnelWnUm49/5XORhNeheQCA7RkKx6+6rJFqsE54SM
         /QqkL7VwQyIoCyoZhOMl463VcITRLVmXciBVK60i7Jn7dTh9dLH8Sf1n3RBn1Ry6T+Zr
         PdiOYIu2OW+IH5gcbU++8FU3D8waQDMnx3axH8GZZtFRAdqC5Og51Hed/r54HA9rkg0S
         GqvMOiQgFO4edeLqhxOGZBIX4BUwJorrewa1Y1Kr11rwm4QYwlYQwneKFmA+aNRZrd2X
         8BhrLTn+uePvyYxWmBN/RUMjBiZljtYSATV/du+gelL/oXU8HQ6pLu3qPr8zT3dmGgRN
         3MsA==
X-Gm-Message-State: ANoB5plTEXgMiqvEaEFE/GWQayhIMB6YKQbGwRaQqjrXpr+/otwWzT82
        z4tuhhmKiYa6ScxbaBSajMzUycWEJkwBGg==
X-Google-Smtp-Source: AA0mqf5kNGvNQJ3q7qt4dzsmMBHYGfSHEpIlxzFiVCUES9SlJv7hmXGFM3hazrBvBHyunRs79XdcNA==
X-Received: by 2002:a05:6214:5d8d:b0:4c7:121:d67a with SMTP id mf13-20020a0562145d8d00b004c70121d67amr8127162qvb.79.1669701586823;
        Mon, 28 Nov 2022 21:59:46 -0800 (PST)
Received: from smtpclient.apple ([2600:1003:b10f:9e5b:184c:2f74:27ec:e005])
        by smtp.gmail.com with ESMTPSA id r26-20020ac8425a000000b003a4f435e381sm8086808qtm.18.2022.11.28.21.59.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Nov 2022 21:59:46 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Joel Fernandes <joel@joelfernandes.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2] rcu-tasks: Make rude RCU-Tasks work well with CPU hotplug
Date:   Tue, 29 Nov 2022 00:59:45 -0500
Message-Id: <24EC376D-B542-4E3C-BC10-3E81F2F2F49C@joelfernandes.org>
References: <PH0PR11MB588001E6982A9DC32F93FD7ADA129@PH0PR11MB5880.namprd11.prod.outlook.com>
Cc:     paulmck@kernel.org, frederic@kernel.org, quic_neeraju@quicinc.com,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <PH0PR11MB588001E6982A9DC32F93FD7ADA129@PH0PR11MB5880.namprd11.prod.outlook.com>
To:     "Zhang, Qiang1" <qiang1.zhang@intel.com>
X-Mailer: iPhone Mail (19G82)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Nov 28, 2022, at 11:54 PM, Zhang, Qiang1 <qiang1.zhang@intel.com> wrote=
:
>=20
> =EF=BB=BFOn Mon, Nov 28, 2022 at 10:34:28PM +0800, Zqiang wrote:
>> Currently, invoke rcu_tasks_rude_wait_gp() to wait one rude
>> RCU-tasks grace period, if __num_online_cpus =3D=3D 1, will return
>> directly, indicates the end of the rude RCU-task grace period.
>> suppose the system has two cpus, consider the following scenario:
>>=20
>>    CPU0                                   CPU1 (going offline)
>>                          migration/1 task:
>>                                      cpu_stopper_thread
>>                                       -> take_cpu_down
>>                                          -> _cpu_disable
>>                               (dec __num_online_cpus)
>>                                          ->cpuhp_invoke_callback
>>                                                preempt_disable
>>                        access old_data0
>>           task1
>> del old_data0                                  .....
>> synchronize_rcu_tasks_rude()
>> task1 schedule out
>> ....
>> task2 schedule in
>> rcu_tasks_rude_wait_gp()
>>     ->__num_online_cpus =3D=3D 1
>>       ->return
>> ....
>> task1 schedule in
>> ->free old_data0
>>                                                preempt_enable
>>=20
>> when CPU1 dec __num_online_cpus and __num_online_cpus is equal one,
>> the CPU1 has not finished offline, stop_machine task(migration/1)
>> still running on CPU1, maybe still accessing 'old_data0', but the
>> 'old_data0' has freed on CPU0.
>>=20
>> This commit add cpus_read_lock/unlock() protection before accessing
>> __num_online_cpus variables, to ensure that the CPU in the offline
>> process has been completed offline.
>>=20
>> Signed-off-by: Zqiang <qiang1.zhang@intel.com>
>>=20
>> First, good eyes and good catch!!!
>>=20
>> The purpose of that check for num_online_cpus() is not performance
>> on single-CPU systems, but rather correct operation during early boot.
>> So a simpler way to make that work is to check for RCU_SCHEDULER_RUNNING,=

>> for example, as follows:
>>=20
>>    if (rcu_scheduler_active !=3D RCU_SCHEDULER_RUNNING &&
>>        num_online_cpus() <=3D 1)
>>        return;    // Early boot fastpath for only one CPU.
>=20
> Hi Paul
>=20
> During system startup, because the RCU_SCHEDULER_RUNNING is set after star=
ting other CPUs,=20
>=20
>              CPU0                                                         =
              CPU1                                                          =
      =20
>=20
> if (rcu_scheduler_active !=3D                                   =20
>    RCU_SCHEDULER_RUNNING &&
>           __num_online_cpus  =3D=3D 1)                                    =
          =20
>    return;                                                                =
         inc  __num_online_cpus
>                            (__num_online_cpus =3D=3D 2)
>=20
> CPU0 didn't notice the update of the __num_online_cpus variable by CPU1 in=
 time
> Can we move rcu_set_runtime_mode() before smp_init()
> any thoughts?

Is anyone expected to do rcu-tasks operation before the scheduler is running=
? Typically this requires the tasks to context switch which is a scheduler o=
peration.

If the scheduler is not yet running, then I don=E2=80=99t think missing an u=
pdate the __num_online_cpus matters since no one does a tasks-RCU synchroniz=
e.

Or did I miss something?

Thanks.



>=20
> Thanks
> Zqiang
>=20
>>=20
>> This works because rcu_scheduler_active is set to RCU_SCHEDULER_RUNNING
>> long before it is possible to offline CPUs.
>>=20
>> Yes, schedule_on_each_cpu() does do cpus_read_lock(), again, good eyes,
>> and it also unnecessarily does the schedule_work_on() the current CPU,
>> but the code calling synchronize_rcu_tasks_rude() is on high-overhead
>> code paths, so this overhead is down in the noise.
>>=20
>> Until further notice, anyway.
>>=20
>> So simplicity is much more important than performance in this code.
>> So just adding the check for RCU_SCHEDULER_RUNNING should fix this,
>> unless I am missing something (always possible!).
>>=20
>>                            Thanx, Paul
>>=20
>> ---
>> kernel/rcu/tasks.h | 20 ++++++++++++++++++--
>> 1 file changed, 18 insertions(+), 2 deletions(-)
>>=20
>> diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
>> index 4a991311be9b..08e72c6462d8 100644
>> --- a/kernel/rcu/tasks.h
>> +++ b/kernel/rcu/tasks.h
>> @@ -1033,14 +1033,30 @@ static void rcu_tasks_be_rude(struct work_struct *=
work)
>> {
>> }
>>=20
>> +static DEFINE_PER_CPU(struct work_struct, rude_work);
>> +
>> // Wait for one rude RCU-tasks grace period.
>> static void rcu_tasks_rude_wait_gp(struct rcu_tasks *rtp)
>> {
>> +    int cpu;
>> +    struct work_struct *work;
>> +
>> +    cpus_read_lock();
>>    if (num_online_cpus() <=3D 1)
>> -        return;    // Fastpath for only one CPU.
>> +        goto end;// Fastpath for only one CPU.
>>=20
>>    rtp->n_ipis +=3D cpumask_weight(cpu_online_mask);
>> -    schedule_on_each_cpu(rcu_tasks_be_rude);
>> +    for_each_online_cpu(cpu) {
>> +        work =3D per_cpu_ptr(&rude_work, cpu);
>> +        INIT_WORK(work, rcu_tasks_be_rude);
>> +        schedule_work_on(cpu, work);
>> +    }
>> +
>> +    for_each_online_cpu(cpu)
>> +        flush_work(per_cpu_ptr(&rude_work, cpu));
>> +
>> +end:
>> +    cpus_read_unlock();
>> }
>>=20
>> void call_rcu_tasks_rude(struct rcu_head *rhp, rcu_callback_t func);
>> --=20
>> 2.25.1
>>=20
