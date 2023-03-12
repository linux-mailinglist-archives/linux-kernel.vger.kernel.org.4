Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9C2B6B66CE
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 14:40:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230454AbjCLNkb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 09:40:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230452AbjCLNk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 09:40:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BF971FF1;
        Sun, 12 Mar 2023 06:40:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0B115B80B50;
        Sun, 12 Mar 2023 13:40:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F08ABC433EF;
        Sun, 12 Mar 2023 13:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678628423;
        bh=Cc5SkNpX+fJG4RhyUV9lX1ru3SeON0+cWxM07x3k8gc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hCXCY3gQlYG4wYh02Oq5jSSRHPDnRfzATTKm9owjSaO0LGOkx3wHIw17a0xH5za97
         koz4zAADjjftqSv+BJbQstR4dibA7NjaNqffj/WaIeTIT6Y3Ra39bwCrgoaFzjYY1v
         lkdv43Z+yG8e0lfh75uL8UeW0WFnYAr8QB7YlUNBvcne76sIFJn9d6D+kdOg9qo5yQ
         oFu2thUebbZd1r9wfWPR/3ClEuzm8W8PnslQTLC8LrAdY8va5At52SYNnxvU3xIup9
         /erOa+vf8y1VGQ3Kk0ZvJrMhc7UcKA6VjruSM3r2FA4Yzw/MFY6s8unDNAHjK4LgJZ
         y8mXWG3kSUP+g==
Date:   Sun, 12 Mar 2023 13:40:18 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Paran Lee <p4ranlee@gmail.com>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Anton Blanchard <anton@ozlabs.org>,
        Daniel Axtens <dja@axtens.net>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [RESEND PATCH] perf tools riscv: Add support for riscv
 lookup_binutils_path
Message-ID: <972fcc78-517b-40fa-b46a-ce5dd6f8e980@spud>
References: <20230312130303.87954-1-p4ranlee@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5/FZjlJfVq2Ptchx"
Content-Disposition: inline
In-Reply-To: <20230312130303.87954-1-p4ranlee@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5/FZjlJfVq2Ptchx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 12, 2023 at 10:03:05PM +0900, Paran Lee wrote:
> Add to know RISC-V binutils path.
>=20
> Signed-off-by: Paran Lee <p4ranlee@gmail.com>
> ---
>  tools/perf/arch/common.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>=20
> diff --git a/tools/perf/arch/common.c b/tools/perf/arch/common.c
> index 59dd875fd5e4..6ac7a22244c0 100644
> --- a/tools/perf/arch/common.c
> +++ b/tools/perf/arch/common.c
> @@ -43,6 +43,20 @@ const char *const powerpc_triplets[] =3D {
>  	NULL
>  };
> =20
> +const char *const riscv32_triplets[] =3D {
> +	"riscv32-unknown-linux-gnu-",
> +	"riscv32-linux-android-",
> +	"riscv32-linux-gnu-",
> +	NULL
> +};
> +
> +const char *const riscv64_triplets[] =3D {
> +	"riscv64-unknown-linux-gnu-",
> +	"riscv64-linux-android-",
> +	"riscv64-linux-gnu-",

I don't know anything about perf, so I could be asking a really silly
question here, but how come riscvN-linux- has been omitted here?
The kernel.org toolchains [1] are prefixed that way, although I noticed
in your v1 that you'd seemingly duplicated the arm64 patterns, so I am
curious as to whether the omission is intentional.

Cheers,
Conor.

[1] https://mirrors.edge.kernel.org/pub/tools/crosstool/

> +	NULL
> +};
> +
>  const char *const s390_triplets[] =3D {
>  	"s390-ibm-linux-",
>  	"s390x-linux-gnu-",
> @@ -168,6 +182,10 @@ static int perf_env__lookup_binutils_path(struct per=
f_env *env,
>  		path_list =3D powerpc_triplets;
>  	else if (!strcmp(arch, "sh"))
>  		path_list =3D sh_triplets;
> +	else if (!strcmp(arch, "riscv32"))
> +		path_list =3D riscv32_triplets;
> +	else if (!strcmp(arch, "riscv64"))
> +		path_list =3D riscv64_triplets;
>  	else if (!strcmp(arch, "s390"))
>  		path_list =3D s390_triplets;
>  	else if (!strcmp(arch, "sparc"))
> --=20
> 2.34.1
>=20

--5/FZjlJfVq2Ptchx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZA3WPwAKCRB4tDGHoIJi
0sdJAQCoa+n+1sORACKtBGf6R1h/ZsaFTKclg0mcHVus8Gc65AEA9FeWMCtsjgc+
UDqGOtpYMTAQ6x/ALdE8HA8PFZ1T1Q8=
=Lmym
-----END PGP SIGNATURE-----

--5/FZjlJfVq2Ptchx--
