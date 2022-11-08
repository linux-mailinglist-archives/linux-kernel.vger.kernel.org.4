Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78E586219F7
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 18:02:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234050AbiKHRCR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 12:02:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231740AbiKHRCO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 12:02:14 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94B9528F
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 09:02:13 -0800 (PST)
Date:   Tue, 8 Nov 2022 18:02:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1667926932;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LeK/LIk+Guc9QGV9/1QheCdNK87ebw4f5sjVkGN6Orw=;
        b=BFroQblfgQGtG5rAQN0ZN4rxBDncY25iD/utujYzqQPBSNpkmqTBSHcDAcUDH5/Gi3UEyL
        zVpfN11ZtCc0pCcPDrM7B+tqcWTPs9mtOSjuZvdJy2rQuUcOg2wISF712Ja8BxvsdLWbvc
        JqRlwwNQUFr0t2Tl7bIzcp/gyNfOs2ZTdKzDy9VtioR07MfnLCpWLhraMmrMf8of9cP+Ek
        ipWa2OznR8ylRb4/GdTUgdWlTPfwIxUyRZSolDNAm4XdRCr6QZSJ4mZfwpGQJKvOp1W+2I
        th7jTmQVejXdVZBGwGgFUpQRuy8q2KMMaUtz+xoBBJJARlVp6ASBCio3SYVjBg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1667926932;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LeK/LIk+Guc9QGV9/1QheCdNK87ebw4f5sjVkGN6Orw=;
        b=ZsHVs8GYkH/BLoxYTxAjEZDcxwPFdZHGFfqt5TZkBrpvm2LO/zj7eaU3vc3AdCREgGrRHi
        G2HTi/E4hYY2LsAg==
From:   Anna-Maria Behnsen <anna-maria@linutronix.de>
To:     Frederic Weisbecker <frederic@kernel.org>
cc:     linux-kernel@vger.kernel.org,
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
In-Reply-To: <20221108104738.GA21669@lothringen>
Message-ID: <9496e1a6-d1-1a20-c1c9-2bc3f34eb888@linutronix.de>
References: <20221104145737.71236-1-anna-maria@linutronix.de> <20221104145737.71236-15-anna-maria@linutronix.de> <20221108104738.GA21669@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Nov 2022, Frederic Weisbecker wrote:

> On Fri, Nov 04, 2022 at 03:57:35PM +0100, Anna-Maria Behnsen wrote:
> > @@ -1859,6 +1863,36 @@ void forward_and_idle_timer_bases(unsigned long basej, u64 basem,
> >  	 */
> >  	is_idle = time_after(nextevt, basej + 1);
> >  
> > +	if (is_idle) {
> > +		u64 next_tmigr;
> > +
> > +		next_tmigr = tmigr_cpu_deactivate(tevt->global);
> > +
> > +		tevt->global = KTIME_MAX;
> > +
> > +		/*
> > +		 * If CPU is the last going idle in timer migration
> > +		 * hierarchy, make sure CPU will wake up in time to handle
> > +		 * remote timers. next_tmigr == KTIME_MAX if other CPUs are
> > +		 * still active.
> > +		 */
> > +		if (next_tmigr < tevt->local) {
> > +			u64 tmp;
> > +
> > +			/* If we missed a tick already, force 0 delta */
> > +			if (next_tmigr < basem)
> > +				next_tmigr = basem;
> > +
> > +			tmp = div_u64(next_tmigr - basem, TICK_NSEC);
> > +
> > +			nextevt = basej + (unsigned long)tmp;
> > +			tevt->local = next_tmigr;
> > +			is_idle = time_after(nextevt, basej + 1);
> 
> So after that, tevt->global shouldn't matter anymore for tick_nohz_next_event(),
> right? If so then probably that line can go away (with a comment specifying why we can
> ignore the global part)?:
> 
>        tevt.local = min_t(u64, tevt.local, tevt.global);
> 

tevt->global is set to KTIME_MAX anyway. So the whole tevt information is
also no longer required in tick_nohz_next_event(). I need to rework the
patch where this was introduced. Then the forward_and_idle_timer_bases()
could still simply return the next timer and then there is no longer a
point against using your idea with naming of the functions.
