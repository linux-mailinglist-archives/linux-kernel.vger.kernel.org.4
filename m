Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45AE05FAA6C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 04:01:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbiJKCB3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 22:01:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbiJKCBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 22:01:25 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6D0062AB1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 19:01:24 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id h15so3378211qtu.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 19:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ORicAiyRp2xEN2rltMwZEQe7uHMjmlXqhAWmpOdSq5I=;
        b=H1LAYRyJEgpkQ57aGdJHIkLjBYRzXfVIIpOCS5FM6HVaohDOhq3WorsMO3pjYKL8cP
         g1ctFlY1rLDyXNScAeCIbyunfhl4CSK+S4yTVbNs6PbXfTQNDip40HI+IjV6yn9FTl+l
         /12o6qNFonsAU0ZwButFeCdoXCW+z3wsdAWtQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ORicAiyRp2xEN2rltMwZEQe7uHMjmlXqhAWmpOdSq5I=;
        b=bwZLb0i0L2EqDmER3MFGzchZxd5F5+dfP3BULW0Od+8eC9cmxBxKm05ryR69GUNRCK
         NnlTypC/zf8Iuy1+8fa0GXN85Rawx+nGYUeoMz/Ne9tM0ACN9TPAqcojfH/LewES3pVv
         147qjmtCDMyV7GfjKgxlI8VqlWNJ57yDW5MSRjFrt/pRpkBHt74kTflgIsE1sDdqjHqe
         Qxv8OYHeh+Zl43mTlsX6AcOezsd4Q3BLMnXyYZ1UWwXF/PC4eLOO2GvZm2oh1uyNr6z1
         Jgk6CokjX1YdXpAiQPtkIcJynhHJNqhKEstt9Qp84ggSAk9KtvGTIOkwxzX8w6tQG/rk
         +6wA==
X-Gm-Message-State: ACrzQf3eKVEBnDMOwMAIfDNuyW/kNw2SndIiI3q1Sdgbdof6UuhnJaWc
        TUvxCVGTYFakRTwclDZ+/4z4YQ==
X-Google-Smtp-Source: AMsMyM7PA9yKtHUCMspsjs6kVoVo+ARNryV+nxDzF02IgwSysj5B9R0IxY2foP3cskjwCNDzIeGhGA==
X-Received: by 2002:a05:622a:3c9:b0:391:984a:9391 with SMTP id k9-20020a05622a03c900b00391984a9391mr17456020qtx.420.1665453683852;
        Mon, 10 Oct 2022 19:01:23 -0700 (PDT)
Received: from localhost (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id o21-20020a05622a009500b00394d7000941sm9116846qtw.85.2022.10.10.19.01.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 19:01:23 -0700 (PDT)
Date:   Tue, 11 Oct 2022 02:01:23 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     "Paul E . McKenney" <paulmck@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] rcu: Fix missing nocb gp wake on rcu_barrier()
Message-ID: <Y0TOc8eigdzanBGQ@google.com>
References: <20221010223956.1041247-1-frederic@kernel.org>
 <20221010223956.1041247-2-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221010223956.1041247-2-frederic@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 11, 2022 at 12:39:55AM +0200, Frederic Weisbecker wrote:
> Upon entraining a callback to a NOCB CPU, no further wake up is
> issued on the corresponding nocb_gp kthread. As a result, the callback
> and all the subsequent ones on that CPU may be ignored, at least until
> an RCU_NOCB_WAKE_FORCE timer is ever armed or another NOCB CPU belonging
> to the same group enqueues a callback on an empty queue.
> 
> Here is a possible bad scenario:
> 
> 1) CPU 0 is NOCB unlike all other CPUs.
> 2) CPU 0 queues a callback
> 2) The grace period related to that callback elapses
> 3) The callback is moved to the done list (but is not invoked yet),
>    there are no more pending callbacks for CPU 0
> 4) CPU 1 calls rcu_barrier() and sends an IPI to CPU 0
> 5) CPU 0 entrains the callback but doesn't wake up nocb_gp
> 6) CPU 1 blocks forever, unless CPU 0 ever queues enough further
>    callbacks to arm an RCU_NOCB_WAKE_FORCE timer.
> 
> Make sure the necessary wake up is produced whenever necessary.
> 
> Reported-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> Fixes: 5d6742b37727 ("rcu/nocb: Use rcu_segcblist for no-CBs CPUs")
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>

Acked-by: Joel Fernandes (Google) <joel@joelfernandes.org>

And if Paul is taking this, I'll rebase and drop this patch from the lazy
series.

thanks,

 - Joel


> ---
>  kernel/rcu/tree.c      | 6 ++++++
>  kernel/rcu/tree.h      | 1 +
>  kernel/rcu/tree_nocb.h | 5 +++++
>  3 files changed, 12 insertions(+)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 96d678c9cfb6..025f59f6f97f 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -3914,6 +3914,8 @@ static void rcu_barrier_entrain(struct rcu_data *rdp)
>  {
>  	unsigned long gseq = READ_ONCE(rcu_state.barrier_sequence);
>  	unsigned long lseq = READ_ONCE(rdp->barrier_seq_snap);
> +	bool wake_nocb = false;
> +	bool was_alldone = false;
>  
>  	lockdep_assert_held(&rcu_state.barrier_lock);
>  	if (rcu_seq_state(lseq) || !rcu_seq_state(gseq) || rcu_seq_ctr(lseq) != rcu_seq_ctr(gseq))
> @@ -3922,6 +3924,7 @@ static void rcu_barrier_entrain(struct rcu_data *rdp)
>  	rdp->barrier_head.func = rcu_barrier_callback;
>  	debug_rcu_head_queue(&rdp->barrier_head);
>  	rcu_nocb_lock(rdp);
> +	was_alldone = rcu_rdp_is_offloaded(rdp) && !rcu_segcblist_pend_cbs(&rdp->cblist);
>  	WARN_ON_ONCE(!rcu_nocb_flush_bypass(rdp, NULL, jiffies));
>  	if (rcu_segcblist_entrain(&rdp->cblist, &rdp->barrier_head)) {
>  		atomic_inc(&rcu_state.barrier_cpu_count);
> @@ -3929,7 +3932,10 @@ static void rcu_barrier_entrain(struct rcu_data *rdp)
>  		debug_rcu_head_unqueue(&rdp->barrier_head);
>  		rcu_barrier_trace(TPS("IRQNQ"), -1, rcu_state.barrier_sequence);
>  	}
> +	wake_nocb = was_alldone && rcu_segcblist_pend_cbs(&rdp->cblist);
>  	rcu_nocb_unlock(rdp);
> +	if (wake_nocb)
> +		wake_nocb_gp(rdp, false);
>  	smp_store_release(&rdp->barrier_seq_snap, gseq);
>  }
>  
> diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
> index d4a97e40ea9c..925dd98f8b23 100644
> --- a/kernel/rcu/tree.h
> +++ b/kernel/rcu/tree.h
> @@ -439,6 +439,7 @@ static void zero_cpu_stall_ticks(struct rcu_data *rdp);
>  static struct swait_queue_head *rcu_nocb_gp_get(struct rcu_node *rnp);
>  static void rcu_nocb_gp_cleanup(struct swait_queue_head *sq);
>  static void rcu_init_one_nocb(struct rcu_node *rnp);
> +static bool wake_nocb_gp(struct rcu_data *rdp, bool force);
>  static bool rcu_nocb_flush_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
>  				  unsigned long j);
>  static bool rcu_nocb_try_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
> diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
> index f77a6d7e1356..094fd454b6c3 100644
> --- a/kernel/rcu/tree_nocb.h
> +++ b/kernel/rcu/tree_nocb.h
> @@ -1558,6 +1558,11 @@ static void rcu_init_one_nocb(struct rcu_node *rnp)
>  {
>  }
>  
> +static bool wake_nocb_gp(struct rcu_data *rdp, bool force)
> +{
> +	return false;
> +}
> +
>  static bool rcu_nocb_flush_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
>  				  unsigned long j)
>  {
> -- 
> 2.25.1
> 
