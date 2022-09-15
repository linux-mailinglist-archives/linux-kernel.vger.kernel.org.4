Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13A705B9C2A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 15:43:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbiIONnv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 09:43:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiIONns (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 09:43:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 213707CB6E;
        Thu, 15 Sep 2022 06:43:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 984AD623E0;
        Thu, 15 Sep 2022 13:43:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDF00C433D6;
        Thu, 15 Sep 2022 13:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663249424;
        bh=/aDcY35t5QlMhKY3xwreZi7wvdza9qhN6fQ3O2aIAHc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h3sQVpBbw/053c0YwMiA2QIeF/gFxM7yLbNAr0jSDOuEJxBkmg0LO0PxcHTKLLtcy
         TIfdwMwXTD2nVV8Sm6hh0wyhs3JqTOzJsOLD+KfAA5XB5wmYhb+D7AZyTkti0/9o68
         frIQZKXUCotMOD69N6UITpzd8OvK68fIjZP83lLBeqELvEazhbX6cIV7cVazv2DE8q
         Hd8+ZG0/KlehKgzanEExqE6sZ0AqauiJWDY1mmtu6g4+F7vJ9HeFqc6sfqMr8zGbDO
         15L3QEZO9c8IroWy4sgo5fgw8tHDyQlnYU+AUa09CmWi4tqsUxzHydvm0UiLYtvz22
         Q4Cu1xjJR1KVw==
Date:   Thu, 15 Sep 2022 19:13:28 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Md Sadre Alam <quic_mdalam@quicinc.com>
Cc:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        linux-mtd@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_srichara@quicinc.com
Subject: Re: [PATCH] mtd: rawnand: qcom: Implement exec_op()
Message-ID: <20220915134328.GD4550@workstation>
References: <1654273498-31998-1-git-send-email-quic_mdalam@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1654273498-31998-1-git-send-email-quic_mdalam@quicinc.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 03, 2022 at 09:54:58PM +0530, Md Sadre Alam wrote:
> Implement exec_op() so we can later get rid of the legacy interface
> implementation.
> 
> Co-developed-by: Sricharan R <quic_srichara@quicinc.com>
> Signed-off-by: Sricharan R <quic_srichara@quicinc.com>
> Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>

Sadre, Sri, any update on this patch?

Thanks,
Mani

> ---
>  drivers/mtd/nand/raw/qcom_nandc.c | 368 +++++++++++++++++++++-----------------
>  1 file changed, 204 insertions(+), 164 deletions(-)
> 
> diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qcom_nandc.c
> index 048b255..507921b 100644
> --- a/drivers/mtd/nand/raw/qcom_nandc.c
> +++ b/drivers/mtd/nand/raw/qcom_nandc.c
> @@ -14,6 +14,7 @@
>  #include <linux/of.h>
>  #include <linux/of_device.h>
>  #include <linux/delay.h>
> +#include <linux/iopoll.h>
>  #include <linux/dma/qcom_bam_dma.h>
>  
>  /* NANDc reg offsets */
> @@ -1305,15 +1306,13 @@ static int nandc_param(struct qcom_nand_host *host)
>  }
>  
>  /* sets up descriptors for NAND_CMD_ERASE1 */
> -static int erase_block(struct qcom_nand_host *host, int page_addr)
> +static int erase_block(struct qcom_nand_host *host)
>  {
>  	struct nand_chip *chip = &host->chip;
>  	struct qcom_nand_controller *nandc = get_qcom_nand_controller(chip);
>  
>  	nandc_set_reg(chip, NAND_FLASH_CMD,
>  		      OP_BLOCK_ERASE | PAGE_ACC | LAST_PAGE);
> -	nandc_set_reg(chip, NAND_ADDR0, page_addr);
> -	nandc_set_reg(chip, NAND_ADDR1, 0);
>  	nandc_set_reg(chip, NAND_DEV0_CFG0,
>  		      host->cfg0_raw & ~(7 << CW_PER_PAGE));
>  	nandc_set_reg(chip, NAND_DEV0_CFG1, host->cfg1_raw);
> @@ -1321,14 +1320,8 @@ static int erase_block(struct qcom_nand_host *host, int page_addr)
>  	nandc_set_reg(chip, NAND_FLASH_STATUS, host->clrflashstatus);
>  	nandc_set_reg(chip, NAND_READ_STATUS, host->clrreadstatus);
>  
> -	write_reg_dma(nandc, NAND_FLASH_CMD, 3, NAND_BAM_NEXT_SGL);
> +	write_reg_dma(nandc, NAND_FLASH_CMD, 1, NAND_BAM_NEXT_SGL);
>  	write_reg_dma(nandc, NAND_DEV0_CFG0, 2, NAND_BAM_NEXT_SGL);
> -	write_reg_dma(nandc, NAND_EXEC_CMD, 1, NAND_BAM_NEXT_SGL);
> -
> -	read_reg_dma(nandc, NAND_FLASH_STATUS, 1, NAND_BAM_NEXT_SGL);
> -
> -	write_reg_dma(nandc, NAND_FLASH_STATUS, 1, 0);
> -	write_reg_dma(nandc, NAND_READ_STATUS, 1, NAND_BAM_NEXT_SGL);
>  
>  	return 0;
>  }
> @@ -1343,16 +1336,12 @@ static int read_id(struct qcom_nand_host *host, int column)
>  		return 0;
>  
>  	nandc_set_reg(chip, NAND_FLASH_CMD, OP_FETCH_ID);
> -	nandc_set_reg(chip, NAND_ADDR0, column);
> -	nandc_set_reg(chip, NAND_ADDR1, 0);
>  	nandc_set_reg(chip, NAND_FLASH_CHIP_SELECT,
>  		      nandc->props->is_bam ? 0 : DM_EN);
>  	nandc_set_reg(chip, NAND_EXEC_CMD, 1);
>  
> -	write_reg_dma(nandc, NAND_FLASH_CMD, 4, NAND_BAM_NEXT_SGL);
> -	write_reg_dma(nandc, NAND_EXEC_CMD, 1, NAND_BAM_NEXT_SGL);
> -
> -	read_reg_dma(nandc, NAND_READ_ID, 1, NAND_BAM_NEXT_SGL);
> +	write_reg_dma(nandc, NAND_FLASH_CMD, 1, NAND_BAM_NEXT_SGL);
> +	write_reg_dma(nandc, NAND_FLASH_CHIP_SELECT, 1, NAND_BAM_NEXT_SGL);
>  
>  	return 0;
>  }
> @@ -1491,7 +1480,6 @@ static void parse_erase_write_errors(struct qcom_nand_host *host, int command)
>  
>  	for (i = 0; i < num_cw; i++) {
>  		u32 flash_status = le32_to_cpu(nandc->reg_read_buf[i]);
> -
>  		if (flash_status & FS_MPU_ERR)
>  			host->status &= ~NAND_STATUS_WP;
>  
> @@ -1523,86 +1511,6 @@ static void post_command(struct qcom_nand_host *host, int command)
>  }
>  
>  /*
> - * Implements chip->legacy.cmdfunc. It's  only used for a limited set of
> - * commands. The rest of the commands wouldn't be called by upper layers.
> - * For example, NAND_CMD_READOOB would never be called because we have our own
> - * versions of read_oob ops for nand_ecc_ctrl.
> - */
> -static void qcom_nandc_command(struct nand_chip *chip, unsigned int command,
> -			       int column, int page_addr)
> -{
> -	struct qcom_nand_host *host = to_qcom_nand_host(chip);
> -	struct nand_ecc_ctrl *ecc = &chip->ecc;
> -	struct qcom_nand_controller *nandc = get_qcom_nand_controller(chip);
> -	bool wait = false;
> -	int ret = 0;
> -
> -	pre_command(host, command);
> -
> -	switch (command) {
> -	case NAND_CMD_RESET:
> -		ret = reset(host);
> -		wait = true;
> -		break;
> -
> -	case NAND_CMD_READID:
> -		nandc->buf_count = 4;
> -		ret = read_id(host, column);
> -		wait = true;
> -		break;
> -
> -	case NAND_CMD_PARAM:
> -		ret = nandc_param(host);
> -		wait = true;
> -		break;
> -
> -	case NAND_CMD_ERASE1:
> -		ret = erase_block(host, page_addr);
> -		wait = true;
> -		break;
> -
> -	case NAND_CMD_READ0:
> -		/* we read the entire page for now */
> -		WARN_ON(column != 0);
> -
> -		host->use_ecc = true;
> -		set_address(host, 0, page_addr);
> -		update_rw_regs(host, ecc->steps, true, 0);
> -		break;
> -
> -	case NAND_CMD_SEQIN:
> -		WARN_ON(column != 0);
> -		set_address(host, 0, page_addr);
> -		break;
> -
> -	case NAND_CMD_PAGEPROG:
> -	case NAND_CMD_STATUS:
> -	case NAND_CMD_NONE:
> -	default:
> -		break;
> -	}
> -
> -	if (ret) {
> -		dev_err(nandc->dev, "failure executing command %d\n",
> -			command);
> -		free_descs(nandc);
> -		return;
> -	}
> -
> -	if (wait) {
> -		ret = submit_descs(nandc);
> -		if (ret)
> -			dev_err(nandc->dev,
> -				"failure submitting descs for command %d\n",
> -				command);
> -	}
> -
> -	free_descs(nandc);
> -
> -	post_command(host, command);
> -}
> -
> -/*
>   * when using BCH ECC, the HW flags an error in NAND_FLASH_STATUS if it read
>   * an erased CW, and reports an erased CW in NAND_ERASED_CW_DETECT_STATUS.
>   *
> @@ -2044,7 +1952,6 @@ static int qcom_nandc_read_page(struct nand_chip *chip, uint8_t *buf,
>  	struct qcom_nand_host *host = to_qcom_nand_host(chip);
>  	struct qcom_nand_controller *nandc = get_qcom_nand_controller(chip);
>  	u8 *data_buf, *oob_buf = NULL;
> -
>  	nand_read_page_op(chip, page, 0, NULL, 0);
>  	data_buf = buf;
>  	oob_buf = oob_required ? chip->oob_poi : NULL;
> @@ -2366,64 +2273,6 @@ static int qcom_nandc_block_markbad(struct nand_chip *chip, loff_t ofs)
>  }
>  
>  /*
> - * the three functions below implement chip->legacy.read_byte(),
> - * chip->legacy.read_buf() and chip->legacy.write_buf() respectively. these
> - * aren't used for reading/writing page data, they are used for smaller data
> - * like reading	id, status etc
> - */
> -static uint8_t qcom_nandc_read_byte(struct nand_chip *chip)
> -{
> -	struct qcom_nand_host *host = to_qcom_nand_host(chip);
> -	struct qcom_nand_controller *nandc = get_qcom_nand_controller(chip);
> -	u8 *buf = nandc->data_buffer;
> -	u8 ret = 0x0;
> -
> -	if (host->last_command == NAND_CMD_STATUS) {
> -		ret = host->status;
> -
> -		host->status = NAND_STATUS_READY | NAND_STATUS_WP;
> -
> -		return ret;
> -	}
> -
> -	if (nandc->buf_start < nandc->buf_count)
> -		ret = buf[nandc->buf_start++];
> -
> -	return ret;
> -}
> -
> -static void qcom_nandc_read_buf(struct nand_chip *chip, uint8_t *buf, int len)
> -{
> -	struct qcom_nand_controller *nandc = get_qcom_nand_controller(chip);
> -	int real_len = min_t(size_t, len, nandc->buf_count - nandc->buf_start);
> -
> -	memcpy(buf, nandc->data_buffer + nandc->buf_start, real_len);
> -	nandc->buf_start += real_len;
> -}
> -
> -static void qcom_nandc_write_buf(struct nand_chip *chip, const uint8_t *buf,
> -				 int len)
> -{
> -	struct qcom_nand_controller *nandc = get_qcom_nand_controller(chip);
> -	int real_len = min_t(size_t, len, nandc->buf_count - nandc->buf_start);
> -
> -	memcpy(nandc->data_buffer + nandc->buf_start, buf, real_len);
> -
> -	nandc->buf_start += real_len;
> -}
> -
> -/* we support only one external chip for now */
> -static void qcom_nandc_select_chip(struct nand_chip *chip, int chipnr)
> -{
> -	struct qcom_nand_controller *nandc = get_qcom_nand_controller(chip);
> -
> -	if (chipnr <= 0)
> -		return;
> -
> -	dev_warn(nandc->dev, "invalid chip select\n");
> -}
> -
> -/*
>   * NAND controller page layout info
>   *
>   * Layout with ECC enabled:
> @@ -2738,8 +2587,207 @@ static int qcom_nand_attach_chip(struct nand_chip *chip)
>  	return 0;
>  }
>  
> +static int nandc_status(struct nand_chip *chip)
> +{
> +	struct qcom_nand_controller *nandc = get_qcom_nand_controller(chip);
> +	struct qcom_nand_host *host = to_qcom_nand_host(chip);
> +
> +	memcpy(nandc->data_buffer, &host->status, 1);
> +
> +	return 0;
> +}
> +
> +static int qcom_nand_send_command(struct nand_chip *chip, u8 command)
> +{
> +	struct qcom_nand_host *host = to_qcom_nand_host(chip);
> +	struct qcom_nand_controller *nandc = get_qcom_nand_controller(chip);
> +	struct nand_ecc_ctrl *ecc = &chip->ecc;
> +
> +	int ret = 0;
> +
> +	pre_command(host, command);
> +
> +	switch (command) {
> +	case NAND_CMD_RESET:
> +		ret = reset(host);
> +		break;
> +	case NAND_CMD_READID:
> +		nandc->buf_count = 4;
> +		ret = read_id(host, 0);
> +		break;
> +	case NAND_CMD_PARAM:
> +		ret = nandc_param(host);
> +		break;
> +	case NAND_CMD_ERASE1:
> +		ret = erase_block(host);
> +		break;
> +	case NAND_CMD_STATUS:
> +		ret = nandc_status(chip);
> +		break;
> +	case NAND_CMD_READ0:
> +		host->use_ecc = true;
> +		update_rw_regs(host, ecc->steps, true, 0);
> +		break;
> +	case NAND_CMD_ERASE2:
> +		break;
> +	case NAND_CMD_SEQIN:
> +		break;
> +	case NAND_CMD_PAGEPROG:
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	return ret;
> +}
> +
> +static int qcom_nand_send_address(struct nand_chip *chip,
> +				  const struct nand_op_instr *instr, int cmd)
> +{
> +	struct qcom_nand_controller *nandc = get_qcom_nand_controller(chip);
> +	u32 page_addr = 0x0, page_mask = 0x0;
> +
> +	page_addr = instr->ctx.addr.addrs[0];
> +
> +	/*
> +	 *Form page address for erase, read, write to using existing api
> +	 */
> +
> +	switch (cmd) {
> +	case NAND_CMD_ERASE1:
> +		page_addr = instr->ctx.addr.addrs[0];
> +		page_mask = instr->ctx.addr.addrs[1];
> +		page_mask <<= 8;
> +		page_addr = (page_addr | page_mask);
> +		page_mask = instr->ctx.addr.addrs[2];
> +		page_mask <<= 16;
> +		page_addr = (page_addr | page_mask);
> +		page_mask = instr->ctx.addr.addrs[3];
> +		page_mask <<= 24;
> +		page_addr = (page_addr | page_mask);
> +		break;
> +	case NAND_CMD_READ0:
> +	case NAND_CMD_SEQIN:
> +		page_addr = instr->ctx.addr.addrs[3];
> +		page_addr <<= 24;
> +		page_mask = instr->ctx.addr.addrs[2];
> +		page_mask <<= 16;
> +		page_addr |= page_mask;
> +		page_mask = instr->ctx.addr.addrs[1];
> +		page_mask <<= 8;
> +		page_addr |= page_mask;
> +		page_mask = instr->ctx.addr.addrs[0];
> +		page_addr |= page_mask;
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	if (cmd == NAND_CMD_PARAM)
> +		return 0;
> +
> +	nandc_set_reg(chip, NAND_ADDR0, page_addr);
> +	nandc_set_reg(chip, NAND_ADDR1, 0);
> +
> +	if (cmd != NAND_CMD_SEQIN)
> +		write_reg_dma(nandc, NAND_ADDR0, 2, 0);
> +
> +	return 0;
> +}
> +
> +static void qcom_nand_read_buf(struct nand_chip *chip, u8 *buf, int len)
> +{
> +	struct qcom_nand_controller *nandc = get_qcom_nand_controller(chip);
> +
> +	memcpy(buf, nandc->data_buffer, len);
> +}
> +
> +static int qcom_nand_exec_instr(struct nand_chip *chip,
> +				const struct nand_op_instr *instr)
> +{
> +	struct qcom_nand_controller *nandc = get_qcom_nand_controller(chip);
> +	struct qcom_nand_host *host = to_qcom_nand_host(chip);
> +	u32 status;
> +	int ret = 0;
> +	bool wait = false;
> +	static int opcode;
> +
> +	switch (instr->type) {
> +	case NAND_OP_CMD_INSTR:
> +		ret = qcom_nand_send_command(chip, instr->ctx.cmd.opcode);
> +		if (instr->ctx.cmd.opcode == NAND_CMD_RESET)
> +			wait = true;
> +		opcode = instr->ctx.cmd.opcode;
> +		break;
> +	case NAND_OP_ADDR_INSTR:
> +		qcom_nand_send_address(chip, instr, opcode);
> +		if (opcode != NAND_CMD_READ0 && opcode != NAND_CMD_READSTART &&
> +		    opcode != NAND_CMD_PARAM && opcode != NAND_CMD_SEQIN)
> +			wait = true;
> +		break;
> +	case NAND_OP_DATA_IN_INSTR:
> +		qcom_nand_read_buf(chip, instr->ctx.data.buf.in, instr->ctx.data.len);
> +		break;
> +	case NAND_OP_DATA_OUT_INSTR:
> +		wait = false;
> +		break;
> +	case NAND_OP_WAITRDY_INSTR:
> +		ret = readl_poll_timeout(nandc->base + NAND_FLASH_STATUS, status,
> +					 (status & FS_READY_BSY_N), 20,
> +					 instr->ctx.waitrdy.timeout_ms * 1000);
> +		if (opcode == NAND_CMD_PARAM)
> +			wait = true;
> +	default:
> +		break;
> +	}
> +
> +	if (wait) {
> +		if (opcode != NAND_CMD_PARAM)
> +			write_reg_dma(nandc, NAND_EXEC_CMD, 1, NAND_BAM_NEXT_SGL);
> +
> +		if (opcode == NAND_CMD_READID)
> +			read_reg_dma(nandc, NAND_READ_ID, 1, NAND_BAM_NEXT_SGL);
> +
> +		if (opcode == NAND_CMD_ERASE1) {
> +			read_reg_dma(nandc, NAND_FLASH_STATUS, 1, NAND_BAM_NEXT_SGL);
> +			write_reg_dma(nandc, NAND_FLASH_STATUS, 1, 0);
> +			write_reg_dma(nandc, NAND_READ_STATUS, 1, NAND_BAM_NEXT_SGL);
> +		}
> +
> +		ret = submit_descs(nandc);
> +		if (ret)
> +			dev_err(nandc->dev, "failure submitting descs for command 0x%02x\n",
> +				opcode);
> +
> +		free_descs(nandc);
> +		post_command(host, opcode);
> +	}
> +
> +	return ret;
> +}
> +
> +static int qcom_nand_exec_op(struct nand_chip *chip,
> +			     const struct nand_operation *op,
> +				bool check_only)
> +{
> +	unsigned int i;
> +	int ret = 0;
> +
> +	if (check_only)
> +		return 0;
> +
> +	for (i = 0; i < op->ninstrs; i++) {
> +		ret = qcom_nand_exec_instr(chip, &op->instrs[i]);
> +		if (ret)
> +			break;
> +	}
> +
> +	return ret;
> +}
> +
>  static const struct nand_controller_ops qcom_nandc_ops = {
>  	.attach_chip = qcom_nand_attach_chip,
> +	.exec_op = qcom_nand_exec_op,
>  };
>  
>  static void qcom_nandc_unalloc(struct qcom_nand_controller *nandc)
> @@ -2938,14 +2986,6 @@ static int qcom_nand_host_init_and_register(struct qcom_nand_controller *nandc,
>  	mtd->owner = THIS_MODULE;
>  	mtd->dev.parent = dev;
>  
> -	chip->legacy.cmdfunc	= qcom_nandc_command;
> -	chip->legacy.select_chip	= qcom_nandc_select_chip;
> -	chip->legacy.read_byte	= qcom_nandc_read_byte;
> -	chip->legacy.read_buf	= qcom_nandc_read_buf;
> -	chip->legacy.write_buf	= qcom_nandc_write_buf;
> -	chip->legacy.set_features	= nand_get_set_features_notsupp;
> -	chip->legacy.get_features	= nand_get_set_features_notsupp;
> -
>  	/*
>  	 * the bad block marker is readable only when we read the last codeword
>  	 * of a page with ECC disabled. currently, the nand_base and nand_bbt
> -- 
> 2.7.4
> 
