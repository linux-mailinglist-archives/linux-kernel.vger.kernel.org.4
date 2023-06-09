Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5459A72938D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 10:44:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240305AbjFIIoi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 04:44:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231143AbjFIIog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 04:44:36 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 564C1B9
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 01:44:33 -0700 (PDT)
X-GND-Sasl: miquel.raynal@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1686300272;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EUFfRtsLHvopatEGwTEyaADeR/Nh06kib+daVSfwfes=;
        b=MeanmY/uWXzjatJigRXE4FAin676dndJHzveYMdReO3ydYBO5ek4HsbrEv/grxjUX6eCGo
        ob0nFC/lSrTRVOrc2eQzR3E24rdfQuCicXQGFfx7nq88seI2scNhlQMhcdPzyLdVXAw4F3
        g5Oxh827fnN2BCDCijwfAuTXdo8XEFM4HWyioqPKd6aEZZnovGGC+Clkftkkj39Xfcvafy
        NchUPN7S9PgM90RB3BVy4k+pwx4OO1w1fp83WcnuBmE9LU+yQ4LGtuvUBFrMtKGKC1SWur
        lduwC5U9Kc97G/hDa9lF70uL/upMt87GZ8y5TvWDtSu58QzAfTc4lKuLNaDE/w==
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6E11C240002;
        Fri,  9 Jun 2023 08:44:29 +0000 (UTC)
Date:   Fri, 9 Jun 2023 10:44:26 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     richard@nod.at, vigneshr@ti.com, heiko@sntech.de,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, yifeng.zhao@rock-chips.com
Subject: Re: [PATCH v1 2/5] mtd: nand: raw: rockchip-nand-controller: add
 skipbbt option
Message-ID: <20230609104426.3901df54@xps-13>
In-Reply-To: <4d9473ce-c167-47d7-e37a-7b39915a724c@gmail.com>
References: <19bf714a-43f9-c30a-8197-91aaaf4a6e5d@gmail.com>
        <4d9473ce-c167-47d7-e37a-7b39915a724c@gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Johan,

jbx6244@gmail.com wrote on Thu, 8 Jun 2023 18:30:27 +0200:

> On Rockchip SoCs the first boot stages are written on NAND
> with help of manufacturer software that uses a different format
> then the MTD framework. Skip the automatic BBT scan with the
> NAND_SKIP_BBTSCAN option so we can run it manually.

How do you run it manually?

> The NAND_NO_BBM_QUIRK option allows us to erase bad blocks with
> the nand_erase_nand() function and the flash_erase command.

For erasure you now have access to a debugfs entry for
experts/forensics which allows you to bypass all bad block checks.

>=20
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
>  drivers/mtd/nand/raw/rockchip-nand-controller.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/drivers/mtd/nand/raw/rockchip-nand-controller.c b/drivers/mt=
d/nand/raw/rockchip-nand-controller.c
> index cafccc324..f56430f6c 100644
> --- a/drivers/mtd/nand/raw/rockchip-nand-controller.c
> +++ b/drivers/mtd/nand/raw/rockchip-nand-controller.c
> @@ -188,6 +188,10 @@ struct rk_nfc {
>  	unsigned long assigned_cs;
>  };
>=20
> +static int skipbbt;
> +module_param(skipbbt, int, 0644);
> +MODULE_PARM_DESC(skipbbt, "Skip BBT scan if the NAND chip contains data =
not in MTD format.");

I highly dislike this.

It's not a module parameter that you need, it is related to a partition.

> +
>  static inline struct rk_nfc_nand_chip *rk_nfc_to_rknand(struct nand_chip=
 *chip)
>  {
>  	return container_of(chip, struct rk_nfc_nand_chip, chip);
> @@ -1156,6 +1160,10 @@ static int rk_nfc_nand_chip_init(struct device *de=
v, struct rk_nfc *nfc,
>=20
>  	nand_set_controller_data(chip, nfc);
>=20
> +	/* Skip the automatic BBT scan so we can run it manually. */
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
