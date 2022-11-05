Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8656F61DDF1
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 21:06:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbiKEUGr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Nov 2022 16:06:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiKEUGo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Nov 2022 16:06:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A8AC13DC5;
        Sat,  5 Nov 2022 13:06:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 36235B8075B;
        Sat,  5 Nov 2022 20:06:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A82E7C433D6;
        Sat,  5 Nov 2022 20:06:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667678799;
        bh=rT733yb6mRDJB52QxKMi0hwcmgmqhGu/jfN2AWSXS9k=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=B3lj/K3g5DYnLIRTc4K+/hbVErxc4p8Dy9UXpVYdzK7ksYOWaeYTXc2C2oXu5Nbgj
         nkG+mpydmdqtPkVMK22OHjceHFGXSakCvwVH+ioQfb+otIkf8OEmzLHTy+uefm1HzB
         PyZLmjEsSN+b8at3u3v4sY1qzfdB7yZn4WvWVFZHUQDNooduw16pBXmVDGdADyMdsu
         pYIfzOLtVlR6bPed2gLkdouARUA0rtjGg2melv0ScFNQB4NSi8crGqOsqZ1O6VdmRJ
         0l/WgVEn+/eWNzRweRJn4fGRvx6FbIXWr80gP7Jc/Uj9ghCnzXCx9BP5nMIRnqoaHu
         rXvP85YZY3PrA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id C154E5C09A2; Sat,  5 Nov 2022 13:06:37 -0700 (PDT)
Date:   Sat, 5 Nov 2022 13:06:37 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Elliott, Robert (Servers)" <elliott@hpe.com>
Cc:     Zhen Lei <thunder.leizhen@huawei.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 4/4] rcu: Add RCU stall diagnosis information
Message-ID: <20221105200637.GC28461@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221104021224.102-1-thunder.leizhen@huawei.com>
 <20221104021224.102-5-thunder.leizhen@huawei.com>
 <MW5PR84MB18425CBD1259317004F7771AAB3A9@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MW5PR84MB18425CBD1259317004F7771AAB3A9@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 05, 2022 at 01:58:28AM +0000, Elliott, Robert (Servers) wrote:
> 
> > --- a/kernel/rcu/Kconfig.debug
> > +++ b/kernel/rcu/Kconfig.debug
> > @@ -95,6 +95,16 @@ config RCU_EXP_CPU_STALL_TIMEOUT
> >  	  says to use the RCU_CPU_STALL_TIMEOUT value converted from
> >  	  seconds to milliseconds.
> > 
> > +config RCU_CPU_STALL_CPUTIME
> 
> Since the information might change and grow over time, consider
> calling it "ADDITIONAL_INFO" rather than just "CPUTIME".

Except that I already redirected Zhen Lei from a generic description
to a more specific one.  The reason for this is that I already get
complaints about the large volume of output from RCU CPU stall warnings,
which suggests that unless the additional information is quite small,
it should get its own Kconfig option and kernel boot parameter.

So we well be keeping RCU_CPU_STALL_CPUTIME.

And yes, I understand that high-end enterprise deployments might have
absolutely no problem with the additional volume, but Linux handles a
range of hardware and workloads that I would have thought impossible
only 20 years ago.  And RCU needs to accommodate the full range.

> > +	bool "Provide additional rcu stall debug information"
> > +	depends on RCU_STALL_COMMON
> > +	default n
> > +	help
> > +	  Statistics during the period from RCU_CPU_STALL_TIMEOUT/2 to
> > +	  RCU_CPU_STALL_TIMEOUT, such as the number of (hard interrupts,
> > soft
> > +	  interrupts, task switches) and the cputime of (hard interrupts,
> > soft
> > +	  interrupts, kerenl tasks) are added to the rcu stall report.
> 
> s/kerenl/kernel/
> 
> Those parenthetical words are not grammatically correct, and
> nobody will remember to update Kconfig if they change the code.
> 
> Try making it is a little less precise: 
> "Collect statistics during the RCU stall timeout period
> (e.g., counts and CPU time consumed by hard interrupts, soft
> interrupts, task switches, and kernel tasks) and include
> them in the RCU stall console error message."

My usual practice when taking in patches from someone whose native
language differs greatly from English is to do a round of wordsmithing.
I run the wordsmithing past the author, which helps catch any errors
I might make translating the rest of the way to Engligh and also
(more frequently than not) helps the author's English skills.

I have taken care of all but part of Zhen Lei's lat patch, and will
pull that in later today.

> ...
> > +
> > +	pr_err("         hardirqs   softirqs   csw/system\n");
> > +	pr_err(" number: %8ld %10d %12lld\n",
> 
> Everything after a %d is a "number". These are more specifically counts.

The distinction between "number" and "count" probably isn't going to
travel well, especially given that the next line could be argued to be
either a number or a count of milliseconds.

To see this, please use Google Translate to convert "George is just along
for the ride" to Chinese (simplified) and back and see what you get.  ;-)

OK, here is what I am going to do.  I am going to translate the last
patch's commit log, but leave the patch itself as Zhen Lei sent it.
Please feel free to send a follow-on patch that does the wordsmithing,
but please check your work with some non-native English speakers.
I am guessing that Zhen Lei would be happy to give you feedback from a
both a technical viewpoint and a Chinese-speaker viewpoint.

Please understand that this offer is not in any way sarcastic or
insincere.  This sort of translation does take time and energy, and so
I would have to be quite stupid not to accept good help.

> > +		kstat_cpu_irqs_sum(cpu) - rsrp->nr_hardirqs,
> > +		kstat_cpu_softirqs_sum(cpu) - rsrp->nr_softirqs,
> > +		nr_context_switches_cpu(cpu) - rsrp->nr_csw);
> 
> Two columns are plural and one is not. 
> 
> Within a few lines, this is referred to as "context_switches", cws, 
> and "task switches." One term would be better. vmstat uses "cs", 
> pidstat uses "cswch", and /proc/<pid>/status uses "ctxt_switches,"
> so there's not one ideal term for that column. Matching one
> of those might be better than using another unique name.
> 
> Since no other variants are shown, the "/system" suffix is a bit
> confusing. 

These are good points, including the lack of standard current
nomenclature.  Again, would you be interested in providing a translation
patch?

> > +	pr_err("cputime: %8lld %10lld %12lld   ==> %lld(ms)\n",
> > +		div_u64(cpustat[CPUTIME_IRQ] - rsrp->cputime_irq, NSEC_PER_MSEC),
> > +		div_u64(cpustat[CPUTIME_SOFTIRQ] - rsrp->cputime_softirq, NSEC_PER_MSEC),
> > +		div_u64(cpustat[CPUTIME_SYSTEM] - rsrp->cputime_system, NSEC_PER_MSEC),
> > +		jiffies64_to_msecs(half_timeout));
> 
> There is no column header for that fourth number. "half_timeout"
> might be good, dropping the "==>".

Another approach is to print it as a fraction, in this case, 2425/2500.
Of course, adding the "/2500" to the other two columns would be annoying.
Yet another approach is to leave that last column, but prepend a "/",
as in "/2500(ms)".

> The "(ms)" at the end is awkward. Try moving it to the left
> as "cputime (ms): "

Good point, and that might also better disambiguate "number" than
any other choice.

> > +int rcu_cpu_stall_cputime __read_mostly =
> > IS_ENABLED(CONFIG_RCU_CPU_STALL_CPUTIME);
> 
> As a config option and module parameter, adding some more
> instrumentation overhead might be worthwhile for other
> likely causes of rcu stalls.
> 
> For example, if enabled, have these functions (if available
> on the architecture) maintain a per-CPU running count of
> their invocations, which also cause the CPU to be unavailable
> for rcu: 
> - kernel_fpu_begin() calls - FPU/SIMD context preservation,
>   which also calls preempt_disable()
> - preempt_disable() calls - scheduler context switches disabled
> - local_irq_save() calls - interrupts disabled
> - cond_resched() calls - lack of these is a problem
> 
> For kernel_fpu_begin and preempt_disable, knowing if it is
> currently blocked for those reasons is probably the most
> helpful.

These could be additional patches.

But please tie any such patch to an actual use case.  After all, if no
one actually uses that additional information, we have irritates untold
numbers of electrons for no purpose.

Also, some of those functions are on fastpaths, so adding unconditional
instrumentation overhead might result in an objection or three.

As always, choose wisely!  ;-)

If I don't see anything from you by this coming Friday, I will fold my
usual wordsmithing into the patch.

							Thanx, Paul
