Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B07306A2613
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Feb 2023 02:03:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbjBYBDe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 20:03:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjBYBDc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 20:03:32 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7464F1ACCF;
        Fri, 24 Feb 2023 17:03:30 -0800 (PST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31P0TJAx003921;
        Sat, 25 Feb 2023 01:03:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Az2KH2GdEWzN3twvzfNDan9Gs0FTfsv+Qm6CS4ij44I=;
 b=GpecsAkBO5lg94NqU8/dj6hkWv8T/fN1Ge5pYb/paQkH10HcFFpZ9ArbrIyM0NvGUcxW
 1GuI95NmG3nMi85/ipiQ+Rogynp0m/ErN7+PYLhRW3myHHwhKS798bTKXEHlDoSwRgvH
 PIX5jIMLCikW5KapOVmfvJ4NBrtkF3iQKdGBV9rVh/fS1LF7sBxt2g2uzoAvu5dcy5Uk
 W48GrKMafiK6IhwE6wN8BU26QhGHR0X4tten5ZUcSyNjpiZQjt+43ZBNNO/8AfnryNr0
 tLR1iL+bODRjkkcVy61j1Ay4eHZ0tQb6MZs/bK8+2Jo3CV124hfpdYQOUNbzZCVtyusA ug== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nwy9a6aqv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 25 Feb 2023 01:03:13 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31P13Chd015628
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 25 Feb 2023 01:03:12 GMT
Received: from [10.110.9.108] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 24 Feb
 2023 17:03:11 -0800
Message-ID: <1cdb4748-d8e2-fcfa-d71b-827ab248f45a@quicinc.com>
Date:   Fri, 24 Feb 2023 17:03:10 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v10 12/26] gunyah: vm_mgr: Add/remove user memory regions
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
 <20230214212417.3315422-1-quic_eberman@quicinc.com>
 <971726ce-b88a-0e68-45aa-862f821116ae@linaro.org>
From:   Elliot Berman <quic_eberman@quicinc.com>
In-Reply-To: <971726ce-b88a-0e68-45aa-862f821116ae@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: FaKPV7PuiZEJvk1TSeHYk_eRLEPZw6Zt
X-Proofpoint-ORIG-GUID: FaKPV7PuiZEJvk1TSeHYk_eRLEPZw6Zt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-24_18,2023-02-24_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1015
 malwarescore=0 spamscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 adultscore=0 phishscore=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302250003
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/23/2023 4:34 PM, Alex Elder wrote:
> On 2/14/23 3:24 PM, Elliot Berman wrote:
>>
>> When launching a virtual machine, Gunyah userspace allocates memory for
>> the guest and informs Gunyah about these memory regions through
>> SET_USER_MEMORY_REGION ioctl.
>>
>> Co-developed-by: Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>
>> Signed-off-by: Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>
>> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
>> ---
>>   drivers/virt/gunyah/Makefile    |   2 +-
>>   drivers/virt/gunyah/vm_mgr.c    |  44 ++++++
>>   drivers/virt/gunyah/vm_mgr.h    |  25 ++++
>>   drivers/virt/gunyah/vm_mgr_mm.c | 235 ++++++++++++++++++++++++++++++++
>>   include/uapi/linux/gunyah.h     |  33 +++++
>>   5 files changed, 338 insertions(+), 1 deletion(-)
>>   create mode 100644 drivers/virt/gunyah/vm_mgr_mm.c
>>
>> diff --git a/drivers/virt/gunyah/Makefile b/drivers/virt/gunyah/Makefile
>> index 03951cf82023..ff8bc4925392 100644
>> --- a/drivers/virt/gunyah/Makefile
>> +++ b/drivers/virt/gunyah/Makefile
>> @@ -2,5 +2,5 @@
>>   obj-$(CONFIG_GUNYAH) += gunyah.o
>> -gunyah_rsc_mgr-y += rsc_mgr.o rsc_mgr_rpc.o vm_mgr.o
>> +gunyah_rsc_mgr-y += rsc_mgr.o rsc_mgr_rpc.o vm_mgr.o vm_mgr_mm.o
>>   obj-$(CONFIG_GUNYAH) += gunyah_rsc_mgr.o
>> diff --git a/drivers/virt/gunyah/vm_mgr.c b/drivers/virt/gunyah/vm_mgr.c
>> index fd890a57172e..84102bac03cc 100644
>> --- a/drivers/virt/gunyah/vm_mgr.c
>> +++ b/drivers/virt/gunyah/vm_mgr.c
>> @@ -18,8 +18,16 @@
>>   static void gh_vm_free(struct work_struct *work)
>>   {
>>       struct gh_vm *ghvm = container_of(work, struct gh_vm, free_work);
>> +    struct gh_vm_mem *mapping, *tmp;
>>       int ret;
>> +    mutex_lock(&ghvm->mm_lock);
>> +    list_for_each_entry_safe(mapping, tmp, &ghvm->memory_mappings, 
>> list) {
>> +        gh_vm_mem_reclaim(ghvm, mapping);
>> +        kfree(mapping);
>> +    }
>> +    mutex_unlock(&ghvm->mm_lock);
>> +
>>       ret = gh_rm_dealloc_vmid(ghvm->rm, ghvm->vmid);
>>       if (ret)
>>           pr_warn("Failed to deallocate vmid: %d\n", ret);
>> @@ -48,11 +56,46 @@ static __must_check struct gh_vm 
>> *gh_vm_alloc(struct gh_rm *rm)
>>       ghvm->vmid = vmid;
>>       ghvm->rm = rm;
>> +    mutex_init(&ghvm->mm_lock);
>> +    INIT_LIST_HEAD(&ghvm->memory_mappings);
>>       INIT_WORK(&ghvm->free_work, gh_vm_free);
>>       return ghvm;
>>   }
>> +static long gh_vm_ioctl(struct file *filp, unsigned int cmd, unsigned 
>> long arg)
>> +{
>> +    struct gh_vm *ghvm = filp->private_data;
>> +    void __user *argp = (void __user *)arg;
>> +    long r;
>> +
>> +    switch (cmd) {
>> +    case GH_VM_SET_USER_MEM_REGION: {
>> +        struct gh_userspace_memory_region region;
>> +
>> +        if (copy_from_user(&region, argp, sizeof(region)))
>> +            return -EFAULT;
>> +
>> +        /* All other flag bits are reserved for future use */
>> +        if (region.flags & ~(GH_MEM_ALLOW_READ | GH_MEM_ALLOW_WRITE | 
>> GH_MEM_ALLOW_EXEC |
>> +            GH_MEM_LENT))
>> +            return -EINVAL;
>> +
>> +
>> +        if (region.memory_size)
> 
> Would there be any value in allowing a zero-size memory
> region to be created?  Maybe that doesn't make sense, but
> I guess i'm questioning whether a zero memory region size
> have special meaning in this interface is a good thing to
> do.  You could sensibly have a separate REMOVE_USER_MEM_REGION
> request, and still permit 0 to be a valid size.
> 

I don't think zero-size memory region makes sense. At best, it only 
registers an empty region with guest and causes memory overhead for 
bookkeeping.

>> +            r = gh_vm_mem_alloc(ghvm, &region);
>> +        else
>> +            r = gh_vm_mem_free(ghvm, region.label);
>> +        break;
>> +    }
>> +    default:
>> +        r = -ENOTTY;
>> +        break;
>> +    }
>> +
>> +    return r;
>> +}
>> +
>>   static int gh_vm_release(struct inode *inode, struct file *filp)
>>   {
>>       struct gh_vm *ghvm = filp->private_data;
>> @@ -65,6 +108,7 @@ static int gh_vm_release(struct inode *inode, 
>> struct file *filp)
>>   }
>>   static const struct file_operations gh_vm_fops = {
>> +    .unlocked_ioctl = gh_vm_ioctl,
>>       .release = gh_vm_release,
>>       .compat_ioctl    = compat_ptr_ioctl,
>>       .llseek = noop_llseek,
>> diff --git a/drivers/virt/gunyah/vm_mgr.h b/drivers/virt/gunyah/vm_mgr.h
>> index 76954da706e9..97bc00c34878 100644
>> --- a/drivers/virt/gunyah/vm_mgr.h
>> +++ b/drivers/virt/gunyah/vm_mgr.h
>> @@ -7,16 +7,41 @@
>>   #define _GH_PRIV_VM_MGR_H
>>   #include <linux/gunyah_rsc_mgr.h>
>> +#include <linux/list.h>
>> +#include <linux/miscdevice.h>
>> +#include <linux/mutex.h>
>>   #include <uapi/linux/gunyah.h>
>>   long gh_dev_vm_mgr_ioctl(struct gh_rm *rm, unsigned int cmd, 
>> unsigned long arg);
>> +enum gh_vm_mem_share_type {
>> +    VM_MEM_SHARE,
>> +    VM_MEM_LEND,
> 
> Are there any other share types anticipated?  Even if
> there were, for now you could use a Boolean to distinguish
> between shared or lent (at least until a third option
> materializes).
> 

There is VM_MEM_DONATE. I can add the type, but it's only used special 
VMs (there's nothing really stopping a generic unauth VM to use it, but 
I don't think anyone will want to).

>> +};
>> +
>> +struct gh_vm_mem {
>> +    struct list_head list;
>> +    enum gh_vm_mem_share_type share_type;
>> +    struct gh_rm_mem_parcel parcel;
>> +
>> +    __u64 guest_phys_addr;
>> +    struct page **pages;
>> +    unsigned long npages;
>> +};
>> +
>>   struct gh_vm {
>>       u16 vmid;
>>       struct gh_rm *rm;
>>       struct work_struct free_work;
>> +    struct mutex mm_lock;
>> +    struct list_head memory_mappings;
>>   };
>> +int gh_vm_mem_alloc(struct gh_vm *ghvm, struct 
>> gh_userspace_memory_region *region);
>> +void gh_vm_mem_reclaim(struct gh_vm *ghvm, struct gh_vm_mem *mapping);
>> +int gh_vm_mem_free(struct gh_vm *ghvm, u32 label);
>> +struct gh_vm_mem *gh_vm_mem_find(struct gh_vm *ghvm, u32 label);
>> +
>>   #endif
>> diff --git a/drivers/virt/gunyah/vm_mgr_mm.c 
>> b/drivers/virt/gunyah/vm_mgr_mm.c
>> new file mode 100644
>> index 000000000000..03e71a36ea3b
>> --- /dev/null
>> +++ b/drivers/virt/gunyah/vm_mgr_mm.c
>> @@ -0,0 +1,235 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All 
>> rights reserved.
>> + */
>> +
>> +#define pr_fmt(fmt) "gh_vm_mgr: " fmt
>> +
>> +#include <linux/gunyah_rsc_mgr.h>
>> +#include <linux/mm.h>
>> +
>> +#include <uapi/linux/gunyah.h>
>> +
>> +#include "vm_mgr.h"
>> +
>> +static inline bool page_contiguous(phys_addr_t p, phys_addr_t t)
> 
> Is there not some existing function that captures this?
> In any case, it's used in one place and I think it would
> be clearer to just put the logic there rather than hiding
> it behind this function.
> 

Done.

>> +{
>> +    return t - p == PAGE_SIZE;
>> +}
>> +
>> +static struct gh_vm_mem *__gh_vm_mem_find(struct gh_vm *ghvm, u32 label)
>> +    __must_hold(&ghvm->mm_lock)
>> +{
>> +    struct gh_vm_mem *mapping;
>> +
>> +    list_for_each_entry(mapping, &ghvm->memory_mappings, list)
>> +        if (mapping->parcel.label == label)
>> +            return mapping;
>> +
>> +    return NULL;
>> +}
>> +
> 
> . . .
> 
>> diff --git a/include/uapi/linux/gunyah.h b/include/uapi/linux/gunyah.h
>> index 10ba32d2b0a6..d85d12119a48 100644
>> --- a/include/uapi/linux/gunyah.h
>> +++ b/include/uapi/linux/gunyah.h
>> @@ -20,4 +20,37 @@
>>    */
>>   #define GH_CREATE_VM            _IO(GH_IOCTL_TYPE, 0x0) /* Returns a 
>> Gunyah VM fd */
>> +/*
>> + * ioctls for VM fds
>> + */
>> +
>> +/**
>> + * struct gh_userspace_memory_region - Userspace memory descripion 
>> for GH_VM_SET_USER_MEM_REGION
>> + * @label: Unique identifer to the region.
> 
> Maybe this is described somewhere, but what is the purpose
> of the label?  Who uses it?  Is it meant to be a value
> only the current owner of a resource understands?  Or does
> resource manager use it internally, or what?
> 

The label is used by kernel, userspace, and Gunyah. Userspace decides 
all the labels and there are no special labels.

  - Userspace can delete memory parcels by label (kernel looks up parcel 
by label)
  - The VM's DTB configuration describes where Gunyah should map memory 
parcels into guest's memory. The VM DTB uses the memory parcel's label 
as the reference.

Thanks,
Elliot

>> + * @flags: Flags for memory parcel behavior
>> + * @guest_phys_addr: Location of the memory region in guest's memory 
>> space (page-aligned)
>> + * @memory_size: Size of the region (page-aligned)
>> + * @userspace_addr: Location of the memory region in caller 
>> (userspace)'s memory
>> + *
>> + * See Documentation/virt/gunyah/vm-manager.rst for further details.
>> + */
>> +struct gh_userspace_memory_region {
>> +    __u32 label;
> 
> Define the possible permission values separate from
> the structure.
> 
>                      -Alex
> 
>> +#define GH_MEM_ALLOW_READ    (1UL << 0)
>> +#define GH_MEM_ALLOW_WRITE    (1UL << 1)
>> +#define GH_MEM_ALLOW_EXEC    (1UL << 2)
>> +/*
>> + * The guest will be lent the memory instead of shared.
>> + * In other words, the guest has exclusive access to the memory 
>> region and the host loses access.
>> + */
>> +#define GH_MEM_LENT        (1UL << 3)
>> +    __u32 flags;
>> +    __u64 guest_phys_addr;
>> +    __u64 memory_size;
>> +    __u64 userspace_addr;
>> +};
>> +
>> +#define GH_VM_SET_USER_MEM_REGION    _IOW(GH_IOCTL_TYPE, 0x1, \
>> +                        struct gh_userspace_memory_region)
>> +
>>   #endif
> 
