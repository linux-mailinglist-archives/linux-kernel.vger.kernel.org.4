Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D50C9701DE0
	for <lists+linux-kernel@lfdr.de>; Sun, 14 May 2023 16:32:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234322AbjENOcm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 10:32:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbjENOcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 10:32:39 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85D6F30CF;
        Sun, 14 May 2023 07:32:36 -0700 (PDT)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id E6AC7240004;
        Sun, 14 May 2023 14:32:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1684074755;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=06LiB1m/4S1iJljwF5Stm/gW1yfN4Sr7PAjYl+bydro=;
        b=oRX4C2sfa8AW337aNspq7cKxaA35IxPUkIlUxc5b+IPYxoAdgMXsLx6TVB0uiJSGG31X9m
        1AOErvwKA+JWuz/wGLKlhB3qAZpHWpN/nD1TeUXx2fWZnbPUH5Y83eGh7RGcnmtWFFljqI
        NioNCWcqchJkeqEdfhmre7AIW23+PCzaTO2LEJrZeTdphz0jpjv0YEFEL6qiE9nynNzvBs
        OXbs+G2eS7dXLYr5pt4XGn18/EbDqFgMd4KuR+6J/+vDqcM7uUuhVK+uTHbWhKAIWoL0+y
        XpKjBl5I3CUFqEdqjw7jm7bxWc1Cie7qBG5R2yY3GWuNdJckTcQLqGHTrsoajw==
Date:   Sun, 14 May 2023 16:32:33 +0200
From:   Herve Codina <herve.codina@bootlin.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v4 2/3] iio: potentiometer: Add support for the Renesas
 X9250 potentiometers
Message-ID: <20230514163233.0c048256@bootlin.com>
In-Reply-To: <20230513193525.43a4475f@jic23-huawei>
References: <20230509160852.158101-1-herve.codina@bootlin.com>
        <20230509160852.158101-3-herve.codina@bootlin.com>
        <20230513193525.43a4475f@jic23-huawei>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonathan,

On Sat, 13 May 2023 19:35:25 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Tue,  9 May 2023 18:08:51 +0200
> Herve Codina <herve.codina@bootlin.com> wrote:
> 
> > The Renesas X9250 integrates four digitally controlled potentiometers.
> > On each potentiometer, the X9250T has a 100 kOhms total resistance and
> > the X9250U has a 50 kOhms total resistance.
> > 
> > Signed-off-by: Herve Codina <herve.codina@bootlin.com>  
> 
> As I only noticed one trivial thing I made the change whilst applying.
> diff --git a/drivers/iio/potentiometer/x9250.c b/drivers/iio/potentiometer/x9250.c
> index 3d4ca18d1f14..7e145d7d14f1 100644
> --- a/drivers/iio/potentiometer/x9250.c
> +++ b/drivers/iio/potentiometer/x9250.c
> @@ -176,10 +176,7 @@ static int x9250_probe(struct spi_device *spi)
>  
>         x9250 = iio_priv(indio_dev);
>         x9250->spi = spi;
> -       x9250->cfg = device_get_match_data(&spi->dev);
> -       if (!x9250->cfg)
> -               x9250->cfg = &x9250_cfg[spi_get_device_id(spi)->driver_data];
> -
> +       x9250->cfg = spi_get_device_match_data(spi);
>         x9250->wp_gpio = devm_gpiod_get_optional(&spi->dev, "wp", GPIOD_OUT_LOW);
>         if (IS_ERR(x9250->wp_gpio))
>                 return dev_err_probe(&spi->dev, PTR_ERR(x9250->wp_gpio),
> 

Are you sure about your modification ?

I am not sure (maybe I am wrong) that
  x9250->cfg = spi_get_device_match_data(spi);
is equivalent to
  x9250->cfg = &x9250_cfg[spi_get_device_id(spi)->driver_data];

The spi_get_device_id(spi)->driver_data value I used is a simple integer
(X9250T or X9250U) and not the x9250_cfg item.
Maybe the x9250_id_table should be modified to replace X9250T by
&x9250_cfg[X9250T] to have your modification working.

The data defined in the driver are the following:
--- 8< ---
static const struct x9250_cfg x9250_cfg[] = {
	[X9250T] = { .name = "x9250t", .kohms =  100, },
	[X9250U] = { .name = "x9250u", .kohms =  50, },
};

...

static const struct of_device_id x9250_of_match[] = {
	{ .compatible = "renesas,x9250t", &x9250_cfg[X9250T]},
	{ .compatible = "renesas,x9250u", &x9250_cfg[X9250U]},
	{ }
};
MODULE_DEVICE_TABLE(of, x9250_of_match);

static const struct spi_device_id x9250_id_table[] = {
	{ "x9250t", X9250T },
	{ "x9250u", X9250U },
	{ }
};
MODULE_DEVICE_TABLE(spi, x9250_id_table);

static struct spi_driver x9250_spi_driver = {
	.driver  = {
		.name = "x9250",
		.of_match_table = x9250_of_match,
	},
	.id_table = x9250_id_table,
	.probe  = x9250_probe,
};
--- 8< ---


Best regards,
Hervé

-- 
Hervé Codina, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
