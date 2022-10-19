Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C20C760543C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 01:53:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbiJSXxK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 19:53:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbiJSXxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 19:53:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1C93176504;
        Wed, 19 Oct 2022 16:53:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A553FB82638;
        Wed, 19 Oct 2022 23:52:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55723C433D6;
        Wed, 19 Oct 2022 23:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666223578;
        bh=CzV1cLAhDDOFkB0KlXANuTK1iu8q0KT3QWKb3iYWOmg=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=jjmcy6A+3AvCsqGGEv4dekZoDw9xHCUs7yJMvfD24gT+APjGNj0yAz5Rvc1PgdHOM
         LKL7m25ugiyfzIVh0IZHHrJBQLJU2TtU7FMe+rkFBatDcAxyd5lk7SvOYPmBmfXzG8
         ASO8RZKiT0hkNZBZphJXcz/wvgcEN9MqrSdrV77+tQHrU3uepZKNMkeoQWAX+4zy4x
         NFLnH+CCSXBBbvstqGFMsNpirNTHsmE/NGm6drHtpju7ZKLLtkf6wMYerezvw0i5xB
         rbWKgQAyeMq7Cvr1dfqA9kaXT6IfqyGYLbMkVksF6hyRcSl3Qb0UnidnatrgIeP+C1
         MfhHwvm7XeIcQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id EA5155C06B4; Wed, 19 Oct 2022 16:52:57 -0700 (PDT)
Date:   Wed, 19 Oct 2022 16:52:57 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Zqiang <qiang1.zhang@intel.com>
Cc:     frederic@kernel.org, joel@joelfernandes.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] rcu: Make call_rcu() lazy only when CONFIG_RCU_LAZY
 is enabled
Message-ID: <20221019235257.GJ5600@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221019233835.395474-1-qiang1.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221019233835.395474-1-qiang1.zhang@intel.com>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 20, 2022 at 07:38:35AM +0800, Zqiang wrote:
> Currently, regardless of whether the CONFIG_RCU_LAZY is enabled,
> invoke the call_rcu() is always lazy, it also means that when
> CONFIG_RCU_LAZY is disabled, invoke the call_rcu_flush() is also
> lazy. therefore, this commit make call_rcu() lazy only when
> CONFIG_RCU_LAZY is enabled.
> 
> Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> ---
>  v1->v2: 
>  Use IS_ENABLED(CONFIG_RCU_LAZY) to the existing function of the same name.
> 
>  kernel/rcu/tree.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index abc615808b6e..ecf42b0d3726 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -2887,7 +2887,10 @@ EXPORT_SYMBOL_GPL(call_rcu_flush);
>   */
>  void call_rcu(struct rcu_head *head, rcu_callback_t func)
>  {
> -	return __call_rcu_common(head, func, true);
> +	if (IS_ENABLED(CONFIG_RCU_LAZY))
> +		return __call_rcu_common(head, func, true);
> +	else
> +		return __call_rcu_common(head, func, false);

This is much better, but why not something like this?

	return __call_rcu_common(head, func, IS_ENABLED(CONFIG_RCU_LAZY));

							Thanx, Paul

>  }
>  EXPORT_SYMBOL_GPL(call_rcu);
>  
> -- 
> 2.25.1
> 
