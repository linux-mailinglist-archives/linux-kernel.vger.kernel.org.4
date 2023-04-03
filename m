Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD18B6D5188
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 21:45:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232442AbjDCTpY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 15:45:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231538AbjDCTpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 15:45:22 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B69F1FFB;
        Mon,  3 Apr 2023 12:45:19 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 333CdQnq028963;
        Mon, 3 Apr 2023 19:45:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=+Ac7/4Z2yuxpzK/gq/zmiCvWHonCoDbbOTHmIXxz6Yo=;
 b=FvD3PIT0ChMNInzNRrLa1yjTRUH/YqMiahCtkgHh6+t404CJenfC7OKQCspSiHiwTpVp
 KXug0J/fQS377/VgtULnZ2FWc5b5MTvvkRERQ3qIb0gLb4ket8pNu83pY1SpMTljmHcK
 PAZjLJm7cxq3MbwYBX+fmxlC6qBmxW02CSt0qnQSRXgfXfCCZWrkycbo6Q1gmX+dJbBo
 fZ0lzfqAnCG5jtm/ZEOZvU8nfm35pYNnwI4huyMHJ+TfvYKexGO6U3VJQJYJdM0kENNA
 uNFglv/MhQd4/GFDpsJbXFHfTMTbCvMA7yYaQ9nslhSFxIWWR8lsaUhlMlTnzj6q20Pz EA== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pqw36s9xr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 Apr 2023 19:45:03 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 333Jj1ut007791
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 3 Apr 2023 19:45:01 GMT
Received: from [10.134.65.165] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Mon, 3 Apr 2023
 12:44:57 -0700
Message-ID: <c60ec162-a6aa-d239-6c58-d6212064951b@quicinc.com>
Date:   Mon, 3 Apr 2023 12:44:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v11 03/26] gunyah: Common types and error codes for Gunyah
 hypercalls
To:     Alex Elder <elder@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>
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
        Will Deacon <will@kernel.org>, Andy Gross <agross@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20230304010632.2127470-1-quic_eberman@quicinc.com>
 <20230304010632.2127470-4-quic_eberman@quicinc.com>
 <ea527244-c8ff-77fb-db77-3aa5470f3fb6@linaro.org>
Content-Language: en-US
From:   Elliot Berman <quic_eberman@quicinc.com>
In-Reply-To: <ea527244-c8ff-77fb-db77-3aa5470f3fb6@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: kuPQrEpQCzbuV2_lIH8KqdXAuDoW68XF
X-Proofpoint-GUID: kuPQrEpQCzbuV2_lIH8KqdXAuDoW68XF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-03_15,2023-04-03_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 phishscore=0 clxscore=1015 malwarescore=0 adultscore=0 mlxscore=0
 mlxlogscore=739 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304030153
X-Spam-Status: No, score=-2.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/31/2023 7:24 AM, Alex Elder wrote:
> On 3/3/23 7:06 PM, Elliot Berman wrote:
>> Add architecture-independent standard error codes, types, and macros for
>> Gunyah hypercalls.
>>
>> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
> 
> See a few comments below.    -Alex
> 
>> ---
>>   include/linux/gunyah.h | 83 ++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 83 insertions(+)
>>   create mode 100644 include/linux/gunyah.h
>>
>> diff --git a/include/linux/gunyah.h b/include/linux/gunyah.h
>> new file mode 100644
>> index 000000000000..54b4be71caf7
>> --- /dev/null
>> +++ b/include/linux/gunyah.h
>> @@ -0,0 +1,83 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +/*
>> + * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All 
>> rights reserved.
>> + */
>> +
>> +#ifndef _LINUX_GUNYAH_H
>> +#define _LINUX_GUNYAH_H
>> +
>> +#include <linux/errno.h>
>> +#include <linux/limits.h>
>> +
>> +/******************************************************************************/
>> +/* Common arch-independent definitions for Gunyah 
>> hypercalls                  */
>> +#define GH_CAPID_INVAL    U64_MAX
>> +#define GH_VMID_ROOT_VM    0xff
> 
> The above definition doesn't seem to be used anywhere, but seeing
> it begs the question to me of what type it is expected to have.
> If it were used, where would it be used in an 8 bit field?
> 

VMIDs are u16, the root VM (Resource Manager) VMID is 0xff. I think this 
definition snuck in from the downstream code and is indeed not being 
needed/used anywhere. I'll remove it.

>> +
>> +enum gh_error {
>> +    GH_ERROR_OK            = 0,
>> +    GH_ERROR_UNIMPLEMENTED        = -1,
>> +    GH_ERROR_RETRY            = -2,
> 
> There might be nothing fundamentally wrong with this, but I
> dislike seeing negative values assigned to enums.
> 
> These error values are returned from the hypervisor, and it
> looks like they'll likely truncated from a 64-bit unsigned
> value.  Are they *sent* from the hypervisor as 64-bit signed
> values?  Or 32-bit signed values?  (In that case, the
> 
> I just wonder if you can use 0xffffffff or 0xffff for example
> rather than -1, depending on the actual value that gets passed.
> 

They are sent from the hypervisor as 64-bit signed values (it's filling 
a register). I think truncating should be OK because Gunyah wants to 
maintain capability with 32-bit architectures and we would not see an 
error number that truly requires more than 32 bits to represent.

>> +
>> +    GH_ERROR_ARG_INVAL        = 1,
>> +    GH_ERROR_ARG_SIZE        = 2,
>> +    GH_ERROR_ARG_ALIGN        = 3,
>> +
>> +    GH_ERROR_NOMEM            = 10,
>> +
>> +    GH_ERROR_ADDR_OVFL        = 20,
>> +    GH_ERROR_ADDR_UNFL        = 21,
>> +    GH_ERROR_ADDR_INVAL        = 22,
>> +
>> +    GH_ERROR_DENIED            = 30,
>> +    GH_ERROR_BUSY            = 31,
>> +    GH_ERROR_IDLE            = 32,
>> +
>> +    GH_ERROR_IRQ_BOUND        = 40,
>> +    GH_ERROR_IRQ_UNBOUND        = 41,
>> +
>> +    GH_ERROR_CSPACE_CAP_NULL    = 50,
>> +    GH_ERROR_CSPACE_CAP_REVOKED    = 51,
>> +    GH_ERROR_CSPACE_WRONG_OBJ_TYPE    = 52,
>> +    GH_ERROR_CSPACE_INSUF_RIGHTS    = 53,
>> +    GH_ERROR_CSPACE_FULL        = 54,
>> +
>> +    GH_ERROR_MSGQUEUE_EMPTY        = 60,
>> +    GH_ERROR_MSGQUEUE_FULL        = 61,
>> +};
>> +
>> +/**
>> + * gh_remap_error() - Remap Gunyah hypervisor errors into a Linux 
>> error code
>> + * @gh_error: Gunyah hypercall return value
>> + */
>> +static inline int gh_remap_error(enum gh_error gh_error)
> 
> Since you're remapping a gh_error, I would have named this
> gh_error_remap().
> 

Done.

>> +{
>> +    switch (gh_error) {
>> +    case GH_ERROR_OK:
>> +        return 0;
>> +    case GH_ERROR_NOMEM:
>> +        return -ENOMEM;
>> +    case GH_ERROR_DENIED:
>> +    case GH_ERROR_CSPACE_CAP_NULL:
>> +    case GH_ERROR_CSPACE_CAP_REVOKED:
>> +    case GH_ERROR_CSPACE_WRONG_OBJ_TYPE:
>> +    case GH_ERROR_CSPACE_INSUF_RIGHTS:
>> +    case GH_ERROR_CSPACE_FULL:
>> +        return -EACCES;
>> +    case GH_ERROR_BUSY:
>> +    case GH_ERROR_IDLE:
>> +        return -EBUSY;
>> +    case GH_ERROR_IRQ_BOUND:
>> +    case GH_ERROR_IRQ_UNBOUND:
>> +    case GH_ERROR_MSGQUEUE_FULL:
>> +    case GH_ERROR_MSGQUEUE_EMPTY:
>> +        return -EIO;
>> +    case GH_ERROR_UNIMPLEMENTED:
>> +    case GH_ERROR_RETRY:
>> +        return -EOPNOTSUPP;
>> +    default:
>> +        return -EINVAL;
>> +    }
>> +}
>> +
>> +#endif
> 
