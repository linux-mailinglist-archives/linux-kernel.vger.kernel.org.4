Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0FFE7251F4
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 04:08:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240569AbjFGCIa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 22:08:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240671AbjFGCI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 22:08:27 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30B9E19AB;
        Tue,  6 Jun 2023 19:08:25 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QbW3469GWz4x3g;
        Wed,  7 Jun 2023 12:08:16 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1686103698;
        bh=/YH5S+2AJFFJq1Hrsg9tO/GOXSqnBHuWYm5WM+dRDo8=;
        h=Date:From:To:Cc:Subject:From;
        b=Dds5m81zIBe8t49fDwqXx9JPjUyrv5mDCmHvUHgOtZz6dE+RDO7hHqxqPHKJwj+8s
         jJ7jaP+c9WbMaHyhWHxXk+Ino8uzM1HRgjy2nnshk8wa1SwomueoHwBM4ROrfjSR7e
         RDTms7AoWTfc8LFcLwOf56AOUJbuB7mkeJCO/p9bXuJ4rn1OHnoRBiIKTO8v1jvDZs
         bT02NdxpQHu5+qukPXyXdBPQUKWVwvNTFKKxF4aq6Yum/ol6bePQ20xd99UsuNLLzw
         Wjym38qKmAVPZWAcyjwbVs2Lda8pUFI/5zBXsY3nNS5RknZpPh3nA2d0Y8IUldgPTn
         4QsuIWhvzsHqQ==
Date:   Wed, 7 Jun 2023 12:08:15 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Ard Biesheuvel <ardb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     "Borislav Petkov (AMD)" <bp@alien8.de>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Masahisa Kojima <masahisa.kojima@linaro.org>
Subject: linux-next: manual merge of the efi tree with the tip tree
Message-ID: <20230607120815.7b569f57@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/mqQlo5pyFjbuTK6uDLYjqlW";
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

--Sig_/mqQlo5pyFjbuTK6uDLYjqlW
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the efi tree got a conflict in:

  drivers/firmware/efi/Makefile

between commit:

  2053bc57f367 ("efi: Add unaccepted memory support")

from the tip tree and commit:

  39c90699b330 ("efi: Add tee-based EFI variable driver")

from the efi tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/firmware/efi/Makefile
index e489fefd23da,2ca8ee6ab490..000000000000
--- a/drivers/firmware/efi/Makefile
+++ b/drivers/firmware/efi/Makefile
@@@ -41,4 -41,4 +41,5 @@@ obj-$(CONFIG_EFI_CAPSULE_LOADER)	+=3D cap
  obj-$(CONFIG_EFI_EARLYCON)		+=3D earlycon.o
  obj-$(CONFIG_UEFI_CPER_ARM)		+=3D cper-arm.o
  obj-$(CONFIG_UEFI_CPER_X86)		+=3D cper-x86.o
 +obj-$(CONFIG_UNACCEPTED_MEMORY)		+=3D unaccepted_memory.o
+ obj-$(CONFIG_TEE_STMM_EFI)		+=3D stmm/tee_stmm_efi.o

--Sig_/mqQlo5pyFjbuTK6uDLYjqlW
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmR/5o8ACgkQAVBC80lX
0Gy9jAf/WJzSWMXkN+9l5ME69MDMs3usoTPWZyzcSqAAT/65auwmh+BMUR7bC8CB
7zRyHffYQicJmO79huNMnWE0UjPqzXl53KvIgBjMRLhk/g5PeUnwEnL44vOA8Jk9
V+9ERmAU8uXMxd1W7/Wrep2ejn8OBjOsG1g9bdx09ryzdYjCwaH6Tlu35sM/rzfJ
RxJv5mUnwy0CTjyokxdBtfX/HbWljSuMKBnFXA/4fGt8GggG3OobazBgQV84Frml
oxOkAy2cpDY60esTvxE2Zo7uJB/qOSN3qCLzBy++FVA2yyja/RXcHY20G/DHSIyU
M6MBpxofFzI48NtspW2mq/igvZQfjg==
=OR90
-----END PGP SIGNATURE-----

--Sig_/mqQlo5pyFjbuTK6uDLYjqlW--
