Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3F7A738EDA
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 20:31:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbjFUSbq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 14:31:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjFUSbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 14:31:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DCD61710;
        Wed, 21 Jun 2023 11:31:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9513961694;
        Wed, 21 Jun 2023 18:31:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B562C433C0;
        Wed, 21 Jun 2023 18:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687372302;
        bh=3o6u2aYrhfQMlUwAXLurIY4fV50SmtZY3yOfVjIeR28=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MQWRmw+9hEXFkCu2JLJqzbgDETxXVogPrWZ8nWcPuTFkA8IbD+Tj46A2xd06P2PGv
         b1d+ejelGNOELlfAyW7tYCoYodCxyT89BvqILNqDqQzQZPe1+BJjiFIxm94ystR3zQ
         nPPckI+c/pZl3hct6McqN882b5B1NCGA5EhyEtPS1wZznU30l1JPUPgIlYhxe5gz/y
         QEBT5xa8wsoYrDVcaoklx/yvyW+MdNMuFLI5kqjfeLPhPBKz9eiSsmhb0fVBhtUo5A
         5jZzmsV89oo/rFbzfs0/w6YEhBrdX5yYwMvQ0HBkYoD8NJKaupOzadBPEAvfjftY2X
         FePWYrONXVC2A==
Date:   Wed, 21 Jun 2023 19:31:37 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        Guo Ren <guoren@kernel.org>, wefu@redhat.com
Subject: Re: linux-next: Tree for Jun 21 (riscv/errata/thead)
Message-ID: <20230621-playoff-wireless-0dcfce9711ff@spud>
References: <20230621145917.3635a2f1@canb.auug.org.au>
 <14aa23d6-b4c2-190f-0d6c-22a82befa04d@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="h3jpjHKuVyhChuPS"
Content-Disposition: inline
In-Reply-To: <14aa23d6-b4c2-190f-0d6c-22a82befa04d@infradead.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--h3jpjHKuVyhChuPS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 21, 2023 at 11:25:14AM -0700, Randy Dunlap wrote:
>=20
>=20
> On 6/20/23 21:59, Stephen Rothwell wrote:
> > Hi all,
> >=20
> > Changes since 20230620:
> >=20
>=20
> on riscv 32-bit:

Is XIP_KERNEL enabled? And if so, does this fix it?
diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
index ce10a38dff37..6833d01e2e70 100644
--- a/arch/riscv/Kconfig.socs
+++ b/arch/riscv/Kconfig.socs
@@ -43,6 +43,7 @@ config ARCH_SUNXI
=20
 config ARCH_THEAD
        bool "T-HEAD RISC-V SoCs"
+       depends on MMU && !XIP_KERNEL
        select ERRATA_THEAD
        help
          This enables support for the RISC-V based T-HEAD SoCs.
(whitespace damaged)

Cheers,
Conor.

>=20
>=20
> WARNING: unmet direct dependencies detected for ERRATA_THEAD
>   Depends on [n]: RISCV_ALTERNATIVE [=3Dn]
>   Selected by [y]:
>   - ARCH_THEAD [=3Dy]
>=20
> WARNING: unmet direct dependencies detected for ERRATA_THEAD
>   Depends on [n]: RISCV_ALTERNATIVE [=3Dn]
>   Selected by [y]:
>   - ARCH_THEAD [=3Dy]
>=20
> WARNING: unmet direct dependencies detected for ERRATA_THEAD
>   Depends on [n]: RISCV_ALTERNATIVE [=3Dn]
>   Selected by [y]:
>   - ARCH_THEAD [=3Dy]
>=20
> ../arch/riscv/errata/thead/errata.c: In function 'errata_probe_pbmt':
> ../arch/riscv/errata/thead/errata.c:29:22: error: 'RISCV_ALTERNATIVES_EAR=
LY_BOOT' undeclared (first use in this function)
>    29 |         if (stage =3D=3D RISCV_ALTERNATIVES_EARLY_BOOT ||
>       |                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ../arch/riscv/errata/thead/errata.c:29:22: note: each undeclared identifi=
er is reported only once for each function it appears in
> ../arch/riscv/errata/thead/errata.c:30:22: error: 'RISCV_ALTERNATIVES_MOD=
ULE' undeclared (first use in this function)
>    30 |             stage =3D=3D RISCV_ALTERNATIVES_MODULE)
>       |                      ^~~~~~~~~~~~~~~~~~~~~~~~~
> ../arch/riscv/errata/thead/errata.c: In function 'errata_probe_cmo':
> ../arch/riscv/errata/thead/errata.c:45:22: error: 'RISCV_ALTERNATIVES_EAR=
LY_BOOT' undeclared (first use in this function)
>    45 |         if (stage =3D=3D RISCV_ALTERNATIVES_EARLY_BOOT)
>       |                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ../arch/riscv/errata/thead/errata.c: In function 'errata_probe_pmu':
> ../arch/riscv/errata/thead/errata.c:63:22: error: 'RISCV_ALTERNATIVES_EAR=
LY_BOOT' undeclared (first use in this function)
>    63 |         if (stage =3D=3D RISCV_ALTERNATIVES_EARLY_BOOT)
>       |                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ../arch/riscv/errata/thead/errata.c: At top level:
> ../arch/riscv/errata/thead/errata.c:86:37: warning: 'struct alt_entry' de=
clared inside parameter list will not be visible outside of this definition=
 or declaration
>    86 | void thead_errata_patch_func(struct alt_entry *begin, struct alt_=
entry *end,
>       |                                     ^~~~~~~~~
> ../arch/riscv/errata/thead/errata.c: In function 'thead_errata_patch_func=
':
> ../arch/riscv/errata/thead/errata.c:95:41: error: increment of pointer to=
 an incomplete type 'struct alt_entry'
>    95 |         for (alt =3D begin; alt < end; alt++) {
>       |                                         ^~
> ../arch/riscv/errata/thead/errata.c:96:24: error: invalid use of undefine=
d type 'struct alt_entry'
>    96 |                 if (alt->vendor_id !=3D THEAD_VENDOR_ID)
>       |                        ^~
> ../arch/riscv/errata/thead/errata.c:98:24: error: invalid use of undefine=
d type 'struct alt_entry'
>    98 |                 if (alt->patch_id >=3D ERRATA_THEAD_NUMBER)
>       |                        ^~
> ../arch/riscv/errata/thead/errata.c:101:33: error: invalid use of undefin=
ed type 'struct alt_entry'
>   101 |                 tmp =3D (1U << alt->patch_id);
>       |                                 ^~
> ../arch/riscv/errata/thead/errata.c:103:34: error: implicit declaration o=
f function 'ALT_OLD_PTR' [-Werror=3Dimplicit-function-declaration]
>   103 |                         oldptr =3D ALT_OLD_PTR(alt);
>       |                                  ^~~~~~~~~~~
> ../arch/riscv/errata/thead/errata.c:103:32: warning: assignment to 'void =
*' from 'int' makes pointer from integer without a cast [-Wint-conversion]
>   103 |                         oldptr =3D ALT_OLD_PTR(alt);
>       |                                ^
> ../arch/riscv/errata/thead/errata.c:104:34: error: implicit declaration o=
f function 'ALT_ALT_PTR' [-Werror=3Dimplicit-function-declaration]
>   104 |                         altptr =3D ALT_ALT_PTR(alt);
>       |                                  ^~~~~~~~~~~
> ../arch/riscv/errata/thead/errata.c:104:32: warning: assignment to 'void =
*' from 'int' makes pointer from integer without a cast [-Wint-conversion]
>   104 |                         altptr =3D ALT_ALT_PTR(alt);
>       |                                ^
> ../arch/riscv/errata/thead/errata.c:107:38: error: 'RISCV_ALTERNATIVES_EA=
RLY_BOOT' undeclared (first use in this function)
>   107 |                         if (stage =3D=3D RISCV_ALTERNATIVES_EARLY=
_BOOT) {
>       |                                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ../arch/riscv/errata/thead/errata.c:108:59: error: invalid use of undefin=
ed type 'struct alt_entry'
>   108 |                                 memcpy(oldptr, altptr, alt->alt_l=
en);
>       |                                                           ^~
> ../arch/riscv/errata/thead/errata.c:111:70: error: invalid use of undefin=
ed type 'struct alt_entry'
>   111 |                                 patch_text_nosync(oldptr, altptr,=
 alt->alt_len);
>       |                                                                  =
    ^~
> cc1: some warnings being treated as errors
>=20
>=20
> --=20
> ~Randy

--h3jpjHKuVyhChuPS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZJNCCQAKCRB4tDGHoIJi
0umMAQCeo7tmsoCFK/laMekW4n23h2SNRMHCYavQ4qKr/38lrAEA562IA0l+w8Xw
rA9XTQCe3y0k47NwabyL9ZgB23r6XA4=
=o8t5
-----END PGP SIGNATURE-----

--h3jpjHKuVyhChuPS--
