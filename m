Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99BA364D1DC
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 22:36:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbiLNVgO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 16:36:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiLNVgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 16:36:11 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B2AFE099;
        Wed, 14 Dec 2022 13:36:09 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NXTFL4TWHz4xN4;
        Thu, 15 Dec 2022 08:36:06 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1671053766;
        bh=oWX9mpT17ur8DOuIMsmVAj3LF7Xrb3G66buPkRIts6g=;
        h=Date:From:To:Cc:Subject:From;
        b=XxhZFerTuwoJSOPVskTHWstoGlXXDWtpamlomjI8VzzJ4I/IpY+sUIq9X6h1i1N3N
         XcG1YD5sSfEF5ARU/o0F0HK7Edmmn+CF0W4mRg1UhQdosWd9gZTo+0Qq6oqNfiHKKs
         78txaUt3igsqdnlzI3+XhzRHdL2b/13SfkjWXern7YYtGtulcGhiCQKijMRMndo9WN
         vbjXEaP6Jhxi1FzWes2iHMg06/RZ33Nm+t83nF5arPsGSV7a7r0X9/NQY61sMJzx/o
         gTehgJ1nUf2nTabPqTXNJIGhpkmOhqzx3Gys61xLxiVvdgTdQpsdneDH1zywB8QHXD
         BmGAhyaxXoR3g==
Date:   Thu, 15 Dec 2022 08:36:04 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Steven Whitehouse <swhiteho@redhat.com>,
        Bob Peterson <rpeterso@redhat.com>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        Dave Chinner <david@fromorbit.com>,
        Dave Chinner <dchinner@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the gfs2 tree with Linus' tree
Message-ID: <20221215083604.5a920366@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/OlyzdxKkZQrSlonkAmdxxpo";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/OlyzdxKkZQrSlonkAmdxxpo
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the gfs2 tree got a conflict in:

  include/linux/iomap.h

between commit:

  d7b64041164c ("iomap: write iomap validity checks")

from Linus' tree and commit:

  2057bcfa562b ("iomap: Move page_done callback under the folio lock")

from the gfs2 tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc include/linux/iomap.h
index 0983dfc9a203,bd6d80453726..000000000000
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@@ -137,24 -127,7 +137,24 @@@ static inline bool iomap_inline_data_va
  struct iomap_page_ops {
  	int (*page_prepare)(struct inode *inode, loff_t pos, unsigned len);
  	void (*page_done)(struct inode *inode, loff_t pos, unsigned copied,
- 			struct page *page);
+ 			struct folio *folio);
 +
 +	/*
 +	 * Check that the cached iomap still maps correctly to the filesystem's
 +	 * internal extent map. FS internal extent maps can change while iomap
 +	 * is iterating a cached iomap, so this hook allows iomap to detect that
 +	 * the iomap needs to be refreshed during a long running write
 +	 * operation.
 +	 *
 +	 * The filesystem can store internal state (e.g. a sequence number) in
 +	 * iomap->validity_cookie when the iomap is first mapped to be able to
 +	 * detect changes between mapping time and whenever .iomap_valid() is
 +	 * called.
 +	 *
 +	 * This is called with the folio over the specified file position held
 +	 * locked by the iomap code.
 +	 */
 +	bool (*iomap_valid)(struct inode *inode, const struct iomap *iomap);
  };
 =20
  /*

--Sig_/OlyzdxKkZQrSlonkAmdxxpo
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmOaQcQACgkQAVBC80lX
0Gxuvwf/ZHQnUbXgGATt/q76ZBDvsJLMm1ytfetRt/ELFDA04SBfVtBMkNIRtbXV
iyqIo2k4RJPzkJgKpmCPUxE8YF3iGoub7JDcCZ3ZKlkT3q+Ef4PvEhWlcfdtFYc+
doRcAsVxCrmne8J2nPcWlepvuSvenCOU+cnx5YnCqn6C+EB5utw6/H587y3+QDZt
ldOGzuixVnQf+lSYOWMNoLdAaMfZvCp/+SIOkw9igboafgfYXHZcsTkBS4iESe1c
4Bd5wt+4tucN9UDWVa8BZ0oHMRJlOcujJh0UrVjRaT0k5lhJnmIBjGNawOpF913B
gOCmWdSxZ+LKnZt6ELBtuOoBTMplhg==
=XwHo
-----END PGP SIGNATURE-----

--Sig_/OlyzdxKkZQrSlonkAmdxxpo--
