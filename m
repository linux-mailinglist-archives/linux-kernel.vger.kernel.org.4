Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F3906D5321
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 23:10:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233574AbjDCVK0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 17:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjDCVKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 17:10:23 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 115E13A88;
        Mon,  3 Apr 2023 14:10:20 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3339l7lC010610;
        Mon, 3 Apr 2023 21:10:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=ehEyjXswBydN/s0s3YRYQqQXILWQyu/h5ZQHCJkbCDE=;
 b=Z38u89EF7tLlIuhCxmMnTxc2N1DeLkMYq3vCP7uh0MWZYfncea4TDFgo4wlJtPmp/t0G
 hD61kW7jZsZNPvCXt0zIojahqOxj3c574/plJvXRFt/pyUbbha31ItU+jTPkVxws7A5p
 U1cD9pB4SeqPbt/5u4nAxDLlN3lIDukt6BSuPFC39yajA/95kuSTJbda0dKvZl7nUwTQ
 ELUMTpuqPd77GbUyt79SWpsPbn/2pRkST5CtPuyQBO573jnpD5ei2/r5StdkLy+2qdK0
 JsygFGKldR0mRJwKVjjuYGEQiCHWkrdLzH5H67o/1+WXHsMFucSMKsjP/pVqqZcAnAwN zw== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pqtdn9vfm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 Apr 2023 21:10:03 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 333LA2bw009184
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 3 Apr 2023 21:10:02 GMT
Received: from [10.134.65.165] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Mon, 3 Apr 2023
 14:09:59 -0700
Message-ID: <cccf9b33-c798-4784-9927-08570ac91f52@quicinc.com>
Date:   Mon, 3 Apr 2023 14:09:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v11 09/26] gunyah: rsc_mgr: Add VM lifecycle RPC
Content-Language: en-US
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
 <20230304010632.2127470-10-quic_eberman@quicinc.com>
 <558f3d62-ac07-49e7-d496-d14c5a90d3ff@linaro.org>
From:   Elliot Berman <quic_eberman@quicinc.com>
In-Reply-To: <558f3d62-ac07-49e7-d496-d14c5a90d3ff@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: LDp2dO9NNDaEA06CbUHLoSvv__LuvdXp
X-Proofpoint-GUID: LDp2dO9NNDaEA06CbUHLoSvv__LuvdXp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-03_16,2023-04-03_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 mlxscore=0 mlxlogscore=999 lowpriorityscore=0 spamscore=0 malwarescore=0
 adultscore=0 bulkscore=0 phishscore=0 priorityscore=1501 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304030165
X-Spam-Status: No, score=-1.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/31/2023 7:25 AM, Alex Elder wrote:
> On 3/3/23 7:06 PM, Elliot Berman wrote:
>> Add Gunyah Resource Manager RPC to launch an unauthenticated VM.
>>
>> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
> 
> Several comments, no major issues here.    -Alex
> 
>> ---
>>   drivers/virt/gunyah/Makefile      |   2 +-
>>   drivers/virt/gunyah/rsc_mgr_rpc.c | 260 ++++++++++++++++++++++++++++++
>>   include/linux/gunyah_rsc_mgr.h    |  73 +++++++++
>>   3 files changed, 334 insertions(+), 1 deletion(-)
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
>> diff --git a/drivers/virt/gunyah/rsc_mgr_rpc.c 
>> b/drivers/virt/gunyah/rsc_mgr_rpc.c
>> new file mode 100644
>> index 000000000000..ffcb861a31b5
>> --- /dev/null
>> +++ b/drivers/virt/gunyah/rsc_mgr_rpc.c
>> @@ -0,0 +1,260 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All 
>> rights reserved.
>> + */
>> +
>> +#include <linux/gunyah_rsc_mgr.h>
>> +#include "rsc_mgr.h"
>> +
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
>> +    __le16 _padding;
>> +} __packed;
>> +
>> +/* Call: VM_ALLOC */
>> +struct gh_rm_vm_alloc_vmid_resp {
>> +    __le16 vmid;
>> +    __le16 _padding;
>> +} __packed;
>> +
>> +/* Call: VM_STOP */
>> +#define GH_RM_VM_STOP_FLAG_FORCE_STOP    BIT(0)
>> +
>> +#define GH_RM_VM_STOP_REASON_FORCE_STOP        3
>> +
>> +struct gh_rm_vm_stop_req {
>> +    __le16 vmid;
>> +    u8 flags;
>> +    u8 _padding;
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
>> +
>> +    return gh_rm_call(rm, message_id, &req_payload, 
>> sizeof(req_payload), NULL, NULL);
>> +}
>> +
>> +/**
>> + * gh_rm_alloc_vmid() - Allocate a new VM in Gunyah. Returns the VM 
>> identifier.
>> + * @rm: Handle to a Gunyah resource manager
>> + * @vmid: Use 0 to dynamically allocate a VM. A reserved VMID can be 
>> supplied
>> + *        to request allocation of a platform-defined VM.
>> + *
>> + * Returns - the allocated VMID or negative value on error
>> + */
>> +int gh_rm_alloc_vmid(struct gh_rm *rm, u16 vmid)
>> +{
>> +    struct gh_rm_vm_common_vmid_req req_payload = {
>> +        .vmid = vmid,
>> +    };
>> +    struct gh_rm_vm_alloc_vmid_resp *resp_payload;
>> +    size_t resp_size;
>> +    void *resp;
>> +    int ret;
>> +
>> +    ret = gh_rm_call(rm, GH_RM_RPC_VM_ALLOC_VMID, &req_payload, 
>> sizeof(req_payload), &resp,
>> +            &resp_size);
>> +    if (ret)
>> +        return ret;
>> +
>> +    if (!vmid) {
>> +        resp_payload = resp;
>> +        ret = le16_to_cpu(resp_payload->vmid);
>> +        kfree(resp);
>> +    }
>> +
>> +    return ret;
>> +}
>> +
>> +/**
>> + * gh_rm_dealloc_vmid() - Dispose the VMID
> 
> s/the/of a/
> 
>> + * @rm: Handle to a Gunyah resource manager
>> + * @vmid: VM identifier allocated with gh_rm_alloc_vmid
>> + */
>> +int gh_rm_dealloc_vmid(struct gh_rm *rm, u16 vmid)
>> +{
>> +    return gh_rm_common_vmid_call(rm, GH_RM_RPC_VM_DEALLOC_VMID, vmid);
>> +}
>> +
>> +/**
>> + * gh_rm_vm_reset() - Reset the VM's resources
>> + * @rm: Handle to a Gunyah resource manager
>> + * @vmid: VM identifier allocated with gh_rm_alloc_vmid
>> + *
>> + * While tearing down the VM, request RM to clean up all the VM 
>> resources
> 
> s/While/As part of/
> 
>> + * associated with the VM. Only after this, Linux can clean up all the
>> + * references it maintains to resources.
>> + */
>> +int gh_rm_vm_reset(struct gh_rm *rm, u16 vmid)
>> +{
>> +    return gh_rm_common_vmid_call(rm, GH_RM_RPC_VM_RESET, vmid);
>> +}
>> +
>> +/**
>> + * gh_rm_vm_start() - Move the VM into "ready to run" state
>> + * @rm: Handle to a Gunyah resource manager
>> + * @vmid: VM identifier allocated with gh_rm_alloc_vmid
>> + *
>> + * On VMs which use proxy scheduling, vcpu_run is needed to actually 
>> run the VM.
>> + * On VMs which use Gunyah's scheduling, the vCPUs start executing in 
>> accordance with Gunyah
>> + * scheduling policies.
>> + */
>> +int gh_rm_vm_start(struct gh_rm *rm, u16 vmid)
>> +{
>> +    return gh_rm_common_vmid_call(rm, GH_RM_RPC_VM_START, vmid);
>> +}
>> +
>> +/**
>> + * gh_rm_vm_stop() - Send a request to Resource Manager VM to 
>> forcibly stop a VM.
>> + * @rm: Handle to a Gunyah resource manager
>> + * @vmid: VM identifier allocated with gh_rm_alloc_vmid
>> + */
>> +int gh_rm_vm_stop(struct gh_rm *rm, u16 vmid)
>> +{
>> +    struct gh_rm_vm_stop_req req_payload = {
>> +        .vmid = cpu_to_le16(vmid),
>> +        .flags = GH_RM_VM_STOP_FLAG_FORCE_STOP,
>> +        .stop_reason = cpu_to_le32(GH_RM_VM_STOP_REASON_FORCE_STOP),
>> +    };
>> +
>> +    return gh_rm_call(rm, GH_RM_RPC_VM_STOP, &req_payload, 
>> sizeof(req_payload), NULL, NULL);
>> +}
>> +
>> +/**
>> + * gh_rm_vm_configure() - Prepare a VM to start and provide the common
>> + *              configuration needed by RM to configure a VM
>> + * @rm: Handle to a Gunyah resource manager
>> + * @vmid: VM identifier allocated with gh_rm_alloc_vmid
>> + * @auth_mechanism: Authentication mechanism used by resource manager 
>> to verify
>> + *                  the virtual machine
>> + * @mem_handle: Handle to a previously shared memparcel that contains 
>> all parts
>> + *              of the VM image subject to authentication.
>> + * @image_offset: Start address of VM image, relative to the start of 
>> memparcel
>> + * @image_size: Size of the VM image
>> + * @dtb_offset: Start address of the devicetree binary with VM 
>> configuration,
>> + *              relative to start of memparcel.
>> + * @dtb_size: Maximum size of devicetree binary. Resource manager 
>> applies
>> + *            an overlay to the DTB and dtb_size should include room for
>> + *            the overlay.
> 
> The above comment about including extra room doesn't sit well.
> How much extra room is required?  Is there any way you can
> provide an estimate?  Or better yet, is it possible to have
> gh_rm_call() somehow calculate that extra amount and add it on?
> 

The amount of extra room that's required is partially dependent on the 
number of Gunyah resources the VM creates. In practice, usually the 
memory map will carve out large amount of memory and DT is much smaller 
than that. Crosvm carves out 2MiB; Qualcomm devices (bootloader) usually 
carve out 2 MiB as well. When telling RM about the DT, you should tell 
RM about the whole 2MiB, not size of the actual devicetree blob.

I realize now this documentation is more UAPI facing than for internal 
kernel API. I'll move this documentation over there as well.

>> + */
>> +int gh_rm_vm_configure(struct gh_rm *rm, u16 vmid, enum 
>> gh_rm_vm_auth_mechanism auth_mechanism,
>> +        u32 mem_handle, u64 image_offset, u64 image_size, u64 
>> dtb_offset, u64 dtb_size)
> 
>  From what I can tell, the auth argument (and generally, ghvm->auth)
> is never used.  If that's the case, it might be nicer to explicitly
> not included it for now, and only add it when it's going to be used
> (and tested to work correctly).
> 
> I don't know if this is a reasonable strategy, but I'm always a
> little skeptical about unused code like this.
> 

I don't have any technical reasons to keep it and I could move the 
hard-coded auth type here. I thought it would best to keep the 
assumption in VM manager and not in the RPC.

>> +{
>> +    struct gh_rm_vm_config_image_req req_payload = {
>> +        .vmid = cpu_to_le16(vmid),
>> +        .auth_mech = cpu_to_le16(auth_mechanism),
>> +        .mem_handle = cpu_to_le32(mem_handle),
>> +        .image_offset = cpu_to_le64(image_offset),
>> +        .image_size = cpu_to_le64(image_size),
>> +        .dtb_offset = cpu_to_le64(dtb_offset),
>> +        .dtb_size = cpu_to_le64(dtb_size),
>> +    };
>> +
> 
> Are there any sanity checks that could be performed before we
> actually make the call to the resource manager?  Like, can
> you ensure the DTB offset and size are in range?
> 

The "VM Manager" will perform those checks, as does Resource Manager. At 
the RPC layer, we don't know the size of the memory parcel so we don't 
have a range to reference.

>> +    return gh_rm_call(rm, GH_RM_RPC_VM_CONFIG_IMAGE, &req_payload, 
>> sizeof(req_payload),
>> +              NULL, NULL);
>> +}
>> +
>> +/**
>> + * gh_rm_vm_init() - Move the VM to initialized state.
> 
> s/the/a/
> 
>> + * @rm: Handle to a Gunyah resource manager
>> + * @vmid: VM identifier
>> + *
>> + * RM will allocate needed resources for the VM.
>> + */
>> +int gh_rm_vm_init(struct gh_rm *rm, u16 vmid)
>> +{
>> +    return gh_rm_common_vmid_call(rm, GH_RM_RPC_VM_INIT, vmid);
>> +}
>> +
>> +/**
>> + * gh_rm_get_hyp_resources() - Retrieve hypervisor resources 
>> (capabilities) associated with a VM
>> + * @rm: Handle to a Gunyah resource manager
>> + * @vmid: VMID of the other VM to get the resources of
>> + * @resources: Set by gh_rm_get_hyp_resources and contains the 
>> returned hypervisor resources.
> 
> Caller must free the resources pointer returned if successful.
> (Please mention this.)
> 
>> + */
>> +int gh_rm_get_hyp_resources(struct gh_rm *rm, u16 vmid,
>> +                struct gh_rm_hyp_resources **resources)
>> +{
>> +    struct gh_rm_vm_common_vmid_req req_payload = {
>> +        .vmid = cpu_to_le16(vmid),
>> +    };
>> +    struct gh_rm_hyp_resources *resp;
>> +    size_t resp_size;
>> +    int ret;
>> +
>> +    ret = gh_rm_call(rm, GH_RM_RPC_VM_GET_HYP_RESOURCES,
>> +             &req_payload, sizeof(req_payload),
>> +             (void **)&resp, &resp_size);
>> +    if (ret)
>> +        return ret;
>> +
>> +    if (!resp_size)
>> +        return -EBADMSG;
>> +
>> +    if (resp_size < struct_size(resp, entries, 0) ||
>> +        resp_size != struct_size(resp, entries, 
>> le32_to_cpu(resp->n_entries))) {
>> +        kfree(resp);
>> +        return -EBADMSG;
>> +    }
>> +
>> +    *resources = resp;
>> +    return 0;
>> +}
>> +
>> +/**
>> + * gh_rm_get_vmid() - Retrieve VMID of this virtual machine
>> + * @rm: Handle to a Gunyah resource manager
>> + * @vmid: Filled with the VMID of this VM
>> + */
>> +int gh_rm_get_vmid(struct gh_rm *rm, u16 *vmid)
>> +{
>> +    static u16 cached_vmid = GH_VMID_INVAL;
>> +    size_t resp_size;
>> +    __le32 *resp;
>> +    int ret;
>> +
>> +    if (cached_vmid != GH_VMID_INVAL) {
>> +        *vmid = cached_vmid;
>> +        return 0;
>> +    }
>> +
>> +    ret = gh_rm_call(rm, GH_RM_RPC_VM_GET_VMID, NULL, 0, (void 
>> **)&resp, &resp_size);
>> +    if (ret)
>> +        return ret;
>> +
>> +    *vmid = cached_vmid = lower_16_bits(le32_to_cpu(*resp));
>> +    kfree(resp);
>> +
>> +    return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(gh_rm_get_vmid);
>> diff --git a/include/linux/gunyah_rsc_mgr.h 
>> b/include/linux/gunyah_rsc_mgr.h
>> index deca9b3da541..6a2f434e67f7 100644
>> --- a/include/linux/gunyah_rsc_mgr.h
>> +++ b/include/linux/gunyah_rsc_mgr.h
>> @@ -18,4 +18,77 @@ int gh_rm_notifier_unregister(struct gh_rm *rm, 
>> struct notifier_block *nb);
>>   struct device *gh_rm_get(struct gh_rm *rm);
>>   void gh_rm_put(struct gh_rm *rm);
>> +struct gh_rm_vm_exited_payload {
>> +    __le16 vmid;
>> +    __le16 exit_type;
>> +    __le32 exit_reason_size;
>> +    u8 exit_reason[];
>> +} __packed;
>> +
>> +#define GH_RM_NOTIFICATION_VM_EXITED         0x56100001
> 
> I think all these notification reasons should be defined in
> an enumerated type, to group them, and name the group.
> 

Gunyah doesn't enumerate these macros. Linux could create enum for these 
macros, but it's not refelected by the hypervisor. Keeping the fully 
expanded macro also makes it easier to match up in the Gunyah source code.

>> +
>> +enum gh_rm_vm_status {
>> +    GH_RM_VM_STATUS_NO_STATE    = 0,
>> +    GH_RM_VM_STATUS_INIT        = 1,
>> +    GH_RM_VM_STATUS_READY        = 2,
>> +    GH_RM_VM_STATUS_RUNNING        = 3,
>> +    GH_RM_VM_STATUS_PAUSED        = 4,
>> +    GH_RM_VM_STATUS_LOAD        = 5,
>> +    GH_RM_VM_STATUS_AUTH        = 6,
>> +    GH_RM_VM_STATUS_INIT_FAILED    = 8,
>> +    GH_RM_VM_STATUS_EXITED        = 9,
>> +    GH_RM_VM_STATUS_RESETTING    = 10,
>> +    GH_RM_VM_STATUS_RESET        = 11,
>> +};
>> +
>> +struct gh_rm_vm_status_payload {
>> +    __le16 vmid;
>> +    u16 reserved;
>> +    u8 vm_status;
>> +    u8 os_status;
>> +    __le16 app_status;
>> +} __packed;
>> +
>> +#define GH_RM_NOTIFICATION_VM_STATUS         0x56100008
>> +
>> +/* RPC Calls */
>> +int gh_rm_alloc_vmid(struct gh_rm *rm, u16 vmid);
>> +int gh_rm_dealloc_vmid(struct gh_rm *rm, u16 vmid);
>> +int gh_rm_vm_reset(struct gh_rm *rm, u16 vmid);
>> +int gh_rm_vm_start(struct gh_rm *rm, u16 vmid);
>> +int gh_rm_vm_stop(struct gh_rm *rm, u16 vmid);
>> +
>> +enum gh_rm_vm_auth_mechanism {
>> +    GH_RM_VM_AUTH_NONE        = 0,
>> +    GH_RM_VM_AUTH_QCOM_PIL_ELF    = 1,
>> +    GH_RM_VM_AUTH_QCOM_ANDROID_PVM    = 2,
>> +};
>> +
>> +int gh_rm_vm_configure(struct gh_rm *rm, u16 vmid, enum 
>> gh_rm_vm_auth_mechanism auth_mechanism,
>> +            u32 mem_handle, u64 image_offset, u64 image_size,
>> +            u64 dtb_offset, u64 dtb_size);
>> +int gh_rm_vm_init(struct gh_rm *rm, u16 vmid);
>> +
>> +struct gh_rm_hyp_resource {
>> +    u8 type;
> 
> Maybe add a comment on the above field, and others, such as:
> 
>      u8 type;    /* enum gh_resource_type */
> 
>> +    u8 reserved;
>> +    __le16 partner_vmid;
>> +    __le32 resource_handle;
>> +    __le32 resource_label;
>> +    __le64 cap_id;
>> +    __le32 virq_handle;
>> +    __le32 virq;
>> +    __le64 base;
>> +    __le64 size;
>> +} __packed;
>> +
>> +struct gh_rm_hyp_resources {
>> +    __le32 n_entries;
>> +    struct gh_rm_hyp_resource entries[];
>> +} __packed;
>> +
>> +int gh_rm_get_hyp_resources(struct gh_rm *rm, u16 vmid,
>> +                struct gh_rm_hyp_resources **resources);
>> +int gh_rm_get_vmid(struct gh_rm *rm, u16 *vmid);
>> +
>>   #endif
> 
