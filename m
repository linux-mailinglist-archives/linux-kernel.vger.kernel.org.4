Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 989AB6A12E3
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 23:41:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbjBWWlZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 17:41:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjBWWlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 17:41:22 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 462B255C3C;
        Thu, 23 Feb 2023 14:41:21 -0800 (PST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31NMEqhv006321;
        Thu, 23 Feb 2023 22:40:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=vwSIdh17qJjWuuG8z6cWMHyJXoRyAfuwcZs4OEdGOzg=;
 b=V7046jEF9kPAvF7/4ErM/lwBvesSCcAH5bXzJjNLStio887Ls4DsJpFmkZW+pwFfsA/K
 ZZ+nRMXBeb9B3L5jo4myeAGtpu7aAc+TQiBxIfAXoJEUTUte5oljeXwODAPzQ59hOjUX
 LeOXj63rbHZTRCI4eB07AdUGEnslg2OIGtdPFnLqO1X+wMjcpxOgZ9k96406PK6VoEle
 NYsGswH8C2TxN2/AhonDwfvnNR/nU3RUnfkZlpoDWoYeYfm8r6gQjAGQefn1Bt+q5UoV
 URupPM+FH46yQsR+TguzgS5k/6KB13fLCtlVgVSkFQpdIKvHOYsa2yz0UjtYdGuifdLr vQ== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nwycnjtbu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Feb 2023 22:40:52 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31NMepx5031123
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Feb 2023 22:40:51 GMT
Received: from [10.134.65.165] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 23 Feb
 2023 14:40:50 -0800
Message-ID: <c5ff1523-7a62-3d3f-6fa9-792ce4d222e8@quicinc.com>
Date:   Thu, 23 Feb 2023 14:40:50 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v10 10/26] gunyah: vm_mgr: Introduce basic VM Manager
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
 <05c4aab8-2d26-b944-adb6-624d67e4a11d@quicinc.com>
 <52d944b1-3ea6-26b7-766a-2fed05dccf3a@linaro.org>
Content-Language: en-US
From:   Elliot Berman <quic_eberman@quicinc.com>
In-Reply-To: <52d944b1-3ea6-26b7-766a-2fed05dccf3a@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: w-UUgCskb9-MmOJrbcAGgLdyO350Ovqq
X-Proofpoint-GUID: w-UUgCskb9-MmOJrbcAGgLdyO350Ovqq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-23_13,2023-02-23_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 spamscore=0
 clxscore=1015 mlxlogscore=999 priorityscore=1501 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302230188
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/23/2023 2:08 AM, Srinivas Kandagatla wrote:
> 
> 
> On 22/02/2023 00:27, Elliot Berman wrote:
>>
>>>> +    .llseek = noop_llseek,
>>>> +};
>>>> +
>>>> +static long gh_dev_ioctl_create_vm(struct gh_rm *rm, unsigned long 
>>>> arg)
>>> Not sure what is the gain of this multiple levels of redirection.
>>>
>>> How about
>>>
>>> long gh_dev_create_vm(struct gh_rm *rm, unsigned long arg)
>>> {
>>> ...
>>> }
>>>
>>> and rsc_mgr just call it as part of its ioctl call
>>>
>>> static long gh_dev_ioctl(struct file *filp, unsigned int cmd, 
>>> unsigned long arg)
>>> {
>>>      struct miscdevice *miscdev = filp->private_data;
>>>      struct gh_rm *rm = container_of(miscdev, struct gh_rm, miscdev);
>>>
>>>      switch (cmd) {
>>>      case GH_CREATE_VM:
>>>          return gh_dev_create_vm(rm, arg);
>>>      default:
>>>          return -ENOIOCTLCMD;
>>>      }
>>> }
>>>
>>
>> I'm anticipating we will add further /dev/gunyah ioctls and I thought 
>> it would be cleaner to have all that in vm_mgr.c itself.
>>
>>>
>>>> +{
>>>> +    struct gh_vm *ghvm;
>>>> +    struct file *file;
>>>> +    int fd, err;
>>>> +
>>>> +    /* arg reserved for future use. */
>>>> +    if (arg)
>>>> +        return -EINVAL;
>>>
>>> The only code path I see here is via GH_CREATE_VM ioctl which 
>>> obviously does not take any arguments, so if you are thinking of 
>>> using the argument for architecture-specific VM flags.  Then this 
>>> needs to be properly done by making the ABI aware of this.
>>
>> It is documented in Patch 17 (Document Gunyah VM Manager)
>>
>> +GH_CREATE_VM
>> +~~~~~~~~~~~~
>> +
>> +Creates a Gunyah VM. The argument is reserved for future use and must 
>> be 0.
>>
> But this conficts with the UAPIs that have been defined. GH_CREATE_VM 
> itself is defined to take no parameters.
> 
> #define GH_CREATE_VM                    _IO(GH_IOCTL_TYPE, 0x0)
> 
> so where are you expecting the argument to come from?
>  >>>
>>> As you mentioned zero value arg imply an "unauthenticated VM" type, 
>>> but this was not properly encoded in the userspace ABI. Why not make 
>>> it future compatible. How about adding arguments to GH_CREATE_VM and 
>>> pass the required information correctly.
>>> Note that once the ABI is accepted then you will not be able to 
>>> change it, other than adding a new one.
>>>
>>
>> Does this means adding #define GH_VM_DEFAULT_ARG 0 ? I am not sure yet 
>> what arguments to add here.
>>
>> The ABI can add new "long" values to GH_CREATE_VM and that wouldn't 
> 
> Sorry, that is exactly what we want to avoid, we can not change the UAPI 
> its going to break the userspace.
> 
>> break compatibility with old kernels; old kernels reject it as -EINVAL.
> 
> If you have userspace built with older kernel headers then that will 
> break. Am not sure about old-kernels.
> 
> What exactly is the argument that you want to add to GH_CREATE_VM?
> 
> If you want to keep GH_CREATE_VM with no arguments that is fine but 
> remove the conflicting comments in the code and document so that its not 
> misleading readers/reviewers that the UAPI is going to be modified in 
> near future.
> 
> 

The convention followed here comes from KVM_CREATE_VM. Is this ioctl 
considered bad example?

>>
>>>> +
>>>> +    ghvm = gh_vm_alloc(rm);
>>>> +    if (IS_ERR(ghvm))
>>>> +        return PTR_ERR(ghvm);
>>>> +
>>>> +    fd = get_unused_fd_flags(O_CLOEXEC);
>>>> +    if (fd < 0) {
>>>> +        err = fd;
>>>> +        goto err_destroy_vm;
>>>> +    }
>>>> +
>>>> +    file = anon_inode_getfile("gunyah-vm", &gh_vm_fops, ghvm, O_RDWR);
>>>> +    if (IS_ERR(file)) {
>>>> +        err = PTR_ERR(file);
>>>> +        goto err_put_fd;
>>>> +    }
>>>> +
>>>> +    fd_install(fd, file);
>>>> +
>>>> +    return fd;
>>>> +
>>>> +err_put_fd:
>>>> +    put_unused_fd(fd);
>>>> +err_destroy_vm:
>>>> +    kfree(ghvm);
>>>> +    return err;
>>>> +}
>>>> +
>>>> +long gh_dev_vm_mgr_ioctl(struct gh_rm *rm, unsigned int cmd, 
>>>> unsigned long arg)
>>>> +{
>>>> +    switch (cmd) {
>>>> +    case GH_CREATE_VM:
>>>> +        return gh_dev_ioctl_create_vm(rm, arg);
>>>> +    default:
>>>> +        return -ENOIOCTLCMD;
>>>> +    }
>>>> +}
>>>> diff --git a/drivers/virt/gunyah/vm_mgr.h 
>>>> b/drivers/virt/gunyah/vm_mgr.h
>>>> new file mode 100644
>>>> index 000000000000..76954da706e9
>>>> --- /dev/null
>>>> +++ b/drivers/virt/gunyah/vm_mgr.h
>>>> @@ -0,0 +1,22 @@
>>>> +/* SPDX-License-Identifier: GPL-2.0-only */
>>>> +/*
>>>> + * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All 
>>>> rights reserved.
>>>> + */
>>>> +
>>>> +#ifndef _GH_PRIV_VM_MGR_H
>>>> +#define _GH_PRIV_VM_MGR_H
>>>> +
>>>> +#include <linux/gunyah_rsc_mgr.h>
>>>> +
>>>> +#include <uapi/linux/gunyah.h>
>>>> +
>>>> +long gh_dev_vm_mgr_ioctl(struct gh_rm *rm, unsigned int cmd, 
>>>> unsigned long arg);
>>>> +
>>>> +struct gh_vm {
>>>> +    u16 vmid;
>>>> +    struct gh_rm *rm;
>>>> +
>>>> +    struct work_struct free_work;
>>>> +};
>>>> +
>>>> +#endif
>>>> diff --git a/include/uapi/linux/gunyah.h b/include/uapi/linux/gunyah.h
>>>> new file mode 100644
>>>> index 000000000000..10ba32d2b0a6
>>>> --- /dev/null
>>>> +++ b/include/uapi/linux/gunyah.h
>>>> @@ -0,0 +1,23 @@
>>>> +/* SPDX-License-Identifier: GPL-2.0-only WITH Linux-syscall-note */
>>>> +/*
>>>> + * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All 
>>>> rights reserved.
>>>> + */
>>>> +
>>>> +#ifndef _UAPI_LINUX_GUNYAH
>>>> +#define _UAPI_LINUX_GUNYAH
>>>> +
>>>> +/*
>>>> + * Userspace interface for /dev/gunyah - gunyah based virtual machine
>>>> + */
>>>> +
>>>> +#include <linux/types.h>
>>>> +#include <linux/ioctl.h>
>>>> +
>>>> +#define GH_IOCTL_TYPE            'G'
>>>> +
>>>> +/*
>>>> + * ioctls for /dev/gunyah fds:
>>>> + */
>>>> +#define GH_CREATE_VM            _IO(GH_IOCTL_TYPE, 0x0) /* Returns 
>>>> a Gunyah VM fd */
>>>
>>> Can HLOS forcefully destroy a VM?
>>> If so should we have a corresponding DESTROY IOCTL?
>>
>> It can forcefully destroy unauthenticated and protected virtual 
>> machines. I don't have a userspace usecase for a DESTROY ioctl yet, 
>> maybe this can be added later? By the way, the VM is forcefully 
> that should be fine, but its also nice to add it for completeness, but 
> not a compulsory atm
> 
>> destroyed when VM refcount is dropped to 0 (close(vm_fd) and any other 
>> relevant file descriptors).
> I have noticed that path.
> 
> --srini
>>
>> - Elliot
