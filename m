Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E61CE6819D7
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 20:05:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237974AbjA3TFv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 14:05:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjA3TFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 14:05:49 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F4C138668;
        Mon, 30 Jan 2023 11:05:48 -0800 (PST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30UHnAqJ015621;
        Mon, 30 Jan 2023 19:05:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=5GNIkhVp6wjOm5iEvu3ujOX68JBENnpJ0gN3RaSIKT0=;
 b=LTmotiit1WWBk+LDgzMq6CVrozjHbqewNNzRvHBTrkb3s/Cxb1aZp8EG0klXF45sgZSB
 fNbzXftw/DDyjMwbI9UpXLjAvC6cYpsd85f8n3JRLxsUn2WUcB2Ovoh0HWeB5bLvAJcb
 BvOq74pOEIjlAeVf6FXrzJVA6BHEnnuyHXpVqr2s3bxwgRAqAwqwz+MPN+yh0E0O8am+
 N4E2UsRBg87+qoZkaRryomSp6qP2L4DHn4s+LkILcUpSNzxSHTEese3WDti5cKbDcvxp
 4xeFfXyeqiMEYZBYgyZ3K2LRO9J8HC/aaGMaSbWRz2AQiUYmPBi6PRD5c0zRXuQDQVMg 5g== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ncsdpvnet-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Jan 2023 19:05:27 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30UJ5Qa0023506
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Jan 2023 19:05:26 GMT
Received: from [10.134.67.48] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 30 Jan
 2023 11:05:26 -0800
Message-ID: <5dbce62b-5c51-6989-d08d-16955d97b4e6@quicinc.com>
Date:   Mon, 30 Jan 2023 11:05:25 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v9 04/27] virt: gunyah: Add hypercalls to identify Gunyah
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Alex Elder <elder@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Murali Nalajala <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Marc Zyngier <maz@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20230120224627.4053418-1-quic_eberman@quicinc.com>
 <20230120224627.4053418-5-quic_eberman@quicinc.com>
 <Y9eVcHM9nZZ/4ZSh@kroah.com>
From:   Elliot Berman <quic_eberman@quicinc.com>
In-Reply-To: <Y9eVcHM9nZZ/4ZSh@kroah.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 6J-mrU5vzFJKFIzMsMuHIadiSuzMK0mq
X-Proofpoint-ORIG-GUID: 6J-mrU5vzFJKFIzMsMuHIadiSuzMK0mq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-30_17,2023-01-30_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 suspectscore=0 mlxlogscore=999
 spamscore=0 clxscore=1015 impostorscore=0 mlxscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301300180
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/30/2023 2:01 AM, Greg Kroah-Hartman wrote:
> On Fri, Jan 20, 2023 at 02:46:03PM -0800, Elliot Berman wrote:
>> Add hypercalls to identify when Linux is running a virtual machine under
>> Gunyah.
>>
>> There are two calls to help identify Gunyah:
>>
>> 1. gh_hypercall_get_uid() returns a UID when running under a Gunyah
>>     hypervisor.
>> 2. gh_hypercall_hyp_identify() returns build information and a set of
>>     feature flags that are supported by Gunyah.
>>
>> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
>> ---
>>   MAINTAINERS                          |  2 +
>>   arch/arm64/Kbuild                    |  1 +
>>   arch/arm64/gunyah/Makefile           |  3 ++
>>   arch/arm64/gunyah/gunyah_hypercall.c | 75 ++++++++++++++++++++++++++++
>>   drivers/virt/Kconfig                 |  2 +
>>   drivers/virt/gunyah/Kconfig          | 14 ++++++
>>   include/linux/gunyah.h               | 33 ++++++++++++
>>   7 files changed, 130 insertions(+)
>>   create mode 100644 arch/arm64/gunyah/Makefile
>>   create mode 100644 arch/arm64/gunyah/gunyah_hypercall.c
>>   create mode 100644 drivers/virt/gunyah/Kconfig
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index f1e07e39b2f5..fe19e71efc6d 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -9048,6 +9048,8 @@ L:	linux-arm-msm@vger.kernel.org
>>   S:	Supported
>>   F:	Documentation/devicetree/bindings/firmware/gunyah-hypervisor.yaml
>>   F:	Documentation/virt/gunyah/
>> +F:	arch/arm64/gunyah/
>> +F:	drivers/virt/gunyah/
>>   F:	include/linux/gunyah.h
>>   
>>   HABANALABS PCI DRIVER
>> diff --git a/arch/arm64/Kbuild b/arch/arm64/Kbuild
>> index 5bfbf7d79c99..e4847ba0e3c9 100644
>> --- a/arch/arm64/Kbuild
>> +++ b/arch/arm64/Kbuild
>> @@ -3,6 +3,7 @@ obj-y			+= kernel/ mm/ net/
>>   obj-$(CONFIG_KVM)	+= kvm/
>>   obj-$(CONFIG_XEN)	+= xen/
>>   obj-$(subst m,y,$(CONFIG_HYPERV))	+= hyperv/
>> +obj-$(CONFIG_GUNYAH)	+= gunyah/
>>   obj-$(CONFIG_CRYPTO)	+= crypto/
>>   
>>   # for cleaning
>> diff --git a/arch/arm64/gunyah/Makefile b/arch/arm64/gunyah/Makefile
>> new file mode 100644
>> index 000000000000..84f1e38cafb1
>> --- /dev/null
>> +++ b/arch/arm64/gunyah/Makefile
>> @@ -0,0 +1,3 @@
>> +# SPDX-License-Identifier: GPL-2.0
>> +
>> +obj-$(CONFIG_GUNYAH) += gunyah_hypercall.o
>> diff --git a/arch/arm64/gunyah/gunyah_hypercall.c b/arch/arm64/gunyah/gunyah_hypercall.c
>> new file mode 100644
>> index 000000000000..ffed4b71641f
>> --- /dev/null
>> +++ b/arch/arm64/gunyah/gunyah_hypercall.c
>> @@ -0,0 +1,75 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
>> + */
>> +
>> +#include <linux/arm-smccc.h>
>> +#include <linux/module.h>
>> +#include <linux/gunyah.h>
>> +
>> +static const uint32_t gunyah_known_uuids[][4] = {
> 
> uint32_t is not a kernel type, please use sane ones, like u32.
> 
>> +	{0x19bd54bd, 0x0b37571b, 0x946f609b, 0x54539de6}, /* QC_HYP (Qualcomm's build) */
>> +	{0x673d5f14, 0x9265ce36, 0xa4535fdb, 0xc1d58fcd}, /* GUNYAH (open source build) */
> 
> And why not use the kernel uuid type here?  Why create your own?
> 
>> +};
>> +
>> +#define GH_HYPERCALL_HYP_IDENTIFY		GH_HYPERCALL(0x0000)
>> +
>> +/**
>> + * gh_hypercall_get_uid() - Returns a UID when running under a Gunyah hypervisor
>> + * @uid: An array of 4 u32's (u32 uid[4];)
>> + *
>> + * Caller should compare the resulting UID to a list of known Gunyah UIDs to
>> + * confirm that Linux is running as a guest of Gunyah.
>> + */
>> +void gh_hypercall_get_uid(u32 uid[4])
>> +{
>> +	struct arm_smccc_res res;
>> +	u32 uid[4];
> 
> How does this work when you have a local variable the same name as the
> parameter to the function?  What shadows what and how?  The compiler
> didn't complain about this?
> 
>> +	int i;
>> +
>> +	arm_smccc_1_1_hvc(ARM_SMCCC_VENDOR_HYP_CALL_UID_FUNC_ID, &res);
>> +
>> +	uid[0] = lower_32_bits(res.a0);
>> +	uid[1] = lower_32_bits(res.a1);
>> +	uid[2] = lower_32_bits(res.a2);
>> +	uid[3] = lower_32_bits(res.a3);
>> +
>> +	for (i = 0; i < ARRAY_SIZE(gunyah_known_uuids); i++)
>> +		if (!memcmp(uid, gunyah_known_uuids[i], sizeof(uid)))
>> +			break;
>> +
>> +	return i != ARRAY_SIZE(gunyah_known_uuids);
> 
> How can a function that returns void actually return anything?
> 
> This obviously was never compiled.  I'm stopping here in my review.
> 

Fell victim to trusting automatic git commit --fixup tools here. I'll 
send out v10 with proper bisectability.

