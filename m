Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A15726647D5
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 18:56:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233545AbjAJR4N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 12:56:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234149AbjAJRzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 12:55:47 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF5907CDD2;
        Tue, 10 Jan 2023 09:55:25 -0800 (PST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30ACiPdM011158;
        Tue, 10 Jan 2023 17:55:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : from : subject : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=bsupJ31BTXkeH2VYmXxsRvepy5ZeRJ9/IKO65yE7UpE=;
 b=HXoVjoNbBfKDiDR9WeJswAlmV/IfVjBCUpWk5PeVrOCLPTjtNb3pprUWnMqwVbsYbdta
 eSaipPBEMniEd1OEoFhDPD8LA6P7sB834rAUk/lwgRvGgWS8V0q2RcsvceZkR3arGPvV
 wE5FBfjcsjYWisgvZu3cYACHPCALhD2dWk5xZ1Nab7APP8qsIf/8qA+GHjkDky/Y2ofY
 J1aMXevyjWCl3+mCbxSAPlk7PGc97cFLgrSuoH+tECAOtaUsBZniyIRG2k1n2zYm5Xkg
 GBiDjJ2paJPAaJiT8gn8Fn1CyJfqxR3L3WI6OkIB3Rhu6gkCR6XMtyC9gnxJUlxN9Cyp qA== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n0q28jpye-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Jan 2023 17:55:12 +0000
Received: from nasanex01b.na.qualcomm.com (corens_vlan604_snip.qualcomm.com [10.53.140.1])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30AHtBvN027679
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Jan 2023 17:55:11 GMT
Received: from [10.134.67.48] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 10 Jan
 2023 09:55:10 -0800
Message-ID: <29dc78ee-1eaa-7e3d-f28c-07a6b60ed2b2@quicinc.com>
Date:   Tue, 10 Jan 2023 09:55:10 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
From:   Elliot Berman <quic_eberman@quicinc.com>
Subject: Re: [PATCH v8 03/28] gunyah: Common types and error codes for Gunyah
 hypercalls
To:     Alex Elder <elder@linaro.org>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Murali Nalajala <quic_mnalajal@quicinc.com>
CC:     Trilok Soni <quic_tsoni@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "Bagas Sanjaya" <bagasdotme@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        "Sudeep Holla" <sudeep.holla@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "Lorenzo Pieralisi" <lpieralisi@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-acpi@vger.kernel.org>
References: <20221219225850.2397345-1-quic_eberman@quicinc.com>
 <20221219225850.2397345-4-quic_eberman@quicinc.com>
 <14eba2db-6f35-8b29-2b5e-6f1937b4e318@linaro.org>
Content-Language: en-US
In-Reply-To: <14eba2db-6f35-8b29-2b5e-6f1937b4e318@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: gUZNVjMhzUxr0FbWf7flWmBnOhmDvJWQ
X-Proofpoint-GUID: gUZNVjMhzUxr0FbWf7flWmBnOhmDvJWQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-10_07,2023-01-10_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 bulkscore=0
 lowpriorityscore=0 mlxlogscore=921 malwarescore=0 suspectscore=0
 adultscore=0 spamscore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301100115
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/9/2023 1:34 PM, Alex Elder wrote:
> On 12/19/22 4:58 PM, Elliot Berman wrote:
>> Add architecture-independent standard error codes, types, and macros for
>> Gunyah hypercalls.
>>
>> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
>> ---
>>   MAINTAINERS            |  1 +
>>   include/linux/gunyah.h | 74 ++++++++++++++++++++++++++++++++++++++++++
>>   2 files changed, 75 insertions(+)
>>   create mode 100644 include/linux/gunyah.h
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index f32320a9efa4..74e76e0ab14d 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -8941,6 +8941,7 @@ L:    linux-arm-msm@vger.kernel.org
>>   S:    Supported
>>   F:    Documentation/devicetree/bindings/firmware/gunyah-hypervisor.yaml
>>   F:    Documentation/virt/gunyah/
>> +F:    include/linux/gunyah.h
>>   HABANALABS PCI DRIVER
>>   M:    Oded Gabbay <ogabbay@kernel.org>
>> diff --git a/include/linux/gunyah.h b/include/linux/gunyah.h
>> new file mode 100644
>> index 000000000000..824e20a11d27
>> --- /dev/null
>> +++ b/include/linux/gunyah.h
>> @@ -0,0 +1,74 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +/*
>> + * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights 
>> reserved.
>> + */
>> +
>> +#ifndef _GUNYAH_H
> 
> Maybe use _LINUX_GUNYAH_H?
> 

Ack.

>> +#define _GUNYAH_H
>> +
>> +#include <linux/types.h>
> 
> Why is types.h included?
> 
> U64_MAX is defined in <linux/limits.h> (in case that's why).

Ack.

> 
> Otherwise this just defines a fixed API exposed by Gunyah
> so there's not much more for me to comment on.
> 
>                      -Alex
> 
>> +#include <linux/errno.h>
>> +
>> +/* Common Gunyah macros */
>> +#define GH_CAPID_INVAL    U64_MAX
>> +#define GH_VMID_ROOT_VM    0xff
>> +
>> +#define GH_ERROR_OK            0
>> +
>> +#define GH_ERROR_UNIMPLEMENTED        -1
>> +#define GH_ERROR_RETRY            -2
>> +
>> +#define GH_ERROR_ARG_INVAL        1
>> +#define GH_ERROR_ARG_SIZE        2
>> +#define GH_ERROR_ARG_ALIGN        3
>> +
>> +#define GH_ERROR_NOMEM            10
>> +
>> +#define GH_ERROR_ADDR_OVFL        20
>> +#define GH_ERROR_ADDR_UNFL        21
>> +#define GH_ERROR_ADDR_INVAL        22
>> +
>> +#define GH_ERROR_DENIED            30
>> +#define GH_ERROR_BUSY            31
>> +#define GH_ERROR_IDLE            32
>> +
>> +#define GH_ERROR_IRQ_BOUND        40
>> +#define GH_ERROR_IRQ_UNBOUND        41
>> +
>> +#define GH_ERROR_CSPACE_CAP_NULL    50
>> +#define GH_ERROR_CSPACE_CAP_REVOKED    51
>> +#define GH_ERROR_CSPACE_WRONG_OBJ_TYPE    52
>> +#define GH_ERROR_CSPACE_INSUF_RIGHTS    53
>> +#define GH_ERROR_CSPACE_FULL        54
>> +
>> +#define GH_ERROR_MSGQUEUE_EMPTY        60
>> +#define GH_ERROR_MSGQUEUE_FULL        61
>> +
>> +static inline int gh_remap_error(int gh_error)
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
>> +        return -EPERM;
>> +    default:
>> +        return -EINVAL;
>> +    }
>> +}
>> +
>> +#endif
> 
