Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 931D46A247B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 23:49:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbjBXWt1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 17:49:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjBXWtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 17:49:25 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8827D6F839;
        Fri, 24 Feb 2023 14:48:55 -0800 (PST)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31OLKath030767;
        Fri, 24 Feb 2023 22:48:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=R7F2MEAqu8edz32MMSv65MBMNDph4m1pFimgxF9cfrE=;
 b=OrrnIm6qfXLO80ao5ePM/N0TJtn1UqgIwT3+sdg2oyk96WykNubruL+Qf+foxBRE8+7R
 V0Lznn75Xz5Cn84u1UVriEtRrfuhRb+ih+ookoYJdweqRT3LVldCWbt+dPMsLAeFoPcJ
 4Qh5Qduy6n2JiB0yXqgdpF6YnmdVTAuWluSC9wmdqe4iu9eM76gVKB2kBBiKNaQp7bNi
 ruRWUiXUw1tXqZu30OGFvivyLW88yODqZNW2g7S03iQz3yW9q2H1PvelTj7hTqeaLhJ8
 ZGyI6FLnZYCLLP/41QQIUBuZof2GV8weU9oBanSY1Tpqf6UBY8ACc4SmmCJ0IkRCUKIC BA== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ny0q58y6p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Feb 2023 22:48:22 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31OMmKOw019791
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Feb 2023 22:48:20 GMT
Received: from [10.110.9.108] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 24 Feb
 2023 14:48:19 -0800
Message-ID: <6efceacf-93d3-787a-a121-bee16f1531f2@quicinc.com>
Date:   Fri, 24 Feb 2023 14:48:18 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v10 10/26] gunyah: vm_mgr: Introduce basic VM Manager
Content-Language: en-US
To:     Arnd Bergmann <arnd@arndb.de>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Alex Elder <elder@linaro.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>
CC:     Murali Nalajala <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        "Konrad Dybcio" <konrad.dybcio@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
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
 <c5ff1523-7a62-3d3f-6fa9-792ce4d222e8@quicinc.com>
 <a50fa44d-fbc3-9ce2-175b-85c8cd7a9f7f@linaro.org>
 <15aa881f-5cf1-446e-a71e-f62d24e87500@app.fastmail.com>
From:   Elliot Berman <quic_eberman@quicinc.com>
In-Reply-To: <15aa881f-5cf1-446e-a71e-f62d24e87500@app.fastmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: cKcIfsydC_ibLi8twrwe-itVdHloxpMW
X-Proofpoint-ORIG-GUID: cKcIfsydC_ibLi8twrwe-itVdHloxpMW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-24_16,2023-02-24_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 mlxlogscore=999 clxscore=1015
 bulkscore=0 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302240183
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/24/2023 5:20 AM, Arnd Bergmann wrote:
> On Fri, Feb 24, 2023, at 11:29, Srinivas Kandagatla wrote:
>> On 23/02/2023 22:40, Elliot Berman wrote:
> 
>>>>> Does this means adding #define GH_VM_DEFAULT_ARG 0 ? I am not sure
>>>>> yet what arguments to add here.
>>>>>
>>>>> The ABI can add new "long" values to GH_CREATE_VM and that wouldn't
>>>>
>>>> Sorry, that is exactly what we want to avoid, we can not change the
>>>> UAPI its going to break the userspace.
>>>>
>>>>> break compatibility with old kernels; old kernels reject it as -EINVAL.
>>>>
>>>> If you have userspace built with older kernel headers then that will
>>>> break. Am not sure about old-kernels.
>>>>
>>>> What exactly is the argument that you want to add to GH_CREATE_VM?
>>>>
>>>> If you want to keep GH_CREATE_VM with no arguments that is fine but
>>>> remove the conflicting comments in the code and document so that its
>>>> not misleading readers/reviewers that the UAPI is going to be modified
>>>> in near future.
>>>>
>>>>
>>>
>>> The convention followed here comes from KVM_CREATE_VM. Is this ioctl
>>> considered bad example?
>>>
>>
>> It is recommended to only use _IO for commands without arguments, and
>> use pointers for passing data. Even though _IO can indicate either
>> commands with no argument or passing an integer value instead of a
>> pointer. Am really not sure how this works in compat case.
>>
>> Am sure there are tricks that can be done with just using _IO() macro
>> (ex vfio), but this does not mean that we should not use _IOW to be more
>> explicit on the type and size of argument that we are expecting.
>>
>> On the other hand If its really not possible to change this IOCTL to
>> _IOW and argument that you are referring would be with in integer range,
>> then what you have with _IO macro should work.
> 
> Passing an 'unsigned long' value instead of a pointer is fine for compat
> mode, as a 32-bit compat_ulong_t always fits inside of the 64-bit
> unsigned long. The downside is that portable code cannot have a
> single ioctl handler function that takes both commands with pointers
> and other commands with integer arguments, as some architectures
> (i.e. s390, possibly arm64+morello in the future) need to mangle
> pointer arguments using compat_ptr() but must not do that on integer
> arguments.

Thanks Arnd for helping clarify here!

I'd be open to making GH_CREATE_VM take a struct argument today, but I 
really don't know what size or what needs to be in that struct. My hope 
is that we can get away with just an integer for future needs. If 
integer doesn't suit, then new ioctl would need to be created. I think 
there's same problem if I pick some struct today (the struct may not 
suit tomorrow and we need to create new ioctl for the new struct).
