Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3BC56000FF
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 17:59:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbiJPP7U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 11:59:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbiJPP7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 11:59:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70BFD2EF47;
        Sun, 16 Oct 2022 08:59:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DD6B060B82;
        Sun, 16 Oct 2022 15:59:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CE73C433C1;
        Sun, 16 Oct 2022 15:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665935954;
        bh=FWGVnL8JUfeZAW/bYV21gjLyuQl9zuKBduitEbI6BCs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kh9L4nstHqwy+c7OVzQSn5Znex9117jL4cmsO2WD6wxAhx26wo82yTLfnFsPdVNJF
         G83nzAe7Js+e02ZiX2s/sgv+TvLXKQmyOJejyGX89wYowEQYabXAFXXNHYIkHqHB48
         bpZLWBBSW61g1J8YhQb9fMGR04EVIlxLKXpRtK+pGuOXRdCqHCWFUxOO669mjs/VR5
         2eNcFUfDv+R0ma5X5STtLESVLGuHCTdZT8F+DLCpPmvvFjSvGurs2cZMyuOjC6DmNV
         2FdvNCP+eo/b7HQIssx59ZSFY7ivwYC5FeIxWSa9M1z5Dy5G7CT9XfGd+ZELE1d6hQ
         wi8fiF5oYAZqw==
Date:   Sun, 16 Oct 2022 16:59:40 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Alexandru Tachici <alexandru.tachici@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 06/14] iio: ad7192: Simplify using
 devm_regulator_get_enable()
Message-ID: <20221016165940.792e15a2@jic23-huawei>
In-Reply-To: <9719c445c095d3d308e2fc9f4f93294f5806c41c.1660934107.git.mazziesaccount@gmail.com>
References: <cover.1660934107.git.mazziesaccount@gmail.com>
        <9719c445c095d3d308e2fc9f4f93294f5806c41c.1660934107.git.mazziesaccount@gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Aug 2022 22:19:01 +0300
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> Use devm_regulator_get_enable() instead of open coded get, enable,
> add-action-to-disable-at-detach - pattern. Also drop the seemingly unused
> struct member 'dvdd'.
> 
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
Now the required dependencies are upstream...

Applied to the togreg branch of iio.git.

Thanks,

Jonathan

> 
> ---
> v2 => v3
> Split to own patch.
> ---
>  drivers/iio/adc/ad7192.c | 15 ++-------------
>  1 file changed, 2 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
> index d71977be7d22..8a52c0dec3f9 100644
> --- a/drivers/iio/adc/ad7192.c
> +++ b/drivers/iio/adc/ad7192.c
> @@ -177,7 +177,6 @@ struct ad7192_chip_info {
>  struct ad7192_state {
>  	const struct ad7192_chip_info	*chip_info;
>  	struct regulator		*avdd;
> -	struct regulator		*dvdd;
>  	struct clk			*mclk;
>  	u16				int_vref_mv;
>  	u32				fclk;
> @@ -1015,19 +1014,9 @@ static int ad7192_probe(struct spi_device *spi)
>  	if (ret)
>  		return ret;
>  
> -	st->dvdd = devm_regulator_get(&spi->dev, "dvdd");
> -	if (IS_ERR(st->dvdd))
> -		return PTR_ERR(st->dvdd);
> -
> -	ret = regulator_enable(st->dvdd);
> -	if (ret) {
> -		dev_err(&spi->dev, "Failed to enable specified DVdd supply\n");
> -		return ret;
> -	}
> -
> -	ret = devm_add_action_or_reset(&spi->dev, ad7192_reg_disable, st->dvdd);
> +	ret = devm_regulator_get_enable(&spi->dev, "dvdd");
>  	if (ret)
> -		return ret;
> +		return dev_err_probe(&spi->dev, ret, "Failed to enable specified DVdd supply\n");
>  
>  	ret = regulator_get_voltage(st->avdd);
>  	if (ret < 0) {

