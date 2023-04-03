Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B9D46D3C79
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 06:37:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231172AbjDCEhK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 00:37:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjDCEhI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 00:37:08 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E15D53C0E;
        Sun,  2 Apr 2023 21:36:52 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PqdQN3lC8z4x91;
        Mon,  3 Apr 2023 14:36:44 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1680496606;
        bh=IJQEAtvb6RcifhvYk/KHwhovNn/rrlBwmMBtLfYxJcw=;
        h=Date:From:To:Cc:Subject:From;
        b=SeFjMHcyk7zEvPvyRyIkzqrBimq5SIfhDr86bw/q+yirRJzNYHfjE8fUGP5uBxPbC
         WBDcUn73oQgDqwkdFWaLtARPiY/pxr/fScOTd7OxoTWxUPVHDVnfwMFIR1upt2NxJm
         2JKF+hCPT5dgeHwhhwskFTYsTLk2ggmMDLj3d8kCOaOQXneH9/xxqrhPUSmGS1QurB
         IoSveGtm6zM06koEgq9UzQP5sKUdMDncspuL+dyYvRcF+fJc1iusHEGqOXbRt/hbKt
         AegmQE/452RhW2tCIMPBulCcBHLKPLNHhEzwdJs5hlSA83N3eK/n/D10jE2ELojyqf
         vX2JBUE2Xwx4w==
Date:   Mon, 3 Apr 2023 14:36:42 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Joerg Roedel <joro@8bytes.org>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Joerg Roedel <jroedel@suse.de>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the tip tree with the iommu tree
Message-ID: <20230403143642.2aa6fe8e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/T7BP1Yzxsjm7Puk=+N0mbgy";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/T7BP1Yzxsjm7Puk=+N0mbgy
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the tip tree got conflicts in:

  drivers/iommu/iommu-sva.c
  include/linux/sched/mm.h
  include/linux/ioasid.h

between commits:

  cd3891158a77 ("iommu/sva: Move PASID helpers to sva code")
  4e14176ab13f ("iommu/sva: Stop using ioasid_set for SVA")
  1a14bf0fc7ed ("iommu/sva: Use GFP_KERNEL for pasid allocation")

from the iommu tree and commit:

  400b9b93441c ("iommu/sva: Replace pasid_valid() helper with mm_valid_pasi=
d()")

from the tip tree.

I fixed it up (I used the former version of include/linux/sched/mm.h,
removed include/linux/ioasid.h, updated drivers/iommu/iommu-sva.c
as below and applied the following patch) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Mon, 3 Apr 2023 14:32:58 +1000
Subject: [PATCH] fixup for "iommu/sva: Replace pasid_valid() helper with mm=
_valid_pasid()"

interacting with "iommu/sva: Replace pasid_valid() helper with
mm_valid_pasid()" and "iommu: Remove ioasid infrastructure"

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 include/linux/iommu.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 54f535ff9868..0c5d4c3b59cd 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -1172,16 +1172,15 @@ static inline bool tegra_dev_iommu_get_stream_id(st=
ruct device *dev, u32 *stream
 	return false;
 }
=20
-static inline bool pasid_valid(ioasid_t ioasid)
-{
-	return ioasid !=3D IOMMU_PASID_INVALID;
-}
-
 #ifdef CONFIG_IOMMU_SVA
 static inline void mm_pasid_init(struct mm_struct *mm)
 {
 	mm->pasid =3D IOMMU_PASID_INVALID;
 }
+static inline bool mm_valid_pasid(struct mm_struct *mm)
+{
+	return mm->pasid !=3D IOMMU_PASID_INVALID;
+}
 void mm_pasid_drop(struct mm_struct *mm);
 struct iommu_sva *iommu_sva_bind_device(struct device *dev,
 					struct mm_struct *mm);
@@ -1203,6 +1202,7 @@ static inline u32 iommu_sva_get_pasid(struct iommu_sv=
a *handle)
 	return IOMMU_PASID_INVALID;
 }
 static inline void mm_pasid_init(struct mm_struct *mm) {}
+static inline bool mm_valid_pasid(struct mm_struct *mm) { return false; }
 static inline void mm_pasid_drop(struct mm_struct *mm) {}
 #endif /* CONFIG_IOMMU_SVA */
=20
--=20
2.39.2

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/iommu/iommu-sva.c
index c434b95dc8eb,dd76a1a09cf7..000000000000
--- a/drivers/iommu/iommu-sva.c
+++ b/drivers/iommu/iommu-sva.c
@@@ -9,14 -10,26 +10,14 @@@
  #include "iommu-sva.h"
 =20
  static DEFINE_MUTEX(iommu_sva_lock);
 -static DECLARE_IOASID_SET(iommu_sva_pasid);
 +static DEFINE_IDA(iommu_global_pasid_ida);
 =20
 -/**
 - * iommu_sva_alloc_pasid - Allocate a PASID for the mm
 - * @mm: the mm
 - * @min: minimum PASID value (inclusive)
 - * @max: maximum PASID value (inclusive)
 - *
 - * Try to allocate a PASID for this mm, or take a reference to the existi=
ng one
 - * provided it fits within the [@min, @max] range. On success the PASID is
 - * available in mm->pasid and will be available for the lifetime of the m=
m.
 - *
 - * Returns 0 on success and < 0 on error.
 - */
 -int iommu_sva_alloc_pasid(struct mm_struct *mm, ioasid_t min, ioasid_t ma=
x)
 +/* Allocate a PASID for the mm within range (inclusive) */
 +static int iommu_sva_alloc_pasid(struct mm_struct *mm, ioasid_t min, ioas=
id_t max)
  {
  	int ret =3D 0;
 -	ioasid_t pasid;
 =20
- 	if (!pasid_valid(min) || !pasid_valid(max) ||
 -	if (min =3D=3D INVALID_IOASID || max =3D=3D INVALID_IOASID ||
++	if (min =3D=3D IOMMU_PASID_INVALID || max =3D=3D IOMMU_PASID_INVALID ||
  	    min =3D=3D 0 || max < min)
  		return -EINVAL;
 =20
@@@ -205,11 -242,3 +209,11 @@@ out_put_mm
 =20
  	return status;
  }
 +
 +void mm_pasid_drop(struct mm_struct *mm)
 +{
- 	if (likely(!pasid_valid(mm->pasid)))
++	if (likely(!mm_valid_pasid(mm)))
 +		return;
 +
 +	ida_free(&iommu_global_pasid_ida, mm->pasid);
 +}

--Sig_/T7BP1Yzxsjm7Puk=+N0mbgy
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmQqV9sACgkQAVBC80lX
0Gyu8wf/db51Y0aQYuguPZ7TqQMU+P+dz2RPWdrLJXJYWpnY6sz5NCNP9KTIzxYZ
wRrhDWko1gWuMuOk42KNvvmTaoyqbQOc/DuO8mNBslZ1LQLunIibH7YeUVrpKfWz
mGE52sH6efW03RR3+lV0V3gZoSJm/G8+2YOtdxC/eTX/HHUSyzWOa+34/eo+aTkk
d0r3zlJcQr57hz8Hi7cYsCB8y1pHWvtDy+zmGi5H5VaT1+rTK2ZJ6j1fsfUDvUPm
4Gj2+gQnxmIAlGAmJ0FfFWpSXd7JdIxgyUjyHf3KvE3MQkTfS7wnFpr93X4gdwJi
LL3EoUhqWkN6+VnwSxt2ZVwPRhPmZw==
=ge99
-----END PGP SIGNATURE-----

--Sig_/T7BP1Yzxsjm7Puk=+N0mbgy--
