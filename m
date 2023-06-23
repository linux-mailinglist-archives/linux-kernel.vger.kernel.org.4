Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4956573B917
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 15:49:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232036AbjFWNtH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 09:49:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232051AbjFWNsj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 09:48:39 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABF8926A0;
        Fri, 23 Jun 2023 06:48:28 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35NC5n4k017019;
        Fri, 23 Jun 2023 13:48:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=wXHP52HDTH7fhbNUHkxBwNKmBwYF5l8AumM5UFiEFdA=;
 b=cvsCJxahr3OH1lB4s8XCEKIv6PcqzTQyiOXQnkuiyr3XTJg26eaheJC5jsXpCsDb989r
 llyh2MzGYCqb3cqj7U0Zommj7/Iz0LTioply/UBsdtoTWFvcPwzVGixAJh62FySikPrt
 oUMYDbIV15tbfveyE7XZRNLGvdbntbeZa6mzsiXJrzU1do7N/RMS1ttBGV0DTIw/3cLn
 YnvpUd+ScyoljRg/aiGAcMknrLRlqIOikhGLox4E/fyDPC0DLm1KJZKqGj5B94w0niQ5
 o6KM5/+2YbNuzaglN461VkelkCTHNwMqKdPD6kqccOW1KKXWlK8ZgPXxYISJcJq9akZq gA== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rcw93hkkk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Jun 2023 13:48:23 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35NDmNkl019496
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Jun 2023 13:48:23 GMT
Received: from [10.204.67.150] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Fri, 23 Jun
 2023 06:48:20 -0700
Message-ID: <bae13ff0-e59b-e0c6-6a60-e52191119511@quicinc.com>
Date:   Fri, 23 Jun 2023 19:18:17 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v1] misc: fastrpc: Pass proper scm arguments for static
 process init
Content-Language: en-US
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        <linux-arm-msm@vger.kernel.org>
CC:     <ekangupt@qti.qualcomm.com>, <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, <bkumar@qti.qualcomm.com>,
        <fastrpc.upstream@qti.qualcomm.com>, stable <stable@kernel.org>
References: <1685972918-30371-1-git-send-email-quic_ekangupt@quicinc.com>
 <16d255fc-7186-11a9-58b5-2d3787f69d59@linaro.org>
From:   Ekansh Gupta <quic_ekangupt@quicinc.com>
In-Reply-To: <16d255fc-7186-11a9-58b5-2d3787f69d59@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 0ZyTS7aUKBnmgBhcwFraiI0ZeGxcZbGG
X-Proofpoint-ORIG-GUID: 0ZyTS7aUKBnmgBhcwFraiI0ZeGxcZbGG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-23_07,2023-06-22_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 adultscore=0 clxscore=1015 impostorscore=0 spamscore=0 phishscore=0
 mlxlogscore=999 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306230125
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/12/2023 4:40 PM, Srinivas Kandagatla wrote:
> Thanks Ekansh for the patch.
> 
> 
> On 05/06/2023 14:48, Ekansh Gupta wrote:
>> Memory is allocated for dynamic loading when audio daemon is trying
>> to attach to audioPD on DSP side. This memory is allocated from
>> reserved CMA memory region and needs ownership assignment to
>> new VMID in order to use it from audioPD.
>>
>> In the current implementation, arguments are not correctly passed
>> to the scm call which might result in failure of dynamic loading
>> on audioPD. Added changes to pass correct arguments during daemon
>> attach request.
>>
>> Fixes:     0871561055e6 ("misc: fastrpc: Add support for audiopd")
>> Cc: stable <stable@kernel.org>
>> Tested-by: Ekansh Gupta <quic_ekangupt@quicinc.com>
>> Signed-off-by: Ekansh Gupta <quic_ekangupt@quicinc.com>
>> ---
>>   drivers/misc/fastrpc.c | 31 +++++++++++++++++++++++++------
>>   1 file changed, 25 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
>> index 30d4d04..b7335dd 100644
>> --- a/drivers/misc/fastrpc.c
>> +++ b/drivers/misc/fastrpc.c
>> @@ -1278,10 +1278,23 @@ static int 
>> fastrpc_init_create_static_process(struct fastrpc_user *fl,
>>           /* Map if we have any heap VMIDs associated with this ADSP 
>> Static Process. */
>>           if (fl->cctx->vmcount) {
>> +            u64 src_perms = BIT(QCOM_SCM_VMID_HLOS);
> 
> This is redundant too, we already have cctx->perms initialized to 
> exactly same bit map.
> 
>> +            struct qcom_scm_vmperm *dst_perms;
>> +            u32 i;
>> +
>> +            dst_perms = kcalloc(fl->cctx->vmcount,
>> +                            sizeof(struct qcom_scm_vmperm), GFP_KERNEL);
>> +            if (!dst_perms)
>> +                return -ENOMEM;
>> +            for (i = 0; i < fl->cctx->vmcount; i++) {
>> +                dst_perms[i].vmid = fl->cctx->vmperms[i].vmid;
>> +                dst_perms[i].perm = fl->cctx->vmperms[i].perm;
> 
> why do we need to copy this to another struct when we already have this 
> information in fl->cctx->vmperms ?
> 
>> +            }
>> +
>>               err = qcom_scm_assign_mem(fl->cctx->remote_heap->phys,
>>                               (u64)fl->cctx->remote_heap->size,
>> -                            &fl->cctx->perms,
>> -                            fl->cctx->vmperms, fl->cctx->vmcount);
>> +                            &src_perms, dst_perms, fl->cctx->vmcount);
> 
> 
>> +            kfree(dst_perms);
>>               if (err) {
>>                   dev_err(fl->sctx->dev, "Failed to assign memory with 
>> phys 0x%llx size 0x%llx err %d",
>>                       fl->cctx->remote_heap->phys, 
>> fl->cctx->remote_heap->size, err);
>> @@ -1322,13 +1335,19 @@ static int 
>> fastrpc_init_create_static_process(struct fastrpc_user *fl,
>>       return 0;
>>   err_invoke:
>>       if (fl->cctx->vmcount) {
>> -        struct qcom_scm_vmperm perm;
>> +        u64 src_perms = 0;
>> +        struct qcom_scm_vmperm dst_perms;
>> +        u32 i;
>> -        perm.vmid = QCOM_SCM_VMID_HLOS;
>> -        perm.perm = QCOM_SCM_PERM_RWX;
>> +        for (i = 0; i < fl->cctx->vmcount; i++) {
>> +            src_perms |= BIT(fl->cctx->vmperms[i].vmid);
>> +        }
> no need for brackets here.
Thanks Srini for your comments. I'll address them in next patch.

-ekansh
>> +
>> +        dst_perms.vmid = QCOM_SCM_VMID_HLOS;
>> +        dst_perms.perm = QCOM_SCM_PERM_RWX;
>>           err = qcom_scm_assign_mem(fl->cctx->remote_heap->phys,
>>                           (u64)fl->cctx->remote_heap->size,
>> -                        &fl->cctx->perms, &perm, 1);
>> +                        &src_perms, &dst_perms, 1);
>>           if (err)
>>               dev_err(fl->sctx->dev, "Failed to assign memory phys 
>> 0x%llx size 0x%llx err %d",
>>                   fl->cctx->remote_heap->phys, 
>> fl->cctx->remote_heap->size, err);
