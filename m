Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB4DE639695
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 15:43:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbiKZOnG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Nov 2022 09:43:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbiKZOnC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Nov 2022 09:43:02 -0500
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54C1CE007
        for <linux-kernel@vger.kernel.org>; Sat, 26 Nov 2022 06:42:59 -0800 (PST)
Received: by mail-qv1-xf31.google.com with SMTP id a17so2752861qvt.9
        for <linux-kernel@vger.kernel.org>; Sat, 26 Nov 2022 06:42:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nQhwElD6HyjdOaWbP69t5Eif9DF7qh6agcOZWVGnnXQ=;
        b=RG0e9GACvhxDMvcR8NUKJ/kSE1TeXzvh4lS6Oyq/5iAvCRyfXRIoFBL/4V/8oOt/Tv
         V3R6VA/kmWNpTuGmd03twm4ppolFss3E+wRezPh/gQsjlrVLBT21snQiSwrrY8KjfR3T
         sbh0sKtMCPyCCx98gFtahTT9mV8TqX6ZyuOys=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nQhwElD6HyjdOaWbP69t5Eif9DF7qh6agcOZWVGnnXQ=;
        b=sPG3jy8TGZjYDrQQJS/NA9IDm8NHDKBlPYqVZ4Stsp9vD2cl6HUvO0FGZP2wErUMYR
         6aapsUdRrly1M175aIEZYF6AGYc0cmuCH3Keq9CjID496sN/3jYO+z2igh9pYueYE4SE
         92rnBd1oZLsWXCgX4+uVfFx387sDmncsPgdusENZBYe/RCWk+NAM64rcWJLP/3IdfDXO
         s7Ka3w3daJHHyV9IJ0KzFkUpxQGfC2epapUduCKU6FO3idiWVsncI79eR7lHbNNN8pnk
         3REzusQBmjkv6BmHTxScFaFuV4qaYhLdBuCNFckqxyhV0Qu1Zk6MqFydwTrBmVydMvO8
         DrlA==
X-Gm-Message-State: ANoB5pnMEVFrCo8coWLfRYhJ178HeQmRgw6++4pzruobpyawrXX00lCs
        KE5Cc2+IgGqtxNuMNTrK6QL3SowGH/qEeQ==
X-Google-Smtp-Source: AA0mqf7N9VYhNM+QHnaJ2zf6+fKMQEnAkxPWuvThoSZGJ183go/Nuh3NiCbyIm5PaAJU6IbaAsKRgA==
X-Received: by 2002:a05:6214:3984:b0:4bb:e31f:a56e with SMTP id ny4-20020a056214398400b004bbe31fa56emr24205391qvb.76.1669473778664;
        Sat, 26 Nov 2022 06:42:58 -0800 (PST)
Received: from smtpclient.apple (c-73-148-104-166.hsd1.va.comcast.net. [73.148.104.166])
        by smtp.gmail.com with ESMTPSA id j10-20020ac84c8a000000b003a5fb681ae7sm3795432qtv.3.2022.11.26.06.42.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Nov 2022 06:42:58 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Joel Fernandes <joel@joelfernandes.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] rcu-tasks: Make rude RCU-Tasks work well with CPU hotplug
Date:   Sat, 26 Nov 2022 09:42:57 -0500
Message-Id: <CE3515A9-2226-4001-BEDA-9DD6CB2ACF09@joelfernandes.org>
References: <PH0PR11MB58804E24C3C14371F4397D68DA119@PH0PR11MB5880.namprd11.prod.outlook.com>
Cc:     Neeraj Upadhyay <quic_neeraju@quicinc.com>, paulmck@kernel.org,
        frederic@kernel.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <PH0PR11MB58804E24C3C14371F4397D68DA119@PH0PR11MB5880.namprd11.prod.outlook.com>
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



> On Nov 26, 2022, at 12:52 AM, Zhang, Qiang1 <qiang1.zhang@intel.com> wrote=
:
>=20
> =EF=BB=BF
>>=20
>> Hi Zqiang,
>>=20
>> On 11/25/2022 9:24 PM, Zqiang wrote:
>> Currently, for the case of num_online_cpus() <=3D 1, return directly,
>> indicates the end of current grace period and then release old data.
>> it's not accurate, for SMP system, when num_online_cpus() is equal
>> one, maybe another cpu that in offline process(after invoke
>> __cpu_disable()) is still in the rude RCU-Tasks critical section
>> holding the old data, this lead to memory corruption.
>>=20
>>=20
>>=20
>> Was this race seen in your testing? For the outgoing CPU, once that
>> CPU marks itself offline (and decrements __num_online_cpus), do we
>> have tracing active on that CPU, and synchronize_rcu_tasks_rude()
>> not waiting for it could potentially lead to memory corruption?
>=20
> Hi Neeraj
>=20
> Indeed, I didn't see race in the actual production environment,
> Maybe my commit information description is not accurate enough,
> like the scene I described with joel.
>=20
> If in cpuhp_invoke_callback, some callback is in rude rcu-tasks read ctric=
al section,
> and still holding old data, but in this time, synchronize_rcu_tasks_rude()=
 not waiting,
> and release old data.
>=20
> Suppose the system has two cpus
>=20
>    CPU0                                                                   =
  CPU1
>                         cpu_stopper_thread
>                                                                           =
       take_cpu_down
>                            __cpu_disable
>                            dec __num_online_cpus=20
> rcu_tasks_rude_wait_gp                                      cpuhp_invoke_c=
allback =20
>    num_online_cpus() =3D=3D 1
>        return;
>=20
> when __num_online_cpus =3D=3D 1, the CPU1 not completely offline.

Agreed with yours and Neeraj assessment.

>>=20
>> As per my understanding, given that outgoing/incoming CPU=20
>> decrements/increments the __num_online_cpus value, and num_online_cpus()
>> is a plain read, problem could happen when the incoming CPU updates the
>> __num_online_cpus  value, however, rcu_tasks_rude_wait_gp()'s=20
>> num_online_cpus() call didn't observe the increment. So,=20
>> cpus_read_lock/unlock() seems to be required to handle this case.
>=20
> Yes, the same problem will be encountered when going online, due to
> access  __num_online_cpus  that is not protected by cpus_read_lock/unlock(=
)=20
> in rcu_tasks_rude_wait_gp().
>=20
> Do I need to change the commit information to send v2?

I think so. If you could add the CPU sequence diagram you mentioned, that wo=
uld be great.

Also I suggest add more details of which specific parts of the hotplug proce=
ss (the ones in stop machine only) are susceptible to the issue. That is, on=
ly those hotplug callbacks that are in  stop machine which may have trampoli=
nes prematurely freed from another cpu, right?

Thanks!

  - Joel



>=20
> Thanks
> Zqiang
>=20
>>=20
>>=20
>> Thanks
>> Neeraj
>>=20
>> Therefore, this commit add cpus_read_lock/unlock() before executing
>> num_online_cpus().
>>=20
>> Signed-off-by: Zqiang <qiang1.zhang@intel.com>
>> ---
>>  kernel/rcu/tasks.h | 20 ++++++++++++++++++--
>>  1 file changed, 18 insertions(+), 2 deletions(-)
>>=20
>> diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
>> index 4a991311be9b..08e72c6462d8 100644
>> --- a/kernel/rcu/tasks.h
>> +++ b/kernel/rcu/tasks.h
>> @@ -1033,14 +1033,30 @@ static void rcu_tasks_be_rude(struct work_struct *=
work)
>>  {
>>  }
>>=20
>> +static DEFINE_PER_CPU(struct work_struct, rude_work);
>> +
>>  // Wait for one rude RCU-tasks grace period.
>>  static void rcu_tasks_rude_wait_gp(struct rcu_tasks *rtp)
>>  {
>> +    int cpu;
>> +    struct work_struct *work;
>> +
>> +    cpus_read_lock();
>>      if (num_online_cpus() <=3D 1)
>> -        return;    // Fastpath for only one CPU.
>> +        goto end;// Fastpath for only one CPU.
>>=20
>>      rtp->n_ipis +=3D cpumask_weight(cpu_online_mask) > -    schedule_on_=
each_cpu(rcu_tasks_be_rude);
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
>>  }
>>=20
>>  void call_rcu_tasks_rude(struct rcu_head *rhp, rcu_callback_t func);
