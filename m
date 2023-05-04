Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60E7F6F63B4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 05:54:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbjEDDyk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 23:54:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjEDDye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 23:54:34 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5261E77;
        Wed,  3 May 2023 20:54:32 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3443k4xM032149;
        Thu, 4 May 2023 03:53:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=rWnRs6caAFnPoAXVFONMmd19SUyveSsytUGzvc8lnnU=;
 b=YipYstZ9llTyzwv2F9LjKlVCfP11J4TPkoTdYr6tBVurClTAQBOYCb3hnhn/B98ip3AW
 w6iHlbpik6g4NuTcdLMteS+c1s4t0/btWLJcO0Xd4wYPpVpcAJP7MTM0rU/qmT0SAiRj
 pz+gyNFNJUSrsE2ColzoKZ1Q+K0Mfxn/ySCOljBzH91podPcf+cblQpsH6eJkcxW57rQ
 BouCu1r7/cJPrwAXx61kjRkq7fw2EFxV1T4PAtlnB6YUKQmQ5Lzlam7O7uCLLx5WKZKU
 XAb+Ewt4zN2ylcEqQMm/AOxuQC7DJlUTSowPBRK33AEzNYnNTkvL19MIQpJEa7OW/HKZ Zw== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qc2aj08wh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 04 May 2023 03:53:40 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3443rc4X025709
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 4 May 2023 03:53:39 GMT
Received: from [192.168.143.77] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Wed, 3 May 2023
 20:53:38 -0700
Message-ID: <4c3648fb-f41c-d097-cd38-f2efcee9ec71@quicinc.com>
Date:   Wed, 3 May 2023 20:53:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 1/5] ufs: mcq: Add supporting functions for mcq abort
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>, <quic_asutoshd@quicinc.com>,
        <quic_cang@quicinc.com>, <mani@kernel.org>,
        <Powen.Kao@mediatek.com>, <stanley.chu@mediatek.com>,
        <adrian.hunter@intel.com>, <beanhuo@micron.com>,
        <avri.altman@wdc.com>, <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Arthur Simchaev <Arthur.Simchaev@wdc.com>,
        Eric Biggers <ebiggers@google.com>,
        open list <linux-kernel@vger.kernel.org>
References: <cover.1681764704.git.quic_nguyenb@quicinc.com>
 <382670235be85aaa7b7dc407bcf378483ac03562.1681764704.git.quic_nguyenb@quicinc.com>
 <19a823d9-d4b0-3c62-38a0-b54dc3937ab3@acm.org>
From:   "Bao D. Nguyen" <quic_nguyenb@quicinc.com>
In-Reply-To: <19a823d9-d4b0-3c62-38a0-b54dc3937ab3@acm.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 6xyAcAowx9G6NBMNkZrCYicmjgBuGYvn
X-Proofpoint-GUID: 6xyAcAowx9G6NBMNkZrCYicmjgBuGYvn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-04_01,2023-05-03_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 adultscore=0 mlxlogscore=999 impostorscore=0 mlxscore=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 phishscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2305040031
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bart,
Thank you so much for a detailed code review.

On 4/25/2023 5:04 PM, Bart Van Assche wrote:
> On 4/17/23 14:05, Bao D. Nguyen wrote:
>> +/* Max mcq register polling time in milisecond unit */
> 
> A nit: please change "millisecond unit" into "milliseconds".
Yes I will change.

> 
>> +static int ufshcd_mcq_poll_register(void __iomem *reg, u32 mask,
>> +                u32 val, unsigned long timeout_ms)
>> +{
>> +    unsigned long timeout = jiffies + msecs_to_jiffies(timeout_ms);
>> +    int err = 0;
>> +
>> +    /* ignore bits that we don't intend to wait on */
>> +    val = val & mask;
>> +
>> +    while ((readl(reg) & mask) != val) {
> 
> & has a higher precedence than != so one pair of parentheses can be left 
> out.
I think it is is actually the other way. & has lower precedence than !=.
Please correct me if I am wrong.

> 
>> +        udelay(20);
>> +        if (time_after(jiffies, timeout)) {
> 
> Please use time_is_before_jiffies() instead of time_after(jiffies, ...).
time_is_before_jiffies() seems to be defined as time_after(). Could you 
please explain the benefits to choose one over the other?

> 
>> +            err = -ETIMEDOUT;
>> +            break;
>> +        }
>> +    }
>> +
>> +    return err;
>> +}
> 
> Please remove the variable 'err' and return the return value directly.
Yes I will change.

>> +
>> +static int ufshcd_mcq_sq_stop(struct ufs_hba *hba, struct 
>> ufs_hw_queue *hwq)
>> +{
>> +    void __iomem *reg;
>> +    u32 i = hwq->id;
> 
> Please use another variable name than 'i' for a hardware queue ID ('id'?).
Yes I will change.

> 
>> +    u32 i = hwq->id;
> 
> Same comment here.
Yes I will change.

> 
>> +/**
>> + * ufshcd_mcq_sq_cleanup - Clean up Submission Queue resources
> 
> A nit: please use lower case text for "submission queue" and also in the 
> comments below ("Clean up" -> "clean up").
The UFS Host Controller specification uses upper case for the Submission 
Queue and Completion Queue, so I tried to follow the the spec language. 
I don't have a preference. I will make the change.

> 
>> +    spin_lock(&hwq->sq_lock);
>> +
>> +    /* stop the SQ fetching before working on it */
>> +    err = ufshcd_mcq_sq_stop(hba, hwq);
>> +    if (err)
>> +        goto unlock;
> 
> No spin locks around delay loops please. Is there anything that prevents 
> to change sq_lock from a spin lock into a mutex?
This function can be called from multiple non-interrupt contexts. I 
needed to prevent concurrent accesses to the sq hw, so yes mutex would 
work better. I will change.

> 
>> +static u64 ufshcd_mcq_get_cmd_desc_addr(struct ufs_hba *hba,
>> +                    int task_tag)
>> +{
>> +    struct ufshcd_lrb *lrbp = &hba->lrb[task_tag];
>> +    __le32 hi = lrbp->utr_descriptor_ptr->command_desc_base_addr_hi;
>> +    __le32 lo = lrbp->utr_descriptor_ptr->command_desc_base_addr_lo;
>> +
>> +    return le64_to_cpu((__le64)hi << 32 | lo);
>> +}
> 
> Please add a new patch at the head of this series that modifies struct 
> utp_transfer_req_desc such that command_desc_base_addr_lo and 
> command_desc_base_addr_hi are combined into a single __le64 variable.
Yes, I will add this as a separate patch.

> 
>> +/**
>> + * ufshcd_mcq_nullify_cmd - Nullify utrd. Host controller does not fetch
>> + * transfer with Command Type = 0xF. post the Completion Queue with 
>> OCS=ABORTED.
>> + * @hba - per adapter instance.
>> + * @hwq - Hardware Queue of the nullified utrd.
>> + */
>> +static void ufshcd_mcq_nullify_cmd(struct ufs_hba *hba, struct 
>> ufs_hw_queue *hwq)
>> +{
>> +    struct utp_transfer_req_desc *utrd;
>> +    u32 dword_0;
>> +
>> +    utrd = (struct utp_transfer_req_desc *)(hwq->sqe_base_addr +
>> +            hwq->id * sizeof(struct utp_transfer_req_desc));
> 
> Please double check this function. It has "cmd" in the function name but 
> none of the arguments passed to this function allows to uniquely 
> identify a command. Is an argument perhaps missing from this function?
Yes, I will make the correction to this function and rename it to 
ufshcd_mcq_nullify_sqe()

> 
> Additionally, hwq->sqe_base_addr points to an array of SQE entries. I do 
> not understand why hwq->id * sizeof(struct utp_transfer_req_desc) is 
> added to that base address. Please clarify. >
>> +        utrd = (struct utp_transfer_req_desc *)(hwq->sqe_base_addr +
>> +                sq_head_slot * sizeof(struct utp_transfer_req_desc));
> 
> hwq->sqe_base_addr already has type struct utp_transfer_req_desc * so 
> the " * sizeof(struct utp_transfer_req_desc)" part looks wrong to me.
Yes, I will correct this.

> 
>> diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
>> index 35a3bd9..808387c 100644
>> --- a/drivers/ufs/core/ufshcd.c
>> +++ b/drivers/ufs/core/ufshcd.c
>> @@ -56,7 +56,6 @@
>>   #define NOP_OUT_RETRIES    10
>>   /* Timeout after 50 msecs if NOP OUT hangs without response */
>>   #define NOP_OUT_TIMEOUT    50 /* msecs */
>> -
>>   /* Query request retries */
>>   #define QUERY_REQ_RETRIES 3
>>   /* Query request timeout */
> 
> Is the above change really necessary?
The blank line was removed by mistake. I will put it back.

>> @@ -173,7 +172,6 @@ EXPORT_SYMBOL_GPL(ufshcd_dump_regs);
>>   enum {
>>       UFSHCD_MAX_CHANNEL    = 0,
>>       UFSHCD_MAX_ID        = 1,
>> -    UFSHCD_NUM_RESERVED    = 1,
>>       UFSHCD_CMD_PER_LUN    = 32 - UFSHCD_NUM_RESERVED,
>>       UFSHCD_CAN_QUEUE    = 32 - UFSHCD_NUM_RESERVED,
>>   };
> 
> Same question here - is this change really necessary?
I am moving the definition of UFSHCD_NUM_RESERVED to 
include/ufs/ufshci.h file so that I can access it from /core/ufs-mcq.c


> Thanks,
> 
> Bart.

