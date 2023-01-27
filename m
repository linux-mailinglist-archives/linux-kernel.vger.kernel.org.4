Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7123E67DC8C
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 04:13:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232282AbjA0DNh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 22:13:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjA0DNg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 22:13:36 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 726BB5866E;
        Thu, 26 Jan 2023 19:13:34 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4P32hr13m5z4xGq;
        Fri, 27 Jan 2023 14:13:31 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1674789213;
        bh=xwNZveydTIEeno+MT0Baz/nzmsO7O2OwXo4/Ro079uA=;
        h=Date:From:To:Cc:Subject:From;
        b=Ws0z9uI0CPJy2OxaiQEpkg+8lMVuRQz1ey9QI0+MHhEAi1twDXEe+wN1ks2BfMVhQ
         5mbBcm83MPFsHOO2OSvQlpy7QwxQ9g0t+EASNC/KzM7SbgY8wm7chFk5/hxPy6KUwR
         6JqgNL1kihF902XUHFXhNsCgZ3zA8zlCyhhcvh4bIhXahlgvpfNLHAqbMCVJXtCxBm
         TVDuzYyR3HIn9k1TbAgwW3JMB+o6ZH0TmE/H1jUvarxdhHGyvTIy0YRrCSYpMuDYrJ
         rhFoyoqvbjq2Q0mqhQ1cyxUyGiL+4kN0hd/5J8GuS39laugj9FHKdvRgGp1EpzX8z8
         Fus+r4vctWJXQ==
Date:   Fri, 27 Jan 2023 14:13:30 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Alex Williamson <alex.williamson@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Joerg Roedel <jroedel@suse.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Niklas Schnelle <schnelle@linux.ibm.com>
Subject: linux-next: manual merge of the iommu tree with Linus' tree
Message-ID: <20230127141330.28b2c653@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/pEcXxS3iKVnJ67XBS3dbI4A";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/pEcXxS3iKVnJ67XBS3dbI4A
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the iommu tree got a conflict in:

  drivers/vfio/vfio_iommu_type1.c

between commit:

  895c0747f726 ("vfio/type1: Respect IOMMU reserved regions in vfio_test_do=
main_fgsp()")

from Linus' tree and commit:

  1369459b2e21 ("iommu: Add a gfp parameter to iommu_map()")

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

diff --cc drivers/vfio/vfio_iommu_type1.c
index 2209372f236d,e14f86a8ef52..000000000000
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@@ -1867,22 -1866,15 +1868,22 @@@ static void vfio_test_domain_fgsp(struc
  	if (!pages)
  		return;
 =20
 -	ret =3D iommu_map(domain->domain, 0, page_to_phys(pages), PAGE_SIZE * 2,
 -			IOMMU_READ | IOMMU_WRITE | IOMMU_CACHE, GFP_KERNEL);
 -	if (!ret) {
 -		size_t unmapped =3D iommu_unmap(domain->domain, 0, PAGE_SIZE);
 +	list_for_each_entry(region, regions, list) {
 +		start =3D ALIGN(region->start, PAGE_SIZE * 2);
 +		if (start >=3D region->end || (region->end - start < PAGE_SIZE * 2))
 +			continue;
 =20
 -		if (unmapped =3D=3D PAGE_SIZE)
 -			iommu_unmap(domain->domain, PAGE_SIZE, PAGE_SIZE);
 -		else
 -			domain->fgsp =3D true;
 +		ret =3D iommu_map(domain->domain, start, page_to_phys(pages), PAGE_SIZE=
 * 2,
- 				IOMMU_READ | IOMMU_WRITE | IOMMU_CACHE);
++				IOMMU_READ | IOMMU_WRITE | IOMMU_CACHE, GFP_KERNEL);
 +		if (!ret) {
 +			size_t unmapped =3D iommu_unmap(domain->domain, start, PAGE_SIZE);
 +
 +			if (unmapped =3D=3D PAGE_SIZE)
 +				iommu_unmap(domain->domain, start + PAGE_SIZE, PAGE_SIZE);
 +			else
 +				domain->fgsp =3D true;
 +		}
 +		break;
  	}
 =20
  	__free_pages(pages, order);

--Sig_/pEcXxS3iKVnJ67XBS3dbI4A
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPTQVoACgkQAVBC80lX
0GzpSggAjQ0cijcA0aYrv+5HJroyntZE06pT+zzi2WB/c0q1TMpQE6+dkTCiqxxS
ncBArX1QWKKAE2q9YRWlX70wtW1a4pHqsJ7hy7Cc8m7tqSE5P1vCy/ows5UiTdJ6
LdEOvAkn+0sCqDYPhb+sAae4iJne2o3URApWZ+9qlpKjV/KzTueVXrRuQOVBl8aU
Wh1ye0EOFN7eZ2E4ftvaysVswg9P1eyvU0sWzoHNHKOqrx11RareGyPYzRi7qmfQ
9v3DlLB4J7t7o7bnG83Qpv418nQUI24vuBSIzQPA+zjfIybjEpmCDziyEXsPVKEJ
vTg8tcdCCWqsJ0eMrJBq6ILa+1RWYw==
=RJ+8
-----END PGP SIGNATURE-----

--Sig_/pEcXxS3iKVnJ67XBS3dbI4A--
