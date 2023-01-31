Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5405683674
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 20:25:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231482AbjAaTZF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 14:25:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230324AbjAaTZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 14:25:01 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C12A91C31A;
        Tue, 31 Jan 2023 11:25:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 54277616C2;
        Tue, 31 Jan 2023 19:25:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCDE9C433D2;
        Tue, 31 Jan 2023 19:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675193099;
        bh=Usq/qChe2TB94lautIipeNYeRg/tKGhE2z4UOGHJcX0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XKgqHeEnxvJYKo4a0AOCwbNQJqX/0a+666YQLKyzsHnSruZvclUbmL92Lj3V8dy9y
         wNCZN84wYg8RzExJ948+qiqzp2fAPFJzGxxDEDPpIVIGQQTPqx2KDRWWHdJr+nonDE
         Z7QGiBEzetzq5mbRpNUVKPFGf0vnNMswwqmsufvg7bWrEpbu0Dc1CSfMuUcoBdzU4a
         uuRBMZgshu9LNKl0mG2ozX+2gGt35kVJCrbLn70bnZl+D667D48ZuZf/fPBvCi6bb4
         UCTr5b0c1Xq2ILDxuq6HGKPLLFSoFXf3ZPt+5Sx+0RSgK531DaRxoeeImSpSHP+wwe
         CKRv9fnl5QppA==
Date:   Tue, 31 Jan 2023 19:24:55 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Alexandre Ghiti <alexghiti@rivosinc.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Ard Biesheuvel <ardb@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v4 0/1] riscv: Allow to downgrade paging mode from the
 command line
Message-ID: <Y9lrB+RUBk1Njhaq@spud>
References: <20230131151115.1972740-1-alexghiti@rivosinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="caGKd7o6+JAz/98x"
Content-Disposition: inline
In-Reply-To: <20230131151115.1972740-1-alexghiti@rivosinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--caGKd7o6+JAz/98x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Alex,

On Tue, Jan 31, 2023 at 04:11:14PM +0100, Alexandre Ghiti wrote:
> This new version gets rid of the limitation that prevented KASAN kernels
> to use the newly introduced parameters.

What's the base commit for this version?
Fails to apply for me on top of for-next, fixes, rc1, and linux-next :/
I also tried it on top of your KASAN series, but no luck there either!

Thanks,
Conor.

> While looking into KASLR, I fell onto commit aacd149b6238 ("arm64: head:
> avoid relocating the kernel twice for KASLR"): it allows to use the fdt
> functions very early in the boot process with KASAN enabled by simply
> compiling a new version of those functions without instrumentation.
>=20
> I had to change the handling of the command line parsing to make the
> code self-contained in kernel/pi/cmd_early.c to avoid calling too many
> __pi prefixed functions from outside this file.
>=20
> I'll use this approach like arm64 to handle the extraction of the random
> seedi from the device tree for KASLR.
>=20
> @Ard: I copied the "pi" name but I have to admit I don't know what it
> means.
>=20
> Alexandre Ghiti (1):
>   riscv: Allow to downgrade paging mode from the command line
>=20
>  .../admin-guide/kernel-parameters.txt         |  5 +-
>  arch/riscv/kernel/Makefile                    |  2 +
>  arch/riscv/kernel/pi/Makefile                 | 34 ++++++++++++
>  arch/riscv/kernel/pi/cmdline_early.c          | 52 +++++++++++++++++++
>  arch/riscv/lib/memcpy.S                       |  2 +
>  arch/riscv/lib/memmove.S                      |  2 +
>  arch/riscv/mm/init.c                          | 36 ++++++++++---
>  7 files changed, 126 insertions(+), 7 deletions(-)
>  create mode 100644 arch/riscv/kernel/pi/Makefile
>  create mode 100644 arch/riscv/kernel/pi/cmdline_early.c
>=20
> --=20
> 2.37.2
>=20

--caGKd7o6+JAz/98x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY9lrBwAKCRB4tDGHoIJi
0gfGAQCENcv+3hKs/6TXI0FLA0kreZMihuI32sRzt84sGUGHIQEA/uU1ZjoXVe2E
ZyLE2YYl1Osh/cmRboDUYwy3r6oGNQE=
=/x1y
-----END PGP SIGNATURE-----

--caGKd7o6+JAz/98x--
