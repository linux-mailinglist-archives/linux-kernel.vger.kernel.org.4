Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46322615B3D
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 04:56:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbiKBD4N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 23:56:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbiKBDzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 23:55:47 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA7CD20F6F;
        Tue,  1 Nov 2022 20:55:43 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4N2Cj62gVwz4xG6;
        Wed,  2 Nov 2022 14:55:38 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1667361338;
        bh=sl4r36z74uNseksdR2xQB6ItGayRMwe+68aobS872bg=;
        h=Date:From:To:Cc:Subject:From;
        b=DiQ6ERBpfmizSE+9N5j0/mys5tuZ6WnP+bH0WuGizDYYQNLfCeFzkfobB54BL++DQ
         R2lPC3+vC56UcMkI8oDaf783XUBJQ5BHeo1w/DFRvGyWgK6v82ejlmT6b7R12tLeGo
         K7YKFnPBGJTURvM8z3PonHbZYgQ/36GfpiDIAwg4FelQTl5ybLbq2OKw+5VSR+nAPL
         cTAfuqRuwpmv+FZkP/fCzjHRnHaorVnOXbWkL0j02aSDoO5jq4jsqL8t7QlUGShUUR
         b9N9G9bzYJ7zXPBGTaIFRLvRo0CLA1TGaDXCXvNW2uXZM0VTYY9Bvmcu/orlS38Y5T
         tQQhm6GULkg1w==
Date:   Wed, 2 Nov 2022 14:55:32 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the mm tree
Message-ID: <20221102145532.1b6e5891@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/pT88DRglJwcKsgFEPHT_M/Y";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/pT88DRglJwcKsgFEPHT_M/Y
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the mm tree, today's linux-next build (arm
multi_v7_defconfig) failed like this:

mm/migrate.c: In function 'unmap_and_move_huge_page':
mm/migrate.c:1315:13: error: implicit declaration of function 'hugetlb_foli=
o_subpool'; did you mean 'hugetlb_page_subpool'? [-Werror=3Dimplicit-functi=
on-declaration]
 1315 |         if (hugetlb_folio_subpool(src) && !folio_mapping(src)) {
      |             ^~~~~~~~~~~~~~~~~~~~~
      |             hugetlb_page_subpool
cc1: some warnings being treated as errors

Caused by commit

  fa7dc4d80445 ("mm/hugetlb: convert move_hugetlb_state() to folios")

This build does *not* have CONFIG_HUGETLB_PAGE set.

I have reverted that commit for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/pT88DRglJwcKsgFEPHT_M/Y
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmNh6jQACgkQAVBC80lX
0GwL/Af+PQqjEx8JanccUpHS4c0USWkOPY2p6hCVh2mjncaAscp4DUb8miUfRRFa
eF1cDMnmTiQgueNkUm7ICos+D3SpZu12Tjg2QLndd8bo+1sDtPW2K0jcZ/8E6bK0
r2qcN6cYfJBscJ12trwS0bhPHQ4utL30Ugn7rQXDcd+MWRdPNFk4DgxLiGwwcujh
hJO4s+/JQXFdWt8h04Zi4Fc9AujRFeK1JhBj0R0pMtXXskDNE/qN+s3g+W9bc2+l
6am1dZe4FuDmfBRlXlMpcCQsEHj7IJL1wQoYQ16Uv5aaocviGWiyhwQQXLoiCUTb
8qv5pRbwKNEPXt7LykJZgmUA2y9H8A==
=csv9
-----END PGP SIGNATURE-----

--Sig_/pT88DRglJwcKsgFEPHT_M/Y--
