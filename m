Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3665D70A2D8
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 00:36:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231563AbjESWg1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 18:36:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjESWgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 18:36:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D4171BD
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 15:36:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 37E7765AF3
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 22:36:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85AFEC433EF;
        Fri, 19 May 2023 22:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1684535783;
        bh=13ItZfCP8MHViSXswO3xyLCnVZA5On30GzWwaZ2N7Y4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=rHEm03DXcJdL7PktvKkr2JfOCBjU3KdqptRFDz3saO3dKHMW53SKZdJUFnJEhzy0Y
         4Icf2Js5DKZNX+Nr/1l3WnUK/7Dq7A6yOoh/Rfek6C9R6ZkBE1Tu8Y6d7W7N1dTlEC
         /+HKe3eQZZOyveL95eU7ddqBmpyJMtB/REwQ/CCg=
Date:   Fri, 19 May 2023 15:36:22 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix mult_frac() multiple argument evaluation bug
Message-Id: <20230519153622.f95f74819ecf467c5291de7d@linux-foundation.org>
In-Reply-To: <f522ad25-f899-4526-abc4-da35868b6a8b@p183>
References: <f522ad25-f899-4526-abc4-da35868b6a8b@p183>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 May 2023 23:24:54 +0300 Alexey Dobriyan <adobriyan@gmail.com> wrote:

> mult_frac() evaluates _all_ arguments multiple times in the body.
> 
> --- a/include/linux/math.h
> +++ b/include/linux/math.h
> @@ -118,17 +118,17 @@ __STRUCT_FRACT(s32)
>  __STRUCT_FRACT(u32)
>  #undef __STRUCT_FRACT
>  
> -/*
> - * Multiplies an integer by a fraction, while avoiding unnecessary
> - * overflow or loss of precision.
> - */
> -#define mult_frac(x, numer, denom)(			\
> -{							\
> -	typeof(x) quot = (x) / (denom);			\
> -	typeof(x) rem  = (x) % (denom);			\
> -	(quot * (numer)) + ((rem * (numer)) / (denom));	\
> -}							\
> -)
> +/* Calculate "x * n / d" without unnecessary overflow or loss of precision. */
> +#define mult_frac(x, n, d)	\
> +({				\
> +	typeof(x) x_ = (x);	\
> +	typeof(n) n_ = (n);	\
> +	typeof(d) d_ = (d);	\
> +				\
> +	typeof(x) q = x_ / d_;	\
> +	typeof(x) r = x_ % d_;	\
> +	q * n_ + r * n_ / d_;	\
> +})
>  

I like, but the compiler doesn't.  x86_64 allmodconfig, gcc-12.2.0.

In file included from ./include/linux/math64.h:6,
                 from ./include/linux/time.h:6,
                 from ./include/linux/ktime.h:24,
                 from ./include/linux/timer.h:6,
                 from drivers/target/target_core_iblock.c:16:
drivers/target/target_core_iblock.c: In function 'iblock_configure_device':
drivers/target/target_core_iblock.c:127:73: error: passing argument 1 of 'queue_max_hw_sectors' makes pointer from integer without a cast [-Werror=int-conversion]
  127 |         dev->dev_attrib.hw_max_sectors = mult_frac(queue_max_hw_sectors(q),
      |                                                                         ^
      |                                                                         |
      |                                                                         unsigned int
./include/linux/math.h:129:16: note: in definition of macro 'mult_frac'
  129 |         typeof(x) r = x_ % d_;  \
      |                ^
In file included from drivers/target/target_core_iblock.c:18:
./include/linux/blkdev.h:1112:77: note: expected 'const struct request_queue *' but argument is of type 'unsigned int'
 1112 | static inline unsigned int queue_max_hw_sectors(const struct request_queue *q)
      |                                                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~^
cc1: all warnings being treated as errors
make[3]: *** [scripts/Makefile.build:252: drivers/target/target_core_iblock.o] Error 1
make[3]: *** Waiting for unfinished jobs....
make[2]: *** [scripts/Makefile.build:494: drivers/target] Error 2
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [scripts/Makefile.build:494: drivers] Error 2
make: *** [Makefile:2026: .] Error 2

