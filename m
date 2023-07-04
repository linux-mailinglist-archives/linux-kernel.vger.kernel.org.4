Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0313D746E7F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 12:24:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231464AbjGDKYP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 06:24:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbjGDKYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 06:24:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6635186
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 03:24:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1EE716113E
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 10:24:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04BD2C433C8;
        Tue,  4 Jul 2023 10:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688466249;
        bh=5qmatxwFy5hpwfxpXYcMAYAtKeUiM25ktbNokO4VyjY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ObdvRBq8uq/9hdDgzyLMpYdWBwU3GPd+tkVha1DO7Y2251ZeU9Y53ZMfn/wg6XkHE
         OrjEKNMZ7h54UuviILFHSWnnR5dj9BAWss5uRxX1DTZUJfe9/q+uKLBcollxYlO8NN
         qmle5sDIs3ZPpwiZ4aMtmFKUZesQEiyZTQwaewD7VnS7AT2Cl4OqqIigjYLfFNwLf/
         RZOPCEIK+p2SzZ99rlivctVuMZidTGHB7rIrrhMYjuvCXiklo9XOBl4Nai3FxU6KbJ
         YWWtW04pPvQPD0KpT/d8+igYGsIMuqLtWa1P4emgzrBRn79cD+FMUqMrhMpn0BL8KV
         1DDox5c1D+DYQ==
Date:   Tue, 4 Jul 2023 12:24:06 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        John Stultz <jstultz@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>
Subject: Re: [patch 20/45] signal: Replace BUG_ON()s
Message-ID: <ZKPzRuZZBLGHfLTZ@lothringen>
References: <20230606132949.068951363@linutronix.de>
 <20230606142032.151323086@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230606142032.151323086@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 06, 2023 at 04:37:50PM +0200, Thomas Gleixner wrote:
> These really can be handled gracefully without killing the machine.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  kernel/signal.c |   11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -1932,10 +1932,11 @@ struct sigqueue *sigqueue_alloc(void)
>  
>  void sigqueue_free(struct sigqueue *q)
>  {
> -	unsigned long flags;
>  	spinlock_t *lock = &current->sighand->siglock;
> +	unsigned long flags;
>  
> -	BUG_ON(!(q->flags & SIGQUEUE_PREALLOC));
> +	if (WARN_ON_ONCE(!(q->flags & SIGQUEUE_PREALLOC)))
> +		return;
>  	/*
>  	 * We must hold ->siglock while testing q->list
>  	 * to serialize with collect_signal() or with
> @@ -1963,7 +1964,10 @@ int send_sigqueue(struct sigqueue *q, st
>  	unsigned long flags;
>  	int ret, result;
>  
> -	BUG_ON(!(q->flags & SIGQUEUE_PREALLOC));
> +	if (WARN_ON_ONCE(!(q->flags & SIGQUEUE_PREALLOC)))
> +		return 0;
> +	if (WARN_ON_ONCE(q->info.si_code != SI_TIMER))
> +		return 0;

Previously it only forbid _requeuing_ other things than posix timers.
Now it only allows posix timers at all.

But anyway posix timers is the only user so far:

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>


>  
>  	ret = -1;
>  	rcu_read_lock();
> @@ -1998,7 +2002,6 @@ int send_sigqueue(struct sigqueue *q, st
>  		 * If an SI_TIMER entry is already queue just increment
>  		 * the overrun count.
>  		 */
> -		BUG_ON(q->info.si_code != SI_TIMER);
>  		q->info.si_overrun++;
>  		result = TRACE_SIGNAL_ALREADY_PENDING;
>  		goto out;
> 
