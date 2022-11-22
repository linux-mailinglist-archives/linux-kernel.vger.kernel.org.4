Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25B16633582
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 07:53:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232021AbiKVGxa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 01:53:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiKVGx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 01:53:28 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B7AC13FB2;
        Mon, 21 Nov 2022 22:53:26 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NGZj02NXCz4xN4;
        Tue, 22 Nov 2022 17:53:24 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1669100005;
        bh=1D8sZG9GF18vPYMLaUq7bP+I0cCCLAR16At2pGyWKkE=;
        h=Date:From:To:Cc:Subject:From;
        b=YkNp3b76Llz3jxrmvY9dUUZ7psft9nmkRc65hcpcL66wIw0xTnXict2zDUVkBsTw3
         4HIt7SNVK2hDAc9PbpytnjDDAnhe3wbY46INMQjQwJuOxF48M8N6BMS6KRLrrZBZf2
         odq05gxw42p8UdVXduuAUAo7By2nLw38iqdhEX/yCZurE+1oZrHdJ7D9E6dUuOWkeL
         t5CUCfbaWU1UjHYYm36qDFcONuIKobZ5DVHxb/wGzpMPqD811j70bIeT8pQDJElZSQ
         /Fa4itJOE8Iul+7OkxN5Qhm/6Uzje1jCuo8XAXu3zWw/Cz015GzN52jAIVRYVG25I7
         974fUQiUk96eQ==
Date:   Tue, 22 Nov 2022 17:53:23 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Yang Li <yang.lee@linux.alibaba.com>,
        David Hildenbrand <david@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the mm tree
Message-ID: <20221122175323.09ad723e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/v5=e6Az0B98G4P9nzdeLmAk";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/v5=e6Az0B98G4P9nzdeLmAk
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the mm tree, today's linux-next build (x86_64 allmodconfig)
failed like this:

In file included from include/uapi/linux/posix_types.h:5,
                 from include/uapi/linux/types.h:14,
                 from include/linux/types.h:6,
                 from include/linux/kasan-checks.h:5,
                 from include/asm-generic/rwonce.h:26,
                 from ./arch/powerpc/include/generated/asm/rwonce.h:1,
                 from include/linux/compiler.h:247,
                 from include/linux/build_bug.h:5,
                 from include/linux/container_of.h:5,
                 from include/linux/list.h:5,
                 from mm/hugetlb.c:6:
mm/hugetlb.c: In function 'add_hugetlb_page':
include/linux/stddef.h:8:14: warning: passing argument 2 of 'set_page_priva=
te' makes integer from pointer without a cast [-Wint-conversion]
    8 | #define NULL ((void *)0)
      |              ^~~~~~~~~~~
      |              |
      |              void *
mm/hugetlb.c:1533:32: note: in expansion of macro 'NULL'
 1533 |         set_page_private(page, NULL);
      |                                ^~~~
In file included from include/linux/mmzone.h:21,
                 from include/linux/gfp.h:7,
                 from include/linux/mm.h:7,
                 from mm/hugetlb.c:8:
include/linux/mm_types.h:464:70: note: expected 'long unsigned int' but arg=
ument is of type 'void *'
  464 | static inline void set_page_private(struct page *page, unsigned lon=
g private)
      |                                                        ~~~~~~~~~~~~=
~~^~~~~~~

Caused by commit

  1f0d844bcc5b ("mm/hugetlb: stop using 0 as NULL pointer")

set_page_private() have taken an unsigned long as its second argument
since (at least) v5.8-rc1.  The cited bugzilla refers to next-20221121,
but even there:

$ git grep set_page_private next-20221121:include/linux/mm_types.h
next-20221121:include/linux/mm_types.h:static inline void set_page_private(=
struct page *page, unsigned long private)

In fact the bugzilla refers to mm/hugetlb.c line 1531.  In next-20221121
that is:

        folio_change_private(folio, 0);

I have reverted that commit for today.  Please take more care :-(

--=20
Cheers,
Stephen Rothwell

--Sig_/v5=e6Az0B98G4P9nzdeLmAk
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmN8ceMACgkQAVBC80lX
0GyFLggAnxyolZS2cOboEfqh4VR8GOlSBGCA7PhqCweD866lLwrZBRdlGx66V9Fj
ZYGlCTC/DncGHHTmDp485N1J6PQxUuuY+OyrJUGqcbRi1+PEHRTHplgzkCDziY0+
/mmY731b2mPfl5hBF9VN9eZ51MiGRbbqIofXAn4x6dUw/KFTy3WtR2IHxqu9E/gK
yThD4OPiORy4FZPI/TiBtgG8Vne/AmE+26NmsFZUXfEu7KvWVNl8gP5kWBTHeuue
FbJqQzbrNkaI/nEZ3ItfmNmsHpL5T0ZM1aFKcPhjLga7w+cvuGxJjEKe+cHiqcHp
ORQnGfiIrDtv1Ffaixed35WJ9XGT4g==
=nEJr
-----END PGP SIGNATURE-----

--Sig_/v5=e6Az0B98G4P9nzdeLmAk--
