Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADCD965AE80
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 09:59:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232064AbjABI70 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 03:59:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231771AbjABI7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 03:59:20 -0500
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28DA9EA4
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 00:59:18 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id BD1BA1BF204;
        Mon,  2 Jan 2023 08:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1672649957;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=onwm0vxTtpJ/7A/xd568TVQxILdHEoQevXcykzJqiG8=;
        b=Z//qXKKap68bm1zIwDki2VQy7UojW4glXIhi22NRwxF2GBP2wWOlV2q79Ns6y/YOPHaMMZ
        uEBpt/PV660NvzmLSutFmJpAvdsKvpDcn2Ns2QcdO3p+pPfkIx2s1SCngH2rQ41sa8m4ym
        w4uJmhemLJE8gJd3zH2Y+v1CHWCg1yNy3bSpqq0o42xcp4a243K7a+oW0F9vFx2ONK2muO
        CP2fsj+YnJZjXmDPTiQx9vgMUosfZ4B0TGmt8nuJf3t9iOdQv1lX+92zV4T0fSoRToNWks
        Dv9pJK4ngsM78ToMT+X1fcTPSFD85WV2qTkI8amBQ7SMVm9MacwpWUg5j7pmrA==
Date:   Mon, 2 Jan 2023 09:59:11 +0100
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
Subject: Re: [PATCH 2/7] mtd: rawnand: sunxi: Remove an unnecessary check
Message-ID: <20230102095911.0243d5b8@xps-13>
In-Reply-To: <20221229181526.53766-3-samuel@sholland.org>
References: <20221229181526.53766-1-samuel@sholland.org>
        <20221229181526.53766-3-samuel@sholland.org>
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

Hi Samuel,

samuel@sholland.org wrote on Thu, 29 Dec 2022 12:15:21 -0600:

> sunxi_nand->nsels cannot be zero, so the second check implies the first.

Actually this check comes from a time where we did check against -1 :)
But, yeah, now it's a duplicate.

> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
>=20
>  drivers/mtd/nand/raw/sunxi_nand.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/mtd/nand/raw/sunxi_nand.c b/drivers/mtd/nand/raw/sun=
xi_nand.c
> index 2ee86f7b0905..8b221f9f10a7 100644
> --- a/drivers/mtd/nand/raw/sunxi_nand.c
> +++ b/drivers/mtd/nand/raw/sunxi_nand.c
> @@ -421,7 +421,7 @@ static void sunxi_nfc_select_chip(struct nand_chip *n=
and, unsigned int cs)
>  	struct sunxi_nand_chip_sel *sel;
>  	u32 ctl;
> =20
> -	if (cs > 0 && cs >=3D sunxi_nand->nsels)
> +	if (cs >=3D sunxi_nand->nsels)
>  		return;
> =20
>  	ctl =3D readl(nfc->regs + NFC_REG_CTL) &


Thanks,
Miqu=C3=A8l
