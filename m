Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2868642006
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Dec 2022 23:24:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230387AbiLDWY2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Dec 2022 17:24:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiLDWY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Dec 2022 17:24:26 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C8A6C766;
        Sun,  4 Dec 2022 14:24:23 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NQLnZ0kJFz4wgr;
        Mon,  5 Dec 2022 09:24:17 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1670192658;
        bh=jzCkICO8z4Bxn4RikYwMGFg8/kv+GAaohmxh9yTXXas=;
        h=Date:From:To:Cc:Subject:From;
        b=hFv1vGvW6MbQQKj5jFGd7sF6Rw3JNjw+AI1+eFtW4IPjODpfQg2fCtPO5ODzJ7odf
         xvmBU6uRMsSjhsq4NHaO7rWsion1LDjjh4qLwIXDGxw9MrZzhfB2mZkJGqglqznJEE
         eQlCKaLvz63K+ULnyn4pLkPjBKnWZbYmZduQAiqBzETE4guuUxkYkzUu/xmtjW8gWx
         40LbS2WtY3r//9IDV8l64rLEQgWBtVveZ0v4GFQwypQ+hZ1P2K2L5haTLJrA96ZCeX
         2p8Gwi7lu24imetfdHyLqVq/C02tnT1/OcHSkJOPVZhLE2heU7sW166XFfhQAFlN7J
         mO8L8bFJPuhwA==
Date:   Mon, 5 Dec 2022 09:24:15 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Al Viro <viro@ZenIV.linux.org.uk>, Gao Xiang <xiang@kernel.org>
Cc:     Gao Xiang <hsiangkao@linux.alibaba.com>,
        Jingbo Xu <jefflexu@linux.alibaba.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the vfs tree with the erofs tree
Message-ID: <20221205092415.56cc6e19@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/g.g95rLd+aEp7LGactM_8Yf";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/g.g95rLd+aEp7LGactM_8Yf
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the vfs tree got a conflict in:

  fs/erofs/fscache.c

between commits:

  89175ef1262d ("erofs: switch to prepare_ondemand_read() in fscache mode")
  89175ef1262d ("erofs: switch to prepare_ondemand_read() in fscache mode")

from the erofs tree and commit:

  89175ef1262d ("erofs: switch to prepare_ondemand_read() in fscache mode")

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
index f14886c479bd,4c837be3b6e3..000000000000
--- a/fs/erofs/fscache.c
+++ b/fs/erofs/fscache.c
@@@ -126,28 -159,47 +126,28 @@@ static int erofs_fscache_read_folios_as
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
@@@ -233,19 -297,17 +233,19 @@@ static int erofs_fscache_data_read_slic
  		}
  		iov_iter_zero(PAGE_SIZE - size, &iter);
  		erofs_put_metabuf(&buf);
 -		return PAGE_SIZE;
 +		primary->submitted +=3D PAGE_SIZE;
 +		return 0;
  	}
 =20
 +	count =3D primary->len - primary->submitted;
  	if (!(map.m_flags & EROFS_MAP_MAPPED)) {
- 		iov_iter_xarray(&iter, READ, &mapping->i_pages, pos, count);
 -		count =3D len;
+ 		iov_iter_xarray(&iter, ITER_DEST, &mapping->i_pages, pos, count);
  		iov_iter_zero(count, &iter);
 -		return count;
 +		primary->submitted +=3D count;
 +		return 0;
  	}
 =20
 -	count =3D min_t(size_t, map.m_llen - (pos - map.m_la), len);
 +	count =3D min_t(size_t, map.m_llen - (pos - map.m_la), count);
  	DBG_BUGON(!count || count % PAGE_SIZE);
 =20
  	mdev =3D (struct erofs_map_dev) {

--Sig_/g.g95rLd+aEp7LGactM_8Yf
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmONHg8ACgkQAVBC80lX
0GwUEwgAnFSYP2Et4YcN+0kK6vadLkzl0zpYBVtfLY2GEfrfvxZlVnI7zLH1BkYt
/VPCeeCmC2gA34LlhHVrZwwaeNWCG9ApLsh+TeenNhATtCLguSh47jj4cU99PZA/
23BD1a13ihkRp/sYbMurqzBHS1Y7GgQXkofaPAMIIVcB1qKVFQ4sG7hXISB8XjDl
txHyteaQGpR3HuMaSIoJz8UFknSgPGfYhLGkU9HjVmp1bOjmiQxCtmO3myx9whvE
MEAxCiOdTSUitSU6dkwt0leF6aMGaQKX9NR24d6AAJcghC6xRB0ZqvQuHkuJYPnK
g92mpgQOyVAYtnW/He48cE7nbzhRrw==
=deRc
-----END PGP SIGNATURE-----

--Sig_/g.g95rLd+aEp7LGactM_8Yf--
