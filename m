Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D806F729FE2
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 18:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241466AbjFIQRi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 12:17:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231964AbjFIQRh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 12:17:37 -0400
Received: from smtp.smtpout.orange.fr (smtp-14.smtpout.orange.fr [80.12.242.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2190B5
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 09:17:31 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id 7engq8ZMSV4eY7engq8iIM; Fri, 09 Jun 2023 18:17:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1686327444;
        bh=PB4fuyF0N+bwbxmHLmFFwIIYDx59WjSLbp5IAGZ7Me0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=OnGvM7AFlKojkEVatPTJq4/0tLPWGizuduEDMEotrmqRjV8gh7cmYb22mNDFB573x
         0lsa4cuWTjSIwzDjQldlEZ+5mF+610tJbA7JNhzgLF2jTTNGktphH2wDV0ICMsi5/n
         Q9KOgBfrJV+6IdyUUbletE51T+kOjD5rjjL+Na0QR519xMCKY6tZZ2Vt0X94yJFB9Z
         2B56N0sCTRMxInt95dSo1f72KaNXYZrvDNngkqf7/hyHNTC+SlW8D7J8yiEGvcoZol
         b2YL5Yv6KVl2xvUhi9Xt44o7wndPyJoeiznIr+7bRZNng9xr+SOGGvLECBIXfPIplT
         9TYK+U7xlOe1A==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 09 Jun 2023 18:17:24 +0200
X-ME-IP: 86.243.2.178
Message-ID: <f1d56fd3-6e1b-58fe-74bd-85d610e62a87@wanadoo.fr>
Date:   Fri, 9 Jun 2023 18:17:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: AW: [PATCH 2/2] tty: serial: samsung_tty: Fix a memory leak in
 s3c24xx_serial_getclk() when iterating clk
Content-Language: fr
To:     Walter Harms <wharms@bfs.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Thomas Abraham <thomas.abraham@linaro.org>,
        Kukjin Kim <kgene.kim@samsung.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
References: <e4359d5ef206f5b349c1d15a515a1205e78dda55.1686285892.git.christophe.jaillet@wanadoo.fr>
 <93bf8f574310256fcea50e5c5a62b5c37e20bb14.1686285892.git.christophe.jaillet@wanadoo.fr>
 <f31523d7270d4a1f82d96b7891ed13e6@bfs.de>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <f31523d7270d4a1f82d96b7891ed13e6@bfs.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 09/06/2023 à 10:57, Walter Harms a écrit :
> 
> while we are here ....
> 
> perhaps INT_MAX from kernel.h ?

from include/vdso/limits.h

> int   deviation = (1 << 30) - 1;

I don't know the initial intent for this value, but it is not the same 
as MAX_INT.

> 
> the part before looks a bit strange
> 
> if (ourport->info->has_divslot) {
>                          unsigned long div = rate / req_baud;
> 
>                          /* The UDIVSLOT register on the newer UARTs allows us to
>                           * get a divisor adjustment of 1/16th on the baud clock.
>                           *
>                           * We don't keep the UDIVSLOT value (the 16ths we
>                           * calculated by not multiplying the baud by 16) as it
>                           * is easy enough to recalculate.
>                           */
> 
>                          quot = div / 16;
>                          baud = rate / div;
> because
>     baud=rate/rate/req_baud = req_baud

In math yes. In integer computation, no.
	rate = 20000
	req_baud = 9600

	div = rate / req_baud 		==> 2
	baud = rate / div;		==> 20000 / 2 = 10000

	9600 <> 10000

I don't know if it is the intent, but it is the way it works.

And knowing that:
	calc_deviation = req_baud - baud;
I guess that it is the way it is expected to work.

With your reasoning, calc_deviation would be always 0.

> can this be simplyfied ? (or is the numeric required  ?)
> 
> 
> Homebrew abs()  kernel.h has a abs() can we use it here ?

include/linux/math.h

> 
>              if (calc_deviation < 0)
>                          calc_deviation = -calc_deviation;

Ok, why not.

> 
> to the patch:
> 
> +                       /*
> +                        * If we find a better clk, release the previous one, if
> +                        * any.
> +                        */
> +                       if (!IS_ERR(*best_clk))
> +                               clk_put(*best_clk);
> 
> the intentions are good. *best_clk is user supplied (and should be NULL)

??? Why should it be NULL?

There is only one caller, and the value id &clk, knowing that:
    struct clk *clk = ERR_PTR(-EINVAL);

The code could be changed to have an initial NULL value, but it would'nt 
bring that much added value, in my PoV.
It would only save a test which is just fine as-is.

> filled & released in the next round but IMHO must be valid (is clk).
> so no need to check. (ntl clk_put seems to handle NULL and ERR )
>     if (!clk || WARN_ON_ONCE(IS_ERR(clk)))
>                  return;

My point with "if (!IS_ERR(*best_clk))" is to handle the initial 
iteration when *best_clk is ERR_PTR(-EINVAL).
clk_put() can handle it, but it would WARN in the normal path, so it 
sounds strange to me.

CJ

> 
> JM2C
>   wh
> ________________________________________
> Von: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> Gesendet: Freitag, 9. Juni 2023 06:45:39
> An: Krzysztof Kozlowski; Alim Akhtar; Greg Kroah-Hartman; Jiri Slaby; Thomas Abraham; Kukjin Kim
> Cc: linux-kernel@vger.kernel.org; kernel-janitors@vger.kernel.org; Christophe JAILLET; linux-arm-kernel@lists.infradead.org; linux-samsung-soc@vger.kernel.org; linux-serial@vger.kernel.org
> Betreff: [PATCH 2/2] tty: serial: samsung_tty: Fix a memory leak in s3c24xx_serial_getclk() when iterating clk
> 
> When the best clk is searched, we iterate over all possible clk.
> 
> If we find a better match, the previous one, if any, needs to be freed.
> If a better match has already been found, we still need to free the new
> one, otherwise it leaks.
> 
> Fixes: 5f5a7a5578c5 ("serial: samsung: switch to clkdev based clock lookup")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> This patch is speculative. Review with care.
> 
> I think that some clk_put() are also missing somewhere else in the driver
> but won't be able to investigate further.
> ---
>   drivers/tty/serial/samsung_tty.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
> index dd751e7010e3..c07877dd25fa 100644
> --- a/drivers/tty/serial/samsung_tty.c
> +++ b/drivers/tty/serial/samsung_tty.c
> @@ -1488,10 +1488,18 @@ static unsigned int s3c24xx_serial_getclk(struct s3c24xx_uart_port *ourport,
>                          calc_deviation = -calc_deviation;
> 
>                  if (calc_deviation < deviation) {
> +                       /*
> +                        * If we find a better clk, release the previous one, if
> +                        * any.
> +                        */
> +                       if (!IS_ERR(*best_clk))
> +                               clk_put(*best_clk);
>                          *best_clk = clk;
>                          best_quot = quot;
>                          *clk_num = cnt;
>                          deviation = calc_deviation;
> +               } else {
> +                       clk_put(clk);
>                  }
>          }
> 
> --
> 2.34.1
> 
> 

