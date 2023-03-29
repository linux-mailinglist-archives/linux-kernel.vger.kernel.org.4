Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C1FE6CDB4A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 15:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230308AbjC2N4z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 09:56:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229976AbjC2N4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 09:56:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A418EB6;
        Wed, 29 Mar 2023 06:56:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4A4D1B81CAB;
        Wed, 29 Mar 2023 13:56:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F4F2C433D2;
        Wed, 29 Mar 2023 13:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680098210;
        bh=sz83pbUhcBCvYaINkOvUuSoxstbUEDcsJvVW4LAj494=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XZQ1/p5S6U77OOspflCRGHzNPZAMB4cGqlNk1A+wjPklv8F+exGcY/aUJ/XFwOc/s
         OexNRkWDDsL7W7k7/Qpe8g8Pyd9yPSPhEgyqgEW5KJgPF1bRO/uehcFxKPcXivX+NQ
         wrhB6TFAJdBz2221jJG33da6pojRR5I16xF8VbAkOj4Jh3l+L0lolIKlKeukZq0kiN
         Wr41ULt3fo/exyNdNQI+8lWAvsEnPhgG4n2blQ19M7dyuX3reW/Rmiysw19gYCr4X1
         gnAkD1OlPHeqfCOXLceB9IiOkcMnoSGImtdyJQZ1zN7tql9oFGdz314US03gCBOCQs
         9ozFsEh5XgdTA==
Date:   Wed, 29 Mar 2023 14:56:45 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Alexandre Ghiti <alexghiti@rivosinc.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor.dooley@microchip.com>,
        linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -fixes v2 3/3] riscv: No need to relocate the dtb as it
 lies in the fixmap region
Message-ID: <381c2753-cbcc-40a0-bcb2-67d18e367822@spud>
References: <20230329081932.79831-1-alexghiti@rivosinc.com>
 <20230329081932.79831-4-alexghiti@rivosinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="e24sXklnJrl97Gf3"
Content-Disposition: inline
In-Reply-To: <20230329081932.79831-4-alexghiti@rivosinc.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--e24sXklnJrl97Gf3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 29, 2023 at 10:19:32AM +0200, Alexandre Ghiti wrote:
> We used to access the dtb via its linear mapping address but now that the
> dtb early mapping was moved in the fixmap region, we can keep using this
> address since it is present in swapper_pg_dir, and remove the dtb
> relocation.
>=20
> Note that the relocation was wrong anyway since early_memremap() is
> restricted to 256K whereas the maximum fdt size is 2MB.

So, should this be marked as a fix, and backported along with 1/3?
Either way,
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

And from v1 (although I didn't actually send it for idk what reason):
Tested-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

>=20
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> ---
>  arch/riscv/mm/init.c | 21 ++-------------------
>  1 file changed, 2 insertions(+), 19 deletions(-)
>=20
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index fb78d6bbabae..0f14f4a8d179 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -249,25 +249,8 @@ static void __init setup_bootmem(void)
>  	 * early_init_fdt_reserve_self() since __pa() does
>  	 * not work for DTB pointers that are fixmap addresses
>  	 */
> -	if (!IS_ENABLED(CONFIG_BUILTIN_DTB)) {
> -		/*
> -		 * In case the DTB is not located in a memory region we won't
> -		 * be able to locate it later on via the linear mapping and
> -		 * get a segfault when accessing it via __va(dtb_early_pa).
> -		 * To avoid this situation copy DTB to a memory region.
> -		 * Note that memblock_phys_alloc will also reserve DTB region.
> -		 */
> -		if (!memblock_is_memory(dtb_early_pa)) {
> -			size_t fdt_size =3D fdt_totalsize(dtb_early_va);
> -			phys_addr_t new_dtb_early_pa =3D memblock_phys_alloc(fdt_size, PAGE_S=
IZE);
> -			void *new_dtb_early_va =3D early_memremap(new_dtb_early_pa, fdt_size);
> -
> -			memcpy(new_dtb_early_va, dtb_early_va, fdt_size);
> -			early_memunmap(new_dtb_early_va, fdt_size);
> -			_dtb_early_pa =3D new_dtb_early_pa;
> -		} else
> -			memblock_reserve(dtb_early_pa, fdt_totalsize(dtb_early_va));
> -	}
> +	if (!IS_ENABLED(CONFIG_BUILTIN_DTB))
> +		memblock_reserve(dtb_early_pa, fdt_totalsize(dtb_early_va));
> =20
>  	dma_contiguous_reserve(dma32_phys_limit);
>  	if (IS_ENABLED(CONFIG_64BIT))
> --=20
> 2.37.2
>=20

--e24sXklnJrl97Gf3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZCRDfQAKCRB4tDGHoIJi
0txGAQCJ95Z8KvRd7YQ/GjQefD8OrTYAFUgQvL3o+EdW+h2eaAD+KEHoGr5BqpRc
ldHxzZyupQd/OEu5QL2owuc2yOxD+Ao=
=UXNP
-----END PGP SIGNATURE-----

--e24sXklnJrl97Gf3--
