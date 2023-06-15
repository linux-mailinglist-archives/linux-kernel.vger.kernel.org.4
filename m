Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEAEC731689
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 13:30:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241469AbjFOLaj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 07:30:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240885AbjFOLah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 07:30:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 148EB2695
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 04:30:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A637A626B2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 11:30:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66CE2C433C0;
        Thu, 15 Jun 2023 11:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686828636;
        bh=R9F8GfHIz5BzxMyYLOltGUrhmXtWgm9RjW99JiZySp0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dB5c/uqncj87+C2R9Ni1LUM4gA5CB+rNQVniaQabBj4lth1T4APuNfj+PUMccVgt5
         OoM3PADiPzcc6z60HlPG6RhGHBHBUwIsZLi1N5ze12FBJjKYbRK3/cI6V35sA444ba
         hzA/Vj6FIif+sW/IuVrARisqzpCukoTYR+54JaM2GSGGgHOyu21JRBWQN3wUMVidZm
         GlSWryL3G9Iek14LFKgdURzUd/llaPe1dSKsKQs1rYnWhhEELJ5yoaA8hqsYXFYxhi
         z9g0egVQgKo70a4eogD6s5NgFMSUtz43i1Kpjah3SrOtF0soUGU13ONJD4fSJRVBGw
         j8z7E9K6JuMWA==
Date:   Thu, 15 Jun 2023 12:30:31 +0100
From:   Mark Brown <broonie@kernel.org>
To:     YingKun Meng <mengyingkun@loongson.cn>
Cc:     lgirdwood@gmail.com, krzysztof.kozlowski@linaro.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        loongarch@lists.linux.dev, loongson-kernel@lists.loongnix.cn
Subject: Re: [PATCH v3 1/3] ASoC: Add support for Loongson I2S controller
Message-ID: <89022514-9f99-4fdc-9eba-d428ad0bcbb6@sirena.org.uk>
References: <20230614122140.3402749-1-mengyingkun@loongson.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="/A+VzvD15DayBDle"
Content-Disposition: inline
In-Reply-To: <20230614122140.3402749-1-mengyingkun@loongson.cn>
X-Cookie: You are false data.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--/A+VzvD15DayBDle
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 14, 2023 at 08:21:40PM +0800, YingKun Meng wrote:
> From: Yingkun Meng <mengyingkun@loongson.cn>
>=20
> Loongson I2S controller is found on 7axxx/2kxxx chips from loongson,
> it is a PCI device with two private DMA controllers, one for playback,
> the other for capture.
>=20
> The driver supports the use of DTS or ACPI to describe device resources.

One minor thing which can be done as an incremental patch:

> +/*
> + * DMA registers descriptor.
> + */
> +struct loongson_dma_desc {
> +	u32 order;		/* Next descriptor address register */

This probably needs a __packed to ensure the layout doesn't get changed
by the compiler (eg, with struct randomisation options).

--/A+VzvD15DayBDle
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSK9lYACgkQJNaLcl1U
h9DVwwf/XbYLj9C6R6KJf+n6qkH6SmKd8327N8rN5wqMmGk3eGtuKHwLH9j4p2BV
vdvPkbcWbLiULZLXC8bpxg/KeOXTyS873qsvMoiNjqaIKKpGAuLNM1fhNrIRtgpg
dj/OBVVQg90Web2zrDiUia0uqRzU8mY/WRffRuVaiUfDBQmaHkaCEgK3cxbP6o91
WTulyQP9NVE6Vh7dcndWOpLc526CZkmOPgO7pSyGzw/n8D09nTicsP6zNb95GtHl
AxQOuu5Dun7ibJAbWKACf+VeXPYfBsg0EuR6/rIn2SrYodg39sPi5b45KL2kR/mI
JvxjCSIrK8YUePlv7O/iqHuaFsJXTQ==
=yMz1
-----END PGP SIGNATURE-----

--/A+VzvD15DayBDle--
