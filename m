Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A86B74714D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 14:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbjGDM1b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 08:27:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231690AbjGDM1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 08:27:08 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3916F10F1
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 05:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1688473613; x=1720009613;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UjTTupn9qJkicPlewg6pVkjIzGItxTvL5gYYji1MF7U=;
  b=2aPYb2DCVIUzw5M5dHQkXYrU7Uf3E9oFK0yHg6tTadR6pzmS5cUvaSrT
   TIbncb9inJZPtZ+wdPutUHRVnaOA/yOQlrthLehfyPtnlEseSCNmQ1oBj
   1/Rd3QxF/iJZ2TYIFHKu5vjtsPMsOD1lIUBvYBeHPFFXWHFdVLb9E8AVx
   D1BAY382RHLqaQLck7GwRegNZa9/To8fOKjf+AuxkwBJT/A4jeELjQPPG
   BPMQ13oxO5uNuaoShNkzpYsxlsmM18132jsXdxonYIeXTPpTIz94+4O7v
   zBM8awJ9NhmlNU/FVSpSQN0l60mbGxsJzgDmsVNgrsDCIbPjwcgXgC+5F
   w==;
X-IronPort-AV: E=Sophos;i="6.01,180,1684825200"; 
   d="asc'?scan'208";a="221231359"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 04 Jul 2023 05:26:52 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 4 Jul 2023 05:26:43 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Tue, 4 Jul 2023 05:26:41 -0700
Date:   Tue, 4 Jul 2023 13:26:12 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Alexandre Ghiti <alexghiti@rivosinc.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Song Shuai <suagrfillet@gmail.com>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] riscv: Start of DRAM should at least be aligned on PMD
 size for the direct mapping
Message-ID: <20230704-emblem-rubble-e4a3a87cb98e@wendy>
References: <20230704121837.248976-1-alexghiti@rivosinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="9jeWf4lkKbux8HSU"
Content-Disposition: inline
In-Reply-To: <20230704121837.248976-1-alexghiti@rivosinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--9jeWf4lkKbux8HSU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Alex,

On Tue, Jul 04, 2023 at 02:18:37PM +0200, Alexandre Ghiti wrote:
> So that we do not end up mapping the whole linear mapping using 4K
> pages, which is slow at boot time, and also very likely at runtime.
>=20
> So make sure we align the start of DRAM on a PMD boundary.
>=20
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Obviously correct me if I am wrong here, but was this not reported by
Song Shuai as a regression?
Accordingly, should this not have Reported-by, Closes/Link & Fixes tags?

Cheers,
Conor.

> ---
>  arch/riscv/mm/init.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index 4fa420faa780..4a43ec275c6d 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -214,8 +214,13 @@ static void __init setup_bootmem(void)
>  	memblock_reserve(vmlinux_start, vmlinux_end - vmlinux_start);
> =20
>  	phys_ram_end =3D memblock_end_of_DRAM();
> +
> +	/*
> +	 * Make sure we align the start of the memory on a PMD boundary so that
> +	 * at worst, we map the linear mapping with PMD mappings.
> +	 */
>  	if (!IS_ENABLED(CONFIG_XIP_KERNEL))
> -		phys_ram_base =3D memblock_start_of_DRAM();
> +		phys_ram_base =3D memblock_start_of_DRAM() & PMD_MASK;
> =20
>  	/*
>  	 * In 64-bit, any use of __va/__pa before this point is wrong as we
> --=20
> 2.39.2
>=20

--9jeWf4lkKbux8HSU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZKQP1gAKCRB4tDGHoIJi
0itCAPwKOEqJ0dNzrojBEleJ+wILpeeIhBt4b6b8vTdYfsnGlAEAkIk4KBiL+H/E
ZM9Cl8dBOGiaC3Ewi3Po+ryBoyKNNQA=
=fhdf
-----END PGP SIGNATURE-----

--9jeWf4lkKbux8HSU--
