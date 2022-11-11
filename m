Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6F80625495
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 08:47:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231615AbiKKHrB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 02:47:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbiKKHq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 02:46:59 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0CF1748E1;
        Thu, 10 Nov 2022 23:46:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3608F61EBF;
        Fri, 11 Nov 2022 07:46:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EFCFC433D6;
        Fri, 11 Nov 2022 07:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668152817;
        bh=vv62wWwduqinrCtZbQZIaSqRP/SZaLuyOTjLzL5M2II=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=jUljLXKbTkBM1clnDanu46i0KM2d1foJBR6/TP/rfUQrkVzilDLS1L3siifcm+wxA
         y0sxUEcus6M0Wdrk4/dUCYeyfYY+5PFOaKmVSz3K6ySWVkjSypYrW+PK9WsuoxpQUZ
         NjrYuePXAi/mVkUyhaHAbVS+fyvEYGzk+N45gXinaX9lKafBxLbnFpQnre8tGz6Izo
         +AlvrWCkI4NZhIhUkLNLToQRk+Krq331WnrdxrSD+Y8pDbDVwc235rWURLudsVyF0g
         s3noIW7AwWbgtvozfegpTSgzfi+r3qlh28W7STwc3o7wRH1l543RCTAAI0D4FJryIr
         fxcQ3zIPp1p9w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 165005C13DC; Thu, 10 Nov 2022 23:46:56 -0800 (PST)
Date:   Thu, 10 Nov 2022 23:46:56 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Zqiang <qiang1.zhang@intel.com>
Cc:     frederic@kernel.org, joel@joelfernandes.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] srcu: Release early_srcu resources when no longer in use
Message-ID: <20221111074656.GT725751@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221110073013.1302564-1-qiang1.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221110073013.1302564-1-qiang1.zhang@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 10, 2022 at 03:30:13PM +0800, Zqiang wrote:
> When the "rcupdate.rcu_self_test = 1" is set in bootargs and CONFIG_SRCU
> option is enabled, the early_srcu will be tested, currently, for TREE SRCU,
> if "srcutree.convert_to_big = 1" is set, the srcu_node structure will be
> allocated at invoke init_srcu_struct_fields() time, after the test is
> completed, the early_srcu will not be used.
> Therefore, this commit invoke cleanup_srcu_struct() to release srcu_node
> structure.
> 
> Signed-off-by: Zqiang <qiang1.zhang@intel.com>

Queued for further review and testing, thank you!

Also with the usual wordsmithing, so please check.

							Thanx, Paul

> ---
>  kernel/rcu/update.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
> index 738842c4886b..a05e23648c6b 100644
> --- a/kernel/rcu/update.c
> +++ b/kernel/rcu/update.c
> @@ -589,6 +589,7 @@ static int rcu_verify_early_boot_tests(void)
>  			early_boot_test_counter++;
>  			srcu_barrier(&early_srcu);
>  			WARN_ON_ONCE(!poll_state_synchronize_srcu(&early_srcu, early_srcu_cookie));
> +			cleanup_srcu_struct(&early_srcu);
>  		}
>  	}
>  	if (rcu_self_test_counter != early_boot_test_counter) {
> -- 
> 2.25.1
> 
