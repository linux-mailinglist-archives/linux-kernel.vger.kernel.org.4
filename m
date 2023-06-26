Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E93073D624
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 05:10:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbjFZDKH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 23:10:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231194AbjFZDJ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 23:09:56 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BACF2189;
        Sun, 25 Jun 2023 20:09:55 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QqCWP188lz4wb0;
        Mon, 26 Jun 2023 13:09:53 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1687748994;
        bh=+czq6miQ0mBDch3gmdYhKC0gx38ZSOssz4z8cIyVzrw=;
        h=Date:From:To:Cc:Subject:From;
        b=Xel0quGwLJn+HtPTqGPfqsT5vMdJ+W6r13r0GJewXUxdBj/nXt2igRHUq0lbdRr/i
         KJc2p2poDtGL0FBEGdwzPgztVomdhwc/dV4pcIzRPJykQCzRMceZaZTWoYuwwjSH1O
         9BB66rHCEL25ZhIe6jvt/8S2MtW8mmNBwR27hxpGiSUF1FuY+y7Alvx9YVUE22/bHr
         MZoHu13Ipdxti2iZC7hZpAAaj2gXDye5ORqpE+ci2O3k0UoD5yRgkJUcuxjwCj4hWG
         t2ze96Ja/JB1DmyX4bv3UM+SGkY5zve0uefAkBHl2AFoZfOyQ6gBMQQrIRWPrbzkpV
         R5uNFYJO2CyHA==
Date:   Mon, 26 Jun 2023 13:09:51 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jens Axboe <axboe@kernel.dk>, Theodore Ts'o <tytso@mit.edu>
Cc:     Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Zhihao Cheng <chengzhihao1@huawei.com>
Subject: linux-next: manual merge of the block tree with the ext4 tree
Message-ID: <20230626130951.54c4254a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/KydiTxXQEOVAP8cdvwZGdIX";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/KydiTxXQEOVAP8cdvwZGdIX
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the block tree got a conflict in:

  fs/ext4/super.c

between commit:

  ffea255f4052 ("ext4: Fix reusing stale buffer heads from last failed moun=
ting")

from the ext4 tree and commits:

  2736e8eeb0cc ("block: use the holder as indication for exclusive opens")
  a42fb5a75ccc ("ext4: Fix warning in blkdev_put()")

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
index b3819e70093e,64342adcd679..000000000000
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
+ 		blkdev_put(bdev, sbi->s_sb);
  		sbi->s_journal_bdev =3D NULL;
  	}
  }

--Sig_/KydiTxXQEOVAP8cdvwZGdIX
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmSZAX8ACgkQAVBC80lX
0GzC9wf/Ue390rIGA2bNChucOnzwaq8JO4xrpT0EbaLBQkmwLW1XU9AOZDurDLnp
bTHZeqD4YFmhUmpbHidN/D4uV4RWE5PUVfryT9ktosPHLvhZrXM8eaz7zHhvvcbM
NDy1UE+wDAjsViLtMZi+HdNBmtGU8alE8kccrwTHAkmz7WIuhrzwXFVhYjGsZygV
mWewz+/z6uUY5Rc7q6ZkCNAAyUM9a7iOVkQMvrDFnKkmmkddRP8YxDUyXT2RURaU
uC6NoZMHXVT1jWO62fkhPpAYZR+XmePTWAuCJmZ6WrnGbGNJwZxwPjPVkoiQ5v2q
KbtY5Ce57rL+jbpW2D+rVebhzNMS0w==
=tREb
-----END PGP SIGNATURE-----

--Sig_/KydiTxXQEOVAP8cdvwZGdIX--
