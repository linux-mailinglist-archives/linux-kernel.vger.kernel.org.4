Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2F2C72D784
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 04:54:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238586AbjFMCyl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 22:54:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232586AbjFMCyj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 22:54:39 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AF921989;
        Mon, 12 Jun 2023 19:54:12 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QgCnG1WfPz4x4F;
        Tue, 13 Jun 2023 12:54:09 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1686624851;
        bh=2iT5jXCclrnY2bEFfafzVRtJej6mnikqPMzQSHmL+Nk=;
        h=Date:From:To:Cc:Subject:From;
        b=ERBA2vZl3YN9L8feZVlb5MvIGKYCMG+vCM+7QKQ1NfnOOc6rtW3olZYHGMxmjyzHa
         Oj9dB64G10Uo+CKTaON6eiqLeNLL5zcYM7vxpGRCt8aJVtoAgPXsJ/auPgrFgW84iG
         cksBe56NfUp8ZtJnz/YJyRrjGGZi6BPZawITGyTMAy7Iys2G8PJFILtOhvu4+Kin6Z
         hfLm+cX7I0HsgC/q/nuo3GS4ku8fvZqJ6WeezEcndBfNR9298VljRcFcdSuCkCXPY1
         FHbRin62HUuuocRlns6WioPvYNZn7Vp8/ztOttucgR7VW+3bKliHn6oMgbiM7U7FM1
         vISXKc1gfvtGw==
Date:   Tue, 13 Jun 2023 12:54:08 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jens Axboe <axboe@kernel.dk>, Theodore Ts'o <tytso@mit.edu>
Cc:     Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Zhihao Cheng <chengzhihao1@huawei.com>
Subject: linux-next: manual merge of the block tree with the ext4 tree
Message-ID: <20230613125408.7321db60@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/_=Ej.ZgdWV78tnMAPIC7EDu";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/_=Ej.ZgdWV78tnMAPIC7EDu
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the block tree got a conflict in:

  fs/ext4/super.c

between commit:

  63bc068f0d1a ("ext4: Fix reusing stale buffer heads from last failed moun=
ting")

from the ext4 tree and commit:

  2736e8eeb0cc ("block: use the holder as indication for exclusive opens")

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

diff --cc fs/ext4/super.c
index b3819e70093e,94a7b56ed876..000000000000
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@@ -1128,13 -1133,7 +1133,13 @@@ static void ext4_blkdev_remove(struct e
  	struct block_device *bdev;
  	bdev =3D sbi->s_journal_bdev;
  	if (bdev) {
 +		/*
 +		 * Invalidate the journal device's buffers.  We don't want them
 +		 * floating about in memory - the physical journal device may
 +		 * hotswapped, and it breaks the `ro-after' testing code.
 +		 */
 +		invalidate_bdev(bdev);
- 		ext4_blkdev_put(bdev);
+ 		blkdev_put(bdev, sbi->s_es);
  		sbi->s_journal_bdev =3D NULL;
  	}
  }

--Sig_/_=Ej.ZgdWV78tnMAPIC7EDu
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmSH2lAACgkQAVBC80lX
0Gy0CggAhTJbE9J247FPiYJ4oEwG+bHBlvwjXQ5N088PRLGfowHUcPugDXppDt6K
uVjYCJd+len9EjcUO1DlOrfhZur6PN4ZVmgoIDtpCmoV1sTgfVATUUsSZpqmbVsB
l239G5vcm+Uj3mtxYskK8KaeSlqG3AZtlcRcJDsGGcFjja8drmOOSVeidwY8PESU
zuxWlfrX+jJM6Bhw0DhcQGJ1tg8Z1/osWgCCe+O7F+dEBdIY/8K+V5EZ0/YCrsnu
EjtbXnDrl8ZkM+X42bUHCExQC2lkKgSWZBab/amZkZLlODJEk1rhlsSihMuefORt
2jInGDxPHy7/0SKnBAvEzWtXPCAbkg==
=F3+1
-----END PGP SIGNATURE-----

--Sig_/_=Ej.ZgdWV78tnMAPIC7EDu--
