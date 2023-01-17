Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 741C966D38D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 01:02:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233680AbjAQACj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 19:02:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233886AbjAQACg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 19:02:36 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 833D42333C;
        Mon, 16 Jan 2023 16:02:34 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Nwpx052cYz4xGq;
        Tue, 17 Jan 2023 11:02:28 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1673913749;
        bh=AHJpO7amNWKomHiN8ExtLZ0DIxReCogY/rawVa+qcZo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kanlpUU+tMqS3D8SIfj/4PMMkPSofmjlWwpc9p/QLjUbIzBZlg2BzQ8GFyWvrAh2Q
         1m+EdcJZti83thAfeYD5gKeSczIa9+NmrGyolJsmQy1v4Znaie6Ol2V0Zc2hZNznct
         aln5qBzhMRNKikKKh3PacYRk0jBa7MrTOUE+Xd9C/dV41aYIdoYuwl8Kst1DOuKR7j
         rkqvX3me1Xee3qi2uI3z2K2BSdXsO5VaM+Q0IVey8wnF5NOF0PsdUV88x/Hi76Z7NK
         eYdck0bYeZXVZD6p7vvu0rNJ5Qzk+T4hadxWmIZR7YEcal7ppnftccFz8/d+D2OWIi
         N1T/ecSgtIsUQ==
Date:   Tue, 17 Jan 2023 11:02:27 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Linux Crypto List <linux-crypto@vger.kernel.org>,
        Danny Tsen <dtsen@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: [PATCH] crypto: p10-aes-gcm - Use _GLOBAL instead of .global
Message-ID: <20230117110227.39fbadcc@canb.auug.org.au>
In-Reply-To: <Y8UWHwTkKIkQn1t0@gondor.apana.org.au>
References: <20230116112939.0820ff24@canb.auug.org.au>
        <Y8UWHwTkKIkQn1t0@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/sQaKN0CTQtCVdeLquIPP2Qc";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/sQaKN0CTQtCVdeLquIPP2Qc
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Herbert,

On Mon, 16 Jan 2023 17:17:19 +0800 Herbert Xu <herbert@gondor.apana.org.au>=
 wrote:
>
> On Mon, Jan 16, 2023 at 11:29:39AM +1100, Stephen Rothwell wrote:
> >=20
> > After merging the crypto tree, today's linux-next build (powerpc
> > ppc64_defconfig) failed like this:
> >=20
> > ERROR: modpost: ".aes_p10_gcm_decrypt" [arch/powerpc/crypto/p10-aes-gcm=
-crypto.ko] undefined!
> > ERROR: modpost: ".aes_p10_gcm_encrypt" [arch/powerpc/crypto/p10-aes-gcm=
-crypto.ko] undefined!
> >=20
> > Caused by commits
> >=20
> >   cc40379b6e19 ("crypto: p10-aes-gcm - Glue code for AES/GCM stitched i=
mplementation")
> >   ca68a96c37eb ("crypto: p10-aes-gcm - An accelerated AES/GCM stitched =
implementation") =20
>=20
> Does this patch help?

Yes, that fixes the PowerPC build, thanks.

Tested-by: Stephen Rothwell <sfr@canb.auug.org.au> # build test only

I have added the patch to linux-next for today.
--=20
Cheers,
Stephen Rothwell

--Sig_/sQaKN0CTQtCVdeLquIPP2Qc
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPF5ZMACgkQAVBC80lX
0GyGrAf/X1lj8waHr3CwumTQIs/llcerw3VhsR5qFiRnoksQLbnErRNtIM2NXHL4
eWMKduSb4fO6FHjscsnD5/YOyIoGnrGvQXXI5kTQpmlY3+EDwDu4nlgNv/UuQAaM
XqyBRggufJonBPoTZi8b3vyy0uXH3d1DPACm9Pjufi3ZgUGTzQGz3RgHc52Pr7I6
fH+5zyuab5s88J8WJdKaTnCyao2KpKZ48jGcfkAdaLf1+gq2grP7kN7Ch3XWkjiV
AXPKeiVqpCd0oHLHHKkjFCZxSIZYlJMld9ijLx0Xi74Wz0TZjiQTigxUJFlK3xPF
A+biR6AfJr1K0dAsBLwQU8p7HvXrBw==
=mHah
-----END PGP SIGNATURE-----

--Sig_/sQaKN0CTQtCVdeLquIPP2Qc--
