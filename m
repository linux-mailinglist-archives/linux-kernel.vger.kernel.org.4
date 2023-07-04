Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3835274735D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 15:55:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231428AbjGDNzP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 09:55:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231140AbjGDNzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 09:55:12 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED62CEE
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 06:55:10 -0700 (PDT)
X-GND-Sasl: miquel.raynal@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1688478909;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LiM73AlJxucWg3z48BYnYknSUwAWZ4Kmkn1Nr2ACD0A=;
        b=IHfecc42WPCyTP/PnqTrZOs7N03YcFRFZJKCEFYdXufKv2oorUwKVv90kcwwrSH8eupA5j
        J9IMYOK67moY3cu0UZZrC5WIA3eH+SzLYpTQoETAR2OKPiRGoXPiLF6OCzIDP+nhwl48GD
        hQyHE29Sl3SyJ1JOMBNlgbgLrlYKynPFO5kzIOZBgGUPsQI24b9wkAinVfsttf2dpAfGw1
        KkR9F+qzDqirxssUAs+KlAqhI1g1l0LM6leHN2Ht1mQ8xE8pUSIJeI2yIQuN70PFC+NHBk
        OwnBMPh3GtF2vDNmt2+3YiQIny5Q/PLpLl//HsVQiMIxRdvaDND2Wi+cfkmWOQ==
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 59B4040009;
        Tue,  4 Jul 2023 13:55:08 +0000 (UTC)
Date:   Tue, 4 Jul 2023 15:55:07 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Lothar =?UTF-8?B?V2HDn21hbm4=?= <LW@KARO-electronics.de>
Cc:     Felix Matouschek <felix@matouschek.org>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Bad ecc layout in drivers/mtd/nand/spi/xtx.c
Message-ID: <20230704155507.0643a856@xps-13>
In-Reply-To: <20230704123743.7f4c87af@ipc1.ka-ro>
References: <20230704123743.7f4c87af@ipc1.ka-ro>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lothar,

Thanks for the report.

LW@KARO-electronics.de wrote on Tue, 4 Jul 2023 12:37:43 +0200:

> Hi,
>=20
> while trying to add support for the 'XT26G01C' variant of the XTX
> SPI-nand chip I noticed a flaw in the ECC layout of the existing
> driver.
> According to the  XT26G01A datasheet the first eight bytes of the OOB
> area are not protected by ECC:
> Offset      ECC  Bytes  Area               Description
> 800H 807H    No      8  Spare 4, Group E   This Area is not covered by in=
ternal ECC,
>                                            800H is reserved for bad block=
 mark       =20
> 808H 82FH   Yes 40 Spare 5 , Group F       User Meta Data Area covered by=
 internal ECC.
> 830H 83FH    No 16 Spare 6 , Group G       ECC_EN=3D1: this area contains=
 Internal ECC Data, Read-Only,
>                                            Programming to this area will =
be ignored
>                                            ECC_EN=3D0: this area is writa=
ble for user
>=20
> But the driver defines bytes 1..47 as user OOB area:
> |static int xt26g0xa_ooblayout_free(struct mtd_info *mtd, int section,
> |				   struct mtd_oob_region *region)
> |{
> |	if (section)
> |		return -ERANGE;
> |
> |	region->offset =3D 1;
> |	region->length =3D 47;
> |
> |	return 0;
> |}
>=20
> IMO this should be:
> |	region->offset =3D 8;
> |	region->length =3D 40;
> to have the whole user oob area protected by ECC.
>=20
> Obviously this cannot simply be changed in the driver because it would
> break access to flash that was programmed with the current parameters.
> Since the data structures that provide the oob layout are completely
> static and cannot be modified at runtime (e.g. depending on some DTB
> property) the only way I see to provide a layout with ECC protection
> for the whole user metadata would be a Kconfig option to select one or
> the other layout at compile time.
>=20
> Any comments or better ideas?

These offsets do not reflect the protected area but the user area,
which can be used (at the users own risks). Somehow the only real user
is jffs2 upstream, and jffs2 was meant to be replaced a long time ago
by UBI which actually workaround-ed this limitation by not using the
OOB area at all. We do not have a real way to distinguish what is ECC
protected or not in the OOB area.

So unless you want to solve a real problem, I would advise to keep it
as it is.

Thanks,
Miqu=C3=A8l
