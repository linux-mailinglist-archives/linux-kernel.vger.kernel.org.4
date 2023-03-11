Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A54A6B6175
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 23:24:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbjCKWYC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 17:24:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjCKWX7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 17:23:59 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2E5A4B83C
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 14:23:56 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id l18so9694511qtp.1
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 14:23:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1678573436;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+/kGUjteHg3feUraWwyhQvXUit2eAqxZXY9ELpsZpXI=;
        b=fz19Rf4OZd2XEItVh1oSfTaiUeJWYqACdTAjvfb3MLf+XGL1tpdDdIQT0xvL8fAZsK
         aaKaa8j1BdtsEY1KoS4HjqwLyL+dVkI9n1cjgi/Gyv7m6/9xxUVrBE8D26bSMQffcqxN
         kPxHUQAifSiQgv4X2O2rdoPbXfUEi91meVfTo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678573436;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+/kGUjteHg3feUraWwyhQvXUit2eAqxZXY9ELpsZpXI=;
        b=nd/ppr3Nwxr0q3cOLbCeUoWx5hfORU6lkL4nYZUi6zeXu3WlqQfRF6L5ajJfSJ1dXG
         F/uiIV603Y1RrVvyvg2Z9xOgDA/xp+k3KyC8L/wQvz229/Pspeo0qmLTs4gSauKCkqRd
         dpLDUrer5uBkGnZMGDJ9IZngb0c3tIlTiWVuxo5rX9OO0s4QdpWeVZcse0NSHMOLEXHe
         WK3VLaN03qkdDnMSZmmObJ5KnO4jlyzwK8zTNwY+wlFr6wsoLBROzJ3UJ6aU3nlsd0qD
         z04d/idtcmu9CfkEWtbWp+A71TpkP2rZkzG/hs1zOU+3fWrkWi+uxT6GcKx0tobgLkLM
         bazQ==
X-Gm-Message-State: AO0yUKWwI45ZBvZBmrZMhYFNnOqhu7EpqZKIjWqJqD+oW154qKxGzmWo
        QsjnPzqA5llXPcOQ0GNjn0q8eQ==
X-Google-Smtp-Source: AK7set8P3EYfAiru3GoMdrMmbmAiz3gwXDglQke5zzBcOnD5MZqA/rJdyXoBZVLG3tKdV2SlNzijAA==
X-Received: by 2002:a05:622a:108:b0:3b9:bca3:d93d with SMTP id u8-20020a05622a010800b003b9bca3d93dmr49725129qtw.22.1678573435641;
        Sat, 11 Mar 2023 14:23:55 -0800 (PST)
Received: from localhost (129.239.188.35.bc.googleusercontent.com. [35.188.239.129])
        by smtp.gmail.com with ESMTPSA id 19-20020ac85613000000b003bffe7fdc38sm2610372qtr.9.2023.03.11.14.23.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Mar 2023 14:23:55 -0800 (PST)
Date:   Sat, 11 Mar 2023 22:23:54 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-doc@vger.kernel.org, rcu@vger.kernel.org, urezki@gmail.com
Subject: Re: [PATCH v3] rcu: Add a minimum time for marking boot as completed
Message-ID: <20230311222354.GA2367813@google.com>
References: <20230303213851.2090365-1-joel@joelfernandes.org>
 <20230304010251.GD1301832@paulmck-ThinkPad-P17-Gen-1>
 <20230304045145.GD2176990@google.com>
 <a9e974d1-2b83-44bc-ab2e-56ef9511c2ef@paulmck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a9e974d1-2b83-44bc-ab2e-56ef9511c2ef@paulmck-laptop>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 11, 2023 at 12:44:53PM -0800, Paul E. McKenney wrote:
> On Sat, Mar 04, 2023 at 04:51:45AM +0000, Joel Fernandes wrote:
> > Hi Paul,
> > 
> > On Fri, Mar 03, 2023 at 05:02:51PM -0800, Paul E. McKenney wrote:
> > [..]
> > > > Qiuxu also noted impressive boot-time improvements with earlier version
> > > > of patch. An excerpt from the data he shared:
> 
> Now that we have the measurement methodology put to bed...
> 
> [ . . . ]
> 
> > > Mightn't this be simpler if the user was only permitted to write zero,
> > > thus just saying "stop immediately"?  If people really need the ability
> > > to extend or shorten the time, a patch can be produced at that point.
> > > And then a non-zero write to the file would become legal.
> > 
> > I prefer to keep it this way as with this method, I can not only get to
> > have variable rcu_boot_end_delay via boot parameter (as in my first patch), I
> > also don't need to add a separate sysfs entry, and can just reuse
> > 'rcu_boot_end_delay' parameter, which I also had in my first patch. And
> > adding yet another sysfs parameter will actually complicate it even more and
> > add more lines of code.
> > 
> > I tested difference scenarios and it works fine, though I missed that
> > mutex locking unfortunately, I did verify different test cases work as
> > expected by manual testing.
> 
> Except that you don't need that extra sysfs value.  You could instead use
> any of a number of state variables that tell you that early boot is done.
> If the state says early boot (as in parsing the kernel command line),
> make the code act as it does now.  Otherwise, make it accept only zero.
> 
> If there really is some system that wants to set one time limit via
> the kernel boot parameter and set another at some time during boot,
> there are very simple userspace facilities to make this happen.
> 
> And there is also a smaller state space and less testing to be done,
> benefits which accrue on an ongoing basis.

Ok, thanks for the suggestion and I will consider it when/if posting the next
revision of this idea. I got strong pushback from Frederic, Vlad and Steven
Rostedt on doing the timeout-based thing, so currently I am analyzing the
boot process more to see if it could be optimized instead. I tend to agree
with them now also because this feature is new and there could be bugs that
this patch might hide..

thanks,

 - Joel


> 
> 							Thanx, Paul
> 
> > Here are some printks and on simple testing in Qemu:
> > 
> > 1. End the boot early, CONFIG is set to 120 seconds:
> > ==================================================
> > [    1.614968] rcu_boot_end_delay = 120000
> > [    1.617630] schedule delayed work joel
> > 
> > Boot took 1.57 seconds
> > root@(none):/# cat /sys/module/rcupdate/parameters/rcu_boot_end_delay
> > 120000
> > root@(none):/#
> > root@(none):/#
> > root@(none):/# echo 0 > /sys/module/rcupdate/parameters/rcu_boot_end_delay
> > [   10.108394] param called joel
> > [   10.110520] sys calling boot ended
> > [   10.112730] rcu_boot_end_delay = 0
> > [   10.115017] boot ended joel
> > -----------------------------------------------
> > 
> > 2. End the boot passing in rcupdate.rcu_boot_end_delay as 10s.
> >    This should overwride the CONFIG of 120 seconds:
> > ==================================================
> > [    1.700090] rcu_boot_end_delay = 10000
> > [    1.702628] schedule delayed work joel
> > 
> > Boot took 1.64 seconds
> > 
> > root@(none):/# [   10.414008] rcu_boot_end_delay = 10000
> > [   10.416670] boot ended joel
> > -----------------------------------------------
> > 
> > 3. Do the same thing as #2, but extend the boot via sysfs to be longer than
> > 10 seconds:
> > ==================================================
> > [    0.060025] param called joel
> > [    0.060026] param called too early joel
> > [    1.663905] rcu_boot_end_delay = 10000
> > [    1.667051] schedule delayed work joel
> > 
> > Boot took 1.61 seconds
> > 
> > root@(none):/#
> > root@(none):/# echo 20000 > /sys/module/rcupdate/parameters/rcu_boot_end_delay
> > [    6.932517] param called joel
> > [    6.934637] sys calling boot ended
> > [    6.936845] rcu_boot_end_delay = 20000
> > [    6.939291] schedule delayed work joel
> > root@(none):/# [   10.389366] rcu_boot_end_delay = 20000
> > [   10.392047] schedule delayed work joel
> > [   20.117416] rcu_boot_end_delay = 20000
> > [   20.120073] boot ended joel
> > -----------------------------------------------
> > 
> > The debug patch is here: https://git.kernel.org/pub/scm/linux/kernel/git/jfern/linux.git/commit/?h=rcu/lazy/postboot
> > 
> > Appended is the updated v4 patch, tested as shown above, more testing is in progress.
> > 
> > thanks,
> > 
> >  - Joel
> > 
> > ---8<-----------------------
> > 
> > From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
> > Subject: [PATCH v4] rcu: Add a minimum time for marking boot as completed
> > 
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
> > option-prefix PATCH v4
> > option-start
> > Tested-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > 
> > diff-note-start
> > v1->v2:
> > 	Update some comments and description.
> > v2->v3:
> >         Add sysfs param, and update with Test data.
> > v3->v4:
> >         Fix locking bug found by Paul, make code more robust
> >         by refactoring locking code.
> >         Doc updates.
> > ---
> >  .../admin-guide/kernel-parameters.txt         | 15 ++++
> >  cc_list                                       |  8 ++
> >  kernel/rcu/Kconfig                            | 21 ++++++
> >  kernel/rcu/update.c                           | 74 ++++++++++++++++++-
> >  4 files changed, 116 insertions(+), 2 deletions(-)
> >  create mode 100644 cc_list
> > 
> > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > index 2429b5e3184b..878c2780f5db 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -5085,6 +5085,21 @@
> >  	rcutorture.verbose= [KNL]
> >  			Enable additional printk() statements.
> >  
> > +	rcupdate.rcu_boot_end_delay= [KNL]
> > +			Minimum time in milliseconds from the start of boot
> > +			that must elapse before the boot sequence can be marked
> > +			complete from RCU's perspective, after which RCU's
> > +			behavior becomes more relaxed. The default value is also
> > +			configurable via CONFIG_RCU_BOOT_END_DELAY.
> > +			Userspace can also mark the boot as completed
> > +			sooner by writing the time in milliseconds, say once
> > +			userspace considers the system as booted, to:
> > +			/sys/module/rcupdate/parameters/rcu_boot_end_delay
> > +			Or even just writing a value of 0 to this sysfs node.
> > +			The sysfs node can also be used to extend the delay
> > +			to be larger than the default, assuming the marking
> > +			of boot complete has not yet occurred.
> > +
> >  	rcupdate.rcu_cpu_stall_ftrace_dump= [KNL]
> >  			Dump ftrace buffer after reporting RCU CPU
> >  			stall warning.
> > diff --git a/cc_list b/cc_list
> > new file mode 100644
> > index 000000000000..7daed4877f5a
> > --- /dev/null
> > +++ b/cc_list
> > @@ -0,0 +1,8 @@
> > +Frederic Weisbecker <frederic@kernel.org>
> > +Joel Fernandes <joel@joelfernandes.org>
> > +Lai Jiangshan <jiangshanlai@gmail.com>
> > +linux-doc@vger.kernel.org
> > +linux-kernel@vger.kernel.org
> > +"Paul E. McKenney" <paulmck@kernel.org>
> > +rcu@vger.kernel.org
> > +urezki@gmail.com
> > diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
> > index 9071182b1284..97f68120d1c0 100644
> > --- a/kernel/rcu/Kconfig
> > +++ b/kernel/rcu/Kconfig
> > @@ -217,6 +217,27 @@ config RCU_BOOST_DELAY
> >  
> >  	  Accept the default if unsure.
> >  
> > +config RCU_BOOT_END_DELAY
> > +	int "Minimum time before RCU may consider in-kernel boot as completed"
> > +	range 0 120000
> > +	default 15000
> > +	help
> > +	  Default value of the minimum time in milliseconds from the start of boot
> > +	  that must elapse before the boot sequence can be marked complete from RCU's
> > +	  perspective, after which RCU's behavior becomes more relaxed.
> > +	  Userspace can also mark the boot as completed sooner than this default
> > +	  by writing the time in milliseconds, say once userspace considers
> > +	  the system as booted, to: /sys/module/rcupdate/parameters/rcu_boot_end_delay.
> > +	  Or even just writing a value of 0 to this sysfs node. The sysfs node can
> > +	  also be used to extend the delay to be larger than the default, assuming
> > +	  the marking of boot completion has not yet occurred.
> > +
> > +	  The actual delay for RCU's view of the system to be marked as booted can be
> > +	  higher than this value if the kernel takes a long time to initialize but it
> > +	  will never be smaller than this value.
> > +
> > +	  Accept the default if unsure.
> > +
> >  config RCU_EXP_KTHREAD
> >  	bool "Perform RCU expedited work in a real-time kthread"
> >  	depends on RCU_BOOST && RCU_EXPERT
> > diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
> > index 19bf6fa3ee6a..18ed3c15e6b5 100644
> > --- a/kernel/rcu/update.c
> > +++ b/kernel/rcu/update.c
> > @@ -224,13 +224,50 @@ void rcu_unexpedite_gp(void)
> >  }
> >  EXPORT_SYMBOL_GPL(rcu_unexpedite_gp);
> >  
> > +/*
> > + * Minimum time in milliseconds from the start boot until RCU can consider
> > + * in-kernel boot as completed.  This can also be tuned at runtime to end the
> > + * boot earlier, by userspace init code writing the time in milliseconds (even
> > + * 0) to: /sys/module/rcupdate/parameters/rcu_boot_end_delay. The sysfs node
> > + * can also be used to extend the delay to be larger than the default, assuming
> > + * the marking of boot complete has not yet occurred.
> > + */
> > +static int rcu_boot_end_delay = CONFIG_RCU_BOOT_END_DELAY;
> > +
> >  static bool rcu_boot_ended __read_mostly;
> > +static bool rcu_boot_end_called __read_mostly;
> > +static DEFINE_MUTEX(rcu_boot_end_lock);
> >  
> >  /*
> > - * Inform RCU of the end of the in-kernel boot sequence.
> > + * Inform RCU of the end of the in-kernel boot sequence. The boot sequence will
> > + * not be marked ended until at least rcu_boot_end_delay milliseconds have passed.
> >   */
> > -void rcu_end_inkernel_boot(void)
> > +void rcu_end_inkernel_boot(void);
> > +static void rcu_boot_end_work_fn(struct work_struct *work)
> > +{
> > +	rcu_end_inkernel_boot();
> > +}
> > +static DECLARE_DELAYED_WORK(rcu_boot_end_work, rcu_boot_end_work_fn);
> > +
> > +/* Must be called with rcu_boot_end_lock held. */
> > +static void rcu_end_inkernel_boot_locked(void)
> >  {
> > +	rcu_boot_end_called = true;
> > +
> > +	if (rcu_boot_ended)
> > +		return;
> > +
> > +	if (rcu_boot_end_delay) {
> > +		u64 boot_ms = div_u64(ktime_get_boot_fast_ns(), 1000000UL);
> > +
> > +		if (boot_ms < rcu_boot_end_delay) {
> > +			schedule_delayed_work(&rcu_boot_end_work,
> > +					rcu_boot_end_delay - boot_ms);
> > +			return;
> > +		}
> > +	}
> > +
> > +	cancel_delayed_work(&rcu_boot_end_work);
> >  	rcu_unexpedite_gp();
> >  	rcu_async_relax();
> >  	if (rcu_normal_after_boot)
> > @@ -238,6 +275,39 @@ void rcu_end_inkernel_boot(void)
> >  	rcu_boot_ended = true;
> >  }
> >  
> > +void rcu_end_inkernel_boot(void)
> > +{
> > +	mutex_lock(&rcu_boot_end_lock);
> > +	rcu_end_inkernel_boot_locked();
> > +	mutex_unlock(&rcu_boot_end_lock);
> > +}
> > +
> > +static int param_set_rcu_boot_end(const char *val, const struct kernel_param *kp)
> > +{
> > +	uint end_ms;
> > +	int ret = kstrtouint(val, 0, &end_ms);
> > +
> > +	if (ret)
> > +		return ret;
> > +	/*
> > +	 * rcu_end_inkernel_boot() should be called at least once during init
> > +	 * before we can allow param changes to end the boot.
> > +	 */
> > +	mutex_lock(&rcu_boot_end_lock);
> > +	rcu_boot_end_delay = end_ms;
> > +	if (!rcu_boot_ended && rcu_boot_end_called) {
> > +		rcu_end_inkernel_boot_locked();
> > +	}
> > +	mutex_unlock(&rcu_boot_end_lock);
> > +	return ret;
> > +}
> > +
> > +static const struct kernel_param_ops rcu_boot_end_ops = {
> > +	.set = param_set_rcu_boot_end,
> > +	.get = param_get_uint,
> > +};
> > +module_param_cb(rcu_boot_end_delay, &rcu_boot_end_ops, &rcu_boot_end_delay, 0644);
> > +
> >  /*
> >   * Let rcutorture know when it is OK to turn it up to eleven.
> >   */
> > -- 
> > 2.40.0.rc0.216.gc4246ad0f0-goog
> > 
