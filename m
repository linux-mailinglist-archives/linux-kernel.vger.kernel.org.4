Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B986B728217
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 16:03:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236553AbjFHODL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 10:03:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234429AbjFHODH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 10:03:07 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9E1B198C;
        Thu,  8 Jun 2023 07:03:05 -0700 (PDT)
X-GND-Sasl: miquel.raynal@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1686232984;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jnCroNGp1M+uiCnGqikYI4/3yHPp7dCX3+gK/nsGdo4=;
        b=nqSOFk2jprLAEjTEnhpb8ceq1s4cTV5qOWx+88Y2Vn/72O7rPjsM4hheBZi0/JxbG2luyg
        i39tWsQkL99tlDnOl8UBMuN5Tn+sY1ttnPjaADKJkSJzuhwKC4vgvIFgoxzVQPpWzmFjoH
        tN4qpTrjTtUYJgSPikJ0EgOno80gRxufPNVQYs+/0Ilhb56T//Cf/FohEG7kcQSTySXuEn
        JbUX/K5a8FI6ezkCOu8yWI4W6t6PAj9Z9yeRorB2cJdNgIBuHkfHjCjrkkUG1PJaTXKw9m
        b/Gu0uwclxezU1Ttb5MlDumZcsdJsNl91v/kv9HQkbTQQTakL3n+iose5SSklg==
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0396DE000B;
        Thu,  8 Jun 2023 14:03:03 +0000 (UTC)
Date:   Thu, 8 Jun 2023 16:03:03 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Md Sadre Alam <quic_mdalam@quicinc.com>
Cc:     mani@kernel.org, richard@nod.at, vigneshr@ti.com,
        linux-mtd@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_srichara@quicinc.com
Subject: Re: [PATCH v3 4/5] mtd: rawnand: qcom: Add support for read, write,
 erase exec_ops
Message-ID: <20230608160303.51ea70a6@xps-13>
In-Reply-To: <20230531124953.21007-4-quic_mdalam@quicinc.com>
References: <20230531124953.21007-1-quic_mdalam@quicinc.com>
        <20230531124953.21007-4-quic_mdalam@quicinc.com>
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

Hi Md,

quic_mdalam@quicinc.com wrote on Wed, 31 May 2023 18:19:52 +0530:

> This change will add exec_ops support for READ, WRITE, and ERASE
> command.
>=20
> Co-developed-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
> ---
> Change in [v3]
>=20
> * Removed chip->cont_read.ongoing flag.
>=20
> * Removed pre_command from erase_etype_exec_ops.
>=20
> Change in [v2]
>=20
> * Missed to post Cover-letter, so posting v2 patch with cover-letter.
>=20
> Change in [v1]
>=20
> * Added initial support for exec_ops.
>=20
>  drivers/mtd/nand/raw/qcom_nandc.c | 97 +++++++++++++++++++++++++++++--
>  1 file changed, 93 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qco=
m_nandc.c
> index b4823b72fe73..7dc769f9e797 100644
> --- a/drivers/mtd/nand/raw/qcom_nandc.c
> +++ b/drivers/mtd/nand/raw/qcom_nandc.c
> @@ -1546,8 +1546,7 @@ static void pre_command(struct qcom_nand_host *host=
, int command)
> =20
>  	clear_read_regs(nandc);
> =20
> -	if (command =3D=3D NAND_CMD_ERASE1)
> -		clear_bam_transaction(nandc);
> +	clear_bam_transaction(nandc);
>  }
> =20
>  /*
> @@ -1764,7 +1763,7 @@ qcom_nandc_read_cw_raw(struct mtd_info *mtd, struct=
 nand_chip *chip,
>  	int ret, reg_off =3D FLASH_BUF_ACC, read_loc =3D 0;
>  	int raw_cw =3D cw;
> =20
> -	nand_read_page_op(chip, page, 0, NULL, 0);
> +	nand_read_page_op(chip, page, 0, data_buf, mtd->writesize);
>  	host->use_ecc =3D false;
> =20
>  	if (nandc->props->qpic_v2)
> @@ -2181,14 +2180,23 @@ static void qcom_nandc_codeword_fixup(struct qcom=
_nand_host *host, int page)
>  static int qcom_nandc_read_page(struct nand_chip *chip, uint8_t *buf,
>  				int oob_required, int page)
>  {
> +	struct mtd_info *mtd =3D nand_to_mtd(chip);
>  	struct qcom_nand_host *host =3D to_qcom_nand_host(chip);
>  	struct qcom_nand_controller *nandc =3D get_qcom_nand_controller(chip);
> +	struct nand_ecc_ctrl *ecc =3D &chip->ecc;
>  	u8 *data_buf, *oob_buf =3D NULL;
> =20
>  	if (host->nr_boot_partitions)
>  		qcom_nandc_codeword_fixup(host, page);
> =20
> -	nand_read_page_op(chip, page, 0, NULL, 0);
> +	nand_read_page_op(chip, page, 0, buf, mtd->writesize);
> +	nandc->buf_count =3D 0;
> +	nandc->buf_start =3D 0;
> +	host->use_ecc =3D true;
> +	clear_read_regs(nandc);
> +	set_address(host, 0, page);
> +	update_rw_regs(host, ecc->steps, true, 0);
> +
>  	data_buf =3D buf;
>  	oob_buf =3D oob_required ? chip->oob_poi : NULL;
> =20
> @@ -2258,6 +2266,9 @@ static int qcom_nandc_write_page(struct nand_chip *=
chip, const uint8_t *buf,
> =20
>  	nand_prog_page_begin_op(chip, page, 0, NULL, 0);
> =20
> +	set_address(host, 0, page);
> +	nandc->buf_count =3D 0;
> +	nandc->buf_start =3D 0;
>  	clear_read_regs(nandc);
>  	clear_bam_transaction(nandc);
> =20
> @@ -3274,6 +3285,67 @@ static int qcom_param_page_type_exec(struct nand_c=
hip *chip,  const struct nand_
>  	return ret;
>  }
> =20
> +static int qcom_erase_cmd_type_exec(struct nand_chip *chip, const struct=
 nand_subop *subop)
> +{
> +	struct qcom_nand_host *host =3D to_qcom_nand_host(chip);
> +	struct qcom_nand_controller *nandc =3D get_qcom_nand_controller(chip);
> +	struct qcom_op q_op;
> +	int ret =3D 0;
> +
> +	qcom_parse_instructions(chip, subop, &q_op);
> +
> +	q_op.cmd_reg |=3D PAGE_ACC | LAST_PAGE;
> +
> +	nandc->buf_count =3D 0;
> +	nandc->buf_start =3D 0;
> +	host->use_ecc =3D false;
> +	clear_read_regs(nandc);
> +	clear_bam_transaction(nandc);
> +
> +	nandc_set_reg(chip, NAND_FLASH_CMD, q_op.cmd_reg);
> +	nandc_set_reg(chip, NAND_ADDR0, q_op.addr1_reg);
> +	nandc_set_reg(chip, NAND_ADDR1, q_op.addr2_reg);
> +	nandc_set_reg(chip, NAND_DEV0_CFG0,
> +		      host->cfg0_raw & ~(7 << CW_PER_PAGE));
> +	nandc_set_reg(chip, NAND_DEV0_CFG1, host->cfg1_raw);
> +	nandc_set_reg(chip, NAND_EXEC_CMD, 1);
> +
> +	write_reg_dma(nandc, NAND_FLASH_CMD, 3, NAND_BAM_NEXT_SGL);
> +	write_reg_dma(nandc, NAND_DEV0_CFG0, 2, NAND_BAM_NEXT_SGL);
> +	write_reg_dma(nandc, NAND_EXEC_CMD, 1, NAND_BAM_NEXT_SGL);
> +
> +	ret =3D submit_descs(nandc);
> +	if (ret) {
> +		dev_err(nandc->dev, "failure in sbumitting erase descriptor\n");

                                                :)

> +		free_descs(nandc);
> +		goto err_out;
> +	}
> +	free_descs(nandc);
> +
> +	ret =3D qcom_wait_rdy_poll(chip, q_op.rdy_timeout_ms);
> +	if (ret)
> +		goto err_out;
> +
> +err_out:
> +	return ret;
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

Mmmh, I don't think this is gonna work. I don't understand what you're
doing here. What is "actual API itself"? What is "read_exec_op"? I
doubt I am going to like what all this means. Please don't make any
assumptions on what could come next. The core asks you to do something,
just do it. If you can't then the parsing will fail. If the core has a
fallback it's fine. If the core does not, we can discuss it. But please
don't do any guesses like that, this is *exactly* why we introduced
exec_op in the first place: you have access to the whole operation, so
please handle it correctly.

> +}
> +
> +static int qcom_data_write_type_exec(struct nand_chip *chip, const struc=
t nand_subop *subop)
> +{
> +	/* currently write_exec_op() return 0, and all the write operation hand=
le in
> +	 * actual API itself
> +	 */
> +	return 0;
> +}
> +
>  static const struct nand_op_parser qcom_op_parser =3D NAND_OP_PARSER(
>  		NAND_OP_PARSER_PATTERN(
>  			qcom_misc_cmd_type_exec,
> @@ -3294,6 +3366,23 @@ static const struct nand_op_parser qcom_op_parser =
=3D NAND_OP_PARSER(
>  			NAND_OP_PARSER_PAT_ADDR_ELEM(false, MAX_ADDRESS_CYCLE),
>  			NAND_OP_PARSER_PAT_WAITRDY_ELEM(true),
>  			NAND_OP_PARSER_PAT_DATA_IN_ELEM(false, 512)),
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
>  		);
> =20
>  static int qcom_check_op(struct nand_chip *chip,


Thanks,
Miqu=C3=A8l
