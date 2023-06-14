Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6E6B730389
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 17:20:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343715AbjFNPUa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 11:20:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343702AbjFNPU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 11:20:29 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DF7C11B;
        Wed, 14 Jun 2023 08:20:23 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35EBRvf4013117;
        Wed, 14 Jun 2023 15:20:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=ifo4/RG7pa8H1yKTyEa13HR1G2GwXRZM5UzIIUVP9ww=;
 b=BMZ4j9Uq6W3Mh/F9xjRzlA+XmQLH8B30xx1exi1yodSRaqJveeGgELriXvNUAG8RxNUK
 AR7OJxST1nY5g0GGbARrLk+C5JRcZkGz8n2m47VayY4RqF9TQOSl/qF2RuD5qbUl5K5S
 SpariEDQrI3EDiNZ1X0v3wUNT1EYDClqKPYBB26dnjeKVmzVdcVdPqU8YyEJuGEIIQFS
 1uRezy4YTCcwVu1uJYkGqNyrSD1zwLZ6pucKBbj4Nbu36nJw2P+joFlcOCnLvp94+0O1
 G5sj3Cr4A44c8OZkeYInGM8ctiMhnOVRG8kb+AcV0+RTydF2aLU4EPJu7Z/m7c1ESkat nA== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r7cka0j40-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Jun 2023 15:20:02 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35EFK1pr008436
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Jun 2023 15:20:01 GMT
Received: from [10.201.3.104] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Wed, 14 Jun
 2023 08:19:58 -0700
Message-ID: <94e642ff-c8eb-8938-17d6-81030516fd05@quicinc.com>
Date:   Wed, 14 Jun 2023 20:49:55 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v3 4/5] mtd: rawnand: qcom: Add support for read, write,
 erase exec_ops
Content-Language: en-US
To:     Miquel Raynal <miquel.raynal@bootlin.com>
CC:     <mani@kernel.org>, <richard@nod.at>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_srichara@quicinc.com>
References: <20230531124953.21007-1-quic_mdalam@quicinc.com>
 <20230531124953.21007-4-quic_mdalam@quicinc.com>
 <20230608160303.51ea70a6@xps-13>
From:   Md Sadre Alam <quic_mdalam@quicinc.com>
In-Reply-To: <20230608160303.51ea70a6@xps-13>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: tIrAPDFnBNalv8xuZIjNkRsLYvzOkGtB
X-Proofpoint-ORIG-GUID: tIrAPDFnBNalv8xuZIjNkRsLYvzOkGtB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-14_10,2023-06-14_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 malwarescore=0 suspectscore=0 priorityscore=1501 lowpriorityscore=0
 mlxlogscore=999 adultscore=0 impostorscore=0 bulkscore=0 clxscore=1015
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306140133
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/8/2023 7:33 PM, Miquel Raynal wrote:
> Hi Md,
> 
> quic_mdalam@quicinc.com wrote on Wed, 31 May 2023 18:19:52 +0530:
> 
>> This change will add exec_ops support for READ, WRITE, and ERASE
>> command.
>>
>> Co-developed-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
>> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
>> Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
>> ---
>> Change in [v3]
>>
>> * Removed chip->cont_read.ongoing flag.
>>
>> * Removed pre_command from erase_etype_exec_ops.
>>
>> Change in [v2]
>>
>> * Missed to post Cover-letter, so posting v2 patch with cover-letter.
>>
>> Change in [v1]
>>
>> * Added initial support for exec_ops.
>>
>>   drivers/mtd/nand/raw/qcom_nandc.c | 97 +++++++++++++++++++++++++++++--
>>   1 file changed, 93 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qcom_nandc.c
>> index b4823b72fe73..7dc769f9e797 100644
>> --- a/drivers/mtd/nand/raw/qcom_nandc.c
>> +++ b/drivers/mtd/nand/raw/qcom_nandc.c
>> @@ -1546,8 +1546,7 @@ static void pre_command(struct qcom_nand_host *host, int command)
>>   
>>   	clear_read_regs(nandc);
>>   
>> -	if (command == NAND_CMD_ERASE1)
>> -		clear_bam_transaction(nandc);
>> +	clear_bam_transaction(nandc);
>>   }
>>   
>>   /*
>> @@ -1764,7 +1763,7 @@ qcom_nandc_read_cw_raw(struct mtd_info *mtd, struct nand_chip *chip,
>>   	int ret, reg_off = FLASH_BUF_ACC, read_loc = 0;
>>   	int raw_cw = cw;
>>   
>> -	nand_read_page_op(chip, page, 0, NULL, 0);
>> +	nand_read_page_op(chip, page, 0, data_buf, mtd->writesize);
>>   	host->use_ecc = false;
>>   
>>   	if (nandc->props->qpic_v2)
>> @@ -2181,14 +2180,23 @@ static void qcom_nandc_codeword_fixup(struct qcom_nand_host *host, int page)
>>   static int qcom_nandc_read_page(struct nand_chip *chip, uint8_t *buf,
>>   				int oob_required, int page)
>>   {
>> +	struct mtd_info *mtd = nand_to_mtd(chip);
>>   	struct qcom_nand_host *host = to_qcom_nand_host(chip);
>>   	struct qcom_nand_controller *nandc = get_qcom_nand_controller(chip);
>> +	struct nand_ecc_ctrl *ecc = &chip->ecc;
>>   	u8 *data_buf, *oob_buf = NULL;
>>   
>>   	if (host->nr_boot_partitions)
>>   		qcom_nandc_codeword_fixup(host, page);
>>   
>> -	nand_read_page_op(chip, page, 0, NULL, 0);
>> +	nand_read_page_op(chip, page, 0, buf, mtd->writesize);
>> +	nandc->buf_count = 0;
>> +	nandc->buf_start = 0;
>> +	host->use_ecc = true;
>> +	clear_read_regs(nandc);
>> +	set_address(host, 0, page);
>> +	update_rw_regs(host, ecc->steps, true, 0);
>> +
>>   	data_buf = buf;
>>   	oob_buf = oob_required ? chip->oob_poi : NULL;
>>   
>> @@ -2258,6 +2266,9 @@ static int qcom_nandc_write_page(struct nand_chip *chip, const uint8_t *buf,
>>   
>>   	nand_prog_page_begin_op(chip, page, 0, NULL, 0);
>>   
>> +	set_address(host, 0, page);
>> +	nandc->buf_count = 0;
>> +	nandc->buf_start = 0;
>>   	clear_read_regs(nandc);
>>   	clear_bam_transaction(nandc);
>>   
>> @@ -3274,6 +3285,67 @@ static int qcom_param_page_type_exec(struct nand_chip *chip,  const struct nand_
>>   	return ret;
>>   }
>>   
>> +static int qcom_erase_cmd_type_exec(struct nand_chip *chip, const struct nand_subop *subop)
>> +{
>> +	struct qcom_nand_host *host = to_qcom_nand_host(chip);
>> +	struct qcom_nand_controller *nandc = get_qcom_nand_controller(chip);
>> +	struct qcom_op q_op;
>> +	int ret = 0;
>> +
>> +	qcom_parse_instructions(chip, subop, &q_op);
>> +
>> +	q_op.cmd_reg |= PAGE_ACC | LAST_PAGE;
>> +
>> +	nandc->buf_count = 0;
>> +	nandc->buf_start = 0;
>> +	host->use_ecc = false;
>> +	clear_read_regs(nandc);
>> +	clear_bam_transaction(nandc);
>> +
>> +	nandc_set_reg(chip, NAND_FLASH_CMD, q_op.cmd_reg);
>> +	nandc_set_reg(chip, NAND_ADDR0, q_op.addr1_reg);
>> +	nandc_set_reg(chip, NAND_ADDR1, q_op.addr2_reg);
>> +	nandc_set_reg(chip, NAND_DEV0_CFG0,
>> +		      host->cfg0_raw & ~(7 << CW_PER_PAGE));
>> +	nandc_set_reg(chip, NAND_DEV0_CFG1, host->cfg1_raw);
>> +	nandc_set_reg(chip, NAND_EXEC_CMD, 1);
>> +
>> +	write_reg_dma(nandc, NAND_FLASH_CMD, 3, NAND_BAM_NEXT_SGL);
>> +	write_reg_dma(nandc, NAND_DEV0_CFG0, 2, NAND_BAM_NEXT_SGL);
>> +	write_reg_dma(nandc, NAND_EXEC_CMD, 1, NAND_BAM_NEXT_SGL);
>> +
>> +	ret = submit_descs(nandc);
>> +	if (ret) {
>> +		dev_err(nandc->dev, "failure in sbumitting erase descriptor\n");
> 
>                                                  :)

      Its spelling mistake. Will fix this in next patch V4.

> 
>> +		free_descs(nandc);
>> +		goto err_out;
>> +	}
>> +	free_descs(nandc);
>> +
>> +	ret = qcom_wait_rdy_poll(chip, q_op.rdy_timeout_ms);
>> +	if (ret)
>> +		goto err_out;
>> +
>> +err_out:
>> +	return ret;
>> +}
>> +
>> +static int qcom_data_read_type_exec(struct nand_chip *chip, const struct nand_subop *subop)
>> +{
>> +	/* currently read_exec_op() return 0 , and all the read operation handle in
>> +	 * actual API itself
>> +	 */
>> +	return 0;
> 
> Mmmh, I don't think this is gonna work. I don't understand what you're
> doing here. What is "actual API itself"? What is "read_exec_op"? I
> doubt I am going to like what all this means. Please don't make any
> assumptions on what could come next. The core asks you to do something,
> just do it. If you can't then the parsing will fail. If the core has a
> fallback it's fine. If the core does not, we can discuss it. But please
> don't do any guesses like that, this is *exactly* why we introduced
> exec_op in the first place: you have access to the whole operation, so
> please handle it correctly.


   Thanks, When Initailly I was started exec_op() implementation I thought
   that nand_read_page_op() will fail, so that I added the dummy
   qcom_data_read_type_exec() and qcom_data_write_type_exec() APIs for read/write.
   But as you said in above comment , we have to follow whatever core ask. So I
   removed these APIs and tested read/write working fine. So now these
   dummy APIs not at all needed.I think I misunderstood. I will keep
   nand_read_page_op() API in original state nand_read_page_op(chip, page, 0, NULL, 0);
   Also removed the pattern for read_page() and write_page() since its not at all
   needed.

   Will fix these all in patch V4.


> 
>> +}
>> +
>> +static int qcom_data_write_type_exec(struct nand_chip *chip, const struct nand_subop *subop)
>> +{
>> +	/* currently write_exec_op() return 0, and all the write operation handle in
>> +	 * actual API itself
>> +	 */
>> +	return 0;
>> +}
>> +
>>   static const struct nand_op_parser qcom_op_parser = NAND_OP_PARSER(
>>   		NAND_OP_PARSER_PATTERN(
>>   			qcom_misc_cmd_type_exec,
>> @@ -3294,6 +3366,23 @@ static const struct nand_op_parser qcom_op_parser = NAND_OP_PARSER(
>>   			NAND_OP_PARSER_PAT_ADDR_ELEM(false, MAX_ADDRESS_CYCLE),
>>   			NAND_OP_PARSER_PAT_WAITRDY_ELEM(true),
>>   			NAND_OP_PARSER_PAT_DATA_IN_ELEM(false, 512)),
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
>>   		);
>>   
>>   static int qcom_check_op(struct nand_chip *chip,
> 
> 
> Thanks,
> Miquèl
