Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9946A6AE0F2
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 14:43:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbjCGNmz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 08:42:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbjCGNmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 08:42:02 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 494CF84F5D
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 05:41:31 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id i9so17100724lfc.6
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 05:41:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1678196489;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BfVNWRy9a0gMO1Pid/nllP9Vg6biqTw3XLwrBavINRo=;
        b=Fkh2gZT69D42Vozm9kyxGPBUzGIu197ZYeGELkVhpyUTCPh+23qoqk7xkTF0ahwOAZ
         jcfMITK1MCmmjILs80UGXYT6fF2d6qqMfkLLx8ruZP08146Z1rTIwQJ8yTFEUvo3b58D
         tXx7Ni3AkpuXC7OOAv43xYILVlXswC7/cDfBI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678196489;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BfVNWRy9a0gMO1Pid/nllP9Vg6biqTw3XLwrBavINRo=;
        b=J/U3dkaYzsuh3K4x9vNK8y/YVj1aofwEVo1At+pF1qRKiNzkXq3kSIn7J//KM/2FR3
         wy9FuaXZHyDJv9DV0zLwXuBaDeaAt9ewh6lz0Q+kzYhEsMqOy7bkFK51hu4QCAgcBcYX
         Ke4LaTZFW5nXrCp1qsK/wnsMTlPcJoBjMFak31HDEFayfYvdSVq3XCIHrBMVG889nf2c
         j8CTBkUmOqq5nVT+B1zMtvxMo1YEq2Dx7SqZ0WyjFIJr4jRZyOF9PSaizmXENaGfiglt
         uzed1ZyYcjiAZHOdHXinCoA8xty4ibBfXS47XfuZ4DWUgJwoKPj47GIa+9/jDq20ZmMd
         IQ+Q==
X-Gm-Message-State: AO0yUKXSGdVo9YfCzPKwy2Faikap6YE/Bo0X9+t84WCn2m9VdHlzP2AW
        R2+tCT88neQH8PdChKVjM41Un4o7Fu47g5CNi3OoFw==
X-Google-Smtp-Source: AK7set9RWntswalOZp7n6m4+l8CAeu4q46lBrQJupqbgtr9kTxlgbnNNvgkboBD1MjO2KqCK/IVL+GT7IThaMzn5eQY=
X-Received: by 2002:ac2:530d:0:b0:4db:1809:29a1 with SMTP id
 c13-20020ac2530d000000b004db180929a1mr8373690lfh.2.1678196489356; Tue, 07 Mar
 2023 05:41:29 -0800 (PST)
MIME-Version: 1.0
References: <20230303213851.2090365-1-joel@joelfernandes.org> <ZAc1wsvd4trjP/xi@lothringen>
In-Reply-To: <ZAc1wsvd4trjP/xi@lothringen>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Tue, 7 Mar 2023 08:41:17 -0500
Message-ID: <CAEXW_YRf9MuJ9YTXGkxJn5BVA2-vt+OD2=b2hN4uLgN3RxWwTw@mail.gmail.com>
Subject: Re: [PATCH v3] rcu: Add a minimum time for marking boot as completed
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-doc@vger.kernel.org, "Paul E. McKenney" <paulmck@kernel.org>,
        rcu@vger.kernel.org, urezki@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 7, 2023 at 8:01=E2=80=AFAM Frederic Weisbecker <frederic@kernel=
.org> wrote:
>
> On Fri, Mar 03, 2023 at 09:38:51PM +0000, Joel Fernandes (Google) wrote:
> > On many systems, a great deal of boot (in userspace) happens after the
> > kernel thinks the boot has completed. It is difficult to determine if
> > the system has really booted from the kernel side. Some features like
> > lazy-RCU can risk slowing down boot time if, say, a callback has been
> > added that the boot synchronously depends on. Further expedited callbac=
ks
> > can get unexpedited way earlier than it should be, thus slowing down
> > boot (as shown in the data below).
> >
> > For these reasons, this commit adds a config option
> > 'CONFIG_RCU_BOOT_END_DELAY' and a boot parameter rcupdate.boot_end_dela=
y.
> > Userspace can also make RCU's view of the system as booted, by writing =
the
> > time in milliseconds to: /sys/module/rcupdate/parameters/rcu_boot_end_d=
elay
> > Or even just writing a value of 0 to this sysfs node.
> > However, under no circumstance will the boot be allowed to end earlier
> > than just before init is launched.
> >
> > The default value of CONFIG_RCU_BOOT_END_DELAY is chosen as 15s. This
> > suites ChromeOS and also a PREEMPT_RT system below very well, which nee=
d
> > no config or parameter changes, and just a simple application of this p=
atch. A
> > system designer can also choose a specific value here to keep RCU from =
marking
> > boot completion.  As noted earlier, RCU's perspective of the system as =
booted
> > will not be marker until at least rcu_boot_end_delay milliseconds have =
passed
> > or an update is made via writing a small value (or 0) in milliseconds t=
o:
> > /sys/module/rcupdate/parameters/rcu_boot_end_delay.
> >
> > One side-effect of this patch is, there is a risk that a real-time work=
load
> > launched just after the kernel boots will suffer interruptions due to e=
xpedited
> > RCU, which previous ended just before init was launched. However, to mi=
tigate
> > such an issue (however unlikely), the user should either tune
> > CONFIG_RCU_BOOT_END_DELAY to a smaller value than 15 seconds or write a=
 value
> > of 0 to /sys/module/rcupdate/parameters/rcu_boot_end_delay, once usersp=
ace
> > boots, and before launching the real-time workload.
> >
> > Qiuxu also noted impressive boot-time improvements with earlier version
> > of patch. An excerpt from the data he shared:
> >
> > 1) Testing environment:
> >     OS            : CentOS Stream 8 (non-RT OS)
> >     Kernel     : v6.2
> >     Machine : Intel Cascade Lake server (2 sockets, each with 44 logica=
l threads)
> >     Qemu  args  : -cpu host -enable-kvm, -smp 88,threads=3D2,sockets=3D=
2, =E2=80=A6
> >
> > 2) OS boot time definition:
> >     The time from the start of the kernel boot to the shell command lin=
e
> >     prompt is shown from the console. [ Different people may have
> >     different OS boot time definitions. ]
> >
> > 3) Measurement method (very rough method):
> >     A timer in the kernel periodically prints the boot time every 100ms=
.
> >     As soon as the shell command line prompt is shown from the console,
> >     we record the boot time printed by the timer, then the printed boot
> >     time is the OS boot time.
> >
> > 4) Measured OS boot time (in seconds)
> >    a) Measured 10 times w/o this patch:
> >         8.7s, 8.4s, 8.6s, 8.2s, 9.0s, 8.7s, 8.8s, 9.3s, 8.8s, 8.3s
> >         The average OS boot time was: ~8.7s
> >
> >    b) Measure 10 times w/ this patch:
> >         8.5s, 8.2s, 7.6s, 8.2s, 8.7s, 8.2s, 7.8s, 8.2s, 9.3s, 8.4s
> >         The average OS boot time was: ~8.3s.
> >
> > Tested-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
>
> I still don't really like that:
>
> 1) It feels like we are curing a symptom for which we don't know the caus=
e.
>    Which RCU write side caller is the source of this slow boot? Some trac=
epoints
>    reporting the wait duration within synchronize_rcu() calls between the=
 end of
>    the kernel boot and the end of userspace boot may be helpful.

Just to clarify (and I feel we discussed this recently) -- there is no
callback I am aware of right now causing a slow boot. The reason for
doing this is we don't have such issues in the future; so it is a
protection. Note the repeated call outs to the scsi callback and also
the rcu_barrier() issue previously fixed. Further, we already see
slight improvements in boot times with disabling lazy during boot (its
not much but its there). Yes, we should fix issues instead of hiding
them - but we also would like to improve the user experience -- just
like we disable lazy and expedited during suspend.

So what is the problem that you really have with this patch even with
data showing improvements? I actually wanted a mechanism like this
from the beginning and was trying to get Intel to write the patch, but
I ended up writing it.

> 2) The kernel boot was already covered before this patch so this is about
>    userspace code calling into the kernel. Is that piece of code also cal=
led
>    after the boot? In that case are we missing a conversion from
>    synchronize_rcu() to synchronize_rcu_expedited() somewhere? Because th=
en
>    the problem is more general than just boot.
>
> This needs to be analyzed first and if it happens that the issue really
> needs to be fixed with telling the kernel that userspace has completed
> booting, eg: because the problem is not in a few callsites that need conv=
ersion
> to expedited but instead in the accumulation of lots of calls that should=
 stay
> as is:

There is no such callback I am aware off that needs such a conversion
and I don't think that will help give any guarantees because there is
no preventing someone from adding a callback that synchronously slows
boot. The approach here is to put a protection. However, I will do
some more investigations into what else may be slowing things as I do
hold a lot of weight for your words! :)

>
> 3) This arbitrary timeout looks dangerous to me as latency sensitive code
>    may run right after the boot. Either you choose a value that is too lo=
w
>    and you miss the optimization or the value is too high and you may bre=
ak
>    things.

So someone is presenting a timing sensitive workload within 15 seconds
of boot? Please provide some evidence of that. The only evidence right
now is on the plus side even for the RT system.

> 4) This should be fixed the way you did:
>    a) a kernel parameter like you did
>    b) The init process (systemd?) tells the kernel when it judges that us=
erspace
>       has completed booting.
>    c) Make these interfaces more generic, maybe that information will be =
useful
>       outside RCU. For example the kernel parameter should be
>       "user_booted_reported" and the sysfs (should be sysctl?):
>       kernel.user_booted =3D 1
>    d) But yuck, this means we must know if the init process supports that=
...
>
> For these reasons, let's make sure we know exactly what is going on first=
.

I can investigate this more and get back to you.

One of the challenges is getting boot tracing working properly.
Systems do weird things like turning off tracing during boot and/or
clearing trace buffers.

 - Joel
