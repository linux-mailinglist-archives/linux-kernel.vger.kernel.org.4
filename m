Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CAD0718EA1
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 00:37:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230416AbjEaWh3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 18:37:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbjEaWh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 18:37:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6108E9F;
        Wed, 31 May 2023 15:37:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EB7EA62B7A;
        Wed, 31 May 2023 22:37:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67BCAC433D2;
        Wed, 31 May 2023 22:37:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685572646;
        bh=EjcnHeLPSFskAfrECWzs0sBFgzC+oBoE4wsOMlpomy0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=edK7cDRjdx4uas4edYdeXU/b0jIuH8g7/WAZNO5DSDCcS0YaLilbgVUxIipuqn5Sp
         lCrLS+s9ffLTuvceyREmandUiBzww2Vm0FYVd7oH4zVCgA7VgWyC4/aQm8/ZjNTSUf
         b8dbYVPA/tpNUEHbYxINyxen0NE2uVgFjLwJopgxn2aGeJWfo+BwbqMuk5GklRaie4
         BgZ3XO7jaS1yOCF3xtfHmqCN16wqOGz3/Y6/nx8TG/JM4IQehwiYUwDsrRH1KQ19w1
         kYhSF0XubTIbUD/FtSIs0J51Ts29QRj156kFbUdfPrTl9s1jRsrnK2pZBGThy4VlGW
         BHubXoEh2en9g==
Date:   Wed, 31 May 2023 23:37:20 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        Joan Bruguera =?iso-8859-1?Q?Mic=F3?= <joanbrugueram@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Alyssa Ross <hi@alyssa.is>,
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] riscv/purgatory: Do not use fortified string functions
Message-ID: <20230531-abruptly-settling-f9852f408dcd@spud>
References: <20230531003404.never.167-kees@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ZFT5h/br0IBkD5vu"
Content-Disposition: inline
In-Reply-To: <20230531003404.never.167-kees@kernel.org>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ZFT5h/br0IBkD5vu
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Kees,

On Tue, May 30, 2023 at 05:34:04PM -0700, Kees Cook wrote:
> With the addition of -fstrict-flex-arrays=3D3, struct sha256_state's
> trailing array is no longer ignored by CONFIG_FORTIFY_SOURCE:
>=20
> struct sha256_state {
>         u32 state[SHA256_DIGEST_SIZE / 4];
>         u64 count;
>         u8 buf[SHA256_BLOCK_SIZE];
> };
>=20
> This means that the memcpy() calls with "buf" as a destination in
> sha256.c's code will attempt to perform run-time bounds checking, which
> could lead to calling missing functions, specifically a potential
> WARN_ONCE, which isn't callable from purgatory.
>=20
> Reported-by: Thorsten Leemhuis <linux@leemhuis.info>
> Closes: https://lore.kernel.org/lkml/175578ec-9dec-7a9c-8d3a-43f24ff86b92=
@leemhuis.info/
> Bisected-by: "Joan Bruguera Mic=F3" <joanbrugueram@gmail.com>
> Fixes: df8fc4e934c1 ("kbuild: Enable -fstrict-flex-arrays=3D3")
> Cc: Paul Walmsley <paul.walmsley@sifive.com>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: Albert Ou <aou@eecs.berkeley.edu>
> Cc: Masahiro Yamada <masahiroy@kernel.org>
> Cc: Conor Dooley <conor.dooley@microchip.com>
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Cc: Alyssa Ross <hi@alyssa.is>
> Cc: Heiko Stuebner <heiko.stuebner@vrull.eu>
> Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> Cc: linux-riscv@lists.infradead.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Perhaps this is indicative of other issues in RISC-V land, but
allmodconfig complains about this patch:

=2E./lib/string.c:17: warning: "__NO_FORTIFY" redefined
=2E./lib/string.c:17:9: warning: preprocessor token __NO_FORTIFY redefined

> ---
>  arch/riscv/purgatory/Makefile | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/arch/riscv/purgatory/Makefile b/arch/riscv/purgatory/Makefile
> index 5730797a6b40..11f4c275f141 100644
> --- a/arch/riscv/purgatory/Makefile
> +++ b/arch/riscv/purgatory/Makefile
> @@ -31,9 +31,9 @@ $(obj)/strncmp.o: $(srctree)/arch/riscv/lib/strncmp.S F=
ORCE
>  $(obj)/sha256.o: $(srctree)/lib/crypto/sha256.c FORCE
>  	$(call if_changed_rule,cc_o_c)
> =20
> -CFLAGS_sha256.o :=3D -D__DISABLE_EXPORTS
> -CFLAGS_string.o :=3D -D__DISABLE_EXPORTS
> -CFLAGS_ctype.o :=3D -D__DISABLE_EXPORTS
> +CFLAGS_sha256.o :=3D -D__DISABLE_EXPORTS -D__NO_FORTIFY
> +CFLAGS_string.o :=3D -D__DISABLE_EXPORTS -D__NO_FORTIFY
> +CFLAGS_ctype.o :=3D -D__DISABLE_EXPORTS -D__NO_FORTIFY
> =20
>  # When linking purgatory.ro with -r unresolved symbols are not checked,
>  # also link a purgatory.chk binary without -r to check for unresolved sy=
mbols.
> --=20
> 2.34.1
>=20
>=20
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

--ZFT5h/br0IBkD5vu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZHfMIAAKCRB4tDGHoIJi
0skGAP0RP0L15KqUDxAa/Z7n2whLtyvwOJmOwsbDDBUC+eTiWAD/cULCWm/j6GXO
GcD+DaRrgW5urSzwpXiAq1ng8PzMFwg=
=q9r1
-----END PGP SIGNATURE-----

--ZFT5h/br0IBkD5vu--
