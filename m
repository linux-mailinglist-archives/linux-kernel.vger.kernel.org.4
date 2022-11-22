Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DDF4633946
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 11:03:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231948AbiKVKC6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 05:02:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232692AbiKVKCv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 05:02:51 -0500
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [217.70.178.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4CA66428
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 02:02:44 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id B3E27240005;
        Tue, 22 Nov 2022 10:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1669111363;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WmyFTJevytlulznh6ayTXhdY+HEVUzYjYVjdJQwaGpA=;
        b=kS1KYIO/K9Qw33D72feMPlykFfp1HxvQj1V26Lb6RRxOCB9idxMwB+em7Z8mwV2QWDqqjw
        zEjaffLJqRaO4qaW1SDdRYf6VTfSm/gQ2P2ENT116NbcBkoI9VXRZZnq8jXFp1b4ZG7M2n
        H9baSI2sLX9o002cd4iavRrgVaOkdvCSsHaT7Hz2YFCDokKCOb181N7wBszHJkOFYnSwME
        s+c5pat0v+obwM/BzYdpSaPPdkXMjEMz+KwOg3znPsGKl6g9ul/lQR0nA7t5NrrMLuNi+I
        pYYWhvqAIulnfOKBPIOC3G/ukgSzqY+kiUDhWLu65y4xQiqqNzsiFT0jP3Jmvg==
Date:   Tue, 22 Nov 2022 11:02:39 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     <ye.xingchen@zte.com.cn>
Cc:     <richard@nod.at>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <chi.minghao@zte.com.cn>
Subject: Re: [PATCH] mtd: rawnand: orion: use  
 devm_platform_get_and_ioremap_resource()
Message-ID: <20221122110226.3cdac73a@xps-13>
In-Reply-To: <202211220933274886024@zte.com.cn>
References: <202211220933274886024@zte.com.cn>
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

Hello,

ye.xingchen@zte.com.cn wrote on Tue, 22 Nov 2022 09:33:27 +0800 (CST):

> From: Minghao Chi <chi.minghao@zte.com.cn>
>=20

Double space in the subject

> Convert platform_get_resource(), devm_ioremap_resource() to a single
> call to devm_platform_get_and_ioremap_resource(), as this is exactly
> what this function does.
>=20
> Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
> ---
>  drivers/mtd/nand/raw/orion_nand.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>=20
> diff --git a/drivers/mtd/nand/raw/orion_nand.c b/drivers/mtd/nand/raw/ori=
on_nand.c
> index 1bfecf502216..00bd7be76e07 100644
> --- a/drivers/mtd/nand/raw/orion_nand.c
> +++ b/drivers/mtd/nand/raw/orion_nand.c
> @@ -102,7 +102,6 @@ static int __init orion_nand_probe(struct platform_de=
vice *pdev)
>  	struct mtd_info *mtd;
>  	struct nand_chip *nc;
>  	struct orion_nand_data *board;
> -	struct resource *res;
>  	void __iomem *io_base;
>  	int ret =3D 0;
>  	u32 val =3D 0;
> @@ -119,8 +118,7 @@ static int __init orion_nand_probe(struct platform_de=
vice *pdev)
>  	info->controller.ops =3D &orion_nand_ops;
>  	nc->controller =3D &info->controller;
>=20
> -	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	io_base =3D devm_ioremap_resource(&pdev->dev, res);
> +	io_base =3D devm_platform_get_and_ioremap_resource(pdev, 0, NULL);

If we no longer use res, why not just devm_platform_ioremap_resource() ?

>=20
>  	if (IS_ERR(io_base))
>  		return PTR_ERR(io_base);


Thanks,
Miqu=C3=A8l
