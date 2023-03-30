Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E02166CF8E7
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 03:54:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbjC3ByW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 21:54:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbjC3ByS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 21:54:18 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A36651732;
        Wed, 29 Mar 2023 18:54:14 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Pn60g5nGxz4x91;
        Thu, 30 Mar 2023 12:54:11 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1680141252;
        bh=wsBgS0+7q4Iz1HSFPTFRTmyyDzUExa0HhMIFPwLBehs=;
        h=Date:From:To:Cc:Subject:From;
        b=qV4negvnuoGXhZFJGWjK5khxbVUJ6p5i4XCAfcVtPGwPSQw/5QsmNF+VWHEoO/y8i
         k8nqL3xpf8gVC0D5qp9mCED6WxFNZli3yjGwrLm7WG2Fn0kq7eRFv9ReSyVo2rk58X
         qQAmzjJ2wf0OA88p+CDupblwu1e+Dk6J/WcuIEPfPhMrcXeGFD+zFA4tLwLww/bUsS
         ZOF9wSJdfeXu+b+NPdbpPgVVUk/vQeAIv9n0V41yta+QfOSMn2RWWVfgO0Y1+kDk9F
         w0zsGCRT0E5MzEwO88tXomUt7qNPKnfde0CHZF84wdXqS2pSK0iZ5ep0y96Wq8bZBL
         qhDA7ak7GpUdw==
Date:   Thu, 30 Mar 2023 12:54:08 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Yi Liu <yi.l.liu@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the iommufd tree
Message-ID: <20230330125408.42b444a0@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/1lE8XqAfog1QPAxNGMj2lTY";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/1lE8XqAfog1QPAxNGMj2lTY
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the iommufd tree, today's linux-next build (x86_64
allmodconfig) failed like this:

drivers/iommu/iommufd/hw_pagetable.c: In function 'iommufd_hwpt_alloc':
drivers/iommu/iommufd/hw_pagetable.c:135:33: error: passing argument 1 of '=
iommufd_get_ioas' from incompatible pointer type [-Werror=3Dincompatible-po=
inter-types]
  135 |         ioas =3D iommufd_get_ioas(ucmd, cmd->pt_id);
      |                                 ^~~~
      |                                 |
      |                                 struct iommufd_ucmd *
In file included from drivers/iommu/iommufd/hw_pagetable.c:8:
drivers/iommu/iommufd/iommufd_private.h:216:73: note: expected 'struct iomm=
ufd_ctx *' but argument is of type 'struct iommufd_ucmd *'
  216 | static inline struct iommufd_ioas *iommufd_get_ioas(struct iommufd_=
ctx *ictx,
      |                                                     ~~~~~~~~~~~~~~~=
~~~~~^~~~

Caused by commit

  a7358b11764e ("iommu/iommufd: Pass iommufd_ctx pointer in iommufd_get_ioa=
s()")

interacting with commit

  8295188cc9e6 ("iommufd: Add IOMMU_HWPT_ALLOC")

it should have been fixed up in the merge commit

  085121c1d1bb ("Merge branch 'ko-iommufd/wip/for-nesting' into k.o-iommufd=
/for-next")

I have used the iommufd tree from next-20230329 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/1lE8XqAfog1QPAxNGMj2lTY
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmQk68EACgkQAVBC80lX
0GyoZQf7B+g9RGscwgpoOe1Gv9VYwUYVfcm3H1e7YT0E4p2/TVxlwmCC7742dRbM
KIaoA4dEQKRuJP74mAs9YI3yux4iKFh4mK6AvBjf5iJ1yz0RoLTAFVKWT2CVCs9w
DNbk3a00wUxLmXszhauYznioQqD62OZ1Qgo38qITWDKpO8PxhDe5y+ALYQyz5KO1
9tRyHcUFaw63bT7gwUdGVOryBA9HTJG/mzMPZH3dd95KAFmpe7TMYEuxBgPOYLj5
fQeP05mLvDHPW2eEZgrkjcHgYvi4KObU2F3paSpW2hQbowEmmmJO+o/cbVX7aztA
bMD+wQUHLZfBQ51u6MDiFL4czsXNYg==
=8lZ+
-----END PGP SIGNATURE-----

--Sig_/1lE8XqAfog1QPAxNGMj2lTY--
