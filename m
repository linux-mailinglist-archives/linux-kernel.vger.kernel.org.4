Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C98068CA7D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 00:24:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbjBFXYO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 18:24:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbjBFXYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 18:24:11 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 388F92410D;
        Mon,  6 Feb 2023 15:24:04 -0800 (PST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 316MFN3k025014;
        Mon, 6 Feb 2023 23:23:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=QG2dMxZzBM6QsdgC2fSbW6enqLXOdr3MgM8XMsQYx58=;
 b=NnHAi6mtA2NPwACApQa8JGJ5x1mzXhKSY1xsAIA0hlvj9RHcf+VZpxu/tDk+HrFUXxrZ
 wHquMGvCtPS2Non24FvfaEXeBVRym+uQK+AQxbqA5XycHKXx3POz+t1PRxrfSmkcIlxy
 NV8KXVcwip7ypY5CeCprLdNfPgIKWPdXxuTx2kP8w7bjQb4NG8RWJqybttwKpdJ0jlv2
 jLitzKVAu2FFJZ3fz0VhHLybuznUTXRsJAaCguJWBpRbzv62Qc+gKXb/NtNMqDX3p8Ns
 H/5FZC6QEQcM1LIEm6U8e1PJhtciE17vUxMcE2AmNJ1MlB+k4LluYjtD691GgN0zJEkp gQ== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nhfkactf7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Feb 2023 23:23:44 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 316NNhjc006329
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 6 Feb 2023 23:23:43 GMT
Received: from [10.134.67.48] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 6 Feb 2023
 15:23:42 -0800
Message-ID: <deff204d-600a-9606-4f77-85779830f2be@quicinc.com>
Date:   Mon, 6 Feb 2023 15:23:42 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v9 13/27] gunyah: vm_mgr: Add/remove user memory regions
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
 <20230120224627.4053418-14-quic_eberman@quicinc.com>
 <36950638-6aae-f115-86e5-97606a5d67fe@linaro.org>
From:   Elliot Berman <quic_eberman@quicinc.com>
In-Reply-To: <36950638-6aae-f115-86e5-97606a5d67fe@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: QbH9SP6itugUeJrU30b9WIznnMy87A-Z
X-Proofpoint-GUID: QbH9SP6itugUeJrU30b9WIznnMy87A-Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-06_07,2023-02-06_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 impostorscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0
 adultscore=0 suspectscore=0 spamscore=0 bulkscore=0 clxscore=1015
 mlxscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302060202
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/6/2023 8:12 AM, Srinivas Kandagatla wrote:
> 
> 
> On 20/01/2023 22:46, Elliot Berman wrote:
>> When launching a virtual machine, Gunyah userspace allocates memory for
>> the guest and informs Gunyah about these memory regions through
>> SET_USER_MEMORY_REGION ioctl.
>>
>> Co-developed-by: Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>
>> Signed-off-by: Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>
>> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
>> ---
>>   drivers/virt/gunyah/Makefile    |   2 +-
>>   drivers/virt/gunyah/vm_mgr.c    |  46 +++++++
>>   drivers/virt/gunyah/vm_mgr.h    |  28 +++-
>>   drivers/virt/gunyah/vm_mgr_mm.c | 223 ++++++++++++++++++++++++++++++++
>>   include/uapi/linux/gunyah.h     |  22 ++++
>>   5 files changed, 319 insertions(+), 2 deletions(-)
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
>> index 0864dbd77e28..b847fde63333 100644
>> --- a/drivers/virt/gunyah/vm_mgr.c
>> +++ b/drivers/virt/gunyah/vm_mgr.c
>> @@ -35,14 +35,55 @@ static __must_check struct gunyah_vm 
>> *gunyah_vm_alloc(struct gh_rm_rpc *rm)
>>       ghvm->vmid = vmid;
>>       ghvm->rm = rm;
>> +    mutex_init(&ghvm->mm_lock);
>> +    INIT_LIST_HEAD(&ghvm->memory_mappings);
>> +
>>       return ghvm;
>>   }
>>   static long gh_vm_ioctl(struct file *filp, unsigned int cmd, 
>> unsigned long arg)
>>   {
>> +    struct gunyah_vm *ghvm = filp->private_data;
>> +    void __user *argp = (void __user *)arg;
>>       long r;
>>       switch (cmd) {
>> +    case GH_VM_SET_USER_MEM_REGION: {
>> +        struct gunyah_vm_memory_mapping *mapping;
>> +        struct gh_userspace_memory_region region;
>> +
>> +        r = -EFAULT;
>> +        if (copy_from_user(&region, argp, sizeof(region)))
>> +            break;
> Why not be explict about the error codes, do something like.
> 
> if (copy_from_user(&region, argp, sizeof(region)))
>      return -EFAULT;
> 
> 
> setting r value everytime before starting any code is making the code 
> more reader unfriendly.
> 
> 

Done.


>> +
>> +        r = -EINVAL;
>> +        /* All other flag bits are reserved for future use */
>> +        if (region.flags & ~(GH_MEM_ALLOW_READ | GH_MEM_ALLOW_WRITE | 
>> GH_MEM_ALLOW_EXEC |
>> +            GH_MEM_LENT))
>> +            break;
>> +
>> +
>> +        if (region.memory_size) {
> 
> This behaviour allocating memory in presense of valid memory_size and 
> finding memory in cases of zero size needs to be described properly in 
> the uapi so that the users are aware of this.
> 

This behavior is described in "Document Gunyah VM Manager": 
https://lore.kernel.org/all/20230120224627.4053418-20-quic_eberman@quicinc.com/

>> +            r = 0;
>> +            mapping = gh_vm_mem_mapping_alloc(ghvm, &region);
>> +            if (IS_ERR(mapping)) {
>> +                r = PTR_ERR(mapping);
>> +                break;
>> +            }
>> +        } else {
>> +            mapping = gh_vm_mem_mapping_find(ghvm, region.label);
>> +            if (IS_ERR(mapping)) {
>> +                r = PTR_ERR(mapping);
>> +                break;
>> +            }
>> +            r = 0;
>> +            if (!mapping)
>> +                break;
>> +            gh_vm_mem_mapping_reclaim(ghvm, mapping);
>> +            kfree(mapping);
>> +        }
>> +        break;
>> +    }
>>       default:
>>           r = -ENOTTY;
>>           break;
>> @@ -54,7 +95,12 @@ static long gh_vm_ioctl(struct file *filp, unsigned 
>> int cmd, unsigned long arg)
>>   static int gh_vm_release(struct inode *inode, struct file *filp)
>>   {
>>       struct gunyah_vm *ghvm = filp->private_data;
>> +    struct gunyah_vm_memory_mapping *mapping, *tmp;
> Locking?
>> +    list_for_each_entry_safe(mapping, tmp, &ghvm->memory_mappings, 
>> list) {
>> +        gh_vm_mem_mapping_reclaim(ghvm, mapping);
>> +        kfree(mapping);
>> +    }
>>       put_gh_rm(ghvm->rm);
>>       kfree(ghvm);
>>       return 0;
>> diff --git a/drivers/virt/gunyah/vm_mgr.h b/drivers/virt/gunyah/vm_mgr.h
>> index e47f34de7f9e..6b38bf780f76 100644
>> --- a/drivers/virt/gunyah/vm_mgr.h
>> +++ b/drivers/virt/gunyah/vm_mgr.h
>> @@ -7,14 +7,40 @@
>>   #define _GH_PRIV_VM_MGR_H
>>   #include <linux/gunyah_rsc_mgr.h>
>> +#include <linux/list.h>
>> +#include <linux/miscdevice.h>
>> +#include <linux/mutex.h>
>>   #include <uapi/linux/gunyah.h>
>>   long gh_dev_vm_mgr_ioctl(struct gh_rm *rm, unsigned int cmd, 
>> unsigned long arg);
>> +enum gunyah_vm_mem_share_type {
>> +    VM_MEM_SHARE,
>> +    VM_MEM_LEND,
>> +};
>> +
>> +struct gunyah_vm_memory_mapping {
>> +    struct list_head list;
>> +    enum gunyah_vm_mem_share_type share_type;
>> +    struct gh_rm_mem_parcel parcel;
>> +
>> +    __u64 guest_phys_addr;
>> +    struct page **pages;
>> +    unsigned long npages;
>> +};
>> +
>>   struct gunyah_vm {
>>       u16 vmid;
>> -    struct gh_rm_rpc *rm;
>> +    struct gh_rm *rm;
>> +
>> +    struct mutex mm_lock;
>> +    struct list_head memory_mappings;
>>   };
>> +struct gunyah_vm_memory_mapping *gh_vm_mem_mapping_alloc(struct 
>> gunyah_vm *ghvm,
>> +                            struct gh_userspace_memory_region *region);
>> +void gh_vm_mem_mapping_reclaim(struct gunyah_vm *ghvm, struct 
>> gunyah_vm_memory_mapping *mapping);
>> +struct gunyah_vm_memory_mapping *gh_vm_mem_mapping_find(struct 
>> gunyah_vm *ghvm, u32 label);
>> +
>>   #endif
>> diff --git a/drivers/virt/gunyah/vm_mgr_mm.c 
>> b/drivers/virt/gunyah/vm_mgr_mm.c
>> new file mode 100644
>> index 000000000000..f2dbdb4ee8ab
>> --- /dev/null
>> +++ b/drivers/virt/gunyah/vm_mgr_mm.c
>> @@ -0,0 +1,223 @@
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
>> +{
>> +    return t - p == PAGE_SIZE;
>> +}
>> +
>> +static struct gunyah_vm_memory_mapping 
>> *__gh_vm_mem_mapping_find(struct gunyah_vm *ghvm, u32 label)
>> +{
>> +    struct gunyah_vm_memory_mapping *mapping;
>> +
>> +
> only one line.

Done.

>> +    list_for_each_entry(mapping, &ghvm->memory_mappings, list)
>> +        if (mapping->parcel.label == label)
>> +            return mapping;
>> +
>> +    return NULL;
>> +}
>> +
>> +void gh_vm_mem_mapping_reclaim(struct gunyah_vm *ghvm, struct 
>> gunyah_vm_memory_mapping *mapping)
>> +{
>> +    int i, ret = 0;
>> +
>> +    if (mapping->parcel.mem_handle != GH_MEM_HANDLE_INVAL) {
>> +        ret = gh_rm_mem_reclaim(ghvm->rm, &mapping->parcel);
>> +        if (ret)
>> +            pr_warn("Failed to reclaim memory parcel for label %d: 
>> %d\n",
>> +                mapping->parcel.label, ret);
>> +    }
>> +
>> +    if (!ret)
>> +        for (i = 0; i < mapping->npages; i++)
>> +            unpin_user_page(mapping->pages[i]);
>> +
>> +    kfree(mapping->pages);
>> +    kfree(mapping->parcel.acl_entries);
>> +    kfree(mapping->parcel.mem_entries);
>> +
>> +    mutex_lock(&ghvm->mm_lock);
>> +    list_del(&mapping->list);
>> +    mutex_unlock(&ghvm->mm_lock);
>> +}
>> +
>> +struct gunyah_vm_memory_mapping *gh_vm_mem_mapping_find(struct 
>> gunyah_vm *ghvm, u32 label)
>> +{
>> +    struct gunyah_vm_memory_mapping *mapping;
>> +    int ret;
>> +
>> +    ret = mutex_lock_interruptible(&ghvm->mm_lock);
>> +    if (ret)
>> +        return ERR_PTR(ret);
>> +    mapping = __gh_vm_mem_mapping_find(ghvm, label);
>> +    mutex_unlock(&ghvm->mm_lock);
>> +    return mapping ? : ERR_PTR(-ENODEV);
>> +}
>> +
>> +struct gunyah_vm_memory_mapping *gh_vm_mem_mapping_alloc(struct 
>> gunyah_vm *ghvm,
>> +                            struct gh_userspace_memory_region *region)
>> +{
> Is this a static functoin or an exported symbol?
> 

Neither, it's used in vm_mgr.c.

>> +    phys_addr_t curr_page, prev_page;
>> +    struct gunyah_vm_memory_mapping *mapping, *tmp_mapping;
>> +    struct gh_rm_mem_entry *mem_entries;
>> +    int i, j, pinned, ret = 0;
>> +    struct gh_rm_mem_parcel *parcel;
>> +    size_t entry_size;
>> +    u16 vmid; > +
> Reverse christmas tree to sor local variables would be nice.
> 

Done, and checked throughout the series as well.

>> +    if (!region->memory_size || !PAGE_ALIGNED(region->memory_size) ||
>> +        !PAGE_ALIGNED(region->userspace_addr))
> Even this alignment needs some documentation.
> 

Documented now.

> Or why not just let the user only pass number of pages instead of size?
> 
> 

KVM, Nitro enclaves, and ACRN all give size directly and not as # of pages.

>> +        return ERR_PTR(-EINVAL);
>> +
>> +    if (!gh_api_has_feature(GH_API_FEATURE_MEMEXTENT))
>> +        return ERR_PTR(-EOPNOTSUPP);
> 
> We should proabably move this as very first check while handling this 
> IOCTL.
> 

Done.

> 
>> +
>> +    ret = mutex_lock_interruptible(&ghvm->mm_lock);
>> +    if (ret)
>> +        return ERR_PTR(ret);
>> +    mapping = __gh_vm_mem_mapping_find(ghvm, region->label);
> 
> so label is unique and userspace proabably aware of this?
> Can we have more than one userspace doing this? and if so how can it 
> ensure that each label is unique?
> 

The label is unique and userspace is aware of this. One userspace owns 
the VM FD.

> 
>> +    if (mapping) {
>> +        mutex_unlock(&ghvm->mm_lock);
>> +        return ERR_PTR(-EEXIST);
>> +    }
>> +
>> +    mapping = kzalloc(sizeof(*mapping), GFP_KERNEL);
>> +    if (!mapping) {
>> +        ret = -ENOMEM;
>> +        goto unlock;
>> +    }
>> +
>> +    mapping->parcel.label = region->label;
> 
>> +    mapping->guest_phys_addr = region->guest_phys_addr;
>> +    mapping->npages = region->memory_size >> PAGE_SHIFT;
>> +    parcel = &mapping->parcel;
>> +    parcel->mem_handle = GH_MEM_HANDLE_INVAL; /* to be filled later 
>> by mem_share/mem_lend */
>> +    parcel->mem_type = GH_RM_MEM_TYPE_NORMAL;
>> +
>> +    /* Check for overlap */
>> +    list_for_each_entry(tmp_mapping, &ghvm->memory_mappings, list) {
>> +        if (!((mapping->guest_phys_addr + (mapping->npages << 
>> PAGE_SHIFT) <=
>> +            tmp_mapping->guest_phys_addr) ||
>> +            (mapping->guest_phys_addr >=
>> +            tmp_mapping->guest_phys_addr + (tmp_mapping->npages << 
>> PAGE_SHIFT)))) {
>> +            ret = -EEXIST;
>> +            goto unlock;
>> +        }
>> +    }
> This looks like we will loop every mappign for each allocation giving us 
> an O(n), How frequent and how many max mappings can be there in the system?
> 

In all our use cases so far, only a few (max 3) mappings are used. 
Gunyah and Linux would be similarly bounded by heap-based memory 
constraints when adding more memory mappings if you don't hit U32_MAX first.

This could be reworked into a rb tree, but I thought it better to use a 
simpler list-based implementation since it was easier to review and 
benefits are not seen when only a few mappings used.

[snip]

>> --- a/include/uapi/linux/gunyah.h
>> +++ b/include/uapi/linux/gunyah.h
>> @@ -20,4 +20,26 @@
>>    */
>>   #define GH_CREATE_VM            _IO(GH_IOCTL_TYPE, 0x0) /* Returns a 
>> Gunyah VM fd */
>> +/*
>> + * ioctls for VM fds
>> + */
>> +struct gh_userspace_memory_region {
> 
> This struct needs some kernedoc.
> 

Done, as well for the other UAPI structs added later in the series.


>> +    __u32 label;
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
> if we are only expecting pages, this should probably be make explict by 
> using nr_pages instead of size
> 
>> +    __u64 userspace_addr;
>> +};
>> +
>> +#define GH_VM_SET_USER_MEM_REGION    _IOW(GH_IOCTL_TYPE, 0x1, \
>> +                        struct gh_userspace_memory_region)
>> +
>>   #endif
