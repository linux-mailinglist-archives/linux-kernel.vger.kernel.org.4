Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11F4D72D9C9
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 08:22:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239968AbjFMGVf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 02:21:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240278AbjFMGVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 02:21:24 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 985D3E47;
        Mon, 12 Jun 2023 23:21:22 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QgJNJ3Ywbz4x3y;
        Tue, 13 Jun 2023 16:21:20 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1686637281;
        bh=09oLrHGEmpgpyTpLPSc4jHEwyd/VNs8IHZbmFF1qxD0=;
        h=Date:From:To:Cc:Subject:From;
        b=p257LeXXti8Ytj43puEZXiR0jOqqbg0HzOPzCYhgkkV3Umbssxt9OYv6TIyHfy8sP
         rlbDjbti7oFaeDP7lv5IZugyvCsDKiwrYRo6CWzoFiM/cJkmyfhUL0efoXJHC53Q+5
         WtRuofXTdsvB/FRX8aWjwmKEUx8empsTq6wNg7DoQJ2iqeMoI2vcdiUS5gvDGJnxM7
         DdKqGhm//56jaI/4d++oZ0aHn8qJAgO0YWF7IAyM4Ff835NO2FxseN6yiE7Vp5p0HZ
         AhobZSuNsaYkLYCcPG9cqWFtmzTe658dKg9ncvgD992nkIkg16w2V5BF49DXsqkLGv
         FyE6vTLL9DLxA==
Date:   Tue, 13 Jun 2023 16:21:19 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        PowerPC <linuxppc-dev@lists.ozlabs.org>
Subject: linux-next: build failure after merge of the mm tree
Message-ID: <20230613162119.4a7a7d3c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/IxEZ4RJthVOEGv9b4i2lpKw";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/IxEZ4RJthVOEGv9b4i2lpKw
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the mm tree, today's linux-next build (powerpc
ppc44x_defconfig) failed like this:

In file included from arch/powerpc/include/asm/page.h:247,
                 from arch/powerpc/include/asm/thread_info.h:13,
                 from include/linux/thread_info.h:60,
                 from include/asm-generic/preempt.h:5,
                 from ./arch/powerpc/include/generated/asm/preempt.h:1,
                 from include/linux/preempt.h:78,
                 from include/linux/spinlock.h:56,
                 from include/linux/ipc.h:5,
                 from include/uapi/linux/sem.h:5,
                 from include/linux/sem.h:5,
                 from include/linux/compat.h:14,
                 from arch/powerpc/kernel/asm-offsets.c:12:
arch/powerpc/include/asm/page_32.h:16: warning: "ARCH_DMA_MINALIGN" redefin=
ed
   16 | #define ARCH_DMA_MINALIGN       L1_CACHE_BYTES
      |=20
In file included from include/linux/time.h:5,
                 from include/linux/compat.h:10:
include/linux/cache.h:104: note: this is the location of the previous defin=
ition
  104 | #define ARCH_DMA_MINALIGN __alignof__(unsigned long long)
      |=20

(lots of theses)

Caused by commit

  cc7335787e73 ("mm/slab: decouple ARCH_KMALLOC_MINALIGN from ARCH_DMA_MINA=
LIGN")

I have applied the following hack for today - we need something better.

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Tue, 13 Jun 2023 16:07:16 +1000
Subject: [PATCH] fix up for "mm/slab: decouple ARCH_KMALLOC_MINALIGN from A=
RCH_DMA_MINALIGN"

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/include/asm/cache.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/powerpc/include/asm/cache.h b/arch/powerpc/include/asm/ca=
che.h
index ae0a68a838e8..e9be1396dfd1 100644
--- a/arch/powerpc/include/asm/cache.h
+++ b/arch/powerpc/include/asm/cache.h
@@ -142,5 +142,14 @@ static inline void iccci(void *addr)
 }
=20
 #endif /* !__ASSEMBLY__ */
+
+#ifndef __powerpc64__
+#ifdef CONFIG_NOT_COHERENT_CACHE
+#ifndef ARCH_DMA_MINALIGN
+#define ARCH_DMA_MINALIGN	L1_CACHE_BYTES
+#endif
+#endif
+#endif
+
 #endif /* __KERNEL__ */
 #endif /* _ASM_POWERPC_CACHE_H */
--=20
2.39.2

--=20
Cheers,
Stephen Rothwell

--Sig_/IxEZ4RJthVOEGv9b4i2lpKw
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmSICt8ACgkQAVBC80lX
0Gyh2gf/VSu16R9zpGg+AreGcHAXLfhTsn75srJGOYEEWqZPPHTW9DZUzOz1IavK
bf4fb8hYVMrLMHrDMJyLENSBxgTdflaDLrifPRkZymuWhkIwRChFPz7na1i8LY93
xo1yrKyYQqH1OEz5lJ3Kd3aXqIRH5dnnpT7Y1LxpmSPVPE+rQvg7PStaokJhgpeX
o6Lv3dnNFwCPtse2bB1EugDaZL+tm9Jj7c8srAT/qtJHjtT6U9NvOnAhWDdB9S+B
Xn7SxZBTA2W0ehVqHFdQtYiXoQONYiG8ILx3MIvGzwKN1YoO2XgsmC70uuVCUzUO
s6MVpN2Bz305ZseGeBP1mzdz2YPl6w==
=p8mM
-----END PGP SIGNATURE-----

--Sig_/IxEZ4RJthVOEGv9b4i2lpKw--
