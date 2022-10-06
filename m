Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD8C45F61FE
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 09:48:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230352AbiJFHr7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 03:47:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbiJFHrw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 03:47:52 -0400
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DAAE9080B
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 00:47:33 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 6BAD62000C;
        Thu,  6 Oct 2022 07:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1665042451;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8pkyBJA5JrizUTo/1Xl3lpdJ31+1JnIMLqVBaslfhqo=;
        b=HYZWRevxTVkiCxrr0UvJAvwRggrGwNnww+vvqX869KtTR/n+Bq/pxHxIvJIj5MQX8JM7BY
        9tyIb4rSiSWvf6QD4sWWPrr89yuZ6EZ6AKJ30c0CXdXXQ7xMG4ydI2TqrUzN//iRQZne4F
        RXTBfQQNxlSNSBsYMFJkwgnpyZNVNI9Mrdenv/yt0jVBl+LgyQ/GfoPQIvbc2wWSsJKEUE
        EAQdUKqVbrDOSRr8nonU8+JUbYnn5l99hucj2vHsM79IJR8ina+mY0pbuG214bDH+bdamL
        VKER5djhHqEPIuB71ibbiKco9vJubonSBdGjFonA/BJx4mcAM0vLeV2pJmLf5Q==
Date:   Thu, 6 Oct 2022 09:47:29 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Subject: Re: [PATCH] mtd: rawnand: mpc5121: Replace NO_IRQ by 0
Message-ID: <20221006094729.61ff9b24@xps-13>
In-Reply-To: <4e3ca3e0077ea124ea210c312e6e620f0f9e8bca.1665034065.git.christophe.leroy@csgroup.eu>
References: <4e3ca3e0077ea124ea210c312e6e620f0f9e8bca.1665034065.git.christophe.leroy@csgroup.eu>
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

Hi Christophe,

christophe.leroy@csgroup.eu wrote on Thu,  6 Oct 2022 07:29:12 +0200:

> NO_IRQ is used to check the return of irq_of_parse_and_map().
>=20
> On some architecture NO_IRQ is 0, on other architectures it is -1.
>=20
> irq_of_parse_and_map() returns 0 on error, independent of NO_IRQ.
>=20
> So use 0 instead of using NO_IRQ.
>=20
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>

Deserves Fixes and Cc:stable tags, isn't it?

> ---
>  drivers/mtd/nand/raw/mpc5121_nfc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/mtd/nand/raw/mpc5121_nfc.c b/drivers/mtd/nand/raw/mp=
c5121_nfc.c
> index 800d774aed8e..f68349cb7824 100644
> --- a/drivers/mtd/nand/raw/mpc5121_nfc.c
> +++ b/drivers/mtd/nand/raw/mpc5121_nfc.c
> @@ -663,7 +663,7 @@ static int mpc5121_nfc_probe(struct platform_device *=
op)
>  	}
> =20
>  	prv->irq =3D irq_of_parse_and_map(dn, 0);
> -	if (prv->irq =3D=3D NO_IRQ) {
> +	if (!prv->irq) {
>  		dev_err(dev, "Error mapping IRQ!\n");
>  		return -EINVAL;
>  	}


Thanks,
Miqu=C3=A8l
