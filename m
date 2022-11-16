Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E815262C078
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 15:07:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233866AbiKPOHn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 09:07:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233879AbiKPOHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 09:07:19 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E2E821E27;
        Wed, 16 Nov 2022 06:05:35 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id n20so23726730ejh.0;
        Wed, 16 Nov 2022 06:05:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GQHF6xrCnnZ/7DJTYm+O8SFaI/pPn9ON4reEyxN2lG8=;
        b=mcsN0Z4GnK2cM6xSJNBIPBi7EHILZ0SYCq+B55jZraePjTlCZXEtZ7XykfS0uNWI3f
         d4ADRfjzgCKuUsx6qddTEP6FuF4e/WBwG7d0hmF9H6A6e5brwnuaq2mlbYzrMYUI9rqf
         c1uiMCi/Nti2X5HtdsS9lAiJ95UhihKrtTidVM+UkACyd1v0slcOqBkjgtJw53UWtRTy
         S4oxCa/eoP30GtWusk6wg7VMKvUA+2ome7Bi5MO9so+csGMjWJGF9fkxej2M3jmxBpmc
         fhkffqsB7BEQhCvE+u/24DJIU5qytn6MBmowCLjOOmV8tXKjlgN++7LCTCDGTuKOqQ2r
         E1Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GQHF6xrCnnZ/7DJTYm+O8SFaI/pPn9ON4reEyxN2lG8=;
        b=mVqg86GOhyCmgc2GwQ0tT7WYjcjVs1dQIh3nbEJ4LaOXPEmyS0okr2PActti0DEFZ4
         kSJYd2hA3Jse6R0HZBbwnWIVYx3JflWS8h0SL0Rzb9U5xOKTuqa02sBPqbH2OHWJ5Kaw
         dUyIjxE2F2CENR3+npqugb9CGce+2NswRNqXvOQVWajC6ho4D5i67CVLxzRhdlp8avvZ
         kD3gs0I7gqa+bJcBmjwJlbCtDTVor1Y8NOGsMLrjKBOc9ekUBK+1FcZNCNdSLAVQtjpz
         0H9CzbZSbKyjxpJGkCNQKVrFEHZ2WDyoBsM78pr20SX1w7ek0LC8ptDbfvglt+M27tw9
         Rp8w==
X-Gm-Message-State: ANoB5pny18pr+N2kwZ4NeFIfbMoGw/n/HnG8Ija7hHwbAAur5Qo3ns3P
        Q7SC6rHwt2kebCSAKs/v/XU=
X-Google-Smtp-Source: AA0mqf6cxmMPu1BENt50HCQDkq9BZrUHa3M+DXUGefFES5D3hEVDS28SanxsIJ1ijZlK6Z2y73tWIw==
X-Received: by 2002:a17:906:eb59:b0:7ae:c1b2:d928 with SMTP id mc25-20020a170906eb5900b007aec1b2d928mr17631108ejb.296.1668607533703;
        Wed, 16 Nov 2022 06:05:33 -0800 (PST)
Received: from orome (p200300e41f201d00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f20:1d00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id h4-20020a0564020e8400b00461bacee867sm7413810eda.25.2022.11.16.06.05.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 06:05:32 -0800 (PST)
Date:   Wed, 16 Nov 2022 15:05:30 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        Brian Masney <bmasney@redhat.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: Re: [PATCH] gpiolib: of: Use correct fwnode for DT-probed chips
Message-ID: <Y3TuKhW9YjOTzcfg@orome>
References: <20221111113732.461881-1-thierry.reding@gmail.com>
 <Y3Kv7XoBytwwy9pC@x1>
 <20221115111800.t6i6fuszhuasvgka@SoMainline.org>
 <Y3S62i7OzocP5QrT@orome>
 <Y3S9oEw6qfLVgGhR@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="8YUqZNNhJPdRaHFQ"
Content-Disposition: inline
In-Reply-To: <Y3S9oEw6qfLVgGhR@smile.fi.intel.com>
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


--8YUqZNNhJPdRaHFQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 16, 2022 at 12:38:24PM +0200, Andy Shevchenko wrote:
> On Wed, Nov 16, 2022 at 11:26:34AM +0100, Thierry Reding wrote:
> > On Tue, Nov 15, 2022 at 12:18:00PM +0100, Marijn Suijten wrote:
> > > On 2022-11-14 16:15:25, Brian Masney wrote:
> > > > On Fri, Nov 11, 2022 at 12:37:32PM +0100, Thierry Reding wrote:
> > > > > From: Thierry Reding <treding@nvidia.com>
> > > > >=20
> > > > > The OF node store in chip->fwnode is used to explicitly override =
the FW
> > > > > node for a GPIO chip. For chips that use the default FW node (i.e=
=2E that
> > > > > of their parent device), this will be NULL and cause the chip not=
 to be
> > > > > fully registered.
> > > > >=20
> > > > > Instead, use the GPIO device's FW node, which is set to either th=
e node
> > > > > of the parent device or the explicit override in chip->fwnode.
> > > > >=20
> > > > > Fixes: 8afe82550240 ("gpiolib: of: Prepare of_gpiochip_add() / of=
_gpiochip_remove() for fwnode")
> > > > > Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> > > > > Signed-off-by: Thierry Reding <treding@nvidia.com>
> > > >=20
> > > > Reviewed-by: Brian Masney <bmasney@redhat.com>
> > > > Tested-by: Brian Masney <bmasney@redhat.com>
> > > >=20
> > > > I separately sent a similar type of patch to fix the same issue tod=
ay:
> > > > https://lore.kernel.org/linux-arm-msm/20221114202943.2389489-1-bmas=
ney@redhat.com/T/#u
> > >=20
> > > For completeness, your linked patch fixes a synchronous external abort
> > > on multiple Qualcomm platforms pointed out in [1].  This patch however
> > > does not, are you sure they fix the exact same issue?
>=20
> Yes, they fix the same issue.
>=20
> > > [1]: https://lore.kernel.org/linux-arm-msm/20221115110800.35gl3j43lmb=
xm3jb@SoMainline.org/
> >=20
> > Can you check if the below fixes the MSM issue that you're seeing
> > (applied on top of my earlier patch, though with Brian's reverted
> > temporarily)?
>=20
> I don't know why we would need this. Brian's patch (already applied into
> GPIO tree) is correct, no? (Moreover, it makes yours unneeded, but I'm fi=
ne
> with having it anyway.)

I've explained this in the reply to Brian's patch, but I don't think we
want to use gc->fwnode other than initially to override the fwnode that
the GPIO chip uses. It might even be worth turning it into a parameter
to gpiochip_add() to avoid the ambiguity we have right now where we
store the same fwnode in two different places and end up using either
depending on whoever wrote the patch and what mood they were in. There
really should only be one place to store this pointer to avoid this sort
of ambiguity.

Thierry

--8YUqZNNhJPdRaHFQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmN07ioACgkQ3SOs138+
s6GcARAAwVSaB6cgAFmgZVVRCE4RrjHNgm0XrWw1TWomrfOvqBcIprj702QqcOfq
DMkgLdW9LPzt/nxItelQ9sn8tfrajma7x+kfTAcXMtTIkZgAKIcP7MLk++ymwL30
RzfsjbFUhCaqSb75m4fktdi6Jdj8G80R4VEmmiEk0nnWu9CeOquC+5MTf+BL3PNy
jCx6ndMyRjuLU7JRVFqkfXJt+LsjDh/+tMIaomfiYnoMRimKxQSmf318avHZXA9/
H8DvEyh+dlGwyexUHBD6GI4N4COFdLamOrjXXjqr/t0lSZ28GrCbhm9ZmhVXjR1j
NkNRElKf0VF41y0/oVoqgt+Aq2AirL2yh0jCQIS7Qou1snvqXDw8aW6AxGSSWpgL
+Oj8k9xqd/OEWchd0J7dQED0Iokv1q+RosY5bGLuAkeAzkKzk7cKqndiNGHl0A+p
IbLX7g8cvI6duFoMh8oSAOWT8ATrCTzzMbHt5GodGITKTWO41VlfUrI3znx/RDNQ
1j8jVLkpgQd1sS//Dj/wgHEWcFKqcvg5Z18dtTSy+EhlHG5UNFQMyHKohXQ+Tnp0
eCDJ18okOfytJbc0N+co2CI91bsAfBIYIMlQtoLfsVFlj4fiT64ZEJE82BVClbHa
IuI4TgbdV/1Y2YIo6RwcaK0Zud4SYVjhxt32aLTbX63OAMYXaLU=
=PJfZ
-----END PGP SIGNATURE-----

--8YUqZNNhJPdRaHFQ--
