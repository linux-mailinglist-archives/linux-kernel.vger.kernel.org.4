Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EF086AE0E3
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 14:41:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbjCGNlS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 08:41:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbjCGNku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 08:40:50 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FD408C95B;
        Tue,  7 Mar 2023 05:40:21 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id h3so13140039lja.12;
        Tue, 07 Mar 2023 05:40:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678196417;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OD1ltzSNVNJ08lX7SZ0vGJFjJfVjvSugHCVz6NDjv9o=;
        b=Pabcmd5klSR771Y3LoNdbZljdSmvfLjktpuDM2yinDDFN8jgApyUQT5kgiA6LioBgC
         XlCj1trS+Q/JkgL0weC856VfLqVFU7Dv8TgAkU+P9U7yVq6YiOalJcq6dje1TaaPRmrK
         BAFtk8PG/In/WpXnHCrJECo5CO7oaP7XMsj4wTT0TbSUHZyEl9lQ/h24ebUI3pKLtigv
         cm7VGFJTcq5Qkd87vEjUjUHRfLWjGxli9H9Jzzv8Xr15sSkeQfQpY2Aqzq4ZlpVAM22t
         toyI3YRj987s5EFYgLm89ns2wqLkkwzqsRJ0cFOrxRiiS2ShEqRA101/S87SpVUqHvEU
         014w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678196417;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OD1ltzSNVNJ08lX7SZ0vGJFjJfVjvSugHCVz6NDjv9o=;
        b=LIq11o7woSTimoTYbzeJuA3e8+qTJ2XBv/L0p9SbpZD41CITS+3ZAerS0aIrWAzgiR
         +BIegfieWhmk/0zXSlspwSLtMR2wYc2Sc4QBAz/y/m/rJFCBRkmCZgCx2Ygrw4rjIHbk
         4LwfU0dpadrNbn07HdZRcd1syMqoS4UYB6F5S3i6OnA739smbKlHrsxuMFHFNIHD8qYE
         hiXkI2/94/W6rKh4ud2g7gFuUX0NvO72jQVLO1KJJ3OpXvaHM0/pqEWghR5v7BBsD/f4
         E5T3FCmRcTVcrmRMtaJ1qvp94QIoR5Lx/CoY/rUMI2mvyaY7pO3YwSTOn76AeLBugOBO
         nc5w==
X-Gm-Message-State: AO0yUKWRSkENy/f0mzXsK1HQlkDKUQtGRxivegZmy3xXBrQIU2ueu9MI
        An8dgdmW+cqCz8Sdg1kqVuk=
X-Google-Smtp-Source: AK7set8GrNX7e+ZsjbFAqEenRBGq1vXl7g2znqXE0Nobd5jDKt14YslkJIuRQPHd/VvQpS7VWHBpcA==
X-Received: by 2002:a2e:7410:0:b0:290:6e01:8d0b with SMTP id p16-20020a2e7410000000b002906e018d0bmr3938166ljc.26.1678196417390;
        Tue, 07 Mar 2023 05:40:17 -0800 (PST)
Received: from pc636 (host-90-235-0-207.mobileonline.telia.com. [90.235.0.207])
        by smtp.gmail.com with ESMTPSA id f18-20020a2ea0d2000000b00295a21c7954sm2179832ljm.50.2023.03.07.05.40.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 05:40:16 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Tue, 7 Mar 2023 14:40:13 +0100
To:     Frederic Weisbecker <frederic@kernel.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-doc@vger.kernel.org, "Paul E. McKenney" <paulmck@kernel.org>,
        rcu@vger.kernel.org, urezki@gmail.com
Subject: Re: [PATCH v3] rcu: Add a minimum time for marking boot as completed
Message-ID: <ZAc+vVZUhXdhpSki@pc636>
References: <20230303213851.2090365-1-joel@joelfernandes.org>
 <ZAc1wsvd4trjP/xi@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZAc1wsvd4trjP/xi@lothringen>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 07, 2023 at 02:01:54PM +0100, Frederic Weisbecker wrote:
> On Fri, Mar 03, 2023 at 09:38:51PM +0000, Joel Fernandes (Google) wrote:
> > On many systems, a great deal of boot (in userspace) happens after the
> > kernel thinks the boot has completed. It is difficult to determine if
> > the system has really booted from the kernel side. Some features like
> > lazy-RCU can risk slowing down boot time if, say, a callback has been
> > added that the boot synchronously depends on. Further expedited callbacks
> > can get unexpedited way earlier than it should be, thus slowing down
> > boot (as shown in the data below).
> > 
> > For these reasons, this commit adds a config option
> > 'CONFIG_RCU_BOOT_END_DELAY' and a boot parameter rcupdate.boot_end_delay.
> > Userspace can also make RCU's view of the system as booted, by writing the
> > time in milliseconds to: /sys/module/rcupdate/parameters/rcu_boot_end_delay
> > Or even just writing a value of 0 to this sysfs node.
> > However, under no circumstance will the boot be allowed to end earlier
> > than just before init is launched.
> > 
> > The default value of CONFIG_RCU_BOOT_END_DELAY is chosen as 15s. This
> > suites ChromeOS and also a PREEMPT_RT system below very well, which need
> > no config or parameter changes, and just a simple application of this patch. A
> > system designer can also choose a specific value here to keep RCU from marking
> > boot completion.  As noted earlier, RCU's perspective of the system as booted
> > will not be marker until at least rcu_boot_end_delay milliseconds have passed
> > or an update is made via writing a small value (or 0) in milliseconds to:
> > /sys/module/rcupdate/parameters/rcu_boot_end_delay.
> > 
> > One side-effect of this patch is, there is a risk that a real-time workload
> > launched just after the kernel boots will suffer interruptions due to expedited
> > RCU, which previous ended just before init was launched. However, to mitigate
> > such an issue (however unlikely), the user should either tune
> > CONFIG_RCU_BOOT_END_DELAY to a smaller value than 15 seconds or write a value
> > of 0 to /sys/module/rcupdate/parameters/rcu_boot_end_delay, once userspace
> > boots, and before launching the real-time workload.
> > 
> > Qiuxu also noted impressive boot-time improvements with earlier version
> > of patch. An excerpt from the data he shared:
> > 
> > 1) Testing environment:
> >     OS            : CentOS Stream 8 (non-RT OS)
> >     Kernel     : v6.2
> >     Machine : Intel Cascade Lake server (2 sockets, each with 44 logical threads)
> >     Qemu  args  : -cpu host -enable-kvm, -smp 88,threads=2,sockets=2, …
> > 
> > 2) OS boot time definition:
> >     The time from the start of the kernel boot to the shell command line
> >     prompt is shown from the console. [ Different people may have
> >     different OS boot time definitions. ]
> > 
> > 3) Measurement method (very rough method):
> >     A timer in the kernel periodically prints the boot time every 100ms.
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
> 1) It feels like we are curing a symptom for which we don't know the cause.
>    Which RCU write side caller is the source of this slow boot? Some tracepoints
>    reporting the wait duration within synchronize_rcu() calls between the end of
>    the kernel boot and the end of userspace boot may be helpful.
>    
> 2) The kernel boot was already covered before this patch so this is about
>    userspace code calling into the kernel. Is that piece of code also called
>    after the boot? In that case are we missing a conversion from
>    synchronize_rcu() to synchronize_rcu_expedited() somewhere? Because then
>    the problem is more general than just boot.
> 
> This needs to be analyzed first and if it happens that the issue really
> needs to be fixed with telling the kernel that userspace has completed
> booting, eg: because the problem is not in a few callsites that need conversion
> to expedited but instead in the accumulation of lots of calls that should stay
> as is:
> 
> 3) This arbitrary timeout looks dangerous to me as latency sensitive code
>    may run right after the boot. Either you choose a value that is too low
>    and you miss the optimization or the value is too high and you may break
>    things.
> 
> 4) This should be fixed the way you did:
>    a) a kernel parameter like you did
>    b) The init process (systemd?) tells the kernel when it judges that userspace
>       has completed booting.
>    c) Make these interfaces more generic, maybe that information will be useful
>       outside RCU. For example the kernel parameter should be
>       "user_booted_reported" and the sysfs (should be sysctl?):
>       kernel.user_booted = 1
>    d) But yuck, this means we must know if the init process supports that...
> 
> For these reasons, let's make sure we know exactly what is going on first.
> 
> Thanks.
Just add some notes and thoughts. There is a rcupdate.rcu_expedited=1
parameter that can be used during the boot. For example on our devices
to speedup a boot we boot the kernel with rcu_expedited:

XQ-DQ54:/ # cat /proc/cmdline
stack_depot_disable=on kasan.stacktrace=off kvm-arm.mode=protected cgroup_disable=pressure console=ttyMSM0,115200n8 loglevel=6 kpti=0 log_buf_len=256K kernel.panic_on_rcu_stall=1 service_locator.enable=1 msm_rtb.filter=0x237 rcupdate.rcu_expedited=1 rcu_nocbs=0-7 ftrace_dump_on_oops swiotlb=noforce loop.max_part=7 fw_devlink.strict=1 allow_mismatched_32bit_el0 cpufreq.default_governor=performance printk.console_no_auto_verbose=1 kasan=off sysctl.kernel.sched_pelt_multiplier=4 can.stats_timer=0 pcie_ports=compat irqaffinity=0-2 disable_dma32=on no-steal-acc cgroup.memory=nokmem,nosocket video=vfb:640x400,bpp=32,memsize=3072000 page_owner=on stack_depot_disable=off printk.console_no_auto_verbose=0 nosoftlockup bootconfig buildvariant=userdebug  msm_drm.dsi_display0=somc,1_panel: rootwait ro init=/init  qcom_geni_serial.con_enabled=0 oembootloader.startup=0x00000001 oembootloader.warmboot=0x00000000 oembootloader.securityflags=0x00000001
XQ-DQ54:/ #

then a user space can decides if it is needed or not:

<snip>
rcu_expedited  rcu_normal
XQ-DQ54:/ # ls -al /sys/kernel/rcu_*
-rw-r--r-- 1 root root 4096 2023-02-16 09:27 /sys/kernel/rcu_expedited
-rw-r--r-- 1 root root 4096 2023-02-16 09:27 /sys/kernel/rcu_normal
XQ-DQ54:/ #
<snip>

for lazy we can add "rcu_cb_lazy" parameter and boot the kernel with
true or false. So we can follow and be aligned with rcu_expedited and
rcu_normal parameters.

--
Uladzislau Rezki
