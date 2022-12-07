Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FEC264654E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 00:44:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbiLGXoi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 18:44:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbiLGXog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 18:44:36 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D85388565C;
        Wed,  7 Dec 2022 15:44:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 76BB061CFD;
        Wed,  7 Dec 2022 23:44:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF14BC433D6;
        Wed,  7 Dec 2022 23:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670456674;
        bh=vzFgktuwaRPidWb2pU12cG5dAs7LJ+oJf2cZXi+LxTI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MfQDnXLUfgTMPTxCYCpzvXC+bUdxJGgb80VCx1DLHpAdJs2CV4KfymvzvO+WABwCy
         3qIKnUm/Ux/kout40G7r9tA1qVUYd6OCukGhraq+FaAzpQ1EydVJdyYp/eprKGm6/3
         fBkd/OFz2tLketcozQhKJ1O4P/jkrnJ1xZrmME7TXNSGbgtHVl5BZ2kwtRxcjiNZJl
         Bx8nyC2m6TYRkKRx69He3W+h/Olb0VD1MXE4ryPDV3pzIXIrCK8DrspEQ+rEUsLoc5
         CybVG6Hv1H0HTRFJFli1+YmNSkvChh8fDkxDI9oPjP7PZcWOapRaUXrXaA4HKgVOfk
         3+1bbrbJfOsGw==
Date:   Wed, 7 Dec 2022 23:44:30 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Kris Bahnsen <kris@embeddedts.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        mark@embeddedts.com
Subject: Re: [PATCH] spi: spi-gpio: Don't set MOSI as an input if not 3WIRE
 mode
Message-ID: <Y5ElXqDduIZhIiAm@sirena.org.uk>
References: <20221207230853.6174-1-kris@embeddedTS.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="56KIyPEz17IU8OgZ"
Content-Disposition: inline
In-Reply-To: <20221207230853.6174-1-kris@embeddedTS.com>
X-Cookie: What!?  Me worry?
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--56KIyPEz17IU8OgZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 07, 2022 at 03:08:53PM -0800, Kris Bahnsen wrote:
> The addition of 3WIRE support would affect MOSI direction even
> when still in standard (4 wire) mode. This can lead to MOSI being
> at an invalid logic level when a device driver sets an SPI
> message with a NULL tx_buf.
>=20
> spi.h states that if tx_buf is NULL then "zeros will be shifted
> out ... " If MOSI is tristated then the data shifted out is subject
> to pull resistors, keepers, or in the absence of those, noise.
>=20
> This issue came to light when using spi-gpio connected to an
> ADS7843 touchscreen controller. MOSI pulled high when clocking
> MISO data in caused the SPI device to interpret this as a command
> which would put the device in an unexpected and non-functional
> state.

A cleaner fix which is probably marginally more performant would be to
make the setting of spi_gpio_set_direction() conditional on SPI_3WIRE -
then we won't call into the function at all when not doing 3 wire,
avoiding the issue entirely.

> As an aside, I wasn't sure how to best put down the Fixes: tags.
> 4b859db2c606 ("spi: spi-gpio: add SPI_3WIRE support") introduced the
> actual bug, but 5132b3d28371 ("spi: gpio: Support 3WIRE high-impedance tu=
rn-around")
> modified that commit slightly and is what this patch actually applies
> to. Let me know if marking both as fixes is incorrect and I can
> create another patch.

That's fine, it doesn't really matter either way.

--56KIyPEz17IU8OgZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmORJV0ACgkQJNaLcl1U
h9Be+Qf+MxW4hMRQzDRJd9NFAhwkIiirk2ELo1vuSbRGPl/593kSW6wvsgXW+0zG
EWFNMMbJ0cJqDUbCxSOGAC9MCg0Rg6gDoFeFf0JLWzB1A6a7bRQ/jkzUqyQV/R0H
LqCAaAPvqFseiYJmoIinWc6Qb/5ANNC9/VEt6wFNefFY4gXDcqQBS2ccN29cay62
2I6rfBf3646lDLVbZOpJe00HKwn0mJV7Ga8Amol6lNu8qrVHXlgXOJz6rJggTI+T
FbGtaTtzYwwBCGj9najlZKH0R1UVY+cdqnkBwGLwymyR6534+kDIGqG6D9d/dtx7
J9Ftqf+gqMSYxLpSAweFLrRGJHbtAg==
=zBN5
-----END PGP SIGNATURE-----

--56KIyPEz17IU8OgZ--
