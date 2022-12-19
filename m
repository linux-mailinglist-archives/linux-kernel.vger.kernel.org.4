Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 768406516AA
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 00:14:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233010AbiLSXOB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 18:14:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232989AbiLSXNZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 18:13:25 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BEC81A384;
        Mon, 19 Dec 2022 15:06:06 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Nbb0g517Qz4x1G;
        Tue, 20 Dec 2022 10:05:55 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1671491156;
        bh=m1FNy0ef8Z6Ok4WPRB4WI1oYFT0cUkkBILg1vbkFQVI=;
        h=Date:From:To:Cc:Subject:From;
        b=ujpeG2YHKZSUg2BJbnkrT65xtAJeFw7EZtr6KMggdmbQSwcOCnHM/0K8nHh6BuO7f
         4xDG54toGM/eHVwRcUnppfJKoLj+eKU2S5DWSovG+QhQgoe+YPp0qUY6wjweB4BvcC
         RCxwDiT/4rJ7PhX+4Fa3Lw/epOSGA7mzjgpxDEjTsoJHdAb9vE70c3yErGQki4S0YU
         ihvkrgLxEz+QP939bgXlX9Fty0E0JlGNWCuVhHk2/6gC15n8gAdO+M2Vcz+KXfwLPC
         Gau7AEw2zMGzj+cU+8PvWRAU0Z8dYASc9Co6WhkIxWwMJ1xwFjoYwcXB1N/YMxR329
         MFt5ScxByQF4g==
Date:   Tue, 20 Dec 2022 10:05:53 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Bobby Eshleman <bobby.eshleman@bytedance.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the vhost tree with Linus' tree
Message-ID: <20221220100553.56279b42@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/vNGSavCtqEiQo9JsuTjYFFf";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/vNGSavCtqEiQo9JsuTjYFFf
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the vhost tree got a conflict in:

  drivers/vhost/vsock.c

between commit:

  de4eda9de2d9 ("use less confusing names for iov_iter direction initialize=
rs")

from Linus' tree and commit:

  101cf89e8d08 ("virtio/vsock: replace virtio_vsock_pkt with sk_buff")

from the vhost tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/vhost/vsock.c
index cd6f7776013a,830bc823addc..000000000000
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@@ -165,8 -157,9 +157,9 @@@ vhost_transport_do_send_pkt(struct vhos
  			break;
  		}
 =20
 -		iov_iter_init(&iov_iter, READ, &vq->iov[out], in, iov_len);
 +		iov_iter_init(&iov_iter, ITER_DEST, &vq->iov[out], in, iov_len);
- 		payload_len =3D pkt->len - pkt->off;
+ 		payload_len =3D skb->len;
+ 		hdr =3D virtio_vsock_hdr(skb);
 =20
  		/* If the packet is greater than the space available in the
  		 * buffer, we split it using multiple buffers.
@@@ -366,18 -340,21 +340,22 @@@ vhost_vsock_alloc_skb(struct vhost_virt
  		return NULL;
  	}
 =20
- 	pkt =3D kzalloc(sizeof(*pkt), GFP_KERNEL);
- 	if (!pkt)
+ 	len =3D iov_length(vq->iov, out);
+=20
+ 	/* len contains both payload and hdr */
+ 	skb =3D virtio_vsock_alloc_skb(len, GFP_KERNEL);
+ 	if (!skb)
  		return NULL;
 =20
 -	iov_iter_init(&iov_iter, WRITE, vq->iov, out, len);
 +	len =3D iov_length(vq->iov, out);
 +	iov_iter_init(&iov_iter, ITER_SOURCE, vq->iov, out, len);
 =20
- 	nbytes =3D copy_from_iter(&pkt->hdr, sizeof(pkt->hdr), &iov_iter);
- 	if (nbytes !=3D sizeof(pkt->hdr)) {
+ 	hdr =3D virtio_vsock_hdr(skb);
+ 	nbytes =3D copy_from_iter(hdr, sizeof(*hdr), &iov_iter);
+ 	if (nbytes !=3D sizeof(*hdr)) {
  		vq_err(vq, "Expected %zu bytes for pkt->hdr, got %zu bytes\n",
- 		       sizeof(pkt->hdr), nbytes);
- 		kfree(pkt);
+ 		       sizeof(*hdr), nbytes);
+ 		kfree_skb(skb);
  		return NULL;
  	}
 =20

--Sig_/vNGSavCtqEiQo9JsuTjYFFf
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmOg7lEACgkQAVBC80lX
0GyLZgf+Pc9cXS0OA5KNne6FUmec+Ev6RsGmENoKwykf7ayCw0iesuBgm3J26yI9
LtxrH+tSiFt/e0lspsUyE6Q3y9kFSXj/A0BmwNqH9YlzxOkEhgWgFeCYjfbAuAg9
NZsRrStznM3YBwiPvn9zCxQfzrWl7ul1ymlnT1ohpvHLD0wDJHlmYZwi8u5lKOL9
qlyoMBkjgz9VslSiIQHyeujV5djFgJlOQo1u83w8Pbo+/XswsNtJ6YnB/2kwym37
EfcLNTfXG66l5jmyCS/VQbmXYZ7peL+/WZXJsTxf1+3KRpqs2OvXLniNEOCoImdv
ngc6mt2M2KCAcA6OqBc795MVQNWlgg==
=BPiX
-----END PGP SIGNATURE-----

--Sig_/vNGSavCtqEiQo9JsuTjYFFf--
