Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 948AE63CE7F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 05:55:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232902AbiK3Ez4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 23:55:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232432AbiK3Ezx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 23:55:53 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B89A2A952
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 20:55:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1BABDB81A20
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 04:55:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9DF7C433C1;
        Wed, 30 Nov 2022 04:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669784150;
        bh=daPHIaEHptqDmcDblMDn8/EoMgNWvo+d8jmNIXKhKd0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PL2zvx2YDqjotznYfAZappPMQryiVaJrJ1t0SfIH4EqY1zE5zTtej11IhOFSOW3Jy
         0J5+4d6xexSRrVqj8kHiUULIfNpJhWTYr7gSmHahzn9hwV+xG9xjoLWpzp0Hq3I7Rf
         uS36UKaTt9RThkSBgn6uLGH/Sjsupg3ZUXREOqgz95WQyr0SXLnDDf3/wjQ4JZkdc6
         9gEXSY81QAegMI/GomMgOfZAZtQoeKv0CBdHei4A3/0H/5dy0HyVcRZEuvsiRww8gJ
         mJ0G61tlaHK6owHSd35LOlAeVODlBFvvnkFnpD3GZhf2f9KZ2fukEakbMuGmICXU3h
         EZidm0s5ewqMA==
Date:   Tue, 29 Nov 2022 20:55:48 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org,
        Sultan Alsawaf <sultan@kerneltoast.com>
Subject: Re: [PATCH] random: align entropy_timer_state to cache line
Message-ID: <Y4biVHVPhVyVJ6Fc@sol.localdomain>
References: <20221130020815.283814-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221130020815.283814-1-Jason@zx2c4.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jason,

On Wed, Nov 30, 2022 at 03:08:15AM +0100, Jason A. Donenfeld wrote:
> The theory behind the jitter dance is that multiple things are poking at
> the same cache line. This only works, however, if those things are
> actually all in the same cache line. Ensure this is the case by aligning
> the struct on the stack to the cache line size.
> 
> On x86, this indeed aligns the stack struct:
> 
>  000000000000000c <try_to_generate_entropy>:
>  {
>     c:  55                      push   %rbp
> -   d:  53                      push   %rbx
> -   e:  48 83 ec 38             sub    $0x38,%rsp
> +   d:  48 89 e5                mov    %rsp,%rbp
> +  10:  41 54                   push   %r12
> +  12:  53                      push   %rbx
> +  13:  48 83 e4 c0             and    $0xffffffffffffffc0,%rsp
> +  17:  48 83 ec 40             sub    $0x40,%rsp
> 
> Cc: Sultan Alsawaf <sultan@kerneltoast.com>
> Fixes: 50ee7529ec45 ("random: try to actively add entropy rather than passively wait for it")
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
>  drivers/char/random.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/char/random.c b/drivers/char/random.c
> index 67558b95d531..2494e08c76d8 100644
> --- a/drivers/char/random.c
> +++ b/drivers/char/random.c
> @@ -1262,7 +1262,7 @@ static void __cold entropy_timer(struct timer_list *timer)
>  static void __cold try_to_generate_entropy(void)
>  {
>  	enum { NUM_TRIAL_SAMPLES = 8192, MAX_SAMPLES_PER_BIT = HZ / 15 };
> -	struct entropy_timer_state stack;
> +	struct entropy_timer_state stack ____cacheline_aligned;

Several years ago, there was a whole thing about how __attribute__((aligned)) to
more than 8 bytes doesn't actually work on stack variables in the kernel on x86,
because the kernel only keeps the stack 8-byte aligned but gcc assumes it is
16-byte aligned.  See
https://lore.kernel.org/linux-crypto/20170110143340.GA3787@gondor.apana.org.au/T/#t

IIRC, nothing was done about it at the time.

Has that been resolved in the intervening years?

- Eric
