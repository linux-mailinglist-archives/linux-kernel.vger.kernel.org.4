Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37EBC722297
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 11:50:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230367AbjFEJur (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 05:50:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjFEJuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 05:50:44 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 825EEBD;
        Mon,  5 Jun 2023 02:50:37 -0700 (PDT)
X-GND-Sasl: miquel.raynal@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1685958636;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vR4k2T1RzS/nAoJgjwjD+YGHoaPZBMd9FOOYoMhuzgk=;
        b=HN9OIdfqr8HPnDe8MEurDz64tduduKukc4BoRSI0NlG2bRxrZ7PuUjNAVF1ucfijb3nsx4
        wphBhTKj9bxZWO8vh5sY997759gXymrYvo7HqNXNWidY/lR7hYQ26s59/rwmzfJz+CgW6H
        ATVXgx62U9ZmsRuBbSaQQfPMhMYmaDgSOi2g8OIxPy5bTJ5T+2EJ4Zut7hX/ZQ2kB4k6t9
        UHyQ76RWWQ2TyB1uGh3bU0KYMLv+CBIjRC4wqZB3Qt73B8dbwRTba84YA/VE18qk0+2jsN
        tuEyx+xcyrkPmLTX1GgBLTcS1AU52YJevyNztq4TE0i5k78hvUaDx7m/ulei8A==
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
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8B6B91C000E;
        Mon,  5 Jun 2023 09:50:34 +0000 (UTC)
Date:   Mon, 5 Jun 2023 11:50:33 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Arseniy Krasnov <avkrasnov@sberdevices.ru>
Cc:     <oxffffaa@gmail.com>, <kernel@sberdevices.ru>,
        <stable@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Liang Yang <liang.yang@amlogic.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>
Subject: Re: [PATCH v1] mtd: rawnand: meson: fix ready/busy command
Message-ID: <20230605115033.7a9eb4c9@xps-13>
In-Reply-To: <9bea333a-e5fc-af89-29a0-fa01236488a3@sberdevices.ru>
References: <20230605061048.485622-1-AVKrasnov@sberdevices.ru>
        <19f809ab-218e-8da5-6d5e-ac47902fa706@sberdevices.ru>
        <20230605101739.069b98af@xps-13>
        <9bea333a-e5fc-af89-29a0-fa01236488a3@sberdevices.ru>
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

avkrasnov@sberdevices.ru wrote on Mon, 5 Jun 2023 11:27:34 +0300:

> On 05.06.2023 11:17, Miquel Raynal wrote:
> > Hi Arseniy,
> >=20
> > avkrasnov@sberdevices.ru wrote on Mon, 5 Jun 2023 09:39:40 +0300:
> >  =20
> >> Hello Miquel!
> >>
> >> I exclude this patch from the recent Meson patchset, as it is fix and =
not related to another patches.
> >> Also I think that I can split Meson patchset (from links below) in the=
 following way:
> >> 1) Patch/patchset for OOB layout
> >> 2) Patchset for "nand-rb" logic (meson_nand.c + DT bindings)
> >> These two can also go independently:
> >> 3) https://lore.kernel.org/linux-mtd/20230601061850.3907800-6-AVKrasno=
v@sberdevices.ru/
> >> 4) https://lore.kernel.org/linux-mtd/20230601061850.3907800-7-AVKrasno=
v@sberdevices.ru/ =20
> >=20
> > LGTM. =20
>=20
> I think we don't need this patch with new RB_INT value. I dive into conve=
rsations with Liang Yang - author of this driver. He said,
> that this define is "special" polling mode. Now I'm a little bit more exp=
erienced in NAND area, so IIUC we have two basic waiting modes:
> 1) Software, by sending status command, then polling reply from controlle=
r, and then finally send READ0 to exit status reading mode (nand_soft_waitr=
dy()).

This is useful...

> 2) By RB pin and interrupt - in this mode we send vendor specific command=
 to the controller and it triggers interrupt on RB pin update.
>    In this case RB pin must be connected to the controller. This mode is =
already implemented by Liang Yang.

...this is useful...

>=20
> Now, command with this new define works in the following way: we send sta=
tus command, by instead of reading reply from it by software,
> controller itself checks RB pin and status ready bit in IO bus. Driver ju=
st waits on completion. After waiting we need to send
> READ0 command again to make controller leave status reading mode. I think=
 this is like "intermediate" mode between software polling
> and hardware interrupt - there is no need to spin in loop, waiting for st=
atus ready bit, but still need to leave status mode by sending
> READ0 command. I'm not sure that we need this as third mode of waiting fo=
r command is done. May be at least not in this work on Meson driver,
> so I guess to drop this patch at  this moment and add 'nand_soft_waitrdy(=
)' support.

...I agree we can skip this one.

Thanks,
Miqu=C3=A8l
