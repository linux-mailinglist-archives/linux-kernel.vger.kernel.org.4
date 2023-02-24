Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5D0C6A252C
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Feb 2023 00:45:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbjBXXpA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 18:45:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjBXXo7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 18:44:59 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8DC439CF7;
        Fri, 24 Feb 2023 15:44:55 -0800 (PST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31OLS0KR009914;
        Fri, 24 Feb 2023 23:44:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : from : subject : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=LyAFSt8ovm7kNNn40sLG7l2+9PseoG3munN0NNC+q98=;
 b=DWSt7nnjKCf9jZ4NFvyC/alEJQznMk61Znc8vSckgmW+CEJgA6bBNrBYBZUggTF8PsUT
 TylqABiyV9c0RySSLAPdPgEiAtA7jy3JdRTilAW+cR+ctrslKrY4JUyVrXOdKZVusph0
 QJ/rIOKHD+2ZO7J0lWcd8ZseiKWNOLhVAiO4aFtWl19dFYZP5LYR1Cjg+x8W6nXlo5fb
 H7mRn+16vJneqCZSNkH+G7yNkH7Py9g2qJBwyPCFABFUfVRAr813OxO/R5cXtmho9V+i
 mW1217qkhBFwxn8PMtKA49mJqh3LzvemY/ZyaHCw+5xJiGoDZtkueXYoGhF/eaVdkx3o og== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nxwb7sp6m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Feb 2023 23:44:31 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31ONiVdD013327
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Feb 2023 23:44:31 GMT
Received: from [10.110.9.108] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 24 Feb
 2023 15:44:29 -0800
Message-ID: <87a34969-5c19-6a2d-e708-399411823c0b@quicinc.com>
Date:   Fri, 24 Feb 2023 15:44:29 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
From:   Elliot Berman <quic_eberman@quicinc.com>
Subject: Re: [PATCH v10 19/26] gunyah: vm_mgr: Add framework to add VM
 Functions
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Alex Elder <elder@linaro.org>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
        Jonathan Corbet <corbet@lwn.net>
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
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20230214211229.3239350-1-quic_eberman@quicinc.com>
 <20230214212531.3323284-1-quic_eberman@quicinc.com>
 <2cd83439-8518-f2a1-42b5-c5936f3e4548@linaro.org>
Content-Language: en-US
In-Reply-To: <2cd83439-8518-f2a1-42b5-c5936f3e4548@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: VyzzYgdLyTCCFPhmlNeYQXGgPCCgH9-d
X-Proofpoint-ORIG-GUID: VyzzYgdLyTCCFPhmlNeYQXGgPCCgH9-d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-24_17,2023-02-24_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 clxscore=1015
 priorityscore=1501 mlxscore=0 spamscore=0 bulkscore=0 adultscore=0
 impostorscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2302240192
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/22/2023 6:08 AM, Srinivas Kandagatla wrote:
> 
> 
> On 14/02/2023 21:25, Elliot Berman wrote:
>>
>> Introduce a framework for Gunyah userspace to install VM functions. VM
>> functions are optional interfaces to the virtual machine. vCPUs,
>> ioeventfs, and irqfds are examples of such VM functions and are
>> implemented in subsequent patches.
>>
>> A generic framework is implemented instead of individual ioctls to
>> create vCPUs, irqfds, etc., in order to simplify the VM manager core
>> implementation and allow dynamic loading of VM function modules.
>>
>> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
>> ---
>>   Documentation/virt/gunyah/vm-manager.rst |  18 ++
>>   drivers/virt/gunyah/vm_mgr.c             | 240 ++++++++++++++++++++++-
>>   drivers/virt/gunyah/vm_mgr.h             |   3 +
>>   include/linux/gunyah_vm_mgr.h            |  80 ++++++++
>>   include/uapi/linux/gunyah.h              |  17 ++
>>   5 files changed, 353 insertions(+), 5 deletions(-)
>>   create mode 100644 include/linux/gunyah_vm_mgr.h
>>
>> diff --git a/Documentation/virt/gunyah/vm-manager.rst 
>> b/Documentation/virt/gunyah/vm-manager.rst
>> index c0126cfeadc7..5272a6e9145c 100644
>> --- a/Documentation/virt/gunyah/vm-manager.rst
>> +++ b/Documentation/virt/gunyah/vm-manager.rst
>> @@ -17,6 +17,24 @@ sharing userspace memory with a VM is done via the 
>> GH_VM_SET_USER_MEM_REGION
>>   ioctl. The VM itself is configured to use the memory region via the
>>   devicetree.
>> +Gunyah Functions
>> +================
>> +
>> +Components of a Gunyah VM's configuration that need kernel 
>> configuration are
>> +called "functions" and are built on top of a framework. Functions are 
>> identified
>> +by a string and have some argument(s) to configure them. They are 
>> typically
>> +created by the `GH_VM_ADD_FUNCTION` ioctl.
>> +
>> +Functions typically will always do at least one of these operations:
>> +
>> +1. Create resource ticket(s). Resource tickets allow a function to 
>> register
>> +   itself as the client for a Gunyah resource (e.g. doorbell or vCPU) 
>> and
>> +   the function is given the pointer to the `struct gunyah_resource` 
>> when the
>> +   VM is starting.
>> +
>> +2. Register IO handler(s). IO handlers allow a function to handle 
>> stage-2 faults
>> +   from the virtual machine.
>> +
>>   Sample Userspace VMM
>>   ====================
>> diff --git a/drivers/virt/gunyah/vm_mgr.c b/drivers/virt/gunyah/vm_mgr.c
>> index fa324385ade5..e9c55e7dd1b3 100644
>> --- a/drivers/virt/gunyah/vm_mgr.c
>> +++ b/drivers/virt/gunyah/vm_mgr.c
>> @@ -6,8 +6,10 @@
>>   #define pr_fmt(fmt) "gh_vm_mgr: " fmt
>>   #include <linux/anon_inodes.h>
>> +#include <linux/compat.h>
>>   #include <linux/file.h>
>>   #include <linux/gunyah_rsc_mgr.h>
>> +#include <linux/gunyah_vm_mgr.h>
>>   #include <linux/miscdevice.h>
>>   #include <linux/mm.h>
>>   #include <linux/module.h>
>> @@ -16,6 +18,177 @@
>>   #include "vm_mgr.h"
>> +static DEFINE_MUTEX(functions_lock);
>> +static DEFINE_IDR(functions);
> Why are these global? Can these be not part of struc gh_rm?

If I make the list part of gh_rm, the core gunyah framework would need 
to know and be dependent on all possible VM functions. This prevents 
CONFIG_GUNYAH=y and CONFIG_GUNYAH_IRQFD=m (or any other function from 
being enabled as a module). I also see a 2-way dependency when enabled 
all enabled as modules. This approach seems vastly simpler.

> Not to mention please move idr to xarrays.
> 

Done.

>> +
>> +int gh_vm_function_register(struct gh_vm_function *drv)
>> +{
>> +    int ret = 0;
>> +
>> +    if (!drv->bind || !drv->unbind)
>> +        return -EINVAL;
>> +
>> +    mutex_lock(&functions_lock);
>> +    if (idr_find(&functions, drv->type)) {
>> +        ret = -EEXIST;
>> +        goto out;
>> +    }
>> +
>> +    INIT_LIST_HEAD(&drv->instances);
>> +    ret = idr_alloc(&functions, drv, drv->type, drv->type + 1, 
>> GFP_KERNEL);
>> +    if (ret > 0)
>> +        ret = 0;
>> +out:
>> +    mutex_unlock(&functions_lock);
>> +    return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(gh_vm_function_register);
>> +
>> +static void gh_vm_remove_function_instance(struct 
>> gh_vm_function_instance *inst)
>> +    __must_hold(functions_lock)
>> +{
>> +    inst->fn->unbind(inst);
>> +    list_del(&inst->vm_list);
>> +    list_del(&inst->fn_list);
>> +    module_put(inst->fn->mod);
>> +    if (inst->arg_size)
>> +        kfree(inst->argp);
>> +    kfree(inst);
>> +}
>> +
>> +void gh_vm_function_unregister(struct gh_vm_function *fn)
>> +{
>> +    struct gh_vm_function_instance *inst, *iter;
>> +
>> +    mutex_lock(&functions_lock);
>> +    list_for_each_entry_safe(inst, iter, &fn->instances,fn_list)
>> +        gh_vm_remove_function_instance(inst);
> 
> We should never have any instances as we have refcounted the module.
> 
> If there are any instances then its clearly a bug, as this will pull out 
> function under the hood while userspace is using it.
> 
> 

Done.

>> +    idr_remove(&functions, fn->type);
>> +    mutex_unlock(&functions_lock);
>> +}
>> +EXPORT_SYMBOL_GPL(gh_vm_function_unregister);
>> +
>> +static long gh_vm_add_function(struct gh_vm *ghvm, struct gh_fn_desc *f)
>> +{
>> +    struct gh_vm_function_instance *inst;
>> +    void __user *argp;
>> +    long r = 0;
>> +
>> +    if (f->arg_size > GH_FN_MAX_ARG_SIZE)
> 
> lets print some useful error message to user.
> 
>> +        return -EINVAL;
>> +
>> +    inst = kzalloc(sizeof(*inst), GFP_KERNEL);
>> +    if (!inst)
>> +        return -ENOMEM;
>> +
>> +    inst->arg_size = f->arg_size;
>> +    if (inst->arg_size) {
>> +        inst->argp = kzalloc(inst->arg_size, GFP_KERNEL);
>> +        if (!inst->arg) {
>> +            r = -ENOMEM;
>> +            gotofree;
>> +        }
>> +
>> +        argp = is_compat_task() ? compat_ptr(f->arg) : (void __user 
>> *) f->arg;
> 
> hmm, arg is not a data pointer it is a fixed size variable (__u64 arg), 
> so why are using compat_ptr() here?
> 
> you should be able to do
> 
> argp = u64_to_user_ptr(f->arg);
> 

Done.

>> +        if (copy_from_user(inst->argp, argp, f->arg_size)) {
>> +            r = -EFAULT;
>> +            gotofree_arg;
>> +        }
>> +    } else {
>> +        inst->arg = f->arg;
> bit lost here, so, we treat the arg as both pointer and value in cases 
> where size is zero.
> 

That's correct -- arg is value in cases where size is zero. It might be 
a bit too strange, and I'm not opposed to always treating arg as pointer 
when size >= 0 and none of the "arg is value". In vCPU and several other 
possible functions we have (presently) downstream, the only argument a 
only a 32-bit integer label. I thought it would be good to optimize this 
path.

>> +    }
>> +
> <---
>> +    mutex_lock(&functions_lock);
>> +    inst->fn = idr_find(&functions, f->type);
>> +    if (!inst->fn) {
>> +        mutex_unlock(&functions_lock);
>> +        r = request_module("ghfunc:%d", f->type);
>> +        if (r)
>> +            gotounlock_free;
>> +
>> +        mutex_lock(&functions_lock);
>> +        inst->fn = idr_find(&functions, f->type);
>> +    }
>> +
>> +    if (!inst->fn) {
>> +        r = -ENOENT;
>> +        goto unlock_free;
>> +    }
>> +
>> +    if (!try_module_get(inst->fn->mod)) {
>> +        r = -ENOENT;
>> +        inst->fn = NULL;
>> +        goto unlock_free;
>> +    }
>> +
> --->
> can we do this snippet as a gh_vm_get_function() and corresponding 
> gh_vm_put_function(). that should make the code more cleaner.
> 

Done.

> 
>> +    inst->ghvm = ghvm;
>> +    inst->rm = ghvm->rm;
>> +
>> +    r = inst->fn->bind(inst);
>> +    if (r < 0) {
>> +        module_put(inst->fn->mod);
>> +        goto unlock_free;
>> +    }
>> +
>> +    list_add(&inst->vm_list, &ghvm->functions);
> 
> I guess its possible to add same functions with same argumentso to this 
> list, how are we preventing this to happen?
> 
> Is it a valid usecase?
> 

I'm not able to think of a function where this is valid. This is handled 
today because the ->bind() callback returns an error. This happens if 
the resource ticket was already created, e.g. same vCPU is requested twice.

This should be handled at function level because two arguments could be 
different but request the same resource. For instance, two 
GH_VM_ADD_FUNCTION to create irqfd with same doorbell. One call is with 
LEVEL flag and the other doesn't have the flag set. Only once we try to 
register the doorbell resource ticket do we realize that 2nd 
GH_VM_ADD_FUNCTION should fail.

>> +    list_add(&inst->fn_list, &inst->fn->instances);
>> +    mutex_unlock(&functions_lock);
>> +    return r;
>> +unlock_free:
>> +    mutex_unlock(&functions_lock);
>> +free_arg:
>> +    if (inst->arg_size)
>> +        kfree(inst->argp);
>> +free:
>> +    kfree(inst);
>> +    return r;
>> +}
>> +
>> +static long gh_vm_rm_function(struct gh_vm *ghvm, struct gh_fn_desc *f)
>> +{
>> +    struct gh_vm_function_instance *inst, *iter;
>> +    void __user *user_argp;
>> +    void *argp;
>> +    long r = 0;
>> +
>> +    r = mutex_lock_interruptible(&functions_lock);
>> +    if (r)
>> +        return r;
>> +
>> +    if (f->arg_size) {
>> +        argp = kzalloc(f->arg_size, GFP_KERNEL);
>> +        if (!argp) {
>> +            r = -ENOMEM;
>> +            gotoout;
>> +        }
>> +
>> +        user_argp = is_compat_task() ? compat_ptr(f->arg) : (void 
>> __user *) f->arg;
> 
> same comment as add;
> 
>> +        if (copy_from_user(argp, user_argp, f->arg_size)) {
>> +            r = -EFAULT;
>> +            kfree(argp);
>> +            gotoout;
>> +        }
>> +
>> +        list_for_each_entry_safe(inst, iter, &ghvm->functions, 
>> vm_list) {
>> +            if (inst->fn->type == f->type &&
>> +                f->arg_size == inst->arg_size &&
>> +                !memcmp(argp, inst->argp, f->arg_size))
>> +                gh_vm_remove_function_instance(inst);
>> +        }
> 
> leaking argp;
> 

Done.

>> +    } else {
>> +        list_for_each_entry_safe(inst, iter, &ghvm->functions, 
>> vm_list) {
>> +            if (inst->fn->type == f->type &&
>> +                f->arg_size == inst->arg_size &&
>> +                inst->arg == f->arg)
>> +                gh_vm_remove_function_instance(inst);
>> +        }
>> +    }
>> +
>> +out:
>> +    mutex_unlock(&functions_lock);
>> +    return r;
>> +}
>> +
>>   static int gh_vm_rm_notification_status(struct gh_vm *ghvm, void *data)
>>   {
>>       struct gh_rm_vm_status_payload *payload = data;
>> @@ -80,6 +253,7 @@ static void gh_vm_stop(struct gh_vm *ghvm)
>>   static void gh_vm_free(struct work_struct *work)
>>   {
>>       struct gh_vm *ghvm = container_of(work,struct gh_vm, free_work);
>> +    struct gh_vm_function_instance *inst, *iiter;
>>       struct gh_vm_mem *mapping, *tmp;
>>       int ret;
>> @@ -90,7 +264,13 @@ static void gh_vm_free(struct work_struct *work)
>>           fallthrough;
>>       case GH_RM_VM_STATUS_INIT_FAILED:
>>       case GH_RM_VM_STATUS_LOAD:
>> -    case GH_RM_VM_STATUS_LOAD_FAILED:
>> +    case GH_RM_VM_STATUS_EXITED:
>> +        mutex_lock(&functions_lock);
>> +        list_for_each_entry_safe(inst, iiter, &ghvm->functions, 
>> vm_list) {
>> +            gh_vm_remove_function_instance(inst);
>> +        }
>> +        mutex_unlock(&functions_lock);
>> +
>>           mutex_lock(&ghvm->mm_lock);
>>           list_for_each_entry_safe(mapping, tmp, 
>> &ghvm->memory_mappings, list) {
>>               gh_vm_mem_reclaim(ghvm, mapping);
>> @@ -113,6 +293,28 @@ static void gh_vm_free(struct work_struct *work)
>>       }
>>   }
>> +static void _gh_vm_put(struct kref *kref)
>> +{
>> +    struct gh_vm *ghvm = container_of(kref, struct gh_vm, kref);
>> +
>> +    /* VM will be reset and make RM calls which can interruptible sleep.
>> +     * Defer to a work so this thread can receive signal.
>> +     */
>> +    schedule_work(&ghvm->free_work);
>> +}
>> +
>> +int __must_check gh_vm_get(struct gh_vm *ghvm)
>> +{
>> +    return kref_get_unless_zero(&ghvm->kref);
>> +}
>> +EXPORT_SYMBOL_GPL(gh_vm_get);
>> +
>> +void gh_vm_put(struct gh_vm *ghvm)
>> +{
>> +    kref_put(&ghvm->kref, _gh_vm_put);
>> +}
>> +EXPORT_SYMBOL_GPL(gh_vm_put);
>> +
>>   static __must_check struct gh_vm *gh_vm_alloc(struct gh_rm *rm)
>>   {
>>       struct gh_vm *ghvm;
>> @@ -147,6 +349,8 @@ static __must_check struct gh_vm 
>> *gh_vm_alloc(struct gh_rm *rm)
>>       INIT_LIST_HEAD(&ghvm->memory_mappings);
>>       init_rwsem(&ghvm->status_lock);
>>       INIT_WORK(&ghvm->free_work, gh_vm_free);
>> +    kref_init(&ghvm->kref);
>> +    INIT_LIST_HEAD(&ghvm->functions);
>>       ghvm->vm_status = GH_RM_VM_STATUS_LOAD;
>>       return ghvm;
>> @@ -291,6 +495,35 @@ static long gh_vm_ioctl(struct file *filp, 
>> unsigned int cmd, unsigned long arg)
>>           r = gh_vm_ensure_started(ghvm);
>>           break;
>>       }
>> +    case GH_VM_ADD_FUNCTION: {
>> +        struct gh_fn_desc *f;
>> +
>> +        f = kzalloc(sizeof(*f), GFP_KERNEL);
>> +        if (!f)
>> +            return -ENOMEM;
>> +
>> +        if (copy_from_user(f, argp, sizeof(*f)))
>> +            return -EFAULT;
>> +
>> +        r = gh_vm_add_function(ghvm, f);
>> +        if (r < 0)
>> +            kfree(f);
> 
> 
> we are memory leaking f here, we should free it irrespective of return 
> value. or I see no reason not to use this small struct from stack.
> 

I can copy to stack directly.

> 
>> +        break;
>> +    }
>> +    case GH_VM_REMOVE_FUNCTION: {
>> +        struct gh_fn_desc *f;
>> +
>> +        f = kzalloc(sizeof(*f), GFP_KERNEL);
>> +        if (!f)
>> +            return -ENOMEM;
>> +
>> +        if (copy_from_user(f, argp, sizeof(*f)))
>> +            return -EFAULT;
>> +
>> +        r = gh_vm_rm_function(ghvm, f);
>> +        kfree(f);
>> +        break;
>> +    }
>>       default:
>>           r = -ENOTTY;
>>           break;
>> @@ -303,10 +536,7 @@ static int gh_vm_release(struct inode *inode, 
>> struct file *filp)
>>   {
>>       struct gh_vm *ghvm = filp->private_data;
>> -    /* VM will be reset and make RM calls which can interruptible sleep.
>> -     * Defer to a work so this thread can receive signal.
>> -     */
>> -    schedule_work(&ghvm->free_work);
>> +    gh_vm_put(ghvm);
>>       return 0;
>>   }
>> diff --git a/drivers/virt/gunyah/vm_mgr.h b/drivers/virt/gunyah/vm_mgr.h
>> index e9cf56647cc2..4750d56c1297 100644
>> --- a/drivers/virt/gunyah/vm_mgr.h
>> +++ b/drivers/virt/gunyah/vm_mgr.h
>> @@ -8,6 +8,7 @@
>>   #include <linux/gunyah_rsc_mgr.h>
>>   #include <linux/list.h>
>> +#include <linux/kref.h>
>>   #include <linux/miscdevice.h>
>>   #include <linux/mutex.h>
>>   #include <linux/rwsem.h>
>> @@ -44,8 +45,10 @@ struct gh_vm {
>>       struct rw_semaphore status_lock;
>>       struct work_struct free_work;
>> +    struct kref kref;
>>       struct mutex mm_lock;
>>       struct list_head memory_mappings;
>> +    struct list_head functions;
>>   };
>>   int gh_vm_mem_alloc(struct gh_vm *ghvm, struct 
>> gh_userspace_memory_region *region);
>> diff --git a/include/linux/gunyah_vm_mgr.h 
>> b/include/linux/gunyah_vm_mgr.h
>> new file mode 100644
>> index 000000000000..f0a95af50b2e
>> --- /dev/null
>> +++ b/include/linux/gunyah_vm_mgr.h
>> @@ -0,0 +1,80 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +/*
>> + * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All 
>> rights reserved.
>> + */
>> +
>> +#ifndef _GUNYAH_VM_MGR_H
>> +#define _GUNYAH_VM_MGR_H
>> +
>> +#include <linux/compiler_types.h>
>> +#include <linux/gunyah.h>
>> +#include <linux/gunyah_rsc_mgr.h>
>> +#include <linux/list.h>
>> +#include <linux/mod_devicetable.h>
> ??
> 
>> +#include <linux/notifier.h>
> 
> ??
> 
>> +
>> +#include <uapi/linux/gunyah.h>
>> +
>> +struct gh_vm;
>> +
>> +int __must_check gh_vm_get(struct gh_vm *ghvm);
>> +void gh_vm_put(struct gh_vm *ghvm);
>> +
>> +struct gh_vm_function_instance;
>> +struct gh_vm_function {
>> +    u32 type; > +    const char *name;
>> +    struct module *mod;
>> +    long (*bind)(struct gh_vm_function_instance *f);
>> +    void (*unbind)(struct gh_vm_function_instance *f);
>> +    struct mutex instances_lock;
>> +    struct list_head instances;
>> +};
>> +
>> +/**
>> + * struct gh_vm_function_instance - Represents one function instance
>> + * @arg_size: size of user argument
>> + * @arg: user argument to describe the function instance; arg_size is 0
>> + * @argp: pointer to user argument
>> + * @ghvm: Pointer to VM instance
>> + * @rm: Pointer to resource manager for the VM instance
>> + * @fn: The ops for the function
>> + * @data: Private data for function
>> + * @vm_list: for gh_vm's functions list
>> + * @fn_list: for gh_vm_function's instances list
>> + */
>> +struct gh_vm_function_instance {
>> +    size_t arg_size;
>> +    union {
>> +        u64 arg;
>> +        void *argp;
>> +    };
>> +    struct gh_vm *ghvm;
>> +    struct gh_rm *rm;
>> +    struct gh_vm_function *fn;
>> +    void *data;
>> +    struct list_head vm_list;
>> +    struct list_head fn_list;
> Am not seeing any advantage of storing the instance in two different 
> list, they look redundant to me. storing the function instances in vm 
> should be good IMO.
> 

I was concerned about removal of function outside of module_removal, but 
we don't have reason/ability to do it.

> 
>> +};
>> +
>> +int gh_vm_function_register(struct gh_vm_function *f);
>> +void gh_vm_function_unregister(struct gh_vm_function *f);
>> +
>> +#define DECLARE_GUNYAH_VM_FUNCTION(_name, _type, _bind, _unbind)    \
>> +    static struct gh_vm_function _name = {        \
>> +        .type = _type,                        \
>> +        .name = __stringify(_name),                \
>> +        .mod = THIS_MODULE,                    \
>> +        .bind = _bind,                        \
>> +        .unbind = _unbind,                    \
>> +    };                                \
>> +    MODULE_ALIAS("ghfunc:"__stringify(_type))
>> +
>> +#define module_gunyah_vm_function(__gf)                    \
>> +    module_driver(__gf, gh_vm_function_register, 
>> gh_vm_function_unregister)
>> +
>> +#define DECLARE_GUNYAH_VM_FUNCTION_INIT(_name, _type, _bind, 
>> _unbind)    \
>> +    DECLARE_GUNYAH_VM_FUNCTION(_name, _type, _bind, _unbind);    \
>> +    module_gunyah_vm_function(_name)
>> +
>> +#endif
>> diff --git a/include/uapi/linux/gunyah.h b/include/uapi/linux/gunyah.h
>> index d899bba6a4c6..8df455a2a293 100644
>> --- a/include/uapi/linux/gunyah.h
>> +++ b/include/uapi/linux/gunyah.h
>> @@ -66,4 +66,21 @@ struct gh_vm_dtb_config {
>>   #define GH_VM_START        _IO(GH_IOCTL_TYPE, 0x3)
>> +#define GH_FN_MAX_ARG_SIZE        256
>> +
>> +/**
>> + * struct gh_fn_desc - Arguments to create a VM function
>> + * @type: Type of the function. See GH_FN_* macro for supported types
>> + * @arg_size: Size of argument to pass to the function
> 
> a note on max arg size  of 256 bytes would be useful.
> 
>> + * @arg: Value or pointer to argument given to the function
> 
> Treating this as value when arg_size == 0 is really confusing abi.
> how about just use as arg as ptr to data along with arg_size;
> 
> --srini
>> + */
>> +struct gh_fn_desc {
>> +    __u32 type;
>> +    __u32 arg_size;
>> +    __u64 arg;
>> +};
>> +
>> +#define GH_VM_ADD_FUNCTION    _IOW(GH_IOCTL_TYPE, 0x4, struct 
>> gh_fn_desc)
>> +#define GH_VM_REMOVE_FUNCTION    _IOW(GH_IOCTL_TYPE, 0x7, struct 
>> gh_fn_desc)
> 
> Do you have an example of how add and rm ioctls are used w.r.t to arg, i 
> see that we check correcteness of arg in between add and remove.
> 
> --srini
>> +
>>   #endif
