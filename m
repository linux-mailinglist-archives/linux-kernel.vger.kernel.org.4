Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90F1E6C2313
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 21:44:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbjCTUoo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 16:44:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbjCTUoi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 16:44:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FC133754A
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 13:43:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 38BAE617E1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 20:43:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36111C433D2;
        Mon, 20 Mar 2023 20:43:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679345030;
        bh=4A/kaxf1QABlVJo5RDUirZ+pZId2W89U9ANAnoVHmrk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WnQ7RzwCrP+QBck7FNLyWYmo/Dkl8dFJwPwqzqy8QGKelJ9pRu/xH+2TOT/p8W1Nj
         JqG9xE24FJrhPgsFYddfN9VuimMqjk/4cGftBLedTePkHSGN2UZzalZyw/9srAMlEp
         xAdt9biFZ57sglbIqJ2Yg4g5gk0BJkZ2HoQ+lGZ4D7DNfIEepF/NSlpxjbhekkMnLE
         b8IVsTIKZ0DQbiaj3oIoDmOxP4Yunh4CcavcWcbchc2RaT7x03JsswsIS9sS/E+ODH
         xfmwJVEGAdb8ve9NKMirygrEvrY17pRy2Jht5+rOgiSXjRRCjjKQFPJljzwBzxBC3U
         2eM2U7VmoVvDQ==
Date:   Mon, 20 Mar 2023 20:43:45 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Marian Postevca <posteuca@mutex.one>
Cc:     Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH 1/4] ASoC: es8316: Enable support for S32 LE format and
 MCLK div by 2
Message-ID: <6825a54e-f2c0-41c4-981c-fafcd10454fd@sirena.org.uk>
References: <20230320203519.20137-1-posteuca@mutex.one>
 <20230320203519.20137-2-posteuca@mutex.one>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="I8SYPlSVeAQJbM4T"
Content-Disposition: inline
In-Reply-To: <20230320203519.20137-2-posteuca@mutex.one>
X-Cookie: Keep away from fire or flame.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--I8SYPlSVeAQJbM4T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 20, 2023 at 10:35:16PM +0200, Marian Postevca wrote:

> To properly support a line of Huawei laptops with AMD CPU and a
> ES8336 codec connected to the ACP3X module we need to enable
> the S32 LE format and the codec option to divide the MCLK by 2.

The 32 bit support and MCLK division are two separate changes so should
be two separate patches.

> -	lrck_divider = es8316->sysclk / params_rate(params);
> +
> +	mclk_div_option = device_property_read_bool(component->dev,
> +						    "everest,mclk-div-by-2");
> +	if (mclk_div_option) {

This introduces a DT property but there's no documentation for it, but I
don't see why we'd want this in the bindings - the driver should be able
to tell from the input clock rate and required output/internal clocks if
it needs to divide MCLK.

--I8SYPlSVeAQJbM4T
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQYxYAACgkQJNaLcl1U
h9CX8gf/RmwyEoVVmr3aQ8Bp4SWGDyii+5RBC0xwiRgZWpgWzB4Dc2tmrAiPwu/S
DlPYvD699CAaluybZtEVr0GDyLE2ijsmd3IlNH41Zv7/EU5zh3pf/9nHwCz7c5XA
0IUONdpeqhsaGivX+mgCnKsDuNRM3Vglfw3RziTKVm8BmwKBYxMTgOQ2C4dB4wb1
YSHPdUE8x5gj7Ft5UMUPUqRNhFJX2+mA6VNtDR2P5YG2guKPrZGPIcNgtViqEfkU
ZA7U0mOvHZQNgqrM6C+XzBLH2nIXTI1IlCSAW5/XFFaD75yTwn+rmpuSe+EnjXRs
qd7ochD5wURL1ibYOSHqOrZnAqDhRg==
=+ZJZ
-----END PGP SIGNATURE-----

--I8SYPlSVeAQJbM4T--
