Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C219643B03
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 02:55:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232548AbiLFBzw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 20:55:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230381AbiLFBzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 20:55:50 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1317817E03;
        Mon,  5 Dec 2022 17:55:49 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NR3R40ht2z4xFy;
        Tue,  6 Dec 2022 12:55:43 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1670291744;
        bh=+kr9K190luLCIYTf2mrVyAk+cbBziqrcU7K/IB9jiJ0=;
        h=Date:From:To:Cc:Subject:From;
        b=tvBWk/RbPq0J71HfYnOxJFYkEZg/+Parb2REp42CCG5B3fIuXpgMNoAPVG+abHR1R
         ONViFihFW27uZtBciSJ7PpeGdyQajMa4AQetD1/A0QBqKj+KQRPf49pJFmg20ycDb3
         PgeX28ISKEnyAUsxSxmvbCF5KUJRg2ahjjwwI497jdRV3SD09xNX2miRD84PMSUocg
         hIHdxX9/7yt/MQ/a2ofpPiV+EIljE2LjfbsRdHhJ7kymFfPYD+jp3BVxzjHmEWT95B
         fXG1vD/ylfWoWiAbRY+2uzqtNOxBTJOQxeMOkeKcDl8f+Zwy+TKPhPLxtPnsBpnmYa
         9WDnKPuXNo2Cg==
Date:   Tue, 6 Dec 2022 12:55:42 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Alex Williamson <alex.williamson@redhat.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Yi Liu <yi.l.liu@intel.com>
Subject: linux-next: manual merge of the iommufd tree with the vfio tree
Message-ID: <20221206125542.52ea97a7@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/aMEmD7DKl0UtDMn_/lkvPb.";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/aMEmD7DKl0UtDMn_/lkvPb.
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the iommufd tree got conflicts in:

  drivers/vfio/Kconfig
  drivers/vfio/Makefile

between commits:

  20601c45a0fa ("vfio: Remove CONFIG_VFIO_SPAPR_EEH")
  e2d55709398e ("vfio: Fold vfio_virqfd.ko into vfio.ko")

from the vfio tree and commits:

  a4d1f91db502 ("vfio-iommufd: Support iommufd for physical VFIO devices")
  e5a9ec7e096a ("vfio: Make vfio_container optionally compiled")
  c2849d718d26 ("vfio: Move vfio group specific code into group.c")

from the iommufd tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/vfio/Kconfig
index 0b8d53f63c7e,286c1663bd75..000000000000
--- a/drivers/vfio/Kconfig
+++ b/drivers/vfio/Kconfig
@@@ -38,6 -46,17 +46,12 @@@ config VFIO_NOIOMM
  	  this mode since there is no IOMMU to provide DMA translation.
 =20
  	  If you don't know what to do here, say N.
+ endif
+=20
 -config VFIO_SPAPR_EEH
 -	tristate
 -	depends on EEH && VFIO_IOMMU_SPAPR_TCE
 -	default VFIO
 -
+ config VFIO_VIRQFD
 -	tristate
++	bool
+ 	select EVENTFD
+ 	default n
 =20
  source "drivers/vfio/pci/Kconfig"
  source "drivers/vfio/platform/Kconfig"
diff --cc drivers/vfio/Makefile
index 0721ed4831c9,3783db7e8082..000000000000
--- a/drivers/vfio/Makefile
+++ b/drivers/vfio/Makefile
@@@ -2,12 -2,17 +2,14 @@@
  obj-$(CONFIG_VFIO) +=3D vfio.o
 =20
  vfio-y +=3D vfio_main.o \
- 	  iova_bitmap.o \
- 	  container.o
+ 	  group.o \
+ 	  iova_bitmap.o
 +vfio-$(CONFIG_VFIO_VIRQFD) +=3D virqfd.o
+ vfio-$(CONFIG_IOMMUFD) +=3D iommufd.o
+ vfio-$(CONFIG_VFIO_CONTAINER) +=3D container.o
 =20
 -obj-$(CONFIG_VFIO_VIRQFD) +=3D vfio_virqfd.o
  obj-$(CONFIG_VFIO_IOMMU_TYPE1) +=3D vfio_iommu_type1.o
  obj-$(CONFIG_VFIO_IOMMU_SPAPR_TCE) +=3D vfio_iommu_spapr_tce.o
 -obj-$(CONFIG_VFIO_SPAPR_EEH) +=3D vfio_spapr_eeh.o
  obj-$(CONFIG_VFIO_PCI) +=3D pci/
  obj-$(CONFIG_VFIO_PLATFORM) +=3D platform/
  obj-$(CONFIG_VFIO_MDEV) +=3D mdev/

--Sig_/aMEmD7DKl0UtDMn_/lkvPb.
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmOOoR4ACgkQAVBC80lX
0GyYAAf/QT53K511Q/L6sbHaIicPx8fBLCfqGweMP+WBoNWSeODAzjTeFcOC0Aau
EdXR1f7twP2qG0O8xSGiKcL78fyg/RiXBQtYaaZAuE043XeTB7ClosXvBxz1ZTij
/tQ5XZ1GwCjMKAI2F4nVBM2yilO0+HJBTwxVPePpc5gFdD+OlMYNPbesMZ5YM1eQ
5BXBM+YlhjQYGJNJI5TFaO/Xe0OtSlL/YKS+3JRkxieHhF/VRtZLCc0L0IceF4lM
Q+FveptrUvpJNI0aSumf9tscr+L7Fgk/YqqgGxmDHFP16SMyiKEEiPMXCaMm5V6x
U5HpmzXfj1tSrB36MvvIX7qWGjV3qQ==
=mJ1+
-----END PGP SIGNATURE-----

--Sig_/aMEmD7DKl0UtDMn_/lkvPb.--
