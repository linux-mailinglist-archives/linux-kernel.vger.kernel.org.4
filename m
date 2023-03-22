Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B57E6C54C0
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 20:17:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230477AbjCVTRw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 15:17:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjCVTRu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 15:17:50 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68F835DEF2;
        Wed, 22 Mar 2023 12:17:47 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32M6fKef018927;
        Wed, 22 Mar 2023 19:17:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=AiP4BOjuLoB/Kjrial9eWIMycztKER8b+U2Ec2SDup8=;
 b=pXHjKfb/yPw9pza9NwbsQH6gTPkbeXVZJSmynf9+XtDqddfqRnzMmg0Bb+A8aYzP+0Di
 R47OL+GLGHqC2PKJT3e2v5oXsmGPwsxXxh63Gwhr7toYP2B1BJzUgkA6GKnqcYjVZWCP
 c73QYWQTaFX+X7Fsh5wAx/2rSlazDwv+NyzDMwGA2QMsXtYZPATUACD+WYOC6FnoK/xR
 0fwCLeF01jW4duXpZgAxg5TQZze2IY9pblyc8+7b6TmryiQCdyFhngXag5LAlrCQrA4n
 sIZHiGroJ1uTBJMcME1ACUsofQonAmNfoWyuevn0wDm8SJRzUzAerAVo6YU9Ed+Nrgnm CA== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pfhntk6vx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Mar 2023 19:17:29 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32MJHSO1011735
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Mar 2023 19:17:28 GMT
Received: from [10.134.65.165] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 22 Mar
 2023 12:17:27 -0700
Message-ID: <1b893760-0be7-e9f5-24c8-3e6dcbe8e237@quicinc.com>
Date:   Wed, 22 Mar 2023 12:17:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v11 15/26] gunyah: rsc_mgr: Add platform ops on
 mem_lend/mem_reclaim
Content-Language: en-US
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Alex Elder <elder@linaro.org>,
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
 <20230304010632.2127470-16-quic_eberman@quicinc.com>
 <5e9b3ec6-5d47-cd73-c7c0-0aa891bdfc23@linaro.org>
From:   Elliot Berman <quic_eberman@quicinc.com>
In-Reply-To: <5e9b3ec6-5d47-cd73-c7c0-0aa891bdfc23@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: jRODWjIfHdBvayWmVaMKT0Cxnkn8s7Al
X-Proofpoint-ORIG-GUID: jRODWjIfHdBvayWmVaMKT0Cxnkn8s7Al
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-22_15,2023-03-22_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 suspectscore=0 phishscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 lowpriorityscore=0 spamscore=0 adultscore=0 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303220134
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/21/2023 7:23 AM, Srinivas Kandagatla wrote:
> 
> 
> On 04/03/2023 01:06, Elliot Berman wrote:
>> On Qualcomm platforms, there is a firmware entity which controls access
>> to physical pages. In order to share memory with another VM, this entity
>> needs to be informed that the guest VM should have access to the memory.
>>
>> Co-developed-by: Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>
>> Signed-off-by: Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>
>> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
>> ---
>>   drivers/virt/gunyah/Kconfig                 |  4 ++
>>   drivers/virt/gunyah/Makefile                |  1 +
>>   drivers/virt/gunyah/gunyah_platform_hooks.c | 80 +++++++++++++++++++++
>>   drivers/virt/gunyah/rsc_mgr.h               |  3 +
>>   drivers/virt/gunyah/rsc_mgr_rpc.c           | 18 ++++-
>>   include/linux/gunyah_rsc_mgr.h              | 17 +++++
>>   6 files changed, 121 insertions(+), 2 deletions(-)
>>   create mode 100644 drivers/virt/gunyah/gunyah_platform_hooks.c
>>
>> diff --git a/drivers/virt/gunyah/Kconfig b/drivers/virt/gunyah/Kconfig
>> index 1a737694c333..de815189dab6 100644
>> --- a/drivers/virt/gunyah/Kconfig
>> +++ b/drivers/virt/gunyah/Kconfig
>> @@ -4,6 +4,7 @@ config GUNYAH
>>       tristate "Gunyah Virtualization drivers"
>>       depends on ARM64
>>       depends on MAILBOX
>> +    select GUNYAH_PLATFORM_HOOKS
>>       help
>>         The Gunyah drivers are the helper interfaces that run in a 
>> guest VM
>>         such as basic inter-VM IPC and signaling mechanisms, and 
>> higher level
>> @@ -11,3 +12,6 @@ config GUNYAH
>>         Say Y/M here to enable the drivers needed to interact in a Gunyah
>>         virtual environment.
>> +
>> +config GUNYAH_PLATFORM_HOOKS
>> +    tristate
>> diff --git a/drivers/virt/gunyah/Makefile b/drivers/virt/gunyah/Makefile
>> index ff8bc4925392..6b8f84dbfe0d 100644
>> --- a/drivers/virt/gunyah/Makefile
>> +++ b/drivers/virt/gunyah/Makefile
>> @@ -1,6 +1,7 @@
>>   # SPDX-License-Identifier: GPL-2.0
>>   obj-$(CONFIG_GUNYAH) += gunyah.o
>> +obj-$(CONFIG_GUNYAH_PLATFORM_HOOKS) += gunyah_platform_hooks.o
>>   gunyah_rsc_mgr-y += rsc_mgr.o rsc_mgr_rpc.o vm_mgr.o vm_mgr_mm.o
>>   obj-$(CONFIG_GUNYAH) += gunyah_rsc_mgr.o
>> diff --git a/drivers/virt/gunyah/gunyah_platform_hooks.c 
>> b/drivers/virt/gunyah/gunyah_platform_hooks.c
>> new file mode 100644
>> index 000000000000..60da0e154e98
>> --- /dev/null
>> +++ b/drivers/virt/gunyah/gunyah_platform_hooks.c
>> @@ -0,0 +1,80 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All 
>> rights reserved.
>> + */
>> +
>> +#include <linux/module.h>
>> +#include <linux/rwsem.h>
>> +#include <linux/gunyah_rsc_mgr.h>
>> +
>> +#include "rsc_mgr.h"
>> +
>> +static struct gh_rm_platform_ops *rm_platform_ops;
>> +static DECLARE_RWSEM(rm_platform_ops_lock);
>> +
>> +int gh_rm_platform_pre_mem_share(struct gh_rm *rm, struct 
>> gh_rm_mem_parcel *mem_parcel)
> 
> I think I have asked this question but I can not find the answer to this 
> from old replies.
> Why is this platform hooks not part of core gunyah? Do we need a 
> dedicated module for this.
> By the looks of APIs I see this is very much close to rm and i think 
> this functionality should live with rm.
> 

If the platform hooks were part of core gunyah, then core gunyah could 
only be enabled as =y in the default defconfig because QCOM_SCM would 
rely on the platform hooks (core gunyah).

With the suggestion to move the SCM platform hooks into separate module, 
I can/will bring the platform hooks back into core gunyah module.

- Elliot

> --srini
> +{
>> +    int ret = 0;
>> +
>> +    down_read(&rm_platform_ops_lock);
>> +    if (rm_platform_ops && rm_platform_ops->pre_mem_share)
>> +        ret = rm_platform_ops->pre_mem_share(rm, mem_parcel);
>> +    up_read(&rm_platform_ops_lock);
>> +    return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(gh_rm_platform_pre_mem_share);
>> +
>> +int gh_rm_platform_post_mem_reclaim(struct gh_rm *rm, struct 
>> gh_rm_mem_parcel *mem_parcel)
>> +{
>> +    int ret = 0;
>> +
>> +    down_read(&rm_platform_ops_lock);
>> +    if (rm_platform_ops && rm_platform_ops->post_mem_reclaim)
>> +        ret = rm_platform_ops->post_mem_reclaim(rm, mem_parcel);
>> +    up_read(&rm_platform_ops_lock);
>> +    return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(gh_rm_platform_post_mem_reclaim);
>> +
>> +int gh_rm_register_platform_ops(struct gh_rm_platform_ops *platform_ops)
>> +{
>> +    int ret = 0;
>> +
>> +    down_write(&rm_platform_ops_lock);
>> +    if (!rm_platform_ops)
>> +        rm_platform_ops = platform_ops;
>> +    else
>> +        ret = -EEXIST;
>> +    up_write(&rm_platform_ops_lock);
>> +    return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(gh_rm_register_platform_ops);
>> +
>> +void gh_rm_unregister_platform_ops(struct gh_rm_platform_ops 
>> *platform_ops)
>> +{
>> +    down_write(&rm_platform_ops_lock);
>> +    if (rm_platform_ops == platform_ops)
>> +        rm_platform_ops = NULL;
>> +    up_write(&rm_platform_ops_lock);
>> +}
>> +EXPORT_SYMBOL_GPL(gh_rm_unregister_platform_ops);
>> +
>> +static void _devm_gh_rm_unregister_platform_ops(void *data)
>> +{
>> +    gh_rm_unregister_platform_ops(data);
>> +}
>> +
>> +int devm_gh_rm_register_platform_ops(struct device *dev, struct 
>> gh_rm_platform_ops *ops)
>> +{
>> +    int ret;
>> +
>> +    ret = gh_rm_register_platform_ops(ops);
>> +    if (ret)
>> +        return ret;
>> +
>> +    return devm_add_action(dev, _devm_gh_rm_unregister_platform_ops, 
>> ops);
>> +}
>> +EXPORT_SYMBOL_GPL(devm_gh_rm_register_platform_ops);
>> +
>> +MODULE_LICENSE("GPL");
>> +MODULE_DESCRIPTION("Gunyah Platform Hooks");
>> diff --git a/drivers/virt/gunyah/rsc_mgr.h 
>> b/drivers/virt/gunyah/rsc_mgr.h
>> index 3665ebc7b020..6838e736f361 100644
>> --- a/drivers/virt/gunyah/rsc_mgr.h
>> +++ b/drivers/virt/gunyah/rsc_mgr.h
>> @@ -13,4 +13,7 @@ struct gh_rm;
>>   int gh_rm_call(struct gh_rm *rsc_mgr, u32 message_id, void 
>> *req_buff, size_t req_buf_size,
>>           void **resp_buf, size_t *resp_buf_size);
>> +int gh_rm_platform_pre_mem_share(struct gh_rm *rm, struct 
>> gh_rm_mem_parcel *mem_parcel);
>> +int gh_rm_platform_post_mem_reclaim(struct gh_rm *rm, struct 
>> gh_rm_mem_parcel *mem_parcel);
>> +
>>   #endif
>> diff --git a/drivers/virt/gunyah/rsc_mgr_rpc.c 
>> b/drivers/virt/gunyah/rsc_mgr_rpc.c
>> index 3df15ad5b97d..733be4dc8dd2 100644
>> --- a/drivers/virt/gunyah/rsc_mgr_rpc.c
>> +++ b/drivers/virt/gunyah/rsc_mgr_rpc.c
>> @@ -204,6 +204,12 @@ static int gh_rm_mem_lend_common(struct gh_rm 
>> *rm, u32 message_id, struct gh_rm_
>>       if (!msg)
>>           return -ENOMEM;
>> +    ret = gh_rm_platform_pre_mem_share(rm, p);
>> +    if (ret) {
>> +        kfree(msg);
>> +        return ret;
>> +    }
>> +
>>       req_header = msg;
>>       acl_section = (void *)req_header + sizeof(*req_header);
>>       mem_section = (void *)acl_section + struct_size(acl_section, 
>> entries, p->n_acl_entries);
>> @@ -227,8 +233,10 @@ static int gh_rm_mem_lend_common(struct gh_rm 
>> *rm, u32 message_id, struct gh_rm_
>>       ret = gh_rm_call(rm, message_id, msg, msg_size, (void **)&resp, 
>> &resp_size);
>>       kfree(msg);
>> -    if (ret)
>> +    if (ret) {
>> +        gh_rm_platform_post_mem_reclaim(rm, p);
>>           return ret;
>> +    }
>>       p->mem_handle = le32_to_cpu(*resp);
>> @@ -283,8 +291,14 @@ int gh_rm_mem_reclaim(struct gh_rm *rm, struct 
>> gh_rm_mem_parcel *parcel)
>>       struct gh_rm_mem_release_req req = {
>>           .mem_handle = cpu_to_le32(parcel->mem_handle),
>>       };
>> +    int ret;
>> +
>> +    ret = gh_rm_call(rm, GH_RM_RPC_MEM_RECLAIM, &req, sizeof(req), 
>> NULL, NULL);
>> +    /* Do not call platform mem reclaim hooks: the reclaim didn't 
>> happen*/
>> +    if (ret)
>> +        return ret;
>> -    return gh_rm_call(rm, GH_RM_RPC_MEM_RECLAIM, &req, sizeof(req), 
>> NULL, NULL);
>> +    return gh_rm_platform_post_mem_reclaim(rm, parcel);
>>   }
>>   /**
>> diff --git a/include/linux/gunyah_rsc_mgr.h 
>> b/include/linux/gunyah_rsc_mgr.h
>> index 8b0b46f28e39..515087931a2b 100644
>> --- a/include/linux/gunyah_rsc_mgr.h
>> +++ b/include/linux/gunyah_rsc_mgr.h
>> @@ -145,4 +145,21 @@ int gh_rm_get_hyp_resources(struct gh_rm *rm, u16 
>> vmid,
>>                   struct gh_rm_hyp_resources **resources);
>>   int gh_rm_get_vmid(struct gh_rm *rm, u16 *vmid);
>> +struct gunyah_rm_platform_ops {
>> +    int (*pre_mem_share)(struct gh_rm *rm, struct gh_rm_mem_parcel 
>> *mem_parcel);
>> +    int (*post_mem_reclaim)(struct gh_rm *rm, struct gh_rm_mem_parcel 
>> *mem_parcel);
>> +};
>> +
>> +#if IS_ENABLED(CONFIG_GUNYAH_PLATFORM_HOOKS)
>> +int gh_rm_register_platform_ops(struct gh_rm_platform_ops 
>> *platform_ops);
>> +void gh_rm_unregister_platform_ops(struct gh_rm_platform_ops 
>> *platform_ops);
>> +int devm_gh_rm_register_platform_ops(struct device *dev, struct 
>> gh_rm_platform_ops *ops);
>> +#else
>> +static inline int gh_rm_register_platform_ops(struct 
>> gh_rm_platform_ops *platform_ops)
>> +    { return 0; }
>> +static inline void gh_rm_unregister_platform_ops(struct 
>> gh_rm_platform_ops *platform_ops) { }
>> +static inline int devm_gh_rm_register_platform_ops(struct device *dev,
>> +    struct gh_rm_platform_ops *ops) { return 0; }
>> +#endif
>> +
>>   #endif
