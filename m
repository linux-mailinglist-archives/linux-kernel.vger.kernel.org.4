Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C45226551F1
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 16:11:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236492AbiLWPLk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 10:11:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbiLWPLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 10:11:38 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2F2964DC;
        Fri, 23 Dec 2022 07:11:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7AA40B82047;
        Fri, 23 Dec 2022 15:11:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 277A4C433D2;
        Fri, 23 Dec 2022 15:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671808295;
        bh=olkq9IWR84wcE92dY5gbILCkG0WnoHRCUpzxjOONHKA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=IuBIwDhQLT19yWyL3/wMWdgBa28aUEX0d2E43oy8JsvjWtPGb1yW3jih2IKzSPB0D
         xzrQf1sH2CxTKfD4Iqg1Km6RZTMfb0NyFINiQFkdF3mkKgW9W8DZpBbeWVckThNY3Q
         56hOyqfDKCpIB43Rd2/T/Ig0yRYDEd/YnygTaHizTZy1yI7b7fxP9XJDbNB3Yo6I9b
         lScfiUKodqWZezu71EQwXn+XBU3RNNQXy7ZeQUgQf0zvmnyzlrf8tJ2xLRK4/eJpuw
         YE7D9IDK7sGQjQoEcavh4hKMb0ybsj/PgGCJ5uM1M6p4MPRNcDXfmxxTEdOcWZ9ENE
         xdjeIn9rHv9jg==
Date:   Fri, 23 Dec 2022 15:24:44 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v1 2/2] iio: adc: ti-adc128s052: Drop anti-pattern of
 ACPI_PTR() use
Message-ID: <20221223152444.63310805@jic23-huawei>
In-Reply-To: <20221214114944.83790-2-andriy.shevchenko@linux.intel.com>
References: <20221214114944.83790-1-andriy.shevchenko@linux.intel.com>
        <20221214114944.83790-2-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-pc-linux-gnu)
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

On Wed, 14 Dec 2022 13:49:44 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> ACPI_PTR() is more harmful than helpful. For example, in this case
> if CONFIG_ACPI=n, the ID table left unused and code is obfuscated
> by ifdeffery.
> 
> Drop anti-pattern of ACPI_PTR() use.
Longer term I wonder if we should just make ACPI_PTR() work the same
way as pm_ptr() now does so that the visibility is maintained and
we don't need the ifdef magic.

I'm sure there is someone out there somewhere who actually cares about
the minor costs of all these tables for their non ACPI platform and
doing something like that might make everyone happier.

> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Applied.
> ---
>  drivers/iio/adc/ti-adc128s052.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/adc/ti-adc128s052.c b/drivers/iio/adc/ti-adc128s052.c
> index 9dfc625100b6..fc09ee6bb174 100644
> --- a/drivers/iio/adc/ti-adc128s052.c
> +++ b/drivers/iio/adc/ti-adc128s052.c
> @@ -9,7 +9,6 @@
>   * https://www.ti.com/lit/ds/symlink/adc124s021.pdf
>   */
>  
> -#include <linux/acpi.h>
>  #include <linux/err.h>
>  #include <linux/spi/spi.h>
>  #include <linux/module.h>
> @@ -201,19 +200,17 @@ static const struct spi_device_id adc128_id[] = {
>  };
>  MODULE_DEVICE_TABLE(spi, adc128_id);
>  
> -#ifdef CONFIG_ACPI
>  static const struct acpi_device_id adc128_acpi_match[] = {
>  	{ "AANT1280", (kernel_ulong_t)&adc128_config[2] },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(acpi, adc128_acpi_match);
> -#endif
>  
>  static struct spi_driver adc128_driver = {
>  	.driver = {
>  		.name = "adc128s052",
>  		.of_match_table = adc128_of_match,
> -		.acpi_match_table = ACPI_PTR(adc128_acpi_match),
> +		.acpi_match_table = adc128_acpi_match,
>  	},
>  	.probe = adc128_probe,
>  	.id_table = adc128_id,

