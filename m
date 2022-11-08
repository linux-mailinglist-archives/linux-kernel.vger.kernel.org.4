Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECE25621935
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 17:16:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234615AbiKHQQR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 11:16:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233665AbiKHQQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 11:16:15 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 506F34FFB1
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 08:16:14 -0800 (PST)
Date:   Tue, 8 Nov 2022 17:16:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1667924171;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Y/ltunOlWhT9qoWXICQY0xwWTfJd8Uki4/DwJbamrBE=;
        b=qxOu//IU8dpyp2QX83G/PvnanL7DYdvtvd46g+6Ih75xGWFSlYF7HBkZ9KU3g1OXhimwgd
        neh2drKoXa3yuVAqSf/eQWJNH+tfBA96rSS2FDcK1UEllJCQnuRoZknxBpMuGSqQNMxTyY
        j3DM1EslEXgw7T7e9KKOMQGNI34SRIcGrXqE42M03b+wvr4MIcHhW1/WK/JKahhOeNSelz
        Xb/5BFRd9B3ucE2IVv2N4PKYoTmhbDaqRAdM2Pb6EEUYCr8qGl1hpg95lCQ7NVDMEYZlc7
        nNh7Cdn6ygx+LiKJfTd3FRCr1tJ8Uqh6j6F2GhDrlAxj34zghqCKwLHj8wGS3Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1667924171;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Y/ltunOlWhT9qoWXICQY0xwWTfJd8Uki4/DwJbamrBE=;
        b=HYCtGka5HQFmG0JjqSK60wBA6ad7vpK/y8RBW9RodlclYKKJOat+rX3lJpN8l60VD9MNyX
        j9emKErcpbSC7LBg==
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
In-Reply-To: <20221107220727.GA10939@lothringen>
Message-ID: <c0afb1-2a23-f595-3e30-bb95c39e8e65@linutronix.de>
References: <20221104145737.71236-1-anna-maria@linutronix.de> <20221104145737.71236-15-anna-maria@linutronix.de> <20221107220727.GA10939@lothringen>
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

On Mon, 7 Nov 2022, Frederic Weisbecker wrote:

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
> > +		} else {
> > +			nextevt = nextevt_local;
> 
> That else part look unecessary.

Yes, you are right. I will add a comment instead. Maybe someone wants to
improve it and then requires the proper nextevt...

> > +		}
> > +	}
> > +
> >  	/* We need to mark both bases in sync */
> >  	base_local->is_idle = base_global->is_idle = is_idle;
> 
> Do we still need to maintain base_global->is_idle ?

is_idle information is required in trigger_dyntick_cpu(). I made a mistake
with the hunk in trigger_dyntick_cpu() introduced in this patch. Because
after this patch, global timers are still enqueued on any CPU because
crystallball still exists. trigger_dyntick_cpu() is also required for non
pinned timers. I need to move the hunk of trigger_dyntick_cpu() into the
last patch of the queue where crystallball is removed during enqueue and
there update also this line. Then I will drop the update of
base_global->is_idle in timer_clear_idle() as well.

Sorry. This went wrong during splitting and folding the queue back and
forwards...

> (I'm going to do daily reviews on this patch because it's quite dense :)

Thanks! I try to answer your questions fast. Let me know when you are done
or when you need an updated version for further review :)

Thanks,

	Anna-Maria

