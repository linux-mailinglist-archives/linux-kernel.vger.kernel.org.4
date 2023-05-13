Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EEA270196D
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 20:51:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232006AbjEMSvv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 14:51:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjEMSvu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 14:51:50 -0400
Received: from maynard.decadent.org.uk (maynard.decadent.org.uk [95.217.213.242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3F49171D
        for <linux-kernel@vger.kernel.org>; Sat, 13 May 2023 11:51:48 -0700 (PDT)
Received: from [213.219.167.32] (helo=deadeye)
        by maynard with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1pxuL1-0007nD-35; Sat, 13 May 2023 20:51:27 +0200
Received: from ben by deadeye with local (Exim 4.96)
        (envelope-from <ben@decadent.org.uk>)
        id 1pxuKz-007N1Y-1u;
        Sat, 13 May 2023 20:51:25 +0200
Message-ID: <9fcf1d5f1612d45b60a65340d125364c5ae26dfb.camel@decadent.org.uk>
Subject: Re: [PATCH] perf tools: Use $KBUILD_BUILD_TIMESTAMP as man page date
From:   Ben Hutchings <ben@decadent.org.uk>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Salvatore Bonaccorso <carnil@debian.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-kernel@vger.kernel.org
Date:   Sat, 13 May 2023 20:51:16 +0200
In-Reply-To: <ZFuVRK4cKapgaRwD@kernel.org>
References: <20160517132809.GE7555@decadent.org.uk>
         <ZFqZAB2ZShmdKtvy@eldamar.lan> <ZFuVRK4cKapgaRwD@kernel.org>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-2EmWy/SIbKwgYwszJqQR"
User-Agent: Evolution 3.46.4-1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 213.219.167.32
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on maynard); SAEximRunCond expanded to false
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-2EmWy/SIbKwgYwszJqQR
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2023-05-10 at 09:59 -0300, Arnaldo Carvalho de Melo wrote:
> Em Tue, May 09, 2023 at 09:03:28PM +0200, Salvatore Bonaccorso escreveu:
> > Hi Peter, Ingo, Arnaldo,
> >=20
> > On Tue, May 17, 2016 at 02:28:09PM +0100, Ben Hutchings wrote:
> > > This allows man pages to be built reproducibly.
> > >=20
> > > Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
> > > ---
> > > --- a/tools/perf/Documentation/Makefile
> > > +++ b/tools/perf/Documentation/Makefile
> > > @@ -120,6 +120,9 @@ endif
> > >  ifdef DOCBOOK_SUPPRESS_SP
> > >  XMLTO_EXTRA +=3D -m manpage-suppress-sp.xsl
> > >  endif
> > > +ifdef KBUILD_BUILD_TIMESTAMP
> > > +ASCIIDOC_EXTRA +=3D -a revdate=3D$(shell date -u -d '$(KBUILD_BUILD_=
TIMESTAMP)' +%Y-%m-%d)
> > > +endif
> > > =20
> > >  SHELL_PATH ?=3D $(SHELL)
> > >  # Shell quote;
> > > --- a/tools/perf/Documentation/asciidoc.conf
> > > +++ b/tools/perf/Documentation/asciidoc.conf
> > > @@ -71,6 +71,9 @@ ifdef::backend-docbook[]
> > >  [header]
> > >  template::[header-declarations]
> > >  <refentry>
> > > +<refentryinfo>
> > > +template::[docinfo]
> > > +</refentryinfo>
> > >  <refmeta>
> > >  <refentrytitle>{mantitle}</refentrytitle>
> > >  <manvolnum>{manvolnum}</manvolnum>
> >=20
> > As we do apply the change in Downstream in Debian, I was wondering if
> > it just felt trough the cracks and could still be applied. Is there
> > anything missing?
>=20
> Isn't this fixed in:
>=20
> commit d586ac10ce56b2381b8e1d8ed74660c1b2b8ab0d
> Author: Ian Rogers <irogers@google.com>
> Date:   Fri Sep 20 21:13:27 2019 -0700
>=20
>     perf docs: Allow man page date to be specified
>=20
>     With this change if a perf_date parameter is provided to asciidoc the=
n
>     it will override the default date written to the man page metadata.
[...]

Not entirely, because the value for perf_date is currently generated
with "git log", and Debian package builds are not done from a Git
checkout.  I'll revise my patch to allow perf_date to be set from
KBUILD_BUILD_TIMESTAMP, which is already used in the kernel build.

Ben.

--=20
Ben Hutchings
Life would be so much easier if we could look at the source code.

--=-2EmWy/SIbKwgYwszJqQR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAmRf3CQACgkQ57/I7JWG
EQkSKg/9HldI3e96mr8bj+uUS34ySDEaf7m4gFRU4phX02nDUrm3Nk2R85iguTCa
L+Hj4vLZqyI24RfNEKyvdROi7qz6TRyQAuUZittM2c+IQ0BSrxCWlBfzrppp2NUB
8Oz4T4I9NQVLYB3I0znRrbJAscMhhCKYYMa8fgJ4rhdpoYNYXggAgCoew58SnXgN
E2qnHb8ARxQxMJ9G0+EkyvijfeHKgy/7BfpfXi1E6xIzpkE6xK0rMs0UuphwnYhE
aiGZqKxo2FaBUEPUKgVwvEkjurlaeDrrnfU/L2UvjpkyOvjh3Iu7jo6ZtRDOip02
WTjhC9hsmfmyBvwH6Xe8nORp4wcVwNFYRBtGonyFHpE2wogwc0zgaeGk08dW6CkY
KfiACsdDz1T/dqWCMYAwKj5ItJXXE9Sf8MTVAit+XleuJ4DMGiKHIbVlhesMCpdc
rFZDh7awQsrxPdLOcQZ7xMzv0uPOnYamDZgqnvyP433KqP2U6yogwalBlgVyz891
+nDaRpB2lcNXuOPcwlacqla8e2EWD80jlrl4/8Kv8dpewhccpzwMDxwn4CdJv2Mk
I62aHl+3znXltKusC26T28ly6zZ1h0Cy/kz++mM9YaZwAlx4itIWm6OFGVKUxelO
0EY2ecx1p+d7gXXw+qC2nABJNJ4VnTRLcerZgUQOIiIbgQFlkKU=
=WjoT
-----END PGP SIGNATURE-----

--=-2EmWy/SIbKwgYwszJqQR--
