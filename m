Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A2DD69D7A9
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 01:46:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232797AbjBUAq0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 19:46:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbjBUAqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 19:46:23 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1492422DEC;
        Mon, 20 Feb 2023 16:46:22 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PLLFR4Kw3z4x7y;
        Tue, 21 Feb 2023 11:46:19 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1676940380;
        bh=L0KhUyvbjfE14zaS4+1g2rH4lX8+hQvFxD/6Jmu/zQg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DBIVbxTfJYPJizeAFAdRod+UuPKRZKDpfzv1uT21aZg0D6W3RjtingqNFtHDJg23t
         Q0Gy/Wh0W8JYwuafyBGjybz6eH6q2dyRV6a9MLH9+BePOv2aXi018KNB/sN0hptPyU
         Ib9bVXLxF4rxxYeDMq1ZBMcO5vLikURg6Qi63YSPCohfUfZ8Mq3tVToLDrDm/VNxZC
         hpy4BMuzBRkFrlTVkxqFm+n6KLKapDg+HQLfcUOeVitt5/jVFP9NulBAaqsoSKi3si
         c7dt3wHyRKJ/b8YZB/hav21wpoHeOQZnuKIDY7P/d5GgfIB/0g8bEe31xsfKKwSbba
         y3to+ORJRcPDw==
Date:   Tue, 21 Feb 2023 11:46:18 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Jeff Layton <jlayton@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Tycho Andersen <tycho@tycho.pizza>
Subject: Re: linux-next: manual merge of the file-locks tree with the fuse
 tree
Message-ID: <20230221114618.23b82b6f@canb.auug.org.au>
In-Reply-To: <20230127112640.6f55e705@canb.auug.org.au>
References: <20230127112640.6f55e705@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/=7Xzw3SP5Tk22TBPfdVzNJW";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/=7Xzw3SP5Tk22TBPfdVzNJW
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Fri, 27 Jan 2023 11:26:40 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> Today's linux-next merge of the file-locks tree got a conflict in:
>=20
>   fs/fuse/file.c
>=20
> between commit:
>=20
>   5a8bee63b10f ("fuse: in fuse_flush only wait if someone wants the retur=
n code")
>=20
> from the fuse tree and commit:
>=20
>   5970e15dbcfe ("filelock: move file locking definitions to separate head=
er file")
>=20
> from the file-locks tree.
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
> diff --cc fs/fuse/file.c
> index 5a98cf915bd3,1458412f2492..000000000000
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@@ -18,7 -18,7 +18,8 @@@
>   #include <linux/falloc.h>
>   #include <linux/uio.h>
>   #include <linux/fs.h>
>  +#include <linux/file.h>
> + #include <linux/filelock.h>
>  =20
>   static int fuse_send_open(struct fuse_mount *fm, u64 nodeid,
>   			  unsigned int open_flags, int opcode,

This is now a conflict between the fuse tree and Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/=7Xzw3SP5Tk22TBPfdVzNJW
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmP0FFoACgkQAVBC80lX
0GxahQgAoTjnSSISnptK3JqxmwC4P5ZBFBr+X5Q6Bw5WnFWFxCo3yksz8anywHIc
4BIzRjBHDSnje0LiOKnm/21AULv6Akj8sUhGjQPIrIHn8KecuqHF7ZVglOFN06oh
+Np0oPgQTziS8NqKfr+qxCcHvpY2uCTfe/tW5SRRrF/2pi+FX9Fd7XOMzDbXTZWW
i8LYuWusDHOGhnw+3oTSGsFf/M7VlNsV0esdlitVzXJRx8m1uXdRd2m7X4FmhG5c
V/I0OdB5jcbDtF+kMqxB86rOdw5DahgzKpmDAqAd34dSyRULbkqBVlzWIzXfYbuO
wNJou39ETUHIHzxgrnkgBub7G2ESog==
=pskB
-----END PGP SIGNATURE-----

--Sig_/=7Xzw3SP5Tk22TBPfdVzNJW--
