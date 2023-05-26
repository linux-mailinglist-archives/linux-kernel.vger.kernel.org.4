Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07DB9712BAE
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 19:22:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236969AbjEZRWO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 13:22:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbjEZRWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 13:22:11 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A18BF7
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 10:22:10 -0700 (PDT)
X-GND-Sasl: miquel.raynal@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1685121728;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=efZQFkhGxaWLVGqIF4cJhlsyJFIZEiGG0itIcLrxbrs=;
        b=PJzMm7FXKrNPBHGJnVX++8nGvS8t+2WQfb77helAAMq2fmDv9SdfYwz7+zT+D/WGsY9G5q
        TspfzH0SJEnPDHP8fkuyDVJnI7oG1jODJC64APzh9cJmSXGHyZ1Io8YI6732cmDqrHBaS2
        pEL6W3jO07t789mvl1WYdpjQb6t10HMEM5eYn6+RyzPspJO0BNR1RzUBCv3txSd0aluBq0
        1JEZMuK9nBSOYsRZhDWILpLMHRlfE4yxc1Fpbwtl9zF3E00Yb+CWVZHKMyGVfa+n/7Arhx
        eknMcg1P2OjyBazGT18mJ5qDosUEQi5dtinazPMXMNrVhRu6Qfv+YvXJ7wAeqQ==
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
Received: by mail.gandi.net (Postfix) with ESMTPSA id C167AC0003;
        Fri, 26 May 2023 17:22:06 +0000 (UTC)
Date:   Fri, 26 May 2023 19:22:05 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Arseniy Krasnov <avkrasnov@sberdevices.ru>
Cc:     Liang Yang <liang.yang@amlogic.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Yixun Lan <yixun.lan@amlogic.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>, <oxffffaa@gmail.com>,
        <kernel@sberdevices.ru>, <linux-mtd@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 1/5] mtd: rawnand: meson: fix command sequence for
 read/write
Message-ID: <20230526192205.4a69ca79@xps-13>
In-Reply-To: <abeadc03-a69c-be1c-3c6a-6ce492a5e4f6@sberdevices.ru>
References: <20230515094440.3552094-1-AVKrasnov@sberdevices.ru>
        <20230515094440.3552094-2-AVKrasnov@sberdevices.ru>
        <20230522170526.6486755a@xps-13>
        <9013b0e2-c923-43f8-0bd6-979bf0c23ebc@sberdevices.ru>
        <abeadc03-a69c-be1c-3c6a-6ce492a5e4f6@sberdevices.ru>
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

avkrasnov@sberdevices.ru wrote on Wed, 24 May 2023 12:05:47 +0300:

> On 23.05.2023 12:12, Arseniy Krasnov wrote:
> > Hello Miquel, Liang
> >=20
> > On 22.05.2023 18:05, Miquel Raynal wrote: =20
> >> Hi Arseniy,
> >>
> >> AVKrasnov@sberdevices.ru wrote on Mon, 15 May 2023 12:44:35 +0300:
> >> =20
> >>> This fixes read/write functionality by:
> >>> 1) Changing NFC_CMD_RB_INT bit value. =20
> >>
> >> I guess this is a separate fix
> >> =20
> >=20
> > Ok, I'll move it to separate patch
> >  =20
> >>> 2) Adding extra NAND_CMD_STATUS command on each r/w request. =20
> >>
> >> Is this really needed? Looks like you're delaying the next op only. Is
> >> using a delay enough? If yes, then it's probably the wrong approach. =
=20
>=20
> Hi Miquel, small update, I found some details from @Liang's message in v1=
 talks from the last month:
>=20
> *
> After sending NAND_CMD_READ0, address, NAND_CMD_READSTART and read status=
(NAND_CMD_STATUS =3D 0x70) commands, it should send
> NAND_CMD_READ0 command for exiting the read status mode from the datashee=
t from NAND device.

That is true.

> but previous meson_nfc_queue_rb()
> only checks the Ready/Busy pin and it doesn't send read status(NAND_CMD_S=
TATUS =3D 0x70) command.
> i think there is something wrong with the Ready/Busy pin(please check the=
 hardware whether this
> Ready/Busy pin is connected with SOC) or the source code. i have the boar=
d without Ready/Busy pin and prefer to use the
> nfc command called RB_IO6. it sends NAND_CMD_STATUS command and checks bi=
t6 of the status register of NAND device from the
> data bus and generate IRQ if ready.
> *
>=20
> I guess, that sequence of commands from this patch is described in datash=
eet (unfortunately I don't have it and relied on the old driver).
> Yesterday I tried to remove sending of NAND_CMD_STATUS from this patch, b=
ut it broke current driver - i had ECC errors, so it looks like
> "shot in the dark" situation, to understand this logic.

When an operation on the NAND array happens (eg. read, prog, erase),
you need to wait "some time" before accessing the internal sram or even
the chip which is "busy" until it gets "ready" again. You can probe the
ready/busy pin (that's the hardware way, fast and reliable) or you can
poll a status with NAND_CMD_STATUS. The chips are designed so they can
actually process that command while they are doing time consuming tasks
to update the host. But IIRC every byte read will return the status
until you send READ0 again, which means "I'm done with the status
read" somehow.

Please see nand_soft_waitrdy() in order to understand how this is
supposed to work. You can even use that helper (which is exported)
instead of open-coding it in your driver. See atmel or sunxi
implementations for instance.

As using the native RB pin is better, you would need to identify
whether you have one or not at probe time and then either poll the
relevant bit of your controller if there is one, or fallback to the
soft read (which should fallback on exec_op in the end).

Thanks,
Miqu=C3=A8l
