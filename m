Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 863CE5B950F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 09:08:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbiIOHIK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 03:08:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiIOHII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 03:08:08 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA35E40E29;
        Thu, 15 Sep 2022 00:08:04 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MSpFD49GHz4x1T;
        Thu, 15 Sep 2022 17:08:00 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1663225680;
        bh=2tY+Yyhd6zapgrI07PnfswA0Gv6Oi8UT9ebEdaEHFjg=;
        h=Date:From:To:Cc:Subject:From;
        b=KSi3F+BkUqdIAtotQcjZbVqOAYsMrerdQq51stbC0wz0Hy/7j8FjSU9YILjPSiiiv
         j+L4XOXfY/qND5Va+j7idarp01y0yMF5QdrL9yfMXshEoHC6j4fLuz1yKonF4FtTLx
         EaZvr3AnVWUXVqXF3cD35Xm8JXpPqdb6qXVPYcn1gDkyiAXgxPu0MAiQb0zzQzdExR
         cLBqAyzw28Tn9qZjmHv1McS5UcPAb00DhtNr6unJ2dhmrNnvg3CN6YM3tG5UrJ8A3E
         zPoV6Lgro8AYsrV5C28wW4dBP56QjxDdOm/d7Gml69rZsiMAACrrCaBnW6iYNNOt1T
         sp3kj9jDFJosA==
Date:   Thu, 15 Sep 2022 17:07:58 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the mm tree
Message-ID: <20220915170758.71068f92@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/XomWJ2eUt6W.gc/e1gPSvGt";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/XomWJ2eUt6W.gc/e1gPSvGt
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the mm tree, today's linux-next build (powerpc
ppc64_defconfig) failed like this:

ld: warning: discarding dynamic section .glink
ld: warning: discarding dynamic section .plt
ld: linkage table error against `hugetlb_vma_lock_release'
ld: stubs don't match calculated size
ld: can not build stubs: bad value
ld: fs/hugetlbfs/inode.o: in function `.remove_inode_hugepages':
inode.c:(.text+0x2538): undefined reference to `.hugetlb_vma_lock_release'
ld: inode.c:(.text+0x25f4): undefined reference to `.hugetlb_vma_lock_relea=
se'

Caused by commits

  d56100904028 ("hugetlb: use new vma_lock for pmd sharing synchronization")
  47bc61e7caf9 ("hugetlb: add vma based lock for pmd sharing")

The definition of hugetlb_vma_lock_release() is guarded by
CONFIG_ARCH_WANT_HUGE_PMD_SHARE, but the usage in fs/hugetlbfs/inode.c
is not.

I have reverted commit d56100904028 (and the following commit) for
today.
--=20
Cheers,
Stephen Rothwell

--Sig_/XomWJ2eUt6W.gc/e1gPSvGt
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmMiz08ACgkQAVBC80lX
0Gw9zgf7BuNat4sGhMU7ate/FPgZIzMpucMo76LE5e/FiI+HNkmTB81Fn9RziUzt
leblGfodaeNLA2Fepn/O4xx3K34K5G02askynu5pOU4MuXvDpaghQUtRiZJTynLJ
a0Nr4A4J4c0MXXLWfQJdl+FfDTmCGIsaDN7FQIAhYo4YhBOzxRC2qRU36/vwsuya
5x3UT3+sImBDwBqmFhOl33aayu+UDh6cLykwFNdX9swF/O0VeJw6D/zsQlWMAfhF
X9FzsIqAYVvBpgw90GcyctHco5WcFQzsEDhV5z+P+/oO7qFA9I/PHdl4Hfub2Kbv
hC9K57Ni/dz/hwt3AaEEo3r2s6nqkQ==
=YLZk
-----END PGP SIGNATURE-----

--Sig_/XomWJ2eUt6W.gc/e1gPSvGt--
