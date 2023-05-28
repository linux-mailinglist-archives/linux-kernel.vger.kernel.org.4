Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B539E713B22
	for <lists+linux-kernel@lfdr.de>; Sun, 28 May 2023 19:33:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbjE1RdU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 May 2023 13:33:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjE1RdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 May 2023 13:33:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7AC1BD;
        Sun, 28 May 2023 10:33:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 70B6160DFC;
        Sun, 28 May 2023 17:33:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33080C433EF;
        Sun, 28 May 2023 17:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685295196;
        bh=qzJfjzEEjZiZQ5UutuKr+0+hvV5RgYLuzJPm3/PtkBE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=UXtD9ZFB/1BoG67nX257ClGZvhetKEoCIktc3yq7ycXgBpJJi1/C9aoLCes39jG8R
         fPgYnl0X49kJEyTZ10gYxvKqMhFNsBii/GEl6qKVrEgMy82whBIvqSzCjiiUJQ4cmj
         eiIQbMT4PyKROjCcoMrchGNdGPErG6DwXzSN1hvkf/Vm9uslvb+8O9YwygTqazfXgi
         exaFiXwTEP25yWd+LHL+VSRN8TI8gWL5fan9NHmhVRO5EpPWp11kVsOA8SxII55xwC
         /L2G/NN7bJC7YRGZHQ4T3CO7wPrYpVstgUeCgkAPnQRWIiaDC27VGU0+sj6aF7opRN
         i5poptqSBLXJg==
Date:   Sun, 28 May 2023 18:49:35 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Artur Rojek <contact@artur-rojek.eu>
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Chris Morgan <macromorgan@hotmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-mips@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: Re: [PATCH v2 1/2] iio/adc: ingenic: Fix channel offsets in buffer
Message-ID: <20230528184935.15dd91fa@jic23-huawei>
In-Reply-To: <20230521225901.388455-2-contact@artur-rojek.eu>
References: <20230521225901.388455-1-contact@artur-rojek.eu>
        <20230521225901.388455-2-contact@artur-rojek.eu>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 May 2023 00:59:00 +0200
Artur Rojek <contact@artur-rojek.eu> wrote:

> Consumers expect the buffer to only contain enabled channels. While
> preparing the buffer, the driver makes two mistakes:
> 1) It inserts empty data for disabled channels.
> 2) Each ADC readout contains samples for two 16-bit channels. If either
>    of them is active, the whole 32-bit sample is pushed into the buffer
>    as-is.
> 
> Both of those issues cause the active channels to appear at the wrong
> offsets in the buffer. Fix the above by demuxing samples for active
> channels only.
> 
> This has remained unnoticed, as all the consumers so far were only using
> channels 0 and 1, leaving them unaffected by changes introduced in this
> commit.
> 
> Signed-off-by: Artur Rojek <contact@artur-rojek.eu>
> Tested-by: Paul Cercueil <paul@crapouillou.net>

Lazy me suggestions that, as we didn't notice this before, clearly the
vast majority of times the channels are both enabled.
As such you 'could' just set available_scan_masks and burn the overhead
of reading channels you don't want, instead letting the IIO core demux
deal with the data movement if needed.

> ---
> 
> v2: - demux active channels from ADC readouts 
>     - clarify in the commit description that this patch doesn't impact
>       existing consumers of this driver
> 
>  drivers/iio/adc/ingenic-adc.c | 20 +++++++++++++-------
>  1 file changed, 13 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iio/adc/ingenic-adc.c b/drivers/iio/adc/ingenic-adc.c
> index a7325dbbb99a..093710a7ad4c 100644
> --- a/drivers/iio/adc/ingenic-adc.c
> +++ b/drivers/iio/adc/ingenic-adc.c
> @@ -802,13 +802,19 @@ static irqreturn_t ingenic_adc_irq(int irq, void *data)
>  	struct ingenic_adc *adc = iio_priv(iio_dev);
>  	unsigned long mask = iio_dev->active_scan_mask[0];
>  	unsigned int i;
> -	u32 tdat[3];
> -
> -	for (i = 0; i < ARRAY_SIZE(tdat); mask >>= 2, i++) {
> -		if (mask & 0x3)
> -			tdat[i] = readl(adc->base + JZ_ADC_REG_ADTCH);
> -		else
> -			tdat[i] = 0;
> +	u16 tdat[6];
> +	u32 val;
> +
> +	memset(tdat, 0, ARRAY_SIZE(tdat));
> +	for (i = 0; mask && i < ARRAY_SIZE(tdat); mask >>= 2) {
> +		if (mask & 0x3) {
> +			val = readl(adc->base + JZ_ADC_REG_ADTCH);
> +			/* Two channels per sample. Demux active. */
> +			if (mask & BIT(0))
> +				tdat[i++] = val & 0xffff;
> +			if (mask & BIT(1))
> +				tdat[i++] = val >> 16;
> +		}
>  	}
>  
>  	iio_push_to_buffers(iio_dev, tdat);

