Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E10ED74131F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 15:57:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231750AbjF1N4Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 09:56:25 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:56424 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230429AbjF1N4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 09:56:22 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 704E61F6E6;
        Wed, 28 Jun 2023 13:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1687960581; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UBkDkoRg0HA6vloPwRjoXM7rrbP50/wBU1LZzUkViAU=;
        b=EVwkpnA3ZnBl4diVvgSAhsFc0JP4kr6t+CDom0M9DLYq1eYt8N+THhgRu+9j36T7vPKeOi
        LJKLNiRmMCwYTXeE2s7k5fcD2XdqTTr3tXb9JZLxdpzZVoMn6LcE+m6Kg3XmAsIUjdAX1Q
        mBPDBX8sXuZ+VbgdBGvJF4NcamLfP+A=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4F01C138EF;
        Wed, 28 Jun 2023 13:56:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id l3/3EAU8nGRSDwAAMHmgww
        (envelope-from <mhocko@suse.com>); Wed, 28 Jun 2023 13:56:21 +0000
Date:   Wed, 28 Jun 2023 15:56:20 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        John Ogness <john.ogness@linutronix.de>,
        Mel Gorman <mgorman@techsingularity.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Thomas Gleixner <tglx@linutronix.de>,
        Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH v3 2/2] mm/page_alloc: Use write_seqlock_irqsave()
 instead write_seqlock() + local_irq_save().
Message-ID: <ZJw8BFHj6YD2Tl6x@dhcp22.suse.cz>
References: <20230623171232.892937-1-bigeasy@linutronix.de>
 <20230623171232.892937-3-bigeasy@linutronix.de>
 <ZJXhxJU2jFccMjkg@dhcp22.suse.cz>
 <20230623201517.yw286Knb@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230623201517.yw286Knb@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew, it seems that we have a consensus on the MM side of things that
this is good enough to go. I am not sure about patch 1, that is more on
lockdep people but I think that this patch is good enough on this own.
Can we get this patch merged into mm tree and see whether any of Tetsuo
concerns pop out?

On Fri 23-06-23 22:15:17, Sebastian Andrzej Siewior wrote:
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
> Acked-by: Michal Hocko <mhocko@suse.com>
> ---
> v2…v3
>   - Update comment as per Michal's suggestion.
> 
> v1…v2:
>   - Improve commit description
> 
>  mm/page_alloc.c | 15 ++++++---------
>  1 file changed, 6 insertions(+), 9 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 47421bedc12b7..440e9af67b48d 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -5808,19 +5808,17 @@ static void __build_all_zonelists(void *data)
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
> -	 * Explicitly disable this CPU's synchronous printk() before taking
> -	 * seqlock to prevent any printk() from trying to hold port->lock, for
> +	 * Also disable synchronous printk() to prevent any printk() from
> +	 * trying to hold port->lock, for
>  	 * tty_insert_flip_string_and_push_buffer() on other CPU might be
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
