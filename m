Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9B29602813
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 11:16:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231231AbiJRJQI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 05:16:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbiJRJQF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 05:16:05 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C326787FA7;
        Tue, 18 Oct 2022 02:16:04 -0700 (PDT)
Received: from fraeml744-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Ms7Tm2ZwXz687Jl;
        Tue, 18 Oct 2022 17:14:20 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml744-chm.china.huawei.com (10.206.15.225) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 18 Oct 2022 11:16:03 +0200
Received: from localhost (10.202.226.42) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 18 Oct
 2022 10:16:02 +0100
Date:   Tue, 18 Oct 2022 10:16:01 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Daniel Mack <daniel@zonque.org>,
        "Haojian Zhuang" <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v1 5/6] spi: pxa2xx: Move OF and ACPI ID tables closer
 to their user
Message-ID: <20221018101601.00007888@huawei.com>
In-Reply-To: <20221017171243.57078-5-andriy.shevchenko@linux.intel.com>
References: <20221017171243.57078-1-andriy.shevchenko@linux.intel.com>
        <20221017171243.57078-5-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Oct 2022 20:12:42 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> There is no code that uses ID tables directly, except the
> struct device_driver at the end of the file. Hence, move
> tables closer to its user. It's always possible to access
> them via pointer to a platform device.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Seems sensible.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/spi/spi-pxa2xx.c | 38 +++++++++++++++++++-------------------
>  1 file changed, 19 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
> index 31927493eeb0..76046612466d 100644
> --- a/drivers/spi/spi-pxa2xx.c
> +++ b/drivers/spi/spi-pxa2xx.c
> @@ -1321,25 +1321,6 @@ static void cleanup(struct spi_device *spi)
>  	kfree(chip);
>  }
>  
> -#ifdef CONFIG_ACPI
> -static const struct acpi_device_id pxa2xx_spi_acpi_match[] = {
> -	{ "INT33C0" },
> -	{ "INT33C1" },
> -	{ "INT3430" },
> -	{ "INT3431" },
> -	{ "80860F0E" },
> -	{ "8086228E" },
> -	{ },
> -};
> -MODULE_DEVICE_TABLE(acpi, pxa2xx_spi_acpi_match);
> -#endif
> -
> -static const struct of_device_id pxa2xx_spi_of_match[] = {
> -	{ .compatible = "marvell,mmp2-ssp", .data = (void *)MMP2_SSP },
> -	{},
> -};
> -MODULE_DEVICE_TABLE(of, pxa2xx_spi_of_match);
> -
>  static bool pxa2xx_spi_idma_filter(struct dma_chan *chan, void *param)
>  {
>  	return param == chan->device->dev;
> @@ -1759,6 +1740,25 @@ static const struct dev_pm_ops pxa2xx_spi_pm_ops = {
>  			   pxa2xx_spi_runtime_resume, NULL)
>  };
>  
> +#ifdef CONFIG_ACPI
> +static const struct acpi_device_id pxa2xx_spi_acpi_match[] = {
> +	{ "80860F0E" },
> +	{ "8086228E" },
> +	{ "INT33C0" },
> +	{ "INT33C1" },
> +	{ "INT3430" },
> +	{ "INT3431" },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(acpi, pxa2xx_spi_acpi_match);
> +#endif
> +
> +static const struct of_device_id pxa2xx_spi_of_match[] = {
> +	{ .compatible = "marvell,mmp2-ssp", .data = (void *)MMP2_SSP },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, pxa2xx_spi_of_match);
> +
>  static struct platform_driver driver = {
>  	.driver = {
>  		.name	= "pxa2xx-spi",

