Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 333C8750786
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 14:07:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231881AbjGLMHI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 08:07:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjGLMHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 08:07:07 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 488EC10F3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 05:07:02 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5BAFC40007;
        Wed, 12 Jul 2023 12:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1689163620;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E7ByKZ6oXF6klWgs2IJLwIobDTVTZio3/GXOfUphAec=;
        b=o4PPeJa6zgRt3UiGPCief6r+PAxy2XWT8DlOmuoUwwpF8ch48sJUaMbjT/suvREM7Hcq37
        8z+/KLv7GUBt6TZtsK79jHsq826uZHC9U7z+/HbNlVpZ+PFFaENxM7b5luXr1XWo2PCgnx
        HsnUVGr7rk9iUmsK0aeibehjZXFeOw/yXIgEt5a9NVFNM+M23L0P3ZV3Ie3XsbsiyMxvpP
        siKtD56rxyksEnM7A8EQBLHK7TDOiyJkkfIbzWJ/vXVwKj7owExNXALh3xU25ZqiOfe7Tn
        mDGkOuKqGvp7Qw7ZGLgfxB+Z9RVBCkygIap408+nQNilsXfZbowSbThkpQ4jgQ==
Date:   Wed, 12 Jul 2023 14:06:55 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Yangtao Li <frank.li@vivo.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/18] mtd: rawnand: sunxi: Use
 devm_platform_get_and_ioremap_resource()
Message-ID: <20230712140655.72fc2a3d@xps-13>
In-Reply-To: <20230712135455.71fbeb5f@xps-13>
References: <20230707040622.78174-1-frank.li@vivo.com>
        <20230712135455.71fbeb5f@xps-13>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


miquel.raynal@bootlin.com wrote on Wed, 12 Jul 2023 13:54:55 +0200:

> Hi Yangtao,
>=20
> frank.li@vivo.com wrote on Fri,  7 Jul 2023 12:06:05 +0800:
>=20
> > Convert platform_get_resource(), devm_ioremap_resource() to a single
> > call to devm_platform_get_and_ioremap_resource(), as this is exactly
> > what this function does.
> >=20
> > Signed-off-by: Yangtao Li <frank.li@vivo.com>
> > ---
> >  drivers/mtd/nand/raw/sunxi_nand.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/mtd/nand/raw/sunxi_nand.c b/drivers/mtd/nand/raw/s=
unxi_nand.c
> > index 9884304634f6..db36bd755b8d 100644
> > --- a/drivers/mtd/nand/raw/sunxi_nand.c
> > +++ b/drivers/mtd/nand/raw/sunxi_nand.c
> > @@ -2087,8 +2087,7 @@ static int sunxi_nfc_probe(struct platform_device=
 *pdev)
> >  	nand_controller_init(&nfc->controller);
> >  	INIT_LIST_HEAD(&nfc->chips);
> > =20
> > -	r =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > -	nfc->regs =3D devm_ioremap_resource(dev, r);
> > +	nfc->regs =3D devm_platform_get_and_ioremap_resource(pdev, 0, &r);
>=20
> Why do you keep a reference over the resource? Why not just
> devm_platform_ioremap_resource(pdev, 0) ?
>=20
> This comment is valid for almost all the cases in this series.

Actually 'r' is used at the bottom, so the patch is good. I reviewed
all the patches, 17 look right, I have a minor comment on one of them.
In order to avoid resending all the patches, I'll first apply the 17
good ones and ask you to resend just the last one.

> When the resource is only needed in an error printk, I am also in favor
> of modifying the error message to avoid having to grab the resource.
>=20
> >  	if (IS_ERR(nfc->regs))
> >  		return PTR_ERR(nfc->regs);
> > =20
>=20
> These comments apply to the 18 patches.
>=20
> Thanks,
> Miqu=C3=A8l


Thanks,
Miqu=C3=A8l
