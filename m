Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 679CE6AB124
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Mar 2023 16:03:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbjCEPDb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Mar 2023 10:03:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjCEPD2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Mar 2023 10:03:28 -0500
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D921B13DEA
        for <linux-kernel@vger.kernel.org>; Sun,  5 Mar 2023 07:03:25 -0800 (PST)
Received: by mail-qv1-xf31.google.com with SMTP id ne1so5010470qvb.9
        for <linux-kernel@vger.kernel.org>; Sun, 05 Mar 2023 07:03:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1678028604;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v50ev4n9UQpdwMmK5/LeeLVgUufJdVBsxARKC22jKRI=;
        b=eTQTVmD4u6DpM0JhY99+UDNxoKmrE92JfldVLODG+F7rQYu0E4niUXIGiZMbONvf67
         0Sch3eWJwy8N38i1nhv1jWcMhqUJxvA04k8W9DBQbLkPs/9mqS+2sFD7pDojXQjers3G
         YLlyT1j0qNIMJ+nh9SUBB2Nqcnl5xcl0Z4kyA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678028604;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v50ev4n9UQpdwMmK5/LeeLVgUufJdVBsxARKC22jKRI=;
        b=MlmFpAZWrY6x2V1nAF7swMf0iDRbCyzOvvj+2OvKQUtAI6fgf9tqC4KmhqqRgzwBVM
         rOaO1edoqE9/MXPKnVjDxTmilMW+NEBaO8T0ZlNUOCSADPoTlNDVxirpMBBzmJIiPbE/
         /VE0lj6cMzJHIJFfAjEhy0hw9Zq+9hsMflQfLEaNlxO5lknDC7DhWen2jNWZPcdDuuFN
         Fh4589as0wt8l9Wr581NHX/aT8xdtlH8pD8VY1lfnByiodtzMqGUEJwAYWVeuHPqkmGp
         KR0Q3V2D1EF3GJO6tIhYG2B61b2PCoSG2l7NpOLg3LOtp0IoabQkBcr6odlyLseL5i/K
         LSEQ==
X-Gm-Message-State: AO0yUKUg1OTYmBdX//7Ri0XWbcu6aealBgdBJFPCgAUgypzfH03KKONt
        rWrUOaprXRh5uIMFs4bqRwvJ5fXzvHnrrDzZAcU=
X-Google-Smtp-Source: AK7set8v953Yh8JpOrd20UDD2OoJdJPBS5ueZ8ouAH8tZl7wYuTmsMeKDDplsf5bWqOTLQk5PEyqlw==
X-Received: by 2002:ad4:5ece:0:b0:539:b68e:3444 with SMTP id jm14-20020ad45ece000000b00539b68e3444mr15464538qvb.27.1678028604216;
        Sun, 05 Mar 2023 07:03:24 -0800 (PST)
Received: from smtpclient.apple ([2600:1005:b003:394d:acb0:58:f50c:218b])
        by smtp.gmail.com with ESMTPSA id d64-20020a37b443000000b0073b587194d0sm5603351qkf.104.2023.03.05.07.03.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Mar 2023 07:03:23 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Joel Fernandes <joel@joelfernandes.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v3] rcu: Add a minimum time for marking boot as completed
Date:   Sun, 5 Mar 2023 10:03:12 -0500
Message-Id: <E5E8224E-B5C4-4796-8ACA-F2E26BEA1374@joelfernandes.org>
References: <ZAR/VdMNBwdrWA/5@pc636>
Cc:     linux-kernel@vger.kernel.org, Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-doc@vger.kernel.org, "Paul E. McKenney" <paulmck@kernel.org>,
        rcu@vger.kernel.org
In-Reply-To: <ZAR/VdMNBwdrWA/5@pc636>
To:     Uladzislau Rezki <urezki@gmail.com>
X-Mailer: iPhone Mail (20B101)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MIME_QP_LONG_LINE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Mar 5, 2023, at 6:39 AM, Uladzislau Rezki <urezki@gmail.com> wrote:
>=20
> =EF=BB=BFOn Fri, Mar 03, 2023 at 09:38:51PM +0000, Joel Fernandes (Google)=
 wrote:
>> On many systems, a great deal of boot (in userspace) happens after the
>> kernel thinks the boot has completed. It is difficult to determine if
>> the system has really booted from the kernel side. Some features like
>> lazy-RCU can risk slowing down boot time if, say, a callback has been
>> added that the boot synchronously depends on. Further expedited callbacks=

>> can get unexpedited way earlier than it should be, thus slowing down
>> boot (as shown in the data below).
>>=20
>> For these reasons, this commit adds a config option
>> 'CONFIG_RCU_BOOT_END_DELAY' and a boot parameter rcupdate.boot_end_delay.=

>> Userspace can also make RCU's view of the system as booted, by writing th=
e
>> time in milliseconds to: /sys/module/rcupdate/parameters/rcu_boot_end_del=
ay
>> Or even just writing a value of 0 to this sysfs node.
>> However, under no circumstance will the boot be allowed to end earlier
>> than just before init is launched.
>>=20
>> The default value of CONFIG_RCU_BOOT_END_DELAY is chosen as 15s. This
>> suites ChromeOS and also a PREEMPT_RT system below very well, which need
>> no config or parameter changes, and just a simple application of this pat=
ch. A
>> system designer can also choose a specific value here to keep RCU from ma=
rking
>> boot completion.  As noted earlier, RCU's perspective of the system as bo=
oted
>> will not be marker until at least rcu_boot_end_delay milliseconds have pa=
ssed
>> or an update is made via writing a small value (or 0) in milliseconds to:=

>> /sys/module/rcupdate/parameters/rcu_boot_end_delay.
>>=20
>> One side-effect of this patch is, there is a risk that a real-time worklo=
ad
>> launched just after the kernel boots will suffer interruptions due to exp=
edited
>> RCU, which previous ended just before init was launched. However, to miti=
gate
>> such an issue (however unlikely), the user should either tune
>> CONFIG_RCU_BOOT_END_DELAY to a smaller value than 15 seconds or write a v=
alue
>> of 0 to /sys/module/rcupdate/parameters/rcu_boot_end_delay, once userspac=
e
>> boots, and before launching the real-time workload.
>>=20
>> Qiuxu also noted impressive boot-time improvements with earlier version
>> of patch. An excerpt from the data he shared:
>>=20
>> 1) Testing environment:
>>    OS            : CentOS Stream 8 (non-RT OS)
>>    Kernel     : v6.2
>>    Machine : Intel Cascade Lake server (2 sockets, each with 44 logical t=
hreads)
>>    Qemu  args  : -cpu host -enable-kvm, -smp 88,threads=3D2,sockets=3D2, =E2=
=80=A6
>>=20
>> 2) OS boot time definition:
>>    The time from the start of the kernel boot to the shell command line
>>    prompt is shown from the console. [ Different people may have
>>    different OS boot time definitions. ]
>>=20
>> 3) Measurement method (very rough method):
>>    A timer in the kernel periodically prints the boot time every 100ms.
>>    As soon as the shell command line prompt is shown from the console,
>>    we record the boot time printed by the timer, then the printed boot
>>    time is the OS boot time.
>>=20
>> 4) Measured OS boot time (in seconds)
>>   a) Measured 10 times w/o this patch:
>>        8.7s, 8.4s, 8.6s, 8.2s, 9.0s, 8.7s, 8.8s, 9.3s, 8.8s, 8.3s
>>        The average OS boot time was: ~8.7s
>>=20
>>   b) Measure 10 times w/ this patch:
>>        8.5s, 8.2s, 7.6s, 8.2s, 8.7s, 8.2s, 7.8s, 8.2s, 9.3s, 8.4s
>>        The average OS boot time was: ~8.3s.
>>=20
>> Tested-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
>> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
>> ---
>> v1->v2:
>>    Update some comments and description.
>> v2->v3:
>>        Add sysfs param, and update with Test data.
>>=20
>> .../admin-guide/kernel-parameters.txt         | 12 ++++
>> cc_list                                       |  8 +++
>> kernel/rcu/Kconfig                            | 19 ++++++
>> kernel/rcu/update.c                           | 68 ++++++++++++++++++-
>> 4 files changed, 106 insertions(+), 1 deletion(-)
>> create mode 100644 cc_list
>>=20
>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentat=
ion/admin-guide/kernel-parameters.txt
>> index 2429b5e3184b..611de90d9c13 100644
>> --- a/Documentation/admin-guide/kernel-parameters.txt
>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>> @@ -5085,6 +5085,18 @@
>>    rcutorture.verbose=3D [KNL]
>>            Enable additional printk() statements.
>>=20
>> +    rcupdate.rcu_boot_end_delay=3D [KNL]
>> +            Minimum time in milliseconds that must elapse
>> +            before the boot sequence can be marked complete
>> +            from RCU's perspective, after which RCU's behavior
>> +            becomes more relaxed. The default value is also
>> +            configurable via CONFIG_RCU_BOOT_END_DELAY.
>> +            Userspace can also mark the boot as completed
>> +            sooner by writing the time in milliseconds, say once
>> +            userspace considers the system as booted, to:
>> +            /sys/module/rcupdate/parameters/rcu_boot_end_delay
>> +            Or even just writing a value of 0 to this sysfs node.
>> +
>>    rcupdate.rcu_cpu_stall_ftrace_dump=3D [KNL]
>>            Dump ftrace buffer after reporting RCU CPU
>>            stall warning.
>> diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
>> index 9071182b1284..4b5ffa36cbaf 100644
>> --- a/kernel/rcu/Kconfig
>> +++ b/kernel/rcu/Kconfig
>> @@ -217,6 +217,25 @@ config RCU_BOOST_DELAY
>>=20
>>      Accept the default if unsure.
>>=20
>> +config RCU_BOOT_END_DELAY
>> +    int "Minimum time before RCU may consider in-kernel boot as complete=
d"
>> +    range 0 120000
>> +    default 15000
>> +    help
>> +      Default value of the minimum time in milliseconds that must elapse=

>> +      before the boot sequence can be marked complete from RCU's perspec=
tive,
>> +      after which RCU's behavior becomes more relaxed.
>> +      Userspace can also mark the boot as completed sooner than this def=
ault
>> +      by writing the time in milliseconds, say once userspace considers
>> +      the system as booted, to: /sys/module/rcupdate/parameters/rcu_boot=
_end_delay.
>> +      Or even just writing a value of 0 to this sysfs node.
>> +
>> +      The actual delay for RCU's view of the system to be marked as boot=
ed can be
>> +      higher than this value if the kernel takes a long time to initiali=
ze but it
>> +      will never be smaller than this value.
>> +
>> +      Accept the default if unsure.
>> +
>> config RCU_EXP_KTHREAD
>>    bool "Perform RCU expedited work in a real-time kthread"
>>    depends on RCU_BOOST && RCU_EXPERT
>> diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
>> index 19bf6fa3ee6a..93138c92136e 100644
>> --- a/kernel/rcu/update.c
>> +++ b/kernel/rcu/update.c
>> @@ -224,18 +224,84 @@ void rcu_unexpedite_gp(void)
>> }
>> EXPORT_SYMBOL_GPL(rcu_unexpedite_gp);
>>=20
>> +/*
>> + * Minimum time in milliseconds until RCU can consider in-kernel boot as=

>> + * completed.  This can also be tuned at runtime to end the boot earlier=
, by
>> + * userspace init code writing the time in milliseconds (even 0) to:
>> + * /sys/module/rcupdate/parameters/rcu_boot_end_delay
>> + */
>> +static int rcu_boot_end_delay =3D CONFIG_RCU_BOOT_END_DELAY;
>> +
>> static bool rcu_boot_ended __read_mostly;
>> +static bool rcu_boot_end_called __read_mostly;
>> +static DEFINE_MUTEX(rcu_boot_end_lock);
>> +
>> +static int param_set_rcu_boot_end(const char *val, const struct kernel_p=
aram *kp)
>> +{
>> +    uint end_ms;
>> +    int ret =3D kstrtouint(val, 0, &end_ms);
>> +
>> +    if (ret)
>> +        return ret;
>> +    WRITE_ONCE(*(uint *)kp->arg, end_ms);
>> +
>> +    /*
>> +     * rcu_end_inkernel_boot() should be called at least once during ini=
t
>> +     * before we can allow param changes to end the boot.
>> +     */
>> +    mutex_lock(&rcu_boot_end_lock);
>> +    rcu_boot_end_delay =3D end_ms;
>> +    if (!rcu_boot_ended && rcu_boot_end_called) {
>> +        mutex_unlock(&rcu_boot_end_lock);
>> +        rcu_end_inkernel_boot();
>> +    }
>> +    mutex_unlock(&rcu_boot_end_lock);
>> +    return ret;
>> +}
>> +
>> +static const struct kernel_param_ops rcu_boot_end_ops =3D {
>> +    .set =3D param_set_rcu_boot_end,
>> +    .get =3D param_get_uint,
>> +};
>> +module_param_cb(rcu_boot_end_delay, &rcu_boot_end_ops, &rcu_boot_end_del=
ay, 0644);
>>=20
>> /*
>> - * Inform RCU of the end of the in-kernel boot sequence.
>> + * Inform RCU of the end of the in-kernel boot sequence. The boot sequen=
ce will
>> + * not be marked ended until at least rcu_boot_end_delay milliseconds ha=
ve passed.
>>  */
>> +void rcu_end_inkernel_boot(void);
>> +static void rcu_boot_end_work_fn(struct work_struct *work)
>> +{
>> +    rcu_end_inkernel_boot();
>> +}
>> +static DECLARE_DELAYED_WORK(rcu_boot_end_work, rcu_boot_end_work_fn);
>> +
>> void rcu_end_inkernel_boot(void)
>> {
>> +    mutex_lock(&rcu_boot_end_lock);
>> +    rcu_boot_end_called =3D true;
>> +
>> +    if (rcu_boot_ended)
>> +        return;
>> +
>> +    if (rcu_boot_end_delay) {
>> +        u64 boot_ms =3D div_u64(ktime_get_boot_fast_ns(), 1000000UL);
>> +
>> +        if (boot_ms < rcu_boot_end_delay) {
>> +            schedule_delayed_work(&rcu_boot_end_work,
>> +                    rcu_boot_end_delay - boot_ms);
> <snip>
> urezki@pc638:~/data/raid0/coding/linux-rcu.git$ git diff
> diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
> index 93138c92136e..93f426f0f4ec 100644
> --- a/kernel/rcu/update.c
> +++ b/kernel/rcu/update.c
> @@ -289,7 +289,7 @@ void rcu_end_inkernel_boot(void)
>=20
>                if (boot_ms < rcu_boot_end_delay) {
>                        schedule_delayed_work(&rcu_boot_end_work,
> -                                       rcu_boot_end_delay - boot_ms);
> +                               msecs_to_jiffies(rcu_boot_end_delay - boot=
_ms));
>                        mutex_unlock(&rcu_boot_end_lock);
>                        return;
>                }
> urezki@pc638:~/data/raid0/coding/linux-rcu.git$
> <snip>
>=20
> I think you need to apply above patch. I am not sure maybe Paul
> has already mentioned about it. But just in case.

Ah, the reason my testing did not catch it is because for HZ=3D1000, msecs
and jiffies are the same.

Great eyes and thank you Vlad, I=E2=80=99ll make the fix and repost it.

 - Joel

>=20
> --
> Uladzislau Rezki
