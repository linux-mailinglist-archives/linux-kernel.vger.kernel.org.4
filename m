Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4CBF612375
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 16:07:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbiJ2OG6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 10:06:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbiJ2OGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 10:06:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 706411C414;
        Sat, 29 Oct 2022 07:06:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 08F7460AB2;
        Sat, 29 Oct 2022 14:06:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47383C433D6;
        Sat, 29 Oct 2022 14:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667052413;
        bh=mw/F8OFLAgejD/aXIyUkv73wixGgwK/udqyK3fMoweA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=B7ywb3mKxrpo+OglEUmVNX0+otzqYbJCqpFdFOKF+O4Sci/9u9ZjHWRCCYZCvL+Tw
         KVWPYlCrFAOIgrrQtu23Wi0HfSi34d9Hffv4T7sdPTW2c/d4Oh6Kk9BoUltLBMDrgn
         pqPdnp+whCnNKg8m0bWkZ5CwnZh7qq2U+YADzJ6+IymlMEIfIzQQmJn0BMy6FVHFdT
         5xbYVzlJLhQbOubE8QfF4V4gi4vC/ULQ9h4Em1eevMfyyLmck8rR6gIG3rtasju3bL
         ZQzKrL9lrFOAsMJwJMcw0QVZdIrmfEhekW4Ma28L0Qa8P/Xd09HqY4ZNuN5LkXOcLh
         kUlwxCPqTDWsQ==
Date:   Sat, 29 Oct 2022 15:18:46 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dmitry Rokosov <DDRokosov@sberdevices.ru>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Jagath Jog J <jagathjog1996@gmail.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/3] iio: accel: Support Kionix/ROHM KX022A
 accelerometer
Message-ID: <20221029151846.399547a7@jic23-huawei>
In-Reply-To: <758b00d6aea0a6431a5a3a78d557d449c113b21e.1666614295.git.mazziesaccount@gmail.com>
References: <cover.1666614295.git.mazziesaccount@gmail.com>
        <758b00d6aea0a6431a5a3a78d557d449c113b21e.1666614295.git.mazziesaccount@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-pc-linux-gnu)
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

On Mon, 24 Oct 2022 15:40:29 +0300
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> KX022A is a 3-axis accelerometer from ROHM/Kionix. The sensor features
> include variable ODRs, I2C and SPI control, FIFO/LIFO with watermark IRQ,
> tap/motion detection, wake-up & back-to-sleep events, four acceleration
> ranges (2, 4, 8 and 16g), and probably some other cool features.
> 
> Add support for the basic accelerometer features such as getting the
> acceleration data via IIO. (raw reads, triggered buffer [data-ready] or
> using the WMI IRQ).
> 
> Important things to be added include the double-tap, motion
> detection and wake-up as well as the runtime power management.
> 
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> 
...
> ---
>  drivers/iio/accel/Kconfig             |   21 +
>  drivers/iio/accel/Makefile            |    3 +
>  drivers/iio/accel/kionix-kx022a-i2c.c |   51 ++
>  drivers/iio/accel/kionix-kx022a-spi.c |   58 ++
>  drivers/iio/accel/kionix-kx022a.c     | 1142 +++++++++++++++++++++++++
>  drivers/iio/accel/kionix-kx022a.h     |   82 ++
>  6 files changed, 1357 insertions(+)
>  create mode 100644 drivers/iio/accel/kionix-kx022a-i2c.c
>  create mode 100644 drivers/iio/accel/kionix-kx022a-spi.c
>  create mode 100644 drivers/iio/accel/kionix-kx022a.c
>  create mode 100644 drivers/iio/accel/kionix-kx022a.h
> 
> diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
> index ffac66db7ac9..b7fd054819d2 100644
> --- a/drivers/iio/accel/Kconfig
> +++ b/drivers/iio/accel/Kconfig
> @@ -409,6 +409,27 @@ config IIO_ST_ACCEL_SPI_3AXIS
>  	  To compile this driver as a module, choose M here. The module
>  	  will be called st_accel_spi.
>  
> +config IIO_KX022A
> +	tristate
> +
> +config IIO_KX022A_SPI
> +	tristate "Kionix KX022A tri-axis digital accelerometer"

Entry should mention SPI / I2C or we have two menu options that are
identical. I'll fix that if nothing else comes up.

> +	depends on SPI
> +	select IIO_KX022A
> +	select REGMAP_SPI
> +	help
> +	  Enable support for the Kionix KX022A digital tri-axis
> +	  accelerometer connected to I2C interface.
