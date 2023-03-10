Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C80BF6B3EEB
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 13:15:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbjCJMPA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 07:15:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbjCJMOu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 07:14:50 -0500
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08C9AEBAC6
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 04:14:49 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id c18so5366906qte.5
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 04:14:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678450488;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dgdFUoryZdcFhfgDIhaRXlxP8edd+zQniGh40m7BgBA=;
        b=z4y8yBIHLGZzYb4Ph5txtLxbBpo8VWigUsvsVudWqw0eM0N49YsTRQPtlf5jnFTf9/
         EvO6tx2VqMncbBDd6LuzgNI4jmhta6qJSkd8h+lqIe6zwMQz0467QAHAP7ijedOuhKFk
         HAal28UBSfBX/CLZ7Ap4hE229dY71orMZWfbuzhxU68tbXg0TUd9z6F3r39U71hqr/56
         2VnqI6SIFoyv63IGE9c7sYRn4Pj4/v9IYeRSn9lphH7JaHnCAljyFWp5++jVgmTuAth6
         IWTJK4qmy1DeKnefehu5oGBz/ilwlmVXx00zJT1T8DUg60cpOl6q339d1In9mdk5ev60
         mBpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678450488;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dgdFUoryZdcFhfgDIhaRXlxP8edd+zQniGh40m7BgBA=;
        b=bHOLfOsvXfH0EI5es7VbHfk1yPc5KjZ2l+BkEaAiAGUCp9Bxya2ofaMWP31urRN6At
         FgWPe7ULt8NAPJ2b1n/tZxFWPOSroU/faacoxuOTVHsZjltktI3rsCM6OXCbVLWvw/5U
         xYUPvQpk4nrNYNLC0z7sT3Y+bmXxQvBDsKEKuUXwVW6gpM7r+66lyPHhu+UBIiv8160I
         pxUSJgf4zbqT+39N4wiyxUMpeqY8Pi+4+cCN98PBLb1wrb/oVN9B5sOTytIRPtcArzgR
         O2m4iDcLGcT3cb9lQd8pffDNYsLOdNRDJuXnP6PjXTD+seSRhrocACfgUu3XuDk+Cod4
         xO6Q==
X-Gm-Message-State: AO0yUKXLznX2GsTpITcuOcZVtzC9VEZ3d0geaSexkQkapETh4VTuW8b+
        DOYyGq982+uvgCYvN9c5gplUGw==
X-Google-Smtp-Source: AK7set8rte1NSJarWcgGPb6PCPs3oXjSbz/6z8voZ27tvgO/xY5SsP/HR0n8nzon4hr4kjJX/qq8xA==
X-Received: by 2002:ac8:5903:0:b0:3b9:b817:e9a8 with SMTP id 3-20020ac85903000000b003b9b817e9a8mr44742379qty.27.1678450488089;
        Fri, 10 Mar 2023 04:14:48 -0800 (PST)
Received: from fedora (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id z17-20020ac83e11000000b003bfd27755d7sm1301282qtf.19.2023.03.10.04.14.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 04:14:47 -0800 (PST)
Date:   Fri, 10 Mar 2023 07:14:45 -0500
From:   William Breathitt Gray <william.gray@linaro.org>
To:     broonie@kernel.org
Cc:     linus.walleij@linaro.org, brgl@bgdev.pl,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH] regmap-irq: Drop map from handle_mask_sync() parameters
Message-ID: <ZAsfNel4835E+i6O@fedora>
References: <20230309232009.2938-1-william.gray@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2fUeKbfcSIUebyxb"
Content-Disposition: inline
In-Reply-To: <20230309232009.2938-1-william.gray@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2fUeKbfcSIUebyxb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 09, 2023 at 06:20:09PM -0500, William Breathitt Gray wrote:
> Remove the map parameter from the struct regmap_irq_chip callback
> handle_mask_sync() because it can be passed via the irq_drv_data
> parameter instead. The gpio-104-dio-48e driver is the only consumer of
> this callback and is thus updated accordingly.
>=20
> Signed-off-by: William Breathitt Gray <william.gray@linaro.org>

[...]

> diff --git a/drivers/gpio/gpio-104-dio-48e.c b/drivers/gpio/gpio-104-dio-=
48e.c
> index a3846faf3..1de551677 100644
> --- a/drivers/gpio/gpio-104-dio-48e.c
> +++ b/drivers/gpio/gpio-104-dio-48e.c
> @@ -99,14 +99,25 @@ static const struct regmap_irq dio48e_regmap_irqs[] =
=3D {
>  	DIO48E_REGMAP_IRQ(0), DIO48E_REGMAP_IRQ(1),
>  };
> =20
> -static int dio48e_handle_mask_sync(struct regmap *const map, const int i=
ndex,
> +/**
> + * struct dio48e_gpio - GPIO device private data structure
> + * @map:	Regmap for the device
> + * @irq_mask:	Current IRQ mask state on the device
> + */
> +struct dio48e_gpio {
> +	struct regmap *map;
> +	unsigned int irq_mask;
> +};
> +
> +static int dio48e_handle_mask_sync(const int index,
>  				   const unsigned int mask_buf_def,
>  				   const unsigned int mask_buf,
>  				   void *const irq_drv_data)
>  {
> -	unsigned int *const irq_mask =3D irq_drv_data;
> -	const unsigned int prev_mask =3D *irq_mask;
> +	struct dio48e_gpio *const dio48egpio =3D irq_drv_data;
> +	const unsigned int prev_mask =3D dio48egpio->irq_mask;
>  	const unsigned int all_masked =3D GENMASK(1, 0);
> +	struct regmap *const map =3D dio48egpio->map;
>  	int err;
>  	unsigned int val;
> =20
> @@ -115,7 +126,7 @@ static int dio48e_handle_mask_sync(struct regmap *con=
st map, const int index,
>  		return 0;
> =20
>  	/* remember the current mask for the next mask sync */
> -	*irq_mask =3D mask_buf;
> +	dio48egpio->irq_mask =3D mask_buf;
> =20
>  	/* if all previously masked, enable interrupts when unmasking */
>  	if (prev_mask =3D=3D all_masked) {

Mark,

These two hunks conflict with a minor gpio-104-dio-48e change in the
gpio/for-next branch [0]. I can rebase this patch on top of that change,
or would you prefer that this goes through the gpio tree?

I'll also split out the gpio-104-dio-48e changes to a precursor patch to
keep the focus here on the regmap-irq changes.

William Breathitt Gray

[0] Commit b961b2aa2f64 ("gpio: 104-dio-48e: Utilize mask_buf_def in handle=
_mask_sync() callback")

--2fUeKbfcSIUebyxb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCZAsfNQAKCRC1SFbKvhIj
K3mWAQC6H/iV7npLxE9mPKpFhWGyskMYJjEodN3tR6eDth2EYgEAi/YP3ZqUeKLQ
22duU3HpZYULXOEAPY6BYOqr0pBIlgo=
=yaME
-----END PGP SIGNATURE-----

--2fUeKbfcSIUebyxb--
