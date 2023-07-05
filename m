Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BEB2747DE2
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 09:07:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232102AbjGEHHM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 03:07:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231791AbjGEHHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 03:07:10 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15CA2E7B;
        Wed,  5 Jul 2023 00:07:07 -0700 (PDT)
X-GND-Sasl: miquel.raynal@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1688540826;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4xHf+sc8Y2BweoyFrc66CDtYOy0GEjOo0c54ioqoJxI=;
        b=L306DyHIWK20FJnSLQR5pvorUVvS/zh654OhhD6vOCmI8ePMnz+llp2KR/fphXBltNyn+5
        lFEhXDIeZJZ8fZZeZJEDo9E862qA9AuD1X/G24y3NAqAu9btqfxYQpkObA5qTQHOFW1GOZ
        a8eX0VnsAHl0lkp/g77Amu1NgIynFc26YkW1lRtr5N55DlU2U2RDPa+nTrSoD9LMoj/zij
        AGbo+S06vPKc9LAGopslFFhA1I1nPrKbu3CRRgB+3CiXwe5E2nY9wra1GoDYv+PBaqjx/3
        S4iiyiZHUd4MBo6w1XvoNTXT6WRKRG+Rl5uh6LK9j/+se8FSlTC72bl4XE8n+w==
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
X-GND-Sasl: miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E6318FF803;
        Wed,  5 Jul 2023 07:07:04 +0000 (UTC)
Date:   Wed, 5 Jul 2023 09:07:03 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Arseniy Krasnov <avkrasnov@sberdevices.ru>
Cc:     Liang Yang <liang.yang@amlogic.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        <oxffffaa@gmail.com>, <kernel@sberdevices.ru>,
        <linux-mtd@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] mtd: rawnand: meson: waiting w/o wired
 ready/busy pin
Message-ID: <20230705090703.15a59c37@xps-13>
In-Reply-To: <59246d83-7c4b-8b34-3173-71bdb698c2aa@sberdevices.ru>
References: <20230608044728.1328506-1-AVKrasnov@sberdevices.ru>
        <20230608044728.1328506-3-AVKrasnov@sberdevices.ru>
        <20230704144357.286281dc@xps-13>
        <47994f36-27d4-e5e4-73a9-6d4225671eec@sberdevices.ru>
        <20230704151220.67857861@xps-13>
        <73849b9c-0700-4946-84a2-428f98f0a6d6@sberdevices.ru>
        <59246d83-7c4b-8b34-3173-71bdb698c2aa@sberdevices.ru>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arseniy,

avkrasnov@sberdevices.ru wrote on Tue, 4 Jul 2023 20:32:13 +0300:

> On 04.07.2023 16:07, Arseniy Krasnov wrote:
> >=20
> >=20
> > On 04.07.2023 16:12, Miquel Raynal wrote: =20
> >> Hi Arseniy,
> >>
> >> avkrasnov@sberdevices.ru wrote on Tue, 4 Jul 2023 15:46:18 +0300:
> >> =20
> >>> On 04.07.2023 15:43, Miquel Raynal wrote: =20
> >>>> Hi Arseniy,
> >>>>
> >>>> AVKrasnov@sberdevices.ru wrote on Thu, 8 Jun 2023 07:47:28 +0300:
> >>>>    =20
> >>>>> If there is no wired ready/busy pin, classic way to wait for command
> >>>>> completion is to use function 'nand_soft_waitrdy()'. Meson NAND has
> >>>>> special command which allows to wait for NAND_STATUS_READY bit with=
out
> >>>>> reading status in a software loop (as 'nand_soft_waitrdy()' does). =
To
> >>>>> use it send this command along with NAND_CMD_STATUS, then wait for =
an
> >>>>> interrupt, and after interrupt send NAND_CMD_READ0. So this feature
> >>>>> allows to use interrupt driven waiting without wired ready/busy pin.
> >>>>>
> >>>>> Suggested-by: Liang Yang <liang.yang@amlogic.com>
> >>>>> Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
> >>>>> ---
> >>>>>  drivers/mtd/nand/raw/meson_nand.c | 77 +++++++++++++++++++++++++++=
++--
> >>>>>  1 file changed, 73 insertions(+), 4 deletions(-)
> >>>>>
> >>>>> diff --git a/drivers/mtd/nand/raw/meson_nand.c b/drivers/mtd/nand/r=
aw/meson_nand.c
> >>>>> index 074e14225c06..9f05e113b4ea 100644
> >>>>> --- a/drivers/mtd/nand/raw/meson_nand.c
> >>>>> +++ b/drivers/mtd/nand/raw/meson_nand.c
> >>>>> @@ -38,6 +38,7 @@
> >>>>>  #define NFC_CMD_SCRAMBLER_DISABLE	0
> >>>>>  #define NFC_CMD_SHORTMODE_DISABLE	0
> >>>>>  #define NFC_CMD_RB_INT		BIT(14)
> >>>>> +#define NFC_CMD_RB_INT_NO_PIN	((0xb << 10) | BIT(18) | BIT(16))
> >>>>> =20
> >>>>>  #define NFC_CMD_GET_SIZE(x)	(((x) >> 22) & GENMASK(4, 0))
> >>>>> =20
> >>>>> @@ -179,6 +180,7 @@ struct meson_nfc {
> >>>>>  	u32 info_bytes;
> >>>>> =20
> >>>>>  	unsigned long assigned_cs;
> >>>>> +	bool no_rb_pin;
> >>>>>  };
> >>>>> =20
> >>>>>  enum {
> >>>>> @@ -392,7 +394,42 @@ static void meson_nfc_set_data_oob(struct nand=
_chip *nand,
> >>>>>  	}
> >>>>>  }
> >>>>> =20
> >>>>> -static int meson_nfc_queue_rb(struct meson_nfc *nfc, int timeout_m=
s)
> >>>>> +static int meson_nfc_wait_no_rb_pin(struct meson_nfc *nfc, int tim=
eout_ms,
> >>>>> +				    bool need_cmd_read0)
> >>>>> +{
> >>>>> +	u32 cmd, cfg;
> >>>>> +
> >>>>> +	meson_nfc_cmd_idle(nfc, nfc->timing.twb);
> >>>>> +	meson_nfc_drain_cmd(nfc);
> >>>>> +	meson_nfc_wait_cmd_finish(nfc, CMD_FIFO_EMPTY_TIMEOUT);
> >>>>> +
> >>>>> +	cfg =3D readl(nfc->reg_base + NFC_REG_CFG);
> >>>>> +	cfg |=3D NFC_RB_IRQ_EN;
> >>>>> +	writel(cfg, nfc->reg_base + NFC_REG_CFG);
> >>>>> +
> >>>>> +	reinit_completion(&nfc->completion);
> >>>>> +	cmd =3D nfc->param.chip_select | NFC_CMD_CLE | NAND_CMD_STATUS;
> >>>>> +	writel(cmd, nfc->reg_base + NFC_REG_CMD);
> >>>>> +
> >>>>> +	/* use the max erase time as the maximum clock for waiting R/B */
> >>>>> +	cmd =3D NFC_CMD_RB | NFC_CMD_RB_INT_NO_PIN | nfc->timing.tbers_ma=
x;
> >>>>> +	writel(cmd, nfc->reg_base + NFC_REG_CMD);
> >>>>> +
> >>>>> +	if (!wait_for_completion_timeout(&nfc->completion,
> >>>>> +					 msecs_to_jiffies(timeout_ms)))
> >>>>> +		return -ETIMEDOUT;
> >>>>> +
> >>>>> +	if (need_cmd_read0) {
> >>>>> +		cmd =3D nfc->param.chip_select | NFC_CMD_CLE | NAND_CMD_READ0;
> >>>>> +		writel(cmd, nfc->reg_base + NFC_REG_CMD);
> >>>>> +		meson_nfc_drain_cmd(nfc);
> >>>>> +		meson_nfc_wait_cmd_finish(nfc, CMD_FIFO_EMPTY_TIMEOUT);
> >>>>> +	}   =20
> >>>>
> >>>> I forgot about this, you should avoid open coding core helpers, can =
you
> >>>> please send a followup patch to use nand_status_op() and
> >>>> nand_exit_status_op() ?   =20
> >>>
> >>> A ok, so:
> >>> 1) Sending NAND_CMD_STATUS goes to nand_status_op()
> >>> 2) Sending NAND_CMD_READ0 goes to nand_exit_status_op()
> >>>
> >>> Ok, no problem! I'll prepare and send it on this week! =20
> >>
> >> Exactly. Sorry I had this in mind but I likely forgot to write it
> >> down. =20
> >=20
> > Ok, got it! =20
>=20
> Hm, seems 'int nand_exit_status_op(struct nand_chip *chip)' is not export=
ed,
> so I can't use it in the Meson module. While 'nand_status_op()' works ok.
> May I can export 'nand_exit_status_op()?'

Yes, in a separate patch please.

>=20
> Thanks, Arseniy
>=20
>=20
> >=20
> > Thanks, Arseniy
> >  =20
> >>
> >> Thanks,
> >> Miqu=C3=A8l =20


Thanks,
Miqu=C3=A8l
