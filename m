Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEB9365B55C
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 17:54:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236535AbjABQyE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 11:54:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234033AbjABQx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 11:53:57 -0500
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [217.70.178.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53D81C16
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 08:53:56 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 80EF8240003;
        Mon,  2 Jan 2023 16:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1672678435;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l16kCBmaT+/ZiyhWXb1vgoNulB2WuFRSgnM49QIaZko=;
        b=bVuZLKex0L4H4p9/bMfQIwC8+jwMOvF5KOOqk7RNiVVHrCuWFqYevj9GYCCh0mBUyNNkE3
        cQsM0W533TGPROxUnQjlsm4U9vyGFi3AVwMAfJ3a/4TsGlhe2ji5m3Xq3n1KuSbvcDmhlL
        +j9oqyluN5dC7Dkr3g7ZAXUJoil+d9WqW5If7uoos7wuOX9354GyYw9oFnrwiEYYBS+cV7
        l0o3o9X2kaGF0hPjPL7kb4WVyQQoBhBYsyl8iN5jTHWlLq5fkP//yqkIIjkw3txystbLUg
        dsggDttEC5ykV5wlsrDkvAQBrVjvjvbGR1ye1rV1RDd5t2iary3gUcA7VcRT+Q==
Date:   Mon, 2 Jan 2023 17:53:51 +0100
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
Message-ID: <20230102175351.64690aaf@xps-13>
In-Reply-To: <e21aba9f-1afd-2615-fe00-3ee4176b9080@sholland.org>
References: <20221229181526.53766-1-samuel@sholland.org>
        <20221229181526.53766-7-samuel@sholland.org>
        <20230102102123.511d337d@xps-13>
        <e21aba9f-1afd-2615-fe00-3ee4176b9080@sholland.org>
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

samuel@sholland.org wrote on Mon, 2 Jan 2023 10:26:48 -0600:

> Hi Miqu=C3=A8l,
>=20
> On 1/2/23 03:21, Miquel Raynal wrote:
> > Hi Samuel,
> >=20
> > samuel@sholland.org wrote on Thu, 29 Dec 2022 12:15:25 -0600:
> >  =20
> >> When using the hardware ECC engine, the OOB data is made available in
> >> the NFC_REG_USER_DATA registers, one 32-bit word per ECC step. Any
> >> additional bytes are only accessible through raw reads and software
> >> descrambling. For efficiency, and to match the vendor driver, ignore
> >> these extra bytes.
> >>
> >> Signed-off-by: Samuel Holland <samuel@sholland.org>
> >> ---
> >>
> >>  drivers/mtd/nand/raw/sunxi_nand.c | 7 +++++++
> >>  1 file changed, 7 insertions(+)
> >>
> >> diff --git a/drivers/mtd/nand/raw/sunxi_nand.c b/drivers/mtd/nand/raw/=
sunxi_nand.c
> >> index 8e873f4fec9a..a3bc9f7f9e5a 100644
> >> --- a/drivers/mtd/nand/raw/sunxi_nand.c
> >> +++ b/drivers/mtd/nand/raw/sunxi_nand.c
> >> @@ -1604,6 +1604,13 @@ static int sunxi_nand_ooblayout_free(struct mtd=
_info *mtd, int section,
> >>  		return 0;
> >>  	}
> >> =20
> >> +	/*
> >> +	 * The controller does not provide access to OOB bytes
> >> +	 * past the end of the ECC data.
> >> +	 */
> >> +	if (section =3D=3D ecc->steps && ecc->engine_type =3D=3D NAND_ECC_EN=
GINE_TYPE_ON_HOST)
> >> +		return -ERANGE; =20
> >=20
> > Again, I am sorry but I cannot take this change, it would typically
> > break jffs2 users (if any?) :( =20
>=20
> Considering the bug I fixed in the previous patch, and the fact that
> mtd_ooblayout_free() zeroes out the structure before calling the .free
> callback, that region was being reported with a length of zero already.
> So I don't think anyone could have been using those bytes anyway.
>=20
> I am looking for a solution here because the ECC/scrambling engine
> really provides no way to access these bytes. Reading them requires
> turning off the ECC engine, performing another read command, and then
> descrambling in software. So we are sort of lying when we claim those
> bytes are available with hardware ECC enabled.
>=20
> If this change cannot be made as-is, is there any way the user could opt
> in to the new layout, to get the improved performance?

Actually that's true, you fixed the reporting of the free area which
was set to 0 until then, which means there cannot be any upstream user.
So knowing that, preventing the accesses to the end of the area seems
acceptable when using HW ECC. Please mention it in the commit log.

Thanks,
Miqu=C3=A8l
