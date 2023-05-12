Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 567EE700346
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 11:04:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240364AbjELJEQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 05:04:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240072AbjELJEK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 05:04:10 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17A21100C1
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 02:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1683882236; x=1715418236;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zcHYREBwGpJMPtTyUBAT9YdL1pOBPSeKhPfj/sCyYOY=;
  b=OeylaUsMQZ7jSp7fhv0Idi+KoXU81+yX0PVk5A3fuQnNk919ysmvweGX
   q9tkFNn/XRdnQj2Z2f3ooOsjn6jPRkqQlMgM6O14k6nmgGfSqHt0PdSOT
   124HOovrIoeCPD0k2/BtDMYCcJ7YlLeeg+otOfkBUYPa5lkKM9drN/hNv
   vhbu9Il1tcqlNKbJDrPy1Zlymi24Hn10/6biD6haUuQA2yT+Myq/7cus2
   4Ajc/0+rJtRHtaW+xOcyXdH0WWMSwW+BEVkZTADKmkk/shiFN0tJohMU0
   66ucRm6KkNx0RDS8tGJugMPvADJEQOxU0VAl5VU0dsb8myyqopM5uN6Hx
   w==;
X-IronPort-AV: E=Sophos;i="5.99,269,1677567600"; 
   d="asc'?scan'208";a="213025948"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 12 May 2023 02:03:42 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 12 May 2023 02:03:41 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Fri, 12 May 2023 02:03:39 -0700
Date:   Fri, 12 May 2023 10:03:19 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Amma Lee <lixiaoyun@binary-semi.com>
CC:     <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>, <conor@kernel.org>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <xiezx@binary-semi.com>
Subject: Re: [PATCH v2] riscv: optimize ELF relocation function in riscv
Message-ID: <20230512-morbidly-supremacy-9cdb519107d1@wendy>
References: <1683881513-18730-1-git-send-email-lixiaoyun@binary-semi.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="tP+IIUGPs57ZcuZy"
Content-Disposition: inline
In-Reply-To: <1683881513-18730-1-git-send-email-lixiaoyun@binary-semi.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--tP+IIUGPs57ZcuZy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Amma,

On Fri, May 12, 2023 at 04:51:53PM +0800, Amma Lee wrote:
> The patch can optimize the running times of "insmod" command by modify ELF
> relocation function.
> When install the riscv ELF driver which contains multiple
> symbol table items to be relocated, kernel takes a lot of time to
> execute the relocation. For example, we install a 3+MB driver need 180+s.
> We focus on the riscv kernel handle R_RISCV_HI20 and R_RISCV_LO12 type
> items relocation function and find that there are two for-loops in this
> function. If we modify the begin number in the second for-loops iteration,
> we could save significant time for installation. We install the 3+MB
> driver could just need 2s.
>=20
> Signed-off-by: Amma Lee <lixiaoyun@binary-semi.com>

> Reviewed-by: Conor Dooley <conor@kernel.org>

I did not provide this tag. Do not add tags that you were not explicitly
given by people.

Also, you didn't actually even implement all of the things I pointed out
either :(

>=20
> ---
>  arch/riscv/kernel/module.c | 53 ++++++++++++++++++++++++++++++----------=
------
>  1 file changed, 35 insertions(+), 18 deletions(-)
>=20
> diff --git a/arch/riscv/kernel/module.c b/arch/riscv/kernel/module.c
> index 55507b0..1683c1d 100755
> --- a/arch/riscv/kernel/module.c
> +++ b/arch/riscv/kernel/module.c
> @@ -385,9 +385,17 @@ int apply_relocate_add(Elf_Shdr *sechdrs, const char=
 *strtab,
> =20
>  		if (type =3D=3D R_RISCV_PCREL_LO12_I || type =3D=3D R_RISCV_PCREL_LO12=
_S) {
>  			unsigned int j;
> -			/*Modify the j for-loops begin number from last iterates end value*/
> +
> +			/*
> +			* In the second for-loops, each traversal for j is
                        ^^
Comment in passing here, we align the *s in comments.

> +			* starts from 0 to the symbol table item index which
> +			* is detected. By the tool "readelf", we find that all
> +			* the symbol table items about R_RISCV_PCREL_HI20 type
> +			* are incrementally added in order. It means that we
> +			* could interate the j with the previous loop end
> +			* value(j_idx) as the begin number in the next loop;
> +			*/
>  			for (j =3D j_idx; j < sechdrs[relsec].sh_size / sizeof(*rel); j++) {
> -			/* Modify end */
>  				unsigned long hi20_loc =3D
>  					sechdrs[sechdrs[relsec].sh_info].sh_addr
>  					+ rel[j].r_offset;
> @@ -420,22 +428,30 @@ int apply_relocate_add(Elf_Shdr *sechdrs, const cha=
r *strtab,
>  					break;
>  				}
>  			}
> +
>  			if (j =3D=3D sechdrs[relsec].sh_size / sizeof(*rel)) {
> -				if(j_idx =3D=3D 0){
> +				if (j_idx =3D=3D 0) {
>  					pr_err(
>  						"%s: Can not find HI20 relocation information\n",
>  						me->name);
>  					return -EINVAL;
>  				}
> -			=09
> -			=09

^^ and this is one of the checkpatch complaints I mentioned last time,
no double blank lines please.

Also, this version of the patch doesn't actually apply for me to
v6.4-rc1 anymore, but the file has not been modified in upstream since
29/01. Not too sure what you have used as the base for this as a result
:/

Thanks,
Conor.

--tP+IIUGPs57ZcuZy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZF4A1wAKCRB4tDGHoIJi
0irwAQDXn6gMCQZLdhE/PL1bweyYVfuZ433ld7TQDL6lYx5XeQD7BTqZMSx7jAAJ
eSUcHx80p8CbMfxrXNZntncAdOt85QE=
=wlVR
-----END PGP SIGNATURE-----

--tP+IIUGPs57ZcuZy--
