Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 368C6627063
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Nov 2022 17:14:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233401AbiKMQOA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 11:14:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231252AbiKMQN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 11:13:57 -0500
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 929746356
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 08:13:55 -0800 (PST)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-13bef14ea06so10270663fac.3
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 08:13:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rie3aJc2EdJufL+DgKGmAfwMS5IGiPxwZ8BE2w/f1TU=;
        b=lK/RJQYpTTK0XTQPTPPXEm6cwO79eeuR/Svllm0NJbzcU5jjpJfnnkzu6nkzdQ89UP
         oxE6yJW7wz8z1G8RH7r1W2LSZVreJFQ6Bpt8uhS4TFYtzeMXdLjjxDUlkXkBULOjvQAF
         9VbpK1zis0t5LMN6bMkVQIblMI/CPegktj1+As1HPULKsbAKAADLiV3isGbaBFx5PwGz
         Sl3SbbufEy9SK9BASDrYOLKGri87aeksqqYDcRQpm9m7njTNkGibIxBJSh8a6wOlNHxH
         XEZlTLxtTm3VlV08vYN5XWbC5eDsJ5k/0o997xACFQd6ToFPoq1FTxPLQLRw71OJivsJ
         VNxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rie3aJc2EdJufL+DgKGmAfwMS5IGiPxwZ8BE2w/f1TU=;
        b=wXUYw83W+dGGeqwSL+oObrAASKyPw6Kt3DkWRFaPI9MRl49AaE4y0OWPO6MpPKV9Kd
         BWP2xGUgnM5004jBOXn55Y0BVYcGrSuvZGmUdZ1cqUvJv21d0i5+SKRC2Fgbpi6AByxc
         EHTqJtOI+WT64bTAKgOJp1Ku0JbOCe7XGjRrPhWyLwUFiIBUl7cL19Bl9nv85+qUhlCQ
         LpFQC/DnMHgKj6sfDdqN3sXYa6/RlTaPGQUg5lcrwfkxMuTU6hHi8CsClJCJzQX9V3Bq
         ZPpLHzFaowLQWNuKoRiEI/mfaZUsIegYMMvSZHrmVwNZgPeBoYdmGJtcoB2yN1IDDYBv
         N5rQ==
X-Gm-Message-State: ANoB5plxOlBB1mH4Zzp6ZvQwrbp/UxK9Ax729o2tYYlY8H5Kco2YCcsJ
        jVPvD4Rau3f2aJcOv34HeXGo+qgLDJPpPQ==
X-Google-Smtp-Source: AA0mqf5q6u+2A+907zP4rxPzv2WmQbvMPCkOvpeg1RZBaTo13bdnAyTWIl8HolUgtH/YCDBFnhyvEg==
X-Received: by 2002:a05:6870:7816:b0:135:1e5e:e71e with SMTP id hb22-20020a056870781600b001351e5ee71emr5086404oab.223.1668356034915;
        Sun, 13 Nov 2022 08:13:54 -0800 (PST)
Received: from fedora (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id y18-20020a056808061200b0034d8abf42f1sm2770068oih.23.2022.11.13.08.13.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Nov 2022 08:13:54 -0800 (PST)
Date:   Sun, 13 Nov 2022 09:13:34 -0500
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linus.walleij@linaro.org, brgl@bgdev.pl,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        michael@walle.cc, broonie@kernel.org
Subject: Re: [PATCH v2 4/4] gpio: i8255: Migrate to regmap API
Message-ID: <Y3D7jipyk5L655AE@fedora>
References: <cover.1668129763.git.william.gray@linaro.org>
 <61327a67cc308af413471a69a4810b2785e53e8e.1668129763.git.william.gray@linaro.org>
 <Y3Dol6rHduFNQT85@smile.fi.intel.com>
 <Y3D6Lji9bKeSbJaI@fedora>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="oTGlfTqifU6OR20N"
Content-Disposition: inline
In-Reply-To: <Y3D6Lji9bKeSbJaI@fedora>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--oTGlfTqifU6OR20N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 13, 2022 at 09:07:42AM -0500, William Breathitt Gray wrote:
> On Sun, Nov 13, 2022 at 02:52:39PM +0200, Andy Shevchenko wrote:
> > On Thu, Nov 10, 2022 at 08:55:53PM -0500, William Breathitt Gray wrote:
> > >  drivers/gpio/Kconfig            |   2 +
> > >  drivers/gpio/gpio-104-dio-48e.c | 397 ++++++++++-------------------
> > >  drivers/gpio/gpio-gpio-mm.c     | 151 +++--------
> > >  drivers/gpio/gpio-i8255.c       | 429 +++++++++++-------------------=
--
> > >  drivers/gpio/gpio-i8255.h       |  80 +++---
> >=20
> > Can we actually split this to a few steps:
> >  - providing gpio-i8255-regmap
> >  - providing gpio-mm-regmap
> >  - converting the driver
> >  - removing not used modules (one by one)
> > ?
> >=20
> > In this case if any regression somewhere appears, we can always perform=
 a
> > (semi-)revert for a certain driver.
>=20
> Sure, I can split the regmap_irq migration for 104-dio-48e into a
> separate precursor patch to reduce the amount of changes we see here and
> provide a revert path for these IRQ changes. I can do a similar change
> for 104-idi-48 as well.
>=20
> The rest of the changes for 104-dio-48 and gpio-mm are essentially just
> the regmap configurations, so the patch will be largely identical even
> if we migrate gpio-i8255 to regmap API first before migrating again to
> the gpio_regmap in a second patch.

Sorry, I realize now that you meant to split the i8255 gpio_regmap
additions to their own patch, perform the driver migrations in the own
respective patches, and then finally remove the dangling unused i8255
functions and structures. Yes I think that would make for a cleaner
patch series so I'll split it up that way.

William Breathitt Gray

--oTGlfTqifU6OR20N
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCY3D7jgAKCRC1SFbKvhIj
K9xoAQChK9V3hkCewQu4U/YzHkR8KOf3J7N1Pl+9IK7YoX3TgwD+L7FDU83nXmWi
g3MvYstO9i7FwtgWranyHbVBbcbCSwU=
=bAac
-----END PGP SIGNATURE-----

--oTGlfTqifU6OR20N--
