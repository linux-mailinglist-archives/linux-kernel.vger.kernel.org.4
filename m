Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08EBC6CD5C0
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 11:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbjC2JCA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 05:02:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230079AbjC2JBw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 05:01:52 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BA4549FA
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 02:01:19 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id DB9F3C0003;
        Wed, 29 Mar 2023 09:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1680080459;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0zatGGQG54bItvUiWFNeQvKWMpLA6rN2JrESMa0BVeA=;
        b=I2DMStzPVY2slXtlPUjHVjnyfnYeLkaLt/n979HwUmcswJ7bxx8q72zGmzWp/37MQZZCw7
        OKY9LNr6x87vhklaiKX0RR00tK51SYUrBzATjoIJOrGxbA3j1/bEthZHFb4IBnubLAhxeC
        dtegH2RO24TjDk2XL4NKYNp5h3FgYba6ROtFakEVFbBLusHZuIzRV8UpKal0KZWqzFx476
        mTjLMhb7DWjsrvHKraCL/XFERW1VbPxH9B3Hm6sSVGlwCVoDs3g/1t2FXANFU6t6cN/Kf3
        Sevj3YUn3Qq3t9qDR0WXKLTdIJqan/QmjEPhOwUPHWP5dtFriEt8YecoGQ6a4w==
Date:   Wed, 29 Mar 2023 11:00:54 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Arseniy Krasnov <avkrasnov@sberdevices.ru>
Cc:     Tudor Ambarus <tudor.ambarus@linaro.org>,
        Liang Yang <liang.yang@amlogic.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Yixun Lan <yixun.lan@amlogic.com>,
        <linux-mtd@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kernel@sberdevices.ru>,
        <oxffffaa@gmail.com>
Subject: Re: [PATCH v2] mtd: rawnand: meson: fix bitmask for length in
 command word
Message-ID: <20230329110054.68455418@xps-13>
In-Reply-To: <c110bd0f-f25a-a74a-07cb-4c3fdb8ef306@sberdevices.ru>
References: <3794ffbf-dfea-e96f-1f97-fe235b005e19@sberdevices.ru>
        <447abc1b-b4a3-5848-c99a-ecbff11486fe@linaro.org>
        <c110bd0f-f25a-a74a-07cb-4c3fdb8ef306@sberdevices.ru>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arseniy,

avkrasnov@sberdevices.ru wrote on Wed, 29 Mar 2023 11:33:38 +0300:

> On 29.03.2023 11:09, Tudor Ambarus wrote:
> >=20
> >=20
> > On 3/29/23 08:47, Arseniy Krasnov wrote: =20
> >> Valid mask is 0x3FFF, without this patch the following problems were
> >> found:
> >>
> >> 1) [    0.938914] Could not find a valid ONFI parameter page, trying
> >>                   bit-wise majority to recover it
> >>    [    0.947384] ONFI parameter recovery failed, aborting
> >>
> >> 2) Read with disabled ECC mode was broken.
> >>
> >> Fixes: 8fae856c5350 ("mtd: rawnand: meson: add support for Amlogic NAN=
D flash controller")
> >> Cc: <Stable@vger.kernel.org>
> >> Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
> >> ---
> >>  drivers/mtd/nand/raw/meson_nand.c | 6 +++---
> >>  1 file changed, 3 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/drivers/mtd/nand/raw/meson_nand.c b/drivers/mtd/nand/raw/=
meson_nand.c
> >> index a28574c00900..074e14225c06 100644
> >> --- a/drivers/mtd/nand/raw/meson_nand.c
> >> +++ b/drivers/mtd/nand/raw/meson_nand.c
> >> @@ -280,7 +280,7 @@ static void meson_nfc_cmd_access(struct nand_chip =
*nand, int raw, bool dir,
> >> =20
> >>  	if (raw) {
> >>  		len =3D mtd->writesize + mtd->oobsize;
> >> -		cmd =3D (len & GENMASK(5, 0)) | scrambler | DMA_DIR(dir);
> >> +		cmd =3D (len & GENMASK(13, 0)) | scrambler | DMA_DIR(dir); =20
> >=20
> > What happens when len > GENMASK(13, 0)? Do you check this somewhere? =20
>=20
> 'len' will be trimmed. I'm not sure that this case is possible here, beca=
use GENMASK(13, 0)
> is hardware limit for this NAND controller, so 'writesize' and 'oobsize' =
will be initialized
> to fit this value. Moreover GENMASK(13, 0) is 16Kb - i think it is big en=
ough for single
> read. Also i'm not sure that it is good approach to check 'len' here - we=
 are in the middle
> of NAND read processing.

No, you should check the page size will not exceed this limit in the
attach hook, likely.

You should also refuse exec_op operations with a data length bigger
than 16k (either with a manual check in your own parser or just by
providing the max size to the parser table, depending on what's used).

>=20
> >=20
> > Please introduce a macro/field for GENMASK(13, 0), having such mask
> > scattered along the code looks hackish and doesn't help readability.
> > You'll get to use FIELD_PREP as well. =20
>=20
> Ack, i'll do it in v3
>=20
> Thanks, Arseniy
>=20
> >  =20
> >>  		writel(cmd, nfc->reg_base + NFC_REG_CMD);
> >>  		return;
> >>  	}
> >> @@ -544,7 +544,7 @@ static int meson_nfc_read_buf(struct nand_chip *na=
nd, u8 *buf, int len)
> >>  	if (ret)
> >>  		goto out;
> >> =20
> >> -	cmd =3D NFC_CMD_N2M | (len & GENMASK(5, 0));
> >> +	cmd =3D NFC_CMD_N2M | (len & GENMASK(13, 0));
> >>  	writel(cmd, nfc->reg_base + NFC_REG_CMD);
> >> =20
> >>  	meson_nfc_drain_cmd(nfc);
> >> @@ -568,7 +568,7 @@ static int meson_nfc_write_buf(struct nand_chip *n=
and, u8 *buf, int len)
> >>  	if (ret)
> >>  		return ret;
> >> =20
> >> -	cmd =3D NFC_CMD_M2N | (len & GENMASK(5, 0));
> >> +	cmd =3D NFC_CMD_M2N | (len & GENMASK(13, 0));
> >>  	writel(cmd, nfc->reg_base + NFC_REG_CMD);
> >> =20
> >>  	meson_nfc_drain_cmd(nfc); =20


Thanks,
Miqu=C3=A8l
