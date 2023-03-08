Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5966F6B0555
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 12:04:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbjCHLEj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 06:04:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbjCHLEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 06:04:00 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93B6295E22
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 03:03:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D18F061761
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 11:03:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6970DC433EF;
        Wed,  8 Mar 2023 11:03:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678273419;
        bh=Zbl3Foqh2H5WwIwrRZv3Jx/V1nZZ5DSGmtKn0Ssa7Ac=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jCPp/xktaaV2xYVkQ6nb3+wmXdq29v6wIVE4TfWp+30FZ5oVstNnL9J8aQsf2jks/
         yB016+p8iFGrBMYjSETJcRSzNqmUj+02ZPVzYN82ZfJLEKnQolJxaopisEBhifU+9G
         sXEq9mZZpuYgHtILY9JDHrg45+gCXfR6abVO9+SfyJQKqcVgTevQIUEbsP0PKZlYva
         His5DUYZc3rVxBVkwfEb6fcNuKm6veFDndk6Iv0Z4+DPWv4hTmglznKvWy4leSLozH
         3+tx4G+GqWLmcHQR4nVsm42jsm8Vsx2cDKHFeLiLvOCWNc6Axa1OujS4Csar2fmJ63
         2pcurg2AWuJrQ==
Date:   Wed, 8 Mar 2023 11:03:35 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Song Shuai <suagrfillet@gmail.com>
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, sudeep.holla@arm.com,
        pierre.gondois@arm.com, conor.dooley@microchip.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Revert "riscv: Set more data to cacheinfo"
Message-ID: <511b57ce-476a-4801-8b14-e2a9c180c400@spud>
References: <20230308064734.512457-1-suagrfillet@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="bwR3dAb+Pcs15DVY"
Content-Disposition: inline
In-Reply-To: <20230308064734.512457-1-suagrfillet@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bwR3dAb+Pcs15DVY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 08, 2023 at 02:47:34PM +0800, Song Shuai wrote:
> This reverts commit baf7cbd94b5688f167443a2cc3dcea3300132099.
>=20
> There are some duplicate cache attributes populations executed
> in both ci_leaf_init() and later cache_setup_properties().
>=20
> Revert the commit baf7cbd94b56 ("riscv: Set more data to cacheinfo")
> to setup only the level and type attributes at this early place.
>

I've attempted to do a little bit of history diving to figure out what
commit to "blame" in a fixes tag for this.
My initial thought was to blame 03f11f03dbfe ("RISC-V: Parse cpu topology
during boot."), but baf7cbd94b56 ("riscv: Set more data to cacheinfo")
looks like it came along some months later.
I assume you double checked that the stuff in the aux vector is the same
before/after this revert? Looking on lore, that seems to be why Zong did
it this way in the first place:
https://lore.kernel.org/linux-riscv/b6fed9b4c2a3eacb2a9c353c2570d9dc1d0c1c8=
8.1598859038.git.zong.li@sifive.com/

Cheers,
Conor.

> Signed-off-by: Song Shuai <suagrfillet@gmail.com>
> ---
>  arch/riscv/kernel/cacheinfo.c | 66 ++++++++---------------------------
>  1 file changed, 15 insertions(+), 51 deletions(-)
>=20
> diff --git a/arch/riscv/kernel/cacheinfo.c b/arch/riscv/kernel/cacheinfo.c
> index 3a13113f1b29..305ebbdc780d 100644
> --- a/arch/riscv/kernel/cacheinfo.c
> +++ b/arch/riscv/kernel/cacheinfo.c
> @@ -64,53 +64,12 @@ uintptr_t get_cache_geometry(u32 level, enum cache_ty=
pe type)
>  			   0;
>  }
> =20
> -static void ci_leaf_init(struct cacheinfo *this_leaf, enum cache_type ty=
pe,
> -			 unsigned int level, unsigned int size,
> -			 unsigned int sets, unsigned int line_size)
> +static void ci_leaf_init(struct cacheinfo *this_leaf,
> +			 struct device_node *node,
> +			 enum cache_type type, unsigned int level)
>  {
>  	this_leaf->level =3D level;
>  	this_leaf->type =3D type;
> -	this_leaf->size =3D size;
> -	this_leaf->number_of_sets =3D sets;
> -	this_leaf->coherency_line_size =3D line_size;
> -
> -	/*
> -	 * If the cache is fully associative, there is no need to
> -	 * check the other properties.
> -	 */
> -	if (sets =3D=3D 1)
> -		return;
> -
> -	/*
> -	 * Set the ways number for n-ways associative, make sure
> -	 * all properties are big than zero.
> -	 */
> -	if (sets > 0 && size > 0 && line_size > 0)
> -		this_leaf->ways_of_associativity =3D (size / sets) / line_size;
> -}
> -
> -static void fill_cacheinfo(struct cacheinfo **this_leaf,
> -			   struct device_node *node, unsigned int level)
> -{
> -	unsigned int size, sets, line_size;
> -
> -	if (!of_property_read_u32(node, "cache-size", &size) &&
> -	    !of_property_read_u32(node, "cache-block-size", &line_size) &&
> -	    !of_property_read_u32(node, "cache-sets", &sets)) {
> -		ci_leaf_init((*this_leaf)++, CACHE_TYPE_UNIFIED, level, size, sets, li=
ne_size);
> -	}
> -
> -	if (!of_property_read_u32(node, "i-cache-size", &size) &&
> -	    !of_property_read_u32(node, "i-cache-sets", &sets) &&
> -	    !of_property_read_u32(node, "i-cache-block-size", &line_size)) {
> -		ci_leaf_init((*this_leaf)++, CACHE_TYPE_INST, level, size, sets, line_=
size);
> -	}
> -
> -	if (!of_property_read_u32(node, "d-cache-size", &size) &&
> -	    !of_property_read_u32(node, "d-cache-sets", &sets) &&
> -	    !of_property_read_u32(node, "d-cache-block-size", &line_size)) {
> -		ci_leaf_init((*this_leaf)++, CACHE_TYPE_DATA, level, size, sets, line_=
size);
> -	}
>  }
> =20
>  int populate_cache_leaves(unsigned int cpu)
> @@ -121,24 +80,29 @@ int populate_cache_leaves(unsigned int cpu)
>  	struct device_node *prev =3D NULL;
>  	int levels =3D 1, level =3D 1;
> =20
> -	/* Level 1 caches in cpu node */
> -	fill_cacheinfo(&this_leaf, np, level);
> +	if (of_property_read_bool(np, "cache-size"))
> +		ci_leaf_init(this_leaf++, np, CACHE_TYPE_UNIFIED, level);
> +	if (of_property_read_bool(np, "i-cache-size"))
> +		ci_leaf_init(this_leaf++, np, CACHE_TYPE_INST, level);
> +	if (of_property_read_bool(np, "d-cache-size"))
> +		ci_leaf_init(this_leaf++, np, CACHE_TYPE_DATA, level);
> =20
> -	/* Next level caches in cache nodes */
>  	prev =3D np;
>  	while ((np =3D of_find_next_cache_node(np))) {
>  		of_node_put(prev);
>  		prev =3D np;
> -
>  		if (!of_device_is_compatible(np, "cache"))
>  			break;
>  		if (of_property_read_u32(np, "cache-level", &level))
>  			break;
>  		if (level <=3D levels)
>  			break;
> -
> -		fill_cacheinfo(&this_leaf, np, level);
> -
> +		if (of_property_read_bool(np, "cache-size"))
> +			ci_leaf_init(this_leaf++, np, CACHE_TYPE_UNIFIED, level);
> +		if (of_property_read_bool(np, "i-cache-size"))
> +			ci_leaf_init(this_leaf++, np, CACHE_TYPE_INST, level);
> +		if (of_property_read_bool(np, "d-cache-size"))
> +			ci_leaf_init(this_leaf++, np, CACHE_TYPE_DATA, level);
>  		levels =3D level;
>  	}
>  	of_node_put(np);
> --=20
> 2.20.1
>=20

--bwR3dAb+Pcs15DVY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZAhrhgAKCRB4tDGHoIJi
0vSXAQCvURMcp1bHLxBYLosA+i+WCSNau6J+dyYcyi9vWcVoKwEAySl9aT/Omtzg
gIYgjttNSKJ1istKGeQ2H9TRaomc/A4=
=bvL+
-----END PGP SIGNATURE-----

--bwR3dAb+Pcs15DVY--
