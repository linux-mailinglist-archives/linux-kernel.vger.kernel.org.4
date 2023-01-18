Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3F83671A20
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 12:11:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbjARLLs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 06:11:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbjARLLJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 06:11:09 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D12CD9084C;
        Wed, 18 Jan 2023 02:18:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6AC8361744;
        Wed, 18 Jan 2023 10:18:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62965C433F0;
        Wed, 18 Jan 2023 10:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674037129;
        bh=xJ/Cw2FUAmOw6EcpQrNQixoTROjtQ1A2Dd9PkmuNyrY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HKNgm6TZG0JRPNEKyK4b5p9suz8FUEJnJj4NnjXJd0OjpN8c6fAp707Uil5d10KFU
         oNy0V/GyZnBjeEw8GicYZEHO+qQLqc4JX8Tq+S7DDCVvB5u/9b1MRsGJqYaUZ/4cWl
         W5Aa8CAQ03rQQ1JrYEziaZhS4hFTQ/wjOEiMhg38BfKoSDAm+OK5v0mjBEYsSEvWue
         8HDwY4g31JlwimOwfBYkRAqy9sIGIuVZ3L56ozzhn+KvM9QOSoXhX8mLvicS3quRzW
         WfSb7hxYHiatpRmy4GkpXVNi12m1wsuBQ7b31b42ylZ8Vh5rNaG0BaravQZiLVl1OO
         G7GfJ2MAA38BA==
Date:   Wed, 18 Jan 2023 11:18:47 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Zqiang <qiang1.zhang@intel.com>
Cc:     paulmck@kernel.org, quic_neeraju@quicinc.com,
        joel@joelfernandes.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] rcu: Remove impossible wakeup rcu GP kthread action
 from rcu_report_qs_rdp()
Message-ID: <Y8fHh3jvi/N2kfDB@lothringen>
References: <20230118073014.2020743-1-qiang1.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230118073014.2020743-1-qiang1.zhang@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2023 at 03:30:14PM +0800, Zqiang wrote:
> When inovke rcu_report_qs_rdp(), if current CPU's rcu_data structure's ->
> grpmask has not been cleared from the corresponding rcu_node structure's
> ->qsmask, after that will clear and report quiescent state, but in this
> time, this also means that current grace period is not end, the current
> grace period is ongoing, because the rcu_gp_in_progress() currently return
> true, so for non-offloaded rdp, invoke rcu_accelerate_cbs() is impossible
> to return true.
> 
> This commit therefore remove impossible rcu_gp_kthread_wake() calling.
> 
> Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

Thanks!

> ---
>  kernel/rcu/tree.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index b2c204529478..0962c2202d45 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -1956,7 +1956,6 @@ rcu_report_qs_rdp(struct rcu_data *rdp)
>  {
>  	unsigned long flags;
>  	unsigned long mask;
> -	bool needwake = false;
>  	bool needacc = false;
>  	struct rcu_node *rnp;
>  
> @@ -1988,7 +1987,12 @@ rcu_report_qs_rdp(struct rcu_data *rdp)
>  		 * NOCB kthreads have their own way to deal with that...
>  		 */
>  		if (!rcu_rdp_is_offloaded(rdp)) {
> -			needwake = rcu_accelerate_cbs(rnp, rdp);
> +			/*
> +			 * Current GP does not end, invoke rcu_gp_in_progress()
> +			 * will return true and so doesn't wake up GP kthread to
> +			 * start a new GP.
> +			 */
> +			WARN_ON_ONCE(rcu_accelerate_cbs(rnp, rdp));
>  		} else if (!rcu_segcblist_completely_offloaded(&rdp->cblist)) {
>  			/*
>  			 * ...but NOCB kthreads may miss or delay callbacks acceleration
> @@ -2000,8 +2004,6 @@ rcu_report_qs_rdp(struct rcu_data *rdp)
>  		rcu_disable_urgency_upon_qs(rdp);
>  		rcu_report_qs_rnp(mask, rnp, rnp->gp_seq, flags);
>  		/* ^^^ Released rnp->lock */
> -		if (needwake)
> -			rcu_gp_kthread_wake();
>  
>  		if (needacc) {
>  			rcu_nocb_lock_irqsave(rdp, flags);
> -- 
> 2.25.1
> 
