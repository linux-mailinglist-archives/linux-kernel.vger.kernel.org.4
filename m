Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E51D96EBFA0
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Apr 2023 14:56:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230234AbjDWM4B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Apr 2023 08:56:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbjDWMz7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Apr 2023 08:55:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E67B61BE3;
        Sun, 23 Apr 2023 05:55:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8228B60C4B;
        Sun, 23 Apr 2023 12:55:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C16C5C433EF;
        Sun, 23 Apr 2023 12:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682254547;
        bh=vECERGKuAmn9newtSGmUIvAUzdcRAPn4AFwRwOiit7k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=XZDuwovBqgmy94ScdpwoYaQiHX9AaFDEzngq8CSzSS1HLmAJRErMaTH2ChPpfLOLu
         BG7/ZnRAjC3RxNW42HUMb33Gwo7tFBeQSuYznBhu62MeUUKtBYfao+ljFqkfeh8xZl
         25WcV1crYFWxFOFavjktday+yFWDXHFhJvuSda/OYqhx8AX6LXe92/sCvvZ6n8AGQj
         nkFf2qINcZ1RM3AmudrhVA24tHk0QHOLKPGqIcwWG9EykLKNWHsa8RG6XLTTa6Ys42
         M54reAwQCKgxKEXdkmGI3sA5cheM06C/MsQwPOUErH0Hd5lxlm7y3onnTi6x3xGiub
         6XZlM57ODtsRQ==
Date:   Sun, 23 Apr 2023 14:11:24 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     Patrik =?UTF-8?B?RGFobHN0csO2bQ==?= <risca@dalakolonin.se>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] iio: adc: palmas: fix off by one bugs
Message-ID: <20230423141124.3d4dc91d@jic23-huawei>
In-Reply-To: <14fee94a-7db7-4371-b7d6-e94d86b9561e@kili.mountain>
References: <14fee94a-7db7-4371-b7d6-e94d86b9561e@kili.mountain>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Apr 2023 13:41:56 +0300
Dan Carpenter <dan.carpenter@linaro.org> wrote:

> Valid values for "adc_chan" are zero to (PALMAS_ADC_CH_MAX - 1).
> Smatch detects some buffer overflows caused by this:
> drivers/iio/adc/palmas_gpadc.c:721 palmas_gpadc_read_event_value() error: buffer overflow 'adc->thresholds' 16 <= 16
> drivers/iio/adc/palmas_gpadc.c:758 palmas_gpadc_write_event_value() error: buffer overflow 'adc->thresholds' 16 <= 16
> 
> The effect of this bug in other functions is more complicated but
> obviously we should fix all of them.
> 
> Fixes: a99544c6c883 ("iio: adc: palmas: add support for iio threshold events")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Looks good to me.  Slight shuffle at the moment will delay me applying this.

I'll wait for Linus to pick up Greg's pull request then rebase my fixes branch
on top of that.  Otherwise I make a mess of linux-next ordering and things might
blow up.

In meantime, Patrik, please take a look.

Jonathan

> ---
> ---
>  drivers/iio/adc/palmas_gpadc.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/adc/palmas_gpadc.c b/drivers/iio/adc/palmas_gpadc.c
> index c1c439215aeb..7dfc9c927a23 100644
> --- a/drivers/iio/adc/palmas_gpadc.c
> +++ b/drivers/iio/adc/palmas_gpadc.c
> @@ -547,7 +547,7 @@ static int palmas_gpadc_read_raw(struct iio_dev *indio_dev,
>  	int adc_chan = chan->channel;
>  	int ret = 0;
>  
> -	if (adc_chan > PALMAS_ADC_CH_MAX)
> +	if (adc_chan >= PALMAS_ADC_CH_MAX)
>  		return -EINVAL;
>  
>  	mutex_lock(&adc->lock);
> @@ -595,7 +595,7 @@ static int palmas_gpadc_read_event_config(struct iio_dev *indio_dev,
>  	int adc_chan = chan->channel;
>  	int ret = 0;
>  
> -	if (adc_chan > PALMAS_ADC_CH_MAX || type != IIO_EV_TYPE_THRESH)
> +	if (adc_chan >= PALMAS_ADC_CH_MAX || type != IIO_EV_TYPE_THRESH)
>  		return -EINVAL;
>  
>  	mutex_lock(&adc->lock);
> @@ -684,7 +684,7 @@ static int palmas_gpadc_write_event_config(struct iio_dev *indio_dev,
>  	int adc_chan = chan->channel;
>  	int ret;
>  
> -	if (adc_chan > PALMAS_ADC_CH_MAX || type != IIO_EV_TYPE_THRESH)
> +	if (adc_chan >= PALMAS_ADC_CH_MAX || type != IIO_EV_TYPE_THRESH)
>  		return -EINVAL;
>  
>  	mutex_lock(&adc->lock);
> @@ -710,7 +710,7 @@ static int palmas_gpadc_read_event_value(struct iio_dev *indio_dev,
>  	int adc_chan = chan->channel;
>  	int ret;
>  
> -	if (adc_chan > PALMAS_ADC_CH_MAX || type != IIO_EV_TYPE_THRESH)
> +	if (adc_chan >= PALMAS_ADC_CH_MAX || type != IIO_EV_TYPE_THRESH)
>  		return -EINVAL;
>  
>  	mutex_lock(&adc->lock);
> @@ -744,7 +744,7 @@ static int palmas_gpadc_write_event_value(struct iio_dev *indio_dev,
>  	int old;
>  	int ret;
>  
> -	if (adc_chan > PALMAS_ADC_CH_MAX || type != IIO_EV_TYPE_THRESH)
> +	if (adc_chan >= PALMAS_ADC_CH_MAX || type != IIO_EV_TYPE_THRESH)
>  		return -EINVAL;
>  
>  	mutex_lock(&adc->lock);

