Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F9F566D560
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 05:33:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235236AbjAQEc6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 23:32:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235060AbjAQEcx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 23:32:53 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6532F2196F;
        Mon, 16 Jan 2023 20:32:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0E95AB80D9A;
        Tue, 17 Jan 2023 04:32:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4ECBC433EF;
        Tue, 17 Jan 2023 04:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673929969;
        bh=wv4vTWupspHSDjaQ/HXuU2c8mRlHtDUbV90EP+bLE4Y=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=luJtdmlfCNtdbs0AlHYhqPdIyGoW0C0RtePyOlx7rhtbo6HjyLIUbye6plQvEkoHk
         eH0HtSLdQRaKgFfAf0XI1qjADuBIKScpkXUKIRSjIqrnc1mJAXW+gIMxehjmRmqH0B
         PaG/P0KAUqHWAusnopkW60wQHAoPHNcySy5ZLuvbpiIfA+sePZT/Exm4zqj3M+RCE+
         tagQtpMEMNFPYfNQ5YrXQRkiX/vssSQZ3vIb9C2rafPDezSqME1Ej8oBNGJ2fx2hHg
         g/OK+krCl4FXnQefZdJyjbPJkaOEzxT36ZAzicNy4+B00MehXQvVdyPoH8XXNexCkz
         GrqZA9tQrqo+Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 494525C06D0; Mon, 16 Jan 2023 20:32:49 -0800 (PST)
Date:   Mon, 16 Jan 2023 20:32:49 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Zqiang <qiang1.zhang@intel.com>
Cc:     frederic@kernel.org, quic_neeraju@quicinc.com,
        joel@joelfernandes.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu: Remove impossible wakeup rcu GP kthread action from
 rcu_report_qs_rdp()
Message-ID: <20230117043249.GE2948950@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20230117021955.1967316-1-qiang1.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230117021955.1967316-1-qiang1.zhang@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 17, 2023 at 10:19:55AM +0800, Zqiang wrote:
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
> ---
>  kernel/rcu/tree.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index b2c204529478..477eb1a374e5 100644
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
> @@ -1988,7 +1987,7 @@ rcu_report_qs_rdp(struct rcu_data *rdp)
>  		 * NOCB kthreads have their own way to deal with that...
>  		 */
>  		if (!rcu_rdp_is_offloaded(rdp)) {
> -			needwake = rcu_accelerate_cbs(rnp, rdp);
> +			rcu_accelerate_cbs(rnp, rdp);

If it is impossible, we should use WARN_ON_ONCE() or similar.  Just
in case the system disagrees on the impossibility.  ;-)

							Thanx, Paul

>  		} else if (!rcu_segcblist_completely_offloaded(&rdp->cblist)) {
>  			/*
>  			 * ...but NOCB kthreads may miss or delay callbacks acceleration
> @@ -2000,8 +1999,6 @@ rcu_report_qs_rdp(struct rcu_data *rdp)
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
