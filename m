Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5358C68F974
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 22:05:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231949AbjBHVFe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 16:05:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232437AbjBHVEz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 16:04:55 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC12A3EFF7;
        Wed,  8 Feb 2023 13:04:32 -0800 (PST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 318KqmFc015146;
        Wed, 8 Feb 2023 21:04:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=k/v7mdhNryfqOSlWbSwdWTE1Ww7OClm6nR+hdGhYcsA=;
 b=ltW2AiLFrFxcCn1OyGR4b4mUOpcmmsnwTb77idm3/tLYS3/ps1lFa/LyENrGV+6Sc2X1
 +a4EYhXH/c+4WeuMURscUJVqI06zfuQ64yEeXZKyd8VIMGRGh2R4VkEG3/S3vmdeCe2D
 gFpuWznn6MX7tx1VTaUNXGQj3Q/+8lU0quS7c6z9whUpJiOleveGA37dzSw3MvWRGWcg
 kV7qD5/FKzeg2Lc3OZHYvjkid9RJlP8MQvL3DtYse+UwJbuFuZn55VjJxjRD/DRCXG1V
 0C8mXTEcQXb3XbuFUHcAkFbGuR4JtRlw99zLCs4uKyA3uiz/quxLG714hfgz4wPhFUIs 4Q== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nmg9eger8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Feb 2023 21:04:18 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 318L4HEv014338
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 8 Feb 2023 21:04:17 GMT
Received: from [10.134.67.48] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 8 Feb 2023
 13:04:17 -0800
Message-ID: <6f214b5a-80da-23c5-6b46-6f75a173a004@quicinc.com>
Date:   Wed, 8 Feb 2023 13:04:16 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v9 14/27] gunyah: vm_mgr: Add ioctls to support basic
 non-proxy VM boot
Content-Language: en-US
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Alex Elder <elder@linaro.org>,
        Murali Nalajala <quic_mnalajal@quicinc.com>
CC:     Trilok Soni <quic_tsoni@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20230120224627.4053418-1-quic_eberman@quicinc.com>
 <20230120224627.4053418-15-quic_eberman@quicinc.com>
 <14d57333-02bc-6294-ed20-4c882dcd0dae@linaro.org>
From:   Elliot Berman <quic_eberman@quicinc.com>
In-Reply-To: <14d57333-02bc-6294-ed20-4c882dcd0dae@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: rEONG9HT338ZzKG4ZVM-Lz0AkwSKmOyL
X-Proofpoint-ORIG-GUID: rEONG9HT338ZzKG4ZVM-Lz0AkwSKmOyL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-08_09,2023-02-08_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 malwarescore=0 impostorscore=0 bulkscore=0 phishscore=0 mlxlogscore=999
 priorityscore=1501 clxscore=1015 lowpriorityscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302080178
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/7/2023 3:36 AM, Srinivas Kandagatla wrote:
> 
> 
> On 20/01/2023 22:46, Elliot Berman wrote:
>> Add remaining ioctls to support non-proxy VM boot:
>>
>>   - Gunyah Resource Manager uses the VM's devicetree to configure the
>>     virtual machine. The location of the devicetree in the guest's
>>     virtual memory can be declared via the SET_DTB_CONFIG ioctl.
>>   - Trigger start of the virtual machine with VM_START ioctl.
>>
>> Co-developed-by: Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>
>> Signed-off-by: Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>
>> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
>> ---
>>   drivers/virt/gunyah/vm_mgr.c    | 110 ++++++++++++++++++++++++++++++++
>>   drivers/virt/gunyah/vm_mgr.h    |   9 +++
>>   drivers/virt/gunyah/vm_mgr_mm.c |  24 +++++++
>>   include/uapi/linux/gunyah.h     |   8 +++
>>   4 files changed, 151 insertions(+)
>>
>> diff --git a/drivers/virt/gunyah/vm_mgr.c b/drivers/virt/gunyah/vm_mgr.c
>> index b847fde63333..48bd3f06fb6c 100644
>> --- a/drivers/virt/gunyah/vm_mgr.c
>> +++ b/drivers/virt/gunyah/vm_mgr.c
>> @@ -9,6 +9,7 @@
>>   #include <linux/file.h>
>>   #include <linux/gunyah_rsc_mgr.h>
>>   #include <linux/miscdevice.h>
>> +#include <linux/mm.h>
>>   #include <linux/module.h>
>>   #include <uapi/linux/gunyah.h>
>> @@ -37,10 +38,98 @@ static __must_check struct gunyah_vm 
>> *gunyah_vm_alloc(struct gh_rm_rpc *rm)
>>       mutex_init(&ghvm->mm_lock);
>>       INIT_LIST_HEAD(&ghvm->memory_mappings);
>> +    init_rwsem(&ghvm->status_lock);
> 
> using read write semaphore is really not going to make any difference in 
> this particular case.
> we have just one reader (gh_vm_ensure_started) and it mostly makes 
> synchronous call to writer (vm_start).
> 

When launching multiple vCPUs, the threads might be racing to ensure the 
VM is started. The typical case is that VM is running and we would have 
bad performance if all the vCPUs needed to sequentially check that the 
VM is indeed running before they're scheduled. rwsem can allow all the 
threads to check if VM is running simultaneously and only one thread to 
start the VM if it wasn't running.

>>       return ghvm;
>>   }
>> +static int gh_vm_start(struct gunyah_vm *ghvm)
>> +{
>> +    struct gunyah_vm_memory_mapping *mapping;
>> +    u64 dtb_offset;
>> +    u32 mem_handle;
>> +    int ret;
>> +
>> +    down_write(&ghvm->status_lock);
>> +    if (ghvm->vm_status != GH_RM_VM_STATUS_NO_STATE) {
>> +        up_write(&ghvm->status_lock);
>> +        return 0;
>> +    }
>> +
>> +    list_for_each_entry(mapping, &ghvm->memory_mappings, list) {
>> +        switch (mapping->share_type) {
>> +        case VM_MEM_LEND:
>> +            ret = gh_rm_mem_lend(ghvm->rm, &mapping->parcel);
>> +            break;
>> +        case VM_MEM_SHARE:
>> +            ret = gh_rm_mem_share(ghvm->rm, &mapping->parcel);
>> +            break;
>> +        }
> 
>> +        if (ret > 0)
>> +            ret = -EINVAL;
> 
> why are we converting the error messages, afaiu both gh_rm_mem_lend and 
> gh_rm_mem_share return a valid error codes.
> 

Removed.

>> +        if (ret) {
>> +            pr_warn("Failed to %s parcel %d: %d\n",
>> +                mapping->share_type == VM_MEM_LEND ? "lend" : "share",
>> +                mapping->parcel.label,
>> +                ret);
>> +            goto err;
>> +        }
>> +    }
>> +
>> +    mapping = gh_vm_mem_mapping_find_mapping(ghvm, 
>> ghvm->dtb_config.gpa, ghvm->dtb_config.size);
>> +    if (!mapping) {
>> +        pr_warn("Failed to find the memory_handle for DTB\n");
>> +        ret = -EINVAL;
>> +        goto err;
>> +    }
>> +
>> +    mem_handle = mapping->parcel.mem_handle;
>> +    dtb_offset = ghvm->dtb_config.gpa - mapping->guest_phys_addr;
>> +
>> +    ret = gh_rm_vm_configure(ghvm->rm, ghvm->vmid, ghvm->auth, 
>> mem_handle,
>> +                0, 0, dtb_offset, ghvm->dtb_config.size);
>> +    if (ret) {
>> +        pr_warn("Failed to configure VM: %d\n", ret);
>> +        goto err;
>> +    }
>> +
>> +    ret = gh_rm_vm_init(ghvm->rm, ghvm->vmid);
>> +    if (ret) {
>> +        pr_warn("Failed to initialize VM: %d\n", ret);
>> +        goto err;
>> +    }
>> +
>> +    ret = gh_rm_vm_start(ghvm->rm, ghvm->vmid);
>> +    if (ret) {
>> +        pr_warn("Failed to start VM: %d\n", ret);
>> +        goto err;
>> +    }
>> +
>> +    ghvm->vm_status = GH_RM_VM_STATUS_READY;
>> +
>> +    up_write(&ghvm->stvm_status = atus_lock);
>> +    return ret;
>> +err:
>> +    ghvm->vm_status = GH_RM_VM_STATUS_INIT_FAILED;
>> +    up_write(&ghvm->status_lock);
>> +    return ret;
>> +}
>> +
>> +static void gh_vm_stop(struct gunyah_vm *ghvm)
>> +{
>> +    int ret;
>> +
>> +    down_write(&ghvm->status_lock);
>> +    if (ghvm->vm_status == GH_RM_VM_STATUS_READY) {
>> +        ret = gh_rm_vm_stop(ghvm->rm, ghvm->vmid);
>> +        if (ret)
>> +            pr_warn("Failed to stop VM: %d\n", ret);
>> +    }
>> +
>> +    ghvm->vm_status = GH_RM_VM_STATUS_EXITED;
>> +    up_write(&ghvm->status_lock);
>> +}
>> +
>>   static long gh_vm_ioctl(struct file *filp, unsigned int cmd, 
>> unsigned long arg)
>>   {
>>       struct gunyah_vm *ghvm = filp->private_data;
>> @@ -84,6 +173,25 @@ static long gh_vm_ioctl(struct file *filp, 
>> unsigned int cmd, unsigned long arg)
>>           }
>>           break;
>>       }
>> +    case GH_VM_SET_DTB_CONFIG: {
>> +        struct gh_vm_dtb_config dtb_config;
>> +
>> +        r = -EFAULT;
>> +        if (copy_from_user(&dtb_config, argp, sizeof(dtb_config)))
>> +            break;
>> +
> same feedback as other patches on setting error codes.
>> +        dtb_config.size = PAGE_ALIGN(dtb_config.size);
>> +        ghvm->dtb_config = dtb_config;
>> +
>> +        r = 0;
>> +        break;
>> +    }
>> +    case GH_VM_START: {
>> +        r = gh_vm_start(ghvm);
>> +        if (r)
>> +            r = -EINVAL;
>> +        break;
>> +    }
>>       default:
>>           r = -ENOTTY;
>>           break;
>> @@ -97,6 +205,8 @@ static int gh_vm_release(struct inode *inode, 
>> struct file *filp)
>>       struct gunyah_vm *ghvm = filp->private_data;
>>       struct gunyah_vm_memory_mapping *mapping, *tmp;
>> +    gh_vm_stop(ghvm);
>> +
>>       list_for_each_entry_safe(mapping, tmp, &ghvm->memory_mappings, 
>> list) {
>>           gh_vm_mem_mapping_reclaim(ghvm, mapping);
>>           kfree(mapping);
>> diff --git a/drivers/virt/gunyah/vm_mgr.h b/drivers/virt/gunyah/vm_mgr.h
>> index 6b38bf780f76..5c02fb305893 100644
>> --- a/drivers/virt/gunyah/vm_mgr.h
>> +++ b/drivers/virt/gunyah/vm_mgr.h
>> @@ -10,6 +10,7 @@
>>   #include <linux/list.h>
>>   #include <linux/miscdevice.h>
>>   #include <linux/mutex.h>
>> +#include <linux/rwsem.h>
>>   #include <uapi/linux/gunyah.h>
>> @@ -34,6 +35,12 @@ struct gunyah_vm {
>>       u16 vmid;
>>       struct gh_rm *rm;
>> +    enum gh_rm_vm_auth_mechanism auth;
>> +    struct gh_vm_dtb_config dtb_config;
>> +
>> +    enum gh_rm_vm_status vm_status;
>> +    struct rw_semaphore status_lock;
>> +
>>       struct mutex mm_lock;
>>       struct list_head memory_mappings;
>>   };
>> @@ -42,5 +49,7 @@ struct gunyah_vm_memory_mapping 
>> *gh_vm_mem_mapping_alloc(struct gunyah_vm *ghvm,
>>                               struct gh_userspace_memory_region *region);
>>   void gh_vm_mem_mapping_reclaim(struct gunyah_vm *ghvm, struct 
>> gunyah_vm_memory_mapping *mapping);
>>   struct gunyah_vm_memory_mapping *gh_vm_mem_mapping_find(struct 
>> gunyah_vm *ghvm, u32 label);
>> +struct gunyah_vm_memory_mapping 
>> *gh_vm_mem_mapping_find_mapping(struct gunyah_vm *ghvm,
>> +                                u64 gpa, u32 size);
>>   #endif
>> diff --git a/drivers/virt/gunyah/vm_mgr_mm.c 
>> b/drivers/virt/gunyah/vm_mgr_mm.c
>> index f2dbdb4ee8ab..7fcb9f8a29bf 100644
>> --- a/drivers/virt/gunyah/vm_mgr_mm.c
>> +++ b/drivers/virt/gunyah/vm_mgr_mm.c
>> @@ -53,6 +53,30 @@ void gh_vm_mem_mapping_reclaim(struct gunyah_vm 
>> *ghvm, struct gunyah_vm_memory_m
>>       mutex_unlock(&ghvm->mm_lock);
>>   }
>> +struct gunyah_vm_memory_mapping 
>> *gh_vm_mem_mapping_find_mapping(struct gunyah_vm *ghvm,
>> +                                u64 gpa, u32 size)
>> +{
>> +    struct gunyah_vm_memory_mapping *mapping = NULL;
>> +    int ret;
>> +
>> +    ret = mutex_lock_interruptible(&ghvm->mm_lock);
>> +    if (ret)
>> +        return ERR_PTR(ret);
>> +
>> +    list_for_each_entry(mapping, &ghvm->memory_mappings, list) {
>> +        if (gpa >= mapping->guest_phys_addr &&
>> +            (gpa + size <= mapping->guest_phys_addr +
>> +            (mapping->npages << PAGE_SHIFT))) {
>> +            goto unlock;
>> +        }
>> +    }
>> +
>> +    mapping = NULL;
>> +unlock:
>> +    mutex_unlock(&ghvm->mm_lock);
>> +    return mapping;
>> +}
>> +
>>   struct gunyah_vm_memory_mapping *gh_vm_mem_mapping_find(struct 
>> gunyah_vm *ghvm, u32 label)
>>   {
>>       struct gunyah_vm_memory_mapping *mapping;
>> diff --git a/include/uapi/linux/gunyah.h b/include/uapi/linux/gunyah.h
>> index 574f33b198d0..36359ad2175e 100644
>> --- a/include/uapi/linux/gunyah.h
>> +++ b/include/uapi/linux/gunyah.h
>> @@ -42,4 +42,12 @@ struct gh_userspace_memory_region {
>>   #define GH_VM_SET_USER_MEM_REGION    _IOW(GH_IOCTL_TYPE, 0x1, \
>>                           struct gh_userspace_memory_region)
>> +struct gh_vm_dtb_config {
>> +    __u64 gpa;
> 
> need kernedoc, what is gpa?
> 

Added. It's the address of the VM's devicetree in guest memory.

>> +    __u64 size;
>> +};
>> +#define GH_VM_SET_DTB_CONFIG    _IOW(GH_IOCTL_TYPE, 0x2, struct 
>> gh_vm_dtb_config)
>> +
>> +#define GH_VM_START        _IO(GH_IOCTL_TYPE, 0x3)
>> +
>>   #endif
