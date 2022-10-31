Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF33461382A
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 14:37:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231135AbiJaNhv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 09:37:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231218AbiJaNhs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 09:37:48 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C660E101F7
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 06:37:46 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id o28so4892008qkl.4
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 06:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EAV9w6JyF/hzCCK8WyXWgDOgUEsVNQ2Wm5PIvVgvzls=;
        b=VNvsY+ZiRnPNOstfurFy36eIrD7B0vYSYFC+hKHYefT2azDggpkAfkGAgispzmmFmJ
         gEkQSyt/a3N1c6LHvds/jzKuI2TybOsMDoIp1jb6Y/NV/p4eF8yIEP2nJHq63bTuIKJ1
         G0+XlgguE0/2meiNpyol1srfBhz7Xlim5ALe8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EAV9w6JyF/hzCCK8WyXWgDOgUEsVNQ2Wm5PIvVgvzls=;
        b=TqMbrnL0LzY4Eoi/64qbYkivAT0OoToYHbBNrXKqZjK8qn7RBoqb+jqo9wRmexNPN9
         VYe0eVzhCq+Q1xuqhvWrmR1+zGT5zV0Swh0TWMIosukFE86m5M3pd4dJwdfYPe4K7305
         nJzMNVRAu6CE8BDVNhiKPpBYO2PwbSEBGDbwhGeZObvJk6Hm79NIjYpOnC00wJM6CSAj
         Z5l4Bg5yJOFFaB9iCbDeyU01r5w8a9lkqd8GV/c//E+TJCWwffF73U3Z5GQhpcm6YMfD
         tiWyfXs5Qtdvrm+F25PZnkG7Kub+tKOvw/rTAENdYfUcay+xQdNJhpg1avnXUzFmHpyL
         vEag==
X-Gm-Message-State: ACrzQf2V5URCTy/bW8RZsIUzcNGL+DMac21wXSK25EtJ3WOaaG03HpMq
        i+BCaISotP/RhVESS8+ehLOkV3YyeRYItA==
X-Google-Smtp-Source: AMsMyM4LTXdbg0W3c742BGTtNamcvyFr45h9P2VQIsVvGALJEFx9dZUbthtIlqAA8Ahs+eX8k3hhgQ==
X-Received: by 2002:a05:620a:21c6:b0:6fa:12ed:9315 with SMTP id h6-20020a05620a21c600b006fa12ed9315mr8639104qka.142.1667223465405;
        Mon, 31 Oct 2022 06:37:45 -0700 (PDT)
Received: from smtpclient.apple ([2600:1003:b868:22b1:c906:7d7c:e816:7c8b])
        by smtp.gmail.com with ESMTPSA id t1-20020a05620a450100b006cbcdc6efedsm4736716qkp.41.2022.10.31.06.37.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Oct 2022 06:37:44 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Joel Fernandes <joel@joelfernandes.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH rcu 13/14] workqueue: Make queue_rcu_work() use call_rcu_flush()
Date:   Mon, 31 Oct 2022 09:37:43 -0400
Message-Id: <B3913CB9-0C0F-4985-81D1-CBD8D808A0EA@joelfernandes.org>
References: <Y1/LwKz60iU2izOZ@pc636>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org
In-Reply-To: <Y1/LwKz60iU2izOZ@pc636>
To:     Uladzislau Rezki <urezki@gmail.com>
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


> On Oct 31, 2022, at 9:21 AM, Uladzislau Rezki <urezki@gmail.com> wrote:
>=20
> =EF=BB=BFOn Fri, Oct 28, 2022 at 09:23:47PM +0000, Joel Fernandes wrote:
>>> On Mon, Oct 24, 2022 at 09:48:19AM -0700, Paul E. McKenney wrote:
>>> On Mon, Oct 24, 2022 at 06:25:30PM +0200, Uladzislau Rezki wrote:
>>>>>=20
>>>>> You guys might need to agree on the definition of "good" here.  Or may=
be
>>>>> understand the differences in your respective platforms' definitions o=
f
>>>>> "good".  ;-)
>>>>>=20
>>>> Indeed. Bad is when once per-millisecond infinitely :) At least in such=
 use
>>>> workload a can detect a power delta and power gain. Anyway, below is a n=
ew
>>>> trace where i do not use "flush" variant for the kvfree_rcu():
>>>>=20
>>>> <snip>
>>>> 1. Home screen swipe:
>>>>         rcuop/0-15      [003] d..1  1792.767750: rcu_batch_start: rcu_p=
reempt CBs=3D1003 bl=3D10
>>>>         rcuop/2-33      [002] d..1  1792.771717: rcu_batch_start: rcu_p=
reempt CBs=3D934 bl=3D10
>>>>         rcuop/3-40      [001] d..1  1794.811816: rcu_batch_start: rcu_p=
reempt CBs=3D1508 bl=3D11
>>>>         rcuop/1-26      [003] d..1  1797.116382: rcu_batch_start: rcu_p=
reempt CBs=3D2127 bl=3D16
>>>>         rcuop/4-48      [001] d..1  1797.124422: rcu_batch_start: rcu_p=
reempt CBs=3D95 bl=3D10
>>>>         rcuop/5-55      [002] d..1  1797.124731: rcu_batch_start: rcu_p=
reempt CBs=3D143 bl=3D10
>>>>         rcuop/6-62      [005] d..1  1798.911719: rcu_batch_start: rcu_p=
reempt CBs=3D132 bl=3D10
>>>>         rcuop/2-33      [002] d..1  1803.003966: rcu_batch_start: rcu_p=
reempt CBs=3D3797 bl=3D29
>>>>         rcuop/0-15      [003] d..1  1803.004707: rcu_batch_start: rcu_p=
reempt CBs=3D2969 bl=3D23
>>>> 2. App launches:
>>>>         rcuop/4-48      [005] d..1  1831.087612: rcu_batch_start: rcu_p=
reempt CBs=3D6141 bl=3D47
>>>>         rcuop/7-69      [007] d..1  1831.095578: rcu_batch_start: rcu_p=
reempt CBs=3D5464 bl=3D42
>>>>         rcuop/5-55      [004] d..1  1832.703571: rcu_batch_start: rcu_p=
reempt CBs=3D8461 bl=3D66
>>>>         rcuop/0-15      [004] d..1  1833.731603: rcu_batch_start: rcu_p=
reempt CBs=3D2548 bl=3D19
>>>>         rcuop/1-26      [006] d..1  1833.743691: rcu_batch_start: rcu_p=
reempt CBs=3D2567 bl=3D20
>>>>         rcuop/2-33      [006] d..1  1833.744005: rcu_batch_start: rcu_p=
reempt CBs=3D2359 bl=3D18
>>>>         rcuop/3-40      [006] d..1  1833.744286: rcu_batch_start: rcu_p=
reempt CBs=3D3681 bl=3D28
>>>>         rcuop/4-48      [002] d..1  1838.079777: rcu_batch_start: rcu_p=
reempt CBs=3D10444 bl=3D81
>>>>         rcuop/7-69      [001] d..1  1838.080375: rcu_batch_start: rcu_p=
reempt CBs=3D12572 bl=3D98
>>>>           <...>-62      [002] d..1  1838.080646: rcu_batch_start: rcu_p=
reempt CBs=3D14135 bl=3D110
>>>>         rcuop/6-62      [000] d..1  1838.087722: rcu_batch_start: rcu_p=
reempt CBs=3D10839 bl=3D84

Please let us try to trim emails. That goes for me too.

>>>>           <...>-62      [003] d..1  1839.227022: rcu_batch_start: rcu_p=
reempt CBs=3D1834 bl=3D14
>>>>           <...>-26      [001] d..1  1839.963315: rcu_batch_start: rcu_p=
reempt CBs=3D5769 bl=3D45
>>>>         rcuop/2-33      [001] d..1  1839.966485: rcu_batch_start: rcu_p=
reempt CBs=3D3789 bl=3D29
>>>>           <...>-40      [001] d..1  1839.966596: rcu_batch_start: rcu_p=
reempt CBs=3D6425 bl=3D50
>>>>         rcuop/2-33      [005] d..1  1840.541272: rcu_batch_start: rcu_p=
reempt CBs=3D825 bl=3D10
>>>>         rcuop/2-33      [005] d..1  1840.547724: rcu_batch_start: rcu_p=
reempt CBs=3D44 bl=3D10
>>>>         rcuop/2-33      [005] d..1  1841.075759: rcu_batch_start: rcu_p=
reempt CBs=3D516 bl=3D10
>>>>         rcuop/0-15      [002] d..1  1841.695716: rcu_batch_start: rcu_p=
reempt CBs=3D6312 bl=3D49
>>>>         rcuop/0-15      [003] d..1  1841.709714: rcu_batch_start: rcu_p=
reempt CBs=3D39 bl=3D10
>>>>         rcuop/5-55      [004] d..1  1843.112442: rcu_batch_start: rcu_p=
reempt CBs=3D16007 bl=3D125
>>>>         rcuop/5-55      [004] d..1  1843.115444: rcu_batch_start: rcu_p=
reempt CBs=3D7901 bl=3D61
>>>>         rcuop/6-62      [001] dn.1  1843.123983: rcu_batch_start: rcu_p=
reempt CBs=3D8427 bl=3D65
>>>>         rcuop/6-62      [006] d..1  1843.412383: rcu_batch_start: rcu_p=
reempt CBs=3D981 bl=3D10
>>>>         rcuop/0-15      [003] d..1  1844.659812: rcu_batch_start: rcu_p=
reempt CBs=3D1851 bl=3D14
>>>>         rcuop/0-15      [003] d..1  1844.667790: rcu_batch_start: rcu_p=
reempt CBs=3D135 bl=3D10
>>>> <snip>
>>>>=20
>>>> it is much more better. But. As i wrote earlier there is a patch that i=
 have submitted
>>>> some time ago improving kvfree_rcu() batching:
>>>>=20
>>>> <snip>
>>>> commit 51824b780b719c53113dc39e027fbf670dc66028
>>>> Author: Uladzislau Rezki (Sony) <urezki@gmail.com>
>>>> Date:   Thu Jun 30 18:33:35 2022 +0200
>>>>=20
>>>>    rcu/kvfree: Update KFREE_DRAIN_JIFFIES interval
>>>>=20
>>>>    Currently the monitor work is scheduled with a fixed interval of HZ/=
20,
>>>>    which is roughly 50 milliseconds. The drawback of this approach is
>>>>    low utilization of the 512 page slots in scenarios with infrequence
>>>>    kvfree_rcu() calls.  For example on an Android system:
>>>> <snip>
>>>>=20
>>>> The trace that i posted was taken without it.
>>>=20
>>> And if I am not getting too confused, that patch is now in mainline.
>>> So it does make sense to rely on it, then.  ;-)
>>=20
>> Vlad's patch to change the KFREE_DRAIN_JIFFIES to 5 seconds seems reasona=
ble
>> to me. However, can we unify KFREE_DRAIN_JIFFIES and LAZY_FLUSH_JIFFIES ?=

>>=20
> This is very good.
>=20
> Below is a plot that i have taken during one use-case. It is about three
> apps usage in parallel. It was done by running "monkey" test:
>=20
> wget ftp://vps418301.ovh.net/incoming/monkey_3_apps_slab_usage_5_minutes.p=
ng
>=20
> i set up three apps as usage scenario: Google Chrome, YoTube and Camera.
> I logged the Slab metric from the /proc/meminfo. Sampling rate is 0.1 seco=
nd.
>=20
> Please have a look at results. It reflects what i am saying. non-flush
> kvfree RCU variant makes a memory usage higher. What is not acceptable
> for our mobile devices and workloads.

Thanks I=E2=80=99ll take a closer look at the data (currently commuting) but=
 here=E2=80=99s a quick reply:

I am curious that with the 5 second timer, you are delaying RCU anyway. Are y=
ou saying that, adding another 10 on top (due to lazyfying) seems to be caus=
ing issues? I find it hard to believe that you cannot give the shrinker enou=
gh work within 5 seconds, such that it also triggers the issues you=E2=80=99=
re seeing. However the workload and data speaks.

>> One at 5 and other at 10 seems odd, especially because the former seems t=
o
>> negate the effects of the latter and anyone tweaking that in the future (=
say
>> via new command line options) should probably tweak them together to incr=
ease
>> batching.
>>=20
> Well. Convert 5 seconds to 10? What will it solve for you? We can do it
> and from a kvfree_rcu() perspective nothing really is changed.

True. In fact with my last patch, I see almost never even the need to go to R=
CU. However my point with unification is just to keep it simple for user for=
 2 knobs that do the same thing. Granted this is a compiler knob but that mi=
ght change in the future. We already have enough knobs in RCU and as you guy=
s know, I=E2=80=99m a fan of not letting the user mess things up too much.

>> Testing shows significantly better batching with Vlad's updates, however I=
 am
>> wondering why the rcu_callback fires in pairs like that from separate
>> kworkers:
>>=20
>>     kworker/6:1-157     [006] d..1   288.861610: rcu_callback: rcu_preemp=
t  rhp=3D0000000079b895f9 func=3Drcu_work_rcufn 1214
>>     kworker/4:2-158     [004]  d..1   288.861612: rcu_callback: rcu_preem=
pt rhp=3D00000000d83fcc90 func=3Drcu_work_rcufn 798
>>=20
>> I wonder if the queued kwork is executing twice accidentally, or somethin=
g.
>>=20
> Because a kfree_rcu_cpu() is a per-cpu thing.

Right, got it.

>> This kernel does have the additional trace patch below, fyi.
>>=20
>> Another thought I have is, if we can just keep the kvfree_rcu() mapped to=

>> call_rcu() via a config option say CONFIG_RCU_LAZY_KFREE, or something.
>>=20
> I am not sure you need it, really. If you wake-up "rcuop" or whatever
> with 0.5 second interval or with 5 seconds interval you will not notice
> anything in terms of power between both.

Yes, you are right. This is not needed considering the improvements you rece=
ntly made.

Cheers,

 - Joel=20


>=20
> --
> Uladzislau Rezki
