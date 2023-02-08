Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 457F06993DF
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 13:06:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbjBPMGU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 07:06:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbjBPMGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 07:06:17 -0500
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20BA4552A4
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 04:06:14 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id n25-20020a9d7119000000b0068bd8c1e836so525163otj.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 04:06:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uglBygBs9ijyHk9bCgsz1JnjSH+tWIY8t2J8IkoGaKg=;
        b=OxdaKe43FG9pkV/bxMqLQm3QB4w5+H6Nr/d+Bjy8+kEDM3NJEhkGNiSMjs3fsLD7nX
         3FQL3VJawYluNdpGWKhI0CjkAQEJJ0k3lKaioo9f336frqO1cuVZtKtUcEpMmj3Q8HnO
         VKlCxnjEruwsZ+y9RMnSfEXge6AGxzVKYQ7rMLP5iJEMNcZjr4oT5VDcToTZjzAtvSja
         3xs6UQaKA5O5AAeox08IcxpMEml2d+IZwaPiKmacDw3lWpGyRi4/ovKLZPZ+2llCiSRY
         UOZt0X5DNWwDYjiNEGh4ij+s8vL2gbmYTOLAdfTolGGIPH7/Y12V0HHcEyXM3THm3ctI
         1HFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uglBygBs9ijyHk9bCgsz1JnjSH+tWIY8t2J8IkoGaKg=;
        b=RO9AjGDcGNd4bR0NMZUFIpihLqeacXKLr4OHVqVBGi4j2GViUQTT0OtJBgroE6gY7a
         ju2yDNNvsbxZKT05TU6SkFA/rP0OYy+aT4W2WbL6GReamLzbnpXJQ5xN39gw5Z27kdTz
         yKSqi6FhzOJfFk4XodtpsQ7LjjbkhT5LUIo7rDvmMUNGbp5G9/+57jmkkiqGHHi5w5qT
         d28Spc+xFKcURxQtNwfi6Sr4paRdXlIaouRyUlmRV3W9eXphfrqhmSYI2xjq9EamWM5N
         chmMF+3h1A4KYp6l0kzE3bZilqeFoQdj40S4ojAbspq/I7f+Ch9yH0K/E6kRP0nFmw/l
         0Gnw==
X-Gm-Message-State: AO0yUKUmwMWYifBib59vusWUHpWWcxxgl1+1adZMFX6gqEfc0YB11m/W
        w254qf+ojLZ5gduuq1kUES8ZuXPMMRJU5Sll
X-Google-Smtp-Source: AK7set/QViwHWfznjRNuw1BE1wQ1msM8bPS/oX7O9gJb49xGfWna2ZIBMwHXu83+kYvTCy95yhddwg==
X-Received: by 2002:a05:6830:2a04:b0:68d:6175:d5b9 with SMTP id y4-20020a0568302a0400b0068d6175d5b9mr778243otu.19.1676549173177;
        Thu, 16 Feb 2023 04:06:13 -0800 (PST)
Received: from fedora (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id n12-20020a9d64cc000000b0068d4a8a8d40sm544774otl.81.2023.02.16.04.06.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Feb 2023 04:06:12 -0800 (PST)
Date:   Wed, 8 Feb 2023 06:16:44 -0500
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Mun Yew Tham <mun.yew.tham@intel.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, Alban Bedel <albeu@free.fr>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Jay Fang <f.fangjian@huawei.com>,
        Daniel Palmer <daniel@thingy.jp>,
        Romain Perier <romain.perier@gmail.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Kevin Hilman <khilman@kernel.org>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-omap@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH 16/17] gpio: pci-idio-16: Convert to immutable irq_chip
Message-ID: <Y+OEnM/gZ+lLRELc@fedora>
References: <20230215-immutable-chips-v1-0-51a8f224a5d0@linaro.org>
 <20230215-immutable-chips-v1-16-51a8f224a5d0@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="AySwEFEhj9sTbaXz"
Content-Disposition: inline
In-Reply-To: <20230215-immutable-chips-v1-16-51a8f224a5d0@linaro.org>
X-Spam-Status: No, score=1.3 required=5.0 tests=BAYES_00,DATE_IN_PAST_96_XX,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--AySwEFEhj9sTbaXz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 16, 2023 at 10:37:17AM +0100, Linus Walleij wrote:
> Convert the driver to immutable irq-chip with a bit of
> intuition.
>=20
> Cc: Marc Zyngier <maz@kernel.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

FYI, I'm migrating pci-idio-16 to the regmap-irq API soon, so this patch
might not be necessary once the code is removed. Anyway, here's my ack
in case this patch series is merged first.

Acked-by: William Breathitt Gray <william.gray@linaro.org>

> ---
>  drivers/gpio/gpio-pci-idio-16.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/gpio/gpio-pci-idio-16.c b/drivers/gpio/gpio-pci-idio=
-16.c
> index a86ce748384b..6726c32e31e6 100644
> --- a/drivers/gpio/gpio-pci-idio-16.c
> +++ b/drivers/gpio/gpio-pci-idio-16.c
> @@ -107,6 +107,8 @@ static void idio_16_irq_mask(struct irq_data *data)
> =20
>  		raw_spin_unlock_irqrestore(&idio16gpio->lock, flags);
>  	}
> +
> +	gpiochip_disable_irq(chip, irqd_to_hwirq(data));
>  }
> =20
>  static void idio_16_irq_unmask(struct irq_data *data)
> @@ -117,6 +119,8 @@ static void idio_16_irq_unmask(struct irq_data *data)
>  	const unsigned long prev_irq_mask =3D idio16gpio->irq_mask;
>  	unsigned long flags;
> =20
> +	gpiochip_enable_irq(chip, irqd_to_hwirq(data));
> +
>  	idio16gpio->irq_mask |=3D mask;
> =20
>  	if (!prev_irq_mask) {
> @@ -138,12 +142,14 @@ static int idio_16_irq_set_type(struct irq_data *da=
ta, unsigned int flow_type)
>  	return 0;
>  }
> =20
> -static struct irq_chip idio_16_irqchip =3D {
> +static const struct irq_chip idio_16_irqchip =3D {
>  	.name =3D "pci-idio-16",
>  	.irq_ack =3D idio_16_irq_ack,
>  	.irq_mask =3D idio_16_irq_mask,
>  	.irq_unmask =3D idio_16_irq_unmask,
> -	.irq_set_type =3D idio_16_irq_set_type
> +	.irq_set_type =3D idio_16_irq_set_type,
> +	.flags =3D IRQCHIP_IMMUTABLE,
> +	GPIOCHIP_IRQ_RESOURCE_HELPERS,
>  };
> =20
>  static irqreturn_t idio_16_irq_handler(int irq, void *dev_id)
> @@ -242,7 +248,7 @@ static int idio_16_probe(struct pci_dev *pdev, const =
struct pci_device_id *id)
>  	idio_16_state_init(&idio16gpio->state);
> =20
>  	girq =3D &idio16gpio->chip.irq;
> -	girq->chip =3D &idio_16_irqchip;
> +	gpio_irq_chip_set_chip(girq, &idio_16_irqchip);
>  	/* This will let us handle the parent IRQ in the driver */
>  	girq->parent_handler =3D NULL;
>  	girq->num_parents =3D 0;
>=20
> --=20
> 2.34.1
>=20

--AySwEFEhj9sTbaXz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCY+OEnAAKCRC1SFbKvhIj
K5eCAPwLmxXCtGXXgP0akD13UFw7dXSdGyxVszeP+0DYBG+nUwD9GF6hkUXvQwOW
2bR53NrSasEyxAdN84aY3rFim+gKKQE=
=Zw1V
-----END PGP SIGNATURE-----

--AySwEFEhj9sTbaXz--
