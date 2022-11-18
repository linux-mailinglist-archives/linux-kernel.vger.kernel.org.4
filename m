Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FF0662F99F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 16:44:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242440AbiKRPop (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 10:44:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242416AbiKRPok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 10:44:40 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC5447CBA4;
        Fri, 18 Nov 2022 07:44:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 62D80B82453;
        Fri, 18 Nov 2022 15:44:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D62CC433D6;
        Fri, 18 Nov 2022 15:44:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668786277;
        bh=lv3Ir6hqjWLfpj3JgMlunLddNrdnY2PDByb5xwuja2I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iznHYNViEZbwr2lnpESQWX8uHtsVjn4Jt1zlsrs+3aV5nwHAPVKwwrM/dLos7JdaZ
         BjH6T8H5sJXbOKtZFK64UqLjW7SOpDP7qu6pAQoBNrsg6JCo5N6/UhCGFGSgSVi6+1
         ZMwRUL4L4zXNJN21VljHkYflhgMvHvkQvQbUOMCFgTFJalMgr3QhZTMs48NGu6TA03
         SwlhqVXP4+G0Mafp0OY8RW6cAHytuAnvjQf0CZYWiUpYE5lEDd7QbwfUuYsR2dPCjz
         WqDDdbEjq4y++xLS2WhjL6xoBIzWHbCxE2GiO4NcjcPpMDFNAGZy7nSzaT7Vg0QR8S
         5jLXbt5JFCRDQ==
Date:   Fri, 18 Nov 2022 15:44:33 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Carlo Caione <carlo@caione.org>
Cc:     Kamlesh Gurudasani <kamlesh.gurudasani@gmail.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        David Airlie <airlied@gmail.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 2/3] drm/tiny: ili9486: Do not assume 8-bit only SPI
 controllers
Message-ID: <Y3eoYTZRyRJnze1z@sirena.org.uk>
References: <20221116-s905x_spi_ili9486-v1-0-630401cb62d5@baylibre.com>
 <20221116-s905x_spi_ili9486-v1-2-630401cb62d5@baylibre.com>
 <Y3YWdeTLfmDh7UyB@sirena.org.uk>
 <cd2d4d1e-f42a-da5b-e498-fbb32f792094@baylibre.com>
 <Y3ZMT4F3+3bjNXKo@sirena.org.uk>
 <e36142ec-6b7f-e667-7d6b-48234318c8cd@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="REJnauToDoQdDoiz"
Content-Disposition: inline
In-Reply-To: <e36142ec-6b7f-e667-7d6b-48234318c8cd@baylibre.com>
X-Cookie: Ego sum ens omnipotens.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--REJnauToDoQdDoiz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 18, 2022 at 11:36:27AM +0100, Carlo Caione wrote:
> On 17/11/2022 15:59, Mark Brown wrote:

> > So this is an issue in the MIPI DBI code where the interpretation of the
> > buffer passed in depends on both the a caller parameter and the
> > capabilities of the underlying SPI controller, meaning that a driver can
> > suddenly become buggy when used with a new controller?

> The MIPI DBI code is fine, in fact it is doing the correct thing in the
> mipi_dbi_typec3_command() function. The problem is that the ILI9486
> driver is hijacking that function installing its own hook that is wrong.

Ah, I see - it's causing confusion because it peers into the
internals of the underlying code.

> The problem arrives when your controller does support 16-bits, so your
> data is not swapped, but you still put the data on the bus with 8-bit
> transfers.

Why would you need to use 8 bit transfers if the controller
supports 16 bits?

--REJnauToDoQdDoiz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmN3qGAACgkQJNaLcl1U
h9D2lAf+Ps2YiMRv04FkRIpnqcdeeVJ5f9fygu+kakEWfMNpqzc+qEbwovF9SZp6
gU8YaTS6ipuPAbf5Zv8ziwDe4wgbRcBHnmegTOmSHj451Oc3q0TBvKkganCwxHFd
K1bB0cJYMmmpt4Y4OR+pyLTLoOMxJ3ADQ+yxqAZTGF5llQXxHw0/8UPhGIXLCAn3
0bTaruYqx9EATK199CVVj/oHzU31Ryj+H9pJOie8PoDBPO1eaykOAC5wiJHjU4M6
qgT29nXAt6XJw/gHnWZoKVLP0uJnJJQDEdL9Mp4y5yWoIFIXLTow1Lg+ZyadiLCm
/DtnT4366TwxKlbjqYPYdT28DOAmBA==
=URfB
-----END PGP SIGNATURE-----

--REJnauToDoQdDoiz--
