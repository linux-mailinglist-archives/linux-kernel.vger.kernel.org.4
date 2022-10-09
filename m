Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 647595F8B4B
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Oct 2022 14:42:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbiJIMmk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Oct 2022 08:42:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbiJIMmf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 08:42:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9438FFB;
        Sun,  9 Oct 2022 05:42:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 79F1CB80D2A;
        Sun,  9 Oct 2022 12:42:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFAB2C433C1;
        Sun,  9 Oct 2022 12:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665319352;
        bh=f+mosKCYImVjf5AY2/cBN3jgVGzwj8LSrp7eU/MOFg4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=N7LKrwOdUGnlYeoUU0LVlhBi005V35WwkiVkWZ8iiLSsbA56VeiIhSPLaQl2WGzuW
         w89wOBey4yI/Nv6EqXwU36cMc7apcX5Uf9B2TGRzEXGMyLMXtpxWzigThXXwk8ymWG
         0PyPUfA3HHJeAO7z5YHpAh7D2t8YlmwkCGdQbFsXI6AaoDZtBQCJa0YnwPbbRnkcb0
         8AQpkbOB56CbaVDO8fhtNWXbyALhLkGTIwSBvWJxFaGAD9fJDI0PnyJm42+tQfLVSL
         yjEXuVd5XJV7H8igsKVNx6/+x7At2UcLA81rzCG5xix/uqbrnkgwMA/i7BDOPJ/HDa
         KOucznWY74CHg==
Date:   Sun, 9 Oct 2022 13:42:52 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Olivier Moysan <olivier.moysan@foss.st.com>
Cc:     Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        <nuno.sa@analog.com>, Paul Cercueil <paul@crapouillou.net>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Wan Jiabing <wanjiabing@vivo.com>,
        Yannick Brosseau <yannick.brosseau@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: Re: [PATCH v3 1/8] iio: adc: stm32-adc: fix channel sampling time
 init
Message-ID: <20221009134252.2b636e0a@jic23-huawei>
In-Reply-To: <20221005161424.4537-2-olivier.moysan@foss.st.com>
References: <20221005161424.4537-1-olivier.moysan@foss.st.com>
        <20221005161424.4537-2-olivier.moysan@foss.st.com>
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

On Wed, 5 Oct 2022 18:14:17 +0200
Olivier Moysan <olivier.moysan@foss.st.com> wrote:

> Fix channel init for ADC generic channel bindings.
> In generic channel initialization, stm32_adc_smpr_init() is called
> to initialize channel sampling time. The "st,min-sample-time-ns"
> property is an optional property. If it is not defined,
> stm32_adc_smpr_init() is currently skipped.
> However stm32_adc_smpr_init() must always be called,
> to force a minimum sampling time for the internal channels,
> as the minimum sampling time is known.
> Make stm32_adc_smpr_init() call unconditional.

Hi Olivier.  Andy commented on this in v2... 

Line lengths in patch description are rather random and no where near the typical
72-75 chars.  Should look more like:

Fix channel init for ADC generic channel bindings. In generic channel
initialization, stm32_adc_smpr_init() is called > to initialize channel
sampling time. The "st,min-sample-time-ns" property is an optional
property. If it is not defined, stm32_adc_smpr_init() is currently
skipped. However stm32_adc_smpr_init() must always be called, to force a
minimum sampling time for the internal channels, as the minimum sampling
time is known. Make stm32_adc_smpr_init() call unconditional.

Fine to have multiple paragraphs, but within each one, don't wrap too early.

> 
> Fixes: 796e5d0b1e9b ("iio: adc: stm32-adc: use generic binding for sample-time")
> Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
> ---
>  drivers/iio/adc/stm32-adc.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
> index 6256977eb7f7..3cda529f081d 100644
> --- a/drivers/iio/adc/stm32-adc.c
> +++ b/drivers/iio/adc/stm32-adc.c
> @@ -2086,18 +2086,19 @@ static int stm32_adc_generic_chan_init(struct iio_dev *indio_dev,
>  		stm32_adc_chan_init_one(indio_dev, &channels[scan_index], val,
>  					vin[1], scan_index, differential);
>  
> +		val = 0;
>  		ret = fwnode_property_read_u32(child, "st,min-sample-time-ns", &val);
>  		/* st,min-sample-time-ns is optional */
> -		if (!ret) {
> -			stm32_adc_smpr_init(adc, channels[scan_index].channel, val);
> -			if (differential)
> -				stm32_adc_smpr_init(adc, vin[1], val);
> -		} else if (ret != -EINVAL) {
> +		if (ret && ret != -EINVAL) {
>  			dev_err(&indio_dev->dev, "Invalid st,min-sample-time-ns property %d\n",
>  				ret);
>  			goto err;
>  		}
>  
> +		stm32_adc_smpr_init(adc, channels[scan_index].channel, val);
> +		if (differential)
> +			stm32_adc_smpr_init(adc, vin[1], val);
> +
>  		scan_index++;
>  	}
>  

