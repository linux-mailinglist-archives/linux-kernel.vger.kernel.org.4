Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E5EF7139C6
	for <lists+linux-kernel@lfdr.de>; Sun, 28 May 2023 15:56:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbjE1N4y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 May 2023 09:56:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjE1N4u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 May 2023 09:56:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01C2AF4
        for <linux-kernel@vger.kernel.org>; Sun, 28 May 2023 06:56:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9163B60B09
        for <linux-kernel@vger.kernel.org>; Sun, 28 May 2023 13:56:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51ADFC433D2;
        Sun, 28 May 2023 13:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685282203;
        bh=U3GojuCuoXYfWzcEEea0OZvAAyMV4nTAAdmCAqb/5K4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WiLbmPxIdViLKmIkD5gfoxXwhcWxALd7JUAghhpXkvD4zlhu1pNx5jwUS+Gq/p0Dm
         CsE//CLrdLGOAqaa4U28W3JdG9mv3mZdpK2pPcKCSqLPvcZ8q99UznkrS2mYlsYT7V
         6MrJKjhfgvqAIZa6sIas1YZIEOK7IvAIcGjoMCFcJs86S23c2jCKb54eWZDEn/EJ2K
         C2oocvFibDsnMkKdOM7Ir6+JLJZCDuhGmJkp28zlcZqxEeoueRqa0vchzjrurxeODS
         OKuRqVfZ+pvxf1I5cajtmN2Jfs5BLGJHonC9kY5IXZiEi9kfuubYY0XfXu8uK2ScCd
         jR7ikbC0vD1Rw==
Date:   Sun, 28 May 2023 14:56:38 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Alexandre Ghiti <alex@ghiti.fr>
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andreas Schwab <schwab@linux-m68k.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -fixes] riscv: Fix relocatable kernels with early
 alternatives using -fno-pie
Message-ID: <20230528-uneatable-earpiece-3f8673548863@spud>
References: <20230526154630.289374-1-alexghiti@rivosinc.com>
 <20230526-clergyman-wriggly-accc659a3fad@spud>
 <20230526-rockfish-moody-f6d3e71f9d24@spud>
 <f6522c82-01bd-8a03-579d-a5b294784480@ghiti.fr>
 <20230527-hyperlink-doctrine-ef22cfcb508a@spud>
 <CAHVXubgx3uBEjMLHXTxr0192ZHbSb=qK4NggZyWQTDfgrJt2-g@mail.gmail.com>
 <20230528-darkness-grandly-6cb9e014391d@spud>
 <cf0d2d2a-c407-7b3d-a5ab-ea5c19e7b890@ghiti.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="/v0GigUCXOkKo7H6"
Content-Disposition: inline
In-Reply-To: <cf0d2d2a-c407-7b3d-a5ab-ea5c19e7b890@ghiti.fr>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--/v0GigUCXOkKo7H6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, May 28, 2023 at 03:42:59PM +0200, Alexandre Ghiti wrote:
> Hmmm, it still works for me with both clang and gcc-9.

gcc-9 is a bit of a relic, do you have more recent compilers lying
around? If not, I can try some older compilers at some point.

> You don't have to do that now but is there a way I could get your compiled
> image? With the sha1 used to build it? Sorry, I don't see what happens, I
> need to get my hands dirty in some debug!

What do you mean by "sha1"? It falls with v6.4-rc1 which is a stable
hash, if that's what you're looking for.

Otherwise,
https://github.com/ConchuOD/riscv-env/releases/download/v2022.03/vmlinux.bin
(ignore the release crap haha, too lazy to find a proper hosting
mechanism)

| git show
| commit 3bd124485ed55d8ee6c1ff3532c8f617b24aa6ef (HEAD)
| Author: Alexandre Ghiti <alexghiti@rivosinc.com>
| Date:   Fri May 26 17:46:30 2023 +0200
|=20
|     riscv: Fix relocatable kernels with early alternatives using -fno-pie
|    =20
|     Early alternatives are called with the mmu disabled, and then should =
not
|     access any global symbols through the GOT since it requires relocatio=
ns,
|     relocations that we do before but *virtually*. So only use medany code
|     model for this early code.
|    =20
|     Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
|     Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
|=20
| diff --git a/arch/riscv/errata/Makefile b/arch/riscv/errata/Makefile
| index a1055965fbee..7b2637c8c332 100644
| --- a/arch/riscv/errata/Makefile
| +++ b/arch/riscv/errata/Makefile
| @@ -1,2 +1,6 @@
| +ifdef CONFIG_RELOCATABLE
| +KBUILD_CFLAGS +=3D -fno-pie
| +endif
| +
|  obj-$(CONFIG_ERRATA_SIFIVE) +=3D sifive/
|  obj-$(CONFIG_ERRATA_THEAD) +=3D thead/
| diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
| index fbdccc21418a..153864e4f399 100644
| --- a/arch/riscv/kernel/Makefile
| +++ b/arch/riscv/kernel/Makefile
| @@ -23,6 +23,10 @@ ifdef CONFIG_FTRACE
|  CFLAGS_REMOVE_alternative.o =3D $(CC_FLAGS_FTRACE)
|  CFLAGS_REMOVE_cpufeature.o =3D $(CC_FLAGS_FTRACE)
|  endif
| +ifdef CONFIG_RELOCATABLE
| +CFLAGS_alternative.o +=3D -fno-pie
| +CFLAGS_cpufeature.o +=3D -fno-pie
| +endif
|  ifdef CONFIG_KASAN
|  KASAN_SANITIZE_alternative.o :=3D n
|  KASAN_SANITIZE_cpufeature.o :=3D n


--/v0GigUCXOkKo7H6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZHNdlgAKCRB4tDGHoIJi
0jVpAQCsS3J3dOetH/LmA47QbQsKg8DEoynoHEWFevPQHP5wDQD+PFcSq+flgTvG
uvSeTue8wERrHQty97tsjtLHWFMCPgg=
=GXTx
-----END PGP SIGNATURE-----

--/v0GigUCXOkKo7H6--
