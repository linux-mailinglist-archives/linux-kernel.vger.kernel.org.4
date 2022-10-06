Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DA8F5F6DF6
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 21:12:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231904AbiJFTMa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 15:12:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231882AbiJFTM1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 15:12:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 997B1A6C2B;
        Thu,  6 Oct 2022 12:12:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3603D61A7C;
        Thu,  6 Oct 2022 19:12:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F53FC433C1;
        Thu,  6 Oct 2022 19:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665083545;
        bh=L1/rrdA1PNfLkqINPeL0IqipCB5baNlSEZu6Kk65+FU=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Yfq7dcrXHxxgUa7KFs2ARpROo4rCIC0PFmX7YafjEQtCw5hkhtpEqkt0hbXRIqfJ5
         NdxR6Rwk/YJtaxCXIKje7CcgOUAxLwdK7h4E6kcVgt1MyQJnacJGd70ymOh0QJiu98
         fMNEGMBIBDZjWIVpgraurgEgbDzh8pXLAzmzZj8ZV7ifBrE91uLQ4NPIAQGO2f5yam
         X2MzXsG/aruudyrSIIDo47aPIKgdWliPSVrYeBygZpQkRKjV2yspSmh+vOjCF63n7c
         xpixT+hHNZ3GIyEIB8Q4udgIoOH0Quwvqd/1CuoO/x0Q99qoqX6TMhePOOKoDyz5St
         W3y4ahpg4PDyA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 40AC95C0F66; Thu,  6 Oct 2022 12:12:25 -0700 (PDT)
Date:   Thu, 6 Oct 2022 12:12:25 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        rushikesh.s.kadam@intel.com, urezki@gmail.com,
        neeraj.iitr10@gmail.com, frederic@kernel.org, rostedt@goodmis.org,
        youssefesmat@google.com, surenb@google.com
Subject: Re: [PATCH v7 03/11] rcu: Refactor code a bit in
 rcu_nocb_do_flush_bypass()
Message-ID: <20221006191225.GD4196@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221004024157.2470238-1-joel@joelfernandes.org>
 <20221004024157.2470238-4-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221004024157.2470238-4-joel@joelfernandes.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 04, 2022 at 02:41:49AM +0000, Joel Fernandes (Google) wrote:
> This consolidates the code a bit and makes it cleaner. Functionally it
> is the same.
> 
> Reported-by: Paul E. McKenney <paulmck@kernel.org>
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
>  kernel/rcu/tree_nocb.h | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
> index 56616bfbe156..dfa736da68ab 100644
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

Much much better, thank you!

							Thanx, Paul

>  	rcu_segcblist_insert_pend_cbs(&rdp->cblist, &rcl);
>  	WRITE_ONCE(rdp->nocb_bypass_first, j);
> -- 
> 2.38.0.rc1.362.ged0d419d3c-goog
> 
