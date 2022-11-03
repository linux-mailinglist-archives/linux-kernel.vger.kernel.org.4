Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2281D61869E
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 18:52:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231697AbiKCRwA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 13:52:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231751AbiKCRvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 13:51:48 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D21D1C43B;
        Thu,  3 Nov 2022 10:51:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id B6BAFCE2843;
        Thu,  3 Nov 2022 17:51:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBBE3C433C1;
        Thu,  3 Nov 2022 17:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667497904;
        bh=L+sNr/FqyDEU87OQPrwUpURz+jZQ/1LLsG0ms6DSClA=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=N87pll4v56mkKsSoYdALk8xub7rUu/L6lKbgoG/aqp4G6fn2XrO1MS22L9kuGSKih
         wdi2BSG8rvvPenruDXVKIjeCqUnFtLYXh6ciAhv7LteGbvRtwPY0wysjMSEkCPV+bi
         29UKqi7jxSI6L38Etq/HdPqaQRfQ+c7pyi+rFlwD/HKkjnRUAKEg/Svpv9RgjeRY5B
         Xp4mBwwDkQEfkvbf966NwrtFVZTBiDIW9VmKMFsZLplvnm2z4FZu74snZozV2uwbTQ
         h06ZTONDGhkKOeLQvg76yN/YBUKKeOWfIyPWCfAxwSu1j/wPL6UjTAFQBsprGzERrp
         nazFR9znPhIgA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 882F05C097E; Thu,  3 Nov 2022 10:51:43 -0700 (PDT)
Date:   Thu, 3 Nov 2022 10:51:43 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] rcu/kfree: Do not request RCU when not needed
Message-ID: <20221103175143.GB5600@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221102184911.GP5600@paulmck-ThinkPad-P17-Gen-1>
 <755B5ED1-653D-4E57-B114-77CDE10A9033@joelfernandes.org>
 <20221102202813.GR5600@paulmck-ThinkPad-P17-Gen-1>
 <Y2O3Bz0DMEBZF+83@pc638.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y2O3Bz0DMEBZF+83@pc638.lan>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 03, 2022 at 01:41:43PM +0100, Uladzislau Rezki wrote:
> > > >> /**
> > > >> @@ -3066,10 +3068,12 @@ static void kfree_rcu_work(struct work_struct *work)
> > > >>    struct kfree_rcu_cpu_work *krwp;
> > > >>    int i, j;
> > > >> 
> > > >> -    krwp = container_of(to_rcu_work(work),
> > > >> +    krwp = container_of(work,
> > > >>                struct kfree_rcu_cpu_work, rcu_work);
> > > >>    krcp = krwp->krcp;
> > > >> 
> > > >> +    cond_synchronize_rcu(krwp->gp_snap);
> > > > 
> > > > Might this provoke OOMs in case of callback flooding?
> > > > 
> > > > An alternative might be something like this:
> > > > 
> > > >    if (!poll_state_synchronize_rcu(krwp->gp_snap)) {
> > > >        queue_rcu_work(system_wq, &krwp->rcu_work);
> > > >        return;
> > > >    }
> > > > 
> > > > Either way gets you a non-lazy callback in the case where a grace
> > > > period has not yet elapsed.
> > > > Or am I missing something that prevents OOMs here?
> > > 
> > > The memory consumptions appears to be much less in his testing with the onslaught of kfree, which makes OOM probably less likely.
> > > 
> > > Though, was your reasoning that in case of a grace period not elapsing, we need a non lazy callback queued, so as to make the reclaim happen sooner?
> > > 
> > > If so, the cond_synchronize_rcu() should already be conditionally queueing non-lazy CB since we don’t make synchronous users wait for seconds. Or did I miss something?
> > 
> > My concern is that the synchronize_rcu() will block a kworker kthread
> > for some time, and that in callback-flood situations this might slow
> > things down due to exhausting the supply of kworkers.
> > 
> This concern works in both cases. I mean in default configuration and
> with a posted patch. The reclaim work, which name is kfree_rcu_work() only
> does a progress when a gp is passed so the rcu_work_rcufn() can queue
> our reclaim kworker.
> 
> As it is now:
> 
> 1. Collect pointers, then we decide to drop them we queue the
>    monitro_work() worker to the system_wq.
> 
> 2. The monitor work, kfree_rcu_work(), tries to attach or saying
> it by another words bypass a "backlog" to "free" channels.
> 
> 3. It invokes the queue_rcu_work() that does call_rcu_flush() and
> in its turn it queues our worker from the handler. So the worker
> is run after GP is passed.

So as it is now, we are not tying up a kworker kthread while waiting
for the grace period, correct?  We instead have an RCU callback queued
during that time, and the kworker kthread gets involved only after the
grace period ends.

> With a patch: 
> 
> [1] and [2] steps are the same. But on third step we do:
> 
> 1. Record the GP status for last in channel;
> 2. Directly queue the drain work without any call_rcu() helpers;
> 3. On the reclaim worker entry we check if GP is passed;
> 4. If not it invokes synchronize_rcu().

And #4 changes that, by (sometimes) tying up a kworker kthread for the
full grace period.

> The patch eliminates extra steps by not going via RCU-core route
> instead it directly invokes the reclaim worker where it either
> proceed or wait a GP if needed.

I agree that the use of the polled API could be reducing delays, which
is a good thing.  Just being my usual greedy self and asking "Why not
both?", that is use queue_rcu_work() instead of synchronize_rcu() in
conjunction with the polled APIs so as to avoid both the grace-period
delay and the tying up of the kworker kthread.

Or am I missing something here?

							Thanx, Paul
