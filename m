Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFA0F70A8CF
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 17:21:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231728AbjETPVz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 May 2023 11:21:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbjETPVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 May 2023 11:21:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4809FB;
        Sat, 20 May 2023 08:21:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4908B60B2A;
        Sat, 20 May 2023 15:21:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C12B8C433D2;
        Sat, 20 May 2023 15:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684596111;
        bh=yktxZKd+NoLw+b5VUo7zKOPzwW61FpSOvbrJbWSrpzk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=J4HoY98o1zePzNEEqOcV/C9E8h1Cdwu5QBxL9BsnZoZa+oR/pCxMhX4LyEG+1qqMk
         G2EQe7JhRb99HIkfYA2bSPoq9Uis+GkzFuoKAgcvAmM9VZaz4n1i3bVBkA+bX+4Uoi
         CqYtFALFyEBKgAvqaQU0QbpjeKmFBCse0MA2cpMwR298Ahj7h6fg2lq57hYASP+SkR
         /K4jYroxSQVHjctAzY0Ew60irNBMaPGJfPOEQhjl9I7zRAQFXeqfzQMKtrTkvcpj/7
         pVIZrdkLH5RzVEYik4B9nzL+2VRF/wjRQkafOlYHI9UWeSxDD5SYWX+DiueEMc9VIc
         1DS07NKWYGMZg==
Date:   Sat, 20 May 2023 16:38:01 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Masahiro Honda <honda@mechatrax.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] iio: adc: ad_sigma_delta: Fix IRQ issue by setting
 IRQ_DISABLE_UNLAZY flag
Message-ID: <20230520163801.04552580@jic23-huawei>
In-Reply-To: <20230518110816.248-1-honda@mechatrax.com>
References: <20230518110816.248-1-honda@mechatrax.com>
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

On Thu, 18 May 2023 20:08:16 +0900
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
> of a conversion. At this time, the value read from the ADC data register
> is the same as the previous conversion result. This patch fixes the issue
> by setting IRQ_DISABLE_UNLAZY flag.
> 
> Fixes: 0c6ef985a1f ("iio: adc: ad7791: fix IRQ flags")
> Fixes: 1a913270e57 ("iio: adc: ad7793: Fix IRQ flag")
> Fixes: e081102f307 ("iio: adc: ad7780: Fix IRQ flag")
> Fixes: 89a86da5cb8 ("iio: adc: ad7192: Add IRQ flag")
> Fixes: 79ef91493f5 ("iio: adc: ad7124: Set IRQ type to falling")
All the fixes tags have 11 chars of the hash, needs to be 12. I fixed that up whilst applying

Applied to the fixes-togreg branch of iio.git and marked for stable.

Thanks,

Jonathan

> Signed-off-by: Masahiro Honda <honda@mechatrax.com>
> ---
> v5:
>  - Fix the patch title.
>  - Add fixes tags.
>  - Add information about behavior to the commit message.
> v4: https://lore.kernel.org/linux-iio/20230502102930.773-1-honda@mechatrax.com/
>  - Remove the callback.
> v3: https://lore.kernel.org/linux-iio/20230420102316.757-1-honda@mechatrax.com/
>  - Remove the Kconfig option.
> v2: https://lore.kernel.org/linux-iio/20230414102744.150-1-honda@mechatrax.com/
>  - Rework commit message.
>  - Add a new entry in the Kconfig.
>  - Call irq_clear_status_flags(irq, IRQ_DISABLE_UNLAZY) when freeing the IRQ.
> v1: https://lore.kernel.org/linux-iio/20230306044737.862-1-honda@mechatrax.com/
> 
>  drivers/iio/adc/ad_sigma_delta.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
> index d8570f62078..7e219287074 100644
> --- a/drivers/iio/adc/ad_sigma_delta.c
> +++ b/drivers/iio/adc/ad_sigma_delta.c
> @@ -584,6 +584,10 @@ static int devm_ad_sd_probe_trigger(struct device *dev, struct iio_dev *indio_de
>  	init_completion(&sigma_delta->completion);
>  
>  	sigma_delta->irq_dis = true;
> +
> +	/* the IRQ core clears IRQ_DISABLE_UNLAZY flag when freeing an IRQ */
> +	irq_set_status_flags(sigma_delta->spi->irq, IRQ_DISABLE_UNLAZY);
> +
>  	ret = devm_request_irq(dev, sigma_delta->spi->irq,
>  			       ad_sd_data_rdy_trig_poll,
>  			       sigma_delta->info->irq_flags | IRQF_NO_AUTOEN,

