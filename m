Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68E666AEF9A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 19:24:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231742AbjCGSYg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 13:24:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232757AbjCGSYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 13:24:08 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69FC099665
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 10:19:39 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id t11so18294427lfr.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 10:19:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1678213177;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VvSIU+fZfVPTzvWxZ2BUi4+tSWg8Mte3j0Lq++/MHMM=;
        b=NsT/xEJfHRH+iS90Lm02KZkIKk8hU2eo/gv8uPgrPZYNtqGSfbhIq2Pk7RXfpJnTNl
         QqpBmCUfz221nOqYtakNAAKVv+44dYDNPGTzTBDOHS0yHhxNsQdNGZ8PY9VS9YlTb8lb
         K468Z7aIwqfL+ZdWOWi/1pH6oVWtoNjU4Y0EM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678213177;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VvSIU+fZfVPTzvWxZ2BUi4+tSWg8Mte3j0Lq++/MHMM=;
        b=30YjWzMk6kro5g9KJGActsuWOUc++jc3dIfIXGggAqyvILLByZkmcVy2vJ7TSxlmZY
         3h9rqnebMLTUl3dQRc1uC4M1eIbXXCN7r3MPJcSUAQ9OYsJxILUWS+9lglY3YgT/cx4T
         99bIHp9GIXki57ga7VGCLjTGd3LiqVL7ID8tqtgZ0hUbegu5VJlSG9/NTnN/2p6HiLBp
         y0Ar6FiNqRbX7ETrIny0dmRWcsZtt3viQiXiDnEmWrwtFmvypovoghrQxN7ZJJmE64CQ
         H7mkA5e6wHQ+fjHuQzU0ExdPP3NgyWY2CdWQ7GkSCZJTi4O7YAAHkNveAr+DpguiDiS1
         QdBA==
X-Gm-Message-State: AO0yUKV1flNxkI/Grs0aPRZ71DrfZ9KymVSC7PFHv6YhqdTKtFHCoob9
        jiBQwlQn7fEZRwN4razCfOnac8isWJ1QYeriNiX7QQ==
X-Google-Smtp-Source: AK7set8FqisTCCII8f+cuU/99Pu0e469ZL5sOLul6EPSTRVtqneaWUQTsExfG3G0DNgCDEqoHb0s7De22xlpSsXtvMA=
X-Received: by 2002:a19:750b:0:b0:4de:6514:2ee4 with SMTP id
 y11-20020a19750b000000b004de65142ee4mr4694081lfe.11.1678213177501; Tue, 07
 Mar 2023 10:19:37 -0800 (PST)
MIME-Version: 1.0
References: <20230303213851.2090365-1-joel@joelfernandes.org>
 <ZAc1wsvd4trjP/xi@lothringen> <CAEXW_YRf9MuJ9YTXGkxJn5BVA2-vt+OD2=b2hN4uLgN3RxWwTw@mail.gmail.com>
 <ZAdyGANbQhduAFTM@lothringen>
In-Reply-To: <ZAdyGANbQhduAFTM@lothringen>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Tue, 7 Mar 2023 13:19:25 -0500
Message-ID: <CAEXW_YTS-fd2XLQi1yVhkgW+QNF+OcHPjjni9ksEk95dUTXDyQ@mail.gmail.com>
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

On Tue, Mar 7, 2023 at 12:19=E2=80=AFPM Frederic Weisbecker <frederic@kerne=
l.org> wrote:
>
> On Tue, Mar 07, 2023 at 08:41:17AM -0500, Joel Fernandes wrote:
> > On Tue, Mar 7, 2023 at 8:01=E2=80=AFAM Frederic Weisbecker <frederic@ke=
rnel.org> wrote:
> > >
> > > On Fri, Mar 03, 2023 at 09:38:51PM +0000, Joel Fernandes (Google) wro=
te:
> > > > On many systems, a great deal of boot (in userspace) happens after =
the
> > > > kernel thinks the boot has completed. It is difficult to determine =
if
> > > > the system has really booted from the kernel side. Some features li=
ke
> > > > lazy-RCU can risk slowing down boot time if, say, a callback has be=
en
> > > > added that the boot synchronously depends on. Further expedited cal=
lbacks
> > > > can get unexpedited way earlier than it should be, thus slowing dow=
n
> > > > boot (as shown in the data below).
> > > >
> > > > For these reasons, this commit adds a config option
> > > > 'CONFIG_RCU_BOOT_END_DELAY' and a boot parameter rcupdate.boot_end_=
delay.
> > > > Userspace can also make RCU's view of the system as booted, by writ=
ing the
> > > > time in milliseconds to: /sys/module/rcupdate/parameters/rcu_boot_e=
nd_delay
> > > > Or even just writing a value of 0 to this sysfs node.
> > > > However, under no circumstance will the boot be allowed to end earl=
ier
> > > > than just before init is launched.
> > > >
> > > > The default value of CONFIG_RCU_BOOT_END_DELAY is chosen as 15s. Th=
is
> > > > suites ChromeOS and also a PREEMPT_RT system below very well, which=
 need
> > > > no config or parameter changes, and just a simple application of th=
is patch. A
> > > > system designer can also choose a specific value here to keep RCU f=
rom marking
> > > > boot completion.  As noted earlier, RCU's perspective of the system=
 as booted
> > > > will not be marker until at least rcu_boot_end_delay milliseconds h=
ave passed
> > > > or an update is made via writing a small value (or 0) in millisecon=
ds to:
> > > > /sys/module/rcupdate/parameters/rcu_boot_end_delay.
> > > >
> > > > One side-effect of this patch is, there is a risk that a real-time =
workload
> > > > launched just after the kernel boots will suffer interruptions due =
to expedited
> > > > RCU, which previous ended just before init was launched. However, t=
o mitigate
> > > > such an issue (however unlikely), the user should either tune
> > > > CONFIG_RCU_BOOT_END_DELAY to a smaller value than 15 seconds or wri=
te a value
> > > > of 0 to /sys/module/rcupdate/parameters/rcu_boot_end_delay, once us=
erspace
> > > > boots, and before launching the real-time workload.
> > > >
> > > > Qiuxu also noted impressive boot-time improvements with earlier ver=
sion
> > > > of patch. An excerpt from the data he shared:
> > > >
> > > > 1) Testing environment:
> > > >     OS            : CentOS Stream 8 (non-RT OS)
> > > >     Kernel     : v6.2
> > > >     Machine : Intel Cascade Lake server (2 sockets, each with 44 lo=
gical threads)
> > > >     Qemu  args  : -cpu host -enable-kvm, -smp 88,threads=3D2,socket=
s=3D2, =E2=80=A6
> > > >
> > > > 2) OS boot time definition:
> > > >     The time from the start of the kernel boot to the shell command=
 line
> > > >     prompt is shown from the console. [ Different people may have
> > > >     different OS boot time definitions. ]
> > > >
> > > > 3) Measurement method (very rough method):
> > > >     A timer in the kernel periodically prints the boot time every 1=
00ms.
> > > >     As soon as the shell command line prompt is shown from the cons=
ole,
> > > >     we record the boot time printed by the timer, then the printed =
boot
> > > >     time is the OS boot time.
> > > >
> > > > 4) Measured OS boot time (in seconds)
> > > >    a) Measured 10 times w/o this patch:
> > > >         8.7s, 8.4s, 8.6s, 8.2s, 9.0s, 8.7s, 8.8s, 9.3s, 8.8s, 8.3s
> > > >         The average OS boot time was: ~8.7s
> > > >
> > > >    b) Measure 10 times w/ this patch:
> > > >         8.5s, 8.2s, 7.6s, 8.2s, 8.7s, 8.2s, 7.8s, 8.2s, 9.3s, 8.4s
> > > >         The average OS boot time was: ~8.3s.
> > > >
> > > > Tested-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> > > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > >
> > > I still don't really like that:
> > >
> > > 1) It feels like we are curing a symptom for which we don't know the =
cause.
> > >    Which RCU write side caller is the source of this slow boot? Some =
tracepoints
> > >    reporting the wait duration within synchronize_rcu() calls between=
 the end of
> > >    the kernel boot and the end of userspace boot may be helpful.
> >
> > Just to clarify (and I feel we discussed this recently) -- there is no
> > callback I am aware of right now causing a slow boot. The reason for
> > doing this is we don't have such issues in the future; so it is a
> > protection. Note the repeated call outs to the scsi callback and also
> > the rcu_barrier() issue previously fixed. Further, we already see
> > slight improvements in boot times with disabling lazy during boot (its
> > not much but its there). Yes, we should fix issues instead of hiding
> > them - but we also would like to improve the user experience -- just
> > like we disable lazy and expedited during suspend.
> >
> > So what is the problem that you really have with this patch even with
> > data showing improvements? I actually wanted a mechanism like this
> > from the beginning and was trying to get Intel to write the patch, but
> > I ended up writing it.
>
> Let's put it another way: kernel boot is mostly code that won't execute
> again. User boot (or rather the kernel part of it) OTOH is code that is
> subject to be repeated again.
>
> A lot of the kernel boot code is __init code that will execute only once.
> And there it makes sense to force hurry and expedited because we may easi=
ly
> miss something and after all this all happens only once, also there is no
> interference with userspace, etc...
>
> User boot OTOH use common kernel code: syscalls, signal, files, etc... An=
d that
> code will be called also after the boot.
>
> So if there is something slowing down user boot, there are some good chan=
ces
> that this thing slows down userspace in general.
>
> Therefore we need to know exactly what's going on because the problem may=
 be
> bigger than what you observe on boot.

These are good points. It motivates me to dig further, as we may be
setting ourselves up for longer term problems for shorter term gains
otherwise. I am thinking I finish my debugobjects patch soon which
adds metadata to callbacks and expose the details via debugfs, and
provide it to Qiuxu and ChromeOS folks to run and study the boot time.

> > > 2) The kernel boot was already covered before this patch so this is a=
bout
> > >    userspace code calling into the kernel. Is that piece of code also=
 called
> > >    after the boot? In that case are we missing a conversion from
> > >    synchronize_rcu() to synchronize_rcu_expedited() somewhere? Becaus=
e then
> > >    the problem is more general than just boot.
> > >
> > > This needs to be analyzed first and if it happens that the issue real=
ly
> > > needs to be fixed with telling the kernel that userspace has complete=
d
> > > booting, eg: because the problem is not in a few callsites that need =
conversion
> > > to expedited but instead in the accumulation of lots of calls that sh=
ould stay
> > > as is:
> >
> > There is no such callback I am aware off that needs such a conversion
> > and I don't think that will help give any guarantees because there is
> > no preventing someone from adding a callback that synchronously slows
> > boot. The approach here is to put a protection. However, I will do
> > some more investigations into what else may be slowing things as I do
> > hold a lot of weight for your words! :)
>
> Kernel boot is already handled and userspace boot can not add a new RCU c=
allback.

Right, so that is in line with your point about userspace slowing down
even after boot, if I am not mistaken.

> > > 3) This arbitrary timeout looks dangerous to me as latency sensitive =
code
> > >    may run right after the boot. Either you choose a value that is to=
o low
> > >    and you miss the optimization or the value is too high and you may=
 break
> > >    things.
> >
> > So someone is presenting a timing sensitive workload within 15 seconds
> > of boot? Please provide some evidence of that.
>
> I have no idea, there are billions of computers running out there, it's a=
 disaster...

Haha... Linux success sounds like a nice problem to have. ;-)

> > The only evidence right now is on the plus side even for the RT system.
>
> Right it's improving the boot of an RT system, doesn't mean it's not brea=
king
> post boot of others.

True. However, I still feel a protection in the future would make
sense in general after we finish these investigations.

> > > 4) This should be fixed the way you did:
> > >    a) a kernel parameter like you did
> > >    b) The init process (systemd?) tells the kernel when it judges tha=
t userspace
> > >       has completed booting.
> > >    c) Make these interfaces more generic, maybe that information will=
 be useful
> > >       outside RCU. For example the kernel parameter should be
> > >       "user_booted_reported" and the sysfs (should be sysctl?):
> > >       kernel.user_booted =3D 1
> > >    d) But yuck, this means we must know if the init process supports =
that...
> > >
> > > For these reasons, let's make sure we know exactly what is going on f=
irst.
> >
> > I can investigate this more and get back to you.
> >
> > One of the challenges is getting boot tracing working properly.
> > Systems do weird things like turning off tracing during boot and/or
> > clearing trace buffers.
>
> Just compare the average and total duration of all synchronize_rcu() call=
s
> (before and after forcing expedited) between launching initand userspace =
boot
> completion. Sure there will be noise but if a difference can be measured =
before
> and after your patch, then a difference might be measureable on tracing a=
s
> well... Well of course tracing can induce subtle things... But let's try =
at
> least, we want to know what we are fixing here.

You mean using function graph tracer? For the synchronize_rcu() stuff,
I'll have to defer to the Qiuxu to try tracing synchronize_rcu() on
his PREEMPT_RT system since I don't have access to that system. I can
try to provide a patch that will make tracing that easier, but that
will be a few days probably as I'm traveling...

On ChromeOS we are seeing slight improvements with this patch (though
it is not clear whether it is statistically significant). So I have to
dig deeper what is going on there.


 - Joel
