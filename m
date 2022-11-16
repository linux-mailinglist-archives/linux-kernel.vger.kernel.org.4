Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B08262B9F7
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 11:49:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238789AbiKPKtN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 05:49:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238977AbiKPKst (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 05:48:49 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C0F04B98E
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 02:36:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2479FB81CC8
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 10:36:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42DAAC433D6;
        Wed, 16 Nov 2022 10:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668594990;
        bh=xr0ZFEuvOSQiO5wfiC76J58bkTvGiFrjjH6PQxaZO5k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UFTePH/MoPTDEWRX890cVPfR1MHcHAFjHWdVyL5MoJaD4MEBi7RzIlCRQubyY6fCm
         XsYIu6buhSd/nmDTfe3ImvLeugaSKTDlYBdDOtKtEKoPW/E//Epgaw5AtFrHdYAaqP
         ce45TaGoBq3l/Mx7SXDFeti2ZCeKETfgTMysX7yUqkYPDGd6ykQ3ZX/xgW6tKuFWa7
         TbT9mCKMREtDuoyne8wJHsLc31hoNOCdjyn7NILrforZ90PXG2F8QU2Ilg3xR+TqOQ
         hblaWN0OYX5cfLMhlK8fUJGFR1X980yYUgkECbsox0GCjoBxIxAJo+kw9xHcScr+YK
         j/IWUIGJpVX5g==
Date:   Wed, 16 Nov 2022 10:36:27 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH 01/11] ASoC: ak5386: switch to using gpiod API
Message-ID: <Y3S9KzTE1/UQDmJl@sirena.org.uk>
References: <20221116053817.2929810-1-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="h7qtd7ThTgGLXAiT"
Content-Disposition: inline
In-Reply-To: <20221116053817.2929810-1-dmitry.torokhov@gmail.com>
X-Cookie: Ego sum ens omnipotens.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--h7qtd7ThTgGLXAiT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 15, 2022 at 09:38:07PM -0800, Dmitry Torokhov wrote:

> Switch the driver from legacy gpio API that is deprecated to the newer
> gpiod API that respects line polarities described in ACPI/DT.

> -	if (gpio_is_valid(priv->reset_gpio))
> -		gpio_set_value(priv->reset_gpio, 1);
> +	if (priv->reset_gpio)
> +		gpiod_set_value(priv->reset_gpio, 0);

How are we ensuring that people have described signals as active
low/high in existing DTs, and are we positive that the signal is
described as active low for all devices?  In particular if the
signal is described as a reset signal then it's active high even
if we want it low while the device is actually in use.

--h7qtd7ThTgGLXAiT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmN0vRkACgkQJNaLcl1U
h9D1rgf/VLoZNVdVmRG2xIS1Qw17P/t1wYsB8UVBspaMvTjSNSnjGcwv5z+bOOpF
WgMWL7VxfEBieL54y6eF3uKjxqj/2RbHVuFazbkfr47QTTIpzECfPe978XbGdsop
FA9NZ58iFXc/4HhB5bTzFsPMt5qSm/5U6+fvsc94ZQzqkHibUx1oTcKWcvlY+Mqo
VRNl4x9SCsmgLWpHPxictCmvqom2ihFK8qVZuZ/DZ+8p7FS6htHSfQ5+w7pidevq
hzZRm8phlVdEMmWAUdYmpMIg4KnJyl13S4WeG5Px2ooSzJ36ERfpVdUrNzbgdlsT
qshHayqjcdk5o0yIMlQ8bKHYN+SFTA==
=uraK
-----END PGP SIGNATURE-----

--h7qtd7ThTgGLXAiT--
