Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57B975B2E91
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 08:14:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230305AbiIIGOC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 02:14:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbiIIGOA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 02:14:00 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CFA1115393;
        Thu,  8 Sep 2022 23:13:58 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MP5Kc4JYWz4xPB;
        Fri,  9 Sep 2022 16:13:56 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1662704036;
        bh=h/w3iXPzuRmLpRLPhEaFTzmdbpFE8fISJwtM0V1+lq0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=uO8xJ4369N/o/HVHItF1PXU0z0qzmlX2bbKtVp4lxeGFtbmz5lvBg2g1GgeiLcA2x
         mjSkiV9wj23RdkM839aSzgN1cPZaQv/hurqoSwwjzmoRXv+yldufyzn7wmvmIq9RX5
         Lt9YEg563S3WAKtkSs4WJwOyjGRSBsjMX8xoEkgJkGGgdCSHGQI2ALZ+W5eO2/SoFC
         3E3Q4o1oIMu+zBdt+9uKgfvKnZacwNUN5QTHMBIa2XxpfzqQqr+FqkwPyLQBMSw81L
         2UEqnNNZAB8iQlmZQLaCuP/MGjTGU6sQYTi784R1UlvZaLmXZexWWLOACEkFYCuRKy
         1eD1na/qffkNA==
Date:   Fri, 9 Sep 2022 16:13:54 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the kbuild tree
Message-ID: <20220909161354.2c94a495@canb.auug.org.au>
In-Reply-To: <20220909152453.5400cf7e@canb.auug.org.au>
References: <20220909090024.47458048@canb.auug.org.au>
        <CAK7LNARPX2Ov-nLAT6mPWbgqQMDCuoW84VN_C2sS1CJkR_n8YQ@mail.gmail.com>
        <20220909152453.5400cf7e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/f75Tq2StyWukWIPMSopuQOo";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/f75Tq2StyWukWIPMSopuQOo
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, 9 Sep 2022 15:24:53 +1000 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>
> On Fri, 9 Sep 2022 14:10:06 +0900 Masahiro Yamada <masahiroy@kernel.org> =
wrote:
> >
> > Hmm, I am testing allmodconfig in my tree,
> > but it is not reproducible so far.
> >=20
> > Do you have any more hint?
> > (which commit exactly?, and what build command did you use? etc.) =20
>=20
> I was trying your top of tree commit
>=20
>   99ea8da56dca "kbuild: use objtool-args-y to clean up objtool arguments"
>=20
> (merged with Linus' tree and some fix patches).
>=20
> I am doing a cross build with an out of tree object directory:
>=20
> $ make ARCH=3Dx86_64 CROSS_COMPILE=3Dx86_64-linux-gnu- O=3D../x86_64_allm=
odconfig -s allmodconfig
> $ make ARCH=3Dx86_64 CROSS_COMPILE=3Dx86_64-linux-gnu- O=3D../x86_64_allm=
odconfig -j100 -O -s

So it seems to be related to doing an incremental build.  I have just
built my "pending-fixes" branch (which I have pushed out to the
linux-next tree on git.kernel.org), then merged your tree and then
built again:

$ make ARCH=3Dx86_64 CROSS_COMPILE=3Dx86_64-linux-gnu- O=3D../obj -j15 -O
make[1]: Entering directory '/home/sfr/kernels/obj'
  GEN     Makefile
make[1]: Leaving directory '/home/sfr/kernels/obj'
make[1]: Entering directory '/home/sfr/kernels/obj'
  UPD     include/generated/compile.h
make[1]: Leaving directory '/home/sfr/kernels/obj'
  DESCEND objtool
make[2]: *** No rule to make target 'objtool/objtool'.  Stop.
make[1]: *** [/home/sfr/kernels/test/Makefile:1361: tools/objtool/objtool] =
Error 2
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:222: __sub-make] Error 2

(I actually did this on my laptop rather than my build machine, but the
compiles are still cross compiles - just from arm64 instead of
powerpc64le).
--=20
Cheers,
Stephen Rothwell

--Sig_/f75Tq2StyWukWIPMSopuQOo
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmMa2aIACgkQAVBC80lX
0GzZyAgAo3FzX3g13JpBsmoxeN5Sx6faELUMFkii0H+7GGrjlbrMs2bVLXy5+iuu
U9AYdu03IjG8LMtCPWwP5u3JPGQOXBhGGqPWaV3Af+fagCksJ9JC1qxiIDbuHfnx
MaxFh63rqcso13L/mHa3evNwcKXpW7qfjGmhfjbz6seC4oMrAsppZeH4ief7xs1B
CmRQ2GiQeg2EgnyF+RksHgjbyLKdyeMQoDtJn0QeNTQVVRy+g/rwNT/z+j5/Hhdi
bIUGaLLgIb84wNSRz8nt0tiNpTfjK0sObPx6NSBEDNOSbFupb6B4KjvkA/UjhKph
T6SZ+awaWZS+Kd/QRo1AImXEMDCFzA==
=s/bx
-----END PGP SIGNATURE-----

--Sig_/f75Tq2StyWukWIPMSopuQOo--
