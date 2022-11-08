Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48E1B620D8F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 11:47:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233795AbiKHKrr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 05:47:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233203AbiKHKrp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 05:47:45 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 593A71055D
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 02:47:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0A5E2B819B8
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 10:47:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22693C433C1;
        Tue,  8 Nov 2022 10:47:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667904461;
        bh=0aemqMIa5Wnsttdn47YkqbHMFof+7rLlgEqf4m2rpHE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c7LgW4B1GvtJdsxvuBowaqHeogpN9LdzwOsJOBqyIsPyDJ2nLemGRCIHd06JvhOWc
         I/QMt46XB6lZZ4+U9I+PV1A88aTgaIvewwB9CTNdd8Gx+JE/ntyL2AIxzKACCn1QkP
         bewbLuQkCRfhh95+UYmqbXfFODQESq8fMzoN3ZogD+ypnaPxlT8ZDp3eUoX4jyur/8
         K+IvHS/MWtM0aBH6x7+a2Wn/IukBZHamqv3TvEj56ylkQ8RCSp2WK0Yh6ipdZUyJ2u
         t/v7BOSWgRygjTSTmdn54VSYgbAb6GyR0MwLtcr/99bHwgkLDF53esvZQvW34Jpa1h
         8+Zdg09txlV3g==
Date:   Tue, 8 Nov 2022 11:47:38 +0100
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
Message-ID: <20221108104738.GA21669@lothringen>
References: <20221104145737.71236-1-anna-maria@linutronix.de>
 <20221104145737.71236-15-anna-maria@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221104145737.71236-15-anna-maria@linutronix.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 04, 2022 at 03:57:35PM +0100, Anna-Maria Behnsen wrote:
> @@ -1859,6 +1863,36 @@ void forward_and_idle_timer_bases(unsigned long basej, u64 basem,
>  	 */
>  	is_idle = time_after(nextevt, basej + 1);
>  
> +	if (is_idle) {
> +		u64 next_tmigr;
> +
> +		next_tmigr = tmigr_cpu_deactivate(tevt->global);
> +
> +		tevt->global = KTIME_MAX;
> +
> +		/*
> +		 * If CPU is the last going idle in timer migration
> +		 * hierarchy, make sure CPU will wake up in time to handle
> +		 * remote timers. next_tmigr == KTIME_MAX if other CPUs are
> +		 * still active.
> +		 */
> +		if (next_tmigr < tevt->local) {
> +			u64 tmp;
> +
> +			/* If we missed a tick already, force 0 delta */
> +			if (next_tmigr < basem)
> +				next_tmigr = basem;
> +
> +			tmp = div_u64(next_tmigr - basem, TICK_NSEC);
> +
> +			nextevt = basej + (unsigned long)tmp;
> +			tevt->local = next_tmigr;
> +			is_idle = time_after(nextevt, basej + 1);

So after that, tevt->global shouldn't matter anymore for tick_nohz_next_event(),
right? If so then probably that line can go away (with a comment specifying why we can
ignore the global part)?:

       tevt.local = min_t(u64, tevt.local, tevt.global);

Thanks.
