Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42E566504B1
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Dec 2022 22:07:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230461AbiLRVHn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Dec 2022 16:07:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiLRVHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Dec 2022 16:07:41 -0500
Received: from smtpout.efficios.com (unknown [IPv6:2607:5300:203:b2ee::31e5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2330760E1
        for <linux-kernel@vger.kernel.org>; Sun, 18 Dec 2022 13:07:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1671397659;
        bh=bzzA9VFUm6NqJzBX2Bls/aaFsWETWnz+FBiGd0+U0XU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=BHXMdpImVf4HLS+Ql8/RN8Lluozm+JA+JFkfgRHd0SqPzaqpgJEAf2mceIkAJPMcV
         yerbMgxa8D66izgvwomHPAi6HzS6ajQKfdp4dbjzfkotdf7ehyCdvopNUdq5T2ufXm
         dtDkVtcGTaRCrgE3I55VDDCf/oNo/KdZaetAZyPObjuC1RAxV6BQIOXbYzBdc5bE6p
         JwlU4c7/pUVTegZge2SUoD+xVWzsUIPiTKgL+cX8CTGpv7nA4fTy/2ZiaWBeYbKd6U
         0Tx/BbwbqZGzQ2EGozbCSPYOacUcCu4wJ/pPA4jH34RHONjarsijz5WP6q4Q+8Bc++
         LUNEVTx3Mv3Bg==
Received: from [10.1.0.203] (192-222-188-69.qc.cable.ebox.net [192.222.188.69])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4NZwQf6jcCzbfL;
        Sun, 18 Dec 2022 16:07:38 -0500 (EST)
Message-ID: <db4cccb8-e7fd-3d54-c5c8-3df90c5ddc49@efficios.com>
Date:   Sun, 18 Dec 2022 16:08:02 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [RFC 1/2] srcu: Remove comment about prior read lock counts
Content-Language: en-US
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org
Cc:     Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
References: <20221218191310.130904-1-joel@joelfernandes.org>
 <20221218191310.130904-2-joel@joelfernandes.org>
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <20221218191310.130904-2-joel@joelfernandes.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-12-18 14:13, Joel Fernandes (Google) wrote:
> The comment says that if an updater saw lock count updates, then
> ensure the reader does not see the new srcu_idx.
> 
> However, there is no memory barrier between a READER reading srcu_idx
> with respect to incrementing the lock count for that srcu_idx.
> 
> So what is really happening is, both "B" and "C" will order the current
> reader's unlock count update, and the _next_ readers lock count update, with
> respect to the write to the currently active index.
> 
> Consider first the case of the unlock count update being seen by the UPDATER:
> 
> (for brevity, the pseudocode shortens "srcu_idx" to "idx")
> 
> READER                            UPDATER
> 
> rcu_read_lock() {
>      idx = READ(idx);
>      lock_count[idx]++;
> 
>      smp_mb();    // B
> }
>                                  srcu_flip() {
>                                      smp_mb(); //E
>                                      idx++;
>                                      smp_mb();
>                                  }
> rcu_read_unlock() {
>      smp_mb();    // C
>      unlock_count[idx]++;
> }
> 
> Consider that the updater saw the unlock count update, and due to this, we
> expect "E" to make sure that the reader only used the old srcu_idx.
> 
> However, say the reader used the new srcu_idx because we dropped "E".  That is
> totally OK because both unlock and lock counts of this reader will negate each
> other during the next scan of the srcu_idx. So we don't have to guarantee at
> all that the reader used the old srcu_idx, that does not buy us anything
> because if it used the new one, we would just ignore it during the next scan
> anyway (the reader is "done").
> 
> Now lets look at the following case:
> 
> READER                            UPDATER
> 
> rcu_read_lock() {
>      idx = READ(idx);
>      lock_count[idx]++;
> 
>      smp_mb();    // B
> }
> 
> rcu_read_unlock() {
>      smp_mb();    // C
>      unlock_count[idx]++;
> }
>                                  srcu_flip() {
>                                      smp_mb(); //E
>                                      idx++;
> rcu_read_lock() {
>      idx = READ(idx);
>      lock_count[idx]++;
> 
>      smp_mb();    // B
>                                      smp_mb();
>                                  }
> }
> 
> Consider that the updater saw the lock count update of the second
> rcu_read_lock(). It does not matter that we guarantee that the reader sees only
> the old srcu_idx. This is because, a reader could totally just sample
> srcu_idx, and stay preempted for long periods of time. So, during any scan, we
> already have the issue of a preempted-reader randomly springing up with a copy
> of the index which we consider the "new index". So guaranteeing that the reader
> saw the old srcu_idx instead of the new one if we saw its lock count updates,
> also does not buy us anything.
> 
> Due to these reasons, drop the argument that the reader has to see a certain
> srcu_idx since we have no control over that anyway, and guaranteeing that does not
> buy us anything.

I don't understand why this first patch only removes a comment about the 
need to order things, when in fact it's the entire memory barrier /* E 
*/ that is useless.

I suspect we should just remove the comment along with the barrier 
without this added step.

What SRCU fundamentally does is detect quiescence of all SRCU readers 
between the beginning of the grace period and its completion. In order 
to ensure forward progress, it does so in a two-phase algorithm. What 
the grace period does to detect quiescence is to observe that each of 
the periods (0/1) have no active reader at a given point in the grace 
period. Then the fact that the period is flipped to send new-coming 
readers into a different period is just to ensure forward progress, and 
is basically irrelevant (order-wise) with the fact that the grace period 
scans both periods and validates that both periods are observed to have 
no active readers.

I'd favor just clarifying the SRCU model in this way, and then remove 
the useless barrier, and also implement improvements to the SRCU 
algorithm and skip the "flip" entirely when we notice (early) that no 
active readers are present in both periods. This is actually similar to 
what I implemented in side-rcu.

Thoughts ?

Thanks,

Mathieu

> 
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
>   kernel/rcu/srcutree.c | 10 ++++------
>   1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> index 1c304fec89c0..d6a4c2439ca6 100644
> --- a/kernel/rcu/srcutree.c
> +++ b/kernel/rcu/srcutree.c
> @@ -983,12 +983,10 @@ static bool try_check_zero(struct srcu_struct *ssp, int idx, int trycount)
>   static void srcu_flip(struct srcu_struct *ssp)
>   {
>   	/*
> -	 * Ensure that if this updater saw a given reader's increment
> -	 * from __srcu_read_lock(), that reader was using an old value
> -	 * of ->srcu_idx.  Also ensure that if a given reader sees the
> -	 * new value of ->srcu_idx, this updater's earlier scans cannot
> -	 * have seen that reader's increments (which is OK, because this
> -	 * grace period need not wait on that reader).
> +	 * Ensure that if a given reader sees the new value of ->srcu_idx, this
> +	 * updater's earlier scans cannot have seen that reader's increments
> +	 * (which is OK, because this grace period need not wait on that
> +	 * reader).
>   	 */
>   	smp_mb(); /* E */  /* Pairs with B and C. */
>   

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

