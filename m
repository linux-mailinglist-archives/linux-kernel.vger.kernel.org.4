Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74869721EF9
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 09:09:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbjFEHJA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 03:09:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230221AbjFEHIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 03:08:48 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95797E51
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 00:08:22 -0700 (PDT)
X-GND-Sasl: miquel.raynal@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1685948897;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LxKZJB11fucc8eEXUnpEucsBbBt1WAs5b1tL7WQ4njU=;
        b=bZJIQ6GqDyE+/lFoGLwhdH4n0Xj5mzbU9R3SnXiISv/R9oaQnBC0b+0I+TdKMaRpe/TjwO
        3bAUBUS6mZWhejmBm+aOUJv6FUCB4M9tUNB1RgkxPcktaLdth0Euf9YcJ7HAiQ7QDmFWzD
        GCyNr+HegKX0U6aGKo8rkJS5L47phwGgOLsNkUh8PvE4xnQEyt54p1Rxyo/EJrxVE37d6r
        UYzoh0jRmMMzcHeQRH9JyLbrjedeCGiYC22fAhdbhtvdiqaJgxNth/8Q23SB04RX6seEWc
        fMBvxF7eSJHrYR4P9lUicc1VDzXUXU3ua8+TTfG3racxHrq31Zkdc1qhqaS4zQ==
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5621A1BF203;
        Mon,  5 Jun 2023 07:08:16 +0000 (UTC)
Date:   Mon, 5 Jun 2023 09:08:15 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Arseniy Krasnov <avkrasnov@sberdevices.ru>
Cc:     Liang Yang <liang.yang@amlogic.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        <oxffffaa@gmail.com>, <kernel@sberdevices.ru>,
        <linux-mtd@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v5 1/6] mtd: rawnand: meson: fix ready/busy command
Message-ID: <20230605090815.48bc2074@xps-13>
In-Reply-To: <1ede0f53-8513-e346-b5a8-fc8a804cfa8d@sberdevices.ru>
References: <20230601061850.3907800-1-AVKrasnov@sberdevices.ru>
        <20230601061850.3907800-2-AVKrasnov@sberdevices.ru>
        <20230601095142.3a611b5a@xps-13>
        <1ede0f53-8513-e346-b5a8-fc8a804cfa8d@sberdevices.ru>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arseniy,

avkrasnov@sberdevices.ru wrote on Fri, 2 Jun 2023 01:44:01 +0300:

> Hello Miquel!
>=20
> May be I can exclude this patch from this patchset and send it as a singl=
e patch
> as it is fix and not related with other patches?

Yes absolutely.

>=20
> Thanks, Arseniy
>=20
> On 01.06.2023 10:51, Miquel Raynal wrote:
> > Hi Arseniy,
> >=20
> > AVKrasnov@sberdevices.ru wrote on Thu, 1 Jun 2023 09:18:44 +0300:
> >  =20
> >> This fixes ready/busy command value. =20
> >=20
> > nit: "Fix the ready/busy command value." =20
> >>
> >> Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
> >> ---
> >>  drivers/mtd/nand/raw/meson_nand.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/mtd/nand/raw/meson_nand.c b/drivers/mtd/nand/raw/=
meson_nand.c
> >> index 074e14225c06..9dd4a676497b 100644
> >> --- a/drivers/mtd/nand/raw/meson_nand.c
> >> +++ b/drivers/mtd/nand/raw/meson_nand.c
> >> @@ -37,7 +37,7 @@
> >>  #define NFC_CMD_SCRAMBLER_ENABLE	BIT(19)
> >>  #define NFC_CMD_SCRAMBLER_DISABLE	0
> >>  #define NFC_CMD_SHORTMODE_DISABLE	0
> >> -#define NFC_CMD_RB_INT		BIT(14)
> >> +#define NFC_CMD_RB_INT		((0xb << 10) | BIT(18) | BIT(16))
> >> =20
> >>  #define NFC_CMD_GET_SIZE(x)	(((x) >> 22) & GENMASK(4, 0))
> >>   =20
> >=20
> >=20
> > Thanks,
> > Miqu=C3=A8l =20


Thanks,
Miqu=C3=A8l
