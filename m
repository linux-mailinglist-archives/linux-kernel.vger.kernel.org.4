Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B53A164BC5C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 19:50:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236428AbiLMSuZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 13:50:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235488AbiLMSuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 13:50:23 -0500
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB0CDF5F;
        Tue, 13 Dec 2022 10:50:21 -0800 (PST)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id AEFD21C09F4; Tue, 13 Dec 2022 19:50:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1670957419;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3i41IrgXQW1S6iU+2m3xA/OqmXK1LICZ0Uy6hCM9JWs=;
        b=l7EIGIrdYfcGP7SzrT6VL2hG2CedmYOUeCMcKTWN2LK1XUMJy8Dz/JRyZXWzts9iUbfW/j
        9+rHUM8qAHJMCPFtcs2jqXVTgR7qIMbYf41le0I0ZSw5HPrJpq/vmsHli0J69e4+fpWwxK
        1lkf+UudxYeG/oLyDDQ+K7ksBQLWRVk=
Date:   Tue, 13 Dec 2022 19:50:21 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Chuanhong Guo <gch981213@gmail.com>
Cc:     linux-leds@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stanislav Jakubek <stano.jakubek@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Sven Schwermer <sven.schwermer@disruptive-technologies.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 0/3] leds: add driver for SPI driven WorldSemi WS2812B
 RGB LEDs
Message-ID: <Y5jJbdlYe24MdWsi@amd.ucw.cz>
References: <20221207040904.582585-1-gch981213@gmail.com>
 <Y5g/9ETxQEVOqB5d@duo.ucw.cz>
 <CAJsYDVK850L3qtPAwcwQ4oZCo+JrSq0=QA33RtiRTk5v6CSj6g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="jFBQcuIEZxZsLN2I"
Content-Disposition: inline
In-Reply-To: <CAJsYDVK850L3qtPAwcwQ4oZCo+JrSq0=QA33RtiRTk5v6CSj6g@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jFBQcuIEZxZsLN2I
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > This patch adds support for driving a chain of WS2812B LED chips
> > > using SPI bus.
> > >
> > > WorldSemi WS2812B is a individually addressable LED chip that
> > > can be chained together and controlled individually using a
> > > single wire. The chip recognize a long pulse as a bit of 1 and
> > > a short pulse as a bit of 0. Host sends a continuous stream
> > > of 24-bits color values, each LED chip takes the first 3 byte
> > > it receives as its color value and passes the leftover bytes to
> > > the next LED on the chain.
> > >
> > > This driver simulates this protocol using SPI bus by sending
> > > a long pulse as 3'b110 and a short pulse as 3'b100. The SPI
> > > frequency needs to be 2.105MHz~2.85MHz for the timing to be
> > > correct and the controller needs to transfer all the bytes
> > > continuously.
> >
> > Is this the same thing as NeoPixel? If so, that may be better-known
> > name.
>=20
> NeoPixel is the name used by Adafruit for WS2812B based LED
> strips. Even though that name may be better-known, this driver
> is for the WS2812B LED chips, not for the specific Adafruit
> products made using those chips. So I think it's more appropriate
> to go with worldsemi,ws2812b instead of NeoPixel for the driver
> name.

Still, it would be suitable to mention the "NeoPixel" name in the
comment at begining of driver, and in Kconfig text.

Best regards,
							Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--jFBQcuIEZxZsLN2I
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCY5jJbQAKCRAw5/Bqldv6
8hVlAJwMcGl9MGvTjaV55V1EavnmdPtuwwCfdciSmOxidUdQRvEJkYbtQO5302A=
=5mf7
-----END PGP SIGNATURE-----

--jFBQcuIEZxZsLN2I--
