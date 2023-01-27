Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9BF867E512
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 13:23:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234170AbjA0MXa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 07:23:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234178AbjA0MWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 07:22:35 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBEDC2529E
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 04:19:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5140B61B60
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 12:19:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 428F0C433EF;
        Fri, 27 Jan 2023 12:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674821993;
        bh=zubF5hxw2biY59REpSIQyi1MVq2TZX3yBWHzKJcHgsY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CA4az619VNsroI1+L26WMX2G37XeSavKkuoJzogafx38KlJ07A2APA7bH+hz+rJrL
         aZ017taa/gKy9u+SmYkhznbAESEvYUUhBrR8S5HC0RZFbekRluVn5LxzN9F8ZseVpP
         DczKpLZ/eSTwxjt66B9UnrCWftC2PZWaQgudNlwozg9Iq2LPx8uN7W+JbnWy2DwSh/
         /dS1h+Xx02psOZipb1AJf2yqZULODekGVE3YUthR7miXEKLu2gdXX6OtZwKvuqShSr
         57FgsvYi/3rz4b2Psz8KyRpMqtK1igzH6OCgwjD25rt+LF4dV7V9TlUiZif54iUC1Q
         meu2OU96+hktw==
Date:   Fri, 27 Jan 2023 12:19:50 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Astrid Rost <astrid.rost@axis.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, kernel@axis.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] ASoC: simple-card-utils: create jack inputs for
 aux_devs
Message-ID: <Y9PBZjkW7Nrsg4j9@sirena.org.uk>
References: <20230123135913.2720991-1-astrid.rost@axis.com>
 <20230123135913.2720991-3-astrid.rost@axis.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fuFuiNw5hNV4x0Gr"
Content-Disposition: inline
In-Reply-To: <20230123135913.2720991-3-astrid.rost@axis.com>
X-Cookie: Serving suggestion.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fuFuiNw5hNV4x0Gr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 23, 2023 at 02:59:12PM +0100, Astrid Rost wrote:
> Add a generic way to create jack inputs for auxiliary jack detection
> drivers (e.g. via i2c, spi), which are not part of any real codec.
> The simple-card can be used as combining card driver to add the jacks,
> no new one is required.
>=20
> Create a jack (for input-events) for jack devices in the auxiliary
> device list (aux_devs). A device which returns a valid value on
> get_jack_type counts as jack device; set_jack is required
> to add the jack to the device.
>=20
> Signed-off-by: Astrid Rost <astrid.rost@axis.com>
> ---
>  include/sound/simple_card_utils.h     |  3 ++
>  sound/soc/generic/simple-card-utils.c | 49 +++++++++++++++++++++++++++
>  sound/soc/generic/simple-card.c       |  4 +++
>  3 files changed, 56 insertions(+)

Given that everyone is really supposed to be using the
audio-graph cards for new systems this should be hooked up there
too.

--fuFuiNw5hNV4x0Gr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmPTwWUACgkQJNaLcl1U
h9D7mwf+Igj87QjF+3lzDf5KS/kImXkgHpOujb/L88hKqV2wmVR20+aOYXJ3l16/
o88NNDzo9WM7DCHi3x/RrJT5ezFuMsxufIO5zd+dwlnAailGOLBObwM6Mc1O7xPU
TWf+dfkS07QDZ4vs3+UWhRvQ4dcn1QskWFnjmnqNg7sDzmID3thA8ekDSsHtpSlF
OUgBaJpaRB8d7C/iT4cHmmJ9F0lhdivdk51D50PFwFD9JLfsphSygZA8eD3nA5BH
DaskyGe9RJM2bWvNk99dNjIf/QUKmtWChBaCZ5D8+6o1Iwr/ocQqeajo61vfO18d
1e3oqNMZ8X1w70OurF3732GlTToDHQ==
=2ZBv
-----END PGP SIGNATURE-----

--fuFuiNw5hNV4x0Gr--
