Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98F8772A367
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 21:50:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232018AbjFITuX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 15:50:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231896AbjFITuT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 15:50:19 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE4BD1FEC;
        Fri,  9 Jun 2023 12:50:15 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 359JmZSR027255;
        Fri, 9 Jun 2023 19:50:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=wJ9YsL7W5/uRql9g9hLhUuvRfqvi5U2DpIzDMRyuY24=;
 b=bpdhHglfmOl+rUc3Bh1rHXvvRS0RYoiWlPagMs3tJO36HKRwwDYlGjzchA0IRqEL6Ytu
 mAKREe1enrdhVx41bV7+wy2MNYzB4BBY8kS9HthglrAVE+bfH5XJ44SbtD5ROCFY8DOs
 v5t+uuGccUk1cewM8zSCXonUUFd/aI/W/M8KoLVHbWR0lb/LYHdnWxcf4AMhQfSwEdNT
 D8p9O3BnpwoaIhU9PaTB/GpgyHoGY5xTEgYikgXDCq/E8wRIA7AYkDSCanV3RP0z1D09
 2aJ7xEruOv6z2vWaGspvSXhkNro6Yd4cY5h7l8UsXjXVn5vje0ZzHstlAjSvv0+RmLAi tQ== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r3vu4hsbc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Jun 2023 19:49:59 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 359JnwPC005250
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 9 Jun 2023 19:49:58 GMT
Received: from [10.134.65.165] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Fri, 9 Jun 2023
 12:49:57 -0700
Message-ID: <c625a138-d27e-bbcb-8056-25abefb75152@quicinc.com>
Date:   Fri, 9 Jun 2023 12:49:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v13 17/24] gunyah: vm_mgr: Add framework for VM Functions
Content-Language: en-US
To:     Alex Elder <elder@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
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
        Will Deacon <will@kernel.org>, Andy Gross <agross@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20230509204801.2824351-1-quic_eberman@quicinc.com>
 <20230509204801.2824351-18-quic_eberman@quicinc.com>
 <3dd82ec0-2a9a-3401-5385-965c624f9f32@linaro.org>
From:   Elliot Berman <quic_eberman@quicinc.com>
In-Reply-To: <3dd82ec0-2a9a-3401-5385-965c624f9f32@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: n9i9EZLoAwf-p1UluZlSCL4RXYHZG_Ok
X-Proofpoint-ORIG-GUID: n9i9EZLoAwf-p1UluZlSCL4RXYHZG_Ok
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-09_14,2023-06-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=999
 lowpriorityscore=0 phishscore=0 priorityscore=1501 clxscore=1015
 suspectscore=0 spamscore=0 mlxscore=0 adultscore=0 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306090165
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/5/2023 12:49 PM, Alex Elder wrote:
> On 5/9/23 3:47 PM, Elliot Berman wrote:
>> Introduce a framework for Gunyah userspace to install VM functions. VM
>> functions are optional interfaces to the virtual machine. vCPUs,
>> ioeventfs, and irqfds are examples of such VM functions and are
> 
> s/ioventfs/ioventfds/
> 
> Also, these aren't just examples of VM functions, they *are* the
> VM functions implemented.
> 
>> implemented in subsequent patches.
>>
>> A generic framework is implemented instead of individual ioctls to
>> create vCPUs, irqfds, etc., in order to simplify the VM manager core
>> implementation and allow dynamic loading of VM function modules.
> 
> This also allows the set of VM functions to be extended without
> updating the API (like it or not).
> 
>>
>> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
> 
> I have a few more comments, but this looks pretty good.
> 
> Reviewed-by: Alex Elder <elder@linaro.org>
> 
>> ---
>>   Documentation/virt/gunyah/vm-manager.rst |  18 ++
>>   drivers/virt/gunyah/vm_mgr.c             | 216 ++++++++++++++++++++++-
>>   drivers/virt/gunyah/vm_mgr.h             |   4 +
>>   include/linux/gunyah_vm_mgr.h            |  87 +++++++++
>>   include/uapi/linux/gunyah.h              |  18 ++
>>   5 files changed, 340 insertions(+), 3 deletions(-)
>>   create mode 100644 include/linux/gunyah_vm_mgr.h
>>
>> diff --git a/Documentation/virt/gunyah/vm-manager.rst 
>> b/Documentation/virt/gunyah/vm-manager.rst
>> index 50d8ae7fabcd..3b51bab9d793 100644
>> --- a/Documentation/virt/gunyah/vm-manager.rst
>> +++ b/Documentation/virt/gunyah/vm-manager.rst
>> @@ -17,6 +17,24 @@ sharing userspace memory with a VM is done via the 
>> `GH_VM_SET_USER_MEM_REGION`_
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
>> +created by the `GH_VM_ADD_FUNCTION`_ ioctl.
> 
> Is a function *type* (e.g., VCPU or ioeventfd) identified by a string?
> Or a function *instance* (e.g. four VCPUs)?  Or both?
> 

Ah, this should be:

Function types are identified by an enum and have some argument(s)...

>> +
>> +Functions typically will always do at least one of these operations:
> 
> Typically, or always?
> 

Hmm, I didn't want to use a more absolute term like "always" since it 
implies to me that the framework forces this somehow. A VM function 
wouldn't do much interesting if it weren't interacting with the VM and 
resource tickets/IO handlers are the ways for functions to interact with 
VMs.

I'll tweak the wording here.

>> +
>> +1. Create resource ticket(s). Resource tickets allow a function to 
>> register
>> +   itself as the client for a Gunyah resource (e.g. doorbell or vCPU) 
>> and
>> +   the function is given the pointer to the &struct gh_resource when the
>> +   VM is starting.
>> +
> 
> What I think this means is that tickets are used to allow functions
> to be defined *before* the VM is actually started.  So once it starts,
> the functions get added.  (I might have this slightly wrong, but in
> any case I'm not sure the above sentence is very clear.)
> 

I'm going to remove the "and the function is given the pointer to..." 
since I agree it is a bit confusing. I think it'll be clearer for me to 
put it in the resource ticket kerneldoc where there's context of the 
populate() callback in the resource ticket. I'll mention there that the 
populate() callback may not be made until the VM is started which could 
be a while.

>> +2. Register IO handler(s). IO handlers allow a function to handle 
>> stage-2 faults
>> +   from the virtual machine.
>> +
>>   Sample Userspace VMM
>>   ====================
>> diff --git a/drivers/virt/gunyah/vm_mgr.c b/drivers/virt/gunyah/vm_mgr.c
>> index a800061f56bf..56464451b262 100644
>> --- a/drivers/virt/gunyah/vm_mgr.c
>> +++ b/drivers/virt/gunyah/vm_mgr.c
>> @@ -6,10 +6,13 @@
>>   #define pr_fmt(fmt) "gh_vm_mgr: " fmt
>>   #include <linux/anon_inodes.h>
>> +#include <linux/compat.h>
>>   #include <linux/file.h>
>>   #include <linux/gunyah_rsc_mgr.h>
>> +#include <linux/gunyah_vm_mgr.h>
>>   #include <linux/miscdevice.h>
>>   #include <linux/module.h>
>> +#include <linux/xarray.h>
>>   #include <uapi/linux/gunyah.h>
>> @@ -17,6 +20,172 @@
>>   static void gh_vm_free(struct work_struct *work);
>> +static DEFINE_XARRAY(gh_vm_functions);
>> +
>> +static void gh_vm_put_function(struct gh_vm_function *fn)
>> +{
>> +    module_put(fn->mod);
>> +}
>> +
>> +static struct gh_vm_function *gh_vm_get_function(u32 type)
>> +{
>> +    struct gh_vm_function *fn;
>> +    int r;
>> +
>> +    fn = xa_load(&gh_vm_functions, type);
>> +    if (!fn) {
>> +        r = request_module("ghfunc:%d", type);
>> +        if (r)
>> +            return ERR_PTR(r > 0 ? -r : r);
> 
> Almost all callers of request_module() simply ignore the
> return value.  What positive values are you expecting to
> see here (and are you sure they're positive errno values)?
> 

I can ignore the return value here, too, to follow the convention.

I had observed request_module can return modprobe's exit code.

>> +
>> +        fn = xa_load(&gh_vm_functions, type);
>> +    }
>> +
>> +    if (!fn || !try_module_get(fn->mod))
>> +        fn = ERR_PTR(-ENOENT);
>> +
>> +    return fn;
>> +}
> 
> . . .
