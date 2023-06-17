Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38BA0734355
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 21:31:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232009AbjFQTa6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 15:30:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230371AbjFQTa4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 15:30:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AB2F1BC9;
        Sat, 17 Jun 2023 12:30:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 06AEA610D5;
        Sat, 17 Jun 2023 19:30:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3865C433C8;
        Sat, 17 Jun 2023 19:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687030254;
        bh=IQMCDstm89WNOkAD3hUjv/AVyjJdT57ALdZ8S6Zh2/A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Oxqsugp1IEU5e2xW2B1VsUR+k5kRlIuqcalKE15Jc0zKaavZ0QaH7s+8CppB1+Ak7
         Q/eHKn4MeKtT4mE1gEbOJKMueEkbjwpXODbppYj3ABhOjlD3ul0m3bWELvCYlnZPSB
         uqxq9OsYLOh0Y7p8PKABwuDf27eQqf51JWFWhuLIoCOTHmlyKJgBqarxHK3oDDPqx7
         9j8fcwhM/hzhEuUP/nvaHpEMm36kvFypYW88PvQNh6s+FFfZWN2JRiqI15lu6pGjD2
         UKxGRpk1JfQZt2hKflq2ygqHjf/EPD/QXxKywwDe0IkXGTYsQKq1/lBNbCWRc21z3E
         yln+qFFHoCKTQ==
Date:   Sat, 17 Jun 2023 20:30:49 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] iio: light: bu27034: Fix scale format
Message-ID: <20230617203049.5e2d304a@jic23-huawei>
In-Reply-To: <5369117315cf05b88cf0ccb87373fd77190f6ca2.1686648422.git.mazziesaccount@gmail.com>
References: <cover.1686648422.git.mazziesaccount@gmail.com>
        <5369117315cf05b88cf0ccb87373fd77190f6ca2.1686648422.git.mazziesaccount@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Jun 2023 12:34:36 +0300
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> The driver is expecting accuracy of NANOs for intensity scale in
> raw_write. The IIO core is however defaulting to MICROs. This leads the
> raw-write of smallest scales to never succeed as correct selector(s) are
> not found.
> 
> Fix this by implementing the .write_raw_get_fmt callback to use NANO
> accuracy for writes of IIO_CHAN_INFO_SCALE.
> 
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> Fixes: e52afbd61039 ("iio: light: ROHM BU27034 Ambient Light Sensor")
Applied to the fixes-togreg branch of iio.git

Note however that the fixes-togreg branch has moved on to a 'post merge window'
state as the last lot of fixes are in char-misc-next (not char-misc-linus)
and hence targetting the merge window.

As such I will be holding these locally for a while as if I push them out
it will make a mess of the ordering of branches merged into linux-next

Jonathan

> ---
>  drivers/iio/light/rohm-bu27034.c | 22 +++++++++++++++++++---
>  1 file changed, 19 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/light/rohm-bu27034.c b/drivers/iio/light/rohm-bu27034.c
> index 846c3d43aa34..f737d62bdf92 100644
> --- a/drivers/iio/light/rohm-bu27034.c
> +++ b/drivers/iio/light/rohm-bu27034.c
> @@ -572,7 +572,7 @@ static int bu27034_set_scale(struct bu27034_data *data, int chan,
>  		return -EINVAL;
>  
>  	if (chan == BU27034_CHAN_ALS) {
> -		if (val == 0 && val2 == 1000)
> +		if (val == 0 && val2 == 1000000)
>  			return 0;
>  
>  		return -EINVAL;
> @@ -584,7 +584,7 @@ static int bu27034_set_scale(struct bu27034_data *data, int chan,
>  		goto unlock_out;
>  
>  	ret = iio_gts_find_gain_sel_for_scale_using_time(&data->gts, time_sel,
> -						val, val2 * 1000, &gain_sel);
> +						val, val2, &gain_sel);
>  	if (ret) {
>  		/*
>  		 * Could not support scale with given time. Need to change time.
> @@ -621,7 +621,7 @@ static int bu27034_set_scale(struct bu27034_data *data, int chan,
>  
>  			/* Can we provide requested scale with this time? */
>  			ret = iio_gts_find_gain_sel_for_scale_using_time(
> -				&data->gts, new_time_sel, val, val2 * 1000,
> +				&data->gts, new_time_sel, val, val2,
>  				&gain_sel);
>  			if (ret)
>  				continue;
> @@ -1213,6 +1213,21 @@ static int bu27034_read_raw(struct iio_dev *idev,
>  	}
>  }
>  
> +static int bu27034_write_raw_get_fmt(struct iio_dev *indio_dev,
> +				     struct iio_chan_spec const *chan,
> +				     long mask)
> +{
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SCALE:
> +		return IIO_VAL_INT_PLUS_NANO;
> +	case IIO_CHAN_INFO_INT_TIME:
> +		return IIO_VAL_INT_PLUS_MICRO;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
>  static int bu27034_write_raw(struct iio_dev *idev,
>  			     struct iio_chan_spec const *chan,
>  			     int val, int val2, long mask)
> @@ -1260,6 +1275,7 @@ static int bu27034_read_avail(struct iio_dev *idev,
>  static const struct iio_info bu27034_info = {
>  	.read_raw = &bu27034_read_raw,
>  	.write_raw = &bu27034_write_raw,
> +	.write_raw_get_fmt = &bu27034_write_raw_get_fmt,
>  	.read_avail = &bu27034_read_avail,
>  };
>  

