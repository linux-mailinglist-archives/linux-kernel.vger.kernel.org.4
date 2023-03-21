Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DBE86C3011
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 12:17:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbjCULRJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 07:17:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjCULRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 07:17:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44B0F44A8
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 04:17:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DECDCB815B8
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 11:17:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7684C433EF;
        Tue, 21 Mar 2023 11:17:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679397423;
        bh=+s5bPg+wwlXrJxE6WqUaBhiPYUErze+0s6+bZZ0vB7E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VsdKqGoIa+4RD6NP6bROOOEb11SP3Ft+hWybNY+NVjTQI/lLV4wElTH6+m7NIIJos
         KX07WyRNpASYCXFy3bPKI3E+3bZfLJo+zlzF+1q8soAPOe7C3F5fj7cKTE+oP3pQ2g
         Ucpbwm5x595eLgM45dXQ94yL1yZlghgZd368h2EKi/snxGpMuXkoF+cJWmukczgk8s
         Moe5NGM6qzoOojKkA3m5OXobh+CHuXWZcpuhyv3RDXpbbjqxu3k9k6xnwGArlw/izz
         u1KrEMOs9IPCTNAZsTkPwU2xnBicmRIb/MDojfhXOUPGDecO/bwEQLPKvGfxGwnR9A
         EXZY4KTuFsPzg==
Date:   Tue, 21 Mar 2023 12:17:00 +0100
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
Subject: Re: [PATCH v5 16/18] timer: Implement the hierarchical pull model
Message-ID: <ZBmSLC6gRaNEb4/Z@lothringen>
References: <20230301141744.16063-1-anna-maria@linutronix.de>
 <20230301141744.16063-17-anna-maria@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230301141744.16063-17-anna-maria@linutronix.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 01, 2023 at 03:17:42PM +0100, Anna-Maria Behnsen wrote:
> +static u64 tmigr_handle_remote_cpu(unsigned int cpu, u64 now,
> +				   unsigned long jif)
> +{
> +	struct timer_events tevt;
> +	struct tmigr_walk data;
> +	struct tmigr_cpu *tmc;
> +	u64 next = KTIME_MAX;
> +	unsigned long flags;
> +
> +	tmc = per_cpu_ptr(&tmigr_cpu, cpu);
> +
> +	raw_spin_lock_irqsave(&tmc->lock, flags);
> +	/*
> +	 * Remote CPU is offline or no longer idle or other cpu handles cpu
> +	 * timers already or next event was already expired - return!
> +	 */
> +	if (!tmc->online || tmc->remote || tmc->cpuevt.ignore ||
> +	    now < tmc->cpuevt.nextevt.expires) {
> +		raw_spin_unlock_irqrestore(&tmc->lock, flags);
> +		return next;
> +	}
> +
> +	tmc->remote = 1;
> +
> +	/* Drop the lock to allow the remote CPU to exit idle */
> +	raw_spin_unlock_irqrestore(&tmc->lock, flags);
> +
> +	if (cpu != smp_processor_id())
> +		timer_expire_remote(cpu);
> +
> +	/* next event of cpu */
> +	fetch_next_timer_interrupt_remote(jif, now, &tevt, cpu);

If the target CPU gets an idle interrupt right after the above call and enqueues
a new timer (which becomes the new earliest), tmigr_cpu_deactivate() ->
tmigr_new_timer() is going to ignore it due to tmc->remote = 1, right?

Or am I missing something else that would make that timer correctly handled?

Thanks.
