Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4E8E636522
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 16:59:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237411AbiKWP7n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 10:59:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235918AbiKWP7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 10:59:33 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CE8EDD;
        Wed, 23 Nov 2022 07:59:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BB56361DDD;
        Wed, 23 Nov 2022 15:59:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A36D7C433C1;
        Wed, 23 Nov 2022 15:59:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669219172;
        bh=xhSayXw1inqZZFR8s8TjR7HOd4tlJGjeZ7YEdMkj0Dw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y8XtedCI2cb2NetRpBy1LlZ+TWi4QP9EUWRkC2deGnsJYW9UVOjt80Is59hSqFyLY
         HH4bCYAqZt9gIh/1DGIasGWhgO5STPf/oEMiyJUZuSdRwDZitVJTLuOgYLYOvMI+2d
         gHejASlEU2w3FyAQI9lixHIJpbPDXs11ZRwgnbM4bjLErBTQtNxVMjIhUsoO0yipOb
         RxpdNqc3cOObreVzSFdGQtgQU6BpqzFPkb2UcmsUCCrVDZoFTCn7FIZbv3k++PpimE
         UTujas1rpDHzA0EhR1CaxDCrKZ+wLgd21dCuWtNNFXSTNOwHFBZBE6EIaNQZ22Sj0+
         sSljr25NhDKQA==
Date:   Wed, 23 Nov 2022 16:59:29 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, rostedt@goodmis.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: Re: [PATCH v2 rcu 05/16] rcu: Refactor code a bit in
 rcu_nocb_do_flush_bypass()
Message-ID: <20221123155929.GB1387380@lothringen>
References: <20221122010408.GA3799268@paulmck-ThinkPad-P17-Gen-1>
 <20221122010421.3799681-5-paulmck@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221122010421.3799681-5-paulmck@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 21, 2022 at 05:04:10PM -0800, Paul E. McKenney wrote:
> From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
> 
> This consolidates the code a bit and makes it cleaner. Functionally it
> is the same.
> 
> Reported-by: Paul E. McKenney <paulmck@kernel.org>
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> ---
>  kernel/rcu/tree_nocb.h | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
> index d6e4c076b0515..213daf81c057f 100644
> --- a/kernel/rcu/tree_nocb.h
> +++ b/kernel/rcu/tree_nocb.h
> @@ -327,10 +327,11 @@ static void wake_nocb_gp_defer(struct rcu_data *rdp, int waketype,
>   *
>   * Note that this function always returns true if rhp is NULL.
>   */
> -static bool rcu_nocb_do_flush_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
> +static bool rcu_nocb_do_flush_bypass(struct rcu_data *rdp, struct rcu_head *rhp_in,
>  				     unsigned long j, bool lazy)
>  {
>  	struct rcu_cblist rcl;
> +	struct rcu_head *rhp = rhp_in;

Why that intermediate rhp_in?

>  
>  	WARN_ON_ONCE(!rcu_rdp_is_offloaded(rdp));
>  	rcu_lockdep_assert_cblist_protected(rdp);
> @@ -345,16 +346,16 @@ static bool rcu_nocb_do_flush_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
>  
>  	/*
>  	 * If the new CB requested was a lazy one, queue it onto the main
> -	 * ->cblist so we can take advantage of a sooner grade period.
> +	 * ->cblist so that we can take advantage of the grace-period that will
> +	 * happen regardless. But queue it onto the bypass list first so that
> +	 * the lazy CB is ordered with the existing CBs in the bypass list.
>  	 */
>  	if (lazy && rhp) {
> -		rcu_cblist_flush_enqueue(&rcl, &rdp->nocb_bypass, NULL);
> -		rcu_cblist_enqueue(&rcl, rhp);
> -		WRITE_ONCE(rdp->lazy_len, 0);
> -	} else {
> -		rcu_cblist_flush_enqueue(&rcl, &rdp->nocb_bypass, rhp);
> -		WRITE_ONCE(rdp->lazy_len, 0);
> +		rcu_cblist_enqueue(&rdp->nocb_bypass, rhp);
> +		rhp = NULL;
>  	}
> +	rcu_cblist_flush_enqueue(&rcl, &rdp->nocb_bypass, rhp);
> +	WRITE_ONCE(rdp->lazy_len, 0);

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

Thanks.

>  
>  	rcu_segcblist_insert_pend_cbs(&rdp->cblist, &rcl);
>  	WRITE_ONCE(rdp->nocb_bypass_first, j);
> -- 
> 2.31.1.189.g2e36527f23
> 
