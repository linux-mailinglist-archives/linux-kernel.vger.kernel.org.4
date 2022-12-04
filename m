Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45E8B641DA3
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Dec 2022 16:29:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbiLDP3N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Dec 2022 10:29:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbiLDP3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Dec 2022 10:29:10 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BD5614D27;
        Sun,  4 Dec 2022 07:29:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2692DB8075D;
        Sun,  4 Dec 2022 15:29:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6711EC433C1;
        Sun,  4 Dec 2022 15:29:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670167746;
        bh=+4UWp3q3T8/z7j3IT3NJBs3BVLIHV3S8FeXV9XhEXcg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=oCxNzFArpSesYBXlBvPnI1v6ofzIW7TJOoWYwzorGkcbMl1/PWRyNVFwKYwa5ckEb
         fXhm7wv8RaLGEMPVLKSN9JGB5NxriBFTybAX0AObXCpntkOKfJtytsN8S+hfD0ORub
         VhWRBNSflQdrqG03Wu9ixVtvnTAKg4BSqj5C2MwuIM/YwIFPu6WfKrzg9kEQucK1H/
         r5qNowpiz72CvvP6sdhIC9MWkwq4oWQLAGbIipryC6LZPFNGBciTxB9WmNKhtymdIP
         hTsYunpRuYpx3mJr5CJDph7bXxLrPhE4i6Jag9UtLQGK/3bJjIkTHTONttLP+WgGKB
         TSIYE48yNuilQ==
Date:   Sun, 4 Dec 2022 15:41:52 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     lars@metafoo.de, jiasheng@iscas.ac.cn, paul@crapouillou.net,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] iio:adc:twl6030: Enable measurements of VUSB, VBAT and
 others
Message-ID: <20221204154152.5f7948b9@jic23-huawei>
In-Reply-To: <20221201181635.3522962-1-andreas@kemnade.info>
References: <20221201181635.3522962-1-andreas@kemnade.info>
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

On Thu,  1 Dec 2022 19:16:35 +0100
Andreas Kemnade <andreas@kemnade.info> wrote:

> Some inputs need to be wired up to produce proper measurements,
> without this change only near zero values are reported.
> 
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>

Sounds like a fix to me.  If so, Fixes tag?

Anything in here we should be turning off again if the driver is removed 
or toggling on suspend? If not, other than the space below this looks fine to me.

Jonathan

> ---
>  drivers/iio/adc/twl6030-gpadc.c | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
> 
> diff --git a/drivers/iio/adc/twl6030-gpadc.c b/drivers/iio/adc/twl6030-gpadc.c
> index f53e8558b560c..40438e5b49702 100644
> --- a/drivers/iio/adc/twl6030-gpadc.c
> +++ b/drivers/iio/adc/twl6030-gpadc.c
> @@ -57,6 +57,18 @@
>  #define TWL6030_GPADCS				BIT(1)
>  #define TWL6030_GPADCR				BIT(0)
>  
> +#define USB_VBUS_CTRL_SET			0x04
> +#define USB_ID_CTRL_SET				0x06
> +
> +#define TWL6030_MISC1				0xE4
> +#define VBUS_MEAS				0x01
> +#define ID_MEAS					0x01
> +
> +#define VAC_MEAS                0x04
> +#define VBAT_MEAS               0x02
> +#define BB_MEAS                 0x01
> +
I'm always of the view one blank line is enough! I'll tidy this up whilst applying.
> +
>  /**
>   * struct twl6030_chnl_calib - channel calibration
>   * @gain:		slope coefficient for ideal curve
> @@ -927,6 +939,26 @@ static int twl6030_gpadc_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>  
> +	ret = twl_i2c_write_u8(TWL_MODULE_USB, VBUS_MEAS, USB_VBUS_CTRL_SET);
> +	if (ret < 0) {
> +		dev_err(dev, "failed to wire up inputs\n");
> +		return ret;
> +	}
> +
> +	ret = twl_i2c_write_u8(TWL_MODULE_USB, ID_MEAS, USB_ID_CTRL_SET);
> +	if (ret < 0) {
> +		dev_err(dev, "failed to wire up inputs\n");
> +		return ret;
> +	}
> +
> +	ret = twl_i2c_write_u8(TWL6030_MODULE_ID0,
> +				VBAT_MEAS | BB_MEAS | BB_MEAS,
> +				TWL6030_MISC1);
> +	if (ret < 0) {
> +		dev_err(dev, "failed to wire up inputs\n");
> +		return ret;
> +	}
> +
>  	indio_dev->name = DRIVER_NAME;
>  	indio_dev->info = &twl6030_gpadc_iio_info;
>  	indio_dev->modes = INDIO_DIRECT_MODE;

