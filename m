Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 645B4636B12
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 21:25:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239903AbiKWUZr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 15:25:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239875AbiKWUZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 15:25:25 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFEDFDB878;
        Wed, 23 Nov 2022 12:20:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5E6D0B8247F;
        Wed, 23 Nov 2022 20:20:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFD89C433C1;
        Wed, 23 Nov 2022 20:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669234856;
        bh=VyRIdHho310smDb/2nnFWvmvE2om5bSSjhO8Tk0Wrvs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ar93+vKEUXidY/IDD51+S0xBkChoU2G1GzWoDRuHiMVZQ3LNzoW+jgYs/HD8x9pyI
         5sV6vRJuW6158+4qbuTyqdqarXkeALW0Ux/1FcZ1CqCxpvyNcwZZQVHizPbI8e+yI8
         /VCaB0JJQoSdON/tqZQQ7CNwCj/L9tRdo2O5ivtZw9/NpTwJdpIj4AaHYfKAQu9yMQ
         vu/eWTaTzhmyQumjZRefFBlQ+mvpd+dNoQwIiiD7E3dG2a2YRUgIHV8VTM/1Y3dc+n
         K5PqwoxvZwqdi/2oPPYjQmNhuW7n90WUrgNPrZTSeCsLNw1pF8MQ12BCn/EE/REMMg
         YDaP7UPsgcU0w==
Date:   Wed, 23 Nov 2022 20:33:29 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Ibrahim Tilki <Ibrahim.Tilki@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>,
        "Julia Lawall" <julia.lawall@lip6.fr>
Subject: Re: [PATCH] iio: adc: max11410: fix incomplete vref buffer mask
Message-ID: <20221123203329.7ce0482a@jic23-huawei>
In-Reply-To: <20221122114718.17557-1-Ibrahim.Tilki@analog.com>
References: <20221122114718.17557-1-Ibrahim.Tilki@analog.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-pc-linux-gnu)
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

On Tue, 22 Nov 2022 14:47:18 +0300
Ibrahim Tilki <Ibrahim.Tilki@analog.com> wrote:

> VREFP bit was missing from channel configuration mask and VREFN bit was
> included twice instead which fails to enable positive reference buffer when
> requested by a channel. Channels that don't enable vrefp buffer were not
> affected.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Julia Lawall <julia.lawall@lip6.fr>
> Signed-off-by: Ibrahim Tilki <Ibrahim.Tilki@analog.com>
Applied and I added a fixes tag (given I've just rebased for a broken fixes tag
I'm glad you didn't as it would have been wrong anyway!)

Thanks,

Jonathan

> ---
>  drivers/iio/adc/max11410.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/max11410.c b/drivers/iio/adc/max11410.c
> index 8cd5663671..fdc9f03135 100644
> --- a/drivers/iio/adc/max11410.c
> +++ b/drivers/iio/adc/max11410.c
> @@ -370,7 +370,7 @@ static int max11410_configure_channel(struct max11410_state *st,
>  		 FIELD_PREP(MAX11410_CTRL_UNIPOLAR_BIT, cfg.bipolar ? 0 : 1);
>  	ret = regmap_update_bits(st->regmap, MAX11410_REG_CTRL,
>  				 MAX11410_CTRL_REFSEL_MASK |
> -				 MAX11410_CTRL_VREFN_BUF_BIT |
> +				 MAX11410_CTRL_VREFP_BUF_BIT |
>  				 MAX11410_CTRL_VREFN_BUF_BIT |
>  				 MAX11410_CTRL_UNIPOLAR_BIT, regval);
>  	if (ret)

