Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB4BF66D523
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 04:48:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235213AbjAQDr7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 22:47:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235121AbjAQDr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 22:47:56 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C701922DC5;
        Mon, 16 Jan 2023 19:47:54 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Nwvx00xGvz4xG5;
        Tue, 17 Jan 2023 14:47:48 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1673927268;
        bh=pdT0tLO8GhTYnyOobd7AHS4rLZhzpys/XxIhDrVwTQE=;
        h=Date:From:To:Cc:Subject:From;
        b=cEF0eu2Lw5aegSx7hGanxUhFFwulU0oLGRKzDX7StCDPirx2Abu/ytDSH084deiY7
         0z/FDrubl8A/sJMWjvQUUlgCAdTrcAzoOKiE8PY3dHCZLToxTdMAOkXNvsVi3kQYa2
         Z7+lGjW01f/8Kvfy3lOv3AQhHhxO6Qxb4iO8z1JGBtr2g6azOGXgZOqgseK6bzFVqP
         CV/C27yiGepyyLOvIuMHs/EhD+MgBM/DYHhse/55OFeSJ38FLztC92pSOp6zCGXTFL
         RF435i6MR6FINTJcMmn8kgsbx8nHJId1zOfw44IdKlanWq8Jd9SDDPrScs/UJrJBLz
         6WmWN7eIklSfg==
Date:   Tue, 17 Jan 2023 14:47:47 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        Linux Crypto List <linux-crypto@vger.kernel.org>
Cc:     Danny Tsen <dtsen@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        PowerPC <linuxppc-dev@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the crypto tree
Message-ID: <20230117144747.37115c52@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/U3=+W9+taE+jWVag5qZssFt";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/U3=+W9+taE+jWVag5qZssFt
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the crypto tree, today's linux-next build (powerpc
pseries_le_defconfig) failed like this:

arch/powerpc/crypto/p10_aes_gcm.o: warning: objtool: .text+0x884: unannotat=
ed intra-function call
arch/powerpc/crypto/aesp8-ppc.o: warning: objtool: aes_p8_set_encrypt_key+0=
x44: unannotated intra-function call
ld: arch/powerpc/crypto/p10_aes_gcm.o: ABI version 1 is not compatible with=
 ABI version 2 output
ld: failed to merge target specific data of file arch/powerpc/crypto/p10_ae=
s_gcm.o

Caused by commit

  ca68a96c37eb ("crypto: p10-aes-gcm - An accelerated AES/GCM stitched impl=
ementation")

I have applied the following hack for today.

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Tue, 17 Jan 2023 14:41:10 +1100
Subject: [PATCH] crypto: p10-aes-gcm - only ABIv1 code has been implemented

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/crypto/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/crypto/Kconfig b/arch/powerpc/crypto/Kconfig
index db7d99383993..36928ad14a6b 100644
--- a/arch/powerpc/crypto/Kconfig
+++ b/arch/powerpc/crypto/Kconfig
@@ -97,6 +97,7 @@ config CRYPTO_AES_PPC_SPE
 config CRYPTO_P10_AES_GCM
 	tristate "Stitched AES/GCM acceleration support on P10+ CPU (PPC)"
 	depends on PPC64
+	depends on PPC64_ELF_ABI_V1
 	select CRYPTO_LIB_AES
 	select CRYPTO_ALGAPI
 	select CRYPTO_AEAD
--=20
2.35.1

--=20
Cheers,
Stephen Rothwell

--Sig_/U3=+W9+taE+jWVag5qZssFt
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPGGmMACgkQAVBC80lX
0GzXFQf+IuQ0OoBK3RJPXB4MBEqFCXGFIsjgycvkBpeMhsPwrlTGzgd+Gk2oNnjn
1VSGXyhT+Qy0mk5iSu7ZHteVWK2oM88re9zAzQoo0FkkNhBDi+6PITfoEjeqAifA
OmVS1AOcz7XOuIVwGs5JosHJ3UGv8kvWiWjJaI6u1WYqpZF2gRfsNu2SnylW4Xs6
8PMa66m4u9QaV3E8lav7d11I0gA88FIk2EE27vbIBboh0pvYY9j/VsEJ09YjplXX
m2EjXwo54fIsP8/6Kunp4cOyd8DKJzwP3RundKYzZDPp5P8UBX9ems5nY7TyfstD
HKhHguDvaYEwFPhNxs1u7LZUIcjpsg==
=rAi6
-----END PGP SIGNATURE-----

--Sig_/U3=+W9+taE+jWVag5qZssFt--
