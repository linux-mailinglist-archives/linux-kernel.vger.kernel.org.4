Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C96D470C00B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 15:49:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233538AbjEVNtX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 09:49:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231725AbjEVNtW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 09:49:22 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10513F4;
        Mon, 22 May 2023 06:49:19 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 5511F1BF206;
        Mon, 22 May 2023 13:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1684763358;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=98DDrxz4hU1l5peZYXkR1grl9w+mJ1Ay3ep3FbsBoIQ=;
        b=Z9F5eTpFhu0GPi4odkH/6aIxvXz0zyW0Pxf+lgyLHrhFN22wuuxVz7zQlV9bR+lW64cssh
        NBOKenZX+RT8/UYOGnMTvF3MygXktEqKMSyl1hgn/QOGFZ929XTEeKaSN1T5Y4PP3/Yyf0
        QR5QhYSK8PcGYDzeTpOrrS842J/aKILZTfoFp8hTFSq7cWJMlJ12vnPXMvhIhr5Iif2LoL
        70B9uaEcGknqReoxyG0shhdHkvzGHWeqIOw7xHK+yvUVKiX2sgGTG3unqMJWGiWlJ2DqHH
        j3PgLA8Hhgdq4TFamzZ405ZZt3M3yzAH5jfbcoPS7ltwdzQ4/6IOVWkQml1iAA==
Date:   Mon, 22 May 2023 15:49:16 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Md Sadre Alam <quic_mdalam@quicinc.com>
Cc:     mani@kernel.org, richard@nod.at, vigneshr@ti.com,
        linux-mtd@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_srichara@quicinc.com
Subject: Re: [PATCH v2 3/5] mtd: rawnand: qcom: Add support for param_page
 read exec_ops
Message-ID: <20230522154916.3bb7be4e@xps-13>
In-Reply-To: <20230511133017.6307-4-quic_mdalam@quicinc.com>
References: <20230511133017.6307-1-quic_mdalam@quicinc.com>
        <20230511133017.6307-4-quic_mdalam@quicinc.com>
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

quic_mdalam@quicinc.com wrote on Thu, 11 May 2023 19:00:15 +0530:

> This change will add exec_ops for PARAM_PAGE_READ command.
>=20
> Co-developed-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
> ---
> Change in [v2]
>=20
> * Missed to post Cover-letter, so posting v2 patch with cover-letter
>=20
>  drivers/mtd/nand/raw/qcom_nandc.c | 91 ++++++++++++++++++++++++++++++-
>  1 file changed, 90 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qco=
m_nandc.c
> index d2f2a8971907..8717d5086f80 100644
> --- a/drivers/mtd/nand/raw/qcom_nandc.c
> +++ b/drivers/mtd/nand/raw/qcom_nandc.c
> @@ -3086,7 +3086,96 @@ static int qcom_erase_cmd_type_exec(struct nand_ch=
ip *chip, const struct nand_su
> =20
>  static int qcom_param_page_type_exec(struct nand_chip *chip,  const stru=
ct nand_subop *subop)
>  {
> -	return 0;
> +	struct qcom_nand_host *host =3D to_qcom_nand_host(chip);
> +	struct qcom_nand_controller *nandc =3D get_qcom_nand_controller(chip);
> +	struct qcom_op q_op;
> +	const struct nand_op_instr *instr =3D NULL;
> +	unsigned int op_id =3D 0;
> +	unsigned int len =3D 0;
> +	int ret =3D 0;
> +
> +	qcom_parse_instructions(chip, subop, &q_op);
> +
> +	q_op.cmd_reg |=3D PAGE_ACC | LAST_PAGE;
> +
> +	pre_command(host, NAND_CMD_PARAM);
> +	/*
> +	 * NAND_CMD_PARAM is called before we know much about the FLASH chip
> +	 * in use. we configure the controller to perform a raw read of 512
> +	 * bytes to read onfi params

There is no guess to do, just follow what the core asks.

> +	 */
> +	if (nandc->props->qpic_v2)
> +		nandc_set_reg(chip, NAND_FLASH_CMD, q_op.cmd_reg);
> +	else
> +		nandc_set_reg(chip, NAND_FLASH_CMD, q_op.cmd_reg);

There is something wrong here.

> +
> +	nandc_set_reg(chip, NAND_ADDR0, 0);
> +	nandc_set_reg(chip, NAND_ADDR1, 0);
> +	nandc_set_reg(chip, NAND_DEV0_CFG0, 0 << CW_PER_PAGE
> +					| 512 << UD_SIZE_BYTES
> +					| 5 << NUM_ADDR_CYCLES
> +					| 0 << SPARE_SIZE_BYTES);
> +	nandc_set_reg(chip, NAND_DEV0_CFG1, 7 << NAND_RECOVERY_CYCLES
> +					| 0 << CS_ACTIVE_BSY
> +					| 17 << BAD_BLOCK_BYTE_NUM
> +					| 1 << BAD_BLOCK_IN_SPARE_AREA
> +					| 2 << WR_RD_BSY_GAP
> +					| 0 << WIDE_FLASH
> +					| 1 << DEV0_CFG1_ECC_DISABLE);
> +	if (!nandc->props->qpic_v2)
> +		nandc_set_reg(chip, NAND_EBI2_ECC_BUF_CFG, 1 << ECC_CFG_ECC_DISABLE);
> +
> +	/* configure CMD1 and VLD for ONFI param probing in QPIC v1 */
> +	if (!nandc->props->qpic_v2) {
> +		nandc_set_reg(chip, NAND_DEV_CMD_VLD,
> +			      (nandc->vld & ~READ_START_VLD));
> +		nandc_set_reg(chip, NAND_DEV_CMD1,
> +			      (nandc->cmd1 & ~(0xFF << READ_ADDR))
> +			      | NAND_CMD_PARAM << READ_ADDR);
> +	}
> +
> +	nandc_set_reg(chip, NAND_EXEC_CMD, 1);
> +
> +	if (!nandc->props->qpic_v2) {
> +		nandc_set_reg(chip, NAND_DEV_CMD1_RESTORE, nandc->cmd1);
> +		nandc_set_reg(chip, NAND_DEV_CMD_VLD_RESTORE, nandc->vld);
> +	}
> +
> +	nandc_set_read_loc(chip, 0, 0, 0, 512, 1);
> +
> +	if (!nandc->props->qpic_v2) {
> +		write_reg_dma(nandc, NAND_DEV_CMD_VLD, 1, 0);
> +		write_reg_dma(nandc, NAND_DEV_CMD1, 1, NAND_BAM_NEXT_SGL);
> +	}
> +
> +	nandc->buf_count =3D 512;

The length is provided by the instruction.

> +	memset(nandc->data_buffer, 0xff, nandc->buf_count);
> +
> +	config_nand_single_cw_page_read(chip, false, 0);
> +
> +	read_data_dma(nandc, FLASH_BUF_ACC, nandc->data_buffer,
> +		      nandc->buf_count, 0);
> +
> +	/* restore CMD1 and VLD regs */
> +	if (!nandc->props->qpic_v2) {
> +		write_reg_dma(nandc, NAND_DEV_CMD1_RESTORE, 1, 0);
> +		write_reg_dma(nandc, NAND_DEV_CMD_VLD_RESTORE, 1, NAND_BAM_NEXT_SGL);
> +	}
> +
> +	ret =3D submit_descs(nandc);
> +	if (ret)
> +		dev_err(nandc->dev, "failure in sbumitting param page descriptor\n");
> +
> +	free_descs(nandc);
> +
> +	ret =3D qcom_wait_rdy_poll(chip, q_op.rdy_timeout_ms);
> +
> +	instr =3D q_op.data_instr;
> +	op_id =3D q_op.data_instr_idx;
> +	len =3D nand_subop_get_data_len(subop, op_id);
> +	memcpy(instr->ctx.data.buf.in, nandc->data_buffer, len);
> +
> +	return ret;
>  }
> =20
>  static int qcom_read_id_type_exec(struct nand_chip *chip, const struct n=
and_subop *subop)


Thanks,
Miqu=C3=A8l
