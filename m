Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F08FF6377C0
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 12:36:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230162AbiKXLgE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 06:36:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230158AbiKXLf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 06:35:58 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97207976C9;
        Thu, 24 Nov 2022 03:35:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2C834620EB;
        Thu, 24 Nov 2022 11:35:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52A01C433C1;
        Thu, 24 Nov 2022 11:35:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669289756;
        bh=TogMFt68iAhnVUJFSxWaOLgAHnp4lsnQ3MKEsm5atos=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rlA0ZA3Dpv8H60wDEUFJwlcAExv1GwsPujyRYiVi7pfXW8CaXCfmIvkZ7YlkOxU3C
         68Gjzz9zmhapDy5AxpwRrIEZUqfIvlOKcGxBXwQw/c+itC/ekCXJmpwLikInbZIIwl
         V+Wk4/7Afts9igGZ11JqYDWz415xh6OjnB499mPRuMAKVbELrr8hDP60tl6hKE/P7x
         AF+3znzg0taw2g2fPahWDhLXNHYQ34lAxJRdu9F56xa0pmv3+LLxvCSTwAMC8bA53F
         4hO48+bI+y/84wNxbZCy3QJ8DrN/T+ZtR/kfJxOKE0x23J1dtGnFo3g3/DDDfwDjc2
         spb7aVQE7JBfg==
Date:   Thu, 24 Nov 2022 11:35:51 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Dhruva Gole <d-gole@ti.com>
Cc:     Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
        greg.malysa@timesys.com,
        "open list:SPI SUBSYSTEM" <linux-spi@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] spi: cadence-quadspi: Add upper limit safety check to
 baudrate divisor
Message-ID: <Y39XFzYJL3EmxSFF@sirena.org.uk>
References: <20221123211705.126900-1-nathan.morrison@timesys.com>
 <9e5264fa-db1a-ed96-5fd8-cbfa4694b8bd@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lnq7tpudOIivlUPp"
Content-Disposition: inline
In-Reply-To: <9e5264fa-db1a-ed96-5fd8-cbfa4694b8bd@ti.com>
X-Cookie: Apply only to affected area.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lnq7tpudOIivlUPp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 24, 2022 at 12:16:10PM +0530, Dhruva Gole wrote:
> On 24/11/22 02:47, Nathan Barrett-Morrison wrote:

> > +	/* Maximum baud divisor */
> > +	if (div > CQSPI_REG_CONFIG_BAUD_MASK)

> I don't think comparing "greater than" with a MASK is atall a good idea.

Why - it's checking that the calculated divisor can actually fit in the
relevant register field which seems like a totally normal thing to do?

> Again, I don't fully understand your situation is as in
> what is the peripheral you are using. So please elaborate on that.

As far as I can tell the issue here is that the device is asking for a
rate which requires a larger divisor than the controller can support but
the driver doesn't do any bounds checking so it just writes the
calculated divisor out to the hardware, corrupting any adjacent fields.

In this context the SPI controller is a peripheral within the SoC.

> Importantly, I would suggest that you _NEVER_ compare ANY value to a
> MASK Macro. MASK Macros are meant to MASK bits.

It's very common to also use masks to identify when values have
overflowed the values that can be written to a field.

--lnq7tpudOIivlUPp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmN/VxcACgkQJNaLcl1U
h9BMpgf/cLsAMTa2AU1EcDgf6Rm2h9wt/E0cD5OwpVV+MrTVABVz3uKgDoNYwfxE
ka2++YyWBIzhbbKtdnvYhBmyeipb+uHTuGkx5+MCZT37sVjJhM3OB87Lja3xzBMD
bzpgTL5D00f4AWPwB3sI4QaU8IzjiaBWZ0vSEaSpMDHHq6y2miWn1q53JcluAZ3A
+ihJvhoFI3c8dO3PfXG8M8nnqD92X9HQpd0URp/4wAszq4RJTqyvwXZCD+Y0ECUw
ES24GzTtJbRbASi9id6DqtaqO1kE6DT3nS/pIjIqSixRHjqPqySeWJDz93XU/KhU
e04SV9UMdIcA5vhAaHDqKE9rHfw02A==
=P2Sd
-----END PGP SIGNATURE-----

--lnq7tpudOIivlUPp--
