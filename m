Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69CAC61E2B8
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 15:50:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbiKFOuG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 09:50:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbiKFOuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 09:50:04 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00DC9E99;
        Sun,  6 Nov 2022 06:50:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A02D7B80B87;
        Sun,  6 Nov 2022 14:50:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C498C433C1;
        Sun,  6 Nov 2022 14:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667746200;
        bh=2/Oq4fxqMnhCc+bd62Y6vkjiu/snPGpLW2GdYhAJ9HU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fpWE9GoPqgrBzQAb4xjS4heDU/dsZ/tb4Y/CLLkxeGtErwgiuNOxgN9V+oXU3pXCC
         T8k6EaBqF/0CDMbv9o41CJARmcb0/crudR0amV23awx5EgcMJIIfzos1UerGsssueC
         vXvcl7qYQiBMs25bSzytt7B42BGIxJ+Pkzf2zjnG1NywY37oKYh065nq0httUG3kzR
         pJMfyLr6S7KGe2N0m6goNmdAbPlhodCnNX6HaGKVwjaSvqTRtJvQGasOyUVnHWzDJ/
         9LM5bejQ31Mnvc85KiO3j7bLget74NesW47z4YjApltZhYxnCe86fd55/uuQr5lpQ8
         jRtMSaCTWCyyw==
Date:   Sun, 6 Nov 2022 14:49:49 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Billy Tsai <billy_tsai@aspeedtech.com>
Cc:     <lars@metafoo.de>, <robh+dt@kernel.org>, <joel@jms.id.au>,
        <andrew@aj.id.au>, <colin.king@canonical.com>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        <BMC-SW@aspeedtech.com>
Subject: Re: [PATCH 1/2] iio: adc: aspeed: Remove the trim valid dts
 property.
Message-ID: <20221106144949.61731d8e@jic23-huawei>
In-Reply-To: <20221031113208.19194-1-billy_tsai@aspeedtech.com>
References: <20221031113208.19194-1-billy_tsai@aspeedtech.com>
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

On Mon, 31 Oct 2022 19:32:07 +0800
Billy Tsai <billy_tsai@aspeedtech.com> wrote:

> The dts property "aspeed,trim-data-valid" is used to determin whether to
> read the OTP register. If the image with the aspeed,trim-data-vali
> install to the chip without valid trimming data the adc controller will
> become confused. This patch use the default otp value 0 as a criterion
> for determining whether trimming data is valid instead of the dts
> property. The chip with actually trimming value is 0 should be filter out.

Hi Billy,

I'm not sure I correctly follow the patch description.  Would the following
be an accurate description?

The dts property "aspeed,trim-data-valid" is currently used to determine
whether to read trimming data from the OTP register. If this is set on
a device without valid trimming data in the OTP the ADC will not function
correctly. This patch drops he use of this property and instead uses the
default (unprogrammed) OTP value of 0 to detect when a fallback value of
0x8 should be used rather then the value read from the OTP.

Also, is this a bug fix we need to backport?  If so please provide a fixes
tag.

Thanks,

Jonathan

> 
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
> ---
>  drivers/iio/adc/aspeed_adc.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iio/adc/aspeed_adc.c b/drivers/iio/adc/aspeed_adc.c
> index ffae64f39221..0f065f0bb8e7 100644
> --- a/drivers/iio/adc/aspeed_adc.c
> +++ b/drivers/iio/adc/aspeed_adc.c
> @@ -201,6 +201,8 @@ static int aspeed_adc_set_trim_data(struct iio_dev *indio_dev)
>  				((scu_otp) &
>  				 (data->model_data->trim_locate->field)) >>
>  				__ffs(data->model_data->trim_locate->field);
> +			if (!trimming_val)
> +				trimming_val = 0x8;
>  		}
>  		dev_dbg(data->dev,
>  			"trimming val = %d, offset = %08x, fields = %08x\n",
> @@ -562,12 +564,9 @@ static int aspeed_adc_probe(struct platform_device *pdev)
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

