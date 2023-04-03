Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17E586D54AE
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 00:21:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233631AbjDCWVH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 18:21:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233653AbjDCWVE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 18:21:04 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 115A44692
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 15:21:00 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-54601d90118so424366067b3.12
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 15:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680560459;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4tpYjQoj3oN1IoUY/Iv8IxUfroJ3Fr1IgWFkmKykvfw=;
        b=HUCtM1lJauriEzHWd+aWCI2BC8Jq48a1ShnRUosbft5UxPct5+OFyOeCZ8yiBaH+dM
         XvlbZklHGWDBjrSxJb3S7WHBaMeE7TNRCfDDKyxWoJqEGj6SJpfJc2I1Sujgg0xQGq5O
         TGNMqh7PO8PND6u+4tHPY0CygO35y1/lzCviyFk1f9M4cN8TZZ80Xe9D+gYHrnIlCgdP
         5Upf6ZvrtLzwyU4djqswhaS5ekk+mzcLx88CsIpW9dsiUuFmiwFlf6Lpvy0kLNJRINcX
         foDoHo94QrviD0U9ABQnD3TktIYD3+Foq2Mkohi5+T1AQtQONhCyyois8ynFG+61p7Or
         6zZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680560459;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4tpYjQoj3oN1IoUY/Iv8IxUfroJ3Fr1IgWFkmKykvfw=;
        b=WUBCH77d753JH82stEWWJtPdA0cKZlJhtenbP/TK4C9LlYYsTpTO+Mog5989qAa1s4
         nDRFBOZy90iRKULwSfC+Hz/gLeCvMfpwY0Nl3+XSSy0MdgxTOaOumWNHkmzCFSfasTL7
         RJVgV1T966PqtSm+KmqIvd7Y36XFrZdIX/Grx2ijT1k0dSYd8+C7Y5c50cmFSIzm6MXS
         70O+Cp6I2TOKpQHk6kZ03Nvzuo04ds/b44K+yO5cRJLHxKRx1JpefTQQ2krkT16M/RJe
         gYdBXbgrLuiqHN9e3QcVBBg1XxbJC58Q75dlFasYfdUbd2n1w/q5FuVfgBWHR59A97iL
         2WKw==
X-Gm-Message-State: AAQBX9cR7XmKZYFzTGDritaq+ueGl8wTnxj+363cKRliueTFejYZITPP
        DZeXco84s1yra0lEm8bP04KffQ==
X-Google-Smtp-Source: AKy350admhROloQrgoeQCgd64bNrsFHuglHZb134fctMGzhDpYAOaPKSIb+hcRc2bKcZcNpF/uRDvA==
X-Received: by 2002:a81:a00a:0:b0:541:75a3:9bc8 with SMTP id x10-20020a81a00a000000b0054175a39bc8mr434644ywg.44.1680560459064;
        Mon, 03 Apr 2023 15:20:59 -0700 (PDT)
Received: from fedora (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id cg9-20020a05690c0a0900b00545a08184b8sm2794019ywb.72.2023.04.03.15.20.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 15:20:58 -0700 (PDT)
Date:   Mon, 3 Apr 2023 18:20:56 -0400
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        techsupport@winsystems.com,
        Paul Demetrotion <pdemetrotion@winsystems.com>,
        Michael Walle <michael@walle.cc>
Subject: Re: [PATCH v5 3/3] gpio: ws16c48: Migrate to the regmap API
Message-ID: <ZCtRSFLL5lkDimeL@fedora>
References: <cover.1679845842.git.william.gray@linaro.org>
 <58531b1b2428e4d5d2ea79e721f7ef6450665280.1679845842.git.william.gray@linaro.org>
 <ZCF9bdyefA/oDmdG@smile.fi.intel.com>
 <ZCmThuzUBYdp29UR@fedora>
 <f4377c61-8745-477d-ab8f-f83de203c4b3@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="50JiiM9KWQUDRx4Z"
Content-Disposition: inline
In-Reply-To: <f4377c61-8745-477d-ab8f-f83de203c4b3@sirena.org.uk>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--50JiiM9KWQUDRx4Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 03, 2023 at 10:12:44PM +0100, Mark Brown wrote:
> On Sun, Apr 02, 2023 at 10:39:02AM -0400, William Breathitt Gray wrote:
> > On Mon, Mar 27, 2023 at 02:26:37PM +0300, Andy Shevchenko wrote:
> > > On Sun, Mar 26, 2023 at 12:25:59PM -0400, William Breathitt Gray wrot=
e:
>=20
> > > > +static const struct regmap_config ws16c48_regmap_config =3D {
> > > > +	.reg_bits =3D 8,
> > > > +	.reg_stride =3D 1,
> > > > +	.val_bits =3D 8,
> > > > +	.io_port =3D true,
> > > > +	.max_register =3D 0xA,
> > > > +	.wr_table =3D &ws16c48_wr_table,
> > > > +	.rd_table =3D &ws16c48_rd_table,
> > > > +	.volatile_table =3D &ws16c48_volatile_table,
> > > > +	.cache_type =3D REGCACHE_FLAT,
> > > > +};
>=20
> > > Do we need regmap lock?
>=20
> > We make regmap calls within an interrupt context in this driver so I
> > think we need to disable the default regmap mutex locking behavior; I
> > believe the current raw_spin_lock locking in this driver is enough to
> > protect access.
>=20
> The above doesn't configure the regmap locking so you'll have a spinlock
> by default (MMIO being a fast bus).

You're right, it'll be a spinlock in this case and not mutex.
Unfortunately, we'll still need to change that to avoid deadlocks on -rt
kernels [0].

William Breathitt Gray

[0] https://lore.kernel.org/all/1466065537-82027-1-git-send-email-mika.west=
erberg@linux.intel.com/

--50JiiM9KWQUDRx4Z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCZCtRSAAKCRC1SFbKvhIj
Ky0DAP9IpyENdB034mfM5YZYx5/meDB6ZINnU28U/PqlovWaAAD9Hf4p7mhg2j/v
Wxu906U2SCA8gH1bxrcyur4P5T0EHgY=
=fMtc
-----END PGP SIGNATURE-----

--50JiiM9KWQUDRx4Z--
