Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B70E16651A5
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 03:19:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235637AbjAKCTg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 21:19:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235245AbjAKCTV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 21:19:21 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03B825FF3;
        Tue, 10 Jan 2023 18:19:19 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NsBFf1md0z4x1R;
        Wed, 11 Jan 2023 13:19:18 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1673403558;
        bh=+4CYT4+gH6Fga+KyiDtZ3QzHc++5C3j4wO1y37rVjIE=;
        h=Date:From:To:Cc:Subject:From;
        b=cVJtZPCljqdlXtHormqLlodkLN98mCHky0sEUE/4rXU1QVHuxEQt02MPCthXsQd8K
         zJmcFTi1NPGkNeQmU4XfOkrpHjyMwx/IYwUVjfkGl21zzLVPUd0ZN0hxo2JkY3BfKE
         CjyGEPZIhe7lPbREIUy8YfTkrUCXrgJaHM3FubvR1E7yFr0egS7l2A/gGUe2cxgIuq
         R9dma09Nojy+xJrcQrigT95IlysUoc9plwTtpVBxtgOfT+RpraMuBMQ6QF8hvu6FpW
         PmVmPFIzTiSdwZzznogKDDyYzKsV4r/qPtfX1fbZkJlVv2/Dti0wCB2/w+uERe9adP
         VdNJ7lpG+PmlQ==
Date:   Wed, 11 Jan 2023 13:19:16 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Dave Jiang <dave.jiang@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the cxl tree with the cxl-fixes tree
Message-ID: <20230111131916.5dccc614@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/uS8Y0B4y3kXkj/+As9q0/0L";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/uS8Y0B4y3kXkj/+As9q0/0L
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the cxl tree got a conflict in:

  drivers/cxl/pci.c

between commit:

  2ec1b17f745b ("cxl: fix cxl_report_and_clear() RAS UE addr mis-assignment=
")

from the cxl-fixes tree and commit:

  4a20bc3e2074 ("cxl/pci: Move tracepoint definitions to drivers/cxl/core/")

from the cxl tree.

I fixed it up (I used this file from the latter and added the following
merge fix patch) and can carry the fix as necessary. This is now fixed
as far as linux-next is concerned, but any non trivial conflicts should
be mentioned to your upstream maintainer when your tree is submitted for
merging.  You may also want to consider cooperating with the maintainer
of the conflicting tree to minimise any particularly complex conflicts.

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Wed, 11 Jan 2023 12:30:07 +1100
Subject: [PATCH] fix up for "cxl: fix cxl_report_and_clear() RAS UE addr mi=
s-assignment"

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/cxl/core/pci.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 1d1492440287..184ead6a2796 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -684,8 +684,11 @@ static bool cxl_report_and_clear(struct cxl_dev_state =
*cxlds)
=20
 	/* If multiple errors, log header points to first error from ctrl reg */
 	if (hweight32(status) > 1) {
-		addr =3D cxlds->regs.ras + CXL_RAS_CAP_CONTROL_OFFSET;
-		fe =3D BIT(FIELD_GET(CXL_RAS_CAP_CONTROL_FE_MASK, readl(addr)));
+		void __iomem *rcc_addr =3D
+			cxlds->regs.ras + CXL_RAS_CAP_CONTROL_OFFSET;
+
+		fe =3D BIT(FIELD_GET(CXL_RAS_CAP_CONTROL_FE_MASK,
+				   readl(rcc_addr)));
 	} else {
 		fe =3D status;
 	}
--=20
2.35.1

--=20
Cheers,
Stephen Rothwell

--Sig_/uS8Y0B4y3kXkj/+As9q0/0L
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmO+HKQACgkQAVBC80lX
0GxlDgf+NezJ8/wcrLzN0TWVtoLwA/1NxYMjLjxnuZ232B9Qln/lRj2f/2LIF0l1
Wcmwtw8gkhDQdOZBbwxiB7MJ1ceF0entpsAJT5qCp4OtXOdrY17i2Mylz3UTNCl2
PyQjLbQBOe1biVKnGM9omsynT59CGpDKJGCBqYE/zp4lnwIqVMpPqbe6nU3m1DAD
rt6yVEyxnGwwSY8SUzI9CCLikdOl/xkdLpKlQ9Ph7RV8rXig9HYq44itSwFA7t4C
ooGNv8E6ulurWLond6IrdQ52lKKq9Bm8NCj/GtBScptsdZZCBpVWgPLJf5NgJ8Mv
3FgwgiK7PIeO/ccuQtcwfLcX3xXbvQ==
=7mzc
-----END PGP SIGNATURE-----

--Sig_/uS8Y0B4y3kXkj/+As9q0/0L--
