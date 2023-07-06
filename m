Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C5AA749B81
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 14:14:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232721AbjGFMOZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 08:14:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230453AbjGFMOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 08:14:23 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4267C171A;
        Thu,  6 Jul 2023 05:14:22 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3666iR97029904;
        Thu, 6 Jul 2023 12:14:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=+Q/btflsW5TQzikZesZHZSlLRjcs2mb2WHp8QLYv/x0=;
 b=clFtVbtGy1eK3lB3Z/oPliWMvIwrqBMJgGjE7LyOtzfyMjtrpvyeQb3Gyt/CmwgXwHpm
 tTajittUnBSCVifl1jb+lFlTc9wrBuiS0KtWB8KEkhaOsWK7HysSplx/oZGQoT7FtHAX
 fAKv6B4S0nrqU9WSzj1NIGswPUl6Xmaq8rVohMQ1gv/QaXpJDavSdgLJwk5ZVz4/qBqM
 rGpWHrk5wet4mqtaaXF/a37mMHMXCGa96RUBX0gEsNPuYA9P2f4EfYLEcYeU87b/8zLB
 9/QqS7884SRQh8EiwCYEOtXeVCIbVC7KXmdsPfUA147C529UB26hc6fMejKEPd8Qvoyl TQ== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rn2cpbbyw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Jul 2023 12:14:00 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 366CE0Ml009684
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 6 Jul 2023 12:14:00 GMT
Received: from [10.201.3.104] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Thu, 6 Jul
 2023 05:13:57 -0700
Message-ID: <06018677-79d9-788b-3583-390eaf08d301@quicinc.com>
Date:   Thu, 6 Jul 2023 17:43:54 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v4 1/5] mtd: rawnand: qcom: Implement exec_op()
To:     Miquel Raynal <miquel.raynal@bootlin.com>
CC:     <mani@kernel.org>, <richard@nod.at>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_srichara@quicinc.com>
References: <20230615073143.25079-1-quic_mdalam@quicinc.com>
 <20230704165052.30039969@xps-13>
Content-Language: en-US
From:   Md Sadre Alam <quic_mdalam@quicinc.com>
In-Reply-To: <20230704165052.30039969@xps-13>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: xODK41afEoIanybAmu-QGJ-S9qqMAuMa
X-Proofpoint-ORIG-GUID: xODK41afEoIanybAmu-QGJ-S9qqMAuMa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-06_07,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 spamscore=0 clxscore=1011 bulkscore=0 mlxlogscore=999
 lowpriorityscore=0 suspectscore=0 impostorscore=0 mlxscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307060109
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/4/2023 8:20 PM, Miquel Raynal wrote:
> Hi,
> 
> quic_mdalam@quicinc.com wrote on Thu, 15 Jun 2023 13:01:39 +0530:
> 
>> Implement exec_op() so we can later get rid of the legacy interface
>> implementation.
>>
>> Co-developed-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
>> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
>> Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
>> ---
>> Change in [v4]
>>
>> * No change for this patch, since this is part of exec_op
>>    series posting new patch.
>>
>> Change in [v3]
>>
>> * Removed NAND_CMD_STATUS check in pre_command and move
>>    it to status exec_op.
>>
>> * Removed min() , since this check not needed
>>
>> * Removed all the dummy APIs of exec_ops, and added it
>>    into same patch where its getting added.
>>
>> * Added qcom_check_op() API to check for unsupported feature
>>    by controller in check_only path.
>>
>> Change in [v2]
>>
>> * Missed to post Cover-letter, so posting v2 patch with cover-letter
>>
>> Change in [v1]
>>
>> * Added initial support for exec_ops.
>>
>>   drivers/mtd/nand/raw/qcom_nandc.c | 159 ++++++++++++++++++++++++++++++
>>   1 file changed, 159 insertions(+)
>>
>> diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qcom_nandc.c
>> index 72d6168d8a1b..d9c4c9fe2fe8 100644
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
>> @@ -235,6 +236,8 @@ nandc_set_reg(chip, reg,			\
>>    */
>>   #define NAND_ERASED_CW_SET		BIT(4)
>>   
>> +#define MAX_ADDRESS_CYCLE		5
>> +#define MAX_CHUNK_SIZE			SZ_8K
> 
> New line.

    Will fix in next patch v5.
> 
>>   /*
>>    * This data type corresponds to the BAM transaction which will be used for all
>>    * NAND transfers.
>> @@ -447,6 +450,29 @@ struct qcom_nand_boot_partition {
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
>> @@ -2867,8 +2893,141 @@ static int qcom_nand_attach_chip(struct nand_chip *chip)
>>   	return 0;
>>   }
>>   
>> +static int qcom_op_cmd_mapping(struct qcom_nand_controller *nandc, u8 cmd,
>> +			       struct qcom_op *q_op)
>> +{
>> +	int ret;
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
> Again, this is not a supported case, you should handle it. And this
> must be checked upon check_only conditions as well.
> 

     Yes understand , Will handle this case in next patch v5.

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
>> +			for (i = 0; i < MAX_ADDRESS_CYCLE; i++) {
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
>> +static int qcom_check_op(struct nand_chip *chip,
>> +			 const struct nand_operation *op)
>> +{
>> +	const struct nand_op_instr *instr;
>> +	int op_id;
>> +
>> +	for (op_id = 0; op_id < op->ninstrs; op_id++) {
>> +		instr = &op->instrs[op_id];
>> +
>> +		switch (instr->type) {
>> +		case NAND_OP_CMD_INSTR:
>> +			if (instr->ctx.cmd.opcode == NAND_CMD_READCACHESEQ ||
>> +			    instr->ctx.cmd.opcode == NAND_CMD_READCACHEEND)
>> +				return -ENOTSUPP;
> 
> Do you really need this check? These operations have specific pattern,
> no? I believe you should not need this check.

    Yes you are correct, these command are having specific pattern.
    Its not needed here , will remove in next patch v5.
>> +			break;
>> +		case NAND_OP_ADDR_INSTR:
>> +			if (instr->ctx.addr.naddrs > MAX_ADDRESS_CYCLE)
>> +				return -ENOTSUPP;
> 
> This one is not needed either, as long as you properly define the
> patterns.

    Yes this one as well not needed. Will remove in next patch v5.
> 
>> +
>> +			break;
>> +		case NAND_OP_DATA_IN_INSTR:
>> +		case NAND_OP_DATA_OUT_INSTR:
>> +			if (instr->ctx.data.len > MAX_CHUNK_SIZE)
> 
> Same.

   Will remove in next patch v5.

>> +				return -ENOTSUPP;
>> +			break;
>> +		default:
>> +			break;
>> +		}
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int qcom_nand_exec_op(struct nand_chip *chip,
>> +			     const struct nand_operation *op,
>> +			bool check_only)
>> +{
>> +	if (check_only)
>> +		return qcom_check_op(chip, op);
>> +
>> +	return 0;
>> +}
>> +
>>   static const struct nand_controller_ops qcom_nandc_ops = {
>>   	.attach_chip = qcom_nand_attach_chip,
>> +	.exec_op = qcom_nand_exec_op,
> 
> I understand the idea of making the series easier to review, and I
> thank you for that, but in practice the series is not bisectable. I
> doubt the driver works right after patch 1.

    Yes you are right. This series patches are not bisectable, but got
    compiled individually. But boot up will not work after patch 1.
> 
> You will likely need two patches, one to add exec_op, one to remove the
> legacy implementation.

    Will combine all the patches in two patches. One for exec_op() implementation.
    another one is Remove legacy implementation. Will do this in next patch v5.
> 
>>   };
>>   
>>   static void qcom_nandc_unalloc(struct qcom_nand_controller *nandc)
> 
> 
> Thanks,
> Miquèl
