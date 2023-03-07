Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6D686AE147
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 14:50:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231231AbjCGNug (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 08:50:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231429AbjCGNuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 08:50:15 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95AEE85B33
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 05:49:10 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id i28so17221723lfv.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 05:49:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1678196944;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CN3RrfwHggCqyNGCibpCijEgRUpbfNo+308R2rtH1gc=;
        b=TGR0qaH0HM4qQykiR3WVw2js1EA+GEqTsFk3nxWysYdiCBLITd/CWnn+55oVdIc2h9
         d0PtO5MPUGx7MlWw9o/eMSAehzqPDZrpYt8zfduG7UACkbFc87f9WRzlWbP7kKwN54+K
         qZv4qN2LtngxA2ZJT1OzSD7vkvgaqjk3cSF6s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678196944;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CN3RrfwHggCqyNGCibpCijEgRUpbfNo+308R2rtH1gc=;
        b=VELtK0csYAIISWkoJ9A8mkEPPNbJTuhbhd7Ck12QYyx+nd0Q3njHTJlM1AST4RtgRq
         6jBnpYmdAqtbEuT4sQLjZd+RPtuoeS6v7WUkwhKRdCMFv0liB6HeIs0s1XlrcN04iOIs
         V5NaA9/Z12hKOqwpdiC6r7+ETTE+hNxPpTmZqsOGrTBBHpLqiVg/VLABzJoEK/7xMx4/
         WXg3d+DLL1b2YTMLI/FmWdOOb4pFO0ghAUZv4inT8CY20jT3bG8uh28s4S9tbiB0AbWz
         n4WcRoGJ4xFQDuypxo+r/LqSK3f2Bf6R+KtCB3KZyQT/ka1AqrMrWEFPADS+H9QHnoCz
         flRQ==
X-Gm-Message-State: AO0yUKWnAR6QjpLE9DlxsynMJC9f5YqaxqZol+0hj6dZkVklpzsLefvz
        p+7xPFti+RikWIBs0kADy3EjdJyJiO0QMbM+UKfGCvCC3MroWhBDt5g=
X-Google-Smtp-Source: AK7set/vsfgf1HpWaYziGLk+ODYZPZ8A3+35BOPJmj4MRgoSF5sQqXQoIiWErbvIguM9cBEin20MvSXx34241RFMS4Y=
X-Received: by 2002:a19:750b:0:b0:4de:6514:2ee4 with SMTP id
 y11-20020a19750b000000b004de65142ee4mr4397242lfe.11.1678196944278; Tue, 07
 Mar 2023 05:49:04 -0800 (PST)
MIME-Version: 1.0
References: <20230303213851.2090365-1-joel@joelfernandes.org>
 <ZAc1wsvd4trjP/xi@lothringen> <ZAc+vVZUhXdhpSki@pc636>
In-Reply-To: <ZAc+vVZUhXdhpSki@pc636>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Tue, 7 Mar 2023 08:48:52 -0500
Message-ID: <CAEXW_YRTLQpQpOW-+n+X59pmB=4TkV=gdsMiQfBkdK_4wO9Jug@mail.gmail.com>
Subject: Re: [PATCH v3] rcu: Add a minimum time for marking boot as completed
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        linux-kernel@vger.kernel.org, Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-doc@vger.kernel.org, "Paul E. McKenney" <paulmck@kernel.org>,
        rcu@vger.kernel.org
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

On Tue, Mar 7, 2023 at 8:40=E2=80=AFAM Uladzislau Rezki <urezki@gmail.com> =
wrote:
>
> On Tue, Mar 07, 2023 at 02:01:54PM +0100, Frederic Weisbecker wrote:
> > On Fri, Mar 03, 2023 at 09:38:51PM +0000, Joel Fernandes (Google) wrote=
:
> > > On many systems, a great deal of boot (in userspace) happens after th=
e
> > > kernel thinks the boot has completed. It is difficult to determine if
> > > the system has really booted from the kernel side. Some features like
> > > lazy-RCU can risk slowing down boot time if, say, a callback has been
> > > added that the boot synchronously depends on. Further expedited callb=
acks
> > > can get unexpedited way earlier than it should be, thus slowing down
> > > boot (as shown in the data below).
> > >
> > > For these reasons, this commit adds a config option
> > > 'CONFIG_RCU_BOOT_END_DELAY' and a boot parameter rcupdate.boot_end_de=
lay.
> > > Userspace can also make RCU's view of the system as booted, by writin=
g the
> > > time in milliseconds to: /sys/module/rcupdate/parameters/rcu_boot_end=
_delay
> > > Or even just writing a value of 0 to this sysfs node.
> > > However, under no circumstance will the boot be allowed to end earlie=
r
> > > than just before init is launched.
> > >
> > > The default value of CONFIG_RCU_BOOT_END_DELAY is chosen as 15s. This
> > > suites ChromeOS and also a PREEMPT_RT system below very well, which n=
eed
> > > no config or parameter changes, and just a simple application of this=
 patch. A
> > > system designer can also choose a specific value here to keep RCU fro=
m marking
> > > boot completion.  As noted earlier, RCU's perspective of the system a=
s booted
> > > will not be marker until at least rcu_boot_end_delay milliseconds hav=
e passed
> > > or an update is made via writing a small value (or 0) in milliseconds=
 to:
> > > /sys/module/rcupdate/parameters/rcu_boot_end_delay.
> > >
> > > One side-effect of this patch is, there is a risk that a real-time wo=
rkload
> > > launched just after the kernel boots will suffer interruptions due to=
 expedited
> > > RCU, which previous ended just before init was launched. However, to =
mitigate
> > > such an issue (however unlikely), the user should either tune
> > > CONFIG_RCU_BOOT_END_DELAY to a smaller value than 15 seconds or write=
 a value
> > > of 0 to /sys/module/rcupdate/parameters/rcu_boot_end_delay, once user=
space
> > > boots, and before launching the real-time workload.
> > >
> > > Qiuxu also noted impressive boot-time improvements with earlier versi=
on
> > > of patch. An excerpt from the data he shared:
> > >
> > > 1) Testing environment:
> > >     OS            : CentOS Stream 8 (non-RT OS)
> > >     Kernel     : v6.2
> > >     Machine : Intel Cascade Lake server (2 sockets, each with 44 logi=
cal threads)
> > >     Qemu  args  : -cpu host -enable-kvm, -smp 88,threads=3D2,sockets=
=3D2, =E2=80=A6
> > >
> > > 2) OS boot time definition:
> > >     The time from the start of the kernel boot to the shell command l=
ine
> > >     prompt is shown from the console. [ Different people may have
> > >     different OS boot time definitions. ]
> > >
> > > 3) Measurement method (very rough method):
> > >     A timer in the kernel periodically prints the boot time every 100=
ms.
> > >     As soon as the shell command line prompt is shown from the consol=
e,
> > >     we record the boot time printed by the timer, then the printed bo=
ot
> > >     time is the OS boot time.
> > >
> > > 4) Measured OS boot time (in seconds)
> > >    a) Measured 10 times w/o this patch:
> > >         8.7s, 8.4s, 8.6s, 8.2s, 9.0s, 8.7s, 8.8s, 9.3s, 8.8s, 8.3s
> > >         The average OS boot time was: ~8.7s
> > >
> > >    b) Measure 10 times w/ this patch:
> > >         8.5s, 8.2s, 7.6s, 8.2s, 8.7s, 8.2s, 7.8s, 8.2s, 9.3s, 8.4s
> > >         The average OS boot time was: ~8.3s.
> > >
> > > Tested-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> >
> > I still don't really like that:
> >
> > 1) It feels like we are curing a symptom for which we don't know the ca=
use.
> >    Which RCU write side caller is the source of this slow boot? Some tr=
acepoints
> >    reporting the wait duration within synchronize_rcu() calls between t=
he end of
> >    the kernel boot and the end of userspace boot may be helpful.
> >
> > 2) The kernel boot was already covered before this patch so this is abo=
ut
> >    userspace code calling into the kernel. Is that piece of code also c=
alled
> >    after the boot? In that case are we missing a conversion from
> >    synchronize_rcu() to synchronize_rcu_expedited() somewhere? Because =
then
> >    the problem is more general than just boot.
> >
> > This needs to be analyzed first and if it happens that the issue really
> > needs to be fixed with telling the kernel that userspace has completed
> > booting, eg: because the problem is not in a few callsites that need co=
nversion
> > to expedited but instead in the accumulation of lots of calls that shou=
ld stay
> > as is:
> >
> > 3) This arbitrary timeout looks dangerous to me as latency sensitive co=
de
> >    may run right after the boot. Either you choose a value that is too =
low
> >    and you miss the optimization or the value is too high and you may b=
reak
> >    things.
> >
> > 4) This should be fixed the way you did:
> >    a) a kernel parameter like you did
> >    b) The init process (systemd?) tells the kernel when it judges that =
userspace
> >       has completed booting.
> >    c) Make these interfaces more generic, maybe that information will b=
e useful
> >       outside RCU. For example the kernel parameter should be
> >       "user_booted_reported" and the sysfs (should be sysctl?):
> >       kernel.user_booted =3D 1
> >    d) But yuck, this means we must know if the init process supports th=
at...
> >
> > For these reasons, let's make sure we know exactly what is going on fir=
st.
> >
> > Thanks.
> Just add some notes and thoughts. There is a rcupdate.rcu_expedited=3D1
> parameter that can be used during the boot. For example on our devices
> to speedup a boot we boot the kernel with rcu_expedited:
>
> XQ-DQ54:/ # cat /proc/cmdline
> stack_depot_disable=3Don kasan.stacktrace=3Doff kvm-arm.mode=3Dprotected =
cgroup_disable=3Dpressure console=3DttyMSM0,115200n8 loglevel=3D6 kpti=3D0 =
log_buf_len=3D256K kernel.panic_on_rcu_stall=3D1 service_locator.enable=3D1=
 msm_rtb.filter=3D0x237 rcupdate.rcu_expedited=3D1 rcu_nocbs=3D0-7 ftrace_d=
ump_on_oops swiotlb=3Dnoforce loop.max_part=3D7 fw_devlink.strict=3D1 allow=
_mismatched_32bit_el0 cpufreq.default_governor=3Dperformance printk.console=
_no_auto_verbose=3D1 kasan=3Doff sysctl.kernel.sched_pelt_multiplier=3D4 ca=
n.stats_timer=3D0 pcie_ports=3Dcompat irqaffinity=3D0-2 disable_dma32=3Don =
no-steal-acc cgroup.memory=3Dnokmem,nosocket video=3Dvfb:640x400,bpp=3D32,m=
emsize=3D3072000 page_owner=3Don stack_depot_disable=3Doff printk.console_n=
o_auto_verbose=3D0 nosoftlockup bootconfig buildvariant=3Duserdebug  msm_dr=
m.dsi_display0=3Dsomc,1_panel: rootwait ro init=3D/init  qcom_geni_serial.c=
on_enabled=3D0 oembootloader.startup=3D0x00000001 oembootloader.warmboot=3D=
0x00000000 oembootloader.securityflags=3D0x00000001
> XQ-DQ54:/ #
>
> then a user space can decides if it is needed or not:
>
> <snip>
> rcu_expedited  rcu_normal
> XQ-DQ54:/ # ls -al /sys/kernel/rcu_*
> -rw-r--r-- 1 root root 4096 2023-02-16 09:27 /sys/kernel/rcu_expedited
> -rw-r--r-- 1 root root 4096 2023-02-16 09:27 /sys/kernel/rcu_normal
> XQ-DQ54:/ #
> <snip>
>
> for lazy we can add "rcu_cb_lazy" parameter and boot the kernel with
> true or false. So we can follow and be aligned with rcu_expedited and
> rcu_normal parameters.

Speaking of aligning, there is also the automated
rcu_normal_after_boot boot option correct? I prefer the automated
option of doing this. So the approach here is not really unprecedented
and is much more robust than relying on userspace too much (I am ok
with adding your suggestion *on top* of the automated toggle, but I
probably would not have ChromeOS use it if the automated way exists).
Or did I miss something?

thanks,

 - Joel
