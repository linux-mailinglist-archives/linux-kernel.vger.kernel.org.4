Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 468726A1388
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 00:10:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbjBWXKd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 18:10:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbjBWXKa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 18:10:30 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5AAF16AF6;
        Thu, 23 Feb 2023 15:10:24 -0800 (PST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31NJExr7006742;
        Thu, 23 Feb 2023 23:10:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=e8d6JQRZYzHOjOhE6CwKkCmgKK3WQqyP3QWaM0JUdf8=;
 b=bJxa/WyKRUXmcBAkbzvKaNoZDEQYCk8fq76Xdyp382xIU+sGK/BmAUnttkHsAWKTmNS+
 xqmBDOpFQmVgUDEFOTRKaaCqiSQp2Kt+6rHbvciXROIqXHdiGfjJ89EJ3xe5E7Yw+kJ1
 l2iPI3SoQrjqYkVd37+xuYqM2BIzDNnuGpWBzM4ZW7zN1fOjctwDHLaFCI8CjTwz+sNO
 DnUryTYdADqtYyhKcoVruGx3TzRb9PlA8JRrMQgjC1eGEgn2gP0VnbxlO5C4tBzcR9p+
 n7rtkwfA8J+m40gO30fIrj2cdXyG31I/OMfImr66MCjzIQB3Zgo6gfrzBPrIDJI8oWuX OA== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nwy9gjw83-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Feb 2023 23:10:05 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31NNA5aK008482
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Feb 2023 23:10:05 GMT
Received: from [10.134.65.165] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 23 Feb
 2023 15:10:04 -0800
Message-ID: <0ba4a554-3a40-1a67-c666-77502f4e6ed6@quicinc.com>
Date:   Thu, 23 Feb 2023 15:10:04 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v10 09/26] gunyah: rsc_mgr: Add VM lifecycle RPC
Content-Language: en-US
To:     Alex Elder <alex.elder@linaro.org>, Alex Elder <elder@linaro.org>,
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
        Catalin Marinas <catalin.marinas@arm.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20230214211229.3239350-1-quic_eberman@quicinc.com>
 <20230214212343.3311875-1-quic_eberman@quicinc.com>
 <556ab51e-ddf8-b56b-1743-36f3b6d623d1@linaro.org>
From:   Elliot Berman <quic_eberman@quicinc.com>
In-Reply-To: <556ab51e-ddf8-b56b-1743-36f3b6d623d1@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: QIOMK4EJZNvm_zoXIL9SasRk7-_pJhmF
X-Proofpoint-ORIG-GUID: QIOMK4EJZNvm_zoXIL9SasRk7-_pJhmF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-23_13,2023-02-23_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=999
 spamscore=0 malwarescore=0 adultscore=0 impostorscore=0 mlxscore=0
 suspectscore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302230193
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/23/2023 1:36 PM, Alex Elder wrote:
> On 2/14/23 3:23 PM, Elliot Berman wrote:
>>
>> Add Gunyah Resource Manager RPC to launch an unauthenticated VM.
>>
>> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
>> ---
>>   drivers/virt/gunyah/Makefile      |   2 +-
>>   drivers/virt/gunyah/rsc_mgr.h     |  45 ++++++
>>   drivers/virt/gunyah/rsc_mgr_rpc.c | 226 ++++++++++++++++++++++++++++++
>>   include/linux/gunyah_rsc_mgr.h    |  73 ++++++++++
>>   4 files changed, 345 insertions(+), 1 deletion(-)
>>   create mode 100644 drivers/virt/gunyah/rsc_mgr_rpc.c
>>
>> diff --git a/drivers/virt/gunyah/Makefile b/drivers/virt/gunyah/Makefile
>> index cc864ff5abbb..de29769f2f3f 100644
>> --- a/drivers/virt/gunyah/Makefile
>> +++ b/drivers/virt/gunyah/Makefile
>> @@ -2,5 +2,5 @@
>>   obj-$(CONFIG_GUNYAH) += gunyah.o
>> -gunyah_rsc_mgr-y += rsc_mgr.o
>> +gunyah_rsc_mgr-y += rsc_mgr.o rsc_mgr_rpc.o
>>   obj-$(CONFIG_GUNYAH) += gunyah_rsc_mgr.o
>> diff --git a/drivers/virt/gunyah/rsc_mgr.h 
>> b/drivers/virt/gunyah/rsc_mgr.h
>> index d4e799a7526f..7406237bc66d 100644
>> --- a/drivers/virt/gunyah/rsc_mgr.h
>> +++ b/drivers/virt/gunyah/rsc_mgr.h
>> @@ -74,4 +74,49 @@ struct gh_rm;
>>   int gh_rm_call(struct gh_rm *rsc_mgr, u32 message_id, void 
>> *req_buff, size_t req_buff_size,
>>           void **resp_buf, size_t *resp_buff_size);
>> +/* Message IDs: VM Management */
>> +#define GH_RM_RPC_VM_ALLOC_VMID            0x56000001
>> +#define GH_RM_RPC_VM_DEALLOC_VMID        0x56000002
>> +#define GH_RM_RPC_VM_START            0x56000004
>> +#define GH_RM_RPC_VM_STOP            0x56000005
>> +#define GH_RM_RPC_VM_RESET            0x56000006
>> +#define GH_RM_RPC_VM_CONFIG_IMAGE        0x56000009
>> +#define GH_RM_RPC_VM_INIT            0x5600000B
>> +#define GH_RM_RPC_VM_GET_HYP_RESOURCES        0x56000020
>> +#define GH_RM_RPC_VM_GET_VMID            0x56000024
>> +
>> +struct gh_rm_vm_common_vmid_req {
>> +    __le16 vmid;
>> +    __le16 reserved0;
>> +} __packed;
>> +
>> +/* Call: VM_ALLOC */
>> +struct gh_rm_vm_alloc_vmid_resp {
>> +    __le16 vmid;
>> +    __le16 reserved0;
>> +} __packed;
>> +
>> +/* Call: VM_STOP */
>> +struct gh_rm_vm_stop_req {
>> +    __le16 vmid;
>> +#define GH_RM_VM_STOP_FLAG_FORCE_STOP    BIT(0)
>> +    u8 flags;
>> +    u8 reserved;
>> +#define GH_RM_VM_STOP_REASON_FORCE_STOP        3
> 
> I suggested this before and you honored it.  Now I'll suggest
> it again, and ask you to do it throughout the driver.
> 
> Please separate the definitions of constant values that
> certain fields can take on from the structure definition.
> I think doing it the way you have here makes it harder to
> understand the structure definition.
> 
> You could define an anonymous enumerated type to hold
> the values meant to be held by each field.
> 

Done.

>> +    __le32 stop_reason;
>> +} __packed;
>> +
>> +/* Call: VM_CONFIG_IMAGE */
>> +struct gh_rm_vm_config_image_req {
>> +    __le16 vmid;
>> +    __le16 auth_mech;
>> +    __le32 mem_handle;
>> +    __le64 image_offset;
>> +    __le64 image_size;
>> +    __le64 dtb_offset;
>> +    __le64 dtb_size;
>> +} __packed;
>> +
>> +/* Call: GET_HYP_RESOURCES */
>> +
>>   #endif
>> diff --git a/drivers/virt/gunyah/rsc_mgr_rpc.c 
>> b/drivers/virt/gunyah/rsc_mgr_rpc.c
>> new file mode 100644
>> index 000000000000..4515cdd80106
>> --- /dev/null
>> +++ b/drivers/virt/gunyah/rsc_mgr_rpc.c
>> @@ -0,0 +1,226 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All 
>> rights reserved.
>> + */
>> +
>> +#include <linux/gunyah_rsc_mgr.h>
>> +
>> +#include "rsc_mgr.h"
>> +
>> +/*
>> + * Several RM calls take only a VMID as a parameter and give only 
>> standard
>> + * response back. Deduplicate boilerplate code by using this common 
>> call.
>> + */
>> +static int gh_rm_common_vmid_call(struct gh_rm *rm, u32 message_id, 
>> u16 vmid)
>> +{
>> +    struct gh_rm_vm_common_vmid_req req_payload = {
>> +        .vmid = cpu_to_le16(vmid),
>> +    };
>> +    size_t resp_size;
>> +    void *resp;
>> +
>> +    return gh_rm_call(rm, message_id, &req_payload, 
>> sizeof(req_payload), &resp, &resp_size);
>> +}
>> +
>> +/**
>> + * gh_rm_alloc_vmid() - Allocate a new VM in Gunyah. Returns the VM 
>> identifier.
>> + * @rm: Handle to a Gunyah resource manager
>> + * @vmid: Use GH_VMID_INVAL or 0 to dynamically allocate a VM. A 
>> reserved VMID can
>> + *        be supplied to request allocation of a platform-defined VM.
> 
> Honestly, I'd rather just see 0 (and *not* GH_VMID_INVAL) be the
> special value to mean "dynamically allocate the VMID."  It seems
> 0 is a reserved VMID anyway, and GH_VMID_INVAL might as well be
> treated here as an invalid parameter.

Done.

> 
> Is there any definitition of which VMIDs are reserved?  Like,
> anything under 1024?

It's platform dependent. On Qualcomm platforms, VMIDs <= 63 
(QCOM_SCM_MAX_MANAGED_VMID) are reserved. Of those reserved VMIDs, 
Gunyah only allows us to allocate the "special VMs" (today: TUIVM, 
CPUSYSVM, OEMVM). Passing any value except 0, tuivm_vmid, cpusysvm_vmid, 
or oemvm_vmid returns an error.

On current non-Qualcomm platforms, there aren't any reserved VMIDs so 
passing anything but 0 returns an error.

Thanks,
Elliot

> 
> That's it on this patch for now.
> 
>                      -Alex
> 
>> + *
>> + * Returns - the allocated VMID or negative value on error
>> + */
>> +int gh_rm_alloc_vmid(struct gh_rm *rm, u16 vmid)
>> +{
>> +    struct gh_rm_vm_common_vmid_req req_payload = { 0 };
>> +    struct gh_rm_vm_alloc_vmid_resp *resp_payload;
>> +    size_t resp_size;
>> +    void *resp;
>> +    int ret;
> 
> . . .
> 
