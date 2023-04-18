Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EFE46E65CB
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 15:25:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232238AbjDRNZQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 09:25:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbjDRNZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 09:25:14 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7149CC29
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 06:25:12 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 0EAEF240002;
        Tue, 18 Apr 2023 13:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1681824311;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a4ugRgZNu/Y+baSK+9UqHRS8pZ9Nhe2pwx9QcHGO7qQ=;
        b=oLiGo4PRzihRAJLpguz+PlMJwr7om8taIquydk8GT6iIDMZI0eemdwaItHjQju6h9yYRQd
        75TGkfQ8FlW6TunA7ncve2pBpkxeh68RNtsyTsEMakpYGhuz9QQncJPNnBOx++2x/35XZ1
        YfYmIV25hOM8VU3hNyOJ5clsnDrwKF1x96n56h6yc+W2TQtmS+0TTr6pA8TQTOPpXjsCnA
        zoqCCNCrtjKuPxquL55ja8iNzy/LyBUZj0GqExbz00XaqkjOEp8Z8gzZ3cL7HakbKpfwQ8
        OoX2fR9wc0DFvtNY3NIjUaSsybzkgTBGfJQG4BQlE7ZTAo/GQECnlYk4Mr95SA==
Date:   Tue, 18 Apr 2023 15:25:05 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Arseniy Krasnov <avkrasnov@sberdevices.ru>
Cc:     Liang Yang <liang.yang@amlogic.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Yixun Lan <yixun.lan@amlogic.com>, <oxffffaa@gmail.com>,
        <kernel@sberdevices.ru>, <linux-mtd@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        "yonghui.yu" <yonghui.yu@amlogic.com>
Subject: Re: [PATCH v1 4/5] mtd: rawnand: meson: clear OOB buffer before
 read
Message-ID: <20230418152505.72fc16da@xps-13>
In-Reply-To: <e7c49f2d-b3c1-8d9b-76fe-c8759b37c7c7@sberdevices.ru>
References: <20230412061700.1492474-1-AVKrasnov@sberdevices.ru>
        <20230412094400.3c82f631@xps-13>
        <ac4b66da-6a76-c2ec-7e21-31632f3448d5@sberdevices.ru>
        <20230412113654.183350d0@xps-13>
        <4eace0a0-f6af-7d99-a52f-7913a2139330@sberdevices.ru>
        <20230412141824.755b2bca@xps-13>
        <eedaaed9-0a41-2c18-9eb2-792613566986@sberdevices.ru>
        <20230412145715.58c2be4a@xps-13>
        <7c996832-258f-001c-56bd-87bbdf23eeaa@amlogic.com>
        <20230412163214.0c764bb3@xps-13>
        <0c61eaae-053e-5768-a533-70b2ff0cc95d@amlogic.com>
        <fbb8cb2b-0996-3029-b368-f67087d73487@amlogic.com>
        <7520e512-8a19-ff04-364c-b5be0a579ef0@sberdevices.ru>
        <20230413102200.309fbe9c@xps-13>
        <b3279de4-e89d-db03-a515-a6aa52ab90d3@sberdevices.ru>
        <20230413122252.0a8efcd8@xps-13>
        <569a948e-654a-b21f-8a4f-55dc4b295387@sberdevices.ru>
        <60fa656e-bda1-1de6-a79e-3e3041cd69a8@sberdevices.ru>
        <780c0cae-18b6-2652-1c2c-6d398ea60451@amlogic.com>
        <e7c49f2d-b3c1-8d9b-76fe-c8759b37c7c7@sberdevices.ru>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arseniy,

> >> Hello again @Liang @Miquel!
> >>
> >> One more question about OOB access, as I can see current driver uses t=
he following
> >> callbacks:
> >>
> >> =C2=A0=C2=A0=C2=A0=C2=A0nand->ecc.write_oob_raw =3D nand_write_oob_std;
> >> =C2=A0=C2=A0=C2=A0=C2=A0nand->ecc.write_oob =3D nand_write_oob_std;
> >>
> >>
> >> Function 'nand_write_oob_std()' writes data to the end of the page. Bu=
t as I
> >> can see by dumping 'data_buf' during read, physical layout of each pag=
e is the
> >> following (1KB ECC):
> >>
> >> 0x000: [=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1 KB of data=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ]
> >> 0x400: [ 2B user data] [ 14B ECC code]
> >> 0x410: [=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1 KB of data=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ]=C2=A0=C2=A0=C2=A0 (A)
> >> 0x810: [ 2B user data] [ 14B ECC code]
> >> 0x820: [=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 32B unused=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ]
> >>
> >>
> >>
> >> So, after 'nand_write_oob_std()' (let data be sequence from [0x0 ... 0=
x3f]),
> >> page will look like this:
> >>
> >> 0x000: [=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 0xFF=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 ]
> >> 0x400: [=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .=
.......=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ]
> >> 0x7f0: [=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 0xFF=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 ]
> >> 0x800: [ 00 .......................=C2=A0 ]
> >> 0x830: [ ........................ 3f ]
> >>
> >> Here we have two problems:
> >> 1) Attempt to display raw data by 'nanddump' utility produces a little=
 bit
> >> =C2=A0=C2=A0=C2=A0 invalid output, as driver relies on layout (A) from=
 above. E.g. OOB data
> >> =C2=A0=C2=A0=C2=A0 is at 0x400 and 0x810. Here is an example (attempt =
to write 0x11 0x22 0x33 0x44):
> >>
> >> 0x000007f0: 11 22 ff ff ff ff ff ff ff ff ff ff ff ff ff ff=C2=A0 |.".=
.............|
> >> =C2=A0=C2=A0 OOB Data: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff=
=C2=A0 |................|
> >> =C2=A0=C2=A0 OOB Data: 33 44 ff ff ff ff ff ff ff ff ff ff ff ff ff ff=
=C2=A0 |3D..............|
> >> =C2=A0=C2=A0 OOB Data: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff=
=C2=A0 |................|
> >> =C2=A0=C2=A0 OOB Data: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff=
=C2=A0 |................|
> >> =20
> > Hi Arseniy,
> >=20
> > I realized the write_oob_raw() and write_oob() are wrong in meson_nand.=
c. I suggest both of them should be reworked and follow the format of meson=
 nand controller. i.e. firstly format the data in Layout (A) and then write=
. reading is firstly reading the data of layout (A) and then compost the la=
yout (B). =20
>=20
> IIUC after such writing only OOB (e.g. user bytes) according layout (A), =
hw will also write ECC codes, so
> it will be impossible to write data to this page later, because we cannot=
 update ECC codes properly for the newly
> written data (we can't update bits from 0 to 1).
>=20
> >=20
> >  =20
> >>
> >> 2) Attempt to read data in ECC mode will fail, because IIUC page is in=
 dirty
> >> =C2=A0=C2=A0=C2=A0 state (I mean was written at least once) and NAND c=
ontroller tries to use
> >> =C2=A0=C2=A0=C2=A0 ECC codes at 0x400 and 0x810, which are obviously b=
roken in this case. Thus =20
> >=20
> > As i said above, write_oob_raw() and write_oob() should be reworked.
> > i don't know what do you mean page was written at least once. anyway th=
e page should be written once, even just write_oob_raw(). =20
>=20
> Sorry, You mean that after OOB write, we cannot write to the data area (e=
.g. 0x0 .. 0x810) until page will be erased? For example
> JFFS2 writes to OOB own markers, then it tries to write to the data area =
of such page.

A page is written after two steps:
- loading the data into the NAND chip cache (that's when you use the
  bus)
- programming the NAND array with the data loaded in cache (that's when
  you wait)

In theory it does not matter where you write in the cache, it's regular
DRAM, you can make random writes there with the appropriate NAND
commands. Of course when using embedded hardware ECC engines, the
controllers usually expect to be fed in a certain way in order to
produce the ECC bytes and put them at the right location in cache.

And then, when you actually send the "program" command, the NAND cells
actually get programmed based on what has been loaded in cache.

Thanks,
Miqu=C3=A8l
