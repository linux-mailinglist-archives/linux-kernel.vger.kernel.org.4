Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4C1570F1EF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 11:14:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240584AbjEXJO3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 05:14:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240322AbjEXJO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 05:14:28 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ED7F90;
        Wed, 24 May 2023 02:14:26 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34O9CPV4021273;
        Wed, 24 May 2023 09:14:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=RrGBhtQ1IB2u4c/+dFXnmueROB9DXKPn4rWiF4pSDKM=;
 b=lubalDbZ0lYhRooMJymNP8tMgwx0EKbioh3Fljg/TpBGOqvaglzi1L1/lYsOjn+VBAMq
 k3G0SVvdXhpKIMapIXLT19QPkqE4azOj7N0YBavGpK29pVz2LcOdVaicb5bTYCcvXVyp
 UOXF9Tlcobh5sxNUzluLW3IiyDTRFwgEeyMvRiJmcM8jDPwgfRlqVJi0nRNi7feX+iwB
 3+UL376TfIerHD0dxNMJMjU+OkKcHoLVSGgwwDJWhzKyX4WmFFPeZe3hY6bxGalBnjF6
 pNhcYGcQ5j8LKVcXx0FMUWJ9Lnbmtkz4L6LLuYZIk0xGCS3W/ZhMxV353oe/qkVBLXPQ 4g== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qsa0v8qen-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 May 2023 09:14:06 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34O9Dg6Z020541
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 May 2023 09:13:42 GMT
Received: from [10.201.3.104] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Wed, 24 May
 2023 02:13:40 -0700
Message-ID: <7f2f1322-2f1d-b846-1213-28a0fa327e1e@quicinc.com>
Date:   Wed, 24 May 2023 14:43:36 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v2 1/5] mtd: rawnand: qcom: Implement exec_op()
To:     Miquel Raynal <miquel.raynal@bootlin.com>
CC:     <mani@kernel.org>, <richard@nod.at>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_srichara@quicinc.com>
References: <20230511133017.6307-1-quic_mdalam@quicinc.com>
 <20230511133017.6307-2-quic_mdalam@quicinc.com>
 <20230522153519.6b574789@xps-13>
Content-Language: en-US
From:   Md Sadre Alam <quic_mdalam@quicinc.com>
In-Reply-To: <20230522153519.6b574789@xps-13>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ili35ntPZq8zEivADv3K7-EJWmapLhYS
X-Proofpoint-ORIG-GUID: ili35ntPZq8zEivADv3K7-EJWmapLhYS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-24_05,2023-05-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 impostorscore=0 suspectscore=0 lowpriorityscore=0 clxscore=1011
 bulkscore=0 priorityscore=1501 spamscore=0 mlxscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305240078
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/22/2023 7:05 PM, Miquel Raynal wrote:
> Hello,
> 
> quic_mdalam@quicinc.com wrote on Thu, 11 May 2023 19:00:13 +0530:
> 
>> Implement exec_op() so we can later get rid of the legacy interface
>> implementation.
>>
>> Co-developed-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
>> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
>> Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
>> ---
>> Change in [v2]
>>
>> * Missed to post Cover-letter, so posting v2 patch with cover-letter
>>   
>>   drivers/mtd/nand/raw/qcom_nandc.c | 214 +++++++++++++++++++++++++++++-
>>   1 file changed, 213 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qcom_nandc.c
>> index 72d6168d8a1b..dae460e2aa0b 100644
>> --- a/drivers/mtd/nand/raw/qcom_nandc.c
>> +++ b/drivers/mtd/nand/raw/qcom_nandc.c
>> @@ -157,6 +157,7 @@
>>   #define	OP_PAGE_PROGRAM_WITH_ECC	0x7
>>   #define	OP_PROGRAM_PAGE_SPARE		0x9
>>   #define	OP_BLOCK_ERASE			0xa
>> +#define	OP_CHECK_STATUS			0xc
>>   #define	OP_FETCH_ID			0xb
>>   #define	OP_RESET_DEVICE			0xd
>>   
>> @@ -235,6 +236,7 @@ nandc_set_reg(chip, reg,			\
>>    */
>>   #define NAND_ERASED_CW_SET		BIT(4)
>>   
>> +#define MAX_ADDRESS_CYCLE		5
>>   /*
>>    * This data type corresponds to the BAM transaction which will be used for all
>>    * NAND transfers.
>> @@ -447,6 +449,29 @@ struct qcom_nand_boot_partition {
>>   	u32 page_size;
>>   };
>>   
>> +/*
>> + * Qcom op for each exec_op transfer
>> + *
>> + * @data_instr:			data instruction pointer
>> + * @data_instr_idx:		data instruction index
>> + * @rdy_timeout_ms:		wait ready timeout in ms
>> + * @rdy_delay_ns:		Additional delay in ns
>> + * @addr1_reg:			Address1 register value
>> + * @addr2_reg:			Address2 register value
>> + * @cmd_reg:			CMD register value
>> + * @flag:			flag for misc instruction
>> + */
>> +struct qcom_op {
>> +	const struct nand_op_instr *data_instr;
>> +	unsigned int data_instr_idx;
>> +	unsigned int rdy_timeout_ms;
>> +	unsigned int rdy_delay_ns;
>> +	u32 addr1_reg;
>> +	u32 addr2_reg;
>> +	u32 cmd_reg;
>> +	u8 flag;
>> +};
>> +
>>   /*
>>    * NAND chip structure
>>    *
>> @@ -1517,7 +1542,8 @@ static void pre_command(struct qcom_nand_host *host, int command)
>>   	clear_read_regs(nandc);
>>   
>>   	if (command == NAND_CMD_RESET || command == NAND_CMD_READID ||
>> -	    command == NAND_CMD_PARAM || command == NAND_CMD_ERASE1)
>> +	    command == NAND_CMD_PARAM || command == NAND_CMD_ERASE1 ||
>> +	    command == NAND_CMD_STATUS)
> 
> I don't like this much, is there another way to derive whether
> clear_bam_transaction() is needed? What is the rationale behind it?

   clear_bam_transcation() is resting all the bam realted counter to 0 before starting new transcation.
   I will move these all condition check to exec_ops() specific API , and remove pre_command itself.
   Will fix this in next patch V3.
> 
>>   		clear_bam_transaction(nandc);
>>   }
>>   
>> @@ -2867,8 +2893,194 @@ static int qcom_nand_attach_chip(struct nand_chip *chip)
>>   	return 0;
>>   }
>>   
>> +static int qcom_op_cmd_mapping(struct qcom_nand_controller *nandc, u8 cmd,
>> +			       struct qcom_op *q_op)
>> +{
>> +	int ret = 0;
>> +
>> +	switch (cmd) {
>> +	case NAND_CMD_RESET:
>> +		ret = OP_RESET_DEVICE;
>> +		break;
>> +	case NAND_CMD_READID:
>> +		ret = OP_FETCH_ID;
>> +		break;
>> +	case NAND_CMD_PARAM:
>> +		if (nandc->props->qpic_v2)
>> +			ret = OP_PAGE_READ_ONFI_READ;
>> +		else
>> +			ret = OP_PAGE_READ;
>> +		break;
>> +	case NAND_CMD_ERASE1:
>> +	case NAND_CMD_ERASE2:
>> +		ret = OP_BLOCK_ERASE;
>> +		break;
>> +	case NAND_CMD_STATUS:
>> +		ret = OP_CHECK_STATUS;
>> +		break;
>> +	case NAND_CMD_PAGEPROG:
>> +		ret = OP_PROGRAM_PAGE;
>> +		break;
>> +	default:
> 
> This should error out and the error be catch in the check_only path.

   Will fix it in next patch V3.
> 
>> +		break;
>> +	}
>> +
>> +	return ret;
>> +}
>> +
>> +/* NAND framework ->exec_op() hooks and related helpers */
>> +static void qcom_parse_instructions(struct nand_chip *chip,
>> +				    const struct nand_subop *subop,
>> +					struct qcom_op *q_op)
>> +{
>> +	struct qcom_nand_controller *nandc = get_qcom_nand_controller(chip);
>> +	const struct nand_op_instr *instr = NULL;
>> +	unsigned int op_id;
>> +	int i;
>> +
>> +	memset(q_op, 0, sizeof(*q_op));
>> +
>> +	for (op_id = 0; op_id < subop->ninstrs; op_id++) {
>> +		unsigned int offset, naddrs;
>> +		const u8 *addrs;
>> +
>> +		instr = &subop->instrs[op_id];
>> +
>> +		switch (instr->type) {
>> +		case NAND_OP_CMD_INSTR:
>> +			q_op->cmd_reg = qcom_op_cmd_mapping(nandc, instr->ctx.cmd.opcode, q_op);
>> +			q_op->rdy_delay_ns = instr->delay_ns;
>> +			break;
>> +
>> +		case NAND_OP_ADDR_INSTR:
>> +			offset = nand_subop_get_addr_start_off(subop, op_id);
>> +			naddrs = nand_subop_get_num_addr_cyc(subop, op_id);
>> +			addrs = &instr->ctx.addr.addrs[offset];
>> +			for (i = 0; i < min(5U, naddrs); i++) {
> 
> Is this min() useful? You already limit the number of cycles to 5,
> otherwise the pattern won't match, right?

   Yeah you are right. If address cycle is fixed to 5 , then this min not required.
   will fix this in next v3 patch.
> 
>> +				if (i < 4)
>> +					q_op->addr1_reg |= (u32)addrs[i] << i * 8;
>> +				else
>> +					q_op->addr2_reg |= addrs[i];
>> +			}
>> +			q_op->rdy_delay_ns = instr->delay_ns;
>> +			break;
>> +
>> +		case NAND_OP_DATA_IN_INSTR:
>> +			q_op->data_instr = instr;
>> +			q_op->data_instr_idx = op_id;
>> +			q_op->rdy_delay_ns = instr->delay_ns;
>> +			fallthrough;
>> +		case NAND_OP_DATA_OUT_INSTR:
>> +			q_op->rdy_delay_ns = instr->delay_ns;
>> +			break;
>> +
>> +		case NAND_OP_WAITRDY_INSTR:
>> +			q_op->rdy_timeout_ms = instr->ctx.waitrdy.timeout_ms;
>> +			q_op->rdy_delay_ns = instr->delay_ns;
>> +			break;
>> +		}
>> +	}
>> +}
>> +
>> +static int qcom_read_status_exec(struct nand_chip *chip,
>> +				 const struct nand_subop *subop)
>> +{
>> +	return 0;
>> +}
>> +
>> +static int qcom_erase_cmd_type_exec(struct nand_chip *chip, const struct nand_subop *subop)
>> +{
>> +	return 0;
>> +}
>> +
>> +static int qcom_param_page_type_exec(struct nand_chip *chip,  const struct nand_subop *subop)
>> +{
>> +	return 0;
>> +}
>> +
>> +static int qcom_read_id_type_exec(struct nand_chip *chip, const struct nand_subop *subop)
>> +{
>> +	return 0;
>> +}
>> +
>> +static int qcom_misc_cmd_type_exec(struct nand_chip *chip, const struct nand_subop *subop)
>> +{
>> +	return 0;
>> +}
>> +
>> +static int qcom_data_read_type_exec(struct nand_chip *chip, const struct nand_subop *subop)
>> +{
>> +	/* currently read_exec_op() return 0 , and all the read operation handle in
>> +	 * actual API itself
>> +	 */
>> +	return 0;
> 
> Please make all exec_op additions in the same patch, unless you're
> truly adding a feature, in this case it can be split, but no pattern
> should match what's unsupported by ->exec_op(). This way we avoid these
> very strange (and wrong) empty functions).

   Sure, will take care this in patch V3.
> 
>> +}
>> +
>> +static int qcom_data_write_type_exec(struct nand_chip *chip, const struct nand_subop *subop)
>> +{
>> +	/* currently write_exec_op() return 0, and all the write operation handle in
>> +	 * actual API itself
>> +	 */
>> +	struct qcom_op q_op;
>> +
>> +	qcom_parse_instructions(chip, subop, &q_op);
>> +
>> +	return 0;
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
>> +			qcom_param_page_type_exec,
>> +			NAND_OP_PARSER_PAT_CMD_ELEM(false),
>> +			NAND_OP_PARSER_PAT_ADDR_ELEM(false, MAX_ADDRESS_CYCLE),
>> +			NAND_OP_PARSER_PAT_WAITRDY_ELEM(true),
>> +			NAND_OP_PARSER_PAT_DATA_IN_ELEM(false, 512)),
>> +		NAND_OP_PARSER_PATTERN(
>> +			qcom_read_status_exec,
>> +			NAND_OP_PARSER_PAT_CMD_ELEM(false),
>> +			NAND_OP_PARSER_PAT_DATA_IN_ELEM(false, 1)),
>> +		NAND_OP_PARSER_PATTERN(
>> +			qcom_erase_cmd_type_exec,
>> +			NAND_OP_PARSER_PAT_CMD_ELEM(false),
>> +			NAND_OP_PARSER_PAT_ADDR_ELEM(false, MAX_ADDRESS_CYCLE),
>> +			NAND_OP_PARSER_PAT_CMD_ELEM(false),
>> +			NAND_OP_PARSER_PAT_WAITRDY_ELEM(false)),
>> +		NAND_OP_PARSER_PATTERN(
>> +			qcom_data_read_type_exec,
>> +			NAND_OP_PARSER_PAT_CMD_ELEM(false),
>> +			NAND_OP_PARSER_PAT_ADDR_ELEM(false, MAX_ADDRESS_CYCLE),
>> +			NAND_OP_PARSER_PAT_CMD_ELEM(false),
>> +			NAND_OP_PARSER_PAT_WAITRDY_ELEM(true),
>> +			NAND_OP_PARSER_PAT_DATA_IN_ELEM(false, 2048)),
>> +		NAND_OP_PARSER_PATTERN(
>> +			qcom_data_write_type_exec,
>> +			NAND_OP_PARSER_PAT_CMD_ELEM(true),
>> +			NAND_OP_PARSER_PAT_ADDR_ELEM(true, MAX_ADDRESS_CYCLE)),
>> +		);
>> +
>> +static int qcom_nand_exec_op(struct nand_chip *chip,
>> +			     const struct nand_operation *op,
>> +			bool check_only)
>> +{
>> +	if (check_only)
>> +		return 0;
> 
> This is wrong, you cannot blindly return 0 if check_only is true.

   Will fix this in next patch V3.
> 
>> +	return nand_op_parser_exec_op(chip, &qcom_op_parser,
>> +			op, check_only);
>> +}
>> +
>>   static const struct nand_controller_ops qcom_nandc_ops = {
>>   	.attach_chip = qcom_nand_attach_chip,
>> +	.exec_op = qcom_nand_exec_op,
>>   };
>>   
>>   static void qcom_nandc_unalloc(struct qcom_nand_controller *nandc)
> 
> 
> Thanks,
> Miquèl
