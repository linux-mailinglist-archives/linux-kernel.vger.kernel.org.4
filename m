Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDE3D6FDA4B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 11:02:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236660AbjEJJCC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 05:02:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236339AbjEJJB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 05:01:59 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB909EE;
        Wed, 10 May 2023 02:01:57 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34A7UmLs023779;
        Wed, 10 May 2023 09:01:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=qBDumBzrCI7aae8oKRaUH7S73VcwhbmFv1GeBKcmgZk=;
 b=V1dpMDpmzRI2Y7b4n3MgC7JkpHTDoq2XA/dHN2saRrvj/8ViHsppZjnwHbbfCEix7D9C
 a+irrZVI3GDsn+XrJjPdI5NPj+mgVH/9LKQvl+RDTsZAGQWTfiuaqWwtLsFzc8SO3qWm
 8LmglCygd8XVeJwLrW9BevRqjw6dIe7hxlz6Vu+MTYrordkfcfDs08CPI2tm3HQpsZem
 2UgZ3WdxxJ8PSp9dfWZ1I4GNC8QbaNcCvvGVHdyaeDGbTuVd/yU/cEKgJTzyamlURMjc
 IjpWocQKh9ogTW0OuDBYo1lHl+uw5kLfcgCZwmraRLg6pObeod0rEFg347zRCpvPrBOe VA== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qfrut9rva-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 May 2023 09:01:33 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34A91Wpq021150
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 May 2023 09:01:32 GMT
Received: from [10.216.49.192] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Wed, 10 May
 2023 02:01:28 -0700
Message-ID: <18728f4a-bf69-9290-c551-5ea7356405f4@quicinc.com>
Date:   Wed, 10 May 2023 14:31:25 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH V2] mtd: rawnand: qcom: Implement exec_op()
To:     Manivannan Sadhasivam <mani@kernel.org>
CC:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_srichara@quicinc.com>
References: <20230419093617.27134-1-quic_mdalam@quicinc.com>
 <20230509110804.GC4823@thinkpad>
Content-Language: en-US
From:   Md Sadre Alam <quic_mdalam@quicinc.com>
In-Reply-To: <20230509110804.GC4823@thinkpad>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: OlZhK6_6yvHqX6FHEaiKiae_2cVsIzqU
X-Proofpoint-ORIG-GUID: OlZhK6_6yvHqX6FHEaiKiae_2cVsIzqU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-10_04,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 phishscore=0 bulkscore=0
 clxscore=1011 adultscore=0 lowpriorityscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305100069
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/9/2023 4:38 PM, Manivannan Sadhasivam wrote:
> On Wed, Apr 19, 2023 at 03:06:17PM +0530, Md Sadre Alam wrote:
>> Implement exec_op() so we can later get rid of the legacy interface
>> implementation.
>>
> 
> It's good that you got the inspiration from previous exec_op() conversion
> patches, but this one should've been splitted into atleast two patches as per
> your patch description.
> 
> One introducing exec_op() and another getting rid of legacy interface.


  Thanks Mani for reviewing. I am going to split the patches as below.

  1) Introduce exec_op structure, parser, command mappping.

  2) Add support for RESET, READID, STATUS exec_ops

  3) Add support for READ_PARAM_PAGE exec_ops

  4) Add support for ERASE, READ, WRITE exec_ops

  5) Remove legacy interface

> 
>> Co-developed-by: Sricharan R <quic_srichara@quicinc.com>
>> Signed-off-by: Sricharan R <quic_srichara@quicinc.com>
>> Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
>> ---
>> Change in [V2]
>>
>> * Address all Miquel comments from V1, regarding exec_ops design
>>
>> * Redesign qpic nand driver with exec_ops using exec_ops parser, to
>>    fit in exec_ops framework
>>
>>   drivers/mtd/nand/raw/qcom_nandc.c | 869 ++++++++++++++++++------------
>>   1 file changed, 520 insertions(+), 349 deletions(-)
>>
>> diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qcom_nandc.c
>> index 72d6168d8a1b..17279890454d 100644
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
>> @@ -432,6 +434,7 @@ struct qcom_nand_controller {
>>   	int reg_read_pos;
>>   
>>   	u32 cmd1, vld;
>> +	bool exec_opwrite;
> 
> Missing kdoc.

  Will add in next patch

> 
>>   };
>>   
>>   /*
>> @@ -447,6 +450,37 @@ struct qcom_nand_boot_partition {
>>   	u32 page_size;
>>   };
>>   
>> +/*
>> + * QCOM op for each exec_op transfer
> 
> What is "QCOM op"? Also please stick to "Qcom" everywhere.

   It is exec_op ops for all instruction supported .
   Will update in next patch.

> 
>> + *
>> + * @addr1_reg:			Address1 register value
>> + *
>> + * @addr2_reg:			Address2 register value
>> + *
>> + * @cmd_reg:			CMD register value
>> + *
>> + * @rdy_timeout_ms:		wait ready timeout in ms
>> + *
> 
> First letter caps for all instances.

   will do in next patch

> 
>> + * @rdy_delay_ns:		Additional delay in ns
>> + *
>> + * @data_instr_idx:		data instruction index
>> + *
>> + * @data_instr:			data instruction pointer
>> + *
> 
> Do not leave this extra newline comment in-between.

   will do in next patch

> 
>> + * @flag:			flag for misc instruction
>> + *
>> + */
>> +struct qcom_op {
>> +	u32 addr1_reg;
>> +	u32 addr2_reg;
>> +	u32 cmd_reg;
>> +	unsigned int rdy_timeout_ms;
>> +	unsigned int rdy_delay_ns;
>> +	unsigned int data_instr_idx;
>> +	const struct nand_op_instr *data_instr;
> 
> Move the pointer to start of the struct.

  will do in next patch.

> 
>> +	u8 flag;
>> +};
>> +
>>   /*
>>    * NAND chip structure
>>    *
>> @@ -765,7 +799,6 @@ static void set_address(struct qcom_nand_host *host, u16 column, int page)
>>   
>>   	if (chip->options & NAND_BUSWIDTH_16)
>>   		column >>= 1;
>> -
> 
> Sporadic?

   will fix in next patch
> 
>>   	nandc_set_reg(chip, NAND_ADDR0, page << 16 | column);
>>   	nandc_set_reg(chip, NAND_ADDR1, page >> 16 & 0xff);
>>   }
>> @@ -1273,155 +1306,6 @@ static void config_nand_cw_write(struct nand_chip *chip)
>>   	write_reg_dma(nandc, NAND_READ_STATUS, 1, NAND_BAM_NEXT_SGL);
>>   }
>>   
>> -/*
>> - * the following functions are used within chip->legacy.cmdfunc() to
>> - * perform different NAND_CMD_* commands
>> - */
>> -
>> -/* sets up descriptors for NAND_CMD_PARAM */
>> -static int nandc_param(struct qcom_nand_host *host)
> 
> As I pointed out above, you need to split these removals into a separate patch.

   will do in next patch.
> 
>> -{
>> -	struct nand_chip *chip = &host->chip;
>> -	struct qcom_nand_controller *nandc = get_qcom_nand_controller(chip);
>> -
>> -	/*
>> -	 * NAND_CMD_PARAM is called before we know much about the FLASH chip
>> -	 * in use. we configure the controller to perform a raw read of 512
>> -	 * bytes to read onfi params
>> -	 */
>> -	if (nandc->props->qpic_v2)
>> -		nandc_set_reg(chip, NAND_FLASH_CMD, OP_PAGE_READ_ONFI_READ |
>> -			      PAGE_ACC | LAST_PAGE);
>> -	else
>> -		nandc_set_reg(chip, NAND_FLASH_CMD, OP_PAGE_READ |
>> -			      PAGE_ACC | LAST_PAGE);
>> -
>> -	nandc_set_reg(chip, NAND_ADDR0, 0);
>> -	nandc_set_reg(chip, NAND_ADDR1, 0);
>> -	nandc_set_reg(chip, NAND_DEV0_CFG0, 0 << CW_PER_PAGE
>> -					| 512 << UD_SIZE_BYTES
>> -					| 5 << NUM_ADDR_CYCLES
>> -					| 0 << SPARE_SIZE_BYTES);
>> -	nandc_set_reg(chip, NAND_DEV0_CFG1, 7 << NAND_RECOVERY_CYCLES
>> -					| 0 << CS_ACTIVE_BSY
>> -					| 17 << BAD_BLOCK_BYTE_NUM
>> -					| 1 << BAD_BLOCK_IN_SPARE_AREA
>> -					| 2 << WR_RD_BSY_GAP
>> -					| 0 << WIDE_FLASH
>> -					| 1 << DEV0_CFG1_ECC_DISABLE);
>> -	if (!nandc->props->qpic_v2)
>> -		nandc_set_reg(chip, NAND_EBI2_ECC_BUF_CFG, 1 << ECC_CFG_ECC_DISABLE);
>> -
>> -	/* configure CMD1 and VLD for ONFI param probing in QPIC v1 */
>> -	if (!nandc->props->qpic_v2) {
>> -		nandc_set_reg(chip, NAND_DEV_CMD_VLD,
>> -			      (nandc->vld & ~READ_START_VLD));
>> -		nandc_set_reg(chip, NAND_DEV_CMD1,
>> -			      (nandc->cmd1 & ~(0xFF << READ_ADDR))
>> -			      | NAND_CMD_PARAM << READ_ADDR);
>> -	}
>> -
>> -	nandc_set_reg(chip, NAND_EXEC_CMD, 1);
>> -
>> -	if (!nandc->props->qpic_v2) {
>> -		nandc_set_reg(chip, NAND_DEV_CMD1_RESTORE, nandc->cmd1);
>> -		nandc_set_reg(chip, NAND_DEV_CMD_VLD_RESTORE, nandc->vld);
>> -	}
>> -
>> -	nandc_set_read_loc(chip, 0, 0, 0, 512, 1);
>> -
>> -	if (!nandc->props->qpic_v2) {
>> -		write_reg_dma(nandc, NAND_DEV_CMD_VLD, 1, 0);
>> -		write_reg_dma(nandc, NAND_DEV_CMD1, 1, NAND_BAM_NEXT_SGL);
>> -	}
>> -
>> -	nandc->buf_count = 512;
>> -	memset(nandc->data_buffer, 0xff, nandc->buf_count);
>> -
>> -	config_nand_single_cw_page_read(chip, false, 0);
>> -
>> -	read_data_dma(nandc, FLASH_BUF_ACC, nandc->data_buffer,
>> -		      nandc->buf_count, 0);
>> -
>> -	/* restore CMD1 and VLD regs */
>> -	if (!nandc->props->qpic_v2) {
>> -		write_reg_dma(nandc, NAND_DEV_CMD1_RESTORE, 1, 0);
>> -		write_reg_dma(nandc, NAND_DEV_CMD_VLD_RESTORE, 1, NAND_BAM_NEXT_SGL);
>> -	}
>> -
>> -	return 0;
>> -}
> 
> [...]
> 
>>   /*
>>    * when using BCH ECC, the HW flags an error in NAND_FLASH_STATUS if it read
>>    * an erased CW, and reports an erased CW in NAND_ERASED_CW_DETECT_STATUS.
>> @@ -1735,7 +1491,8 @@ qcom_nandc_read_cw_raw(struct mtd_info *mtd, struct nand_chip *chip,
>>   	int ret, reg_off = FLASH_BUF_ACC, read_loc = 0;
>>   	int raw_cw = cw;
>>   
>> -	nand_read_page_op(chip, page, 0, NULL, 0);
>> +	chip->cont_read.ongoing = false;
>> +	nand_read_page_op(chip, page, 0, data_buf, 2048);
> 
> How is this change related to exec_op() conversion? Looks like this and few
> things below should be part of a separate patch.

   Without this data_buf and proper length the read exec_op api is not getting called
   from nand_base layer. So its needed. As i am separating patches , this change will be part
   of read exec_op support patch.
> 
>>   	host->use_ecc = false;
>>   
>>   	if (nandc->props->qpic_v2)
>> @@ -2047,7 +1804,9 @@ static int read_page_ecc(struct qcom_nand_host *host, u8 *data_buf,
>>   		return ret;
>>   	}
>>   
>> -	return parse_read_errors(host, data_buf_start, oob_buf_start, page);
>> +	ret = parse_read_errors(host, data_buf_start, oob_buf_start, page);
>> +
>> +	return ret;
> 
> Why?

   will fix in next patch
> 
>>   }
>>   
>>   /*
>> @@ -2154,12 +1913,25 @@ static int qcom_nandc_read_page(struct nand_chip *chip, uint8_t *buf,
>>   {
>>   	struct qcom_nand_host *host = to_qcom_nand_host(chip);
>>   	struct qcom_nand_controller *nandc = get_qcom_nand_controller(chip);
>> +	struct nand_ecc_ctrl *ecc = &chip->ecc;
>>   	u8 *data_buf, *oob_buf = NULL;
>> +	int ret = 0;
>>   
>>   	if (host->nr_boot_partitions)
>>   		qcom_nandc_codeword_fixup(host, page);
>>   
>> -	nand_read_page_op(chip, page, 0, NULL, 0);
>> +	chip->cont_read.ongoing = false;
>> +	ret = nand_read_page_op(chip, page, 0, buf, 2048);
>> +	if (ret)
>> +		return ret;
>> +
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
>> @@ -2229,6 +2001,10 @@ static int qcom_nandc_write_page(struct nand_chip *chip, const uint8_t *buf,
>>   
>>   	nand_prog_page_begin_op(chip, page, 0, NULL, 0);
>>   
>> +	set_address(host, 0, page);
>> +	nandc->buf_count = 0;
>> +	nandc->buf_start = 0;
>> +
> 
> As said above, you need a separate patch for the above change. I do not get the
> context of the above change.
> 
> And I stopped reviewing here. It's hard to review ~800 lines of change in one
> shot. Please split this patch into sensible chunks so that it makes life easy
> for reviewers.
> 
> - Mani

   Sure will fix all comments in next patch and post it again.

  Thanks,
  Alam.

> 
