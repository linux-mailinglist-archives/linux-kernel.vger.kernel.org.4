Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6071473AEE7
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 05:05:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231500AbjFWDFC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 23:05:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230235AbjFWDEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 23:04:53 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2646C2135;
        Thu, 22 Jun 2023 20:04:49 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QnMXs5dMSz4wjB;
        Fri, 23 Jun 2023 13:04:45 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1687489487;
        bh=r2ZwcIFT4HlwJjAj+VisO/XGPwfJvpYrACK4BtmNfhY=;
        h=Date:From:To:Cc:Subject:From;
        b=TJd1L/eQg1XgkXP9LOYB6VQ2T1YqBm0OuFJM0pc/r4TCOFy4DClv7TmUylR4Af+GR
         xjxKvyYZ6dtjKZolUQhLZtwGLJQanHtHBq8WDW+o8upCyX6P7bO/jv+ZpzkWRWbRVm
         aCg1IDamyE+dD7/4oe7ufWjPmQ2BdthmYLBf8MTihF4QANBdR7AjV+66ghIHJbVH4T
         Zb3TjwLNfM7WJtEwva4NANAeWTAw4NL7iwlYHPdgrWy3wc4RiOaxkNQ+UVi/iwQpgS
         JYMVT8delOY3IjxF9hyYeqrUA36kVXJYKRnXElqibS/RjT1/G4x1YkM+t8Tx5q2r8e
         UOXjU9KfzyqIA==
Date:   Fri, 23 Jun 2023 13:04:43 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        David Miller <davem@davemloft.net>
Cc:     Jakub Kicinski <kuba@kernel.org>,
        Networking <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: linux-next: manual merge of the vhost tree with the net-next tree
Message-ID: <20230623130443.6c9a481e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Sq/s683MbuDhTPbsFIgzDlo";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Sq/s683MbuDhTPbsFIgzDlo
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the vhost tree got a conflict in:

  drivers/net/virtio_net.c

between commit:

  80f50f918c6e ("virtio_net: separate the logic of freeing the rest mergeab=
le buf")

from the net-next tree and commit:

  21081476b808 ("virtio_net: support dma premapped")

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

diff --cc drivers/net/virtio_net.c
index 0db14f6b87d3,d67b36fdba0d..000000000000
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@@ -1128,28 -1136,6 +1233,28 @@@ err
  	return NULL;
  }
 =20
 +static void mergeable_buf_free(struct receive_queue *rq, int num_buf,
 +			       struct net_device *dev,
 +			       struct virtnet_rq_stats *stats)
 +{
 +	struct page *page;
 +	void *buf;
 +	int len;
 +
 +	while (num_buf-- > 1) {
- 		buf =3D virtqueue_get_buf(rq->vq, &len);
++		buf =3D virtnet_rq_get_buf(rq, &len, NULL);
 +		if (unlikely(!buf)) {
 +			pr_debug("%s: rx error: %d buffers missing\n",
 +				 dev->name, num_buf);
 +			dev->stats.rx_length_errors++;
 +			break;
 +		}
 +		stats->bytes +=3D len;
 +		page =3D virt_to_head_page(buf);
 +		put_page(page);
 +	}
 +}
 +
  /* Why not use xdp_build_skb_from_frame() ?
   * XDP core assumes that xdp frags are PAGE_SIZE in length, while in
   * virtio-net there are 2 points that do not match its requirements:

--Sig_/Sq/s683MbuDhTPbsFIgzDlo
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEyBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmSVC8sACgkQAVBC80lX
0GxbWAf2I4Ddy8m9IViYJOw9ulRJ1xTRB4eS69zxg4ddrmyNDuXd7RovOT6PyTbe
u+CZBM60EPl8RgBoXBRUG0iq/GOSaemiizccOLMH8OVcz7/GSwUeZJbboFQjHEgV
HWUv6gIkQePtsIh8SQPl8ouuKGiXYeIJlC7UHyAeuQX1IAaHq9yohOJVIPpuwiaB
mExe34icoqh4unAr3EmAvZ64cfy+sfZy7mh5XgfpSGdCkSsDdBhn+ITJMJJZKKvO
kcQcBAx3ii547fJ5QQxKG/FQabIwi+jK3KanXVnnXWe3DejCvF92TxkxdO8ApdBW
Q1cGn7j3wP9e6zzf9bJi8YTZTLzp
=SIiz
-----END PGP SIGNATURE-----

--Sig_/Sq/s683MbuDhTPbsFIgzDlo--
