Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 799B25FE6A9
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 03:42:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbiJNBm0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 21:42:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiJNBmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 21:42:24 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BCB819C05C;
        Thu, 13 Oct 2022 18:42:21 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MpTf40d6qz4wgr;
        Fri, 14 Oct 2022 12:42:20 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1665711740;
        bh=UOqOv9ZXTG50TVbS4bfjEnoDOx+u6Ff5Z3TJqIYC0jM=;
        h=Date:From:To:Cc:Subject:From;
        b=EMIVKjO8LK58j+wxxvgH1hUKrT5GwGFk1uj+JFlahxWZZkD2tN5O1/wSNObWNfcHD
         AOXqMGEMNWM/9bwRNisei+VYUj2TfCOniuAvZAdN0uiVlT/Qca/C2IJVdjvPTAuaG4
         tnXivgttxtNfST1NJkcU26kMNrhk+Dg+bszVLc95ti2Tl/V36W6GkVYKH9BmCrLSVU
         B6tqUW8fXzQmnCL+kMK2c9+EKS4PgVShOpYzyqGHbIUb23J3kQ67+BqOSTuy1NOLtd
         vDBmAQBE4Mm2WUb2dGBx6gY4w5uBXX38O1OCKody0sJPvi4U3TpT9U4GzWEoo32Zs9
         g7hu8G/wvR3qQ==
Date:   Fri, 14 Oct 2022 12:42:17 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the kbuild tree
Message-ID: <20221014124217.20fd0a27@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/sE6JmWz7i8cpoH0y/7G.8Qz";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/sE6JmWz7i8cpoH0y/7G.8Qz
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the kbuild tree, today's linux-next build (i386 defconfig)
failed like this:

In file included from arch/x86/kernel/head_32.S:29:
arch/x86/include/asm/pgtable_32.h:68:5: error: "PTRS_PER_PMD" is not define=
d, evaluates to 0 [-Werror=3Dundef]
   68 | #if PTRS_PER_PMD > 1
      |     ^~~~~~~~~~~~
cc1: all warnings being treated as errors

Exposed by commit

  0a7606a9832a ("kbuild: move -Wundef from KBUILD_CFLAGS to KBUILD_CPPFLAGS=
")

I have no idea what the root cause is. :-(

It is a great pity that this commit was not in linux-next before the
merge window opened. :-(

I have applied the following hack for today.

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Fri, 14 Oct 2022 12:34:34 +1100
Subject: [PATCH] i386: hack for "kbuild: move -Wundef from KBUILD_CFLAGS to=
 KBUILD_CPPFLAGS"

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/x86/include/asm/pgtable_32.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/pgtable_32.h b/arch/x86/include/asm/pgtab=
le_32.h
index 7c9c968a42ef..0f3f186ca140 100644
--- a/arch/x86/include/asm/pgtable_32.h
+++ b/arch/x86/include/asm/pgtable_32.h
@@ -65,7 +65,7 @@ do {						\
  * With PAE paging (PTRS_PER_PMD > 1), we allocate PTRS_PER_PGD =3D=3D 4 p=
ages for
  * the PMD's in addition to the pages required for the last level pagetabl=
es.
  */
-#if PTRS_PER_PMD > 1
+#if defined(PTRS_PER_PMD) && (PTRS_PER_PMD > 1)
 #define PAGE_TABLE_SIZE(pages) (((pages) / PTRS_PER_PMD) + PTRS_PER_PGD)
 #else
 #define PAGE_TABLE_SIZE(pages) ((pages) / PTRS_PER_PGD)
--=20
2.35.1

--=20
Cheers,
Stephen Rothwell

--Sig_/sE6JmWz7i8cpoH0y/7G.8Qz
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmNIvnkACgkQAVBC80lX
0GyZHgf9Efsz4o/W+18mhNjLoXQH22ofjTMOjJMiBdjXo+X1kQhnL/1j9XS/W+8h
SqTLrWHpAhEVinfSX3F2ULzbMgw6qXrWHTYVFGFnQVtRF6C9bmSYsccdLBvgoNUl
ViOCvhRaJ50mqcnN4GhjksgAwq5/K8O4ij3IeyZuVK5BoOrsELL9A4xKe4wKZQpV
llWNR0iSxLX9N7cndAB9aU1MutqAc4TDx4qc+RAujKcY9tnsgpQlssdBzpjQhF+h
kH7QgNme/LMAsmfNOId+ho9+2fj2McMcvXQJtrKxCAfxAUjWqGAIX0GoOKecnngk
qLTl84cLFKZlkEowXRjS1zKrwIah6Q==
=ZcHs
-----END PGP SIGNATURE-----

--Sig_/sE6JmWz7i8cpoH0y/7G.8Qz--
