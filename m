Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19E2A636B53
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 21:39:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236775AbiKWUjJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 15:39:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240115AbiKWUhh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 15:37:37 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E55CEDBB;
        Wed, 23 Nov 2022 12:36:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5CF1EB8247F;
        Wed, 23 Nov 2022 20:36:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19E41C433C1;
        Wed, 23 Nov 2022 20:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669235758;
        bh=csngaTp+NrqsU6/cicHN8vYzPPuMHHibb61Uw1t3Cig=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=iYZbEEf+wDHc1MNJagehBOkLLLXnNUlk28ITL0QylEr9ibOlcUoAeLkIp9M4RE0sw
         8tERSCXXaI7xs5wluvE8YdCN/S6TpcFHF5khwxFsRNs9A11erQI5zqoGuvZ3Wpr2ks
         1akFitNxniY9OWbLs6yWmb0p0pxv9hd73nHxgWrJ0Aqbthr2JaSxLUoOT+zTiYvn+l
         +Ive6iFPvRCjEju4txAfxfFttfDptJBiEe8V9riRPP/8Nf5ynEiobWJ41m+pzfqKAm
         UExXKyVncJ9+ziS2AIQcKfU5w0m9UHAqGRkquSLC1F3A8AV+A4DfCWZrQw6yyLkxti
         OjlHlerNQlkfA==
Date:   Wed, 23 Nov 2022 20:48:32 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drivers: iio: dac: ad5592r: add gpio_chip names
Message-ID: <20221123204832.3e514378@jic23-huawei>
In-Reply-To: <20221117090130.51702-1-antoniu.miclaus@analog.com>
References: <20221117090130.51702-1-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Nov 2022 11:01:30 +0200
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> Add array of explicit gpio names for the `gpiochip` structure of
> ad5592r, mainly for debug purposes.
Can you give an example of when this is more useful than the offset?
(which I'm assuming is also available when debugging?)

Jonathan

> 
> Since the gpios are configurable via the dts, generic names are
> used.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
>  drivers/iio/dac/ad5592r-base.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/iio/dac/ad5592r-base.c b/drivers/iio/dac/ad5592r-base.c
> index 7a9b5fc1e579..076bc9ecfb49 100644
> --- a/drivers/iio/dac/ad5592r-base.c
> +++ b/drivers/iio/dac/ad5592r-base.c
> @@ -124,6 +124,10 @@ static int ad5592r_gpio_request(struct gpio_chip *chip, unsigned offset)
>  	return 0;
>  }
>  
> +static const char * const ad5592r_gpio_names[] = {
> +	"GPIO0", "GPIO1", "GPIO2", "GPIO3", "GPIO4", "GPIO5", "GPIO6", "GPIO7",
> +};
> +
>  static int ad5592r_gpio_init(struct ad5592r_state *st)
>  {
>  	if (!st->gpio_map)
> @@ -140,6 +144,7 @@ static int ad5592r_gpio_init(struct ad5592r_state *st)
>  	st->gpiochip.set = ad5592r_gpio_set;
>  	st->gpiochip.request = ad5592r_gpio_request;
>  	st->gpiochip.owner = THIS_MODULE;
> +	st->gpiochip.names = ad5592r_gpio_names;
>  
>  	mutex_init(&st->gpio_lock);
>  

