Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDC0F712BBF
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 19:27:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236875AbjEZR1k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 13:27:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbjEZR1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 13:27:38 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9818CF7;
        Fri, 26 May 2023 10:27:36 -0700 (PDT)
X-GND-Sasl: miquel.raynal@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1685122055;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sLLkkTARqYG2/kq9zm8hqhnR4AX8Ph/c88jn0yKAnqU=;
        b=j6AmoKuokt9TL+mjt11P5LSYrljI4dAEec4BwDJ6vF3J5DeiGOkx5kcRtPk4dBcV1Q5l0i
        uKGtfCsVvoD842m+YZ5yJXxCAlWb0/l9bSXIVd7Tn8YBNcKbBhoPOFdy4zk/wF19fFQ4Ix
        wCnpJh9Og2gf/56IaDe/wkAtqvTd0hTF2BEncqDhoU4LiIXOSgPNR8eNN9AOt0Evro1Xak
        y6GLycoh4ZHTY7pbaKunrX/+IvNuvthcRHGabMvvh6NnHaoqhGXw3fAKb4bU0C6N+dlKxW
        OFR2lzz3nxyl7WK9CqUV7umUJrhKyiiCec2QEDFpGxv4BEr0frzgVVLSQ9727A==
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 77D28C0003;
        Fri, 26 May 2023 17:27:34 +0000 (UTC)
Date:   Fri, 26 May 2023 19:27:33 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Md Sadre Alam <quic_mdalam@quicinc.com>
Cc:     <mani@kernel.org>, <richard@nod.at>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_srichara@quicinc.com>
Subject: Re: [PATCH v2 2/5] mtd: rawnand: qcom: Add support for reset,
 readid, status exec_op
Message-ID: <20230526192733.003b5293@xps-13>
In-Reply-To: <a92d2d3f-34b5-9cf1-ed40-1c812cbd0125@quicinc.com>
References: <20230511133017.6307-1-quic_mdalam@quicinc.com>
        <20230511133017.6307-3-quic_mdalam@quicinc.com>
        <20230522154507.0255d902@xps-13>
        <a92d2d3f-34b5-9cf1-ed40-1c812cbd0125@quicinc.com>
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

Hi Md,

quic_mdalam@quicinc.com wrote on Wed, 24 May 2023 14:54:34 +0530:

> On 5/22/2023 7:15 PM, Miquel Raynal wrote:
> > Hi Md,
> >=20
> > quic_mdalam@quicinc.com wrote on Thu, 11 May 2023 19:00:14 +0530:
> >  =20
> >> This change will add exec_ops support for RESET , READ_ID, STATUS
> >> command.
> >>
> >> Co-developed-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> >> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> >> Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
> >> ---
> >> Change in [v2]
> >>
> >> * Missed to post Cover-letter, so posting v2 patch with cover-letter
> >>
> >>   drivers/mtd/nand/raw/qcom_nandc.c | 166 ++++++++++++++++++++++++++++=
+-
> >>   1 file changed, 163 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/=
qcom_nandc.c
> >> index dae460e2aa0b..d2f2a8971907 100644
> >> --- a/drivers/mtd/nand/raw/qcom_nandc.c
> >> +++ b/drivers/mtd/nand/raw/qcom_nandc.c
> >> @@ -384,6 +384,9 @@ struct nandc_regs {
> >>    * @reg_read_pos:		marker for data read in reg_read_buf
> >>    *
> >>    * @cmd1/vld:			some fixed controller register values
> >> + *
> >> + * @exec_opwrite:		flag to select correct number of code word
> >> + *				while reading status
> >>    */
> >>   struct qcom_nand_controller {
> >>   	struct device *dev;
> >> @@ -434,6 +437,7 @@ struct qcom_nand_controller {
> >>   	int reg_read_pos; =20
> >>   >>   	u32 cmd1, vld; =20
> >> +	bool exec_opwrite;
> >>   }; =20
> >>   >>   /* =20
> >> @@ -2920,6 +2924,8 @@ static int qcom_op_cmd_mapping(struct qcom_nand_=
controller *nandc, u8 cmd,
> >>   		break;
> >>   	case NAND_CMD_PAGEPROG:
> >>   		ret =3D OP_PROGRAM_PAGE;
> >> +		q_op->flag =3D NAND_CMD_PAGEPROG; =20
> >=20
> > Just use the instruction value? =20
>=20
>    Sure , will fix this in next patch V3.
> >  =20
> >> +		nandc->exec_opwrite =3D true;
> >>   		break;
> >>   	default:
> >>   		break;
> >> @@ -2982,10 +2988,95 @@ static void qcom_parse_instructions(struct nan=
d_chip *chip,
> >>   	}
> >>   } =20
> >>   >> +static void qcom_delay_ns(unsigned int ns) =20
> >> +{
> >> +	if (!ns)
> >> +		return;
> >> +
> >> +	if (ns < 10000)
> >> +		ndelay(ns);
> >> +	else
> >> +		udelay(DIV_ROUND_UP(ns, 1000));
> >> +}
> >> +
> >> +static int qcom_wait_rdy_poll(struct nand_chip *chip, unsigned int ti=
me_ms)
> >> +{
> >> +	struct qcom_nand_controller *nandc =3D get_qcom_nand_controller(chip=
);
> >> +	unsigned long start =3D jiffies + msecs_to_jiffies(time_ms);
> >> +	u32 flash;
> >> +
> >> +	nandc_read_buffer_sync(nandc, true);
> >> +
> >> +	do {
> >> +		flash =3D le32_to_cpu(nandc->reg_read_buf[0]);
> >> +		if (flash & FS_READY_BSY_N)
> >> +			return 0;
> >> +		cpu_relax();
> >> +	} while (time_after(start, jiffies));
> >> +
> >> +	dev_err(nandc->dev, "Timeout waiting for device to be ready:0x%08x\n=
", flash);
> >> +
> >> +	return -ETIMEDOUT;
> >> +}
> >> +
> >>   static int qcom_read_status_exec(struct nand_chip *chip,
> >>   				 const struct nand_subop *subop)
> >>   {
> >> -	return 0;
> >> +	struct qcom_nand_host *host =3D to_qcom_nand_host(chip);
> >> +	struct qcom_nand_controller *nandc =3D get_qcom_nand_controller(chip=
);
> >> +	struct nand_ecc_ctrl *ecc =3D &chip->ecc;
> >> +	struct qcom_op q_op;
> >> +	const struct nand_op_instr *instr =3D NULL;
> >> +	unsigned int op_id =3D 0;
> >> +	unsigned int len =3D 0;
> >> +	int ret =3D 0, num_cw =3D 1, i;
> >> +	u32 flash_status;
> >> +
> >> +	host->status =3D NAND_STATUS_READY | NAND_STATUS_WP;
> >> +
> >> +	qcom_parse_instructions(chip, subop, &q_op);
> >> +
> >> +	if (nandc->exec_opwrite) { =20
> >=20
> > I definitely don't understand this flag at all. =20
>=20
>    This flag is to get the status for all code word in case of program pa=
ge operation.
>    Since this read status is common for reading status for all kind of op=
eration.
>    so in page program operation it needs to get status for all code word =
i.e 4 in 2K page.
>    but for normal operation number of code word will be 1.

Then you don't need that dark flag, just ask for a number of CW to
check. It will always be 1 unless you're in a page helper and want as
many CW as chunks.

> >  =20
> >> +		num_cw =3D ecc->steps;
> >> +		nandc->exec_opwrite =3D false;
> >> +	}
> >> +

Thanks,
Miqu=C3=A8l
