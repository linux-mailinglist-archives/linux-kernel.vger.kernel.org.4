Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCC2963CBF4
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 00:38:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbiK2Xii (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 18:38:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbiK2Xig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 18:38:36 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C0BF5B841;
        Tue, 29 Nov 2022 15:38:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 371966195B;
        Tue, 29 Nov 2022 23:38:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C4F9C433D7;
        Tue, 29 Nov 2022 23:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669765113;
        bh=LlNv7abHsvSQJUXOKNoMnMcBbroOgNGcMquCXxMr+Ps=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=SKXs8ulgmKXSt0N4sAl7mzGTeKHc3wZzWWUsQ846poNr4lMwEnvsa6yHCelMppqYi
         9Syz7cYAIZsFRlkkIKGv2AC1eRO9Hsp14hDNopf9ofFR+Uw28gd8JXFuOrp26KQicJ
         9eAhH4mp9CwW0ZFqaMGWVgXWW11ZezYi4CwXPfbUNUNQgzC8GVVcxedUhjr0a6/a4X
         3eaAublixCCoQJyfKi2Eje4RdFmBVz+uFvv4l9dRiq8LxMUwM6tOjtmI55QzORG06R
         4rpnSwN2/xqBITHJjCg2C5v6aCRipqL2tPKUUR+lhEHsjAB0ghjxZ1170ghXV7NZv2
         Mzosx3op9MkkA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 244125C0584; Tue, 29 Nov 2022 15:38:33 -0800 (PST)
Date:   Tue, 29 Nov 2022 15:38:33 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraj.iitr10@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH v2 3/4] rcu/kvfree: Move need_offload_krc() out of
 krcp->lock
Message-ID: <20221129233833.GA154809@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221129155822.538434-1-urezki@gmail.com>
 <20221129155822.538434-4-urezki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221129155822.538434-4-urezki@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 29, 2022 at 04:58:21PM +0100, Uladzislau Rezki (Sony) wrote:
> Currently a need_offload_krc() function requires the krcp->lock
> to be held because krcp->head can not be checked concurrently.
> 
> Fix it by updating the krcp->head using WRITE_ONCE() macro so
> it becomes lock-free and safe for readers to see a valid data
> without any locking.

Don't we also need to use READ_ONCE() for the code loading this krcp->head
pointer?  Or do the remaining plain C-language accesses somehow avoid
running concurrently with those new WRITE_ONCE() invocations?

						Thanx, Paul

> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> ---
>  kernel/rcu/tree.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 445f8c11a9a3..c94c17194299 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -3058,7 +3058,7 @@ static void kfree_rcu_monitor(struct work_struct *work)
>  			// objects queued on the linked list.
>  			if (!krwp->head_free) {
>  				krwp->head_free = krcp->head;
> -				krcp->head = NULL;
> +				WRITE_ONCE(krcp->head, NULL);
>  			}
>  
>  			WRITE_ONCE(krcp->count, 0);
> @@ -3072,6 +3072,8 @@ static void kfree_rcu_monitor(struct work_struct *work)
>  		}
>  	}
>  
> +	raw_spin_unlock_irqrestore(&krcp->lock, flags);
> +
>  	// If there is nothing to detach, it means that our job is
>  	// successfully done here. In case of having at least one
>  	// of the channels that is still busy we should rearm the
> @@ -3079,8 +3081,6 @@ static void kfree_rcu_monitor(struct work_struct *work)
>  	// still in progress.
>  	if (need_offload_krc(krcp))
>  		schedule_delayed_monitor_work(krcp);
> -
> -	raw_spin_unlock_irqrestore(&krcp->lock, flags);
>  }
>  
>  static enum hrtimer_restart
> @@ -3250,7 +3250,7 @@ void kvfree_call_rcu(struct rcu_head *head, void *ptr)
>  
>  		head->func = ptr;
>  		head->next = krcp->head;
> -		krcp->head = head;
> +		WRITE_ONCE(krcp->head, head);
>  		success = true;
>  	}
>  
> @@ -3327,15 +3327,12 @@ static struct shrinker kfree_rcu_shrinker = {
>  void __init kfree_rcu_scheduler_running(void)
>  {
>  	int cpu;
> -	unsigned long flags;
>  
>  	for_each_possible_cpu(cpu) {
>  		struct kfree_rcu_cpu *krcp = per_cpu_ptr(&krc, cpu);
>  
> -		raw_spin_lock_irqsave(&krcp->lock, flags);
>  		if (need_offload_krc(krcp))
>  			schedule_delayed_monitor_work(krcp);
> -		raw_spin_unlock_irqrestore(&krcp->lock, flags);
>  	}
>  }
>  
> -- 
> 2.30.2
> 
