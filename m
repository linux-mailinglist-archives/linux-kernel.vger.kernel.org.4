Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B51D063AD83
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 17:20:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231896AbiK1QUR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 11:20:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231743AbiK1QUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 11:20:15 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D20A5219B
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 08:20:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 67A8F61245
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 16:20:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7403AC433D6;
        Mon, 28 Nov 2022 16:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669652413;
        bh=bMg0cj3qFxO+1K9hMYJ2UaA3wGkPMTjESiR5sw9ag58=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h5t+jLUTb6/eznuzlaE8V6HwOERy4xcK8p/bqroQKm+Pa5ev0KZR4e/ig/zcDhcVZ
         DDtU0rmswSg9Egqk89bBG0aVxZEzZcVU7QimSQAr+DkpQngrRM19Ox78jq8i9TH23U
         6cAdpXgWdbDf8FqJIBx4xss+Nak66IEVhUONotomKJaQA95j+yJB++2xHZKMm9VfVa
         pOoarKRfEfcvh72yCfOhJC5z9xNmWF8OkzNuzEirWgmzTmE/peTyN0A2gJuc5dvWkb
         lq3zgFzhaLxd9q8MYkD+kf4jGDzXh3A+0GXyAkB2dj0jLatkcm+iHF5K4BrkhH2iia
         Tn1B0qq/VOqtA==
Date:   Mon, 28 Nov 2022 17:20:10 +0100
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
Message-ID: <20221128162010.GB1699488@lothringen>
References: <20221104145737.71236-1-anna-maria@linutronix.de>
 <20221104145737.71236-15-anna-maria@linutronix.de>
 <20221115113152.GH590078@lothringen>
 <e2b4a90-2d9-f2db-8c85-2e64caed5d0@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e2b4a90-2d9-f2db-8c85-2e64caed5d0@linutronix.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 24, 2022 at 08:47:56AM +0100, Anna-Maria Behnsen wrote:
> On Tue, 15 Nov 2022, Frederic Weisbecker wrote:
> 
> > On Fri, Nov 04, 2022 at 03:57:35PM +0100, Anna-Maria Behnsen wrote:
> > > +static int tmigr_cpu_offline(unsigned int cpu)
> > > +{
> > > +	struct tmigr_cpu *tmc = this_cpu_ptr(&tmigr_cpu);
> > > +
> > > +	raw_spin_lock_irq(&tmc->lock);
> > > +	tmc->online = 0;
> > > +	__tmigr_cpu_deactivate(tmc, KTIME_MAX);
> > 
> > This means that if the CPU is going idle for some time during
> > the hotplug process (ie: at some point between CPUHP_AP_TMIGR_ONLINE
> > and CPUHP_TEARDOWN_CPU), then a global timer may be delayed for that long.
> > 
> > I guess it shouldn't be too bad but worth mentioning...
> > 
> > Although if it happens to be a problem it could be solved with simply allowing
> > tmigr_cpu_deactivate() when !tmc->online.
> 
> The plan was (and I broke it) to let the CPU handle global timers by itself
> as long as timer migration hierarchy is not completely initialized and as
> long as CPU is marked offline in timer migration hierarchy. Otherwise
> global timers might be delayed during this period. The proper way would be
> that tmigr_cpu_deactivate(nextexp) directly returns nextexp if !tmc->online
> and tmigr hierarchy is not in place yet. I will have a deeper look if there
> was a reason why I changed the return to KTIME_MAX...

Well, do you need tmc->online at all?

I guess tmigr_cpu_offline() could be simply removed because when the CPU goes
finally down in do_idle() it does:

	tick_nohz_idle_stop_tick();
	cpuhp_report_idle_dead();

So the tick is expected to be stopped (better check it is) and thus the tmc
should be deactivated.

I guess you just need to call tmigr_cpu_activate() from timers_prepare_cpu().

Or am I missing something along the way?
