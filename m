Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D2B25F4FD7
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 08:39:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbiJEGjU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 02:39:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiJEGjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 02:39:17 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8AF2606AD;
        Tue,  4 Oct 2022 23:39:14 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Mj4fj32tCz4x1R;
        Wed,  5 Oct 2022 17:39:09 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1664951950;
        bh=UrEsygdFipco2BHqGzf2XhG4aPMLc7N3pT9vVU3rPes=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GVyLF01LsA+9BoT/62ukIKyCbFN3keDIDiTUWQvMKQ61Y0ZgzhzCUzggm1hvWDUFd
         2hx3exu180aTKU3H3BSiIr2K8oSiqwj25b55gsAFFxZb3V8+nP4e7wkXQguQVJVyjO
         m6CSIPP3SOBwyfX+TDVHDAn5a75xzmZ2PZytjuWLOk8Qf1R/kMJG1KOlX7t8PZKib5
         qlqUzhvwKoMfT322YAchmpSVQqUaPWu+iNtR5MeX3YSIUxMocab94jh+8vlOaKZbZX
         78dAb+Ay+obLKyMWmH/0iVF9cH5S67lly2I6uU/AEDM98Y5s4B5D/ZI6S96LYpj8Dn
         coq+T4dD4VpIg==
Date:   Wed, 5 Oct 2022 17:39:04 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Alexander Potapenko <glider@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the mm-stable tree with the kspp
 tree
Message-ID: <20221005173904.12540ffe@canb.auug.org.au>
In-Reply-To: <20221004204025.7be8a3be@canb.auug.org.au>
References: <20221004204025.7be8a3be@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/4y4jTsp8=i3rlvQ4LDEz0E5";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/4y4jTsp8=i3rlvQ4LDEz0E5
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Tue, 4 Oct 2022 20:40:25 +1100 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>=20
> Today's linux-next merge of the mm-stable tree got a conflict in:
>=20
>   include/linux/fortify-string.h
>=20
> between commit:
>=20
>   9f7d69c5cd23 ("fortify: Convert to struct vs member helpers")
>=20
> from the kspp tree and commit:
>=20
>   ff901d80fff6 ("x86: kmsan: use __msan_ string functions where possible.=
")
>=20
> from the mm-stable tree.
>=20
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>=20
>=20
> diff --cc include/linux/fortify-string.h
> index b62c90cfafaf,6c8a1a29d0b6..000000000000
> --- a/include/linux/fortify-string.h
> +++ b/include/linux/fortify-string.h
> @@@ -325,11 -282,13 +325,13 @@@ __FORTIFY_INLINE void fortify_memset_ch
>   })
>  =20
>   /*
>  - * __builtin_object_size() must be captured here to avoid evaluating ar=
gument
>  - * side-effects further into the macro layers.
>  + * __struct_size() vs __member_size() must be captured here to avoid
>  + * evaluating argument side-effects further into the macro layers.
>    */
> + #ifndef CONFIG_KMSAN
>   #define memset(p, c, s) __fortify_memset_chk(p, c, s,			\
>  -		__builtin_object_size(p, 0), __builtin_object_size(p, 1))
>  +		__struct_size(p), __member_size(p))
> + #endif
>  =20
>   /*
>    * To make sure the compiler can enforce protection against buffer over=
flows,

This is now a conflict between the mm-stable tree and Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/4y4jTsp8=i3rlvQ4LDEz0E5
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmM9JogACgkQAVBC80lX
0GwIZggApjYw82dVFfmTq72uxz8Uh2M/14G4pOF3PhfTWl1KdABDnsEY5sQVI9Y2
6Qw2VS6DvCOtKw7s2N2NKsDhcI1EjoujdpYvBv9mLljOi0JZbckepvSfi0AsjV5H
XTPXbAFm/Q1A1If9+H/Uk68r4XIusJDSzPkuvOoBXig21Hw/Wf9aqAO8/IkYIFda
y/sC4h+XT6yUSCKKqunL3X9xNepzg8lDJx8MCNwZ4Lftf7KAHZ1g4Pjn5ih+cmdS
QfLnt2lLGvP4KyKzdsDbyDnO1HVuB2IxyBJCw7K7zJoppj5KIdNcCOeShaJ7AZDC
292SrElD/rcpgDlRL9tJNU0QV+h5QA==
=JZVb
-----END PGP SIGNATURE-----

--Sig_/4y4jTsp8=i3rlvQ4LDEz0E5--
