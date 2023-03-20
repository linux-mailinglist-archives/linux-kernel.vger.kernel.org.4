Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F393D6C0979
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 04:49:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbjCTDtS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 23:49:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbjCTDsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 23:48:43 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC62B2310B;
        Sun, 19 Mar 2023 20:47:28 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Pg0zt6lCXz4whr;
        Mon, 20 Mar 2023 14:47:22 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1679284043;
        bh=zhrYKikuNU6HLBemtyFkC/elS6VlZHlEGYMgkDqXPdE=;
        h=Date:From:To:Cc:Subject:From;
        b=ZyxhwK1m8JxWtiD/uVjnXvQAYK+veraiXJMO8Tv7mzrpqDgjlQnq9PDr4tpTGfWvs
         VkuAcSYYsm0Q9nQuldsLtMW4pG6xOPO5y+ouFCN5Ciep+ForViwaHn+P3zC5eIltIu
         TnNpXJjmPSZvpcDSzmuduxr6fQEXfqIFK5XrXQW5fHWW8TjBxLiid7cSDmXVkifk7H
         0STg2z+I3ieky1qvtZP4ydj/JQZRABWhAfUzr9IKxmNYVjZ9LsIe7I1GP/2GfZ2J7Z
         UIPPU96LcCejydwQ1CYvog6K+Z4k5rXNR2Oh+jqB6Rv17Pc9u+588alXjdQ5pBR1qs
         5HGGgA3Nn35rw==
Date:   Mon, 20 Mar 2023 14:47:21 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     David Miller <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>
Subject: linux-next: build warning after merge of the mm tree
Message-ID: <20230320144721.663280c3@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/HRxvvNdxII22gqvB21ViAOG";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/HRxvvNdxII22gqvB21ViAOG
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the mm tree, today's linux-next build (sparc64 defconfig)
produced this warning:

In file included from include/linux/wait.h:11,
                 from include/linux/swait.h:8,
                 from include/linux/completion.h:12,
                 from include/linux/mm_types.h:14,
                 from include/linux/uio.h:10,
                 from include/linux/vmalloc.h:12,
                 from include/asm-generic/io.h:994,
                 from arch/sparc/include/asm/io.h:22,
                 from arch/sparc/vdso/vclock_gettime.c:18:
arch/sparc/include/asm/current.h:18:30: warning: call-clobbered register us=
ed for global register variable
   18 | register struct task_struct *current asm("g4");
      |                              ^~~~~~~

I guess the immediate cause is commit

  4e29dd9708cb ("mm: vmalloc: convert vread() to vread_iter()")

from the mm that included linux/uio.h into include/linux/vmalloc.h.
Though there may be a deeper old cause that may need addressing in the
longer term.

Indeed, this patch (obviously) makes the warning go away (and
presumably speeds up the build ever so slightly :-)).

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Mon, 20 Mar 2023 14:02:18 +1100
Subject: [PATCH] mm: vmalloc: fix sparc64 warning

This fixes this warning from a sparc64 defconfig build:

In file included from /home/sfr/next/next/include/linux/wait.h:11,
                 from /home/sfr/next/next/include/linux/swait.h:8,
                 from /home/sfr/next/next/include/linux/completion.h:12,
                 from /home/sfr/next/next/include/linux/mm_types.h:14,
                 from /home/sfr/next/next/include/linux/uio.h:10,
                 from /home/sfr/next/next/include/linux/vmalloc.h:12,
                 from /home/sfr/next/next/include/asm-generic/io.h:994,
                 from /home/sfr/next/next/arch/sparc/include/asm/io.h:22,
                 from /home/sfr/next/next/arch/sparc/vdso/vclock_gettime.c:=
18:
/home/sfr/next/next/arch/sparc/include/asm/current.h:18:30: warning: call-c=
lobbered register used for global register variable
   18 | register struct task_struct *current asm("g4");
      |                              ^~~~~~~

Fixes: 4e29dd9708cb ("mm: vmalloc: convert vread() to vread_iter()")
Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 include/linux/vmalloc.h | 2 +-
 mm/vmalloc.c            | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
index 6beb2ace6a7a..c187c4d9bc33 100644
--- a/include/linux/vmalloc.h
+++ b/include/linux/vmalloc.h
@@ -9,12 +9,12 @@
 #include <asm/page.h>		/* pgprot_t */
 #include <linux/rbtree.h>
 #include <linux/overflow.h>
-#include <linux/uio.h>
=20
 #include <asm/vmalloc.h>
=20
 struct vm_area_struct;		/* vma defining user mapping in mm_types.h */
 struct notifier_block;		/* in notifier.h */
+struct iov_iter;		/* in uio.h */
=20
 /* bits in flags of vmalloc's vm_struct below */
 #define VM_IOREMAP		0x00000001	/* ioremap() and friends */
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index f19509a6eef4..6e5647937dab 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -40,6 +40,7 @@
 #include <linux/hugetlb.h>
 #include <linux/sched/mm.h>
 #include <linux/rwsem.h>
+#include <linux/uio.h>
 #include <asm/tlbflush.h>
 #include <asm/shmparam.h>
=20
--=20
2.39.2

--=20
Cheers,
Stephen Rothwell

--Sig_/HRxvvNdxII22gqvB21ViAOG
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmQX10kACgkQAVBC80lX
0GxGegf8CxgtfuqS/B0X/fmLUYRCScucym4ByYWw3fXh3REUVyKLmX3LJxTu857M
K8C9LGi+v200LODUKtMVBPeeddJ//vS3uo36DJYMuV3a5krjzKlLPzNmLOWeS+/T
6YIlJdIAhAh5xzgOjCgNJ1ngeK+oqBhKrkNGoUr23qklUsn/g4vNe+tIAwXkLeVC
IsAMvrfZi0XjSVwmPWPnxrPdV14TYquL8AZ2Z6+iGlA/gu1SUIPsRMIlEs7Qoie/
V5wXyKQw/myazUwbhWQGfALtuIWNzFO4uk7Vghkdcp1pCGp4h/AKhp9STRSCWvOZ
OKPqKe2/knR2N4PjBZOfo8OB//zotw==
=JLJ6
-----END PGP SIGNATURE-----

--Sig_/HRxvvNdxII22gqvB21ViAOG--
