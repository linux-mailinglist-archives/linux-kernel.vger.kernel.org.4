Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36FE8712B69
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 19:09:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242148AbjEZRJW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 13:09:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236757AbjEZRJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 13:09:20 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 935F51B4
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 10:09:10 -0700 (PDT)
X-GND-Sasl: miquel.raynal@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1685120948;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mdi3+7iY1FuuVZkTHEgLzoKSqhn5EptZQCzuKXVDC0s=;
        b=ZtKAWITht2MZsPftTNyQR0rssOpfR0x0RkKpyVvkGXiNJijisFlfgOqCuq/mhPJtyz5Ror
        uRm31TWwLlCyu95bUA/IWD5Xdlxq+UBmuwB5dRL9pGUc/rSbm8Hw0/nz6tm6YLkVvfWPST
        VYEsq1Va1Qg7/9FKOmqfUqUOs17k4nlWHKEuMYLTOxBf1UPqoC8JxLfXSTr/4MiSRUJ+hk
        xIaINAqGLNijTwq1cHYzwTC8Kl0A3r5Qo5r1B33RoUnd5YRag6V+HosxwW8cVZulf/TS9l
        8i8kYjkmP/ltSzYPzSnJRO19FGBSFMlaezoILrh/gXrhKzAaCUT+gMbrSjsqAA==
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
Received: by mail.gandi.net (Postfix) with ESMTPSA id A77D41BF204;
        Fri, 26 May 2023 17:09:06 +0000 (UTC)
Date:   Fri, 26 May 2023 19:09:05 +0200
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
        <linux-amlogic@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 3/5] mtd: rawnand: meson: always read whole OOB bytes
Message-ID: <20230526190905.1d5a3821@xps-13>
In-Reply-To: <84a2e0c4-cc6f-1743-ee93-c13bc8bf09f1@sberdevices.ru>
References: <20230515094440.3552094-1-AVKrasnov@sberdevices.ru>
        <20230515094440.3552094-4-AVKrasnov@sberdevices.ru>
        <20230522173813.08afe6b8@xps-13>
        <84a2e0c4-cc6f-1743-ee93-c13bc8bf09f1@sberdevices.ru>
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

avkrasnov@sberdevices.ru wrote on Tue, 23 May 2023 20:27:35 +0300:

> On 22.05.2023 18:38, Miquel Raynal wrote:
> > Hi Arseniy,
> >=20
> > AVKrasnov@sberdevices.ru wrote on Mon, 15 May 2023 12:44:37 +0300:
> >  =20
> >> This changes size of read access to OOB area by reading all bytes of
> >> OOB (free bytes + ECC engine bytes). =20
> >=20
> > This is normally up to the user (user in your case =3D=3D jffs2). The
> > controller driver should expose a number of user accessible bytes and
> > then when users want the OOB area, they should access it entirely. On
> > top of that read, they can extract (or "write only") the user bytes. =20
>=20
> Sorry, I didn't get it. If driver exposes N bytes of user accessible byte=
s,
> I must always return whole OOB yes? E.g. N + rest of OOB

Yes. At the NAND controller level, you get asked for either a page of
data (sometimes a subpage, but whatever), and/or the oob area. You need
to provide what is requested, no more, no less. The upper layers will
trim down what's uneeded and extract the bytes they want.

> >> Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
> >> ---
> >>  drivers/mtd/nand/raw/meson_nand.c | 24 ++++++++++++++++++++++++
> >>  1 file changed, 24 insertions(+)
> >>
> >> diff --git a/drivers/mtd/nand/raw/meson_nand.c b/drivers/mtd/nand/raw/=
meson_nand.c
> >> index 8526a6b87720..a31106c943d7 100644
> >> --- a/drivers/mtd/nand/raw/meson_nand.c
> >> +++ b/drivers/mtd/nand/raw/meson_nand.c
> >> @@ -755,6 +755,30 @@ static int __meson_nfc_read_oob(struct nand_chip =
*nand, int page,
> >>  	u32 oob_bytes;
> >>  	u32 page_size;
> >>  	int ret;
> >> +	int i;
> >> +
> >> +	/* Read ECC codes and user bytes. */
> >> +	for (i =3D 0; i < nand->ecc.steps; i++) {
> >> +		u32 ecc_offs =3D nand->ecc.size * (i + 1) +
> >> +			       NFC_OOB_PER_ECC(nand) * i;
> >> +
> >> +		ret =3D nand_read_page_op(nand, page, 0, NULL, 0);
> >> +		if (ret)
> >> +			return ret;
> >> +
> >> +		/* Use temporary buffer, because 'nand_change_read_column_op()'
> >> +		 * seems work with some alignment, so we can't read data to
> >> +		 * 'oob_buf' directly. =20
> >=20
> > DMA? =20
>=20
> Yes I guess, this address passed to exec_op code and used as DMA.

If your controller uses DMA on exec_op accesses, then yes. Exec_op
reads/writes are usually small enough (or not time sensitive at all if
they are bigger) so it's not required to use DMA there. Anyhow, oob_buf
is suitable for DMA purposes, so I'm a bit surprised you need a bounce
buffer, if that's the only reason. Maybe you need a bounce buffer to
reorganize the data. That would be a much better explanation.

> >> +		 */
> >> +		ret =3D nand_change_read_column_op(nand, ecc_offs, meson_chip->oob_=
buf,
> >> +						 NFC_OOB_PER_ECC(nand), false);
> >> +		if (ret)
> >> +			return ret;
> >> +
> >> +		memcpy(oob_buf + i * NFC_OOB_PER_ECC(nand),
> >> +		       meson_chip->oob_buf,
> >> +		       NFC_OOB_PER_ECC(nand));
> >> +	}
> >> =20
> >>  	oob_bytes =3D meson_nfc_get_oob_bytes(nand);
> >>   =20
> >=20
> >=20
> > Thanks,
> > Miqu=C3=A8l =20
>=20
> Thanks, Arseniy


Thanks,
Miqu=C3=A8l
