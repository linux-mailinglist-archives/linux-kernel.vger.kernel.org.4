Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F7E75F0EEC
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 17:35:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231373AbiI3PfP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 11:35:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231320AbiI3PfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 11:35:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CC2A7A507;
        Fri, 30 Sep 2022 08:35:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 60041B8294C;
        Fri, 30 Sep 2022 15:35:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ADAEC433D6;
        Fri, 30 Sep 2022 15:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664552107;
        bh=V1v51XA15ibgw/ZSURTuBj6NK6h8zctYBjxiV7XCb1A=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=jZ+lHdoG7zudaWlkQE9qj8788pSzVuO2N5/mRJQKUGU5yZkrOF1/rm2IbtZTGLCmD
         hJNNTPB9tZ7ag4FfxtXpEFWnpSUEbWSODHaOITU9C2uS10nxCWb/7NO8TU43tK/mH2
         tv15Ilohcmv8/6vjc8fK+ysvvyDGCuLP/2c15ybv2MeFRpioW027wHklAwnpixaQ9X
         COew1oxGYlWUkxPOzAXEYMKJkAgM2x+b5aDFt4h1ut0ifVYxM+R7fe3Bq1kMCbOs8j
         0di6Q5cqoCDgzmsUa4KstDwtJ3ovBEcxxpEcUaT4qUjBXaBmtRuAbLCfG7LGVGNYxV
         nwavEGdZrOXBQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id ADB325C0BE3; Fri, 30 Sep 2022 08:35:06 -0700 (PDT)
Date:   Fri, 30 Sep 2022 08:35:06 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, rostedt@goodmis.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH RFC v2 rcu 1/8] srcu: Convert ->srcu_lock_count and
 ->srcu_unlock_count to atomic
Message-ID: <20220930153506.GD4196@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220929180714.GA2874192@paulmck-ThinkPad-P17-Gen-1>
 <20220929180731.2875722-1-paulmck@kernel.org>
 <87ill4vrb9.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ill4vrb9.fsf@jogness.linutronix.de>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 30, 2022 at 05:08:18PM +0206, John Ogness wrote:
> Hi Paul,
> 
> On 2022-09-29, "Paul E. McKenney" <paulmck@kernel.org> wrote:
> > diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> > index 1c304fec89c0..6fd0665f4d1f 100644
> > --- a/kernel/rcu/srcutree.c
> > +++ b/kernel/rcu/srcutree.c
> > @@ -636,7 +636,7 @@ int __srcu_read_lock(struct srcu_struct *ssp)
> >  	int idx;
> >  
> >  	idx = READ_ONCE(ssp->srcu_idx) & 0x1;
> > -	this_cpu_inc(ssp->sda->srcu_lock_count[idx]);
> > +	this_cpu_inc(ssp->sda->srcu_lock_count[idx].counter);
> >  	smp_mb(); /* B */  /* Avoid leaking the critical section. */
> >  	return idx;
> >  }
> 
> Is there any particular reason that you are directly modifying @counter
> instead of raw_cpu_ptr()+atomic_long_inc() that do you in
> __srcu_read_lock_nmisafe() of patch 2?

Performance.  From what I can see, this_cpu_inc() is way faster than
atomic_long_inc() on x86 and s390.  Maybe also on loongarch.  No idea
on arm64.

> > @@ -650,7 +650,7 @@ EXPORT_SYMBOL_GPL(__srcu_read_lock);
> >  void __srcu_read_unlock(struct srcu_struct *ssp, int idx)
> >  {
> >  	smp_mb(); /* C */  /* Avoid leaking the critical section. */
> > -	this_cpu_inc(ssp->sda->srcu_unlock_count[idx]);
> > +	this_cpu_inc(ssp->sda->srcu_unlock_count[idx].counter);
> >  }
> >  EXPORT_SYMBOL_GPL(__srcu_read_unlock);
> 
> Ditto.

Ditto back at you!  ;-)

> > @@ -1687,8 +1687,8 @@ void srcu_torture_stats_print(struct srcu_struct *ssp, char *tt, char *tf)
> >  			struct srcu_data *sdp;
> >  
> >  			sdp = per_cpu_ptr(ssp->sda, cpu);
> > -			u0 = data_race(sdp->srcu_unlock_count[!idx]);
> > -			u1 = data_race(sdp->srcu_unlock_count[idx]);
> > +			u0 = data_race(sdp->srcu_unlock_count[!idx].counter);
> > +			u1 = data_race(sdp->srcu_unlock_count[idx].counter);
> >  
> >  			/*
> >  			 * Make sure that a lock is always counted if the corresponding
> 
> And instead of atomic_long_read().

You are right, here I could just as well use atomic_long_read().

> > @@ -1696,8 +1696,8 @@ void srcu_torture_stats_print(struct srcu_struct *ssp, char *tt, char *tf)
> >  			 */
> >  			smp_rmb();
> >  
> > -			l0 = data_race(sdp->srcu_lock_count[!idx]);
> > -			l1 = data_race(sdp->srcu_lock_count[idx]);
> > +			l0 = data_race(sdp->srcu_lock_count[!idx].counter);
> > +			l1 = data_race(sdp->srcu_lock_count[idx].counter);
> >  
> >  			c0 = l0 - u0;
> >  			c1 = l1 - u1;
> 
> Ditto.

And here as well.  ;-)

I will fix these, and thank you for looking this over!

							Thanx, Paul
