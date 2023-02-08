Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F08E68F70E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 19:37:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbjBHShq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 13:37:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231331AbjBHSha (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 13:37:30 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7A274FAFB;
        Wed,  8 Feb 2023 10:37:01 -0800 (PST)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 318IMSiV011476;
        Wed, 8 Feb 2023 18:36:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Ps4OKQ3QjqajZSHjhiW3B0IGT/BB/Ksecf76/2BGmfI=;
 b=az+ufgsaxv51Pkl16srXhAe3BG6y61gPM/eVxt8NpMHmq7vhoA1LB1LjhY2UYmQR0/Le
 y8otzoifehjaG2czfh/FuKO18/ICVyDafnHrZoOjAX2Aq3UogFMsT/NlVvO+er8CIhFs
 x8Lv4KGGpdUg5HHGaFOHui8N7sR1gc98lSaeYV5IeumVC22y96Zh5biIWzOsFYWnsK4z
 9WkjjQqKKu+ox8reXre+iISwzAY1d20RoTdPTUTBnoQCP+uNAJ9lyUmZLUoBpwNzTMzj
 S9XxZYNzEocjoT2q1qsOOgBbwI8/bRaypt3njJUeDHUSn/HPvTr6zYynn67sqHLtkVt0 rw== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nkk2d4q9y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Feb 2023 18:36:38 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 318IabDD004091
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 8 Feb 2023 18:36:37 GMT
Received: from [10.134.67.48] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 8 Feb 2023
 10:36:36 -0800
Message-ID: <4e03be86-8a9a-13b2-db06-add22595ec96@quicinc.com>
Date:   Wed, 8 Feb 2023 10:36:36 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v9 24/27] virt: gunyah: Add proxy-scheduled vCPUs
Content-Language: en-US
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Alex Elder <elder@linaro.org>,
        Murali Nalajala <quic_mnalajal@quicinc.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "Catalin Marinas" <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
CC:     Trilok Soni <quic_tsoni@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Marc Zyngier <maz@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20230120224627.4053418-1-quic_eberman@quicinc.com>
 <20230120224627.4053418-25-quic_eberman@quicinc.com>
 <8b03eafd-8d8e-6e80-2b88-0e186f3ab392@linaro.org>
From:   Elliot Berman <quic_eberman@quicinc.com>
In-Reply-To: <8b03eafd-8d8e-6e80-2b88-0e186f3ab392@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: O5-ZKekEL6pLh8PYKe57ARkBVIBuZ2N1
X-Proofpoint-ORIG-GUID: O5-ZKekEL6pLh8PYKe57ARkBVIBuZ2N1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-08_08,2023-02-08_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0
 mlxlogscore=999 clxscore=1015 mlxscore=0 adultscore=0 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302080160
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/7/2023 6:43 AM, Srinivas Kandagatla wrote:
> 
> 
> On 20/01/2023 22:46, Elliot Berman wrote:
>> Gunyah allows host virtual machines to schedule guest virtual machines
>> and handle their MMIO accesses. vCPUs are presented to the host as a
>> Gunyah resource and represented to userspace as a Gunyah VM function.
>>
>> Creating the vcpu VM function will create a file descriptor that:
>>   - can run an ioctl: GH_VCPU_RUN to schedule the guest vCPU until the
>>     next interrupt occurs on the host or when the guest vCPU can no
>>     longer be run.
>>   - can be mmap'd to share a gh_vcpu_run structure which can look up the
>>     reason why GH_VCPU_RUN returned and provide return values for MMIO
>>     access.
>>
>> Co-developed-by: Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>
>> Signed-off-by: Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>
>> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
>> ---
>>   Documentation/virt/gunyah/vm-manager.rst |  30 +-
>>   arch/arm64/gunyah/gunyah_hypercall.c     |  28 ++
>>   drivers/virt/gunyah/Kconfig              |  11 +
>>   drivers/virt/gunyah/Makefile             |   2 +
>>   drivers/virt/gunyah/gunyah_vcpu.c        | 358 +++++++++++++++++++++++
>>   drivers/virt/gunyah/vm_mgr.c             |  25 ++
>>   drivers/virt/gunyah/vm_mgr.h             |   1 +
>>   include/linux/gunyah.h                   |   7 +
>>   include/uapi/linux/gunyah.h              |  30 ++
>>   9 files changed, 490 insertions(+), 2 deletions(-)
>>   create mode 100644 drivers/virt/gunyah/gunyah_vcpu.c
>>
> ...
> 
> 
>> diff --git a/include/uapi/linux/gunyah.h b/include/uapi/linux/gunyah.h
>> index ec8da6fde045..b4afb11f538a 100644
>> --- a/include/uapi/linux/gunyah.h
>> +++ b/include/uapi/linux/gunyah.h
>> @@ -53,9 +53,14 @@ struct gh_vm_dtb_config {
>>   #define GUNYAH_FUNCTION_NAME_SIZE        32
>>   #define GUNYAH_FUNCTION_MAX_ARG_SIZE        1024
>> +struct gh_fn_vcpu_arg {
>> +    __u32 vcpu_id;
>> +};
>> +
>>   struct gh_vm_function {
>>       char name[GUNYAH_FUNCTION_NAME_SIZE];
>>       union {
>> +        struct gh_device_vcpu_arg vcpu;
>>           char data[GUNYAH_FUNCTION_MAX_ARG_SIZE];
>>       };
>>   };
>> @@ -63,4 +68,29 @@ struct gh_vm_function {
>>   #define GH_VM_ADD_FUNCTION    _IOW(GH_IOCTL_TYPE, 0x4, struct 
>> gh_vm_function)
>>   #define GH_VM_REMOVE_FUNCTION    _IOW(GH_IOCTL_TYPE, 0x7, struct 
>> gh_vm_function)
>> +/* for GH_VCPU_RUN, returned by mmap(vcpu_fd, offset=0) */
>> +struct gh_vcpu_run {
> this looks unused, I dont see any reference to this.
> 

This structure gets mapped into userspace from the vCPU file descriptor, 
similar principle to KVM.

Thanks,
Elliot

>> +    /* in */
>> +    __u8 immediate_exit;
>> +    __u8 padding1[7];
>> +
>> +    /* out */
>> +#define GH_VM_EXIT_UNKNOWN            0
>> +#define GH_VM_EXIT_MMIO               1
>> +    __u32 exit_reason;
> 
> If this is ment to go in any of the ioctl arguments then this suffers 
> same issue of padding.
> 
>> +
>> +    union {
>> +        /* GH_VM_EXIT_MMIO */
>> +        struct {
>> +            __u64 phys_addr;
>> +            __u8  data[8];
>> +            __u32 len;
>> +            __u8  is_write;
>> +        } mmio;
>> +    };
>> +};
>> +
>> +#define GH_VCPU_RUN        _IO(GH_IOCTL_TYPE, 0x5)
>> +#define GH_VCPU_MMAP_SIZE    _IO(GH_IOCTL_TYPE, 0x6)
>> +
>>   #endif
