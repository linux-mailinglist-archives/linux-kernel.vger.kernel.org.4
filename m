Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 143E0667E33
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 19:37:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239940AbjALShq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 13:37:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240151AbjALShL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 13:37:11 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 603CE67187;
        Thu, 12 Jan 2023 10:08:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EA852B81F02;
        Thu, 12 Jan 2023 18:08:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CE90C433EF;
        Thu, 12 Jan 2023 18:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673546895;
        bh=LITh+aXjMTjYXFbixbj6JWlvN9AC8dKaUcM9PfRjomE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qA8oGiUj/9CPAD09xGTeNPJf0MqCwc45WB2rfpCZsQOrN3T4sv6EIhF/k+pM6BY2N
         EaQhyYIIUbV7FsZv3Aq4yaoCJUisUMn9T2DzKG9tSYNqGoVcu/CcOzKauH5MC6OHT8
         FTArMJbCJ3RawQQrbteavn8y2SKtuYm3b41ZoDuR8Hpb9do8tTC64jTZH8nls7JZxh
         8wKrTK31+DKgzvgnPId46ZATskfgFLCJ4oNylCkCYAhYauDkC2Y2CoaSiZDKhpwa23
         O212Zcf+4lKY81KFhPGKGj21rkFpdTf3rn+yrYKWdGrZ1oAD/lDJLtf+PtGCQVbYfa
         lZCWLjeyAr7Sw==
Date:   Thu, 12 Jan 2023 18:08:08 +0000
From:   Mark Brown <broonie@kernel.org>
To:     William Zhang <william.zhang@broadcom.com>
Cc:     Linux SPI List <linux-spi@vger.kernel.org>,
        Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>,
        anand.gore@broadcom.com, tomer.yacoby@broadcom.com,
        dan.beygelman@broadcom.com, joel.peshkin@broadcom.com,
        f.fainelli@gmail.com, jonas.gorski@gmail.com,
        kursad.oney@broadcom.com, dregan@mail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/16] spi: bcm63xx-hsspi: Make dummy cs workaround as an
 option
Message-ID: <Y8BMiOvbjncXK4RO@sirena.org.uk>
References: <20230106200809.330769-1-william.zhang@broadcom.com>
 <20230106200809.330769-11-william.zhang@broadcom.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bW0HKNDw1MvhDoNy"
Content-Disposition: inline
In-Reply-To: <20230106200809.330769-11-william.zhang@broadcom.com>
X-Cookie: A watched clock never boils.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bW0HKNDw1MvhDoNy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 06, 2023 at 12:08:02PM -0800, William Zhang wrote:

> Due to the controller limitation to keep the chip select low during the
> bus idle time between the transfer, a dummy cs workaround was used when
> this driver was first upstreamed to the kernel.
>=20
> The workaround picks dummy_cs as !actual_cs and usually cs is 0 and
> dummy cs is 1. But this does not work out in all the situations as
> customer reported issues for their board design. Due to SPI block design
> constrain, the controller works in different mode internally depending
> on the clock. When clock is 30MHz or above, controller works in faster
> mode and cs 1 signal is used internally as feedback from the pad. So cs
> 1 pin must be brought out and configured as chip select function in
> pinmux. When clock is below 30MHz, only cs 0 pin is used. In summary
> when clock is below 30MHz, the workaround always works as only cs 0 is
> involved. For clock faster than 30MHz, it require cs1 pin used in the
> board design and configured as chip selection function.

> In a typical usage of SPI flash on cs 0 that normally runs at 100MHz,
> cs 1 pin must be used in the board design but this is not always the
> case for many customer boards.

> For voice daughtercard usage,  the SoC alway uses internal cs 7 for
> voice card SPI control. Then it requires cs 0 pin as the dummy cs but
> board with voice design may not use cs 0 pin at all.

So I think what this is trying to say is that operation over 30MHz with
the existing workaround requires that the board be designed to bring out
the chip select used as the dummy as a physical chip select (or
potentially it has to be the actual chip select for the device?) but
that likely won't have been done?  And potentially this only works if CS
1 is the one brought out?  I'm unclear if CS 1 is just the most common
dummy chip select or if there's something else going on here.

> The controller actually has a prepend feature that can combine multiple
> SPI transfers in a SPI message into one single transfer when the
> transfers meet certain requirements. So there is no need for keeping cs
> low when the message only has one transfer. Most of the SPI devices
> including SPI NOR, SPI NAND flash, Broadcom voice card and etc can use
> this feature without the dummy cs workaround.

> This patch makes the dummy cs workaround as an option based on the
> dts flag brcm,use-cs-workaround. By default dummy cs workaround is
> hard coded to enable. We will use the prepend feature and disable this
> workaround as default in the next patch of this series unless this flag
> is set in dts.

=2E..and based on your other comments I gather it's difficult to disable
the workaround per message?  I'm also guessing that the overhead from
always doing full duplex transfers is noticable so it's better to try
the workaround.

I wonder if we can't do this by selecting the workaround based on the
configured device speed.  If the device is configured to use more than
30MHz then disable the workaround, if it's set to lower then use it.  In
practice most devices don't change their speed after setup, and the
driver could check for and handle that case I guess (eg, limit the speed
configured if the workaround has been activated or rewrite the message
to a single transfer if neded).  That would be less error prone for
users, there wouldn't be any possibility of them setting this flag
incorrectly.

--bW0HKNDw1MvhDoNy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmPATIgACgkQJNaLcl1U
h9CcNgf/fWX0iEg9AyY7WMh0wES005sc4MvmRCSw8w5AOYN/t0Vc1fzakGhtkED1
DrOI8Yji9L9vKpsm+yiGIZVH4fXuM13rmn74wtAm46TqX5QbiJeY65bOUmQepALh
sRSGJRA4bVmtLloK+1Wmnu+rX45MRt9CJuEgDhZHbHzf6uSa+TnpJUFOYnFllnkJ
szOLS2ITNFk5rKW/W/9bEEDZWF8Q/0iDGAxGSEzfbYmsm+Z0WyMaf8IYtQne1v9s
Dxfh7e3hbzmHrPUJB22uMf81TYLA09REuvFXdVhjrPQgrr0PfeXICEOocX6uKTDd
z6MSDZP2yqBDQD57wJe8/3w/y+DCVw==
=c9io
-----END PGP SIGNATURE-----

--bW0HKNDw1MvhDoNy--
