Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52257637920
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 13:42:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbiKXMm2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 07:42:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbiKXMmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 07:42:09 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5EF0D92F2;
        Thu, 24 Nov 2022 04:41:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 56ABA62117;
        Thu, 24 Nov 2022 12:41:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E8EEC433C1;
        Thu, 24 Nov 2022 12:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669293718;
        bh=1iJR7svHch/4T42w9H9emz8bEDSlGXspdjOx/hxrm0c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ohhfNIJXuUoO96qIbvqJlGPesY8HIlSJOzb2cUIWs7/NdrX6dhZqzdkKAE1TjgpVI
         a5pigHiHTlg8wK+6+UdKBHqGuYXizkS093Y/DGiffBgCZK97ChCZbpzRJxuYkJD4ZQ
         mPn9BUyz0PPjP6OssoOg//mRfoJCceH7lewJ0GmdgdM6J+LLICEO/dVMiQk70A6Ror
         fZpIitc6pV/SzM911YLTqOj0mimRzwbm5yqkFYaYIfxcnD0JQaqjCJxqkFKL4X8EM0
         T8GCVCGpeQLwC8THzWXr+eTYEB/Eja+NJNK8Wn4OHl1BW3r2GPUrJQi0mSOlLqtfgc
         RGQZaJFyobbaA==
Date:   Thu, 24 Nov 2022 12:41:54 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Dhruva Gole <d-gole@ti.com>
Cc:     Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
        greg.malysa@timesys.com,
        "open list:SPI SUBSYSTEM" <linux-spi@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] spi: cadence-quadspi: Add upper limit safety check to
 baudrate divisor
Message-ID: <Y39mkl+9W8S6ZzOk@sirena.org.uk>
References: <20221123211705.126900-1-nathan.morrison@timesys.com>
 <9e5264fa-db1a-ed96-5fd8-cbfa4694b8bd@ti.com>
 <Y39XFzYJL3EmxSFF@sirena.org.uk>
 <88b6dab2-87b1-34ef-b267-43933d79ab8e@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="BSJOWebIfHRbS2Ss"
Content-Disposition: inline
In-Reply-To: <88b6dab2-87b1-34ef-b267-43933d79ab8e@ti.com>
X-Cookie: Apply only to affected area.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--BSJOWebIfHRbS2Ss
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 24, 2022 at 05:57:10PM +0530, Dhruva Gole wrote:
> On 24/11/22 17:05, Mark Brown wrote:

> > As far as I can tell the issue here is that the device is asking for a
> > rate which requires a larger divisor than the controller can support but
> > the driver doesn't do any bounds checking so it just writes the
> > calculated divisor out to the hardware, corrupting any adjacent fields.

> but, I am not sure it would anyway corrupt any adjacent bits,

> The code
> reg |= (div & CQSPI_REG_CONFIG_BAUD_MASK) << CQSPI_REG_CONFIG_BAUD_LSB

> does mask the div value to ensure bits ONLY in CQSPI_REG_CONFIG_BAUD_MASK
> region are set and nothing else right?

Yes, that'd avoid corrupting adjacent bits (though it'd still be making
things worse in that it makes the divider smaller).

> I believe a simple warning is enough, and better not touch the div variable
> because it seems unnecessary. We already have a mask to take care of masking
> the appropriate bits.

That'd still leave the clock driven too fast which could break things,
going for the maximum divider would mitigate this (though an error would
be even safer).

--BSJOWebIfHRbS2Ss
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmN/ZpEACgkQJNaLcl1U
h9AvPAf9G6Ky3lmquOrNVgL0eNAxmRCd4YVvOTlKeIHNJrNv6TT320J/DzrVN4w+
9ktTV3ZW4wsBcN1P3zz6nz8lwIofuAK+exw90LI2BduuLQ99UWguHRTZ5Boe9LDf
xnFPHZmYF3HwIDC+S854MAKeEv99++By+wMtrhTBzv/OMF1OPynedrcmhNLYDZF6
V8Hca5elzIKlOI0jF8GZ1tYllW50vvdNbgsCVpD5cUxtlsZDOuqLuH40xmS6DZ6A
87YYdtrvk4LbTpVumgtypvnzECMDx+Jya1OSjqcRrEY9UDFklb2EX0RUJspLMpA7
A2qJeq9A2Gf0/ULY7DAUK3T2I34JeA==
=ZHIr
-----END PGP SIGNATURE-----

--BSJOWebIfHRbS2Ss--
