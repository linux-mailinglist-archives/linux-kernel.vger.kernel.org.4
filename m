Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C2E06B03D0
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 11:14:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbjCHKOt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 05:14:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbjCHKOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 05:14:47 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CC0230B25;
        Wed,  8 Mar 2023 02:14:45 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id t11so20655725lfr.1;
        Wed, 08 Mar 2023 02:14:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678270483;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hlrfoA/FBrEH3n0KjGry8MZjVfOr+LQ30iq7NC4AnNs=;
        b=VNLa2aJ4cUXo/kcz4gVQLmqiJz2t8BhDKJd40Ye8Db2yDyucv2O+vuDzle5hxtFXFS
         /ZW64C1nJnTNRxqk1/UMUjvVaQ/HxxeEBQtnXmpDc+I9OK/NrOiNu0oHo1IQaSzF2kfN
         +ueqK5nQhW1n0qS8fCKz/szfVdL8xNevPVwWDdUdvQQWQGnuxapyt4E9TKJrRgF3V+86
         QhC/2imWVgZzx6tpDSMwOolpWCTtZLC0T6JoA1ZQ96IhxxiDGYVgFyzia2EuYLFsIPmH
         DMaF/1X7b/kzIKePnjenyJPGjS0tmhsScGQbkqYxFQWMsao51naaw4RSYb0isrdA+c8S
         8P7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678270483;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hlrfoA/FBrEH3n0KjGry8MZjVfOr+LQ30iq7NC4AnNs=;
        b=L0bl59CG4hknhZkzow2zVhWquBV9rcUNGAC25oem7TEczrhOh+JHve+/gzyDHhpojq
         SPw403HvZcTI7YibP9E3BwNh7lHI02iR1YFxQnucBuu/E5qENvN+G4JkGFQ4ZDq/qwvp
         CKv8OwEFpmD/jJG3JOGooEFjDrnTdR+TTAkTov3fQBZcKAOJHkACuz+I9CkAa17WESoR
         tYEWsCdbQIqtKwvOJtJAc7L9B9s4ukyXHZjuVncQiFE/uSE2wlbnqYwbYRRjbM7sxuyD
         nQ2pjX7jmcGP80AOkgdx+/XBIAB5r9b4Xsp/o+BAuTdN/z4d67bTcZFLU3x7r26flPID
         1KFg==
X-Gm-Message-State: AO0yUKUgLGjlwt6Q1ngtIBewxnO4/HDeM4fdbHNH8uGqTP+jidbx20Pn
        /oQwetdH2EVqB/KV5nrUeDI=
X-Google-Smtp-Source: AK7set+urCGWvEYGpBlS8pnqIFeGINkgeIUY9d27Js0iErMtDQYllskxL0nWHiUBQO4r9slTJ4no4g==
X-Received: by 2002:ac2:43c5:0:b0:4de:ca63:b2d9 with SMTP id u5-20020ac243c5000000b004deca63b2d9mr4988693lfl.49.1678270483487;
        Wed, 08 Mar 2023 02:14:43 -0800 (PST)
Received: from pc636 (host-95-193-108-241.mobileonline.telia.com. [95.193.108.241])
        by smtp.gmail.com with ESMTPSA id q9-20020ac25149000000b004dda74eccafsm2311862lfd.68.2023.03.08.02.14.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 02:14:43 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Wed, 8 Mar 2023 11:14:40 +0100
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        linux-kernel@vger.kernel.org, Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-doc@vger.kernel.org, "Paul E. McKenney" <paulmck@kernel.org>,
        rcu@vger.kernel.org
Subject: Re: [PATCH v3] rcu: Add a minimum time for marking boot as completed
Message-ID: <ZAhgEK/dMqVf6/hO@pc636>
References: <20230303213851.2090365-1-joel@joelfernandes.org>
 <ZAc1wsvd4trjP/xi@lothringen>
 <ZAc+vVZUhXdhpSki@pc636>
 <CAEXW_YRTLQpQpOW-+n+X59pmB=4TkV=gdsMiQfBkdK_4wO9Jug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEXW_YRTLQpQpOW-+n+X59pmB=4TkV=gdsMiQfBkdK_4wO9Jug@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 07, 2023 at 08:48:52AM -0500, Joel Fernandes wrote:
> On Tue, Mar 7, 2023 at 8:40 AM Uladzislau Rezki <urezki@gmail.com> wrote:
> >
> > On Tue, Mar 07, 2023 at 02:01:54PM +0100, Frederic Weisbecker wrote:
> > > On Fri, Mar 03, 2023 at 09:38:51PM +0000, Joel Fernandes (Google) wrote:
> > > > On many systems, a great deal of boot (in userspace) happens after the
> > > > kernel thinks the boot has completed. It is difficult to determine if
> > > > the system has really booted from the kernel side. Some features like
> > > > lazy-RCU can risk slowing down boot time if, say, a callback has been
> > > > added that the boot synchronously depends on. Further expedited callbacks
> > > > can get unexpedited way earlier than it should be, thus slowing down
> > > > boot (as shown in the data below).
> > > >
> > > > For these reasons, this commit adds a config option
> > > > 'CONFIG_RCU_BOOT_END_DELAY' and a boot parameter rcupdate.boot_end_delay.
> > > > Userspace can also make RCU's view of the system as booted, by writing the
> > > > time in milliseconds to: /sys/module/rcupdate/parameters/rcu_boot_end_delay
> > > > Or even just writing a value of 0 to this sysfs node.
> > > > However, under no circumstance will the boot be allowed to end earlier
> > > > than just before init is launched.
> > > >
> > > > The default value of CONFIG_RCU_BOOT_END_DELAY is chosen as 15s. This
> > > > suites ChromeOS and also a PREEMPT_RT system below very well, which need
> > > > no config or parameter changes, and just a simple application of this patch. A
> > > > system designer can also choose a specific value here to keep RCU from marking
> > > > boot completion.  As noted earlier, RCU's perspective of the system as booted
> > > > will not be marker until at least rcu_boot_end_delay milliseconds have passed
> > > > or an update is made via writing a small value (or 0) in milliseconds to:
> > > > /sys/module/rcupdate/parameters/rcu_boot_end_delay.
> > > >
> > > > One side-effect of this patch is, there is a risk that a real-time workload
> > > > launched just after the kernel boots will suffer interruptions due to expedited
> > > > RCU, which previous ended just before init was launched. However, to mitigate
> > > > such an issue (however unlikely), the user should either tune
> > > > CONFIG_RCU_BOOT_END_DELAY to a smaller value than 15 seconds or write a value
> > > > of 0 to /sys/module/rcupdate/parameters/rcu_boot_end_delay, once userspace
> > > > boots, and before launching the real-time workload.
> > > >
> > > > Qiuxu also noted impressive boot-time improvements with earlier version
> > > > of patch. An excerpt from the data he shared:
> > > >
> > > > 1) Testing environment:
> > > >     OS            : CentOS Stream 8 (non-RT OS)
> > > >     Kernel     : v6.2
> > > >     Machine : Intel Cascade Lake server (2 sockets, each with 44 logical threads)
> > > >     Qemu  args  : -cpu host -enable-kvm, -smp 88,threads=2,sockets=2, …
> > > >
> > > > 2) OS boot time definition:
> > > >     The time from the start of the kernel boot to the shell command line
> > > >     prompt is shown from the console. [ Different people may have
> > > >     different OS boot time definitions. ]
> > > >
> > > > 3) Measurement method (very rough method):
> > > >     A timer in the kernel periodically prints the boot time every 100ms.
> > > >     As soon as the shell command line prompt is shown from the console,
> > > >     we record the boot time printed by the timer, then the printed boot
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
> > > 1) It feels like we are curing a symptom for which we don't know the cause.
> > >    Which RCU write side caller is the source of this slow boot? Some tracepoints
> > >    reporting the wait duration within synchronize_rcu() calls between the end of
> > >    the kernel boot and the end of userspace boot may be helpful.
> > >
> > > 2) The kernel boot was already covered before this patch so this is about
> > >    userspace code calling into the kernel. Is that piece of code also called
> > >    after the boot? In that case are we missing a conversion from
> > >    synchronize_rcu() to synchronize_rcu_expedited() somewhere? Because then
> > >    the problem is more general than just boot.
> > >
> > > This needs to be analyzed first and if it happens that the issue really
> > > needs to be fixed with telling the kernel that userspace has completed
> > > booting, eg: because the problem is not in a few callsites that need conversion
> > > to expedited but instead in the accumulation of lots of calls that should stay
> > > as is:
> > >
> > > 3) This arbitrary timeout looks dangerous to me as latency sensitive code
> > >    may run right after the boot. Either you choose a value that is too low
> > >    and you miss the optimization or the value is too high and you may break
> > >    things.
> > >
> > > 4) This should be fixed the way you did:
> > >    a) a kernel parameter like you did
> > >    b) The init process (systemd?) tells the kernel when it judges that userspace
> > >       has completed booting.
> > >    c) Make these interfaces more generic, maybe that information will be useful
> > >       outside RCU. For example the kernel parameter should be
> > >       "user_booted_reported" and the sysfs (should be sysctl?):
> > >       kernel.user_booted = 1
> > >    d) But yuck, this means we must know if the init process supports that...
> > >
> > > For these reasons, let's make sure we know exactly what is going on first.
> > >
> > > Thanks.
> > Just add some notes and thoughts. There is a rcupdate.rcu_expedited=1
> > parameter that can be used during the boot. For example on our devices
> > to speedup a boot we boot the kernel with rcu_expedited:
> >
> > XQ-DQ54:/ # cat /proc/cmdline
> > stack_depot_disable=on kasan.stacktrace=off kvm-arm.mode=protected cgroup_disable=pressure console=ttyMSM0,115200n8 loglevel=6 kpti=0 log_buf_len=256K kernel.panic_on_rcu_stall=1 service_locator.enable=1 msm_rtb.filter=0x237 rcupdate.rcu_expedited=1 rcu_nocbs=0-7 ftrace_dump_on_oops swiotlb=noforce loop.max_part=7 fw_devlink.strict=1 allow_mismatched_32bit_el0 cpufreq.default_governor=performance printk.console_no_auto_verbose=1 kasan=off sysctl.kernel.sched_pelt_multiplier=4 can.stats_timer=0 pcie_ports=compat irqaffinity=0-2 disable_dma32=on no-steal-acc cgroup.memory=nokmem,nosocket video=vfb:640x400,bpp=32,memsize=3072000 page_owner=on stack_depot_disable=off printk.console_no_auto_verbose=0 nosoftlockup bootconfig buildvariant=userdebug  msm_drm.dsi_display0=somc,1_panel: rootwait ro init=/init  qcom_geni_serial.con_enabled=0 oembootloader.startup=0x00000001 oembootloader.warmboot=0x00000000 oembootloader.securityflags=0x00000001
> > XQ-DQ54:/ #
> >
> > then a user space can decides if it is needed or not:
> >
> > <snip>
> > rcu_expedited  rcu_normal
> > XQ-DQ54:/ # ls -al /sys/kernel/rcu_*
> > -rw-r--r-- 1 root root 4096 2023-02-16 09:27 /sys/kernel/rcu_expedited
> > -rw-r--r-- 1 root root 4096 2023-02-16 09:27 /sys/kernel/rcu_normal
> > XQ-DQ54:/ #
> > <snip>
> >
> > for lazy we can add "rcu_cb_lazy" parameter and boot the kernel with
> > true or false. So we can follow and be aligned with rcu_expedited and
> > rcu_normal parameters.
> 
> Speaking of aligning, there is also the automated
> rcu_normal_after_boot boot option correct? I prefer the automated
> option of doing this. So the approach here is not really unprecedented
> and is much more robust than relying on userspace too much (I am ok
> with adding your suggestion *on top* of the automated toggle, but I
> probably would not have ChromeOS use it if the automated way exists).
> Or did I miss something?
> 
According to name of the rcu_end_inkernel_boot() function and a place
when it is invoked we can conclude that it marks the end of kernel boot
and it happens before running an "init" process.

With your patch we change a behavior. The initialization occurs not right
after a kernel is up and running but rather after 15 seconds timeout what
at least does not correspond to a function name. Apart from that an expected
behavior might be different. For example some test-suites or smoke tests, etc.

Another thought about "automated boot complete" is we do not know from
kernel space when it really completes for user space, because from kernel
space we are done and we can detect it. In this cases a user space is a
right candidate to say when it is ready.

For example for Android a boot complete happens when a home-screen appears.
For Chrome OS i think there is something similar. There must be a boot complete
event in its init scripts or something similar.

This is just my thoughts. I do not really mind but i also do not see a high
need in having it.

--
Uladzislau Rezki
