Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90365626AA3
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 17:38:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234542AbiKLQil (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 11:38:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234974AbiKLQii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 11:38:38 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E649E13FBD;
        Sat, 12 Nov 2022 08:38:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 82D8860C02;
        Sat, 12 Nov 2022 16:38:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 758F2C433C1;
        Sat, 12 Nov 2022 16:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668271115;
        bh=KEiKqzioFQGruCHYGHrlQ43igNpeASPP8FviAOa/NZM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Rr8x0S3uFDthtVzGeycWVrrgBqYy+QwCgAUyOeZb9hJisjSEHuqIcDE69dk9Tj8ku
         Qk/fGQbT37XgGL1E5XUTpGstaTF85HGQzWn7BLe7Kfioq7H4f6YOOfcxpVbJ3yGNuS
         NWvvR12jEB0tETWqFH+4VM9Y0/9eDr+SarieuNJqzyXMpi/oXwqnN8ebgAoagV/qPJ
         8YPDx7wUS21Yv8sMg8ZgX7iYioZbDxVy9dpO6vtDCqatacu+VQvARvRlgk3SGkr/yC
         6l2xr3RluoVFTR6oB7H2UOQThfkqunUgJJSJkrcvTaYLrG2JZDFwq5KIGWIZ8VBDJI
         vQDayv/ZL1zvw==
Date:   Sat, 12 Nov 2022 16:50:49 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] iio: addac: ad74413r: add spi_device_id table
Message-ID: <20221112165049.51a5f391@jic23-huawei>
In-Reply-To: <20221111143921.742194-2-linux@rasmusvillemoes.dk>
References: <20221111143921.742194-1-linux@rasmusvillemoes.dk>
        <20221111143921.742194-2-linux@rasmusvillemoes.dk>
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

On Fri, 11 Nov 2022 15:39:17 +0100
Rasmus Villemoes <linux@rasmusvillemoes.dk> wrote:

> Silence the run-time warning
> 
>   SPI driver ad74413r has no spi_device_id for adi,ad74412r
> 
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> ---
>  drivers/iio/addac/ad74413r.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/iio/addac/ad74413r.c b/drivers/iio/addac/ad74413r.c
> index 899bcd83f40b..37485be88a63 100644
> --- a/drivers/iio/addac/ad74413r.c
> +++ b/drivers/iio/addac/ad74413r.c
> @@ -1457,12 +1457,20 @@ static const struct of_device_id ad74413r_dt_id[] = {
>  };
>  MODULE_DEVICE_TABLE(of, ad74413r_dt_id);
>  
> +static const struct spi_device_id ad74413r_spi_id[] = {
> +	{ .name = "ad74412r", .driver_data = (kernel_ulong_t)&ad74412r_chip_info_data },
> +	{ .name = "ad74413r", .driver_data = (kernel_ulong_t)&ad74413r_chip_info_data },
> +	{},
Trivial, but prefer not to have a comma after a "NULL" terminator like this.
It would never make sense to add anything after it in the array.
Now you are matching existing driver style, but I'd still rather not see more
instances of this added.

Also, driver_data is not currently used. It should be because adding this
spi_id table means the driver can be probed via various routes where
device_get_match_data() == NULL. 

Hence, alongside this change you need to have a fallback to cover that case.
Something along the lines of...

	st->chip_info = device_get_match_data(..);
	if (!st->chip_info) {
		struct spi_device_id *id = spi_get_device_id();
		if (!id)
			return -EINVAL;

		st->chip_info = (void *)id->driver_data;
		//or better yet cast to the correct type I'm just too lazy to look it up ;)
		if (!st->chip_info)
			return -EINVAL;

	}
> +};
> +MODULE_DEVICE_TABLE(spi, ad74413r_spi_id);
> +
>  static struct spi_driver ad74413r_driver = {
>  	.driver = {
>  		   .name = "ad74413r",
>  		   .of_match_table = ad74413r_dt_id,
>  	},
>  	.probe = ad74413r_probe,
> +	.id_table = ad74413r_spi_id,
>  };
>  
>  module_driver(ad74413r_driver,

