Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58DC065D396
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 14:00:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232614AbjADNAk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 08:00:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbjADNAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 08:00:37 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AA4F12624
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 05:00:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0790961425
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 13:00:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE597C433EF;
        Wed,  4 Jan 2023 13:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672837235;
        bh=aINReqP5sO7hUDTxAOXJWJ1lezkfPWFHYacE2WLSAIM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d13CxfskSSa47ik9YFbYTqnfy5hGnxfMFm1eHx8Vy+gys0g8NN+ivnn+0YcvqqkjF
         5aSk+zyLaBBA2wMGRh1vPFxiaNwhaO7PAwOshw5pajnl3ogH+F2CDg+RomRWToFeeY
         eUhzKbCE8Eqlsrkqu36gBSZur6+7lQ3sILvWW93jFkLVCoyaqPUEOZCdORmyJfQuFM
         2A1vFpAkpDDsIjKdOSsGeRD+/EmmtvFh/9sRzV0PlhbD0RoQQ4rPvrqVSyTqaXTde+
         8sPl3pBCorhERsGhXJxVHY3NZjE8LjAKBdXyvyTlFHP+Trf2fcE50MHB3JsQ1elJjg
         uVEKxWmyjNGmA==
Date:   Wed, 4 Jan 2023 13:00:31 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Ley Foon Tan <leyfoon.tan@starfivetech.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ley Foon Tan <lftan.linux@gmail.com>
Subject: Re: [PATCH] riscv: Move call to init_cpu_topology() to later
 initialization stage
Message-ID: <Y7V4byskevAWKM3G@spud>
References: <20230103035316.3841303-1-leyfoon.tan@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="upFcVDVkXP8V4qFX"
Content-Disposition: inline
In-Reply-To: <20230103035316.3841303-1-leyfoon.tan@starfivetech.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--upFcVDVkXP8V4qFX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Ley Foon Tan,

Apologies for my various bits of confusion.

On Tue, Jan 03, 2023 at 11:53:16AM +0800, Ley Foon Tan wrote:
> topology_parse_cpu_capacity() is failed to allocate memory with kcalloc()
> after read "capacity-dmips-mhz" DT parameter in CPU DT nodes. This
> topology_parse_cpu_capacity() is called from init_cpu_topology(), move
> call to init_cpu_topology() to later initialization  stage (after memory
> allocation is available).
>=20
> Note, this refers to ARM64 implementation, call init_cpu_topology() in
> smp_prepare_cpus().
>=20
> Tested on Qemu platform.

I'd like to suggest a change to the commit message:
```
If "capacity-dmips-mhz" is present in a CPU DT node,
topology_parse_cpu_capacity() will fail to allocate memory.
arm64, with which this code path is shared, does not call
topology_parse_cpu_capacity() until later in boot where memory
allocation is available.
While "capacity-dmips-mhz" is not yet a valid property on RISC-V,
invalid properties should be ignored rather than cause issues.
Move init_cpu_topology(), which calls topology_parse_cpu_capacity(),
to a later initialization stage, to match arm64.

As a side effect of this change, RISC-V is "protected" from changes to
core topology code that would work on arm64 where memory allocation is
safe but on RISC-V isn't.
```

You don't need to use exactly that, but with something along those
lines:
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

>=20
> Signed-off-by: Ley Foon Tan <leyfoon.tan@starfivetech.com>
>=20
> ---
>=20
> In drivers/base/arch_topology.c: topology_parse_cpu_capacity():
>=20
> 	ret =3D of_property_read_u32(cpu_node, "capacity-dmips-mhz",
> 				   &cpu_capacity);
> 	if (!ret) {
> 		if (!raw_capacity) {
> 			raw_capacity =3D kcalloc(num_possible_cpus(),
> 					       sizeof(*raw_capacity),
> 					       GFP_KERNEL);
> 			if (!raw_capacity) {
> 				cap_parsing_failed =3D true;
> 				return false;
> 			}
> ---
>  arch/riscv/kernel/smpboot.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
> index 3373df413c88..ddb2afba6d25 100644
> --- a/arch/riscv/kernel/smpboot.c
> +++ b/arch/riscv/kernel/smpboot.c
> @@ -39,7 +39,6 @@ static DECLARE_COMPLETION(cpu_running);
> =20
>  void __init smp_prepare_boot_cpu(void)
>  {
> -	init_cpu_topology();
>  }
> =20
>  void __init smp_prepare_cpus(unsigned int max_cpus)
> @@ -48,6 +47,8 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
>  	int ret;
>  	unsigned int curr_cpuid;
> =20
> +	init_cpu_topology();
> +
>  	curr_cpuid =3D smp_processor_id();
>  	store_cpu_topology(curr_cpuid);
>  	numa_store_cpu_info(curr_cpuid);
> --=20
> 2.25.1
>=20

--upFcVDVkXP8V4qFX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY7V4bwAKCRB4tDGHoIJi
0o0PAP9HD9PLqgsCZxfFPCseSIFNVy2GxrDM9AOY7oa7VqDuPgD/cAkklAAE+I71
MIeO+K6gmi6G4ENFCyIG/KlgIrjdkAU=
=kUSK
-----END PGP SIGNATURE-----

--upFcVDVkXP8V4qFX--
