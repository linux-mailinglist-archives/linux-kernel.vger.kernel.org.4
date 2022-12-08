Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB23C646610
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 01:43:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbiLHAnE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 19:43:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbiLHAnD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 19:43:03 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8704828E20;
        Wed,  7 Dec 2022 16:43:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 18CF2B812A9;
        Thu,  8 Dec 2022 00:43:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8956C433D6;
        Thu,  8 Dec 2022 00:42:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670460179;
        bh=5+MymqbYQvxdK9QKpGYAdzjwENQ2BZKC4mTVoXHLF3Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Bpkmo0U3AUXp/1hJP1vRsNYzLkjFbML8a1fJNrqHM0SOu0/h/x4WEpplXs8ohufor
         KjDlU+zWx//zYfQpocphLBPzKYy73HInELqv3lCPnQZCum9jvaGaIrO9Cgbr+EvLLv
         SAxWfHEN3zQfCpdUuse/aRPhzivsligFlzEJwBq+BrLON3bL02eEkhqDafqA3RIORs
         c22FXGMWk7Mc1huTJyALDfSpDVismStwuzeOAZez8I0QxjR3TYUxSwoVJRHuVUUwgu
         2rYb4rPJ+V/Q4Si7HotRXJqKoKQhTBhBcqesdxhVKRlATjroTPPIAkDQmyX6ZtQHTr
         NoocYTUUxyZ+w==
Date:   Thu, 8 Dec 2022 00:42:55 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Kris Bahnsen <kris@embeddedts.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        mark@embeddedts.com
Subject: Re: [PATCH] spi: spi-gpio: Don't set MOSI as an input if not 3WIRE
 mode
Message-ID: <Y5EzD8AaAj0EGnvH@sirena.org.uk>
References: <20221207230853.6174-1-kris@embeddedTS.com>
 <Y5ElXqDduIZhIiAm@sirena.org.uk>
 <1670459801.7091.1.camel@embeddedTS.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4hWHV25Qz4zHeXzX"
Content-Disposition: inline
In-Reply-To: <1670459801.7091.1.camel@embeddedTS.com>
X-Cookie: What!?  Me worry?
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4hWHV25Qz4zHeXzX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 07, 2022 at 04:36:41PM -0800, Kris Bahnsen wrote:
> On Wed, 2022-12-07 at 23:44 +0000, Mark Brown wrote:

> > A cleaner fix which is probably marginally more performant would be to
> > make the setting of spi_gpio_set_direction() conditional on SPI_3WIRE -
> > then we won't call into the function at all when not doing 3 wire,
> > avoiding the issue entirely.

> That makes sense to me. I was operating under the assumption that 3WIRE
> mode could be switched in to at a later time via ioctl(), but with the
> death of spidev that is presumably no longer a concern.

Ugh, right, spidev.  Really even with spidev devices should probably
have the mode configured beforehand (I'm not sure pinmux will do the
right thing on most platforms...) but now I check it's part of the ABI
so we can't get rid of it and therefore your current patch probably is
what we need.  No need to reroll, sorry for the noise :/

I'm not sure why you think spidev is dying, it does still exist and
devices use it?

--4hWHV25Qz4zHeXzX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmORMw4ACgkQJNaLcl1U
h9AFoQf/dWk/njflOwqMtkBP7+OFX53BxWtrCGZMwjWfdgV1bHOnN0GVy4rPMlN5
9HggfP9qUQ8zNX/ZdDHlORNe9YMrnyY8TTjrqdwWkcQhC6IGSlR3aFL3CfLpSB1Y
0kyLwu9mMgoL07xzq6wjooyG/eLtISaBMTYwJqgeS9eCk/YzTpTY9K89DmryKVv0
yRkH/hektDnCCh3I3WJSf/OoVQfoqjEcfdP4uVF/c+uV+6yUcPLWjoO6exo/b4Vi
irjQPWbMaLTHi6Lt0n+Fa/n7I8nP2WCnsMod8jglT1faVCkNtWHoXG5970juewi8
iponvZArStFjqDE68vy+rzmZgvMPbw==
=hWr/
-----END PGP SIGNATURE-----

--4hWHV25Qz4zHeXzX--
