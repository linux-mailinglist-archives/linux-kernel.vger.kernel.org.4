Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AAC45B7817
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 19:36:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232449AbiIMRgW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 13:36:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233156AbiIMRf5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 13:35:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36EF09C1D3;
        Tue, 13 Sep 2022 09:25:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C801561505;
        Tue, 13 Sep 2022 16:25:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ABA4C433C1;
        Tue, 13 Sep 2022 16:25:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663086357;
        bh=8vJ/UUqlCSFJed61igiwRoW2/DOdxtHeMwQmw4L0tC4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NnTnDB8u0/XsRatUnyZHBfj7yzEf6HklHBboxKgJ0dZaV/NF16Fex9lnrUrYyQeyS
         Fwcm3tiUgxV8oNDhpB4IrN2URwP2yRc6q3bVFotauOkGCsquzXcl9wH7CnkQxTZPoQ
         cOXtnJiRZcunhjkoaeLilyuozWMwisjyZiLP1PdlwyC5AdEntmHMYMGPQCcLbf48Ej
         0+d5MpMF/4ub4kLT8TBSwmWJrBu6itN8dviuBMSofHOBjDTY8ETG49ShxvJuvTjuoF
         Efrh+zVSYmgJWbAuUKP5h9ZMou6H3ajjH27lCVi7YzuPuiakX5Zx6YXECsZLSnQNPJ
         SI1g9Wzg/c05Q==
Date:   Tue, 13 Sep 2022 12:25:54 -0400
From:   William Breathitt Gray <wbg@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     William Breathitt Gray <william.gray@linaro.org>, brgl@bgdev.pl,
        linus.walleij@linaro.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org
Subject: Re: [PATCH 2/3] gpio: 104-idio-16: Utilize the idio-16 GPIO library
Message-ID: <YyCvEqPyNB+zAK8U@ishi>
References: <cover.1662927941.git.william.gray@linaro.org>
 <6f8b7d379a83e1509ec790bbaf0a9e15fdf26180.1662927941.git.william.gray@linaro.org>
 <YyCtdw14JijxsEQ4@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3ufRt+hoOry1rdxq"
Content-Disposition: inline
In-Reply-To: <YyCtdw14JijxsEQ4@smile.fi.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3ufRt+hoOry1rdxq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 13, 2022 at 07:19:03PM +0300, Andy Shevchenko wrote:
> On Sun, Sep 11, 2022 at 04:34:39PM -0400, William Breathitt Gray wrote:
> > The ACCES 104-IDIO-16 device is part of the ACCES IDIO-16 family, so the
> > idio-16 GPIO library module is selected and utilized to consolidate
> > code.
>=20
> > +	/* Reading output signals is not supported */
> > +	if (offset < IDIO_16_NOUT)
> >  		return -EINVAL;
>=20
> I see it's in the original code, but isn't it possible to cache and return
> cached value in such cases?
>=20
> --=20
> With Best Regards,
> Andy Shevchenko

I think you're right, we're already caching the outputs for the sake of
the signal set calls, so we can just return those respective output
values for the signal get calls. It should also save us some cycles by
avoiding the read8() calls for the outputs in the PCI-IDIO-16 case.

William Breathitt Gray

--3ufRt+hoOry1rdxq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCYyCvEgAKCRC1SFbKvhIj
K+xAAQCBkEg0rtlQVJ8koaK1tME77efiRZW7NpitUewpqEb30wD6A2dNj1Tfmi22
+hbHskwM7K5n7Y0/InctcY0S1FK3agc=
=y2tL
-----END PGP SIGNATURE-----

--3ufRt+hoOry1rdxq--
