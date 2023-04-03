Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CD5E6D3BD8
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 04:36:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbjDCCgQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Apr 2023 22:36:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjDCCgO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Apr 2023 22:36:14 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8C39AF32;
        Sun,  2 Apr 2023 19:36:13 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PqZlJ0ZLQz4x91;
        Mon,  3 Apr 2023 12:36:12 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1680489372;
        bh=tyIbJors8/I/IcYyDef7AvvZsNU4h0fCbRiFxDr/c9U=;
        h=Date:From:To:Cc:Subject:From;
        b=EGwLh3RcEv+UBI8aPcbSbWsNWDozHv/SO5yF/lESRrgUvbikUWH28+JSg+FdnZuM1
         1uHPeD7R87ZA2D8zZzMv929ZznaNrtSIMHOCi/SoG3oe3vPSX3WgB8BsH1sWpk8m/k
         6ctm6mp9bFf+qBfEYYtNwE/FopY9X/fqNJvUN8hB7Ef+OfHl2fRmWiKbJKYpAZUVxr
         Xx9ghsh0Iz9edrtWZHOq3DiRUwV5NHRenJi+8gN45K5ySvdWoqvOi4OJ+WgmvL4XJm
         WW8czgDTPHI6THRP9V6WGNV+kN6f8mUTvusFgvXRAoZerspr+xfpph9MfbhxCcUjHU
         nUHDGqUP9uSqQ==
Date:   Mon, 3 Apr 2023 12:36:11 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Breno Leitao <leitao@debian.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Pavel Begunkov <asml.silence@gmail.com>
Subject: linux-next: manual merge of the block tree with Linus' tree
Message-ID: <20230403123611.6e448a26@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ycKp6JUz5eyclORc1Jjgqk5";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ycKp6JUz5eyclORc1Jjgqk5
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the block tree got a conflict in:

  io_uring/alloc_cache.h

between commit:

  fd30d1cdcc4f ("io_uring: fix poll/netmsg alloc caches")

from Linus' tree and commits:

  66eb95a0cf1c ("io_uring: Move from hlist to io_wq_work_node")
  16afed16c7a6 ("io_uring: Add KASAN support for alloc_caches")

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

diff --cc io_uring/alloc_cache.h
index c2cde88aeed5,3aba7b356320..000000000000
--- a/io_uring/alloc_cache.h
+++ b/io_uring/alloc_cache.h
@@@ -23,12 -25,13 +25,14 @@@ static inline bool io_alloc_cache_put(s
 =20
  static inline struct io_cache_entry *io_alloc_cache_get(struct io_alloc_c=
ache *cache)
  {
- 	if (!hlist_empty(&cache->list)) {
- 		struct hlist_node *node =3D cache->list.first;
+ 	if (cache->list.next) {
+ 		struct io_cache_entry *entry;
 =20
- 		hlist_del(node);
+ 		entry =3D container_of(cache->list.next, struct io_cache_entry, node);
+ 		kasan_unpoison_range(entry, cache->elem_size);
+ 		cache->list.next =3D cache->list.next->next;
 +		cache->nr_cached--;
- 		return container_of(node, struct io_cache_entry, node);
+ 		return entry;
  	}
 =20
  	return NULL;

--Sig_/ycKp6JUz5eyclORc1Jjgqk5
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmQqO5sACgkQAVBC80lX
0GymcAf7BBWYKTDBKqno6dvrJGiS6mRsI6M2S0mEyIZa6jRpFwe40ohbY9Bn3Lil
yWZYDJEVgiiDPAxLXFGf/WW89oYHIw7Uh/kuuLHOtqKjRegb3kuD/9s4jy+H6xFS
OqemdFFB557Fthv3q2VXfiKi8pMMwiYPRctLyW4oAaayYD6Ok9GMuRZViATHJlL9
qNIXU7yd/07s2/1hv1upRD9CS4fPYw+WZmV0y8NXw67nkeFNOusrcwwrIM38uIFX
B6Os5DIu9w4HEn6ccLlbZ6Fejw1PcFYTkNB4DVTJFCy8TduR+sGH/GyuTghpNS5F
FqX2M0+WD6LoE8cE2127vnaRJPeNqQ==
=80CD
-----END PGP SIGNATURE-----

--Sig_/ycKp6JUz5eyclORc1Jjgqk5--
