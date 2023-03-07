Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE2006AEAD4
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 18:37:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231671AbjCGRhp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 12:37:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbjCGRhS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 12:37:18 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9EC220044;
        Tue,  7 Mar 2023 09:33:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5797AB817AE;
        Tue,  7 Mar 2023 17:33:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F51EC4339C;
        Tue,  7 Mar 2023 17:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678210394;
        bh=dbWa0dh6TW5y30BdIUcuVUIG35+wcQGVwS2WNIVbWMk=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=uMVUe1mxfahIDhWS/tx8YAJMvwMstDT/nqbJHVPFWRT+AUoVq04VzuzIhPN7WnBNc
         s7D2xfiNmwc/ErFx4rAxn1DOdMjFA1NVre71Nc0+/HtnA62NmN2RPYh+83QDBWbMeU
         yZR0il8wfoqwWfkSXaXvP+vCSdd/Tk6AKYXyCCAB1wMMrcknniS4sfTarht1QJM/3R
         90c3Nt9kiJbYIDDSQQ+csETRn13u1KHOT3mR8TuvzJaNpPE9oR9nZxrS/8BFCZspts
         rNTx22IQyE9kTkl56t7xOCLe/SEkDufTx7l/c+dyLSRgP1sAkZC6MhmvBjNSRXNMBX
         bdTirIWj24QXg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id A2C085C01E4; Tue,  7 Mar 2023 09:33:13 -0800 (PST)
Date:   Tue, 7 Mar 2023 09:33:13 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        linux-kernel@vger.kernel.org, Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-doc@vger.kernel.org, rcu@vger.kernel.org
Subject: Re: [PATCH v3] rcu: Add a minimum time for marking boot as completed
Message-ID: <20230307173313.GJ1301832@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20230303213851.2090365-1-joel@joelfernandes.org>
 <ZAc1wsvd4trjP/xi@lothringen>
 <ZAc+vVZUhXdhpSki@pc636>
 <CAEXW_YRTLQpQpOW-+n+X59pmB=4TkV=gdsMiQfBkdK_4wO9Jug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEXW_YRTLQpQpOW-+n+X59pmB=4TkV=gdsMiQfBkdK_4wO9Jug@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

See this commit:

3705b88db0d7cc ("rcu: Add a module parameter to force use of expedited RCU primitives")

Antti provided this commit precisely in order to allow Android devices
to expedite the boot process and to shut off the expediting at a time of
Android userspace's choosing.  So Android has been making this work for
about ten years, which strikes me as an adequate proof of concept.  ;-)

Of course, Android has a rather tightly controlled userspace, as do
real-time embedded systems (I sure hope, anyway!).  Which is why your
timeout-based fallback/backup makes a lot of sense.  And why someone might
want an aggressive indication when that timeout-based backup is needed.

							Thanx, Paul
