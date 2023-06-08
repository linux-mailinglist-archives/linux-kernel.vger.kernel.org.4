Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEE007277DE
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 08:55:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234003AbjFHGzH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 02:55:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234574AbjFHGzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 02:55:05 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7DCC198B
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 23:55:03 -0700 (PDT)
X-GND-Sasl: miquel.raynal@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1686207302;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WWXRdGGmZzI4Wh/27K2Er33T4VOE2lP1R5sKn6cAeUI=;
        b=cIHM8Ny2Ggz/XxrcksVYSha0jPw2RudbIikuhNwLP87L6c5T/dO0nLCnq7/t2dd4tuSSZx
        eH2FRbTb9fk0peNC1dTrsP3lXpOyrbMkcf3Pme0TXwZZBt133gJn2epruYfxUYYda/BwDx
        zd/LGcC3575sLCjmAbBWgWtywY5j/TJvgPMzaJqWNPHe1HBikwmVUod87l7q/qlZ0ojWMZ
        X9xIk5VKS2wletCOvV4fyyAxTwr7a8ab9nJgZ56+1uVRDUQ1jJ9poPf+PknDHj1VGYx/82
        2Wf6bLXhhSJ19RWZwTs6f0MGRspKwqM1D2rrru8YkiaD/q+hiCRcxEIYzaKrHQ==
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
Received: by mail.gandi.net (Postfix) with ESMTPSA id AE64BC0009;
        Thu,  8 Jun 2023 06:54:59 +0000 (UTC)
Date:   Thu, 8 Jun 2023 08:54:58 +0200
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
Message-ID: <20230608085458.449a24c0@xps-13>
In-Reply-To: <7903580d-685c-14e6-5572-81a4cb31cced@amlogic.com>
References: <20230606101644.3297859-1-AVKrasnov@sberdevices.ru>
        <9adef6da-5930-dcaa-f148-e4a398d39f2d@sberdevices.ru>
        <3a9470ed-d7ad-6cae-0d58-732399590272@sberdevices.ru>
        <7903580d-685c-14e6-5572-81a4cb31cced@amlogic.com>
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

Hi Liang,

liang.yang@amlogic.com wrote on Thu, 8 Jun 2023 14:42:53 +0800:

> Hi Arseniy,
>=20
> On 2023/6/8 5:17, Arseniy Krasnov wrote:
> > [ EXTERNAL EMAIL ]
> >=20
> > Hi again Miquel, Liang!
> >=20
> > What do You think about this patch?
> >=20
> > Thanks, Arseniy
> >=20
> > On 06.06.2023 19:29, Arseniy Krasnov wrote: =20
> >> Sorry, here is changelog:
> >> v1 -> v2:
> >> * Move checks from 'switch/case' which executes commands in 'meson_nfc=
_exec_op()' to a special
> >>    separated function 'meson_nfc_check_op()' which is called before co=
mmands processing.
> >>
> >> On 06.06.2023 13:16, Arseniy Krasnov wrote: =20
> >>> Meson NAND controller has limited buffer length, so check it before
> >>> command execution to avoid length trim. Also check MTD write size on
> >>> chip attach.
> >>>
> >>> Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
> >>> ---
> >>>   drivers/mtd/nand/raw/meson_nand.c | 47 +++++++++++++++++++++++++++-=
---
> >>>   1 file changed, 42 insertions(+), 5 deletions(-)
> >>>
> >>> diff --git a/drivers/mtd/nand/raw/meson_nand.c b/drivers/mtd/nand/raw=
/meson_nand.c
> >>> index 23a73268421b..db6b18753071 100644
> >>> --- a/drivers/mtd/nand/raw/meson_nand.c
> >>> +++ b/drivers/mtd/nand/raw/meson_nand.c
> >>> @@ -111,6 +111,8 @@
> >>>
> >>>   #define PER_INFO_BYTE               8
> >>>
> >>> +#define NFC_CMD_RAW_LEN     GENMASK(13, 0)
> >>> +
> >>>   struct meson_nfc_nand_chip {
> >>>       struct list_head node;
> >>>       struct nand_chip nand;
> >>> @@ -284,7 +286,7 @@ static void meson_nfc_cmd_access(struct nand_chip=
 *nand, int raw, bool dir,
> >>>
> >>>       if (raw) {
> >>>               len =3D mtd->writesize + mtd->oobsize;
> >>> -            cmd =3D (len & GENMASK(13, 0)) | scrambler | DMA_DIR(dir=
);
> >>> +            cmd =3D len | scrambler | DMA_DIR(dir);
> >>>               writel(cmd, nfc->reg_base + NFC_REG_CMD); =20
>=20
> I think we could keep "& GENMASK(13, 0)". it is better here to indicate h=
ow many bits of length in this command and don't destory the command once w=
e don't check the "len" outside of this function. or the code "if (len >  N=
FC_CMD_RAW_LEN)" is better to put inside this function nearly. Thanks.

It depends who calls this helper. If only used inside exec_op,
it's not useful. If used outside, then if you want to clarify
things you may want to use:

#define NFC_CMD_OP_LEN(cmd) FIELD_PREP(GENMASK(13, 0), (cmd))

This is by far my favorite construction. Could apply to many other
fields, like DMA_DIR, scrambler, etc.

> >>>               return;
> >>>       }
> >>> @@ -573,7 +575,7 @@ static int meson_nfc_read_buf(struct nand_chip *n=
and, u8 *buf, int len)
> >>>       if (ret)
> >>>               goto out;
> >>>
> >>> -    cmd =3D NFC_CMD_N2M | (len & GENMASK(13, 0));
> >>> +    cmd =3D NFC_CMD_N2M | len;
> >>>       writel(cmd, nfc->reg_base + NFC_REG_CMD);
> >>>
> >>>       meson_nfc_drain_cmd(nfc);
> >>> @@ -597,7 +599,7 @@ static int meson_nfc_write_buf(struct nand_chip *=
nand, u8 *buf, int len)
> >>>       if (ret)
> >>>               return ret;
> >>>
> >>> -    cmd =3D NFC_CMD_M2N | (len & GENMASK(13, 0));
> >>> +    cmd =3D NFC_CMD_M2N | len;
> >>>       writel(cmd, nfc->reg_base + NFC_REG_CMD);
> >>>
> >>>       meson_nfc_drain_cmd(nfc);
> >>> @@ -1007,6 +1009,31 @@ meson_nand_op_put_dma_safe_output_buf(const st=
ruct nand_op_instr *instr,
> >>>               kfree(buf);
> >>>   }
> >>>
> >>> +static int meson_nfc_check_op(struct nand_chip *chip,
> >>> +                          const struct nand_operation *op)
> >>> +{
> >>> +    int op_id;
> >>> +
> >>> +    for (op_id =3D 0; op_id < op->ninstrs; op_id++) {
> >>> +            const struct nand_op_instr *instr;
> >>> +
> >>> +            instr =3D &op->instrs[op_id];
> >>> +
> >>> +            switch (instr->type) {
> >>> +            case NAND_OP_DATA_IN_INSTR:
> >>> +            case NAND_OP_DATA_OUT_INSTR:
> >>> +                    if (instr->ctx.data.len > NFC_CMD_RAW_LEN)
> >>> +                            return -ENOTSUPP;
> >>> +
> >>> +                    break;
> >>> +            default:
> >>> +                    break;
> >>> +            }
> >>> +    }
> >>> +
> >>> +    return 0;
> >>> +}
> >>> +
> >>>   static int meson_nfc_exec_op(struct nand_chip *nand,
> >>>                            const struct nand_operation *op, bool chec=
k_only)
> >>>   {
> >>> @@ -1015,10 +1042,12 @@ static int meson_nfc_exec_op(struct nand_chip=
 *nand,
> >>>       const struct nand_op_instr *instr =3D NULL;
> >>>       void *buf;
> >>>       u32 op_id, delay_idle, cmd;
> >>> +    int err;
> >>>       int i;
> >>>
> >>> -    if (check_only)
> >>> -            return 0;
> >>> +    err =3D meson_nfc_check_op(nand, op);
> >>> +    if (err || check_only)
> >>> +            return err;
> >>>
> >>>       meson_nfc_select_chip(nand, op->cs);
> >>>       for (op_id =3D 0; op_id < op->ninstrs; op_id++) {
> >>> @@ -1293,6 +1322,7 @@ static int meson_nand_attach_chip(struct nand_c=
hip *nand)
> >>>       struct meson_nfc_nand_chip *meson_chip =3D to_meson_nand(nand);
> >>>       struct mtd_info *mtd =3D nand_to_mtd(nand);
> >>>       int nsectors =3D mtd->writesize / 1024;
> >>> +    int raw_writesize;
> >>>       int ret;
> >>>
> >>>       if (!mtd->name) {
> >>> @@ -1304,6 +1334,13 @@ static int meson_nand_attach_chip(struct nand_=
chip *nand)
> >>>                       return -ENOMEM;
> >>>       }
> >>>
> >>> +    raw_writesize =3D mtd->writesize + mtd->oobsize;
> >>> +    if (raw_writesize > NFC_CMD_RAW_LEN) {
> >>> +            dev_err(nfc->dev, "too big write size in raw mode: %d > =
%ld\n",
> >>> +                    raw_writesize, NFC_CMD_RAW_LEN);
> >>> +            return -EINVAL;
> >>> +    }
> >>> +
> >>>       if (nand->bbt_options & NAND_BBT_USE_FLASH)
> >>>               nand->bbt_options |=3D NAND_BBT_NO_OOB;
> >>> =20


Thanks,
Miqu=C3=A8l
