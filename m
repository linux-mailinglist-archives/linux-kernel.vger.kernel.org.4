Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ADEE62D8BF
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 12:02:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239768AbiKQLBx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 06:01:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239647AbiKQLAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 06:00:40 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 004BB1C7;
        Thu, 17 Nov 2022 02:59:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7F8BCB81FF4;
        Thu, 17 Nov 2022 10:59:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C113CC433D6;
        Thu, 17 Nov 2022 10:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668682794;
        bh=FTcXBVf4xKuIE7vas46JjAXZsr5dkNSkrqRgK59BR3E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j3aCJYHiEH9yeDG4sHk7/Z9AsxDyOnRrOuUaaPmyFhDe4xZ7640/EoC+qQ21H+kXH
         08J0YkV0AvOWwkIZgeORvNcR7+Thk9/gFhQ+j/07CgdiSiqgHT9sIkpbJnlNSmSYy7
         F0s+Lkp/tCo9flUPLLLEOsKv77nTk0+dt8r9HQwPWNuFFrKmTl0g1PmuMnTR1dHuFK
         +EIKV6Bz/yqgXNyld4b+aneK1HPLhq8HFjHJiNQnrXiCMqPg/W7GwFnmcAzJ9Q24D4
         g/OdUB4RLlrAVnEBDmQqm2/TGfn+5SaqpKMM4hfxrlG03xxcvz/cnqRwwzEEYNWBF6
         8Rz0l/MIOY8Kg==
Date:   Thu, 17 Nov 2022 10:59:50 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Carlo Caione <ccaione@baylibre.com>
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
Subject: Re: [PATCH 3/3] spi: meson-spicc: Lower CS between bursts
Message-ID: <Y3YUJjSTI9U9qz59@sirena.org.uk>
References: <20221116-s905x_spi_ili9486-v1-0-630401cb62d5@baylibre.com>
 <20221116-s905x_spi_ili9486-v1-3-630401cb62d5@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sVW5maJnbV5GYFNa"
Content-Disposition: inline
In-Reply-To: <20221116-s905x_spi_ili9486-v1-3-630401cb62d5@baylibre.com>
X-Cookie: Ego sum ens omnipotens.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--sVW5maJnbV5GYFNa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 17, 2022 at 09:47:41AM +0100, Carlo Caione wrote:
> On some hardware (reproduced on S905X) when a large payload is
> transmitted over SPI in bursts at the end of each burst, the clock line
> briefly fluctuates creating spurious clock transitions that are being
> recognised by the connected device as a genuine pulses, creating an
> offset in the data being transmitted.

> Lower the GPIO CS between bursts to avoid the clock being interpreted as
> valid.

This is just plain broken, *many* SPI devices attach meaning to
chip select edges - for example register writes will typically
have the register address followed by one or more register values
for sequential registers.  Bouncing chip select in the middle of
transfer will corrupt data.  If the device can't handle larger
transfers it needs to advertise this limit and refuse to handle
them.

--sVW5maJnbV5GYFNa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmN2FCYACgkQJNaLcl1U
h9BA1Af9GvKfza2vtRbu0JnM9pTzjygGkt+vf4n801Z7oafMH+9AsCMpa4yyr7Dq
zhMWNsKInloF+p+FGqJUx6iky4xR83YXfpR1dzXn9xh27MNjYMSvH9MgbDLKKPyZ
TG+uVFrFsaus8eR7mzZw80l7KCiw6ypiGWh5o+qtO7UWGCVnbcwl1NeD0RDolNE+
tmRoPMEoZohX3XIGL5NGihK0buq/ZFq4EkrpUK7mfJ5kHSCwtX7O4ZR4SUI2VB8g
WiLut2anQJ/MgXPdHnhKdrY47fwGRDi3TCI88Le+mb2gc3iUAf4r1rdqviUnMps7
6nf/3APDiJ0vw09mztpBv8KT1ASrrg==
=atc7
-----END PGP SIGNATURE-----

--sVW5maJnbV5GYFNa--
