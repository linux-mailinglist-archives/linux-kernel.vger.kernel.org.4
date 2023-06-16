Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3229773243D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 02:25:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbjFPAZf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 20:25:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjFPAZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 20:25:33 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AD56294A;
        Thu, 15 Jun 2023 17:25:32 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Qj0LF5ThSz4wgm;
        Fri, 16 Jun 2023 10:25:25 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1686875126;
        bh=+/o2wJdvhNn8owmtxm/tIRC6tn+RcQNcjmwiB22+zVg=;
        h=Date:From:To:Cc:Subject:From;
        b=m1jw6Z0h3IRyqMc4AM9INTrWVvilJbZK4KTxwahHwOULPV5tax6BHXYxwKu78J8Se
         Hwr3/DE2MYMHWgNdb1SR6Q5Hp9ZRlMHEpCCWHsOWYqKJOkWmybh/0Y/CzQ4V2qrR4X
         1NJQ0xHphPCZzvtxPL3iAva0zXFKQludkO1QaXAr4reKAWpbP++zIfdcHnWIBVuKGs
         yX0ufvFCNCMZ7Aid6ReCaRB8XsLbOaxbS8nxQdgyOnrsYPrretS9bB13u3rkNlatf1
         9ZphMKn5k+sAK4UcgTMcIbOivCNizgWNFsJs4MqakOljHTwl32lIWoIdV2TxjXsO9Z
         34lXwig7Qb7pg==
Date:   Fri, 16 Jun 2023 10:25:24 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jaegeuk Kim <jaegeuk@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Lu Hongfei <luhongfei@vivo.com>, Yangtao Li <frank.li@vivo.com>
Subject: linux-next: manual merge of the f2fs tree with the mm tree
Message-ID: <20230616102524.73bb5efb@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/1K8=XFi3JGtX_ErmP+2iZxH";
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

--Sig_/1K8=XFi3JGtX_ErmP+2iZxH
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the f2fs tree got a conflict in:

  fs/f2fs/file.c

between commit:

  0d625446d0a4 ("backing_dev: remove current->backing_dev_info")

from the mm tree and commit:

  d61812691182 ("f2fs: enable nowait async buffered writes")

from the f2fs tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc fs/f2fs/file.c
index 7134fe8bd008,41e7c2b80f31..000000000000
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@@ -4514,12 -4535,12 +4535,9 @@@ static ssize_t f2fs_buffered_write_iter
  	struct inode *inode =3D file_inode(file);
  	ssize_t ret;
 =20
- 	if (iocb->ki_flags & IOCB_NOWAIT)
- 		return -EOPNOTSUPP;
-=20
 -	current->backing_dev_info =3D inode_to_bdi(inode);
  	ret =3D generic_perform_write(iocb, from);
 -	current->backing_dev_info =3D NULL;
 =20
  	if (ret > 0) {
 -		iocb->ki_pos +=3D ret;
  		f2fs_update_iostat(F2FS_I_SB(inode), inode,
  						APP_BUFFERED_IO, ret);
  	}

--Sig_/1K8=XFi3JGtX_ErmP+2iZxH
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmSLq/UACgkQAVBC80lX
0GwVMwgAnd5ImyDarc6jxM1+o+593CR9ganMycSCvedlLU2ar4g7p+0wk4gNj09G
CFXVGJAyxVecB+0Vf/k62XSgH4aqTo7C0nbOJWUwDDFCkSDJAuiBMIBKEPhaj6ue
Z5sJsmxElShlKmHeiS0MXPDijtw/qX/LXotXY0Zp7viyD0+GHVb3kDQh2WvNoKcm
M3849td1zC8fLZpcdEOA8dHz7J+5YIS01ANtoYShrAChPEr+Zu17KFMRTeQ/R6m1
Y4PXieRoJgyhLQxrOLQwaPIviCRPo3BHsFNs9WFw6du7mkEff1m5rSzgczJG2J0d
RYeNIcIMQGfLypbqzbrg1+Xl3du95g==
=9ED2
-----END PGP SIGNATURE-----

--Sig_/1K8=XFi3JGtX_ErmP+2iZxH--
