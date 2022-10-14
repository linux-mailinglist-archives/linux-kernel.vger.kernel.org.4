Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87F965FEDC9
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 14:02:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbiJNMCf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 08:02:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbiJNMCb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 08:02:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BBFA18F92C;
        Fri, 14 Oct 2022 05:02:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 07F3D61AC1;
        Fri, 14 Oct 2022 12:02:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 673B3C433D7;
        Fri, 14 Oct 2022 12:02:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665748949;
        bh=kVy31r3/h21vCG8QHqLh13ALXicMXU3nisOAYti+Q5k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OSs8wt76NzBNkq27S7FBfulQrBeTLcmu6r1j6QUFhDoEqWgg5gF6iOlPlRy6Ca89D
         gk2jDUIN+ygSCA3HfY4mLsG3HKbhwSeywdB2FFsn0AAoExAkyl1adgOynbqiOk/17O
         6sLobr1OU2h9vmaP9XWtmazxiUSX1SuVYbY6nUGBDbWeYmeXb286S8ObQMuRvpuD5s
         jEOeTTuJJLvVsWsbLY0lrpWptf2LiK91Ts1WbEUVMeqjitKu9fxZXS73cUHhQnaYc7
         oWB0cZYHTqnOhyIkUlszA65A1QvCeCC8LEKBt8HbzPcMPAqcpqZL2Cv2hkZpvI3qbd
         lOPAvB/k++TYQ==
Date:   Fri, 14 Oct 2022 13:02:23 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Padmanabhan Rajanbabu <p.rajanbabu@samsung.com>
Cc:     lgirdwood@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, s.nawrocki@samsung.com,
        perex@perex.cz, tiwai@suse.com, pankaj.dubey@samsung.com,
        alim.akhtar@samsung.com, rcsekar@samsung.com,
        aswani.reddy@samsung.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH 2/6] ASoC: samsung: i2s: configure PSR from sound card
Message-ID: <Y0lPz91gbovAub9D@sirena.org.uk>
References: <20221014102151.108539-1-p.rajanbabu@samsung.com>
 <CGME20221014104857epcas5p2a275a1d606ca066227228d13bcf5b120@epcas5p2.samsung.com>
 <20221014102151.108539-3-p.rajanbabu@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="/9qwgKi0P7NmZJOz"
Content-Disposition: inline
In-Reply-To: <20221014102151.108539-3-p.rajanbabu@samsung.com>
X-Cookie: There's only one everything.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--/9qwgKi0P7NmZJOz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 14, 2022 at 03:51:47PM +0530, Padmanabhan Rajanbabu wrote:
> Currently the prescaler value in samsung I2S dai is calculated by
> dividing the peripheral input clock frequency with frame clock
> frequency and root clock frequency divider. This prescaler value is
> used to divide the input clock to generate root clock (RCLK) from which
> frame clock is generated for I2S communication.
>=20
> However for the platforms which does not have a dedicated audio PLL as
> an input clock source, the prescaler divider will not generate accurate
> root clock frequency, which inturn affects sampling frequency also.
>=20
> To overcome this scenario, support has been added to let the sound card
> identify right prescaler divider value and configure the prescaler (PSR)
> divider directly the from the sound card to achieve near accurate sample
> frequencies

It's not clear to me why the solution here is to move the configuration
to the sound card rather than to improve the I2S driver to be able to
cope with whatever the restrictions are on the PSR in these systems - it
seems more cumbersome for system integrators, especially since you've
not documented the issues or how to configure it.  Could you expand on
what the constraints are here and why it's not possible for the driver
to figure things out (given some quirk information)?

--/9qwgKi0P7NmZJOz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmNJT84ACgkQJNaLcl1U
h9DRTwf+J9Be15r7sAl4i8Dde8zTmse0pnZWcotDM9pbxNNsJ1iutdxRsMnVlQuJ
9HavNjMp/3R7o6I3cIMB8ssa+EEaSLYDp8NzgDFhog/37cUV0whEBD6J7CRq1NRm
pmN7pQkbvhvgK1M7y87LDhliNEYfVeRIkZR1Rk71ncNurfT5MLwYZNwuUcvmXpwG
hkvgjy15llDZwcMT6Phj7VPmubu1MKGKhkLXQJLNKJFYD36NoSWI8qK6ID17RrQl
JGMpowz32/S0oIjmLkWgPpf1upirFZC/nL4YO/mbYoDF5jUYsFPxAXD2MmRv8Bue
7y5v0drOp0Cq70TJFJ3xkEb8CWA4ng==
=sCvP
-----END PGP SIGNATURE-----

--/9qwgKi0P7NmZJOz--
