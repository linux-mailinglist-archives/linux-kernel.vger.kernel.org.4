Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3F7D680269
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 23:56:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233308AbjA2W4w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 17:56:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjA2W4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 17:56:44 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D4345FC2;
        Sun, 29 Jan 2023 14:56:42 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4P4ms328zVz4x2c;
        Mon, 30 Jan 2023 09:56:39 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1675033001;
        bh=gbyszc1FJYVufykExUphRGi7MXMQQUMbTAeAOCiv0eU=;
        h=Date:From:To:Cc:Subject:From;
        b=XzJ7i5wce8XxxbZck8vZ0tFhsQpEZ4DRNI/llces4akj7Y0rpXJxWQUj9P6uPfAIR
         IkledSw/PzVTlvZdzKuVgB1L2IACSp1cTOyuYp8ZsVd+3y3+/X4VYK6pe9w8WkE76B
         j6VWwPVXvtzrsUh9abY3KctDC9PdcZV/Aqpdn1Tdc+AscvK8O4VQSB5KuN+n2A0rmG
         cK+Pt84mq9HeYQiNM+K/1xWXqEW7t4KgsKFgCmftSmbjirkA8yKaNeTJ0A3tj8DF1I
         I8hAxlXLoeFf4GgzgYFW75uz183BEQPAICagTzdHOioRyKDln2sAU/FU6TDvDsDZvS
         4e7iR3oqMfJ/Q==
Date:   Mon, 30 Jan 2023 09:56:38 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        ARM <linux-arm-kernel@lists.infradead.org>,
        Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the arm-soc tree with the kbuild tree
Message-ID: <20230130095638.72fdea23@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/NOQQ6yxR.V20NOgccAP6Zje";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/NOQQ6yxR.V20NOgccAP6Zje
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the arm-soc tree got a conflict in:

  arch/arm/mach-s3c/Makefile

between commit:

  608d67522f28 ("kbuild: remove --include-dir MAKEFLAG from top Makefile")

from the kbuild tree and commits:

  61b7f8920b17 ("ARM: s3c: remove all s3c24xx support")
  1ea35b355722 ("ARM: s3c: remove s3c24xx specific hacks")

from the arm-soc tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc arch/arm/mach-s3c/Makefile
index deb44326b828,988c49672715..000000000000
--- a/arch/arm/mach-s3c/Makefile
+++ b/arch/arm/mach-s3c/Makefile
@@@ -2,13 -2,7 +2,7 @@@
  #
  # Copyright 2009 Simtec Electronics
 =20
- ifdef CONFIG_ARCH_S3C24XX
- include $(srctree)/$(src)/Makefile.s3c24xx
- endif
-=20
- ifdef CONFIG_ARCH_S3C64XX
 -include $(src)/Makefile.s3c64xx
 +include $(srctree)/$(src)/Makefile.s3c64xx
- endif
 =20
  # Objects we always build independent of SoC choice
 =20

--Sig_/NOQQ6yxR.V20NOgccAP6Zje
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPW+aYACgkQAVBC80lX
0Gzmdgf+PQtyfIvlgIdBomk9l/ALlUMdU8uyMmKT+3rm9oCmuFlDdnm3LeMOAhye
FLWPQTAsh0vJPAAiREX9B1MIOb4lHSJExp9L5EjtUPxOvtS2c0zU7oO6/sHk2EwY
Saxo7Nw1mJaBsoXQV4GUqfBSokLMmcYbGYVpPUhv7Y+jaAYZ2n3wzWyW0zDLJzrw
tQYSXg/lasG3iT2KLkL+snoLJGqxL9+Sv0gT6qnZ5XiULq9Q/mnLl1ak5ryjynVf
T2Z4p9MarogfTKKBP9oceF0SoGA+VOujsrxF77H7anjjQBDgDACNT8YQ04TBcClM
Lb0eoSSDzBfTY2B/YYib9qIX8QVs8Q==
=G3xx
-----END PGP SIGNATURE-----

--Sig_/NOQQ6yxR.V20NOgccAP6Zje--
