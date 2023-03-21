Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CC656C349A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 15:44:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231447AbjCUOoP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 10:44:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230468AbjCUOoN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 10:44:13 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 223DA12593
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 07:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=i8NHZmwEgYzN0PCOWaTMBvVmXjZjxbaqnytcQp40WVs=; b=IkWaYndo7jT9ZLCd2DwPmP5nbT
        67JCrbD14zZecApkVpa7RE2N0elxFNAs1n4RFAQKeJOfBexzJMCZNCrDxtk0XTsVQIHF8oWX2AX8Z
        gygEkvIj99OLc0l5B2d09iPOg0Vgh1Vyilo8Wjge5cgsd0Z9gyDdIR/xnYtyDCy/Vg65VdHWUI/Vo
        AHEVLC4l9hZK6m/0DUppk1fTCcngfsxQRco4uc4gviSG7oxglzEXt0BpNAt2rGZZ5CKjy0BPf6RBX
        CbA9ZxIFaPfZt25cj0u/YjLvIzjwi7p38mecozyuvDyz9dDFWBPB2IHd4y/W/ecSCYroUcVHQIIrB
        BnYWQUuA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pedDN-004HR3-1F;
        Tue, 21 Mar 2023 14:43:53 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1657A3002C0;
        Tue, 21 Mar 2023 15:43:51 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id F2EEC240FB835; Tue, 21 Mar 2023 15:43:50 +0100 (CET)
Date:   Tue, 21 Mar 2023 15:43:50 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Eric Dumazet <edumazet@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Arjan van de Ven <arjan@infradead.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Rik van Riel <riel@surriel.com>
Subject: Re: [PATCH v5 14/18] timer: Check if timers base is handled already
Message-ID: <20230321144350.GP2234901@hirez.programming.kicks-ass.net>
References: <20230301141744.16063-1-anna-maria@linutronix.de>
 <20230301141744.16063-15-anna-maria@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230301141744.16063-15-anna-maria@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 01, 2023 at 03:17:40PM +0100, Anna-Maria Behnsen wrote:
> Due to the conversion of the NOHZ timer placement to a pull at expiry
> time model, the per CPU timer bases with non pinned timers are no
> longer handled only by the local CPU. In case a remote CPU already
> expires the non pinned timers base of the local cpu, nothing more
> needs to be done by the local CPU. A check at the begin of the expire
> timers routine is required, because timer base lock is dropped before
> executing the timer callback function.
> 
> This is a preparatory work, but has no functional impact right now.
> 
> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
> ---
>  kernel/time/timer.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/kernel/time/timer.c b/kernel/time/timer.c
> index be085e94afcc..9553da99e262 100644
> --- a/kernel/time/timer.c
> +++ b/kernel/time/timer.c
> @@ -2144,6 +2144,9 @@ static inline void __run_timers(struct timer_base *base)
>  
>  	lockdep_assert_held(&base->lock);
>  
> +	if (!!base->running_timer)
> +		return;

You can leave out the double-negation, 'if (base->running_timer)' is
equivalent and reads much easier.

>  	while (time_after_eq(jiffies, base->clk) &&
>  	       time_after_eq(jiffies, base->next_expiry)) {
>  		levels = collect_expired_timers(base, heads);
> -- 
> 2.30.2
> 
