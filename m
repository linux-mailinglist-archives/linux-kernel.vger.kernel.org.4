Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F024638214
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 02:22:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229495AbiKYBW0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 20:22:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiKYBWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 20:22:24 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D1B615A23;
        Thu, 24 Nov 2022 17:22:23 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NJHCY6zVtz4x1D;
        Fri, 25 Nov 2022 12:22:17 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1669339339;
        bh=saHo3P0BwjjRoCeS8vHqkJcotvhah21HE79XVudW4A8=;
        h=Date:From:To:Cc:Subject:From;
        b=YdXoKpEBEbGG3yYiqxgt0dBcIkIROSq2g2FG/mWZW/2O+I13Cg72in6k7vlGGFiGR
         3sbM2LEoEQSFh/lVIWuAZHNpyVsVlUdkhC66+kEzNKDmjjWT9e3G3xe+v8cSt1ljsx
         Z83Z8sNYVMnQxcIKWWrksc/zf8xSxBp+lTgN7w1t5DSbQhhhodgtn5SMio7Jp+G3KK
         Pn+XwRzz/FmGhHoZNhjpoArfHv02Px2wstdxnk9ncBYpAJ7a4Uzko4gFqbU9OcSY81
         slHSrZgRK82hK/lTqujDACDxY3ehGqhipoFWP3+Aq3iDPDZiB9ltif0rPqLwRfJ0gJ
         /PoMmSaKa7Tfg==
Date:   Fri, 25 Nov 2022 12:22:16 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Ard Biesheuvel <ardb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Borislav Petkov <bp@suse.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the efi tree with the tip tree
Message-ID: <20221125122216.07eae5c6@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/TefiX9Y0xVmb/u4GSqfcIzX";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/TefiX9Y0xVmb/u4GSqfcIzX
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the efi tree got a conflict in:

  arch/x86/boot/compressed/efi_thunk_64.S

between commit:

  cb8bda8ad443 ("x86/boot/compressed: Rename efi_thunk_64.S to efi-mixed.S")

from the tip tree and commit:

  a61962d8e7d3 ("efi: libstub: Permit mixed mode return types other than ef=
i_status_t")

from the efi tree.

I fixed it up (I remofved the file and applied the following patch) and
can carry the fix as necessary. This is now fixed as far as linux-next
is concerned, but any non trivial conflicts should be mentioned to your
upstream maintainer when your tree is submitted for merging.  You may
also want to consider cooperating with the maintainer of the conflicting
tree to minimise any particularly complex conflicts.

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Fri, 25 Nov 2022 12:15:58 +1100
Subject: [PATCH] fix up for "efi: libstub: Permit mixed mode return types o=
ther than efi_status_t"

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/x86/boot/compressed/efi_mixed.S | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/x86/boot/compressed/efi_mixed.S b/arch/x86/boot/compresse=
d/efi_mixed.S
index 8b02e507d3bb..4ca70bf93dc0 100644
--- a/arch/x86/boot/compressed/efi_mixed.S
+++ b/arch/x86/boot/compressed/efi_mixed.S
@@ -132,12 +132,6 @@ SYM_FUNC_START(__efi64_thunk)
 	movl	%ebx, %fs
 	movl	%ebx, %gs
=20
-	/*
-	 * Convert 32-bit status code into 64-bit.
-	 */
-	roll	$1, %eax
-	rorq	$1, %rax
-
 	pop	%rbx
 	pop	%rbp
 	RET
--=20
2.35.1

--=20
Cheers,
Stephen Rothwell

--Sig_/TefiX9Y0xVmb/u4GSqfcIzX
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmOAGMkACgkQAVBC80lX
0GyuTgf+KRC2uYSZ8t9WyLMyCwCsMKqgTGvRRXy+TYQr3EHfUMfcvtZIVHzy6yft
uRiffDEZ6u/GvEsPy+ah2gh2KgTeN1OMS4lZs9sqiF3YdDEELcI+iVWAKox0P5Vn
O6cgIiafxnAdEkRM8G/zJGL5cJTRCZ9IoU5xmmNfE8ru+OEf4432skQpWw+p+J5T
ecOv/Yle8+I+NFHHSJFUsPrWu1E295PFDt3n82Fhk3Br6reXJXvn5aU/CE3u109F
VaA/DX3xr5+jvolbhb5EAHjgNxnFC3B5ZgCozkXluEidQmWwA6xBKGgNQOdE3J4z
J2CU4jH61vbDA7LYGL+pOLay7XZ+oQ==
=/BQW
-----END PGP SIGNATURE-----

--Sig_/TefiX9Y0xVmb/u4GSqfcIzX--
