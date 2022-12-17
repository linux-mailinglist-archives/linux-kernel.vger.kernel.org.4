Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ECB764F6A0
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Dec 2022 02:03:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbiLQBDt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 20:03:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbiLQBDr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 20:03:47 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97B971A836;
        Fri, 16 Dec 2022 17:03:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3495462295;
        Sat, 17 Dec 2022 01:03:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 930ACC433D2;
        Sat, 17 Dec 2022 01:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671239025;
        bh=w9On+uZB4e7roiFnK6EGr6v5XURJWc3Mq8xBPv2QiR8=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=UaM0Gof9fRgjOLAAvXSs1di556bXuZDWTNPA+0WzaO4rcpT11h02RmcvXPtnwmYJS
         vo+flpgrU57bTQ72decuPSybDhxfXiUsT1UJUqGYTVzZgV787WUzXjZyE/aSJUX2dq
         seZ8vyDpAfwlsAoM4Jz8Yen+M+izlRi+j6GoDZrwKKHUofVidGFsXxPsMqUye+f+er
         1nyUAJffjNerIO9zZkMUnnTsOE+JjgfYAMOtWGBxeDnZ6ER4HQyqcxsJSpNfyTM8MM
         yfG5KVujWZGyi4moPVINT3gEAYCW2pZVQjsGiSfOMJgOnvMLawuKae8ynvi+ThaeMY
         zql35FDmc4HJw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 331B85C0A2D; Fri, 16 Dec 2022 17:03:45 -0800 (PST)
Date:   Fri, 16 Dec 2022 17:03:45 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Zqiang <qiang1.zhang@intel.com>
Cc:     frederic@kernel.org, quic_neeraju@quicinc.com,
        joel@joelfernandes.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu: Fix opposite might_sleep() check in
 rcu_blocking_is_gp()
Message-ID: <20221217010345.GF4001@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221215035755.2820163-1-qiang1.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221215035755.2820163-1-qiang1.zhang@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 15, 2022 at 11:57:55AM +0800, Zqiang wrote:
> Currently, if the system is in the RCU_SCHEDULER_INACTIVE state, invoke
> synchronize_rcu_*() will implies a grace period and return directly,
> so there is no sleep action due to waiting for a grace period to end,
> but this might_sleep() check is the opposite. therefore, this commit
> puts might_sleep() check in the correct palce.
> 
> Signed-off-by: Zqiang <qiang1.zhang@intel.com>

Queued for testing and review, thank you!

I was under the impression that might_sleep() did some lockdep-based
checking, but I am unable to find it.  If there really is such checking,
that would be a potential argument for leaving this code as it is.

But in the meantime, full speed ahead!  ;-)

						Thanx, Paul

> ---
>  kernel/rcu/tree.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index ee8a6a711719..65f3dd2fd3ae 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -3379,9 +3379,10 @@ void __init kfree_rcu_scheduler_running(void)
>   */
>  static int rcu_blocking_is_gp(void)
>  {
> -	if (rcu_scheduler_active != RCU_SCHEDULER_INACTIVE)
> +	if (rcu_scheduler_active != RCU_SCHEDULER_INACTIVE) {
> +		might_sleep();
>  		return false;
> -	might_sleep();  /* Check for RCU read-side critical section. */
> +	}
>  	return true;
>  }
>  
> -- 
> 2.25.1
> 
