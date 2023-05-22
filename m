Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C3D870BFDE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 15:35:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233539AbjEVNfb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 09:35:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233477AbjEVNf0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 09:35:26 -0400
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 164EDC5;
        Mon, 22 May 2023 06:35:22 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id B8AD76000E;
        Mon, 22 May 2023 13:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1684762521;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=93QLYjBLzRenUZLy6HJ6kcMyZj1oFduVWd88cWEjx6k=;
        b=NAU+J4uoHF8i5jfYVq37IeXdmTrXNht4KZmDADuD+nGtm2X9dhj0tD/q2KSSGP7JCbQ0Vl
        dMbHUiBdsf3rRrqx4Ltkrq5PHfq+Sgv7ckl0ssKaEDqaqZrtmta+0PobyW5who27fZk3ui
        8jZcr6d98h7DiaZujxUsh34W584F+CKk1HbQhTUcYJxq/oRDVYr7FjNoqAsUnWXGHnXXhb
        8lezkmU+P/Tyrpu0Wthd6eD1LU1i8Rxh4cvqG6eLl7pfLtcge7px/ajvw/EVQDY4/S1KoD
        xoIJabGKpk4kGWV3KxSa/biM6oGHg+Cfk42NSgpQg3mr/lB3VkgUnDnNphaTjw==
Date:   Mon, 22 May 2023 15:35:19 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Md Sadre Alam <quic_mdalam@quicinc.com>
Cc:     mani@kernel.org, richard@nod.at, vigneshr@ti.com,
        linux-mtd@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_srichara@quicinc.com
Subject: Re: [PATCH v2 1/5] mtd: rawnand: qcom: Implement exec_op()
Message-ID: <20230522153519.6b574789@xps-13>
In-Reply-To: <20230511133017.6307-2-quic_mdalam@quicinc.com>
References: <20230511133017.6307-1-quic_mdalam@quicinc.com>
        <20230511133017.6307-2-quic_mdalam@quicinc.com>
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

Hello,

quic_mdalam@quicinc.com wrote on Thu, 11 May 2023 19:00:13 +0530:

> Implement exec_op() so we can later get rid of the legacy interface
> implementation.
>=20
> Co-developed-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
> ---
> Change in [v2]
>=20
> * Missed to post Cover-letter, so posting v2 patch with cover-letter
> =20
>  drivers/mtd/nand/raw/qcom_nandc.c | 214 +++++++++++++++++++++++++++++-
>  1 file changed, 213 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qco=
m_nandc.c
> index 72d6168d8a1b..dae460e2aa0b 100644
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
> @@ -235,6 +236,7 @@ nandc_set_reg(chip, reg,			\
>   */
>  #define NAND_ERASED_CW_SET		BIT(4)
> =20
> +#define MAX_ADDRESS_CYCLE		5
>  /*
>   * This data type corresponds to the BAM transaction which will be used =
for all
>   * NAND transfers.
> @@ -447,6 +449,29 @@ struct qcom_nand_boot_partition {
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
> @@ -1517,7 +1542,8 @@ static void pre_command(struct qcom_nand_host *host=
, int command)
>  	clear_read_regs(nandc);
> =20
>  	if (command =3D=3D NAND_CMD_RESET || command =3D=3D NAND_CMD_READID ||
> -	    command =3D=3D NAND_CMD_PARAM || command =3D=3D NAND_CMD_ERASE1)
> +	    command =3D=3D NAND_CMD_PARAM || command =3D=3D NAND_CMD_ERASE1 ||
> +	    command =3D=3D NAND_CMD_STATUS)

I don't like this much, is there another way to derive whether
clear_bam_transaction() is needed? What is the rationale behind it?

>  		clear_bam_transaction(nandc);
>  }
> =20
> @@ -2867,8 +2893,194 @@ static int qcom_nand_attach_chip(struct nand_chip=
 *chip)
>  	return 0;
>  }
> =20
> +static int qcom_op_cmd_mapping(struct qcom_nand_controller *nandc, u8 cm=
d,
> +			       struct qcom_op *q_op)
> +{
> +	int ret =3D 0;
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

This should error out and the error be catch in the check_only path.

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
> +			for (i =3D 0; i < min(5U, naddrs); i++) {

Is this min() useful? You already limit the number of cycles to 5,
otherwise the pattern won't match, right?

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
> +static int qcom_read_status_exec(struct nand_chip *chip,
> +				 const struct nand_subop *subop)
> +{
> +	return 0;
> +}
> +
> +static int qcom_erase_cmd_type_exec(struct nand_chip *chip, const struct=
 nand_subop *subop)
> +{
> +	return 0;
> +}
> +
> +static int qcom_param_page_type_exec(struct nand_chip *chip,  const stru=
ct nand_subop *subop)
> +{
> +	return 0;
> +}
> +
> +static int qcom_read_id_type_exec(struct nand_chip *chip, const struct n=
and_subop *subop)
> +{
> +	return 0;
> +}
> +
> +static int qcom_misc_cmd_type_exec(struct nand_chip *chip, const struct =
nand_subop *subop)
> +{
> +	return 0;
> +}
> +
> +static int qcom_data_read_type_exec(struct nand_chip *chip, const struct=
 nand_subop *subop)
> +{
> +	/* currently read_exec_op() return 0 , and all the read operation handl=
e in
> +	 * actual API itself
> +	 */
> +	return 0;

Please make all exec_op additions in the same patch, unless you're
truly adding a feature, in this case it can be split, but no pattern
should match what's unsupported by ->exec_op(). This way we avoid these
very strange (and wrong) empty functions).

> +}
> +
> +static int qcom_data_write_type_exec(struct nand_chip *chip, const struc=
t nand_subop *subop)
> +{
> +	/* currently write_exec_op() return 0, and all the write operation hand=
le in
> +	 * actual API itself
> +	 */
> +	struct qcom_op q_op;
> +
> +	qcom_parse_instructions(chip, subop, &q_op);
> +
> +	return 0;
> +}
> +
> +static const struct nand_op_parser qcom_op_parser =3D NAND_OP_PARSER(
> +		NAND_OP_PARSER_PATTERN(
> +			qcom_misc_cmd_type_exec,
> +			NAND_OP_PARSER_PAT_CMD_ELEM(false),
> +			NAND_OP_PARSER_PAT_WAITRDY_ELEM(false)),
> +		NAND_OP_PARSER_PATTERN(
> +			qcom_read_id_type_exec,
> +			NAND_OP_PARSER_PAT_CMD_ELEM(false),
> +			NAND_OP_PARSER_PAT_ADDR_ELEM(false, MAX_ADDRESS_CYCLE),
> +			NAND_OP_PARSER_PAT_DATA_IN_ELEM(false, 8)),
> +		NAND_OP_PARSER_PATTERN(
> +			qcom_param_page_type_exec,
> +			NAND_OP_PARSER_PAT_CMD_ELEM(false),
> +			NAND_OP_PARSER_PAT_ADDR_ELEM(false, MAX_ADDRESS_CYCLE),
> +			NAND_OP_PARSER_PAT_WAITRDY_ELEM(true),
> +			NAND_OP_PARSER_PAT_DATA_IN_ELEM(false, 512)),
> +		NAND_OP_PARSER_PATTERN(
> +			qcom_read_status_exec,
> +			NAND_OP_PARSER_PAT_CMD_ELEM(false),
> +			NAND_OP_PARSER_PAT_DATA_IN_ELEM(false, 1)),
> +		NAND_OP_PARSER_PATTERN(
> +			qcom_erase_cmd_type_exec,
> +			NAND_OP_PARSER_PAT_CMD_ELEM(false),
> +			NAND_OP_PARSER_PAT_ADDR_ELEM(false, MAX_ADDRESS_CYCLE),
> +			NAND_OP_PARSER_PAT_CMD_ELEM(false),
> +			NAND_OP_PARSER_PAT_WAITRDY_ELEM(false)),
> +		NAND_OP_PARSER_PATTERN(
> +			qcom_data_read_type_exec,
> +			NAND_OP_PARSER_PAT_CMD_ELEM(false),
> +			NAND_OP_PARSER_PAT_ADDR_ELEM(false, MAX_ADDRESS_CYCLE),
> +			NAND_OP_PARSER_PAT_CMD_ELEM(false),
> +			NAND_OP_PARSER_PAT_WAITRDY_ELEM(true),
> +			NAND_OP_PARSER_PAT_DATA_IN_ELEM(false, 2048)),
> +		NAND_OP_PARSER_PATTERN(
> +			qcom_data_write_type_exec,
> +			NAND_OP_PARSER_PAT_CMD_ELEM(true),
> +			NAND_OP_PARSER_PAT_ADDR_ELEM(true, MAX_ADDRESS_CYCLE)),
> +		);
> +
> +static int qcom_nand_exec_op(struct nand_chip *chip,
> +			     const struct nand_operation *op,
> +			bool check_only)
> +{
> +	if (check_only)
> +		return 0;

This is wrong, you cannot blindly return 0 if check_only is true.

> +	return nand_op_parser_exec_op(chip, &qcom_op_parser,
> +			op, check_only);
> +}
> +
>  static const struct nand_controller_ops qcom_nandc_ops =3D {
>  	.attach_chip =3D qcom_nand_attach_chip,
> +	.exec_op =3D qcom_nand_exec_op,
>  };
> =20
>  static void qcom_nandc_unalloc(struct qcom_nand_controller *nandc)


Thanks,
Miqu=C3=A8l
