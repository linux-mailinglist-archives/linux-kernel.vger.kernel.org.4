Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBC35750798
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 14:10:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232537AbjGLMKC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 08:10:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbjGLMJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 08:09:59 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6A1DE4D
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 05:09:57 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2C5EB1BF214;
        Wed, 12 Jul 2023 12:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1689163796;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zvTXj2XKIImCanBcXd2KzasaETb74Ehz2NCjHpi8yRA=;
        b=flF18ImExTNqBaUSiEUNqXskEu134Ys8W2gfI8indQjF8nRIKYFPdmi5VGR+vPgzm2ob1d
        CVohabiv7UJjNqBz2mdRRPrgFEEsRmyswj+7isa3Nq86JPDCZplyVZG2f7VBSGs6WyqjHZ
        /mBWutSDzFKrrkk4nLIExk/fHlpAmTE9wIgdIDQoH7TaDbc/Wr6J1JptosxhOxJaTDbr+9
        O+P0Xss+c1njp+zC60pzXqsVqVqwQLPUnzubjgMmiaW8fDVzXnE1h8zkwORGVvsJprHT/e
        APIewenREK6JwuAjx+t31q+0e2/xHTZfMWjFlkfrxHF3WJGNNUB8eH18oxn9CA==
Date:   Wed, 12 Jul 2023 14:09:53 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Yangtao Li <frank.li@vivo.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/18] mtd: rawnand: davinci: Convert to
 devm_platform_ioremap_resource()
Message-ID: <20230712140953.30b5309c@xps-13>
In-Reply-To: <20230707040622.78174-9-frank.li@vivo.com>
References: <20230707040622.78174-1-frank.li@vivo.com>
        <20230707040622.78174-9-frank.li@vivo.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yangtao,

frank.li@vivo.com wrote on Fri,  7 Jul 2023 12:06:13 +0800:

> Use devm_platform_ioremap_resource() to simplify code.
>=20
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>  drivers/mtd/nand/raw/davinci_nand.c | 21 +++++++++------------
>  1 file changed, 9 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/mtd/nand/raw/davinci_nand.c b/drivers/mtd/nand/raw/d=
avinci_nand.c
> index 415d6aaa8255..2db1cd1d3d03 100644
> --- a/drivers/mtd/nand/raw/davinci_nand.c
> +++ b/drivers/mtd/nand/raw/davinci_nand.c
> @@ -710,8 +710,7 @@ static int nand_davinci_probe(struct platform_device =
*pdev)
>  {
>  	struct davinci_nand_pdata	*pdata;
>  	struct davinci_nand_info	*info;
> -	struct resource			*res1;
> -	struct resource			*res2;
> +	struct resource			*res;
>  	void __iomem			*vaddr;
>  	void __iomem			*base;
>  	int				ret;
> @@ -736,26 +735,24 @@ static int nand_davinci_probe(struct platform_devic=
e *pdev)
> =20
>  	platform_set_drvdata(pdev, info);
> =20
> -	res1 =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	res2 =3D platform_get_resource(pdev, IORESOURCE_MEM, 1);
> -	if (!res1 || !res2) {
> -		dev_err(&pdev->dev, "resource missing\n");
> -		return -EINVAL;
> -	}
> -
> -	vaddr =3D devm_ioremap_resource(&pdev->dev, res1);
> +	vaddr =3D devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(vaddr))
>  		return PTR_ERR(vaddr);
> =20
> +	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 1);
> +	if (!res) {
> +		dev_err(&pdev->dev, "resource missing\n");
> +		return -EINVAL;
> +	}
>  	/*
>  	 * This registers range is used to setup NAND settings. In case with
>  	 * TI AEMIF driver, the same memory address range is requested already
>  	 * by AEMIF, so we cannot request it twice, just ioremap.
>  	 * The AEMIF and NAND drivers not use the same registers in this range.
>  	 */
> -	base =3D devm_ioremap(&pdev->dev, res2->start, resource_size(res2));
> +	base =3D devm_ioremap(&pdev->dev, res->start, resource_size(res));
>  	if (!base) {
> -		dev_err(&pdev->dev, "ioremap failed for resource %pR\n", res2);
> +		dev_err(&pdev->dev, "ioremap failed for resource %pR\n", res);

I believe this is the only use of the resource, I am in favor of just
using the regular devm_platform_ioremap_resource() helper here and just
drop the reference to the resource from the message.

I will apply all other patches, please send a v2 only for this one
once improved.

>  		return -EADDRNOTAVAIL;
>  	}
> =20


Thanks,
Miqu=C3=A8l
