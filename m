Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4B5566DFD3
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 15:03:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbjAQODN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 09:03:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbjAQODJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 09:03:09 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE0F538B78;
        Tue, 17 Jan 2023 06:03:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5C143B8163C;
        Tue, 17 Jan 2023 14:03:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9463AC433D2;
        Tue, 17 Jan 2023 14:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673964185;
        bh=009ZkaKNNYtdbuuDx1qA9wZr22kzjPWN7yIb2q0DdEA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Dktz/WYJgv4QvyvDV2LbvZmxjtWZWLprYGVoku3jmdDH79C6Rr5ME968EUSWwVcih
         5aouenxh36cnXsIEEFum2DRiZ7fyRn287tGrUNutJWRRQ9eRLncilq/HkQXZU5sozk
         8LVH6IgiWeLZgkrL7aYIXc530jWklLqfNIt+Ic1JMHjSrXVsqoZ7oFOFwzvsYZ8Hb4
         w9nXQds86zFR3FsxlHzM0KN0ABftoBpbKaEfnsnLlY4dXA4e6Zt4junWySb0wHm9nL
         PPm5Gg7QZWrH9fxX7gsLBKdVJk/MWjV9FiUWvahoFRggZnIrjvjjyj5yJP5IzIB6dZ
         Ai7kQS9PV+BNA==
Date:   Tue, 17 Jan 2023 15:03:03 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Zqiang <qiang1.zhang@intel.com>
Cc:     paulmck@kernel.org, quic_neeraju@quicinc.com,
        joel@joelfernandes.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] rcu: Remove impossible wakeup rcu GP kthread action
 from rcu_report_qs_rdp()
Message-ID: <Y8aql+vHNcdth0T1@lothringen>
References: <20230117074443.1982347-1-qiang1.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230117074443.1982347-1-qiang1.zhang@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 17, 2023 at 03:44:43PM +0800, Zqiang wrote:
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
> index b2c204529478..c78d48482583 100644
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
> +			WARN_ON_ONCE(rcu_accelerate_cbs(rnp, rdp));

Please also add a comment explaining why we don't expect to have
to wake up the GP kthread.

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

Thanks!


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
