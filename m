Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EF6960E6AA
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 19:39:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234193AbiJZRix (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 13:38:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234137AbiJZRit (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 13:38:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47566BECE7;
        Wed, 26 Oct 2022 10:38:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E1CC861FFC;
        Wed, 26 Oct 2022 17:38:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F1CCC433D6;
        Wed, 26 Oct 2022 17:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666805927;
        bh=vwqpmGUZc3BSLxZLKxJIYXRkmkp4FjHgGBH1uTJ7iRw=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=usohgiDGQaZljMppPbloxCseE3J6s52Z1KmiRkTgTZJC7iOTlCLKskCE6pdDHJ1db
         k1A4yxR8xAv3MGSs2R8f81OqgtLIX6dTQWGw2YD7AD7WC4RuY4gs2aXCWM8qMdfJQy
         blSlWh+AZekrhaZdr3L99nQf1XjZRMqukJcm2znsoHzYMV/8HuPdQ/nSVnyJxy8cNe
         Cy4g2BcLsm9Fv9x+47A8h6x+ep3FwYZH8nysQgQlltaD8DwT5hkOzAWWimPeI4rvfc
         74psiwAxeaAAWP14IIDqGNwBFyR7pJdWS4QoxHSK4beGgr0pyMUFil+7Zq6Bqq//ga
         YzOJdxik+Jr7Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id CD77B5C05F8; Wed, 26 Oct 2022 10:38:46 -0700 (PDT)
Date:   Wed, 26 Oct 2022 10:38:46 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraj.iitr10@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH 1/1] rcu: Refactor kvfree_call_rcu() and high-level
 helpers
Message-ID: <20221026173846.GO5600@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221025144612.506951-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221025144612.506951-1-urezki@gmail.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 25, 2022 at 04:46:12PM +0200, Uladzislau Rezki (Sony) wrote:
> Currently a kvfree_call_rcu() takes an offset within a
> structure as a second parameter, so a helper such as a
> kvfree_rcu_arg_2() has to convert rcu_head and a freed
> ptr to an offset in order to pass it. That leads to an
> extra conversion on macro entry.
> 
> Instead of converting, refactor the code in way that a
> pointer that has to be freed is passed directly to the
> kvfree_call_rcu().
> 
> This patch does not make any functional change and is
> transparent to all kvfree_rcu() users.
> 
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

Nice simplification!

Hearing no immediate protests, I have pulled this in for testing and
for further review.

							Thanx, Paul

> ---
>  include/linux/rcupdate.h |  5 ++---
>  include/linux/rcutiny.h  | 12 ++++++------
>  include/linux/rcutree.h  |  2 +-
>  kernel/rcu/tiny.c        |  9 +++------
>  kernel/rcu/tree.c        | 29 ++++++++++++-----------------
>  5 files changed, 24 insertions(+), 33 deletions(-)
> 
> diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
> index 08605ce7379d..cbd34058fff1 100644
> --- a/include/linux/rcupdate.h
> +++ b/include/linux/rcupdate.h
> @@ -985,8 +985,7 @@ do {									\
>  									\
>  	if (___p) {									\
>  		BUILD_BUG_ON(!__is_kvfree_rcu_offset(offsetof(typeof(*(ptr)), rhf)));	\
> -		kvfree_call_rcu(&((___p)->rhf), (rcu_callback_t)(unsigned long)		\
> -			(offsetof(typeof(*(ptr)), rhf)));				\
> +		kvfree_call_rcu(&((___p)->rhf), (void *) (___p));			\
>  	}										\
>  } while (0)
>  
> @@ -995,7 +994,7 @@ do {								\
>  	typeof(ptr) ___p = (ptr);				\
>  								\
>  	if (___p)						\
> -		kvfree_call_rcu(NULL, (rcu_callback_t) (___p));	\
> +		kvfree_call_rcu(NULL, (void *) (___p));		\
>  } while (0)
>  
>  /*
> diff --git a/include/linux/rcutiny.h b/include/linux/rcutiny.h
> index 768196a5f39d..9623c039964c 100644
> --- a/include/linux/rcutiny.h
> +++ b/include/linux/rcutiny.h
> @@ -98,25 +98,25 @@ static inline void synchronize_rcu_expedited(void)
>   */
>  extern void kvfree(const void *addr);
>  
> -static inline void __kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
> +static inline void __kvfree_call_rcu(struct rcu_head *head, void *ptr)
>  {
>  	if (head) {
> -		call_rcu(head, func);
> +		call_rcu(head, (rcu_callback_t) ((void *) head - ptr));
>  		return;
>  	}
>  
>  	// kvfree_rcu(one_arg) call.
>  	might_sleep();
>  	synchronize_rcu();
> -	kvfree((void *) func);
> +	kvfree(ptr);
>  }
>  
>  #ifdef CONFIG_KASAN_GENERIC
> -void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func);
> +void kvfree_call_rcu(struct rcu_head *head, void *ptr);
>  #else
> -static inline void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
> +static inline void kvfree_call_rcu(struct rcu_head *head, void *ptr)
>  {
> -	__kvfree_call_rcu(head, func);
> +	__kvfree_call_rcu(head, ptr);
>  }
>  #endif
>  
> diff --git a/include/linux/rcutree.h b/include/linux/rcutree.h
> index 5efb51486e8a..e37a0747a8b2 100644
> --- a/include/linux/rcutree.h
> +++ b/include/linux/rcutree.h
> @@ -33,7 +33,7 @@ static inline void rcu_virt_note_context_switch(int cpu)
>  }
>  
>  void synchronize_rcu_expedited(void);
> -void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func);
> +void kvfree_call_rcu(struct rcu_head *head, void *ptr);
>  
>  void rcu_barrier(void);
>  bool rcu_eqs_special_set(int cpu);
> diff --git a/kernel/rcu/tiny.c b/kernel/rcu/tiny.c
> index a33a8d4942c3..6c9496d08669 100644
> --- a/kernel/rcu/tiny.c
> +++ b/kernel/rcu/tiny.c
> @@ -246,15 +246,12 @@ bool poll_state_synchronize_rcu(unsigned long oldstate)
>  EXPORT_SYMBOL_GPL(poll_state_synchronize_rcu);
>  
>  #ifdef CONFIG_KASAN_GENERIC
> -void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
> +void kvfree_call_rcu(struct rcu_head *head, void *ptr)
>  {
> -	if (head) {
> -		void *ptr = (void *) head - (unsigned long) func;
> -
> +	if (head)
>  		kasan_record_aux_stack_noalloc(ptr);
> -	}
>  
> -	__kvfree_call_rcu(head, func);
> +	__kvfree_call_rcu(head, ptr);
>  }
>  EXPORT_SYMBOL_GPL(kvfree_call_rcu);
>  #endif
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 0ca21ac0f064..9fea2aff87a1 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -3068,8 +3068,8 @@ static void kfree_rcu_work(struct work_struct *work)
>  	 * This list is named "Channel 3".
>  	 */
>  	for (; head; head = next) {
> -		unsigned long offset = (unsigned long)head->func;
> -		void *ptr = (void *)head - offset;
> +		void *ptr = (void *) head->func;
> +		unsigned long offset = (void *) head - ptr;
>  
>  		next = head->next;
>  		debug_rcu_head_unqueue((struct rcu_head *)ptr);
> @@ -3307,26 +3307,21 @@ add_ptr_to_bulk_krc_lock(struct kfree_rcu_cpu **krcp,
>   * be free'd in workqueue context. This allows us to: batch requests together to
>   * reduce the number of grace periods during heavy kfree_rcu()/kvfree_rcu() load.
>   */
> -void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
> +void kvfree_call_rcu(struct rcu_head *head, void *ptr)
>  {
>  	unsigned long flags;
>  	struct kfree_rcu_cpu *krcp;
>  	bool success;
> -	void *ptr;
>  
> -	if (head) {
> -		ptr = (void *) head - (unsigned long) func;
> -	} else {
> -		/*
> -		 * Please note there is a limitation for the head-less
> -		 * variant, that is why there is a clear rule for such
> -		 * objects: it can be used from might_sleep() context
> -		 * only. For other places please embed an rcu_head to
> -		 * your data.
> -		 */
> +	/*
> +	 * Please note there is a limitation for the head-less
> +	 * variant, that is why there is a clear rule for such
> +	 * objects: it can be used from might_sleep() context
> +	 * only. For other places please embed an rcu_head to
> +	 * your data.
> +	 */
> +	if (!head)
>  		might_sleep();
> -		ptr = (unsigned long *) func;
> -	}
>  
>  	// Queue the object but don't yet schedule the batch.
>  	if (debug_rcu_head_queue(ptr)) {
> @@ -3347,7 +3342,7 @@ void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
>  			// Inline if kvfree_rcu(one_arg) call.
>  			goto unlock_return;
>  
> -		head->func = func;
> +		head->func = ptr;
>  		head->next = krcp->head;
>  		krcp->head = head;
>  		success = true;
> -- 
> 2.30.2
> 
