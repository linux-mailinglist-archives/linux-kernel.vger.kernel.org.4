Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5FA9623B22
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 06:09:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231571AbiKJFJM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 00:09:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbiKJFJJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 00:09:09 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A132C2B1B8;
        Wed,  9 Nov 2022 21:09:07 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4N78y91rybz4xGT;
        Thu, 10 Nov 2022 16:09:05 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1668056945;
        bh=t1Zs9kyiW0gGCqlM+108NhrzNMiXqtOdDkhiwRDuybI=;
        h=Date:From:To:Cc:Subject:From;
        b=KaFSnpyYTblTDwELjpAvfWZqcnSPqeVZass62HvV24hdbfkEDilIf95Uz2qec3iDo
         fJ9I/W7gQrctebulesjhNppoDh2dZoS+oozowgu2hNHwnlvRZCtpqwxMh/59RtkMU3
         /k5t9Ek/mavhLFVmC9Bu5TBzQyNCdCALkV+Z4YXXFZ9auoi1ZnQFP+1VmVS9edF/CE
         Gz9RmBxInXorCs7XceQSwd3bIDAaqADp9b5KirXEvpdaP2EzmEfKCuTEe1CSmv2YVb
         zsqePCq/Kmj2hsKKifGn9b5l2FovaODp3ObkutgLUc17jFm5ZHGKpgXq3whdYhV0Ng
         oBMGyi9ax+0Jg==
Date:   Thu, 10 Nov 2022 16:09:03 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Ard Biesheuvel <ardb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the efi tree with the arm64 tree
Message-ID: <20221110160903.062515c8@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/dIVKFk9o3ktPdWvxMAXl9y1";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/dIVKFk9o3ktPdWvxMAXl9y1
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the efi tree got a conflict in:

  drivers/firmware/efi/libstub/Makefile

between commit:

  68c76ad4a957 ("arm64: unwind: add asynchronous unwind tables to kernel an=
d modules")

from the arm64 tree and commit:

  0d60ffeec53c ("efi: libstub: Deduplicate ftrace command line argument fil=
tering")

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

diff --cc drivers/firmware/efi/libstub/Makefile
index 1016f0b5311d,402dfb30ddc7..000000000000
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@@ -18,17 -22,14 +22,15 @@@ cflags-$(CONFIG_X86)		+=3D -m$(BITS) -D__
 =20
  # arm64 uses the full KBUILD_CFLAGS so it's necessary to explicitly
  # disable the stackleak plugin
- cflags-$(CONFIG_ARM64)		:=3D $(subst $(CC_FLAGS_FTRACE),,$(KBUILD_CFLAGS)=
) \
- 				   -fpie $(DISABLE_STACKLEAK_PLUGIN) \
+ cflags-$(CONFIG_ARM64)		+=3D -fpie $(DISABLE_STACKLEAK_PLUGIN) \
 +				   -fno-unwind-tables -fno-asynchronous-unwind-tables \
  				   $(call cc-option,-mbranch-protection=3Dnone)
- cflags-$(CONFIG_ARM)		:=3D $(subst $(CC_FLAGS_FTRACE),,$(KBUILD_CFLAGS)) \
- 				   -fno-builtin -fpic \
+ cflags-$(CONFIG_ARM)		+=3D -DEFI_HAVE_STRLEN -DEFI_HAVE_STRNLEN \
+ 				   -DEFI_HAVE_MEMCHR -DEFI_HAVE_STRRCHR \
+ 				   -DEFI_HAVE_STRCMP -fno-builtin -fpic \
  				   $(call cc-option,-mno-single-pic-base)
- cflags-$(CONFIG_RISCV)		:=3D $(subst $(CC_FLAGS_FTRACE),,$(KBUILD_CFLAGS)=
) \
- 				   -fpic
- cflags-$(CONFIG_LOONGARCH)	:=3D $(subst $(CC_FLAGS_FTRACE),,$(KBUILD_CFLA=
GS)) \
- 				   -fpie
+ cflags-$(CONFIG_RISCV)		+=3D -fpic
+ cflags-$(CONFIG_LOONGARCH)	+=3D -fpie
 =20
  cflags-$(CONFIG_EFI_PARAMS_FROM_FDT)	+=3D -I$(srctree)/scripts/dtc/libfdt
 =20

--Sig_/dIVKFk9o3ktPdWvxMAXl9y1
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmNsh28ACgkQAVBC80lX
0GzcMwf+PfmrUtugjgfcTYuNzGiu/KrseZCgDJWS4FGFZad16xb83A2y2sLrgH6o
3pezuaR5+h29eTtqwtblV2Z3tLqN/HxLRm74JWUNvq/sz9YPa2WcFbzva6Yq2TIN
4Hh9AerOcXBIDLgJiVSG1YTtLyJgaSjzoJB3N3o5Kx+2xf/TbV6sj9JxqBS+4hdL
DulEV1IiOWzp8AmCqq4PClJWMrsWhY0GttsdahlO5JIjB5/ruVodFaJ1FmMxqUFi
IZsOrgCx3tA2rQseOOfeTRx/2KWxCpAZDOHcN7Am7njKUhBpp6SNWrrm9yKaih97
je3kOMYlFw8dSXsN0sxEYlC1cZXVyQ==
=i0yt
-----END PGP SIGNATURE-----

--Sig_/dIVKFk9o3ktPdWvxMAXl9y1--
