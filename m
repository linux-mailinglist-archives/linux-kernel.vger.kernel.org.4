Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 467DE616DF4
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 20:47:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbiKBTrE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 15:47:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiKBTrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 15:47:03 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FAC5EE37
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 12:47:01 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id s20so6084159qkg.5
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 12:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q3+rVHbRVHoRsFi8EU7mjtkE4YA9UXd3aKmvyhixqEI=;
        b=fVZV1lWBKLHEMbZnvzyPodl0NbQM6aKGkLYuh+hbnV78mokKHq6rFMTGaCPcw3rS7T
         l3IS8w+ECX78EOO0aktBWw6woo4nCTHW2aco7VLJciwlhaCvB09O3OT18LvxTunPzxMd
         JCxKq6wMNHpYG8H8Y1GHweh5nsFJulIZY0rmk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q3+rVHbRVHoRsFi8EU7mjtkE4YA9UXd3aKmvyhixqEI=;
        b=fNlpVOT1QPP0PQSe81JF/VePuYuYG6JUYQKIX2pcgMViWIpb0/h8hz5qyoXt1ttQbx
         GuPMaF71kPSlumEJyR1YSpMEdaia4zUomSqaNwk50imUkPX1ZBdosiCgNKzwvrFOO+zu
         AG4mf6Y8AX8YjW9Miy2h5J3K98D2AnP7XVsBdvZreElzc7AJyMFkazFnvriUAF4/oNE0
         ZCSO5WC+Slq+DIQVcz4QYsSkSSW9bTkddnwke+8NXqHJ3McKg8lSrZbaWAv0cXeV9zFV
         3CuMkfkMw5gpTalf9nrLO+JWcepAK/PskNK4spfTfWRRlujv9mweugn5MnkpT/gOPfrj
         FMuw==
X-Gm-Message-State: ACrzQf0hCRwtnO2Ls7FdnjEGmd4cvKo1zhqQIiyYDXroh2Ewebdv624u
        6SDYKcccWYQ1mzQIlbxVjPnmDQ==
X-Google-Smtp-Source: AMsMyM6o5pA5VVVSNdTYX3RDKqOZ0PsT2Gvv25+bIMBnyg2pqexS1GR/uoWv3o7DIJ0FVZFQo9ajAQ==
X-Received: by 2002:a05:620a:4305:b0:6f6:7a35:bc24 with SMTP id u5-20020a05620a430500b006f67a35bc24mr18261178qko.447.1667418420697;
        Wed, 02 Nov 2022 12:47:00 -0700 (PDT)
Received: from smtpclient.apple (c-73-148-104-166.hsd1.va.comcast.net. [73.148.104.166])
        by smtp.gmail.com with ESMTPSA id n13-20020a05620a222d00b006fa12a74c53sm8889447qkh.61.2022.11.02.12.46.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Nov 2022 12:46:59 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Joel Fernandes <joel@joelfernandes.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH RFC] rcu/kfree: Do not request RCU when not needed
Date:   Wed, 2 Nov 2022 15:46:59 -0400
Message-Id: <755B5ED1-653D-4E57-B114-77CDE10A9033@joelfernandes.org>
References: <20221102184911.GP5600@paulmck-ThinkPad-P17-Gen-1>
Cc:     Uladzislau Rezki <urezki@gmail.com>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221102184911.GP5600@paulmck-ThinkPad-P17-Gen-1>
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



> On Nov 2, 2022, at 2:49 PM, Paul E. McKenney <paulmck@kernel.org> wrote:
>=20
> =EF=BB=BFOn Wed, Nov 02, 2022 at 07:31:40PM +0100, Uladzislau Rezki wrote:=

>>> On Wed, Nov 02, 2022 at 01:29:17PM -0400, Joel Fernandes wrote:
>>> On Wed, Nov 2, 2022 at 1:24 PM Uladzislau Rezki <urezki@gmail.com> wrote=
:
>>>>=20
>>>> On Wed, Nov 02, 2022 at 09:35:44AM -0700, Paul E. McKenney wrote:
>>>>> On Wed, Nov 02, 2022 at 12:13:17PM -0400, Joel Fernandes wrote:
>>>>>> On Wed, Nov 2, 2022 at 8:37 AM Uladzislau Rezki <urezki@gmail.com> wr=
ote:
>>>>>>>=20
>>>>>>> On Sat, Oct 29, 2022 at 01:28:56PM +0000, Joel Fernandes (Google) wr=
ote:
>>>>>>>> On ChromeOS, I am (almost) always seeing the optimization trigger.
>>>>>>>> Tested boot up and trace_printk'ing how often it triggers.
>>>>>>>>=20
>>>>>>>> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
>>>>>>>> ---
>>>>>>>> kernel/rcu/tree.c | 18 +++++++++++++++++-
>>>>>>>> 1 file changed, 17 insertions(+), 1 deletion(-)
>>>>>>>>=20
>>>>>>>> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
>>>>>>>> index 591187b6352e..3e4c50b9fd33 100644
>>>>>>>> --- a/kernel/rcu/tree.c
>>>>>>>> +++ b/kernel/rcu/tree.c
>>>>>>>> @@ -2935,6 +2935,7 @@ struct kfree_rcu_cpu_work {
>>>>>>>>=20
>>>>>>>> /**
>>>>>>>>  * struct kfree_rcu_cpu - batch up kfree_rcu() requests for RCU gra=
ce period
>>>>>>>> + * @rdp: The rdp of the CPU that this kfree_rcu corresponds to.
>>>>>>>>  * @head: List of kfree_rcu() objects not yet waiting for a grace p=
eriod
>>>>>>>>  * @bkvhead: Bulk-List of kvfree_rcu() objects not yet waiting for a=
 grace period
>>>>>>>>  * @krw_arr: Array of batches of kfree_rcu() objects waiting for a g=
race period
>>>>>>>> @@ -2964,6 +2965,8 @@ struct kfree_rcu_cpu {
>>>>>>>>      struct kfree_rcu_cpu_work krw_arr[KFREE_N_BATCHES];
>>>>>>>>      raw_spinlock_t lock;
>>>>>>>>      struct delayed_work monitor_work;
>>>>>>>> +     struct rcu_data *rdp;
>>>>>>>> +     unsigned long last_gp_seq;
>>>>>>>>      bool initialized;
>>>>>>>>      int count;
>>>>>>>>=20
>>>>>>>> @@ -3167,6 +3170,7 @@ schedule_delayed_monitor_work(struct kfree_rc=
u_cpu *krcp)
>>>>>>>>                      mod_delayed_work(system_wq, &krcp->monitor_wor=
k, delay);
>>>>>>>>              return;
>>>>>>>>      }
>>>>>>>> +     krcp->last_gp_seq =3D krcp->rdp->gp_seq;
>>>>>>>>      queue_delayed_work(system_wq, &krcp->monitor_work, delay);
>>>>>>>> }
>>>>>>>>=20
>>>>>>>> @@ -3217,7 +3221,17 @@ static void kfree_rcu_monitor(struct work_st=
ruct *work)
>>>>>>>>                      // be that the work is in the pending state wh=
en
>>>>>>>>                      // channels have been detached following by ea=
ch
>>>>>>>>                      // other.
>>>>>>>> -                     queue_rcu_work(system_wq, &krwp->rcu_work);
>>>>>>>> +                     //
>>>>>>>> +                     // NOTE about gp_seq wrap: In case of gp_seq o=
verflow,
>>>>>>>> +                     // it is possible for rdp->gp_seq to be less t=
han
>>>>>>>> +                     // krcp->last_gp_seq even though a GP might b=
e over. In
>>>>>>>> +                     // this rare case, we would just have one ext=
ra GP.
>>>>>>>> +                     if (krcp->last_gp_seq &&
>>>>>>>>=20
>>>>>>> This check can be eliminated i think. A kfree_rcu_cpu is defined as
>>>>>>> static so by default the last_gp_set is set to zero.
>>>>>>=20
>>>>>> Ack.
>>>>>>=20
>>>>>>>> @@ -4802,6 +4816,8 @@ static void __init kfree_rcu_batch_init(void)=

>>>>>>>>      for_each_possible_cpu(cpu) {
>>>>>>>>              struct kfree_rcu_cpu *krcp =3D per_cpu_ptr(&krc, cpu);=

>>>>>>>>=20
>>>>>>>> +             krcp->rdp =3D per_cpu_ptr(&rcu_data, cpu);
>>>>>>>> +             krcp->last_gp_seq =3D 0;
>>>>>>>>=20
>>>>>>> Yep. This one can be just dropped.
>>>>>>>=20
>>>>>>> But all the rest looks good :) I will give it a try from test point o=
f
>>>>>>> view. It is interested from the memory footprint point of view.
>>>>>>=20
>>>>>> Ack. Thanks. Even though we should not sample rdp->gp_seq, I think it=

>>>>>> is still worth a test.
>>>>>=20
>>>>> Just for completeness, the main purpose of rdp->gp_seq is to reject
>>>>> quiescent states that were seen during already-completed grace periods=
.
>>>>>=20
>>>> So it means that instead of gp_seq reading we should take a snaphshot
>>>> of the current state:
>>>>=20
>>>> snp =3D get_state_synchronize_rcu();
>>>>=20
>>>> and later on do a:
>>>>=20
>>>> cond_synchronize_rcu(snp);
>>>>=20
>>>> to wait for a GP.
>>>=20
>>> This can't be called from the timer IRQ handler though (monitor)
>>>=20
>>>> Or if the poll_state_synchronize_rcu(oldstate)) !=3D 0
>>>> queue_rcu_work().
>>>=20
>>> But something like this should be possible (maybe)
>>>=20
>>>> Sorry for a description using the RCU API functions name :)
>>>=20
>>> I believe you will have to call rcu_poll_gp_seq_start() as well if you
>>> are using polled API. I am planning to look at this properly more,
>>> soon. Right now I am going to write up the rcutop doc and share with
>>> you guys.
>>>=20
>>> (Maybe RCU polling is the right thing to do as we reuse all the infra
>>> and any corner case it is handling)
>>>=20
>> OK. This is in my todo list also. Since we have discussed it let's move
>> it forward.
>>=20
>> Below what i have came up with to switch for polling APIs:
>>=20
>>> =46rom 799ce1653d159ef3d35f34a284f738c2c267c75f Mon Sep 17 00:00:00 2001=

>> From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
>> Date: Wed, 2 Nov 2022 19:26:27 +0100
>> Subject: [PATCH 1/1] rcu: kvfree_rcu: Reduce a memory footptint by using
>> polling APIs
>>=20
>> Total time taken by all kfree'ers: 6564718459 ns, loops: 10000, batches: 1=
110, memory footprint: 5057MB
>> Total time taken by all kfree'ers: 8431051895 ns, loops: 10000, batches: 1=
109, memory footprint: 2749MB
>> Total time taken by all kfree'ers: 9477830789 ns, loops: 10000, batches: 1=
158, memory footprint: 2934MB
>> Total time taken by all kfree'ers: 9950211144 ns, loops: 10000, batches: 9=
81, memory footprint: 2704MB
>>=20
>> with a patch:
>>=20
>> Total time taken by all kfree'ers: 7712110118 ns, loops: 10000, batches: 1=
660, memory footprint: 91MB
>> Total time taken by all kfree'ers: 7002403664 ns, loops: 10000, batches: 1=
482, memory footprint: 86MB
>> Total time taken by all kfree'ers: 7842282319 ns, loops: 10000, batches: 1=
738, memory footprint: 86MB
>> Total time taken by all kfree'ers: 7230161977 ns, loops: 10000, batches: 1=
542, memory footprint: 72MB
>>=20
>> Tested with NOCB option, all offloading CPUs:
>>=20
>> kvm.sh --memory 10G --torture rcuscale --allcpus --duration 1 \
>>  --kconfig CONFIG_NR_CPUS=3D64 \
>>  --kconfig CONFIG_RCU_NOCB_CPU=3Dy \
>>  --kconfig CONFIG_RCU_NOCB_CPU_DEFAULT_ALL=3Dy \
>>  --bootargs "rcuscale.kfree_rcu_test=3D1 rcuscale.kfree_nthreads=3D16 \
>>  rcuscale.holdoff=3D20 rcuscale.kfree_loops=3D10000 torture.disable_onoff=
_at_boot" --trust-make
>>=20
>> According to data there is a big gain in memory footprint with a patch.
>> It is because of call_rcu() and call_rcu_flush() take more effort and
>> time to queue a callback and then wait for a gp.
>>=20
>> With polling API:
>>  a) we do not need to queue any callback;
>>  b) we might not even need wait for a GP completion.
>>=20
>> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
>> ---
>> kernel/rcu/tree.c | 21 ++++++++++++++++-----
>> 1 file changed, 16 insertions(+), 5 deletions(-)
>>=20
>> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
>> index 76973d716921..17c3d6f2c55b 100644
>> --- a/kernel/rcu/tree.c
>> +++ b/kernel/rcu/tree.c
>> @@ -2919,18 +2919,20 @@ struct kvfree_rcu_bulk_data {
>>    ((PAGE_SIZE - sizeof(struct kvfree_rcu_bulk_data)) / sizeof(void *))
>>=20
>> /**
>> + * @rcu_work: A work to reclaim a memory after a grace period
>>  * struct kfree_rcu_cpu_work - single batch of kfree_rcu() requests
>> - * @rcu_work: Let queue_rcu_work() invoke workqueue handler after grace p=
eriod
>>  * @head_free: List of kfree_rcu() objects waiting for a grace period
>>  * @bkvhead_free: Bulk-List of kvfree_rcu() objects waiting for a grace p=
eriod
>>  * @krcp: Pointer to @kfree_rcu_cpu structure
>> + * @gp_snap: A snapshot of current grace period
>>  */
>>=20
>> struct kfree_rcu_cpu_work {
>> -    struct rcu_work rcu_work;
>> +    struct work_struct rcu_work;
>>    struct rcu_head *head_free;
>>    struct kvfree_rcu_bulk_data *bkvhead_free[FREE_N_CHANNELS];
>>    struct kfree_rcu_cpu *krcp;
>> +    unsigned long gp_snap;
>> };
>>=20
>> /**
>> @@ -3066,10 +3068,12 @@ static void kfree_rcu_work(struct work_struct *wo=
rk)
>>    struct kfree_rcu_cpu_work *krwp;
>>    int i, j;
>>=20
>> -    krwp =3D container_of(to_rcu_work(work),
>> +    krwp =3D container_of(work,
>>                struct kfree_rcu_cpu_work, rcu_work);
>>    krcp =3D krwp->krcp;
>>=20
>> +    cond_synchronize_rcu(krwp->gp_snap);
>=20
> Might this provoke OOMs in case of callback flooding?
>=20
> An alternative might be something like this:
>=20
>    if (!poll_state_synchronize_rcu(krwp->gp_snap)) {
>        queue_rcu_work(system_wq, &krwp->rcu_work);
>        return;
>    }
>=20
> Either way gets you a non-lazy callback in the case where a grace
> period has not yet elapsed.
> Or am I missing something that prevents OOMs here?

The memory consumptions appears to be much less in his testing with the onsl=
aught of kfree, which makes OOM probably less likely.

Though, was your reasoning that in case of a grace period not elapsing, we n=
eed a non lazy callback queued, so as to make the reclaim happen sooner?

If so, the cond_synchronize_rcu() should already be conditionally queueing n=
on-lazy CB since we don=E2=80=99t make synchronous users wait for seconds. O=
r did I miss something?

Thanks,

- Joel

>=20
>                            Thanx, Paul
>=20
>> +
>>    raw_spin_lock_irqsave(&krcp->lock, flags);
>>    // Channels 1 and 2.
>>    for (i =3D 0; i < FREE_N_CHANNELS; i++) {
>> @@ -3194,6 +3198,13 @@ static void kfree_rcu_monitor(struct work_struct *=
work)
>>        if ((krcp->bkvhead[0] && !krwp->bkvhead_free[0]) ||
>>            (krcp->bkvhead[1] && !krwp->bkvhead_free[1]) ||
>>                (krcp->head && !krwp->head_free)) {
>> +            /*
>> +             * Take a snapshot for this krwp. Please note no
>> +             * more any objects can be added to this krwp free
>> +             * channels.
>> +             */
>> +            krwp->gp_snap =3D get_state_synchronize_rcu();
>> +
>>            // Channel 1 corresponds to the SLAB-pointer bulk path.
>>            // Channel 2 corresponds to vmalloc-pointer bulk path.
>>            for (j =3D 0; j < FREE_N_CHANNELS; j++) {
>> @@ -3217,7 +3228,7 @@ static void kfree_rcu_monitor(struct work_struct *w=
ork)
>>            // be that the work is in the pending state when
>>            // channels have been detached following by each
>>            // other.
>> -            queue_rcu_work(system_wq, &krwp->rcu_work);
>> +            queue_work(system_wq, &krwp->rcu_work);
>>        }
>>    }
>>=20
>> @@ -4808,7 +4819,7 @@ static void __init kfree_rcu_batch_init(void)
>>        struct kfree_rcu_cpu *krcp =3D per_cpu_ptr(&krc, cpu);
>>=20
>>        for (i =3D 0; i < KFREE_N_BATCHES; i++) {
>> -            INIT_RCU_WORK(&krcp->krw_arr[i].rcu_work, kfree_rcu_work);
>> +            INIT_WORK(&krcp->krw_arr[i].rcu_work, kfree_rcu_work);
>>            krcp->krw_arr[i].krcp =3D krcp;
>>        }
>>=20
>> --=20
>> 2.30.2
>>=20
>> --
>> Uladzislau Rezki
