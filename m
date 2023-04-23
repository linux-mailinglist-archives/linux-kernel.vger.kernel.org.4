Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D3A36EBEFC
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Apr 2023 13:00:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbjDWLAl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Apr 2023 07:00:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbjDWLAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Apr 2023 07:00:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D46952D4D;
        Sun, 23 Apr 2023 03:59:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6F48B61877;
        Sun, 23 Apr 2023 10:59:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4FDBC433EF;
        Sun, 23 Apr 2023 10:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682247591;
        bh=YajMEGmWHLgl1dfPPf14NhWBx/ZoF0B5xJpseBunF4E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=UfJ07nKA9joGzh+ZowR7I0eHRXFLQW5hrUhmCxq/eOCLeNh4aJvsh1OLCOjKRzK7H
         038uUwEruwmoYUlcrGr8vCqKJHwB2zyHzVt3j8x+t/qmvmIUfqsmdDp4172AsYLfrQ
         Yez/WxD55/dVwY16fGVYP4kl4juiB0yOmJMpLhXV6ar4FoVrStZSxFlcwDiyoS6fjL
         I1D4lkjTrEERYBvu9YUHY7c2Q3CE/hSqtHyZHKEIUmhGKsB8Kbq4YLi1pJqBHZTKmN
         CgsNDSxGYEJ0Rs2VtMpkXSynfOMglGPLIovQ2NyFM6hGdudp8iSVD9/3t8jtRIcgsO
         2ZFOyZkrITkgQ==
Date:   Sun, 23 Apr 2023 12:15:28 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Masahiro Honda <honda@mechatrax.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] Fix IRQ issue by setting IRQ_DISABLE_UNLAZY flag
Message-ID: <20230423121528.259d3cd4@jic23-huawei>
In-Reply-To: <20230420102316.757-1-honda@mechatrax.com>
References: <20230420102316.757-1-honda@mechatrax.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Apr 2023 19:23:16 +0900
Masahiro Honda <honda@mechatrax.com> wrote:

> The Sigma-Delta ADCs supported by this driver can use SDO as an interrupt
> line to indicate the completion of a conversion. However, some devices
> cannot properly detect the completion of a conversion by an interrupt.
> This is for the reason mentioned in the following commit.
> 
> commit e9849777d0e2 ("genirq: Add flag to force mask in
>                       disable_irq[_nosync]()")
> 
> A read operation is performed by an extra interrupt before the completion
> of a conversion. This patch fixes the issue by setting IRQ_DISABLE_UNLAZY
> flag.
> 
> Signed-off-by: Masahiro Honda <honda@mechatrax.com>
> ---
> v3:
>  - Remove the Kconfig option.
> v2: https://lore.kernel.org/linux-iio/20230414102744.150-1-honda@mechatrax.com/
>  - Rework commit message.
>  - Add a new entry in the Kconfig.
>  - Call irq_clear_status_flags(irq, IRQ_DISABLE_UNLAZY) when freeing the IRQ.
> v1: https://lore.kernel.org/linux-iio/20230306044737.862-1-honda@mechatrax.com/
> 
>  drivers/iio/adc/ad_sigma_delta.c | 25 ++++++++++++++++++++-----
>  1 file changed, 20 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
> index d8570f620..215ecbedb 100644
> --- a/drivers/iio/adc/ad_sigma_delta.c
> +++ b/drivers/iio/adc/ad_sigma_delta.c
> @@ -565,6 +565,14 @@ int ad_sd_validate_trigger(struct iio_dev *indio_dev, struct iio_trigger *trig)
>  }
>  EXPORT_SYMBOL_NS_GPL(ad_sd_validate_trigger, IIO_AD_SIGMA_DELTA);
>  
> +static void ad_sd_free_irq(void *sd)
> +{
> +	struct ad_sigma_delta *sigma_delta = sd;
> +
> +	irq_clear_status_flags(sigma_delta->spi->irq, IRQ_DISABLE_UNLAZY);
> +	free_irq(sigma_delta->spi->irq, sigma_delta);
> +}

Don't fuse the two operations unwinding like this.  Just register a callback that only
does the irq_clear_status_flags immediately after setting them.  Then leave
the orginally devm_request_irq call alone.  If it fails, the devm cleanup will
deal with the irq_clear_status_flag for you.

It almost never makes sense for a single devm call to unwind more than one function call in
a driver.

Otherwise this looks fine to me,

Thanks,

Jonathan



> +
>  static int devm_ad_sd_probe_trigger(struct device *dev, struct iio_dev *indio_dev)
>  {
>  	struct ad_sigma_delta *sigma_delta = iio_device_get_drvdata(indio_dev);
> @@ -584,11 +592,18 @@ static int devm_ad_sd_probe_trigger(struct device *dev, struct iio_dev *indio_de
>  	init_completion(&sigma_delta->completion);
>  
>  	sigma_delta->irq_dis = true;
> -	ret = devm_request_irq(dev, sigma_delta->spi->irq,
> -			       ad_sd_data_rdy_trig_poll,
> -			       sigma_delta->info->irq_flags | IRQF_NO_AUTOEN,
> -			       indio_dev->name,
> -			       sigma_delta);
> +	irq_set_status_flags(sigma_delta->spi->irq, IRQ_DISABLE_UNLAZY);
> +	ret = request_irq(sigma_delta->spi->irq,
> +			  ad_sd_data_rdy_trig_poll,
> +			  sigma_delta->info->irq_flags | IRQF_NO_AUTOEN,
> +			  indio_dev->name,
> +			  sigma_delta);
> +	if (ret) {
> +		irq_clear_status_flags(sigma_delta->spi->irq, IRQ_DISABLE_UNLAZY);
> +		return ret;
> +	}
> +
> +	ret = devm_add_action_or_reset(dev, ad_sd_free_irq, sigma_delta);
>  	if (ret)
>  		return ret;
>  

