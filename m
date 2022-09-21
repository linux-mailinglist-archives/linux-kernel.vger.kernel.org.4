Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05AA35BFC75
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 12:38:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbiIUKh5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 06:37:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbiIUKhy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 06:37:54 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABE08883F0;
        Wed, 21 Sep 2022 03:37:52 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id D6A42240003;
        Wed, 21 Sep 2022 10:37:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1663756671;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hRyV869MMgVK7tdzah/59H1NCr8I0pXUftnnb2Omlnw=;
        b=BfwpWdFGgsgb6hcA0xwT4keRDMomtfabg9ZMIfH4FnLef2kMtqWK7Daop0sNNTzBuhLL8N
        s23992Tiq5yUiGtoLj+i2TImgmcDkGg4sxoGmDZQxRA6N1FC4wIVpDveTeygb5Wju/9IHd
        iG0Q3/wfT0RCQWF/PgHPqSsx49n+ymxi5MBdZ9NPH16LnpHkFwsrtbTCu2uoCUj3WthKLY
        o5zszKzjLpYht9Nvp0bKhKvCFVZJ3T0lPxYC8EYToa0AZDn+fDLOuetKICQRKhgevkTWSx
        IqJntZ5h0APBBEHjpxkEOhHhzPLGTLDFPcAz86Wxaa0895v6mCtLUXJAs/FEvg==
Date:   Wed, 21 Sep 2022 12:37:45 +0200
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
        Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [RFC PATCH v2 19/20] nvmem: layouts: rewrite the u-boot-env
 driver as a NVMEM layout
Message-ID: <20220921123745.61299d6a@xps-13>
In-Reply-To: <20220901221857.2600340-20-michael@walle.cc>
References: <20220901221857.2600340-1-michael@walle.cc>
        <20220901221857.2600340-20-michael@walle.cc>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

michael@walle.cc wrote on Fri,  2 Sep 2022 00:18:56 +0200:

> Instead of hardcoding the underlying access method mtd_read() and
> duplicating all the error handling, rewrite the driver as a nvmem
> layout which just uses nvmem_device_read() and thus works with any
> NVMEM device.
>=20
> But because this is now not a device anymore, the compatible string
> will have to be changed so the device will still be probed:
>   compatible =3D "u-boot,env";
> to
>   compatible =3D "u-boot,env", "nvmem-cells";
>=20
> "nvmem-cells" will tell the mtd layer to register a nvmem_device().
> "u-boot,env" will tell the NVMEM that it should apply the u-boot
> environment layout to the NVMEM device.
>=20
> Signed-off-by: Michael Walle <michael@walle.cc>
> ---
> changes since v1:
>  - none
>=20
>  drivers/nvmem/layouts/Kconfig      |   8 ++
>  drivers/nvmem/layouts/Makefile     |   1 +
>  drivers/nvmem/layouts/u-boot-env.c | 144 +++++++++++++++++++
>  drivers/nvmem/u-boot-env.c         | 218 -----------------------------

Nit: IIRC there is a MAINTAINERS entry to update as well.

Thanks,
Miqu=C3=A8l
