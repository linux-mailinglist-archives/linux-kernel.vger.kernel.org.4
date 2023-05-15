Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A70FF702521
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 08:44:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240031AbjEOGoa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 02:44:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240063AbjEOGo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 02:44:26 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A25B8124;
        Sun, 14 May 2023 23:44:19 -0700 (PDT)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 5C2E8240009;
        Mon, 15 May 2023 06:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1684133058;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BPwTE4rB3CorEdCyedZeKumEN4c9XLY/wx43h2Qazkg=;
        b=AyM5KFjBAESikv1MOL4fL4d91/u57UW/m1u+gjWTpXc3Sxp2B7GfwWdBaaL+306RT4PMqH
        xMOrSUy2xhQ9XfFKcXWQCKfDNJp8/F1eKw84dU9VQWDEPrinegIRi7jogSRwjb5SKYxPXd
        zAP5qz1TziuRv+tNXCCRasrCQmm+P3vC+RT7Zug50u5L2CyJkJ00tw6cG9A+dYvHtJY5ZO
        trqgCvvA0pd4ylDnjG5kzoYGwP7oR66nG7iWIEjO4Zpc9gYncbdycCqThfhAqL093i8KIj
        2KNOFuYjaICAqQKVrFWUOWv+jTR1lvr9TTOvvo0Vtn/dahQajAycaL703hXVYw==
Date:   Mon, 15 May 2023 08:44:16 +0200
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
Message-ID: <20230515084416.399f47c8@bootlin.com>
In-Reply-To: <20230514181912.314ef781@jic23-huawei>
References: <20230509160852.158101-1-herve.codina@bootlin.com>
        <20230509160852.158101-3-herve.codina@bootlin.com>
        <20230513193525.43a4475f@jic23-huawei>
        <20230514163233.0c048256@bootlin.com>
        <20230514181912.314ef781@jic23-huawei>
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

On Sun, 14 May 2023 18:19:12 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Sun, 14 May 2023 16:32:33 +0200
> Herve Codina <herve.codina@bootlin.com> wrote:
> 
> > Hi Jonathan,
> > 
> > On Sat, 13 May 2023 19:35:25 +0100
> > Jonathan Cameron <jic23@kernel.org> wrote:
> >   
> > > On Tue,  9 May 2023 18:08:51 +0200
> > > Herve Codina <herve.codina@bootlin.com> wrote:
> > >     
> > > > The Renesas X9250 integrates four digitally controlled potentiometers.
> > > > On each potentiometer, the X9250T has a 100 kOhms total resistance and
> > > > the X9250U has a 50 kOhms total resistance.
> > > > 
> > > > Signed-off-by: Herve Codina <herve.codina@bootlin.com>      
> > > 
> > > As I only noticed one trivial thing I made the change whilst applying.
> > > diff --git a/drivers/iio/potentiometer/x9250.c b/drivers/iio/potentiometer/x9250.c
> > > index 3d4ca18d1f14..7e145d7d14f1 100644
> > > --- a/drivers/iio/potentiometer/x9250.c
> > > +++ b/drivers/iio/potentiometer/x9250.c
> > > @@ -176,10 +176,7 @@ static int x9250_probe(struct spi_device *spi)
> > >  
> > >         x9250 = iio_priv(indio_dev);
> > >         x9250->spi = spi;
> > > -       x9250->cfg = device_get_match_data(&spi->dev);
> > > -       if (!x9250->cfg)
> > > -               x9250->cfg = &x9250_cfg[spi_get_device_id(spi)->driver_data];
> > > -
> > > +       x9250->cfg = spi_get_device_match_data(spi);
> > >         x9250->wp_gpio = devm_gpiod_get_optional(&spi->dev, "wp", GPIOD_OUT_LOW);
> > >         if (IS_ERR(x9250->wp_gpio))
> > >                 return dev_err_probe(&spi->dev, PTR_ERR(x9250->wp_gpio),
> > >     
> > 
> > Are you sure about your modification ?
> > 
> > I am not sure (maybe I am wrong) that
> >   x9250->cfg = spi_get_device_match_data(spi);
> > is equivalent to
> >   x9250->cfg = &x9250_cfg[spi_get_device_id(spi)->driver_data];
> > 
> > The spi_get_device_id(spi)->driver_data value I used is a simple integer
> > (X9250T or X9250U) and not the x9250_cfg item.
> > Maybe the x9250_id_table should be modified to replace X9250T by
> > &x9250_cfg[X9250T] to have your modification working.  
> 
> Excellent point.  I'm was  clearly half asleep. The mod should have included
> switching them over to be pointers.
> 
> > 
> > The data defined in the driver are the following:
> > --- 8< ---
> > static const struct x9250_cfg x9250_cfg[] = {
> > 	[X9250T] = { .name = "x9250t", .kohms =  100, },
> > 	[X9250U] = { .name = "x9250u", .kohms =  50, },
> > };
> > 
> > ...
> > 
> > static const struct of_device_id x9250_of_match[] = {
> > 	{ .compatible = "renesas,x9250t", &x9250_cfg[X9250T]},
> > 	{ .compatible = "renesas,x9250u", &x9250_cfg[X9250U]},
> > 	{ }
> > };
> > MODULE_DEVICE_TABLE(of, x9250_of_match);
> > 
> > static const struct spi_device_id x9250_id_table[] = {
> > 	{ "x9250t", X9250T },
> > 	{ "x9250u", X9250U },  
> So these should be (kernel_ulong_t)&x9250_cfg[X9250T] etc for the data.
> I've tweaked it so that is now the case. Oops and thanks for sanity checking.
> Sometimes we see what we expect to see rather than what is there.
> 
> Tweak on top of original tweak is:
> diff --git a/drivers/iio/potentiometer/x9250.c b/drivers/iio/potentiometer/x9250.c
> index 7e145d7d14f1..0cc7f72529be 100644
> --- a/drivers/iio/potentiometer/x9250.c
> +++ b/drivers/iio/potentiometer/x9250.c
> @@ -198,8 +198,8 @@ static const struct of_device_id x9250_of_match[] = {
>  MODULE_DEVICE_TABLE(of, x9250_of_match);
>  
>  static const struct spi_device_id x9250_id_table[] = {
> -       { "x9250t", X9250T },
> -       { "x9250u", X9250U },
> +       { "x9250t", (kernel_ulong_t)&x9250_cfg[X9250T] },
> +       { "x9250u", (kernel_ulong_t)&x9250_cfg[X9250U] },
>         { }
>  };
> 
> 

Pefect, thanks.

Also can you add a last modification (my bad, I should see that before):

 static const struct of_device_id x9250_of_match[] = {
-       { .compatible = "renesas,x9250t", &x9250_cfg[X9250T]},
-       { .compatible = "renesas,x9250u", &x9250_cfg[X9250U]},
+       { .compatible = "renesas,x9250t", .data = &x9250_cfg[X9250T]},
+       { .compatible = "renesas,x9250u", .data = &x9250_cfg[X9250U]},
        { }
 };

I think adding '.data = ' would be better and avoid to have some quite tricky
bug in case of struct of_device_id modification.

Regards,
Hervé


> Jonathan
> 
> > 	{ }
> > };
> > MODULE_DEVICE_TABLE(spi, x9250_id_table);
> > 
> > static struct spi_driver x9250_spi_driver = {
> > 	.driver  = {
> > 		.name = "x9250",
> > 		.of_match_table = x9250_of_match,
> > 	},
> > 	.id_table = x9250_id_table,
> > 	.probe  = x9250_probe,
> > };
> > --- 8< ---
> > 
> > 
> > Best regards,
> > Hervé
> >   
> 
