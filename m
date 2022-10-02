Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66CF85F2744
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 01:47:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbiJBXrA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Oct 2022 19:47:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbiJBXq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Oct 2022 19:46:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8EC83386D;
        Sun,  2 Oct 2022 16:46:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5B5BB60EF8;
        Sun,  2 Oct 2022 23:46:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F2E6C433C1;
        Sun,  2 Oct 2022 23:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664754415;
        bh=XcewWfKnRD74JQsdozQG7901trIOCcxllnj8J+U8pbs=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=iaBx7Svbo4yi2e/ADqUKhoWl/JlTDVmiWP5lC/MdUXZ/TaaCai59PoKlLNkPklggM
         wAzhwQRqB10sGs+8tH7XCYf78o4ieAVHgvh6AkkTxuIqV+af0o2PDVpjKIHoK0gm+/
         sH5EXmv1dvYTzSXpp3Cw2lsR28XPfad40LnyLBJqQm2EBk3LWRKVsfhi8UBYgnkawh
         b1Gd+q85P/KdFBWbc0OuG4LA3zNxiJOdkMcEKPasIs9Jrf+U3LhtZFzjcZh5dpNnFU
         kL1dKQTR5qjoWK5Nljb57ynEyPiX4Or1O+Ekb2i2FKoW/juGgtHDUmuvi/7UdVGIte
         x1RDMGYJK7xtw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 3AF855C0BE3; Sun,  2 Oct 2022 16:46:55 -0700 (PDT)
Date:   Sun, 2 Oct 2022 16:46:55 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, rostedt@goodmis.org,
        Randy Dunlap <rdunlap@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        John Ogness <john.ogness@linutronix.de>,
        Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH RFC v2 rcu 2/8] srcu: Create an srcu_read_lock_nmisafe()
 and srcu_read_unlock_nmisafe()
Message-ID: <20221002234655.GV4196@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220929180714.GA2874192@paulmck-ThinkPad-P17-Gen-1>
 <20220929180731.2875722-2-paulmck@kernel.org>
 <20221002155516.GB292620@lothringen>
 <20221002160957.GP4196@paulmck-ThinkPad-P17-Gen-1>
 <20221002214710.GA297965@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221002214710.GA297965@lothringen>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 02, 2022 at 11:47:10PM +0200, Frederic Weisbecker wrote:
> On Sun, Oct 02, 2022 at 09:09:57AM -0700, Paul E. McKenney wrote:
> > On Sun, Oct 02, 2022 at 05:55:16PM +0200, Frederic Weisbecker wrote:
> > > On Thu, Sep 29, 2022 at 11:07:25AM -0700, Paul E. McKenney wrote:
> > > > @@ -1090,7 +1121,7 @@ static unsigned long srcu_gp_start_if_needed(struct srcu_struct *ssp,
> > > >  	int ss_state;
> > > >  
> > > >  	check_init_srcu_struct(ssp);
> > > > -	idx = srcu_read_lock(ssp);
> > > > +	idx = __srcu_read_lock_nmisafe(ssp);
> > > 
> > > Why do we need to force the atomic based version here (even if CONFIG_NEED_SRCU_NMI_SAFE=y)?
> > 
> > In kernels built with CONFIG_NEED_SRCU_NMI_SAFE=n, we of course need it.
> > As you say, in kernels built with CONFIG_NEED_SRCU_NMI_SAFE=y, we don't.
> > But it doesn't hurt to always use __srcu_read_lock_nmisafe() here, and
> > this is nowhere near a fastpath, so there is little benefit to using
> > __srcu_read_lock() when it is safe to do so.
> > 
> > In addition, note that it is possible that a given srcu_struct structure's
> > first grace period is executed before its first reader.  In that
> > case, we have no way of knowing which of __srcu_read_lock_nmisafe()
> > or __srcu_read_lock() to choose.
> > 
> > So this code always does it the slow(ish) safe way.
> 
> But then srcu_read_lock_nmisafe() would work as well, right?

Almost.

The problem is that without the leading "__", this would convince SRCU
that this is an NMI-safe srcu_struct.  Which it might not be.  Worse yet,
if this srcu_struct had already done an srcu_read_lock(), it would splat.

> > > >  	ss_state = smp_load_acquire(&ssp->srcu_size_state);
> > > >  	if (ss_state < SRCU_SIZE_WAIT_CALL)
> > > >  		sdp = per_cpu_ptr(ssp->sda, 0);
> > > > @@ -1123,7 +1154,7 @@ static unsigned long srcu_gp_start_if_needed(struct srcu_struct *ssp,
> > > >  		srcu_funnel_gp_start(ssp, sdp, s, do_norm);
> > > >  	else if (needexp)
> > > >  		srcu_funnel_exp_start(ssp, sdp_mynode, s);
> > > > -	srcu_read_unlock(ssp, idx);
> > > > +	__srcu_read_unlock_nmisafe(ssp, idx);
> > > >  	return s;
> > > >  }
> > > >  
> > > > @@ -1427,13 +1458,13 @@ void srcu_barrier(struct srcu_struct *ssp)
> > > >  	/* Initial count prevents reaching zero until all CBs are posted. */
> > > >  	atomic_set(&ssp->srcu_barrier_cpu_cnt, 1);
> > > >  
> > > > -	idx = srcu_read_lock(ssp);
> > > > +	idx = __srcu_read_lock_nmisafe(ssp);
> > > 
> > > And same here?
> > 
> > Yes, same here.  ;-)
> 
> Now bonus question: why do SRCU grace period starting/tracking
> need to be in an SRCU read side critical section? :o)

Because I am lazy and like to keep things simple?  ;-)

More seriously, take a look at srcu_gp_start_if_needed() and the functions
it calls and ask yourself what bad things could happen if they were
preempted for an arbitrarily long period of time.

							Thanx, Paul
