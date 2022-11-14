Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 116B162752E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 05:11:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235805AbiKNELO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 23:11:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235415AbiKNELK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 23:11:10 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31A92DFC1;
        Sun, 13 Nov 2022 20:11:03 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4N9bTJ1mfbz4xYV;
        Mon, 14 Nov 2022 15:11:00 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1668399062;
        bh=ELRgeMtGATfLN7epm2jF0HOOeRGn2e6ViLNPW7m4kxM=;
        h=Date:From:To:Cc:Subject:From;
        b=aCKo5RR/HrWvWgOaaE4L9S70+JAHH6mQ5cIB/hbo9Q0cA+WJm/HSfc8gpnoIQ5iA+
         asruQgF/wpG8t7xhuVVPdTUaTn6tyX1N/xArRXCg7SF1e+AHcXy5B2TqgmDPRBf7wL
         0zmmYenVJ2WRiptrjO7dZ9yXvbZfyPPW0pLZWJExzOc/BglhZil9oUjwX9UH5EbXdG
         Py9ILcAaGJASESeGVkP7MV0s/xFvIC/10e1PdQ4QtepWKAX1sw84yTy+xLPMqHlcEv
         CBocBjec3qa9nWNaCRYBhRn4Xkic0IA8fcyS0KjGTniZ5fT7PX9DwbqNp0OUr2yB4d
         5jG3GbljTwK8w==
Date:   Mon, 14 Nov 2022 15:10:54 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Joerg Roedel <joro@8bytes.org>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Joerg Roedel <jroedel@suse.de>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: linux-next: manual merge of the tip tree with the iommu tree
Message-ID: <20221114151054.18a48fd9@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/a6RNwPaTJg8HZH972XRHN+J";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/a6RNwPaTJg8HZH972XRHN+J
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the tip tree got a conflict in:

  drivers/iommu/iommu-sva-lib.c

between commit:

  757636ed2607 ("iommu: Rename iommu-sva-lib.{c,h}")

from the iommu tree and commits:

  e79114b17b81 ("iommu/sva: Replace pasid_valid() helper with mm_valid_pasi=
d()")
  53e220bbaa51 ("x86/mm/iommu/sva: Make LAM and SVA mutually exclusive")

from the tip tree.

The file was renamed in the former, so I deleted it and applied the
following merge resolution patch.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Mon, 14 Nov 2022 12:36:45 +1100
Subject: [PATCH] fix up for "iommu: Rename iommu-sva-lib.{c,h}"

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/iommu/iommu-sva.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
index 24bf9b2b58aa..af05dd9f2a6f 100644
--- a/drivers/iommu/iommu-sva.c
+++ b/drivers/iommu/iommu-sva.c
@@ -2,6 +2,8 @@
 /*
  * Helpers for IOMMU drivers implementing SVA
  */
+#include <linux/mm.h>
+#include <linux/mmu_context.h>
 #include <linux/mutex.h>
 #include <linux/sched/mm.h>
 #include <linux/iommu.h>
@@ -32,21 +34,31 @@ int iommu_sva_alloc_pasid(struct mm_struct *mm, ioasid_=
t min, ioasid_t max)
 	    min =3D=3D 0 || max < min)
 		return -EINVAL;
=20
+	/* Serialize against address tagging enabling */
+	if (mmap_write_lock_killable(mm))
+		return -EINTR;
+
+	if (!arch_pgtable_dma_compat(mm)) {
+		mmap_write_unlock(mm);
+		return -EBUSY;
+	}
+
 	mutex_lock(&iommu_sva_lock);
 	/* Is a PASID already associated with this mm? */
-	if (pasid_valid(mm->pasid)) {
+	if (mm_valid_pasid(mm)) {
 		if (mm->pasid < min || mm->pasid >=3D max)
 			ret =3D -EOVERFLOW;
 		goto out;
 	}
=20
 	pasid =3D ioasid_alloc(&iommu_sva_pasid, min, max, mm);
-	if (!pasid_valid(pasid))
+	if (pasid =3D=3D INVALID_IOASID)
 		ret =3D -ENOMEM;
 	else
 		mm_pasid_set(mm, pasid);
 out:
 	mutex_unlock(&iommu_sva_lock);
+	mmap_write_unlock(mm);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(iommu_sva_alloc_pasid);
--=20
2.35.1

--=20
Cheers,
Stephen Rothwell

--Sig_/a6RNwPaTJg8HZH972XRHN+J
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmNxv84ACgkQAVBC80lX
0GxiYggApObytv4qilGY3x7zqtfqmzTTOmT2+WH/CatcrmF53CZi92jxn3SEtzY5
mCAOiu0NHIbX32GsUEUqdtiSklYGeYwMrQAiE0XYMMBB63giyXLb6WVO2rIpOY4W
jBjFZK3m31LqeccUqjnALEcSRHfpkCLqOGDoXnim1OwnWPjR4Ea8CgUxOdFFzTf4
Ft2CVSS8W99C6JXtmj96gAKTFzVv5GTUI0oXkOPlKbIuzWioGE5uCdEJYPRTCfYs
ZZfmnRsY9jj5CCRAj9GmXDGK2+VrN07SoFK/kUjJkrSRott8q+4XR4uZGfShz+j9
ywk979OdlVWrl72e6zH8q4ziuZGZhA==
=Rl10
-----END PGP SIGNATURE-----

--Sig_/a6RNwPaTJg8HZH972XRHN+J--
