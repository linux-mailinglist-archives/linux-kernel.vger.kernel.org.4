Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7E996993E3
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 13:06:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbjBPMGu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 07:06:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbjBPMGq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 07:06:46 -0500
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB960552AD
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 04:06:42 -0800 (PST)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-16346330067so2289869fac.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 04:06:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mRWEN0keF6NiEd7O9ayzoP6wwuhhhF8V1d3xPTIxNoI=;
        b=CoYVjdLzmYKvj7Vd87G8M0+tYb1Ba3tu1VwpLjaeGT/voYVghBoZRmM3+NienWGtJU
         MeuZV+1IDBoQO59Jj+fWFaIIHgUFxpG6EyTJ+CSnW819UHaOAv9ugYbCRh7m94dzjC2k
         5P0Otds2OcdruKvClfV1YcUlCxNC7O7iC4pesdlSbV8v1Xw+ibyXN2ukLOxwQ/WzGiSl
         qkfAUjvubdR7Lf9Dudmsni/8S6hkq9i3mIm9cQ3CNfSodZaLJZKuj7vf/OLtjIC3OL/W
         LUihx7TpXmnrgxDgiV6QlthzG9184i9sa4dGeoaLus31NR4hFhW00FPj8MW+q2sIFUWU
         dalQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mRWEN0keF6NiEd7O9ayzoP6wwuhhhF8V1d3xPTIxNoI=;
        b=cApAaZ90xB5/TFKO2uLjU4XtDdkkuVrzTPGlJW24DOeO6ojbBw7XrUoff3kvAfzwig
         zvcPCGJ9pxk+wycPk8phv1nHg+zddavfPR6WQQ7Slwz6UCcd+KGatwubbgOhUjUARy1s
         RbPkEW9SuXcphPhZwROgpuFFffC+Qg2HvooWOca6W5C5doLhfqTm5SxqbrEefuaA0WSJ
         sOq0cSkhwwXIXUimXrAdVRg7lFH/1gO1Bi84opkWKttbPrVg0AkSkei8b/BEInlcP8Te
         88YIjM9OauojyFwDsrBlXIybyjk+OVWHOU1KNZqEBDQqFgykVWhjXpybVEWw33y8VysK
         nnLw==
X-Gm-Message-State: AO0yUKXTqDTfg8nRYCFWOA6xaVlTMYouBJgHaUEEJLF8BckLU5Cji4Wy
        PllNnMwYTxfmnwH4Oduy6DlKAw==
X-Google-Smtp-Source: AK7set94J1nmitezcU13KRwKZUpuXlQCbbTw5DAP8kxFwGDFXsKNw5nnYXe6YgwYapp9po8R9SvLqQ==
X-Received: by 2002:a05:6870:b51f:b0:16d:ea1d:6a6a with SMTP id v31-20020a056870b51f00b0016dea1d6a6amr2823105oap.40.1676549201345;
        Thu, 16 Feb 2023 04:06:41 -0800 (PST)
Received: from fedora (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id m3-20020a056870a40300b00152c52608dbsm476595oal.34.2023.02.16.04.06.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Feb 2023 04:06:40 -0800 (PST)
Date:   Wed, 8 Feb 2023 06:17:14 -0500
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
Subject: Re: [PATCH 17/17] gpio: pcie-idio-24: Convert to immutable irq_chip
Message-ID: <Y+OEujGudfk1SkSS@fedora>
References: <20230215-immutable-chips-v1-0-51a8f224a5d0@linaro.org>
 <20230215-immutable-chips-v1-17-51a8f224a5d0@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cyeQsMhX/E0TO8qE"
Content-Disposition: inline
In-Reply-To: <20230215-immutable-chips-v1-17-51a8f224a5d0@linaro.org>
X-Spam-Status: No, score=1.3 required=5.0 tests=BAYES_00,DATE_IN_PAST_96_XX,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cyeQsMhX/E0TO8qE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 16, 2023 at 10:37:18AM +0100, Linus Walleij wrote:
> Convert the driver to immutable irq-chip with a bit of
> intuition.
>=20
> Cc: Marc Zyngier <maz@kernel.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Acked-by: William Breathitt Gray <william.gray@linaro.org>

> ---
>  drivers/gpio/gpio-pcie-idio-24.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/gpio/gpio-pcie-idio-24.c b/drivers/gpio/gpio-pcie-id=
io-24.c
> index 8a9b98fa418f..ac42150f4009 100644
> --- a/drivers/gpio/gpio-pcie-idio-24.c
> +++ b/drivers/gpio/gpio-pcie-idio-24.c
> @@ -396,6 +396,8 @@ static void idio_24_irq_mask(struct irq_data *data)
>  	}
> =20
>  	raw_spin_unlock_irqrestore(&idio24gpio->lock, flags);
> +
> +	gpiochip_disable_irq(chip, irqd_to_hwirq(data));
>  }
> =20
>  static void idio_24_irq_unmask(struct irq_data *data)
> @@ -408,6 +410,8 @@ static void idio_24_irq_unmask(struct irq_data *data)
>  	const unsigned long bank_offset =3D bit_offset / 8;
>  	unsigned char cos_enable_state;
> =20
> +	gpiochip_enable_irq(chip, irqd_to_hwirq(data));
> +
>  	raw_spin_lock_irqsave(&idio24gpio->lock, flags);
> =20
>  	prev_irq_mask =3D idio24gpio->irq_mask >> bank_offset * 8;
> @@ -437,12 +441,14 @@ static int idio_24_irq_set_type(struct irq_data *da=
ta, unsigned int flow_type)
>  	return 0;
>  }
> =20
> -static struct irq_chip idio_24_irqchip =3D {
> +static const struct irq_chip idio_24_irqchip =3D {
>  	.name =3D "pcie-idio-24",
>  	.irq_ack =3D idio_24_irq_ack,
>  	.irq_mask =3D idio_24_irq_mask,
>  	.irq_unmask =3D idio_24_irq_unmask,
> -	.irq_set_type =3D idio_24_irq_set_type
> +	.irq_set_type =3D idio_24_irq_set_type,
> +	.flags =3D IRQCHIP_IMMUTABLE,
> +	GPIOCHIP_IRQ_RESOURCE_HELPERS,
>  };
> =20
>  static irqreturn_t idio_24_irq_handler(int irq, void *dev_id)
> @@ -535,7 +541,7 @@ static int idio_24_probe(struct pci_dev *pdev, const =
struct pci_device_id *id)
>  	idio24gpio->chip.set_multiple =3D idio_24_gpio_set_multiple;
> =20
>  	girq =3D &idio24gpio->chip.irq;
> -	girq->chip =3D &idio_24_irqchip;
> +	gpio_irq_chip_set_chip(girq, &idio_24_irqchip);
>  	/* This will let us handle the parent IRQ in the driver */
>  	girq->parent_handler =3D NULL;
>  	girq->num_parents =3D 0;
>=20
> --=20
> 2.34.1
>=20

--cyeQsMhX/E0TO8qE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCY+OEugAKCRC1SFbKvhIj
K02BAP91FSltXanO1Y/3GfoNBCJE7RStvsFHG9hsQlUmwpOJuwEA/eYRZLIo5k9G
AtVeJJfhJC6J5AUcb0/9/dTNIIukVQ4=
=HUho
-----END PGP SIGNATURE-----

--cyeQsMhX/E0TO8qE--
