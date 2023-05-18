Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E73F6707DCF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 12:16:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230396AbjERKP6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 06:15:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230418AbjERKPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 06:15:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C43C6269E
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 03:15:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 71ED161DA1
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 10:14:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD585C4339B;
        Thu, 18 May 2023 10:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684404867;
        bh=R8KFE+mMzR0aZs3lJPqTVG74O5pymfV/W6ghJb7wJVI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s1IvXN/cuDGlTG4I6ZqVNWpZMMzBosy5LyEhJgmrEXro7gy3U/YmGXM27b8SjMlFi
         iTg/Y4RG3DToT7Eh2N5kOtIBMWLp3js0UxHJyjjFTMw9pCGOIE8JfrGbsugn8kdMcC
         aFAcFnOQIDeIUQQ17rA2cCqenGI4w5JdtFBxDHTHvPJVmRG8SqJDG7aDcYo5jKrZDB
         XpWo88zdsSlmUX6FfCes44y7iy7zQWtRL+fKR3gvT4b3U18XI6xJ017V4F0Ia6uub0
         yI4iJyvFKx+KpznlCVnLTN3MfOTxaQ3aIulizvibwztNGwt9Z/XggSfDmu9jDezWVG
         1KqKxU9V+Pqrw==
Date:   Thu, 18 May 2023 11:14:23 +0100
From:   Lee Jones <lee@kernel.org>
To:     Naresh Solanki <naresh.solanki@9elements.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mfd: max5970: Rename driver and remove wildcard
Message-ID: <20230518101423.GE404509@google.com>
References: <20230427113046.3971425-1-Naresh.Solanki@9elements.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230427113046.3971425-1-Naresh.Solanki@9elements.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Apr 2023, Naresh Solanki wrote:

> The previous version of this driver included wildcards in file names
> and descriptions. This patch renames the driver to only support MAX5970
> and MAX5978, which are the only chips that the driver actually supports.

So multiple devices are supported:

  MAX5970  ... AND
  MAX5978  ... thus
  MAX597X  ... does make sense, no?
 
 What are you trying to achieve?

> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
> ---
>  drivers/mfd/Kconfig                        |  4 ++--
>  drivers/mfd/simple-mfd-i2c.c               | 18 +++++++++---------
>  include/linux/mfd/{max597x.h => max5970.h} | 16 ++++++++--------
>  3 files changed, 19 insertions(+), 19 deletions(-)
>  rename include/linux/mfd/{max597x.h => max5970.h} (92%)
> 
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index e90463c4441c..71231388e03c 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -266,8 +266,8 @@ config MFD_MADERA_SPI
>  	  Support for the Cirrus Logic Madera platform audio SoC
>  	  core functionality controlled via SPI.
>  
> -config MFD_MAX597X
> -	tristate "Maxim 597x power switch and monitor"
> +config MFD_MAX5970
> +	tristate "Maxim 5970/5978 power switch and monitor"
>  	depends on (I2C && OF)
>  	select MFD_SIMPLE_MFD_I2C
>  	help
> diff --git a/drivers/mfd/simple-mfd-i2c.c b/drivers/mfd/simple-mfd-i2c.c
> index 20782b4dd172..1f1c007560d8 100644
> --- a/drivers/mfd/simple-mfd-i2c.c
> +++ b/drivers/mfd/simple-mfd-i2c.c
> @@ -72,22 +72,22 @@ static const struct simple_mfd_data silergy_sy7636a = {
>  	.mfd_cell_size = ARRAY_SIZE(sy7636a_cells),
>  };
>  
> -static const struct mfd_cell max597x_cells[] = {
> -	{ .name = "max597x-regulator", },
> -	{ .name = "max597x-iio", },
> -	{ .name = "max597x-led", },
> +static const struct mfd_cell max5970_cells[] = {
> +	{ .name = "max5970-regulator", },
> +	{ .name = "max5970-iio", },
> +	{ .name = "max5970-led", },
>  };
>  
> -static const struct simple_mfd_data maxim_max597x = {
> -	.mfd_cell = max597x_cells,
> -	.mfd_cell_size = ARRAY_SIZE(max597x_cells),
> +static const struct simple_mfd_data maxim_max5970 = {
> +	.mfd_cell = max5970_cells,
> +	.mfd_cell_size = ARRAY_SIZE(max5970_cells),
>  };
>  
>  static const struct of_device_id simple_mfd_i2c_of_match[] = {
>  	{ .compatible = "kontron,sl28cpld" },
>  	{ .compatible = "silergy,sy7636a", .data = &silergy_sy7636a},
> -	{ .compatible = "maxim,max5970", .data = &maxim_max597x},
> -	{ .compatible = "maxim,max5978", .data = &maxim_max597x},
> +	{ .compatible = "maxim,max5970", .data = &maxim_max5970},
> +	{ .compatible = "maxim,max5978", .data = &maxim_max5970},
>  	{}
>  };
>  MODULE_DEVICE_TABLE(of, simple_mfd_i2c_of_match);
> diff --git a/include/linux/mfd/max597x.h b/include/linux/mfd/max5970.h
> similarity index 92%
> rename from include/linux/mfd/max597x.h
> rename to include/linux/mfd/max5970.h
> index a850b2e02e6a..762a7d40c843 100644
> --- a/include/linux/mfd/max597x.h
> +++ b/include/linux/mfd/max5970.h
> @@ -7,25 +7,25 @@
>   * Author: Patrick Rudolph <patrick.rudolph@9elements.com>
>   */
>  
> -#ifndef _MFD_MAX597X_H
> -#define _MFD_MAX597X_H
> +#ifndef _MFD_MAX5970_H
> +#define _MFD_MAX5970_H
>  
>  #include <linux/regmap.h>
>  
>  #define MAX5970_NUM_SWITCHES 2
>  #define MAX5978_NUM_SWITCHES 1
> -#define MAX597X_NUM_LEDS     4
> +#define MAX5970_NUM_LEDS     4
>  
> -struct max597x_data {
> +struct max5970_data {
>  	int num_switches;
>  	u32 irng[MAX5970_NUM_SWITCHES];
>  	u32 mon_rng[MAX5970_NUM_SWITCHES];
>  	u32 shunt_micro_ohms[MAX5970_NUM_SWITCHES];
>  };
>  
> -enum max597x_chip_type {
> -	MAX597x_TYPE_MAX5978 = 1,
> -	MAX597x_TYPE_MAX5970,
> +enum max5970_chip_type {
> +	TYPE_MAX5978 = 1,
> +	TYPE_MAX5970,
>  };
>  
>  #define MAX5970_REG_CURRENT_L(ch)		(0x01 + (ch) * 4)
> @@ -93,4 +93,4 @@ enum max597x_chip_type {
>  #define MAX_REGISTERS			0x49
>  #define ADC_MASK			0x3FF
>  
> -#endif				/* _MFD_MAX597X_H */
> +#endif				/* _MFD_MAX5970_H */
> 
> base-commit: b4c288cfd2f84c44994330c408e14645d45dee5b
> -- 
> 2.39.1
> 

-- 
Lee Jones [李琼斯]
