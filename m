Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA3856A496D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 19:16:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230488AbjB0SQL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 13:16:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbjB0SQE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 13:16:04 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 316792529A
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 10:16:00 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id c3so3381404qtc.8
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 10:16:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sA0zwwxSh10gV4VGqqHr6okLTh8FciLwKCJEIhDneKk=;
        b=I7nxXGKe5lOO0fMuzeK6FgmJ5fyTftYzC0AYeHHWyPcOTTBZYieC0dkPYxddejdbiq
         XU/jLBHCpF1XuZ0vMRxZ+2HbJdGLuBDHxxRCPTgrrvmKB4VREJlM35yOp2OZ0CfQWLj0
         VvZRTHvNYRnVeLgKaXpCYF5j/z3h2xp2VMmh0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sA0zwwxSh10gV4VGqqHr6okLTh8FciLwKCJEIhDneKk=;
        b=r8EClTG5W2XKQx5jn+JEWmoANtDBmsKkqG7DqdqC/XThRd7j8Ns+RGsXY5fsS77yLD
         t1UVtDMRJrNr6LmbNbecLVgn9lHnQH44B6h5grad3hzyJttA6ntX9O1+elKr1bjZvyit
         eOVYjf0236nJZh/ELCD/uyC7k/802CBya5bYmV1/u6u/rR5t9rRUnoZpk+MKMDIMwtQF
         HahjHWSEobHDl3idSvArhCqS9zOJay5vE6kyaPvYEFPynaPM96854lDd30E9AszuZb5G
         SNySwL8ZUubZIQkrUue8+eU7XJo528WAmCgJC6n2CzedOCTK6yS0lYFd/Wz2yxlbA2uY
         PxCg==
X-Gm-Message-State: AO0yUKWiaTvpwKUxJzd9kDB8F5g6JhlCp0sBJu2aKlKTofHPF5f+YA5R
        yhnSiS8hc8r0GxVqdvufkrbrNw==
X-Google-Smtp-Source: AK7set9TLj+Hn7daTx771B36Hbj9u9bLdRF1XVFNaZvgVP2Ck3m5z9f9M0aumqD+YjEuhNxIguVSQg==
X-Received: by 2002:a05:622a:5cf:b0:3bd:1a07:2086 with SMTP id d15-20020a05622a05cf00b003bd1a072086mr308587qtb.36.1677521759207;
        Mon, 27 Feb 2023 10:15:59 -0800 (PST)
Received: from smtpclient.apple (c-98-249-43-138.hsd1.va.comcast.net. [98.249.43.138])
        by smtp.gmail.com with ESMTPSA id p12-20020a37420c000000b007426ec97253sm2853850qka.111.2023.02.27.10.15.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Feb 2023 10:15:58 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Joel Fernandes <joel@joelfernandes.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH RFC v2] rcu: Add a minimum time for marking boot as completed
Date:   Mon, 27 Feb 2023 13:15:47 -0500
Message-Id: <577E687B-1E01-4953-A353-D8B91DF8387E@joelfernandes.org>
References: <Y/zxDuxsihJXTdxf@pc636>
Cc:     paulmck@kernel.org, "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>,
        linux-kernel@vger.kernel.org,
        Frederic Weisbecker <frederic@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-doc@vger.kernel.org, rcu@vger.kernel.org
In-Reply-To: <Y/zxDuxsihJXTdxf@pc636>
To:     Uladzislau Rezki <urezki@gmail.com>
X-Mailer: iPhone Mail (20B101)
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLACK autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Feb 27, 2023, at 1:06 PM, Uladzislau Rezki <urezki@gmail.com> wrote:
>=20
> =EF=BB=BFOn Mon, Feb 27, 2023 at 10:16:51AM -0500, Joel Fernandes wrote:
>>> On Mon, Feb 27, 2023 at 9:55 AM Paul E. McKenney <paulmck@kernel.org> wr=
ote:
>>>=20
>>> On Mon, Feb 27, 2023 at 08:22:06AM -0500, Joel Fernandes wrote:
>>>>=20
>>>>=20
>>>>> On Feb 27, 2023, at 2:53 AM, Zhuo, Qiuxu <qiuxu.zhuo@intel.com> wrote:=

>>>>>=20
>>>>> =EF=BB=BF
>>>>>>=20
>>>>>> From: Joel Fernandes (Google) <joel@joelfernandes.org>
>>>>>> Sent: Saturday, February 25, 2023 11:34 AM
>>>>>> To: linux-kernel@vger.kernel.org
>>>>>> Cc: Joel Fernandes (Google) <joel@joelfernandes.org>; Frederic Weisbe=
cker
>>>>>> <frederic@kernel.org>; Lai Jiangshan <jiangshanlai@gmail.com>; linux-=

>>>>>> doc@vger.kernel.org; Paul E. McKenney <paulmck@kernel.org>;
>>>>>> rcu@vger.kernel.org
>>>>>> Subject: [PATCH RFC v2] rcu: Add a minimum time for marking boot as
>>>>>> completed
>>>>>>=20
>>>>>> On many systems, a great deal of boot happens after the kernel thinks=
 the
>>>>>> boot has completed. It is difficult to determine if the system has re=
ally
>>>>>> booted from the kernel side. Some features like lazy-RCU can risk slo=
wing
>>>>>> down boot time if, say, a callback has been added that the boot
>>>>>> synchronously depends on.
>>>>>>=20
>>>>>> Further, it is better to boot systems which pass 'rcu_normal_after_bo=
ot' to
>>>>>> stay expedited for as long as the system is still booting.
>>>>>>=20
>>>>>> For these reasons, this commit adds a config option
>>>>>> 'CONFIG_RCU_BOOT_END_DELAY' and a boot parameter
>>>>>> rcupdate.boot_end_delay.
>>>>>>=20
>>>>>> By default, this value is 20s. A system designer can choose to specif=
y a value
>>>>>> here to keep RCU from marking boot completion.  The boot sequence wil=
l not
>>>>>> be marked ended until at least boot_end_delay milliseconds have passe=
d.
>>>>>=20
>>>>> Hi Joel,
>>>>>=20
>>>>> Just some thoughts on the default value of 20s, correct me if I'm wron=
g :-).
>>>>>=20
>>>>> Does the OS with CONFIG_PREEMPT_RT=3Dy kernel concern more about the
>>>>> real-time latency than the overall OS boot time?
>>>>=20
>>>> But every system has to boot, even an RT system.
>>>>=20
>>>>>=20
>>>>> If so, we might make rcupdate.boot_end_delay =3D 0 as the default valu=
e
>>>>> (NOT the default 20s) for CONFIG_PREEMPT_RT=3Dy kernels?
>>>>=20
>>>> Could you measure how much time your RT system takes to boot before the=
 application runs?
>>>>=20
>>>> I can change it to default 0 essentially NOOPing it, but I would rather=
 have a saner default (10 seconds even), than having someone forget to tune t=
his for their system.
>>>=20
>>> Provide a /sys location that the userspace code writes to when it
>>> is ready?  Different systems with different hardware and software
>>> configurations are going to take different amounts of time to boot,
>>> correct?
>>=20
>> I could add a sysfs node, but I still wanted this patch as well
>> because I am wary of systems where yet more userspace changes are
>> required. I feel the kernel should itself be able to do this. Yes, it
>> is possible the system completes "booting" at a different time than
>> what the kernel thinks. But it does that anyway (even without this
>> patch), so I am not seeing a good reason to not do this in the kernel.
>> It is also only a minimum cap, so if the in-kernel boot takes too
>> long, then the patch will have no effect.
>>=20
>> Thoughts?
>>=20
> Why "rcu_boot_ended" is not enough? As i see right after that an "init"
> process or shell or panic is going to be invoked by the kernel. It basical=
ly
> indicates that a kernel is fully functional.
>=20
> Or an idea to wait even further? Until all kernel modules are loaded by
> user space.

I mentioned in commit message it is daemons, userspace initialization etc. T=
here is a lot of userspace booting up as well and using the kernel while doi=
ng so.

So, It does not make sense to me to mark kernel as booted too early. And no h=
arm in adding some builtin kernel hysteresis. What am I missing?

Thanks,

- Joel
(And Steven please dont kick my butt for the lack of wrapping, I am working o=
n fixing it :P).


>=20
> Thanks!
>=20
> --
> Uladzislau Rezki
