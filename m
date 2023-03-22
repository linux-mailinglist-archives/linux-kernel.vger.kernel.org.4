Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04D8E6C4A18
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 13:15:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbjCVMPv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 08:15:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbjCVMPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 08:15:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94AD736478
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 05:15:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 408A3B81C6C
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 12:15:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D206BC433EF;
        Wed, 22 Mar 2023 12:15:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679487342;
        bh=MJZTBV/TiIQxklEISjGR4bR/i64yEQVzbc3Njsr1RI0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JB1EtYuWzA0LQQiZ3O9zApfzLPUvnHT14FdF+yexXrmIcyJfls70JS0w0TACVfVaN
         dII7VuMFVBVdx9bLgDqHrnZ1kVzFqfS+rsNTD0DRIYVz7mMxDJQ2vVrQ/VYCID2/2E
         ETK8g38plUMOOXdC3eS0DtdsdyxfQP53KgUb9xCptMPkFp5vZbN2Mw4qY0oWUAwcrD
         9M5vCzt5Hu8tfOBEkWzYbFuDe5w0IA8pGUi6TYyI0+N1Z7CZV1qMpEnaGwfSP82o6B
         5qcHsZEpmhB9NFw7r85SVpW87/rmWcDvajmSFgXnRb8wMilXkf3A1EM/mT7HcplgHf
         +TLs4AKykF71g==
Date:   Wed, 22 Mar 2023 13:15:36 +0100
From:   Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
To:     <ye.xingchen@zte.com.cn>
Cc:     <miquel.raynal@bootlin.com>, <kishon@kernel.org>,
        <linux-phy@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <vkoul@kernel.org>
Subject: Re: [PATCH] phy: marvell: phy-mvebu-a3700-comphy: use
 devm_platform_ioremap_resource_byname()
Message-ID: <20230322131536.2b43010f@dellmb>
In-Reply-To: <202303221007049346627@zte.com.cn>
References: <202303221007049346627@zte.com.cn>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.35; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Mar 2023 10:07:04 +0800 (CST)
<ye.xingchen@zte.com.cn> wrote:

> From: Ye Xingchen <ye.xingchen@zte.com.cn>
>=20
> Convert platform_get_resource_byname(),devm_ioremap_resource() to a single
> call to devm_platform_ioremap_resource_byname(), as this is exactly what
> this function does.
>=20
> Signed-off-by: Ye Xingchen <ye.xingchen@zte.com.cn>
> ---
>  drivers/phy/marvell/phy-mvebu-a3700-comphy.c | 16 ++++------------
>  1 file changed, 4 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/phy/marvell/phy-mvebu-a3700-comphy.c b/drivers/phy/m=
arvell/phy-mvebu-a3700-comphy.c
> index d641b345afa3..9aeeedf59f44 100644
> --- a/drivers/phy/marvell/phy-mvebu-a3700-comphy.c
> +++ b/drivers/phy/marvell/phy-mvebu-a3700-comphy.c
> @@ -1241,7 +1241,6 @@ static int mvebu_a3700_comphy_probe(struct platform=
_device *pdev)
>  	struct mvebu_a3700_comphy_priv *priv;
>  	struct phy_provider *provider;
>  	struct device_node *child;
> -	struct resource *res;
>  	struct clk *clk;
>  	int ret;
>=20
> @@ -1251,26 +1250,19 @@ static int mvebu_a3700_comphy_probe(struct platfo=
rm_device *pdev)
>=20
>  	spin_lock_init(&priv->lock);
>=20
> -	res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM, "comphy");
> -	priv->comphy_regs =3D devm_ioremap_resource(&pdev->dev, res);
> +	priv->comphy_regs =3D devm_platform_ioremap_resource_byname(pdev, "comp=
hy");
>  	if (IS_ERR(priv->comphy_regs))
>  		return PTR_ERR(priv->comphy_regs);
>=20
> -	res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM,
> -					   "lane1_pcie_gbe");
> -	priv->lane1_phy_regs =3D devm_ioremap_resource(&pdev->dev, res);
> +	priv->lane1_phy_regs =3D devm_platform_ioremap_resource_byname(pdev, "l=
ane1_pcie_gbe");
>  	if (IS_ERR(priv->lane1_phy_regs))
>  		return PTR_ERR(priv->lane1_phy_regs);
>=20
> -	res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM,
> -					   "lane0_usb3_gbe");
> -	priv->lane0_phy_regs =3D devm_ioremap_resource(&pdev->dev, res);
> +	priv->lane0_phy_regs =3D devm_platform_ioremap_resource_byname(pdev, "l=
ane0_usb3_gbe");
>  	if (IS_ERR(priv->lane0_phy_regs))
>  		return PTR_ERR(priv->lane0_phy_regs);
>=20
> -	res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM,
> -					   "lane2_sata_usb3");
> -	priv->lane2_phy_indirect =3D devm_ioremap_resource(&pdev->dev, res);
> +	priv->lane2_phy_indirect =3D devm_platform_ioremap_resource_byname(pdev=
, "lane2_sata_usb3");
>  	if (IS_ERR(priv->lane2_phy_indirect))
>  		return PTR_ERR(priv->lane2_phy_indirect);
>=20

Reviewed-by: Marek Beh=C3=BAn <kabel@kernel.org>
