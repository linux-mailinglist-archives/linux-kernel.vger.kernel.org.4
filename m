Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EADBE73BE53
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 20:17:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbjFWSRt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 14:17:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjFWSRs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 14:17:48 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1E522705
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 11:17:42 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 76DB42199D;
        Fri, 23 Jun 2023 18:17:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1687544261; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=t1uqCqPbLvdYT+hRmV0MBBOULi1G46OtarHmqDXAzJ0=;
        b=KGh7V5u2aX/1HxzjaOzy9g5Ev/MinoQZGuXpMIPieNwHSCrU0z8zno1vZgDzYHVrFNIo2U
        zJsTI9c9G+dlLQJHvm7PQ3S0WiNBkzrOwedOlAdFkG5ka5SZ4lkwz7wI7KGJ0T6Repmswq
        DNsHC2hooT9DlC1Ton17bEDkYD3HPvo=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 553BE1331F;
        Fri, 23 Jun 2023 18:17:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id MQHuEcXhlWQsRwAAMHmgww
        (envelope-from <mhocko@suse.com>); Fri, 23 Jun 2023 18:17:41 +0000
Date:   Fri, 23 Jun 2023 20:17:40 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        John Ogness <john.ogness@linutronix.de>,
        Mel Gorman <mgorman@techsingularity.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Thomas Gleixner <tglx@linutronix.de>,
        Waiman Long <longman@redhat.co>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH v2 2/2] mm/page_alloc: Use write_seqlock_irqsave()
 instead write_seqlock() + local_irq_save().
Message-ID: <ZJXhxJU2jFccMjkg@dhcp22.suse.cz>
References: <20230623171232.892937-1-bigeasy@linutronix.de>
 <20230623171232.892937-3-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230623171232.892937-3-bigeasy@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 23-06-23 19:12:32, Sebastian Andrzej Siewior wrote:
> __build_all_zonelists() acquires zonelist_update_seq by first disabling
> interrupts via local_irq_save() and then acquiring the seqlock with
> write_seqlock(). This is troublesome and leads to problems on
> PREEMPT_RT. The problem is that the inner spinlock_t becomes a sleeping
> lock on PREEMPT_RT and must not be acquired with disabled interrupts.
> 
> The API provides write_seqlock_irqsave() which does the right thing in
> one step.
> printk_deferred_enter() has to be invoked in non-migrate-able context to
> ensure that deferred printing is enabled and disabled on the same CPU.
> This is the case after zonelist_update_seq has been acquired.
> 
> There was discussion on the first submission that the order should be:
> 	local_irq_disable();
> 	printk_deferred_enter();
> 	write_seqlock();
> 
> to avoid pitfalls like having an unaccounted printk() coming from
> write_seqlock_irqsave() before printk_deferred_enter() is invoked. The
> only origin of such a printk() can be a lockdep splat because the
> lockdep annotation happens after the sequence count is incremented.
> This is exceptional and subject to change.
> 
> It was also pointed that PREEMPT_RT can be affected by the printk
> problem since its write_seqlock_irqsave() does not really disable
> interrupts. This isn't the case because PREEMPT_RT's printk
> implementation differs from the mainline implementation in two important
> aspects:
> - Printing happens in a dedicated threads and not at during the
>   invocation of printk().
> - In emergency cases where synchronous printing is used, a different
>   driver is used which does not use tty_port::lock.
> 
> Acquire zonelist_update_seq with write_seqlock_irqsave() and then defer
> printk output.
> 
> Fixes: 1007843a91909 ("mm/page_alloc: fix potential deadlock on zonelist_update_seq seqlock")
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Thanks for extending the changelog. This is much more clearer IMO.

One nit below which I haven't noticed before. Anyway
Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  mm/page_alloc.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 47421bedc12b7..99b7e7d09c5c0 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -5808,11 +5808,10 @@ static void __build_all_zonelists(void *data)
>  	unsigned long flags;
>  
>  	/*
> -	 * Explicitly disable this CPU's interrupts before taking seqlock
> -	 * to prevent any IRQ handler from calling into the page allocator
> -	 * (e.g. GFP_ATOMIC) that could hit zonelist_iter_begin and livelock.
> +	 * The zonelist_update_seq must be acquired with irqsave because the
> +	 * reader can be invoked from IRQ with GFP_ATOMIC.
>  	 */
> -	local_irq_save(flags);
> +	write_seqlock_irqsave(&zonelist_update_seq, flags);
>  	/*
>  	 * Explicitly disable this CPU's synchronous printk() before taking
>  	 * seqlock to prevent any printk() from trying to hold port->lock, for

This is not the case anymore because the locking ordering has flipped. I
would just extend the comment above by something like:

	 * Also disable synchronous printk() to prevent any printk() from trying
	 * to hold port->lock, for tty_insert_flip_string_and_push_buffer() on
	 * other CPU might be calling kmalloc(GFP_ATOMIC | __GFP_NOWARN) with
	 * port->lock held.

> @@ -5820,7 +5819,6 @@ static void __build_all_zonelists(void *data)
>  	 * calling kmalloc(GFP_ATOMIC | __GFP_NOWARN) with port->lock held.
>  	 */
>  	printk_deferred_enter();
> -	write_seqlock(&zonelist_update_seq);
>  
>  #ifdef CONFIG_NUMA
>  	memset(node_load, 0, sizeof(node_load));
> @@ -5857,9 +5855,8 @@ static void __build_all_zonelists(void *data)
>  #endif
>  	}
>  
> -	write_sequnlock(&zonelist_update_seq);
>  	printk_deferred_exit();
> -	local_irq_restore(flags);
> +	write_sequnlock_irqrestore(&zonelist_update_seq, flags);
>  }
>  
>  static noinline void __init
> -- 
> 2.40.1

-- 
Michal Hocko
SUSE Labs
