Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4E526092CC
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 14:42:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbiJWMmP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 08:42:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbiJWMmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 08:42:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EEF86E8B9;
        Sun, 23 Oct 2022 05:42:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6287A60A4B;
        Sun, 23 Oct 2022 12:42:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48F2BC433C1;
        Sun, 23 Oct 2022 12:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666528927;
        bh=z/exFzsXImhJJM377UDQ0yPTeqlUGFaEtkysGUue2GA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=b/odMp2oXSJqy64TNm0G/vKGWP0EFAVKL8Z/iUmvmAIeKCBYu4q2EJfargNiSDC0J
         9PUPIBQ9uGEJIoCGVLvZTx/NpNC7DgJQ5W/+w1f6xtw3iPwJDlrfKpk2ZjgMJ+h7/P
         WLQam7BtxwBeL/pVZDfE3EVE5UMtWxbj8BUQmhizvzNkDBcBE9DPXbpF+rWniAv+dA
         H+OATwcCWLgUQ96Y8XvSbBHa3HTLgzQhDSJInWxi6W1vYln8abzmvRFH8C9ez6/5lv
         p0GvBU7508PyNiFHQfMt6r9oX/+yJxnGzbqSBzOK+Mb0NOBOmWA4TMZhXsNtTDGZDC
         NzTeA0j21ttMg==
Date:   Sun, 23 Oct 2022 13:42:41 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Cosmin Tanislav <demonsingur@gmail.com>
Cc:     Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Cosmin Tanislav <cosmin.tanislav@analog.com>
Subject: Re: [PATCH v2 2/5] iio: temperature: ltc2983: make bulk write
 buffer DMA-safe
Message-ID: <20221023134241.79c52280@jic23-huawei>
In-Reply-To: <20221020090257.1717053-3-demonsingur@gmail.com>
References: <20221020090257.1717053-1-demonsingur@gmail.com>
        <20221020090257.1717053-3-demonsingur@gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Oct 2022 12:02:54 +0300
Cosmin Tanislav <demonsingur@gmail.com> wrote:

> From: Cosmin Tanislav <cosmin.tanislav@analog.com>
> 
> regmap_bulk_write() does not guarantee implicit DMA-safety,
> even though the current implementation duplicates the given
> buffer. Do not rely on it.
> 
> Fixes: f110f3188e56 ("iio: temperature: Add support for LTC2983")
> Signed-off-by: Cosmin Tanislav <cosmin.tanislav@analog.com>
LGTM.

As you right observed this is only sort of a fix because right now we
are fine anyway, so in the interests of getting the rest of the series
upstream quicker I'll take this one for the next merge window along
with the rest of the set.

Thanks,

Jonathan

> ---
>  drivers/iio/temperature/ltc2983.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/temperature/ltc2983.c b/drivers/iio/temperature/ltc2983.c
> index a60ccf183687..1117991ca2ab 100644
> --- a/drivers/iio/temperature/ltc2983.c
> +++ b/drivers/iio/temperature/ltc2983.c
> @@ -209,6 +209,7 @@ struct ltc2983_data {
>  	 * Holds the converted temperature
>  	 */
>  	__be32 temp __aligned(IIO_DMA_MINALIGN);
> +	__be32 chan_val;
>  };
>  
>  struct ltc2983_sensor {
> @@ -313,19 +314,18 @@ static int __ltc2983_fault_handler(const struct ltc2983_data *st,
>  	return 0;
>  }
>  
> -static int __ltc2983_chan_assign_common(const struct ltc2983_data *st,
> +static int __ltc2983_chan_assign_common(struct ltc2983_data *st,
>  					const struct ltc2983_sensor *sensor,
>  					u32 chan_val)
>  {
>  	u32 reg = LTC2983_CHAN_START_ADDR(sensor->chan);
> -	__be32 __chan_val;
>  
>  	chan_val |= LTC2983_CHAN_TYPE(sensor->type);
>  	dev_dbg(&st->spi->dev, "Assign reg:0x%04X, val:0x%08X\n", reg,
>  		chan_val);
> -	__chan_val = cpu_to_be32(chan_val);
> -	return regmap_bulk_write(st->regmap, reg, &__chan_val,
> -				 sizeof(__chan_val));
> +	st->chan_val = cpu_to_be32(chan_val);
> +	return regmap_bulk_write(st->regmap, reg, &st->chan_val,
> +				 sizeof(st->chan_val));
>  }
>  
>  static int __ltc2983_chan_custom_sensor_assign(struct ltc2983_data *st,

