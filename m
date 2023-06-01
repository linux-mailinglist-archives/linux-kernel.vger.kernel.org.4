Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8AAF71F0E0
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 19:34:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232873AbjFARea (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 13:34:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232852AbjFARe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 13:34:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A520134;
        Thu,  1 Jun 2023 10:34:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D975464859;
        Thu,  1 Jun 2023 17:34:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29F8DC433EF;
        Thu,  1 Jun 2023 17:34:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685640866;
        bh=NLd5rE4WJi/QMXLKsa2Ce3607NEbnjCF2lgw/E4Ilrg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nFNBX6d5uMMdF/EJtBaNz9XDKPIY4Hwf+NtRvr23KUZW0AdM3dBhxs2js0P6gFgTr
         vKXeLsDOhpOGQFEYDpC7pO0IEFblRaIQDP4dbvtf6sfeohyVa4pbAetThmI+nHtm4z
         Ghim2VhR6ACJeiPRPhvq9oapSHjPY2wOdhWFdkWqAXsyAABO/aKLIRvdAsI+htOO9K
         sRQG4DD0WUoXEpTDnNDKUJdhurHWQ4jBkqKV/4usG4gM9QYseaDetzDGKGcegNtLa1
         4R2l6IvsTu1IiRgYHMJ49HvsAbMmWq3PvTngIZ4rjvg7MvPLYKGGw/BHyB/OnbMP4P
         lgxohBw8vW3kA==
Date:   Thu, 1 Jun 2023 18:34:20 +0100
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
        linux-riscv@lists.infradead.org,
        Andrew Jones <ajones@ventanamicro.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] riscv/purgatory: Do not use fortified string functions
Message-ID: <20230601-connected-unbolted-cf708c6da4a1@spud>
References: <20230601160025.gonna.868-kees@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="gTf3B7hbVc2YnwMI"
Content-Disposition: inline
In-Reply-To: <20230601160025.gonna.868-kees@kernel.org>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gTf3B7hbVc2YnwMI
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 01, 2023 at 09:00:28AM -0700, Kees Cook wrote:
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

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks for the quick update Kees,
Conor.

--gTf3B7hbVc2YnwMI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZHjWiwAKCRB4tDGHoIJi
0kIWAP4veZuc8tWugVZu2IOiEMZz7rzMOFo6ZJkp3tl6YRkuVAEA632MtlL3l8y6
KzIVgnx4OmDbCYnaIi/5WDzQtqJwOQ8=
=YraL
-----END PGP SIGNATURE-----

--gTf3B7hbVc2YnwMI--
