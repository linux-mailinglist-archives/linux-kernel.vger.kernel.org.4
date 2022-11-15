Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AD4B6297EA
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 13:02:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230473AbiKOMCp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 07:02:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbiKOMCn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 07:02:43 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D2DBD58
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 04:02:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BC6AE616E6
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 12:02:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D1DDC433C1;
        Tue, 15 Nov 2022 12:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668513762;
        bh=2LYQnIPvG6RuLuf9gDjL3wiE71esLq3vQpTI1+ELwPs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L6bhtbHYUsQKq/vY/LqcUKtttI50CMT23911KDXF9tridMaXkLVjw9+JUXwmAIzAa
         MI30sJZM1w76+RQ+psCKRfrbG+cbSK4HhkClsUlq/6ZYU+YH5P9SGKtmJny2QKcZr+
         UFNVBZ6l4zvCP5n5NOiM7J/Br8y2ep7T7b7mwmAYgzS39ddTvOPldRO+WUHPUwjHq7
         +vwQu+WvseNnJaZ6J+XEeSZPw7tlRz5TG0zKwjj02e9sz3cXKynUBb3rpoVHShGfdn
         m/sfA8F5PauSCn2vYniMywgLfSIHwhG3pqrr8Vykhw1WClQBJObRnp4rSuuR/HpKak
         LUnxVDDO0XIeg==
Date:   Tue, 15 Nov 2022 13:02:39 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Yun Zhou <yun.zhou@windriver.com>
Cc:     jstultz@google.com, tglx@linutronix.de, sboyd@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] timers: fix LVL_START macro
Message-ID: <20221115120239.GA721394@lothringen>
References: <20221115025614.79537-1-yun.zhou@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221115025614.79537-1-yun.zhou@windriver.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yun Zhou,

On Tue, Nov 15, 2022 at 10:56:14AM +0800, Yun Zhou wrote:
> The number of buckets per level should be LVL_SIZE, not LVL_SIZE-1.
> 
> Signed-off-by: Yun Zhou <yun.zhou@windriver.com>
> ---
>  kernel/time/timer.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/time/timer.c b/kernel/time/timer.c
> index 717fcb9fb14a..1116b208093e 100644
> --- a/kernel/time/timer.c
> +++ b/kernel/time/timer.c
> @@ -161,7 +161,7 @@ EXPORT_SYMBOL(jiffies_64);
>   * time. We start from the last possible delta of the previous level
>   * so that we can later add an extra LVL_GRAN(n) to n (see calc_index()).
>   */
> -#define LVL_START(n)	((LVL_SIZE - 1) << (((n) - 1) * LVL_CLK_SHIFT))
> +#define LVL_START(n)	(LVL_SIZE << (((n) - 1) * LVL_CLK_SHIFT))

See the comment above:

   "We start from the last possible delta of the previous level
    so that we can later add an extra LVL_GRAN(n) to n (see calc_index())."

Thanks.

>  
>  /* Size of each clock level */
>  #define LVL_BITS	6
> -- 
> 2.35.2
> 
