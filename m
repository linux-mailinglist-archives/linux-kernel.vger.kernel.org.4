Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35CA56D819A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 17:20:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238892AbjDEPUV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 11:20:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239047AbjDEPT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 11:19:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 095B46E8E;
        Wed,  5 Apr 2023 08:19:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 695D4625CE;
        Wed,  5 Apr 2023 15:19:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD343C433D2;
        Wed,  5 Apr 2023 15:19:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680707985;
        bh=PuNyebMcWExvNb7lI3uYOcBfkIpKPWXtSV885yELU/A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iyPbdUS/PciNISIkqvDYxhgYHfATs/2l+J+BBpLgZjcg2xY7iwQLIKYhnbjkQz1YC
         90gUZN2F88Sur7EvoCX7IZ0Mopc+JJeAE1uJHKeYdgNri+okM69bRRy+eXXj8pjMc/
         NoRde2a6m56zB15sDJ/JvJSsF8r1dmGbunOhgARRp0jRG/CbMdz63JmmA3Ve9zRTW7
         Ft48qyVtV7pTmpva92rhq02jknpCCQLDD9Yd+YU9FvgvjGBSBamI2dun4C2EviZZvW
         HN1kJbzvt2P6DeXcquTFI7tb4CnKSsojBQxzWkw/dClgeDHjKRJomDPsTu2tx6JM6f
         6AvbTW9SDdptA==
Date:   Wed, 5 Apr 2023 16:19:40 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Naresh Solanki <naresh.solanki@9elements.com>,
        linux-hwmon@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        linux-kernel@vger.kernel.org, Sascha Hauer <sha@pengutronix.de>,
        jerome Neanne <jneanne@baylibre.com>,
        "Mutanen, Mikko" <Mikko.Mutanen@fi.rohmeurope.com>
Subject: Re: [PATCH v2 2/3] hwmon: (pmbus/core): Add regulator event support
Message-ID: <0672fe4d-7293-4374-9186-29b008e5f8a2@sirena.org.uk>
References: <20230328150335.90238-1-Naresh.Solanki@9elements.com>
 <20230328150335.90238-2-Naresh.Solanki@9elements.com>
 <c88d3cdd-fb2f-c3ac-a9e8-e49f8e98b811@gmail.com>
 <17934bff-f728-d57a-c3c8-956634bd48c8@roeck-us.net>
 <3be67394-6082-1aeb-8a8d-90149217bdc7@gmail.com>
 <aea044ab-3a83-2369-aff7-5ef153618619@roeck-us.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="AXEyRbUEaBmFtXCR"
Content-Disposition: inline
In-Reply-To: <aea044ab-3a83-2369-aff7-5ef153618619@roeck-us.net>
X-Cookie: 1 bulls, 3 cows.
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--AXEyRbUEaBmFtXCR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 05, 2023 at 07:18:32AM -0700, Guenter Roeck wrote:

> The consumers for the regulators provided by PMBus devices are the devices
> connected to those PMBus devices, just like with (presumably) every other
> regulator. Not sure why a regulator instantiated by a regulator driver
> would provide a regulator regulating itself.

Some devices have optionally used internal regulators which can also be
left idle with the supply done externally, and it is also very common to
chain LDOs to DCDCs provided by the same chip (DCDCs provide much better
efficiency but have lower quality output so doing most of the voltage
drop with a DCDC then cleaning up the output with a LDO can be an
effective combination).

> Same situation. I though a regulator driver would notify the regulator subsystem
> if it observes a problem with the supplies it regulates, but based on your feedback
> I am not sure anymore what those notifications are supposed to be used for,
> and if such notifications are appropriate. That means I'll have to read up on all
> this, and I don't have the time to do that in the near future given that I am buried
> in pending reviews and the work I am actually getting paid for.

The theory is that if a consumer detects that the device it's
controlling has bad power then it can take corrective action if there's
some specification mandated error handling (for something like a
standard bus) or risk of hardware damage.  It can also try to avoid
interacting with hardware if that might not work.

--AXEyRbUEaBmFtXCR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEyBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQtkYsACgkQJNaLcl1U
h9DACgf4ojk7O7jd5Q9qFRGfKJmspFUv7OLLalVmvqbfOMWPXQ0B+lyCAVFhsnuX
KjZQ8C1ddkaXJt6sKhwBbHRh9os8FexzLeIa1abH1/qeGcLWi6xD5/XdYgXDrFrQ
nVEbkC3+WVp65G48TWuEKQWkr2bVTVTpqgxkUDGcFDmBfyQH0Njn7HdCEbW5g2So
slmU7riBXQfrhUhrlEWKOXXsCx6/GBaqr66lcRzaA/IxLmS+W2e1aBrDue7w71LP
4q0T9fMHDFQbhWzFntXnPqj+GeufgdzAy2qacxFuu2rbGL0IZniNWGajJMwKJQog
wxkJ9vh3WKhXsjsMUadX0UaNAZZV
=H1gL
-----END PGP SIGNATURE-----

--AXEyRbUEaBmFtXCR--
