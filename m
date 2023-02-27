Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A298A6A4A9B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 20:10:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbjB0TKs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 14:10:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbjB0TKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 14:10:47 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21DD32412A
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 11:10:44 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id n2so9893689lfb.12
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 11:10:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gb+ylv7fOsT/EqUUa32R/hvpCHUNsZDpedSr1Yuw2VY=;
        b=ZXZiEMhbvySq2/7qhvyqin9Bgc0TdTV5UXF7fuFsZOpWJaUgfAFnAn5o9UoCwZZhRi
         pk9p9fwB5rINmla46YFxpd36DVDrs+uLOKs5frcSBz4xu5T08eokeOEO3TJq1xuULzPV
         Whshjg0/d/B1qdTNX42tQqLH0W00E3tngIi9U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gb+ylv7fOsT/EqUUa32R/hvpCHUNsZDpedSr1Yuw2VY=;
        b=SwKjkcqbs+lacjlJfO5E4gTwQWQ9oPbIQ+pcjz7A/4s0D0hPfEqylIymiHdBG5nUhj
         GHWGt7esfFgayKe8W6P6zpsBtmrwfCSyI3R01TcNhPjMr/v1hr8jopdOX0grXjg07GeH
         0Rd2UXZs/SW/qJOrltwhKXY9TIDFR2ayklRF7hhz/W437QPxJDIGKl4hhamWwnAP6RSu
         JF1JKbTI5Oyz55HO8qMdC+Kxq9s3Lj9+4a6uZCXHpkg/Gs7EQvB3R+L1ayYOfeqK8srP
         xS1K888KTEAiwM426Kc3x46ZQNM1Fsvb8GF9b0GyYx7FdJLd/oYqsmGt+1j8Fpi2a7vt
         U2Qg==
X-Gm-Message-State: AO0yUKWFy4RAlDCOEFJ37x07FKGDQqvoiVt0ka09JxIj3o2YkVBXx/pR
        M60bNkbrXIbrqegTyrEjtG0ukBkJfesfmpFrrCltAQ==
X-Google-Smtp-Source: AK7set+RZfsxSr6qAraut154L4XQdSB4lbe2BejBKMIPwO3hcufXg0JwLbLucRgjjFNojoFpoaCso34bGrj+ra9imE0=
X-Received: by 2002:a05:6512:208:b0:4d5:ca32:9bdf with SMTP id
 a8-20020a056512020800b004d5ca329bdfmr7917463lfo.11.1677525042278; Mon, 27 Feb
 2023 11:10:42 -0800 (PST)
MIME-Version: 1.0
References: <Y/z0fHHYdxEXcWMT@pc636> <7EBE4F51-F2BD-4B42-AFC1-CA234E78CC7B@joelfernandes.org>
 <Y/z9Its1RKetIr8V@pc636>
In-Reply-To: <Y/z9Its1RKetIr8V@pc636>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Mon, 27 Feb 2023 14:10:30 -0500
Message-ID: <CAEXW_YSjT_orp8TbomBFU+ETS7YJ7TrbHTdrsBRTzCKG5_SBdw@mail.gmail.com>
Subject: Re: [PATCH RFC v2] rcu: Add a minimum time for marking boot as completed
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     paulmck@kernel.org, "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>,
        linux-kernel@vger.kernel.org,
        Frederic Weisbecker <frederic@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-doc@vger.kernel.org, rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLACK autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 27, 2023 at 1:57=E2=80=AFPM Uladzislau Rezki <urezki@gmail.com>=
 wrote:
>
> On Mon, Feb 27, 2023 at 01:27:20PM -0500, Joel Fernandes wrote:
> >
> >
> > > On Feb 27, 2023, at 1:20 PM, Uladzislau Rezki <urezki@gmail.com> wrot=
e:
> > >
> > > =EF=BB=BFOn Mon, Feb 27, 2023 at 01:15:47PM -0500, Joel Fernandes wro=
te:
> > >>
> > >>
> > >>>> On Feb 27, 2023, at 1:06 PM, Uladzislau Rezki <urezki@gmail.com> w=
rote:
> > >>>
> > >>> =EF=BB=BFOn Mon, Feb 27, 2023 at 10:16:51AM -0500, Joel Fernandes w=
rote:
> > >>>>> On Mon, Feb 27, 2023 at 9:55 AM Paul E. McKenney <paulmck@kernel.=
org> wrote:
> > >>>>>
> > >>>>> On Mon, Feb 27, 2023 at 08:22:06AM -0500, Joel Fernandes wrote:
> > >>>>>>
> > >>>>>>
> > >>>>>>> On Feb 27, 2023, at 2:53 AM, Zhuo, Qiuxu <qiuxu.zhuo@intel.com>=
 wrote:
> > >>>>>>>
> > >>>>>>> =EF=BB=BF
> > >>>>>>>>
> > >>>>>>>> From: Joel Fernandes (Google) <joel@joelfernandes.org>
> > >>>>>>>> Sent: Saturday, February 25, 2023 11:34 AM
> > >>>>>>>> To: linux-kernel@vger.kernel.org
> > >>>>>>>> Cc: Joel Fernandes (Google) <joel@joelfernandes.org>; Frederic=
 Weisbecker
> > >>>>>>>> <frederic@kernel.org>; Lai Jiangshan <jiangshanlai@gmail.com>;=
 linux-
> > >>>>>>>> doc@vger.kernel.org; Paul E. McKenney <paulmck@kernel.org>;
> > >>>>>>>> rcu@vger.kernel.org
> > >>>>>>>> Subject: [PATCH RFC v2] rcu: Add a minimum time for marking bo=
ot as
> > >>>>>>>> completed
> > >>>>>>>>
> > >>>>>>>> On many systems, a great deal of boot happens after the kernel=
 thinks the
> > >>>>>>>> boot has completed. It is difficult to determine if the system=
 has really
> > >>>>>>>> booted from the kernel side. Some features like lazy-RCU can r=
isk slowing
> > >>>>>>>> down boot time if, say, a callback has been added that the boo=
t
> > >>>>>>>> synchronously depends on.
> > >>>>>>>>
> > >>>>>>>> Further, it is better to boot systems which pass 'rcu_normal_a=
fter_boot' to
> > >>>>>>>> stay expedited for as long as the system is still booting.
> > >>>>>>>>
> > >>>>>>>> For these reasons, this commit adds a config option
> > >>>>>>>> 'CONFIG_RCU_BOOT_END_DELAY' and a boot parameter
> > >>>>>>>> rcupdate.boot_end_delay.
> > >>>>>>>>
> > >>>>>>>> By default, this value is 20s. A system designer can choose to=
 specify a value
> > >>>>>>>> here to keep RCU from marking boot completion.  The boot seque=
nce will not
> > >>>>>>>> be marked ended until at least boot_end_delay milliseconds hav=
e passed.
> > >>>>>>>
> > >>>>>>> Hi Joel,
> > >>>>>>>
> > >>>>>>> Just some thoughts on the default value of 20s, correct me if I=
'm wrong :-).
> > >>>>>>>
> > >>>>>>> Does the OS with CONFIG_PREEMPT_RT=3Dy kernel concern more abou=
t the
> > >>>>>>> real-time latency than the overall OS boot time?
> > >>>>>>
> > >>>>>> But every system has to boot, even an RT system.
> > >>>>>>
> > >>>>>>>
> > >>>>>>> If so, we might make rcupdate.boot_end_delay =3D 0 as the defau=
lt value
> > >>>>>>> (NOT the default 20s) for CONFIG_PREEMPT_RT=3Dy kernels?
> > >>>>>>
> > >>>>>> Could you measure how much time your RT system takes to boot bef=
ore the application runs?
> > >>>>>>
> > >>>>>> I can change it to default 0 essentially NOOPing it, but I would=
 rather have a saner default (10 seconds even), than having someone forget =
to tune this for their system.
> > >>>>>
> > >>>>> Provide a /sys location that the userspace code writes to when it
> > >>>>> is ready?  Different systems with different hardware and software
> > >>>>> configurations are going to take different amounts of time to boo=
t,
> > >>>>> correct?
> > >>>>
> > >>>> I could add a sysfs node, but I still wanted this patch as well
> > >>>> because I am wary of systems where yet more userspace changes are
> > >>>> required. I feel the kernel should itself be able to do this. Yes,=
 it
> > >>>> is possible the system completes "booting" at a different time tha=
n
> > >>>> what the kernel thinks. But it does that anyway (even without this
> > >>>> patch), so I am not seeing a good reason to not do this in the ker=
nel.
> > >>>> It is also only a minimum cap, so if the in-kernel boot takes too
> > >>>> long, then the patch will have no effect.
> > >>>>
> > >>>> Thoughts?
> > >>>>
> > >>> Why "rcu_boot_ended" is not enough? As i see right after that an "i=
nit"
> > >>> process or shell or panic is going to be invoked by the kernel. It =
basically
> > >>> indicates that a kernel is fully functional.
> > >>>
> > >>> Or an idea to wait even further? Until all kernel modules are loade=
d by
> > >>> user space.
> > >>
> > >> I mentioned in commit message it is daemons, userspace initializatio=
n etc. There is a lot of userspace booting up as well and using the kernel =
while doing so.
> > >>
> > >> So, It does not make sense to me to mark kernel as booted too early.=
 And no harm in adding some builtin kernel hysteresis. What am I missing?
> > >>
> > > Than it is up to user space to decide when it is ready in terms of "b=
oot completed".
> >
> > I dont know if you caught up with the other threads. See replies from P=
aul and my reply to that.
> >
> > Also what you are proposing can be more harmful. If user space has a bu=
g and does not notify the kernel that boot completed, then the boot can sta=
y incomplete forever. The idea with this patch is to make things better, no=
t worse.
> >
> I saw that Paul proposed to have a sysfs attribute using which you can
> send a notification.

Maybe I am missing something but how will a sysfs node on its own work real=
ly?

1. delete kernel marking itself boot completed  -- and then sysfs
marks it completed?

2. delete kernel marking itself boot completed  -- and then sysfs
marks it completed, if sysfs does not come in in N seconds, then
kernel marks as completed?

#1 is a no go, that just means a bug waiting to happen if userspace
forgets to write to sysfs.

#2 is just an extension of this patch. So I can add a sysfs node on
top of this. And we can make the minimum time as a long period of
time, as you noted below:

> IMHO, to me this patch does not provide a clear correlation between what
> is a boot complete and when it occurs. A boot complete is a synchronous
> event whereas the patch thinks that after some interval a "boot" is compl=
eted.

But that is exactly how the kernel code is now without this patch, so
it is already broken in that sense, I am not really breaking it more
;-)

> We can imply that after, say 100 seconds an initialization of user space
> is done. Maybe 100 seconds then? :)

Yes I am Ok with that. So are you suggesting we change the default to
100 seconds and then add a sysfs node to mark as boot done whenever
userspace notifies?

Thanks,

 - Joel
