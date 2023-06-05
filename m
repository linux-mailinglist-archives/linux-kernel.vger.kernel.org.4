Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E251B7220E3
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 10:22:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229441AbjFEIWZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 04:22:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjFEIWS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 04:22:18 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D805DB
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 01:22:15 -0700 (PDT)
X-GND-Sasl: miquel.raynal@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1685953334;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wA0xU7QmwEZWzRDuo37VFnIbazTtYFeQ5ft/6O7tFKk=;
        b=oHGUBOnufDUl9EY24vegbo6x61xjnkj3wFdOBSek+WML6KVMwtJN6Caij3VaA6FX9OATB7
        jIx9/QYt7HMfrqLb+Q8CUhA4LHI0+uOzOvRDpEu97YzjQQ4uC34iDnqQTNKhmsm5GdZA4S
        SKPWdnI/Rc/z3Wpc2KKkc/t3vo7ZwHb8TEuvtmYOS0B8sP7YSpwtv9NNdzXE3opSsnQcJ5
        K/AFGgoV9AD4FLSSCMkuG9zNbFyJX8ODvg7tTgtBnN0E004tjPIuh5vkg0oZvYxxX1i8eL
        JPlOXgWdh8Jp7jMxYYlAVhEd53u1eX5usy2fdCShFsf8AT4TM2is5RbU4lfhkA==
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 595AAE0004;
        Mon,  5 Jun 2023 08:22:10 +0000 (UTC)
Date:   Mon, 5 Jun 2023 10:22:08 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     andy.shevchenko@gmail.com
Cc:     Nikita Shubin <nikita.shubin@maquefel.me>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Christophe Kerello <christophe.kerello@foss.st.com>,
        Jean Delvare <jdelvare@suse.de>,
        Liang Yang <liang.yang@amlogic.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Michael Peters <mpeters@embeddedts.com>,
        Kris Bahnsen <kris@embeddedts.com>,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Subject: Re: [PATCH v1 24/43] mtd: nand: add support for ts72xx
Message-ID: <20230605102208.4e6d26f3@xps-13>
In-Reply-To: <ZHugqa697eGqHnr4@surfacebook>
References: <20230424123522.18302-1-nikita.shubin@maquefel.me>
        <20230601054549.10843-6-nikita.shubin@maquefel.me>
        <ZHugqa697eGqHnr4@surfacebook>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi andy.shevchenko@gmail.com,

andy.shevchenko@gmail.com wrote on Sat, 3 Jun 2023 23:20:57 +0300:

> Thu, Jun 01, 2023 at 08:45:29AM +0300, Nikita Shubin kirjoitti:
> > Technologic Systems has it's own nand controller implementation in CPLD.
> >=20
> > This patch adds support for TS-72XX boards family. =20
>=20
> Use imperative mode, this is documented in the Submitting Patches,
>=20
> ...
>=20
> > +/*
> > + * Technologic Systems TS72xx NAND controller driver
> > + *
> > + * Copyright (C) 2023 Nikita Shubin <nikita.shubin@maquefel.me>
> > + *
> > + * derived: plat_nand.c =20
>=20
> Derived from:
>=20
> > + *  Author: Vitaly Wool <vitalywool@gmail.com>
> > + */ =20
>=20
> ...
>=20
> > +#include <linux/err.h>
> > +#include <linux/io.h>
> > +#include <linux/module.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/slab.h> =20
>=20
> + Blank line?
>=20
> > +#include <linux/mtd/mtd.h>
> > +#include <linux/mtd/platnand.h> =20
>=20
> ...
>=20
> > +		bits =3D readb(addr) & ~0x07; =20
>=20
> GENMASK()?
>=20
> ...
>=20
> > +	addr +=3D (1 << TS72XX_NAND_BUSY_ADDR_LINE); =20
>=20
> BIT() ?
>=20
> ...
>=20
> > +	return !!(readb(addr) & 0x20); =20
>=20
> BIT() ?
>=20
> ...
>=20
> > +	struct ts72xx_nand_data *data;
> > +	struct mtd_info *mtd;
> > +	int err =3D 0; =20
>=20
> Redundant assignment.
>=20
> > +	/* Allocate memory for the device structure (and zero it) */
> > +	data =3D devm_kzalloc(&pdev->dev, sizeof(struct ts72xx_nand_data), =20
>=20
> sizeof(*data) and make it a single line.
>=20
> > +			    GFP_KERNEL);
> > +	if (!data)
> > +		return -ENOMEM; =20
>=20
> ...
>=20
> > +	nand_set_flash_node(&data->chip, pdev->dev.of_node); =20
>=20
> Hmm... wondering why this uses OF node instead of fwnode... But okay, thi=
s is
> question to the subsystem maintaners.
>=20
>=20
> > +	err =3D mtd_device_parse_register(mtd, NULL, NULL,
> > +					NULL, 0); =20
>=20
> There is plenty of space on the previous line.
>=20
> > + =20
>=20
> Redundant blank line.
>=20
> > +	if (!err)
> > +		return err;
> > +
> > +	nand_cleanup(&data->chip);
> > +
> > +	return 0; =20
>=20
> This seems at least weird and rather broken.

Yeah, I made the same comment.

> To me it looks like
>=20
> 	if (err) {
> 		nand_cleanup(&data->chip);
> 		return err;
> 	}
>=20
> 	return 0;
>=20
> has to be here.
>=20
> > +} =20
>=20
> ...
>=20
> > +	ret =3D mtd_device_unregister(nand_to_mtd(chip));
> > +	WARN_ON(ret); =20
>=20
> WARN_ON()?! Why?

This is actually something that is expected for now, the device
unregistration should not fail and the return value should not be used
to skip other cleanups. I cannot find the original discussion anymore
but we decided to use that construction. We might actually switch that
one to void someday.

>=20
> > +	nand_cleanup(chip);
> > +} =20
>=20


Thanks,
Miqu=C3=A8l
