Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1F686C8818
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 23:09:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231571AbjCXWJO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 18:09:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbjCXWJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 18:09:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 580A410C6;
        Fri, 24 Mar 2023 15:09:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EA51C62CE6;
        Fri, 24 Mar 2023 22:09:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2498C433D2;
        Fri, 24 Mar 2023 22:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679695751;
        bh=LQPEjQgMHXn1jrgNVQJMxSof7H2xHMusNBeu5tdTz60=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rmb36Meo1e0IN/TauON8s9uY/QKfoQUvUVFHcdsO+v7XIKgLofa7i74fFF+ctkvhe
         UgrrMsr5E9QLwS+TfDTT68UN4y7ZXcmbzptLxrMM7+c0oiTG8H58+RkZ4qLCNK0ZJj
         AsZSrNXo4jbicryrDNrGeirYV37lzIPEI0VAncgqDMViIjDDrR0WIlm79QuVUPbsCz
         3Z9/OhxTk1UIQLVERMsaHA+607CXEdGQR3Myv9pCrYRMsH3WgiVehnBwpC7d87u1mU
         E/VwAEvO/NwuWhDg4Xv+1bFstCR/7FLvFZ7hFETys80lKpUmUajUu03wyHKvh2PKAW
         DnnZkkDdlt70A==
Date:   Fri, 24 Mar 2023 23:09:08 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, rcu <rcu@vger.kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH 1/4] rcu/nocb: Protect lazy shrinker against concurrent
 (de-)offloading
Message-ID: <ZB4fhA1BafN7h2N3@localhost.localdomain>
References: <20230322194456.2331527-1-frederic@kernel.org>
 <20230322194456.2331527-2-frederic@kernel.org>
 <c614c542-f2b5-4b39-bbc4-ae5f0a125c81@paulmck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c614c542-f2b5-4b39-bbc4-ae5f0a125c81@paulmck-laptop>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Wed, Mar 22, 2023 at 04:18:24PM -0700, Paul E. McKenney a écrit :
> > @@ -1336,13 +1336,25 @@ lazy_rcu_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
> >  	unsigned long flags;
> >  	unsigned long count = 0;
> >  
> > +	/*
> > +	 * Protect against concurrent (de-)offloading. Otherwise nocb locking
> > +	 * may be ignored or imbalanced.
> > +	 */
> > +	mutex_lock(&rcu_state.barrier_mutex);
> 
> I was worried about this possibly leading to out-of-memory deadlock,
> but if I recall correctly, the (de-)offloading process never allocates
> memory, so this should be OK?

Good point. It _should_ be fine but like you, Joel and Hillf pointed out
it's asking for trouble.

We could try Joel's idea to use mutex_trylock() as a best effort, which
should be fine as it's mostly uncontended.

The alternative is to force nocb locking and check the offloading state
right after. So instead of:

	rcu_nocb_lock_irqsave(rdp, flags);
	//flush stuff
	rcu_nocb_unlock_irqrestore(rdp, flags);

Have:

	raw_spin_lock_irqsave(rdp->nocb_lock, flags);
	if (!rcu_rdp_is_offloaded(rdp))
		raw_spin_unlock_irqrestore(rdp->nocb_lock, flags);
		continue;
	}
	//flush stuff
	rcu_nocb_unlock_irqrestore(rdp, flags);

But it's not pretty and also disqualifies the last two patches as
rcu_nocb_mask can't be iterated safely anymore.

What do you think?

> >  	/* Snapshot count of all CPUs */
> >  	for_each_possible_cpu(cpu) {
> >  		struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
> > -		int _count = READ_ONCE(rdp->lazy_len);
> > +		int _count;
> > +
> > +		if (!rcu_rdp_is_offloaded(rdp))
> > +			continue;
> 
> If the CPU is offloaded, isn't ->lazy_len guaranteed to be zero?
> 
> Or can it contain garbage after a de-offloading operation?

If it's deoffloaded, ->lazy_len is indeed (supposed to be) guaranteed to be zero.
Bypass is flushed and disabled atomically early on de-offloading and the
flush resets ->lazy_len.

Thanks.
