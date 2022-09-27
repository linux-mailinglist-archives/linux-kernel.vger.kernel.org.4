Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D77905EB89A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 05:22:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231300AbiI0DWF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 23:22:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231447AbiI0DVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 23:21:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 766326CF7A;
        Mon, 26 Sep 2022 20:20:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D4901B81904;
        Tue, 27 Sep 2022 03:20:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77104C433C1;
        Tue, 27 Sep 2022 03:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664248821;
        bh=Ia9r1cC20xjlRYjYtn/YrO85OhxRUaYR0SqK8rn+nVE=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=TwSSFGWy8ou6RUmQ2z5qrPujRluplVj8B9yebO1zCiQk3OgciY6Thr8p58LqXZEnG
         lAf6AYrczAkidamJSAte9Yu6GredeO/RQsoVxOyfeVvWtL2KKt9V/F7W+C1KSK+kgG
         SUvbt79UpIWXAPeztnlQ2GBAoROzIqNrFNgVNhUxWsfhT1pf5IDh67vSwnXMqvCS4R
         qsNMqWcpOAmT3zJGmJ4ocuem4Z+sahlU8R3wjuxnq8GXl5Ar3r0g8ai6ZY5yTL9gcA
         MxzIeiNa0GWeLjKiR/Ewgt0U9r2tvr9H9F+OJgyU9LcuLtJZyQzQQgSSoUWPSsLRXX
         Je0UUONKxTkZg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 0C1BA5C0B39; Mon, 26 Sep 2022 20:20:21 -0700 (PDT)
Date:   Mon, 26 Sep 2022 20:20:21 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, rushikesh.s.kadam@intel.com,
        neeraj.iitr10@gmail.com, frederic@kernel.org, rostedt@goodmis.org
Subject: Re: [PATCH v6 1/4] rcu: Make call_rcu() lazy to save power
Message-ID: <20220927032021.GF4196@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220926223534.GY4196@paulmck-ThinkPad-P17-Gen-1>
 <BE2B629D-B5D2-4ED0-944E-2F13E846047E@joelfernandes.org>
 <20220926235755.GD4196@paulmck-ThinkPad-P17-Gen-1>
 <YzJO58HXH6YYxmND@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YzJO58HXH6YYxmND@google.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 27, 2022 at 01:16:23AM +0000, Joel Fernandes wrote:
> On Mon, Sep 26, 2022 at 04:57:55PM -0700, Paul E. McKenney wrote:
> [..]
> > > >>>>>> diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
> > > >>>>>> index 08605ce7379d..40ae36904825 100644
> > > >>>>>> --- a/include/linux/rcupdate.h
> > > >>>>>> +++ b/include/linux/rcupdate.h
> > > >>>>>> @@ -108,6 +108,13 @@ static inline int rcu_preempt_depth(void)
> > > >>>>>> 
> > > >>>>>> #endif /* #else #ifdef CONFIG_PREEMPT_RCU */
> > > >>>>>> 
> > > >>>>>> +#ifdef CONFIG_RCU_LAZY
> > > >>>>>> +void call_rcu_flush(struct rcu_head *head, rcu_callback_t func);
> > > >>>>>> +#else
> > > >>>>>> +static inline void call_rcu_flush(struct rcu_head *head,
> > > >>>>>> +        rcu_callback_t func) {  call_rcu(head, func); }
> > > >>>>>> +#endif
> > > >>>>>> +
> > > >>>>>> /* Internal to kernel */
> > > >>>>>> void rcu_init(void);
> > > >>>>>> extern int rcu_scheduler_active;
> > > >>>>>> diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
> > > >>>>>> index f53ad63b2bc6..edd632e68497 100644
> > > >>>>>> --- a/kernel/rcu/Kconfig
> > > >>>>>> +++ b/kernel/rcu/Kconfig
> > > >>>>>> @@ -314,4 +314,12 @@ config TASKS_TRACE_RCU_READ_MB
> > > >>>>>>      Say N here if you hate read-side memory barriers.
> > > >>>>>>      Take the default if you are unsure.
> > > >>>>>> 
> > > >>>>>> +config RCU_LAZY
> > > >>>>>> +    bool "RCU callback lazy invocation functionality"
> > > >>>>>> +    depends on RCU_NOCB_CPU
> > > >>>>>> +    default n
> > > >>>>>> +    help
> > > >>>>>> +      To save power, batch RCU callbacks and flush after delay, memory
> > > >>>>>> +      pressure or callback list growing too big.
> > > >>>>>> +
> > > >>>>>> 
> > > >>>>> Do you think you need this kernel option? Can we just consider and make
> > > >>>>> it a run-time configurable? For example much more users will give it a try,
> > > >>>>> so it will increase a coverage. By default it can be off.
> > > >>>>> 
> > > >>>>> Also you do not need to do:
> > > >>>>> 
> > > >>>>> #ifdef LAZY
> > > >>>> 
> > > >>>> How does the "LAZY" macro end up being runtime-configurable? That's static /
> > > >>>> compile time. Did I miss something?
> > > >>>> 
> > > >>> I am talking about removing if:
> > > >>> 
> > > >>> config RCU_LAZY
> > > >>> 
> > > >>> we might run into issues related to run-time switching though.
> > > >> 
> > > >> When we started off, Paul said he wanted it kernel CONFIGurable. I will defer
> > > >> to Paul on a decision for that. I prefer kernel CONFIG so people don't forget
> > > >> to pass a boot param.
> > > > 
> > > > I am fine with a kernel boot parameter for this one.  You guys were the
> > > > ones preferring Kconfig options.  ;-)
> > > 
> > > Yes I still prefer that.. ;-)
> > > 
> > > > But in that case, the CONFIG_RCU_NOCB_CPU would come into play to handle
> > > > the case where there is no bypass.
> > > 
> > > If you don’t mind, let’s do both like we did for NOCB_CPU_ALL. In which
> > > case, Vlad since this was your suggestion, would you be so kind to send a
> > > patch adding a boot parameter on top of the series? ;-). I’ll include it
> > > in the next version. I’d suggest keep the boot param default off and add
> > > a CONFIG option that forces the boot param to be turned on.
> > 
> > NOCB_CPU_ALL?  If you are thinking in terms of laziness/flushing being
> > done on a per-CPU basis among the rcu_nocbs CPUs, that sounds like
> > something for later.
> 
> Oh, no, I was just trying to bring that up as an example of making boot
> parameters and CONFIG options for the same thing.
> 
> > Are you thinking in terms of Kconfig options that allow: (1) No laziness.
> > (2) Laziness on all rcu_nocbs CPUs, but only if specified by a boot
> > parameter.  (3) Laziness on all rcu_nocbs CPUs regardless of boot
> > parameter.  I could get behind that.
> 
> Sure agreed, or we could just make it CONFIG_RCU_LAZY_DEFAULT=y and if boot
> param is specified, override the CONFIG. That will be the simplest and least
> confusing IMO.

If CONFIG_RCU_LAZY_DEFAULT=n, what (if anything) does the boot parameter do?

Not criticizing, not yet, anyway.  ;-)

							Thanx, Paul
