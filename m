Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF4EB6C59FB
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 00:02:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbjCVXCM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 19:02:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjCVXCJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 19:02:09 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AB7B6588;
        Wed, 22 Mar 2023 16:02:07 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PhkWK5Wy0z4wgv;
        Thu, 23 Mar 2023 10:02:05 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1679526126;
        bh=rsjvqVJpvHhn9wRdeV5pStst41E897IWLfvCHN97eSk=;
        h=Date:From:To:Cc:Subject:From;
        b=b/1l+aN6FdtzsGnJeU4vZ6zfMymHuKX1qf4TrxKM93Q1oH0DApKA9+8YbQlCYOcP8
         XUqBXrZhkanYla8b7fc8hw2YrwE6BQiZImi7723RXJU2SKTCgZplo2koP6LVFL9hqc
         CfxZxGcuGxXgFqsi2DEyZs88cXLhesPj8hdiqyuPPB5EvM48fIouujekuu+TwjadFc
         AYWiZ8IlRYLuySQmur8TpFcQ7aOjSzFV5y5NvzHV096sQfWb8c4I/PXPLtIzKI9J/F
         vCB00TtLdLu8X5hXAQoCyBAHqIYLhtk0xrtd+DhCeWMIRTl5iBVT3fX4gxV7q77N5s
         bBnFoVxRB0zrw==
Date:   Thu, 23 Mar 2023 10:02:04 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jens Axboe <axboe@kernel.dk>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     David Howells <dhowells@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>
Subject: linux-next: manual merge of the block tree with the mm tree
Message-ID: <20230323100204.0917cecf@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/F_Hox9gVbvq./rE=fe37W1n";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/F_Hox9gVbvq./rE=fe37W1n
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the block tree got a conflict in:

  lib/iov_iter.c

between commit:

  c4cf24ce34b7 ("iov_iter: add copy_page_to_iter_atomic()")

from the mm tree and commit:

  a53f5dee3448 ("iov_iter: Kill ITER_PIPE")

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

diff --cc lib/iov_iter.c
index 48ca1c5dfc04,fad95e4cf372..000000000000
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@@ -821,60 -532,6 +532,34 @@@ size_t copy_page_from_iter_atomic(struc
  }
  EXPORT_SYMBOL(copy_page_from_iter_atomic);
 =20
 +size_t copy_page_to_iter_atomic(struct page *page, unsigned offset, size_=
t bytes,
 +				struct iov_iter *i)
 +{
 +	char *kaddr =3D kmap_local_page(page);
 +	char *p =3D kaddr + offset;
 +	size_t copied =3D 0;
 +
 +	if (!page_copy_sane(page, offset, bytes) ||
 +	    WARN_ON_ONCE(i->data_source))
 +		goto out;
 +
 +	if (unlikely(iov_iter_is_pipe(i))) {
 +		copied =3D copy_page_to_iter_pipe(page, offset, bytes, i);
 +		goto out;
 +	}
 +
 +	iterate_and_advance(i, bytes, base, len, off,
 +		copyout(base, p + off, len),
 +		memcpy(base, p + off, len)
 +	)
 +	copied =3D bytes;
 +
 +out:
 +	kunmap_local(kaddr);
 +	return copied;
 +}
 +EXPORT_SYMBOL(copy_page_to_iter_atomic);
 +
- static void pipe_advance(struct iov_iter *i, size_t size)
- {
- 	struct pipe_inode_info *pipe =3D i->pipe;
- 	int off =3D i->last_offset;
-=20
- 	if (!off && !size) {
- 		pipe_discard_from(pipe, i->start_head); // discard everything
- 		return;
- 	}
- 	i->count -=3D size;
- 	while (1) {
- 		struct pipe_buffer *buf =3D pipe_buf(pipe, i->head);
- 		if (off) /* make it relative to the beginning of buffer */
- 			size +=3D abs(off) - buf->offset;
- 		if (size <=3D buf->len) {
- 			buf->len =3D size;
- 			i->last_offset =3D last_offset(buf);
- 			break;
- 		}
- 		size -=3D buf->len;
- 		i->head++;
- 		off =3D 0;
- 	}
- 	pipe_discard_from(pipe, i->head + 1); // discard everything past this one
- }
-=20
  static void iov_iter_bvec_advance(struct iov_iter *i, size_t size)
  {
  	const struct bio_vec *bvec, *end;

--Sig_/F_Hox9gVbvq./rE=fe37W1n
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmQbiOwACgkQAVBC80lX
0GyEnQf/adjSrEyVT5xgEmHcYmkA53kR4C6XwCEYlKz0LJsi9EDBenLoQD+UAywd
TMfEaC46VrVnxytjGdRFaCDOVmNRJ958dzBMhFQyJ8z3pmefRUHN7YEPTUoiLvsB
HAxklMthx7EdmurBJWxEDnhLyo0I+yhUWT5yTSyRqD6NbRxnCrF292OYF+EvxuVy
JbGfH2TPmi1gSkQsikDYPcdn9gbCIBVB0OPBOd0qXZSdKAc9FAzw/rB5Z2nxbuw5
2WlmHjhYd29wIh7hNnMr9PHDIycW7E76b/AXBPgeZVb2H+j+6R6RpJ2zw6WYdQgc
KVsD9ja8e4NzrHRv5R1zYbtFHr+2vA==
=O9gB
-----END PGP SIGNATURE-----

--Sig_/F_Hox9gVbvq./rE=fe37W1n--
