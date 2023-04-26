Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37A666EF532
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 15:11:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241108AbjDZNLO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 09:11:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241099AbjDZNLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 09:11:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ADA444A1;
        Wed, 26 Apr 2023 06:11:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2AA1263693;
        Wed, 26 Apr 2023 13:11:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18171C433EF;
        Wed, 26 Apr 2023 13:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682514663;
        bh=0Xy4nfIjtJp9Ml67azA3/rEsuiUldnZOda9YJckRL0w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=olqP/0CYbO6RV1mZZfd5wgF1ZG6oXWzG1GxOL6fpgX0kb4iqze2KThTDN/1k7iaio
         KxcG4Fyx58Z/secfCtV/MtLsBlooInaFl00h1CsH/c5ZBG6kwIvh6zJpkMUAkR25Gw
         Sjwe/KbiexTvbpaGdWD3HvIeCe09QGOgZ6Q/iToUAVHQ1IyPjnEnz1vHIVwMJsiACy
         4nKL7Y9KPzK6g/y3g+ESWdUsCAn7JE+zQF6Nlq8u+r9SbzR7+TrOg30mLtznEmuCVR
         7v6pu3MRv/5eX23b1VPV/E0a8qscrWtDFRhx3IIqwsvXcCV49LaCpqjLKHNjNPzL1d
         e4jC/7XDJCQHQ==
Date:   Wed, 26 Apr 2023 14:10:57 +0100
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
Message-ID: <38eef5df-ca8d-41f1-93e7-e13c1d7b6232@sirena.org.uk>
References: <20230425134527.483607-1-linux@rasmusvillemoes.dk>
 <706c591f-4800-1b96-52c0-37b5f6de7623@rasmusvillemoes.dk>
 <fd22bfc4-b019-4445-acc5-f7902a2386fe@sirena.org.uk>
 <9f403dd7-1ac8-bebe-1b24-bede61087bba@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rBlslG3Mk26QI9iP"
Content-Disposition: inline
In-Reply-To: <9f403dd7-1ac8-bebe-1b24-bede61087bba@rasmusvillemoes.dk>
X-Cookie: Drilling for oil is boring.
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rBlslG3Mk26QI9iP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 26, 2023 at 02:47:44PM +0200, Rasmus Villemoes wrote:
> On 26/04/2023 14.25, Mark Brown wrote:

> > I'm not sure this is sensible, it'll be a fairly rare situation and we
> > don't want to preclude using the built in chip select functionality for
> > some of the chip selects.  In a situation like this we only need to have
> > a single chip select to be managed as a GPIO rather than all of them,
> > which I'd expect to end up handled in the DT by not allocating that chip
> > select number.

> Sorry, I don't understand what you're saying. What exactly is not
> sensible? And what is "a situation like this"?

Building hardware which uses all the native chip selects and also GPIO
ones and then describing it in DT as using native chip selects.

> I described a problem with what is now 87c614175bbf in linux-next: If
> one has five spi devices, the first four of which use the four native
> chip selects, there is no way to use a gpio for the fifth, because
> whichever "channel" you choose in the CHANNEL_SELECT field will cause
> the ecspi IP block to drive some SSx pin low, while the spi core is also
> driving the gpio low, so two different devices would be selected.

Sure, and therefore I'd not expect anyone to actually describe the
hardware like that but to instead describe the hardware as using three
or fewer of the native chip selects with the remaining chip selects
described as GPIOs.  If the device requires that a native chip select be
controlled the hardware simply won't work without at least one native
chip select being unallocated.

> It's not exactly a regression, because any chip_select >= 4 never
> actually worked, but what I'm saying is that 87c614175bbf also isn't a
> complete fix if one wants to support mixing native and gpio chip
> selects. For that, one really needs the unused_native_cs to be used for
> all gpio chip selects; in particular, one needs some unused native cs to
> exist. IOW, what my series tries to do.

No, we only need one unused chip select to be available.

--rBlslG3Mk26QI9iP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmRJIuEACgkQJNaLcl1U
h9BgiAgAgkYHH4s+VEMVE8lt5FDgOcuKDX8OAJoS7brgBVg5qntDfktjQXgiDifW
oNV/buBUQEELmDjDo0dDe85fl9KIPh49UWm0Y5JolLPrLHKelP7u4LxV5UmaeDqE
AngjdjlIhyTDA0Zlm6dodSpypMBoIdAePBWccNFNGH2qvAeFyuz0wtlz3BJnqifK
Jvrncz1yMFu/AtBXlKCnQ3Tm2O6Mb+e7W2wm9DMdhiWESUNHeCCly2MCtxoYGOts
oWAqc1OvwoQiPMGxzA/amDkv4/JTHw4PbM1/mEQUPS1h+ftYjbw+o4JfO0TezTut
URvN7vCEPokYufiNl/IW0dsvbZ3/NQ==
=5+FJ
-----END PGP SIGNATURE-----

--rBlslG3Mk26QI9iP--
