Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FDF77281EA
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 15:58:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235942AbjFHN6f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 09:58:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236571AbjFHN6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 09:58:34 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B1AA271D;
        Thu,  8 Jun 2023 06:58:22 -0700 (PDT)
X-GND-Sasl: miquel.raynal@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1686232700;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hu8WQ6UxuPnSUFTYE06bY2rD6OPC19JmrSL9FS3lZP8=;
        b=ijN72V67HxZX7oEwK58MjxHVsz/n5DfhRoMMT4rsCE560/wxNabK0bKLdE1VrvgQlA6kT2
        9ufa43OnBSXpq4pHC973875hhk9oYeKFxRzj8DwUQL/ZowyleCg7nOGRBGnqjH04/6GrU8
        px5ZqblwqeByLxrW0adXfdhKAoZ/L0RLHyVTZxL3/wx10RqtPNh3/OmEb5A6hQ4ygjgDJ6
        HJfTAnVXDRCYtDz85/leEjizJceMfbT0wA5ghj3FoTyNYa3weWKtjrYa12OgwkyzUh0K0n
        q7JTlm6CKLn4Tsdtm3W9uslfz5COEA2fV2yxsFIMW6iBHcC3fXkLiwpLhHBH1g==
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1B9C1E0011;
        Thu,  8 Jun 2023 13:58:19 +0000 (UTC)
Date:   Thu, 8 Jun 2023 15:58:19 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Md Sadre Alam <quic_mdalam@quicinc.com>
Cc:     mani@kernel.org, richard@nod.at, vigneshr@ti.com,
        linux-mtd@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_srichara@quicinc.com
Subject: Re: [PATCH v3 2/5] mtd: rawnand: qcom: Add support for reset,
 readid, status exec_op
Message-ID: <20230608155819.4b1e4276@xps-13>
In-Reply-To: <20230531124953.21007-2-quic_mdalam@quicinc.com>
References: <20230531124953.21007-1-quic_mdalam@quicinc.com>
        <20230531124953.21007-2-quic_mdalam@quicinc.com>
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

quic_mdalam@quicinc.com wrote on Wed, 31 May 2023 18:19:50 +0530:

> This change will add exec_ops support for RESET , READ_ID, STATUS
> command.

Imperative form here and after in your commit log please.

Add support for...

Minor comments below, otherwise looks good.

>=20
> Co-developed-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
> ---
> Change in [v3]
>=20
> * Updated q_op->flag in qcom_op_cmd_mapping() with OP_PROGRAM_PAGE
>   instead NAND_CMD_PAGEPROG
>=20
> * Change the if condition check for exec_opwrite into single line check.
>=20
> * Added error check
>=20
> * Removed check for NAND_CMD_RESET, NAND_CMD_READID from pre_command.
>=20
> Change in [v2]
>=20
> * Missed to post Cover-letter, so posting v2 patch with cover-letter
>=20
> Change in [v1]
>=20
> * Added initial support for exec_ops.
>   =20
>  drivers/mtd/nand/raw/qcom_nandc.c | 218 +++++++++++++++++++++++++++++-
>  1 file changed, 215 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qco=
m_nandc.c
> index 6a83cd86a12d..659ba923b68a 100644
> --- a/drivers/mtd/nand/raw/qcom_nandc.c
> +++ b/drivers/mtd/nand/raw/qcom_nandc.c
> @@ -385,6 +385,9 @@ struct nandc_regs {
>   * @reg_read_pos:		marker for data read in reg_read_buf
>   *
>   * @cmd1/vld:			some fixed controller register values
> + *
> + * @exec_opwrite:		flag to select correct number of code word
> + *				while reading status
>   */
>  struct qcom_nand_controller {
>  	struct device *dev;
> @@ -435,6 +438,7 @@ struct qcom_nand_controller {
>  	int reg_read_pos;
> =20
>  	u32 cmd1, vld;
> +	bool exec_opwrite;
>  };
> =20
>  /*
> @@ -1542,8 +1546,7 @@ static void pre_command(struct qcom_nand_host *host=
, int command)
> =20
>  	clear_read_regs(nandc);
> =20
> -	if (command =3D=3D NAND_CMD_RESET || command =3D=3D NAND_CMD_READID ||
> -	    command =3D=3D NAND_CMD_PARAM || command =3D=3D NAND_CMD_ERASE1)
> +	if (command =3D=3D NAND_CMD_PARAM || command =3D=3D NAND_CMD_ERASE1)
>  		clear_bam_transaction(nandc);
>  }
> =20
> @@ -2920,6 +2923,8 @@ static int qcom_op_cmd_mapping(struct qcom_nand_con=
troller *nandc, u8 cmd,
>  		break;
>  	case NAND_CMD_PAGEPROG:
>  		ret =3D OP_PROGRAM_PAGE;
> +		q_op->flag =3D OP_PROGRAM_PAGE;
> +		nandc->exec_opwrite =3D true;
>  		break;
>  	default:
>  		break;
> @@ -2982,6 +2987,212 @@ static void qcom_parse_instructions(struct nand_c=
hip *chip,
>  	}
>  }
> =20
> +static void qcom_delay_ns(unsigned int ns)
> +{
> +	if (!ns)
> +		return;
> +
> +	if (ns < 10000)
> +		ndelay(ns);
> +	else
> +		udelay(DIV_ROUND_UP(ns, 1000));
> +}
> +
> +static int qcom_wait_rdy_poll(struct nand_chip *chip, unsigned int time_=
ms)
> +{
> +	struct qcom_nand_controller *nandc =3D get_qcom_nand_controller(chip);
> +	unsigned long start =3D jiffies + msecs_to_jiffies(time_ms);
> +	u32 flash;
> +
> +	nandc_read_buffer_sync(nandc, true);
> +
> +	do {
> +		flash =3D le32_to_cpu(nandc->reg_read_buf[0]);
> +		if (flash & FS_READY_BSY_N)
> +			return 0;
> +		cpu_relax();
> +	} while (time_after(start, jiffies));
> +
> +	dev_err(nandc->dev, "Timeout waiting for device to be ready:0x%08x\n", =
flash);
> +
> +	return -ETIMEDOUT;
> +}
> +
> +static int qcom_read_status_exec(struct nand_chip *chip,
> +				 const struct nand_subop *subop)
> +{
> +	struct qcom_nand_host *host =3D to_qcom_nand_host(chip);
> +	struct qcom_nand_controller *nandc =3D get_qcom_nand_controller(chip);
> +	struct nand_ecc_ctrl *ecc =3D &chip->ecc;
> +	struct qcom_op q_op;
> +	const struct nand_op_instr *instr =3D NULL;
> +	unsigned int op_id =3D 0;
> +	unsigned int len =3D 0;
> +	int ret =3D 0, num_cw, i;
> +	u32 flash_status;
> +
> +	host->status =3D NAND_STATUS_READY | NAND_STATUS_WP;
> +
> +	qcom_parse_instructions(chip, subop, &q_op);
> +
> +	num_cw =3D nandc->exec_opwrite ? ecc->steps : 1;
> +	nandc->exec_opwrite =3D false;
> +
> +	nandc->buf_count =3D 0;
> +	nandc->buf_start =3D 0;
> +	host->use_ecc =3D false;
> +
> +	clear_read_regs(nandc);
> +	clear_bam_transaction(nandc);
> +
> +	nandc_set_reg(chip, NAND_FLASH_CMD, q_op.cmd_reg);
> +	nandc_set_reg(chip, NAND_EXEC_CMD, 1);
> +
> +	write_reg_dma(nandc, NAND_FLASH_CMD, 1, NAND_BAM_NEXT_SGL);
> +	write_reg_dma(nandc, NAND_EXEC_CMD, 1, NAND_BAM_NEXT_SGL);
> +	read_reg_dma(nandc, NAND_FLASH_STATUS, 1, NAND_BAM_NEXT_SGL);
> +
> +	ret =3D submit_descs(nandc);
> +	if (ret) {
> +		dev_err(nandc->dev, "failure in sbumitting status descriptor\n");

                                                 ^

Please run checkpatch.pl --strict

> +		free_descs(nandc);
> +		goto err_out;
> +	}
> +	free_descs(nandc);
> +
> +	nandc_read_buffer_sync(nandc, true);
> +
> +	for (i =3D 0; i < num_cw; i++) {
> +		flash_status =3D le32_to_cpu(nandc->reg_read_buf[i]);
> +
> +	if (flash_status & FS_MPU_ERR)
> +		host->status &=3D ~NAND_STATUS_WP;
> +
> +	if (flash_status & FS_OP_ERR || (i =3D=3D (num_cw - 1) &&
> +					 (flash_status & FS_DEVICE_STS_ERR)))

  	if (flash_status & FS_OP_ERR ||
	    (i =3D=3D (num_cw - 1) && (flash_status & FS_DEVICE_STS_ERR)))

looks more readable?

> +		host->status |=3D NAND_STATUS_FAIL;
> +	}
> +
> +	flash_status =3D host->status;
> +	instr =3D q_op.data_instr;
> +	op_id =3D q_op.data_instr_idx;
> +	len =3D nand_subop_get_data_len(subop, op_id);
> +	memcpy(instr->ctx.data.buf.in, &flash_status, len);
> +
> +err_out:
> +	return ret;
> +}
> +
> +static int qcom_read_id_type_exec(struct nand_chip *chip, const struct n=
and_subop *subop)
> +{
> +	struct qcom_nand_controller *nandc =3D get_qcom_nand_controller(chip);
> +	struct qcom_nand_host *host =3D to_qcom_nand_host(chip);
> +	struct qcom_op q_op;
> +	const struct nand_op_instr *instr =3D NULL;
> +	unsigned int op_id =3D 0;
> +	unsigned int len =3D 0;
> +	int ret =3D 0;
> +
> +	qcom_parse_instructions(chip, subop, &q_op);
> +
> +	nandc->buf_count =3D 0;
> +	nandc->buf_start =3D 0;
> +	host->use_ecc =3D false;
> +
> +	clear_read_regs(nandc);
> +	clear_bam_transaction(nandc);
> +
> +	nandc_set_reg(chip, NAND_FLASH_CMD, q_op.cmd_reg);
> +	nandc_set_reg(chip, NAND_ADDR0, q_op.addr1_reg);
> +	nandc_set_reg(chip, NAND_ADDR1, q_op.addr2_reg);
> +	nandc_set_reg(chip, NAND_FLASH_CHIP_SELECT,
> +		      nandc->props->is_bam ? 0 : DM_EN);
> +
> +	nandc_set_reg(chip, NAND_EXEC_CMD, 1);
> +
> +	write_reg_dma(nandc, NAND_FLASH_CMD, 4, NAND_BAM_NEXT_SGL);
> +	write_reg_dma(nandc, NAND_EXEC_CMD, 1, NAND_BAM_NEXT_SGL);
> +
> +	read_reg_dma(nandc, NAND_READ_ID, 1, NAND_BAM_NEXT_SGL);
> +
> +	ret =3D submit_descs(nandc);
> +	if (ret) {
> +		dev_err(nandc->dev, "failure in sbumitting read id descriptor\n");
> +		free_descs(nandc);
> +		goto err_out;
> +	}
> +	free_descs(nandc);
> +
> +	instr =3D q_op.data_instr;
> +	op_id =3D q_op.data_instr_idx;
> +	len =3D nand_subop_get_data_len(subop, op_id);
> +
> +	nandc_read_buffer_sync(nandc, true);
> +	memcpy(instr->ctx.data.buf.in, nandc->reg_read_buf, len);
> +
> +err_out:
> +	return ret;
> +}
> +
> +static int qcom_misc_cmd_type_exec(struct nand_chip *chip, const struct =
nand_subop *subop)
> +{
> +	struct qcom_nand_controller *nandc =3D get_qcom_nand_controller(chip);
> +	struct qcom_nand_host *host =3D to_qcom_nand_host(chip);
> +	struct qcom_op q_op;
> +	int ret =3D 0;
> +
> +	qcom_parse_instructions(chip, subop, &q_op);
> +
> +	if (q_op.flag =3D=3D OP_PROGRAM_PAGE)
> +		goto wait_rdy;
> +
> +	nandc->buf_count =3D 0;
> +	nandc->buf_start =3D 0;
> +	host->use_ecc =3D false;
> +
> +	clear_read_regs(nandc);
> +	clear_bam_transaction(nandc);
> +
> +	nandc_set_reg(chip, NAND_FLASH_CMD, q_op.cmd_reg);
> +	nandc_set_reg(chip, NAND_EXEC_CMD, 1);
> +
> +	write_reg_dma(nandc, NAND_FLASH_CMD, 1, NAND_BAM_NEXT_SGL);
> +	write_reg_dma(nandc, NAND_EXEC_CMD, 1, NAND_BAM_NEXT_SGL);
> +
> +	read_reg_dma(nandc, NAND_FLASH_STATUS, 1, NAND_BAM_NEXT_SGL);
> +
> +	ret =3D submit_descs(nandc);
> +	if (ret) {
> +		dev_err(nandc->dev, "failure in sbumitting misc descriptor\n");
> +		free_descs(nandc);
> +		goto err_out;
> +	}
> +	free_descs(nandc);
> +
> +wait_rdy:
> +	qcom_delay_ns(q_op.rdy_delay_ns);
> +	ret =3D qcom_wait_rdy_poll(chip, q_op.rdy_timeout_ms);
> +
> +err_out:
> +	return ret;
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
> +			qcom_read_status_exec,
> +			NAND_OP_PARSER_PAT_CMD_ELEM(false),
> +			NAND_OP_PARSER_PAT_DATA_IN_ELEM(false, 1)),
> +		);
> +
>  static int qcom_check_op(struct nand_chip *chip,
>  			const struct nand_operation *op)
>  {
> @@ -3022,7 +3233,8 @@ static int qcom_nand_exec_op(struct nand_chip *chip,
>  	if (check_only)
>  		return qcom_check_op(chip, op);
> =20
> -	return 0;
> +	return nand_op_parser_exec_op(chip, &qcom_op_parser,
> +			op, check_only);
>  }
> =20
>  static const struct nand_controller_ops qcom_nandc_ops =3D {


Thanks,
Miqu=C3=A8l
