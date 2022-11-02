Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDAE2616388
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 14:14:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231310AbiKBNOK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 09:14:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231295AbiKBNOH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 09:14:07 -0400
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 517ED2A42A
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 06:14:04 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 0C7ED60006;
        Wed,  2 Nov 2022 13:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1667394843;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SWrjuLHxDOvHyRY+U2MUirlxhgSugyGnR6jFnCK6J/g=;
        b=EfOmzAaN1DB3s2DQVMtv9NHt0sLwwUN6mz10ZWzs6Rb1vVz/2VRgUKHyR/pjktiK3nETXw
        hzbNkbqx1QWnYRsC48nk4Y7EEFnm9ZztrVgf1egOSibQEmf0t7OpqT+nhd3VuE5wz/FXFI
        UgV9/LFUsIqZ4Qbz9XHgWMa5xMSRb+SKUFboGubWGbmBpaqw/OWLL/HbtbNUqAbq13Rg+I
        8MjghpnA5Jhu2MXl8/bIO4HNALnS+GLw2/Ha4N1pqUEwPhqodwitU88mpNvaYLwlSZ72Kk
        7qk6yJfbX7lUpxwxQgghAO9A2PKb9IjzaaaHPwgNTLM7R2G1m4Oftny4+N8U2Q==
Date:   Wed, 2 Nov 2022 14:14:00 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Roger Quadros <rogerq@kernel.org>
Cc:     Colin Foster <colin.foster@in-advantage.com>,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        Pratyush Yadav <p.yadav@ti.com>,
        Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Richard Weinberger <richard@nod.at>
Subject: Re: Barebox / Kernel Omap ECC inconsistency?
Message-ID: <20221102141400.31125365@xps-13>
In-Reply-To: <ec160658-e251-bfdc-05ac-631bd4c716dc@kernel.org>
References: <Y2FvB5D0K4MBii8N@COLIN-DESKTOP1.localdomain>
        <ec160658-e251-bfdc-05ac-631bd4c716dc@kernel.org>
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

Hi Colin,

rogerq@kernel.org wrote on Wed, 2 Nov 2022 09:12:27 +0200:

> Hi Colin,
>=20
> On 01/11/2022 21:09, Colin Foster wrote:
> > Hello,
> >=20
> > I'm trying to revive a product that runs on a Phytec OMAP 4460 SOM. I
> > submitted a .dts RFC a month or so ago, and plan to perform the
> > suggestions and resubmit, but I'm up against one main hurdle that seems
> > to be related to flash OOB/ECC. (get_maintainers on
> > drivers/mtd/nand/raw/omap2.c is how I got this email list)
> >=20
> > Barebox has "native" support for the Phytec SOM:
> > https://git.pengutronix.de/cgit/barebox/tree/arch/arm/boards/phytec-phy=
core-omap4460
> >=20
> > It seems like Barebox is writing and expecting ECC bits to start at an
> > offset of 12 bytes, while the kernel (and Barebox comments suggest) the
> > ECC bytes should start at 2. I'm seeing this with
> > `nanddump -n -o -l 0x41000 -f mtdxnanddump /dev/mtdx`
> >=20
> > Barebox created partition with UBI (mtd3)
> > ...
> > 00000800  ff ff ff ff ff ff ff ff  ff ff ff ff 56 49 fd 17
> > 00000810  b2 25 60 1a 42 1d eb 56  5d ff ff ff ff ff ff ff
> > ...
> >=20
> > Kernel created partition with UBI (mtd4)
> > ...
> > 00000800  ff ff 07 73 04 ac 57 6b  9b 1f 92 49 ab e0 b9 ff
> > 00000810  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff
> > ...
> >=20
> >=20
> > My question:=20
> >=20
> > Am I right to assume this is an issue in Barebox? Perhaps this is just =
a =20
>=20
> I'm guessing so. Both u-boot and Linux for OMAP put the ECC bytes right
> after the Bad block marker which is 2 bytes.

Yep. I checked, this has been like that since at least 2014, I don't
think we changed the layout in U-Boot/Linux "recently"... (I haven't
checked earlier, by laziness).

> https://elixir.bootlin.com/linux/latest/source/drivers/mtd/nand/raw/omap2=
.c#L1729
> https://elixir.bootlin.com/linux/latest/source/drivers/mtd/nand/raw/omap2=
.c#L134
>=20
> > bug that has been fairly dormant for 15 years. If that is the case, I
> > assume there's probably no hope in getting this mainlined, and "native"
> > barebox support is just a ruse.
> >=20
> > If that isn't the case, is there a hidden "shift OOB by 10" config
> > option that I'm missing? Or am I interpreting this data incorrectly?
> >=20
> >=20
> > Any suggestions would be greatly appreciated. =20
>=20
> You should fix the OMAP NAND driver/config in Barebox to match that
> with Linux OMAP NAND driver if you want them to run on the same system.

Agreed.

Thanks,
Miqu=C3=A8l
