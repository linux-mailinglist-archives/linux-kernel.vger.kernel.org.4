Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FCDA741764
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 19:42:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231214AbjF1Rmx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 13:42:53 -0400
Received: from dfw.source.kernel.org ([139.178.84.217]:54786 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbjF1Rmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 13:42:51 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 395116141D;
        Wed, 28 Jun 2023 17:42:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44D93C433C8;
        Wed, 28 Jun 2023 17:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687974170;
        bh=lqDFjemWmplk7HOK0FDXsjyFPEZ6trWi4OmRwLFV/5M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Cm/4DEX2nbNEK3Lyi4lprLSxrrS6BvJE6GZxSx4V7hZoBmtsObVCdDFxffScaEzoU
         zpoKJDIHPrv6LznJN61cXRAx+tK+xTUHZGrP6fJaMg1HTTK0wrM4fjUCOD7I2707co
         4uezjJdsVDzYBI1dEV88F0nduy1MZH3/lRdNG/NzkTTKCCZ7u939C0msw9J9gnnC2/
         5J7ygqQM6/o0Fxrz+IGMxSUfY+9ttOYaWuvg/uqXTdmnAoaGiRi8mnnpX8qUArd6nd
         1MZ8an89pGr3FubGz43ikVU0pklxkUT+Y2mtsO7c7dUKdD/Z3d4qCC1tlxvpPhcizy
         ze6YsJIw1OBDg==
Date:   Wed, 28 Jun 2023 18:42:44 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     krzysztof.kozlowski+dt@linaro.org, andersson@kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, dmitry.baryshkov@linaro.org,
        johan+linaro@kernel.org, perex@perex.cz, tiwai@suse.com,
        lgirdwood@gmail.com, ckeepax@opensource.cirrus.com,
        kuninori.morimoto.gx@renesas.com, linux-kernel@vger.kernel.org,
        pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org
Subject: Re: [PATCH 2/3] ASoC: qcom: q6apm: add support for reading firmware
 name from DT
Message-ID: <bca929a1-03bd-4854-872a-07060e483d1b@sirena.org.uk>
References: <20230628102621.15016-1-srinivas.kandagatla@linaro.org>
 <20230628102621.15016-3-srinivas.kandagatla@linaro.org>
 <f71c8d2b-d5f4-42bb-932f-5b9ec6117ffc@sirena.org.uk>
 <b2aef484-71c9-5655-c1f8-ddde57687491@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Iw1MrnpkR98xnaXf"
Content-Disposition: inline
In-Reply-To: <b2aef484-71c9-5655-c1f8-ddde57687491@linaro.org>
X-Cookie: HELLO, everybody, I'm a HUMAN!!
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Iw1MrnpkR98xnaXf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 28, 2023 at 05:30:15PM +0100, Srinivas Kandagatla wrote:
> On 28/06/2023 12:53, Mark Brown wrote:

> > Why not try a series of firmware names/locations generated using the
> > identifying information for the card/system?  That way we don't have to

> There is no consistent way with the current state of what is available in
> linux-firmware and what drivers can generate from DMI, atleast with Qualcomm
> SoCs.

What's in linux-firmware now is not relevant, we can change that however
we like.

> Example for x13s has all the firmwares are under qcom/sc8280xp/LENOVO/21BX
> for two models 21BX, 21BY.

> However none of the DMI properties match exactly to 21BX or 21BY.

> These have to be either derived from product name 21BYZ9SNUS or some other
> dmi properties.

> This logic is not going to be very reliable, can differ across platforms.

But the goal here is to have platform specific firmwares so that's fine?
So long as we come up with something stable and platform specific
userspace will have the information to provide the firmware it likes,
even if that does end up involving a lot of symlinks.

> All of the qcom platforms use firmware-name from DT to get the full firmware
> path with name.

> I know this has scaling issues, but with the current state of things, its
> the only option I see.

When you say "all the qcom platforms" what do you mean, you're proposing
a new property here?

--Iw1MrnpkR98xnaXf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSccRMACgkQJNaLcl1U
h9BRrwf8DRcauWHVO26sbyrZZ2DD0opRH8+s+6Omd6fL+MKJ8WXwMYpBKHxfHWFU
2LchHvPwo+UVu/lj6qhkOM/B3RV8yt0VK1yMpjcKGEPqJWIQn6dH9lEIcnCnVmTU
dIkoxX4fd0FjNthvyVBqjuzKHkHQsaanWH6S6zz2KtDRThROD6EuaJv4ODfOGYST
55BSX3JIZ5rTOVhCsT9fMLCpK353CHOaqrO7xd4UdGDRoLYP8gNxIivjZPBBKnBy
SEAtK3SVxhNBv0xRTYivVY0yvIBjf/XyVRuDrRlllCywc9vTZRDEYT6wXFfcyQ5z
yS96KgbdGB1uTs/blOMFnzxh1peu+w==
=/Cgk
-----END PGP SIGNATURE-----

--Iw1MrnpkR98xnaXf--
