Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0821B679F66
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 18:01:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234595AbjAXRBZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 12:01:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233580AbjAXRBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 12:01:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C1004B8A1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 09:01:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8F9E361306
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 17:01:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5481EC433D2;
        Tue, 24 Jan 2023 17:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674579671;
        bh=hH4ROFBDE9/zvCleMxO0DBsKXeLU0Z/8dFxdcAZGYMI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Xx7okMwMsx1OdKtdINef/nsB6UPGFCy5I8aNzzJ49saQp+dHtt/IfDu/atvIBwzhl
         9ADvrLntSkKdkpOmIu3Og70fxhXty9DVLI8V6eQC/ZO8NhJUDFAO/5PegwaZNAvYhh
         iBNdXUlA9i7E4CDD0oeQ2B2AiCcPlArgRsbGnRV7fejqbWn1QToVQCw69tpX6jfG9S
         56PanImLqpeQrsON5VmL39gcwJJTCYO4bU+5ZDTiBfjwbp8mOJNiCnpbWUacTs10Ks
         HIv4RYtrgv+fQwIaU6V9DFkCBPpw+vCIHXEpOHq1+bG6VBxOn3xJfPsdSb87cZaiuJ
         WOuaAfxdg0WjQ==
Date:   Tue, 24 Jan 2023 17:01:04 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Pierre Gondois <pierre.gondois@arm.com>
Cc:     linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Dan Carpenter <error27@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Akihiko Odaki <akihiko.odaki@daynix.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Gavin Shan <gshan@redhat.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH -next v2 3/3] cacheinfo: Remove unused check in
 init_cache_level()
Message-ID: <Y9AO0GDslKS0Hs1c@spud>
References: <20230124154053.355376-1-pierre.gondois@arm.com>
 <20230124154053.355376-4-pierre.gondois@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="C5gbpn4doceQBVba"
Content-Disposition: inline
In-Reply-To: <20230124154053.355376-4-pierre.gondois@arm.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--C5gbpn4doceQBVba
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 24, 2023 at 04:40:48PM +0100, Pierre Gondois wrote:
> commit e75d18cecbb3 ("arm64: cacheinfo: Fix incorrect assignment
> of signed error value to unsigned fw_level")
> checks the fw_level value in init_cache_level() in case the value is
> negative.
> Remove this check as the error code is not returned through
> fw_level anymore, and reset fw_level if acpi_get_cache_info()
> failed. This allows to try fetching the cache information from
> clidr_el1.

I dunno anything about clidr_el1, but the mechanics of the change seem
fair. There is a non-acpi path too, which shouldn't return negative
numbers either so LGTM.

> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
> ---
>  arch/arm64/kernel/cacheinfo.c | 3 ---
>  1 file changed, 3 deletions(-)
>=20
> diff --git a/arch/arm64/kernel/cacheinfo.c b/arch/arm64/kernel/cacheinfo.c
> index bf348b8d321f..c307f69e9b55 100644
> --- a/arch/arm64/kernel/cacheinfo.c
> +++ b/arch/arm64/kernel/cacheinfo.c
> @@ -62,9 +62,6 @@ int init_cache_level(unsigned int cpu)
>  			fw_level =3D 0;
>  	}
> =20
> -	if (fw_level < 0)
> -		return fw_level;
> -
>  	if (level < fw_level) {
>  		/*
>  		 * some external caches not specified in CLIDR_EL1
> --=20
> 2.25.1
>=20

--C5gbpn4doceQBVba
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY9AO0AAKCRB4tDGHoIJi
0szJAQCdmFEFdFU4G6o36G8+91OO9PTUNKda+jTIrbjZ3pKAnwD/XUULiEMDXoMo
mI2CSx7E69a1BYjjDaTuo6jiVUpjBQs=
=Wii1
-----END PGP SIGNATURE-----

--C5gbpn4doceQBVba--
