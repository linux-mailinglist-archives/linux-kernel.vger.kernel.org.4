Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FD3465C226
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 15:43:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237989AbjACOmM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 09:42:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237944AbjACOmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 09:42:05 -0500
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [217.70.178.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61F88EE29
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 06:42:03 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id E824924000D;
        Tue,  3 Jan 2023 14:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1672756921;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rTMO3TySG46QgZw+qOV1x67KwVNxb2EvI1mr7+JDBlY=;
        b=baEdm2IA5eAa4DvzbMbllbXt8eMiBNwUoF0l5/gM7tLt9Ot8Ap7FMA5x30dtyecLguiDWC
        +mfcg3zF3zln8j648DeTEEjCqgOBA73cd9PkGMe84kQQB2ARMKb/aNWvC53Drltu8V2EXo
        ZRwqCeGg47jMempFyYrDgL1kATygNal+T7387r9/UXb+To6i8aLGo1v6ZlK9F9Rlr8NnRp
        k5T4B9o0cSxFL2P9hP86M6PWtHifg9VO0fVrRGsEDketJgYWTlRnst7p5+ODfCorAag7q9
        h1mgsd54VW2USPLbBFa9R8YsrVBNwK21fcKwgviV8IQ6woar9EHL6x17Cz5P5Q==
Date:   Tue, 3 Jan 2023 15:41:54 +0100
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
Subject: Re: [PATCH 4/7] mtd: rawnand: sunxi: Fix ECC strength maximization
Message-ID: <20230103154155.7064e59e@xps-13>
In-Reply-To: <6940e60e-834d-9cc6-c3b8-657b100ea5db@sholland.org>
References: <20221229181526.53766-1-samuel@sholland.org>
        <20221229181526.53766-5-samuel@sholland.org>
        <20230102101132.66aa1a1d@xps-13>
        <4207d4eb-31d5-31c0-1a7f-67ec00b63f58@sholland.org>
        <20230102174517.1ccb3654@xps-13>
        <6940e60e-834d-9cc6-c3b8-657b100ea5db@sholland.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Samuel,

samuel@sholland.org wrote on Mon, 2 Jan 2023 11:06:20 -0600:

> Hi Miqu=C3=A8l,
>=20
> On 1/2/23 10:45, Miquel Raynal wrote:
> >>>> This is already accounted for in the subtraction for OOB, since the =
BBM
> >>>> overlaps the first OOB dword. With this change, the driver picks the
> >>>> same ECC strength as the vendor driver.
> >>>>
> >>>> Fixes: 4796d8655915 ("mtd: nand: sunxi: Support ECC maximization")
> >>>> Signed-off-by: Samuel Holland <samuel@sholland.org>
> >>>> ---
> >>>>
> >>>>  drivers/mtd/nand/raw/sunxi_nand.c | 3 +--
> >>>>  1 file changed, 1 insertion(+), 2 deletions(-)
> >>>>
> >>>> diff --git a/drivers/mtd/nand/raw/sunxi_nand.c b/drivers/mtd/nand/ra=
w/sunxi_nand.c
> >>>> index 1bddeb1be66f..1ecf2cee343b 100644
> >>>> --- a/drivers/mtd/nand/raw/sunxi_nand.c
> >>>> +++ b/drivers/mtd/nand/raw/sunxi_nand.c
> >>>> @@ -1643,8 +1643,7 @@ static int sunxi_nand_hw_ecc_ctrl_init(struct =
nand_chip *nand,
> >>>>  		ecc->size =3D 1024;
> >>>>  		nsectors =3D mtd->writesize / ecc->size;
> >>>> =20
> >>>> -		/* Reserve 2 bytes for the BBM */
> >>>> -		bytes =3D (mtd->oobsize - 2) / nsectors;
> >>>> +		bytes =3D mtd->oobsize / nsectors;   =20
> >>>
> >>> I'm sorry but I don't think we can make this work. This change would
> >>> break all existing users...   =20
> >>
> >> OK, it is not too much of an issue because I can manually specify the
> >> ECC parameters in the devicetree. Do you think it makes sense to fix
> >> this when adding new hardware variants/compatible strings? =20
> >=20
> > Actually, looking at the code again, I don't get how the above diff
> > could be valid. The "maximize strength" logic (in which this diff is)
> > looks for the biggest region to store ECC bytes. These bytes cannot
> > be stored on the BBM, which "mtd->oobsize - 2" tries to avoid, so we
> > cannot get rid of this. =20
>=20
> Right, we cannot overlap the BBM, but the BBM is accounted for in the
> line below:
>=20
>   /* 4 non-ECC bytes are added before each ECC bytes section */
>   bytes -=3D 4;
>=20
> Normally those 4 bytes are all free OOB, but for the first ECC step,
> those are split into 2 free bytes and 2 BBM bytes:
>=20
>   /*
>    * The first 2 bytes are used for BB markers, hence we
>    * only have 2 bytes available in the first user data
>    * section.
>    */
>   if (!section && ecc->engine_type =3D=3D NAND_ECC_ENGINE_TYPE_ON_HOST) {
>           oobregion->offset =3D 2;
>           oobregion->length =3D 2;
>=20
>           return 0;
>   }
>=20
> So if we subtract 4 bytes for the each free OOB area, including the
> first one, and also subtract 2 bytes for the BBM, we are double-counting
> the BBM. I should have made my commit message clearer. But I am going to
> drop this patch anyway.

Ah, yes, you are absolutely right, then.

Thanks,
Miqu=C3=A8l
