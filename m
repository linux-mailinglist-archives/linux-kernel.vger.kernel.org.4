Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 302066CF4A6
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 22:47:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbjC2UrL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 16:47:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbjC2UrJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 16:47:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61FDA211D;
        Wed, 29 Mar 2023 13:47:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F1BF861E30;
        Wed, 29 Mar 2023 20:47:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62ADFC433EF;
        Wed, 29 Mar 2023 20:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680122825;
        bh=Y9gW5bUpWF6O6u6VrSg80iulJKNDNjmWPZdbHZAdcbQ=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=oSCCIA5y0k5m/+2+D1p9a9iSlXFQlcro7fkMwaLpvEL7qTgQZwtDBduPWERCgB6Z0
         9TchGaRY1gmRfP07txXNy7fqKruW7toMonhRPV+qYnHioD2ugc6EXSTCIMaJBsBfhH
         WXOyJskd1CGca+/smKXr/puHiOHyHN1IS6Zh7nPYcEmEIMmBgPjX2Dm7lI83xQh8+d
         A976oOKTTHP9pN1yB3fAGIsmV0rm0Be8BFIhYXWStoMOnfUxTaA68nhlaFJbx5E+Tb
         lpEROQSfqEFSD7NyKLm69vpOzyIzT3e0EZOpjTdmD8BS+YpYT1n0Wv5mhMHrsI7PuR
         C865vS7H3Hc5A==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id F14A5154047D; Wed, 29 Mar 2023 13:47:04 -0700 (PDT)
Date:   Wed, 29 Mar 2023 13:47:04 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, rcu <rcu@vger.kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH 2/4] rcu/nocb: Fix shrinker race against callback enqueuer
Message-ID: <78605970-d561-403e-8301-895ca87977f2@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230329160203.191380-1-frederic@kernel.org>
 <20230329160203.191380-3-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230329160203.191380-3-frederic@kernel.org>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 29, 2023 at 06:02:01PM +0200, Frederic Weisbecker wrote:
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
> ---
>  kernel/rcu/tree_nocb.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
> index 1a86883902ce..c321fce2af8e 100644
> --- a/kernel/rcu/tree_nocb.h
> +++ b/kernel/rcu/tree_nocb.h
> @@ -1364,7 +1364,7 @@ lazy_rcu_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
>  			continue;
>  
>  		rcu_nocb_lock_irqsave(rdp, flags);
> -		WRITE_ONCE(rdp->lazy_len, 0);
> +		WARN_ON_ONCE(!rcu_nocb_flush_bypass(rdp, NULL, jiffies, false));

And I do feel much better about this version.  ;-)

>  		rcu_nocb_unlock_irqrestore(rdp, flags);
>  		wake_nocb_gp(rdp, false);
>  		sc->nr_to_scan -= _count;
> -- 
> 2.34.1
> 
