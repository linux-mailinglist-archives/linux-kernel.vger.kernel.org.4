Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F6246A0033
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 01:51:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232965AbjBWAvQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 19:51:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232484AbjBWAvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 19:51:14 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96336311EC;
        Wed, 22 Feb 2023 16:51:12 -0800 (PST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31MMsMNe010572;
        Thu, 23 Feb 2023 00:50:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : from : subject : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Hyvetjjv4/f6lg/AmVU3Uxy/R0nl9IZIJe5R08fn/ts=;
 b=K1UKNOttEwtHDWCt7vB3G9i5P/WNkNwfHwzgHHfJiK7F7h6uLmql8WcX3xfUfsqSS9Er
 XSzXq7bQl/L4jynrdlvROYNwZBX8LQ8CT01YwGKF3k4RHPIgPokixb6tEO+eg2EfKVMB
 NoEPNxLBsWbDZR3l7OV+jZbS19y0DgHIiCuZmSNq6VcE8zasQPVknenrcTLT147OmKbF
 OLac5VYBpaqFwZIHdFAUzPTLn/nJroQTfFHNxh36zFkJaYsq5F+U4HVIEY6ZnnADT8Tj
 uCby8HYMfm1UxOhswUg/Fv7GQKGOPADUo32uRgRj1LrP6bbSGfIFRB1gqd+dA1mhpyuI 2Q== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nw8gnu8bb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Feb 2023 00:50:54 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31N0ortv000562
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Feb 2023 00:50:53 GMT
Received: from [10.134.67.48] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 22 Feb
 2023 16:50:52 -0800
Message-ID: <320d42a0-9889-43ae-5d62-0c4cab3434c5@quicinc.com>
Date:   Wed, 22 Feb 2023 16:50:52 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
From:   Elliot Berman <quic_eberman@quicinc.com>
Subject: Re: [PATCH v10 13/26] gunyah: vm_mgr: Add ioctls to support basic
 non-proxy VM boot
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
        Catalin Marinas <catalin.marinas@arm.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20230214211229.3239350-1-quic_eberman@quicinc.com>
 <20230214212427.3316544-1-quic_eberman@quicinc.com>
 <1080339c-608e-6df8-8eee-b8f3bb7f396d@linaro.org>
Content-Language: en-US
In-Reply-To: <1080339c-608e-6df8-8eee-b8f3bb7f396d@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: P97o6uUCWw4jxBzhEfIZGvkxIbTFbTW1
X-Proofpoint-GUID: P97o6uUCWw4jxBzhEfIZGvkxIbTFbTW1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-22_12,2023-02-22_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 adultscore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0 phishscore=0
 suspectscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302230005
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/21/2023 6:17 AM, Srinivas Kandagatla wrote:
> 
> 
> On 14/02/2023 21:24, Elliot Berman wrote:
>>
>> Add remaining ioctls to support non-proxy VM boot:
>>
>>   - Gunyah Resource Manager uses the VM's devicetree to configure the
>>     virtual machine. The location of the devicetree in the guest's
>>     virtual memory can be declared via the SET_DTB_CONFIGioctl.
>>   - Trigger start of the virtual machine with VM_START ioctl.
>>
>> Co-developed-by: Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>
>> Signed-off-by: Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>
>> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
>> ---
>>   drivers/virt/gunyah/vm_mgr.c    | 229 ++++++++++++++++++++++++++++++--
>>   drivers/virt/gunyah/vm_mgr.h    |  10 ++
>>   drivers/virt/gunyah/vm_mgr_mm.c |  23 ++++
>>   include/linux/gunyah_rsc_mgr.h  |   6 +
>>   include/uapi/linux/gunyah.h     |  13 ++
>>   5 files changed, 268 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/virt/gunyah/vm_mgr.c b/drivers/virt/gunyah/vm_mgr.c
>> index 84102bac03cc..fa324385ade5 100644
>> --- a/drivers/virt/gunyah/vm_mgr.c
>> +++ b/drivers/virt/gunyah/vm_mgr.c
>> @@ -9,37 +9,114 @@
>>   #include <linux/file.h>
>>   #include <linux/gunyah_rsc_mgr.h>
>>   #include <linux/miscdevice.h>
>> +#include <linux/mm.h>
>>   #include <linux/module.h>
>>   #include <uapi/linux/gunyah.h>
>>   #include "vm_mgr.h"
>> +static int gh_vm_rm_notification_status(struct gh_vm *ghvm, void *data)
>> +{
>> +    struct gh_rm_vm_status_payload *payload = data;
>> +
>> +    if (payload->vmid != ghvm->vmid)
>> +        return NOTIFY_OK;
> Is this even possible? If yes, then this is a bug somewhere, we should 
> not be getting notifications for something that does not belong to this vm.
> What is the typical case for such behavior? comment would be useful.
> 

VM manager has reigstered to receive all notifications. If there are 
multiple VMs running, then the notifier callback receives notifications 
about all VMs. I've not yet implemented any filtering at resource 
manager level because it added lot of processing code in the resource 
manager that is easily done in the notifier callback.

> 
>> +
>> +    /* All other state transitions are synchronous to a corresponding 
>> RM call */
>> +    if (payload->vm_status == GH_RM_VM_STATUS_RESET){
>> +        down_write(&ghvm->status_lock);
>> +        ghvm->vm_status = payload->vm_status;
>> +        up_write(&ghvm->status_lock);
>> +        wake_up(&ghvm->vm_status_wait);
>> +    }
>> +
>> +    return NOTIFY_DONE;
>> +}
>> +
>> +static int gh_vm_rm_notification_exited(struct gh_vm *ghvm, void *data)
>> +{
>> +    struct gh_rm_vm_exited_payload *payload = data;
>> +
>> +    if (payload->vmid != ghvm->vmid)
>> +        return NOTIFY_OK;
> same
> 
>> +
>> +    down_write(&ghvm->status_lock);
>> +    ghvm->vm_status = GH_RM_VM_STATUS_EXITED;
>> +    up_write(&ghvm->status_lock);
>> +
>> +    return NOTIFY_DONE;
>> +}
>> +
>> +static int gh_vm_rm_notification(struct notifier_block *nb, unsigned 
>> long action, void *data)
>> +{
>> +    struct gh_vm *ghvm = container_of(nb, struct gh_vm, nb);
>> +
>> +    switch (action) {
>> +    case GH_RM_NOTIFICATION_VM_STATUS:
>> +        return gh_vm_rm_notification_status(ghvm, data);
>> +    case GH_RM_NOTIFICATION_VM_EXITED:
>> +        return gh_vm_rm_notification_exited(ghvm, data);
>> +    default:
>> +        return NOTIFY_OK;
>> +    }
>> +}
>> +
>> +static void gh_vm_stop(struct gh_vm *ghvm)
>> +{
>> +    int ret;
>> +
>> +    down_write(&ghvm->status_lock);
>> +    if (ghvm->vm_status == GH_RM_VM_STATUS_RUNNING) {
>> +        ret = gh_rm_vm_stop(ghvm->rm, ghvm->vmid);
>> +        if (ret)
>> +            pr_warn("Failed to stop VM: %d\n", ret);
> Should we not bail out from this fail path?
> 

This is called in the gh_vm_free path and we have some options here when 
we get some error while stopping a VM. So far, my strategy has been to 
ignore error as best we can and continue. We might get further errors, 
but we can also continue to clean up some more resources.

If there's an error, I'm not sure if there is a proper strategy to get 
someone to retry later: userspace is closing all its references to the 
VM and we need to stop the VM and clean up all our resources. Nitro 
Enclaves and ACRN suffer similar

> 
>> +    }
>> +
>> +    ghvm->vm_status = GH_RM_VM_STATUS_EXITED;
>> +    up_write(&ghvm->status_lock);
>> +}
>> +
>>   static void gh_vm_free(struct work_struct *work)
>>   {
>>       struct gh_vm *ghvm = container_of(work,struct gh_vm, free_work);
>>       struct gh_vm_mem *mapping, *tmp;
>>       int ret;
>> -    mutex_lock(&ghvm->mm_lock);
>> -    list_for_each_entry_safe(mapping, tmp, &ghvm->memory_mappings, 
>> list) {
>> -        gh_vm_mem_reclaim(ghvm, mapping);
>> -        kfree(mapping);
>> +    switch (ghvm->vm_status) {
>> +unknown_state:
> 
> Never seen this style of using goto from switch to a new label in switch 
> case. Am sure this is some kinda trick but its not helping readers.
> 
> Can we rewrite this using a normal semantics.
> 
> may be a do while could help.
> 

Srivatsa suggested dropping the goto, I can do that.
> 
>> +    case GH_RM_VM_STATUS_RUNNING:
>> +        gh_vm_stop(ghvm);
>> +        fallthrough;
>> +    case GH_RM_VM_STATUS_INIT_FAILED:
>> +    case GH_RM_VM_STATUS_LOAD:
>> +    case GH_RM_VM_STATUS_LOAD_FAILED:
>> +        mutex_lock(&ghvm->mm_lock);
>> +        list_for_each_entry_safe(mapping, tmp, 
>> &ghvm->memory_mappings, list) {
>> +            gh_vm_mem_reclaim(ghvm, mapping);
>> +            kfree(mapping);
>> +        }
>> +        mutex_unlock(&ghvm->mm_lock);
>> +        fallthrough;
>> +    case GH_RM_VM_STATUS_NO_STATE:
>> +        ret = gh_rm_dealloc_vmid(ghvm->rm, ghvm->vmid);
>> +        if (ret)
>> +            pr_warn("Failed to deallocate vmid: %d\n", ret);
>> +
>> +        gh_rm_notifier_unregister(ghvm->rm, &ghvm->nb);
>> +        put_gh_rm(ghvm->rm);
>> +        kfree(ghvm);
>> +        break;
>> +    default:
>> +        pr_err("VM is unknown state:%d, assuming it's running.\n", 
>> ghvm->vm_status);
> vm_status did not change do we not endup here again?
> 
>> +        goto unknown_state;
>>       }
>> -    mutex_unlock(&ghvm->mm_lock);
>> -
>> -    ret = gh_rm_dealloc_vmid(ghvm->rm, ghvm->vmid);
>> -    if (ret)
>> -        pr_warn("Failed to deallocate vmid: %d\n", ret);
>> -
>> -    put_gh_rm(ghvm->rm);
>> -    kfree(ghvm);
>>   }
>>   static __must_check struct gh_vm *gh_vm_alloc(struct gh_rm *rm)
>>   {
>>       struct gh_vm *ghvm;
>> -    int vmid;
>> +    int vmid, ret;
>>       vmid = gh_rm_alloc_vmid(rm, 0);
>>       if (vmid < 0)
>> @@ -56,13 +133,123 @@ static __must_check struct gh_vm 
>> *gh_vm_alloc(struct gh_rm *rm)
>>       ghvm->vmid = vmid;
>>       ghvm->rm = rm;
>> +    init_waitqueue_head(&ghvm->vm_status_wait);
>> +    ghvm->nb.notifier_call = gh_vm_rm_notification;
>> +    ret = gh_rm_notifier_register(rm, &ghvm->nb);
>> +    if (ret) {
>> +        put_gh_rm(rm);
>> +        gh_rm_dealloc_vmid(rm, vmid);
>> +        kfree(ghvm);
>> +        return ERR_PTR(ret);
>> +    }
>> +
>>       mutex_init(&ghvm->mm_lock);
>>       INIT_LIST_HEAD(&ghvm->memory_mappings);
>> +    init_rwsem(&ghvm->status_lock);
>>       INIT_WORK(&ghvm->free_work, gh_vm_free);
>> +    ghvm->vm_status = GH_RM_VM_STATUS_LOAD;
>>       return ghvm;
>>   }
>> +static int gh_vm_start(struct gh_vm *ghvm)
>> +{
>> +    struct gh_vm_mem *mapping;
>> +    u64 dtb_offset;
>> +    u32 mem_handle;
>> +    int ret;
>> +
>> +    down_write(&ghvm->status_lock);
>> +    if (ghvm->vm_status != GH_RM_VM_STATUS_LOAD) {
>> +        up_write(&ghvm->status_lock);
>> +        return 0;
>> +    }
>> +
>> +    ghvm->vm_status = GH_RM_VM_STATUS_RESET;
>> +
> 
> <------
> should we not take ghvm->mm_lock here to make sure that list is 
> consistent while processing.

Done.

>> +    list_for_each_entry(mapping, &ghvm->memory_mappings,list) {
>> +        switch (mapping->share_type){
>> +        case VM_MEM_LEND:
>> +            ret = gh_rm_mem_lend(ghvm->rm, &mapping->parcel);
>> +            break;
>> +        case VM_MEM_SHARE:
>> +            ret = gh_rm_mem_share(ghvm->rm, &mapping->parcel);
>> +            break;
>> +        }
>> +        if (ret) {
>> +            pr_warn("Failed to %s parcel %d: %d\n",
>> +                mapping->share_type == VM_MEM_LEND ? "lend" : "share",
>> +                mapping->parcel.label,
>> +                ret);
>> +            gotoerr;
>> +        }
>> +    }
> --->
> 
>> +
>> +    mapping = gh_vm_mem_find_mapping(ghvm, ghvm->dtb_config.gpa, 
>> ghvm->dtb_config.size);
>> +    if (!mapping) {
>> +        pr_warn("Failed to find the memory_handle for DTB\n");
> 
> What wil happen to the mappings that are lend or shared?
> 

When the VM is cleaned up (on final destruction), the mappings are 
reclaimed.

>> +        ret = -EINVAL;
>> +        goto err;
>> +    }
>> +
>> +    mem_handle = mapping->parcel.mem_handle;
>> +    dtb_offset = ghvm->dtb_config.gpa - mapping->guest_phys_addr;
>> +
>> +    ret = gh_rm_vm_configure(ghvm->rm, ghvm->vmid, ghvm->auth, 
>> mem_handle,
> 
> where is authentication mechanism (auth) comming from? Who is supposed 
> to set this value?
> 
> Should it come from userspace? if so I do not see any UAPI facility to 
> do that via VM_START ioctl.
> 

Right, we are only adding the support for unauthenticated VMs for now. 
There would be further UAPI facilities to set the authentication type.

> 
>> +                0, 0, dtb_offset, ghvm->dtb_config.size);
>> +    if (ret) {
>> +        pr_warn("Failed to configureVM: %d\n", ret);
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
>> +        pr_warn("Failed to start VM:%d\n", ret);
>> +        goto err;
>> +    }
>> +
>> +    ghvm->vm_status = GH_RM_VM_STATUS_RUNNING;
>> +    up_write(&ghvm->status_lock);
>> +    return ret;
>> +err:
>> +    ghvm->vm_status = GH_RM_VM_STATUS_INIT_FAILED;
>> +    up_write(&ghvm->status_lock);
> 
> Am really not sure if we are doing right thing in the error path, there 
> are multiple cases that seems to be not handled or if it was not 
> required no comments to clarify this are documented.
> ex: if vm start fails then what happes with memory mapping or do we need 
> to un-configure vm or un-init vm from hypervisor side?
> 
> if none of this is required its useful to add come clear comments.
> 

It is required and done in the VM cleanup path. I'll add comment with 
this info.

>> +    return ret;
>> +}
>> +
>> +static int gh_vm_ensure_started(struct gh_vm *ghvm)
>> +{
>> +    int ret;
>> +
>> +retry:
>> +    ret = down_read_interruptible(&ghvm->status_lock);
>> +    if (ret)
>> +        return ret;
>> +
>> +    /* Unlikely because VM is typically started */
>> +    if (unlikely(ghvm->vm_status == GH_RM_VM_STATUS_LOAD)) {
>> +        up_read(&ghvm->status_lock);
>> +        ret = gh_vm_start(ghvm);
>> +        if (ret)
>> +            gotoout;
>> +        goto retry;
>> +    }
> 
> do while will do better job here w.r.t to readablity.
> 

I think do while and my current "goto retry" imply a long loop is 
possible. The "goto retry" or while loop is guaranteed to run only once 
because gh_vm_start will always bring VM out of GH_RM_VM_STATUS_LOAD.

How about this?

-               goto retry;
+               /** gh_vm_start() is guaranteed to bring status out of
+                * GH_RM_VM_STATUS_LOAD, thus inifitely recursive call 
is not
+                * possible
+                */
+               return gh_vm_ensure_started(ghvm);



>> +
>> +    /* Unlikely because VM is typically running */
>> +    if (unlikely(ghvm->vm_status != GH_RM_VM_STATUS_RUNNING))
>> +        ret = -ENODEV;
>> +
>> +out:
>> +    up_read(&ghvm->status_lock);
>> +    return ret;
>> +}
>> +
>>   static long gh_vm_ioctl(struct file *filp, unsigned int cmd, 
>> unsigned long arg)
>>   {
>>       struct gh_vm *ghvm = filp->private_data;
>> @@ -88,6 +275,22 @@ static long gh_vm_ioctl(struct file *filp, 
>> unsigned int cmd, unsigned long arg)
>>               r = gh_vm_mem_free(ghvm, region.label);
>>           break;
>>       }
>> +    case GH_VM_SET_DTB_CONFIG: {
>> +        struct gh_vm_dtb_config dtb_config;
>> +
>> +        if (copy_from_user(&dtb_config, argp, sizeof(dtb_config)))
>> +            return -EFAULT;
>> +
>> +        dtb_config.size = PAGE_ALIGN(dtb_config.size);
>> +        ghvm->dtb_config = dtb_config;
>> +
>> +        r = 0;
>> +        break;
>> +    }
>> +    case GH_VM_START: {
>> +        r = gh_vm_ensure_started(ghvm);
>> +        break;
>> +    }
>>       default:
>>           r = -ENOTTY;
>>           break;
>> diff --git a/drivers/virt/gunyah/vm_mgr.h b/drivers/virt/gunyah/vm_mgr.h
>> index 97bc00c34878..e9cf56647cc2 100644
>> --- a/drivers/virt/gunyah/vm_mgr.h
>> +++ b/drivers/virt/gunyah/vm_mgr.h
>> @@ -10,6 +10,8 @@
>>   #include <linux/list.h>
>>   #include <linux/miscdevice.h>
>>   #include <linux/mutex.h>
>> +#include <linux/rwsem.h>
>> +#include <linux/wait.h>
>>   #include <uapi/linux/gunyah.h>
>> @@ -33,6 +35,13 @@ struct gh_vm_mem {
>>   struct gh_vm {
>>       u16 vmid;
>>       struct gh_rm *rm;
>> +    enum gh_rm_vm_auth_mechanism auth;
>> +    struct gh_vm_dtb_config dtb_config;
>> +
>> +    struct notifier_block nb;
>> +    enum gh_rm_vm_status vm_status;
>> +    wait_queue_head_t vm_status_wait;
>> +    struct rw_semaphore status_lock;
>>       struct work_struct free_work;
>>       struct mutex mm_lock;
>> @@ -43,5 +52,6 @@ int gh_vm_mem_alloc(struct gh_vm *ghvm, struct 
>> gh_userspace_memory_region *regio
>>   void gh_vm_mem_reclaim(struct gh_vm *ghvm, struct gh_vm_mem *mapping);
>>   int gh_vm_mem_free(struct gh_vm *ghvm, u32 label);
>>   struct gh_vm_mem *gh_vm_mem_find(struct gh_vm *ghvm, u32 label);
>> +struct gh_vm_mem *gh_vm_mem_find_mapping(struct gh_vm *ghvm, u64 gpa, 
>> u32 size);
>>   #endif
>> diff --git a/drivers/virt/gunyah/vm_mgr_mm.c 
>> b/drivers/virt/gunyah/vm_mgr_mm.c
>> index 03e71a36ea3b..128b90da555a 100644
>> --- a/drivers/virt/gunyah/vm_mgr_mm.c
>> +++ b/drivers/virt/gunyah/vm_mgr_mm.c
>> @@ -52,6 +52,29 @@ void gh_vm_mem_reclaim(struct gh_vm *ghvm, struct 
>> gh_vm_mem *mapping)
>>       list_del(&mapping->list);
>>   }
>> +struct gh_vm_mem *gh_vm_mem_find_mapping(struct gh_vm *ghvm, u64 gpa, 
>> u32 size)
> naming is bit missleading we already have
> gh_vm_mem_find/__gh_vm_mem_find which is returning mapping based on label
> now with gh_vm_mem_find_mapping() is doing same thing but with address.
> 
> Can we rename them clearly
> gh_vm_mem_find_mapping_by_label()
> gh_vm_mem_find_mapping_by_addr()
> 

Done.

- Elliot
