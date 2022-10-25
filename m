Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CE8160C5CD
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 09:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232048AbiJYHsC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 03:48:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231953AbiJYHr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 03:47:57 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21067161FCE
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 00:47:53 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 5EF0EC0008;
        Tue, 25 Oct 2022 07:47:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1666684072;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tzRPPOC0dgpsRT+KNgmTDR2mgXFxU07YYnSqsUCT1kg=;
        b=aOzwzcbMEIl5WPpnU47KzOVf51YQkKfHmSjYRCaFiuZKwrrD1ucjb8/Gn+8vp+ucmH5JeK
        5RNC3GVxEJLr0IiNtBvs7CaKEBQxZElV2FuUety3knYmSQfGFon9ve+3P1JuBCeTpmgKth
        S0uIHomTprmZUtQKtCyt6FM0Ctg9e6iNAtRpdQkP2xrWnhj02fLJqx6zMRPt1ASlTE9HNh
        kmNlgKIYhhd2RcJ/xJA93fKBFwqCrvrbd4Iu+hXopKGj8RuxC3pJ+utbWJF3A45Z9LuA5j
        yfcq7e1L19UBAIRpxWeqjaLBSjCMByzuWXcjo05LVdXpKH4qZmL0mdJ0A4lE6w==
Date:   Tue, 25 Oct 2022 09:47:48 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Vadym Kochan <vadym.kochan@plvision.eu>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Elad Nachman <enachman@marvell.com>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Aviram Dali <aviramd@marvell.com>
Subject: Re: [PATCH] mtd: rawnand: marvell: add missing layouts
Message-ID: <20221025094748.7dda3a57@xps-13>
In-Reply-To: <20221024215531.32033-1-vadym.kochan@plvision.eu>
References: <20221024215531.32033-1-vadym.kochan@plvision.eu>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vadym,

vadym.kochan@plvision.eu wrote on Tue, 25 Oct 2022 00:55:31 +0300:

> From: Aviram Dali <aviramd@marvell.com>
>=20
> A missing layouts were added to the driver to support NAND flashes
> with ECC layouts of 12 or 16 with page sized of 2048, 4096 or 8192.
>=20
> Usually theses are rare layouts, but in Marvell AC5 driver, the ECC
> level is set according to the spare area, so we may use these layouts
> more frequently.

Again, please do not carry cosmetic changes and real new additions in
the same patch.

>=20
> Signed-off-by: Aviram Dali <aviramd@marvell.com>
> Signed-off-by: Vadym Kochan <vadym.kochan@plvision.eu>
> ---
>  drivers/mtd/nand/raw/marvell_nand.c | 23 +++++++++++++++--------
>  1 file changed, 15 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/mtd/nand/raw/marvell_nand.c b/drivers/mtd/nand/raw/m=
arvell_nand.c
> index b9d1e96e3334..7944787f7b9f 100644
> --- a/drivers/mtd/nand/raw/marvell_nand.c
> +++ b/drivers/mtd/nand/raw/marvell_nand.c
> @@ -283,14 +283,21 @@ struct marvell_hw_ecc_layout {
> =20
>  /* Layouts explained in AN-379_Marvell_SoC_NFC_ECC */
>  static const struct marvell_hw_ecc_layout marvell_nfc_layouts[] =3D {
> -	MARVELL_LAYOUT(  512,   512,  1,  1,  1,  512,  8,  8,  0,  0,  0),
> -	MARVELL_LAYOUT( 2048,   512,  1,  1,  1, 2048, 40, 24,  0,  0,  0),
> -	MARVELL_LAYOUT( 2048,   512,  4,  1,  1, 2048, 32, 30,  0,  0,  0),
> -	MARVELL_LAYOUT( 2048,   512,  8,  2,  1, 1024,  0, 30,1024,32, 30),
> -	MARVELL_LAYOUT( 4096,   512,  4,  2,  2, 2048, 32, 30,  0,  0,  0),
> -	MARVELL_LAYOUT( 4096,   512,  8,  5,  4, 1024,  0, 30,  0, 64, 30),
> -	MARVELL_LAYOUT( 8192,   512,  4,  4,  4, 2048,  0, 30,  0,  0,  0),
> -	MARVELL_LAYOUT( 8192,   512,  8,  9,  8, 1024,  0, 30,  0, 160, 30),
> +	MARVELL_LAYOUT(512,   512,  1,  1,  1,  512,  8,  8,  0,   0,  0),
> +	MARVELL_LAYOUT(2048,   512,  1,  1,  1, 2048, 40, 24,  0,   0,  0),
> +	MARVELL_LAYOUT(2048,   512,  4,  1,  1, 2048, 32, 30,  0,   0,  0),
> +	MARVELL_LAYOUT(2048,   512,  8,  2,  1, 1024,  0, 30,  1024, 32, 30),
> +	MARVELL_LAYOUT(2048,   512,  8,  2,  1, 1024,  0, 30,  1024, 64, 30),
> +	MARVELL_LAYOUT(2048,   512,  12, 3,  2, 704,   0, 30,  640, 0,  30),
> +	MARVELL_LAYOUT(2048,   512,  16, 5,  4, 512,   0, 30,  0,   32, 30),
> +	MARVELL_LAYOUT(4096,   512,  4,  2,  2, 2048, 32, 30,  0,   0,  0),
> +	MARVELL_LAYOUT(4096,   512,  8,  5,  4, 1024,  0, 30,  0,   64, 30),
> +	MARVELL_LAYOUT(4096,   512,  12, 6,  5, 704,   0, 30,  576, 32, 30),
> +	MARVELL_LAYOUT(4096,   512,  16, 9,  8, 512,   0, 30,  0,   32, 30),
> +	MARVELL_LAYOUT(8192,   512,  4,  4,  4, 2048,  0, 30,  0,   0,  0),
> +	MARVELL_LAYOUT(8192,   512,  8,  9,  8, 1024,  0, 30,  0,  160, 30),
> +	MARVELL_LAYOUT(8192,   512,  12, 12, 11, 704,  0, 30,  448, 64, 30),
> +	MARVELL_LAYOUT(8192,   512,  16, 17, 16, 512,  0, 30,  0,   32, 30),
>  };
> =20
>  /**


Thanks,
Miqu=C3=A8l
