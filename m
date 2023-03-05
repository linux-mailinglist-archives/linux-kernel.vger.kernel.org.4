Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 659D66AB21B
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Mar 2023 21:34:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbjCEUeO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Mar 2023 15:34:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjCEUeM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Mar 2023 15:34:12 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27EB793CB;
        Sun,  5 Mar 2023 12:34:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6D9E060B55;
        Sun,  5 Mar 2023 20:34:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAE50C433D2;
        Sun,  5 Mar 2023 20:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678048449;
        bh=z/fOphc4Q/M0HMev/IXB826ZCR7xLHOao0bqg4tm5es=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=QFAWG+qY6p9bTYdx/4FF2536ldczVJ17LjvjSB0rRKAWWNbBsB3R5lc7W3IYk4mNi
         tZ8XYFRAjiOxxoDQWX6u7YShaYoHvVgZXZmH9IIG3yPEUobZ4zCzXLkF0YRySdAzqQ
         krsp0pO+X3KXU4QqTYsePP2jTN1l7ZOTcHV9+uNr508jXN8EErjFY0V4LfCTWkNs/5
         xcdsCzLdOc+Kumh15Chj/l/wmgQ89lOtRWr3WFKhWx1OgHE20z5ok9sXSeY3mKHpe7
         15JmvH8lXoySphVnxMn+60cu22+zUV/1s3hqkejERzvpX1VSjgZhy5AT3/gkffyVae
         9JWPD31lbHW7A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 59CFF5C035B; Sun,  5 Mar 2023 12:34:09 -0800 (PST)
Date:   Sun, 5 Mar 2023 12:34:09 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-doc@vger.kernel.org, rcu@vger.kernel.org
Subject: Re: [PATCH v3] rcu: Add a minimum time for marking boot as completed
Message-ID: <20230305203409.GA1355021@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20230303213851.2090365-1-joel@joelfernandes.org>
 <ZAR/VdMNBwdrWA/5@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZAR/VdMNBwdrWA/5@pc636>
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 05, 2023 at 12:39:01PM +0100, Uladzislau Rezki wrote:
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
> > ---
> > v1->v2:
> > 	Update some comments and description.
> > v2->v3:
> >         Add sysfs param, and update with Test data.
> > 
> >  .../admin-guide/kernel-parameters.txt         | 12 ++++
> >  cc_list                                       |  8 +++
> >  kernel/rcu/Kconfig                            | 19 ++++++
> >  kernel/rcu/update.c                           | 68 ++++++++++++++++++-
> >  4 files changed, 106 insertions(+), 1 deletion(-)
> >  create mode 100644 cc_list
> > 
> > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > index 2429b5e3184b..611de90d9c13 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -5085,6 +5085,18 @@
> >  	rcutorture.verbose= [KNL]
> >  			Enable additional printk() statements.
> >  
> > +	rcupdate.rcu_boot_end_delay= [KNL]
> > +			Minimum time in milliseconds that must elapse
> > +			before the boot sequence can be marked complete
> > +			from RCU's perspective, after which RCU's behavior
> > +			becomes more relaxed. The default value is also
> > +			configurable via CONFIG_RCU_BOOT_END_DELAY.
> > +			Userspace can also mark the boot as completed
> > +			sooner by writing the time in milliseconds, say once
> > +			userspace considers the system as booted, to:
> > +			/sys/module/rcupdate/parameters/rcu_boot_end_delay
> > +			Or even just writing a value of 0 to this sysfs node.
> > +
> >  	rcupdate.rcu_cpu_stall_ftrace_dump= [KNL]
> >  			Dump ftrace buffer after reporting RCU CPU
> >  			stall warning.
> > diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
> > index 9071182b1284..4b5ffa36cbaf 100644
> > --- a/kernel/rcu/Kconfig
> > +++ b/kernel/rcu/Kconfig
> > @@ -217,6 +217,25 @@ config RCU_BOOST_DELAY
> >  
> >  	  Accept the default if unsure.
> >  
> > +config RCU_BOOT_END_DELAY
> > +	int "Minimum time before RCU may consider in-kernel boot as completed"
> > +	range 0 120000
> > +	default 15000
> > +	help
> > +	  Default value of the minimum time in milliseconds that must elapse
> > +	  before the boot sequence can be marked complete from RCU's perspective,
> > +	  after which RCU's behavior becomes more relaxed.
> > +	  Userspace can also mark the boot as completed sooner than this default
> > +	  by writing the time in milliseconds, say once userspace considers
> > +	  the system as booted, to: /sys/module/rcupdate/parameters/rcu_boot_end_delay.
> > +	  Or even just writing a value of 0 to this sysfs node.
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
> > index 19bf6fa3ee6a..93138c92136e 100644
> > --- a/kernel/rcu/update.c
> > +++ b/kernel/rcu/update.c
> > @@ -224,18 +224,84 @@ void rcu_unexpedite_gp(void)
> >  }
> >  EXPORT_SYMBOL_GPL(rcu_unexpedite_gp);
> >  
> > +/*
> > + * Minimum time in milliseconds until RCU can consider in-kernel boot as
> > + * completed.  This can also be tuned at runtime to end the boot earlier, by
> > + * userspace init code writing the time in milliseconds (even 0) to:
> > + * /sys/module/rcupdate/parameters/rcu_boot_end_delay
> > + */
> > +static int rcu_boot_end_delay = CONFIG_RCU_BOOT_END_DELAY;
> > +
> >  static bool rcu_boot_ended __read_mostly;
> > +static bool rcu_boot_end_called __read_mostly;
> > +static DEFINE_MUTEX(rcu_boot_end_lock);
> > +
> > +static int param_set_rcu_boot_end(const char *val, const struct kernel_param *kp)
> > +{
> > +	uint end_ms;
> > +	int ret = kstrtouint(val, 0, &end_ms);
> > +
> > +	if (ret)
> > +		return ret;
> > +	WRITE_ONCE(*(uint *)kp->arg, end_ms);
> > +
> > +	/*
> > +	 * rcu_end_inkernel_boot() should be called at least once during init
> > +	 * before we can allow param changes to end the boot.
> > +	 */
> > +	mutex_lock(&rcu_boot_end_lock);
> > +	rcu_boot_end_delay = end_ms;
> > +	if (!rcu_boot_ended && rcu_boot_end_called) {
> > +		mutex_unlock(&rcu_boot_end_lock);
> > +		rcu_end_inkernel_boot();
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
> >  
> >  /*
> > - * Inform RCU of the end of the in-kernel boot sequence.
> > + * Inform RCU of the end of the in-kernel boot sequence. The boot sequence will
> > + * not be marked ended until at least rcu_boot_end_delay milliseconds have passed.
> >   */
> > +void rcu_end_inkernel_boot(void);
> > +static void rcu_boot_end_work_fn(struct work_struct *work)
> > +{
> > +	rcu_end_inkernel_boot();
> > +}
> > +static DECLARE_DELAYED_WORK(rcu_boot_end_work, rcu_boot_end_work_fn);
> > +
> >  void rcu_end_inkernel_boot(void)
> >  {
> > +	mutex_lock(&rcu_boot_end_lock);
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
> <snip>
> urezki@pc638:~/data/raid0/coding/linux-rcu.git$ git diff
> diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
> index 93138c92136e..93f426f0f4ec 100644
> --- a/kernel/rcu/update.c
> +++ b/kernel/rcu/update.c
> @@ -289,7 +289,7 @@ void rcu_end_inkernel_boot(void)
>  
>                 if (boot_ms < rcu_boot_end_delay) {
>                         schedule_delayed_work(&rcu_boot_end_work,
> -                                       rcu_boot_end_delay - boot_ms);
> +                               msecs_to_jiffies(rcu_boot_end_delay - boot_ms));
>                         mutex_unlock(&rcu_boot_end_lock);
>                         return;
>                 }
> urezki@pc638:~/data/raid0/coding/linux-rcu.git$
> <snip>
> 
> I think you need to apply above patch. I am not sure maybe Paul
> has already mentioned about it. But just in case.

No, I did miss that one, so thank you very much for spotting it!

							Thanx, Paul
