Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E4887162D7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 15:59:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232753AbjE3N7S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 09:59:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232747AbjE3N7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 09:59:11 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1A9A12B
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 06:59:02 -0700 (PDT)
X-GND-Sasl: miquel.raynal@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1685455140;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iPKl0w/v3sbTqMK8trZ1QoQzZIkuiRuU+iuDTR4PM7w=;
        b=i+lgq76jw4UBnAvmGTjz1XNJYzfeipH8VUCxaBpcXsPCRpL+2ebVNd7FAOQgDXWKlPn+zh
        DLNnHiORlxkXCoaxSPHDHOnTnEVsyAGF3JETcU3Mf2K/sH8nDlO+EeEPG9W0Sl8IWCL6ac
        +UWW0Qb2XVl0U+Zjq8P8r4Iv0Q4lMOfaOCrJxT9DztW3/dklpIXTVq0IM2XXQsQ3cDJenF
        MTeyYBAEx/EifOTodiKZGxTrxlLCVzPFkZOBR/2BMsLA/YgwMleYKu0uK/TU/mtI7MTgYW
        vw/geCnyfMwFBQDKbi0sG4mPLa0Ryk1kyntZqCY7nN8mD0Dvkj9oQvhYVwRDng==
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
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 509141C0005;
        Tue, 30 May 2023 13:58:59 +0000 (UTC)
Date:   Tue, 30 May 2023 15:58:58 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Arseniy Krasnov <avkrasnov@sberdevices.ru>
Cc:     Liang Yang <liang.yang@amlogic.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        JeromeBrunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Yixun Lan <yixun.lan@amlogic.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>, <oxffffaa@gmail.com>,
        <kernel@sberdevices.ru>, <linux-mtd@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 1/5] mtd: rawnand: meson: fix command sequence for
 read/write
Message-ID: <20230530155858.6bfbed89@xps-13>
In-Reply-To: <9d3ada22-0176-2113-bff2-27f8a4ad5c23@sberdevices.ru>
References: <20230515094440.3552094-1-AVKrasnov@sberdevices.ru>
        <20230515094440.3552094-2-AVKrasnov@sberdevices.ru>
        <20230522170526.6486755a@xps-13>
        <9013b0e2-c923-43f8-0bd6-979bf0c23ebc@sberdevices.ru>
        <abeadc03-a69c-be1c-3c6a-6ce492a5e4f6@sberdevices.ru>
        <20230526192205.4a69ca79@xps-13>
        <6077c959-f566-d399-d2be-8460eb063415@sberdevices.ru>
        <20230530150556.498c1fae@xps-13>
        <9d3ada22-0176-2113-bff2-27f8a4ad5c23@sberdevices.ru>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arseniy,

avkrasnov@sberdevices.ru wrote on Tue, 30 May 2023 16:35:59 +0300:

> On 30.05.2023 16:05, Miquel Raynal wrote:
> > Hi Arseniy,
> >=20
> > avkrasnov@sberdevices.ru wrote on Tue, 30 May 2023 14:19:08 +0300:
> >  =20
> >> On 26.05.2023 20:22, Miquel Raynal wrote: =20
> >>> Hi Arseniy,
> >>>
> >>> avkrasnov@sberdevices.ru wrote on Wed, 24 May 2023 12:05:47 +0300:
> >>>    =20
> >>>> On 23.05.2023 12:12, Arseniy Krasnov wrote:   =20
> >>>>> Hello Miquel, Liang
> >>>>>
> >>>>> On 22.05.2023 18:05, Miquel Raynal wrote:     =20
> >>>>>> Hi Arseniy,
> >>>>>>
> >>>>>> AVKrasnov@sberdevices.ru wrote on Mon, 15 May 2023 12:44:35 +0300:
> >>>>>>     =20
> >>>>>>> This fixes read/write functionality by:
> >>>>>>> 1) Changing NFC_CMD_RB_INT bit value.     =20
> >>>>>>
> >>>>>> I guess this is a separate fix
> >>>>>>     =20
> >>>>>
> >>>>> Ok, I'll move it to separate patch
> >>>>>      =20
> >>>>>>> 2) Adding extra NAND_CMD_STATUS command on each r/w request.     =
=20
> >>>>>>
> >>>>>> Is this really needed? Looks like you're delaying the next op only=
. Is
> >>>>>> using a delay enough? If yes, then it's probably the wrong approac=
h.     =20
> >>>>
> >>>> Hi Miquel, small update, I found some details from @Liang's message =
in v1 talks from the last month:
> >>>>
> >>>> *
> >>>> After sending NAND_CMD_READ0, address, NAND_CMD_READSTART and read s=
tatus(NAND_CMD_STATUS =3D 0x70) commands, it should send
> >>>> NAND_CMD_READ0 command for exiting the read status mode from the dat=
asheet from NAND device.   =20
> >>>
> >>> That is true.
> >>>    =20
> >>>> but previous meson_nfc_queue_rb()
> >>>> only checks the Ready/Busy pin and it doesn't send read status(NAND_=
CMD_STATUS =3D 0x70) command.
> >>>> i think there is something wrong with the Ready/Busy pin(please chec=
k the hardware whether this
> >>>> Ready/Busy pin is connected with SOC) or the source code. i have the=
 board without Ready/Busy pin and prefer to use the
> >>>> nfc command called RB_IO6. it sends NAND_CMD_STATUS command and chec=
ks bit6 of the status register of NAND device from the
> >>>> data bus and generate IRQ if ready.
> >>>> *
> >>>>
> >>>> I guess, that sequence of commands from this patch is described in d=
atasheet (unfortunately I don't have it and relied on the old driver).
> >>>> Yesterday I tried to remove sending of NAND_CMD_STATUS from this pat=
ch, but it broke current driver - i had ECC errors, so it looks like
> >>>> "shot in the dark" situation, to understand this logic.   =20
> >>>
> >>> When an operation on the NAND array happens (eg. read, prog, erase),
> >>> you need to wait "some time" before accessing the internal sram or ev=
en
> >>> the chip which is "busy" until it gets "ready" again. You can probe t=
he
> >>> ready/busy pin (that's the hardware way, fast and reliable) or you can
> >>> poll a status with NAND_CMD_STATUS. The chips are designed so they can
> >>> actually process that command while they are doing time consuming tas=
ks
> >>> to update the host. But IIRC every byte read will return the status
> >>> until you send READ0 again, which means "I'm done with the status
> >>> read" somehow.
> >>>
> >>> Please see nand_soft_waitrdy() in order to understand how this is
> >>> supposed to work. You can even use that helper (which is exported)
> >>> instead of open-coding it in your driver. See atmel or sunxi
> >>> implementations for instance.
> >>>
> >>> As using the native RB pin is better, you would need to identify
> >>> whether you have one or not at probe time and then either poll the
> >>> relevant bit of your controller if there is one, or fallback to the
> >>> soft read (which should fallback on exec_op in the end).   =20
> >>
> >> Thanks for this information! I'll use 'nand_soft_waitrdy()' at least, =
because i guess that
> >> there is no RB pin on my device. =20
> >=20
> > Currently there is only support for the physical pin IIRC. This means
> > you cannot just drop it. You need to support both. =20
>=20
> Yes, i'm not going to drop RB pin support, but as I don't have device to =
test it(i guess), i'll add
> 'nand_sort_waitrdy()' anyway.

Clear. Then go for it :)

Thanks,
Miqu=C3=A8l
