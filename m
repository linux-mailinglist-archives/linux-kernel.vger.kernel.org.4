Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 565F37220C8
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 10:17:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230396AbjFEIRs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 04:17:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbjFEIRq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 04:17:46 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FFE7AD;
        Mon,  5 Jun 2023 01:17:44 -0700 (PDT)
X-GND-Sasl: miquel.raynal@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1685953062;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gdAlxoLc+mdMpOk5isWATrbVT+kMTap6Q3uXBMQmEUc=;
        b=lbmd7wKAXRz20bqQebmTUQ3lA8oFmKhG78pmycCoMN+7cJ3zihD6ZWJApUzgpDmZr44UFh
        BZymwwSHqmpod20ANFdYpqmCdYz7czRvJYTUk/aWywLf/d7o7p2vrZQkXZGfulaATEInx8
        oGth25NHshSCMzwgI+aU+hIwUcF4D8uvVTyVBAtp+U9dlIy0oYqxkuN53zPO28b6srNL/0
        FJeFv69+2zWvzRoOq1tbQ/I/+nml5DKOTkBIEugYeXx2jU9FHpO3akER025fuLBPfZmBSX
        XlhLlq0Tmu3Z++ZNoUiWEyYwy7VUqu6vpp3m+0fWbfFmqfNCA2bCCcu1g3iLfw==
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
Received: by mail.gandi.net (Postfix) with ESMTPSA id DAAAFC000D;
        Mon,  5 Jun 2023 08:17:40 +0000 (UTC)
Date:   Mon, 5 Jun 2023 10:17:39 +0200
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
Message-ID: <20230605101739.069b98af@xps-13>
In-Reply-To: <19f809ab-218e-8da5-6d5e-ac47902fa706@sberdevices.ru>
References: <20230605061048.485622-1-AVKrasnov@sberdevices.ru>
        <19f809ab-218e-8da5-6d5e-ac47902fa706@sberdevices.ru>
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

avkrasnov@sberdevices.ru wrote on Mon, 5 Jun 2023 09:39:40 +0300:

> Hello Miquel!
>=20
> I exclude this patch from the recent Meson patchset, as it is fix and not=
 related to another patches.
> Also I think that I can split Meson patchset (from links below) in the fo=
llowing way:
> 1) Patch/patchset for OOB layout
> 2) Patchset for "nand-rb" logic (meson_nand.c + DT bindings)
> These two can also go independently:
> 3) https://lore.kernel.org/linux-mtd/20230601061850.3907800-6-AVKrasnov@s=
berdevices.ru/
> 4) https://lore.kernel.org/linux-mtd/20230601061850.3907800-7-AVKrasnov@s=
berdevices.ru/

LGTM.

>=20
> What do You think?
>=20
> Thanks, Arseniy
>=20
> On 05.06.2023 09:10, Arseniy Krasnov wrote:
> > Fix the ready/busy command value.
> >=20
> > Fixes: 8fae856c5350 ("mtd: rawnand: meson: add support for Amlogic NAND=
 flash controller")
> > Cc: stable@vger.kernel.org
> > Suggested-by: Liang Yang <liang.yang@amlogic.com>
> > Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
> > ---
> >  drivers/mtd/nand/raw/meson_nand.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/mtd/nand/raw/meson_nand.c b/drivers/mtd/nand/raw/m=
eson_nand.c
> > index 074e14225c06..9dd4a676497b 100644
> > --- a/drivers/mtd/nand/raw/meson_nand.c
> > +++ b/drivers/mtd/nand/raw/meson_nand.c
> > @@ -37,7 +37,7 @@
> >  #define NFC_CMD_SCRAMBLER_ENABLE	BIT(19)
> >  #define NFC_CMD_SCRAMBLER_DISABLE	0
> >  #define NFC_CMD_SHORTMODE_DISABLE	0
> > -#define NFC_CMD_RB_INT		BIT(14)
> > +#define NFC_CMD_RB_INT		((0xb << 10) | BIT(18) | BIT(16))
> > =20
> >  #define NFC_CMD_GET_SIZE(x)	(((x) >> 22) & GENMASK(4, 0))
> >   =20


Thanks,
Miqu=C3=A8l
