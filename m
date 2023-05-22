Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 160E070C093
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 15:57:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231770AbjEVN5p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 09:57:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234416AbjEVN5Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 09:57:25 -0400
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B571273B;
        Mon, 22 May 2023 06:54:33 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 71A7E60005;
        Mon, 22 May 2023 13:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1684763627;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ixcjlCNBU42p+hd7IanBDXQJQKVObBCB+C1cvP15qs0=;
        b=AzrnujWV/ToVqnXNKd0vuTZ5LRVjAIQ2Ya0tZ5jcSjCdtnLttZBPKtgCFDMryRyDscFFF+
        V2iOe4YF4ELGHpOPmG0kJRo4JQtJNiuQRwbhnGdanjFdW47zrrwikJntyj6KCqzxcWF2ke
        +NLnsu3h4Ih8xBmFf42n+/MFtZYo68xt/MGhN5kHVmAVQB7nAKt65vgQQKXEt4bSRXWbqm
        S6I78s4QDp4CnGySe7I7csJ9TioAsPXuHutskca1VvQ6nSAEN8i4jwkHCgXic0EnFE9k9t
        HGPGsgoTR0iMrBBCvmfo8RZCBUmmtdWE+HPfjEi86BbamVgmBz6kaVqSBtcfVQ==
Date:   Mon, 22 May 2023 15:53:45 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Md Sadre Alam <quic_mdalam@quicinc.com>
Cc:     mani@kernel.org, richard@nod.at, vigneshr@ti.com,
        linux-mtd@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_srichara@quicinc.com
Subject: Re: [PATCH v2 4/5] mtd: rawnand: qcom: Add support for read, write,
 erase exec_ops
Message-ID: <20230522155345.1d12600e@xps-13>
In-Reply-To: <20230511133017.6307-5-quic_mdalam@quicinc.com>
References: <20230511133017.6307-1-quic_mdalam@quicinc.com>
        <20230511133017.6307-5-quic_mdalam@quicinc.com>
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


quic_mdalam@quicinc.com wrote on Thu, 11 May 2023 19:00:16 +0530:

> This change will add exec_ops support for READ, WRITE, and ERASE
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
>  drivers/mtd/nand/raw/qcom_nandc.c | 52 +++++++++++++++++++++++++++++--
>  1 file changed, 49 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qco=
m_nandc.c
> index 8717d5086f80..14ab21a4771b 100644
> --- a/drivers/mtd/nand/raw/qcom_nandc.c
> +++ b/drivers/mtd/nand/raw/qcom_nandc.c
> @@ -1765,7 +1765,8 @@ qcom_nandc_read_cw_raw(struct mtd_info *mtd, struct=
 nand_chip *chip,
>  	int ret, reg_off =3D FLASH_BUF_ACC, read_loc =3D 0;
>  	int raw_cw =3D cw;
> =20
> -	nand_read_page_op(chip, page, 0, NULL, 0);
> +	chip->cont_read.ongoing =3D false;

This should be checked once for all by the core at startup, that's when
you can tell the core continuous read is not supported by the
controller.

> +	nand_read_page_op(chip, page, 0, data_buf, mtd->writesize);
>  	host->use_ecc =3D false;
> =20
>  	if (nandc->props->qpic_v2)
> @@ -2182,14 +2183,24 @@ static void qcom_nandc_codeword_fixup(struct qcom=
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
> +	chip->cont_read.ongoing =3D false;
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
> @@ -2259,6 +2270,10 @@ static int qcom_nandc_write_page(struct nand_chip =
*chip, const uint8_t *buf,
> =20
>  	nand_prog_page_begin_op(chip, page, 0, NULL, 0);
> =20
> +	set_address(host, 0, page);
> +	nandc->buf_count =3D 0;
> +	nandc->buf_start =3D 0;
> +
>  	clear_read_regs(nandc);
>  	clear_bam_transaction(nandc);
> =20
> @@ -3081,7 +3096,38 @@ static int qcom_read_status_exec(struct nand_chip =
*chip,
> =20
>  static int qcom_erase_cmd_type_exec(struct nand_chip *chip, const struct=
 nand_subop *subop)
>  {
> -	return 0;
> +	struct qcom_nand_host *host =3D to_qcom_nand_host(chip);
> +	struct qcom_nand_controller *nandc =3D get_qcom_nand_controller(chip);
> +	struct qcom_op q_op;
> +	int ret =3D 0;
> +
> +	qcom_parse_instructions(chip, subop, &q_op);
> +
> +	q_op.cmd_reg |=3D PAGE_ACC | LAST_PAGE;
> +
> +	pre_command(host, NAND_CMD_ERASE1);

The instruction is up to the caller, not to the driver. If no other
instruction rather than NAND_CMD_ERASE1 can be used with this pattern,
then it should be properly described (see the Arasan controller,
anfc_check_op()).

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
> +	if (ret)
> +		dev_err(nandc->dev, "failure in sbumitting reset descriptor\n");
> +
> +	free_descs(nandc);
> +
> +	ret =3D qcom_wait_rdy_poll(chip, q_op.rdy_timeout_ms);
> +
> +	return ret;
>  }
> =20
>  static int qcom_param_page_type_exec(struct nand_chip *chip,  const stru=
ct nand_subop *subop)


Thanks,
Miqu=C3=A8l
