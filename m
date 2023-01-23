Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4063D677655
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 09:32:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231540AbjAWIcS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 03:32:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbjAWIcR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 03:32:17 -0500
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0D901A961
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 00:32:15 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id D5AB54000C;
        Mon, 23 Jan 2023 08:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1674462734;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=N5sr1+ft/o4KFGfy74z6A876hko9sf4WKrKKmi7Je/Y=;
        b=KuoNAfOv2pzHTPxQdsQDTsRxDucuLyajao1IkRwSgW0PBw/AR0kYdXWOVgMFnNpsqGFx+h
        41ejb8jbZap1x8ttBNzcXJZPqDSO9tXmdmnXaB4VoOySlL6kUZ7wLfT6iMnScmRCIGHzO6
        PiMk5LexuK8SRkHyEYIiXIAcdE+W/dAEx6sv5T/d6EigOw8p5514TFKf1wFOg4lgoiUshk
        0o8PJFBOlUK59cdoMz3N5rZsKV4c2N1Clgu/cPlgRXekCBEZJ2kiHF29ilWrDlZXYpxhAo
        2DOnc9oStAtUweOC3GsaqSRs4hhn9v7ChZPIcSChth/FXjZuwv9ibKkUEgcC9w==
Date:   Mon, 23 Jan 2023 09:32:09 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Li Chen <lchen@ambarella.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Li Chen <me@linux.beauty>, Roger Quadros <rogerq@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Chuanhong Guo <gch981213@gmail.com>,
        Liang Yang <liang.yang@amlogic.com>,
        Jean Delvare <jdelvare@suse.de>,
        Andreas =?UTF-8?B?QsO2aGxlcg==?= <dev@aboehler.at>,
        Christian Lamparter <chunkeey@gmail.com>,
        Rickard x Andersson <rickaran@axis.com>,
        linux-kernel@vger.kernel.org (open list),
        linux-mtd@lists.infradead.org (open list:NAND FLASH SUBSYSTEM),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Ambarella SoC
        support)
Subject: Re: [PATCH 12/15] mtd: nand: add Ambarella nand support
Message-ID: <20230123093209.770995cf@xps-13>
In-Reply-To: <20230123073305.149940-13-lchen@ambarella.com>
References: <20230123073305.149940-1-lchen@ambarella.com>
        <20230123073305.149940-13-lchen@ambarella.com>
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

Hi Li,

I'm sorry, this is not going to work at all.

> +	ambarella_nand_init(host);
> +
> +	mtd =3D nand_to_mtd(&host->chip);
> +	mtd->name =3D "amba_nand";
> +
> +	nand_controller_init(&host->controller);
> +	nand_set_controller_data(&host->chip, host);
> +	nand_set_flash_node(&host->chip, dev->of_node);
> +
> +	host->chip.controller =3D &host->controller;
> +	host->chip.controller->ops =3D &ambarella_controller_ops;
> +	host->chip.legacy.chip_delay =3D 0;
> +	host->chip.legacy.read_byte =3D ambarella_nand_read_byte;
> +	host->chip.legacy.write_buf =3D ambarella_nand_write_buf;
> +	host->chip.legacy.read_buf =3D ambarella_nand_read_buf;
> +	host->chip.legacy.select_chip =3D ambarella_nand_select_chip;
> +	host->chip.legacy.cmd_ctrl =3D ambarella_nand_cmd_ctrl;
> +	host->chip.legacy.dev_ready =3D ambarella_nand_dev_ready;
> +	host->chip.legacy.waitfunc =3D ambarella_nand_waitfunc;
> +	host->chip.legacy.cmdfunc =3D ambarella_nand_cmdfunc;
> +	host->chip.legacy.set_features =3D nand_get_set_features_notsupp;
> +	host->chip.legacy.get_features =3D nand_get_set_features_notsupp;

Please be aware that we no longer accept legacy introductions upstream.

You can look for ->exec_op() conversions using git-log.

> +	host->chip.options |=3D NAND_NO_SUBPAGE_WRITE | NAND_USES_DMA;
> +
> +	rval =3D nand_scan(&host->chip, 1);
> +	if (rval < 0)
> +		return rval;
> +
> +	rval =3D mtd_device_register(mtd, NULL, 0);
> +	if (rval < 0)
> +		nand_cleanup(&host->chip);
> +
> +	return rval;
> +}

[...]

> diff --git a/drivers/mtd/nand/raw/nand_ids.c
b/drivers/mtd/nand/raw/nand_ids.c
> index dacc5529b3df..9f264e2a6484 100644
> --- a/drivers/mtd/nand/raw/nand_ids.c
> +++ b/drivers/mtd/nand/raw/nand_ids.c
> @@ -62,6 +62,10 @@ struct nand_flash_dev nand_flash_ids[] =3D {
>  		{ .id =3D {0x98, 0xd3, 0x91, 0x26, 0x76} },
>  		  SZ_4K, SZ_1K, SZ_256K, 0, 5, 256, NAND_ECC_INFO(8, SZ_512)},
> =20
> +	{"MT29F2G01ABAGD SPINAND 2G 3.3V 8-bit",
> +		{ .id =3D {0x2c, 0x24, 0x00, 0x00, 0x00} },
> +		  SZ_2K, SZ_256, SZ_128K, 0, 2, 128},
> +

Raw NAND !=3D SPI-NAND. I don't get what you're doing here but either you
want to drive SPI-NANDs and this is a SPI controller driver that
implements spi-mem ops and should be located under drivers/spi/, or
this is a plain raw NAND controller which is wired to a parallel NAND
and this should be under drivers/mtd/nand/raw/.

ECC controllers can be shared with the ECC engine abstraction though.

>  	LEGACY_ID_NAND("NAND 4MiB 5V 8-bit",   0x6B, 4, SZ_8K, SP_OPTIONS),
>  	LEGACY_ID_NAND("NAND 4MiB 3,3V 8-bit", 0xE3, 4, SZ_8K, SP_OPTIONS),
>  	LEGACY_ID_NAND("NAND 4MiB 3,3V 8-bit", 0xE5, 4, SZ_8K, SP_OPTIONS),


Thanks,
Miqu=C3=A8l
