Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1086A6E55CF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 02:26:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbjDRA01 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 20:26:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjDRA0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 20:26:23 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9364B2D48;
        Mon, 17 Apr 2023 17:26:21 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33HNkIVT022287;
        Tue, 18 Apr 2023 00:26:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=AJqlNH9AsjGuxks27wWDGzNAPxxsF2qLR48Xhj8sNBo=;
 b=IEkLL96MoCo3r9oNY1GtfKprCONFgOGHpyf/mwfdklEVk/Z5DPEEDDuaGrJevVQkALz0
 y7ayqKGLXcGcndvgri5NLVK4GDLDv8+dnW1j1WP7CEi4B+0MTFFv8bBYzUj2akOTSPXB
 4hNQo5V32zZnV4ITViTlYI3jESFJSFQ6EG4KlVgaR5stQwDrpULngVHEN/4It2J8iIZR
 Z01CP6MEBwh18Scs3idnUEPM+VpznCdhPyIOgsHMM3kvTycXsIX09NEkVTBoJqZR4VxR
 Wsrdv32dke6kW1ARdIwxCuyeOBRvchgbDE9IQXHbGBnaQzfmHEcJqBfCn7pFXBgdBGR9 qA== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pymp4d1cg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Apr 2023 00:25:59 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33I0Pw9Y011638
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Apr 2023 00:25:58 GMT
Received: from [10.134.65.165] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Mon, 17 Apr
 2023 17:25:57 -0700
Message-ID: <de523682-a8b3-5434-bc1f-a06645f10183@quicinc.com>
Date:   Mon, 17 Apr 2023 17:25:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v11 18/26] virt: gunyah: Translate gh_rm_hyp_resource into
 gunyah_resource
Content-Language: en-US
To:     Alex Elder <elder@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
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
        Andy Gross <agross@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20230304010632.2127470-1-quic_eberman@quicinc.com>
 <20230304010632.2127470-19-quic_eberman@quicinc.com>
 <f2994324-cf04-c695-bbbe-df4cf2faa0c1@linaro.org>
From:   Elliot Berman <quic_eberman@quicinc.com>
In-Reply-To: <f2994324-cf04-c695-bbbe-df4cf2faa0c1@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 23VbPKPAL09lWfI3EaF0tJ3aKur-_4gk
X-Proofpoint-ORIG-GUID: 23VbPKPAL09lWfI3EaF0tJ3aKur-_4gk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-17_14,2023-04-17_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 impostorscore=0 spamscore=0 mlxlogscore=999 lowpriorityscore=0
 phishscore=0 priorityscore=1501 bulkscore=0 adultscore=0 suspectscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304180001
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/31/2023 7:26 AM, Alex Elder wrote:
> On 3/3/23 7:06 PM, Elliot Berman wrote:
>> When booting a Gunyah virtual machine, the host VM may gain capabilities
>> to interact with resources for the guest virtual machine. Examples of
>> such resources are vCPUs or message queues. To use those resources, we
>> need to translate the RM response into a gunyah_resource structure which
>> are useful to Linux drivers. Presently, Linux drivers need only to know
>> the type of resource, the capability ID, and an interrupt.
>>
>> On ARM64 systems, the interrupt reported by Gunyah is the GIC interrupt
>> ID number and always a SPI.
>>
>> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
> 
> Several comments here, nothing major.    -Alex
> 
>> ---
>>   arch/arm64/include/asm/gunyah.h |  23 +++++
>>   drivers/virt/gunyah/rsc_mgr.c   | 163 +++++++++++++++++++++++++++++++-
>>   include/linux/gunyah.h          |   4 +
>>   include/linux/gunyah_rsc_mgr.h  |   3 +
>>   4 files changed, 192 insertions(+), 1 deletion(-)
>>   create mode 100644 arch/arm64/include/asm/gunyah.h
>>
>> diff --git a/arch/arm64/include/asm/gunyah.h 
>> b/arch/arm64/include/asm/gunyah.h
>> new file mode 100644
>> index 000000000000..64cfb964efee
>> --- /dev/null
>> +++ b/arch/arm64/include/asm/gunyah.h
>> @@ -0,0 +1,23 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +/*
>> + * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights 
>> reserved.
>> + */
>> +#ifndef __ASM_GUNYAH_H_
>> +#define __ASM_GUNYAH_H_
> 
> Maybe just one _ at the beginning and none at the end?
> Follow the same convention across all your header files.
> (Maybe you're looking at other files in the same directory
> as this one, but that's not consistent.)
> 
>> +
>> +#include <linux/irq.h>
>> +#include <dt-bindings/interrupt-controller/arm-gic.h>
>> +
>> +static inline int arch_gh_fill_irq_fwspec_params(u32 virq, struct 
>> irq_fwspec *fwspec)
>> +{
>> +    if (virq < 32 || virq > 1019)
>> +        return -EINVAL;
> 
> What is special about VIRQs greater than 1019 (minus 32)?
> 
> It's probably documented somewhere but it's worth adding a
> comment here to explain the check.
> 
> You would know better than I, but could/should the caller
> be responsible for this check?  (Not a big deal.)
> 

I think definitely not the caller should be responsible for this check.

On arm systems, the IRQ # that is returned is the hwirq # for the GIC.

Presently, Gunyah only gives us SPI interrupts [32,1019] so I've written 
a translation to a SPI fwspec.

>> +
>> +    fwspec->param_count = 3;
>> +    fwspec->param[0] = GIC_SPI;
>> +    fwspec->param[1] = virq - 32;
> 
> And why is 32 subtracted?
> 

GIC driver expects the SPI #, not the hwirq #.

>> +    fwspec->param[2] = IRQ_TYPE_EDGE_RISING;
>> +    return 0;
>> +}
>> +
>> +#endif
>> diff --git a/drivers/virt/gunyah/rsc_mgr.c 
>> b/drivers/virt/gunyah/rsc_mgr.c
>> index d7ce692d0067..383be5ac0f44 100644
>> --- a/drivers/virt/gunyah/rsc_mgr.c
>> +++ b/drivers/virt/gunyah/rsc_mgr.c
>> @@ -17,6 +17,8 @@
>>   #include <linux/platform_device.h>
>>   #include <linux/miscdevice.h>
>> +#include <asm/gunyah.h>
>> +
>>   #include "rsc_mgr.h"
>>   #include "vm_mgr.h"
>> @@ -132,6 +134,7 @@ struct gh_rm_connection {
>>    * @send_lock: synchronization to allow only one request to be sent 
>> at a time
>>    * @nh: notifier chain for clients interested in RM notification 
>> messages
>>    * @miscdev: /dev/gunyah
>> + * @irq_domain: Domain to translate Gunyah hwirqs to Linux irqs
>>    */
>>   struct gh_rm {
>>       struct device *dev;
>> @@ -150,6 +153,7 @@ struct gh_rm {
>>       struct blocking_notifier_head nh;
>>       struct miscdevice miscdev;
>> +    struct irq_domain *irq_domain;
>>   };
>>   /**
>> @@ -190,6 +194,134 @@ static inline int gh_rm_remap_error(enum 
>> gh_rm_error rm_error)
>>       }
>>   }
>> +struct gh_irq_chip_data {
>> +    u32 gh_virq;
>> +};
>> +
>> +static struct irq_chip gh_rm_irq_chip = {
>> +    .name            = "Gunyah",
>> +    .irq_enable        = irq_chip_enable_parent,
>> +    .irq_disable        = irq_chip_disable_parent,
>> +    .irq_ack        = irq_chip_ack_parent,
>> +    .irq_mask        = irq_chip_mask_parent,
>> +    .irq_mask_ack        = irq_chip_mask_ack_parent,
>> +    .irq_unmask        = irq_chip_unmask_parent,
>> +    .irq_eoi        = irq_chip_eoi_parent,
>> +    .irq_set_affinity    = irq_chip_set_affinity_parent,
>> +    .irq_set_type        = irq_chip_set_type_parent,
>> +    .irq_set_wake        = irq_chip_set_wake_parent,
>> +    .irq_set_vcpu_affinity    = irq_chip_set_vcpu_affinity_parent,
>> +    .irq_retrigger        = irq_chip_retrigger_hierarchy,
>> +    .irq_get_irqchip_state    = irq_chip_get_parent_state,
>> +    .irq_set_irqchip_state    = irq_chip_set_parent_state,
>> +    .flags            = IRQCHIP_SET_TYPE_MASKED |
>> +                  IRQCHIP_SKIP_SET_WAKE |
>> +                  IRQCHIP_MASK_ON_SUSPEND,
>> +};
>> +
>> +static int gh_rm_irq_domain_alloc(struct irq_domain *d, unsigned int 
>> virq, unsigned int nr_irqs,
>> +                 void *arg)
>> +{
>> +    struct gh_irq_chip_data *chip_data, *spec = arg;
>> +    struct irq_fwspec parent_fwspec;
>> +    struct gh_rm *rm = d->host_data;
>> +    u32 gh_virq = spec->gh_virq;
>> +    int ret;
>> +
>> +    if (nr_irqs != 1 || gh_virq == U32_MAX)
> 
> Does U32_MAX have special meaning?  Why are you checking for it?
> Whatever it is, you should explain why this is invalid here.
> 

This was holdover from deprecated Gunyah code. Since there are new 
features/version checks it's not possible for Linux to encounter these 
values. I've dropped it in v12.


Thanks,
Elliot
