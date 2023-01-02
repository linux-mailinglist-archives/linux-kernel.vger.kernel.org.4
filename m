Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7983565AE9D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 10:21:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbjABJVe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 04:21:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjABJVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 04:21:31 -0500
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1272DCF
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 01:21:28 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 3A05AE000E;
        Mon,  2 Jan 2023 09:21:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1672651286;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7iy6kRpjbShIO/YNDBtH1+IvGNDYKzJ6crYcrc+yU+s=;
        b=bBD2KATViq9V9UFZTRuVakbuRQmAKRuR+IDKsnCP+gWLdh+yPLGqT/HX6i4IHbXs43RZNe
        yVXVnsWjw91UjV7MAlz7nlm35DsxSEGo/a4ifHfJaJ0oCB4rTnsIrNKWx1KQIlSny87nIv
        KFlis88NcA1ut7c65tYKU/kc2w8RUMnAwukx5uvyRioydsU7uXdFM+2MXFijyNC6tAmmo6
        9nuLZLiIEEzmgK8TyTNCXM59jVBQ97zOnCj6lwSrTAXkJ+7n0v8kwxtl7wbeIy8S5EWWyt
        AMO3z+26t+oOVCfG6c9VTqtwJsGSPD1IsVWrI05gII4nQyocPnP+LSUS6zV+nA==
Date:   Mon, 2 Jan 2023 10:21:23 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Brian Norris <computersforpeace@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH 6/7] mtd: rawnand: sunxi: Update OOB layout to match
 hardware
Message-ID: <20230102102123.511d337d@xps-13>
In-Reply-To: <20221229181526.53766-7-samuel@sholland.org>
References: <20221229181526.53766-1-samuel@sholland.org>
        <20221229181526.53766-7-samuel@sholland.org>
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

Hi Samuel,

samuel@sholland.org wrote on Thu, 29 Dec 2022 12:15:25 -0600:

> When using the hardware ECC engine, the OOB data is made available in
> the NFC_REG_USER_DATA registers, one 32-bit word per ECC step. Any
> additional bytes are only accessible through raw reads and software
> descrambling. For efficiency, and to match the vendor driver, ignore
> these extra bytes.
>=20
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
>=20
>  drivers/mtd/nand/raw/sunxi_nand.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/drivers/mtd/nand/raw/sunxi_nand.c b/drivers/mtd/nand/raw/sun=
xi_nand.c
> index 8e873f4fec9a..a3bc9f7f9e5a 100644
> --- a/drivers/mtd/nand/raw/sunxi_nand.c
> +++ b/drivers/mtd/nand/raw/sunxi_nand.c
> @@ -1604,6 +1604,13 @@ static int sunxi_nand_ooblayout_free(struct mtd_in=
fo *mtd, int section,
>  		return 0;
>  	}
> =20
> +	/*
> +	 * The controller does not provide access to OOB bytes
> +	 * past the end of the ECC data.
> +	 */
> +	if (section =3D=3D ecc->steps && ecc->engine_type =3D=3D NAND_ECC_ENGIN=
E_TYPE_ON_HOST)
> +		return -ERANGE;

Again, I am sorry but I cannot take this change, it would typically
break jffs2 users (if any?) :(

>  	oobregion->offset =3D section * (ecc->bytes + 4);
> =20
>  	if (section < ecc->steps)


Thanks,
Miqu=C3=A8l
