Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48CB172812B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 15:21:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236314AbjFHNVd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 09:21:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236402AbjFHNVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 09:21:21 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F02071BD6
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 06:21:18 -0700 (PDT)
X-GND-Sasl: miquel.raynal@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1686230477;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9Lo1sqW665OmQu1ENY3kkmv19RpKne/RRcU8PBoQrig=;
        b=TqAp1+S/CkTMibHiSxtGThtl3IQmfO6Tgset4bbWurxsfM4WVmnONx50sA3oty7hPI23s2
        5t12zUJue4WQkw95/FJ7R9t7KHDNdE3GSKcPWV51UbciU+u7thGnjMkxlQZ8A6PD6+67rN
        g1Sll4okQxtHkCpmjiMsJBlne69H6MAxVfbWSqseVviCQTGIM0eHhAttIW6Yda+rBqmIm5
        QhOxJo72F3MoHyTQXKKmCtJXgra/vXeUqArKEg6kTttslYkVhKbJMFOOzftVIUx/7jsVRF
        88rAv8dLWnU65Aki+BfC9HXq2MM2lyWnKc90l8k4STovPhGMjs3RD4i+KyWKHw==
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
Received: by mail.gandi.net (Postfix) with ESMTPSA id 64410E000C;
        Thu,  8 Jun 2023 13:21:15 +0000 (UTC)
Date:   Thu, 8 Jun 2023 15:21:14 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Liang Yang <liang.yang@amlogic.com>
Cc:     Arseniy Krasnov <avkrasnov@sberdevices.ru>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        oxffffaa@gmail.com, kernel@sberdevices.ru,
        linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mtd: rawnand: meson: check buffer length
Message-ID: <20230608152114.3a1d82ac@xps-13>
In-Reply-To: <a6a20b50-02b0-53c0-1e65-75035bc59c87@amlogic.com>
References: <20230606101644.3297859-1-AVKrasnov@sberdevices.ru>
        <9adef6da-5930-dcaa-f148-e4a398d39f2d@sberdevices.ru>
        <3a9470ed-d7ad-6cae-0d58-732399590272@sberdevices.ru>
        <7903580d-685c-14e6-5572-81a4cb31cced@amlogic.com>
        <20230608085458.449a24c0@xps-13>
        <4e6cd8a8-f618-4bc3-5fa9-eab2b501dd89@amlogic.com>
        <a6a20b50-02b0-53c0-1e65-75035bc59c87@amlogic.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Liang,

liang.yang@amlogic.com wrote on Thu, 8 Jun 2023 20:37:14 +0800:

> Hi Arseniy and Miquel,
>=20
> On 2023/6/8 15:12, Liang Yang wrote:
> > Hi Miquel,
> >=20
> > On 2023/6/8 14:54, Miquel Raynal wrote: =20
> >> [ EXTERNAL EMAIL ]
> >>
> >> Hi Liang,
> >>
> >> liang.yang@amlogic.com wrote on Thu, 8 Jun 2023 14:42:53 +0800:
> >> =20
> >>> Hi Arseniy,
> >>>
> >>> On 2023/6/8 5:17, Arseniy Krasnov wrote: =20
> >>>> [ EXTERNAL EMAIL ]
> >>>>
> >>>> Hi again Miquel, Liang!
> >>>>
> >>>> What do You think about this patch?
> >>>>
> >>>> Thanks, Arseniy
> >>>>
> >>>> On 06.06.2023 19:29, Arseniy Krasnov wrote: =20
> >>>>> Sorry, here is changelog:
> >>>>> v1 -> v2:
> >>>>> * Move checks from 'switch/case' which executes commands in >>>>> '=
meson_nfc_exec_op()' to a special
> >>>>> =C2=A0=C2=A0=C2=A0 separated function 'meson_nfc_check_op()' which =
is called >>>>> before commands processing.
> >>>>>
> >>>>> On 06.06.2023 13:16, Arseniy Krasnov wrote: =20
> >>>>>> Meson NAND controller has limited buffer length, so check it before
> >>>>>> command execution to avoid length trim. Also check MTD write size =
on
> >>>>>> chip attach.
> >>>>>>
> >>>>>> Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
> >>>>>> ---
> >>>>>> =C2=A0=C2=A0 drivers/mtd/nand/raw/meson_nand.c | 47 >>>>>> +++++++=
++++++++++++++++++++----
> >>>>>> =C2=A0=C2=A0 1 file changed, 42 insertions(+), 5 deletions(-)
> >>>>>>
> >>>>>> diff --git a/drivers/mtd/nand/raw/meson_nand.c >>>>>> b/drivers/mt=
d/nand/raw/meson_nand.c
> >>>>>> index 23a73268421b..db6b18753071 100644
> >>>>>> --- a/drivers/mtd/nand/raw/meson_nand.c
> >>>>>> +++ b/drivers/mtd/nand/raw/meson_nand.c
> >>>>>> @@ -111,6 +111,8 @@
> >>>>>>
> >>>>>> =C2=A0=C2=A0 #define PER_INFO_BYTE=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 8
> >>>>>>
> >>>>>> +#define NFC_CMD_RAW_LEN=C2=A0=C2=A0=C2=A0=C2=A0 GENMASK(13, 0)
> >>>>>> +
> >>>>>> =C2=A0=C2=A0 struct meson_nfc_nand_chip {
> >>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct list_head node;
> >>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct nand_chip nand;
> >>>>>> @@ -284,7 +286,7 @@ static void meson_nfc_cmd_access(struct >>>>>>=
 nand_chip *nand, int raw, bool dir,
> >>>>>>
> >>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (raw) {
> >>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 len =3D mtd->writesize + mtd->oobsize;
> >>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 cmd =3D (len & GENMASK(13, 0)) | scrambler | DMA_DIR(dir);
> >>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 cmd =3D len | scrambler | DMA_DIR(dir);
> >>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 writel(cmd, nfc->reg_base + NFC_REG_CMD); =20
> >>>
> >>> I think we could keep "& GENMASK(13, 0)". it is better here to >>> in=
dicate how many bits of length in this command and don't destory >>> the co=
mmand once we don't check the "len" outside of this function. >>> or the co=
de "if (len >=C2=A0 NFC_CMD_RAW_LEN)" is better to put inside >>> this func=
tion nearly. Thanks. =20
> >>
> >> It depends who calls this helper. If only used inside >> exec_op,write=
_page_raw() and read_page_raw() also call >> meson_nfc_cmd_access(), > but =
i don't find where constrain the "len". =20
>=20
> Is the helper "meson_nfc_check_op()" needed by exec_op() after the constr=
aint in attach_chip()? the length passed in exec_op() seems smaller than "m=
td->writesize + mtd->oobsize" now.

exec_op() is primarily dedicated to performing side commands than page
accesses, typically the parameter page is X bytes, you might want to
read it 3 times, depending on the capabilities of the controller, you
might need to split the operation or not, so the core checks what are
the controller capabilities before doing the operation. So yes, the
check_op() thing is necessary.

>=20
> @Arseniy if it does need, I think the same constraint is needed by
> "meson_nfc_cmd_access()"
>=20
> >  =20
> >> it's not useful. If used outside, then if you want to clarify
> >> things you may want to use:
> >>
> >> #define NFC_CMD_OP_LEN(cmd) FIELD_PREP(GENMASK(13, 0), (cmd))
> >>
> >> This is by far my favorite construction. Could apply to many other
> >> fields, like DMA_DIR, scrambler, etc. =20
>=20
> @Miquel, FIELD_PREP() is better, but i have no idea whether we should add=
 FIELD_PREP() in this patch, or keep the previous code.
>=20
> >> =20
> >>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 return;
> >>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> >>>>>> @@ -573,7 +575,7 @@ static int meson_nfc_read_buf(struct nand_chip=
 >>>>>> *nand, u8 *buf, int len)
> >>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret)
> >>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 goto out;
> >>>>>>
> >>>>>> -=C2=A0=C2=A0=C2=A0 cmd =3D NFC_CMD_N2M | (len & GENMASK(13, 0));
> >>>>>> +=C2=A0=C2=A0=C2=A0 cmd =3D NFC_CMD_N2M | len;
> >>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 writel(cmd, nfc->reg_base + N=
FC_REG_CMD);
> >>>>>>
> >>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 meson_nfc_drain_cmd(nfc);
> >>>>>> @@ -597,7 +599,7 @@ static int meson_nfc_write_buf(struct >>>>>> n=
and_chip *nand, u8 *buf, int len)
> >>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret)
> >>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 return ret;
> >>>>>>
> >>>>>> -=C2=A0=C2=A0=C2=A0 cmd =3D NFC_CMD_M2N | (len & GENMASK(13, 0));
> >>>>>> +=C2=A0=C2=A0=C2=A0 cmd =3D NFC_CMD_M2N | len;
> >>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 writel(cmd, nfc->reg_base + N=
FC_REG_CMD);
> >>>>>>
> >>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 meson_nfc_drain_cmd(nfc);
> >>>>>> @@ -1007,6 +1009,31 @@ meson_nand_op_put_dma_safe_output_buf(const=
 >>>>>> struct nand_op_instr *instr,
> >>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 kfree(buf);
> >>>>>> =C2=A0=C2=A0 }
> >>>>>>
> >>>>>> +static int meson_nfc_check_op(struct nand_chip *chip,
> >>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 const struct nand_operation *op)
> >>>>>> +{
> >>>>>> +=C2=A0=C2=A0=C2=A0 int op_id;
> >>>>>> +
> >>>>>> +=C2=A0=C2=A0=C2=A0 for (op_id =3D 0; op_id < op->ninstrs; op_id++=
) {
> >>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 const struct nand_op_instr *instr;
> >>>>>> +
> >>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 instr =3D &op->instrs[op_id];
> >>>>>> +
> >>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 switch (instr->type) {
> >>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 case NAND_OP_DATA_IN_INSTR:
> >>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 case NAND_OP_DATA_OUT_INSTR:
> >>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (instr->ctx.data.len=
 > NFC_CMD_RAW_LEN)
> >>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 return -ENOTSUPP;
> >>>>>> +
> >>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
> >>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 default:
> >>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
> >>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 }
> >>>>>> +=C2=A0=C2=A0=C2=A0 }
> >>>>>> +
> >>>>>> +=C2=A0=C2=A0=C2=A0 return 0;
> >>>>>> +}
> >>>>>> +
> >>>>>> =C2=A0=C2=A0 static int meson_nfc_exec_op(struct nand_chip *nand,
> >>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 const struct nand_operation *op, bool >>>>>> check_on=
ly)
> >>>>>> =C2=A0=C2=A0 {
> >>>>>> @@ -1015,10 +1042,12 @@ static int meson_nfc_exec_op(struct >>>>>>=
 nand_chip *nand,
> >>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const struct nand_op_instr *i=
nstr =3D NULL;
> >>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 void *buf;
> >>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u32 op_id, delay_idle, cmd;
> >>>>>> +=C2=A0=C2=A0=C2=A0 int err;
> >>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int i;
> >>>>>>
> >>>>>> -=C2=A0=C2=A0=C2=A0 if (check_only)
> >>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 return 0;
> >>>>>> +=C2=A0=C2=A0=C2=A0 err =3D meson_nfc_check_op(nand, op);
> >>>>>> +=C2=A0=C2=A0=C2=A0 if (err || check_only)
> >>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 return err;
> >>>>>>
> >>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 meson_nfc_select_chip(nand, o=
p->cs);
> >>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for (op_id =3D 0; op_id < op-=
>ninstrs; op_id++) {
> >>>>>> @@ -1293,6 +1322,7 @@ static int meson_nand_attach_chip(struct >>>=
>>> nand_chip *nand)
> >>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct meson_nfc_nand_chip *m=
eson_chip =3D to_meson_nand(nand);
> >>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct mtd_info *mtd =3D nand=
_to_mtd(nand);
> >>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int nsectors =3D mtd->writesi=
ze / 1024;
> >>>>>> +=C2=A0=C2=A0=C2=A0 int raw_writesize;
> >>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int ret;
> >>>>>>
> >>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!mtd->name) {
> >>>>>> @@ -1304,6 +1334,13 @@ static int meson_nand_attach_chip(struct >>=
>>>> nand_chip *nand)
> >>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -=
ENOMEM;
> >>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> >>>>>>
> >>>>>> +=C2=A0=C2=A0=C2=A0 raw_writesize =3D mtd->writesize + mtd->oobsiz=
e;
> >>>>>> +=C2=A0=C2=A0=C2=A0 if (raw_writesize > NFC_CMD_RAW_LEN) {
> >>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 dev_err(nfc->dev, "too big write size in raw mode: %d >>>>>> > %ld\n",
> >>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 raw_writesize, NFC_CMD_=
RAW_LEN);
> >>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 return -EINVAL;
> >>>>>> +=C2=A0=C2=A0=C2=A0 }
> >>>>>> +
> >>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (nand->bbt_options & NAND_=
BBT_USE_FLASH)
> >>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 nand->bbt_options |=3D NAND_BBT_NO_OOB;
> >>>>>> =20
> >>
> >>
> >> Thanks,
> >> Miqu=C3=A8l =20


Thanks,
Miqu=C3=A8l
