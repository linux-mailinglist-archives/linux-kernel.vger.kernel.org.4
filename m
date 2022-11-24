Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49DB6637186
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 05:39:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229487AbiKXEjg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 23:39:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiKXEje (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 23:39:34 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0F4CC76A1;
        Wed, 23 Nov 2022 20:39:31 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NHldY5QPsz4x1V;
        Thu, 24 Nov 2022 15:39:29 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1669264769;
        bh=Wkffq8oWHUF8FYHUVrRhoAICuivnqolMGhtPHjsiE/g=;
        h=Date:From:To:Cc:Subject:From;
        b=mwhO++q2wA8pGBEAaHsn7XhcwCNgV3vqi4GZfrLZJIhvQ1bGg0GUMlYG1465r0XQb
         tV2oGoYDXP194sqtQ2wDNNVhw5bz2ZFJl6I3rMtYXLSDO3z/mkcc1CZaOlXe2XaFMr
         dm7sMqHW+vCYRtpkMbzoSwVHhiABHU1Og9VvPJsj8xozOzFfUpQkgbc2XFbxkvxpCU
         iWA4bDmU7xYc6kibEVNdFxjMDzWcBwsIhmVdrew0xdSUWIo4VHgh91lG6glyjrpCVy
         qIYv2sPPFcVeYqVR/TbCYTDvL5ea6LAQkA1nRcIUZP6VlXO7sG/RkxGyTGcI/Tr4rz
         FaguIxGOzx0tQ==
Date:   Thu, 24 Nov 2022 15:39:23 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the slab tree
Message-ID: <20221124153923.58a1a9f4@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Qjwz+U2bJaQS49kdl29__5z";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Qjwz+U2bJaQS49kdl29__5z
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the slab tree, today's linux-next build (powerpc
ppc64_defconfig) failed like this:

mm/slab_common.c: In function 'kmem_dump_obj':
mm/slab_common.c:603:49: error: 'struct kmem_cache' has no member named 'us=
ersize'
  603 |         if (kp.kp_slab_cache && kp.kp_slab_cache->usersize)
      |                                                 ^~
In file included from include/asm-generic/bug.h:22,
                 from arch/powerpc/include/asm/bug.h:159,
                 from include/linux/bug.h:5,
                 from include/linux/thread_info.h:13,
                 from include/asm-generic/preempt.h:5,
                 from ./arch/powerpc/include/generated/asm/preempt.h:1,
                 from include/linux/preempt.h:78,
                 from include/linux/spinlock.h:56,
                 from include/linux/mmzone.h:8,
                 from include/linux/gfp.h:7,
                 from include/linux/slab.h:15,
                 from mm/slab_common.c:7:
mm/slab_common.c:604:53: error: 'struct kmem_cache' has no member named 'us=
ersize'
  604 |                 pr_cont(" size %u", kp.kp_slab_cache->usersize);
      |                                                     ^~
include/linux/printk.h:429:33: note: in definition of macro 'printk_index_w=
rap'
  429 |                 _p_func(_fmt, ##__VA_ARGS__);                      =
     \
      |                                 ^~~~~~~~~~~
include/linux/printk.h:542:9: note: in expansion of macro 'printk'
  542 |         printk(KERN_CONT fmt, ##__VA_ARGS__)
      |         ^~~~~~
mm/slab_common.c:604:17: note: in expansion of macro 'pr_cont'
  604 |                 pr_cont(" size %u", kp.kp_slab_cache->usersize);
      |                 ^~~~~~~

Caused by commit

  3cdb7b6ad16a ("mm, slab: ignore hardened usercopy parameters when disable=
d")

I have used the slab tree from next-20221123 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/Qjwz+U2bJaQS49kdl29__5z
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmN+9XsACgkQAVBC80lX
0GwWXwgAlhcRqLaCbvwwFmyBHozjn/fk4bFDEvvz8cw44mmd1039Qgk7EWZx5qtj
9UDqEOCITkL8EEyjQtkfOkukNFW+qGDBQv0iC7RWMdQGuqZyqpdEMBSMFPgmWiTv
UH1sOz8DX493s6c5VO9/gBLdgdplTaem8yGP450RX8tvfA8mGXj6daAgsoOnFRfc
icM2SCq+cqHrc93f9hpreaAA0Ihi4WCsKJKZB5LqzQsLw/tUpxbOVEH/vFES1GzZ
VYVk2j9sYBzWVkdCg5H8hLXJmgIxpI4WUeS9NhJku8nPbxvFwY62mnpBrKA2xXbk
Suy136xiZJ4kR9Mdt+fIaXe/2NDG0A==
=Vb6i
-----END PGP SIGNATURE-----

--Sig_/Qjwz+U2bJaQS49kdl29__5z--
