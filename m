Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2919E715849
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 10:22:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbjE3IWC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 04:22:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230262AbjE3IVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 04:21:53 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83E14D9
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 01:21:47 -0700 (PDT)
X-GND-Sasl: miquel.raynal@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1685434906;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L7k/WfCxpV4Wb3Zf5dT6zrNqHZZm4+YA1ttDwgyZUUY=;
        b=hr0vWnFnLsrmGlwaEPeP0BZVQwmQQBY7HJ0zKb/nJ7Jh9iXFeqJpxXFjLeQHR89kaxYXrH
        YyjAhBfk0o8KXYQqHT5DUz9SVLYG7cWIgLCEkQBiQI4Nf2FG8oD8HW+DFn2H4Mo9Zhr1z5
        G7iwIg557uEeAhSJoBBmmAjNEFjMpxq0sjbNNQZSIptstl1ZYNwqwScOEyZ5RlpWBDB25l
        CKDu3PaBETbpHzbbyTdjehvI3qkiUZUCfyZDMTyc+tjFpdYbSqRVgbJlfpOldlAzBa7fEm
        DOy8oC4s9vgRp5Gy4nOonwL9f+j6BMr3QOIOSDy0sHtfyKkDUa70DeBJy3ab5g==
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
Received: by mail.gandi.net (Postfix) with ESMTPSA id 282FDC0005;
        Tue, 30 May 2023 08:21:43 +0000 (UTC)
Date:   Tue, 30 May 2023 10:21:43 +0200
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
Message-ID: <20230530102143.6b2a199a@xps-13>
In-Reply-To: <1f4c90c4-e436-c53f-bb6f-416db374ae52@sberdevices.ru>
References: <20230515094440.3552094-1-AVKrasnov@sberdevices.ru>
        <20230515094440.3552094-3-AVKrasnov@sberdevices.ru>
        <20230522173334.7aa6f917@xps-13>
        <ebbc26e3-6a1c-eead-051c-8f93beba41f3@sberdevices.ru>
        <20230526190347.6e34a2be@xps-13>
        <b9f0a38a-0d50-23f0-4509-c38362d05f12@sberdevices.ru>
        <20230530094420.06281ab5@xps-13>
        <1f4c90c4-e436-c53f-bb6f-416db374ae52@sberdevices.ru>
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

avkrasnov@sberdevices.ru wrote on Tue, 30 May 2023 11:09:10 +0300:

> Hi Miquel,
>=20
> On 30.05.2023 10:44, Miquel Raynal wrote:
> > Hi Arseniy,
> >  =20
> >>>>>> -static void meson_nfc_get_user_byte(struct nand_chip *nand, u8 *o=
ob_buf)
> >>>>>> -{
> >>>>>> -	struct meson_nfc_nand_chip *meson_chip =3D to_meson_nand(nand);
> >>>>>> -	__le64 *info;
> >>>>>> -	int i, count;
> >>>>>> +	int i;
> >>>>>> =20
> >>>>>> -	for (i =3D 0, count =3D 0; i < nand->ecc.steps; i++, count +=3D =
2) {
> >>>>>> +	for (i =3D 0; i < nand->ecc.steps; i++) {
> >>>>>>  		info =3D &meson_chip->info_buf[i];
> >>>>>> -		oob_buf[count] =3D *info;
> >>>>>> -		oob_buf[count + 1] =3D *info >> 8;
> >>>>>> +		/* Always ignore user bytes programming. */     =20
> >>>>>
> >>>>> Why?     =20
> >>>>
> >>>> I think comment message is wrong a little bit. Here "user bytes" are
> >>>> user bytes protected by ECC (e.g. location of these bytes differs fr=
om new
> >>>> OOB layout introduced by this patch). During page write this hardware
> >>>> always writes these bytes along with data. But, new OOB layout alway=
s ignores
> >>>> these 4 bytes, so set them to 0xFF always.   =20
> >>>
> >>> When performing page reads/writes, you need to take the data as it's
> >>> been provided. You may move the data around in the buffer provided to
> >>> the controller, so that it get the ECC data at the right location, and
> >>> you need of course to reorganize the data when reading as well, so th=
at
> >>> the user sees XkiB of data + YB of OOB. That's all you need to do in
> >>> these helpers.
> >>>    =20
> >>
> >> I think there is some misunderstanding about these "user bytes" above:=
 there are 4
> >> bytes which this NAND controller always writes to page in ECC mode - i=
t was free OOB
> >> bytes covered by ECC. Controller grabs values from DMA buffer (second =
DMA buffer which
> >> doesn't contains page data) and writes it along with data and ECC code=
s. Idea of this
> >> change is to always suppress this write by setting them to 0xFF (may b=
e there is some
> >> command option to not write it, but I don't have doc), because all of =
them (4 bytes)
> >> become unavailable to reader/writer. =20
> >=20
> > At the NAND controller level, I would rather avoid doing things like
> > that.
> >=20
> > I believe you can just update the ooblayout so that protected OOB bytes
> > are not exposed to the user as free bytes. Then your buffers should
> > already contain 0xffffff at the problematic location. =20
>=20
> So Your idea is to continue fill DMA buffer (for these 4 bytes) from prov=
ided OOB buffer,
> relying on that as these bytes are unused, they will be 0xFF in OOB buffe=
r so we get the same result?

Yes.

The problem you face is due to jffs2 using free OOB bytes to store some
data. If this data is in the protected area -> BOOM.

If another application wants to use all the bytes and writes them all
in the same PROGRAM operation it's fine.

Jffs2 accesses the free area through the OOB layouts only, so just
tweaking the OOB layouts should work.

Thanks,
Miqu=C3=A8l
