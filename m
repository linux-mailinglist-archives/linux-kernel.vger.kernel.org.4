Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7881A74E2D7
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 02:55:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230388AbjGKAzx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 20:55:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbjGKAzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 20:55:51 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AEB9A0;
        Mon, 10 Jul 2023 17:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1689036943;
        bh=H2odAZEC3iFOjj/wHrtG44sMYC7pyrZZzT+lRFSPmvI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=UAC9KLdbqMsjVhik77jNP5q+dyfue9EdJJS7U/mdqUtCI8xPFK6YR8MuhtP+k0zEV
         xIiT+to2xYFDfMdZiBtBGd4UZ66IYpm6q0mQtwEOW5wfg+UyCPm+oNIWH4G5dgwII6
         2+RQcPvOy7qDaFg6n6PF2ajCnYmLNZqtYEs62l8IXQkOIz6UCCoX4ENiiglPRhpHYI
         HKjyflBLP5IW/Kd8QpkZORNzNZPflx0CWlkIA+utfWFN0OougwPlxGKmQxu0573tDp
         umY9cGg/TCcZ7Rjl1Y7lQJPUwE59bJEIrpgp163lU4d4NsioY9Kk+jYeA5OU7EmAW6
         PlLOfURL+EnEw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4R0Mqc6DVvz4wxN;
        Tue, 11 Jul 2023 10:55:40 +1000 (AEST)
Date:   Tue, 11 Jul 2023 10:55:38 +1000
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
Subject: Re: linux-next: manual merge of the tip tree with the mm-stable
 tree
Message-ID: <20230711105538.2e941593@canb.auug.org.au>
In-Reply-To: <20230622131609.3fdf314d@canb.auug.org.au>
References: <20230622131609.3fdf314d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/bBa/Hh7hroM.Z8bJmHCgiEF";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/bBa/Hh7hroM.Z8bJmHCgiEF
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Thu, 22 Jun 2023 13:16:09 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> Today's linux-next merge of the tip tree got a conflict in:
>=20
>   mm/migrate.c
>=20
> between commit:
>=20
>   c33c794828f2 ("mm: ptep_get() conversion")
>=20
> from the mm-stable tree and commit:
>=20
>   23a219c1860b ("mm: Make pte_mkwrite() take a VMA")
>=20
> from the tip tree.
>=20
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>=20
> diff --cc mm/migrate.c
> index 6f4066425d47,8b46b722f1a4..000000000000
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@@ -220,8 -219,8 +220,8 @@@ static bool remove_migration_pte(struc
>   		if (folio_test_dirty(folio) && is_migration_entry_dirty(entry))
>   			pte =3D pte_mkdirty(pte);
>   		if (is_writable_migration_entry(entry))
> - 			pte =3D pte_mkwrite(pte);
> + 			pte =3D pte_mkwrite(pte, vma);
>  -		else if (pte_swp_uffd_wp(*pvmw.pte))
>  +		else if (pte_swp_uffd_wp(old_pte))
>   			pte =3D pte_mkuffd_wp(pte);
>  =20
>   		if (folio_test_anon(folio) && !is_readable_migration_entry(entry))

This is now a conflict between the tip tree and Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/bBa/Hh7hroM.Z8bJmHCgiEF
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmSsqIoACgkQAVBC80lX
0GzPZgf8CUpuNV/f7OrZlANxJmbZARnQ0fyoVgNxVARKNEu6zH+huXt4fuhcZKft
rsGI/wMExltAt/ldr++EDzVJ76H7FD0bjft2uFCJfVQRSpV2RD1lnaESpPjJrECh
91UffgfQWbF4ZimHWGxqFCBwAggjLrb/720655G3JDsNDWPo0KQVrJDS5vyEBjnh
uFlSXrFudSgkG9rG3qWw1+VIcXcEhthdM8ykb3PIkXE8Ck+kjfCyNj2hth3J9jOK
EjLEp9eWhOkcfRWhUPm6DGdu2PPkD+lZH3GR9ZLGBibltijABdhZnFL8V4Z4cW7r
OZj6b6SNcvRd7A9tSGQFmr6+om5Ckw==
=ePuI
-----END PGP SIGNATURE-----

--Sig_/bBa/Hh7hroM.Z8bJmHCgiEF--
