Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D79662B9EF
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 11:48:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238960AbiKPKs0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 05:48:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238974AbiKPKsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 05:48:05 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5058848772;
        Wed, 16 Nov 2022 02:35:42 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id bj12so42926905ejb.13;
        Wed, 16 Nov 2022 02:35:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZfF5H7OlX+Ehk6ts6kc2Re3wIjyOZLFN9LUYQD5Q15M=;
        b=U/uD1d/2Wjuu25fimzOIP49QGtcRNDST/oFYv+Z8ZhiJoE2vQrSrFxiLacjUKtAngb
         SiGHZ8uzIl4O7IzY2x3J0UfFPhEG3aQY6H3YKDeeEy1U25zjaVR5gynDxWqvcQs3ZkFR
         t8a3gygO+JVcD2x6p1xBgCzdYKH9snze/KSz2fOceABefkYcnnIPpyrjJI+wI+71cRMH
         cYeAN9ZaSUN9yPm0DLwjoCxDoq1mZ/Epj+Q2K2LI2H4VjHg/ViNRuo2hWk6BTUWajeE5
         LOvDsR9kwTqcxmEE5sytC0pHxhgEsNJ6GbUqtwZ5cmHd4xoZzxYuTXinbXEOqU/tiJ95
         BtoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZfF5H7OlX+Ehk6ts6kc2Re3wIjyOZLFN9LUYQD5Q15M=;
        b=o5M7zynh3RADkjMWl2W7IiQ8KL1ZE+3nGm/h2FfsLLdpcc3pmu/I9P7iQSg4LW0Tft
         GhK7A1zQSWF69vlkJLw30VQ3bAdk/YiUyoxQWoBnegcC1ZMfsg68zV+JcuRnH01ko9U1
         VpfK3Nj7Tpf1Kzwdb3UuIY+/yDD4Fs4qF7pKnj84uLbCon3i52VZzj4MH/9loHqSVX5m
         Zki1Msl8M1O6/3c3CP0cySNCsRj39r9GTFVOgQszoFDxZv4HLQvuThq/SkQXlpiieX2Q
         +buUlLin9ccHK89kbeLSy7PFOXVp11lwOUGHgLSFQ7sxfeE1Esr4p2/WDWtl+oP/4mnp
         vpMA==
X-Gm-Message-State: ANoB5pnGvde0YheynGbQyVpGXbXjST3SP87aV2WnYNGw3w5/tU15fJBT
        KAlkL7o//lDBHNxGNhPOJghMI3zxZT0=
X-Google-Smtp-Source: AA0mqf6kSY6gPS6yfpKaa5qoUDtPjmZS/yWQjgb6foff2z7DWFURXJ88wzapywoRgciG97yTxRRI9w==
X-Received: by 2002:a17:907:2350:b0:78d:9c2f:bf78 with SMTP id we16-20020a170907235000b0078d9c2fbf78mr17153920ejb.594.1668594940541;
        Wed, 16 Nov 2022 02:35:40 -0800 (PST)
Received: from orome (p200300e41f201d00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f20:1d00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id b14-20020aa7dc0e000000b00462e1d8e914sm7241163edu.68.2022.11.16.02.35.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 02:35:39 -0800 (PST)
Date:   Wed, 16 Nov 2022 11:35:37 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Brian Masney <bmasney@redhat.com>
Cc:     linus.walleij@linaro.org, brgl@bgdev.pl,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, psodagud@quicinc.com,
        quic_shazhuss@quicinc.com, quic_ppareek@quicinc.com,
        ahalaney@redhat.com, echanude@redhat.com,
        nicolas.dechesne@linaro.org
Subject: Re: [PATCH RFC] gpiolib: ensure that fwnode is properly set
Message-ID: <Y3S8+cZO379Oiyce@orome>
References: <20221114202943.2389489-1-bmasney@redhat.com>
 <Y3S5sZIVi2DPua0p@orome>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="cAHYK1Crg6nEop4T"
Content-Disposition: inline
In-Reply-To: <Y3S5sZIVi2DPua0p@orome>
User-Agent: Mutt/2.2.8 (2022-11-05)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cAHYK1Crg6nEop4T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 16, 2022 at 11:21:37AM +0100, Thierry Reding wrote:
> On Mon, Nov 14, 2022 at 03:29:43PM -0500, Brian Masney wrote:
> > Note that this is a RFC patch and not meant to be merged. I looked into
> > a problem with linux-next-20221110 on the Qualcomm SA8540P automotive
> > board (sc8280xp) where the UFS host controller would fail to probe due
> > to repeated probe deferrals when trying to get reset-gpios via
> > devm_gpiod_get_optional().
> >=20
> > of_get_named_gpiod_flags() returns -EPROBE_DEFER, which is caused by
> > of_gpiochip_match_node_and_xlate() returning 0 since the of_xlate funct=
ion
> > pointer is not set for the qcom,sc8280xp-tlmm pinctrl driver. The
> > pinctrl driver doesn't define one, so of_gpiochip_add() should
> > automatically setup of_gpio_simple_xlate() on it's behalf. This doesn't
> > happen since the fwnode member on the struct gpiochip is set to null
> > when of_gpiochip_add() is called. Let's work around this by ensuring
> > that it's set if available.
> >=20
> > Note that this broke sometime within the last few weeks within
> > linux-next and I haven't bisected this. I'm posting this in the hopes
> > that someone may know offhand which patch(es) may have broken this.
> >=20
> > Signed-off-by: Brian Masney <bmasney@redhat.com>
> > ---
> >  drivers/gpio/gpiolib.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> > index 11fb7ec883e9..8bec66008869 100644
> > --- a/drivers/gpio/gpiolib.c
> > +++ b/drivers/gpio/gpiolib.c
> > @@ -678,7 +678,7 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc=
, void *data,
> >  	 * Assign fwnode depending on the result of the previous calls,
> >  	 * if none of them succeed, assign it to the parent's one.
> >  	 */
> > -	gdev->dev.fwnode =3D dev_fwnode(&gdev->dev) ?: fwnode;
> > +	gc->fwnode =3D gdev->dev.fwnode =3D dev_fwnode(&gdev->dev) ?: fwnode;
>=20
> This doesn't look right to me. Looking at the documentation of
> gc->fwnode and how it is used, the purpose of this is to allow
> explicitly overriding the fwnode that the GPIO chip will use.
>=20
> So really this should not be used beyond the initial registration
> in gpiochip_add_data_with_key(). If the above patch fixes anything,
> then I suspect somebody is using gc->fwnode outside of this
> registration.
>=20
> Looking at gpiolib, the only remaining place that seems to do this is
> the gpio-reserved-ranges handling code, in which case, the below on top
> of my initial patch might fix that. That might explain why MSM is still
> seeing issues.
>=20
> --- >8 ---
> diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> index 11fb7ec883e9..d692ad5c5a27 100644
> --- a/drivers/gpio/gpiolib.c
> +++ b/drivers/gpio/gpiolib.c
> @@ -447,10 +447,11 @@ static unsigned long *gpiochip_allocate_mask(struct=
 gpio_chip *gc)
> =20
>  static unsigned int gpiochip_count_reserved_ranges(struct gpio_chip *gc)
>  {
> +	struct fwnode_handle *fwnode =3D dev_fwnode(&gc->gpiodev->dev);
>  	int size;
> =20
>  	/* Format is "start, count, ..." */
> -	size =3D fwnode_property_count_u32(gc->fwnode, "gpio-reserved-ranges");
> +	size =3D fwnode_property_count_u32(fwnode, "gpio-reserved-ranges");
>  	if (size > 0 && size % 2 =3D=3D 0)
>  		return size;
> =20
> @@ -471,6 +472,7 @@ static int gpiochip_alloc_valid_mask(struct gpio_chip=
 *gc)
> =20
>  static int gpiochip_apply_reserved_ranges(struct gpio_chip *gc)
>  {
> +	struct fwnode_handle *fwnode =3D dev_fwnode(&gc->gpiodev->dev);
>  	unsigned int size;
>  	u32 *ranges;
>  	int ret;
> @@ -483,7 +485,7 @@ static int gpiochip_apply_reserved_ranges(struct gpio=
_chip *gc)
>  	if (!ranges)
>  		return -ENOMEM;
> =20
> -	ret =3D fwnode_property_read_u32_array(gc->fwnode, "gpio-reserved-range=
s", ranges, size);
> +	ret =3D fwnode_property_read_u32_array(fwnode, "gpio-reserved-ranges", =
ranges, size);
>  	if (ret) {
>  		kfree(ranges);
>  		return ret;
> --- >8 ---
>=20
> I don't have a good idea about the Lenovo X13 issue, though, but I
> haven't looked at ACPI at all since I don't have any hardware to test
> on.

Ah... looks like that device was actually a Thinkpad X13*s*, which is
based on a Qualcomm chip, so maybe this patch fixes that one, too. It
does use gpio-reserved-ranges, so seems at least likely.

Thierry

--cAHYK1Crg6nEop4T
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmN0vPgACgkQ3SOs138+
s6Gglw/+KVnw7BuUhbeGDzN3JVl64OYcwz1syDvc/+w6J27C0o2R06hPOjRPMtof
hiOQPAaTdtUqDjM5tsi77Cslhwt7wOVwLOLvJ0XzA2agearmoIv+M1+De2tbIpmL
726JCNYZhgDBjy0PrRvDK1y5/nA6lc5+U9rRIz1p0SNx414SIxUspu5IwnbuyABj
8hB9V9LzVOwDE5wr88Rp7NrrKYoMbmsY4DlzFY8pa8nmhDtr1gxXtFVY3tqDEG21
qc9BlegBlAC1e/TulKQcbwOJNASrNZaAyZNR/99YXIWg0brJjP4pCimkiuicPkGk
fUYggbEgiBoIfb+U5XRHxYfgiugchH0opKzhuixdiiL5lzD0RgWtCYatCsofOuYo
q8qcJ9V4Ah+c6LOM/Y2yNz8sr/NqBV7DWqesEm0PdCovSHsnLxrHYe1qbktiiKof
nBCQe2zoHGurMQ1K+O4awbzFnlgRw9XA4faG3hgfzrkLepmZcDC0nApXBFVvFfl+
rdn89/ZShjiWdkUwrE6mFg+dFWSbUICGb9HluOYrSvnlA/als7ovOtSpW3vrkiEC
GO/GNELpm+LcyMOEiHFr3ZcDM5pSTk/G3qCav55YNgi+KUISTKcGGWjpc28sDqQY
s7P0W/nKgQGBZq7Y9Az9iNfzmcrmy3ibMGAZ4m6fnVR/7CEawBA=
=eSq5
-----END PGP SIGNATURE-----

--cAHYK1Crg6nEop4T--
