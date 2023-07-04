Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B223E74754E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 17:29:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231578AbjGDP3K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 11:29:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231528AbjGDP2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 11:28:37 -0400
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43BF010EA
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 08:28:21 -0700 (PDT)
X-GND-Sasl: miquel.raynal@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1688484499;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cKvjqirkVFA+BNwb+44FbYBe7KMP6crTFIpQu43cGgY=;
        b=iqpIQ5dk7iebCcPsVughgIw60V8zQuNfjxJgtFr+44ariRfiXUvU3jwBrrLPh6hPLKK1FZ
        Y4KTfBaa82r2XG0FvFclSrix8rbJBLFZ0EfgqB1WmWrtGepOPOJoN3+89DiiIONOoM4ER8
        ca0mvSsrtVyQwj7C3oLEniPoocrAfwHgv9i3WxMGYvLTzCOgFlmb3W3UJN/lTP/Yvpfav2
        elCYPKab0cTTllKtKQbVBs0L00qRZ45xIrGhy8oGXbmpg5xA8fUoY+8uwhH5XNT7SXBI7u
        hPFwxCC8crVM2pnScZuRzKYCbrktb92AEQAlE38R4sHOCryq7EwMhy+gjURuRw==
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
X-GND-Sasl: miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id EE7D92000D;
        Tue,  4 Jul 2023 15:28:17 +0000 (UTC)
Date:   Tue, 4 Jul 2023 17:28:17 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     William Zhang <william.zhang@broadcom.com>
Cc:     Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>,
        Linux MTD List <linux-mtd@lists.infradead.org>,
        f.fainelli@gmail.com, rafal@milecki.pl, kursad.oney@broadcom.com,
        joel.peshkin@broadcom.com, computersforpeace@gmail.com,
        anand.gore@broadcom.com, dregan@mail.com, kamal.dasu@broadcom.com,
        tomer.yacoby@broadcom.com, dan.beygelman@broadcom.com,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        linux-kernel@vger.kernel.org,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Richard Weinberger <richard@nod.at>,
        Kamal Dasu <kdasu.kdev@gmail.com>
Subject: Re: [PATCH v3 4/5] mtd: rawnand: brcmnand: Fix potential
 out-of-bounds access in oob write
Message-ID: <20230704172817.02e4cdb8@xps-13>
In-Reply-To: <20230627193738.19596-5-william.zhang@broadcom.com>
References: <20230627193738.19596-1-william.zhang@broadcom.com>
        <20230627193738.19596-5-william.zhang@broadcom.com>
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

Hi William,

william.zhang@broadcom.com wrote on Tue, 27 Jun 2023 12:37:37 -0700:

> When the oob buffer length is not in multiple of words, the oob write
> function does out-of-bounds read on the oob source buffer at the last
> iteration. Fix that by always checking length limit on the oob buffer
> read and fill with 0xff when reaching the end of the buffer to the oob
> registers.
>=20
> Fixes: 27c5b17cd1b1 ("mtd: nand: add NAND driver "library" for Broadcom S=
TB NAND controller")

Wrong Fixes.

Missing Cc stable.

> Signed-off-by: William Zhang <william.zhang@broadcom.com>
> Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
>=20
> ---
>=20
> Changes in v3:
> - Fix kernel test robot sparse warning:
>    drivers/mtd/nand/raw/brcmnand/brcmnand.c:1500:54: sparse: expected uns=
igned int [usertype] data
>    drivers/mtd/nand/raw/brcmnand/brcmnand.c:1500:54: sparse: got restrict=
ed __be32 [usertype]
>=20
> Changes in v2:
> - Handle the remaining unaligned oob data after the oob data write loop
>=20
>  drivers/mtd/nand/raw/brcmnand/brcmnand.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/mtd/nand/raw/brcmnand/brcmnand.c b/drivers/mtd/nand/=
raw/brcmnand/brcmnand.c
> index ea03104692bf..407bf79cbaf4 100644
> --- a/drivers/mtd/nand/raw/brcmnand/brcmnand.c
> +++ b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
> @@ -1477,19 +1477,28 @@ static int write_oob_to_regs(struct brcmnand_cont=
roller *ctrl, int i,
>  			     const u8 *oob, int sas, int sector_1k)
>  {
>  	int tbytes =3D sas << sector_1k;
> -	int j;
> +	int j, k =3D 0;
> +	u32 last =3D 0xffffffff;
> +	u8 *plast =3D (u8 *)&last;
> =20
>  	/* Adjust OOB values for 1K sector size */
>  	if (sector_1k && (i & 0x01))
>  		tbytes =3D max(0, tbytes - (int)ctrl->max_oob);
>  	tbytes =3D min_t(int, tbytes, ctrl->max_oob);
> =20
> -	for (j =3D 0; j < tbytes; j +=3D 4)
> +	for (j =3D 0; (j + 3) < tbytes; j +=3D 4)

Maybe a comment here as well to mention that you stop at the last
iteration? Otherwise, just reading the line does not make you choice
obvious.

>  		oob_reg_write(ctrl, j,
>  				(oob[j + 0] << 24) |
>  				(oob[j + 1] << 16) |
>  				(oob[j + 2] <<  8) |
>  				(oob[j + 3] <<  0));
> +
> +	while (j < tbytes)
> +		plast[k++] =3D oob[j++];
> +
> +	if (tbytes & 0x3)
> +		oob_reg_write(ctrl, (tbytes & ~0x3), (__force u32)cpu_to_be32(last));
> +
>  	return tbytes;
>  }
> =20


Thanks,
Miqu=C3=A8l
