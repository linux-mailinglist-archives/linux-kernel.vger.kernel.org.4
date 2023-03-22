Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDFF66C5A74
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 00:33:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbjCVXdh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 19:33:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjCVXde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 19:33:34 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C845B20A03;
        Wed, 22 Mar 2023 16:33:26 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PhlCT1w7jz4x4r;
        Thu, 23 Mar 2023 10:33:25 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1679528005;
        bh=9f11EWXC83jy/U6MAOs+3NlbCygEy0ALYbtabQn2CFM=;
        h=Date:From:To:Cc:Subject:From;
        b=G9fq5a+tJHyNOISPewt9aVQfukJEzFSEabgWs8owJdGsBMhTieZ1jpfStmC/8msfK
         Cp9MhA+bKv/Kj+7JnhcRA3HMKkmPl+wNEoyamdHfTFgda1yRR03SUIllkBZeRS0wwn
         HoS4hXPH6deUm8iOqTFoocowO+aTir/fUs2Ws5qmlnMBrl8UQzJm2woWLIH8gNzJC0
         No3mUkECgCtmEV7QYvg13Gf5cQWwwjtSKUrlad9dtZx3mkGUXCuPcZWBonpsl0CyJm
         O/3yjrP209mtKWi4MuwOu5j+v7533wpy9tOEjBRmUTDThlfaDSQ1yRXwIKBDVaV41o
         tu+xwFAg+mtXw==
Date:   Thu, 23 Mar 2023 10:33:24 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jens Axboe <axboe@kernel.dk>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Lorenzo Stoakes <lstoakes@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the block tree
Message-ID: <20230323103324.222dbdbc@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/kLeb+iJqftKXW_gE/e58pRH";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/kLeb+iJqftKXW_gE/e58pRH
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the block tree, today's linux-next build (powerpc
ppc64_defconfig) failed like this:

In file included from arch/powerpc/include/asm/cmpxchg.h:6,
                 from arch/powerpc/include/asm/atomic.h:11,
                 from include/linux/atomic.h:7,
                 from include/crypto/hash.h:11,
                 from lib/iov_iter.c:2:
lib/iov_iter.c: In function 'copy_page_to_iter_atomic':
lib/iov_iter.c:546:22: error: implicit declaration of function 'iov_iter_is=
_pipe'; did you mean 'iov_iter_is_bvec'? [-Werror=3Dimplicit-function-decla=
ration]
  546 |         if (unlikely(iov_iter_is_pipe(i))) {
      |                      ^~~~~~~~~~~~~~~~
include/linux/compiler.h:78:45: note: in definition of macro 'unlikely'
   78 | # define unlikely(x)    __builtin_expect(!!(x), 0)
      |                                             ^
lib/iov_iter.c:547:26: error: implicit declaration of function 'copy_page_t=
o_iter_pipe'; did you mean 'copy_page_to_iter'? [-Werror=3Dimplicit-functio=
n-declaration]
  547 |                 copied =3D copy_page_to_iter_pipe(page, offset, byt=
es, i);
      |                          ^~~~~~~~~~~~~~~~~~~~~~
      |                          copy_page_to_iter

Caused by commit

  a53f5dee3448 ("iov_iter: Kill ITER_PIPE")

interacting with commit

  c4cf24ce34b7 ("iov_iter: add copy_page_to_iter_atomic()")

from the mm tree.

I have reverted that mm tree commit (and the following two commits)
for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/kLeb+iJqftKXW_gE/e58pRH
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmQbkEQACgkQAVBC80lX
0GwAeAgAkiiRafmFwNG31P6QLwkfj0bRW4Sn+6OpwzyUEdtxLy7ffcI1aYK/ZETE
5ZcQFo1kZS+SgUGBhMdnX50VJdAwYaStLS2euUTzg7Xr9GccHpE+/iSIehB2K1xR
2s+Cvo097pH1BstYWFpNLTX9LgMTNfG9Ohpusg3Y9NUUGzG290QvwiF3weDhndGE
4rAJUeGy2xTHRikL1jpITy3Vte6nqrI0SjcAgTbFTWipubZ6raRBhPj/orQkJF7+
v3OugTU338DQHtvp1GiV+bDJCdKdIL4Vn3RyKfqdzDF7AV6f144cWXAaOcD5LYrc
6mXYONYTtVa5ZFM22FxhVXlx9C74Yg==
=mmPH
-----END PGP SIGNATURE-----

--Sig_/kLeb+iJqftKXW_gE/e58pRH--
