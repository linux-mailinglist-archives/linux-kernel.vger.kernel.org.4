Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C39E7342FF
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 20:17:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346447AbjFQSRL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 14:17:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346363AbjFQSRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 14:17:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52239173D;
        Sat, 17 Jun 2023 11:17:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B454160F56;
        Sat, 17 Jun 2023 18:17:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C443C433C0;
        Sat, 17 Jun 2023 18:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687025824;
        bh=ueWStTbqbLW6LcZTy4ADQaePn4EDhabTtkcgFvECcjM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HbBW2yCh7qaZ/dBunxgvmE89K1Av8DhvPUMICVIJymc7b1F2joSbFgJHpRBHVkzrq
         FEKfLs15EpwuRXptQ10aReKEGNeqpf/THvJxCFlw/agxBdmgdeMF1RPWIUIt5aa3zv
         ZEOOuMfIDu3NZkRbGCve4dZc2HCG4ZlHPEYDFP2Uw8I0e3ABYbJsU1N0KGj46pjsdx
         zOp6DIj+rGiH/xz9Fd/eiKrZ4tbgd03Zdn2KS7RIc/4IUYKlMvjldMmPCef1zEH2DH
         Wxvx+JxSdXhsN3h4fZktCsHDeOxj46iu7yNAx8Y7PuIUbd836Nh3T6yRrqbXAYzffo
         EI6jx4CuOYztQ==
Date:   Sat, 17 Jun 2023 19:16:58 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Markus Burri <markus.burri@mt.com>
Cc:     linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH v3] iio: ado: ad7192: Add error check and more debug log
Message-ID: <20230617191658.2ee5e82b@jic23-huawei>
In-Reply-To: <20230614073033.2497318-1-markus.burri@mt.com>
References: <20230614073033.2497318-1-markus.burri@mt.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
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

On Wed, 14 Jun 2023 09:30:33 +0200
Markus Burri <markus.burri@mt.com> wrote:

> Print read and expected device ID as debug warning.
> Add error check for ad_sd_init() result.
> 
> Signed-off-by: Markus Burri <markus.burri@mt.com>
Hi Markus,

I've applied this to the togreg branch of iio.git which is initially pushed out
as testing for 0-day to see if it can find anything we missed.

A few things wrong process wise that I fixed.
1) Nuno had given a tag on v2.  You should have added that to your v3 rather
   than relying on the maintainer happening to remember it (which I only did
   because of 2.
2) The patch title still has 'ado' not 'adi'

So stuff to keep in mind for next time!

Jonathan
  
> ---
>  drivers/iio/adc/ad7192.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
> index d71977b..220c3b7 100644
> --- a/drivers/iio/adc/ad7192.c
> +++ b/drivers/iio/adc/ad7192.c
> @@ -403,8 +403,8 @@ static int ad7192_setup(struct ad7192_state *st, struct device_node *np)
>  	id &= AD7192_ID_MASK;
>  
>  	if (id != st->chip_info->chip_id)
> -		dev_warn(&st->sd.spi->dev, "device ID query failed (0x%X)\n",
> -			 id);
> +		dev_warn(&st->sd.spi->dev, "device ID query failed (0x%X != 0x%X)\n",
> +			 id, st->chip_info->chip_id);
>  
>  	st->mode = AD7192_MODE_SEL(AD7192_MODE_IDLE) |
>  		AD7192_MODE_CLKSRC(st->clock_sel) |
> @@ -1049,7 +1049,9 @@ static int ad7192_probe(struct spi_device *spi)
>  	else
>  		indio_dev->info = &ad7192_info;
>  
> -	ad_sd_init(&st->sd, indio_dev, spi, &ad7192_sigma_delta_info);
> +	ret = ad_sd_init(&st->sd, indio_dev, spi, &ad7192_sigma_delta_info);
> +	if (ret)
> +		return ret;
>  
>  	ret = devm_ad_sd_setup_buffer_and_trigger(&spi->dev, indio_dev);
>  	if (ret)

