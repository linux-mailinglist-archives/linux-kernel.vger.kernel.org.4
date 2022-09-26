Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E41475EB49E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 00:35:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbiIZWfl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 18:35:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiIZWfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 18:35:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67B0E925BD;
        Mon, 26 Sep 2022 15:35:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 33252614B4;
        Mon, 26 Sep 2022 22:35:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B0F4C433C1;
        Mon, 26 Sep 2022 22:35:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664231734;
        bh=K0B8fQ5zGnHhxggHnGB8PPf5/ZMXP/Zm1UsDPPj5wMs=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=nsT2PH2iv1Z3QL+dtSqr2w64DAryv+xs5oAUv03/2XW2HLBdsFnrMtthIIUavDZTc
         jfWe8ZHY/9+yJhxEllvuQXT3qG0bK90teLAH4clx5ycfpPDsgueyyBlTdQ7JUU93Sv
         cz6fo2nd6/Ydod0FoK4vsqOkPh/vVo889XKSS5tkiFh0URani1dXlChduhgTBU89b/
         6kD07Av07v2Ev1rsebHpgLXOK/WTgfgUHe5juZq/rLSKQ6AmCiJ0EaT+zpEsBsYXiy
         jSb214S4F3tN6pbXIiBXvMiyxsIvhqYugdl4P30g2Lb31rRQnsC5lmmC7WUB8E5gn4
         t5D4D8WVXwObw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 2789A5C05B1; Mon, 26 Sep 2022 15:35:34 -0700 (PDT)
Date:   Mon, 26 Sep 2022 15:35:34 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, rushikesh.s.kadam@intel.com,
        neeraj.iitr10@gmail.com, frederic@kernel.org, rostedt@goodmis.org
Subject: Re: [PATCH v6 1/4] rcu: Make call_rcu() lazy to save power
Message-ID: <20220926223534.GY4196@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220922220104.2446868-1-joel@joelfernandes.org>
 <20220922220104.2446868-2-joel@joelfernandes.org>
 <YzAX5kOwjrZzoed6@pc636>
 <YzCUDXn3htWbqM4f@google.com>
 <YzH/646RHxhHBy6+@pc636>
 <YzIRg2u2JYXN9bnK@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzIRg2u2JYXN9bnK@google.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 26, 2022 at 08:54:27PM +0000, Joel Fernandes wrote:
> Hi Vlad,
> 
> On Mon, Sep 26, 2022 at 09:39:23PM +0200, Uladzislau Rezki wrote:
> [...]
> > > > On my KVM machine the boot time is affected:
> > > > 
> > > > <snip>
> > > > [    2.273406] e1000 0000:00:03.0 eth0: Intel(R) PRO/1000 Network Connection
> > > > [   11.945283] e1000 0000:00:03.0 ens3: renamed from eth0
> > > > [   22.165198] sr 1:0:0:0: [sr0] scsi3-mmc drive: 4x/4x cd/rw xa/form2 tray
> > > > [   22.165206] cdrom: Uniform CD-ROM driver Revision: 3.20
> > > > [   32.406981] sr 1:0:0:0: Attached scsi CD-ROM sr0
> > > > [  104.115418] process '/usr/bin/fstype' started with executable stack
> > > > [  104.170142] EXT4-fs (sda1): mounted filesystem with ordered data mode. Quota mode: none.
> > > > [  104.340125] systemd[1]: systemd 241 running in system mode. (+PAM +AUDIT +SELINUX +IMA +APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ +LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD -IDN2 +IDN -PCRE2 default-hierarchy=hybrid)
> > > > [  104.340193] systemd[1]: Detected virtualization kvm.
> > > > [  104.340196] systemd[1]: Detected architecture x86-64.
> > > > [  104.359032] systemd[1]: Set hostname to <pc638>.
> > > > [  105.740109] random: crng init done
> > > > [  105.741267] systemd[1]: Reached target Remote File Systems.
> > > > <snip>
> > > > 
> > > > 2 - 11 and second delay is between 32 - 104. So there are still users which must
> > > > be waiting for "RCU" in a sync way.
> > > 
> > > I was wondering if you can compare boot logs and see which timestamp does the
> > > slow down start from. That way, we can narrow down the callback. Also another
> > > idea is, add "trace_event=rcu:rcu_callback,rcu:rcu_invoke_callback
> > > ftrace_dump_on_oops" to the boot params, and then manually call
> > > "tracing_off(); panic();" from the code at the first printk that seems off in
> > > your comparison of good vs bad. For example, if "crng init done" timestamp is
> > > off, put the "tracing_off(); panic();" there. Then grab the serial console
> > > output to see what were the last callbacks that was queued/invoked.
> 
> Would you be willing to try these steps? Meanwhile I will try on my side as
> well with the .config you sent me in another email.
> 
> > > > > diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
> > > > > index 08605ce7379d..40ae36904825 100644
> > > > > --- a/include/linux/rcupdate.h
> > > > > +++ b/include/linux/rcupdate.h
> > > > > @@ -108,6 +108,13 @@ static inline int rcu_preempt_depth(void)
> > > > >  
> > > > >  #endif /* #else #ifdef CONFIG_PREEMPT_RCU */
> > > > >  
> > > > > +#ifdef CONFIG_RCU_LAZY
> > > > > +void call_rcu_flush(struct rcu_head *head, rcu_callback_t func);
> > > > > +#else
> > > > > +static inline void call_rcu_flush(struct rcu_head *head,
> > > > > +		rcu_callback_t func) {  call_rcu(head, func); }
> > > > > +#endif
> > > > > +
> > > > >  /* Internal to kernel */
> > > > >  void rcu_init(void);
> > > > >  extern int rcu_scheduler_active;
> > > > > diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
> > > > > index f53ad63b2bc6..edd632e68497 100644
> > > > > --- a/kernel/rcu/Kconfig
> > > > > +++ b/kernel/rcu/Kconfig
> > > > > @@ -314,4 +314,12 @@ config TASKS_TRACE_RCU_READ_MB
> > > > >  	  Say N here if you hate read-side memory barriers.
> > > > >  	  Take the default if you are unsure.
> > > > >  
> > > > > +config RCU_LAZY
> > > > > +	bool "RCU callback lazy invocation functionality"
> > > > > +	depends on RCU_NOCB_CPU
> > > > > +	default n
> > > > > +	help
> > > > > +	  To save power, batch RCU callbacks and flush after delay, memory
> > > > > +	  pressure or callback list growing too big.
> > > > > +
> > > > >
> > > > Do you think you need this kernel option? Can we just consider and make
> > > > it a run-time configurable? For example much more users will give it a try,
> > > > so it will increase a coverage. By default it can be off.
> > > > 
> > > > Also you do not need to do:
> > > > 
> > > > #ifdef LAZY
> > > 
> > > How does the "LAZY" macro end up being runtime-configurable? That's static /
> > > compile time. Did I miss something?
> > > 
> > I am talking about removing if:
> > 
> > config RCU_LAZY
> > 
> > we might run into issues related to run-time switching though.
> 
> When we started off, Paul said he wanted it kernel CONFIGurable. I will defer
> to Paul on a decision for that. I prefer kernel CONFIG so people don't forget
> to pass a boot param.

I am fine with a kernel boot parameter for this one.  You guys were the
ones preferring Kconfig options.  ;-)

But in that case, the CONFIG_RCU_NOCB_CPU would come into play to handle
the case where there is no bypass.

							Thanx, Paul
