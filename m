Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81EF069F4DA
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 13:49:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232113AbjBVMtC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 07:49:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjBVMtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 07:49:00 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A22723403E;
        Wed, 22 Feb 2023 04:48:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 307486144D;
        Wed, 22 Feb 2023 12:48:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5792BC433EF;
        Wed, 22 Feb 2023 12:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677070138;
        bh=Hnp1Jwu9a8CBmgHckfMcvqLnlFg+60GtQkHlfuuu4UM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hTs3a7BUk/Nbbt7ZCtxnH5AzJUD9CwXzx/fa2JCsiRupAbEazktCTpkK27LiGmmIi
         JAfEzaS+YjFEbEmVUKyGmge7+f7h2DAP4cIs9WkJWQrR/TVycOTKkDe+hkpqaG9TR+
         ah3RT1bT7VaC04VQrR+Ovh9lOMuObvXQleEQ2NWnVbZA9CcYdXB+y2PueBs8W1XhGM
         +2VhFWnGS4/9Xm5uLM2YzmJk3+mFQENMrBGVS5tgGdHmNGefg214Fq6MPYv1WhstX1
         c/IUw/8zCj+foWAnTCxZDL9Ybb8df5iHJScrsyQLLR9dNF0skmcKeiARPyP/kFfHra
         QufM2s3fRcH+Q==
Date:   Wed, 22 Feb 2023 12:48:52 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Chancel Liu <chancel.liu@nxp.com>
Cc:     lgirdwood@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, perex@perex.cz, tiwai@suse.com,
        ckeepax@opensource.cirrus.com, patches@opensource.cirrus.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 4/4] ASoC: wm8524: Delay some time to follow power up
 sequency
Message-ID: <Y/YPNMGMZcVZs3xy@sirena.org.uk>
References: <20230222113945.3390672-1-chancel.liu@nxp.com>
 <20230222113945.3390672-4-chancel.liu@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="GFX2+WHXFfiKPtak"
Content-Disposition: inline
In-Reply-To: <20230222113945.3390672-4-chancel.liu@nxp.com>
X-Cookie: My LESLIE GORE record is BROKEN ...
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--GFX2+WHXFfiKPtak
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 22, 2023 at 07:39:45PM +0800, Chancel Liu wrote:

> +	switch (cmd) {
> +	case SNDRV_PCM_TRIGGER_START:
> +	case SNDRV_PCM_TRIGGER_RESUME:
> +	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
> +		mdelay(wm8524->power_up_delay);
> +		break;

Doing a 100ms busy wait in atomic context does not seem like a great
idea, never mind a 1.5s one.  This shouldn't be done in trigger, it
needs to be done later - digital_mute() might be a better time to hook
in, though longer delays like this are really quite bad.

--GFX2+WHXFfiKPtak
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmP2DzQACgkQJNaLcl1U
h9B3UAf/THImSrqx7z6IC2WFRk7sBUql5uJGOLV4wYzC9y6CzkSA4y7OjKr5SeAh
hP0yz3ExyBKe0G/DeBDvNTgouGS2PpgJFJBF8pfJGdQF+W3jD+ofej8az6J4Taht
OzztOwq5nttxTqgvuup/jrWDiavqbPYVJ2JtEdAbRatyC0B7BzU+lhljOqBOfZw7
xIFHIc1x6y0r+HD35UAda4KTcSb+/5kVRPQessl8HnvZUYo2MaqGialfCMmDFR9g
4ncQI+QQcacYlDqvpH3OsnYqoeWq1mubJWFdmYA6WGNOPfBrIV2ZkBE9wc2xWa57
xITgsctHqcDMIwWAQaQb4i+PLkV7wg==
=SxJQ
-----END PGP SIGNATURE-----

--GFX2+WHXFfiKPtak--
