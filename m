Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F6067018F5
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 20:07:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234043AbjEMSHx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 14:07:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235216AbjEMSHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 14:07:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38181171E;
        Sat, 13 May 2023 11:07:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C855661B84;
        Sat, 13 May 2023 18:07:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F4ACC433EF;
        Sat, 13 May 2023 18:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684001232;
        bh=/F+5Gn4t4lhKm49bYUfuuizxiZujuf++3EirSVYEsXU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=b9qYkrJWk2lZsb5SYLDaoYSVpNUJ1fMmsf7fR7kroIK6WBv4gz/NPwznAfAWRGDRK
         1FmKeYWWWbUud95CWbYs8emvEA4LRTaMdCOgA0IpAm+jsN1ZHoLqX1SADMrFFbxbqZ
         92wY4QH5jtY1fgXR41mYHx0Gznqg3a7nljGZk+7zwyrbGckYIWXt+WoQENcPxVPXui
         Ds30n0qO/5CPvLhJgX1OF20gtRrOm5iXVl7GuRa+W9iNBhJb0ywXgF7C2Uuay6Uoyq
         F4JBFO3IHdf0m+EKM3Eycrtb6vVkaIfeYZp96tWbblEkmPF4oj9nX/pleOp0vFV1wG
         7xuWY+XA1+Pmw==
Date:   Sat, 13 May 2023 19:23:13 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] iio: bu27034: Ensure reset is written
Message-ID: <20230513192313.57e1dd21@jic23-huawei>
In-Reply-To: <ZFjWhbfuN5XcKty+@fedora>
References: <ZFjWhbfuN5XcKty+@fedora>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 May 2023 14:01:25 +0300
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> The reset bit must be always written to the hardware no matter what value
> is in a cache or register. Ensure this by using regmap_write_bits()
> instead of the regmap_update_bits(). Furthermore, the SWRESET bit may be
> self-clearing, so mark the SYSTEM_CONTROL register volatile to guarantee
> we do also read the right state - should we ever need to read it.
> 
> Finally, writing the SWRESET bit will restore the default register
> values. This can cause register cache to be outdated if there are any
> register values cached.
> 
> Rebuild register cache after SWRESET and use regmap_update_bits() when
> performing the reset.
> 
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> Fixes: e52afbd61039 ("iio: light: ROHM BU27034 Ambient Light Sensor")

Still unclear to me if we should treat the register as volatile as hitting
relevant bits causes a reset of the whole device anyway, but meh, it doesn't
cause any problems and it's your driver.

Applied to the fixes-togreg branch of iio.git

Thanks,

Jonathan

> 
> ---
> v3: Combined patches:
> ("iio: bu27034: Ensure reset is written")
> https://lore.kernel.org/lkml/ZFIw%2FKdApZe1euN8@fedora/
> ("iio: bu27034: Reinit regmap cache after reset")
> https://lore.kernel.org/lkml/ZFM7lE4ZuDrUTspH@fedora/
> ---
>  drivers/iio/light/rohm-bu27034.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/light/rohm-bu27034.c b/drivers/iio/light/rohm-bu27034.c
> index 25c9b79574a5..f85194fda6b0 100644
> --- a/drivers/iio/light/rohm-bu27034.c
> +++ b/drivers/iio/light/rohm-bu27034.c
> @@ -231,6 +231,9 @@ struct bu27034_result {
>  
>  static const struct regmap_range bu27034_volatile_ranges[] = {
>  	{
> +		.range_min = BU27034_REG_SYSTEM_CONTROL,
> +		.range_max = BU27034_REG_SYSTEM_CONTROL,
> +	}, {
>  		.range_min = BU27034_REG_MODE_CONTROL4,
>  		.range_max = BU27034_REG_MODE_CONTROL4,
>  	}, {
> @@ -1272,12 +1275,19 @@ static int bu27034_chip_init(struct bu27034_data *data)
>  	int ret, sel;
>  
>  	/* Reset */
> -	ret = regmap_update_bits(data->regmap, BU27034_REG_SYSTEM_CONTROL,
> +	ret = regmap_write_bits(data->regmap, BU27034_REG_SYSTEM_CONTROL,
>  			   BU27034_MASK_SW_RESET, BU27034_MASK_SW_RESET);
>  	if (ret)
>  		return dev_err_probe(data->dev, ret, "Sensor reset failed\n");
>  
>  	msleep(1);
> +
> +	ret = regmap_reinit_cache(data->regmap, &bu27034_regmap);
> +	if (ret) {
> +		dev_err(data->dev, "Failed to reinit reg cache\n");
> +		return ret;
> +	}
> +
>  	/*
>  	 * Read integration time here to ensure it is in regmap cache. We do
>  	 * this to speed-up the int-time acquisition in the start of the buffer

