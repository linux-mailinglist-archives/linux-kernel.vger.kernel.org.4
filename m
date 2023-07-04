Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E3A7747470
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 16:51:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231810AbjGDOu7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 10:50:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjGDOu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 10:50:58 -0400
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DFB710D3;
        Tue,  4 Jul 2023 07:50:55 -0700 (PDT)
X-GND-Sasl: miquel.raynal@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1688482254;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hAa7biTsEED7+TVhihDfqMHafKwUs8+5OXhvg/ElE2s=;
        b=YWOIxp7ej0lyjKKecyJ5g5EpkiQ0RanVWn9ynveagXeTCSCdxEuVU/rrz47+vjlr/C4fO4
        LZkvdu37RdsbaAdhsVevTFxHZK8bo7b7lD9/Hm/caoZ9Ehz+Frww2+kVM7rcfY08vaOlm7
        b+ttbprF9qH/WPTgxsZRu6mm99WoTttwdLn4FIHfJQzMhjm5Ft7fiEGiw7DhHOjc3vsZH6
        gSUC071MEX+YTN7N93yDZsvXZg6/35YCLq3cYnUOca/l5yWXBI7ul9BQtx+YctOCC8PWak
        X4nKtlA8XpKpm6IbFy0GX63yH23yAOMomYH4WfaHP4HjpWpGPQ2OplFXxfylQQ==
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 331CB2000B;
        Tue,  4 Jul 2023 14:50:53 +0000 (UTC)
Date:   Tue, 4 Jul 2023 16:50:52 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Md Sadre Alam <quic_mdalam@quicinc.com>
Cc:     mani@kernel.org, richard@nod.at, vigneshr@ti.com,
        linux-mtd@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_srichara@quicinc.com
Subject: Re: [PATCH v4 1/5] mtd: rawnand: qcom: Implement exec_op()
Message-ID: <20230704165052.30039969@xps-13>
In-Reply-To: <20230615073143.25079-1-quic_mdalam@quicinc.com>
References: <20230615073143.25079-1-quic_mdalam@quicinc.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

quic_mdalam@quicinc.com wrote on Thu, 15 Jun 2023 13:01:39 +0530:

> Implement exec_op() so we can later get rid of the legacy interface
> implementation.
>=20
> Co-developed-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
> ---
> Change in [v4]
>=20
> * No change for this patch, since this is part of exec_op
>   series posting new patch.
>=20
> Change in [v3]
>=20
> * Removed NAND_CMD_STATUS check in pre_command and move
>   it to status exec_op.
>=20
> * Removed min() , since this check not needed
>=20
> * Removed all the dummy APIs of exec_ops, and added it
>   into same patch where its getting added.
>=20
> * Added qcom_check_op() API to check for unsupported feature
>   by controller in check_only path.
>=20
> Change in [v2]
>=20
> * Missed to post Cover-letter, so posting v2 patch with cover-letter
>=20
> Change in [v1]
>=20
> * Added initial support for exec_ops.
>=20
>  drivers/mtd/nand/raw/qcom_nandc.c | 159 ++++++++++++++++++++++++++++++
>  1 file changed, 159 insertions(+)
>=20
> diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qco=
m_nandc.c
> index 72d6168d8a1b..d9c4c9fe2fe8 100644
> --- a/drivers/mtd/nand/raw/qcom_nandc.c
> +++ b/drivers/mtd/nand/raw/qcom_nandc.c
> @@ -157,6 +157,7 @@
>  #define	OP_PAGE_PROGRAM_WITH_ECC	0x7
>  #define	OP_PROGRAM_PAGE_SPARE		0x9
>  #define	OP_BLOCK_ERASE			0xa
> +#define	OP_CHECK_STATUS			0xc
>  #define	OP_FETCH_ID			0xb
>  #define	OP_RESET_DEVICE			0xd
> =20
> @@ -235,6 +236,8 @@ nandc_set_reg(chip, reg,			\
>   */
>  #define NAND_ERASED_CW_SET		BIT(4)
> =20
> +#define MAX_ADDRESS_CYCLE		5
> +#define MAX_CHUNK_SIZE			SZ_8K

New line.

>  /*
>   * This data type corresponds to the BAM transaction which will be used =
for all
>   * NAND transfers.
> @@ -447,6 +450,29 @@ struct qcom_nand_boot_partition {
>  	u32 page_size;
>  };
> =20
> +/*
> + * Qcom op for each exec_op transfer
> + *
> + * @data_instr:			data instruction pointer
> + * @data_instr_idx:		data instruction index
> + * @rdy_timeout_ms:		wait ready timeout in ms
> + * @rdy_delay_ns:		Additional delay in ns
> + * @addr1_reg:			Address1 register value
> + * @addr2_reg:			Address2 register value
> + * @cmd_reg:			CMD register value
> + * @flag:			flag for misc instruction
> + */
> +struct qcom_op {
> +	const struct nand_op_instr *data_instr;
> +	unsigned int data_instr_idx;
> +	unsigned int rdy_timeout_ms;
> +	unsigned int rdy_delay_ns;
> +	u32 addr1_reg;
> +	u32 addr2_reg;
> +	u32 cmd_reg;
> +	u8 flag;
> +};
> +
>  /*
>   * NAND chip structure
>   *
> @@ -2867,8 +2893,141 @@ static int qcom_nand_attach_chip(struct nand_chip=
 *chip)
>  	return 0;
>  }
> =20
> +static int qcom_op_cmd_mapping(struct qcom_nand_controller *nandc, u8 cm=
d,
> +			       struct qcom_op *q_op)
> +{
> +	int ret;
> +
> +	switch (cmd) {
> +	case NAND_CMD_RESET:
> +		ret =3D OP_RESET_DEVICE;
> +		break;
> +	case NAND_CMD_READID:
> +		ret =3D OP_FETCH_ID;
> +		break;
> +	case NAND_CMD_PARAM:
> +		if (nandc->props->qpic_v2)
> +			ret =3D OP_PAGE_READ_ONFI_READ;
> +		else
> +			ret =3D OP_PAGE_READ;
> +		break;
> +	case NAND_CMD_ERASE1:
> +	case NAND_CMD_ERASE2:
> +		ret =3D OP_BLOCK_ERASE;
> +		break;
> +	case NAND_CMD_STATUS:
> +		ret =3D OP_CHECK_STATUS;
> +		break;
> +	case NAND_CMD_PAGEPROG:
> +		ret =3D OP_PROGRAM_PAGE;
> +		break;
> +	default:

Again, this is not a supported case, you should handle it. And this
must be checked upon check_only conditions as well.

> +		break;
> +	}
> +
> +	return ret;
> +}
> +
> +/* NAND framework ->exec_op() hooks and related helpers */
> +static void qcom_parse_instructions(struct nand_chip *chip,
> +				    const struct nand_subop *subop,
> +					struct qcom_op *q_op)
> +{
> +	struct qcom_nand_controller *nandc =3D get_qcom_nand_controller(chip);
> +	const struct nand_op_instr *instr =3D NULL;
> +	unsigned int op_id;
> +	int i;
> +
> +	memset(q_op, 0, sizeof(*q_op));
> +
> +	for (op_id =3D 0; op_id < subop->ninstrs; op_id++) {
> +		unsigned int offset, naddrs;
> +		const u8 *addrs;
> +
> +		instr =3D &subop->instrs[op_id];
> +
> +		switch (instr->type) {
> +		case NAND_OP_CMD_INSTR:
> +			q_op->cmd_reg =3D qcom_op_cmd_mapping(nandc, instr->ctx.cmd.opcode, q=
_op);
> +			q_op->rdy_delay_ns =3D instr->delay_ns;
> +			break;
> +
> +		case NAND_OP_ADDR_INSTR:
> +			offset =3D nand_subop_get_addr_start_off(subop, op_id);
> +			naddrs =3D nand_subop_get_num_addr_cyc(subop, op_id);
> +			addrs =3D &instr->ctx.addr.addrs[offset];
> +			for (i =3D 0; i < MAX_ADDRESS_CYCLE; i++) {
> +				if (i < 4)
> +					q_op->addr1_reg |=3D (u32)addrs[i] << i * 8;
> +				else
> +					q_op->addr2_reg |=3D addrs[i];
> +			}
> +			q_op->rdy_delay_ns =3D instr->delay_ns;
> +			break;
> +
> +		case NAND_OP_DATA_IN_INSTR:
> +			q_op->data_instr =3D instr;
> +			q_op->data_instr_idx =3D op_id;
> +			q_op->rdy_delay_ns =3D instr->delay_ns;
> +			fallthrough;
> +		case NAND_OP_DATA_OUT_INSTR:
> +			q_op->rdy_delay_ns =3D instr->delay_ns;
> +			break;
> +
> +		case NAND_OP_WAITRDY_INSTR:
> +			q_op->rdy_timeout_ms =3D instr->ctx.waitrdy.timeout_ms;
> +			q_op->rdy_delay_ns =3D instr->delay_ns;
> +			break;
> +		}
> +	}
> +}
> +
> +static int qcom_check_op(struct nand_chip *chip,
> +			 const struct nand_operation *op)
> +{
> +	const struct nand_op_instr *instr;
> +	int op_id;
> +
> +	for (op_id =3D 0; op_id < op->ninstrs; op_id++) {
> +		instr =3D &op->instrs[op_id];
> +
> +		switch (instr->type) {
> +		case NAND_OP_CMD_INSTR:
> +			if (instr->ctx.cmd.opcode =3D=3D NAND_CMD_READCACHESEQ ||
> +			    instr->ctx.cmd.opcode =3D=3D NAND_CMD_READCACHEEND)
> +				return -ENOTSUPP;

Do you really need this check? These operations have specific pattern,
no? I believe you should not need this check.
> +			break;
> +		case NAND_OP_ADDR_INSTR:
> +			if (instr->ctx.addr.naddrs > MAX_ADDRESS_CYCLE)
> +				return -ENOTSUPP;

This one is not needed either, as long as you properly define the
patterns.

> +
> +			break;
> +		case NAND_OP_DATA_IN_INSTR:
> +		case NAND_OP_DATA_OUT_INSTR:
> +			if (instr->ctx.data.len > MAX_CHUNK_SIZE)

Same.
> +				return -ENOTSUPP;
> +			break;
> +		default:
> +			break;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static int qcom_nand_exec_op(struct nand_chip *chip,
> +			     const struct nand_operation *op,
> +			bool check_only)
> +{
> +	if (check_only)
> +		return qcom_check_op(chip, op);
> +
> +	return 0;
> +}
> +
>  static const struct nand_controller_ops qcom_nandc_ops =3D {
>  	.attach_chip =3D qcom_nand_attach_chip,
> +	.exec_op =3D qcom_nand_exec_op,

I understand the idea of making the series easier to review, and I
thank you for that, but in practice the series is not bisectable. I
doubt the driver works right after patch 1.

You will likely need two patches, one to add exec_op, one to remove the
legacy implementation.

>  };
> =20
>  static void qcom_nandc_unalloc(struct qcom_nand_controller *nandc)


Thanks,
Miqu=C3=A8l
