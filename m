Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3F6A655213
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 16:31:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236499AbiLWPbq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 10:31:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231423AbiLWPbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 10:31:43 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94C2D63FD;
        Fri, 23 Dec 2022 07:31:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 313F16150C;
        Fri, 23 Dec 2022 15:31:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C14B1C433D2;
        Fri, 23 Dec 2022 15:31:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671809500;
        bh=Yv990aidhbKkTEJvdoOyJvp9FxAYjDIxP+cgiiuIyv8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=XJzBsc1QdbvzKgxYeXFnYdycVxsbK/dRc1bsNlglPTTPcjnbJP8qm8FYKqsOkicXH
         g/9WQhIGbb3B5nXIv32QFQBi8vFpmvYBzZGqxFVNMVnMIdav4Dm2ff3l3Gk0IFpyYW
         3aNhs6sOBGBbKSOuMXgYci0zn2r+hq9DAHnp7UzeRWPG37wPuNSMI2Pw6Chu+6pvY1
         Kfd1Z84qlnVT8oi3jANw+UzuCa0YX6iEEPsVYEqb2rfram5zThKf/IuGK1zwZVyR1J
         ijqpoxQa6Sc2JBTX2o6Ubou6YSF0zv7F76Q5AyqvIWG3gyGsUm16M3Red/aJ8DflPP
         P6CxxBg8WenSA==
Date:   Fri, 23 Dec 2022 15:44:50 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v1 1/2] iio: adc: ti-adc128s052: Switch to use
 spi_get_device_match_data()
Message-ID: <20221223154450.458771b8@jic23-huawei>
In-Reply-To: <20221223152242.2ee926eb@jic23-huawei>
References: <20221214114944.83790-1-andriy.shevchenko@linux.intel.com>
        <20221223152242.2ee926eb@jic23-huawei>
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

On Fri, 23 Dec 2022 15:22:42 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> On Wed, 14 Dec 2022 13:49:43 +0200
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> 
> > The spi_get_device_match_data() helps to get driver data from the
> > firmware node or SPI ID table. Use it instead of open coding.
> > 
> > While at it, switch ID tables to provide an acrual pointers to
> > the configuration data.
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > ---
> > 
> > Requires aea672d054a2 ("spi: Introduce spi_get_device_match_data()
> > helper") which is part of upstream as of today.  
> 
> I rebased to get that (will rebase again on rc1).
> 
> Applied to the togreg branch of iio.git and pushed out as testing
> to keep 0-day busy over my holidays.

I take it back...  Build test failed...

> 
> Jonathan
> 
> > 
> >  drivers/iio/adc/ti-adc128s052.c | 39 +++++++++++++++------------------
> >  1 file changed, 18 insertions(+), 21 deletions(-)
> > 
> > diff --git a/drivers/iio/adc/ti-adc128s052.c b/drivers/iio/adc/ti-adc128s052.c
> > index b3d5b9b7255b..9dfc625100b6 100644
> > --- a/drivers/iio/adc/ti-adc128s052.c
> > +++ b/drivers/iio/adc/ti-adc128s052.c
> > @@ -139,16 +139,11 @@ static void adc128_disable_regulator(void *reg)
> >  
> >  static int adc128_probe(struct spi_device *spi)
> >  {
> > +	const struct adc128_configuration *config;
> >  	struct iio_dev *indio_dev;
> > -	unsigned int config;
> >  	struct adc128 *adc;
> >  	int ret;
> >  
> > -	if (dev_fwnode(&spi->dev))
> > -		config = (unsigned long) device_get_match_data(&spi->dev);
> > -	else
> > -		config = spi_get_device_id(spi)->driver_data;
> > -
> >  	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*adc));
> >  	if (!indio_dev)
> >  		return -ENOMEM;
> > @@ -160,6 +155,8 @@ static int adc128_probe(struct spi_device *spi)
> >  	indio_dev->modes = INDIO_DIRECT_MODE;
> >  	indio_dev->info = &adc128_info;
> >  
> > +	config = spi_get_device_match_data(&spi->dev);
Takes a struct spi_device*

Also, having opened code up to fix this, we have a spi_get_device_id() left
just above that needs dealing with.

And a lot of uses of config below that need fixing.

I'm dropping this series until that's all fixed up.

Jonathan



> > +
> >  	indio_dev->channels = adc128_config[config].channels;
> >  	indio_dev->num_channels = adc128_config[config].num_channels;
> >  
> > @@ -181,32 +178,32 @@ static int adc128_probe(struct spi_device *spi)
> >  }
> >  
> >  static const struct of_device_id adc128_of_match[] = {
> > -	{ .compatible = "ti,adc128s052", .data = (void*)0L, },
> > -	{ .compatible = "ti,adc122s021", .data = (void*)1L, },
> > -	{ .compatible = "ti,adc122s051", .data = (void*)1L, },
> > -	{ .compatible = "ti,adc122s101", .data = (void*)1L, },
> > -	{ .compatible = "ti,adc124s021", .data = (void*)2L, },
> > -	{ .compatible = "ti,adc124s051", .data = (void*)2L, },
> > -	{ .compatible = "ti,adc124s101", .data = (void*)2L, },
> > +	{ .compatible = "ti,adc128s052", .data = &adc128_config[0] },
> > +	{ .compatible = "ti,adc122s021", .data = &adc128_config[1] },
> > +	{ .compatible = "ti,adc122s051", .data = &adc128_config[1] },
> > +	{ .compatible = "ti,adc122s101", .data = &adc128_config[1] },
> > +	{ .compatible = "ti,adc124s021", .data = &adc128_config[2] },
> > +	{ .compatible = "ti,adc124s051", .data = &adc128_config[2] },
> > +	{ .compatible = "ti,adc124s101", .data = &adc128_config[2] },
> >  	{ /* sentinel */ },
> >  };
> >  MODULE_DEVICE_TABLE(of, adc128_of_match);
> >  
> >  static const struct spi_device_id adc128_id[] = {
> > -	{ "adc128s052", 0 },	/* index into adc128_config */
> > -	{ "adc122s021",	1 },
> > -	{ "adc122s051",	1 },
> > -	{ "adc122s101",	1 },
> > -	{ "adc124s021", 2 },
> > -	{ "adc124s051", 2 },
> > -	{ "adc124s101", 2 },
> > +	{ "adc128s052", (kernel_ulong_t)&adc128_config[0] },
> > +	{ "adc122s021",	(kernel_ulong_t)&adc128_config[1] },
> > +	{ "adc122s051",	(kernel_ulong_t)&adc128_config[1] },
> > +	{ "adc122s101",	(kernel_ulong_t)&adc128_config[1] },
> > +	{ "adc124s021", (kernel_ulong_t)&adc128_config[2] },
> > +	{ "adc124s051", (kernel_ulong_t)&adc128_config[2] },
> > +	{ "adc124s101", (kernel_ulong_t)&adc128_config[2] },
> >  	{ }
> >  };
> >  MODULE_DEVICE_TABLE(spi, adc128_id);
> >  
> >  #ifdef CONFIG_ACPI
> >  static const struct acpi_device_id adc128_acpi_match[] = {
> > -	{ "AANT1280", 2 }, /* ADC124S021 compatible ACPI ID */
> > +	{ "AANT1280", (kernel_ulong_t)&adc128_config[2] },
> >  	{ }
> >  };
> >  MODULE_DEVICE_TABLE(acpi, adc128_acpi_match);  
> 

