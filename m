Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B9FD62B861
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 11:30:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231394AbiKPKag (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 05:30:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236814AbiKPK3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 05:29:45 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A014F10F9;
        Wed, 16 Nov 2022 02:26:38 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id n20so22362334ejh.0;
        Wed, 16 Nov 2022 02:26:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wZZMUhbKy7ynmOXNWH4kaH5VmBJFo340pscy2ibaMNA=;
        b=HZ1wSriRfPZJmhfe7cRemFo0WYY/MWcqYreV3FKi50VCEeB2EUUYTJ8Tp+2HzYhq8p
         haaa/NG86zlsNy8C1hIGIOac28ezcy2vsEzyidHCq0qvdNb2+b87pc30KgKeAhYP4Ewg
         Z7Lb8rTeBdU2Uiz4iyjvFWcz+Fi6fxB0frQbWeI74t0V7U3W+RcDcpDOtgW8JLKQ75ic
         BsxuDQmVirB8Yj+rGPht9o+LEIE4PfQzzfJLVw3QypdCzaCUZUzLEUaKTyk/N7FN2qr2
         5b55RoLkOkLRtb1SS37lsl5y+z0LtWhgS++aExDsxYMPoBm2CK00Qnqsh3c7xfAKIUvc
         op3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wZZMUhbKy7ynmOXNWH4kaH5VmBJFo340pscy2ibaMNA=;
        b=ADMYATEAdV4hVGI2bbAZ+7zlA4lC1K9MW2SW290+10H+g11aQNJdqYtnSFzaH6QMfs
         ADqExvwIa4HHOeTI8ZzJmxaPAd/hJFHkZnsEKG3q0ffCqmk9trC2nG0w85WUVqXqHCLi
         XAh2lc7CW3tetKgWwGUwwRDixn/V1JtZB6T4KPg1LgyvI4J2WtEJx6OdnH38lZPyGB2J
         El0V+bDaqZraQ5a2AuMYgwSVwmtTrWJ6HDkkTIEsJFweFYwqOxeqO1tSJfNJyMhhvs7T
         50mD7bYx3wFgSEj6PmOx+mi0jnq3hhvC9extX6GiqbmiYFH6cU1GkzL9B360a53IMIT+
         rnlw==
X-Gm-Message-State: ANoB5pndN135zj4ddiwDnkvux/KvWMquU0/qPKI/l0sxMmmaL7082/IM
        rTmqiyNB3cSfw6H5vStC6eo=
X-Google-Smtp-Source: AA0mqf74VbIVWmlTNuSozK+5PNnszZ7A8uhH/Gk+C9mUxD3bAKfJuDEgae0qq76KE9yfDnkHPHE4NQ==
X-Received: by 2002:a17:906:269a:b0:7ad:84cc:fb33 with SMTP id t26-20020a170906269a00b007ad84ccfb33mr17430651ejc.380.1668594397130;
        Wed, 16 Nov 2022 02:26:37 -0800 (PST)
Received: from orome (p200300e41f201d00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f20:1d00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id r18-20020a1709061bb200b0077d37a5d401sm6710292ejg.33.2022.11.16.02.26.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 02:26:36 -0800 (PST)
Date:   Wed, 16 Nov 2022 11:26:34 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Marijn Suijten <marijn.suijten@somainline.org>
Cc:     Brian Masney <bmasney@redhat.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: Re: [PATCH] gpiolib: of: Use correct fwnode for DT-probed chips
Message-ID: <Y3S62i7OzocP5QrT@orome>
References: <20221111113732.461881-1-thierry.reding@gmail.com>
 <Y3Kv7XoBytwwy9pC@x1>
 <20221115111800.t6i6fuszhuasvgka@SoMainline.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="t/QMyFVa0+ws/Ltf"
Content-Disposition: inline
In-Reply-To: <20221115111800.t6i6fuszhuasvgka@SoMainline.org>
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


--t/QMyFVa0+ws/Ltf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 15, 2022 at 12:18:00PM +0100, Marijn Suijten wrote:
> On 2022-11-14 16:15:25, Brian Masney wrote:
> > On Fri, Nov 11, 2022 at 12:37:32PM +0100, Thierry Reding wrote:
> > > From: Thierry Reding <treding@nvidia.com>
> > >=20
> > > The OF node store in chip->fwnode is used to explicitly override the =
FW
> > > node for a GPIO chip. For chips that use the default FW node (i.e. th=
at
> > > of their parent device), this will be NULL and cause the chip not to =
be
> > > fully registered.
> > >=20
> > > Instead, use the GPIO device's FW node, which is set to either the no=
de
> > > of the parent device or the explicit override in chip->fwnode.
> > >=20
> > > Fixes: 8afe82550240 ("gpiolib: of: Prepare of_gpiochip_add() / of_gpi=
ochip_remove() for fwnode")
> > > Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> > > Signed-off-by: Thierry Reding <treding@nvidia.com>
> >=20
> > Reviewed-by: Brian Masney <bmasney@redhat.com>
> > Tested-by: Brian Masney <bmasney@redhat.com>
> >=20
> > I separately sent a similar type of patch to fix the same issue today:
> > https://lore.kernel.org/linux-arm-msm/20221114202943.2389489-1-bmasney@=
redhat.com/T/#u
>=20
> For completeness, your linked patch fixes a synchronous external abort
> on multiple Qualcomm platforms pointed out in [1].  This patch however
> does not, are you sure they fix the exact same issue?
>=20
> [1]: https://lore.kernel.org/linux-arm-msm/20221115110800.35gl3j43lmbxm3j=
b@SoMainline.org/

Can you check if the below fixes the MSM issue that you're seeing
(applied on top of my earlier patch, though with Brian's reverted
temporarily)?

Thanks,
Thierry

--- >8 ---
diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 11fb7ec883e9..d692ad5c5a27 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -447,10 +447,11 @@ static unsigned long *gpiochip_allocate_mask(struct g=
pio_chip *gc)
=20
 static unsigned int gpiochip_count_reserved_ranges(struct gpio_chip *gc)
 {
+	struct fwnode_handle *fwnode =3D dev_fwnode(&gc->gpiodev->dev);
 	int size;
=20
 	/* Format is "start, count, ..." */
-	size =3D fwnode_property_count_u32(gc->fwnode, "gpio-reserved-ranges");
+	size =3D fwnode_property_count_u32(fwnode, "gpio-reserved-ranges");
 	if (size > 0 && size % 2 =3D=3D 0)
 		return size;
=20
@@ -471,6 +472,7 @@ static int gpiochip_alloc_valid_mask(struct gpio_chip *=
gc)
=20
 static int gpiochip_apply_reserved_ranges(struct gpio_chip *gc)
 {
+	struct fwnode_handle *fwnode =3D dev_fwnode(&gc->gpiodev->dev);
 	unsigned int size;
 	u32 *ranges;
 	int ret;
@@ -483,7 +485,7 @@ static int gpiochip_apply_reserved_ranges(struct gpio_c=
hip *gc)
 	if (!ranges)
 		return -ENOMEM;
=20
-	ret =3D fwnode_property_read_u32_array(gc->fwnode, "gpio-reserved-ranges"=
, ranges, size);
+	ret =3D fwnode_property_read_u32_array(fwnode, "gpio-reserved-ranges", ra=
nges, size);
 	if (ret) {
 		kfree(ranges);
 		return ret;
--- >8 ---

--t/QMyFVa0+ws/Ltf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmN0utoACgkQ3SOs138+
s6HY+w/9FPuWzbA0QDSng/u8HNj0vDTsWe/g5Yf3zW0pdt8x3f9eIL3hivFA7aT8
qEMPLl8JbcoK0VX8Jx6/i6VviJthgKxwjT0ET39uwHMEac7e0P5zNPLoY3T6L6Nq
EFYUYoiHecionPiKK5DxG6+W08BIVmSM0XnwDvK2INRUQGemxE5qPq35v9NK62Ep
nyFZeL2goKpea3F2wUMqFcUHJqVzCaNc7/bgmnrHaAkJpS0kcupkwM4qjPTp3VHl
Ey+M/BsS+NB7Eu45xHSOnwwL0jRhj4LGsmM/q0sYS1tQ9aHiO75x/y0S7pqdIyM6
V0zopPZttwy0OLGfZQcMgiSLVj0rpVXVxH50O+w+GbycibQBKpY3PNt+se9G5foK
FxsDZcyQuRJwEHYnrLqO+Nlne2795YAQbO4OFakg1DU+DQ3zsL8byWwMKBVCpqdy
R0vfwRcC/Bh8CdCs9n0A6//BZhfnsiyXFqyqHxay9QI83/egha4ek8TPEtA6mgMp
vxu4mLJJ+XHCU3HkE6t1/IKsCjXcJgFoWs+HcDoq1N0r0u9cIS0wC+ncti6JyEoN
r1HmQ4anutzfYz8jATxAR1feMYhtKd3iFWwpmWFbnpMDuj8q6JbGaQVaqmhvbQoU
SFGNbDvpzUCUTfEBUKaHRtoNoox6SBu+gzCwpvpIUa9Ml0/v4aw=
=XuqC
-----END PGP SIGNATURE-----

--t/QMyFVa0+ws/Ltf--
