Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0AD3715782
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 09:46:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbjE3Hqo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 03:46:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbjE3HqQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 03:46:16 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AED6CE4C
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 00:44:45 -0700 (PDT)
X-GND-Sasl: miquel.raynal@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1685432664;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fOSXuwa5qNQTlbZ+yAfd+pe1WH2YkOx4imfXGbwKHUw=;
        b=frOHFMcA+eC2S94i1B/AgAHDDLvh0pZ31vqzDUnYqTpplzeHpXksOpKOe33b2LK98ysFtW
        4rtvqN8N4Yljh9c0WQAc3qtSJx5pnM/alRLxBCsF4Jofz2qNvObYif4SLBduzJYDIyQpaJ
        eASn6fo/0mdn54M65+7P3OQnguQk9YwYhEVGm5VpcvQwiJ6ueo216DWNHjUNcVG6RWPQcc
        wcxiojiePYg0gcwHTE/VfV2RSZtR8+aGyZ1kBjg2PjEm/KjI41hjsX4IBVeUbIKjYGsb90
        /583cp83GJ3GEnuUkPlBTr6OYNfjfFknJPO35kdwueku5jlEvMdMuWp/M4zhXQ==
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
Received: by mail.gandi.net (Postfix) with ESMTPSA id CF8D7E0012;
        Tue, 30 May 2023 07:44:21 +0000 (UTC)
Date:   Tue, 30 May 2023 09:44:20 +0200
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
Subject: Re: [PATCH v4 2/5] mtd: rawnand: meson: move OOB to non-protected
 ECC area
Message-ID: <20230530094420.06281ab5@xps-13>
In-Reply-To: <b9f0a38a-0d50-23f0-4509-c38362d05f12@sberdevices.ru>
References: <20230515094440.3552094-1-AVKrasnov@sberdevices.ru>
        <20230515094440.3552094-3-AVKrasnov@sberdevices.ru>
        <20230522173334.7aa6f917@xps-13>
        <ebbc26e3-6a1c-eead-051c-8f93beba41f3@sberdevices.ru>
        <20230526190347.6e34a2be@xps-13>
        <b9f0a38a-0d50-23f0-4509-c38362d05f12@sberdevices.ru>
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

> >>>> -static void meson_nfc_get_user_byte(struct nand_chip *nand, u8 *oob=
_buf)
> >>>> -{
> >>>> -	struct meson_nfc_nand_chip *meson_chip =3D to_meson_nand(nand);
> >>>> -	__le64 *info;
> >>>> -	int i, count;
> >>>> +	int i;
> >>>> =20
> >>>> -	for (i =3D 0, count =3D 0; i < nand->ecc.steps; i++, count +=3D 2)=
 {
> >>>> +	for (i =3D 0; i < nand->ecc.steps; i++) {
> >>>>  		info =3D &meson_chip->info_buf[i];
> >>>> -		oob_buf[count] =3D *info;
> >>>> -		oob_buf[count + 1] =3D *info >> 8;
> >>>> +		/* Always ignore user bytes programming. */   =20
> >>>
> >>> Why?   =20
> >>
> >> I think comment message is wrong a little bit. Here "user bytes" are
> >> user bytes protected by ECC (e.g. location of these bytes differs from=
 new
> >> OOB layout introduced by this patch). During page write this hardware
> >> always writes these bytes along with data. But, new OOB layout always =
ignores
> >> these 4 bytes, so set them to 0xFF always. =20
> >=20
> > When performing page reads/writes, you need to take the data as it's
> > been provided. You may move the data around in the buffer provided to
> > the controller, so that it get the ECC data at the right location, and
> > you need of course to reorganize the data when reading as well, so that
> > the user sees XkiB of data + YB of OOB. That's all you need to do in
> > these helpers.
> >  =20
>=20
> I think there is some misunderstanding about these "user bytes" above: th=
ere are 4
> bytes which this NAND controller always writes to page in ECC mode - it w=
as free OOB
> bytes covered by ECC. Controller grabs values from DMA buffer (second DMA=
 buffer which
> doesn't contains page data) and writes it along with data and ECC codes. =
Idea of this
> change is to always suppress this write by setting them to 0xFF (may be t=
here is some
> command option to not write it, but I don't have doc), because all of the=
m (4 bytes)
> become unavailable to reader/writer.

At the NAND controller level, I would rather avoid doing things like
that.

I believe you can just update the ooblayout so that protected OOB bytes
are not exposed to the user as free bytes. Then your buffers should
already contain 0xffffff at the problematic location.

Thanks,
Miqu=C3=A8l
