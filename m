Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3E1C693B5E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 01:33:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbjBMAdx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Feb 2023 19:33:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjBMAdv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 19:33:51 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD3A0F745;
        Sun, 12 Feb 2023 16:33:39 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PFQLT5X9Kz4x81;
        Mon, 13 Feb 2023 11:33:37 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1676248418;
        bh=M45M70mLI0IbHL2Z9TjHIaAPXGjHd6MSyzTuOfO8lk0=;
        h=Date:From:To:Cc:Subject:From;
        b=OHSm6VG0Z4y4ZlWioEyQ7dz4c1G+DQHA0JroNzmqHr/bFr9dgkPA3qDjzbwQMiUHH
         s6beMAVQwMfRbIWVj+3d1jb9oOmFajXIIyfKZgDChlTSQ8Dhqt3qrstnlJVgRLdFZe
         PcRg7WHVX9BCkzokv1/UZBo4gFLZ1ZkoueK7cey1X2QDcMcusWiTqNrsk2areWiJuy
         3XxQrHoHfXMGKg6YtDdnQ4536rFnxr5FENBU32tzX8YwWaVVW03lcSIB4Z/c3oWfKH
         gkD163j74VXdKGezJt3Gs6aqeqHCAEJ7et2r3Q8f+H71R65YGOWKzn4Mex0NoBeiKD
         R5H13O3O2nu8A==
Date:   Mon, 13 Feb 2023 11:33:36 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jens Axboe <axboe@kernel.dk>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     David Howells <dhowells@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Qian Yingjin <qian@ddn.com>
Subject: linux-next: manual merge of the block tree with the mm-hotfixes
 tree
Message-ID: <20230213113336.7867ec39@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/BlFzpBK2_o2ZQx00MSjfy0S";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/BlFzpBK2_o2ZQx00MSjfy0S
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the block tree got a conflict in:

  mm/filemap.c

between commit:

  cfecbdbbbd86 ("mm/filemap: fix page end in filemap_get_read_batch")

from the mm-hotfixes tree and commit:

  cd119d2fa647 ("mm: Pass info, not iter, into filemap_get_pages() and unst=
atic it")

from the block tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc mm/filemap.c
index 0e20a8d6dd93,6970be64a3e0..000000000000
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@@ -2588,8 -2591,7 +2591,8 @@@ int filemap_get_pages(struct kiocb *ioc
  	struct folio *folio;
  	int err =3D 0;
 =20
 +	/* "last_index" is the index of the page beyond the end of the read */
- 	last_index =3D DIV_ROUND_UP(iocb->ki_pos + iter->count, PAGE_SIZE);
+ 	last_index =3D DIV_ROUND_UP(iocb->ki_pos + count, PAGE_SIZE);
  retry:
  	if (fatal_signal_pending(current))
  		return -EINTR;

--Sig_/BlFzpBK2_o2ZQx00MSjfy0S
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPphWAACgkQAVBC80lX
0GzGrQf/cSAWIGtRBqznq/wzb2MI/QlqN+lpC/l2Gc+NHXKa8+48noPwy779LQ/Q
teGsFq9ZseW20SY0UTpHD06caez1S2Al/ejPnuCNPaD3S0oekk2NFubyfWsCElMq
0aog0CugZDRLdOF/THmeOHGABHjj6rUXkjbmcHPo5v0Pm7D5y9NysBX8aHRkXukr
Y7KiNgWzsyiYyxOWHpgI2Ycy23BG0HHPu76+i7Awleucg1z0Xa8cyaQw4KG7w2Wx
GMIrKTumuay49rp88T3xcFfwV1ZgyRjtkruVdfKtd/P3kx50Byd574fM7lc6c7nm
GbLTK/DpqaUcC8kMSgkDIRTj2ikqPg==
=mNzI
-----END PGP SIGNATURE-----

--Sig_/BlFzpBK2_o2ZQx00MSjfy0S--
