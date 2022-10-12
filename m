Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED68B5FCEAF
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 01:00:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbiJLXAW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 19:00:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbiJLW7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 18:59:48 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E454A265B;
        Wed, 12 Oct 2022 15:59:38 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Mnp4n3VNtz4xFy;
        Thu, 13 Oct 2022 09:59:37 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1665615577;
        bh=dlSeURIZbGv4D6or2NL+ft3mN0Zln/f62r9aYjEnMow=;
        h=Date:From:To:Cc:Subject:From;
        b=U+7uKzeYv21M1JzyLUkb/tiTrIuiz4TQhKYCO4hOGSfGn9eGvWY6hb+GWn0549712
         b1Kotg7Sosfk6elk25ayJ+3blvtN5T/+hHWyUX3IIezk7nW1WaSLlk1mF8BTu26Ofv
         LVc96KF6XED5IlVkqnRLxkOejoZN+A8/oycq4zZ5O/wPDQifAHNmXSN4EjACjJTIFH
         idkoeMfFII75MCIZ/b9XkbzScgxFCZbKKn77mTSRP5tpMPsXcvIqZ8dx0Ix8aLTNoB
         6UvM3YalN+h7/FPblRW9Liz+72LWbvkudiQ1HQ7el1y/ZW0ilae3fVSjKiVneWjjVD
         gMuNbrR82IT7w==
Date:   Thu, 13 Oct 2022 09:59:36 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Miklos Szeredi <mszeredi@redhat.com>
Subject: linux-next: manual merge of the fuse tree with Linus' tree
Message-ID: <20221013095936.2dedd370@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Llt5gQlEHDQTa.K.F1cSsqF";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Llt5gQlEHDQTa.K.F1cSsqF
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the fuse tree got a conflict in:

  include/uapi/linux/fuse.h

between commit:

  7d37539037c2 ("fuse: implement ->tmpfile()")

from Linus' tree and commit:

  22fb2e02a194 ("fuse: add "expire only" mode to FUSE_NOTIFY_INVAL_ENTRY")

from the fuse tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc include/uapi/linux/fuse.h
index 76ee8f9e024a,1688fdea550f..000000000000
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@@ -196,7 -196,7 +196,8 @@@
   *  - add FUSE_HAS_INODE_DAX, FUSE_ATTR_DAX
   *
   *  7.37
 + *  - add FUSE_TMPFILE
+  *  - add FUSE_EXPIRE_ONLY flag to fuse_notify_inval_entry
   */
 =20
  #ifndef _LINUX_FUSE_H

--Sig_/Llt5gQlEHDQTa.K.F1cSsqF
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmNHRtgACgkQAVBC80lX
0Gx+bggAhdojgh8S2JpfopzVI4uM7Bqdt4DvXgs2tMlcREdHwyU0hQpZBfui7qYq
Sud1Rc2zB9sGxkK9uA3MyJkxbafV0X8twpXFJ/5qfP5ZAkiJ5yY7xIUa/L8jh+IT
koL+kFgyIzNc+WHPDLshWwlCJRALblW5N9CYdGcaGUVg4MKPPlsal2y7NFj28TPV
GowunLMSl0YZRxJiOGc5e8YIA6ayM3D/fFyULQmFJp+jLfczi7eTRHVU3TqQe8zG
acLMlKlnxgXR68NghBepNt7JZ2m41fDuWAoStgbUtae2LBtwjLCsHVLsGwHOASU7
Zy5j8GGix+xZ//LUbjBd5mr706NHmw==
=icT7
-----END PGP SIGNATURE-----

--Sig_/Llt5gQlEHDQTa.K.F1cSsqF--
