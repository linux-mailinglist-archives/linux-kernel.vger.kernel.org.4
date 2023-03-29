Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59FBA6CED0D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 17:34:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbjC2Pe0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 11:34:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbjC2Pd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 11:33:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0420F49FA;
        Wed, 29 Mar 2023 08:33:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9341461D8E;
        Wed, 29 Mar 2023 15:33:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28112C433D2;
        Wed, 29 Mar 2023 15:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680104030;
        bh=IxAbBP9UjglHluPryJjf4M5TDGTVE3KN+oepn4YHf/w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g0APkOz/qZlNfpr2NCNDI4Pxe00LN4KoAe4O+FwTiY/73aViE1XZUWX9msBX4VEUR
         p67+BKKQJlNR7Lj+fjdM/ZfVWb7Pr4yAP9i4Rp+Vi8KFRw651xspY0SFOzlqLnxZON
         zMant2XIebI+d/+eV80EXyK5c1zt8Bnxuvd/ML9bnE7tdAUwkJLJGhGtpTPlaX0s8/
         oLpETCOSK91MCNujSKsefWxOSoATkQBWOh7cqWCK7bYp7Vct5dDH63jYR1czg6Z6V6
         ipU59BL2UDAV4M9hPSAlmyAXIQIF562uUKjo0eRIta/o6JPHxAVR3g+JrDcSwIEIwi
         Yh7SKufVBPXmg==
Date:   Wed, 29 Mar 2023 16:33:45 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Alexandre Ghiti <alexghiti@rivosinc.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor.dooley@microchip.com>,
        linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -fixes v2 3/3] riscv: No need to relocate the dtb as it
 lies in the fixmap region
Message-ID: <9c90f390-92d2-4dde-8cd7-b50e9c858787@spud>
References: <20230329081932.79831-1-alexghiti@rivosinc.com>
 <20230329081932.79831-4-alexghiti@rivosinc.com>
 <381c2753-cbcc-40a0-bcb2-67d18e367822@spud>
 <CAHVXubhVGR1vjqFVv1vuDGDMSiG0JBpKtRZnzgzpa9VBK+BuNw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="nf9NXaBcWq31jVDo"
Content-Disposition: inline
In-Reply-To: <CAHVXubhVGR1vjqFVv1vuDGDMSiG0JBpKtRZnzgzpa9VBK+BuNw@mail.gmail.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--nf9NXaBcWq31jVDo
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 29, 2023 at 04:40:18PM +0200, Alexandre Ghiti wrote:
> On Wed, Mar 29, 2023 at 3:56=E2=80=AFPM Conor Dooley <conor@kernel.org> w=
rote:
> >
> > On Wed, Mar 29, 2023 at 10:19:32AM +0200, Alexandre Ghiti wrote:
> > > We used to access the dtb via its linear mapping address but now that=
 the
> > > dtb early mapping was moved in the fixmap region, we can keep using t=
his
> > > address since it is present in swapper_pg_dir, and remove the dtb
> > > relocation.
> > >
> > > Note that the relocation was wrong anyway since early_memremap() is
> > > restricted to 256K whereas the maximum fdt size is 2MB.
> >
> > So, should this be marked as a fix, and backported along with 1/3?
>=20
> Hmmm the whole series should be backported, it does not make sense to
> move the dtb mapping and keep accessing it using its linear mapping
> address since it could fail for the exact reason the relocation was
> implemented in the first place and the relocation is wrong.
>=20
> Maybe we should simply add a "Cc: stable@vger.kernel.org" on all the patc=
hes?

Yup, although hopefully Palmer can handle that if nothing else needs
changing.

--nf9NXaBcWq31jVDo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZCRaWQAKCRB4tDGHoIJi
0mnyAQDXKpwmfpB5q4X6QPOw2jiCPiYKY75s1bbJ5ruHbLirBAD/XxFephOltSEa
xNmJKur1/tjGtJkHfUraiWjc0d6WGgo=
=WNhR
-----END PGP SIGNATURE-----

--nf9NXaBcWq31jVDo--
