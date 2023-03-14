Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37F846BA27C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 23:30:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231256AbjCNWaR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 18:30:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230135AbjCNWaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 18:30:15 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE93F1EBD6;
        Tue, 14 Mar 2023 15:30:12 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PbpBB68pSz4x5Z;
        Wed, 15 Mar 2023 09:30:10 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1678833011;
        bh=r3NREL+VBQJPkeJMcCS1jossad3z1IHYbb8vXt1/oR4=;
        h=Date:From:To:Cc:Subject:From;
        b=TKCVR8aPVcVYDeFPrY16CoMMyeFbx2Nonec7SZkO4w4n31AmMUH3hTkHjyp8DspWp
         FHsd3yIr/6fnAcA3JljkTMuVq8m/qKqxTyuMau015qMmm0+7hJj8NjAsYqdK6xq0gs
         10mTUhlBdxA+r3P1eB9R+wZN0s3hfELK5ONJnM7JZqVKSKdDn5/+xuqukqA0KFm+qU
         jHeXXo4btWEGUAysI0sTRlzQd88ZenK5ttuShKiXr59Lu74S6oTLLdWt0fxN12NFCb
         R5CwoMwB4dwM4xPArU3uXxq4u96WIfenv26Pr7Y4N1yTjTqfkJAADPoA8O88gT+L/K
         WC0Euvij6yRNw==
Date:   Wed, 15 Mar 2023 09:30:08 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Huacai Chen <chenhuacai@loongson.cn>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     Huacai Chen <chenhuacai@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the loongarch tree with the efi-fixes
 tree
Message-ID: <20230315093008.6b0932a3@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/LR2r0/FhEHPTrFt+viiclqp";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/LR2r0/FhEHPTrFt+viiclqp
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the loongarch tree got conflicts in:

  drivers/firmware/efi/libstub/efi-stub-entry.c
  drivers/firmware/efi/libstub/efi-stub.c

between commit:

  ef3efc2af044 ("efi: libstub: Use relocated version of kernel's struct scr=
een_info")

from the efi-fixes tree and commit:

  d34b13f27dff ("efi/libstub: Call setup_graphics() before handle_kernel_im=
age()")

from the loongarch tree.

I fixed it up (I think, see below) and can carry the fix as necessary.
This is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/firmware/efi/libstub/efi-stub-entry.c
index 629840696ea0,c00a73a4518f..000000000000
--- a/drivers/firmware/efi/libstub/efi-stub-entry.c
+++ b/drivers/firmware/efi/libstub/efi-stub-entry.c
@@@ -5,19 -5,30 +5,43 @@@
 =20
  #include "efistub.h"
 =20
 +#ifndef CONFIG_ARM
 +static struct screen_info *si;
 +
 +struct screen_info *alloc_screen_info(void)
 +{
 +	return si;
 +}
 +
 +void free_screen_info(struct screen_info *si)
 +{
 +}
 +#endif
 +
+ static struct screen_info *setup_graphics(void)
+ {
+ 	unsigned long size;
+ 	efi_status_t status;
+ 	efi_guid_t gop_proto =3D EFI_GRAPHICS_OUTPUT_PROTOCOL_GUID;
+ 	void **gop_handle =3D NULL;
+ 	struct screen_info *si =3D NULL;
+=20
+ 	size =3D 0;
+ 	status =3D efi_bs_call(locate_handle, EFI_LOCATE_BY_PROTOCOL,
+ 			     &gop_proto, NULL, &size, gop_handle);
+ 	if (status =3D=3D EFI_BUFFER_TOO_SMALL) {
+ 		si =3D alloc_screen_info();
+ 		if (!si)
+ 			return NULL;
+ 		status =3D efi_setup_gop(si, &gop_proto, size);
+ 		if (status !=3D EFI_SUCCESS) {
+ 			free_screen_info(si);
+ 			return NULL;
+ 		}
+ 	}
+ 	return si;
+ }
+=20
  /*
   * EFI entry point for the generic EFI stub used by ARM, arm64, RISC-V and
   * LoongArch. This is the entrypoint that is described in the PE/COFF hea=
der
@@@ -69,13 -83,10 +96,15 @@@ efi_status_t __efiapi efi_pe_entry(efi_
  		return status;
  	}
 =20
 +#ifndef CONFIG_ARM
 +	/* point si to the relocated copy of struct screen_info */
 +	si =3D (void *)&screen_info + image_addr - (unsigned long)image->image_b=
ase;
 +#endif
 +
  	status =3D efi_stub_common(handle, image, image_addr, cmdline_ptr);
 =20
+ 	free_screen_info(si);
+=20
  	efi_free(image_size, image_addr);
  	efi_free(reserve_size, reserve_addr);
 =20
diff --cc drivers/firmware/efi/libstub/efi-stub.c
index c4b9eccad0f1,bc67af721412..000000000000
--- a/drivers/firmware/efi/libstub/efi-stub.c
+++ b/drivers/firmware/efi/libstub/efi-stub.c
@@@ -47,30 -47,15 +47,6 @@@
  static u64 virtmap_base =3D EFI_RT_VIRTUAL_BASE;
  static bool flat_va_mapping =3D (EFI_RT_VIRTUAL_OFFSET !=3D 0);
 =20
- static struct screen_info *setup_graphics(void)
 -struct screen_info * __weak alloc_screen_info(void)
--{
- 	efi_guid_t gop_proto =3D EFI_GRAPHICS_OUTPUT_PROTOCOL_GUID;
- 	efi_status_t status;
- 	unsigned long size;
- 	void **gop_handle =3D NULL;
- 	struct screen_info *si =3D NULL;
 -	return &screen_info;
 -}
--
- 	size =3D 0;
- 	status =3D efi_bs_call(locate_handle, EFI_LOCATE_BY_PROTOCOL,
- 			     &gop_proto, NULL, &size, gop_handle);
- 	if (status =3D=3D EFI_BUFFER_TOO_SMALL) {
- 		si =3D alloc_screen_info();
- 		if (!si)
- 			return NULL;
- 		status =3D efi_setup_gop(si, &gop_proto, size);
- 		if (status !=3D EFI_SUCCESS) {
- 			free_screen_info(si);
- 			return NULL;
- 		}
- 	}
- 	return si;
 -void __weak free_screen_info(struct screen_info *si)
 -{
--}
--
  static void install_memreserve_table(void)
  {
  	struct linux_efi_memreserve *rsv;

--Sig_/LR2r0/FhEHPTrFt+viiclqp
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmQQ9XEACgkQAVBC80lX
0GxMJAgAlFXUP8uBQ1Y9JlkBUDF7xo0M3GI2smVQ49FDeDAns1/R8jz3ipkQcYWO
gvPm6EuGKB8auLzgTsp5EJyWU6x/2ANTUP6mrAswTGLVTFfvoiJMtnW8JndHUmGh
WSmT/qkXzDIw+HT/j3jP5ya/MRh9Ju4lRLx5PAZETMGiMLUeaF7U/uCyk5A9kGVe
OF7uP7S5Mi4TjconLlFTf2wHWgqcRDg313gJHflJlaIF0pNn0IUxk/kKBW5kpq7v
E9xDUFBJYk3okcqknyarNDjR9QrAfUbdOJMLRS33EhGDXZNGG7BeVlMksbU2uTR4
PTJ3BHN7Eut8WcFmB9DvZnJMRu0wzA==
=mCm1
-----END PGP SIGNATURE-----

--Sig_/LR2r0/FhEHPTrFt+viiclqp--
