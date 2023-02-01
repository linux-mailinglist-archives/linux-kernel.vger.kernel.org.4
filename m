Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E93C685C8A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 02:14:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbjBABON (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 20:14:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbjBABOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 20:14:12 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86E042E82A;
        Tue, 31 Jan 2023 17:14:10 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4P63ph0936z4x1h;
        Wed,  1 Feb 2023 12:14:03 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1675214045;
        bh=l5yz/bNmQuAYYaT1/3tibN0/ip45vWqvjdxuM9ny+Uo=;
        h=Date:From:To:Cc:Subject:From;
        b=lb2pP2WR2DRpXzPfoa2upGjBcDoQRQSOx4ILh16xiBs4niA1pWFY8iC+4BUwp5pQV
         DWPtmKYnqlUCm++o8RFDO3jpuWQUV04JCSjGBWssgKL9+CQyM5Gn7VbupE0yMBcvjX
         f6KtvZH4rkfJfE04zd2hOVc3YHwAAMPQzHuTDP5PyVm4d0HF37GHfJ+1z05910LII6
         XZYwHngJfb5dPHjLgmsBX5Ym5eVxTRlTz8sYWbxiVB7bax0Oze6aEgzGm9TObbTXw3
         IedNa1Frf+1tcmLiVc/gIs1ZgVkfB3XqMfMhiEIDYzd4kpsWH/QgnBq63BQdhAkbr+
         3gR+LbOtJ8vEw==
Date:   Wed, 1 Feb 2023 12:14:02 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Joerg Roedel <joro@8bytes.org>, Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Joerg Roedel <jroedel@suse.de>,
        Leon Romanovsky <leon@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Yang Yingliang <yangyingliang@huawei.com>
Subject: linux-next: manual merge of the iommu tree with the rdma-fixes tree
Message-ID: <20230201121402.15715aaa@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/KO+Qn=kJEb1seysFOgdy.XL";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/KO+Qn=kJEb1seysFOgdy.XL
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the iommu tree got a conflict in:

  drivers/infiniband/hw/usnic/usnic_uiom.c

between commit:

  b7e08a5a63a1 ("RDMA/usnic: use iommu_map_atomic() under spin_lock()")

from the rdma-fixes tree and commits:

  1369459b2e21 ("iommu: Add a gfp parameter to iommu_map()")
  4dc6376af596 ("iommu: Remove iommu_map_atomic()")

from the iommu tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/infiniband/hw/usnic/usnic_uiom.c
index a2857accc427,aeeaca65ace9..000000000000
--- a/drivers/infiniband/hw/usnic/usnic_uiom.c
+++ b/drivers/infiniband/hw/usnic/usnic_uiom.c
@@@ -276,8 -276,8 +276,8 @@@ iter_chunk
  				size =3D pa_end - pa_start + PAGE_SIZE;
  				usnic_dbg("va 0x%lx pa %pa size 0x%zx flags 0x%x",
  					va_start, &pa_start, size, flags);
- 				err =3D iommu_map_atomic(pd->domain, va_start,
- 						       pa_start, size, flags);
+ 				err =3D iommu_map(pd->domain, va_start, pa_start,
 -						size, flags, GFP_KERNEL);
++						size, flags, GFP_ATOMIC);
  				if (err) {
  					usnic_err("Failed to map va 0x%lx pa %pa size 0x%zx with err %d\n",
  						va_start, &pa_start, size, err);
@@@ -293,8 -293,8 +293,8 @@@
  				size =3D pa - pa_start + PAGE_SIZE;
  				usnic_dbg("va 0x%lx pa %pa size 0x%zx flags 0x%x\n",
  					va_start, &pa_start, size, flags);
- 				err =3D iommu_map_atomic(pd->domain, va_start,
- 						       pa_start, size, flags);
+ 				err =3D iommu_map(pd->domain, va_start, pa_start,
 -						size, flags, GFP_KERNEL);
++						size, flags, GFP_ATOMIC);
  				if (err) {
  					usnic_err("Failed to map va 0x%lx pa %pa size 0x%zx with err %d\n",
  						va_start, &pa_start, size, err);

--Sig_/KO+Qn=kJEb1seysFOgdy.XL
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPZvNoACgkQAVBC80lX
0GzNbQgAgri4W93O4DcoSY5/rit/owWa6QkmoqG9HgyPQxT41jRGJ7xjDGTkqO+F
z+uLtnxiS/jl58IetK+ZZsNBgftTwz9w7keAMmyTbk979pFcWMV536CMiwOIF4xF
X5anfONdr694jKEJjehg4/v9DGqRW1PbcqKa+UoDs8kbts8kf8tm6W1yd+fMnOS2
PHVTOkiCOVRxnLr/D3fVXTz7WZpdVhK/wOHjuTYAasiOWTS4N/WgQpEGey/vf2QP
lYG+TWcXDva2e5JsamLA+XRIhoLkBDptSAxpgjD/vWbFTxaNYsesYqzSrqCjui4V
k49ttW/hpl2Z97nJPrYe0uwUb+cvKw==
=PaRY
-----END PGP SIGNATURE-----

--Sig_/KO+Qn=kJEb1seysFOgdy.XL--
