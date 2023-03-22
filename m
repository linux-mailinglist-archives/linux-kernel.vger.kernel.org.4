Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAB736C5A36
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 00:19:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbjCVXTv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 19:19:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbjCVXTs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 19:19:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C01320A12;
        Wed, 22 Mar 2023 16:19:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EA0E3B81E92;
        Wed, 22 Mar 2023 23:19:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2C4CC433EF;
        Wed, 22 Mar 2023 23:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679527184;
        bh=CeNA3Xry0fukNgve+HGWGm961c/J0hFU2HFr5a30is4=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=JHAWGcHAf7EZwxxHPoUqdpWeJl1FvTYi/A/to/4Ud+Gob/l0jU0mW0k9McyV5960e
         aBE2ib1HW20u7+cCOe5U8agHkIJfMmKHf762PC7Vf0m2S92MgqvOaCtNK3jWP0QDEL
         FaL17FWfX4khnSwVxGrY89vLxrWhvN89Sm+yfZY/YcpFPjfEWnDmRqolCxIOPAaq8k
         x1TT++pulKOUiwvTNSMInCsQto7FPDh8wCzz+PCzkJ41Cqox17CjA+MANC8HMqp+4X
         aAMrawakhfbrch9lAzwewLVGHze3mF0GiBpkHwFl8/cXJQXw9OVMAIjTE1Z3D51dri
         V49rWhqkFuvew==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 5C0721540397; Wed, 22 Mar 2023 16:19:44 -0700 (PDT)
Date:   Wed, 22 Mar 2023 16:19:44 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, rcu <rcu@vger.kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH 2/4] rcu/nocb: Fix shrinker race against callback enqueuer
Message-ID: <39a0664a-cabf-4e3c-a663-af6e33fbe339@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230322194456.2331527-1-frederic@kernel.org>
 <20230322194456.2331527-3-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230322194456.2331527-3-frederic@kernel.org>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 22, 2023 at 08:44:54PM +0100, Frederic Weisbecker wrote:
> The shrinker resets the lazy callbacks counter in order to trigger the
> pending lazy queue flush though the rcuog kthread. The counter reset is
> protected by the ->nocb_lock against concurrent accesses...except
> for one of them. Here is a list of existing synchronized readers/writer:
> 
> 1) The first lazy enqueuer (incrementing ->lazy_len to 1) does so under
>    ->nocb_lock and ->nocb_bypass_lock.
> 
> 2) The further lazy enqueuers (incrementing ->lazy_len above 1) do so
>    under ->nocb_bypass_lock _only_.
> 
> 3) The lazy flush checks and resets to 0 under ->nocb_lock and
> 	->nocb_bypass_lock.
> 
> The shrinker protects its ->lazy_len reset against cases 1) and 3) but
> not against 2). As such, setting ->lazy_len to 0 under the ->nocb_lock
> may be cancelled right away by an overwrite from an enqueuer, leading
> rcuog to ignore the flush.
> 
> To avoid that, use the proper bypass flush API which takes care of all
> those details.
> 
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>

Again, good catch, and this one looks good to me.

So what am I missing?  ;-)

							Thanx, Paul

> ---
>  kernel/rcu/tree_nocb.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
> index dd9b655ae533..cb57e8312231 100644
> --- a/kernel/rcu/tree_nocb.h
> +++ b/kernel/rcu/tree_nocb.h
> @@ -1356,7 +1356,7 @@ lazy_rcu_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
>  			continue;
>  
>  		rcu_nocb_lock_irqsave(rdp, flags);
> -		WRITE_ONCE(rdp->lazy_len, 0);
> +		WARN_ON_ONCE(!rcu_nocb_flush_bypass(rdp, NULL, jiffies, false));
>  		rcu_nocb_unlock_irqrestore(rdp, flags);
>  		wake_nocb_gp(rdp, false);
>  		sc->nr_to_scan -= _count;
> -- 
> 2.34.1
> 
