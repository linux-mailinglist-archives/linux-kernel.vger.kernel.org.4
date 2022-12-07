Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E1E0646554
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 00:45:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbiLGXpP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 18:45:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbiLGXpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 18:45:10 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94A0888B64;
        Wed,  7 Dec 2022 15:45:08 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NSDRP6Gwgz4wgr;
        Thu,  8 Dec 2022 10:45:05 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1670456707;
        bh=MTqwpivDHUloOt+tie8jqGHyS0Vza8jO6VUXaymsmqM=;
        h=Date:From:To:Cc:Subject:From;
        b=kMLgvTdkUWAQjlQckGSiyRW61UXC2UT5RxaHcOfpLUZMiBaLgotaiPszH/4t1hXDF
         4UnwSkdpbQ+oMSJtpBYlo/96nJk90oFPdJ6YUIcC0au87vnl4k1x4pEsOiq0JnV08N
         YArkOzXoO6lGjxYb9NTzdKEQOgq3Ci9Um5SSNg7BpmzIOjr8b0eCfYiBrHXjNVtozi
         8Udkx0Atg2xNzAreTYra2ebnEWS8Dm8o4wXdZI9isUUdibCzevuBupc2ZP5vFvrB0U
         zjn53GhRiPxbjDlJlhajxW0j9RnqD7EleH9Hc0gynUV2zts4EYHeqA6YpDBBjTGNC/
         NADg7PIr2Rs3g==
Date:   Thu, 8 Dec 2022 10:45:03 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Joerg Roedel <joro@8bytes.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Joerg Roedel <jroedel@suse.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Thierry Reding <treding@nvidia.com>
Subject: linux-next: manual merge of the iommu tree with the mmc tree
Message-ID: <20221208104503.0ee41406@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/0sb8vr5wSOSGjEYBuP4dL6j";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/0sb8vr5wSOSGjEYBuP4dL6j
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the iommu tree got a conflict in:

  include/linux/iommu.h

between commit:

  493c9b68d1d8 ("iommu/tegra: Add tegra_dev_iommu_get_stream_id() helper")

from the mmc tree and commit:

  be51b1d6bbff ("iommu/sva: Refactoring iommu_sva_bind/unbind_device()")

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

diff --cc include/linux/iommu.h
index 6f53ad74fa0d,68d7d304cdb7..000000000000
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@@ -1103,25 -1143,26 +1147,47 @@@ static inline void iommu_dma_compose_ms
 =20
  #endif	/* CONFIG_IOMMU_DMA */
 =20
 +/*
 + * Newer generations of Tegra SoCs require devices' stream IDs to be dire=
ctly programmed into
 + * some registers. These are always paired with a Tegra SMMU or ARM SMMU,=
 for which the contents
 + * of the struct iommu_fwspec are known. Use this helper to formalize acc=
ess to these internals.
 + */
 +#define TEGRA_STREAM_ID_BYPASS 0x7f
 +
 +static inline bool tegra_dev_iommu_get_stream_id(struct device *dev, u32 =
*stream_id)
 +{
 +#ifdef CONFIG_IOMMU_API
 +	struct iommu_fwspec *fwspec =3D dev_iommu_fwspec_get(dev);
 +
 +	if (fwspec && fwspec->num_ids =3D=3D 1) {
 +		*stream_id =3D fwspec->ids[0] & 0xffff;
 +		return true;
 +	}
 +#endif
 +
 +	return false;
 +}
 +
+ #ifdef CONFIG_IOMMU_SVA
+ struct iommu_sva *iommu_sva_bind_device(struct device *dev,
+ 					struct mm_struct *mm);
+ void iommu_sva_unbind_device(struct iommu_sva *handle);
+ u32 iommu_sva_get_pasid(struct iommu_sva *handle);
+ #else
+ static inline struct iommu_sva *
+ iommu_sva_bind_device(struct device *dev, struct mm_struct *mm)
+ {
+ 	return NULL;
+ }
+=20
+ static inline void iommu_sva_unbind_device(struct iommu_sva *handle)
+ {
+ }
+=20
+ static inline u32 iommu_sva_get_pasid(struct iommu_sva *handle)
+ {
+ 	return IOMMU_PASID_INVALID;
+ }
+ #endif /* CONFIG_IOMMU_SVA */
+=20
  #endif /* __LINUX_IOMMU_H */

--Sig_/0sb8vr5wSOSGjEYBuP4dL6j
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmORJX8ACgkQAVBC80lX
0GwhyAf/a/4RjAEYhZFjVYmqi5aN2GbYGUaEDt+uPdx2Q88oudryeyqWRvTVHv6I
YpEdukXTAKMLNNXm/yse01nYQ2hWdzZRzu4LUxttKxyIJX7ua7aWQss25/OvpYLa
XDPgu8lc4EJ+HLvqQ6Gxi7bz9kkegoZM3rPpBLSfh+gm9q2ls4jMEkojV+m8CAEo
cWmZrFKL8Xr+qvNOh4zHmnP/Of0nUxfDj4wJ6/uRHj3JT75CWzvvRH0Z6B3qtkXy
Br5B6GmE/DXwrSz6PQ06/8/rlsM+hi+pRHYJDOq2V1ShzQV/TFS6WG0h9JnQF6Gt
lbkUwvDGON11JRNRbPUePc85kftvDA==
=BgRg
-----END PGP SIGNATURE-----

--Sig_/0sb8vr5wSOSGjEYBuP4dL6j--
