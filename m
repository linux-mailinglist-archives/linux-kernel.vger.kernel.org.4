Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9A5274E2F3
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 03:07:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230472AbjGKBHm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 21:07:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230459AbjGKBHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 21:07:40 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0F961A2;
        Mon, 10 Jul 2023 18:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1689037656;
        bh=bEugtFsBjYWlNrUnI+PYUCIXHBfzwDrWOXSQ3VqJJfM=;
        h=Date:From:To:Cc:Subject:From;
        b=P9taIQQtF2Twj357LNlcb2SK3AMB1nq+FCGW6GSt01hhQaR7lPRwjxUwf6VxtQBJJ
         SJERtdL2Z8UpTNisi4MzIVBPMZKq90ibbW8znniiB6JDU3o7ukbdi1KMldfaY7wjMC
         V4ELipkDtgJ8v4QVRo4WTgt9+OOYdV/6ue/YL5YLiRQFRVBET8pyzBsQ3jOfvM3drc
         yzyJc14Ty4BaaC09AXoWnchemXC+TSr3kf5B5NuLoQ871b1anJHEV9ot4f6mG4Tbi7
         71Dhf71ASioL4atFbsD7EIldjv5B0w137M0Fc2HUIbGtUoyOJFokzwSrA3BHGy3q96
         hRgBipQkOEjig==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4R0N5M65Sjz4whq;
        Tue, 11 Jul 2023 11:07:35 +1000 (AEST)
Date:   Tue, 11 Jul 2023 11:07:34 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Tejun Heo <tj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Domenico Cerasuolo <cerasuolodomenico@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Michal =?UTF-8?B?S291dG7DvQ==?= <mkoutny@suse.com>
Subject: linux-next: manual merge of the cgroup tree with the mm tree
Message-ID: <20230711110734.7009339b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/OdjcXm3YrOaxU=NDyxRACBr";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/OdjcXm3YrOaxU=NDyxRACBr
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the cgroup tree got conflicts in:

  tools/testing/selftests/cgroup/.gitignore
  tools/testing/selftests/cgroup/Makefile

between commit:

  479a748978d2 ("selftests: cgroup: add test_zswap program")

from the mm tree and commit:

  cd3c6f682df4 ("selftests: cgroup: Add cpuset migrations testcase")

from the cgroup tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc tools/testing/selftests/cgroup/.gitignore
index 4d556df4f77b,8443a8d46a1c..000000000000
--- a/tools/testing/selftests/cgroup/.gitignore
+++ b/tools/testing/selftests/cgroup/.gitignore
@@@ -5,5 -5,5 +5,6 @@@ test_freeze
  test_kmem
  test_kill
  test_cpu
+ test_cpuset
 +test_zswap
  wait_inotify
diff --cc tools/testing/selftests/cgroup/Makefile
index 27dbdd7bb4bb,dee0f013c7f4..000000000000
--- a/tools/testing/selftests/cgroup/Makefile
+++ b/tools/testing/selftests/cgroup/Makefile
@@@ -12,7 -12,7 +12,8 @@@ TEST_GEN_PROGS +=3D test_cor
  TEST_GEN_PROGS +=3D test_freezer
  TEST_GEN_PROGS +=3D test_kill
  TEST_GEN_PROGS +=3D test_cpu
+ TEST_GEN_PROGS +=3D test_cpuset
 +TEST_GEN_PROGS +=3D test_zswap
 =20
  LOCAL_HDRS +=3D $(selfdir)/clone3/clone3_selftests.h $(selfdir)/pidfd/pid=
fd.h
 =20
@@@ -24,4 -24,4 +25,5 @@@ $(OUTPUT)/test_core: cgroup_util.
  $(OUTPUT)/test_freezer: cgroup_util.c
  $(OUTPUT)/test_kill: cgroup_util.c
  $(OUTPUT)/test_cpu: cgroup_util.c
+ $(OUTPUT)/test_cpuset: cgroup_util.c
 +$(OUTPUT)/test_zswap: cgroup_util.c

--Sig_/OdjcXm3YrOaxU=NDyxRACBr
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmSsq1YACgkQAVBC80lX
0GyS3Af+IRyDtLhR07zFX/qV3NddyMqWJQVnLbBIUXF0P3lkNurEvErQLgNkx08R
YQnMPhhBSpTPn3ipZ15BCObQcyDpmMUTm2C+WXkuAeUTcqMh3MOCmBrn4nza4QmU
Kgj1bqu2LiflxaXxTmlX4h1t47NYHaJM1yiO+OQfsgx/323xIA/Mo1zBYEFQK3Td
SxWHLF860QpM/dNSwji57lPpZLcoxNbfs6NX5qctkdokVsDv27g3qcFmRc2FdCKt
e4VM23EmRYBUjvX20o81yF5igsfNmbDeULaB9Mv4Gv+YqateAE2NQTHYNFokqVPL
D5NAXqTQOH4C8tmcXHNmJThrt34g+g==
=fAxk
-----END PGP SIGNATURE-----

--Sig_/OdjcXm3YrOaxU=NDyxRACBr--
