Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C734B6CEF8D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 18:35:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbjC2Qf1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 12:35:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbjC2QfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 12:35:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28FAC61A9;
        Wed, 29 Mar 2023 09:35:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 817C5B8237A;
        Wed, 29 Mar 2023 16:35:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35CEAC433A4;
        Wed, 29 Mar 2023 16:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680107717;
        bh=9Qz5EAmCOL+i+u0TEzl9COJMOzeqVFdc0yFKt5x5s1c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Go7xWPDCKBNfq4Ytevsuw8fdbZYMfquPT5WqMXt5jkfMK8rHWFAEMXPniq6MkRxKV
         pLRo7kbE/bB1NJOgdSiyzoVxcXmmp9YrZQUo/elIokZSlkTDOrFxfyyPUfYsJ3PE6y
         fCRzRWzPNDaaLUIzpH4XbarDbFqfYLzCkdQZZ9X3pys1e3P/jPVhlyPrXq0SA99WDw
         ic9mE49NIASEX2Iz6XnIQRV85YQ1Aqq3gRNlJnJ32hBSXTIrMVUi2ya7R2inE8BnQH
         kS3QNRQ0Xu3dLJh3+Y7JU6pDt0pR3yi3LZZBToP9Gga9ARu/UZVO8KG74Jiz3SjmrR
         JsYF7Zrj3jGmg==
Date:   Wed, 29 Mar 2023 17:35:12 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Alexandre Ghiti <alexghiti@rivosinc.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor.dooley@microchip.com>,
        linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -fixes v2 2/3] riscv: Do not set initial_boot_params to
 the linear address of the dtb
Message-ID: <5f01d8ec-553b-4954-a72d-de212230be96@spud>
References: <20230329081932.79831-1-alexghiti@rivosinc.com>
 <20230329081932.79831-3-alexghiti@rivosinc.com>
 <179c38d6-4298-4a16-b0d7-8aee49a91f58@spud>
 <CAHVXubh9t7VuM337Br-4y7zJp1msr6+bAtr1eVLc+P50V9Bikg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="kjAfQifgMlHd6Dn/"
Content-Disposition: inline
In-Reply-To: <CAHVXubh9t7VuM337Br-4y7zJp1msr6+bAtr1eVLc+P50V9Bikg@mail.gmail.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kjAfQifgMlHd6Dn/
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 29, 2023 at 04:52:45PM +0200, Alexandre Ghiti wrote:
> On Wed, Mar 29, 2023 at 4:37=E2=80=AFPM Conor Dooley <conor@kernel.org> w=
rote:
> >
> > On Wed, Mar 29, 2023 at 10:19:31AM +0200, Alexandre Ghiti wrote:
> > > early_init_dt_verify() is already called in parse_dtb() and since the=
 dtb
> > > address does not change anymore (it is now in the fixmap region), no =
need
> > > to reset initial_boot_params by calling early_init_dt_verify() again.
> > >
> > > Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> > > ---
> > >  arch/riscv/kernel/setup.c | 5 +----
> > >  1 file changed, 1 insertion(+), 4 deletions(-)
> > >
> > > diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
> > > index 542eed85ad2c..a059b73f4ddb 100644
> > > --- a/arch/riscv/kernel/setup.c
> > > +++ b/arch/riscv/kernel/setup.c
> > > @@ -278,10 +278,7 @@ void __init setup_arch(char **cmdline_p)
> > >  #if IS_ENABLED(CONFIG_BUILTIN_DTB)
> > >       unflatten_and_copy_device_tree();
> > >  #else
> > > -     if (early_init_dt_verify(__va(XIP_FIXUP(dtb_early_pa))))
> > > -             unflatten_device_tree();
> >
> > Silly question maybe, but since it isn't explicitly mentioned, the
> > XIP_FIXUP bits no longer matter?
>=20
> The XIP_FIXUP is only needed when translating virtual to physical
> addresses, but that does not mean I did not break it, I haven't
> considered XIP at all...

So, what currently happens is that, during early boot, we call
parse_dtb() right at the beginning of setup_arch().
That calls early_init_dt_scan(dtb_early_pa), which in turn calls
early_init_dt_verify(dtb_early_pa).

Here, relatively late during boot, we are coming along and calling the
function again. This existed prior to the XIP stuff landing, but the
specific XIP_FIXUP handling looks to be the fallout from:
https://lore.kernel.org/linux-riscv/82a05081-5662-c787-44e4-d480774ce31c@gh=
iti.fr/

The check in the first place was added by Anup's move away from fixmap
for dtb stuff, which makes me wonder - should this actually be part of
1/3? Something, something we no longer need to do this because these
addresses no longer change as per 1/3?

> > Also, in related news, I assume you don't have a QEMU setup that can do
> > boot an XIP kernel?
>=20
> I haven't booted a XIP kernel for a long time now, here are my notes
> from that time:
> https://github.com/AlexGhiti/alexghiti.github.io/blob/main/xip/XIP.md

Right, I'll have to get around to trying that. We never put any
investment into QEMU internally, nor run any CI against it, so the HSS
doesn't actually work in QEMU anymore.
Assertion failures due to missing peripheral emulation :(
Probably don't need the HSS though and can do a direct kernel boot, I'll
have to see if that works for this XIP stuff, I know it does for regular
kernels.

Cheers,
Conor.

--kjAfQifgMlHd6Dn/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZCRowAAKCRB4tDGHoIJi
0ha3AQDqn5pBsE36Dp/vUjZCUYNwqjpdLvfFR9ru62ASV7a8CwEAgUXOc+FcR+Ok
bwGeyZ4aob+H7tDntX3k8QaoUhlvkAE=
=idAD
-----END PGP SIGNATURE-----

--kjAfQifgMlHd6Dn/--
