Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81DF46B0A01
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 14:54:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231861AbjCHNxt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 08:53:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231697AbjCHNxJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 08:53:09 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42A752E82A
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 05:53:07 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id v11so17685897plz.8
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 05:53:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1678283583;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7UAQRD5xDMDl5efcAdmHuAflyn+NPkuoZTTYDMUgB8s=;
        b=ki22F7TgI2MQZgePihLjwE5YSCWxd2rvt+pllNoMevXIca/gQ2b0Xepv4PdyuGQToE
         lP7cuAYFGTJZHL8wbTZkkSGfRNtBfDuEQnbSMdChDyi4+zqyxnqcrzi7EoPXGJY9Qyfp
         duxehLJvrLqD7BPRCnRnbh+/YruZKPAM4oS7w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678283583;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7UAQRD5xDMDl5efcAdmHuAflyn+NPkuoZTTYDMUgB8s=;
        b=zYULy3NcVn2K0dVJuPILZngUeekifqinK+Zk3pW+rYUev9rm+pfqvmxsCkYAISV+3E
         77P/Bq6QEsFjDfPJ7jhEFMleA1f89f5hkycRBe8AfYZwuJtqEzRF2FQTPtBOOJJKcz1I
         NF9wnPXdLsNMIAUubVi9PRIUWx7D01UADLMCxO4qKTifcu3QqAaFQAWiNXGXhDYJgbRW
         6+paZsq8n1pmwinkm4HGqmYrMm2fncPAR7wMfWP8dG3HZjVZzAcNPjOYpTCGSOLs6nEI
         EfMb7KJiU5JLL5XDZEve2S5/yEhL7wUZ/wUGG0MMB8SbEM9L58eXKOTXKjKiku+LroAu
         mZMQ==
X-Gm-Message-State: AO0yUKXMgaglYwMqjnokN00jvrdIj5V7570LyqlbyJLtHXfosILsx0uP
        C6KFJj8H5hCGdZXyynq7ueloUxmiSd4cFLCURS8=
X-Google-Smtp-Source: AK7set/8Ob0YrcwSnOsTfRsXCvNrgOTxxGqEkn3mGRnIQ7Oa1joXwsxdzgFIWxQp3Tb6ROO6WsEk7g==
X-Received: by 2002:a05:6a20:5481:b0:cc:c3f7:9178 with SMTP id i1-20020a056a20548100b000ccc3f79178mr22690275pzk.31.1678283582967;
        Wed, 08 Mar 2023 05:53:02 -0800 (PST)
Received: from smtpclient.apple ([2600:1010:b049:5d6c:a98c:abbd:1cd:6532])
        by smtp.gmail.com with ESMTPSA id h22-20020aa786d6000000b005e4c3e2022fsm9402979pfo.72.2023.03.08.05.53.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Mar 2023 05:53:02 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Joel Fernandes <joel@joelfernandes.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v3] rcu: Add a minimum time for marking boot as completed
Date:   Wed, 8 Mar 2023 05:52:50 -0800
Message-Id: <FF43EB74-026D-4863-8926-8DB40FED5930@joelfernandes.org>
References: <ZAdyGANbQhduAFTM@lothringen>
Cc:     linux-kernel@vger.kernel.org, Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-doc@vger.kernel.org, "Paul E. McKenney" <paulmck@kernel.org>,
        rcu@vger.kernel.org, urezki@gmail.com
In-Reply-To: <ZAdyGANbQhduAFTM@lothringen>
To:     Frederic Weisbecker <frederic@kernel.org>
X-Mailer: iPhone Mail (20B101)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MIME_QP_LONG_LINE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Mar 7, 2023, at 9:19 AM, Frederic Weisbecker <frederic@kernel.org> wrot=
e:
>=20
> =EF=BB=BFOn Tue, Mar 07, 2023 at 08:41:17AM -0500, Joel Fernandes wrote:
>>> On Tue, Mar 7, 2023 at 8:01=E2=80=AFAM Frederic Weisbecker <frederic@ker=
nel.org> wrote:
>>>=20
>>> On Fri, Mar 03, 2023 at 09:38:51PM +0000, Joel Fernandes (Google) wrote:=

>>>> On many systems, a great deal of boot (in userspace) happens after the
>>>> kernel thinks the boot has completed. It is difficult to determine if
>>>> the system has really booted from the kernel side. Some features like
>>>> lazy-RCU can risk slowing down boot time if, say, a callback has been
>>>> added that the boot synchronously depends on. Further expedited callbac=
ks
>>>> can get unexpedited way earlier than it should be, thus slowing down
>>>> boot (as shown in the data below).
>>>>=20
>>>> For these reasons, this commit adds a config option
>>>> 'CONFIG_RCU_BOOT_END_DELAY' and a boot parameter rcupdate.boot_end_dela=
y.
>>>> Userspace can also make RCU's view of the system as booted, by writing t=
he
>>>> time in milliseconds to: /sys/module/rcupdate/parameters/rcu_boot_end_d=
elay
>>>> Or even just writing a value of 0 to this sysfs node.
>>>> However, under no circumstance will the boot be allowed to end earlier
>>>> than just before init is launched.
>>>>=20
>>>> The default value of CONFIG_RCU_BOOT_END_DELAY is chosen as 15s. This
>>>> suites ChromeOS and also a PREEMPT_RT system below very well, which nee=
d
>>>> no config or parameter changes, and just a simple application of this p=
atch. A
>>>> system designer can also choose a specific value here to keep RCU from m=
arking
>>>> boot completion.  As noted earlier, RCU's perspective of the system as b=
ooted
>>>> will not be marker until at least rcu_boot_end_delay milliseconds have p=
assed
>>>> or an update is made via writing a small value (or 0) in milliseconds t=
o:
>>>> /sys/module/rcupdate/parameters/rcu_boot_end_delay.
>>>>=20
>>>> One side-effect of this patch is, there is a risk that a real-time work=
load
>>>> launched just after the kernel boots will suffer interruptions due to e=
xpedited
>>>> RCU, which previous ended just before init was launched. However, to mi=
tigate
>>>> such an issue (however unlikely), the user should either tune
>>>> CONFIG_RCU_BOOT_END_DELAY to a smaller value than 15 seconds or write a=
 value
>>>> of 0 to /sys/module/rcupdate/parameters/rcu_boot_end_delay, once usersp=
ace
>>>> boots, and before launching the real-time workload.
>>>>=20
>>>> Qiuxu also noted impressive boot-time improvements with earlier version=

>>>> of patch. An excerpt from the data he shared:
>>>>=20
>>>> 1) Testing environment:
>>>>    OS            : CentOS Stream 8 (non-RT OS)
>>>>    Kernel     : v6.2
>>>>    Machine : Intel Cascade Lake server (2 sockets, each with 44 logical=
 threads)
>>>>    Qemu  args  : -cpu host -enable-kvm, -smp 88,threads=3D2,sockets=3D2=
, =E2=80=A6
>>>>=20
>>>> 2) OS boot time definition:
>>>>    The time from the start of the kernel boot to the shell command line=

>>>>    prompt is shown from the console. [ Different people may have
>>>>    different OS boot time definitions. ]
>>>>=20
>>>> 3) Measurement method (very rough method):
>>>>    A timer in the kernel periodically prints the boot time every 100ms.=

>>>>    As soon as the shell command line prompt is shown from the console,
>>>>    we record the boot time printed by the timer, then the printed boot
>>>>    time is the OS boot time.
>>>>=20
>>>> 4) Measured OS boot time (in seconds)
>>>>   a) Measured 10 times w/o this patch:
>>>>        8.7s, 8.4s, 8.6s, 8.2s, 9.0s, 8.7s, 8.8s, 9.3s, 8.8s, 8.3s
>>>>        The average OS boot time was: ~8.7s
>>>>=20
>>>>   b) Measure 10 times w/ this patch:
>>>>        8.5s, 8.2s, 7.6s, 8.2s, 8.7s, 8.2s, 7.8s, 8.2s, 9.3s, 8.4s
>>>>        The average OS boot time was: ~8.3s.
>>>>=20
>>>> Tested-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
>>>> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
>>>=20
>>> I still don't really like that:
>>>=20
>>> 1) It feels like we are curing a symptom for which we don't know the cau=
se.
>>>   Which RCU write side caller is the source of this slow boot? Some trac=
epoints
>>>   reporting the wait duration within synchronize_rcu() calls between the=
 end of
>>>   the kernel boot and the end of userspace boot may be helpful.
>>=20
>> Just to clarify (and I feel we discussed this recently) -- there is no
>> callback I am aware of right now causing a slow boot. The reason for
>> doing this is we don't have such issues in the future; so it is a
>> protection. Note the repeated call outs to the scsi callback and also
>> the rcu_barrier() issue previously fixed. Further, we already see
>> slight improvements in boot times with disabling lazy during boot (its
>> not much but its there). Yes, we should fix issues instead of hiding
>> them - but we also would like to improve the user experience -- just
>> like we disable lazy and expedited during suspend.
>>=20
>> So what is the problem that you really have with this patch even with
>> data showing improvements? I actually wanted a mechanism like this
>> from the beginning and was trying to get Intel to write the patch, but
>> I ended up writing it.
>=20
> Let's put it another way: kernel boot is mostly code that won't execute
> again. User boot (or rather the kernel part of it) OTOH is code that is
> subject to be repeated again.
>=20
> A lot of the kernel boot code is __init code that will execute only once.
> And there it makes sense to force hurry and expedited because we may easil=
y
> miss something and after all this all happens only once, also there is no
> interference with userspace, etc...
>=20
> User boot OTOH use common kernel code: syscalls, signal, files, etc... And=
 that
> code will be called also after the boot.
>=20
> So if there is something slowing down user boot, there are some good chanc=
es
> that this thing slows down userspace in general.
>=20
> Therefore we need to know exactly what's going on because the problem may b=
e
> bigger than what you observe on boot.

Just to add to previous reply:

One thing to consider is that it is more of a performance improvement for bo=
oting in expedited mode to fallback to normal later, than a bug fix. Repeate=
d synchronize_rcu() can easily add 100s of milliseconds and to remedy that =E2=
=80=94 a conversion of the call from normal API to the expedited API will no=
t help.

What is needed is user mode to notify kernel or do some kind of timed fallba=
ck line I did here. Both of these approaches have their pros and cons (and s=
o IMO we should probably give an option to do both).

Thanks,

- Joel

>=20
>>=20
>>> 2) The kernel boot was already covered before this patch so this is abou=
t
>>>   userspace code calling into the kernel. Is that piece of code also cal=
led
>>>   after the boot? In that case are we missing a conversion from
>>>   synchronize_rcu() to synchronize_rcu_expedited() somewhere? Because th=
en
>>>   the problem is more general than just boot.
>>>=20
>>> This needs to be analyzed first and if it happens that the issue really
>>> needs to be fixed with telling the kernel that userspace has completed
>>> booting, eg: because the problem is not in a few callsites that need con=
version
>>> to expedited but instead in the accumulation of lots of calls that shoul=
d stay
>>> as is:
>>=20
>> There is no such callback I am aware off that needs such a conversion
>> and I don't think that will help give any guarantees because there is
>> no preventing someone from adding a callback that synchronously slows
>> boot. The approach here is to put a protection. However, I will do
>> some more investigations into what else may be slowing things as I do
>> hold a lot of weight for your words! :)
>=20
> Kernel boot is already handled and userspace boot can not add a new RCU ca=
llback.
>=20
>>=20
>>>=20
>>> 3) This arbitrary timeout looks dangerous to me as latency sensitive cod=
e
>>>   may run right after the boot. Either you choose a value that is too lo=
w
>>>   and you miss the optimization or the value is too high and you may bre=
ak
>>>   things.
>>=20
>> So someone is presenting a timing sensitive workload within 15 seconds
>> of boot? Please provide some evidence of that.
>=20
> I have no idea, there are billions of computers running out there, it's a d=
isaster...
>=20
>> The only evidence right now is on the plus side even for the RT system.
>=20
> Right it's improving the boot of an RT system, doesn't mean it's not break=
ing
> post boot of others.
>=20
>>=20
>>> 4) This should be fixed the way you did:
>>>   a) a kernel parameter like you did
>>>   b) The init process (systemd?) tells the kernel when it judges that us=
erspace
>>>      has completed booting.
>>>   c) Make these interfaces more generic, maybe that information will be u=
seful
>>>      outside RCU. For example the kernel parameter should be
>>>      "user_booted_reported" and the sysfs (should be sysctl?):
>>>      kernel.user_booted =3D 1
>>>   d) But yuck, this means we must know if the init process supports that=
...
>>>=20
>>> For these reasons, let's make sure we know exactly what is going on firs=
t.
>>=20
>> I can investigate this more and get back to you.
>>=20
>> One of the challenges is getting boot tracing working properly.
>> Systems do weird things like turning off tracing during boot and/or
>> clearing trace buffers.
>=20
> Just compare the average and total duration of all synchronize_rcu() calls=

> (before and after forcing expedited) between launching initand userspace b=
oot
> completion. Sure there will be noise but if a difference can be measured b=
efore
> and after your patch, then a difference might be measureable on tracing as=

> well... Well of course tracing can induce subtle things... But let's try a=
t
> least, we want to know what we are fixing here.
>=20
> Thanks.
>=20
