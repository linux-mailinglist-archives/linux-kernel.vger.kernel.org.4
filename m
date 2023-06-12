Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39B1D72CC7A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 19:27:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235342AbjFLR0u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 13:26:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231724AbjFLR0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 13:26:48 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C48A3107
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 10:26:46 -0700 (PDT)
X-GND-Sasl: miquel.raynal@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1686590805;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=m9Ld3OwQozi+S0Y0u/WiINpRr2FYKCtYTGv24WgCdUw=;
        b=KAmFjkkHeR8C+bJJkvmf0Blk30klu1nOUq+nG09jWWZmumLatfuKnzxeo8/O49IsNiyhto
        5/bDH1HgX4sy0cIsK/zYMDgkRCxHPopLl3gItJVR5Dp67BcSo7e8axfNliTagtTE02480s
        Yc076fm8LD6+H+ybgK/Xr8p9+YshBepsfce5VV7Q8NtgOKr3/DjizZEP9TxvTucuZAktjB
        1vrBva4ofkHjnEWGPOVJm1I6JbFOy6DX7/vxxuB4kYGn9iWOYgHdiE86C1cJ94e29oze3X
        UrbZRvxkhN/OCGCAm2KSONQvkU85dl5tov1PHyqqliyVsmjriYuNYMLKxW2VGA==
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 55B281C0003;
        Mon, 12 Jun 2023 17:26:41 +0000 (UTC)
Date:   Mon, 12 Jun 2023 19:26:40 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     richard@nod.at, vigneshr@ti.com, heiko@sntech.de,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, yifeng.zhao@rock-chips.com
Subject: Re: [PATCH v2 3/5] mtd: nand: raw: rockchip-nand-controller: fix
 oobfree offset and description
Message-ID: <20230612192640.63baf3e8@xps-13>
In-Reply-To: <f2cebf54-a16c-c849-a988-bfd98c502748@gmail.com>
References: <11e16c3b-6f7b-a6a9-b0ed-b7ac0cd703e3@gmail.com>
        <f2cebf54-a16c-c849-a988-bfd98c502748@gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Johan,

jbx6244@gmail.com wrote on Mon, 12 Jun 2023 17:03:18 +0200:

> The MTD framework reserves 1 or 2 bytes for the bad block marker
> depending on the bus size. The rockchip-nand-controller driver
> currently only supports a 8 bit bus, but reserves standard 2 bytes
> for the BBM.

We always reserve 2 bytes, no?

> The first free OOB byte is therefore OOB2 at offset 2.
> Page address(PA) bytes are moved to the last 4 positions before
> ECC. Update the description for Linux.

The description should just be:

Move Page Address (PA) bytes to the last 4 positions before ECC.

And then you should justify why this is needed. Also, this would break
all existing jffs2 users, right?

>=20
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
>  drivers/mtd/nand/raw/rockchip-nand-controller.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/mtd/nand/raw/rockchip-nand-controller.c b/drivers/mt=
d/nand/raw/rockchip-nand-controller.c
> index 31d8c7a87..fcda4c760 100644
> --- a/drivers/mtd/nand/raw/rockchip-nand-controller.c
> +++ b/drivers/mtd/nand/raw/rockchip-nand-controller.c
> @@ -566,9 +566,10 @@ static int rk_nfc_write_page_raw(struct nand_chip *c=
hip, const u8 *buf,
>  		 *    BBM  OOB1 OOB2 OOB3 |......|  PA0  PA1  PA2  PA3
>  		 *
>  		 * The rk_nfc_ooblayout_free() function already has reserved
> -		 * these 4 bytes with:
> +		 * these 4 bytes together with 2 bytes for BBM
> +		 * by reducing it's length:
>  		 *
> -		 * oob_region->offset =3D NFC_SYS_DATA_SIZE + 2;
> +		 * oob_region->length =3D rknand->metadata_size - NFC_SYS_DATA_SIZE - =
2;
>  		 */
>  		if (!i)
>  			memcpy(rk_nfc_oob_ptr(chip, i),
> @@ -945,12 +946,8 @@ static int rk_nfc_ooblayout_free(struct mtd_info *mt=
d, int section,
>  	if (section)
>  		return -ERANGE;
>=20
> -	/*
> -	 * The beginning of the OOB area stores the reserved data for the NFC,
> -	 * the size of the reserved data is NFC_SYS_DATA_SIZE bytes.
> -	 */
>  	oob_region->length =3D rknand->metadata_size - NFC_SYS_DATA_SIZE - 2;
> -	oob_region->offset =3D NFC_SYS_DATA_SIZE + 2;
> +	oob_region->offset =3D 2;
>=20
>  	return 0;
>  }
> --
> 2.30.2
>=20


Thanks,
Miqu=C3=A8l
