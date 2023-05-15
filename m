Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFB0A703E8E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 22:21:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245327AbjEOUVp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 16:21:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245320AbjEOUVn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 16:21:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8EC51155C;
        Mon, 15 May 2023 13:21:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 94DA263249;
        Mon, 15 May 2023 20:21:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43F92C433EF;
        Mon, 15 May 2023 20:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684182069;
        bh=vneTiolPf0A2Sa5tiEShJ2027gWIInNKUlCskRhQSyA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oDszpfaL2n5JSU5VL8RWJ54HuEmjYpA7txuT0l48ytlPnsdNzwa+JSMbkS1LBwpLl
         6vOrYQja/IdlO7J0H7c65rmF76LDqK9j9YPksMwXSCBmIGcvlGLd85ULOnF6YGLNAu
         hMD7r+/KBFsTl3u469Z4bPv4S8ku+GeSLh8J4b2hstM0cd7a7oSubninZYYPOYPZvQ
         RwiaIZ4vIu1iUZmHhFM1tKM7HOoKVHg4HxDcEZq0tBg69B6W8TLEmmbC6svFQGUK20
         uXmQ7ACeshKdeca3hqmGRJ+lZym/k2OaVjiCR1Z9AyW7hRHtO9z37brDpltxzrJKMm
         O05XLEZjTeC7Q==
Date:   Mon, 15 May 2023 21:21:04 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Lucas Tanure <tanure@linux.com>, Rob Herring <robh@kernel.org>,
        robh+dt@kernel.org, frowand.list@gmail.com,
        devicetree@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 6.3 06/11] of: fdt: Scan /memreserve/ last
Message-ID: <20230515-headroom-swirl-a0a845584a58@spud>
References: <20230511193757.623114-1-sashal@kernel.org>
 <20230511193757.623114-6-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6soQmHEW88UuH2jH"
Content-Disposition: inline
In-Reply-To: <20230511193757.623114-6-sashal@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6soQmHEW88UuH2jH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Sasha,

On Thu, May 11, 2023 at 03:37:49PM -0400, Sasha Levin wrote:
> From: Lucas Tanure <tanure@linux.com>
>=20
> [ Upstream commit b413281876292de44ae84e9a9ce9d62e47f266e9 ]
>=20
> Change the scanning /memreserve/ and /reserved-memory node order to fix
> Kernel panic on Khadas Vim3 Board.
>=20
> If /memreserve/ goes first, the memory is reserved, but nomap can't be
> applied to the region. So the memory won't be used by Linux, but it is
> still present in the linear map as normal memory, which allows
> speculation. Legitimate access to adjacent pages will cause the CPU
> to end up prefetching into them leading to Kernel panic.
>=20
> So /reserved-memory node should go first, as it has a more updated
> description of the memory regions and can apply flags, like nomap.
>=20
> Link: https://lore.kernel.org/all/CAJX_Q+1Tjc+-TjZ6JW9X0NxEdFe=3D82a9626y=
L63j7uVD4LpxEA@mail.gmail.com/
> Signed-off-by: Lucas Tanure <tanure@linux.com>
> Link: https://lore.kernel.org/r/20230424113846.46382-1-tanure@linux.com
> Signed-off-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>

Rob requested that this patch (and it's bretheren in other AUTOSEL
series) not be backported immediately:
| Going to let this sit in linux-next for a bit. I also didn't tag for=20
| stable kernels. I want it to get some exposure in mainline at least for=
=20
| a few -rc releases rather than getting backported right away. Please=20
| help ensure that happens if you see stable review emails. I'm going to=20
| be offline most of the next month.
https://lore.kernel.org/linux-devicetree/168262872454.3491083.6407810340850=
053636.robh@kernel.org/

Perhaps delaying it for another couple of weeks, since we have only just
had -rc2, is a good idead?

Cheers,
Conor.

> ---
>  drivers/of/fdt.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> index d1a68b6d03b3f..c28aedd7ae1f7 100644
> --- a/drivers/of/fdt.c
> +++ b/drivers/of/fdt.c
> @@ -635,6 +635,9 @@ void __init early_init_fdt_scan_reserved_mem(void)
>  	if (!initial_boot_params)
>  		return;
> =20
> +	fdt_scan_reserved_mem();
> +	fdt_reserve_elfcorehdr();
> +
>  	/* Process header /memreserve/ fields */
>  	for (n =3D 0; ; n++) {
>  		fdt_get_mem_rsv(initial_boot_params, n, &base, &size);
> @@ -643,8 +646,6 @@ void __init early_init_fdt_scan_reserved_mem(void)
>  		memblock_reserve(base, size);
>  	}
> =20
> -	fdt_scan_reserved_mem();
> -	fdt_reserve_elfcorehdr();
>  	fdt_init_reserved_mem();
>  }
> =20
> --=20
> 2.39.2
>=20

--6soQmHEW88UuH2jH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZGKUMAAKCRB4tDGHoIJi
0je0AP9UARPo+3TtaaOtoqw6XGAYl8gFA8rqU3XepzJta/TGIwD+JHLnxtUifu5o
T766zPKM2gwA5PiYb9+49w7CqiHLdwc=
=vzJq
-----END PGP SIGNATURE-----

--6soQmHEW88UuH2jH--
