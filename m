Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4C586ADFA7
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 14:02:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbjCGNCm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 08:02:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230100AbjCGNCO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 08:02:14 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 956457BA23;
        Tue,  7 Mar 2023 05:02:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DACAAB818BD;
        Tue,  7 Mar 2023 13:01:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D871C433EF;
        Tue,  7 Mar 2023 13:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678194117;
        bh=Unor41C6sc4gfodbTZTfdh9oGCwuWkFxOLAQ6OB1om4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dbXKxCqBPjUUOk6WkPT0uGYPC4GNpeacvmVVa0H3nH0mhpGRPBxU9vOX8lqeq3e37
         y7+CDQmQWC3PiM+qgzwxCN0/a/ltFmczoPVeBMKorO5D1SHr5wzbURHjKN93I+B9WW
         hjYRVKT5Ya20SJkWyI5hBGbAUS3YKFgMYsyBD6eLaGchwej8d+Q44bFU4vGoBUpKEU
         KwKgkeywuH2JHq7U1/mjqsIR3DHFVsilTczDeGKjAT22a3ZdhWSbL/mPky0CNJWJWy
         8Rf4QWV2xXJ7k9vnjLSuqjLjx8+ObSyo/xdudhHN03oY73L1eJ7VUpXGFd2bk+reBx
         aWUK+f40C0Bpg==
Date:   Tue, 7 Mar 2023 14:01:54 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-doc@vger.kernel.org, "Paul E. McKenney" <paulmck@kernel.org>,
        rcu@vger.kernel.org, urezki@gmail.com
Subject: Re: [PATCH v3] rcu: Add a minimum time for marking boot as completed
Message-ID: <ZAc1wsvd4trjP/xi@lothringen>
References: <20230303213851.2090365-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230303213851.2090365-1-joel@joelfernandes.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 03, 2023 at 09:38:51PM +0000, Joel Fernandes (Google) wrote:
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
> Tested-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>

I still don't really like that:

1) It feels like we are curing a symptom for which we don't know the cause.
   Which RCU write side caller is the source of this slow boot? Some tracepoints
   reporting the wait duration within synchronize_rcu() calls between the end of
   the kernel boot and the end of userspace boot may be helpful.
   
2) The kernel boot was already covered before this patch so this is about
   userspace code calling into the kernel. Is that piece of code also called
   after the boot? In that case are we missing a conversion from
   synchronize_rcu() to synchronize_rcu_expedited() somewhere? Because then
   the problem is more general than just boot.

This needs to be analyzed first and if it happens that the issue really
needs to be fixed with telling the kernel that userspace has completed
booting, eg: because the problem is not in a few callsites that need conversion
to expedited but instead in the accumulation of lots of calls that should stay
as is:

3) This arbitrary timeout looks dangerous to me as latency sensitive code
   may run right after the boot. Either you choose a value that is too low
   and you miss the optimization or the value is too high and you may break
   things.

4) This should be fixed the way you did:
   a) a kernel parameter like you did
   b) The init process (systemd?) tells the kernel when it judges that userspace
      has completed booting.
   c) Make these interfaces more generic, maybe that information will be useful
      outside RCU. For example the kernel parameter should be
      "user_booted_reported" and the sysfs (should be sysctl?):
      kernel.user_booted = 1
   d) But yuck, this means we must know if the init process supports that...

For these reasons, let's make sure we know exactly what is going on first.

Thanks.
