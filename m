Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1F5B74A2D5
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 19:08:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232502AbjGFRIg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 13:08:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232480AbjGFRId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 13:08:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 330FC1BFC;
        Thu,  6 Jul 2023 10:08:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C60F060F64;
        Thu,  6 Jul 2023 17:08:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24E2EC433C8;
        Thu,  6 Jul 2023 17:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688663308;
        bh=BLriyU2lQdQ+9jLmtcnnU/JwBhc5ejNM5/UtXol14aI=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Oql36+giQ1DnHS9/DvZeYxbWptAdZctYcjpnhXtp2ULoVSNifM2Dvjo4OHE2rMBZi
         a2ayofrQXX1z1Wu24D5HbITvkO1lJUFVrcESdEy8QzFtRHrpPIShBMbDtCG4o75GaA
         6vpuOFhwbusmkh++dEqUJzNKrRfd5fmpCBCuXJeyWQE2Zi27NJI/xTS7uCwB7p+BGT
         R3FniIxECXHWjAVeTWoVvK7Czp+zZ9oY3mBQRKYAxntkRPtCpc8YKf970ltBPFcEgP
         wnuulv42lxCjq63fcXA1oAbrVDMCkk4Tb+RwODpskPvzDUfn+C5bRqnQz6mX/TY5fB
         YuzSmlmi6P73A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id AF8FFCE3A5C; Thu,  6 Jul 2023 10:08:27 -0700 (PDT)
Date:   Thu, 6 Jul 2023 10:08:27 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Zqiang <qiang.zhang1211@gmail.com>
Cc:     frederic@kernel.org, quic_neeraju@quicinc.com,
        joel@joelfernandes.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] srcu: Make srcu_might_be_idle() take early return if
 rcu_gp_is_normal() return true
Message-ID: <77d16cbb-b28c-4b13-aecb-9ad787559557@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230704082615.7415-1-qiang.zhang1211@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230704082615.7415-1-qiang.zhang1211@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 04, 2023 at 04:26:15PM +0800, Zqiang wrote:
> When invoke synchronize_srcu(), in the srcu_might_be_idle(), the current
> CPU's sdp->lock will be acquired to check whether there are pending
> callbacks in the sdp->srcu_cblist, if there are no pending callbacks,
> probabilistically probe global state to decide whether to convert to
> synchronize_srcu_expedited() call. however, for the rcupdate.rcu_normal=1
> kernels and after the rcu_set_runtime_mode() is called, invoke the
> rcu_gp_is_normal() is always return true, this mean that invoke the
> synchronize_srcu_expedited() always fall back to synchronize_srcu(),
> so there is no need to acquire sdp->lock to check sdp->srcu_cblist and
> probe global state in srcu_might_be_idle().
> 
> This commit therefore make srcu_might_be_idle() return immediately if the
> rcu_gp_is_normal() return true.
> 
> Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
> ---
>  kernel/rcu/srcutree.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> index 20d7a238d675..aea49cb60a45 100644
> --- a/kernel/rcu/srcutree.c
> +++ b/kernel/rcu/srcutree.c
> @@ -1172,6 +1172,8 @@ static bool srcu_might_be_idle(struct srcu_struct *ssp)
>  	unsigned long tlast;
>  
>  	check_init_srcu_struct(ssp);
> +	if (rcu_gp_is_normal())
> +		return false;

Again, thank you for looking into SRCU!

I am not at all enthusiastic about this one.  With this change, the name
srcu_might_be_idle() is no longer accurate.  Yes, the name could change,
but any name would be longer and more confusing.

So unless there is a measureable benefit to this one on a production
workload, I cannot justify taking it.

Is there a measureable benefit?

							Thanx, Paul

>  	/* If the local srcu_data structure has callbacks, not idle.  */
>  	sdp = raw_cpu_ptr(ssp->sda);
>  	spin_lock_irqsave_rcu_node(sdp, flags);
> -- 
> 2.17.1
> 
