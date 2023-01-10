Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 950966647F4
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 18:59:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234892AbjAJR7Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 12:59:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235339AbjAJR6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 12:58:01 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C2B5848F6;
        Tue, 10 Jan 2023 09:56:58 -0800 (PST)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30AEg6J1028558;
        Tue, 10 Jan 2023 17:56:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : from : subject : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=iorMp17q7wINe0N4cPm7TTA02s+Ru0Iit7bFiFuy9t8=;
 b=nijQqr1253SUqmBCmtqGaV2nKwD8lst/prEqeSVKalINyarTEcZircZ7d4HEA10m5Sa3
 WZGXfWGqgb5a+b8K2WS2ujiqCpTqro1XVs7ONiyV1R6P5e5dhdAqW5C/4GoQ9M//d6L5
 BcHpVtgW72w0xfIRUYTVkEoK2/CvGjO8skYFYLT6aAdcU3QeeuDk5KCBZKvnHXNRD5/m
 QIokAWi9UYBkyGScJmSJRsJzbCLCsoWUJecxIDfFZvQGz+uJ8XnpqlT9sdx6vvXSXVsS
 3rYPJXpb7LbkU35pBHSqGI2h3N+KKcvMU3LcL9YBGqLCD1lacMaMvf5J5NUiNZUvTRi9 xw== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n0sshabn3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Jan 2023 17:56:43 +0000
Received: from nasanex01b.na.qualcomm.com (corens_vlan604_snip.qualcomm.com [10.53.140.1])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30AHufhv029190
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Jan 2023 17:56:41 GMT
Received: from [10.134.67.48] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 10 Jan
 2023 09:56:41 -0800
Message-ID: <7e64039a-55ce-d79d-8501-10de09269afb@quicinc.com>
Date:   Tue, 10 Jan 2023 09:56:40 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
From:   Elliot Berman <quic_eberman@quicinc.com>
Subject: Re: [PATCH v8 06/28] virt: gunyah: Identify hypervisor version
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
 <20221219225850.2397345-7-quic_eberman@quicinc.com>
 <51c36831-19c1-dd67-9e31-87733c190a9c@linaro.org>
Content-Language: en-US
In-Reply-To: <51c36831-19c1-dd67-9e31-87733c190a9c@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: e2wEreoohIgL8SWgbG9PdENHo8Q5EPFS
X-Proofpoint-ORIG-GUID: e2wEreoohIgL8SWgbG9PdENHo8Q5EPFS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-10_07,2023-01-10_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 spamscore=0 clxscore=1015 suspectscore=0
 adultscore=0 impostorscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301100115
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/9/2023 1:34 PM, Alex Elder wrote:
> On 12/19/22 4:58 PM, Elliot Berman wrote:
>> Export the version of Gunyah which is reported via the hyp_identify
>> hypercall. Increments of the major API version indicate possibly
>> backwards incompatible changes.
>>
>> Export the hypervisor identity so that Gunyah drivers can act according
>> to the major API version.
>>
>> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
>> ---
>>   drivers/virt/Makefile        |  1 +
>>   drivers/virt/gunyah/Makefile |  1 +
>>   drivers/virt/gunyah/gunyah.c | 46 ++++++++++++++++++++++++++++++++++++
>>   include/linux/gunyah.h       |  6 +++++
>>   4 files changed, 54 insertions(+)
>>   create mode 100644 drivers/virt/gunyah/Makefile
>>   create mode 100644 drivers/virt/gunyah/gunyah.c
>>
>> diff --git a/drivers/virt/Makefile b/drivers/virt/Makefile
>> index 093674e05c40..92b7e5311548 100644
>> --- a/drivers/virt/Makefile
>> +++ b/drivers/virt/Makefile
>> @@ -11,3 +11,4 @@ obj-$(CONFIG_NITRO_ENCLAVES)    += nitro_enclaves/
>>   obj-$(CONFIG_ACRN_HSM)        += acrn/
>>   obj-$(CONFIG_EFI_SECRET)    += coco/efi_secret/
>>   obj-$(CONFIG_SEV_GUEST)       += coco/sev-guest/
>> +obj-y                += gunyah/
>> diff --git a/drivers/virt/gunyah/Makefile b/drivers/virt/gunyah/Makefile
>> new file mode 100644
>> index 000000000000..2ac4ee64b89d
>> --- /dev/null
>> +++ b/drivers/virt/gunyah/Makefile
>> @@ -0,0 +1 @@
>> +obj-$(CONFIG_GUNYAH) += gunyah.o
>> diff --git a/drivers/virt/gunyah/gunyah.c b/drivers/virt/gunyah/gunyah.c
>> new file mode 100644
>> index 000000000000..c34c9046fc08
>> --- /dev/null
>> +++ b/drivers/virt/gunyah/gunyah.c
>> @@ -0,0 +1,46 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights 
>> reserved.
>> + */
>> +
>> +#define pr_fmt(fmt) "gunyah: " fmt
>> +
>> +#include <linux/gunyah.h>
>> +#include <linux/init.h>
>> +#include <linux/module.h>
>> +#include <linux/printk.h>
>> +
>> +struct gh_hypercall_hyp_identify_resp gunyah_api;
>> +EXPORT_SYMBOL_GPL(gunyah_api);
>> +
>> +static const uint32_t gunyah_known_uuids[][4] = {
>> +    {0x19bd54bd, 0x0b37571b, 0x946f609b, 0x54539de6}, /*QC_HYP 
>> (Qualcomm's build) */
>> +    {0x673d5f14, 0x9265ce36, 0xa4535fdb, 0xc1d58fcd}, /*GUNYAH (open 
>> source build) */
>> +};
>> +
>> +static int __init gunyah_init(void)
>> +{
>> +    u32 uid[4];
>> +    int i;
>> +
>> +    gh_hypercall_get_uid(uid);
>> +
>> +    for (i = 0; i < ARRAY_SIZE(gunyah_known_uuids); i++)
>> +        if (!memcmp(uid, gunyah_known_uuids[i], sizeof(uid)))
>> +            break;
>> +
>> +    if (i == ARRAY_SIZE(gunyah_known_uuids))
>> +        return -ENODEV;
>> +
>> +    gh_hypercall_hyp_identify(&gunyah_api);
>> +
>> +    pr_info("Running under Gunyah hypervisor %llx/v%u\n",
>> +        FIELD_GET(GH_API_INFO_VARIANT_MASK, gunyah_api.api_info),
>> +        gh_api_version());
>> +
>> +    return 0;
>> +}
>> +arch_initcall(gunyah_init);
>> +
>> +MODULE_LICENSE("GPL");
>> +MODULE_DESCRIPTION("Gunyah Hypervisor Driver");
>> diff --git a/include/linux/gunyah.h b/include/linux/gunyah.h
>> index 2765d2b40198..166156f69df9 100644
>> --- a/include/linux/gunyah.h
>> +++ b/include/linux/gunyah.h
>> @@ -92,6 +92,12 @@ struct gh_hypercall_hyp_identify_resp {
>>       u64 api_info;
>>       u64 flags[3];
>>   };
>> +extern struct gh_hypercall_hyp_identify_resp gunyah_api;
> 
> Must this global variable be exposed?  Can't you hide it--as
> well as its interpretation--inside "gunyah.c"?
>  >> +
>> +static inline u16 gh_api_version(void)
>> +{
>> +    return FIELD_GET(GH_API_INFO_API_VERSION_MASK, gunyah_api.api_info);
>> +}
> 
> If you don't make the above function inline, can you hide the
> definition of gunyah_api?
> 

This seems like a good idea to me. I'm thinking to have the following 
functions:

enum gh_api_feature {
	GH_API_FEATURE_DOORBELL,
	GH_API_FEATURE_MSGQUEUE,
	GH_API_FEATURE_VIC,
	GH_API_FEATURE_VPM,
	GH_API_FEATURE_VCPU,
	GH_API_FEATURE_MEMEXTENT,
	GH_API_FEATURE_TRACE_CTRL,
};

u16 gh_api_version(void);
bool gh_api_has_feature(enum gh_api_feature feature);

Thanks,
Elliot
