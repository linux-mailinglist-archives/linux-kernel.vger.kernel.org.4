Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63FA35B9CAC
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 16:12:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbiIOOMA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 10:12:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbiIOOL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 10:11:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17F039C1FC;
        Thu, 15 Sep 2022 07:11:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 87E2EB820C8;
        Thu, 15 Sep 2022 14:11:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FB07C433C1;
        Thu, 15 Sep 2022 14:11:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663251114;
        bh=RYXH0B0lLGnuvQmKKR9zIdEDry6jbulxKb4gTP3wlKA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=XDBiWLJii8a45fug0nASjUFhsvIlix040ni/13UNK4Tq8UFYX0wP2f1nSsLMnvo5g
         WEpV5EIWwshn9n6UYCyInIfZiEjOe6z51e+wMW7tIjv+IfaAl/d1Q/SVBIXWs7RXtA
         sFx/IgKRCu+LycMsHQ7L7uOvs0TMuJVzICirovwnTIN9kQkWnmHro0xVm8sqFNuAjs
         BgcO9Nmb7oDIaWlxw9o50PCYvNSux40FraIM9ww7McezErpKOJWSwQWJRmm0N0JvXf
         PPidOCjMFtnE81xTlohNf1Zv0zf9yInmbzrGbT9wIeWq2sbdpFlafa7TNlCEDzql9d
         t04roYtogczRg==
Date:   Thu, 15 Sep 2022 15:11:54 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     cmo@melexis.com
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: temperature: mlx90614 Refactoring available filter
 attributes
Message-ID: <20220915151154.4e121c21@jic23-huawei>
In-Reply-To: <20220906112632.244453-1-cmo@melexis.com>
References: <20220906112632.244453-1-cmo@melexis.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
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

On Tue,  6 Sep 2022 13:26:32 +0200
cmo@melexis.com wrote:

> From: Crt Mori <cmo@melexis.com>
> 
> Change/refactor to the new way of defining available attribute values.
> 
> Signed-off-by: Crt Mori <cmo@melexis.com>

Applied.  thanks

> ---
>  drivers/iio/temperature/mlx90614.c | 41 ++++++++++++++++++++++--------
>  1 file changed, 30 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/iio/temperature/mlx90614.c b/drivers/iio/temperature/mlx90614.c
> index c253a5315988..3157416be912 100644
> --- a/drivers/iio/temperature/mlx90614.c
> +++ b/drivers/iio/temperature/mlx90614.c
> @@ -79,16 +79,15 @@ struct mlx90614_data {
>  
>  /* Bandwidth values for IIR filtering */
>  static const int mlx90614_iir_values[] = {77, 31, 20, 15, 723, 153, 110, 86};
> -static IIO_CONST_ATTR(in_temp_object_filter_low_pass_3db_frequency_available,
> -		      "0.15 0.20 0.31 0.77 0.86 1.10 1.53 7.23");
> -
> -static struct attribute *mlx90614_attributes[] = {
> -	&iio_const_attr_in_temp_object_filter_low_pass_3db_frequency_available.dev_attr.attr,
> -	NULL,
> -};
> -
> -static const struct attribute_group mlx90614_attr_group = {
> -	.attrs = mlx90614_attributes,
> +static const int mlx90614_freqs[][2] = {
> +	{0, 150000},
> +	{0, 200000},
> +	{0, 310000},
> +	{0, 770000},
> +	{0, 860000},
> +	{1, 100000},
> +	{1, 530000},
> +	{7, 230000}
>  };
>  
>  /*
> @@ -373,6 +372,22 @@ static int mlx90614_write_raw_get_fmt(struct iio_dev *indio_dev,
>  	}
>  }
>  
> +static int mlx90614_read_avail(struct iio_dev *indio_dev,
> +			       struct iio_chan_spec const *chan,
> +			       const int **vals, int *type, int *length,
> +			       long mask)
> +{
> +	switch (mask) {
> +	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
> +		*vals = (int *)mlx90614_freqs;
> +		*type = IIO_VAL_INT_PLUS_MICRO;
> +		*length = 2 * ARRAY_SIZE(mlx90614_freqs);
> +		return IIO_AVAIL_LIST;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
>  static const struct iio_chan_spec mlx90614_channels[] = {
>  	{
>  		.type = IIO_TEMP,
> @@ -389,6 +404,8 @@ static const struct iio_chan_spec mlx90614_channels[] = {
>  		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
>  		    BIT(IIO_CHAN_INFO_CALIBEMISSIVITY) |
>  			BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY),
> +		.info_mask_separate_available =
> +			BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY),
>  		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_OFFSET) |
>  		    BIT(IIO_CHAN_INFO_SCALE),
>  	},
> @@ -401,6 +418,8 @@ static const struct iio_chan_spec mlx90614_channels[] = {
>  		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
>  		    BIT(IIO_CHAN_INFO_CALIBEMISSIVITY) |
>  			BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY),
> +		.info_mask_separate_available =
> +			BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY),
>  		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_OFFSET) |
>  		    BIT(IIO_CHAN_INFO_SCALE),
>  	},
> @@ -410,7 +429,7 @@ static const struct iio_info mlx90614_info = {
>  	.read_raw = mlx90614_read_raw,
>  	.write_raw = mlx90614_write_raw,
>  	.write_raw_get_fmt = mlx90614_write_raw_get_fmt,
> -	.attrs = &mlx90614_attr_group,
> +	.read_avail = mlx90614_read_avail,
>  };
>  
>  #ifdef CONFIG_PM

