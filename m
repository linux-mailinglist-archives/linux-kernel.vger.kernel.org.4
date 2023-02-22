Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C80E69EBF5
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 01:28:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbjBVA2C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 19:28:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjBVA2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 19:28:00 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E195A4;
        Tue, 21 Feb 2023 16:27:48 -0800 (PST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31M0RS5p002955;
        Wed, 22 Feb 2023 00:27:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=206/ENTYhpd8cRg/HRQOtIZa/mKOhxRJ+u795kVpeiQ=;
 b=Zr27zCvg8JKYoGzW/fp+UXjF1KxAcQFNI0YlIbtRm3v+ZPyHrYacO4JWRx/rrm1dJLnw
 DgKNByMMl7KpTZTe/w9nJuZB9EIiZ5ru61nn3KpMPH7WzUJMcSjTqmyqBPN5WrwtTJXX
 MjsOa3Bm6Jj3NNkqur1zeVqa123VbKZH1vpn3t8i/C5Vz0NNGGeKHoHJpbNJa1Fw69Nn
 m+PA2loU9kDGSS3/SX6BS+4MbLEc2+UEGGLrAgkPF4D0RVlMSQDDn5iS82bGZAbXJ/h/
 VZLvo+x1KzHC3SUlHC89jwdGlEfaFNIVk6Yv2hkxOQKsY98hJuNqvj2buL2vQH4yyNjf AQ== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nw8gnr02j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Feb 2023 00:27:28 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31M0RRoN025909
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Feb 2023 00:27:27 GMT
Received: from [10.110.71.80] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 21 Feb
 2023 16:27:26 -0800
Message-ID: <05c4aab8-2d26-b944-adb6-624d67e4a11d@quicinc.com>
Date:   Tue, 21 Feb 2023 16:27:25 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v10 10/26] gunyah: vm_mgr: Introduce basic VM Manager
Content-Language: en-US
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Alex Elder <elder@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
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
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20230214211229.3239350-1-quic_eberman@quicinc.com>
 <20230214212356.3313181-1-quic_eberman@quicinc.com>
 <dbcfa4e9-a1ad-0f24-77bf-05934ca26bb2@linaro.org>
From:   Elliot Berman <quic_eberman@quicinc.com>
In-Reply-To: <dbcfa4e9-a1ad-0f24-77bf-05934ca26bb2@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: HKKGuBqppjiiOzIkNHkllqlyyIafk3Jn
X-Proofpoint-GUID: HKKGuBqppjiiOzIkNHkllqlyyIafk3Jn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-21_13,2023-02-20_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 adultscore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0 phishscore=0
 suspectscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302220000
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/21/2023 2:46 AM, Srinivas Kandagatla wrote:
> 
> 
> On 14/02/2023 21:23, Elliot Berman wrote:
>>
>> Gunyah VM manager is a kernel moduel which exposes an interface to
>> Gunyah userspace to load, run, and interact with other Gunyah virtual
>> machines. The interface is a character device at /dev/gunyah.
>>
>> Add a basic VM manager driver. Upcoming patches will add more ioctls
>> into this driver.
>>
>> Co-developed-by: Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>
>> Signed-off-by: Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>
>> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
>> ---
>>   .../userspace-api/ioctl/ioctl-number.rst      |   1 +
>>   drivers/virt/gunyah/Makefile                  |   2 +-
>>   drivers/virt/gunyah/rsc_mgr.c                 |  37 +++++-
>>   drivers/virt/gunyah/vm_mgr.c                  | 118 ++++++++++++++++++
>>   drivers/virt/gunyah/vm_mgr.h                  |  22 ++++
>>   include/uapi/linux/gunyah.h                   |  23 ++++
>>   6 files changed, 201 insertions(+), 2 deletions(-)
>>   create mode 100644 drivers/virt/gunyah/vm_mgr.c
>>   create mode 100644 drivers/virt/gunyah/vm_mgr.h
>>   create mode 100644 include/uapi/linux/gunyah.h
>>
>> diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst 
>> b/Documentation/userspace-api/ioctl/ioctl-number.rst
>> index 0a1882e296ae..2513324ae7be 100644
>> --- a/Documentation/userspace-api/ioctl/ioctl-number.rst
>> +++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
>> @@ -137,6 +137,7 @@ Code  Seq#    Include 
>> File                                           Comments
>>   'F'   DD     video/sstfb.h                                           
>> conflict!
>>   'G'   00-3F  drivers/misc/sgi-gru/grulib.h                           
>> conflict!
>>   'G'   00-0F  xen/gntalloc.h, xen/gntdev.h                            
>> conflict!
>> +'G'   00-0f  linux/gunyah.h                                          
>> conflict!
>>   'H'   00-7F  linux/hiddev.h                                          
>> conflict!
>>   'H'   00-0F  linux/hidraw.h                                          
>> conflict!
>>   'H'   01     linux/mei.h                                             
>> conflict!
>> diff --git a/drivers/virt/gunyah/Makefile b/drivers/virt/gunyah/Makefile
>> index de29769f2f3f..03951cf82023 100644
>> --- a/drivers/virt/gunyah/Makefile
>> +++ b/drivers/virt/gunyah/Makefile
>> @@ -2,5 +2,5 @@
>>   obj-$(CONFIG_GUNYAH) += gunyah.o
>> -gunyah_rsc_mgr-y += rsc_mgr.o rsc_mgr_rpc.o
>> +gunyah_rsc_mgr-y += rsc_mgr.o rsc_mgr_rpc.o vm_mgr.o
>>   obj-$(CONFIG_GUNYAH) += gunyah_rsc_mgr.o
>> diff --git a/drivers/virt/gunyah/rsc_mgr.c 
>> b/drivers/virt/gunyah/rsc_mgr.c
>> index 2a47139873a8..73c5a6b7cbbc 100644
>> --- a/drivers/virt/gunyah/rsc_mgr.c
>> +++ b/drivers/virt/gunyah/rsc_mgr.c
>> @@ -16,8 +16,10 @@
>>   #include <linux/completion.h>
>>   #include <linux/gunyah_rsc_mgr.h>
>>   #include <linux/platform_device.h>
>> +#include <linux/miscdevice.h>
>>   #include "rsc_mgr.h"
>> +#include "vm_mgr.h"
>>   #define RM_RPC_API_VERSION_MASK        GENMASK(3, 0)
>>   #define RM_RPC_HEADER_WORDS_MASK    GENMASK(7, 4)
>> @@ -103,6 +105,8 @@ struct gh_rm {
>>       struct kmem_cache *cache;
>>       struct mutex send_lock;
>>       struct blocking_notifier_head nh;
>> +
>> +    struct miscdevice miscdev;
>>   };
>>   static struct gh_rm_connection *gh_rm_alloc_connection(__le32 
>> msg_id, u8 type)
>> @@ -509,6 +513,21 @@ void put_gh_rm(struct gh_rm *rm)
>>   }
>>   EXPORT_SYMBOL_GPL(put_gh_rm);
>> +static long gh_dev_ioctl(struct file *filp, unsigned int cmd, 
>> unsigned long arg)
>> +{
>> +    struct miscdevice *miscdev = filp->private_data;
>> +    struct gh_rm *rm = container_of(miscdev, struct gh_rm, miscdev);
>> +
>> +    return gh_dev_vm_mgr_ioctl(rm, cmd, arg);
>> +}
>> +
>> +static const struct file_operations gh_dev_fops = {
>> +    .owner        = THIS_MODULE,
>> +    .unlocked_ioctl    = gh_dev_ioctl,
>> +    .compat_ioctl    = compat_ptr_ioctl,
>> +    .llseek        = noop_llseek,
>> +};
>> +
>>   static int gh_msgq_platform_probe_direction(struct platform_device 
>> *pdev,
>>                       bool tx, int idx, struct gunyah_resource *ghrsc)
>>   {
>> @@ -567,7 +586,22 @@ static int gh_rm_drv_probe(struct platform_device 
>> *pdev)
>>       rm->msgq_client.rx_callback = gh_rm_msgq_rx_data;
>>       rm->msgq_client.tx_done = gh_rm_msgq_tx_done;
>> -    return gh_msgq_init(&pdev->dev, &rm->msgq, &rm->msgq_client, 
>> &rm->tx_ghrsc, &rm->rx_ghrsc);
>> +    ret = gh_msgq_init(&pdev->dev, &rm->msgq, &rm->msgq_client, 
>> &rm->tx_ghrsc, &rm->rx_ghrsc);
>> +    if (ret)
>> +        goto err_cache;
>> +
>> +    rm->miscdev.name = "gunyah";
>> +    rm->miscdev.minor = MISC_DYNAMIC_MINOR;
>> +    rm->miscdev.fops = &gh_dev_fops;
>> +
>> +    ret = misc_register(&rm->miscdev);
>> +    if (ret)
>> +        goto err_msgq;
>> +
>> +    return 0;
>> +err_msgq:
>> +    mbox_free_channel(gh_msgq_chan(&rm->msgq));
>> +    gh_msgq_remove(&rm->msgq);
>>   err_cache:
>>       kmem_cache_destroy(rm->cache);
>>       return ret;
>> @@ -577,6 +611,7 @@ static int gh_rm_drv_remove(struct platform_device 
>> *pdev)
>>   {
>>       struct gh_rm *rm = platform_get_drvdata(pdev);
>> +    misc_deregister(&rm->miscdev);
>>       mbox_free_channel(gh_msgq_chan(&rm->msgq));
>>       gh_msgq_remove(&rm->msgq);
>>       kmem_cache_destroy(rm->cache);
>> diff --git a/drivers/virt/gunyah/vm_mgr.c b/drivers/virt/gunyah/vm_mgr.c
>> new file mode 100644
>> index 000000000000..fd890a57172e
>> --- /dev/null
>> +++ b/drivers/virt/gunyah/vm_mgr.c
>> @@ -0,0 +1,118 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All 
>> rights reserved.
>> + */
>> +
>> +#define pr_fmt(fmt) "gh_vm_mgr: " fmt
>> +
>> +#include <linux/anon_inodes.h>
>> +#include <linux/file.h>
>> +#include <linux/gunyah_rsc_mgr.h>
>> +#include <linux/miscdevice.h>
>> +#include <linux/module.h>
>> +
>> +#include <uapi/linux/gunyah.h>
>> +
>> +#include "vm_mgr.h"
>> +
>> +static void gh_vm_free(struct work_struct *work)
>> +{
>> +    struct gh_vm *ghvm = container_of(work, struct gh_vm, free_work);
>> +    int ret;
>> +
>> +    ret = gh_rm_dealloc_vmid(ghvm->rm, ghvm->vmid);
>> +    if (ret)
>> +        pr_warn("Failed to deallocate vmid: %d\n", ret);
>> +
>> +    put_gh_rm(ghvm->rm);
>> +    kfree(ghvm);
>> +}
>> +
>> +static __must_check struct gh_vm *gh_vm_alloc(struct gh_rm *rm)
>> +{
>> +    struct gh_vm *ghvm;
>> +    int vmid;
>> +
>> +    vmid = gh_rm_alloc_vmid(rm, 0);
>> +    if (vmid < 0)
>> +        return ERR_PTR(vmid);
>> +
>> +    ghvm = kzalloc(sizeof(*ghvm), GFP_KERNEL);
>> +    if (!ghvm) {
>> +        gh_rm_dealloc_vmid(rm, vmid);
>> +        return ERR_PTR(-ENOMEM);
>> +    }
>> +
>> +    get_gh_rm(rm);
>> +
>> +    ghvm->vmid = vmid;
>> +    ghvm->rm = rm;
>> +
>> +    INIT_WORK(&ghvm->free_work, gh_vm_free);
>> +
>> +    return ghvm;
>> +}
>> +
>> +static int gh_vm_release(struct inode *inode, struct file *filp)
>> +{
>> +    struct gh_vm *ghvm = filp->private_data;
>> +
>> +    /* VM will be reset and make RM calls which can interruptible sleep.
>> +     * Defer to a work so this thread can receive signal.
>> +     */
>> +    schedule_work(&ghvm->free_work);
>> +    return 0;
>> +}
>> +
>> +static const struct file_operations gh_vm_fops = {
>> +    .release = gh_vm_release,
> 
>> +    .compat_ioctl    = compat_ptr_ioctl,
> 
> This line should go with the patch that adds real ioctl
> 

Done.

>> +    .llseek = noop_llseek,
>> +};
>> +
>> +static long gh_dev_ioctl_create_vm(struct gh_rm *rm, unsigned long arg)
> Not sure what is the gain of this multiple levels of redirection.
> 
> How about
> 
> long gh_dev_create_vm(struct gh_rm *rm, unsigned long arg)
> {
> ...
> }
> 
> and rsc_mgr just call it as part of its ioctl call
> 
> static long gh_dev_ioctl(struct file *filp, unsigned int cmd, unsigned 
> long arg)
> {
>      struct miscdevice *miscdev = filp->private_data;
>      struct gh_rm *rm = container_of(miscdev, struct gh_rm, miscdev);
> 
>      switch (cmd) {
>      case GH_CREATE_VM:
>          return gh_dev_create_vm(rm, arg);
>      default:
>          return -ENOIOCTLCMD;
>      }
> }
> 

I'm anticipating we will add further /dev/gunyah ioctls and I thought it 
would be cleaner to have all that in vm_mgr.c itself.

> 
>> +{
>> +    struct gh_vm *ghvm;
>> +    struct file *file;
>> +    int fd, err;
>> +
>> +    /* arg reserved for future use. */
>> +    if (arg)
>> +        return -EINVAL;
> 
> The only code path I see here is via GH_CREATE_VM ioctl which obviously 
> does not take any arguments, so if you are thinking of using the 
> argument for architecture-specific VM flags.  Then this needs to be 
> properly done by making the ABI aware of this.

It is documented in Patch 17 (Document Gunyah VM Manager)

+GH_CREATE_VM
+~~~~~~~~~~~~
+
+Creates a Gunyah VM. The argument is reserved for future use and must be 0.

> 
> As you mentioned zero value arg imply an "unauthenticated VM" type, but 
> this was not properly encoded in the userspace ABI. Why not make it 
> future compatible. How about adding arguments to GH_CREATE_VM and pass 
> the required information correctly.
> Note that once the ABI is accepted then you will not be able to change 
> it, other than adding a new one.
> 

Does this means adding #define GH_VM_DEFAULT_ARG 0 ? I am not sure yet 
what arguments to add here.

The ABI can add new "long" values to GH_CREATE_VM and that wouldn't 
break compatibility with old kernels; old kernels reject it as -EINVAL.

>> +
>> +    ghvm = gh_vm_alloc(rm);
>> +    if (IS_ERR(ghvm))
>> +        return PTR_ERR(ghvm);
>> +
>> +    fd = get_unused_fd_flags(O_CLOEXEC);
>> +    if (fd < 0) {
>> +        err = fd;
>> +        goto err_destroy_vm;
>> +    }
>> +
>> +    file = anon_inode_getfile("gunyah-vm", &gh_vm_fops, ghvm, O_RDWR);
>> +    if (IS_ERR(file)) {
>> +        err = PTR_ERR(file);
>> +        goto err_put_fd;
>> +    }
>> +
>> +    fd_install(fd, file);
>> +
>> +    return fd;
>> +
>> +err_put_fd:
>> +    put_unused_fd(fd);
>> +err_destroy_vm:
>> +    kfree(ghvm);
>> +    return err;
>> +}
>> +
>> +long gh_dev_vm_mgr_ioctl(struct gh_rm *rm, unsigned int cmd, unsigned 
>> long arg)
>> +{
>> +    switch (cmd) {
>> +    case GH_CREATE_VM:
>> +        return gh_dev_ioctl_create_vm(rm, arg);
>> +    default:
>> +        return -ENOIOCTLCMD;
>> +    }
>> +}
>> diff --git a/drivers/virt/gunyah/vm_mgr.h b/drivers/virt/gunyah/vm_mgr.h
>> new file mode 100644
>> index 000000000000..76954da706e9
>> --- /dev/null
>> +++ b/drivers/virt/gunyah/vm_mgr.h
>> @@ -0,0 +1,22 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +/*
>> + * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All 
>> rights reserved.
>> + */
>> +
>> +#ifndef _GH_PRIV_VM_MGR_H
>> +#define _GH_PRIV_VM_MGR_H
>> +
>> +#include <linux/gunyah_rsc_mgr.h>
>> +
>> +#include <uapi/linux/gunyah.h>
>> +
>> +long gh_dev_vm_mgr_ioctl(struct gh_rm *rm, unsigned int cmd, unsigned 
>> long arg);
>> +
>> +struct gh_vm {
>> +    u16 vmid;
>> +    struct gh_rm *rm;
>> +
>> +    struct work_struct free_work;
>> +};
>> +
>> +#endif
>> diff --git a/include/uapi/linux/gunyah.h b/include/uapi/linux/gunyah.h
>> new file mode 100644
>> index 000000000000..10ba32d2b0a6
>> --- /dev/null
>> +++ b/include/uapi/linux/gunyah.h
>> @@ -0,0 +1,23 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only WITH Linux-syscall-note */
>> +/*
>> + * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All 
>> rights reserved.
>> + */
>> +
>> +#ifndef _UAPI_LINUX_GUNYAH
>> +#define _UAPI_LINUX_GUNYAH
>> +
>> +/*
>> + * Userspace interface for /dev/gunyah - gunyah based virtual machine
>> + */
>> +
>> +#include <linux/types.h>
>> +#include <linux/ioctl.h>
>> +
>> +#define GH_IOCTL_TYPE            'G'
>> +
>> +/*
>> + * ioctls for /dev/gunyah fds:
>> + */
>> +#define GH_CREATE_VM            _IO(GH_IOCTL_TYPE, 0x0) /* Returns a 
>> Gunyah VM fd */
> 
> Can HLOS forcefully destroy a VM?
> If so should we have a corresponding DESTROY IOCTL?

It can forcefully destroy unauthenticated and protected virtual 
machines. I don't have a userspace usecase for a DESTROY ioctl yet, 
maybe this can be added later? By the way, the VM is forcefully 
destroyed when VM refcount is dropped to 0 (close(vm_fd) and any other 
relevant file descriptors).

- Elliot
