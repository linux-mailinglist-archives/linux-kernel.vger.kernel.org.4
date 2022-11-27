Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB38C639D89
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Nov 2022 23:13:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbiK0WNc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 17:13:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbiK0WNa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 17:13:30 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2F30F001;
        Sun, 27 Nov 2022 14:13:28 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NL2tG66KGz4x7X;
        Mon, 28 Nov 2022 09:13:25 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1669587207;
        bh=OA8cwrc4AeSC9IBQ9abRGC2/KKssQi4afT8E9LGyKVk=;
        h=Date:From:To:Cc:Subject:From;
        b=cguNTcg8P3fCYHCZLFPddlZ097kZ8OdMn3F2dPr5la/i53ksyND3qddeSvosbhq1q
         aBvVGs/AQzTzQm17gruINIaMRIksABsDIfvmR3k2sxX9ohZtXkCWkoq1SQDN6fBx3h
         I+ox5h8I7WvpOXh9voiOnvIleGeeCt9eM89qqReTbb6SrIfev+aaxnR3Hg/767YruF
         +tIGh9nYviqLvliR0qg49qNcqDuAvjXChMTQ0wMLzUMgI9MSPPmNTXIX2AGMAR5rYq
         GpnoPzxi2qtqY56h+wLezDJxt4HG09kYjxI2CPQ+XXc8xi0/VY1CjJGMgN7/LcQmtY
         3RCFPmzS3LEKQ==
Date:   Mon, 28 Nov 2022 09:13:23 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Al Viro <viro@ZenIV.linux.org.uk>, Gao Xiang <xiang@kernel.org>
Cc:     Gao Xiang <hsiangkao@linux.alibaba.com>,
        Jingbo Xu <jefflexu@linux.alibaba.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the vfs tree with the erofs tree
Message-ID: <20221128091323.246f8ce1@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/RFFSCt_qwUFuccD.ZiwmMWl";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/RFFSCt_qwUFuccD.ZiwmMWl
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the vfs tree got a conflict in:

  fs/erofs/fscache.c

between commit:

  313e9413d512 ("erofs: switch to prepare_ondemand_read() in fscache mode")

from the erofs tree and commit:

  de4eda9de2d9 ("use less confusing names for iov_iter direction initialize=
rs")

from the vfs tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc fs/erofs/fscache.c
index 3e794891cd91,4c837be3b6e3..000000000000
--- a/fs/erofs/fscache.c
+++ b/fs/erofs/fscache.c
@@@ -99,28 -159,47 +99,28 @@@ static int erofs_fscache_read_folios_as
 =20
  	ret =3D fscache_begin_read_operation(cres, cookie);
  	if (ret)
 -		goto out;
 +		return ret;
 =20
  	while (done < len) {
 -		subreq =3D kzalloc(sizeof(struct netfs_io_subrequest),
 -				 GFP_KERNEL);
 -		if (subreq) {
 -			INIT_LIST_HEAD(&subreq->rreq_link);
 -			refcount_set(&subreq->ref, 2);
 -			subreq->rreq =3D rreq;
 -			refcount_inc(&rreq->ref);
 -		} else {
 -			ret =3D -ENOMEM;
 -			goto out;
 -		}
 -
 -		subreq->start =3D pstart + done;
 -		subreq->len	=3D  len - done;
 -		subreq->flags =3D 1 << NETFS_SREQ_ONDEMAND;
 +		loff_t sstart =3D pstart + done;
 +		size_t slen =3D len - done;
 +		unsigned long flags =3D 1 << NETFS_SREQ_ONDEMAND;
 =20
 -		list_add_tail(&subreq->rreq_link, &rreq->subrequests);
 -
 -		source =3D cres->ops->prepare_read(subreq, LLONG_MAX);
 -		if (WARN_ON(subreq->len =3D=3D 0))
 +		source =3D cres->ops->prepare_ondemand_read(cres,
 +				sstart, &slen, LLONG_MAX, &flags, 0);
 +		if (WARN_ON(slen =3D=3D 0))
  			source =3D NETFS_INVALID_READ;
  		if (source !=3D NETFS_READ_FROM_CACHE) {
 -			erofs_err(sb, "failed to fscache prepare_read (source %d)",
 -				  source);
 -			ret =3D -EIO;
 -			subreq->error =3D ret;
 -			erofs_fscache_put_subrequest(subreq);
 -			goto out;
 +			erofs_err(sb, "failed to fscache prepare_read (source %d)", source);
 +			return -EIO;
  		}
 =20
 -		atomic_inc(&rreq->nr_outstanding);
 +		refcount_inc(&req->ref);
- 		iov_iter_xarray(&iter, READ, &req->mapping->i_pages,
++		iov_iter_xarray(&iter, ITER_DEST, &req->mapping->i_pages,
 +				lstart + done, slen);
 =20
 -		iov_iter_xarray(&iter, ITER_DEST, &rreq->mapping->i_pages,
 -				start + done, subreq->len);
 -
 -		ret =3D fscache_read(cres, subreq->start, &iter,
 -				   NETFS_READ_HOLE_FAIL,
 -				   erofc_fscache_subreq_complete, subreq);
 +		ret =3D fscache_read(cres, sstart, &iter, NETFS_READ_HOLE_FAIL,
 +				   erofs_fscache_subreq_complete, req);
  		if (ret =3D=3D -EIOCBQUEUED)
  			ret =3D 0;
  		if (ret) {

--Sig_/RFFSCt_qwUFuccD.ZiwmMWl
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmOD4QQACgkQAVBC80lX
0Gwatgf+NTudyrRvgpuCiIqk0Hhf1gBTbF6Cf2ruPW19LohMNaT7vfQH6N9LdGxj
/czXh4IW+o+2k/LO6XP22XJX/OoaWgTpHaXJtYfGp1r1EdaTUgAcyEdSDVzuiy7G
pEMJwNlLgmobWhl9EXiBVzHmUDbHogxyPhsLt/DzAiiRJfeZFjqkrsnLvtAgx0nW
OqrkDLzSjuBcuUJpnrv0k7lpgIG1z7UfqtvG/uUdASSCmWP49M4c+sn9tJuBnEaV
d78xzj7caPCasW+zU9jHte525p4YTGFM1OrxlQFNMbfdG4DjvVONfoW93NBgkeUB
a78cYxPqnamL1KRwapCfoO/WzJ7W6Q==
=ZWer
-----END PGP SIGNATURE-----

--Sig_/RFFSCt_qwUFuccD.ZiwmMWl--
