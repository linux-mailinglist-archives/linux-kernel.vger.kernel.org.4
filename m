Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 919856B032A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 10:41:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbjCHJlo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 04:41:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjCHJlg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 04:41:36 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 314FBB2571;
        Wed,  8 Mar 2023 01:41:25 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id b10so16000362ljr.0;
        Wed, 08 Mar 2023 01:41:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678268483;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PNReZ4sapT5f1+mBpJgB+af7Ul1owO+DsCyA93X2HKY=;
        b=cn0f4JKD+GtWLq8gupCO2j3KUVaco8Pi6PVwyDsO54nWOAKZ6v0uk5+r8ZnezE3fvP
         6K3j7jWUyE70nw3IERgXY1TPqPS1CCkz3IApXzh/yI07+5MoP+cz4n1xuC7AIBLXAqYM
         LrxjaKg6bXNyYa+ABIYxMPSeyLvbLwfpxsjUrG9v+EmRyCDN0hBbj8qFUkucPdrv4l0b
         QI3/XdL9P5rCnLBRDm3ZpAMK39ZNqa+tTn0e3u2+xkzS31RSe/upE6rEsqx9rAJJH2wF
         llILDzv2eAJIqB3umwrlLHWHmlST857W4F7cI+7Ct8+LNLzYTY+JVKB+Cs3Q+voWXkKm
         YjKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678268483;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PNReZ4sapT5f1+mBpJgB+af7Ul1owO+DsCyA93X2HKY=;
        b=Sy0+gDv9t3LkqODvsl+W08rXYl7sywBek6o+OvABMNXunsqpvCw5PaJcbXRcEFmSCT
         QTX06f1eQoLTGyKYIc7KKADUJ3uas4AxuXafbLD50gu/zZdFd4nNeDcq7/qXFSooG17M
         KmNzHq4GxdICvrQnaIc95SeRyw1Uy0W93ZbkVuvb7HKZOgCXyu60He9jLTQUyctQVIf9
         vtIGEw+a/e2jxxW2wc2P3aWuieo4QhdAWKx+iIgXBEdQuilODL2lGXm9lHHUBREShZ37
         Mau9dVJv0OkxwB0uG0kfXvuKy+X8h8Gnz0uNhV/fUvLfys1Hm12eiAHRWt5Gxug1V4bl
         PbvQ==
X-Gm-Message-State: AO0yUKUOIPjJWdv5JJIAEBV8C6pdSJhfOXLT/L4v0vZFmlU32gTnxVhZ
        ajqQ+hzZEQibxLqCH1aS1U3JEjbUXcO7tA==
X-Google-Smtp-Source: AK7set+NmrjshoP62LKX9PZu19CrFO06c52I2ml6Jp1or8d6w+Zh6JifufTOKvHNlJZ6e+bo094qww==
X-Received: by 2002:a05:651c:513:b0:295:9659:fba5 with SMTP id o19-20020a05651c051300b002959659fba5mr7185719ljp.37.1678268483249;
        Wed, 08 Mar 2023 01:41:23 -0800 (PST)
Received: from pc636 (host-95-193-108-241.mobileonline.telia.com. [95.193.108.241])
        by smtp.gmail.com with ESMTPSA id q25-20020ac25119000000b004e670ce364bsm2281570lfb.277.2023.03.08.01.41.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 01:41:22 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Wed, 8 Mar 2023 10:41:19 +0100
To:     "Paul E. McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        linux-kernel@vger.kernel.org, Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-doc@vger.kernel.org, rcu@vger.kernel.org
Subject: Re: [PATCH v3] rcu: Add a minimum time for marking boot as completed
Message-ID: <ZAhYP9a8u05hzsOn@pc636>
References: <20230303213851.2090365-1-joel@joelfernandes.org>
 <ZAc1wsvd4trjP/xi@lothringen>
 <ZAc+vVZUhXdhpSki@pc636>
 <CAEXW_YRTLQpQpOW-+n+X59pmB=4TkV=gdsMiQfBkdK_4wO9Jug@mail.gmail.com>
 <20230307173313.GJ1301832@paulmck-ThinkPad-P17-Gen-1>
 <20230307185443.GA516865@google.com>
 <20230307192726.GL1301832@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230307192726.GL1301832@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 07, 2023 at 11:27:26AM -0800, Paul E. McKenney wrote:
> On Tue, Mar 07, 2023 at 06:54:43PM +0000, Joel Fernandes wrote:
> > On Tue, Mar 07, 2023 at 09:33:13AM -0800, Paul E. McKenney wrote:
> > > On Tue, Mar 07, 2023 at 08:48:52AM -0500, Joel Fernandes wrote:
> > > > On Tue, Mar 7, 2023 at 8:40 AM Uladzislau Rezki <urezki@gmail.com> wrote:
> > > > >
> > > > > On Tue, Mar 07, 2023 at 02:01:54PM +0100, Frederic Weisbecker wrote:
> > > > > > On Fri, Mar 03, 2023 at 09:38:51PM +0000, Joel Fernandes (Google) wrote:
> > > > > > > On many systems, a great deal of boot (in userspace) happens after the
> > > > > > > kernel thinks the boot has completed. It is difficult to determine if
> > > > > > > the system has really booted from the kernel side. Some features like
> > > > > > > lazy-RCU can risk slowing down boot time if, say, a callback has been
> > > > > > > added that the boot synchronously depends on. Further expedited callbacks
> > > > > > > can get unexpedited way earlier than it should be, thus slowing down
> > > > > > > boot (as shown in the data below).
> > > > > > >
> > > > > > > For these reasons, this commit adds a config option
> > > > > > > 'CONFIG_RCU_BOOT_END_DELAY' and a boot parameter rcupdate.boot_end_delay.
> > > > > > > Userspace can also make RCU's view of the system as booted, by writing the
> > > > > > > time in milliseconds to: /sys/module/rcupdate/parameters/rcu_boot_end_delay
> > > > > > > Or even just writing a value of 0 to this sysfs node.
> > > > > > > However, under no circumstance will the boot be allowed to end earlier
> > > > > > > than just before init is launched.
> > > > > > >
> > > > > > > The default value of CONFIG_RCU_BOOT_END_DELAY is chosen as 15s. This
> > > > > > > suites ChromeOS and also a PREEMPT_RT system below very well, which need
> > > > > > > no config or parameter changes, and just a simple application of this patch. A
> > > > > > > system designer can also choose a specific value here to keep RCU from marking
> > > > > > > boot completion.  As noted earlier, RCU's perspective of the system as booted
> > > > > > > will not be marker until at least rcu_boot_end_delay milliseconds have passed
> > > > > > > or an update is made via writing a small value (or 0) in milliseconds to:
> > > > > > > /sys/module/rcupdate/parameters/rcu_boot_end_delay.
> > > > > > >
> > > > > > > One side-effect of this patch is, there is a risk that a real-time workload
> > > > > > > launched just after the kernel boots will suffer interruptions due to expedited
> > > > > > > RCU, which previous ended just before init was launched. However, to mitigate
> > > > > > > such an issue (however unlikely), the user should either tune
> > > > > > > CONFIG_RCU_BOOT_END_DELAY to a smaller value than 15 seconds or write a value
> > > > > > > of 0 to /sys/module/rcupdate/parameters/rcu_boot_end_delay, once userspace
> > > > > > > boots, and before launching the real-time workload.
> > > > > > >
> > > > > > > Qiuxu also noted impressive boot-time improvements with earlier version
> > > > > > > of patch. An excerpt from the data he shared:
> > > > > > >
> > > > > > > 1) Testing environment:
> > > > > > >     OS            : CentOS Stream 8 (non-RT OS)
> > > > > > >     Kernel     : v6.2
> > > > > > >     Machine : Intel Cascade Lake server (2 sockets, each with 44 logical threads)
> > > > > > >     Qemu  args  : -cpu host -enable-kvm, -smp 88,threads=2,sockets=2, …
> > > > > > >
> > > > > > > 2) OS boot time definition:
> > > > > > >     The time from the start of the kernel boot to the shell command line
> > > > > > >     prompt is shown from the console. [ Different people may have
> > > > > > >     different OS boot time definitions. ]
> > > > > > >
> > > > > > > 3) Measurement method (very rough method):
> > > > > > >     A timer in the kernel periodically prints the boot time every 100ms.
> > > > > > >     As soon as the shell command line prompt is shown from the console,
> > > > > > >     we record the boot time printed by the timer, then the printed boot
> > > > > > >     time is the OS boot time.
> > > > > > >
> > > > > > > 4) Measured OS boot time (in seconds)
> > > > > > >    a) Measured 10 times w/o this patch:
> > > > > > >         8.7s, 8.4s, 8.6s, 8.2s, 9.0s, 8.7s, 8.8s, 9.3s, 8.8s, 8.3s
> > > > > > >         The average OS boot time was: ~8.7s
> > > > > > >
> > > > > > >    b) Measure 10 times w/ this patch:
> > > > > > >         8.5s, 8.2s, 7.6s, 8.2s, 8.7s, 8.2s, 7.8s, 8.2s, 9.3s, 8.4s
> > > > > > >         The average OS boot time was: ~8.3s.
> > > > > > >
> > > > > > > Tested-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> > > > > > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > > > >
> > > > > > I still don't really like that:
> > > > > >
> > > > > > 1) It feels like we are curing a symptom for which we don't know the cause.
> > > > > >    Which RCU write side caller is the source of this slow boot? Some tracepoints
> > > > > >    reporting the wait duration within synchronize_rcu() calls between the end of
> > > > > >    the kernel boot and the end of userspace boot may be helpful.
> > > > > >
> > > > > > 2) The kernel boot was already covered before this patch so this is about
> > > > > >    userspace code calling into the kernel. Is that piece of code also called
> > > > > >    after the boot? In that case are we missing a conversion from
> > > > > >    synchronize_rcu() to synchronize_rcu_expedited() somewhere? Because then
> > > > > >    the problem is more general than just boot.
> > > > > >
> > > > > > This needs to be analyzed first and if it happens that the issue really
> > > > > > needs to be fixed with telling the kernel that userspace has completed
> > > > > > booting, eg: because the problem is not in a few callsites that need conversion
> > > > > > to expedited but instead in the accumulation of lots of calls that should stay
> > > > > > as is:
> > > > > >
> > > > > > 3) This arbitrary timeout looks dangerous to me as latency sensitive code
> > > > > >    may run right after the boot. Either you choose a value that is too low
> > > > > >    and you miss the optimization or the value is too high and you may break
> > > > > >    things.
> > > > > >
> > > > > > 4) This should be fixed the way you did:
> > > > > >    a) a kernel parameter like you did
> > > > > >    b) The init process (systemd?) tells the kernel when it judges that userspace
> > > > > >       has completed booting.
> > > > > >    c) Make these interfaces more generic, maybe that information will be useful
> > > > > >       outside RCU. For example the kernel parameter should be
> > > > > >       "user_booted_reported" and the sysfs (should be sysctl?):
> > > > > >       kernel.user_booted = 1
> > > > > >    d) But yuck, this means we must know if the init process supports that...
> > > > > >
> > > > > > For these reasons, let's make sure we know exactly what is going on first.
> > > > > >
> > > > > > Thanks.
> > > > > Just add some notes and thoughts. There is a rcupdate.rcu_expedited=1
> > > > > parameter that can be used during the boot. For example on our devices
> > > > > to speedup a boot we boot the kernel with rcu_expedited:
> > > > >
> > > > > XQ-DQ54:/ # cat /proc/cmdline
> > > > > XQ-DQ54:/ #
> > > > >
> > > > > then a user space can decides if it is needed or not:
> > > > >
> > > > > <snip>
> > > > > rcu_expedited  rcu_normal
> > > > > XQ-DQ54:/ # ls -al /sys/kernel/rcu_*
> > > > > -rw-r--r-- 1 root root 4096 2023-02-16 09:27 /sys/kernel/rcu_expedited
> > > > > -rw-r--r-- 1 root root 4096 2023-02-16 09:27 /sys/kernel/rcu_normal
> > > > > XQ-DQ54:/ #
> > > > > <snip>
> > > > >
> > > > > for lazy we can add "rcu_cb_lazy" parameter and boot the kernel with
> > > > > true or false. So we can follow and be aligned with rcu_expedited and
> > > > > rcu_normal parameters.
> > > > 
> > > > Speaking of aligning, there is also the automated
> > > > rcu_normal_after_boot boot option correct? I prefer the automated
> > > > option of doing this. So the approach here is not really unprecedented
> > > > and is much more robust than relying on userspace too much (I am ok
> > > > with adding your suggestion *on top* of the automated toggle, but I
> > > > probably would not have ChromeOS use it if the automated way exists).
> > > > Or did I miss something?
> > > 
> > > See this commit:
> > > 
> > > 3705b88db0d7cc ("rcu: Add a module parameter to force use of expedited RCU primitives")
> > > 
> > > Antti provided this commit precisely in order to allow Android devices
> > > to expedite the boot process and to shut off the expediting at a time of
> > > Android userspace's choosing.  So Android has been making this work for
> > > about ten years, which strikes me as an adequate proof of concept.  ;-)
> > 
> > Thanks for the pointer. That's true. Looking at Android sources, I find that
> > Android Mediatek devices at least are setting rcu_expedited to 1 at late
> > stage of their userspace boot (which is weird, it should be set to 1 as early
> > as possible), and interestingly I cannot find them resetting it back to 0!.
> > Maybe they set rcu_normal to 1? But I cannot find that either. Vlad? :P
> 
> Interesting.  Though this is consistent with Antti's commit log, where
> he talks about expediting grace periods but not unexpediting them.
> 
Do you think we need to unexpedite it? :))))

--
Uladzislau Rezki
