Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63F507395C4
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 05:16:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbjFVDQR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 23:16:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjFVDQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 23:16:14 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 792681BCD;
        Wed, 21 Jun 2023 20:16:13 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QmlrV3Bvhz4x04;
        Thu, 22 Jun 2023 13:16:10 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1687403771;
        bh=4QeuJyJpgKxrumCndMNF5jV1ekgOSpVmwiEy6ir+L9E=;
        h=Date:From:To:Cc:Subject:From;
        b=n6oT5gEFqAzzNMFXU5Nyt70Ti849dZTQMBIw44SHAX/czW4z58UZ2bymX5XqfQmKc
         8xGuJgNxNWy78HXBm8XG1jLvLScfaZGHv7lErd6mqmQ8lQ/CulSCo+5LfvN0+YdtUz
         hWTiZyb0342G3tGsfGpTbwNSNZvgLbIedg3c/1l3T31ZITQPWhy/34M4NcwsTkNvfF
         sdD/+Wyf7IiEpLbgqNR5kxQoN0Rpyr0/WNxdT8dHqmU3htIqPSVUYq6iqKClh4JYVx
         G7bT91excTVynonbC1yajIJtZhWTDqMYfQ+PMg80xSJ1Hr3TZcUzi0+RgQvtIHRS93
         T16iw+282y5dA==
Date:   Thu, 22 Jun 2023 13:16:09 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Ryan Roberts <ryan.roberts@arm.com>
Subject: linux-next: manual merge of the tip tree with the mm-stable tree
Message-ID: <20230622131609.3fdf314d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/dPngXCYV1Had5_29rk5pHpH";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/dPngXCYV1Had5_29rk5pHpH
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the tip tree got a conflict in:

  mm/migrate.c

between commit:

  c33c794828f2 ("mm: ptep_get() conversion")

from the mm-stable tree and commit:

  23a219c1860b ("mm: Make pte_mkwrite() take a VMA")

from the tip tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc mm/migrate.c
index 6f4066425d47,8b46b722f1a4..000000000000
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@@ -220,8 -219,8 +220,8 @@@ static bool remove_migration_pte(struc
  		if (folio_test_dirty(folio) && is_migration_entry_dirty(entry))
  			pte =3D pte_mkdirty(pte);
  		if (is_writable_migration_entry(entry))
- 			pte =3D pte_mkwrite(pte);
+ 			pte =3D pte_mkwrite(pte, vma);
 -		else if (pte_swp_uffd_wp(*pvmw.pte))
 +		else if (pte_swp_uffd_wp(old_pte))
  			pte =3D pte_mkuffd_wp(pte);
 =20
  		if (folio_test_anon(folio) && !is_readable_migration_entry(entry))

--Sig_/dPngXCYV1Had5_29rk5pHpH
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmSTvPkACgkQAVBC80lX
0Gx9+Af+L6Kvxcj/+tF5s2Z4bVylxonNrdsWnz1wAfY1sGIR2iTQXswKrTAh3iiW
CEuqmgJuiDN7kjFboNBB+QaFrrjdCe9jcCXOCuuVB9UhX91LNgJ+fIMkNkT+YOtt
YrL/8l9kyzPFh2LGdG2N0We1auK7nkrvAPSOLQxApjD+gEcw72UsWYMMjujGdOg/
qjIKwekmskBzshBUpqooohHV/3u6W2Wwcw733QurWH7fhr/sAeeeZ1mppkf3bpw/
8lQtNHmxIrfW8AVCH0ZsiYai7EoTnxh27CLPBNCJ7U3WvkEWUqzgtkeizA6+sJ0S
7ukeYp7Ssphfha+ZcL2HULsRuZu3sA==
=Tq32
-----END PGP SIGNATURE-----

--Sig_/dPngXCYV1Had5_29rk5pHpH--
