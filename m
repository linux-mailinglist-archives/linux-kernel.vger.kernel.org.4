Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1CB35FFB21
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Oct 2022 17:56:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbiJOP43 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Oct 2022 11:56:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbiJOP41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Oct 2022 11:56:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B46850FAA;
        Sat, 15 Oct 2022 08:56:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 245A560D29;
        Sat, 15 Oct 2022 15:56:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BDBCC433D6;
        Sat, 15 Oct 2022 15:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665849385;
        bh=QGSTjg5RYI5bnHPXoE3XKdNotgMZOaQIAFpSpm3dcI8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gg82aqVOXCtuNJfFEX2Xn/i+g8Z3yiXXg9hlOSFeCFRv1sqhtP0kUMU5WxRlobdfg
         d68+7eDOVWjNm5+PDT564x9JpWbpPdFSSHsmTPl5oCN0+lP8S39ia6HY7aK2BJ0ipx
         tkwELDC2kB0DyCIh9njpFt01uWryuUdb/xU288n9gBSdMu+TLdHi9zpcvwcUC2Xi7P
         /uAI/NWfFaAxd4TJ6nJ0NHTsjZeSVJoO+wbJvBQAoSTQqFfqYXWaonztdx/yspiSOd
         Zjrc9u3faL6mIoEHHxkinWLz/8b1uemnJUzMWKmW+6Tv/swI4stctso0P3ObDn4x4P
         uNfvT+EWVm1Fw==
Date:   Sat, 15 Oct 2022 16:56:49 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Olivier Moysan <olivier.moysan@foss.st.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH v4 1/8] iio: adc: stm32-adc: fix channel sampling time
 init
Message-ID: <20221015165649.7720a101@jic23-huawei>
In-Reply-To: <20221012142205.13041-2-olivier.moysan@foss.st.com>
References: <20221012142205.13041-1-olivier.moysan@foss.st.com>
        <20221012142205.13041-2-olivier.moysan@foss.st.com>
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

On Wed, 12 Oct 2022 16:21:58 +0200
Olivier Moysan <olivier.moysan@foss.st.com> wrote:

> Fix channel init for ADC generic channel bindings.
> In generic channel initialization, stm32_adc_smpr_init() is called to
> initialize channel sampling time. The "st,min-sample-time-ns" property
> is an optional property. If it is not defined, stm32_adc_smpr_init() is
> currently skipped.
> However stm32_adc_smpr_init() must always be called, to force a minimum
> sampling time for the internal channels, as the minimum sampling time is
> known. Make stm32_adc_smpr_init() call unconditional.
> 
> Fixes: 796e5d0b1e9b ("iio: adc: stm32-adc: use generic binding for sample-time")
> Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>

So I'm crossing my fingers a little that this fix and the rest of the series can
go through different paths - looks like it should be clean.

Applied to the fixes-togreg branch of iio.git and marked for stable.

Thanks,

Jonathan

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

