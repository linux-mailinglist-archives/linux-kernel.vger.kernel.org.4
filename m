Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB0E670F2D1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 11:32:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbjEXJcm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 05:32:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjEXJck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 05:32:40 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2265793;
        Wed, 24 May 2023 02:32:39 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34O8c7rJ019014;
        Wed, 24 May 2023 09:32:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=dANZ+34Cj+apXQq0ujqh5laptz7aFMADMcnj2pcYRpg=;
 b=V7KqU+ES0Bv6cJ/Iw18gliaRRDRNAHZR9ZyANakioHJP47CSf0k5Cuy+CKn7ycQ715uL
 QQWupR1isJf5CnWhTdcoyj3DIUJyayVUF9/fDJUOPqA0CG89FjeZ2cJ60anWXGCQvWOm
 4PARlycNFi4Xn4trAbBEoxIEwO/yAWYABYTMXFQov7XaJM3p8DAmClXjfObKd7jjrOza
 wl0zvNVBE/0kTGzXjD7rmI40vU6KQOkmy2Yetuis8pjwz6NGsry564+P5S6z/RwZQzVY
 V3nKvLczbLBUAnUq+SAbmpAkTmV5CjGlcZC3WZdiam/YgxYghNx6c+XXW86dL8A9Wsc4 hQ== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qsf8805df-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 May 2023 09:32:28 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34O9WS0F004019
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 May 2023 09:32:28 GMT
Received: from [10.201.3.104] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Wed, 24 May
 2023 02:32:25 -0700
Message-ID: <fa9806d7-a69a-6998-d77e-543f2dfbf456@quicinc.com>
Date:   Wed, 24 May 2023 15:02:22 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v2 4/5] mtd: rawnand: qcom: Add support for read, write,
 erase exec_ops
Content-Language: en-US
To:     Miquel Raynal <miquel.raynal@bootlin.com>
CC:     <mani@kernel.org>, <richard@nod.at>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_srichara@quicinc.com>
References: <20230511133017.6307-1-quic_mdalam@quicinc.com>
 <20230511133017.6307-5-quic_mdalam@quicinc.com>
 <20230522155345.1d12600e@xps-13>
From:   Md Sadre Alam <quic_mdalam@quicinc.com>
In-Reply-To: <20230522155345.1d12600e@xps-13>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: -U9uGJkjeqSIBjqHQfJKJSV3cPBKL8Au
X-Proofpoint-GUID: -U9uGJkjeqSIBjqHQfJKJSV3cPBKL8Au
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-24_05,2023-05-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=999 mlxscore=0 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305240080
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/22/2023 7:23 PM, Miquel Raynal wrote:
> 
> quic_mdalam@quicinc.com wrote on Thu, 11 May 2023 19:00:16 +0530:
> 
>> This change will add exec_ops support for READ, WRITE, and ERASE
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
>>   drivers/mtd/nand/raw/qcom_nandc.c | 52 +++++++++++++++++++++++++++++--
>>   1 file changed, 49 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qcom_nandc.c
>> index 8717d5086f80..14ab21a4771b 100644
>> --- a/drivers/mtd/nand/raw/qcom_nandc.c
>> +++ b/drivers/mtd/nand/raw/qcom_nandc.c
>> @@ -1765,7 +1765,8 @@ qcom_nandc_read_cw_raw(struct mtd_info *mtd, struct nand_chip *chip,
>>   	int ret, reg_off = FLASH_BUF_ACC, read_loc = 0;
>>   	int raw_cw = cw;
>>   
>> -	nand_read_page_op(chip, page, 0, NULL, 0);
>> +	chip->cont_read.ongoing = false;
> 
> This should be checked once for all by the core at startup, that's when
> you can tell the core continuous read is not supported by the
> controller.

   Sure, Will fix this in next patch V3.
> 
>> +	nand_read_page_op(chip, page, 0, data_buf, mtd->writesize);
>>   	host->use_ecc = false;
>>   
>>   	if (nandc->props->qpic_v2)
>> @@ -2182,14 +2183,24 @@ static void qcom_nandc_codeword_fixup(struct qcom_nand_host *host, int page)
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
>> +	chip->cont_read.ongoing = false;
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
>> @@ -2259,6 +2270,10 @@ static int qcom_nandc_write_page(struct nand_chip *chip, const uint8_t *buf,
>>   
>>   	nand_prog_page_begin_op(chip, page, 0, NULL, 0);
>>   
>> +	set_address(host, 0, page);
>> +	nandc->buf_count = 0;
>> +	nandc->buf_start = 0;
>> +
>>   	clear_read_regs(nandc);
>>   	clear_bam_transaction(nandc);
>>   
>> @@ -3081,7 +3096,38 @@ static int qcom_read_status_exec(struct nand_chip *chip,
>>   
>>   static int qcom_erase_cmd_type_exec(struct nand_chip *chip, const struct nand_subop *subop)
>>   {
>> -	return 0;
>> +	struct qcom_nand_host *host = to_qcom_nand_host(chip);
>> +	struct qcom_nand_controller *nandc = get_qcom_nand_controller(chip);
>> +	struct qcom_op q_op;
>> +	int ret = 0;
>> +
>> +	qcom_parse_instructions(chip, subop, &q_op);
>> +
>> +	q_op.cmd_reg |= PAGE_ACC | LAST_PAGE;
>> +
>> +	pre_command(host, NAND_CMD_ERASE1);
> 
> The instruction is up to the caller, not to the driver. If no other
> instruction rather than NAND_CMD_ERASE1 can be used with this pattern,
> then it should be properly described (see the Arasan controller,
> anfc_check_op()).
> 
   Thanks, will fix this in next patch V3.

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
>> +	if (ret)
>> +		dev_err(nandc->dev, "failure in sbumitting reset descriptor\n");
>> +
>> +	free_descs(nandc);
>> +
>> +	ret = qcom_wait_rdy_poll(chip, q_op.rdy_timeout_ms);
>> +
>> +	return ret;
>>   }
>>   
>>   static int qcom_param_page_type_exec(struct nand_chip *chip,  const struct nand_subop *subop)
> 
> 
> Thanks,
> Miquèl
