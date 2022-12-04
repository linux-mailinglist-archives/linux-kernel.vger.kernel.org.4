Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA956642098
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 00:49:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230506AbiLDXtE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Dec 2022 18:49:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230500AbiLDXtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Dec 2022 18:49:02 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCB0C12770;
        Sun,  4 Dec 2022 15:49:00 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NQNgG6tqhz4x1V;
        Mon,  5 Dec 2022 10:48:58 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1670197739;
        bh=+vB27jZCm23Y1/9SyViZVWCYwgmEVTcCkiUt2rzz33I=;
        h=Date:From:To:Cc:Subject:From;
        b=piaUmGfItMGzN64D+5zR5NjTZcU7+hDYmB9JvFiblO2UFNj8uDrYdazUxjxg/drnE
         wBhZXzNUgiIQc6OAQSLT7/utmPfdJMXqYASxAR8pMsHI+ORtTQ31BF57gQmt4eAFCC
         eHSjgAlp5H5k4oPAe3o/RWCgLD9CWkGgMLJXJVb5zkbCgJQgiZCa/zOsgdla5btO0d
         I+xed926xeiNM3A6rZ+FshV6lP1mCaKLShJubdOd1EBwo1V8fdrQbXfFUAyCao+x0M
         GWq9Oc60AvdWVoyzNDKnIs3nY16KNyTr4ZWife7aXfrwwbG2X4vGRcE8GXeErEZ2JW
         BTr45ubGdvvaw==
Date:   Mon, 5 Dec 2022 10:48:57 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Linux Crypto List <linux-crypto@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        PowerPC <linuxppc-dev@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the crypto tree
Message-ID: <20221205104857.2dab1586@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/_/H3hxTla0yybYJkUTynFV+";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/_/H3hxTla0yybYJkUTynFV+
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the crypto tree, today's linux-next build (powerpc
ppc64_defconfig) failed like this:

In file included from include/crypto/algapi.h:10,
                 from include/crypto/internal/hash.h:11,
                 from arch/powerpc/crypto/sha1.c:15:
arch/powerpc/include/asm/cache.h:40:9: error: unknown type name 'u32'
   40 |         u32 size;
      |         ^~~
arch/powerpc/include/asm/cache.h:41:9: error: unknown type name 'u32'
   41 |         u32 line_size;
      |         ^~~

(and so on ... lots of errors)

Caused by commit

  e634ac4a8aaa ("crypto: api - Add crypto_tfm_ctx_dma")

It could be (easily) argued that arch/powerpc/include/asm/cache.h should
include linus/types.h, but it is also unusual to include an asm/... file
before all the linux/... files.

Anyway, I applied the following patch for today.

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Mon, 5 Dec 2022 10:42:57 +1100
Subject: [PATCH] fix up for "crypto: api - Add crypto_tfm_ctx_dma"

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 include/crypto/algapi.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/crypto/algapi.h b/include/crypto/algapi.h
index 8722fd67f40a..fced47dbd306 100644
--- a/include/crypto/algapi.h
+++ b/include/crypto/algapi.h
@@ -7,13 +7,13 @@
 #ifndef _CRYPTO_ALGAPI_H
 #define _CRYPTO_ALGAPI_H
=20
-#include <asm/cache.h>
 #include <linux/align.h>
 #include <linux/crypto.h>
 #include <linux/kconfig.h>
 #include <linux/list.h>
 #include <linux/types.h>
=20
+#include <asm/cache.h>
 #include <asm/unaligned.h>
=20
 /*
--=20
2.35.1

--=20
Cheers,
Stephen Rothwell

--Sig_/_/H3hxTla0yybYJkUTynFV+
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmONMekACgkQAVBC80lX
0GzQiAf/akCzR057nPM882K1o9KZYXzPCXyMXYTKvL9m/tI8mTGNePBV284U4ovn
u6Y1ej4dEHvVVleH1kE7PTZKTlKCu42yf4/YK3UGRpePO1pMtG8GipOsL9b8vtZ8
LAQT3Bk1mNhWU1n5K1xAilFzwOfHKiELP/DonAwf58N8VoBQqRG0mZGZmT6SOed5
fINaDgBqOjxdwPmOAxTfktJwcFAxnweUFkIQBJc8kvQbI57rS5J2poTEIKgRDFrx
yzTYQN1nBrm5ZyGz0CkqgWGZnO77cLNv3Eyns+jLBc3SztrPXARInwp3LZzKixXR
gnE3H+oZquAOBGo9SmCSceMfOM+34Q==
=doak
-----END PGP SIGNATURE-----

--Sig_/_/H3hxTla0yybYJkUTynFV+--
