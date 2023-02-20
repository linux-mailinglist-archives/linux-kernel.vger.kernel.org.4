Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D5DF69C447
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 03:58:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbjBTC6t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Feb 2023 21:58:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjBTC6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Feb 2023 21:58:48 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BAD3BB8E;
        Sun, 19 Feb 2023 18:58:47 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PKnDj2vsyz4x5Y;
        Mon, 20 Feb 2023 13:58:45 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1676861925;
        bh=q7lP8DrogDLmuyR5YNW/czXfL8KaWmB+HhDmsECEDIk=;
        h=Date:From:To:Cc:Subject:From;
        b=q72TMkRWIVqjzxssT4dRG5GgZkhT676yNPcBctgQHrHejaH8HDhiNimCn6ogXBcZn
         nZj+4mNWHDudAimWy9snvu9NqinKJ/2fLNp2G9WsSVIcWwFonKu+KqomHLfB2gXR3r
         OyOy6cV5Dy21kRaDm5vDZhXzSlDUJ7S/79OX/avRhvhB8KxmOXOaCuKz3JR9ZUHrTK
         /akeHTc9evpv4pxlyXSx4fxvq+E10TadF+W6rHIr1i8Ocab1xdisNohFYwedil6E7L
         uYDR6dOuLr/dMofm4cVpewIArDHL1M0D+0M8CZgkbe3ImsXZC31rV5ZLxeD8/TTMCW
         szUA0zIVWJVBQ==
Date:   Mon, 20 Feb 2023 13:58:44 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Pierre Gondois <pierre.gondois@arm.com>
Subject: linux-next: manual merge of the efi tree with Linus' tree
Message-ID: <20230220135844.73e9dcae@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/cNYlBCqbc_9Zi4hLFVflN2c";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/cNYlBCqbc_9Zi4hLFVflN2c
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the efi tree got a conflict in:

  arch/arm64/include/asm/efi.h

between commit:

  8a9a1a18731e ("arm64: efi: Avoid workqueue to check whether EFI runtime i=
s live")

from Linus' tree and commit:

  0e68b5517d37 ("arm64: efi: Make efi_rt_lock a raw_spinlock")

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

diff --cc arch/arm64/include/asm/efi.h
index acaa39f6381a,1b81dd5554cb..000000000000
--- a/arch/arm64/include/asm/efi.h
+++ b/arch/arm64/include/asm/efi.h
@@@ -47,18 -48,9 +48,18 @@@ int efi_set_mapping_permissions(struct=20
  	efi_virtmap_unload();						\
  })
 =20
- extern spinlock_t efi_rt_lock;
+ extern raw_spinlock_t efi_rt_lock;
 +extern u64 *efi_rt_stack_top;
  efi_status_t __efi_rt_asm_wrapper(void *, const char *, ...);
 =20
 +/*
 + * efi_rt_stack_top[-1] contains the value the stack pointer had before
 + * switching to the EFI runtime stack.
 + */
 +#define current_in_efi()						\
 +	(!preemptible() && efi_rt_stack_top !=3D NULL &&			\
 +	 on_task_stack(current, READ_ONCE(efi_rt_stack_top[-1]), 1))
 +
  #define ARCH_EFI_IRQ_FLAGS_MASK (PSR_D_BIT | PSR_A_BIT | PSR_I_BIT | PSR_=
F_BIT)
 =20
  /*

--Sig_/cNYlBCqbc_9Zi4hLFVflN2c
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPy4eQACgkQAVBC80lX
0GxDZAgAmQMAhjeaOZtoS3wIaCO9sa2C/EqeGcops8N3A/DL+Q7ESeJhDRaDpsSD
C+qdqlnZpSjWrmAg/Rw8iZenzddhOGtdKjvIWz+g5HDFltyC5RdMMYzfie9VWVA5
T897r14pVFsLnq//qyfrVegn0tcUWSu23Yu7NAlqGztR4EyRGz3lQYHnmvOn4tLr
YRF+jGiFpAnod9KDEpWbnDH0RclEAZXic9ePi0rOLUYs4oj9lDgY5YEP2Xw4ri1V
Er1VlWNAy+D1KcbFxJ8OeqT53r5auJXjWCQ1HXDaTeLpRUQGYRsszEjcQYIUXQNu
TohVHNT+e4HSBjKSbH4RcxruALq6GA==
=1XgF
-----END PGP SIGNATURE-----

--Sig_/cNYlBCqbc_9Zi4hLFVflN2c--
