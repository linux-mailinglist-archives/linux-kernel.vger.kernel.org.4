Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2629270F2B1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 11:25:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240662AbjEXJZM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 05:25:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240582AbjEXJZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 05:25:05 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B1B8132;
        Wed, 24 May 2023 02:25:00 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34O69Xba020041;
        Wed, 24 May 2023 09:24:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=jR8xbN02g1iVFrHNjVDXGt7T+04Pj6aXBV8NXmKY83g=;
 b=jTJ5f6jmEMApNaatcLsmfsAG4+a8x5RqMwiTimZGBUSRsPBQXu1Y/hgfG9J407ovEfDV
 Ja0nS5NRd1Do7kKLt3nZIv3BCt2NcA2ECtf6+0v8Ni1aSG5RSFbhWAydtY4jB0lKXkf+
 wLV9q6Yevp97uF6ARq9h2Hz8xkoO5+UyGYP7/Asy7ezcA3W5RQcoZkX+Cr/xIZ5asRAh
 49qV/KZ1PJXJy5JmaxHvqkXPfucRQ+adbW3CqIAuRRKn5TQ1WfAtYaZHu1u/UoaG0du7
 9V/gyo+NihoZbowscMp2phTu3fdjCVToWO5hdPPvXF1oqno1rIENPgiTVIl68NWx9Bsl /w== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qs42uscwg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 May 2023 09:24:41 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34O9OeDC008843
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 May 2023 09:24:40 GMT
Received: from [10.201.3.104] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Wed, 24 May
 2023 02:24:37 -0700
Message-ID: <a92d2d3f-34b5-9cf1-ed40-1c812cbd0125@quicinc.com>
Date:   Wed, 24 May 2023 14:54:34 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v2 2/5] mtd: rawnand: qcom: Add support for reset, readid,
 status exec_op
Content-Language: en-US
To:     Miquel Raynal <miquel.raynal@bootlin.com>
CC:     <mani@kernel.org>, <richard@nod.at>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_srichara@quicinc.com>
References: <20230511133017.6307-1-quic_mdalam@quicinc.com>
 <20230511133017.6307-3-quic_mdalam@quicinc.com>
 <20230522154507.0255d902@xps-13>
From:   Md Sadre Alam <quic_mdalam@quicinc.com>
In-Reply-To: <20230522154507.0255d902@xps-13>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 7AO6XZuIieta8a0nJxV6HKAewInfFnIX
X-Proofpoint-GUID: 7AO6XZuIieta8a0nJxV6HKAewInfFnIX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-24_05,2023-05-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 spamscore=0 mlxscore=0
 phishscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305240079
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/22/2023 7:15 PM, Miquel Raynal wrote:
> Hi Md,
> 
> quic_mdalam@quicinc.com wrote on Thu, 11 May 2023 19:00:14 +0530:
> 
>> This change will add exec_ops support for RESET , READ_ID, STATUS
>> command.
>>
>> Co-developed-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
>> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
>> Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
>> ---
>> Change in [v2]
>>
>> * Missed to post Cover-letter, so posting v2 patch with cover-letter
>>
>>   drivers/mtd/nand/raw/qcom_nandc.c | 166 +++++++++++++++++++++++++++++-
>>   1 file changed, 163 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qcom_nandc.c
>> index dae460e2aa0b..d2f2a8971907 100644
>> --- a/drivers/mtd/nand/raw/qcom_nandc.c
>> +++ b/drivers/mtd/nand/raw/qcom_nandc.c
>> @@ -384,6 +384,9 @@ struct nandc_regs {
>>    * @reg_read_pos:		marker for data read in reg_read_buf
>>    *
>>    * @cmd1/vld:			some fixed controller register values
>> + *
>> + * @exec_opwrite:		flag to select correct number of code word
>> + *				while reading status
>>    */
>>   struct qcom_nand_controller {
>>   	struct device *dev;
>> @@ -434,6 +437,7 @@ struct qcom_nand_controller {
>>   	int reg_read_pos;
>>   
>>   	u32 cmd1, vld;
>> +	bool exec_opwrite;
>>   };
>>   
>>   /*
>> @@ -2920,6 +2924,8 @@ static int qcom_op_cmd_mapping(struct qcom_nand_controller *nandc, u8 cmd,
>>   		break;
>>   	case NAND_CMD_PAGEPROG:
>>   		ret = OP_PROGRAM_PAGE;
>> +		q_op->flag = NAND_CMD_PAGEPROG;
> 
> Just use the instruction value?

   Sure , will fix this in next patch V3.
> 
>> +		nandc->exec_opwrite = true;
>>   		break;
>>   	default:
>>   		break;
>> @@ -2982,10 +2988,95 @@ static void qcom_parse_instructions(struct nand_chip *chip,
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
>>   static int qcom_read_status_exec(struct nand_chip *chip,
>>   				 const struct nand_subop *subop)
>>   {
>> -	return 0;
>> +	struct qcom_nand_host *host = to_qcom_nand_host(chip);
>> +	struct qcom_nand_controller *nandc = get_qcom_nand_controller(chip);
>> +	struct nand_ecc_ctrl *ecc = &chip->ecc;
>> +	struct qcom_op q_op;
>> +	const struct nand_op_instr *instr = NULL;
>> +	unsigned int op_id = 0;
>> +	unsigned int len = 0;
>> +	int ret = 0, num_cw = 1, i;
>> +	u32 flash_status;
>> +
>> +	host->status = NAND_STATUS_READY | NAND_STATUS_WP;
>> +
>> +	qcom_parse_instructions(chip, subop, &q_op);
>> +
>> +	if (nandc->exec_opwrite) {
> 
> I definitely don't understand this flag at all.

   This flag is to get the status for all code word in case of program page operation.
   Since this read status is common for reading status for all kind of operation.
   so in page program operation it needs to get status for all code word i.e 4 in 2K page.
   but for normal operation number of code word will be 1.
> 
>> +		num_cw = ecc->steps;
>> +		nandc->exec_opwrite = false;
>> +	}
>> +
>> +	pre_command(host, NAND_CMD_STATUS);
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
>> +	if (ret)
>> +		dev_err(nandc->dev, "failure in sbumitting status descriptor\n");
>> +
>> +	free_descs(nandc);
>> +
>> +	nandc_read_buffer_sync(nandc, true);
>> +	for (i = 0; i < num_cw; i++) {
>> +		flash_status = le32_to_cpu(nandc->reg_read_buf[i]);
>> +
>> +	if (flash_status & FS_MPU_ERR)
>> +		host->status &= ~NAND_STATUS_WP;
>> +
>> +	if (flash_status & FS_OP_ERR || (i == (num_cw - 1) &&
>> +					 (flash_status & FS_DEVICE_STS_ERR)))
>> +		host->status |= NAND_STATUS_FAIL;
> 
> If there is a failure detected, error out (everywhere).

   Sure, will fix it in next patch V3.
> 
>> +	}
>> +
>> +	flash_status = host->status;
>> +
>> +	instr = q_op.data_instr;
>> +	op_id = q_op.data_instr_idx;
>> +	len = nand_subop_get_data_len(subop, op_id);
>> +	memcpy(instr->ctx.data.buf.in, &flash_status, len);
>> +
>> +	return ret;
>>   }
>>   
>>   static int qcom_erase_cmd_type_exec(struct nand_chip *chip, const struct nand_subop *subop)
>> @@ -3000,12 +3091,81 @@ static int qcom_param_page_type_exec(struct nand_chip *chip,  const struct nand_
>>   
>>   static int qcom_read_id_type_exec(struct nand_chip *chip, const struct nand_subop *subop)
>>   {
>> -	return 0;
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
>> +	pre_command(host, NAND_CMD_READID);
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
>> +	if (ret)
>> +		dev_err(nandc->dev, "failure in sbumitting read id descriptor\n");
>> +
>> +	free_descs(nandc);
>> +
>> +	instr = q_op.data_instr;
>> +	op_id = q_op.data_instr_idx;
>> +	len = nand_subop_get_data_len(subop, op_id);
>> +
>> +	nandc_read_buffer_sync(nandc, true);
>> +	memcpy(instr->ctx.data.buf.in, nandc->reg_read_buf, len);
>> +
>> +	return ret;
>>   }
>>   
>>   static int qcom_misc_cmd_type_exec(struct nand_chip *chip, const struct nand_subop *subop)
>>   {
>> -	return 0;
>> +	struct qcom_nand_controller *nandc = get_qcom_nand_controller(chip);
>> +	struct qcom_nand_host *host = to_qcom_nand_host(chip);
>> +	struct qcom_op q_op;
>> +	int ret = 0;
>> +
>> +	qcom_parse_instructions(chip, subop, &q_op);
>> +
>> +	if (q_op.flag == NAND_CMD_PAGEPROG)
>> +		goto wait_rdy;
>> +
>> +	pre_command(host, NAND_CMD_RESET);
> 
> ???

   Will fix it in next patch V3.
> 
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
>> +	if (ret)
>> +		dev_err(nandc->dev, "failure in sbumitting misc descriptor\n");
> 
> Typo                                             ^
> 
> Same above.
> 
> You should error out immediately when something wrong happens.

   Sure, will fix it in next patch V3.
> 
>> +
>> +	free_descs(nandc);
>> +
>> +wait_rdy:
>> +	qcom_delay_ns(q_op.rdy_delay_ns);
>> +
>> +	ret = qcom_wait_rdy_poll(chip, q_op.rdy_timeout_ms);
>> +
>> +	return ret;
>>   }
>>   
>>   static int qcom_data_read_type_exec(struct nand_chip *chip, const struct nand_subop *subop)
> 
> 
> Thanks,
> Miquèl
