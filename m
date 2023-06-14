Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FA91730117
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 16:01:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245337AbjFNOBo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 10:01:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245264AbjFNOBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 10:01:41 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FA74E62;
        Wed, 14 Jun 2023 07:01:39 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35EAqDC7014640;
        Wed, 14 Jun 2023 14:01:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=r/QJ5fAwW0n8cil9PlzvW1b1KG9pmM+MhFdKRtgUXcI=;
 b=LaDPuwGWANJpuSXn8rLYDdoqzJYHBZrYCHgAH5rxJ1b1C8ncxgsPLEuiIuJLTCepHcSa
 LwqBMaIT3uoMvE1gbfLnu6hrb/PcSH7k7cNm2nHnhIbjMJ8RvC7hlx5ozyiJdrFl4/y2
 1Hx+tGZku4fwXDQlZ7O8cPVZbEWgrK40+UopEarHoeWNySm1XPbpiw9BvbA641QvCEs/
 Z0QHtIDXG8JRE8p81xRsSPDjqwtSvdm2Lwcvm3EgSPPj/mqeqmBd/OeorxEj7II51s2m
 5PbxGSJp3us01qg3CezGXx1IVx7msos1Nxf+vzPFl1entITQZwv6AypzP9el8MNJ28fC Zg== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r6s3wtxma-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Jun 2023 14:01:18 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35EE1Htq011867
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Jun 2023 14:01:17 GMT
Received: from [10.201.3.104] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Wed, 14 Jun
 2023 07:01:14 -0700
Message-ID: <dc33bf26-cfb8-0ed2-41c3-4d8da7f482c5@quicinc.com>
Date:   Wed, 14 Jun 2023 19:31:11 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v3 2/5] mtd: rawnand: qcom: Add support for reset, readid,
 status exec_op
To:     Miquel Raynal <miquel.raynal@bootlin.com>
CC:     <mani@kernel.org>, <richard@nod.at>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_srichara@quicinc.com>
References: <20230531124953.21007-1-quic_mdalam@quicinc.com>
 <20230531124953.21007-2-quic_mdalam@quicinc.com>
 <20230608155819.4b1e4276@xps-13>
Content-Language: en-US
From:   Md Sadre Alam <quic_mdalam@quicinc.com>
In-Reply-To: <20230608155819.4b1e4276@xps-13>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Mmm96WBZfO4nbEuATtizjseInzHXM0tY
X-Proofpoint-GUID: Mmm96WBZfO4nbEuATtizjseInzHXM0tY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-14_10,2023-06-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 adultscore=0 mlxlogscore=999 mlxscore=0 suspectscore=0 lowpriorityscore=0
 malwarescore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2305260000 definitions=main-2306140122
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/8/2023 7:28 PM, Miquel Raynal wrote:
> Hello,
> 
> quic_mdalam@quicinc.com wrote on Wed, 31 May 2023 18:19:50 +0530:
> 
>> This change will add exec_ops support for RESET , READ_ID, STATUS
>> command.
> 
> Imperative form here and after in your commit log please.
> 
> Add support for...
> 
> Minor comments below, otherwise looks good.

   Thanks, I will update commit message in all the patches in next
   patch V4.

> 
>>
>> Co-developed-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
>> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
>> Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
>> ---
>> Change in [v3]
>>
>> * Updated q_op->flag in qcom_op_cmd_mapping() with OP_PROGRAM_PAGE
>>    instead NAND_CMD_PAGEPROG
>>
>> * Change the if condition check for exec_opwrite into single line check.
>>
>> * Added error check
>>
>> * Removed check for NAND_CMD_RESET, NAND_CMD_READID from pre_command.
>>
>> Change in [v2]
>>
>> * Missed to post Cover-letter, so posting v2 patch with cover-letter
>>
>> Change in [v1]
>>
>> * Added initial support for exec_ops.
>>     
>>   drivers/mtd/nand/raw/qcom_nandc.c | 218 +++++++++++++++++++++++++++++-
>>   1 file changed, 215 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qcom_nandc.c
>> index 6a83cd86a12d..659ba923b68a 100644
>> --- a/drivers/mtd/nand/raw/qcom_nandc.c
>> +++ b/drivers/mtd/nand/raw/qcom_nandc.c
>> @@ -385,6 +385,9 @@ struct nandc_regs {
>>    * @reg_read_pos:		marker for data read in reg_read_buf
>>    *
>>    * @cmd1/vld:			some fixed controller register values
>> + *
>> + * @exec_opwrite:		flag to select correct number of code word
>> + *				while reading status
>>    */
>>   struct qcom_nand_controller {
>>   	struct device *dev;
>> @@ -435,6 +438,7 @@ struct qcom_nand_controller {
>>   	int reg_read_pos;
>>   
>>   	u32 cmd1, vld;
>> +	bool exec_opwrite;
>>   };
>>   
>>   /*
>> @@ -1542,8 +1546,7 @@ static void pre_command(struct qcom_nand_host *host, int command)
>>   
>>   	clear_read_regs(nandc);
>>   
>> -	if (command == NAND_CMD_RESET || command == NAND_CMD_READID ||
>> -	    command == NAND_CMD_PARAM || command == NAND_CMD_ERASE1)
>> +	if (command == NAND_CMD_PARAM || command == NAND_CMD_ERASE1)
>>   		clear_bam_transaction(nandc);
>>   }
>>   
>> @@ -2920,6 +2923,8 @@ static int qcom_op_cmd_mapping(struct qcom_nand_controller *nandc, u8 cmd,
>>   		break;
>>   	case NAND_CMD_PAGEPROG:
>>   		ret = OP_PROGRAM_PAGE;
>> +		q_op->flag = OP_PROGRAM_PAGE;
>> +		nandc->exec_opwrite = true;
>>   		break;
>>   	default:
>>   		break;
>> @@ -2982,6 +2987,212 @@ static void qcom_parse_instructions(struct nand_chip *chip,
>>   	}
>>   }
>>   
>> +static void qcom_delay_ns(unsigned int ns)
>> +{
>> +	if (!ns)
>> +		return;
>> +
>> +	if (ns < 10000)
>> +		ndelay(ns);
>> +	else
>> +		udelay(DIV_ROUND_UP(ns, 1000));
>> +}
>> +
>> +static int qcom_wait_rdy_poll(struct nand_chip *chip, unsigned int time_ms)
>> +{
>> +	struct qcom_nand_controller *nandc = get_qcom_nand_controller(chip);
>> +	unsigned long start = jiffies + msecs_to_jiffies(time_ms);
>> +	u32 flash;
>> +
>> +	nandc_read_buffer_sync(nandc, true);
>> +
>> +	do {
>> +		flash = le32_to_cpu(nandc->reg_read_buf[0]);
>> +		if (flash & FS_READY_BSY_N)
>> +			return 0;
>> +		cpu_relax();
>> +	} while (time_after(start, jiffies));
>> +
>> +	dev_err(nandc->dev, "Timeout waiting for device to be ready:0x%08x\n", flash);
>> +
>> +	return -ETIMEDOUT;
>> +}
>> +
>> +static int qcom_read_status_exec(struct nand_chip *chip,
>> +				 const struct nand_subop *subop)
>> +{
>> +	struct qcom_nand_host *host = to_qcom_nand_host(chip);
>> +	struct qcom_nand_controller *nandc = get_qcom_nand_controller(chip);
>> +	struct nand_ecc_ctrl *ecc = &chip->ecc;
>> +	struct qcom_op q_op;
>> +	const struct nand_op_instr *instr = NULL;
>> +	unsigned int op_id = 0;
>> +	unsigned int len = 0;
>> +	int ret = 0, num_cw, i;
>> +	u32 flash_status;
>> +
>> +	host->status = NAND_STATUS_READY | NAND_STATUS_WP;
>> +
>> +	qcom_parse_instructions(chip, subop, &q_op);
>> +
>> +	num_cw = nandc->exec_opwrite ? ecc->steps : 1;
>> +	nandc->exec_opwrite = false;
>> +
>> +	nandc->buf_count = 0;
>> +	nandc->buf_start = 0;
>> +	host->use_ecc = false;
>> +
>> +	clear_read_regs(nandc);
>> +	clear_bam_transaction(nandc);
>> +
>> +	nandc_set_reg(chip, NAND_FLASH_CMD, q_op.cmd_reg);
>> +	nandc_set_reg(chip, NAND_EXEC_CMD, 1);
>> +
>> +	write_reg_dma(nandc, NAND_FLASH_CMD, 1, NAND_BAM_NEXT_SGL);
>> +	write_reg_dma(nandc, NAND_EXEC_CMD, 1, NAND_BAM_NEXT_SGL);
>> +	read_reg_dma(nandc, NAND_FLASH_STATUS, 1, NAND_BAM_NEXT_SGL);
>> +
>> +	ret = submit_descs(nandc);
>> +	if (ret) {
>> +		dev_err(nandc->dev, "failure in sbumitting status descriptor\n");
> 
>                                                   ^
> 
> Please run checkpatch.pl --strict

   Thanks for pointing this, its spelling mistake. I will fix this in next patch V4.
> 
>> +		free_descs(nandc);
>> +		goto err_out;
>> +	}
>> +	free_descs(nandc);
>> +
>> +	nandc_read_buffer_sync(nandc, true);
>> +
>> +	for (i = 0; i < num_cw; i++) {
>> +		flash_status = le32_to_cpu(nandc->reg_read_buf[i]);
>> +
>> +	if (flash_status & FS_MPU_ERR)
>> +		host->status &= ~NAND_STATUS_WP;
>> +
>> +	if (flash_status & FS_OP_ERR || (i == (num_cw - 1) &&
>> +					 (flash_status & FS_DEVICE_STS_ERR)))
> 
>    	if (flash_status & FS_OP_ERR ||
> 	    (i == (num_cw - 1) && (flash_status & FS_DEVICE_STS_ERR)))
> 
> looks more readable?

   Yes you are right. I will fix this in next patch V4.

> 
>> +		host->status |= NAND_STATUS_FAIL;
>> +	}
>> +
>> +	flash_status = host->status;
>> +	instr = q_op.data_instr;
>> +	op_id = q_op.data_instr_idx;
>> +	len = nand_subop_get_data_len(subop, op_id);
>> +	memcpy(instr->ctx.data.buf.in, &flash_status, len);
>> +
>> +err_out:
>> +	return ret;
>> +}
>> +
>> +static int qcom_read_id_type_exec(struct nand_chip *chip, const struct nand_subop *subop)
>> +{
>> +	struct qcom_nand_controller *nandc = get_qcom_nand_controller(chip);
>> +	struct qcom_nand_host *host = to_qcom_nand_host(chip);
>> +	struct qcom_op q_op;
>> +	const struct nand_op_instr *instr = NULL;
>> +	unsigned int op_id = 0;
>> +	unsigned int len = 0;
>> +	int ret = 0;
>> +
>> +	qcom_parse_instructions(chip, subop, &q_op);
>> +
>> +	nandc->buf_count = 0;
>> +	nandc->buf_start = 0;
>> +	host->use_ecc = false;
>> +
>> +	clear_read_regs(nandc);
>> +	clear_bam_transaction(nandc);
>> +
>> +	nandc_set_reg(chip, NAND_FLASH_CMD, q_op.cmd_reg);
>> +	nandc_set_reg(chip, NAND_ADDR0, q_op.addr1_reg);
>> +	nandc_set_reg(chip, NAND_ADDR1, q_op.addr2_reg);
>> +	nandc_set_reg(chip, NAND_FLASH_CHIP_SELECT,
>> +		      nandc->props->is_bam ? 0 : DM_EN);
>> +
>> +	nandc_set_reg(chip, NAND_EXEC_CMD, 1);
>> +
>> +	write_reg_dma(nandc, NAND_FLASH_CMD, 4, NAND_BAM_NEXT_SGL);
>> +	write_reg_dma(nandc, NAND_EXEC_CMD, 1, NAND_BAM_NEXT_SGL);
>> +
>> +	read_reg_dma(nandc, NAND_READ_ID, 1, NAND_BAM_NEXT_SGL);
>> +
>> +	ret = submit_descs(nandc);
>> +	if (ret) {
>> +		dev_err(nandc->dev, "failure in sbumitting read id descriptor\n");
>> +		free_descs(nandc);
>> +		goto err_out;
>> +	}
>> +	free_descs(nandc);
>> +
>> +	instr = q_op.data_instr;
>> +	op_id = q_op.data_instr_idx;
>> +	len = nand_subop_get_data_len(subop, op_id);
>> +
>> +	nandc_read_buffer_sync(nandc, true);
>> +	memcpy(instr->ctx.data.buf.in, nandc->reg_read_buf, len);
>> +
>> +err_out:
>> +	return ret;
>> +}
>> +
>> +static int qcom_misc_cmd_type_exec(struct nand_chip *chip, const struct nand_subop *subop)
>> +{
>> +	struct qcom_nand_controller *nandc = get_qcom_nand_controller(chip);
>> +	struct qcom_nand_host *host = to_qcom_nand_host(chip);
>> +	struct qcom_op q_op;
>> +	int ret = 0;
>> +
>> +	qcom_parse_instructions(chip, subop, &q_op);
>> +
>> +	if (q_op.flag == OP_PROGRAM_PAGE)
>> +		goto wait_rdy;
>> +
>> +	nandc->buf_count = 0;
>> +	nandc->buf_start = 0;
>> +	host->use_ecc = false;
>> +
>> +	clear_read_regs(nandc);
>> +	clear_bam_transaction(nandc);
>> +
>> +	nandc_set_reg(chip, NAND_FLASH_CMD, q_op.cmd_reg);
>> +	nandc_set_reg(chip, NAND_EXEC_CMD, 1);
>> +
>> +	write_reg_dma(nandc, NAND_FLASH_CMD, 1, NAND_BAM_NEXT_SGL);
>> +	write_reg_dma(nandc, NAND_EXEC_CMD, 1, NAND_BAM_NEXT_SGL);
>> +
>> +	read_reg_dma(nandc, NAND_FLASH_STATUS, 1, NAND_BAM_NEXT_SGL);
>> +
>> +	ret = submit_descs(nandc);
>> +	if (ret) {
>> +		dev_err(nandc->dev, "failure in sbumitting misc descriptor\n");
>> +		free_descs(nandc);
>> +		goto err_out;
>> +	}
>> +	free_descs(nandc);
>> +
>> +wait_rdy:
>> +	qcom_delay_ns(q_op.rdy_delay_ns);
>> +	ret = qcom_wait_rdy_poll(chip, q_op.rdy_timeout_ms);
>> +
>> +err_out:
>> +	return ret;
>> +}
>> +
>> +static const struct nand_op_parser qcom_op_parser = NAND_OP_PARSER(
>> +		NAND_OP_PARSER_PATTERN(
>> +			qcom_misc_cmd_type_exec,
>> +			NAND_OP_PARSER_PAT_CMD_ELEM(false),
>> +			NAND_OP_PARSER_PAT_WAITRDY_ELEM(false)),
>> +		NAND_OP_PARSER_PATTERN(
>> +			qcom_read_id_type_exec,
>> +			NAND_OP_PARSER_PAT_CMD_ELEM(false),
>> +			NAND_OP_PARSER_PAT_ADDR_ELEM(false, MAX_ADDRESS_CYCLE),
>> +			NAND_OP_PARSER_PAT_DATA_IN_ELEM(false, 8)),
>> +		NAND_OP_PARSER_PATTERN(
>> +			qcom_read_status_exec,
>> +			NAND_OP_PARSER_PAT_CMD_ELEM(false),
>> +			NAND_OP_PARSER_PAT_DATA_IN_ELEM(false, 1)),
>> +		);
>> +
>>   static int qcom_check_op(struct nand_chip *chip,
>>   			const struct nand_operation *op)
>>   {
>> @@ -3022,7 +3233,8 @@ static int qcom_nand_exec_op(struct nand_chip *chip,
>>   	if (check_only)
>>   		return qcom_check_op(chip, op);
>>   
>> -	return 0;
>> +	return nand_op_parser_exec_op(chip, &qcom_op_parser,
>> +			op, check_only);
>>   }
>>   
>>   static const struct nand_controller_ops qcom_nandc_ops = {
> 
> 
> Thanks,
> Miquèl
