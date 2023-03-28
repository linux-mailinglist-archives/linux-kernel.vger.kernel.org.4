Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FF616CB8D2
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 09:57:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232636AbjC1H4p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 03:56:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232572AbjC1H4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 03:56:43 -0400
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [IPv6:2001:4b98:dc4:8::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6206F358E
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 00:56:40 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id A5C92100008;
        Tue, 28 Mar 2023 07:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1679990198;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Zr1o5TB0Xj1P1dQ5QPlZqlhmW5d3VRuBkiP3EgOGwTw=;
        b=eioNhmkwx4o6qxydayUajT7JJJwg2Ee8Ma2qYzqPd+QNmP8g9tAgZz4ik0cEEHBl8+UqP4
        nC+GHT1SCbGQTUoQsVBBMOJmk7fhg1hhdesjsh6051Cu+nVKqAbLB31zo+M1ZRQeLQHeWV
        sg8dX/J26JIyt6+oYnh7PvEMJ+B88MbdLMeajQBazRAZgsl7/PpcUkL+xmm23Pxxsa3TBj
        4RcYNJaouNTjqxqIOv7HmXQIAfwXKE+dNbadr6pOjmq5iZBas/HHdIColfTxL2ki9dMmIV
        W1Mxht/dvCOmphpl0p4u2J0dgEm1j7bCVIFbpUuTDE00euphHMYAnuNAAQSMsA==
Date:   Tue, 28 Mar 2023 09:56:33 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Christophe Kerello <christophe.kerello@foss.st.com>
Cc:     Tudor Ambarus <tudor.ambarus@linaro.org>, <richard@nod.at>,
        <vigneshr@ti.com>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: Re: [PATCH v2 2/2] mtd: rawnand: stm32_fmc2: use timings.mode
 instead of checking tRC_min
Message-ID: <20230328095633.188aff27@xps-13>
In-Reply-To: <6759a843-409b-d9fe-8a00-ed6d69144aaf@foss.st.com>
References: <20230327094742.38856-1-christophe.kerello@foss.st.com>
        <20230327094742.38856-3-christophe.kerello@foss.st.com>
        <75dcd205-5432-7103-370c-d65d792631ea@linaro.org>
        <20230327124313.1ccd3d66@xps-13>
        <70d0a8b6-62c2-fa3e-df5c-f86ba75484d0@linaro.org>
        <6759a843-409b-d9fe-8a00-ed6d69144aaf@foss.st.com>
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

Hi Christophe,

christophe.kerello@foss.st.com wrote on Tue, 28 Mar 2023 09:27:55 +0200:

> Hello Miquel,
>=20
> On 3/27/23 13:06, Tudor Ambarus wrote:
> >=20
> >=20
> > On 3/27/23 11:43, Miquel Raynal wrote: =20
> >> Hi Tudor,
> >>
> >> tudor.ambarus@linaro.org wrote on Mon, 27 Mar 2023 11:30:51 +0100:
> >> =20
> >>> On 3/27/23 10:47, Christophe Kerello wrote: =20
> >>>> This patch is using timings.mode value instead of checking tRC_min t=
iming
> >>>> for EDO mode support. =20
> >>>>    >>> =20
> >>> Fixes and Cc to stable here too, as you'd like to have this backported
> >>> as well, don't you? =20
> >>
> >> Actually the reason why Christophe split this into two patches is
> >> because timings.mode was introduced rather lately, he wanted the same
> >> patch to apply on all stable kernels, he actually asked for that split
> >> and I agreed (another solution would have been to send this current
> >> patch to Linus and have the other version sent to stable, but it
> >> requires a bit of scheduling on both ends).
> >>
> >> Link: https://lore.kernel.org/linux-mtd/20230327101156.0ec2816a@xps-13=
/T/#t =20
> >=20
> > Right, I understood that from the beginning. If it were to me, I would
> > Cc: stable@vger.kernel.org #v5.4+ for the first patch and
> > Cc: stable@vger.kernel.org #v5.10+ for the second.
> >=20
> > So first would be alone just in v5.4, and starting with v5.10 we'll have
> > both and we'll mimic what we currently have in upstream mainline.
> >  =20
>=20
> I can send a V3 with cc tag added as per Tudor's suggestion.
> Or cc tag will be added when the patches will be applied?

I'll handle it, no problem. Is it fine if I send this as part of the
next merge window or do you expect this fix to be applied earlier? I
just sent my fixes PR on Monday morning.

>=20
> Regards,
> Christophe Kerello.
>=20
> >> =20
> >>> =20
> >>>> Signed-off-by: Christophe Kerello <christophe.kerello@foss.st.com> =
=20
> >>>
> >>> Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> >>> =20
> >>>> ---
> >>>>   drivers/mtd/nand/raw/stm32_fmc2_nand.c | 2 +-
> >>>>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/drivers/mtd/nand/raw/stm32_fmc2_nand.c b/drivers/mtd/na=
nd/raw/stm32_fmc2_nand.c
> >>>> index 3abb63d00a0b..9e74bcd90aaa 100644
> >>>> --- a/drivers/mtd/nand/raw/stm32_fmc2_nand.c
> >>>> +++ b/drivers/mtd/nand/raw/stm32_fmc2_nand.c
> >>>> @@ -1531,7 +1531,7 @@ static int stm32_fmc2_nfc_setup_interface(stru=
ct nand_chip *chip, int chipnr,
> >>>>   	if (IS_ERR(sdrt))
> >>>>   		return PTR_ERR(sdrt); =20
> >>>>   >>>> -	if (sdrt->tRC_min < 30000) =20
> >>>> +	if (conf->timings.mode > 3)
> >>>>   		return -EOPNOTSUPP; =20
> >>>>   >>>>   	if (chipnr =3D=3D NAND_DATA_IFACE_CHECK_ONLY) =20
> >>
> >>
> >> Thanks,
> >> Miqu=C3=A8l =20


Thanks,
Miqu=C3=A8l
