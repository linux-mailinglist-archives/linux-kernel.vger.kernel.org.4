Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97EFC5E7EF5
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 17:50:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232797AbiIWPt7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 11:49:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232762AbiIWPtU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 11:49:20 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F569146F84;
        Fri, 23 Sep 2022 08:48:05 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 5E00BFF809;
        Fri, 23 Sep 2022 15:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1663948083;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lo2OfiFsituiAjWzRKD+8mam5gTPh7hGEapVViTm41I=;
        b=fsi/9hSaY/0DUzrW2fRSEnNXqB9wsVkDc8+Ln6V2dgFk/WsWpD8ZUPRF9l1bhZLlpHMooS
        UDcKQSzp/PN4D6sKnKmilsjeKp3JQSGnxpTHDes8cuHi+m/PO+RLvmALwZiwdf/6KUl4UD
        ZDslRsUikY86FVM167/dIxig6MmRRNlOf4FfrTrqo5uh42ZpuaJnLPGBe696TODaRiCRBy
        KkmORG0fN6VwaMO9W7rgdunJtTMk9nrQFTPYCT76qaqVL2YDNmc9rs2P9I/Us4UOwiudae
        eeyXGsdPbxc12KynT7BaS50Xt5hi9ehrLZdQQcfofIRLaD3gkDcCKydFYDShFA==
Date:   Fri, 23 Sep 2022 17:47:59 +0200
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
        Robert Marko <robert.marko@sartura.hr>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v2 00/20] nvmem: core: introduce NVMEM layouts
Message-ID: <20220923174759.299e504e@xps-13>
In-Reply-To: <20220901221857.2600340-1-michael@walle.cc>
References: <20220901221857.2600340-1-michael@walle.cc>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_FILL_THIS_FORM_SHORT autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

I have a few additional questions regarding the bindings.

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
>=20
> You can also have cells which have no static offset, like the
> ones in an u-boot environment. The last patches will convert the current
> u-boot environment driver to a NVMEM layout and lifting the restriction
> that it only works with mtd devices. But as it will change the required
> compatible strings, it is marked as RFC for now. It also needs to have
> its device tree schema update which is left out here. These two patches
> are not expected to be applied, but rather to show another example of
> how to use the layouts.
>=20
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

So if I understand correctly, there should be:
- one DT node defining the storage medium eeprom/mtd/whatever,
- another DT node defining the nvmem device with two compatibles, the
  "nvmem" (or "user-otp") and the layout.
Is this correct? Actually I was a bit surprised because generally
speaking, DT maintainers (rightfully) do not want to describe how we
use devices, the nvmem abstraction looks like a Linux thing when on top
of mtd devices for instance, so I just wanted to confirm this point.

Then, as we have an nvmem device described in the DT, why not just
pointing at the nvmem device from the cell consumer, rather than still
having the need to define all the cells that the nvmem device will
produce in the DT?

Maybe an example to show what I mean. Here is the current way:

nvmem_provider: nvmem-provider {
	properties;

	mycell: my_cell {
		[properties;]
	};
};

And we point to a cell with:

	nvmem-cells =3D <&mycell>;

But, as for the tlv tables, there are many cells that will be produced,
and the driver may anyway just ask for the cell name (eg. performing a
lookup of the "mac-address" cell name), so why bothering to describe all
the cells in the DT, like:

	nvmem-cells-providers =3D <&nvmem_provider>;

What do you think?

Maybe for the mac addresses this is a bit limiting as, in practice, we
often have base mac addresses available and using:

	nvmem-cells =3D <&mycell INDEX>;

allows to dynamically create many different mac addresses, but I wonder
if the approach would be interesting for other cell types. Just an open
question.

Thanks,
Miqu=C3=A8l
