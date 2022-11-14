Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B8A1628A22
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 21:10:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237510AbiKNUJz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 15:09:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237509AbiKNUJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 15:09:29 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0013C1B7A9;
        Mon, 14 Nov 2022 12:09:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 89C926144B;
        Mon, 14 Nov 2022 20:09:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A22D7C433D6;
        Mon, 14 Nov 2022 20:09:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668456567;
        bh=CG12EQqGhqcddZAaKvzY1RjvyFLqLPjqbkdgD9qGLHA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qgc1Yfx34GODBMR1J+DE3O48+t5FVIF7aPoVwTCdw7qwAZcfvuiLxFClpFBw/7qQ2
         0dOuh6wk0M445tCti6l8nlpPshPO5cJ5E+Bm0ltNcVAGLhF59SfjkkwGtnGZE/Q1r8
         mIoTrBIoUfILyApIcP1Yd/TQj9cDl62ZnzfnQ+7TllYxjIs9ziTt3IlToeVX+TrhjC
         z2dVVvmrbBhYpD7WNWQF2KzLwC8G7VXTNn9dsM3VRnpRqRThB6skpwby8/ED7x+eTO
         wis9svFl+wKpK9wCn7e+GtMrr33i1CGfktSVoCYQOLJOTBUg0ozRdIVwitMqlq5xLp
         0asyMBgGbpJEA==
Date:   Mon, 14 Nov 2022 20:21:43 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Billy Tsai <billy_tsai@aspeedtech.com>
Cc:     <lars@metafoo.de>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <joel@jms.id.au>,
        <andrew@aj.id.au>, <linmq006@gmail.com>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [v3 1/2] iio: adc: aspeed: Remove the trim valid dts property.
Message-ID: <20221114202143.6156b436@jic23-huawei>
In-Reply-To: <20221114025057.10843-1-billy_tsai@aspeedtech.com>
References: <20221114025057.10843-1-billy_tsai@aspeedtech.com>
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

On Mon, 14 Nov 2022 10:50:56 +0800
Billy Tsai <billy_tsai@aspeedtech.com> wrote:

> The dts property "aspeed,trim-data-valid" is currently used to determine
> whether to read trimming data from the OTP register. If this is set on
> a device without valid trimming data in the OTP the ADC will not function
> correctly. This patch drops the use of this property and instead uses the
> default (unprogrammed) OTP value of 0 to detect when a fallback value of
> 0x8 should be used rather then the value read from the OTP.
> 
> Fixes: d0a4c17b4073 ("iio: adc: aspeed: Get and set trimming data.")
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
Series applied to the fixes-togreg branch of iio.git and marked for stable.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/aspeed_adc.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iio/adc/aspeed_adc.c b/drivers/iio/adc/aspeed_adc.c
> index 9341e0e0eb55..998e8bcc06e1 100644
> --- a/drivers/iio/adc/aspeed_adc.c
> +++ b/drivers/iio/adc/aspeed_adc.c
> @@ -202,6 +202,8 @@ static int aspeed_adc_set_trim_data(struct iio_dev *indio_dev)
>  				((scu_otp) &
>  				 (data->model_data->trim_locate->field)) >>
>  				__ffs(data->model_data->trim_locate->field);
> +			if (!trimming_val)
> +				trimming_val = 0x8;
>  		}
>  		dev_dbg(data->dev,
>  			"trimming val = %d, offset = %08x, fields = %08x\n",
> @@ -563,12 +565,9 @@ static int aspeed_adc_probe(struct platform_device *pdev)
>  	if (ret)
>  		return ret;
>  
> -	if (of_find_property(data->dev->of_node, "aspeed,trim-data-valid",
> -			     NULL)) {
> -		ret = aspeed_adc_set_trim_data(indio_dev);
> -		if (ret)
> -			return ret;
> -	}
> +	ret = aspeed_adc_set_trim_data(indio_dev);
> +	if (ret)
> +		return ret;
>  
>  	if (of_find_property(data->dev->of_node, "aspeed,battery-sensing",
>  			     NULL)) {

