Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A030639F87
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 03:41:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbiK1Cl3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 21:41:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiK1Cl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 21:41:27 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D80C81144B;
        Sun, 27 Nov 2022 18:41:26 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NL8qP4JXGz4x7X;
        Mon, 28 Nov 2022 13:41:21 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1669603282;
        bh=GIw18h1LlIuW/xXSG4BYNgbAk/AEeU+yEwmxCG2/KyE=;
        h=Date:From:To:Cc:Subject:From;
        b=IfNev6IkFpTMmpmRqTPXdxXoFk3aUui45H2yEkzk81aCJOj32wBcDEtLOA9KCcJvI
         1mj1VEmiF1kX3FSCwx0ZryeqSBD35/BPBrL4YvRvMCo4ctqo+cXegdbaX45KvUauLF
         uXEWBp9kTebVT3X4pkerk3j1yPkO/mlp/9ttyaS99BNimS/bcoPPJpknui+0D1YkIs
         ZeGCtxX3+fl4Q+sqJJmiUvJF4ez4o3qkX1bzyY8iYlc2W7R8gegIcTif5WREbNn6eZ
         FVkkfhTbohby1xi5oYZjB+E7vtVY2yc7iMABpbUsuXLHowV4LleMYQ55T3Pb6vnxdH
         ER/dq9wLgw4ww==
Date:   Mon, 28 Nov 2022 13:41:20 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mark Brown <broonie@kernel.org>
Cc:     Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>,
        Ben Levinsky <ben.levinsky@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Michal Simek <michal.simek@amd.com>,
        Rajan Vaja <rajan.vaja@xilinx.com>,
        Tanmay Shah <tanmay.shah@amd.com>
Subject: linux-next: manual merge of the rpmsg tree with the spi tree
Message-ID: <20221128134120.0afdceb3@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/QtuRcZtBKYOlx.6+a/hRLll";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/QtuRcZtBKYOlx.6+a/hRLll
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the rpmsg tree got a conflict in:

  include/linux/firmware/xlnx-zynqmp.h

between commit:

  1e400cb9cff2 ("firmware: xilinx: Add qspi firmware interface")

from the spi tree and commit:

  b2bd0a8c3ab1 ("firmware: xilinx: Add ZynqMP firmware ioctl enums for RPU =
configuration.")

from the rpmsg tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc include/linux/firmware/xlnx-zynqmp.h
index fac37680ffe7,cf92e739fa3b..000000000000
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@@ -135,7 -138,10 +138,11 @@@ enum pm_ret_status=20
  };
 =20
  enum pm_ioctl_id {
+ 	IOCTL_GET_RPU_OPER_MODE =3D 0,
+ 	IOCTL_SET_RPU_OPER_MODE =3D 1,
+ 	IOCTL_RPU_BOOT_ADDR_CONFIG =3D 2,
+ 	IOCTL_TCM_COMB_CONFIG =3D 3,
 +	IOCTL_SET_TAPDELAY_BYPASS =3D 4,
  	IOCTL_SD_DLL_RESET =3D 6,
  	IOCTL_SET_SD_TAPDELAY =3D 7,
  	IOCTL_SET_PLL_FRAC_MODE =3D 8,

--Sig_/QtuRcZtBKYOlx.6+a/hRLll
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmOEH9AACgkQAVBC80lX
0GzmAQgAhe6QBjVQ7ZpYxc343NG9pptZCwVVyEzw7f3E2yhnlgxQ6F9bqEknWXX7
6fL2WFUIUFfyebNxdADiggyVQihLn7loEWXEoGyJbVdmMHE82VC2TETIyyUQdxfE
SqEkfPZte0+fJ7o5WgR60s1422dp51mmynWVVwinSOPHdopEJyjDy9ZuvKvvuHvM
2MdJuzNjfi55SBp26w6ab27twQSXqdE4575dQ2yAMH0HvGrPsA4OaZr5lURJ5d7o
W0DjRgPE+AXrLZd0mVARl7ELdikgQMa+Nt+Cz3sL/Le2VSXX9Z75dWGQHVxPDKl0
rpPDvP4bvx2eD2NL3iyKAhWOM2CgVg==
=n8zh
-----END PGP SIGNATURE-----

--Sig_/QtuRcZtBKYOlx.6+a/hRLll--
