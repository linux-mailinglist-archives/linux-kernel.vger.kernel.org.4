Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05A5170BFF9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 15:45:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233606AbjEVNpQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 09:45:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230184AbjEVNpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 09:45:14 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCC50C6;
        Mon, 22 May 2023 06:45:12 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 4A59AC0008;
        Mon, 22 May 2023 13:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1684763110;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nUSffco4/w//XAZ47cQUSWYcDz41qfX87j0DxKN1CAE=;
        b=XqLOC5hX6TjWGppK7GxG8h5/b8VVCWX/RXJtP66a12W1AAKIH61DM6rBKTqsi4CGF1ZPm5
        /FjG9BjwdTtBcpLpuiDAa6dOfDoKZyP3+61PxaBCCCfYSZwRD4UjWpLWGnMHOFRafkVXuf
        1LrDH6YsIvUpp+4z8ag875XUI3+hDqhl4Scqt2BSDRbpi3axcEIO1x4NSkrxYyUgGT2vZ0
        QsxDYPmDTq/+iciT/uyYr+HJI9ENIvVhwtAxgsbxjn595GPLk7Au+EhAT2eeclRTnRBzel
        LD3Lg6Bb7pAIB43M5w66f9YM5W5Ub7Vqm5X4HV59kYr7CqFjVLOF1F8Z8WX+sQ==
Date:   Mon, 22 May 2023 15:45:07 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Md Sadre Alam <quic_mdalam@quicinc.com>
Cc:     mani@kernel.org, richard@nod.at, vigneshr@ti.com,
        linux-mtd@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_srichara@quicinc.com
Subject: Re: [PATCH v2 2/5] mtd: rawnand: qcom: Add support for reset,
 readid, status exec_op
Message-ID: <20230522154507.0255d902@xps-13>
In-Reply-To: <20230511133017.6307-3-quic_mdalam@quicinc.com>
References: <20230511133017.6307-1-quic_mdalam@quicinc.com>
        <20230511133017.6307-3-quic_mdalam@quicinc.com>
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

Hi Md,

quic_mdalam@quicinc.com wrote on Thu, 11 May 2023 19:00:14 +0530:

> This change will add exec_ops support for RESET , READ_ID, STATUS
> command.
>=20
> Co-developed-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
> ---
> Change in [v2]
>=20
> * Missed to post Cover-letter, so posting v2 patch with cover-letter
>=20
>  drivers/mtd/nand/raw/qcom_nandc.c | 166 +++++++++++++++++++++++++++++-
>  1 file changed, 163 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qco=
m_nandc.c
> index dae460e2aa0b..d2f2a8971907 100644
> --- a/drivers/mtd/nand/raw/qcom_nandc.c
> +++ b/drivers/mtd/nand/raw/qcom_nandc.c
> @@ -384,6 +384,9 @@ struct nandc_regs {
>   * @reg_read_pos:		marker for data read in reg_read_buf
>   *
>   * @cmd1/vld:			some fixed controller register values
> + *
> + * @exec_opwrite:		flag to select correct number of code word
> + *				while reading status
>   */
>  struct qcom_nand_controller {
>  	struct device *dev;
> @@ -434,6 +437,7 @@ struct qcom_nand_controller {
>  	int reg_read_pos;
> =20
>  	u32 cmd1, vld;
> +	bool exec_opwrite;
>  };
> =20
>  /*
> @@ -2920,6 +2924,8 @@ static int qcom_op_cmd_mapping(struct qcom_nand_con=
troller *nandc, u8 cmd,
>  		break;
>  	case NAND_CMD_PAGEPROG:
>  		ret =3D OP_PROGRAM_PAGE;
> +		q_op->flag =3D NAND_CMD_PAGEPROG;

Just use the instruction value?

> +		nandc->exec_opwrite =3D true;
>  		break;
>  	default:
>  		break;
> @@ -2982,10 +2988,95 @@ static void qcom_parse_instructions(struct nand_c=
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
>  static int qcom_read_status_exec(struct nand_chip *chip,
>  				 const struct nand_subop *subop)
>  {
> -	return 0;
> +	struct qcom_nand_host *host =3D to_qcom_nand_host(chip);
> +	struct qcom_nand_controller *nandc =3D get_qcom_nand_controller(chip);
> +	struct nand_ecc_ctrl *ecc =3D &chip->ecc;
> +	struct qcom_op q_op;
> +	const struct nand_op_instr *instr =3D NULL;
> +	unsigned int op_id =3D 0;
> +	unsigned int len =3D 0;
> +	int ret =3D 0, num_cw =3D 1, i;
> +	u32 flash_status;
> +
> +	host->status =3D NAND_STATUS_READY | NAND_STATUS_WP;
> +
> +	qcom_parse_instructions(chip, subop, &q_op);
> +
> +	if (nandc->exec_opwrite) {

I definitely don't understand this flag at all.

> +		num_cw =3D ecc->steps;
> +		nandc->exec_opwrite =3D false;
> +	}
> +
> +	pre_command(host, NAND_CMD_STATUS);
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
> +	if (ret)
> +		dev_err(nandc->dev, "failure in sbumitting status descriptor\n");
> +
> +	free_descs(nandc);
> +
> +	nandc_read_buffer_sync(nandc, true);
> +	for (i =3D 0; i < num_cw; i++) {
> +		flash_status =3D le32_to_cpu(nandc->reg_read_buf[i]);
> +
> +	if (flash_status & FS_MPU_ERR)
> +		host->status &=3D ~NAND_STATUS_WP;
> +
> +	if (flash_status & FS_OP_ERR || (i =3D=3D (num_cw - 1) &&
> +					 (flash_status & FS_DEVICE_STS_ERR)))
> +		host->status |=3D NAND_STATUS_FAIL;

If there is a failure detected, error out (everywhere).

> +	}
> +
> +	flash_status =3D host->status;
> +
> +	instr =3D q_op.data_instr;
> +	op_id =3D q_op.data_instr_idx;
> +	len =3D nand_subop_get_data_len(subop, op_id);
> +	memcpy(instr->ctx.data.buf.in, &flash_status, len);
> +
> +	return ret;
>  }
> =20
>  static int qcom_erase_cmd_type_exec(struct nand_chip *chip, const struct=
 nand_subop *subop)
> @@ -3000,12 +3091,81 @@ static int qcom_param_page_type_exec(struct nand_=
chip *chip,  const struct nand_
> =20
>  static int qcom_read_id_type_exec(struct nand_chip *chip, const struct n=
and_subop *subop)
>  {
> -	return 0;
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
> +	pre_command(host, NAND_CMD_READID);
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
> +	if (ret)
> +		dev_err(nandc->dev, "failure in sbumitting read id descriptor\n");
> +
> +	free_descs(nandc);
> +
> +	instr =3D q_op.data_instr;
> +	op_id =3D q_op.data_instr_idx;
> +	len =3D nand_subop_get_data_len(subop, op_id);
> +
> +	nandc_read_buffer_sync(nandc, true);
> +	memcpy(instr->ctx.data.buf.in, nandc->reg_read_buf, len);
> +
> +	return ret;
>  }
> =20
>  static int qcom_misc_cmd_type_exec(struct nand_chip *chip, const struct =
nand_subop *subop)
>  {
> -	return 0;
> +	struct qcom_nand_controller *nandc =3D get_qcom_nand_controller(chip);
> +	struct qcom_nand_host *host =3D to_qcom_nand_host(chip);
> +	struct qcom_op q_op;
> +	int ret =3D 0;
> +
> +	qcom_parse_instructions(chip, subop, &q_op);
> +
> +	if (q_op.flag =3D=3D NAND_CMD_PAGEPROG)
> +		goto wait_rdy;
> +
> +	pre_command(host, NAND_CMD_RESET);

???

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
> +	if (ret)
> +		dev_err(nandc->dev, "failure in sbumitting misc descriptor\n");

Typo                                             ^

Same above.

You should error out immediately when something wrong happens.

> +
> +	free_descs(nandc);
> +
> +wait_rdy:
> +	qcom_delay_ns(q_op.rdy_delay_ns);
> +
> +	ret =3D qcom_wait_rdy_poll(chip, q_op.rdy_timeout_ms);
> +
> +	return ret;
>  }
> =20
>  static int qcom_data_read_type_exec(struct nand_chip *chip, const struct=
 nand_subop *subop)


Thanks,
Miqu=C3=A8l
