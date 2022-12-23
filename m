Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76B79655284
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 17:03:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236301AbiLWQD4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 11:03:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230425AbiLWQDw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 11:03:52 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36A5D379E1;
        Fri, 23 Dec 2022 08:03:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C384B61506;
        Fri, 23 Dec 2022 16:03:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EE03C433D2;
        Fri, 23 Dec 2022 16:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671811430;
        bh=CmUH9OByAmfCEX6dhnmiGAFzKh+4JSJjcrx/3zhP8Wc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=B4KHp3xlUExVt2qI5q/7TrchTsQ+aUOj5gkMOeXR+3Zt02q/le2/UVpY/Kt/jyzXe
         NDbSaGI3hp8T9jIWCPgUFqqWFjM6KXAsg9PRfHn5vMDV44cLZdKAfwP9wUPX/O+t5E
         3qHvDAKC40IHevgx8lkaou+nJCO/64XYcgBdujI05+cdDxF6Xy1Xiw9Kp1KcQ0UwcR
         kmCySDCg4vpN20UFkkngQDB2uuvEX5V7R/n/HwV/uX+g54HPWlbpUXzh7i6XfKe5e0
         m8S4Vs/Yp6rXDivqXMQTECkuUEMaaWVZWbvDcDe0xh6oWMGOab46MiupGT+hBfb38G
         d6M9zj71C9cLQ==
Date:   Fri, 23 Dec 2022 16:16:59 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Daniel Beer <dlbeer@gmail.com>
Cc:     linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ad_sigma_delta: fix race between IRQ and completion
Message-ID: <20221223161659.7652c95c@jic23-huawei>
In-Reply-To: <63a01acb.a70a0220.9a08f.987d@mx.google.com>
References: <63a01acb.a70a0220.9a08f.987d@mx.google.com>
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

On Mon, 19 Dec 2022 20:48:46 +1300
Daniel Beer <dlbeer@gmail.com> wrote:

> ad_sigma_delta waits for a conversion which terminates with the firing
> of a one-shot IRQ handler. In this handler, the interrupt is disabled
> and a completion is set.
> 
> Meanwhile, the thread that initiated the conversion is waiting on the
> completion to know when the conversion happened. If this wait times out,
> the conversion is aborted and IRQs are disabled. But the IRQ may fire
> anyway between the time the completion wait times out and the disabling
> of interrupts. If this occurs, we get a double-disabled interrupt.

Ouch and good work tracking it down.  just to check, did you see this
bug happen in the wild or spotted by code inspection?

Given that timeout generally indicates hardware failure, I'm not sure
how critical this is to fix.

I don't think this fix fully closes the race - see inline.

Jonathan

> 
> This patch fixes that by wrapping the completion wait in a function that
> handles timeouts correctly by synchronously disabling the interrupt and
> then undoing the damage if it got disabled twice.
> 
> Fixes: af3008485ea0 ("iio:adc: Add common code for ADI Sigma Delta devices")
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Signed-off-by: Daniel Beer <dlbeer@gmail.com>
> ---
>  drivers/iio/adc/ad_sigma_delta.c | 49 +++++++++++++++++++-------------
>  1 file changed, 30 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
> index d8570f620785..2f1702eeed56 100644
> --- a/drivers/iio/adc/ad_sigma_delta.c
> +++ b/drivers/iio/adc/ad_sigma_delta.c
> @@ -202,6 +202,31 @@ int ad_sd_reset(struct ad_sigma_delta *sigma_delta,
>  }
>  EXPORT_SYMBOL_NS_GPL(ad_sd_reset, IIO_AD_SIGMA_DELTA);
>  
> +static int ad_sd_wait_and_disable(struct ad_sigma_delta *sigma_delta,
> +				  unsigned long timeout)
> +{
> +	const int ret = wait_for_completion_interruptible_timeout(
> +			&sigma_delta->completion, timeout);
> +
> +	if (!ret) {
> +		/* Just because the completion timed out, doesn't mean that the
Multiline comment syntax in IIO is the
/*
 * Just...

form.

> +		 * IRQ didn't fire. It might be in progress right now.
> +		 */
> +		disable_irq(sigma_delta->spi->irq);
> +
> +		/* The IRQ handler may have run after all. If that happened,

Same for this comment.

> +		 * then we will now have double-disabled the IRQ, and irq_dis
> +		 * will be true (having been set in the handler).
> +		 */
> +		if (sigma_delta->irq_dis)
> +			enable_irq(sigma_delta->spi->irq);
> +		else
> +			sigma_delta->irq_dis = true;

I'd set this unconditionally.  It might already be set, but that shouldn't
be a problem.

Is this fix sufficient?  If the interrupt is being handled on a different
CPU to the caller of this function, I think we can still race enough that
this fails to fix it up.  Might need a spinlock to prevent that.

  CPU 0                                        CPU 1
ad_sd_data_rdy_trig_poll()               ad_sd_wait_and_disable()
                                       
                                         //wait_for_completion ends
					
Interrupt
                                          disable_irq()
					  if (sigma-delta->irq_dis) !true	
					  else
						sigma_delta->irq_dis = true

disable_irq_nosync(irq)
sigma_delta->irq_dis = true;

So we still end up with a doubly disabled irq.  Add a spinlock to make the
disable and the setting of sigma_delta->irq_dis atomic then it should all be fine.                



> +	}
> +
> +	return ret;
> +}
> +
>  int ad_sd_calibrate(struct ad_sigma_delta *sigma_delta,
>  	unsigned int mode, unsigned int channel)
>  {
> @@ -223,14 +248,11 @@ int ad_sd_calibrate(struct ad_sigma_delta *sigma_delta,
>  
>  	sigma_delta->irq_dis = false;
>  	enable_irq(sigma_delta->spi->irq);
> -	timeout = wait_for_completion_timeout(&sigma_delta->completion, 2 * HZ);
> -	if (timeout == 0) {
> -		sigma_delta->irq_dis = true;
> -		disable_irq_nosync(sigma_delta->spi->irq);
> +	timeout = ad_sd_wait_and_disable(sigma_delta, 2 * HZ);
> +	if (timeout == 0)
>  		ret = -EIO;
> -	} else {
> +	else
>  		ret = 0;
> -	}
>  out:
>  	sigma_delta->keep_cs_asserted = false;
>  	ad_sigma_delta_set_mode(sigma_delta, AD_SD_MODE_IDLE);
> @@ -296,8 +318,7 @@ int ad_sigma_delta_single_conversion(struct iio_dev *indio_dev,
>  
>  	sigma_delta->irq_dis = false;
>  	enable_irq(sigma_delta->spi->irq);
> -	ret = wait_for_completion_interruptible_timeout(
> -			&sigma_delta->completion, HZ);
> +	ret = ad_sd_wait_and_disable(sigma_delta, HZ);
>  
>  	if (ret == 0)
>  		ret = -EIO;
> @@ -314,11 +335,6 @@ int ad_sigma_delta_single_conversion(struct iio_dev *indio_dev,
>  		&raw_sample);
>  
>  out:
> -	if (!sigma_delta->irq_dis) {
> -		disable_irq_nosync(sigma_delta->spi->irq);
> -		sigma_delta->irq_dis = true;
> -	}
> -
>  	sigma_delta->keep_cs_asserted = false;
>  	ad_sigma_delta_set_mode(sigma_delta, AD_SD_MODE_IDLE);
>  	sigma_delta->bus_locked = false;
> @@ -411,12 +427,7 @@ static int ad_sd_buffer_postdisable(struct iio_dev *indio_dev)
>  	struct ad_sigma_delta *sigma_delta = iio_device_get_drvdata(indio_dev);
>  
>  	reinit_completion(&sigma_delta->completion);
> -	wait_for_completion_timeout(&sigma_delta->completion, HZ);
> -
> -	if (!sigma_delta->irq_dis) {
> -		disable_irq_nosync(sigma_delta->spi->irq);
> -		sigma_delta->irq_dis = true;
> -	}
> +	ad_sd_wait_and_disable(sigma_delta, HZ);
>  
>  	sigma_delta->keep_cs_asserted = false;
>  	ad_sigma_delta_set_mode(sigma_delta, AD_SD_MODE_IDLE);

