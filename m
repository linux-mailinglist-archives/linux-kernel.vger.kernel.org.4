Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B934A5F7E5C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 21:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbiJGT4k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 15:56:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbiJGT4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 15:56:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 538CCB40EF;
        Fri,  7 Oct 2022 12:56:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D04F3B82446;
        Fri,  7 Oct 2022 19:56:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70124C433D6;
        Fri,  7 Oct 2022 19:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665172589;
        bh=a/01ILpeAOG6Hq469xSdhepxBw9DlD51I2SjaCYf0wM=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=LG3YuKeFmjJtdpaekLU3F5GxRsgdkfax0zlhslFCDettqfyYWnfaxAr2u7g7fPbUy
         43KOPdhajcjk+FzmNn7fBsY7unL/EkZ1KGqbZjmCV/XjYHsPWDSutYXSV9YL/oDvp4
         iXOjBQCOZd5XYtT4uwZT/08qGHhd5PCMOMM9gwUdN5vDnwkzHvai/78y10tFi2OR8U
         HM8ZSkD1bsq5bOM9e8fgZ8ch8IoGXBLfz9/t8UjcA3TOYeOt5IbALSoLBCwTT7Yqz+
         t085A4waimZ9Yc/uHPaUG6rWcO8PGISF0oRSksRxD91hjRrHSXZbyOPsuYXWpf6T08
         th57evb2+R/HA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 13ED75C06AE; Fri,  7 Oct 2022 12:56:29 -0700 (PDT)
Date:   Fri, 7 Oct 2022 12:56:29 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        rushikesh.s.kadam@intel.com, urezki@gmail.com,
        neeraj.iitr10@gmail.com, frederic@kernel.org, rostedt@goodmis.org,
        youssefesmat@google.com, surenb@google.com
Subject: Re: [PATCH v7 10/11] scsi/scsi_error: Use call_rcu_flush() instead
 of call_rcu()
Message-ID: <20221007195629.GK4196@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <Y0BfvzpF1DE10nOg@google.com>
 <00F8CD19-98E7-4CEB-AC8E-4E86642E91A7@joelfernandes.org>
 <20221007175208.GI4196@paulmck-ThinkPad-P17-Gen-1>
 <Y0B+CqZVP3bqQyn5@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y0B+CqZVP3bqQyn5@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 07, 2022 at 07:29:14PM +0000, Joel Fernandes wrote:
> On Fri, Oct 07, 2022 at 10:52:08AM -0700, Paul E. McKenney wrote:
> > On Fri, Oct 07, 2022 at 01:31:23PM -0400, Joel Fernandes wrote:
> > > 
> > > 
> > > > On Oct 7, 2022, at 1:19 PM, Joel Fernandes <joel@joelfernandes.org> wrote:
> > > > 
> > > > ﻿On Fri, Oct 07, 2022 at 03:18:26AM +0000, Joel Fernandes wrote:
> > > >>> On Tue, Oct 04, 2022 at 02:41:56AM +0000, Joel Fernandes (Google) wrote:
> > > >>> From: Uladzislau Rezki <urezki@gmail.com>
> > > >>> 
> > > >>> Slow boot time is seen on KVM running typical Linux distributions due to
> > > >>> SCSI layer calling call_rcu(). Recent changes to save power may be
> > > >>> causing this slowness. Using call_rcu_flush() fixes the issue and brings
> > > >>> the boot time back to what it originally was. Convert it.
> > > >>> 
> > > >>> Signed-off-by: Uladzislau Rezki <urezki@gmail.com>
> > > >>> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > >> 
> > > >> And I successfully setup Debian on KVM and verified that this fixes it, so
> > > >> now I have a nice reproducible rig for my
> > > >> 'lazy-callback-doing-a-wakeup-detector' (I wrote half the detector thanks to
> > > >> ideas from Steve, and will finish the other half tomorrow or so).
> > > >> 
> > > >> Tested-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > > 
> > > > Looks like I can catch Vlad's issue with the below patch. Thoughts? Does this
> > > > look reasonable for mainline? (I think so as it is self-contained and the
> > > > debug option is default off, and could be useful down the line).
> > 
> > Excellent as a debug patch!!!  Let's see how it goes -- if it proves
> > sufficiently useful, some form should go into mainline.  Or at least
> > be feature prominently somewhere public.
> 
> Ok that sounds good.
> 
> > > > [    6.887033 ] rcu: *****************************************************
> > > > [    6.891242 ] rcu: RCU: A wake up has been detected from a lazy callback!
> > > > [    6.895377 ] rcu: The callback name is: scsi_eh_inc_host_failed
> > > > [    6.899084 ] rcu: The task it woke up is: scsi_eh_1 (61)
> > > > [    6.902405 ] rcu: This could cause performance issues! Check the stack.
> > > > [    6.906532 ] rcu: *****************************************************
> > > > 
> > > > 
> > > > [   17.127128 ] rcu: *****************************************************
> > > > [   17.131397 ] rcu: RCU: A wake up has been detected from a lazy callback!
> > > > [   17.135703 ] rcu: The callback name is: scsi_eh_inc_host_failed
> > > > [   17.139485 ] rcu: The task it woke up is: scsi_eh_1 (61)
> > > > [   17.142828 ] rcu: This could cause performance issues! Check the stack.
> > > > [   17.146962 ] rcu: *****************************************************
> > > > 
> > > > And thanks to Steve for the binary search code.
> > > > 
> > > > One thing I found is I have to ignore kworkers because there are times when a
> > > > work item is queued from a callback and those callbacks don't seem to
> > > > contribute to performance issues. So I am filtering these:
> > > > 
> > > > [   38.631724 ] rcu: The callback name is: thread_stack_free_rcu
> > > > [   38.635317 ] rcu: The task it woke up is: kworker/3:2 (143)
> > > > 
> > > > [   39.649332 ] rcu: The callback name is: delayed_put_task_struct
> > > > [   39.653037 ] rcu: The task it woke up is: kworker/0:1 (40)
> > > > 
> > > > ---8<-----------------------
> > > > 
> > > > From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
> > > > Subject: [PATCH] lazy wake debug
> > > > 
> > > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > > ---
> > > > kernel/rcu/Kconfig      |   7 ++
> > > > kernel/rcu/lazy-debug.h | 149 ++++++++++++++++++++++++++++++++++++++++
> > > > kernel/rcu/tree.c       |   9 +++
> > > > 3 files changed, 165 insertions(+)
> > > > create mode 100644 kernel/rcu/lazy-debug.h
> > > > 
> > > > diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
> > > > index edd632e68497..08c06f739187 100644
> > > > --- a/kernel/rcu/Kconfig
> > > > +++ b/kernel/rcu/Kconfig
> > > > @@ -322,4 +322,11 @@ config RCU_LAZY
> > > >      To save power, batch RCU callbacks and flush after delay, memory
> > > >      pressure or callback list growing too big.
> > > > 
> > > > +config RCU_LAZY_DEBUG
> > > > +    bool "RCU callback lazy invocation debugging"
> > > > +    depends on RCU_LAZY
> > > > +    default n
> > > > +    help
> > > > +      Debugging to catch issues caused by delayed RCU callbacks.
> > > > +
> > > > endmenu # "RCU Subsystem"
> > > > diff --git a/kernel/rcu/lazy-debug.h b/kernel/rcu/lazy-debug.h
> > > > new file mode 100644
> > > > index 000000000000..fc1cc1cb89f0
> > > > --- /dev/null
> > > > +++ b/kernel/rcu/lazy-debug.h
> > > > @@ -0,0 +1,149 @@
> > > > +#include <linux/string.h>
> > > > +#include <linux/spinlock.h>
> > > > +
> > > > +#ifdef CONFIG_RCU_LAZY_DEBUG
> > > > +#include <linux/preempt.h>
> > > > +#include <trace/events/sched.h>
> > > > +
> > > > +static DEFINE_PER_CPU(bool, rcu_lazy_cb_exec) = false;
> > > > +static DEFINE_PER_CPU(void *, rcu_lazy_ip) = NULL;
> > > > +
> > > > +static DEFINE_RAW_SPINLOCK(lazy_funcs_lock);
> > > > +
> > > > +#define FUNC_SIZE 1024
> > > 
> > > And I know this array can overflow in the future so I will add checks for that in the code if we are going with this patch.
> > 
> > I believe that there are fewer than 300 RCU callback functions, but yes,
> > there would need to at least be a check at some point.
> > 
> > I still strongly suggest the static search in addition to this.  Yes, this
> > is a cool patch, but it should be mostly used for the difficult-to-find
> > instances.
> 
> I wrote some scripts shared below (could be improves) which search for "wake"
> in code following an RCU callback's reference. This catches SCSI too but I
> did find one more:
> 
> (1)
> rxrpc_destroy_connection()
> 
> 	which does:
> 	wake_up_var(&conn->params.local->rxnet->nr_conns);
> 
> 
> I think I'll change this to call_rcu_flush() to be safe.
> 
> ========
> 
> All others are harmless / false-positives which I inspected and didn't have
> anything concerning.

Very good, and thank you for doing this!

Maybe include the script in the cover letter of the next version?

							Thanx, Paul

> ---8<-----------------------
> 
> From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
> Subject: [PATCH] debug: look for wake references after rcu callback body
> 
> First run search-call-rcu.sh which generates some files, then run
> search-wakers.sh to see the references to wake.
> 
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
>  search-call-rcu.sh | 19 +++++++++++++++++++
>  search-wakers.sh   | 15 +++++++++++++++
>  2 files changed, 34 insertions(+)
>  create mode 100755 search-call-rcu.sh
>  create mode 100755 search-wakers.sh
> 
> diff --git a/search-call-rcu.sh b/search-call-rcu.sh
> new file mode 100755
> index 000000000000..21406355888c
> --- /dev/null
> +++ b/search-call-rcu.sh
> @@ -0,0 +1,19 @@
> +#!/bin/bash
> +
> +rm func-list
> +touch func-list
> +
> +for f in $(find . \( -name "*.c" -o -name "*.h" \) | grep -v rcu); do
> +
> +	funcs=$(perl -0777 -ne 'while(m/call_rcu\([&]?.+,\s?(.+)\).*;/g){print "$1\n";}' $f)
> +
> +	if [ "x$funcs" != "x" ]; then
> +		for func in $funcs; do
> +			echo "$f $func" >> func-list
> +			echo "$f $func"
> +		done
> +	fi
> +
> +done
> +
> +cat func-list | sort | uniq | tee func-list-sorted
> diff --git a/search-wakers.sh b/search-wakers.sh
> new file mode 100755
> index 000000000000..a96d60a7e16b
> --- /dev/null
> +++ b/search-wakers.sh
> @@ -0,0 +1,15 @@
> +#!/bin/bash
> +
> +while read fl; do
> +	file=$(echo $fl | cut -d " " -f1)
> +	func=$(echo $fl | cut -d " " -f2)
> +
> +	grep -A 30 $func $file | grep wake > /dev/null
> +
> +	if [ $? -eq 0 ]; then
> +		echo "keyword wake found after function reference $func in $file"
> +		echo "Output:"
> +		grep -A 30 $func $file 
> +		echo "==========================================================="
> +	fi
> +done < func-list-sorted
> -- 
> 2.38.0.rc1.362.ged0d419d3c-goog
> 
