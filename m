Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B74D36B6097
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 21:45:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbjCKUo6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 15:44:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbjCKUo5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 15:44:57 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 141CB498AE;
        Sat, 11 Mar 2023 12:44:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8C5CB60DD8;
        Sat, 11 Mar 2023 20:44:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB721C433EF;
        Sat, 11 Mar 2023 20:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678567493;
        bh=aNjUrBLAQjEI0WquHparWO+QOAGNS9UwSMxSsJZKeCE=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=R7LRLTELy/k8FS0FNQ10tuTLXV1o+ouuQf5+GHqVJBLoOd+wcpaNg/1ZoujLJOLHn
         Tfyk7VbC6MDQ6nKU9Ivpju/0QnxaVtavOUvvighBHLHfoJKb/KQe1fVQ260Xz7v6Vf
         GwTmMBybKO5Iz2oAWGQK8M3kzje8Bb6W6ooLdhivAsQBlavUflOoJ2K5oFR5aWw1e2
         o6ZM4PMZUAMBPPHDOmhTV0jBwlg74naWlWNRZcIMmjezaGdYi03RYQm2qRBcxLP8g9
         l8892BSS+o9p0UN2jOH60tT4csYMqz2zAG62ZG50H9tGuyJmpzFRxnSYon/wStF4XE
         uPgIJVlUk5uFQ==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 7241C154037F; Sat, 11 Mar 2023 12:44:53 -0800 (PST)
Date:   Sat, 11 Mar 2023 12:44:53 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-doc@vger.kernel.org, rcu@vger.kernel.org, urezki@gmail.com
Subject: Re: [PATCH v3] rcu: Add a minimum time for marking boot as completed
Message-ID: <a9e974d1-2b83-44bc-ab2e-56ef9511c2ef@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230303213851.2090365-1-joel@joelfernandes.org>
 <20230304010251.GD1301832@paulmck-ThinkPad-P17-Gen-1>
 <20230304045145.GD2176990@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230304045145.GD2176990@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 04, 2023 at 04:51:45AM +0000, Joel Fernandes wrote:
> Hi Paul,
> 
> On Fri, Mar 03, 2023 at 05:02:51PM -0800, Paul E. McKenney wrote:
> [..]
> > > Qiuxu also noted impressive boot-time improvements with earlier version
> > > of patch. An excerpt from the data he shared:

Now that we have the measurement methodology put to bed...

[ . . . ]

> > Mightn't this be simpler if the user was only permitted to write zero,
> > thus just saying "stop immediately"?  If people really need the ability
> > to extend or shorten the time, a patch can be produced at that point.
> > And then a non-zero write to the file would become legal.
> 
> I prefer to keep it this way as with this method, I can not only get to
> have variable rcu_boot_end_delay via boot parameter (as in my first patch), I
> also don't need to add a separate sysfs entry, and can just reuse
> 'rcu_boot_end_delay' parameter, which I also had in my first patch. And
> adding yet another sysfs parameter will actually complicate it even more and
> add more lines of code.
> 
> I tested difference scenarios and it works fine, though I missed that
> mutex locking unfortunately, I did verify different test cases work as
> expected by manual testing.

Except that you don't need that extra sysfs value.  You could instead use
any of a number of state variables that tell you that early boot is done.
If the state says early boot (as in parsing the kernel command line),
make the code act as it does now.  Otherwise, make it accept only zero.

If there really is some system that wants to set one time limit via
the kernel boot parameter and set another at some time during boot,
there are very simple userspace facilities to make this happen.

And there is also a smaller state space and less testing to be done,
benefits which accrue on an ongoing basis.

							Thanx, Paul

> Here are some printks and on simple testing in Qemu:
> 
> 1. End the boot early, CONFIG is set to 120 seconds:
> ==================================================
> [    1.614968] rcu_boot_end_delay = 120000
> [    1.617630] schedule delayed work joel
> 
> Boot took 1.57 seconds
> root@(none):/# cat /sys/module/rcupdate/parameters/rcu_boot_end_delay
> 120000
> root@(none):/#
> root@(none):/#
> root@(none):/# echo 0 > /sys/module/rcupdate/parameters/rcu_boot_end_delay
> [   10.108394] param called joel
> [   10.110520] sys calling boot ended
> [   10.112730] rcu_boot_end_delay = 0
> [   10.115017] boot ended joel
> -----------------------------------------------
> 
> 2. End the boot passing in rcupdate.rcu_boot_end_delay as 10s.
>    This should overwride the CONFIG of 120 seconds:
> ==================================================
> [    1.700090] rcu_boot_end_delay = 10000
> [    1.702628] schedule delayed work joel
> 
> Boot took 1.64 seconds
> 
> root@(none):/# [   10.414008] rcu_boot_end_delay = 10000
> [   10.416670] boot ended joel
> -----------------------------------------------
> 
> 3. Do the same thing as #2, but extend the boot via sysfs to be longer than
> 10 seconds:
> ==================================================
> [    0.060025] param called joel
> [    0.060026] param called too early joel
> [    1.663905] rcu_boot_end_delay = 10000
> [    1.667051] schedule delayed work joel
> 
> Boot took 1.61 seconds
> 
> root@(none):/#
> root@(none):/# echo 20000 > /sys/module/rcupdate/parameters/rcu_boot_end_delay
> [    6.932517] param called joel
> [    6.934637] sys calling boot ended
> [    6.936845] rcu_boot_end_delay = 20000
> [    6.939291] schedule delayed work joel
> root@(none):/# [   10.389366] rcu_boot_end_delay = 20000
> [   10.392047] schedule delayed work joel
> [   20.117416] rcu_boot_end_delay = 20000
> [   20.120073] boot ended joel
> -----------------------------------------------
> 
> The debug patch is here: https://git.kernel.org/pub/scm/linux/kernel/git/jfern/linux.git/commit/?h=rcu/lazy/postboot
> 
> Appended is the updated v4 patch, tested as shown above, more testing is in progress.
> 
> thanks,
> 
>  - Joel
> 
> ---8<-----------------------
> 
> From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
> Subject: [PATCH v4] rcu: Add a minimum time for marking boot as completed
> 
> On many systems, a great deal of boot (in userspace) happens after the
> kernel thinks the boot has completed. It is difficult to determine if
> the system has really booted from the kernel side. Some features like
> lazy-RCU can risk slowing down boot time if, say, a callback has been
> added that the boot synchronously depends on. Further expedited callbacks
> can get unexpedited way earlier than it should be, thus slowing down
> boot (as shown in the data below).
> 
> For these reasons, this commit adds a config option
> 'CONFIG_RCU_BOOT_END_DELAY' and a boot parameter rcupdate.boot_end_delay.
> Userspace can also make RCU's view of the system as booted, by writing the
> time in milliseconds to: /sys/module/rcupdate/parameters/rcu_boot_end_delay
> Or even just writing a value of 0 to this sysfs node.
> However, under no circumstance will the boot be allowed to end earlier
> than just before init is launched.
> 
> The default value of CONFIG_RCU_BOOT_END_DELAY is chosen as 15s. This
> suites ChromeOS and also a PREEMPT_RT system below very well, which need
> no config or parameter changes, and just a simple application of this patch. A
> system designer can also choose a specific value here to keep RCU from marking
> boot completion.  As noted earlier, RCU's perspective of the system as booted
> will not be marker until at least rcu_boot_end_delay milliseconds have passed
> or an update is made via writing a small value (or 0) in milliseconds to:
> /sys/module/rcupdate/parameters/rcu_boot_end_delay.
> 
> One side-effect of this patch is, there is a risk that a real-time workload
> launched just after the kernel boots will suffer interruptions due to expedited
> RCU, which previous ended just before init was launched. However, to mitigate
> such an issue (however unlikely), the user should either tune
> CONFIG_RCU_BOOT_END_DELAY to a smaller value than 15 seconds or write a value
> of 0 to /sys/module/rcupdate/parameters/rcu_boot_end_delay, once userspace
> boots, and before launching the real-time workload.
> 
> Qiuxu also noted impressive boot-time improvements with earlier version
> of patch. An excerpt from the data he shared:
> 
> 1) Testing environment:
>     OS            : CentOS Stream 8 (non-RT OS)
>     Kernel     : v6.2
>     Machine : Intel Cascade Lake server (2 sockets, each with 44 logical threads)
>     Qemu  args  : -cpu host -enable-kvm, -smp 88,threads=2,sockets=2, …
> 
> 2) OS boot time definition:
>     The time from the start of the kernel boot to the shell command line
>     prompt is shown from the console. [ Different people may have
>     different OS boot time definitions. ]
> 
> 3) Measurement method (very rough method):
>     A timer in the kernel periodically prints the boot time every 100ms.
>     As soon as the shell command line prompt is shown from the console,
>     we record the boot time printed by the timer, then the printed boot
>     time is the OS boot time.
> 
> 4) Measured OS boot time (in seconds)
>    a) Measured 10 times w/o this patch:
>         8.7s, 8.4s, 8.6s, 8.2s, 9.0s, 8.7s, 8.8s, 9.3s, 8.8s, 8.3s
>         The average OS boot time was: ~8.7s
> 
>    b) Measure 10 times w/ this patch:
>         8.5s, 8.2s, 7.6s, 8.2s, 8.7s, 8.2s, 7.8s, 8.2s, 9.3s, 8.4s
>         The average OS boot time was: ~8.3s.
> 
> option-prefix PATCH v4
> option-start
> Tested-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> 
> diff-note-start
> v1->v2:
> 	Update some comments and description.
> v2->v3:
>         Add sysfs param, and update with Test data.
> v3->v4:
>         Fix locking bug found by Paul, make code more robust
>         by refactoring locking code.
>         Doc updates.
> ---
>  .../admin-guide/kernel-parameters.txt         | 15 ++++
>  cc_list                                       |  8 ++
>  kernel/rcu/Kconfig                            | 21 ++++++
>  kernel/rcu/update.c                           | 74 ++++++++++++++++++-
>  4 files changed, 116 insertions(+), 2 deletions(-)
>  create mode 100644 cc_list
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 2429b5e3184b..878c2780f5db 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -5085,6 +5085,21 @@
>  	rcutorture.verbose= [KNL]
>  			Enable additional printk() statements.
>  
> +	rcupdate.rcu_boot_end_delay= [KNL]
> +			Minimum time in milliseconds from the start of boot
> +			that must elapse before the boot sequence can be marked
> +			complete from RCU's perspective, after which RCU's
> +			behavior becomes more relaxed. The default value is also
> +			configurable via CONFIG_RCU_BOOT_END_DELAY.
> +			Userspace can also mark the boot as completed
> +			sooner by writing the time in milliseconds, say once
> +			userspace considers the system as booted, to:
> +			/sys/module/rcupdate/parameters/rcu_boot_end_delay
> +			Or even just writing a value of 0 to this sysfs node.
> +			The sysfs node can also be used to extend the delay
> +			to be larger than the default, assuming the marking
> +			of boot complete has not yet occurred.
> +
>  	rcupdate.rcu_cpu_stall_ftrace_dump= [KNL]
>  			Dump ftrace buffer after reporting RCU CPU
>  			stall warning.
> diff --git a/cc_list b/cc_list
> new file mode 100644
> index 000000000000..7daed4877f5a
> --- /dev/null
> +++ b/cc_list
> @@ -0,0 +1,8 @@
> +Frederic Weisbecker <frederic@kernel.org>
> +Joel Fernandes <joel@joelfernandes.org>
> +Lai Jiangshan <jiangshanlai@gmail.com>
> +linux-doc@vger.kernel.org
> +linux-kernel@vger.kernel.org
> +"Paul E. McKenney" <paulmck@kernel.org>
> +rcu@vger.kernel.org
> +urezki@gmail.com
> diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
> index 9071182b1284..97f68120d1c0 100644
> --- a/kernel/rcu/Kconfig
> +++ b/kernel/rcu/Kconfig
> @@ -217,6 +217,27 @@ config RCU_BOOST_DELAY
>  
>  	  Accept the default if unsure.
>  
> +config RCU_BOOT_END_DELAY
> +	int "Minimum time before RCU may consider in-kernel boot as completed"
> +	range 0 120000
> +	default 15000
> +	help
> +	  Default value of the minimum time in milliseconds from the start of boot
> +	  that must elapse before the boot sequence can be marked complete from RCU's
> +	  perspective, after which RCU's behavior becomes more relaxed.
> +	  Userspace can also mark the boot as completed sooner than this default
> +	  by writing the time in milliseconds, say once userspace considers
> +	  the system as booted, to: /sys/module/rcupdate/parameters/rcu_boot_end_delay.
> +	  Or even just writing a value of 0 to this sysfs node. The sysfs node can
> +	  also be used to extend the delay to be larger than the default, assuming
> +	  the marking of boot completion has not yet occurred.
> +
> +	  The actual delay for RCU's view of the system to be marked as booted can be
> +	  higher than this value if the kernel takes a long time to initialize but it
> +	  will never be smaller than this value.
> +
> +	  Accept the default if unsure.
> +
>  config RCU_EXP_KTHREAD
>  	bool "Perform RCU expedited work in a real-time kthread"
>  	depends on RCU_BOOST && RCU_EXPERT
> diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
> index 19bf6fa3ee6a..18ed3c15e6b5 100644
> --- a/kernel/rcu/update.c
> +++ b/kernel/rcu/update.c
> @@ -224,13 +224,50 @@ void rcu_unexpedite_gp(void)
>  }
>  EXPORT_SYMBOL_GPL(rcu_unexpedite_gp);
>  
> +/*
> + * Minimum time in milliseconds from the start boot until RCU can consider
> + * in-kernel boot as completed.  This can also be tuned at runtime to end the
> + * boot earlier, by userspace init code writing the time in milliseconds (even
> + * 0) to: /sys/module/rcupdate/parameters/rcu_boot_end_delay. The sysfs node
> + * can also be used to extend the delay to be larger than the default, assuming
> + * the marking of boot complete has not yet occurred.
> + */
> +static int rcu_boot_end_delay = CONFIG_RCU_BOOT_END_DELAY;
> +
>  static bool rcu_boot_ended __read_mostly;
> +static bool rcu_boot_end_called __read_mostly;
> +static DEFINE_MUTEX(rcu_boot_end_lock);
>  
>  /*
> - * Inform RCU of the end of the in-kernel boot sequence.
> + * Inform RCU of the end of the in-kernel boot sequence. The boot sequence will
> + * not be marked ended until at least rcu_boot_end_delay milliseconds have passed.
>   */
> -void rcu_end_inkernel_boot(void)
> +void rcu_end_inkernel_boot(void);
> +static void rcu_boot_end_work_fn(struct work_struct *work)
> +{
> +	rcu_end_inkernel_boot();
> +}
> +static DECLARE_DELAYED_WORK(rcu_boot_end_work, rcu_boot_end_work_fn);
> +
> +/* Must be called with rcu_boot_end_lock held. */
> +static void rcu_end_inkernel_boot_locked(void)
>  {
> +	rcu_boot_end_called = true;
> +
> +	if (rcu_boot_ended)
> +		return;
> +
> +	if (rcu_boot_end_delay) {
> +		u64 boot_ms = div_u64(ktime_get_boot_fast_ns(), 1000000UL);
> +
> +		if (boot_ms < rcu_boot_end_delay) {
> +			schedule_delayed_work(&rcu_boot_end_work,
> +					rcu_boot_end_delay - boot_ms);
> +			return;
> +		}
> +	}
> +
> +	cancel_delayed_work(&rcu_boot_end_work);
>  	rcu_unexpedite_gp();
>  	rcu_async_relax();
>  	if (rcu_normal_after_boot)
> @@ -238,6 +275,39 @@ void rcu_end_inkernel_boot(void)
>  	rcu_boot_ended = true;
>  }
>  
> +void rcu_end_inkernel_boot(void)
> +{
> +	mutex_lock(&rcu_boot_end_lock);
> +	rcu_end_inkernel_boot_locked();
> +	mutex_unlock(&rcu_boot_end_lock);
> +}
> +
> +static int param_set_rcu_boot_end(const char *val, const struct kernel_param *kp)
> +{
> +	uint end_ms;
> +	int ret = kstrtouint(val, 0, &end_ms);
> +
> +	if (ret)
> +		return ret;
> +	/*
> +	 * rcu_end_inkernel_boot() should be called at least once during init
> +	 * before we can allow param changes to end the boot.
> +	 */
> +	mutex_lock(&rcu_boot_end_lock);
> +	rcu_boot_end_delay = end_ms;
> +	if (!rcu_boot_ended && rcu_boot_end_called) {
> +		rcu_end_inkernel_boot_locked();
> +	}
> +	mutex_unlock(&rcu_boot_end_lock);
> +	return ret;
> +}
> +
> +static const struct kernel_param_ops rcu_boot_end_ops = {
> +	.set = param_set_rcu_boot_end,
> +	.get = param_get_uint,
> +};
> +module_param_cb(rcu_boot_end_delay, &rcu_boot_end_ops, &rcu_boot_end_delay, 0644);
> +
>  /*
>   * Let rcutorture know when it is OK to turn it up to eleven.
>   */
> -- 
> 2.40.0.rc0.216.gc4246ad0f0-goog
> 
