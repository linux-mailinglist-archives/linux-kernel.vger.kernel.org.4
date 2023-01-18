Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F013D671175
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 04:05:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbjARDEy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 22:04:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjARDEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 22:04:50 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70C9A4FC3F;
        Tue, 17 Jan 2023 19:04:48 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NxVwt4lM1z4wgq;
        Wed, 18 Jan 2023 14:04:46 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1674011087;
        bh=M3BcInVBdGIb/eB5yTCtLvBO8sYnUT7vEAWHpGvU/p8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=rxpofKDtHQGO3VvuGcfmLroaX6kR+MQdUAci0CxVCxv2W9IhvCgSmZt3wSyLQmRNg
         A8FVyjsDa7yc7mx/6AZqzOAwvxzpqCxaY6S3M2YpIobT0NzyCFfRCq+q/RS0mLTbzM
         4o4lxrV44qlzjG6XudBb2iqgF0CGxRTOnNIbAxXh7OuyKYYw2vtLKUpijZjbd6VDde
         vA8ol94I8/pG9Rw/gZdfzq+86VIPOLOsDdKbWtJlPWb3OhWFucOVlqyhh6pJR5DeWa
         ENcrhYql/DiGenJsUvPgwYvHsb+zV6u3vk/pvt5Y/P0IhQkZr3MXoDlxXG8zPzZdZ9
         yfJw0tlxL6cBA==
Date:   Wed, 18 Jan 2023 14:04:44 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Linux Crypto List <linux-crypto@vger.kernel.org>,
        Danny Tsen <dtsen@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        PowerPC <linuxppc-dev@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: crypto: p10-aes-gcm - Add asm markings necessary for kernel
 code
Message-ID: <20230118140444.25353e67@canb.auug.org.au>
In-Reply-To: <Y8ZNoBSX5P0ieJ3t@gondor.apana.org.au>
References: <20230117144747.37115c52@canb.auug.org.au>
        <Y8ZNoBSX5P0ieJ3t@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/d5q8/40ndh9awWN2bgWdQ/3";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/d5q8/40ndh9awWN2bgWdQ/3
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Herbert,

On Tue, 17 Jan 2023 15:26:24 +0800 Herbert Xu <herbert@gondor.apana.org.au>=
 wrote:
>
> On Tue, Jan 17, 2023 at 02:47:47PM +1100, Stephen Rothwell wrote:
> > Hi all,
> >=20
> > After merging the crypto tree, today's linux-next build (powerpc
> > pseries_le_defconfig) failed like this:
> >=20
> > arch/powerpc/crypto/p10_aes_gcm.o: warning: objtool: .text+0x884: unann=
otated intra-function call
> > arch/powerpc/crypto/aesp8-ppc.o: warning: objtool: aes_p8_set_encrypt_k=
ey+0x44: unannotated intra-function call
> > ld: arch/powerpc/crypto/p10_aes_gcm.o: ABI version 1 is not compatible =
with ABI version 2 output
> > ld: failed to merge target specific data of file arch/powerpc/crypto/p1=
0_aes_gcm.o
> >=20
> > Caused by commit
> >=20
> >   ca68a96c37eb ("crypto: p10-aes-gcm - An accelerated AES/GCM stitched =
implementation")
> >=20
> > I have applied the following hack for today. =20
>=20
> Thanks Stephen, I'm going to update the previous fix as follows:

I still get:

arch/powerpc/crypto/aesp8-ppc.o: warning: objtool: aes_p8_set_encrypt_key+0=
x44: unannotated intra-function call

from the powerpc pseries_le_defconfig build (which is otherwise ok).

Now I also get (from a powerpc allyesconfig build):

tmp/cc8g6b4E.s: Assembler messages:
tmp/cc8g6b4E.s: Error: .size expression for gcm_init_p8 does not evaluate t=
o a constant
tmp/cc8g6b4E.s: Error: .size expression for .gcm_init_p8 does not evaluate =
to a constant
tmp/cc8g6b4E.s: Error: .size expression for gcm_init_htable does not evalua=
te to a constant
tmp/cc8g6b4E.s: Error: .size expression for .gcm_init_htable does not evalu=
ate to a constant
tmp/cc8g6b4E.s: Error: .size expression for gcm_gmult_p8 does not evaluate =
to a constant
tmp/cc8g6b4E.s: Error: .size expression for .gcm_gmult_p8 does not evaluate=
 to a constant
tmp/cc8g6b4E.s: Error: .size expression for gcm_ghash_p8 does not evaluate =
to a constant
tmp/cc8g6b4E.s: Error: .size expression for .gcm_ghash_p8 does not evaluate=
 to a constant
make[4]: *** [next/scripts/Makefile.build:374: arch/powerpc/crypto/ghashp8-=
ppc.o] Error 1
tmp/ccNrBtc1.s: Assembler messages:
tmp/ccNrBtc1.s: Error: .size expression for aes_p8_set_encrypt_key does not=
 evaluate to a constant
tmp/ccNrBtc1.s: Error: .size expression for .aes_p8_set_encrypt_key does no=
t evaluate to a constant
tmp/ccNrBtc1.s: Error: .size expression for aes_p8_set_decrypt_key does not=
 evaluate to a constant
tmp/ccNrBtc1.s: Error: .size expression for .aes_p8_set_decrypt_key does no=
t evaluate to a constant
tmp/ccNrBtc1.s: Error: .size expression for aes_p8_encrypt does not evaluat=
e to a constant
tmp/ccNrBtc1.s: Error: .size expression for .aes_p8_encrypt does not evalua=
te to a constant
tmp/ccNrBtc1.s: Error: .size expression for aes_p8_decrypt does not evaluat=
e to a constant
tmp/ccNrBtc1.s: Error: .size expression for .aes_p8_decrypt does not evalua=
te to a constant
tmp/ccNrBtc1.s: Error: .size expression for aes_p8_cbc_encrypt does not eva=
luate to a constant
tmp/ccNrBtc1.s: Error: .size expression for .aes_p8_cbc_encrypt does not ev=
aluate to a constant
tmp/ccNrBtc1.s: Error: .size expression for aes_p8_ctr32_encrypt_blocks doe=
s not evaluate to a constant
tmp/ccNrBtc1.s: Error: .size expression for .aes_p8_ctr32_encrypt_blocks do=
es not evaluate to a constant
tmp/ccNrBtc1.s: Error: .size expression for aes_p8_xts_encrypt does not eva=
luate to a constant
tmp/ccNrBtc1.s: Error: .size expression for .aes_p8_xts_encrypt does not ev=
aluate to a constant
tmp/ccNrBtc1.s: Error: .size expression for aes_p8_xts_decrypt does not eva=
luate to a constant
tmp/ccNrBtc1.s: Error: .size expression for .aes_p8_xts_decrypt does not ev=
aluate to a constant
make[4]: *** [next/scripts/Makefile.build:374: arch/powerpc/crypto/aesp8-pp=
c.o] Error 1
make[4]: Target 'arch/powerpc/crypto/' not remade because of errors.

$ grep gcm_init_p8 arch/powerpc/crypto/ghashp8-ppc.s
.align 2 ; .type gcm_init_p8,@function; .globl gcm_init_p8; gcm_init_p8:
.size gcm_init_p8,.-.gcm_init_p8
.size .gcm_init_p8,.-.gcm_init_p8

I have just marked CRYPTO_P10_AES_GCM as BROKEN for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/d5q8/40ndh9awWN2bgWdQ/3
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPHYcwACgkQAVBC80lX
0GziiAf/a7dQVij/7kJX36npVT5mYMIuyE334Zgbza3Gmd4KG//ah30gYZvin/7L
tfdBgix0zKknGuSJATGs3vVxJUM5CahLwTYyN7XXO1JKuSTZ38Mo7aKMb7GA6leU
4vhULq53kfckA4A7b49buAzXZVY/0uWM4csvbtto6Fp8oC6MHoBtpgm/7JHFFiUj
WNir3nwi3J2OCu1emMBfF1Vna38FT+nZWU5z8nklS7oojuEm+JW26A3KRgjIdg5R
oiU7IiOT0qYKd8WQfap74qkLaGxAd1ZIGIdMvpUks3iS3p9K/HiGXc8nKqRVXhyd
hkIMeiBJVIAD9XEsx47ucLaP0acAPA==
=wJm4
-----END PGP SIGNATURE-----

--Sig_/d5q8/40ndh9awWN2bgWdQ/3--
