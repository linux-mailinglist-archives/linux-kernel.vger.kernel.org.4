Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C8EB6540C3
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 13:12:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235566AbiLVMML (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 07:12:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235777AbiLVMLe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 07:11:34 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5196B36D42;
        Thu, 22 Dec 2022 04:03:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 4F7F3CE19BB;
        Thu, 22 Dec 2022 12:03:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F10E6C433D2;
        Thu, 22 Dec 2022 12:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671710602;
        bh=juXlLY89CiB9bJ9o17px1v8bs7xEFLxq9o/YkeYNwvg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BxxeCHxAMVIThDcrxhuGCdBUO2YtMPtf5b0Acf6+0I8BGI7do+Tclh9jQgSSqEgyW
         dVgpCG6SSH5CzjlfPTZ7kylDtjvA4WMECdQEXSopfTE+O/nu+PatRbvNyGMsUI/3hE
         0UnYbgAKzG9G8wa9MwxAwyJS2kF9mKd8CXyX+lH4eOkGZ2Vzu6qzVa+RB4YwbUm41g
         MLK4+xh3SK/W4B67xN/gcHzrmWMvgwnOgbe91MuVcpg4Fr4uhMfiJ42JQw2OUFRL9p
         MO557ODWyoovr88Y/RnW2NKOd7CcYLkjQ7xb28qpFwsVVA2WiPwtYxB3iYilDcs/YR
         BX12fqUGDv8dQ==
Date:   Thu, 22 Dec 2022 13:03:19 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>, neeraj.iitr10@gmail.com
Subject: Re: [PATCH] srcu: Remove memory barrier "E" as it does not do
 anything
Message-ID: <20221222120319.GA44533@lothringen>
References: <20221222002011.1858494-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221222002011.1858494-1-joel@joelfernandes.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 22, 2022 at 12:20:11AM +0000, Joel Fernandes (Google) wrote:
> During a flip, we have a full memory barrier before srcu_idx is incremented.
> 
> The idea is we intend to order the first phase scan's read of lock
> counters with the flipping of the index.
> 
> However, such ordering is already enforced because of the
> control-dependency between the 2 scans. We would be flipping the index
> only if lock and unlock counts matched.
> 
> But such match will not happen if there was a pending reader before the flip
> in the first place (observation courtesy Mathieu Desnoyers).
> 
> The litmus test below shows this:
> (test courtesy Frederic Weisbecker, Changes for ctrldep by Boqun/me):
> 
> C srcu
> 
> {}
> 
> // updater
> P0(int *IDX, int *LOCK0, int *UNLOCK0, int *LOCK1, int *UNLOCK1)
> {
>         int lock1;
>         int unlock1;
>         int lock0;
>         int unlock0;
> 
>         // SCAN1
>         unlock1 = READ_ONCE(*UNLOCK1);
>         smp_mb(); // A
>         lock1 = READ_ONCE(*LOCK1);
> 
>         // FLIP
>         if (lock1 == unlock1) {         // Control dep
>                 smp_mb(); // E
>                 WRITE_ONCE(*IDX, 1);
>                 smp_mb(); // D
> 
>                 // SCAN2
>                 unlock0 = READ_ONCE(*UNLOCK0);
>                 smp_mb(); // A
>                 lock0 = READ_ONCE(*LOCK0);
>         }
> }
> 
> // reader
> P1(int *IDX, int *LOCK0, int *UNLOCK0, int *LOCK1, int *UNLOCK1)
> {
>         int tmp;
>         int idx1;
>         int idx2;
> 
>         // 1st reader
>         idx1 = READ_ONCE(*IDX);
>         if (idx1 == 0) {
>                 tmp = READ_ONCE(*LOCK0);
>                 WRITE_ONCE(*LOCK0, tmp + 1);
>                 smp_mb(); /* B and C */
>                 tmp = READ_ONCE(*UNLOCK0);
>                 WRITE_ONCE(*UNLOCK0, tmp + 1);
>         } else {
>                 tmp = READ_ONCE(*LOCK1);
>                 WRITE_ONCE(*LOCK1, tmp + 1);
>                 smp_mb(); /* B and C */
>                 tmp = READ_ONCE(*UNLOCK1);
>                 WRITE_ONCE(*UNLOCK1, tmp + 1);
>         }
> 
>         // second reader
>         idx2 = READ_ONCE(*IDX);
>         if (idx2 == 0) {
>                 tmp = READ_ONCE(*LOCK0);
>                 WRITE_ONCE(*LOCK0, tmp + 1);
>                 smp_mb(); /* B and C */
>                 tmp = READ_ONCE(*UNLOCK0);
>                 WRITE_ONCE(*UNLOCK0, tmp + 1);
>         } else {
>                 tmp = READ_ONCE(*LOCK1);
>                 WRITE_ONCE(*LOCK1, tmp + 1);
>                 smp_mb(); /* B and C */
>                 tmp = READ_ONCE(*UNLOCK1);
>                 WRITE_ONCE(*UNLOCK1, tmp + 1);
>         }
> }
> 
> The following bad condition will not occur even if memory barrier E
> is dropped:
> 
> (* bad condition: SCAN1 saw lock count changes though 1st reader saw flip *)
>  exists (0:lock1=1 /\ 1:idx1=1 /\ 1:idx2=1)

Good catch!

The litmus test can be shorten with removing the second reader and limit the
exists clause to 0:lock1=1 :

---
C srcu-E

{}

// updater
P0(int *IDX, int *LOCK0, int *UNLOCK0, int *LOCK1, int *UNLOCK1)
{
	int lock1;
	int unlock1;
	int lock0;
	int unlock0;

	// SCAN1
	unlock1 = READ_ONCE(*UNLOCK1);
	smp_mb(); // A
	lock1 = READ_ONCE(*LOCK1);

	// FLIP
	if (lock1 == unlock1) {         // Control dep
		WRITE_ONCE(*IDX, 1);
		smp_mb(); // D

		// SCAN2
		unlock0 = READ_ONCE(*UNLOCK0);
		smp_mb(); // A
		lock0 = READ_ONCE(*LOCK0);
	}
}

// reader
P1(int *IDX, int *LOCK0, int *UNLOCK0, int *LOCK1, int *UNLOCK1)
{
	int tmp;
	int idx1;
	int idx2;

	// 1st reader
	idx1 = READ_ONCE(*IDX);
	if (idx1 == 0) {
		tmp = READ_ONCE(*LOCK0);
		WRITE_ONCE(*LOCK0, tmp + 1);
		smp_mb(); /* B and C */
		tmp = READ_ONCE(*UNLOCK0);
		WRITE_ONCE(*UNLOCK0, tmp + 1);
	} else {
		tmp = READ_ONCE(*LOCK1);
		WRITE_ONCE(*LOCK1, tmp + 1);
		smp_mb(); /* B and C */
		tmp = READ_ONCE(*UNLOCK1);
		WRITE_ONCE(*UNLOCK1, tmp + 1);
	}
}
exists (0:lock1=1) (* only happens if the control dep is removed *)
--

> diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> index 1c304fec89c0..d1368d64fdba 100644
> --- a/kernel/rcu/srcutree.c
> +++ b/kernel/rcu/srcutree.c
> @@ -983,15 +983,9 @@ static bool try_check_zero(struct srcu_struct *ssp, int idx, int trycount)
>  static void srcu_flip(struct srcu_struct *ssp)
>  {
>  	/*
> -	 * Ensure that if this updater saw a given reader's increment
> -	 * from __srcu_read_lock(), that reader was using an old value
> -	 * of ->srcu_idx.  Also ensure that if a given reader sees the
> -	 * new value of ->srcu_idx, this updater's earlier scans cannot
> -	 * have seen that reader's increments (which is OK, because this
> -	 * grace period need not wait on that reader).
> +	 * Control dependency locks==unlocks ensures that if a reader sees the
> +	 * flip, previous scan would only see before-flip reader lock counts.

I would personally prefer that we keep the detailed comment explaining the
ordering requirements here, just mentioning it's performed via control
dependency now. This way we don't need to debate that again in 10 years.

Thanks.


>  	 */
> -	smp_mb(); /* E */  /* Pairs with B and C. */
> -
>  	WRITE_ONCE(ssp->srcu_idx, ssp->srcu_idx + 1);
>  
>  	/*
> -- 
> 2.39.0.314.g84b9a713c41-goog
> 
