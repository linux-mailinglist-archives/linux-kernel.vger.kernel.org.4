Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD8355BD1B9
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 18:02:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbiISQCg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 12:02:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbiISQCP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 12:02:15 -0400
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [IPv6:2001:4b98:dc4:8::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E7903AE52
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 09:00:29 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id EB70A24000E;
        Mon, 19 Sep 2022 16:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1663603227;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4w2H0/aVozaHmubnqFnPjiPTuYGSRzmbJ5Wwl6IDQwM=;
        b=Lcv42Ss9HGpIaCPVGZlsqSX3b4RETBixGo4uKB9QrhoufMMLiAxBu08X17z+G4slmrlwN9
        Z6WowHP6ZO5LMXhxmBydcyUHnj54Jq2E3Mj4uVzL1yZstEYPbO4zJNE5J4XnvQ0h7POLr8
        oSAVOOn21UXyjWZKkBGyiyp3sXrL7L8tfC7N5kWrIg/0GuF+sF8/rL/SPppLiv8tquBLre
        c5kwjH+1qwDO5GwgW93QEETcLp6ugYlLjWklnhej2XFyve0vxTaS2mL0BsR7l+LoEuJzLp
        76RsJ5bA3HANiTyTGPiCUSrFbvWdg3bkXLJdQgX7i4ZgC5a+FUR6nlXpiNXjqw==
Date:   Mon, 19 Sep 2022 18:00:22 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Jack Wang <jinpu.wang@ionos.com>
Cc:     linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Christophe Kerello <christophe.kerello@foss.st.com>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mtd: rawnand: stm32_fmc2: Fix dma_map_sg error
 check
Message-ID: <20220919180022.2c80e2b7@xps-13>
In-Reply-To: <20220825075338.35338-2-jinpu.wang@ionos.com>
References: <20220825075338.35338-1-jinpu.wang@ionos.com>
        <20220825075338.35338-2-jinpu.wang@ionos.com>
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

Hi Jack,

jinpu.wang@ionos.com wrote on Thu, 25 Aug 2022 09:53:37 +0200:

> dma_map_sg return 0 on error, in case of error return -EIO.
>=20
> Cc: Miquel Raynal <miquel.raynal@bootlin.com>
> Cc: Richard Weinberger <richard@nod.at>
> Cc: Vignesh Raghavendra <vigneshr@ti.com>
> Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
> Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>
> Cc: Philipp Zabel <p.zabel@pengutronix.de>
> Cc: Christophe Kerello <christophe.kerello@foss.st.com>
> Cc: Cai Huoqing <cai.huoqing@linux.dev>
> Cc: linux-mtd@lists.infradead.org
> Cc: linux-stm32@st-md-mailman.stormreply.com
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Fixes: 2cd457f328c1 ("mtd: rawnand: stm32_fmc2: add STM32 FMC2 NAND flash=
 controller driver")
> Signed-off-by: Jack Wang <jinpu.wang@ionos.com>

I'll apply this series so I need to re-add Christophe's tag sent on the
patch alone (which is identical as far as I see):

Reviewed-by: Christophe Kerello <christophe.kerello@foss.st.com>

> ---
>  drivers/mtd/nand/raw/stm32_fmc2_nand.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/mtd/nand/raw/stm32_fmc2_nand.c b/drivers/mtd/nand/ra=
w/stm32_fmc2_nand.c
> index 87c1c7dd97eb..a0c825af19fa 100644
> --- a/drivers/mtd/nand/raw/stm32_fmc2_nand.c
> +++ b/drivers/mtd/nand/raw/stm32_fmc2_nand.c
> @@ -862,8 +862,8 @@ static int stm32_fmc2_nfc_xfer(struct nand_chip *chip=
, const u8 *buf,
> =20
>  	ret =3D dma_map_sg(nfc->dev, nfc->dma_data_sg.sgl,
>  			 eccsteps, dma_data_dir);
> -	if (ret < 0)
> -		return ret;
> +	if (!ret)
> +		return -EIO;
> =20
>  	desc_data =3D dmaengine_prep_slave_sg(dma_ch, nfc->dma_data_sg.sgl,
>  					    eccsteps, dma_transfer_dir,
> @@ -893,8 +893,10 @@ static int stm32_fmc2_nfc_xfer(struct nand_chip *chi=
p, const u8 *buf,
> =20
>  		ret =3D dma_map_sg(nfc->dev, nfc->dma_ecc_sg.sgl,
>  				 eccsteps, dma_data_dir);
> -		if (ret < 0)
> +		if (!ret) {
> +			ret =3D -EIO;
>  			goto err_unmap_data;
> +		}
> =20
>  		desc_ecc =3D dmaengine_prep_slave_sg(nfc->dma_ecc_ch,
>  						   nfc->dma_ecc_sg.sgl,


Thanks,
Miqu=C3=A8l
