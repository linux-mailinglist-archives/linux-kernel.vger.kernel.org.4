Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B7CA69C391
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 01:21:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbjBTAV2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Feb 2023 19:21:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjBTAV0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Feb 2023 19:21:26 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 809E2CA16;
        Sun, 19 Feb 2023 16:21:24 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PKjl30Ccwz4x7j;
        Mon, 20 Feb 2023 11:21:18 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1676852479;
        bh=4BSWAvtFmwccJIo2hDiied+AI6qXBhtcj1JRzK343dc=;
        h=Date:From:To:Cc:Subject:From;
        b=E5VI9cML6QjGzK+n+lPoL2CyLFVJP+yui3nXm0cRSTf5N1mGDLJzDLOlXbTZhrNZu
         q6KrafkwUhCS1zle0ThsaMoJBBjXaLvjQsmu3cFmwk5A19GinkhBEypiZKDRgI3Xf3
         ZtGX/MNBMWh1+1vouL5GDyX/TPWat2nEh5b7d/H5dPHZqAhVqY4Ues+w22pse8DG9c
         xChJIeBWiTJsiJyTWqpqn7aPIHqIDz43h0WaNakdu3m7rKlNNFmt6HdoI+nckpw+zX
         gfg5Kyn09g/NMZS99d6bXzSMCKLIh1aCICIl4mpvgbcaSr9oiQ4g2buQyRTmpWYfbK
         thmNYVyLxdTNQ==
Date:   Mon, 20 Feb 2023 11:21:17 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jens Axboe <axboe@kernel.dk>, Steve French <smfrench@gmail.com>
Cc:     CIFS <linux-cifs@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Steve French <stfrench@microsoft.com>
Subject: linux-next: manual merge of the block tree with the cifs tree
Message-ID: <20230220112117.1146e711@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/fO4sQ6X/dB6yXdprS68.=fS";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/fO4sQ6X/dB6yXdprS68.=fS
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the block tree got a conflict in:

  mm/filemap.c

between commit:

  03aaa67b45e7 ("splice: Add a func to do a splice from a buffered file wit=
hout ITER_PIPE")

from the cifs tree and commit:

  a53cad008099 ("splice: Add a func to do a splice from a buffered file wit=
hout ITER_PIPE")

from the block tree.

These are slightly different versions of the same patch :-( (with the same
author date).  the difference amounts to this in filemap_splice_read():

-			n =3D splice_folio_into_pipe(pipe, folio, *ppos, len);
+			n =3D min_t(loff_t, len, isize - *ppos);
+			n =3D splice_folio_into_pipe(pipe, folio, *ppos, n);

I fixed it up (I used the former version (that has the min_t check)) and
can carry the fix as necessary. This is now fixed as far as linux-next
is concerned, but any non trivial conflicts should be mentioned to your
upstream maintainer when your tree is submitted for merging.  You may
also want to consider cooperating with the maintainer of the conflicting
tree to minimise any particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/fO4sQ6X/dB6yXdprS68.=fS
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPyvP0ACgkQAVBC80lX
0GydiAf+K86uMYMOLF3tGcGUbSDPuKh7Go6VxsGrZvZlKcmKo93tKCMPSRarbNTs
ongr670hX2i+ot9bzahi2z4M3NvP8m9hnCdtHaMcNs1uYxLA1iXYo9tViI9vcGju
zcqJwwTwci/zLm74JDBbweoWRm6jthkw43VDNinVSau6YGMKdpntYmkYZJbG28pw
H3PH9b1JCnVdcrEVW9ojWqgT12glrkjtHKRJxjqlgJgfWCmCI1P52jpEaxRzVs5u
6Sv3I7yCca7ZpfT7LZWN6uLlDtymMPEjTJ0AqXdj/Q8dMN+LiwYBql226ERDvc9J
t2CrQJn8IkV0tjHresbZ8OzCjJh4KA==
=xC3y
-----END PGP SIGNATURE-----

--Sig_/fO4sQ6X/dB6yXdprS68.=fS--
