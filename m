Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B89774A2C3
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 19:06:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232412AbjGFRGD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 13:06:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232257AbjGFRGC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 13:06:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C2A31BE1;
        Thu,  6 Jul 2023 10:06:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2711B60F64;
        Thu,  6 Jul 2023 17:06:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AE9BC433AD;
        Thu,  6 Jul 2023 17:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688663160;
        bh=nW2uMa3dM6Rbpdf1TtLn2cGbPwpI8W7PDo0lEnEFIxo=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=SWQafKJlJ7E/0yn9ufCoZvx/NoEBiYJHc61mdMpnnacnpDz07NaiCNlvi2k5srhYT
         W2mw2oixgaAUZFWxUUoqaA8k2HKhyPQPf6fcu0f/2pN04y6NzTBqcUdbO13M/GPQHk
         ytKt9+GLoN81PZe/8WLPclNtbZ1V1cm+2GMq4wTKLlOJTUr8q569oKNiYD5GOWApXj
         iA2kw+RxPy0Gvrq7zc4b4hxudYjjtcjHggPBVHTJqa8+ZDPxPWc7qtrpQ87CSzYDmW
         sG0Fwo6IAhNIWn0A1oXsclwNl15X2jzBUzJCxd1f+G69Ma4hPVEq6EbUgycUQN0eZ7
         71pvLdVnOTwJw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 16493CE3A5C; Thu,  6 Jul 2023 10:06:00 -0700 (PDT)
Date:   Thu, 6 Jul 2023 10:06:00 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Zqiang <qiang.zhang1211@gmail.com>
Cc:     frederic@kernel.org, quic_neeraju@quicinc.com,
        joel@joelfernandes.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] srcu: Priority check rcu_gp_is_expedited() in
 synchronize_srcu()
Message-ID: <2728d9db-d20d-4203-8152-f6bc7c089bbd@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230704070809.31951-1-qiang.zhang1211@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230704070809.31951-1-qiang.zhang1211@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 04, 2023 at 03:08:09PM +0800, Zqiang wrote:
> Since the atomic variable rcu_expedited_nesting is initialized to
> true, so the rcu_gp_is_expedited() is always return true during
> system startup until the rcu_end_inkernel_boot() is called. this
> means that without setting rcupdate.rcu_normal=1 and before the
> rcu_end_inkernel_boot() is executed, regardless of whether the
> return value of srcu_might_be_idle() is true, call synchronize_srcu()
> always fall back to synchronize_srcu_expedited(), so there is
> no need to checking srcu_might_be_idle() return value.
> 
> For the rcupdate.rcu_normal=0, rcupdate.rcu_normal_after_boot=0 and
> rcupdate.rcu_expedited=1 kernels, there is also no need to checking
> srcu_might_be_idle() return value.
> 
> This commit therefore priority check rcu_gp_is_expedited() return value
> in synchronize_srcu().
> 
> Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>

Thank you for taking the time to look into SRCU!

But are you seeing real performance issues that this addresses?

My guess is "no", given that this is nowhere near a fastpath, but I
figured that I should ask.

							Thanx, Paul

> ---
>  kernel/rcu/srcutree.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> index 20d7a238d675..a819f11d9b90 100644
> --- a/kernel/rcu/srcutree.c
> +++ b/kernel/rcu/srcutree.c
> @@ -1435,7 +1435,7 @@ EXPORT_SYMBOL_GPL(synchronize_srcu_expedited);
>   */
>  void synchronize_srcu(struct srcu_struct *ssp)
>  {
> -	if (srcu_might_be_idle(ssp) || rcu_gp_is_expedited())
> +	if (rcu_gp_is_expedited() || srcu_might_be_idle(ssp))
>  		synchronize_srcu_expedited(ssp);
>  	else
>  		__synchronize_srcu(ssp, true);
> -- 
> 2.17.1
> 
