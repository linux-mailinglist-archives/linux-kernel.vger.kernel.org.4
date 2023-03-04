Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81AE66AA80F
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 05:51:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbjCDEvw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 23:51:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjCDEvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 23:51:51 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4105919F1B
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 20:51:48 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id z6so5313922qtv.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Mar 2023 20:51:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1677905507;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8P0DvZz6I4k4uGPL0I3pwXYRbKFerr/p/wSXjL5OtiA=;
        b=KovF+Y4N9R5IO+OwCiIhDC9WCHBzExTHdKDOpQjTlhX9NVAvmX72doOTsSKba8bspu
         4MVrbODbzoL//miX8qWugBB3nI8TCSYQex5BASu2G33c3neTga4CKmzaUe01DDMzEIcd
         yM65fXXYHtfb8PCvRfqWkhrSEGhv5S2Pla4T8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677905507;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8P0DvZz6I4k4uGPL0I3pwXYRbKFerr/p/wSXjL5OtiA=;
        b=fR9Y66uq5LKOLniqOsW8onwFzRBbwRlq6vJNTjfo7Aq8Qoc9OqZd3VtnjZF2et4a/d
         xy1G3Tbk9K0EJy9hYln05A5S9kAt4rlY5REkV5tXZ3gRVt04PZYS9W8kNGtFWjc/Y4YD
         cAaxBBZRCmHUipr9V3oetHL+O2VNjy3DigeTurB4vfgDq2nS1iFYfOdc/9yM9DYTr1/F
         ibyF3tLAMV5s7TKyTvjCV9ewobXyumqNStMoZbDXmgsGHuyf2/XjNZblVizWG9RyxY0E
         mZPHbKJnskkwgLg58XZNg0aJ3Tzjfe2Wf6O53qhFGEeImBQ7vygnwccxa9XIb8m5tIQQ
         7paA==
X-Gm-Message-State: AO0yUKULsxziGe1j3W3H2Rsa6vZsEeh5lY+liVpvYPqq7odazSHaf3HS
        n0DqYHrqDmJp0uk3NB4QDxwStmspbezgzwR8Eqk=
X-Google-Smtp-Source: AK7set81Trih4PoojQj8PHilYKBW3VK/jKb46cjxeiNA/pA9bpoVQZFZuzQbvDS0YrhexUWhF8SXcw==
X-Received: by 2002:a05:622a:1981:b0:3bf:da2e:8c74 with SMTP id u1-20020a05622a198100b003bfda2e8c74mr8013861qtc.25.1677905507009;
        Fri, 03 Mar 2023 20:51:47 -0800 (PST)
Received: from localhost (129.239.188.35.bc.googleusercontent.com. [35.188.239.129])
        by smtp.gmail.com with ESMTPSA id u37-20020a05622a19a500b003bd0e7ff466sm3184661qtc.7.2023.03.03.20.51.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Mar 2023 20:51:46 -0800 (PST)
Date:   Sat, 4 Mar 2023 04:51:45 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-doc@vger.kernel.org, rcu@vger.kernel.org, urezki@gmail.com
Subject: Re: [PATCH v3] rcu: Add a minimum time for marking boot as completed
Message-ID: <20230304045145.GD2176990@google.com>
References: <20230303213851.2090365-1-joel@joelfernandes.org>
 <20230304010251.GD1301832@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230304010251.GD1301832@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

On Fri, Mar 03, 2023 at 05:02:51PM -0800, Paul E. McKenney wrote:
[..]
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
> 
> Unfortunately, given that a's average is within one standard deviation
> of b's average, this is most definitely not statistically significant.
> Especially given only ten measurements for each case -- you need *at*
> *least* 24, preferably more.  Especially in this case, where you don't
> really know what the underlying distribution is.
> 
> But we can apply the binomial distribution instead of the usual
> normal distribution.  First, let's sort and take the medians:
> 
> a: 8.2 8.3 8.4 8.6 8.7 8.7 8.8 8.8 9.0 9.3  Median: 8.7
> b: 7.6 7.8 8.2 8.2 8.2 8.2 8.4 8.5 8.7 9.3  Median: 8.2
> 
> 8/10 of a's data points are greater than 0.1 more than b's median
> and 8/10 of b's data points are less than 0.1 less than a's median.
> What are the odds that this happens by random chance?
> 
> This is given by sum_0^2 (0.5^10 * binomial(10,i)), which is about 0.055.
> This is not quite 95% confidence, so not hugely convincing, but it is at
> least close.  Not that this is the confidence that (b) is 100ms faster
> than (a), not just that (b) is faster than (a).
> 
> Not sure that this really carries its weight, but in contrast to the
> usual statistics based on the normal distribution, it does suggest at
> least a little improvement.  On the other hand, anyone who has carefully
> studied nonparametric statistics probably jumped out of the boat several
> paragraphs ago.  ;-)

Thanks for the analysis, I did feel the samples were few. I am happy to
update it with more data if Qiuxu can collect more samples and provide.

[..]
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
> 
> Can userspace also extend the time in this manner?  I am not too worried
> either way, but it would be good to make this clear.

Yes, it can be extended because once the default timer fires, it will
schedule a new timer to account for that. Thanks, I'll clarify in the above
docs.

> If userspace writes a non-zero value, is that from the current time or
> from boot?

Good point, it is from the start of boot always, I fixed it.

[..]
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
> 
> Doesn't this write to rcu_boot_end_delay outside of the lock?

True, but actually I realize I don't even need to do it because I overwrite
it in the next step ;-). So I'll just remove it.

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
> 
> Temporarily dropping rcu_boot_end_lock looks like an accident waiting
> to happen.
> 
> > +	}
> > +	mutex_unlock(&rcu_boot_end_lock);
> 
> And dropping it twice does not seem good, either.  Or am I missing some
> subtle control-flow trick?

You are quite right, sorry to miss it. To prevent this sort of issue
happening again, I moved the locking to the caller which also simplifies the
code a bit and prevents such traps.

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
> 
> Isn't it necessary to cancel a previously scheduled work to make sure
> that the new value overrides the old one?

No it is not necessary, as we can keep the older timer and once it fires, its
callback will call rcu_end_inkernel_boot() which will queue another timer to
extend the delay further. As long as 'rcu_boot_end_delay' is updated, it will
work fine. You can see that in test #3 below.

Actually this part of the code is equivalent to what I had in my first
patch, so it is not any new code I am adding.

> Mightn't this be simpler if the user was only permitted to write zero,
> thus just saying "stop immediately"?  If people really need the ability
> to extend or shorten the time, a patch can be produced at that point.
> And then a non-zero write to the file would become legal.

I prefer to keep it this way as with this method, I can not only get to
have variable rcu_boot_end_delay via boot parameter (as in my first patch), I
also don't need to add a separate sysfs entry, and can just reuse
'rcu_boot_end_delay' parameter, which I also had in my first patch. And
adding yet another sysfs parameter will actually complicate it even more and
add more lines of code.

I tested difference scenarios and it works fine, though I missed that
mutex locking unfortunately, I did verify different test cases work as
expected by manual testing.

Here are some printks and on simple testing in Qemu:

1. End the boot early, CONFIG is set to 120 seconds:
==================================================
[    1.614968] rcu_boot_end_delay = 120000
[    1.617630] schedule delayed work joel

Boot took 1.57 seconds
root@(none):/# cat /sys/module/rcupdate/parameters/rcu_boot_end_delay
120000
root@(none):/#
root@(none):/#
root@(none):/# echo 0 > /sys/module/rcupdate/parameters/rcu_boot_end_delay
[   10.108394] param called joel
[   10.110520] sys calling boot ended
[   10.112730] rcu_boot_end_delay = 0
[   10.115017] boot ended joel
-----------------------------------------------

2. End the boot passing in rcupdate.rcu_boot_end_delay as 10s.
   This should overwride the CONFIG of 120 seconds:
==================================================
[    1.700090] rcu_boot_end_delay = 10000
[    1.702628] schedule delayed work joel

Boot took 1.64 seconds

root@(none):/# [   10.414008] rcu_boot_end_delay = 10000
[   10.416670] boot ended joel
-----------------------------------------------

3. Do the same thing as #2, but extend the boot via sysfs to be longer than
10 seconds:
==================================================
[    0.060025] param called joel
[    0.060026] param called too early joel
[    1.663905] rcu_boot_end_delay = 10000
[    1.667051] schedule delayed work joel

Boot took 1.61 seconds

root@(none):/#
root@(none):/# echo 20000 > /sys/module/rcupdate/parameters/rcu_boot_end_delay
[    6.932517] param called joel
[    6.934637] sys calling boot ended
[    6.936845] rcu_boot_end_delay = 20000
[    6.939291] schedule delayed work joel
root@(none):/# [   10.389366] rcu_boot_end_delay = 20000
[   10.392047] schedule delayed work joel
[   20.117416] rcu_boot_end_delay = 20000
[   20.120073] boot ended joel
-----------------------------------------------

The debug patch is here: https://git.kernel.org/pub/scm/linux/kernel/git/jfern/linux.git/commit/?h=rcu/lazy/postboot

Appended is the updated v4 patch, tested as shown above, more testing is in progress.

thanks,

 - Joel

---8<-----------------------

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: [PATCH v4] rcu: Add a minimum time for marking boot as completed

On many systems, a great deal of boot (in userspace) happens after the
kernel thinks the boot has completed. It is difficult to determine if
the system has really booted from the kernel side. Some features like
lazy-RCU can risk slowing down boot time if, say, a callback has been
added that the boot synchronously depends on. Further expedited callbacks
can get unexpedited way earlier than it should be, thus slowing down
boot (as shown in the data below).

For these reasons, this commit adds a config option
'CONFIG_RCU_BOOT_END_DELAY' and a boot parameter rcupdate.boot_end_delay.
Userspace can also make RCU's view of the system as booted, by writing the
time in milliseconds to: /sys/module/rcupdate/parameters/rcu_boot_end_delay
Or even just writing a value of 0 to this sysfs node.
However, under no circumstance will the boot be allowed to end earlier
than just before init is launched.

The default value of CONFIG_RCU_BOOT_END_DELAY is chosen as 15s. This
suites ChromeOS and also a PREEMPT_RT system below very well, which need
no config or parameter changes, and just a simple application of this patch. A
system designer can also choose a specific value here to keep RCU from marking
boot completion.  As noted earlier, RCU's perspective of the system as booted
will not be marker until at least rcu_boot_end_delay milliseconds have passed
or an update is made via writing a small value (or 0) in milliseconds to:
/sys/module/rcupdate/parameters/rcu_boot_end_delay.

One side-effect of this patch is, there is a risk that a real-time workload
launched just after the kernel boots will suffer interruptions due to expedited
RCU, which previous ended just before init was launched. However, to mitigate
such an issue (however unlikely), the user should either tune
CONFIG_RCU_BOOT_END_DELAY to a smaller value than 15 seconds or write a value
of 0 to /sys/module/rcupdate/parameters/rcu_boot_end_delay, once userspace
boots, and before launching the real-time workload.

Qiuxu also noted impressive boot-time improvements with earlier version
of patch. An excerpt from the data he shared:

1) Testing environment:
    OS            : CentOS Stream 8 (non-RT OS)
    Kernel     : v6.2
    Machine : Intel Cascade Lake server (2 sockets, each with 44 logical threads)
    Qemu  args  : -cpu host -enable-kvm, -smp 88,threads=2,sockets=2, …

2) OS boot time definition:
    The time from the start of the kernel boot to the shell command line
    prompt is shown from the console. [ Different people may have
    different OS boot time definitions. ]

3) Measurement method (very rough method):
    A timer in the kernel periodically prints the boot time every 100ms.
    As soon as the shell command line prompt is shown from the console,
    we record the boot time printed by the timer, then the printed boot
    time is the OS boot time.

4) Measured OS boot time (in seconds)
   a) Measured 10 times w/o this patch:
        8.7s, 8.4s, 8.6s, 8.2s, 9.0s, 8.7s, 8.8s, 9.3s, 8.8s, 8.3s
        The average OS boot time was: ~8.7s

   b) Measure 10 times w/ this patch:
        8.5s, 8.2s, 7.6s, 8.2s, 8.7s, 8.2s, 7.8s, 8.2s, 9.3s, 8.4s
        The average OS boot time was: ~8.3s.

option-prefix PATCH v4
option-start
Tested-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>

diff-note-start
v1->v2:
	Update some comments and description.
v2->v3:
        Add sysfs param, and update with Test data.
v3->v4:
        Fix locking bug found by Paul, make code more robust
        by refactoring locking code.
        Doc updates.
---
 .../admin-guide/kernel-parameters.txt         | 15 ++++
 cc_list                                       |  8 ++
 kernel/rcu/Kconfig                            | 21 ++++++
 kernel/rcu/update.c                           | 74 ++++++++++++++++++-
 4 files changed, 116 insertions(+), 2 deletions(-)
 create mode 100644 cc_list

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 2429b5e3184b..878c2780f5db 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5085,6 +5085,21 @@
 	rcutorture.verbose= [KNL]
 			Enable additional printk() statements.
 
+	rcupdate.rcu_boot_end_delay= [KNL]
+			Minimum time in milliseconds from the start of boot
+			that must elapse before the boot sequence can be marked
+			complete from RCU's perspective, after which RCU's
+			behavior becomes more relaxed. The default value is also
+			configurable via CONFIG_RCU_BOOT_END_DELAY.
+			Userspace can also mark the boot as completed
+			sooner by writing the time in milliseconds, say once
+			userspace considers the system as booted, to:
+			/sys/module/rcupdate/parameters/rcu_boot_end_delay
+			Or even just writing a value of 0 to this sysfs node.
+			The sysfs node can also be used to extend the delay
+			to be larger than the default, assuming the marking
+			of boot complete has not yet occurred.
+
 	rcupdate.rcu_cpu_stall_ftrace_dump= [KNL]
 			Dump ftrace buffer after reporting RCU CPU
 			stall warning.
diff --git a/cc_list b/cc_list
new file mode 100644
index 000000000000..7daed4877f5a
--- /dev/null
+++ b/cc_list
@@ -0,0 +1,8 @@
+Frederic Weisbecker <frederic@kernel.org>
+Joel Fernandes <joel@joelfernandes.org>
+Lai Jiangshan <jiangshanlai@gmail.com>
+linux-doc@vger.kernel.org
+linux-kernel@vger.kernel.org
+"Paul E. McKenney" <paulmck@kernel.org>
+rcu@vger.kernel.org
+urezki@gmail.com
diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
index 9071182b1284..97f68120d1c0 100644
--- a/kernel/rcu/Kconfig
+++ b/kernel/rcu/Kconfig
@@ -217,6 +217,27 @@ config RCU_BOOST_DELAY
 
 	  Accept the default if unsure.
 
+config RCU_BOOT_END_DELAY
+	int "Minimum time before RCU may consider in-kernel boot as completed"
+	range 0 120000
+	default 15000
+	help
+	  Default value of the minimum time in milliseconds from the start of boot
+	  that must elapse before the boot sequence can be marked complete from RCU's
+	  perspective, after which RCU's behavior becomes more relaxed.
+	  Userspace can also mark the boot as completed sooner than this default
+	  by writing the time in milliseconds, say once userspace considers
+	  the system as booted, to: /sys/module/rcupdate/parameters/rcu_boot_end_delay.
+	  Or even just writing a value of 0 to this sysfs node. The sysfs node can
+	  also be used to extend the delay to be larger than the default, assuming
+	  the marking of boot completion has not yet occurred.
+
+	  The actual delay for RCU's view of the system to be marked as booted can be
+	  higher than this value if the kernel takes a long time to initialize but it
+	  will never be smaller than this value.
+
+	  Accept the default if unsure.
+
 config RCU_EXP_KTHREAD
 	bool "Perform RCU expedited work in a real-time kthread"
 	depends on RCU_BOOST && RCU_EXPERT
diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
index 19bf6fa3ee6a..18ed3c15e6b5 100644
--- a/kernel/rcu/update.c
+++ b/kernel/rcu/update.c
@@ -224,13 +224,50 @@ void rcu_unexpedite_gp(void)
 }
 EXPORT_SYMBOL_GPL(rcu_unexpedite_gp);
 
+/*
+ * Minimum time in milliseconds from the start boot until RCU can consider
+ * in-kernel boot as completed.  This can also be tuned at runtime to end the
+ * boot earlier, by userspace init code writing the time in milliseconds (even
+ * 0) to: /sys/module/rcupdate/parameters/rcu_boot_end_delay. The sysfs node
+ * can also be used to extend the delay to be larger than the default, assuming
+ * the marking of boot complete has not yet occurred.
+ */
+static int rcu_boot_end_delay = CONFIG_RCU_BOOT_END_DELAY;
+
 static bool rcu_boot_ended __read_mostly;
+static bool rcu_boot_end_called __read_mostly;
+static DEFINE_MUTEX(rcu_boot_end_lock);
 
 /*
- * Inform RCU of the end of the in-kernel boot sequence.
+ * Inform RCU of the end of the in-kernel boot sequence. The boot sequence will
+ * not be marked ended until at least rcu_boot_end_delay milliseconds have passed.
  */
-void rcu_end_inkernel_boot(void)
+void rcu_end_inkernel_boot(void);
+static void rcu_boot_end_work_fn(struct work_struct *work)
+{
+	rcu_end_inkernel_boot();
+}
+static DECLARE_DELAYED_WORK(rcu_boot_end_work, rcu_boot_end_work_fn);
+
+/* Must be called with rcu_boot_end_lock held. */
+static void rcu_end_inkernel_boot_locked(void)
 {
+	rcu_boot_end_called = true;
+
+	if (rcu_boot_ended)
+		return;
+
+	if (rcu_boot_end_delay) {
+		u64 boot_ms = div_u64(ktime_get_boot_fast_ns(), 1000000UL);
+
+		if (boot_ms < rcu_boot_end_delay) {
+			schedule_delayed_work(&rcu_boot_end_work,
+					rcu_boot_end_delay - boot_ms);
+			return;
+		}
+	}
+
+	cancel_delayed_work(&rcu_boot_end_work);
 	rcu_unexpedite_gp();
 	rcu_async_relax();
 	if (rcu_normal_after_boot)
@@ -238,6 +275,39 @@ void rcu_end_inkernel_boot(void)
 	rcu_boot_ended = true;
 }
 
+void rcu_end_inkernel_boot(void)
+{
+	mutex_lock(&rcu_boot_end_lock);
+	rcu_end_inkernel_boot_locked();
+	mutex_unlock(&rcu_boot_end_lock);
+}
+
+static int param_set_rcu_boot_end(const char *val, const struct kernel_param *kp)
+{
+	uint end_ms;
+	int ret = kstrtouint(val, 0, &end_ms);
+
+	if (ret)
+		return ret;
+	/*
+	 * rcu_end_inkernel_boot() should be called at least once during init
+	 * before we can allow param changes to end the boot.
+	 */
+	mutex_lock(&rcu_boot_end_lock);
+	rcu_boot_end_delay = end_ms;
+	if (!rcu_boot_ended && rcu_boot_end_called) {
+		rcu_end_inkernel_boot_locked();
+	}
+	mutex_unlock(&rcu_boot_end_lock);
+	return ret;
+}
+
+static const struct kernel_param_ops rcu_boot_end_ops = {
+	.set = param_set_rcu_boot_end,
+	.get = param_get_uint,
+};
+module_param_cb(rcu_boot_end_delay, &rcu_boot_end_ops, &rcu_boot_end_delay, 0644);
+
 /*
  * Let rcutorture know when it is OK to turn it up to eleven.
  */
-- 
2.40.0.rc0.216.gc4246ad0f0-goog

