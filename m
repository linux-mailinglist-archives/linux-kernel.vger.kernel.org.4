Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C3DC6EF439
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 14:25:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240845AbjDZMZ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 08:25:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240277AbjDZMZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 08:25:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6765E1702;
        Wed, 26 Apr 2023 05:25:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F39A362EFC;
        Wed, 26 Apr 2023 12:25:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92572C433D2;
        Wed, 26 Apr 2023 12:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682511925;
        bh=vuJL6yCTBAU/JeYidaeHQ1VVVOlHKOhea8HHqq/kUFE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FBLiatJcUp5pyQtsxwYdz/RtxnIhOdF3qSezRm8fR7bNiL/Yiz771S+DxknmhXIM0
         Qqd9av/VX3r+qT9WJDYmXfCLfcqXGGJOr1ncxad2Q/qTSF6PTVJLWdtH9IR4MSUYG6
         62C0T3RmlKvzgtWjhCiW83LTv8ZL7onaqEOxq6/pEQ0YzF4qt04Ui+2SZ5HIY+2ZYO
         wXOjZkymI9DoPggtx1QAxH8HGwyqhR5VsI498AOicGup2B4J5Ai54j2Gyr1mj7SRBb
         Mkx8YLuxTBamtmT3yXGjM35TZ+ESStNJK8bPwUW5tAXTdnZPC7uDYZb1UetICaXw7B
         aHegbFJwOEh7w==
Date:   Wed, 26 Apr 2023 13:25:18 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Kevin Groeneveld <kgroeneveld@lenbrook.com>
Subject: Re: [PATCH 0/3] spi: spi-imx: fix use of more than four chip selects
Message-ID: <fd22bfc4-b019-4445-acc5-f7902a2386fe@sirena.org.uk>
References: <20230425134527.483607-1-linux@rasmusvillemoes.dk>
 <706c591f-4800-1b96-52c0-37b5f6de7623@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mTo1aoA7l1FLU+ZV"
Content-Disposition: inline
In-Reply-To: <706c591f-4800-1b96-52c0-37b5f6de7623@rasmusvillemoes.dk>
X-Cookie: Drilling for oil is boring.
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mTo1aoA7l1FLU+ZV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 26, 2023 at 09:19:29AM +0200, Rasmus Villemoes wrote:

> I did consider that approach, but rejected it because it wouldn't work
> with mixing native and gpio chip selects. Say, somebody uses SS0
> natively, but then also have four additional gpios. Then chipselect 4
> would end up activating both the SS0 pin as well as the gpio, selecting
> both devices.

> I don't know if that's really a realistic scenario. But at least I think
> the driver should then somehow have a way to indicate to the core that
> one should either use native or gpio chip selects, but not a mix.

I'm not sure this is sensible, it'll be a fairly rare situation and we
don't want to preclude using the built in chip select functionality for
some of the chip selects.  In a situation like this we only need to have
a single chip select to be managed as a GPIO rather than all of them,
which I'd expect to end up handled in the DT by not allocating that chip
select number.

--mTo1aoA7l1FLU+ZV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmRJGC0ACgkQJNaLcl1U
h9Cv9gf/XCK1SyOxyzEOvuhk1i/JyK/WG1acRj2U9uzscWVynOdWLKdJep0MUfTy
AWhKbbp2728bYltDXZ5tyZo2CgEGPuLmeW1+YkeCmuBDTI3SMvIkaRX33m1eGcqd
JN6MDhEnA7ZlTxIXr+6YzuOZESrwMA9LqY1pJ2uyI5TgKs/mPaAiraa9ciHT60Nk
tgaEyKYybP/4xdjUIHIe7bExMBm2FmFT6u+k1g194y8mszimefiU0SKtaFM2UcWc
+96gmYUT5fqQrYM0OgfvJdLrOO72a2DJ6rH5c28/sYWi2g1p6SzGf3PlhHvL/k9S
t7VhpyKXhsJdpqIpnFKVfEuC5xFavg==
=eTNG
-----END PGP SIGNATURE-----

--mTo1aoA7l1FLU+ZV--
