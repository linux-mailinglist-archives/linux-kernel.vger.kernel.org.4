Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DBFC74750D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 17:14:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231680AbjGDPN5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 11:13:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231249AbjGDPNy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 11:13:54 -0400
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CFA210CF
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 08:13:53 -0700 (PDT)
X-GND-Sasl: miquel.raynal@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1688483632;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vXGiUI7wXthGZKQ/sxJzjijIY2a26JIxtb9GTkcZ6mU=;
        b=ZrdHbbyuAduccdHY9ijrExqWBbYQXeH5ibGBH4XcqvtTTD0jkSMeeZNAWtOF7pGfMrDpGH
        cEcOmHkDq6cMCEdkGQR/WnTYQR1TjPuj4xaxq/fhcy37oUCj5rBKMdKaLBE3m7GVCAmhco
        7BFVpTltuJSlRYXCt1wsbhwRE7hc5PRybVaqydcLPo9/lMf0+GKOU04HG5lTL1ZMc3aevQ
        pYB7yjhHECcAZaKVB9mHg3TU2TE1IC8VXTwv6cHQZRTMGDOzC+0mXqnr3tZ4xrAjb0Jvqw
        HK8JAu3Fhms9VXRlYSBHoCtaCFV9vSaz+KMU0piBK2EAuREw1EvD0qflPBgYgA==
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id B78866000F;
        Tue,  4 Jul 2023 15:13:49 +0000 (UTC)
Date:   Tue, 4 Jul 2023 17:13:48 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     richard@nod.at, vigneshr@ti.com, heiko@sntech.de,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, yifeng.zhao@rock-chips.com
Subject: Re: [PATCH v3 3/3] mtd: rawnand: rockchip-nand-controller: add
 skipbbt option
Message-ID: <20230704171348.5eee98f7@xps-13>
In-Reply-To: <457c1da7-61dc-2a56-4f86-47413795138c@gmail.com>
References: <0047fc52-bc45-a768-8bdd-c0f12cddc17e@gmail.com>
        <457c1da7-61dc-2a56-4f86-47413795138c@gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Johan,

jbx6244@gmail.com wrote on Thu, 15 Jun 2023 19:34:26 +0200:

> On Rockchip SoCs the first boot stages are written on NAND
> with help of manufacturer software that uses a different format
> then the MTD framework. Skip the automatic BBT scan with the
> NAND_SKIP_BBTSCAN option so that the original content is unchanged
> during the driver probe.
> The NAND_NO_BBM_QUIRK option allows us to erase bad blocks with
> the nand_erase_nand() function and the flash_erase command.
> With these options the user has the "freedom of choice" by neutral
> access mode to read and write in whatever format is needed.

Can the boot_rom_mode thing help?

For writing this part you can disable the bad block protection using
debugfs and then write an externally processed file in raw mode I guess.

For the boot I think I proposed a DT property. I don't remember how far
the discussion went.

>=20
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
>=20
> Changes V3:
>   Change prefixes
>=20
> Changed V2:
>   reword
>=20
> ---
>=20
> I'm aware that the maintainer finds it "awful",
> but it's absolute necessary to:
> 1: read/write boot blocks in user space without touching original content
> 2: format a NAND for MTD either with built in or external driver module
>=20
> So we keep it include in this serie.
> ---
>  drivers/mtd/nand/raw/rockchip-nand-controller.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/drivers/mtd/nand/raw/rockchip-nand-controller.c b/drivers/mt=
d/nand/raw/rockchip-nand-controller.c
> index 5a0468034..fcda4c760 100644
> --- a/drivers/mtd/nand/raw/rockchip-nand-controller.c
> +++ b/drivers/mtd/nand/raw/rockchip-nand-controller.c
> @@ -188,6 +188,10 @@ struct rk_nfc {
>  	unsigned long assigned_cs;
>  };
>=20
> +static int skipbbt;
> +module_param(skipbbt, int, 0644);
> +MODULE_PARM_DESC(skipbbt, "Skip BBT scan if data on the NAND chip is not=
 in MTD format.");
> +
>  static inline struct rk_nfc_nand_chip *rk_nfc_to_rknand(struct nand_chip=
 *chip)
>  {
>  	return container_of(chip, struct rk_nfc_nand_chip, chip);
> @@ -1153,6 +1157,9 @@ static int rk_nfc_nand_chip_init(struct device *dev=
, struct rk_nfc *nfc,
>=20
>  	nand_set_controller_data(chip, nfc);
>=20
> +	if (skipbbt)
> +		chip->options |=3D NAND_SKIP_BBTSCAN | NAND_NO_BBM_QUIRK;
> +
>  	chip->options |=3D NAND_USES_DMA | NAND_NO_SUBPAGE_WRITE;
>  	chip->bbt_options =3D NAND_BBT_USE_FLASH | NAND_BBT_NO_OOB;
>=20
> --
> 2.30.2
>=20


Thanks,
Miqu=C3=A8l
