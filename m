Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 214766B5D27
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 16:06:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230263AbjCKPGR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 10:06:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbjCKPGK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 10:06:10 -0500
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5601111E6CA
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 07:06:09 -0800 (PST)
Received: by mail-oo1-xc2c.google.com with SMTP id u3-20020a4ad0c3000000b0052541ef0bafso1229723oor.5
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 07:06:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678547168;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QSjJSFKnSJ9NNZL9oVyJv4eP2OOu2hx/+ygM+UpA2Gk=;
        b=R5gi8dNiXcO8VhEzWnGZ+j1QDnktS/fNhHnRz5EIzqAsQko/NXeD4amguP6U5pRbxT
         YaU8ljLavK2ZKjct/VC7ZlN25yDbjQgGe5z7dkIq0kLgClkbAmYGhS8NgFEl2vPg34gx
         ux8BPoH5tDkhwGPVFHk1ZXql3lXwxXtJEcvLfXmW/cFI1sOcWyNksw7992x7Y85bLAC9
         w19g0q9RR54pHTdoaizS3hbet8DLhnbgeQT07H9c41LKRveLqVo93h1A93WbpIoJOUPq
         9bMDZktPQ4y6Umct1tGpd6Hed7X6DeCsknMu+iAogSMkPzwTJ/megjUy/aHcK5TTJUjm
         hgYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678547168;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QSjJSFKnSJ9NNZL9oVyJv4eP2OOu2hx/+ygM+UpA2Gk=;
        b=rvzyPaolmkqhwoJxQPdM/TMrHaB/wpBrhxRiGOZah+/bfT9PCPkiAUsBamGXBYseQo
         ht17m+gMJyII7YRQq9CihxKMlfWlFhGG/5P3/vMYVIiAjRDoXw6qtznr4g2Q64eA5CCq
         wN6DKO8BCdL5NTHVYsiIoZVem8XGi4iNKqSFCGSkCjH7D3LE67QgX7EUsvWGIT3qkkGl
         PCRztY2l5e+O8LoKdxE2G5b5v4t/f4wN/B4QufnwsUfk6Yf+zZ3QZScs4ryK1Cd6E/zC
         WhTBcSxuN92snixbbzSB6wC/GtHtBraG6SNpueOeh4gb/3lgI/ioRKmtJSUN0G8Nkh+G
         Np9w==
X-Gm-Message-State: AO0yUKVbu7E6Fx1za3GxZQR5exOvhIYXAF9M3o63anlxv9AFbu//Xp8T
        840iVBYCMmvCezkKFllQBcCo1A==
X-Google-Smtp-Source: AK7set8wgUqiaZeZ2snB6JPbJ/8K6anS+l6yd/zrihTWdRMWzgZwMR96bH6fkwKpnWCc1kTMEiavnw==
X-Received: by 2002:a4a:c183:0:b0:51f:fa7e:3804 with SMTP id w3-20020a4ac183000000b0051ffa7e3804mr12287503oop.8.1678547168626;
        Sat, 11 Mar 2023 07:06:08 -0800 (PST)
Received: from fedora (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id x67-20020a4a4146000000b00525240c6149sm1092732ooa.31.2023.03.11.07.06.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Mar 2023 07:06:07 -0800 (PST)
Date:   Sat, 11 Mar 2023 10:06:05 -0500
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     wim@linux-watchdog.org, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Paul Demetrotion <pdemetrotion@winsystems.com>,
        techsupport@winsystems.com
Subject: Re: [PATCH] watchdog: ebc-c384_wdt: Migrate to the regmap API
Message-ID: <ZAyY3VGlo4N4SLZQ@fedora>
References: <20230311004404.62980-1-william.gray@linaro.org>
 <b65233f4-c8e2-435d-8321-03cc5f6b1c3d@roeck-us.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="b+Kv2GvGpypcTEIM"
Content-Disposition: inline
In-Reply-To: <b65233f4-c8e2-435d-8321-03cc5f6b1c3d@roeck-us.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--b+Kv2GvGpypcTEIM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 11, 2023 at 06:04:08AM -0800, Guenter Roeck wrote:
> On Fri, Mar 10, 2023 at 07:44:04PM -0500, William Breathitt Gray wrote:
> > The regmap API supports IO port accessors so we can take advantage of
> > regmap abstractions rather than handling access to the device registers
> > directly in the driver.
> >=20
> > Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
>=20
> I assume you did, but just to be sure: Did you test this on hardware ?

I've only done a build test; I no longer have access to a WINSYSTEMS
EBC-C384 motherboard to test this on real hardware. I've CC'd Paul
Demetrotion and the WINSYSTEMS tech support list to this thread as
hopefully one of the WINSYSTEMS engineers may help us test this.

> > @@ -37,43 +40,54 @@ module_param(timeout, uint, 0);
> >  MODULE_PARM_DESC(timeout, "Watchdog timeout in seconds (default=3D"
> >  	__MODULE_STRING(WATCHDOG_TIMEOUT) ")");
> > =20
> > +static const struct regmap_range ebc_c384_wdt_wr_ranges[] =3D {
> > +	regmap_reg_range(0x1, 0x2),
>=20
> Any reasons for not using defines ?

I feel direct addresses are somewhat clearer in this context. Regmap
configurations describe the address range of valid read and write
operations. Although the range for this device is simple, other devices
might have multiple ranges with gaps of invalid addresses.

For example, our valid write address range is 0x1-0x2 here:

    regmap_reg_range(0x1, 0x2)

Which is much clearer than trying to match these to register defines:

    regmap_reg_range(CFG_REG, PET_REG)

Because it's not immediately clear that CFG_REG to PET_REG is a
contiguous address range.

> > +};
> > +static const struct regmap_access_table ebc_c384_wdt_wr_table =3D {
> > +	.yes_ranges =3D ebc_c384_wdt_wr_ranges,
> > +	.n_yes_ranges =3D ARRAY_SIZE(ebc_c384_wdt_wr_ranges),
> > +};
> > +static const struct regmap_config ebc_c384_wdt_regmap_config =3D {
> > +	.reg_bits =3D 8,
> > +	.reg_stride =3D 1,
> > +	.val_bits =3D 8,
> > +	.io_port =3D true,
> > +	.max_register =3D 0x2,
>=20
> Any reason for not using a define ?

Same reason as above: `max_register =3D 0x2` is already clear enough and
`max_register =3D EBC_C384_MAX_REGISTER` wouldn't add any substantial
clarity.

> > +	.wr_table =3D &ebc_c384_wdt_wr_table,
> > +};
> > +
> >  static int ebc_c384_wdt_start(struct watchdog_device *wdev)
> >  {
> > +	struct regmap *const map =3D wdev->driver_data;
>=20
> Please use watchdog_get_drvdata() and watchdog_set_drvdata() when accessi=
ng
> or setting watchdog driver data.
>=20
> Guenter

I'll adjust the driver_data interactions in my v2 submission to utilize
watchdog_get_drvdata() and watchdog_set_drvdata().

William Breathitt Gray

--b+Kv2GvGpypcTEIM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCZAyY3QAKCRC1SFbKvhIj
K7ZYAP0ame//zn/G+yvSJeRUMTvZqJhg5hNgtPG5kKZDam+8mgEA2zNrGImNqwNe
bjBGtRFEADurS58TbPdwdjn8yZ+9QAE=
=zCZs
-----END PGP SIGNATURE-----

--b+Kv2GvGpypcTEIM--
