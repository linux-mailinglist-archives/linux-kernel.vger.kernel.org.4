Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA59B633226
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 02:30:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232056AbiKVBaX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 20:30:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230152AbiKVBaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 20:30:21 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A626E8FB2C;
        Mon, 21 Nov 2022 17:30:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 428E761518;
        Tue, 22 Nov 2022 01:30:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92C8FC433D6;
        Tue, 22 Nov 2022 01:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669080619;
        bh=jUZcCkMSTRNtZdyFv5KfYCxYq1zoggq+MPCMZ2FS/bY=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Al+YBoEE7BD/NlQ5fesXawqAmkuoHypdBfvdACapsCKBFWSi6poXcgxdE29vQ7cWx
         Psi/uSBoorr0nZjRPIKSea44HfvMuAdprk2bu9/mT2aKMvgPeHuDGDwcbfcqrLizrp
         Ag5wtmuwp2J//KK8XsUoGZbQeweY9sC8C5SiR+NRZKpRqyDiUiqy54433gRf7f6amO
         2cqbuQ8Q0YZb+Q9uj6ZldPXZ6huf5MQqnQZP2OwlZq63jk14w4c8UOnAgeLrKZyA11
         MMdQH0V5UG/ZnmH81C3yZcdDW8CbceIL/64N6jvYa3yIxJvEN8OGZ11r7K7ZedBhL/
         WUMECzyI08t8A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 242895C0641; Mon, 21 Nov 2022 17:30:19 -0800 (PST)
Date:   Mon, 21 Nov 2022 17:30:19 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Zqiang <qiang1.zhang@intel.com>
Cc:     frederic@kernel.org, joel@joelfernandes.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu-tasks: Use accurate runstart time for RCU Tasks
 boot-time testing
Message-ID: <20221122013019.GW4001@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221121150150.319715-1-qiang1.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221121150150.319715-1-qiang1.zhang@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 21, 2022 at 11:01:50PM +0800, Zqiang wrote:
> Currently, only get jiffies once as the runstart time for all RCU
> Tasks testing. it's not accurate, for each RCU Tasks type test, since
> corresponding type of synchronize_rcu_tasks*() be invoked, so before
> each RCU Tasks test starts, we need to wait for the grace period of
> the previous RCU Tasks test to end, there will be a deviation in the
> start time of the RCU Tasks test.
> 
> Therefore, this commit at the start of each RCU Tasks test, re-fetch the
> jiffies time as the runstart time.
> 
> Signed-off-by: Zqiang <qiang1.zhang@intel.com>

Good catch!  Applied with the usual wordsmithing, so please do check.

							Thanx, Paul

> ---
>  kernel/rcu/tasks.h | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> index b0b885e071fa..4a991311be9b 100644
> --- a/kernel/rcu/tasks.h
> +++ b/kernel/rcu/tasks.h
> @@ -1813,23 +1813,21 @@ static void test_rcu_tasks_callback(struct rcu_head *rhp)
>  
>  static void rcu_tasks_initiate_self_tests(void)
>  {
> -	unsigned long j = jiffies;
> -
>  	pr_info("Running RCU-tasks wait API self tests\n");
>  #ifdef CONFIG_TASKS_RCU
> -	tests[0].runstart = j;
> +	tests[0].runstart = jiffies;
>  	synchronize_rcu_tasks();
>  	call_rcu_tasks(&tests[0].rh, test_rcu_tasks_callback);
>  #endif
>  
>  #ifdef CONFIG_TASKS_RUDE_RCU
> -	tests[1].runstart = j;
> +	tests[1].runstart = jiffies;
>  	synchronize_rcu_tasks_rude();
>  	call_rcu_tasks_rude(&tests[1].rh, test_rcu_tasks_callback);
>  #endif
>  
>  #ifdef CONFIG_TASKS_TRACE_RCU
> -	tests[2].runstart = j;
> +	tests[2].runstart = jiffies;
>  	synchronize_rcu_tasks_trace();
>  	call_rcu_tasks_trace(&tests[2].rh, test_rcu_tasks_callback);
>  #endif
> -- 
> 2.25.1
> 
