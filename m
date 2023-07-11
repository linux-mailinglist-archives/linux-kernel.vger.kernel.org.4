Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB0B674E2EA
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 03:01:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230393AbjGKBBM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 21:01:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbjGKBBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 21:01:10 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96E53CE;
        Mon, 10 Jul 2023 18:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1689037267;
        bh=B4DwB8zOKuSyVO8uxq9Dy+tWno5pkUGZDOX2npkrOD0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FqgRuQwsI8m5TJWRKxGQU19rmC2knnq0gj7qmZEsQwbK+Fje37fEzCqEcAyjKJDji
         rKninmF78dATO6nX5GwjJJI6iimcmp0EXe808LB/JOt3Krcle4+1MWAhxHVth0VDeW
         BTPBecpJkPr5av6LNy8D32qp8NtDzjr0T9ojG6JaBXfvUWELqRyM8xBxBL2N812/YI
         SNOZKn2SMKF+Xpa7iSXee9xKHt2QMOjRGMrKDM8iM+lc0UykkWst6RZdL9RDzUgZPC
         dkBi501Qvi4pU4KW3b89L0oILpMbL6F/jTg22kpPIoMJJwM2EFuvPyqNcIQjQ8wQSR
         h3AwpOEL5wm7g==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4R0Mxt43rfz4whq;
        Tue, 11 Jul 2023 11:01:06 +1000 (AEST)
Date:   Tue, 11 Jul 2023 11:01:05 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        David Miller <davem@davemloft.net>
Cc:     Jakub Kicinski <kuba@kernel.org>,
        Networking <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: linux-next: manual merge of the vhost tree with the net-next
 tree
Message-ID: <20230711110105.467f896d@canb.auug.org.au>
In-Reply-To: <20230623130443.6c9a481e@canb.auug.org.au>
References: <20230623130443.6c9a481e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/vYM/I6ZyNfC9j0yYpl4QqtM";
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

--Sig_/vYM/I6ZyNfC9j0yYpl4QqtM
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Fri, 23 Jun 2023 13:04:43 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> Today's linux-next merge of the vhost tree got a conflict in:
>=20
>   drivers/net/virtio_net.c
>=20
> between commit:
>=20
>   80f50f918c6e ("virtio_net: separate the logic of freeing the rest merge=
able buf")
>=20
> from the net-next tree and commit:
>=20
>   21081476b808 ("virtio_net: support dma premapped")

This is now commit

  c8dc5b9adff9 ("virtio_net: support dma premapped")

> from the vhost tree.
>=20
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>=20
> diff --cc drivers/net/virtio_net.c
> index 0db14f6b87d3,d67b36fdba0d..000000000000
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@@ -1128,28 -1136,6 +1233,28 @@@ err
>   	return NULL;
>   }
>  =20
>  +static void mergeable_buf_free(struct receive_queue *rq, int num_buf,
>  +			       struct net_device *dev,
>  +			       struct virtnet_rq_stats *stats)
>  +{
>  +	struct page *page;
>  +	void *buf;
>  +	int len;
>  +
>  +	while (num_buf-- > 1) {
> - 		buf =3D virtqueue_get_buf(rq->vq, &len);
> ++		buf =3D virtnet_rq_get_buf(rq, &len, NULL);
>  +		if (unlikely(!buf)) {
>  +			pr_debug("%s: rx error: %d buffers missing\n",
>  +				 dev->name, num_buf);
>  +			dev->stats.rx_length_errors++;
>  +			break;
>  +		}
>  +		stats->bytes +=3D len;
>  +		page =3D virt_to_head_page(buf);
>  +		put_page(page);
>  +	}
>  +}
>  +
>   /* Why not use xdp_build_skb_from_frame() ?
>    * XDP core assumes that xdp frags are PAGE_SIZE in length, while in
>    * virtio-net there are 2 points that do not match its requirements:

This is now a conflict between the vhost tree and Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/vYM/I6ZyNfC9j0yYpl4QqtM
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmSsqdEACgkQAVBC80lX
0GyZPwf/cFvPmsfrNh9BzsRVjwY6977gPEoHeWXeTWzEamrXxH9+UOS3MTsf1NN5
uBJb1Rm0aRlrsfShLxBK4T5R72fjuRIGlr1W5xesLn69O4uRnMcPpCB4FfZRFU8A
5rywlnAQVJjt/AgQkjOKhaxzC52h9msxHAvNNwqtYRp6o3ysLumE2WcPoIX8AtCZ
I50pnZ94DJIwS+APgaNL7q/yNZl7UezYcXbhmHQqg02Tgp4sYfoE0lkFo6jGXkjW
u9whwIXx+uctvAUzQUFpxijZmUrD9U19X9h245jZJRu+T/oh7jJDDPEVyoZd8ihE
R5SgjBc7rFEFuIJHnlLVcOkovYZFaA==
=uY7L
-----END PGP SIGNATURE-----

--Sig_/vYM/I6ZyNfC9j0yYpl4QqtM--
