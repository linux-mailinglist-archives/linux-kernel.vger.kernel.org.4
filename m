Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 879F561E4DF
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 18:25:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230339AbiKFRZ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 12:25:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229985AbiKFRZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 12:25:24 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A06D9114;
        Sun,  6 Nov 2022 09:25:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5D1B5B80B2F;
        Sun,  6 Nov 2022 17:25:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 939DFC433D6;
        Sun,  6 Nov 2022 17:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667755521;
        bh=e82KjLGJkQfImKjPXj9sUI2Xk2nqoAZxHSjqDeIcDxM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=iYJOAq+3q4EA3ILvjEI/NvBkCoEzJDIE28xJUwxSP8WRH5lPSciR1c9Jx6HNoD/Sa
         fTqp7FfbeGLW8mWqng4VjEj6E07K2F+NJnaJq3finTN7s3lLvpLqk0Hl9QUF5E9bS4
         DLeWm3CuTp87aMqqLJ8MuWApQXLrWvPB8bk3PuxiecWn8Wn2CBufOjwIBpa3W1VkwZ
         zA7bdDW6fAfy6h3ruZ2kIlFbPB1CwutScOpVljRdi7+/ZifhiQEh7ueC/OBEcFLAKY
         hxP/cwweWp/ti0nRFdzRpoMUkI5vAx2Kg0VT7l1QyvObDaF4hiNLWDDgILUTEjCphZ
         8tjV6DsfLre+Q==
Date:   Sun, 6 Nov 2022 17:25:10 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Angel Iglesias <ang.iglesiasg@gmail.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 2/2] iio: pressure: bmp280: convert to i2c's
 .probe_new()
Message-ID: <20221106172510.144f7bf4@jic23-huawei>
In-Reply-To: <237d16807630c6f2a9d2864521228b9d837984b6.1667750698.git.ang.iglesiasg@gmail.com>
References: <cover.1667750698.git.ang.iglesiasg@gmail.com>
        <237d16807630c6f2a9d2864521228b9d837984b6.1667750698.git.ang.iglesiasg@gmail.com>
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

On Sun,  6 Nov 2022 17:43:16 +0100
Angel Iglesias <ang.iglesiasg@gmail.com> wrote:

> Use i2c_client_get_device_id() to get the i2c_device_id* parameter in the
> .new_probe() callback.
> 
> Signed-off-by: Angel Iglesias <ang.iglesiasg@gmail.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

I'm fine with Wolfram picking this up as an example of using the new code,
or I can take it through IIO after merging Wolfram's immutable branch.

So for option 1:
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> 
> diff --git a/drivers/iio/pressure/bmp280-i2c.c b/drivers/iio/pressure/bmp280-i2c.c
> index 0c27211f3ea0..14eab086d24a 100644
> --- a/drivers/iio/pressure/bmp280-i2c.c
> +++ b/drivers/iio/pressure/bmp280-i2c.c
> @@ -5,11 +5,11 @@
>  
>  #include "bmp280.h"
>  
> -static int bmp280_i2c_probe(struct i2c_client *client,
> -			    const struct i2c_device_id *id)
> +static int bmp280_i2c_probe(struct i2c_client *client)
>  {
>  	struct regmap *regmap;
>  	const struct regmap_config *regmap_config;
> +	const struct i2c_device_id *id = i2c_client_get_device_id(client);
>  
>  	switch (id->driver_data) {
>  	case BMP180_CHIP_ID:
> @@ -65,7 +65,7 @@ static struct i2c_driver bmp280_i2c_driver = {
>  		.of_match_table = bmp280_of_i2c_match,
>  		.pm = pm_ptr(&bmp280_dev_pm_ops),
>  	},
> -	.probe		= bmp280_i2c_probe,
> +	.probe_new	= bmp280_i2c_probe,
>  	.id_table	= bmp280_i2c_id,
>  };
>  module_i2c_driver(bmp280_i2c_driver);

