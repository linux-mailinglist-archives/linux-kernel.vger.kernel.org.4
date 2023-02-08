Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 644D768F825
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 20:34:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231877AbjBHTee (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 14:34:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbjBHTea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 14:34:30 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35C1848A37;
        Wed,  8 Feb 2023 11:34:29 -0800 (PST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 318GxU3f014158;
        Wed, 8 Feb 2023 19:34:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=wLN3aqt4BsZmshWcM1qzuY4DzPsmH0ag0Wq1aFzyO9U=;
 b=RXjBwrCAB+EGPNGX+zXdyBGwijxm2bveTfrWyfz+wqFvdSodU7DO8kDLcMjYYK06kl07
 72DZQUez0EipDxMEsu7W+/1hs0Q19IqZJlyZOWkfeA6W2usvFZVIlOQRQsIU6LlJZM3y
 zudBKNlamSvkshTPaIu3ndg5fQw3YQliy18R9zKrQY7y4Ei4KZ4g3sEd8XFeKErhp601
 zrtHExDWS9oGYN3iZZFxYsJyaOTXgLdzqdaL9Zz7EejnOpMdwVG1YG5yvi+Kl2VB7Zbd
 FAj3wU8XG8lwagRUA7dDjUh6JaJG6hAQT4oP1t1J6Aq6Kh1DnCnnSP6/Hy6EmYNzfTv7 4Q== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nm7u89q9x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Feb 2023 19:34:12 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 318JYBrA026357
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 8 Feb 2023 19:34:11 GMT
Received: from [10.134.67.48] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 8 Feb 2023
 11:34:11 -0800
Message-ID: <f48868a9-313d-b3ee-d8b2-98774f0d1cd8@quicinc.com>
Date:   Wed, 8 Feb 2023 11:34:10 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v9 21/27] gunyah: vm_mgr: Add framework to add VM
 Functions
Content-Language: en-US
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Alex Elder <elder@linaro.org>,
        Murali Nalajala <quic_mnalajal@quicinc.com>,
        Jonathan Corbet <corbet@lwn.net>
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
        Catalin Marinas <catalin.marinas@arm.com>,
        "Will Deacon" <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20230120224627.4053418-1-quic_eberman@quicinc.com>
 <20230120224627.4053418-22-quic_eberman@quicinc.com>
 <c1564a80-d1be-f31d-2db3-1ec0b847e921@linaro.org>
From:   Elliot Berman <quic_eberman@quicinc.com>
In-Reply-To: <c1564a80-d1be-f31d-2db3-1ec0b847e921@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: U5KxnPAtgGMiTV34f4pL7tSGAJNn1neE
X-Proofpoint-ORIG-GUID: U5KxnPAtgGMiTV34f4pL7tSGAJNn1neE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-08_09,2023-02-08_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 priorityscore=1501 spamscore=0 suspectscore=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302080167
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/7/2023 5:15 AM, Srinivas Kandagatla wrote:
> 
> 
> On 20/01/2023 22:46, Elliot Berman wrote:
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
[snip]
>> +#define DECLARE_GUNYAH_VM_FUNCTION(_name, _bind, _release)        \
>> +    static struct gunyah_vm_function_driver _name = {        \
>> +        .name = __stringify(_name),                \
>> +        .mod = THIS_MODULE,                    \
>> +        .bind = _bind,                        \
>> +        .release = _release,                    \
>> +    };                                \
>> +    MODULE_ALIAS("ghfunc:"__stringify(_name))
> 
> lets not over kill this by having DECLARE_GUNYAH_VM_FUNCTION, this will 
> make the drivers readable in a more familar way. let the driver define 
> this static struct.
> 
> 
>> +
>> +#define DECLARE_GUNYAH_VM_FUNCTION_INIT(_name, _bind, _release)        \
>> +    DECLARE_GUNYAH_VM_FUNCTION(_name, _bind, _release);        \
>> +    static int __init _name##_mod_init(void)            \
>> +    {                                \
>> +        return gunyah_vm_function_register(&(_name));        \
>> +    }                                \
>> +    module_init(_name##_mod_init);                    \
>> +    static void __exit _name##_mod_exit(void)            \
>> +    {                                \
>> +        gunyah_vm_function_unregister(&(_name));        \
>> +    }                                \
>> +    module_exit(_name##_mod_exit)
>> +
> 
> How about:
> 
> #define module_gunyah_function_driver(__gf_driver)
>          module_driver(__gf_driver, gunyah_vm_function_register, \
>                          gunyah_vm_function_unregister)
> 
> Having relook at the patch, I think modeling the gunyah_vm_function as a 
> proper device and driver model will scale, you could leverage most of 
> this manual management to the existing driver model. May I suggest to 
> you take a look at  include/linux/auxiliary_bus.h
> with that you could model add_functions as
> auxiliary_device_add and the respecitive drivers as 
> module_auxiliary_driver.
> 

I'm not sure if device model can fit well here. I wanted to make sure 
that the VM function actually bound to a driver when user requests it 
and the driver to be able to return some info about it to the user  -- 
vCPUs return a file descriptor for instance. I could probably make it 
work with a device/driver model, but I'm not sure if it should be done 
like that.

>> +#endif
>> diff --git a/include/uapi/linux/gunyah.h b/include/uapi/linux/gunyah.h
>> index 36359ad2175e..ec8da6fde045 100644
>> --- a/include/uapi/linux/gunyah.h
>> +++ b/include/uapi/linux/gunyah.h
>> @@ -50,4 +50,17 @@ struct gh_vm_dtb_config {
>>   #define GH_VM_START        _IO(GH_IOCTL_TYPE, 0x3)
>> +#define GUNYAH_FUNCTION_NAME_SIZE        32
>> +#define GUNYAH_FUNCTION_MAX_ARG_SIZE        1024
>> +
>> +struct gh_vm_function {
>> +    char name[GUNYAH_FUNCTION_NAME_SIZE];
>> +    union {
>> +        char data[GUNYAH_FUNCTION_MAX_ARG_SIZE];
> 
> Are we missing any thing here, its odd to see a single member union like 
> this.
> if other memembers are part of another patch please move them to this 
> one as its confusing.

I can add a comment that members will be added as new functions are 
added. If I put it in this patch, it raises questions about where those 
other members are being used.


