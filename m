Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 682937256F9
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 10:09:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235447AbjFGIJO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 04:09:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238665AbjFGIJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 04:09:11 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 395D710EC
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 01:09:07 -0700 (PDT)
X-GND-Sasl: miquel.raynal@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1686125346;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Uvksj9+UTvDgflRsg73N5TFFbYS+sBxliu8X8GLsizk=;
        b=G59dKWV0vhixhK+7vErxEEZ4NfcDztQRB6cB2HMGjROdt1v88OIGFy+8wrGrQv7FsgbzJf
        2tk+pv6vqg1HIedGRioquJpX3vymzXs16pxp/r667GQXf+G9gxCaK7Kf+UNkwNlYuuMn1O
        A57Jtz0psOH3fWW8tE8v+pIb/zObc3o7A+W3qs/sEPO7oHwBv2uAiKwwL0FwPZ4GnfucgV
        EYmY+k/nNjiWprnS7mBaA4Wrj4WAdQ2pnytjHUyIKfQHGqP6oMulZ0Imp/KXJXqXrQm4LD
        qzfBY7o3uxkC+qFTG11SNmABBplJpAHAdf9w+u85OAVBP8kffmdgvmuO7y1Q7A==
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
Received: by mail.gandi.net (Postfix) with ESMTPSA id 71A6EC0009;
        Wed,  7 Jun 2023 08:09:03 +0000 (UTC)
Date:   Wed, 7 Jun 2023 10:09:02 +0200
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
Subject: Re: [PATCH 04/12] mtd: rawnand: brcmnand: Fix potential
 out-of-bounds access in oob write
Message-ID: <20230607100902.4df2bc27@xps-13>
In-Reply-To: <20230606231252.94838-5-william.zhang@broadcom.com>
References: <20230606231252.94838-1-william.zhang@broadcom.com>
        <20230606231252.94838-5-william.zhang@broadcom.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi William,

william.zhang@broadcom.com wrote on Tue,  6 Jun 2023 16:12:44 -0700:

> When the oob buffer length is not in multiple of words, the oob write
> function does out-of-bounds read on the oob source buffer at the last
> iteration. Fix that by always checking length limit on the oob buffer
> read and fill with 0xff when reaching the end of the buffer to the oob
> registers.
>=20
> Fixes: 27c5b17cd1b1 ("mtd: nand: add NAND driver "library" for Broadcom S=
TB NAND controller")
> Signed-off-by: William Zhang <william.zhang@broadcom.com>
> Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
> ---
>=20
>  drivers/mtd/nand/raw/brcmnand/brcmnand.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/mtd/nand/raw/brcmnand/brcmnand.c b/drivers/mtd/nand/=
raw/brcmnand/brcmnand.c
> index 20832857c4aa..d920e88c7f5b 100644
> --- a/drivers/mtd/nand/raw/brcmnand/brcmnand.c
> +++ b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
> @@ -1486,10 +1486,10 @@ static int write_oob_to_regs(struct brcmnand_cont=
roller *ctrl, int i,
> =20
>  	for (j =3D 0; j < tbytes; j +=3D 4)
>  		oob_reg_write(ctrl, j,
> -				(oob[j + 0] << 24) |
> -				(oob[j + 1] << 16) |
> -				(oob[j + 2] <<  8) |
> -				(oob[j + 3] <<  0));
> +				(((j < tbytes) ? oob[j] : 0xff) << 24) |
> +				(((j + 1 < tbytes) ? oob[j + 1] : 0xff) << 16) |
> +				(((j + 2 < tbytes) ? oob[j + 2] : 0xff) << 8) |
> +				((j + 3 < tbytes) ? oob[j + 3] : 0xff));

This is a lot of additional operations which most of the time are not
relevant. I would instead got for one less iteration in the for loop
when there is unaligned data, and then dedicated if/else to fill the
missing bytes.

>  	return tbytes;
>  }
> =20


Thanks,
Miqu=C3=A8l
