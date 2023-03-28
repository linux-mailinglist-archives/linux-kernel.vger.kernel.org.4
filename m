Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B16C6CB423
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 04:30:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbjC1Caq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 22:30:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbjC1Can (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 22:30:43 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A3AD30ED
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 19:30:08 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id g9so8286832qvt.8
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 19:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1679970583;
        h=to:references:message-id:date:cc:in-reply-to:from:mime-version
         :subject:content-transfer-encoding:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pWz6d1QehWZ2JoCvpbDcTQFIKEH+s3VBG9kI0UG6rOM=;
        b=Mh2Pg+vnSUCd/9ByY5vk8n7ODXG6gL+h3nDPbFBtMK4pOAoKg5V74LbuB/KmZamkzk
         pzxNrePZxr1qCVPEi6bzVbSFtUKZihmAIgCzVI1CYiQi5V09x/WAV/4yLnXK95eg/4xi
         AfG5ttrBmbNG1kFJSX96AFGG9hzDC9FoZ6MAc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679970583;
        h=to:references:message-id:date:cc:in-reply-to:from:mime-version
         :subject:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pWz6d1QehWZ2JoCvpbDcTQFIKEH+s3VBG9kI0UG6rOM=;
        b=D/xJeVBBzkCY2rrKoIMyjdb+QKr+zUg9B2oQHOyZFjBED7LKK5MZm73ajdfJlpIRKe
         E2FUu/Rv/ZAr6EAi3pnN27xnUx79j4ghUXBybJ8n4hd8XUX0qGiUpJGHeDkNQeGh4j43
         hnlq1FmNtJja8cgDu9yLMvG8t/ME11nK7q80y0jpbjqF0/Ms48GLYddprmaSx4ihlqnE
         JKiJJpQDYv7vqTGlgAtrefcDMAy/WCojS5CYS1QgydTNQax8kf4qUkk5fnXMDKpfK0YL
         VM47taLPTQccMBHUbKMORHkR2OU3uJBE3ksk3gDlnsF/NBRa1eWnAxeuKk2ZqGAdEPBa
         GNVw==
X-Gm-Message-State: AAQBX9fhCsCGDwVeujH/v4r3xZB2FqwuJ2WoN0BujZhadjMqSINK4Jhj
        QUh2f9SMgRiQJg9oo4pJr5ZJVA==
X-Google-Smtp-Source: AKy350a6S6hlmwesUGVXB/PIFKOPE2Rczk0rpvXfdRbyfkgknQSS2QzRMif8jdc6je8Ks9TZO4b7PQ==
X-Received: by 2002:a05:6214:20e8:b0:571:13c:6806 with SMTP id 8-20020a05621420e800b00571013c6806mr22424370qvk.33.1679970583479;
        Mon, 27 Mar 2023 19:29:43 -0700 (PDT)
Received: from smtpclient.apple ([2600:1003:b130:c6c6:6401:1533:c2de:a27d])
        by smtp.gmail.com with ESMTPSA id x14-20020a0cfe0e000000b005dd8b9345e3sm3423380qvr.123.2023.03.27.19.29.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Mar 2023 19:29:42 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/1] Reduce synchronize_rcu() waiting time
Mime-Version: 1.0 (1.0)
X-Apple-Notify-Thread: NO
X-Universally-Unique-Identifier: F8192FEA-755F-4711-984A-533C5ADE2112
From:   Joel Fernandes <joel@joelfernandes.org>
In-Reply-To: <ca153af5-bd66-4d48-afa5-ace3a13aec3c@paulmck-laptop>
Cc:     "Zhang, Qiang1" <qiang1.zhang@intel.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>, RCU <rcu@vger.kernel.org>,
        quic_neeraju@quicinc.com, Boqun Feng <boqun.feng@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Frederic Weisbecker <frederic@kernel.org>
Date:   Mon, 27 Mar 2023 22:29:31 -0400
X-Apple-Message-Smime-Encrypt: NO
Message-Id: <FC49F388-0480-4687-8DD3-94049FCBC92B@joelfernandes.org>
References: <ca153af5-bd66-4d48-afa5-ace3a13aec3c@paulmck-laptop>
To:     paulmck@kernel.org
X-Mailer: iPhone Mail (20B101)
X-Spam-Status: No, score=1.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLACK autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

> On Mar 27, 2023, at 9:06 PM, Paul E. McKenney <paulmck@kernel.org> wrote:
>=20
> =EF=BB=BFOn Mon, Mar 27, 2023 at 11:21:23AM +0000, Zhang, Qiang1 wrote:
>>>> From: Uladzislau Rezki (Sony) <urezki@gmail.com>
>>>> Sent: Tuesday, March 21, 2023 6:28 PM
>>>> [...]
>>>> Subject: [PATCH 1/1] Reduce synchronize_rcu() waiting time
>>>>=20
>>>> A call to a synchronize_rcu() can be expensive from time point of view.=

>>>> Different workloads can be affected by this especially the ones which u=
se this
>>>> API in its time critical sections.
>>>>=20
>>>=20
>>> This is interesting and meaningful research. ;-)
>>>=20
>>>> For example in case of NOCB scenario the wakeme_after_rcu() callback
>>>> invocation depends on where in a nocb-list it is located. Below is an e=
xample
>>>> when it was the last out of ~3600 callbacks:
>>>=20
>>=20
>>=20
>>=20
>> Can it be implemented separately as follows?  it seems that the code is s=
impler
>> (only personal opinion)  =F0=9F=98=8A.
>>=20
>> But I didn't test whether this reduce synchronize_rcu() waiting time
>>=20
>> +static void rcu_poll_wait_gp(struct rcu_tasks *rtp)
>> +{
>> +       unsigned long gp_snap;
>> +
>> +       gp_snap =3D start_poll_synchronize_rcu();
>> +       while (!poll_state_synchronize_rcu(gp_snap))
>> +               schedule_timeout_idle(1);
>=20
> I could be wrong, but my guess is that the guys working with
> battery-powered devices are not going to be very happy with this loop.
>=20
> All those wakeups by all tasks waiting for a grace period end up
> consuming a surprisingly large amount of energy.

Is that really the common case? On the general topic of wake-ups:
Most of the time there should be only one
task waiting synchronously on a GP to end. If that is
true, then it feels like waking
up nocb Kthreads which indirectly wake other threads is doing more work than=
 usual?

I am curious to measure how much does Vlad patch reduce wakeups in the commo=
n case.

I was also wondering how Vlad patch effects RCU-barrier ordering. I guess
we want the wake up to happen in the order of
other callbacks also waiting.

One last note, most battery powered systems are perhaps already using expedi=
ted RCU ;-)

Thoughts?

 - Joel=20

>=20
>                            Thanx, Paul
>=20
>> +}
>> +
>> +void call_rcu_poll(struct rcu_head *rhp, rcu_callback_t func);
>> +DEFINE_RCU_TASKS(rcu_poll, rcu_poll_wait_gp, call_rcu_poll,
>> +                 "RCU Poll");
>> +void call_rcu_poll(struct rcu_head *rhp, rcu_callback_t func)
>> +{
>> +       call_rcu_tasks_generic(rhp, func, &rcu_poll);
>> +}
>> +EXPORT_SYMBOL_GPL(call_rcu_poll);
>> +
>> +void synchronize_rcu_poll(void)
>> +{
>> +       synchronize_rcu_tasks_generic(&rcu_poll);
>> +}
>> +EXPORT_SYMBOL_GPL(synchronize_rcu_poll);
>> +
>> +static int __init rcu_spawn_poll_kthread(void)
>> +{
>> +       cblist_init_generic(&rcu_poll);
>> +       rcu_poll.gp_sleep =3D HZ / 10;
>> +       rcu_spawn_tasks_kthread_generic(&rcu_poll);
>> +       return 0;
>> +}
>>=20
>> Thanks
>> Zqiang
>>=20
>>=20
>>>>=20
>>>> <snip>
>>>>  <...>-29      [001] d..1. 21950.145313: rcu_batch_start: rcu_preempt
>>>> CBs=3D3613 bl=3D28
>>>> ...
>>>>  <...>-29      [001] ..... 21950.152578: rcu_invoke_callback: rcu_preem=
pt
>>>> rhp=3D00000000b2d6dee8 func=3D__free_vm_area_struct.cfi_jt
>>>>  <...>-29      [001] ..... 21950.152579: rcu_invoke_callback: rcu_preem=
pt
>>>> rhp=3D00000000a446f607 func=3D__free_vm_area_struct.cfi_jt
>>>>  <...>-29      [001] ..... 21950.152580: rcu_invoke_callback: rcu_preem=
pt
>>>> rhp=3D00000000a5cab03b func=3D__free_vm_area_struct.cfi_jt
>>>>  <...>-29      [001] ..... 21950.152581: rcu_invoke_callback: rcu_preem=
pt
>>>> rhp=3D0000000013b7e5ee func=3D__free_vm_area_struct.cfi_jt
>>>>  <...>-29      [001] ..... 21950.152582: rcu_invoke_callback: rcu_preem=
pt
>>>> rhp=3D000000000a8ca6f9 func=3D__free_vm_area_struct.cfi_jt
>>>>  <...>-29      [001] ..... 21950.152583: rcu_invoke_callback: rcu_preem=
pt
>>>> rhp=3D000000008f162ca8 func=3Dwakeme_after_rcu.cfi_jt
>>>>  <...>-29      [001] d..1. 21950.152625: rcu_batch_end: rcu_preempt CBs=
-
>>>> invoked=3D3612 idle=3D....
>>>> <snip>
>>>>=20
>>>=20
>>> Did the results above tell us that CBs-invoked=3D3612 during the time 21=
950.145313 ~ 21950.152625?
>>>=20
>>> Yes.
>>>=20
>>>=20
>>> If possible, may I know the steps, commands, and related parameters to p=
roduce the results above?
>>> Thank you!
>>>=20
>>> Build the kernel with CONFIG_RCU_TRACE configuration. Update your "set_e=
vent"
>>> file with appropriate traces:
>>>=20
>>> <snip>
>>> XQ-DQ54:/sys/kernel/tracing # echo rcu:rcu_batch_start rcu:rcu_batch_end=
 rcu:rcu_invoke_callback > set_event
>>>=20
>>> XQ-DQ54:/sys/kernel/tracing # cat set_event
>>> rcu:rcu_batch_start
>>> rcu:rcu_invoke_callback
>>> rcu:rcu_batch_end
>>> XQ-DQ54:/sys/kernel/tracing #
>>> <snip>
>>>=20
>>> Collect traces as much as you want: XQ-DQ54:/sys/kernel/tracing # echo 1=
 > tracing_on; sleep 10; echo 0 > tracing_on
>>> Next problem is how to parse it. Of course you will not be able to parse=

>>> megabytes of traces. For that purpose i use a special C trace parser.
>>> If you need an example please let me know i can show here.
>>>=20
>>> --
>>> Uladzislau Rezki
