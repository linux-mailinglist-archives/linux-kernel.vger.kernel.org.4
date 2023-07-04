Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E8C17474B7
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 17:03:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231532AbjGDPDn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 11:03:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbjGDPDl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 11:03:41 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47ADD10CA
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 08:03:40 -0700 (PDT)
X-GND-Sasl: miquel.raynal@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1688483018;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u8ZiWkw6IBpKG50zIyLyU+jiftpJ82AROu6SkrKwfwg=;
        b=LWX3IDTrOPsRhKGhQr/GX/zJ9BYGijrfq5Bcu9sImmDOBKiP1LgjkqfkBSLUHrL5wKT/9f
        kAkEbbvo7+ilIRp0XLlfvpSsIV89TczcafFhWxmgxXPcqV9iER5sS/9LOORpVPMqTR+/Tw
        oaCnhqbuO4meQoccNvu2XMTFfuYYWsmHyh0yHY8Kq2+s3Cszj6lJ08pYfvMAK31shCura9
        U3Qm7FdvSX7TRFnG1+rFAFpP5iRxXZKk+wROrHe104zENZHGCKB+QGMOV6D2Im/aq4Fgd2
        7vf3RcwU/iCIrtxFPDm5a3Alu4Kz2GZZ6N5Xrr1lIEADshzr7Yl59Q93eDGiKw==
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3B32D1C000A;
        Tue,  4 Jul 2023 15:03:37 +0000 (UTC)
Date:   Tue, 4 Jul 2023 17:03:36 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     richard@nod.at, vigneshr@ti.com, heiko@sntech.de,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, yifeng.zhao@rock-chips.com
Subject: Re: [PATCH v3 1/3] mtd: rawnand: rockchip-nand-controller: fix
 oobfree offset and description
Message-ID: <20230704170336.7e46911f@xps-13>
In-Reply-To: <dfb76ad5-b62a-3f1d-494e-cd17d57945ae@gmail.com>
References: <0047fc52-bc45-a768-8bdd-c0f12cddc17e@gmail.com>
        <dfb76ad5-b62a-3f1d-494e-cd17d57945ae@gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Johan,

Would you mind reducing the subjets with
s/rockchip-nand-controller/rockchip/?

jbx6244@gmail.com wrote on Thu, 15 Jun 2023 19:34:01 +0200:

> The MTD framework reserves 1 or 2 bytes for the bad block marker
> depending on the bus size. The rockchip-nand-controller driver
> currently only supports a 8 bit bus, but reserves standard 2 bytes
> for the BBM in the chip->oob_poi buffer. The first free OOB byte is
> therefore OOB2 at offset 2.

Again, I don't think it's ever been a single byte. Please drop this
paragraph, it does not justify anything below. What is important here
is the PA thing I guess.

> Page Address (PA) bytes are located at the

Maybe you can briefly explain what the PA bytes are above.

> last 4 positions before ECC. The current advertised free OOB area has
> an offset that starts at OOB6 and a length that overlaps with the space

Let me try to rephrase this:

"
The currently advertised free OOB area starts at offset 6, like
if 4 PA bytes were located right after the BBM. This is wrong as the
PA bytes are located right before the ECC bytes.

Fix the layout by allowing access to all bytes between the BBM and the
PA bytes instead of reserving 4 bytes right after the BBM.

> reserved for the PA bytes. Writing unrelated data to a reserved space
> with a specific task can corrupt our boot block page read order.

"our"?

> Fix by changing the free OOB offset to 2.
>=20
> This change breaks existing jffs2 users.
>=20
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>

Please add a Fixes tag, now that I look at it again, it looks like
the original author did try to protect these PA bytes, but failed.

> ---
>=20
> Changed V3:
>   Change prefixes
>   Reword
>   State break existing users.
>=20
> ---
>=20
> Example:
>=20
> Wrong free OOB offset starts at OOB6:
> oob_region->offset =3D NFC_SYS_DATA_SIZE + 2;
>                    =3D 4 + 2
>                    =3D 6
>=20
> oob_region->length =3D rknand->metadata_size - NFC_SYS_DATA_SIZE - 2;
>                    =3D 32 - 4 - 2
>                    =3D 26
>=20
> Together with this length above it overlaps a reserved space for the
> boot blocks Page Address(PA)
>=20
> chip->oob_poi buffer layout for 8 steps:
>=20
> BBM0   BBM1  OOB2  OOB3  | OOB4  OOB5  OOB6  OOB7
>=20
> OOB8   OOB9  OOB10 OOB11 | OOB12 OOB13 OOB15 OOB15
> OOB16  OOB17 OOB18 OOB19 | OOB20 OOB21 OOB22 OOB23
>=20
> OOB24  OOB25 OOB26 OOB27 | PA0   PA1   PA2   PA3
>=20
> ECC0   ECC1  ECC2  ECC3  | ...   ...   ...   ...
>=20
> Fix by new offset at OOB2:
> oob_region->offset =3D 2;
>=20
> The full range of free OOB with 8 steps runs from OOB2
> till/including OOB27.
> ---
>  drivers/mtd/nand/raw/rockchip-nand-controller.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/mtd/nand/raw/rockchip-nand-controller.c b/drivers/mt=
d/nand/raw/rockchip-nand-controller.c
> index 2312e2736..37fc07ba5 100644
> --- a/drivers/mtd/nand/raw/rockchip-nand-controller.c
> +++ b/drivers/mtd/nand/raw/rockchip-nand-controller.c
> @@ -562,9 +562,10 @@ static int rk_nfc_write_page_raw(struct nand_chip *c=
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
> @@ -933,12 +934,8 @@ static int rk_nfc_ooblayout_free(struct mtd_info *mt=
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
