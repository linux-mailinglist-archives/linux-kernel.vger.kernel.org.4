Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E653623AB5
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 04:55:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232307AbiKJDzJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 22:55:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbiKJDzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 22:55:07 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD08A21E0A;
        Wed,  9 Nov 2022 19:55:05 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4N77Jl3gF6z4xYD;
        Thu, 10 Nov 2022 14:55:03 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1668052504;
        bh=b7e2IkOP0F0WeZOg5dfnibVWxTSp5I9yLTgZhjI6fDc=;
        h=Date:From:To:Cc:Subject:From;
        b=EyfXceksohI12E8SNw8W2GCpj55Pcj2qQl90Rc/uxPpp1q0CLlmlpXnTauzaN7slg
         obDseUMGJx6RP2QP4oJk1av3TwdtfahDye3by3YpqUTvDwVtHhiEw3GiKahBru5j4v
         S8W+8XUjOzfOgwcO/SU/W2ul4oe1noLyrqJ1MycvL4PcVDLliKLmIwFU80IrE1vh2Y
         JVwgCbr8NbNF5GOKg7L1sH21QcnG2UszLeu2yt9+DGppORCMYCIncltuZ7mWowico2
         r7MyXIkdl4z/UnipelKmwTI064KsIul2tCj2Xo4fXNmC0K1+91HvlKsizD0WEjst0B
         MUDH0pLN3FGvQ==
Date:   Thu, 10 Nov 2022 14:55:01 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the gpio-brgl tree with the arm64 tree
Message-ID: <20221110145501.5fc3ded0@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/N/HVRkWgm7aDdarSZSTKM_5";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/N/HVRkWgm7aDdarSZSTKM_5
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the gpio-brgl tree got a conflict in:

  arch/arm64/Kconfig

between commit:

  3b619e22c460 ("arm64: implement dynamic shadow call stack for Clang")

from the arm64 tree and commit:

  f5a681d23888 ("arm64: Remove CONFIG_ARCH_NR_GPIO")

from the gpio-brgl tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc arch/arm64/Kconfig
index ed9c184ccc6b,a0c36763d954..000000000000
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@@ -2150,27 -2145,6 +2150,15 @@@ config STACKPROTECTOR_PER_TAS
  	def_bool y
  	depends on STACKPROTECTOR && CC_HAVE_STACKPROTECTOR_SYSREG
 =20
- # The GPIO number here must be sorted by descending number. In case of
- # a multiplatform kernel, we just want the highest value required by the
- # selected platforms.
- config ARCH_NR_GPIO
-         int
-         default 2048 if ARCH_APPLE
-         default 0
-         help
-           Maximum number of GPIOs in the system.
-=20
-           If unsure, leave the default value.
-=20
 +config UNWIND_PATCH_PAC_INTO_SCS
 +	bool "Enable shadow call stack dynamically using code patching"
 +	# needs Clang with https://reviews.llvm.org/D111780 incorporated
 +	depends on CC_IS_CLANG && CLANG_VERSION >=3D 150000
 +	depends on ARM64_PTR_AUTH_KERNEL && CC_HAS_BRANCH_PROT_PAC_RET
 +	depends on SHADOW_CALL_STACK
 +	select UNWIND_TABLES
 +	select DYNAMIC_SCS
 +
  endmenu # "Kernel Features"
 =20
  menu "Boot options"

--Sig_/N/HVRkWgm7aDdarSZSTKM_5
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmNsdhUACgkQAVBC80lX
0GwhnAgApPuEUrMCQbb3/3t8odAcacprFjAZOQVYKtn2T6Su1p5Hp5FFEMvLi+Kb
JUu2hHOtF2FaFtE7T4Wk/kgcnJnYy0Gx/a1keVZv0r8SOW3wuTXJHRb5HTj8cno9
GmZ/xdf/vwxMjbLoTqKUc+a+LBsme6k+YZV6p2Y7qrEcbM2nby3TTfF0eIzN8o1H
p/JTjzzyQDFm38njhLPhoN1KHPojvS8g0hD5FYl30qXrhgikO275PvUhivBTtS5G
pAGlfZnZlechQlHeyWf8gTrmO7eD1405M4a3JEt41bdHi7IKkrV7scduB4/g/Hx6
vzW9PIRZbKSrgKxBJ7qZFsMooIfWIQ==
=1Rvx
-----END PGP SIGNATURE-----

--Sig_/N/HVRkWgm7aDdarSZSTKM_5--
