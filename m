Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48D9F649461
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Dec 2022 14:13:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbiLKNNX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Dec 2022 08:13:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbiLKNNV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Dec 2022 08:13:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFA65A194;
        Sun, 11 Dec 2022 05:13:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 44058B80AC6;
        Sun, 11 Dec 2022 13:13:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7B0FC433D2;
        Sun, 11 Dec 2022 13:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670764396;
        bh=S4HS9lp0u5jUl5N2a6hCMvc/CwN3DsY0N2OH614zOoQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=I2NfcdLlw+vADc0TuShPmdp8R3d9sH84IZOV5IZV4Y/TVorpu2LueFtSHJBOfgvw0
         8qEEFCONMenEHj+tMPF6qdFIzyfoVoDtmtTdDB+b2hIVuKUq2shyik2pK40xCfC/Zv
         pu5lhXM1F3rqNGZjOWtlv1iqTnkXNpke5W/Emxxr3DAS7U0cXq/MHeT8xxVFDM6n9c
         9R93K4CZrKP6pbMSIu9/DvxyDnKGur8CTxcfHVAG49E3a0BxCKYJwUAzHWyurYit2f
         UpDinex3p+nGO0W76SUAnvQSLWr6wd/an7qHZF8E6fAjifu93sEnpKaHczZaDWalu5
         II8mSaOAqoIfQ==
Date:   Sun, 11 Dec 2022 13:26:11 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Ferry Toth <ftoth@exalondelft.nl>
Subject: Re: [PATCH v1 01/11] iio: light: tsl2563: Do not hardcode interrupt
 trigger type
Message-ID: <20221211132611.0ab2f29e@jic23-huawei>
In-Reply-To: <20221207190348.9347-1-andriy.shevchenko@linux.intel.com>
References: <20221207190348.9347-1-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-pc-linux-gnu)
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

On Wed,  7 Dec 2022 21:03:38 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> From: Ferry Toth <ftoth@exalondelft.nl>
> 
> Instead of hardcoding IRQ trigger type to IRQF_TRIGGER_RAISING,
> let's respect the settings specified in the firmware description.
> To be compatible with the older firmware descriptions, if trigger
> type is not set up there, we'll set it to default (raising edge).
> 
> Fixes: 388be4883952 ("staging:iio: tsl2563 abi fixes and interrupt handling")
> Fixes: bdab1001738f ("staging:iio:light:tsl2563 remove old style event registration.")
> Signed-off-by: Ferry Toth <ftoth@exalondelft.nl>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Andy, would have preferred a cover letter, so I had an obvious place
to reply to the whole series...

Mostly I'm amazed anyone still has one of these devices (I have one but
it's on a break out board for the stargate2/imote2 pxa27x platform that we
dropped support for last year - I hadn't booted it for a few years)
- I can probably bodge it onto something else but I can't say it was
high on my todo list ;)  So nice to know that someone still cares about
this.

So I'm curious Ferry, what device has one of these?

Whole series applied to the togreg branch of iio.git though note I'll only
push this out as testing for now because I'll want to rebase that tree
after rc1 is available.

Thanks,

Jonathan

> ---
>  drivers/iio/light/tsl2563.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/light/tsl2563.c b/drivers/iio/light/tsl2563.c
> index d0e42b73203a..71302ae864d9 100644
> --- a/drivers/iio/light/tsl2563.c
> +++ b/drivers/iio/light/tsl2563.c
> @@ -704,6 +704,7 @@ static int tsl2563_probe(struct i2c_client *client)
>  	struct iio_dev *indio_dev;
>  	struct tsl2563_chip *chip;
>  	struct tsl2563_platform_data *pdata = client->dev.platform_data;
> +	unsigned long irq_flags;
>  	int err = 0;
>  	u8 id = 0;
>  
> @@ -759,10 +760,15 @@ static int tsl2563_probe(struct i2c_client *client)
>  		indio_dev->info = &tsl2563_info_no_irq;
>  
>  	if (client->irq) {
> +		irq_flags = irq_get_trigger_type(client->irq);
> +		if (irq_flags == IRQF_TRIGGER_NONE)
> +			irq_flags = IRQF_TRIGGER_RISING;
> +		irq_flags |= IRQF_ONESHOT;
> +
>  		err = devm_request_threaded_irq(&client->dev, client->irq,
>  					   NULL,
>  					   &tsl2563_event_handler,
> -					   IRQF_TRIGGER_RISING | IRQF_ONESHOT,
> +					   irq_flags,
>  					   "tsl2563_event",
>  					   indio_dev);
>  		if (err) {

