Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09676637312
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 08:48:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbiKXHsL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 02:48:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbiKXHsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 02:48:08 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95F8825C62
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 23:47:59 -0800 (PST)
Date:   Thu, 24 Nov 2022 08:47:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669276077;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=H8MkVKqMFPY7RVtK+U9IsLl419c2sAFoJ/y3MjxQSoQ=;
        b=KhL5m+1qGMnIkw8GjP8ewX0gISSmUyVAsbmCuMEUb3IPn9NjBvgT7N3Z4Q/dBB4LdzGnO6
        6A5kFXLqXGsuoU2cWJKos/zqdnLgT5Isuu/kROKIYqgVqUpZ9bLknGY8S+a1wWsoEYprzc
        8V9XouzbKBN37oBM1Po7dbE+jBKHgss3TlKtq3/zAeg/zl0TIK8s1RIK1vg2/t9HbgFIlF
        Xx1zBAtEoxb2th0xwpER+wM5KHlQwIwDrP1ev1QRHj/kveO+Zgh0Q+/9jDt3TyPpDtzhgc
        kWl/0v9MzCM2T1kZ5ohlAwT1HA4kLXdiSox3Oi5LPii/T+/vgB+tc9YKwyjJoA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669276077;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=H8MkVKqMFPY7RVtK+U9IsLl419c2sAFoJ/y3MjxQSoQ=;
        b=dm1HTwTzfb14QhOpvzna5A+QlMZCATo5SjpzrHiVdvrmBDfMiRk+VG4Xt63Q19hmvvibZW
        EWq6mQqjOW/OZyDw==
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
In-Reply-To: <20221115113152.GH590078@lothringen>
Message-ID: <e2b4a90-2d9-f2db-8c85-2e64caed5d0@linutronix.de>
References: <20221104145737.71236-1-anna-maria@linutronix.de> <20221104145737.71236-15-anna-maria@linutronix.de> <20221115113152.GH590078@lothringen>
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

On Tue, 15 Nov 2022, Frederic Weisbecker wrote:

> On Fri, Nov 04, 2022 at 03:57:35PM +0100, Anna-Maria Behnsen wrote:
> > +static int tmigr_cpu_offline(unsigned int cpu)
> > +{
> > +	struct tmigr_cpu *tmc = this_cpu_ptr(&tmigr_cpu);
> > +
> > +	raw_spin_lock_irq(&tmc->lock);
> > +	tmc->online = 0;
> > +	__tmigr_cpu_deactivate(tmc, KTIME_MAX);
> 
> This means that if the CPU is going idle for some time during
> the hotplug process (ie: at some point between CPUHP_AP_TMIGR_ONLINE
> and CPUHP_TEARDOWN_CPU), then a global timer may be delayed for that long.
> 
> I guess it shouldn't be too bad but worth mentioning...
> 
> Although if it happens to be a problem it could be solved with simply allowing
> tmigr_cpu_deactivate() when !tmc->online.

The plan was (and I broke it) to let the CPU handle global timers by itself
as long as timer migration hierarchy is not completely initialized and as
long as CPU is marked offline in timer migration hierarchy. Otherwise
global timers might be delayed during this period. The proper way would be
that tmigr_cpu_deactivate(nextexp) directly returns nextexp if !tmc->online
and tmigr hierarchy is not in place yet. I will have a deeper look if there
was a reason why I changed the return to KTIME_MAX...

Thanks,

	Anna-Maria

