Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E6F96CA198
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 12:43:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233685AbjC0KnZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 06:43:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233665AbjC0KnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 06:43:22 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E76D3AB0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 03:43:16 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id E91B5E0009;
        Mon, 27 Mar 2023 10:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1679913795;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mq3au7tx9bpvb0kny92KW5V+FEUINAGvXJjvAKrCa6I=;
        b=pTSYk9flkxtggRnAAMuEA+CmCNzdRs8EdTgeg4n2cRjlHnYujmuFf0cMFpysnMlfKNL/5P
        CJTVUYuxQyDbwPy/FZoZy1cHHy2vGBtlnQ4ziqRpfiNIoXFBsQLtKLSMPozE9xyd93sI9e
        KV1UXAlY8RBj4pM4+emy03nOjnikD30pWAegnE87XXhROq1SxdBHVyQ2hf1ov9wixB7Wuf
        pi/7hcEBFGDY7f9yDlLLTAKOwTRouaPoE8wUY51e3fKAqSS+Kev97yy5gTVlxrKeUfWoT3
        2N2N5wjc3tLFMO2lbt7pW1Eq4Yhh+i/Rjurr7WLZ2tjw1h73hKJfK+hSYEUUwA==
Date:   Mon, 27 Mar 2023 12:43:13 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Tudor Ambarus <tudor.ambarus@linaro.org>
Cc:     Christophe Kerello <christophe.kerello@foss.st.com>,
        richard@nod.at, vigneshr@ti.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH v2 2/2] mtd: rawnand: stm32_fmc2: use timings.mode
 instead of checking tRC_min
Message-ID: <20230327124313.1ccd3d66@xps-13>
In-Reply-To: <75dcd205-5432-7103-370c-d65d792631ea@linaro.org>
References: <20230327094742.38856-1-christophe.kerello@foss.st.com>
        <20230327094742.38856-3-christophe.kerello@foss.st.com>
        <75dcd205-5432-7103-370c-d65d792631ea@linaro.org>
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

Hi Tudor,

tudor.ambarus@linaro.org wrote on Mon, 27 Mar 2023 11:30:51 +0100:

> On 3/27/23 10:47, Christophe Kerello wrote:
> > This patch is using timings.mode value instead of checking tRC_min timi=
ng
> > for EDO mode support.
> >  =20
>=20
> Fixes and Cc to stable here too, as you'd like to have this backported
> as well, don't you?

Actually the reason why Christophe split this into two patches is
because timings.mode was introduced rather lately, he wanted the same
patch to apply on all stable kernels, he actually asked for that split
and I agreed (another solution would have been to send this current
patch to Linus and have the other version sent to stable, but it
requires a bit of scheduling on both ends).

Link: https://lore.kernel.org/linux-mtd/20230327101156.0ec2816a@xps-13/T/#t

>=20
> > Signed-off-by: Christophe Kerello <christophe.kerello@foss.st.com> =20
>=20
> Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>
>=20
> > ---
> >  drivers/mtd/nand/raw/stm32_fmc2_nand.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/mtd/nand/raw/stm32_fmc2_nand.c b/drivers/mtd/nand/=
raw/stm32_fmc2_nand.c
> > index 3abb63d00a0b..9e74bcd90aaa 100644
> > --- a/drivers/mtd/nand/raw/stm32_fmc2_nand.c
> > +++ b/drivers/mtd/nand/raw/stm32_fmc2_nand.c
> > @@ -1531,7 +1531,7 @@ static int stm32_fmc2_nfc_setup_interface(struct =
nand_chip *chip, int chipnr,
> >  	if (IS_ERR(sdrt))
> >  		return PTR_ERR(sdrt);
> > =20
> > -	if (sdrt->tRC_min < 30000)
> > +	if (conf->timings.mode > 3)
> >  		return -EOPNOTSUPP;
> > =20
> >  	if (chipnr =3D=3D NAND_DATA_IFACE_CHECK_ONLY) =20


Thanks,
Miqu=C3=A8l
