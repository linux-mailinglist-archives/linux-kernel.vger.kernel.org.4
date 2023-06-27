Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EC9973EFCA
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 02:39:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbjF0AjK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 20:39:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbjF0AjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 20:39:08 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA89C171A;
        Mon, 26 Jun 2023 17:39:06 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Qqm6s6Rxsz4wqW;
        Tue, 27 Jun 2023 10:39:01 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1687826342;
        bh=VBT+hkINubzn7ViFqxIo6R9gSORoTGH+ce7ZiG8bKuQ=;
        h=Date:From:To:Cc:Subject:From;
        b=RtevIlJxP+0j//DHKYgpQ3xpWkHD2EW2KTUSSFmgp0/2cPdasfm0t2t75O2tH9FGT
         sAbw+G6J9McV/wQe0987xdbhumcYnIrFVFQBTeAK6p4L7oLP8VNgadxcp2Hu8eRgh9
         k865VQokUQ2qeAPyYmODxlQ7GEj08F4/6GLutn0IKAIuiw0c30S1nBe8yNRcoS6Ylc
         L/lJw0nC0xY7LpwK+nMahTOpnM2MiXHZKabEb9StG9kbAQ5goA6YAtDU1ck/EtlkpF
         IiOubNLFSIVILoF1s/ziHKqpkVwiFLeHh1pJ/84Dk2VRwkjgZC3qruQyA4C0I1aiT8
         H5O0+4T65ld7w==
Date:   Tue, 27 Jun 2023 10:39:00 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Chao Yu <chao@kernel.org>, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@kernel.dk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the ext4 tree with Linus' tree
Message-ID: <20230627103900.04fa564f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/HBQEYr8Ix=16y6_LUWeJbGf";
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

--Sig_/HBQEYr8Ix=16y6_LUWeJbGf
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the ext4 tree got a conflict in:

  fs/ext4/ioctl.c

between commit:

  97524b454bc5 ("ext4: split ext4_shutdown")

from Linus' tree and commit:

  c4d13222afd8 ("ext4: fix to check return value of freeze_bdev() in ext4_s=
hutdown()")

from the ext4 tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc fs/ext4/ioctl.c
index 961284cc9b65,55be1b8a6360..000000000000
--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@@ -793,10 -793,18 +793,11 @@@ static int ext4_ioctl_setproject(struc
  }
  #endif
 =20
 -static int ext4_shutdown(struct super_block *sb, unsigned long arg)
 +int ext4_force_shutdown(struct super_block *sb, u32 flags)
  {
  	struct ext4_sb_info *sbi =3D EXT4_SB(sb);
 -	__u32 flags;
+ 	int ret;
 =20
 -	if (!capable(CAP_SYS_ADMIN))
 -		return -EPERM;
 -
 -	if (get_user(flags, (__u32 __user *)arg))
 -		return -EFAULT;
 -
  	if (flags > EXT4_GOING_FLAGS_NOLOGFLUSH)
  		return -EINVAL;
 =20

--Sig_/HBQEYr8Ix=16y6_LUWeJbGf
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmSaL6QACgkQAVBC80lX
0GwIFgf/UokoeB3Jb0j4QTLFAD53lLaMkyad8c+daW5gbsV7BHAcjnYpDXE4nvAj
rn7agDHmoF4k3oMY10R0Gz2qdzZOhZV9g2i4l7TJn59ZQdp6vabORBk3pW/tIXoD
/dqaSsODw9TumRXgpews0X7S3qjmcVOa0G/N49ribZyi5+dEu3GppOrMarIVC3f/
/ScAyMTRl59LbqeZBU5iCJe+1rjttE6NF+1W0J4t+7EDYC+D28uvdrpV49llhASh
xgHz8YkCVhf9Vwjr91iejcZWVbfUkbGkdlH7VnIDCJVLf8EKt5mzKuAgraNbF6KA
rNvUAQt9fTJ2+1qybDbTobSbHW5nCA==
=sukt
-----END PGP SIGNATURE-----

--Sig_/HBQEYr8Ix=16y6_LUWeJbGf--
