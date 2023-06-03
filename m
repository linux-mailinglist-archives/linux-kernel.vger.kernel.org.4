Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B8907212A2
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jun 2023 22:22:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230521AbjFCUVD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Jun 2023 16:21:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbjFCUVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Jun 2023 16:21:02 -0400
Received: from fgw23-7.mail.saunalahti.fi (fgw23-7.mail.saunalahti.fi [62.142.5.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0238E123
        for <linux-kernel@vger.kernel.org>; Sat,  3 Jun 2023 13:21:01 -0700 (PDT)
Received: from localhost (88-113-26-95.elisa-laajakaista.fi [88.113.26.95])
        by fgw23.mail.saunalahti.fi (Halon) with ESMTP
        id 25f5af74-024c-11ee-b972-005056bdfda7;
        Sat, 03 Jun 2023 23:20:58 +0300 (EEST)
From:   andy.shevchenko@gmail.com
Date:   Sat, 3 Jun 2023 23:20:57 +0300
To:     Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
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
Message-ID: <ZHugqa697eGqHnr4@surfacebook>
References: <20230424123522.18302-1-nikita.shubin@maquefel.me>
 <20230601054549.10843-6-nikita.shubin@maquefel.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230601054549.10843-6-nikita.shubin@maquefel.me>
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thu, Jun 01, 2023 at 08:45:29AM +0300, Nikita Shubin kirjoitti:
> Technologic Systems has it's own nand controller implementation in CPLD.
> 
> This patch adds support for TS-72XX boards family.

Use imperative mode, this is documented in the Submitting Patches,

...

> +/*
> + * Technologic Systems TS72xx NAND controller driver
> + *
> + * Copyright (C) 2023 Nikita Shubin <nikita.shubin@maquefel.me>
> + *
> + * derived: plat_nand.c

Derived from:

> + *  Author: Vitaly Wool <vitalywool@gmail.com>
> + */

...

> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>

+ Blank line?

> +#include <linux/mtd/mtd.h>
> +#include <linux/mtd/platnand.h>

...

> +		bits = readb(addr) & ~0x07;

GENMASK()?

...

> +	addr += (1 << TS72XX_NAND_BUSY_ADDR_LINE);

BIT() ?

...

> +	return !!(readb(addr) & 0x20);

BIT() ?

...

> +	struct ts72xx_nand_data *data;
> +	struct mtd_info *mtd;
> +	int err = 0;

Redundant assignment.

> +	/* Allocate memory for the device structure (and zero it) */
> +	data = devm_kzalloc(&pdev->dev, sizeof(struct ts72xx_nand_data),

sizeof(*data) and make it a single line.

> +			    GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;

...

> +	nand_set_flash_node(&data->chip, pdev->dev.of_node);

Hmm... wondering why this uses OF node instead of fwnode... But okay, this is
question to the subsystem maintaners.


> +	err = mtd_device_parse_register(mtd, NULL, NULL,
> +					NULL, 0);

There is plenty of space on the previous line.

> +

Redundant blank line.

> +	if (!err)
> +		return err;
> +
> +	nand_cleanup(&data->chip);
> +
> +	return 0;

This seems at least weird and rather broken.
To me it looks like

	if (err) {
		nand_cleanup(&data->chip);
		return err;
	}

	return 0;

has to be here.

> +}

...

> +	ret = mtd_device_unregister(nand_to_mtd(chip));
> +	WARN_ON(ret);

WARN_ON()?! Why?

> +	nand_cleanup(chip);
> +}

-- 
With Best Regards,
Andy Shevchenko


