Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E48E70F2C6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 11:29:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240257AbjEXJ3P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 05:29:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230356AbjEXJ3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 05:29:12 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9B6090;
        Wed, 24 May 2023 02:29:11 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34O5Jpuf031611;
        Wed, 24 May 2023 09:29:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=8wt6AN6pl6ghSok1hDDHJ3uMHeMEuXrVVpwKZb4ImaA=;
 b=UU9aHMhhqUWGQCCBxaNAJWeh5sY9aguwPdJseMPAVArbkX2nPuXqKqEig9Rb4p4PZ6Gb
 nz+iEjOglOnawlCEEa0fj11NC0c/4avjz/OXJqB8lWBcyO2HrdnR0Zqn5O4Ka9NOYXgt
 3Ox0EuTwQTj8LVXcLlNPJvQzVGUmZIGmyo1V0gRwVs3tGCtQajtSOzcfiekGOxEPOv+M
 ArnKXDkb7iZihguL12hVooZM0WXLqPu58SQYPdYWqBJnYI1RzSae973N5QmdlDq9VDsd
 QLuMAcnCHHkEHqB6kHaDP+1C00pA2oj2BEeic/3DyDUtgLhokH/zFOp8WrzoqEqV56u9 uw== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qscaurj71-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 May 2023 09:29:02 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34O9T1NI017392
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 May 2023 09:29:01 GMT
Received: from [10.201.3.104] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Wed, 24 May
 2023 02:28:58 -0700
Message-ID: <69bde397-9d6a-d6b2-846c-310fbbbaba98@quicinc.com>
Date:   Wed, 24 May 2023 14:58:55 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v2 3/5] mtd: rawnand: qcom: Add support for param_page
 read exec_ops
Content-Language: en-US
To:     Miquel Raynal <miquel.raynal@bootlin.com>
CC:     <mani@kernel.org>, <richard@nod.at>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_srichara@quicinc.com>
References: <20230511133017.6307-1-quic_mdalam@quicinc.com>
 <20230511133017.6307-4-quic_mdalam@quicinc.com>
 <20230522154916.3bb7be4e@xps-13>
From:   Md Sadre Alam <quic_mdalam@quicinc.com>
In-Reply-To: <20230522154916.3bb7be4e@xps-13>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: iltTnx8JJHJ3PpptWLFUC1OqnB6XTwH_
X-Proofpoint-GUID: iltTnx8JJHJ3PpptWLFUC1OqnB6XTwH_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-24_05,2023-05-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 impostorscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
 phishscore=0 bulkscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305240079
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/22/2023 7:19 PM, Miquel Raynal wrote:
> Hi Md,
> 
> quic_mdalam@quicinc.com wrote on Thu, 11 May 2023 19:00:15 +0530:
> 
>> This change will add exec_ops for PARAM_PAGE_READ command.
>>
>> Co-developed-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
>> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
>> Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
>> ---
>> Change in [v2]
>>
>> * Missed to post Cover-letter, so posting v2 patch with cover-letter
>>
>>   drivers/mtd/nand/raw/qcom_nandc.c | 91 ++++++++++++++++++++++++++++++-
>>   1 file changed, 90 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qcom_nandc.c
>> index d2f2a8971907..8717d5086f80 100644
>> --- a/drivers/mtd/nand/raw/qcom_nandc.c
>> +++ b/drivers/mtd/nand/raw/qcom_nandc.c
>> @@ -3086,7 +3086,96 @@ static int qcom_erase_cmd_type_exec(struct nand_chip *chip, const struct nand_su
>>   
>>   static int qcom_param_page_type_exec(struct nand_chip *chip,  const struct nand_subop *subop)
>>   {
>> -	return 0;
>> +	struct qcom_nand_host *host = to_qcom_nand_host(chip);
>> +	struct qcom_nand_controller *nandc = get_qcom_nand_controller(chip);
>> +	struct qcom_op q_op;
>> +	const struct nand_op_instr *instr = NULL;
>> +	unsigned int op_id = 0;
>> +	unsigned int len = 0;
>> +	int ret = 0;
>> +
>> +	qcom_parse_instructions(chip, subop, &q_op);
>> +
>> +	q_op.cmd_reg |= PAGE_ACC | LAST_PAGE;
>> +
>> +	pre_command(host, NAND_CMD_PARAM);
>> +	/*
>> +	 * NAND_CMD_PARAM is called before we know much about the FLASH chip
>> +	 * in use. we configure the controller to perform a raw read of 512
>> +	 * bytes to read onfi params
> 
> There is no guess to do, just follow what the core asks.

   Sure, will fix this in next patch V3.
> 
>> +	 */
>> +	if (nandc->props->qpic_v2)
>> +		nandc_set_reg(chip, NAND_FLASH_CMD, q_op.cmd_reg);
>> +	else
>> +		nandc_set_reg(chip, NAND_FLASH_CMD, q_op.cmd_reg);
> 
> There is something wrong here.
> 
   Will fix this in next patch V3.

>> +
>> +	nandc_set_reg(chip, NAND_ADDR0, 0);
>> +	nandc_set_reg(chip, NAND_ADDR1, 0);
>> +	nandc_set_reg(chip, NAND_DEV0_CFG0, 0 << CW_PER_PAGE
>> +					| 512 << UD_SIZE_BYTES
>> +					| 5 << NUM_ADDR_CYCLES
>> +					| 0 << SPARE_SIZE_BYTES);
>> +	nandc_set_reg(chip, NAND_DEV0_CFG1, 7 << NAND_RECOVERY_CYCLES
>> +					| 0 << CS_ACTIVE_BSY
>> +					| 17 << BAD_BLOCK_BYTE_NUM
>> +					| 1 << BAD_BLOCK_IN_SPARE_AREA
>> +					| 2 << WR_RD_BSY_GAP
>> +					| 0 << WIDE_FLASH
>> +					| 1 << DEV0_CFG1_ECC_DISABLE);
>> +	if (!nandc->props->qpic_v2)
>> +		nandc_set_reg(chip, NAND_EBI2_ECC_BUF_CFG, 1 << ECC_CFG_ECC_DISABLE);
>> +
>> +	/* configure CMD1 and VLD for ONFI param probing in QPIC v1 */
>> +	if (!nandc->props->qpic_v2) {
>> +		nandc_set_reg(chip, NAND_DEV_CMD_VLD,
>> +			      (nandc->vld & ~READ_START_VLD));
>> +		nandc_set_reg(chip, NAND_DEV_CMD1,
>> +			      (nandc->cmd1 & ~(0xFF << READ_ADDR))
>> +			      | NAND_CMD_PARAM << READ_ADDR);
>> +	}
>> +
>> +	nandc_set_reg(chip, NAND_EXEC_CMD, 1);
>> +
>> +	if (!nandc->props->qpic_v2) {
>> +		nandc_set_reg(chip, NAND_DEV_CMD1_RESTORE, nandc->cmd1);
>> +		nandc_set_reg(chip, NAND_DEV_CMD_VLD_RESTORE, nandc->vld);
>> +	}
>> +
>> +	nandc_set_read_loc(chip, 0, 0, 0, 512, 1);
>> +
>> +	if (!nandc->props->qpic_v2) {
>> +		write_reg_dma(nandc, NAND_DEV_CMD_VLD, 1, 0);
>> +		write_reg_dma(nandc, NAND_DEV_CMD1, 1, NAND_BAM_NEXT_SGL);
>> +	}
>> +
>> +	nandc->buf_count = 512;
> 
> The length is provided by the instruction.

    Will fix this in next patch V3.
> 
>> +	memset(nandc->data_buffer, 0xff, nandc->buf_count);
>> +
>> +	config_nand_single_cw_page_read(chip, false, 0);
>> +
>> +	read_data_dma(nandc, FLASH_BUF_ACC, nandc->data_buffer,
>> +		      nandc->buf_count, 0);
>> +
>> +	/* restore CMD1 and VLD regs */
>> +	if (!nandc->props->qpic_v2) {
>> +		write_reg_dma(nandc, NAND_DEV_CMD1_RESTORE, 1, 0);
>> +		write_reg_dma(nandc, NAND_DEV_CMD_VLD_RESTORE, 1, NAND_BAM_NEXT_SGL);
>> +	}
>> +
>> +	ret = submit_descs(nandc);
>> +	if (ret)
>> +		dev_err(nandc->dev, "failure in sbumitting param page descriptor\n");
>> +
>> +	free_descs(nandc);
>> +
>> +	ret = qcom_wait_rdy_poll(chip, q_op.rdy_timeout_ms);
>> +
>> +	instr = q_op.data_instr;
>> +	op_id = q_op.data_instr_idx;
>> +	len = nand_subop_get_data_len(subop, op_id);
>> +	memcpy(instr->ctx.data.buf.in, nandc->data_buffer, len);
>> +
>> +	return ret;
>>   }
>>   
>>   static int qcom_read_id_type_exec(struct nand_chip *chip, const struct nand_subop *subop)
> 
> 
> Thanks,
> Miquèl
