Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26AD072165E
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jun 2023 13:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231314AbjFDLdE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 07:33:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjFDLdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 07:33:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FC79DA;
        Sun,  4 Jun 2023 04:33:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 04A3361134;
        Sun,  4 Jun 2023 11:33:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6B0EC433EF;
        Sun,  4 Jun 2023 11:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685878381;
        bh=xvMJ3ehOlg6D/nr4URcRAcKPQ4ful8e1IqWXQ7fGVTU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=A/bfpTrs/Szu+hLTZ7Srx57g028noNj6jn2mk6mZA+NjjpagxNvNfPmX6tzwExgOa
         uXyrJ45DOOym/aafOG9FrP0gJiqKRIvPX3byCqrjlepCWAbOdeEGghRLYX7vHclWEz
         AU4RNnM+796Y2GLLgf7NAgY3He7zmg8x+xuuhhHuf3nLgCACmZVDM5/s9G485+sbr1
         ILmEPZD3JTl+rkgNBC2FsmoEpVrc7UUhrgDh2TEDScyI1Ii3LzpCjwt92Rez/uhsXp
         EpOPaiJzJSbvlYJqgSBe8swgm9TREs1WCKvxMUB5zzVAw682CjSw6KB5Gw93ipr8MZ
         yiF1aVE8xQskA==
Date:   Sun, 4 Jun 2023 12:32:56 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     fl.scratchpad@gmail.com
Cc:     Alexandru Tachici <alexandru.tachici@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Alexandru Ardelean <aardelean@deviqon.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nuno Sa <nuno.sa@analog.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v3 1/5] iio: adc: ad7192: Fix null ad7192_state pointer
 access
Message-ID: <20230604123256.6cf470bc@jic23-huawei>
In-Reply-To: <20230530075311.400686-2-fl.scratchpad@gmail.com>
References: <20230530075311.400686-1-fl.scratchpad@gmail.com>
        <20230530075311.400686-2-fl.scratchpad@gmail.com>
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

On Tue, 30 May 2023 09:53:07 +0200
fl.scratchpad@gmail.com wrote:

> From: Fabrizio Lamarque <fl.scratchpad@gmail.com>
> 
> Pointer to indio_dev structure is obtained via spi_get_drvdata() at
> the beginning of function ad7192_setup(), but the spi->dev->driver_data
> member is not initialized, hence a NULL pointer is returned.
> 
> Fix by changing ad7192_setup() signature to take pointer to struct
> iio_dev, and get ad7192_state pointer via st = iio_priv(indio_dev);
> 
> Fixes: bd5dcdeb3fd0 ("iio: adc: ad7192: convert to device-managed functions")
> Signed-off-by: Fabrizio Lamarque <fl.scratchpad@gmail.com>
> Reviewed-by: Nuno Sa <nuno.sa@analog.com>
I'll pick those of this series up that everyone seems happy with.

Applied to the fixes-togreg branch of iio.git
Thanks,

Jonathan

> ---
>  drivers/iio/adc/ad7192.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
> index 55a6ab591016..94a9cf34a255 100644
> --- a/drivers/iio/adc/ad7192.c
> +++ b/drivers/iio/adc/ad7192.c
> @@ -380,9 +380,9 @@ static int ad7192_of_clock_select(struct ad7192_state *st)
>  	return clock_sel;
>  }
>  
> -static int ad7192_setup(struct ad7192_state *st, struct device_node *np)
> +static int ad7192_setup(struct iio_dev *indio_dev, struct device_node *np)
>  {
> -	struct iio_dev *indio_dev = spi_get_drvdata(st->sd.spi);
> +	struct ad7192_state *st = iio_priv(indio_dev);
>  	bool rej60_en, refin2_en;
>  	bool buf_en, bipolar, burnout_curr_en;
>  	unsigned long long scale_uv;
> @@ -1073,7 +1073,7 @@ static int ad7192_probe(struct spi_device *spi)
>  		}
>  	}
>  
> -	ret = ad7192_setup(st, spi->dev.of_node);
> +	ret = ad7192_setup(indio_dev, spi->dev.of_node);
>  	if (ret)
>  		return ret;
>  

