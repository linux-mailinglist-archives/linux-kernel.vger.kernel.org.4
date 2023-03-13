Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C3D86B75C5
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 12:18:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbjCMLSc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 07:18:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbjCMLSX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 07:18:23 -0400
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [217.70.178.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B188113DE
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 04:18:16 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 902CA100005;
        Mon, 13 Mar 2023 11:18:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1678706295;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XOFpHOYu/H34Q2s+uwCeSHHQZCRIFK+aDl1wzsSdNlQ=;
        b=mVTipQjYC4iXdBOVs4SnNxA5VDqWyafInznBZdUaXtkHWT9+6cDncJ0vUkBhL0AOpiyqqi
        TlaYW49Xx/L3SzPV/kNCaTovQ9xlvsId5XSWHzP6KlmakXsmS6NDL3SIxYYCjl97LaDwR8
        yNJ2wSsuTZm5CTLDzG3GhUzzk1EaEzL3Aj64r1ADABqxkSXDH9L2no0tkbL8pDNxKZgvNF
        mW22Xqp+R6J2TnAOfufNZw5VUQn2+pJBIB+PoG2hihV8YwRjqDU+mFhYN9zEuZq3BrktAI
        HM2Qhqfjx80wLB+pkcAdLniwvv/+oGS+d7ptC4Fb4lXaN6qUosc+gDOLYSVQig==
Date:   Mon, 13 Mar 2023 12:18:08 +0100
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
        <linux-mtd@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kernel@sberdevices.ru>,
        <oxffffaa@gmail.com>
Subject: Re: [RFC PATCH v1] mtd: rawnand: meson: invalidate cache on polling
 ECC bit
Message-ID: <20230313121808.27170d1b@xps-13>
In-Reply-To: <20f7f1f8-e8f8-b3e1-251e-27db71ab6840@sberdevices.ru>
References: <d4ef0bd6-816e-f6fa-9385-f05f775f0ae2@sberdevices.ru>
        <20f7f1f8-e8f8-b3e1-251e-27db71ab6840@sberdevices.ru>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arseniy,

avkrasnov@sberdevices.ru wrote on Mon, 13 Mar 2023 10:36:11 +0300:

> Hello,
>=20
> we reproduced this problem on one of our boards. It triggers very rare
> when 'usleep_range()' is present, but when sleeping is removed - it fires
> always. I suppose problem is with caching, as 'info_buf' memory is mapped=
 by
> 'dma_map_single()'.

The fix looks really legitimate, indeed I get that the usleep_range()
might make it work most of the time but not always. Having this bit in
a DMA buf area is a bit strange. Well, the fix LGTM anyway.

>=20
> Thanks, Arseniy
>=20
> On 13.03.2023 10:32, Arseniy Krasnov wrote:
> > 'info_buf' memory is cached and driver polls ECC bit in it. This bit
> > is set by the NAND controller. If 'usleep_range()' returns before device
> > sets this bit, 'info_buf' will be cached and driver won't see update of
> > this bit and will loop forever.
> >=20
> > Fixes: 8fae856c5350 ("mtd: rawnand: meson: add support for Amlogic NAND=
 flash controller")
> > Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
> > ---
> >  drivers/mtd/nand/raw/meson_nand.c | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/mtd/nand/raw/meson_nand.c b/drivers/mtd/nand/raw/m=
eson_nand.c
> > index 5ee01231ac4c..2c05c08a0eaf 100644
> > --- a/drivers/mtd/nand/raw/meson_nand.c
> > +++ b/drivers/mtd/nand/raw/meson_nand.c
> > @@ -176,6 +176,7 @@ struct meson_nfc {
> > =20
> >  	dma_addr_t daddr;
> >  	dma_addr_t iaddr;
> > +	u32 info_bytes;
> > =20
> >  	unsigned long assigned_cs;
> >  };
> > @@ -503,6 +504,7 @@ static int meson_nfc_dma_buffer_setup(struct nand_c=
hip *nand, void *databuf,
> >  					 nfc->daddr, datalen, dir);
> >  			return ret;
> >  		}
> > +		nfc->info_bytes =3D infolen;
> >  		cmd =3D GENCMDIADDRL(NFC_CMD_AIL, nfc->iaddr);
> >  		writel(cmd, nfc->reg_base + NFC_REG_CMD);
> > =20
> > @@ -520,8 +522,10 @@ static void meson_nfc_dma_buffer_release(struct na=
nd_chip *nand,
> >  	struct meson_nfc *nfc =3D nand_get_controller_data(nand);
> > =20
> >  	dma_unmap_single(nfc->dev, nfc->daddr, datalen, dir);
> > -	if (infolen)
> > +	if (infolen) {
> >  		dma_unmap_single(nfc->dev, nfc->iaddr, infolen, dir);
> > +		nfc->info_bytes =3D 0;
> > +	}
> >  }
> > =20
> >  static int meson_nfc_read_buf(struct nand_chip *nand, u8 *buf, int len)
> > @@ -710,6 +714,8 @@ static void meson_nfc_check_ecc_pages_valid(struct =
meson_nfc *nfc,
> >  		usleep_range(10, 15);
> >  		/* info is updated by nfc dma engine*/
> >  		smp_rmb();
> > +		dma_sync_single_for_cpu(nfc->dev, nfc->iaddr, nfc->info_bytes,
> > +					DMA_FROM_DEVICE);
> >  		ret =3D *info & ECC_COMPLETE;
> >  	} while (!ret);
> >  } =20


Thanks,
Miqu=C3=A8l
