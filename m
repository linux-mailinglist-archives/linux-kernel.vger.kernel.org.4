Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6CD36E7692
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 11:43:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232199AbjDSJnE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 05:43:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231349AbjDSJm5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 05:42:57 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB018118FF;
        Wed, 19 Apr 2023 02:42:23 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33J9X0UW022640;
        Wed, 19 Apr 2023 09:42:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=enV3Ou49TQ0tLJ+4BRLx5tgiLXn3WtfctN4VoKv5ZXk=;
 b=OmvWWNK3ldt1sr+pmRdd4TbjCG/mQ3VkSfpBoLevlI1SeCC8WNZkuB9LZySMxbokIjkt
 4KcrertNWPpEV6ZaEINdWoYO86jSxCvEnzCIafAEgDySyNyHpRFGsCFdbZRFytzx5C6/
 WF8XLuZI2qeUtK/IyISqoKKgYdllYi58wZ9W+1wBmHe+lSW/SBmxYsIN3qoh/t8yk9Cw
 qwUGmnnXCSMx5DKbt6kJvBVzQyZ+9KoMuDRHL6ByR4EJ5+BGas38wDSlJ1jVygGwdqtc
 1leVUvXH4dmzPnlFQOjkTKJKRi9WJlcprtbngiJOYdBRrOg3xME5syKYqA81PGp7ehwS VQ== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3q26wy0t84-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Apr 2023 09:41:59 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33J9fxap009876
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Apr 2023 09:41:59 GMT
Received: from [10.201.3.104] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Wed, 19 Apr
 2023 02:41:55 -0700
Message-ID: <525bd97f-df56-a1bc-06d5-9b4e453810e5@quicinc.com>
Date:   Wed, 19 Apr 2023 15:11:51 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] mtd: rawnand: qcom: Implement exec_op()
Content-Language: en-US
To:     Manivannan Sadhasivam <mani@kernel.org>
CC:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_srichara@quicinc.com>
References: <1654273498-31998-1-git-send-email-quic_mdalam@quicinc.com>
 <20220915134328.GD4550@workstation>
From:   Md Sadre Alam <quic_mdalam@quicinc.com>
In-Reply-To: <20220915134328.GD4550@workstation>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: W4Z73tbOUoyOXUb7dZg7mfDjT-f1ubCa
X-Proofpoint-ORIG-GUID: W4Z73tbOUoyOXUb7dZg7mfDjT-f1ubCa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-19_05,2023-04-18_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 clxscore=1015 mlxscore=0 malwarescore=0 spamscore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304190086
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/15/2022 7:13 PM, Manivannan Sadhasivam wrote:
> On Fri, Jun 03, 2022 at 09:54:58PM +0530, Md Sadre Alam wrote:
>> Implement exec_op() so we can later get rid of the legacy interface
>> implementation.
>>
>> Co-developed-by: Sricharan R <quic_srichara@quicinc.com>
>> Signed-off-by: Sricharan R <quic_srichara@quicinc.com>
>> Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
> 
> Sadre, Sri, any update on this patch?
> 
> Thanks,
> Mani
>

Hi Mani,

I have sent V2 patch and address all the comments from patch V1.

https://lore.kernel.org/lkml/20230419093617.27134-1-quic_mdalam@quicinc.com/

Thanks,
Alam.

>> ---
>>   drivers/mtd/nand/raw/qcom_nandc.c | 368 +++++++++++++++++++++-----------------
>>   1 file changed, 204 insertions(+), 164 deletions(-)
>>
>> diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qcom_nandc.c
>> index 048b255..507921b 100644
>> --- a/drivers/mtd/nand/raw/qcom_nandc.c
>> +++ b/drivers/mtd/nand/raw/qcom_nandc.c
>> @@ -14,6 +14,7 @@
>>   #include <linux/of.h>
>>   #include <linux/of_device.h>
>>   #include <linux/delay.h>
>> +#include <linux/iopoll.h>
>>   #include <linux/dma/qcom_bam_dma.h>
>>   
>>   /* NANDc reg offsets */
>> @@ -1305,15 +1306,13 @@ static int nandc_param(struct qcom_nand_host *host)
>>   }
>>   
>>   /* sets up descriptors for NAND_CMD_ERASE1 */
>> -static int erase_block(struct qcom_nand_host *host, int page_addr)
>> +static int erase_block(struct qcom_nand_host *host)
>>   {
>>   	struct nand_chip *chip = &host->chip;
>>   	struct qcom_nand_controller *nandc = get_qcom_nand_controller(chip);
>>   
>>   	nandc_set_reg(chip, NAND_FLASH_CMD,
>>   		      OP_BLOCK_ERASE | PAGE_ACC | LAST_PAGE);
>> -	nandc_set_reg(chip, NAND_ADDR0, page_addr);
>> -	nandc_set_reg(chip, NAND_ADDR1, 0);
>>   	nandc_set_reg(chip, NAND_DEV0_CFG0,
>>   		      host->cfg0_raw & ~(7 << CW_PER_PAGE));
>>   	nandc_set_reg(chip, NAND_DEV0_CFG1, host->cfg1_raw);
>> @@ -1321,14 +1320,8 @@ static int erase_block(struct qcom_nand_host *host, int page_addr)
>>   	nandc_set_reg(chip, NAND_FLASH_STATUS, host->clrflashstatus);
>>   	nandc_set_reg(chip, NAND_READ_STATUS, host->clrreadstatus);
>>   
>> -	write_reg_dma(nandc, NAND_FLASH_CMD, 3, NAND_BAM_NEXT_SGL);
>> +	write_reg_dma(nandc, NAND_FLASH_CMD, 1, NAND_BAM_NEXT_SGL);
>>   	write_reg_dma(nandc, NAND_DEV0_CFG0, 2, NAND_BAM_NEXT_SGL);
>> -	write_reg_dma(nandc, NAND_EXEC_CMD, 1, NAND_BAM_NEXT_SGL);
>> -
>> -	read_reg_dma(nandc, NAND_FLASH_STATUS, 1, NAND_BAM_NEXT_SGL);
>> -
>> -	write_reg_dma(nandc, NAND_FLASH_STATUS, 1, 0);
>> -	write_reg_dma(nandc, NAND_READ_STATUS, 1, NAND_BAM_NEXT_SGL);
>>   
>>   	return 0;
>>   }
>> @@ -1343,16 +1336,12 @@ static int read_id(struct qcom_nand_host *host, int column)
>>   		return 0;
>>   
>>   	nandc_set_reg(chip, NAND_FLASH_CMD, OP_FETCH_ID);
>> -	nandc_set_reg(chip, NAND_ADDR0, column);
>> -	nandc_set_reg(chip, NAND_ADDR1, 0);
>>   	nandc_set_reg(chip, NAND_FLASH_CHIP_SELECT,
>>   		      nandc->props->is_bam ? 0 : DM_EN);
>>   	nandc_set_reg(chip, NAND_EXEC_CMD, 1);
>>   
>> -	write_reg_dma(nandc, NAND_FLASH_CMD, 4, NAND_BAM_NEXT_SGL);
>> -	write_reg_dma(nandc, NAND_EXEC_CMD, 1, NAND_BAM_NEXT_SGL);
>> -
>> -	read_reg_dma(nandc, NAND_READ_ID, 1, NAND_BAM_NEXT_SGL);
>> +	write_reg_dma(nandc, NAND_FLASH_CMD, 1, NAND_BAM_NEXT_SGL);
>> +	write_reg_dma(nandc, NAND_FLASH_CHIP_SELECT, 1, NAND_BAM_NEXT_SGL);
>>   
>>   	return 0;
>>   }
>> @@ -1491,7 +1480,6 @@ static void parse_erase_write_errors(struct qcom_nand_host *host, int command)
>>   
>>   	for (i = 0; i < num_cw; i++) {
>>   		u32 flash_status = le32_to_cpu(nandc->reg_read_buf[i]);
>> -
>>   		if (flash_status & FS_MPU_ERR)
>>   			host->status &= ~NAND_STATUS_WP;
>>   
>> @@ -1523,86 +1511,6 @@ static void post_command(struct qcom_nand_host *host, int command)
>>   }
>>   
>>   /*
>> - * Implements chip->legacy.cmdfunc. It's  only used for a limited set of
>> - * commands. The rest of the commands wouldn't be called by upper layers.
>> - * For example, NAND_CMD_READOOB would never be called because we have our own
>> - * versions of read_oob ops for nand_ecc_ctrl.
>> - */
>> -static void qcom_nandc_command(struct nand_chip *chip, unsigned int command,
>> -			       int column, int page_addr)
>> -{
>> -	struct qcom_nand_host *host = to_qcom_nand_host(chip);
>> -	struct nand_ecc_ctrl *ecc = &chip->ecc;
>> -	struct qcom_nand_controller *nandc = get_qcom_nand_controller(chip);
>> -	bool wait = false;
>> -	int ret = 0;
>> -
>> -	pre_command(host, command);
>> -
>> -	switch (command) {
>> -	case NAND_CMD_RESET:
>> -		ret = reset(host);
>> -		wait = true;
>> -		break;
>> -
>> -	case NAND_CMD_READID:
>> -		nandc->buf_count = 4;
>> -		ret = read_id(host, column);
>> -		wait = true;
>> -		break;
>> -
>> -	case NAND_CMD_PARAM:
>> -		ret = nandc_param(host);
>> -		wait = true;
>> -		break;
>> -
>> -	case NAND_CMD_ERASE1:
>> -		ret = erase_block(host, page_addr);
>> -		wait = true;
>> -		break;
>> -
>> -	case NAND_CMD_READ0:
>> -		/* we read the entire page for now */
>> -		WARN_ON(column != 0);
>> -
>> -		host->use_ecc = true;
>> -		set_address(host, 0, page_addr);
>> -		update_rw_regs(host, ecc->steps, true, 0);
>> -		break;
>> -
>> -	case NAND_CMD_SEQIN:
>> -		WARN_ON(column != 0);
>> -		set_address(host, 0, page_addr);
>> -		break;
>> -
>> -	case NAND_CMD_PAGEPROG:
>> -	case NAND_CMD_STATUS:
>> -	case NAND_CMD_NONE:
>> -	default:
>> -		break;
>> -	}
>> -
>> -	if (ret) {
>> -		dev_err(nandc->dev, "failure executing command %d\n",
>> -			command);
>> -		free_descs(nandc);
>> -		return;
>> -	}
>> -
>> -	if (wait) {
>> -		ret = submit_descs(nandc);
>> -		if (ret)
>> -			dev_err(nandc->dev,
>> -				"failure submitting descs for command %d\n",
>> -				command);
>> -	}
>> -
>> -	free_descs(nandc);
>> -
>> -	post_command(host, command);
>> -}
>> -
>> -/*
>>    * when using BCH ECC, the HW flags an error in NAND_FLASH_STATUS if it read
>>    * an erased CW, and reports an erased CW in NAND_ERASED_CW_DETECT_STATUS.
>>    *
>> @@ -2044,7 +1952,6 @@ static int qcom_nandc_read_page(struct nand_chip *chip, uint8_t *buf,
>>   	struct qcom_nand_host *host = to_qcom_nand_host(chip);
>>   	struct qcom_nand_controller *nandc = get_qcom_nand_controller(chip);
>>   	u8 *data_buf, *oob_buf = NULL;
>> -
>>   	nand_read_page_op(chip, page, 0, NULL, 0);
>>   	data_buf = buf;
>>   	oob_buf = oob_required ? chip->oob_poi : NULL;
>> @@ -2366,64 +2273,6 @@ static int qcom_nandc_block_markbad(struct nand_chip *chip, loff_t ofs)
>>   }
>>   
>>   /*
>> - * the three functions below implement chip->legacy.read_byte(),
>> - * chip->legacy.read_buf() and chip->legacy.write_buf() respectively. these
>> - * aren't used for reading/writing page data, they are used for smaller data
>> - * like reading	id, status etc
>> - */
>> -static uint8_t qcom_nandc_read_byte(struct nand_chip *chip)
>> -{
>> -	struct qcom_nand_host *host = to_qcom_nand_host(chip);
>> -	struct qcom_nand_controller *nandc = get_qcom_nand_controller(chip);
>> -	u8 *buf = nandc->data_buffer;
>> -	u8 ret = 0x0;
>> -
>> -	if (host->last_command == NAND_CMD_STATUS) {
>> -		ret = host->status;
>> -
>> -		host->status = NAND_STATUS_READY | NAND_STATUS_WP;
>> -
>> -		return ret;
>> -	}
>> -
>> -	if (nandc->buf_start < nandc->buf_count)
>> -		ret = buf[nandc->buf_start++];
>> -
>> -	return ret;
>> -}
>> -
>> -static void qcom_nandc_read_buf(struct nand_chip *chip, uint8_t *buf, int len)
>> -{
>> -	struct qcom_nand_controller *nandc = get_qcom_nand_controller(chip);
>> -	int real_len = min_t(size_t, len, nandc->buf_count - nandc->buf_start);
>> -
>> -	memcpy(buf, nandc->data_buffer + nandc->buf_start, real_len);
>> -	nandc->buf_start += real_len;
>> -}
>> -
>> -static void qcom_nandc_write_buf(struct nand_chip *chip, const uint8_t *buf,
>> -				 int len)
>> -{
>> -	struct qcom_nand_controller *nandc = get_qcom_nand_controller(chip);
>> -	int real_len = min_t(size_t, len, nandc->buf_count - nandc->buf_start);
>> -
>> -	memcpy(nandc->data_buffer + nandc->buf_start, buf, real_len);
>> -
>> -	nandc->buf_start += real_len;
>> -}
>> -
>> -/* we support only one external chip for now */
>> -static void qcom_nandc_select_chip(struct nand_chip *chip, int chipnr)
>> -{
>> -	struct qcom_nand_controller *nandc = get_qcom_nand_controller(chip);
>> -
>> -	if (chipnr <= 0)
>> -		return;
>> -
>> -	dev_warn(nandc->dev, "invalid chip select\n");
>> -}
>> -
>> -/*
>>    * NAND controller page layout info
>>    *
>>    * Layout with ECC enabled:
>> @@ -2738,8 +2587,207 @@ static int qcom_nand_attach_chip(struct nand_chip *chip)
>>   	return 0;
>>   }
>>   
>> +static int nandc_status(struct nand_chip *chip)
>> +{
>> +	struct qcom_nand_controller *nandc = get_qcom_nand_controller(chip);
>> +	struct qcom_nand_host *host = to_qcom_nand_host(chip);
>> +
>> +	memcpy(nandc->data_buffer, &host->status, 1);
>> +
>> +	return 0;
>> +}
>> +
>> +static int qcom_nand_send_command(struct nand_chip *chip, u8 command)
>> +{
>> +	struct qcom_nand_host *host = to_qcom_nand_host(chip);
>> +	struct qcom_nand_controller *nandc = get_qcom_nand_controller(chip);
>> +	struct nand_ecc_ctrl *ecc = &chip->ecc;
>> +
>> +	int ret = 0;
>> +
>> +	pre_command(host, command);
>> +
>> +	switch (command) {
>> +	case NAND_CMD_RESET:
>> +		ret = reset(host);
>> +		break;
>> +	case NAND_CMD_READID:
>> +		nandc->buf_count = 4;
>> +		ret = read_id(host, 0);
>> +		break;
>> +	case NAND_CMD_PARAM:
>> +		ret = nandc_param(host);
>> +		break;
>> +	case NAND_CMD_ERASE1:
>> +		ret = erase_block(host);
>> +		break;
>> +	case NAND_CMD_STATUS:
>> +		ret = nandc_status(chip);
>> +		break;
>> +	case NAND_CMD_READ0:
>> +		host->use_ecc = true;
>> +		update_rw_regs(host, ecc->steps, true, 0);
>> +		break;
>> +	case NAND_CMD_ERASE2:
>> +		break;
>> +	case NAND_CMD_SEQIN:
>> +		break;
>> +	case NAND_CMD_PAGEPROG:
>> +		break;
>> +	default:
>> +		break;
>> +	}
>> +
>> +	return ret;
>> +}
>> +
>> +static int qcom_nand_send_address(struct nand_chip *chip,
>> +				  const struct nand_op_instr *instr, int cmd)
>> +{
>> +	struct qcom_nand_controller *nandc = get_qcom_nand_controller(chip);
>> +	u32 page_addr = 0x0, page_mask = 0x0;
>> +
>> +	page_addr = instr->ctx.addr.addrs[0];
>> +
>> +	/*
>> +	 *Form page address for erase, read, write to using existing api
>> +	 */
>> +
>> +	switch (cmd) {
>> +	case NAND_CMD_ERASE1:
>> +		page_addr = instr->ctx.addr.addrs[0];
>> +		page_mask = instr->ctx.addr.addrs[1];
>> +		page_mask <<= 8;
>> +		page_addr = (page_addr | page_mask);
>> +		page_mask = instr->ctx.addr.addrs[2];
>> +		page_mask <<= 16;
>> +		page_addr = (page_addr | page_mask);
>> +		page_mask = instr->ctx.addr.addrs[3];
>> +		page_mask <<= 24;
>> +		page_addr = (page_addr | page_mask);
>> +		break;
>> +	case NAND_CMD_READ0:
>> +	case NAND_CMD_SEQIN:
>> +		page_addr = instr->ctx.addr.addrs[3];
>> +		page_addr <<= 24;
>> +		page_mask = instr->ctx.addr.addrs[2];
>> +		page_mask <<= 16;
>> +		page_addr |= page_mask;
>> +		page_mask = instr->ctx.addr.addrs[1];
>> +		page_mask <<= 8;
>> +		page_addr |= page_mask;
>> +		page_mask = instr->ctx.addr.addrs[0];
>> +		page_addr |= page_mask;
>> +		break;
>> +	default:
>> +		break;
>> +	}
>> +
>> +	if (cmd == NAND_CMD_PARAM)
>> +		return 0;
>> +
>> +	nandc_set_reg(chip, NAND_ADDR0, page_addr);
>> +	nandc_set_reg(chip, NAND_ADDR1, 0);
>> +
>> +	if (cmd != NAND_CMD_SEQIN)
>> +		write_reg_dma(nandc, NAND_ADDR0, 2, 0);
>> +
>> +	return 0;
>> +}
>> +
>> +static void qcom_nand_read_buf(struct nand_chip *chip, u8 *buf, int len)
>> +{
>> +	struct qcom_nand_controller *nandc = get_qcom_nand_controller(chip);
>> +
>> +	memcpy(buf, nandc->data_buffer, len);
>> +}
>> +
>> +static int qcom_nand_exec_instr(struct nand_chip *chip,
>> +				const struct nand_op_instr *instr)
>> +{
>> +	struct qcom_nand_controller *nandc = get_qcom_nand_controller(chip);
>> +	struct qcom_nand_host *host = to_qcom_nand_host(chip);
>> +	u32 status;
>> +	int ret = 0;
>> +	bool wait = false;
>> +	static int opcode;
>> +
>> +	switch (instr->type) {
>> +	case NAND_OP_CMD_INSTR:
>> +		ret = qcom_nand_send_command(chip, instr->ctx.cmd.opcode);
>> +		if (instr->ctx.cmd.opcode == NAND_CMD_RESET)
>> +			wait = true;
>> +		opcode = instr->ctx.cmd.opcode;
>> +		break;
>> +	case NAND_OP_ADDR_INSTR:
>> +		qcom_nand_send_address(chip, instr, opcode);
>> +		if (opcode != NAND_CMD_READ0 && opcode != NAND_CMD_READSTART &&
>> +		    opcode != NAND_CMD_PARAM && opcode != NAND_CMD_SEQIN)
>> +			wait = true;
>> +		break;
>> +	case NAND_OP_DATA_IN_INSTR:
>> +		qcom_nand_read_buf(chip, instr->ctx.data.buf.in, instr->ctx.data.len);
>> +		break;
>> +	case NAND_OP_DATA_OUT_INSTR:
>> +		wait = false;
>> +		break;
>> +	case NAND_OP_WAITRDY_INSTR:
>> +		ret = readl_poll_timeout(nandc->base + NAND_FLASH_STATUS, status,
>> +					 (status & FS_READY_BSY_N), 20,
>> +					 instr->ctx.waitrdy.timeout_ms * 1000);
>> +		if (opcode == NAND_CMD_PARAM)
>> +			wait = true;
>> +	default:
>> +		break;
>> +	}
>> +
>> +	if (wait) {
>> +		if (opcode != NAND_CMD_PARAM)
>> +			write_reg_dma(nandc, NAND_EXEC_CMD, 1, NAND_BAM_NEXT_SGL);
>> +
>> +		if (opcode == NAND_CMD_READID)
>> +			read_reg_dma(nandc, NAND_READ_ID, 1, NAND_BAM_NEXT_SGL);
>> +
>> +		if (opcode == NAND_CMD_ERASE1) {
>> +			read_reg_dma(nandc, NAND_FLASH_STATUS, 1, NAND_BAM_NEXT_SGL);
>> +			write_reg_dma(nandc, NAND_FLASH_STATUS, 1, 0);
>> +			write_reg_dma(nandc, NAND_READ_STATUS, 1, NAND_BAM_NEXT_SGL);
>> +		}
>> +
>> +		ret = submit_descs(nandc);
>> +		if (ret)
>> +			dev_err(nandc->dev, "failure submitting descs for command 0x%02x\n",
>> +				opcode);
>> +
>> +		free_descs(nandc);
>> +		post_command(host, opcode);
>> +	}
>> +
>> +	return ret;
>> +}
>> +
>> +static int qcom_nand_exec_op(struct nand_chip *chip,
>> +			     const struct nand_operation *op,
>> +				bool check_only)
>> +{
>> +	unsigned int i;
>> +	int ret = 0;
>> +
>> +	if (check_only)
>> +		return 0;
>> +
>> +	for (i = 0; i < op->ninstrs; i++) {
>> +		ret = qcom_nand_exec_instr(chip, &op->instrs[i]);
>> +		if (ret)
>> +			break;
>> +	}
>> +
>> +	return ret;
>> +}
>> +
>>   static const struct nand_controller_ops qcom_nandc_ops = {
>>   	.attach_chip = qcom_nand_attach_chip,
>> +	.exec_op = qcom_nand_exec_op,
>>   };
>>   
>>   static void qcom_nandc_unalloc(struct qcom_nand_controller *nandc)
>> @@ -2938,14 +2986,6 @@ static int qcom_nand_host_init_and_register(struct qcom_nand_controller *nandc,
>>   	mtd->owner = THIS_MODULE;
>>   	mtd->dev.parent = dev;
>>   
>> -	chip->legacy.cmdfunc	= qcom_nandc_command;
>> -	chip->legacy.select_chip	= qcom_nandc_select_chip;
>> -	chip->legacy.read_byte	= qcom_nandc_read_byte;
>> -	chip->legacy.read_buf	= qcom_nandc_read_buf;
>> -	chip->legacy.write_buf	= qcom_nandc_write_buf;
>> -	chip->legacy.set_features	= nand_get_set_features_notsupp;
>> -	chip->legacy.get_features	= nand_get_set_features_notsupp;
>> -
>>   	/*
>>   	 * the bad block marker is readable only when we read the last codeword
>>   	 * of a page with ECC disabled. currently, the nand_base and nand_bbt
>> -- 
>> 2.7.4
>>
