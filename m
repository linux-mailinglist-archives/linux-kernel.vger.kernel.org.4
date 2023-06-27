Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33DC673EFD9
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 02:45:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbjF0Ap1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 20:45:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjF0ApZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 20:45:25 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EE2F172A;
        Mon, 26 Jun 2023 17:45:23 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QqmG91QqHz4wZv;
        Tue, 27 Jun 2023 10:45:20 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1687826721;
        bh=FpreN/zpKx5TdtbmQIYenqQgdzwueK8hzykvHFrWr6s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=a8GEpcdn44laWVKdcZMDncNZzPipma0DiLDrijw8H0AEpKM50hEkYQSe4MHp4K4Z3
         ccKwRZYxlv56kKEkJjIMaORFaWZHalDhWKfTLgvDn0QhESjx0nCBkxc/+cRo30dg9/
         37AzIRdeJX+jAUw5OwnhokvSVkPX57CHVtw1xYMDG/x9/jPHK++Y3xWeCxgQGPE585
         GehrFnJHB1QU8xYNIHXrJGZCVuk6+RasMj2qof+4SFENT2D2SyXv/BkAFgAqVElH7w
         UfqDFqW7UXVFX+iypcqzvVMSzeyj+8mPAUO1VyUwCs8nzd6Qy+rbIdAZqDo/qHHLcM
         LZKbIHdYdEnew==
Date:   Tue, 27 Jun 2023 10:45:20 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     David Sterba <dsterba@suse.cz>, Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the btrfs tree with the mm tree
Message-ID: <20230627104520.25411bc6@canb.auug.org.au>
In-Reply-To: <20230605090803.43597523@canb.auug.org.au>
References: <20230605090803.43597523@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/07p9.jN09_KvQsSc1NEgl_j";
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

--Sig_/07p9.jN09_KvQsSc1NEgl_j
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Mon, 5 Jun 2023 09:08:03 +1000 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>
> Today's linux-next merge of the btrfs tree got a conflict in:
>=20
>   fs/btrfs/file.c
>=20
> between commit:
>=20
>   39bf7bdb48fe ("backing_dev: remove current->backing_dev_info")
>=20
> from the mm tree and commit:
>=20
>   3564004ccddf ("btrfs: determine synchronous writers from bio or writeba=
ck control")
>=20
> from the btrfs tree.
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
> diff --cc fs/btrfs/file.c
> index ecd43ab66fa6,f53b7b75092d..000000000000
> --- a/fs/btrfs/file.c
> +++ b/fs/btrfs/file.c
> @@@ -1683,9 -1682,7 +1679,6 @@@ ssize_t btrfs_do_write_iter(struct kioc
>   			num_written =3D num_sync;
>   	}
>  =20
> - 	if (sync)
> - 		atomic_dec(&inode->sync_writers);
> -=20
>  -	current->backing_dev_info =3D NULL;
>   	return num_written;
>   }
>  =20

This is now a conflict between the mm-stable tree and Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/07p9.jN09_KvQsSc1NEgl_j
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmSaMSAACgkQAVBC80lX
0Gxxkgf/QyBsL8zTNhiKo2kbPIgDJ+cSPrJWsqnA2JuXYbNXk4NNvGI4M7CioFLQ
nS7kAC+bXcfX9q0clILQbiQct4CzBPPN0dAEN88p/QaNPoDQvuH+OjN3tyHjKNKk
SO52Tir9ix9Q/v5LGaURamDXoTCgeR7C6tfx4BleVN6beXDYwPBwuMQyXiMW+XVe
NSrDNGHCOfz2seXFpzcPBYpJ0Y5MGkaEKJ8X8hidz47wKcRnSU9X1KjlA98w99QD
50+WDDSdrZAHXwUGbV1WXEXBCQgCBjn8fGLUZEFTV25GZkaOz4BF4a6L02q0K1gx
0YgWbWaZuo8QhTnt/gDCG9SCErFqlQ==
=1S7N
-----END PGP SIGNATURE-----

--Sig_/07p9.jN09_KvQsSc1NEgl_j--
