Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B9E263BDF9
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 11:30:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbiK2Ka3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 05:30:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbiK2Ka1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 05:30:27 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DD4443841
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 02:30:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D19996163F
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 10:30:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB83FC433D6;
        Tue, 29 Nov 2022 10:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669717825;
        bh=tsChTk2lNnfhfT5WAB5AdC2MGZxTWsYaSIB/W+j6Euw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CceToEYwaXxwDZ7/HJN+IneV5V5FbKQmArc3bP7+E9OlH4skdO9EKHKAcZyasahjt
         8jfDwQnybMbk+edqmlCeBeNfP4O7Cp8XkXXHwhXy1f2iAOv5ybQC2XxJz5cWTJoBrl
         qt1LqFrzC1/f708Vkxcx2r59cPZRNfcT3Z5ZiloC0vHXV5mAoRRcgBEFRhxpn1Rneg
         753Y/NHJln8VAFxkzN9OOJojy+8exlsI828rnAzpudEsGyipFPhQaWy8jmK3l6T/dM
         DIVHWV5AZEYVEu38L2RiRWDrEzM8aSSSllQyujt2Ceiq5v/9N3wX1TZcjDqUjXy4Y/
         /o1bUCrCgl52A==
Date:   Tue, 29 Nov 2022 11:30:21 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Eric Dumazet <edumazet@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Arjan van de Ven <arjan@infradead.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Rik van Riel <riel@surriel.com>
Subject: Re: [PATCH v4 14/16] timer: Implement the hierarchical pull model
Message-ID: <20221129103021.GB1706373@lothringen>
References: <20221104145737.71236-1-anna-maria@linutronix.de>
 <20221104145737.71236-15-anna-maria@linutronix.de>
 <20221115113152.GH590078@lothringen>
 <e2b4a90-2d9-f2db-8c85-2e64caed5d0@linutronix.de>
 <20221128162010.GB1699488@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221128162010.GB1699488@lothringen>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 28, 2022 at 05:20:10PM +0100, Frederic Weisbecker wrote:
> On Thu, Nov 24, 2022 at 08:47:56AM +0100, Anna-Maria Behnsen wrote:
> > On Tue, 15 Nov 2022, Frederic Weisbecker wrote:
> > 
> > > On Fri, Nov 04, 2022 at 03:57:35PM +0100, Anna-Maria Behnsen wrote:
> > > > +static int tmigr_cpu_offline(unsigned int cpu)
> > > > +{
> > > > +	struct tmigr_cpu *tmc = this_cpu_ptr(&tmigr_cpu);
> > > > +
> > > > +	raw_spin_lock_irq(&tmc->lock);
> > > > +	tmc->online = 0;
> > > > +	__tmigr_cpu_deactivate(tmc, KTIME_MAX);
> > > 
> > > This means that if the CPU is going idle for some time during
> > > the hotplug process (ie: at some point between CPUHP_AP_TMIGR_ONLINE
> > > and CPUHP_TEARDOWN_CPU), then a global timer may be delayed for that long.
> > > 
> > > I guess it shouldn't be too bad but worth mentioning...
> > > 
> > > Although if it happens to be a problem it could be solved with simply allowing
> > > tmigr_cpu_deactivate() when !tmc->online.
> > 
> > The plan was (and I broke it) to let the CPU handle global timers by itself
> > as long as timer migration hierarchy is not completely initialized and as
> > long as CPU is marked offline in timer migration hierarchy. Otherwise
> > global timers might be delayed during this period. The proper way would be
> > that tmigr_cpu_deactivate(nextexp) directly returns nextexp if !tmc->online
> > and tmigr hierarchy is not in place yet. I will have a deeper look if there
> > was a reason why I changed the return to KTIME_MAX...
> 
> Well, do you need tmc->online at all?
> 
> I guess tmigr_cpu_offline() could be simply removed because when the CPU goes
> finally down in do_idle() it does:
> 
> 	tick_nohz_idle_stop_tick();
> 	cpuhp_report_idle_dead();
> 
> So the tick is expected to be stopped (better check it is) and thus the tmc
> should be deactivated.
> 
> I guess you just need to call tmigr_cpu_activate() from timers_prepare_cpu().

Now of course the issue is that between CPUHP_TIMERS_PREPARE and
CPUHP_AP_ONLINE_IDLE the tglobal timers may not be served.

One way to deal with that is to call tmigr_cpu_activate() from
cpu_startup_entry().

Otherwise then back to tmc->online I guess.
