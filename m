Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 532EA602811
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 11:15:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231225AbiJRJPE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 05:15:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbiJRJPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 05:15:01 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 883E73DBFF;
        Tue, 18 Oct 2022 02:14:56 -0700 (PDT)
Received: from fraeml712-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Ms7Qn1lQ3z67NLc;
        Tue, 18 Oct 2022 17:11:45 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml712-chm.china.huawei.com (10.206.15.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 18 Oct 2022 11:14:53 +0200
Received: from localhost (10.202.226.42) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 18 Oct
 2022 10:14:53 +0100
Date:   Tue, 18 Oct 2022 10:14:52 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Daniel Mack <daniel@zonque.org>,
        "Haojian Zhuang" <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v1 6/6] spi: pxa2xx: Switch from PM ifdeffery to
 pm_ptr()
Message-ID: <20221018101452.0000001c@huawei.com>
In-Reply-To: <20221017171243.57078-6-andriy.shevchenko@linux.intel.com>
References: <20221017171243.57078-1-andriy.shevchenko@linux.intel.com>
        <20221017171243.57078-6-andriy.shevchenko@linux.intel.com>
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

On Mon, 17 Oct 2022 20:12:43 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> Cleaning up the driver to use pm_ptr() macro instead of ifdeffery
> that makes it simpler and allows the compiler to remove those functions
> if built without CONFIG_PM and CONFIG_PM_SLEEP support.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
FWIW I like these - so drive by review.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

I think you could change the handling of !pm_runtime_suspended()
to use pm_runtime_force_suspend() and equivalent for resume path.
I haven't checked that closely though - just looks like a typical
usecase for those functions that are hardened against some of
the corner cases that can occur in interactions between different
forms of pm.


> ---
>  drivers/spi/spi-pxa2xx.c | 11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
> index 76046612466d..60cab241200b 100644
> --- a/drivers/spi/spi-pxa2xx.c
> +++ b/drivers/spi/spi-pxa2xx.c
> @@ -1680,7 +1680,6 @@ static int pxa2xx_spi_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> -#ifdef CONFIG_PM_SLEEP
>  static int pxa2xx_spi_suspend(struct device *dev)
>  {
>  	struct driver_data *drv_data = dev_get_drvdata(dev);
> @@ -1715,9 +1714,7 @@ static int pxa2xx_spi_resume(struct device *dev)
>  	/* Start the queue running */
>  	return spi_controller_resume(drv_data->controller);
>  }
> -#endif
>  
> -#ifdef CONFIG_PM
>  static int pxa2xx_spi_runtime_suspend(struct device *dev)
>  {
>  	struct driver_data *drv_data = dev_get_drvdata(dev);
> @@ -1732,12 +1729,10 @@ static int pxa2xx_spi_runtime_resume(struct device *dev)
>  
>  	return clk_prepare_enable(drv_data->ssp->clk);
>  }
> -#endif
>  
>  static const struct dev_pm_ops pxa2xx_spi_pm_ops = {
> -	SET_SYSTEM_SLEEP_PM_OPS(pxa2xx_spi_suspend, pxa2xx_spi_resume)
> -	SET_RUNTIME_PM_OPS(pxa2xx_spi_runtime_suspend,
> -			   pxa2xx_spi_runtime_resume, NULL)
> +	SYSTEM_SLEEP_PM_OPS(pxa2xx_spi_suspend, pxa2xx_spi_resume)
> +	RUNTIME_PM_OPS(pxa2xx_spi_runtime_suspend, pxa2xx_spi_runtime_resume, NULL)
>  };
>  
>  #ifdef CONFIG_ACPI
> @@ -1762,7 +1757,7 @@ MODULE_DEVICE_TABLE(of, pxa2xx_spi_of_match);
>  static struct platform_driver driver = {
>  	.driver = {
>  		.name	= "pxa2xx-spi",
> -		.pm	= &pxa2xx_spi_pm_ops,
> +		.pm	= pm_ptr(&pxa2xx_spi_pm_ops),
>  		.acpi_match_table = ACPI_PTR(pxa2xx_spi_acpi_match),
>  		.of_match_table = of_match_ptr(pxa2xx_spi_of_match),
>  	},

