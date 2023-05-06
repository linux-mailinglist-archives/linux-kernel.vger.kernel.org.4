Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 441DB6F9386
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 20:11:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbjEFSLN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 14:11:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjEFSLL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 14:11:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6352512E8D;
        Sat,  6 May 2023 11:11:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E3BA960920;
        Sat,  6 May 2023 18:11:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 561E3C433EF;
        Sat,  6 May 2023 18:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683396669;
        bh=QjZcL8y5D7KAx3x7BxWOJfEfiy6Po3Zh5Efa6SNbl3o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fLVEDIbyoo3limReVYuSDFg4elF9sc8kS56S7SCksH57mSM982cFrhCTag1QuG8Qb
         cosPKH8AHrOUarVjx/BLBkSij8TKBdkkq25AXLx2jyOQqSZ7FT31TeISkVNlUZ0QAx
         d96ETMDugSZA9Sd1/JceZFr2A+++ccRAL3/I9ERRxgTp+ahoM6AQ5igU6CgrcJPCDF
         YbqkKjHKsJaU8f/ZEkVqVX5knUh7LG6jIRx9Oy2grdtcs/Szr+2tcsCzwJOsGKmIf6
         QMR26BUxrFJx5QPgRXa/FKyFks8hlwG8fz/tynePAsbQzDP4s6juleJoTKg26KVfvT
         zKIkCzrLXVbsw==
Date:   Sat, 6 May 2023 19:27:02 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: bu27034: Ensure reset is written
Message-ID: <20230506192702.57ebf533@jic23-huawei>
In-Reply-To: <ZFIw/KdApZe1euN8@fedora>
References: <ZFIw/KdApZe1euN8@fedora>
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

On Wed, 3 May 2023 13:01:32 +0300
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> The reset bit must be always written to the hardware no matter what value
> is in a cache or register. Ensure this by using regmap_write_bits()
> instead of the regmap_update_bits(). Furthermore, the RESET bit may be
> self-clearing, so mark the SYSTEM_CONTROL register volatile to guarantee
> we do also read the right state - should we ever need to read it.
> 
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> Fixes: e52afbd61039 ("iio: light: ROHM BU27034 Ambient Light Sensor")

This obviously interacts with the regcache update.

Fun question is whether a register is volatile if it results in all
registers (including itself) resetting.  In my view, no it isn't volatile.
So fixing the regcache stuff as in your other patch is more appropriate.

Jonathan

> 
> ---
> Changelog:
> v1 => v2:
>   - Fix SoB tag
> 
> 
> I haven't verified if the reset bit is self-clearin as I did temporarily
> give away the HW.
> 
> In worst case the bit is not self clearing - but we don't really
> get performance penalty even if we set the register volatile because the
> SYSTEM_CONTROL register only has the part-ID and the reset fields. The
> part-id is only read once at probe.
> 
> ---
>  drivers/iio/light/rohm-bu27034.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/light/rohm-bu27034.c b/drivers/iio/light/rohm-bu27034.c
> index 25c9b79574a5..740ebd86b6e5 100644
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
> @@ -1272,7 +1275,7 @@ static int bu27034_chip_init(struct bu27034_data *data)
>  	int ret, sel;
>  
>  	/* Reset */
> -	ret = regmap_update_bits(data->regmap, BU27034_REG_SYSTEM_CONTROL,
> +	ret = regmap_write_bits(data->regmap, BU27034_REG_SYSTEM_CONTROL,
>  			   BU27034_MASK_SW_RESET, BU27034_MASK_SW_RESET);
>  	if (ret)
>  		return dev_err_probe(data->dev, ret, "Sensor reset failed\n");
> 
> base-commit: 7fcbd72176076c44b47e8f68f0223c02c411f420

