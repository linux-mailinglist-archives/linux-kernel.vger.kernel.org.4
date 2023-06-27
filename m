Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE59773EFDB
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 02:46:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbjF0Aqw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 20:46:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjF0Aqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 20:46:51 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48D6512C;
        Mon, 26 Jun 2023 17:46:50 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QqmHr1vD1z4wZv;
        Tue, 27 Jun 2023 10:46:48 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1687826808;
        bh=Y72SU4FB9301ltMa6LwnjGji2x9UTnFq9kBOUG8LCwM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RQwWWzxe3hy80JPWXzjMDbOrjPbOPhxKgB98dM8hl7cUhj36RLNqrBV4EmGIbwN2T
         oI/O+nAYJN+ySRiwtuibW82kBUrPuN9vLrIRDW65Du5WikSRsXdccCHVb4mBDSGs6w
         M2soSZ96SZ6Ip2V63+eXue6DDI96iCanplgsqILvvy2GD3mbsla74dGq1aCFNwmY6p
         FjOTPcHD5HHj5oVRSF07cMmKK6May51q9ZPrUgcbYevc9Uh02LRJWLKji2hrfYT5ZP
         /8i/Ctj7/fOfI5Ua0a0D1KcEZzTNwzkCxCoPARPWNzNrx1s1YZWRcFGnQTY6Oe3UFU
         yq5EuUUvEliTw==
Date:   Tue, 27 Jun 2023 10:46:46 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Jan Kara <jack@suse.cz>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Zhihao Cheng <chengzhihao1@huawei.com>
Subject: Re: linux-next: manual merge of the block tree with the ext4 tree
Message-ID: <20230627104646.35f4279d@canb.auug.org.au>
In-Reply-To: <20230626130951.54c4254a@canb.auug.org.au>
References: <20230626130951.54c4254a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/o8s4kc5BqlBWkzFu/sTqaXY";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/o8s4kc5BqlBWkzFu/sTqaXY
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Mon, 26 Jun 2023 13:09:51 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>=20
> Today's linux-next merge of the block tree got a conflict in:
>=20
>   fs/ext4/super.c
>=20
> between commit:
>=20
>   ffea255f4052 ("ext4: Fix reusing stale buffer heads from last failed mo=
unting")
>=20
> from the ext4 tree and commits:
>=20
>   2736e8eeb0cc ("block: use the holder as indication for exclusive opens")
>   a42fb5a75ccc ("ext4: Fix warning in blkdev_put()")
>=20
> from the block tree.
>=20
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>=20
> --=20
> Cheers,
> Stephen Rothwell
>=20
> diff --cc fs/ext4/super.c
> index b3819e70093e,64342adcd679..000000000000
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@@ -1128,13 -1133,7 +1133,13 @@@ static void ext4_blkdev_remove(struct e
>   	struct block_device *bdev;
>   	bdev =3D sbi->s_journal_bdev;
>   	if (bdev) {
>  +		/*
>  +		 * Invalidate the journal device's buffers.  We don't want them
>  +		 * floating about in memory - the physical journal device may
>  +		 * hotswapped, and it breaks the `ro-after' testing code.
>  +		 */
>  +		invalidate_bdev(bdev);
> - 		ext4_blkdev_put(bdev);
> + 		blkdev_put(bdev, sbi->s_sb);
>   		sbi->s_journal_bdev =3D NULL;
>   	}
>   }

This is now a conflict between the ext4 tree and Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/o8s4kc5BqlBWkzFu/sTqaXY
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmSaMXYACgkQAVBC80lX
0Gy6ZAgAhEWNmfVOvFAeP1iZyimyJh91WRnHUKGNYvZDUnRufFm2/Weo3msLu0sI
JHSAtSVjC71A04nHt/er2ZjTtoCthupwVC4YbmJ1OkAKSUT8y6/Mm/nEyg7gh0Tv
SQQWnc6gAkUnomEWeUK29ItmlxZdIYvbdvkLaITBXN1oXHc+zl+J8DqTV7hsRGdM
wUypnWh/dx2x37+bP7xMx3kxqHzv8X1BPIAxUZX6qPIOa686oWwj/xjp62zJ26wY
4uRufm+c9BDpp8Q3dNDaBErRRfcYyie/i7wN4Sjk0tfXlH5rfZm0Tw+JokLeWjy+
P2XBy1epMY0twEhkNCuUlBXj/OjFAA==
=xBOG
-----END PGP SIGNATURE-----

--Sig_/o8s4kc5BqlBWkzFu/sTqaXY--
