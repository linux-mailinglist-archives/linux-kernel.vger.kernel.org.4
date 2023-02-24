Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B234F6A23B7
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 22:24:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbjBXVYj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 16:24:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230165AbjBXVYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 16:24:34 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C5CF39CF7;
        Fri, 24 Feb 2023 13:24:21 -0800 (PST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31OCG7Nt012852;
        Fri, 24 Feb 2023 21:24:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=dqn3TSizO1k0WXRWN0nK+feytmKUay5FFzXt31bXIZk=;
 b=WPoC+b/cQ5HOwg375AGWx/+c3gnzUeF0v/2y3P4qXN0l2eIpgTme8BPvDTqspIa5pCEH
 EzBlekb5AZ4wmddiahDsg93jAjh/+pF4M9cEaKGI1ggDsT+f8cdNJ3G7QBFL9oCANsnL
 5CDo0n1fODi5y81Bsmd0hP2O0/GNp4CiDBY5xKwih2i1yCEpwbC4hn3tGG242XghLUBh
 4KamqAIz3E9TKGWzvB3X8LckhsVZ1lqfd7Q/9qZFJ+unVOktkf2fAH5WL/5lfmoJi9SF
 /Qq9lQW7PoS6dq6yshWfixucGEt+5vVg65Z3Tf7XionP9jhOwqlw8ru6VOadZWf6YXhV Ow== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nxw3d9jn3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Feb 2023 21:24:03 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31OLO2F3015714
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Feb 2023 21:24:02 GMT
Received: from [10.110.9.108] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 24 Feb
 2023 13:24:00 -0800
Message-ID: <556dedfa-2c18-fca7-94d9-994d29b7bacc@quicinc.com>
Date:   Fri, 24 Feb 2023 13:24:00 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v10 06/26] virt: gunyah: msgq: Add hypercalls to send and
 receive messages
Content-Language: en-US
To:     Alex Elder <alex.elder@linaro.org>, Alex Elder <elder@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Will Deacon" <will@kernel.org>
CC:     Murali Nalajala <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        "Konrad Dybcio" <konrad.dybcio@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20230214211229.3239350-1-quic_eberman@quicinc.com>
 <20230214212303.3307536-1-quic_eberman@quicinc.com>
 <d4cdae93-a003-d07f-3074-3542a231747b@linaro.org>
From:   Elliot Berman <quic_eberman@quicinc.com>
In-Reply-To: <d4cdae93-a003-d07f-3074-3542a231747b@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: rL3Ze6N_w2egxgkQGAEE24YRFNj3xBCX
X-Proofpoint-ORIG-GUID: rL3Ze6N_w2egxgkQGAEE24YRFNj3xBCX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-24_16,2023-02-24_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 mlxscore=0 lowpriorityscore=0 phishscore=0 adultscore=0
 suspectscore=0 bulkscore=0 impostorscore=0 mlxlogscore=999 malwarescore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302240169
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/23/2023 4:15 PM, Alex Elder wrote:
> On 2/14/23 3:23 PM, Elliot Berman wrote:
>> Add hypercalls to send and receive messages on a Gunyah message queue.
>>
>> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
>> ---
>>   arch/arm64/gunyah/gunyah_hypercall.c | 32 ++++++++++++++++++++++++++++
>>   include/linux/gunyah.h               |  7 ++++++
>>   2 files changed, 39 insertions(+)
>>
>> diff --git a/arch/arm64/gunyah/gunyah_hypercall.c 
>> b/arch/arm64/gunyah/gunyah_hypercall.c
>> index f30d06ee80cf..2ca9ab098ff6 100644
>> --- a/arch/arm64/gunyah/gunyah_hypercall.c
>> +++ b/arch/arm64/gunyah/gunyah_hypercall.c
>> @@ -38,6 +38,8 @@ EXPORT_SYMBOL_GPL(arch_is_gunyah_guest);
>>                              fn)
>>   #define GH_HYPERCALL_HYP_IDENTIFY        GH_HYPERCALL(0x8000)
>> +#define GH_HYPERCALL_MSGQ_SEND            GH_HYPERCALL(0x801B)
>> +#define GH_HYPERCALL_MSGQ_RECV            GH_HYPERCALL(0x801C)
>>   /**
>>    * gh_hypercall_hyp_identify() - Returns build information and 
>> feature flags
>> @@ -57,5 +59,35 @@ void gh_hypercall_hyp_identify(struct 
>> gh_hypercall_hyp_identify_resp *hyp_identi
>>   }
>>   EXPORT_SYMBOL_GPL(gh_hypercall_hyp_identify);
>> +enum gh_error gh_hypercall_msgq_send(u64 capid, size_t size, 
>> uintptr_t buff, int tx_flags,
>> +                    bool *ready)
>> +{
>> +    struct arm_smccc_res res;
>> +
>> +    arm_smccc_1_1_hvc(GH_HYPERCALL_MSGQ_SEND, capid, size, buff, 
>> tx_flags, 0, &res);
>> +
>> +    if (res.a0 == GH_ERROR_OK)
>> +        *ready = res.a1;
>> +
>> +    return res.a0;
>> +}
>> +EXPORT_SYMBOL_GPL(gh_hypercall_msgq_send);
>> +
>> +enum gh_error gh_hypercall_msgq_recv(u64 capid, uintptr_t buff, 
>> size_t size, size_t *recv_size,
>> +                    bool *ready)
>> +{
>> +    struct arm_smccc_res res;
>> +
>> +    arm_smccc_1_1_hvc(GH_HYPERCALL_MSGQ_RECV, capid, buff, size, 0, 
>> &res);
>> +
>> +    if (res.a0 == GH_ERROR_OK) {
>> +        *recv_size = res.a1;
> 
> Is there any chance the 64-bit size is incompatible
> with size_t?  (Too big?)

This is safe because size of messages <= 240.

> 
>> +        *ready = res.a2;
> 
>          *ready = !!res.a2;
> 
>> +    }
>> +
>> +    return res.a0;
>> +}
>> +EXPORT_SYMBOL_GPL(gh_hypercall_msgq_recv);
>> +
>>   MODULE_LICENSE("GPL");
>>   MODULE_DESCRIPTION("Gunyah Hypervisor Hypercalls");
>> diff --git a/include/linux/gunyah.h b/include/linux/gunyah.h
>> index 3fef2854c5e1..cb6df4eec5c2 100644
>> --- a/include/linux/gunyah.h
>> +++ b/include/linux/gunyah.h
>> @@ -112,4 +112,11 @@ struct gh_hypercall_hyp_identify_resp {
>>   void gh_hypercall_hyp_identify(struct gh_hypercall_hyp_identify_resp 
>> *hyp_identity);
>> +#define GH_HYPERCALL_MSGQ_TX_FLAGS_PUSH        BIT(0)
>> +
>> +enum gh_error gh_hypercall_msgq_send(u64 capid, size_t size, 
>> uintptr_t buff, int tx_flags,
>> +                    bool *ready);
> 
> Why uintptr_t?  Why not just pass a host pointer (void *)
> and do whatever conversion is necessary inside the function?
> 
>                      -Alex
> 
>> +enum gh_error gh_hypercall_msgq_recv(u64 capid, uintptr_t buff, 
>> size_t size, size_t *recv_size,
>> +                    bool *ready);
>> +
>>   #endif
> 
