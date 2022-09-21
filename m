Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F4995BFBD3
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 11:58:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230135AbiIUJ62 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 05:58:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbiIUJ6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 05:58:24 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C8CD31233;
        Wed, 21 Sep 2022 02:58:21 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 196031BF20E;
        Wed, 21 Sep 2022 09:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1663754300;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DyHD1cpJLUHFIMs13MWIgjp+SJUxrqpST3FASTVSKyg=;
        b=NKgx0wIhTPfQ5YxJxGGUmmnBRphvtN7QuHUpyH1cPD/8Ph1Qw3r+I4svJb9t8CV534EELl
        3usa6Vb6KvFX6P1OoFx2BdG2IAaLed+v0IfcpsWTPkMe7cv/Q0rxMM2e+4hlpJqjG5a9TU
        y78/qxC74wNo3nbRqLfZAQlIeBmdm2cJWDUpXvLtNUrA6tXLuehjmubX2k/RAT2Ne5bMMQ
        onN/8FdpyDJ+1pEbMwqwv4B2MROBUm9XOlYifOg5FbE3cn9A7THPNKeMZJ7+Lxd4bqLtEh
        wf1+htFsCdXcF/B3Zh3Zzpvv3TP+5o9JqBmNWYApH9rrSzR5qW3Ch4eBYxGn8g==
Date:   Wed, 21 Sep 2022 11:58:13 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Michael Walle <michael@walle.cc>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Robert Marko <robert.marko@sartura.hr>
Subject: Re: [PATCH v2 00/20] nvmem: core: introduce NVMEM layouts
Message-ID: <20220921115813.208ff789@xps-13>
In-Reply-To: <20220901221857.2600340-1-michael@walle.cc>
References: <20220901221857.2600340-1-michael@walle.cc>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael, Srinivas,

+ Thomas and Robert

michael@walle.cc wrote on Fri,  2 Sep 2022 00:18:37 +0200:

> This is now the third attempt to fetch the MAC addresses from the VPD
> for the Kontron sl28 boards. Previous discussions can be found here:
> https://lore.kernel.org/lkml/20211228142549.1275412-1-michael@walle.cc/
>=20
>=20
> NVMEM cells are typically added by board code or by the devicetree. But
> as the cells get more complex, there is (valid) push back from the
> devicetree maintainers to not put that handling in the devicetree.
>=20
> Therefore, introduce NVMEM layouts. They operate on the NVMEM device and
> can add cells during runtime. That way it is possible to add more complex
> cells than it is possible right now with the offset/length/bits
> description in the device tree. For example, you can have post processing
> for individual cells (think of endian swapping, or ethernet offset
> handling).
>=20
> The imx-ocotp driver is the only user of the global post processing hook,
> convert it to nvmem layouts and drop the global post pocessing hook. Plea=
se
> note, that this change is only compile-time tested.

These layouts are an excellent idea. I actually have a new use case for
them. In modern Ethernet switches which follow the ONIE standard [1]
there is an nvmem device which contains a standardized
type-length-value array with many information about manufacturing and
mac addresses. There is no "static" pattern there and anyway so many
possible entries that it would be very tedious to list all of them in
the bindings, as each manufacturer chooses what it want to export on
each of its devices (although reading the data sequentially and
extracting the cells is rather straightforward).

Moreover, the specification [1] does not define any storage device
type, so it can be eg. an MTD device or an EEPROM. Having an
nvmem device provider separated from the nvmem cells provider makes
complete sense, the "layout" drivers idea proposed by Michael seem to be
a perfect fit.

Srinivas, can you give us an update on what you think about this
series (not a commitment, just how you feel it overall)?

Michael, is there a v3 in preparation? I'll try to write something on
top of your v2 otherwise.

> You can also have cells which have no static offset, like the
> ones in an u-boot environment. The last patches will convert the current
> u-boot environment driver to a NVMEM layout and lifting the restriction
> that it only works with mtd devices. But as it will change the required
> compatible strings, it is marked as RFC for now. It also needs to have
> its device tree schema update which is left out here. These two patches
> are not expected to be applied, but rather to show another example of
> how to use the layouts.

Actually I think these two matches make complete sense, right now one
can only use the u-boot-env cells if the environment is stored in an
mtd device, of course this covers many cases but not all of them and it
would be really nice to have this first layout example merged, not only
on the mailing list.

> For now, the layouts are selected by a specific compatible string in a
> device tree. E.g. the VPD on the kontron sl28 do (within a SPI flash node=
):
>   compatible =3D "kontron,sl28-vpd", "user-otp";
> or if you'd use the u-boot environment (within an MTD patition):
>   compatible =3D "u-boot,env", "nvmem";
>=20
> The "user-otp" (or "nvmem") will lead to a NVMEM device, the
> "kontron,sl28-vpd" (or "u-boot,env") will then apply the specific layout
> on top of the NVMEM device.

Thanks,
Miqu=C3=A8l
