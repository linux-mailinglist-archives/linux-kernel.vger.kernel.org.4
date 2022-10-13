Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0862F5FE508
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 00:12:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbiJMWMt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 18:12:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiJMWMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 18:12:46 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 857C3186D6D;
        Thu, 13 Oct 2022 15:12:43 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MpP033bSXz4wgr;
        Fri, 14 Oct 2022 09:12:35 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1665699158;
        bh=i+mX7jV1B0D9yOrXhGL0NkOVW598hkTqpVEzYb1LcFI=;
        h=Date:From:To:Cc:Subject:From;
        b=oRPcsGo0ebqIjRDcowUiDp+krwMf38lKkNqsgZtHiKWIn369RzIzeEN/rHSL7jmO/
         CX4P18Zshm4th+4UCSf5g3SScA1zELKjpOHMFCRKdEeKbytxTBFv6Id9EGwQdzU7mN
         yjL9WHp63NrZKlMghzuPqPWaGmFf2+Q8838MQQgW0GukP+XUZeR5Vjf3OcgcwgeVWs
         v4lu/63DVgEobZch0VUik1IhUaCpnFVRbakfeegSRGqGWoETI7Nmv5YW5ExZWa84yg
         hGjpP9WRA1ceS4G6lPmLULqobU5pns3MpXPROBUavVrrJ9Ap/qgQUyIcgD3kFhHxgJ
         udsEln8oLznKw==
Date:   Fri, 14 Oct 2022 09:11:46 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul@pwsan.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Palmer Dabbelt <palmer@rivosinc.com>
Subject: linux-next: manual merge of the risc-v tree with Linus' tree
Message-ID: <20221014091146.6e5c71c8@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/bigP7HqE3vsNCRjg5k2J1US";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/bigP7HqE3vsNCRjg5k2J1US
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the risc-v tree got a conflict in:

  arch/riscv/kernel/vdso.c

between commit:

  9b580a1d60de ("riscv: use vma iterator for vdso")

from Linus' tree and commit:

  a8616d2dc193 ("riscv: vdso: fix NULL deference in vdso_join_timens() when=
 vfork")

from the risc-v tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc arch/riscv/kernel/vdso.c
index 692e7ae3dcb8,4abc9aebdfae..000000000000
--- a/arch/riscv/kernel/vdso.c
+++ b/arch/riscv/kernel/vdso.c
@@@ -114,16 -119,18 +119,19 @@@ int vdso_join_timens(struct task_struc
  {
  	struct mm_struct *mm =3D task->mm;
  	struct vm_area_struct *vma;
 +	VMA_ITERATOR(vmi, mm, 0);
- 	struct __vdso_info *vdso_info =3D mm->context.vdso_info;
 =20
  	mmap_read_lock(mm);
 =20
 -	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
 +	for_each_vma(vmi, vma) {
  		unsigned long size =3D vma->vm_end - vma->vm_start;
 =20
- 		if (vma_is_special_mapping(vma, vdso_info->dm))
+ 		if (vma_is_special_mapping(vma, vdso_info.dm))
  			zap_page_range(vma, vma->vm_start, size);
+ #ifdef CONFIG_COMPAT
+ 		if (vma_is_special_mapping(vma, compat_vdso_info.dm))
+ 			zap_page_range(vma, vma->vm_start, size);
+ #endif
  	}
 =20
  	mmap_read_unlock(mm);

--Sig_/bigP7HqE3vsNCRjg5k2J1US
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmNIjSIACgkQAVBC80lX
0Gx7JQf+KtDvhzAjWmIfBHV6S7UDLRSzjxo4fok/FaOs8V75mRF5kOYOH8OGInDp
90otBQTk3orufIEd504B1NoEDVewTsS4BtuIMVUTRMdFxczUF7ag8vJ4x7MbfuV5
8KA6NGmykgDyc7I5LU+VyhcNyldG9D8Zz3DaB08DZ8SiO9Awj53OZCIJdUvyaghi
dBBL8UoufgLefkE8xBNX4WMHLA9Hr/rkrumGKplD9VexrgBKiaLSQSjHaXMN1DAV
7QBNRbTegC7BYZgEPwPYtQHWhd6KOX4MEJsPGHcq6avFXEPZOkp2ZLQQCN2uLV8x
aQGqchr0+hqm7BSrOgZ65Eusen8qLw==
=09CV
-----END PGP SIGNATURE-----

--Sig_/bigP7HqE3vsNCRjg5k2J1US--
