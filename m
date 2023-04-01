Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C71416D3149
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 16:27:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbjDAO1T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Apr 2023 10:27:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjDAO1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Apr 2023 10:27:16 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4725BB760;
        Sat,  1 Apr 2023 07:27:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 83195CE30E8;
        Sat,  1 Apr 2023 14:27:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 675CDC4339B;
        Sat,  1 Apr 2023 14:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680359231;
        bh=W7F17oBW/ltv6imOjiYKBF/4ZuAGoS6HNZVgbX5Fup8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=TR+ciGCHzOx9LczvIpmiosrIVLCwoyJh5KzWPwmuA7h972Tov49HTpwHH5lhhpezR
         WlW35Fkjo8TAx3opX6Fl85h2WYKNnIZ5KK0CIyNk1gN6pRvYhQci/sqig5o6CyY1sa
         nbgZlbUU4CeZwdLEwg0KjV2fUCazpblVq35LepFz3y5eJXsb/0hlEq3q2fyx1EXCLF
         +fsCGhIZicLv19CusvJmFCgAqVsA/N1KTLDHOg35xoAj0sC34zzzWXsrOiWj1JFEyP
         kwgLNF8ozZ6KtDECKhg+Agw1NjEhXusw0EUkjmJtWf9QH5787rwVpUllz4t7t7Jheo
         +2uf2wOt2xAeA==
Date:   Sat, 1 Apr 2023 15:42:20 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alisa Roman <alisa.roman@analog.com>,
        Fabrizio Lamarque <fl.scratchpad@gmail.com>
Subject: Re: [PATCH] iio: adc: ad7192: Change "shorted" channels to
 differential
Message-ID: <20230401154220.755e52cb@jic23-huawei>
In-Reply-To: <20230330102100.17590-1-paul@crapouillou.net>
References: <20230330102100.17590-1-paul@crapouillou.net>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Mar 2023 12:21:00 +0200
Paul Cercueil <paul@crapouillou.net> wrote:

> The AD7192 provides a specific channel configuration where both negative
> and positive inputs are connected to AIN2. This was represented in the
> ad7192 driver as a IIO channel with .channel = 2 and .extended_name set
> to "shorted".
> 
> The problem with this approach, is that the driver provided two IIO
> channels with the identifier .channel = 2; one "shorted" and the other
> not. This goes against the IIO ABI, as a channel identifier should be
> unique.
> 
> Address this issue by changing "shorted" channels to being differential
> instead, with channel 2 vs. itself, as we're actually measuring AIN2 vs.
> itself.
> 
> Note that the fix tag is for the commit that moved the driver out of
> staging. The bug existed before that, but backporting would become very
> complex further down and unlikely to happen.
> 
> Fixes: b581f748cce0 ("staging: iio: adc: ad7192: move out of staging")
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> Co-developed-by: Alisa Roman <alisa.roman@analog.com>
> Signed-off-by: Alisa Roman <alisa.roman@analog.com>

+CC Fabrizio who has a fix series under review for the same driver.

I'm going to let this one sit on the list for a little while.
It is a breaking ABI change (that hopefully no one will notice - given
the first fix from Fabrizio shows the driver crashes on probe currently we
should be safe on that).

Arguably just changing the index would also have been an ABI change, but
that would have gotten past any code that didn't take much notice of the
channel index whereas this won't.

Anyhow, will give it a little while for comments then pick this up
on top of Fabrizio's fixes series.  Give me a poke in 2-3 weeks if I
seem to have lost it.

Jonathan


> ---
>  drivers/iio/adc/ad7192.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
> index 55a6ab591016..99bb604b78c8 100644
> --- a/drivers/iio/adc/ad7192.c
> +++ b/drivers/iio/adc/ad7192.c
> @@ -897,10 +897,6 @@ static const struct iio_info ad7195_info = {
>  	__AD719x_CHANNEL(_si, _channel1, -1, _address, NULL, IIO_VOLTAGE, \
>  		BIT(IIO_CHAN_INFO_SCALE), ad7192_calibsys_ext_info)
>  
> -#define AD719x_SHORTED_CHANNEL(_si, _channel1, _address) \
> -	__AD719x_CHANNEL(_si, _channel1, -1, _address, "shorted", IIO_VOLTAGE, \
> -		BIT(IIO_CHAN_INFO_SCALE), ad7192_calibsys_ext_info)
> -
>  #define AD719x_TEMP_CHANNEL(_si, _address) \
>  	__AD719x_CHANNEL(_si, 0, -1, _address, NULL, IIO_TEMP, 0, NULL)
>  
> @@ -908,7 +904,7 @@ static const struct iio_chan_spec ad7192_channels[] = {
>  	AD719x_DIFF_CHANNEL(0, 1, 2, AD7192_CH_AIN1P_AIN2M),
>  	AD719x_DIFF_CHANNEL(1, 3, 4, AD7192_CH_AIN3P_AIN4M),
>  	AD719x_TEMP_CHANNEL(2, AD7192_CH_TEMP),
> -	AD719x_SHORTED_CHANNEL(3, 2, AD7192_CH_AIN2P_AIN2M),
> +	AD719x_DIFF_CHANNEL(3, 2, 2, AD7192_CH_AIN2P_AIN2M),
>  	AD719x_CHANNEL(4, 1, AD7192_CH_AIN1),
>  	AD719x_CHANNEL(5, 2, AD7192_CH_AIN2),
>  	AD719x_CHANNEL(6, 3, AD7192_CH_AIN3),
> @@ -922,7 +918,7 @@ static const struct iio_chan_spec ad7193_channels[] = {
>  	AD719x_DIFF_CHANNEL(2, 5, 6, AD7193_CH_AIN5P_AIN6M),
>  	AD719x_DIFF_CHANNEL(3, 7, 8, AD7193_CH_AIN7P_AIN8M),
>  	AD719x_TEMP_CHANNEL(4, AD7193_CH_TEMP),
> -	AD719x_SHORTED_CHANNEL(5, 2, AD7193_CH_AIN2P_AIN2M),
> +	AD719x_DIFF_CHANNEL(5, 2, 2, AD7193_CH_AIN2P_AIN2M),
>  	AD719x_CHANNEL(6, 1, AD7193_CH_AIN1),
>  	AD719x_CHANNEL(7, 2, AD7193_CH_AIN2),
>  	AD719x_CHANNEL(8, 3, AD7193_CH_AIN3),

