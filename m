Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25DE1606B61
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 00:42:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbiJTWmF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 18:42:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbiJTWmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 18:42:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00DCF222F32;
        Thu, 20 Oct 2022 15:41:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C613FB8224C;
        Thu, 20 Oct 2022 22:41:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69FBDC433D6;
        Thu, 20 Oct 2022 22:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666305706;
        bh=Yi4fDwSopn4pkowl2P2tTxm/UJWI6VaP5ZfVWNtQKvM=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=gpAMmahO3E4acOm9gJLrL+b9ScxKrlfJraDV6LtILX0BSz9nKft5lmvO7XuLB3Pp9
         8vlJqa3lT4ZtCDDpQc1HtmZ5XY1+XSkuxkGDSJ3P/II05+vlyvjqCxAnmD6hYaNtBO
         LeP26d68XGpwpddeC+k3+SWNyyOPsgkcLMYA0DcuWX2fEZgDp8kT8W34rnocsfXziU
         9fM4GKb9bBArzsxwFjwets/PLxQFhs/Xc6V5QpHt2I5wS8crMQ8+Yy26OJVUBFAyeX
         GHXT71fu7fCSqrmUWZKBLRhfPz6ySeRW/wM+5thGosFBvdWmnA+922b3+EzpZqiUuQ
         7pzxmFBAXCZhA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 0BC1E5C1109; Thu, 20 Oct 2022 15:41:46 -0700 (PDT)
Date:   Thu, 20 Oct 2022 15:41:46 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     John Ogness <john.ogness@linutronix.de>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, tglx@linutronix.de, pmladek@suse.com
Subject: Re: [PATCH v2 rcu 0/8] NMI-safe SRCU reader API
Message-ID: <20221020224146.GA354603@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220929180714.GA2874192@paulmck-ThinkPad-P17-Gen-1>
 <87k04x4e0r.fsf@jogness.linutronix.de>
 <20221018152418.GR5600@paulmck-ThinkPad-P17-Gen-1>
 <87ilkh0y52.fsf@jogness.linutronix.de>
 <20221018185936.GX5600@paulmck-ThinkPad-P17-Gen-1>
 <20221018215721.GA1716567@paulmck-ThinkPad-P17-Gen-1>
 <87pmeoawwe.fsf@jogness.linutronix.de>
 <20221019191418.GF5600@paulmck-ThinkPad-P17-Gen-1>
 <20221019220537.GA1234896@lothringen>
 <20221020222718.GA5600@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221020222718.GA5600@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 20, 2022 at 03:27:18PM -0700, Paul E. McKenney wrote:
> On Thu, Oct 20, 2022 at 12:05:37AM +0200, Frederic Weisbecker wrote:
> > On Wed, Oct 19, 2022 at 12:14:18PM -0700, Paul E. McKenney wrote:
> > > On Wed, Oct 19, 2022 at 01:19:53PM +0206, John Ogness wrote:
> > > > On 2022-10-18, "Paul E. McKenney" <paulmck@kernel.org> wrote:
> > > > > And the v6.1-rc1 stack is now at srcunmisafe.2022.10.18b.
> > > > 
> > > > Thanks!
> > > > 
> > > > I guess the kernel test robot will catch this, but if you checkout
> > > > commit 79c95dc428ad ("arch/x86: Add ARCH_HAS_NMI_SAFE_THIS_CPU_OPS
> > > > Kconfig option") and build for x86_64, you will get:
> > > > 
> > > > x86_64-linux-gnu-ld: kernel/rcu/srcutree.o: in function `srcu_gp_start_if_needed':
> > > > srcutree.c:(.text+0x133a): undefined reference to `__srcu_read_lock_nmisafe'
> > > > x86_64-linux-gnu-ld: srcutree.c:(.text+0x1490): undefined reference to `__srcu_read_unlock_nmisafe'
> > > > x86_64-linux-gnu-ld: kernel/rcu/srcutree.o: in function `srcu_barrier':
> > > > srcutree.c:(.text+0x1b03): undefined reference to `__srcu_read_lock_nmisafe'
> > > > x86_64-linux-gnu-ld: srcutree.c:(.text+0x1b38): undefined reference to `__srcu_read_unlock_nmisafe'
> > > > 
> > > > Note that this error is fixed with a later commit:
> > > > 
> > > > commit c2d158a284ab ("srcu: Debug NMI safety even on archs that don't
> > > > require it").
> > > > 
> > > > This does not affect what I am working on, so feel free to take care of
> > > > it whenever it fits your schedule.
> > > 
> > > Good catch, thank you!
> > > 
> > > It looks like the first two hunks in include/linux/srcu.h from that
> > > later commit need to be in that earlier commit.
> > > 
> > > Frederic, does this make sense, or am I off in the weeds?
> > 
> > Actually you need to do that earlier, in
> > 6584822b1be1 ("srcu: Create an srcu_read_lock_nmisafe() and srcu_read_unlock_nmisafe()")
> > 
> > This way you don't only fix x86 bisectability but also the one of all the other safe archs.
> > 
> > And it's not just the first two hunks, you also need to include
> > the removal of the srcutiny.h/srcutree.h definitions.
> > 
> > So namely you need to apply the following to 6584822b1be1. You might
> > meet some minor retro-conflicts (the chknmisafe parameter didn't exist yet),
> > but that's pretty much it:
> 
> Thank you both!
> 
> I have an untested but allegedly fixed branch on -rcu on branch
> srcunmisafe.2022.10.20a.

Aside from having accidentally fused Frederic's last two commits together.
I will split them back out on the next rebase.

							Thanx, Paul

> > diff --git a/include/linux/srcu.h b/include/linux/srcu.h
> > index 565f60d57484..f0814ffca34b 100644
> > --- a/include/linux/srcu.h
> > +++ b/include/linux/srcu.h
> > @@ -52,8 +52,6 @@ int init_srcu_struct(struct srcu_struct *ssp);
> >  #else
> >  /* Dummy definition for things like notifiers.  Actual use gets link error. */
> >  struct srcu_struct { };
> > -int __srcu_read_lock_nmisafe(struct srcu_struct *ssp, bool chknmisafe) __acquires(ssp);
> > -void __srcu_read_unlock_nmisafe(struct srcu_struct *ssp, int idx, bool chknmisafe) __releases(ssp);
> >  #endif
> >  
> >  void call_srcu(struct srcu_struct *ssp, struct rcu_head *head,
> > @@ -66,6 +64,20 @@ unsigned long get_state_synchronize_srcu(struct srcu_struct *ssp);
> >  unsigned long start_poll_synchronize_srcu(struct srcu_struct *ssp);
> >  bool poll_state_synchronize_srcu(struct srcu_struct *ssp, unsigned long cookie);
> >  
> > +#ifdef CONFIG_NEED_SRCU_NMI_SAFE
> > +int __srcu_read_lock_nmisafe(struct srcu_struct *ssp) __acquires(ssp);
> > +void __srcu_read_unlock_nmisafe(struct srcu_struct *ssp, int idx) __releases(ssp);
> > +#else
> > +static inline int __srcu_read_lock_nmisafe(struct srcu_struct *ssp)
> > +{
> > +	return __srcu_read_lock(ssp);
> > +}
> > +static inline void __srcu_read_unlock_nmisafe(struct srcu_struct *ssp, int idx)
> > +{
> > +	__srcu_read_unlock(ssp, idx);
> > +}
> > +#endif /* CONFIG_NEED_SRCU_NMI_SAFE */
> > +
> >  #ifdef CONFIG_SRCU
> >  void srcu_init(void);
> >  #else /* #ifdef CONFIG_SRCU */
> > diff --git a/include/linux/srcutiny.h b/include/linux/srcutiny.h
> > index f890301f123d..f3a4d65b91ef 100644
> > --- a/include/linux/srcutiny.h
> > +++ b/include/linux/srcutiny.h
> > @@ -89,16 +89,4 @@ static inline void srcu_torture_stats_print(struct srcu_struct *ssp,
> >  		 data_race(READ_ONCE(ssp->srcu_idx)),
> >  		 data_race(READ_ONCE(ssp->srcu_idx_max)));
> >  }
> > -
> > -static inline int __srcu_read_lock_nmisafe(struct srcu_struct *ssp, bool chknmisafe)
> > -{
> > -	BUG();
> > -	return 0;
> > -}
> > -
> > -static inline void __srcu_read_unlock_nmisafe(struct srcu_struct *ssp, int idx, bool chknmisafe)
> > -{
> > -	BUG();
> > -}
> > -
> >  #endif
> > diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
> > index 35ffdedf86cc..c689a81752c9 100644
> > --- a/include/linux/srcutree.h
> > +++ b/include/linux/srcutree.h
> > @@ -159,7 +155,4 @@ void synchronize_srcu_expedited(struct srcu_struct *ssp);
> >  void srcu_barrier(struct srcu_struct *ssp);
> >  void srcu_torture_stats_print(struct srcu_struct *ssp, char *tt, char *tf);
> >  
> > -int __srcu_read_lock_nmisafe(struct srcu_struct *ssp, bool chknmisafe) __acquires(ssp);
> > -void __srcu_read_unlock_nmisafe(struct srcu_struct *ssp, int idx, bool chknmisafe) __releases(ssp);
> > -
> >  #endif
> > 
> > 
