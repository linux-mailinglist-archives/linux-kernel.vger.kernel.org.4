Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 659EA6FC499
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 13:08:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235461AbjEILIq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 07:08:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235456AbjEILIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 07:08:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62D5F10A34;
        Tue,  9 May 2023 04:08:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C38A862DD8;
        Tue,  9 May 2023 11:08:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECD43C433EF;
        Tue,  9 May 2023 11:08:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683630499;
        bh=dXmLrHGxkupZiY54DWvta2OfEpwR9qKirDnx8YEOrW4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qZPDYfSz1FEyqTi4suQD6Y0fhi3af2Jfs6LePh7GPVxq0m1H3ZY7xfTsoyYyS/QsB
         CznPBAQ+33YmjohAB5b4xba4yIkgHhkRfh35HZgc+3+X4lUY+7lXS4gel5iK30JQV9
         AO0EKQCPa3Yzk8Q2CwqoSkT7tq3a0Mh3IChlcwBOyIo/i41gpG+sGhWepbQOMx4MdL
         6ossfWdDZQWz9cdzaDelgNaFscLdyyfn7YEywxByaHP/r0ndA9lfYTO7fFbb8PQmtF
         x0Zqi3X3OaDamg0OZk+QwZKcZ3Kvdl4qVk4RdpQRGk22NOn7+cchYpQsCclzyUHfEX
         7g5loE6rAwxvw==
Date:   Tue, 9 May 2023 16:38:04 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Md Sadre Alam <quic_mdalam@quicinc.com>
Cc:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        linux-mtd@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_srichara@quicinc.com
Subject: Re: [PATCH V2] mtd: rawnand: qcom: Implement exec_op()
Message-ID: <20230509110804.GC4823@thinkpad>
References: <20230419093617.27134-1-quic_mdalam@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230419093617.27134-1-quic_mdalam@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 19, 2023 at 03:06:17PM +0530, Md Sadre Alam wrote:
> Implement exec_op() so we can later get rid of the legacy interface
> implementation.
> 

It's good that you got the inspiration from previous exec_op() conversion
patches, but this one should've been splitted into atleast two patches as per
your patch description.

One introducing exec_op() and another getting rid of legacy interface.

> Co-developed-by: Sricharan R <quic_srichara@quicinc.com>
> Signed-off-by: Sricharan R <quic_srichara@quicinc.com>
> Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
> ---
> Change in [V2]
> 
> * Address all Miquel comments from V1, regarding exec_ops design
> 
> * Redesign qpic nand driver with exec_ops using exec_ops parser, to 
>   fit in exec_ops framework 
> 
>  drivers/mtd/nand/raw/qcom_nandc.c | 869 ++++++++++++++++++------------
>  1 file changed, 520 insertions(+), 349 deletions(-)
> 
> diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qcom_nandc.c
> index 72d6168d8a1b..17279890454d 100644
> --- a/drivers/mtd/nand/raw/qcom_nandc.c
> +++ b/drivers/mtd/nand/raw/qcom_nandc.c
> @@ -157,6 +157,7 @@
>  #define	OP_PAGE_PROGRAM_WITH_ECC	0x7
>  #define	OP_PROGRAM_PAGE_SPARE		0x9
>  #define	OP_BLOCK_ERASE			0xa
> +#define	OP_CHECK_STATUS			0xc
>  #define	OP_FETCH_ID			0xb
>  #define	OP_RESET_DEVICE			0xd
>  
> @@ -235,6 +236,7 @@ nandc_set_reg(chip, reg,			\
>   */
>  #define NAND_ERASED_CW_SET		BIT(4)
>  
> +#define MAX_ADDRESS_CYCLE		5
>  /*
>   * This data type corresponds to the BAM transaction which will be used for all
>   * NAND transfers.
> @@ -432,6 +434,7 @@ struct qcom_nand_controller {
>  	int reg_read_pos;
>  
>  	u32 cmd1, vld;
> +	bool exec_opwrite;

Missing kdoc.

>  };
>  
>  /*
> @@ -447,6 +450,37 @@ struct qcom_nand_boot_partition {
>  	u32 page_size;
>  };
>  
> +/*
> + * QCOM op for each exec_op transfer

What is "QCOM op"? Also please stick to "Qcom" everywhere.

> + *
> + * @addr1_reg:			Address1 register value
> + *
> + * @addr2_reg:			Address2 register value
> + *
> + * @cmd_reg:			CMD register value
> + *
> + * @rdy_timeout_ms:		wait ready timeout in ms
> + *

First letter caps for all instances.

> + * @rdy_delay_ns:		Additional delay in ns
> + *
> + * @data_instr_idx:		data instruction index
> + *
> + * @data_instr:			data instruction pointer
> + *

Do not leave this extra newline comment in-between.

> + * @flag:			flag for misc instruction
> + *
> + */
> +struct qcom_op {
> +	u32 addr1_reg;
> +	u32 addr2_reg;
> +	u32 cmd_reg;
> +	unsigned int rdy_timeout_ms;
> +	unsigned int rdy_delay_ns;
> +	unsigned int data_instr_idx;
> +	const struct nand_op_instr *data_instr;

Move the pointer to start of the struct.

> +	u8 flag;
> +};
> +
>  /*
>   * NAND chip structure
>   *
> @@ -765,7 +799,6 @@ static void set_address(struct qcom_nand_host *host, u16 column, int page)
>  
>  	if (chip->options & NAND_BUSWIDTH_16)
>  		column >>= 1;
> -

Sporadic?

>  	nandc_set_reg(chip, NAND_ADDR0, page << 16 | column);
>  	nandc_set_reg(chip, NAND_ADDR1, page >> 16 & 0xff);
>  }
> @@ -1273,155 +1306,6 @@ static void config_nand_cw_write(struct nand_chip *chip)
>  	write_reg_dma(nandc, NAND_READ_STATUS, 1, NAND_BAM_NEXT_SGL);
>  }
>  
> -/*
> - * the following functions are used within chip->legacy.cmdfunc() to
> - * perform different NAND_CMD_* commands
> - */
> -
> -/* sets up descriptors for NAND_CMD_PARAM */
> -static int nandc_param(struct qcom_nand_host *host)

As I pointed out above, you need to split these removals into a separate patch.

> -{
> -	struct nand_chip *chip = &host->chip;
> -	struct qcom_nand_controller *nandc = get_qcom_nand_controller(chip);
> -
> -	/*
> -	 * NAND_CMD_PARAM is called before we know much about the FLASH chip
> -	 * in use. we configure the controller to perform a raw read of 512
> -	 * bytes to read onfi params
> -	 */
> -	if (nandc->props->qpic_v2)
> -		nandc_set_reg(chip, NAND_FLASH_CMD, OP_PAGE_READ_ONFI_READ |
> -			      PAGE_ACC | LAST_PAGE);
> -	else
> -		nandc_set_reg(chip, NAND_FLASH_CMD, OP_PAGE_READ |
> -			      PAGE_ACC | LAST_PAGE);
> -
> -	nandc_set_reg(chip, NAND_ADDR0, 0);
> -	nandc_set_reg(chip, NAND_ADDR1, 0);
> -	nandc_set_reg(chip, NAND_DEV0_CFG0, 0 << CW_PER_PAGE
> -					| 512 << UD_SIZE_BYTES
> -					| 5 << NUM_ADDR_CYCLES
> -					| 0 << SPARE_SIZE_BYTES);
> -	nandc_set_reg(chip, NAND_DEV0_CFG1, 7 << NAND_RECOVERY_CYCLES
> -					| 0 << CS_ACTIVE_BSY
> -					| 17 << BAD_BLOCK_BYTE_NUM
> -					| 1 << BAD_BLOCK_IN_SPARE_AREA
> -					| 2 << WR_RD_BSY_GAP
> -					| 0 << WIDE_FLASH
> -					| 1 << DEV0_CFG1_ECC_DISABLE);
> -	if (!nandc->props->qpic_v2)
> -		nandc_set_reg(chip, NAND_EBI2_ECC_BUF_CFG, 1 << ECC_CFG_ECC_DISABLE);
> -
> -	/* configure CMD1 and VLD for ONFI param probing in QPIC v1 */
> -	if (!nandc->props->qpic_v2) {
> -		nandc_set_reg(chip, NAND_DEV_CMD_VLD,
> -			      (nandc->vld & ~READ_START_VLD));
> -		nandc_set_reg(chip, NAND_DEV_CMD1,
> -			      (nandc->cmd1 & ~(0xFF << READ_ADDR))
> -			      | NAND_CMD_PARAM << READ_ADDR);
> -	}
> -
> -	nandc_set_reg(chip, NAND_EXEC_CMD, 1);
> -
> -	if (!nandc->props->qpic_v2) {
> -		nandc_set_reg(chip, NAND_DEV_CMD1_RESTORE, nandc->cmd1);
> -		nandc_set_reg(chip, NAND_DEV_CMD_VLD_RESTORE, nandc->vld);
> -	}
> -
> -	nandc_set_read_loc(chip, 0, 0, 0, 512, 1);
> -
> -	if (!nandc->props->qpic_v2) {
> -		write_reg_dma(nandc, NAND_DEV_CMD_VLD, 1, 0);
> -		write_reg_dma(nandc, NAND_DEV_CMD1, 1, NAND_BAM_NEXT_SGL);
> -	}
> -
> -	nandc->buf_count = 512;
> -	memset(nandc->data_buffer, 0xff, nandc->buf_count);
> -
> -	config_nand_single_cw_page_read(chip, false, 0);
> -
> -	read_data_dma(nandc, FLASH_BUF_ACC, nandc->data_buffer,
> -		      nandc->buf_count, 0);
> -
> -	/* restore CMD1 and VLD regs */
> -	if (!nandc->props->qpic_v2) {
> -		write_reg_dma(nandc, NAND_DEV_CMD1_RESTORE, 1, 0);
> -		write_reg_dma(nandc, NAND_DEV_CMD_VLD_RESTORE, 1, NAND_BAM_NEXT_SGL);
> -	}
> -
> -	return 0;
> -}

[...]

>  /*
>   * when using BCH ECC, the HW flags an error in NAND_FLASH_STATUS if it read
>   * an erased CW, and reports an erased CW in NAND_ERASED_CW_DETECT_STATUS.
> @@ -1735,7 +1491,8 @@ qcom_nandc_read_cw_raw(struct mtd_info *mtd, struct nand_chip *chip,
>  	int ret, reg_off = FLASH_BUF_ACC, read_loc = 0;
>  	int raw_cw = cw;
>  
> -	nand_read_page_op(chip, page, 0, NULL, 0);
> +	chip->cont_read.ongoing = false;
> +	nand_read_page_op(chip, page, 0, data_buf, 2048);

How is this change related to exec_op() conversion? Looks like this and few
things below should be part of a separate patch.

>  	host->use_ecc = false;
>  
>  	if (nandc->props->qpic_v2)
> @@ -2047,7 +1804,9 @@ static int read_page_ecc(struct qcom_nand_host *host, u8 *data_buf,
>  		return ret;
>  	}
>  
> -	return parse_read_errors(host, data_buf_start, oob_buf_start, page);
> +	ret = parse_read_errors(host, data_buf_start, oob_buf_start, page);
> +
> +	return ret;

Why?

>  }
>  
>  /*
> @@ -2154,12 +1913,25 @@ static int qcom_nandc_read_page(struct nand_chip *chip, uint8_t *buf,
>  {
>  	struct qcom_nand_host *host = to_qcom_nand_host(chip);
>  	struct qcom_nand_controller *nandc = get_qcom_nand_controller(chip);
> +	struct nand_ecc_ctrl *ecc = &chip->ecc;
>  	u8 *data_buf, *oob_buf = NULL;
> +	int ret = 0;
>  
>  	if (host->nr_boot_partitions)
>  		qcom_nandc_codeword_fixup(host, page);
>  
> -	nand_read_page_op(chip, page, 0, NULL, 0);
> +	chip->cont_read.ongoing = false;
> +	ret = nand_read_page_op(chip, page, 0, buf, 2048);
> +	if (ret)
> +		return ret;
> +
> +	nandc->buf_count = 0;
> +	nandc->buf_start = 0;
> +	host->use_ecc = true;
> +	clear_read_regs(nandc);
> +	set_address(host, 0, page);
> +	update_rw_regs(host, ecc->steps, true, 0);
> +
>  	data_buf = buf;
>  	oob_buf = oob_required ? chip->oob_poi : NULL;
>  
> @@ -2229,6 +2001,10 @@ static int qcom_nandc_write_page(struct nand_chip *chip, const uint8_t *buf,
>  
>  	nand_prog_page_begin_op(chip, page, 0, NULL, 0);
>  
> +	set_address(host, 0, page);
> +	nandc->buf_count = 0;
> +	nandc->buf_start = 0;
> +

As said above, you need a separate patch for the above change. I do not get the
context of the above change.

And I stopped reviewing here. It's hard to review ~800 lines of change in one
shot. Please split this patch into sensible chunks so that it makes life easy
for reviewers.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
