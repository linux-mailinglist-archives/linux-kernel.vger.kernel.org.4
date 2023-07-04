Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2A42746786
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 04:23:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbjGDCXx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 22:23:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjGDCXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 22:23:52 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FC3613D;
        Mon,  3 Jul 2023 19:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1688437424;
        bh=MjDf1HuKD5isgjMVPro7kfTdMThGf8HPmRufpQJgWIc=;
        h=Date:From:To:Cc:Subject:From;
        b=vI8cr7ayU4erZZJYXTxlFlg6ciUfA1ZSENoSsikvgmlpJ/jvUiNdswEHb+uOE1pMP
         bR9M0748FqVSNDIDZfIqGuuaWto/t9h6vpXwKOf04JLvFNwvAVYgymy4DXpX/JkFdk
         77c8ZubEZJjHe6p7T6u4KgXwkKwIR7dTrDneE/85+m88qWf4/+ceynADKhwiU3yDZ5
         8JSi49ETOR1nrm/OfqSU1+JNKkHSLvu1KxOt0vTTtngg26tA5m1G4pWpucPfQzDU1w
         NGJNOwpkpZSQixLmRALj7wzsPxYPqwYRW7aBtJbe8Vbw9tOotLZmlZcl99/FWOZ5KW
         TETc+QFrV2frQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Qw66S4BWqz4wZw;
        Tue,  4 Jul 2023 12:23:44 +1000 (AEST)
Date:   Tue, 4 Jul 2023 12:23:42 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Suren Baghdasaryan <surenb@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the mm  tree
Message-ID: <20230704122342.4a1e2945@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/mKZ=U5fh_qVW6EVEdIbCAG=";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/mKZ=U5fh_qVW6EVEdIbCAG=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the origin tree, today's linux-next build (arm64 defconfig)
failed like this:

arch/arm64/mm/fault.c: In function 'do_page_fault':
arch/arm64/mm/fault.c:624:9: error: 'vma' undeclared (first use in this fun=
ction); did you mean 'vmap'?
  624 |         vma =3D lock_mm_and_find_vma(mm, addr, regs);
      |         ^~~:
      |         vmap

Caused by commit

  ae870a68b5d1 ("arm64/mm: Convert to using lock_mm_and_find_vma()")

interacting with commit

  1e72a0774792 ("mm: disable CONFIG_PER_VMA_LOCK by default until its fixed=
")

from the mm tree.

I applied the following for today (but have no idea if it is correct).

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Tue, 4 Jul 2023 12:14:37 +1000
Subject: [PATCH] fix up for "arm64/mm: Convert to using lock_mm_and_find_vm=
a()"

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/arm64/mm/fault.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 9d78ff78b0e3..b8c80f7b8a5f 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -536,9 +536,7 @@ static int __kprobes do_page_fault(unsigned long far, u=
nsigned long esr,
 	unsigned long vm_flags;
 	unsigned int mm_flags =3D FAULT_FLAG_DEFAULT;
 	unsigned long addr =3D untagged_addr(far);
-#ifdef CONFIG_PER_VMA_LOCK
 	struct vm_area_struct *vma;
-#endif
=20
 	if (kprobe_page_fault(regs, esr))
 		return 0;
--=20
2.39.2

--=20
Cheers,
Stephen Rothwell

--Sig_/mKZ=U5fh_qVW6EVEdIbCAG=
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEyBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmSjgq4ACgkQAVBC80lX
0Gw0qgf4usc2SIx+CPeeegNFMMTBj1qomTeCLecHbzx8lbmEgwrSnjDl+4U00W1k
WUeeaO2q6gqhHDKObNz26Ns/jFSgr3jD2vRWYmusiXgwxocqGsjvfuTKirLSqooj
boYgiR6tLg9WPSvP/PcHvppGKl/o4+TzaC0AC4Ggybjlgi/651ipxhSG+b1K7HZQ
brzaF60IRV5jCUpyE8TYVz2VDB2mRwYx7jw3ecSvlBVxnqxhbhSMG9ffsh8NCu5K
nzVjCgqY8vAIr0PBzvGHDhzq9RLB0I72bKvY9/LIlLMQhYi1sHFFdLTkPTJG5DSx
NgVKG3JQ+UTgnbqrjiCX4xOPgwUU
=t04A
-----END PGP SIGNATURE-----

--Sig_/mKZ=U5fh_qVW6EVEdIbCAG=--
