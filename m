Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0669627534
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 05:13:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235819AbiKNENB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 23:13:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235812AbiKNEMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 23:12:45 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8CB2FF2;
        Sun, 13 Nov 2022 20:12:42 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4N9bW962rhz4xYV;
        Mon, 14 Nov 2022 15:12:37 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1668399158;
        bh=wU9me65dQPWJLcVeRPfEcSc268kF5re5uMiLEGCuSZE=;
        h=Date:From:To:Cc:Subject:From;
        b=FHgPqZjuueXabT0ClhV0T1iT+ckZup/oqVDyj+4JABdMSrcTrleIhZhRhUSmjUPdn
         kXVi3vibeF/0Frs7/vwTzag9BDrwD1fhjpP7JfRrVnrxr6Wg6j9tgvSIkkahHcr0Nc
         +83dbUfxWOtHjIqafv7kPB07pA+AdFgu3orlvx0FfsqKhNlPM1vCM+KptvDF9Y7VdE
         fUYbRgTYBNFEVRo5Vm3fXZHAE2d1rGhmVWfsAEhJ5WFPs3n7d9a5+/CLqrE+PXoG2c
         lvihohW2r4a3m7PjYlpqNEOJ4TTE6IsE0kun4p2MJ3OxiZjWkWtkFwxnnNM5BrYIDc
         eP8M8E5OTZ8eg==
Date:   Mon, 14 Nov 2022 15:12:35 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <greg@kroah.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the driver-core tree
Message-ID: <20221114151235.01e5ff3b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/UB3t=s2L7cXPITcUlOb.IdE";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/UB3t=s2L7cXPITcUlOb.IdE
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the driver-core tree, today's linux-next build (arm
multi_v7_defconfig) failed like this:

drivers/mfd/vexpress-sysreg.c:64:51: error: initializer element is not cons=
tant
   64 |                 .resources =3D (struct resource []) {
      |                                                   ^
drivers/mfd/vexpress-sysreg.c:64:51: note: (near initialization for 'vexpre=
ss_sysreg_cells[0]')
drivers/mfd/vexpress-sysreg.c:73:51: error: initializer element is not cons=
tant
   73 |                 .resources =3D (struct resource []) {
      |                                                   ^
drivers/mfd/vexpress-sysreg.c:73:51: note: (near initialization for 'vexpre=
ss_sysreg_cells[1]')
drivers/mfd/vexpress-sysreg.c:82:51: error: initializer element is not cons=
tant
   82 |                 .resources =3D (struct resource []) {
      |                                                   ^
drivers/mfd/vexpress-sysreg.c:82:51: note: (near initialization for 'vexpre=
ss_sysreg_cells[2]')
drivers/mfd/vexpress-sysreg.c:90:51: error: initializer element is not cons=
tant
   90 |                 .resources =3D (struct resource []) {
      |                                                   ^
drivers/mfd/vexpress-sysreg.c:90:51: note: (near initialization for 'vexpre=
ss_sysreg_cells[3]')

Caused (probably) by commit

  52c4d11f1dce ("resource: Convert DEFINE_RES_NAMED() to be compound litera=
l")

I have used the driver-core tree from next-20221111 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/UB3t=s2L7cXPITcUlOb.IdE
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmNxwDMACgkQAVBC80lX
0Gykbwf/cjBm0o4rPPu5Q2OlLQpB3e8ADmnaEH0EsCbDfLWPOPuxLPLn3rTPWhRX
n3qH0VaSYkb33yNvUCCX3YV5wM7hn54fET+9JTnmBTSicKLcIrqH3cdv0rwLHjoC
pZqQWfT80NukyCz0/rI7JDB3pHsNUqyIsjEqji2GPHMFCtdpWrDHc1MxYEIi4q5n
/jYGP/LUPelCDaKweu8WQzog6UGP6bbahidPQbwHvcJJL+IMQRH0Js55/0k1MpaD
xdoviZ8hK7xHVSxyjMc3tUpOiK1+AgzL2xPNht+0ABNB50nG11On9IjlkUTJUmJN
fucqRPX3T4MK2kxmlTorNEmfx6eeHQ==
=FDfi
-----END PGP SIGNATURE-----

--Sig_/UB3t=s2L7cXPITcUlOb.IdE--
