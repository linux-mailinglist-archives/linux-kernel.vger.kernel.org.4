Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D88B5BBA30
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Sep 2022 21:58:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbiIQT6Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Sep 2022 15:58:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiIQT6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Sep 2022 15:58:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B10F2C67F;
        Sat, 17 Sep 2022 12:58:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D2010B80CC9;
        Sat, 17 Sep 2022 19:58:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B4D5C433D6;
        Sat, 17 Sep 2022 19:58:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663444690;
        bh=3vm2XB41ub78dBlNNb37rRU70W7xPM2xBMBgKKbUlNw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CfCkVFuQPXNGuaEbmLc5yUACzeeEu8F03wnO2jzUcQ6UWyex3xJhZKcWRceQvI2M5
         rtRafpGR8GYTtlMeyAWQUiO0i+NpBNCQN52c8SEiBvlnSR6IEocJ9D5eS7ybJC0qQU
         eubecWN2Xs2n6GjCgjvwJ194XGVcpAlTLVh7zEDdXTIzk12iupUvuM0QdrtZVs4526
         XaVUovMzczDbVKho2G1+JXJgz5nELHVljKOuM8ySAE/h0l3DpVdqDNYVUxVm1OStyL
         XiddZxPiWSKCpEEV+cW+T1g0xlABU865r0l/+V9ekvjdRxSR6QrLTr5JEDWigIP4cn
         m0Fn2J31m1LvQ==
Date:   Sat, 17 Sep 2022 21:58:07 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        rushikesh.s.kadam@intel.com, urezki@gmail.com,
        neeraj.iitr10@gmail.com, paulmck@kernel.org, rostedt@goodmis.org
Subject: Re: [PATCH rcu/next 3/3] rcu: Call trace_rcu_callback() also for
 bypass queuing (v2)
Message-ID: <20220917195807.GA39579@lothringen>
References: <20220917164200.511783-1-joel@joelfernandes.org>
 <20220917164200.511783-4-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220917164200.511783-4-joel@joelfernandes.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 17, 2022 at 04:42:00PM +0000, Joel Fernandes (Google) wrote:
> @@ -2809,17 +2825,15 @@ void call_rcu(struct rcu_head *head, rcu_callback_t func)
>  	}
>  
>  	check_cb_ovld(rdp);
> -	if (rcu_nocb_try_bypass(rdp, head, &was_alldone, flags))
> +
> +	if (rcu_nocb_try_bypass(rdp, head, &was_alldone, flags)) {
> +		__trace_rcu_callback(head, rdp);
>  		return; // Enqueued onto ->nocb_bypass, so just leave.
> +	}

I think the bypass enqueues should be treated differently. Either with extending
the current trace_rcu_callback/trace_rcu_kvfree_callback (might break tools) or
with creating a new trace_rcu_callback_bypass()/trace_rcu_kvfree_callback_bypass().

Those could later be paired with a trace_rcu_bypass_flush().

Thanks.


> +
>  	// If no-CBs CPU gets here, rcu_nocb_try_bypass() acquired ->nocb_lock.
>  	rcu_segcblist_enqueue(&rdp->cblist, head);
> -	if (__is_kvfree_rcu_offset((unsigned long)func))
> -		trace_rcu_kvfree_callback(rcu_state.name, head,
> -					 (unsigned long)func,
> -					 rcu_segcblist_n_cbs(&rdp->cblist));
> -	else
> -		trace_rcu_callback(rcu_state.name, head,
> -				   rcu_segcblist_n_cbs(&rdp->cblist));
> +	__trace_rcu_callback(head, rdp);
>  
>  	trace_rcu_segcb_stats(&rdp->cblist, TPS("SegCBQueued"));
>  
> -- 
> 2.37.3.968.ga6b4b080e4-goog
> 
