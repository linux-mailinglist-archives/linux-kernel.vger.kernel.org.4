Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19BC173B912
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 15:48:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231975AbjFWNsT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 09:48:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231970AbjFWNsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 09:48:02 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 859692683;
        Fri, 23 Jun 2023 06:47:52 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35NDIhOP001859;
        Fri, 23 Jun 2023 13:47:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=qeZOd6t88l7R9L6KRwGZHuEZ1hfUgStlMJpZgNgrpLA=;
 b=LL40cHiyJAVw7MR3seUwPrCaIgMToHRHpD1yutLOwG52vR7+zOo9YnO/VuH2H+2jW3DW
 NwQbr7tQHUrFWrQDvZ9N/G0EuHSHzO3ReDj7zEMLTtno84dO49c4+bWnrC8NtlLVlAdB
 bRjG04EYyWUftioZtZdhltFLIAZCJZHOiRTSvfgugeX5Ys7r44ZJMadD1yi0BzvyaiW7
 X6fplLz4KpijuGNDrjWqV14MDGUt+7KuyCBav7O2FYQFdZ1goYY+LxfINwnlK/jNg+We
 P+sIH0tRL9s9XUU2NktP1lh5NjtFz3b01zTmadfT9U2wl/Xatx0kV5BnB0OmD9PSE50G bw== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rcju83hh9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Jun 2023 13:47:47 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35NDlaYT010380
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Jun 2023 13:47:36 GMT
Received: from [10.204.67.150] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Fri, 23 Jun
 2023 06:47:33 -0700
Message-ID: <b8265a1d-926c-f8c4-7b60-de5f55bd1b0a@quicinc.com>
Date:   Fri, 23 Jun 2023 19:17:30 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v1] misc: fastrpc: Fix remote heap allocation request
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        <linux-arm-msm@vger.kernel.org>
CC:     <ekangupt@qti.qualcomm.com>, <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, <bkumar@qti.qualcomm.com>,
        <fastrpc.upstream@qti.qualcomm.com>, stable <stable@kernel.org>
References: <1685974276-23435-1-git-send-email-quic_ekangupt@quicinc.com>
 <81343778-6d5c-db85-29e3-8fcba0ec2e8a@linaro.org>
Content-Language: en-US
From:   Ekansh Gupta <quic_ekangupt@quicinc.com>
In-Reply-To: <81343778-6d5c-db85-29e3-8fcba0ec2e8a@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 6uSgvIoDs_HITDroV5kJCVMihI41OFWB
X-Proofpoint-GUID: 6uSgvIoDs_HITDroV5kJCVMihI41OFWB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-23_07,2023-06-22_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 clxscore=1011 phishscore=0 suspectscore=0 mlxlogscore=999
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 malwarescore=0
 impostorscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2305260000 definitions=main-2306230125
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/12/2023 5:34 PM, Srinivas Kandagatla wrote:
> 
> 
> On 05/06/2023 15:11, Ekansh Gupta wrote:
>> Remote heap is used by DSP audioPD on need basis. This memory is
>> allocated from reserved CMA memory region and is then shared with
>> audioPD to use it for it's functionality.
>>
>> Current implementation of remote heap is not allocating the memory
>> from CMA region, instead it is allocating the memory from SMMU
>> context bank. The arguments passed to scm call for the reassignment
>> of ownership is also not correct. Added changes to allocate CMA
>> memory and have a proper ownership reassignment.
>>
>> Fixes: 532ad70c6d44 ("misc: fastrpc: Add mmap request assigning for 
>> static PD pool")
>> Cc: stable <stable@kernel.org>
>> Tested-by: Ekansh Gupta <quic_ekangupt@quicinc.com>
>> Signed-off-by: Ekansh Gupta <quic_ekangupt@quicinc.com>
>> ---
>>   drivers/misc/fastrpc.c | 26 ++++++++++++++++++++------
>>   1 file changed, 20 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
>> index 30d4d04..f5fc2de 100644
>> --- a/drivers/misc/fastrpc.c
>> +++ b/drivers/misc/fastrpc.c
>> @@ -1866,7 +1866,11 @@ static int fastrpc_req_mmap(struct fastrpc_user 
>> *fl, char __user *argp)
>>           return -EINVAL;
>>       }
>> -    err = fastrpc_buf_alloc(fl, fl->sctx->dev, req.size, &buf);
>> +    if (req.flags == ADSP_MMAP_REMOTE_HEAP_ADDR)
>> +        err = fastrpc_remote_heap_alloc(fl, dev, req.size, &buf);
>> +    else
>> +        err = fastrpc_buf_alloc(fl, dev, req.size, &buf);
>> +
>>       if (err) {
>>           dev_err(dev, "failed to allocate buffer\n");
>>           return err;
>> @@ -1905,12 +1909,22 @@ static int fastrpc_req_mmap(struct 
>> fastrpc_user *fl, char __user *argp)
>>       /* Add memory to static PD pool, protection thru hypervisor */
>>       if (req.flags == ADSP_MMAP_REMOTE_HEAP_ADDR && fl->cctx->vmcount) {
>> -        struct qcom_scm_vmperm perm;
>> +        u64 src_perms = BIT(QCOM_SCM_VMID_HLOS);
>> +        struct qcom_scm_vmperm *dst_perms;
>> +        u32 i;
>> -        perm.vmid = QCOM_SCM_VMID_HLOS;
>> -        perm.perm = QCOM_SCM_PERM_RWX;
>> -        err = qcom_scm_assign_mem(buf->phys, buf->size,
>> -            &fl->cctx->perms, &perm, 1);
>> +        dst_perms = kcalloc(fl->cctx->vmcount,
>> +            sizeof(struct qcom_scm_vmperm), GFP_KERNEL);
>> +        if (!dst_perms)
>> +            return -ENOMEM;
>> +        for (i = 0; i < fl->cctx->vmcount; i++) {
>> +            dst_perms[i].vmid = fl->cctx->vmperms[i].vmid;
>> +            dst_perms[i].perm = fl->cctx->vmperms[i].perm;
>> +        }
>> +
> Why not use fl->cctx->vmperms instead of allocating a new dst_perms?
> 
> --srini
> 
Thanks Srini for your comments. I'll address them in next patch.
>> +        err = qcom_scm_assign_mem(buf->phys,(u64)buf->size,
>> +            &src_perms, dst_perms, fl->cctx->vmcount);
>> +        kfree(dst_perms);
>>           if (err) {
>>               dev_err(fl->sctx->dev, "Failed to assign memory phys 
>> 0x%llx size 0x%llx err %d",
>>                       buf->phys, buf->size, err);
