Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 395CA5F2402
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Oct 2022 18:10:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbiJBQKK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Oct 2022 12:10:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230003AbiJBQKA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Oct 2022 12:10:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38D7414D1C;
        Sun,  2 Oct 2022 09:09:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 55B6C60EE6;
        Sun,  2 Oct 2022 16:09:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A96B9C433D6;
        Sun,  2 Oct 2022 16:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664726997;
        bh=6AHOtxn8ChjuF9xscKsKUy4q/JvTx0xf6gt6Gom4JFs=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=idP7q+gnazFDO38aCyQudXI0RBz3DsyCpbzhJcwOcO+yuDMKASL0BSDToImPVu8Ze
         uedSbwVV2a9C0rBRCjmfVA1j3BnvJvkhnX0ouxekXqVujXHrQwKdy9sTkRZuw0G9pT
         LfyvbHKkHwRE8qLyCROMtTFNlc7d1fPlMCYHPVF+vvt5qnhyaJnKD9F6pNIA8jb+tG
         affmoRix/bM9aaD44kjvC6a8iqVAjWF220r+u3QfVfBad40v4Ar47fy6jOJLkjJrKt
         d81ffZ+dbPxdL/JAfMwKmmMc6oz0eN+MpHTi+yWoPB0b3bkNFeqIBNYYaMEcic1CB2
         Tsv2VUZmxzHOg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 42F6D5C086D; Sun,  2 Oct 2022 09:09:57 -0700 (PDT)
Date:   Sun, 2 Oct 2022 09:09:57 -0700
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
Message-ID: <20221002160957.GP4196@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220929180714.GA2874192@paulmck-ThinkPad-P17-Gen-1>
 <20220929180731.2875722-2-paulmck@kernel.org>
 <20221002155516.GB292620@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221002155516.GB292620@lothringen>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 02, 2022 at 05:55:16PM +0200, Frederic Weisbecker wrote:
> On Thu, Sep 29, 2022 at 11:07:25AM -0700, Paul E. McKenney wrote:
> > @@ -1090,7 +1121,7 @@ static unsigned long srcu_gp_start_if_needed(struct srcu_struct *ssp,
> >  	int ss_state;
> >  
> >  	check_init_srcu_struct(ssp);
> > -	idx = srcu_read_lock(ssp);
> > +	idx = __srcu_read_lock_nmisafe(ssp);
> 
> Why do we need to force the atomic based version here (even if CONFIG_NEED_SRCU_NMI_SAFE=y)?

In kernels built with CONFIG_NEED_SRCU_NMI_SAFE=n, we of course need it.
As you say, in kernels built with CONFIG_NEED_SRCU_NMI_SAFE=y, we don't.
But it doesn't hurt to always use __srcu_read_lock_nmisafe() here, and
this is nowhere near a fastpath, so there is little benefit to using
__srcu_read_lock() when it is safe to do so.

In addition, note that it is possible that a given srcu_struct structure's
first grace period is executed before its first reader.  In that
case, we have no way of knowing which of __srcu_read_lock_nmisafe()
or __srcu_read_lock() to choose.

So this code always does it the slow(ish) safe way.

> >  	ss_state = smp_load_acquire(&ssp->srcu_size_state);
> >  	if (ss_state < SRCU_SIZE_WAIT_CALL)
> >  		sdp = per_cpu_ptr(ssp->sda, 0);
> > @@ -1123,7 +1154,7 @@ static unsigned long srcu_gp_start_if_needed(struct srcu_struct *ssp,
> >  		srcu_funnel_gp_start(ssp, sdp, s, do_norm);
> >  	else if (needexp)
> >  		srcu_funnel_exp_start(ssp, sdp_mynode, s);
> > -	srcu_read_unlock(ssp, idx);
> > +	__srcu_read_unlock_nmisafe(ssp, idx);
> >  	return s;
> >  }
> >  
> > @@ -1427,13 +1458,13 @@ void srcu_barrier(struct srcu_struct *ssp)
> >  	/* Initial count prevents reaching zero until all CBs are posted. */
> >  	atomic_set(&ssp->srcu_barrier_cpu_cnt, 1);
> >  
> > -	idx = srcu_read_lock(ssp);
> > +	idx = __srcu_read_lock_nmisafe(ssp);
> 
> And same here?

Yes, same here.  ;-)

							Thanx, Paul

> Thanks.
> 
> >  	if (smp_load_acquire(&ssp->srcu_size_state) < SRCU_SIZE_WAIT_BARRIER)
> >  		srcu_barrier_one_cpu(ssp, per_cpu_ptr(ssp->sda, 0));
> >  	else
> >  		for_each_possible_cpu(cpu)
> >  			srcu_barrier_one_cpu(ssp, per_cpu_ptr(ssp->sda, cpu));
> > -	srcu_read_unlock(ssp, idx);
> > +	__srcu_read_unlock_nmisafe(ssp, idx);
> >  
> >  	/* Remove the initial count, at which point reaching zero can happen. */
> >  	if (atomic_dec_and_test(&ssp->srcu_barrier_cpu_cnt))
> > -- 
> > 2.31.1.189.g2e36527f23
> > 
