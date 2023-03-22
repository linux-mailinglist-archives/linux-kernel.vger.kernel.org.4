Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D3B16C5AE6
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 00:59:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbjCVX7k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 19:59:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjCVX7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 19:59:38 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA5E119114;
        Wed, 22 Mar 2023 16:59:35 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Phlnf1wD5z4x80;
        Thu, 23 Mar 2023 10:59:34 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1679529574;
        bh=KIke8oEsNLt3y5zFOoJ6KgGQKeAub2/Zlsgqf1VHrR8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RBgodTKPmofTfkDjaWyfeThFYUD/UXjjeJVpVyCMJaJa83XY3NGI9sZYBY0PGF+OH
         r6Pg27ABBqPGiI7+9SpcrbH+qa1zAWTGrUaKwJG6FOBMbaGkVVn7IiBdGYJM4EamWb
         fKvBaN8f+9rG7gtVS2NV4JbC3IvTwjFUBaWILh288dTf7VFCQJX4QohJri3lUjgNhy
         MefqundI5e+5J5vn6aCC/oiVN98036uAFUMblZeUXFTUVZA2BF53SIx4bD4XJegk7v
         9+cimx9dX3uL0owDNYltuUteUXHIOE3Rg8lY+jmfBC320LYlXvnLMD5yS3g6a0nkk5
         eObEHhcOnZv3A==
Date:   Thu, 23 Mar 2023 10:59:33 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jens Axboe <axboe@kernel.dk>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Lorenzo Stoakes <lstoakes@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the block tree
Message-ID: <20230323105933.13a0297a@canb.auug.org.au>
In-Reply-To: <20230323103324.222dbdbc@canb.auug.org.au>
References: <20230323103324.222dbdbc@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ED1RWZz0zVB5Us_eWv2dxvL";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ED1RWZz0zVB5Us_eWv2dxvL
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Thu, 23 Mar 2023 10:33:24 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> After merging the block tree, today's linux-next build (powerpc
> ppc64_defconfig) failed like this:
>=20
> In file included from arch/powerpc/include/asm/cmpxchg.h:6,
>                  from arch/powerpc/include/asm/atomic.h:11,
>                  from include/linux/atomic.h:7,
>                  from include/crypto/hash.h:11,
>                  from lib/iov_iter.c:2:
> lib/iov_iter.c: In function 'copy_page_to_iter_atomic':
> lib/iov_iter.c:546:22: error: implicit declaration of function 'iov_iter_=
is_pipe'; did you mean 'iov_iter_is_bvec'? [-Werror=3Dimplicit-function-dec=
laration]
>   546 |         if (unlikely(iov_iter_is_pipe(i))) {
>       |                      ^~~~~~~~~~~~~~~~
> include/linux/compiler.h:78:45: note: in definition of macro 'unlikely'
>    78 | # define unlikely(x)    __builtin_expect(!!(x), 0)
>       |                                             ^
> lib/iov_iter.c:547:26: error: implicit declaration of function 'copy_page=
_to_iter_pipe'; did you mean 'copy_page_to_iter'? [-Werror=3Dimplicit-funct=
ion-declaration]
>   547 |                 copied =3D copy_page_to_iter_pipe(page, offset, b=
ytes, i);
>       |                          ^~~~~~~~~~~~~~~~~~~~~~
>       |                          copy_page_to_iter
>=20
> Caused by commit
>=20
>   a53f5dee3448 ("iov_iter: Kill ITER_PIPE")
>=20
> interacting with commit
>=20
>   c4cf24ce34b7 ("iov_iter: add copy_page_to_iter_atomic()")
>=20
> from the mm tree.
>=20
> I have reverted that mm tree commit (and the following two commits)
> for today.

Having now read the followup messages to the merge conflict report, I
have gone back and fixed it up as suggested (see my other reply).

--=20
Cheers,
Stephen Rothwell

--Sig_/ED1RWZz0zVB5Us_eWv2dxvL
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmQblmUACgkQAVBC80lX
0GwjSwgAkbGag85HRogYTAhTPX19tOyvN5E92zUVFi6ZGj8Lt6JT8WSoVDxAQWv+
xDCw3hQCvVUemDr37J95QGyx3Q29jsCVsoOqx7dwx1Yw0G+ItpaeQR4E0Majd5FP
2kW3JdncegJL0YV+Dbb+6R9UbmeakdXh8BDkn9GhIXGJMl8GJU6KGvQKcDzyUpwv
coMQkepmTT/AjSZU7R1LV2y0bt+B7eUpxDOwLLe4CELOL6RQjDV8sy9BSZue0BL6
meakPoFhcORd9UbrJk6ZhLgYjqaVZ67YbUUnIJuALAfhjV1B/jawL7xyX6psJ9Nn
/oiPNqdJwMFFXmVu/wf8ltf8rpoHDg==
=cQ+/
-----END PGP SIGNATURE-----

--Sig_/ED1RWZz0zVB5Us_eWv2dxvL--
