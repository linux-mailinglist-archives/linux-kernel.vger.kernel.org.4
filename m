Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25DA16B3140
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 23:49:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231265AbjCIWsx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 17:48:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231244AbjCIWsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 17:48:50 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0AFB37F32;
        Thu,  9 Mar 2023 14:48:23 -0800 (PST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 329MdOiw022701;
        Thu, 9 Mar 2023 22:48:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=jCp5r5nHForfVmyWDKvzdKSTFdbqCc1jRZu9dDZ7yr8=;
 b=FZd1cK4L3t/xturiKdlksICu3LaRD7N39qQ4Rsgbz+bDgv2Q4EU+bHupVmTISPACZHVl
 UVPfXR+6x5QOHXLijv6mwn+1DZFWy/MtDa3AjtKFBSEtQf6yyHrig2NITfnMZuQWSnCl
 T3CGbHjFUnpAo3VfZ7wdJkLHSzSs8jfE7TOrC9evDPKFai1u3jUvEmiGe8eXSermsfus
 esXVhmxMPrJp4BGsJ4S0JJjf6PoX/EsAnrA3Vild6In3vFQMiB+YUpasIqVBEpp8v4XR
 8HQH9AC8Q6ms5C0DsfzA05y7qPvluHJx5xoT3+Bz8mdphiC1QxeopbAw1QqcwdkQvep5 jg== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3p72qaufxc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Mar 2023 22:48:01 +0000
Received: from nasanex01a.na.qualcomm.com ([10.52.223.231])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 329Mm0ia016411
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 9 Mar 2023 22:48:00 GMT
Received: from [192.168.143.77] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 9 Mar 2023
 14:47:59 -0800
Message-ID: <821e6994-9fed-2c15-6c25-b1761a267ec9@quicinc.com>
Date:   Thu, 9 Mar 2023 14:47:59 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [RFC PATCH v2 1/3] ufs: mcq: Add supporting functions for mcq
 abort
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>, <quic_asutoshd@quicinc.com>,
        <quic_cang@quicinc.com>, <mani@kernel.org>,
        <stanley.chu@mediatek.com>, <adrian.hunter@intel.com>,
        <beanhuo@micron.com>, <avri.altman@wdc.com>,
        <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Arthur Simchaev <Arthur.Simchaev@wdc.com>,
        open list <linux-kernel@vger.kernel.org>
References: <cover.1678338926.git.quic_nguyenb@quicinc.com>
 <68b786f390dbd93218a482d18c513bc332e82da3.1678338926.git.quic_nguyenb@quicinc.com>
 <1ca7dbef-5747-29c2-a11c-086cf36d636f@acm.org>
From:   "Bao D. Nguyen" <quic_nguyenb@quicinc.com>
In-Reply-To: <1ca7dbef-5747-29c2-a11c-086cf36d636f@acm.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: aLZV0joGzHDQNUtH9aELvuC5zuX_qFvX
X-Proofpoint-ORIG-GUID: aLZV0joGzHDQNUtH9aELvuC5zuX_qFvX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-09_12,2023-03-09_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 impostorscore=0 suspectscore=0 clxscore=1015 bulkscore=0
 mlxlogscore=999 spamscore=0 mlxscore=0 phishscore=0 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303090182
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/9/2023 10:15 AM, Bart Van Assche wrote:
> On 3/8/23 21:28, Bao D. Nguyen wrote:
>> +static bool ufshcd_mcq_sqe_search(struct ufs_hba *hba,
>> +        struct ufs_hw_queue *hwq, int task_tag)
>> +{
>> +    struct utp_transfer_req_desc *utrd;
>> +    u32 mask = hwq->max_entries - 1;
>> +    bool ret = false;
>> +    u64 addr, match;
>> +    u32 i;
>
> The variable name "i" is usually used for a loop index. In this case 
> it represents a slot in the submission queue. How about renaming "i" 
> into "slot"?
I will make the change.
>
>> +static inline void ufshcd_mcq_update_sq_head_slot(struct 
>> ufs_hw_queue *q)
>> +{
>> +    u32 val = readl(q->mcq_sq_head);
>> +
>> +    q->sq_head_slot = val / sizeof(struct utp_transfer_req_desc);
>> +}
>
> Please modify this function such that it returns the head slot value 
> instead of storing it in a member variable and remove the sq_head_slot 
> member variable. Storing the sq_head_slot value in a member variable 
> seems wrong to me since the value of that variable will be outdated as 
> soon as the submission queue is restarted.
>
I can modify the function that I am introducing in this patch namely 
ufshcd_mcq_update_sq_head_slot() according to your suggestion.
However, to keep the original mcq code consistent with this change, 
should I make the same modifications to these existing functions 
ufshcd_mcq_update_cq_tail_slot(), ufshcd_mcq_update_cq_head() in a 
separate patch and include in this series?

>> +static inline bool ufshcd_mcq_is_sq_empty(struct ufs_hw_queue *q)
>> +{
>> +    return q->sq_head_slot == q->sq_tail_slot;
>> +}
>
> Please remove this function and inline this function into its callers.

Same comment. Should I also update the existing ufshcd_mcq_is_cq_empty() 
in a separate patch together with ufshcd_mcq_update_cq_tail_slot(), 
ufshcd_mcq_update_cq_head() mentioned above?

Thanks,

Bao

>
> Thanks,
>
> Bart.


