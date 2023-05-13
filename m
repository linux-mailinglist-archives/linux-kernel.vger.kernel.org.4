Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45EA3701950
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 20:42:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231562AbjEMSmB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 14:42:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjEMSl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 14:41:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43020213B;
        Sat, 13 May 2023 11:41:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C8E2D60916;
        Sat, 13 May 2023 18:41:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39B95C433D2;
        Sat, 13 May 2023 18:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684003317;
        bh=960B3HljHMc0xLQjiljh6ZBWtqoJCu2x7TZSrYLcxOo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=P8gOM8RceHjtAdVimH1LpSFkvtDhuCareHditzq/ugTD9OooEG8hGPF5vctRsXcRb
         R1tbSqsYjBrVa53DI1zS5OU825adh6E6SOF6zqvQWGGmceqXsB+6sD7sWssoLHA1fG
         B0V/x+oL8+hWSj5MX772du2wfljH9vK/o9AY6aC2DgC/ghjTfjDVfQxGnOpldAw+O9
         u47OuzGiJdT4Q35oG2Qb6oPlr9JglydAn0yLzpWIk9RWE/pdJ3nsdBo5BIoDvM31pO
         U2XHEdM6R5l/zdHid76Lc6F2YKIxl2SjOAnjH/1kwRVY3zTXPmOQMSWbRnE0askxme
         F47hp4gVnSHxQ==
Date:   Sat, 13 May 2023 19:57:58 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Astrid Rost <astrid.rost@axis.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel@axis.com>
Subject: Re: [PATCH v2 1/7] iio: light: vcnl4000: Add proximity irq for
 vcnl4200
Message-ID: <20230513195758.0d18825f@jic23-huawei>
In-Reply-To: <20230509140153.3279288-2-astrid.rost@axis.com>
References: <20230509140153.3279288-1-astrid.rost@axis.com>
        <20230509140153.3279288-2-astrid.rost@axis.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 May 2023 16:01:47 +0200
Astrid Rost <astrid.rost@axis.com> wrote:

> Add proximity interrupt support for vcnl4200 (similar to vcnl4040).
> Add support to configure proximity sensor interrupts and threshold
> limits. If an interrupt is detected an event will be pushed to the
> event interface.
> 
> Signed-off-by: Astrid Rost <astrid.rost@axis.com>
Where possible (and I think it is here) please avoid putting data as code.
That is, move the necessary register address into the
*_chip_spec structure.  That way, if another version of the chip is supported
in future we can simply add the value to the right instance of that structure.
That tends to end up more flexible than if / else / switch statements.

Thanks,

Jonathan

> ---
>  drivers/iio/light/vcnl4000.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
> index 56d3963d3d66..13568454baff 100644
> --- a/drivers/iio/light/vcnl4000.c
> +++ b/drivers/iio/light/vcnl4000.c
> @@ -65,6 +65,7 @@
>  #define VCNL4200_PS_DATA	0x08 /* Proximity data */
>  #define VCNL4200_AL_DATA	0x09 /* Ambient light data */
>  #define VCNL4040_INT_FLAGS	0x0b /* Interrupt register */
> +#define VCNL4200_INT_FLAGS	0x0d /* Interrupt register */
>  #define VCNL4200_DEV_ID		0x0e /* Device ID, slave address and version */
>  
>  #define VCNL4040_DEV_ID		0x0c /* Device ID and version */
> @@ -1004,8 +1005,14 @@ static irqreturn_t vcnl4040_irq_thread(int irq, void *p)
>  	struct iio_dev *indio_dev = p;
>  	struct vcnl4000_data *data = iio_priv(indio_dev);
>  	int ret;
> +	int reg;
>  
> -	ret = i2c_smbus_read_word_data(data->client, VCNL4040_INT_FLAGS);
> +	if (data->id == VCNL4200)
> +		reg = VCNL4200_INT_FLAGS;
> +	else
> +		reg = VCNL4040_INT_FLAGS;

Prefer this as
	data->chip_spec->int_reg

> +
> +	ret = i2c_smbus_read_word_data(data->client, reg);
>  	if (ret < 0)
>  		return IRQ_HANDLED;
>  
> @@ -1321,9 +1328,10 @@ static const struct vcnl4000_chip_spec vcnl4000_chip_spec_cfg[] = {
>  		.measure_light = vcnl4200_measure_light,
>  		.measure_proximity = vcnl4200_measure_proximity,
>  		.set_power_state = vcnl4200_set_power_state,
> -		.channels = vcnl4000_channels,
> +		.channels = vcnl4040_channels,
>  		.num_channels = ARRAY_SIZE(vcnl4000_channels),
> -		.info = &vcnl4000_info,
> +		.info = &vcnl4040_info,
> +		.irq_thread = vcnl4040_irq_thread,
>  	},
>  };
>  

