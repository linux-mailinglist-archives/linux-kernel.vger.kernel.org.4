Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2C0769FEBF
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 23:52:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233053AbjBVWwb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 17:52:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233051AbjBVWw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 17:52:28 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 352EE301B6;
        Wed, 22 Feb 2023 14:52:27 -0800 (PST)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31MEjTtf002541;
        Wed, 22 Feb 2023 22:52:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=LgmYIsv97qPbDmuwM1PfV1v0A5XJ8xw9/5yC+6G52TE=;
 b=oN35t60zzfOaTOdp4vp6r5BmyxwEvzSEPBdqtsrIwdRe4XB7onsshfSIZg/10Jz4dCca
 BBxpfRiur79dRlD/OItdK8oc9/8U/iQx0N58+L0hhd/9gvxaz7fDkaxGL4qbClxUpV6c
 uQvBzz+Zve1MfqwxDE8K0VGPTc5tFx1pCNXo8Z3zvycUzdAXAmp4b1u3pQfkNUMpzDjZ
 6sHlb0+NncHaW3HWQ253QDoDgxAGdraiixdI6BSnLJHysGNJIGJ/MznZLfjhlU7TW88G
 aUG3sWBwfF+q/KRjNVb4+GAz61MGQctlSp+TLLEJZoCqPoXOYu8S3Aa0jdXeZtGFvi9y vg== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nwn3894ts-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Feb 2023 22:52:09 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31MMq892026213
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Feb 2023 22:52:08 GMT
Received: from [10.134.67.48] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 22 Feb
 2023 14:52:07 -0800
Message-ID: <931494e0-b2da-5746-a86c-42b972072080@quicinc.com>
Date:   Wed, 22 Feb 2023 14:52:07 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v10 08/26] gunyah: rsc_mgr: Add resource manager RPC core
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Alex Elder <elder@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
        Murali Nalajala <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "Arnd Bergmann" <arnd@arndb.de>, Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20230214211229.3239350-1-quic_eberman@quicinc.com>
 <20230214212327.3310128-1-quic_eberman@quicinc.com>
 <Y+3QqdQVH5BTbnaP@kroah.com>
 <b04aef26-ee0d-af01-3aa1-a0c77d9cbaf3@quicinc.com>
 <Y+8upgx58a+vLeaT@kroah.com>
From:   Elliot Berman <quic_eberman@quicinc.com>
In-Reply-To: <Y+8upgx58a+vLeaT@kroah.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: n7hNREE5imiuMUSHjvLRU8RWFJOvXThF
X-Proofpoint-ORIG-GUID: n7hNREE5imiuMUSHjvLRU8RWFJOvXThF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-22_10,2023-02-22_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1015
 malwarescore=0 bulkscore=0 phishscore=0 spamscore=0 priorityscore=1501
 mlxlogscore=939 adultscore=0 suspectscore=0 lowpriorityscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302220198
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/16/2023 11:37 PM, Greg Kroah-Hartman wrote:
> On Thu, Feb 16, 2023 at 09:40:52AM -0800, Elliot Berman wrote:
>>
>>
>> On 2/15/2023 10:43 PM, Greg Kroah-Hartman wrote:
>>> On Tue, Feb 14, 2023 at 01:23:25PM -0800, Elliot Berman wrote:
>>>> +struct gh_rm {
>>>> +	struct device *dev;
>>>
>>> What device does this point to?
>>>
>>
>> The platform device.
> 
> What platform device?  And why a platform device?
> 

This will be used for the dev_printk. It's presently also used for the 
reference counting. From your comments below, I'll switch the reference 
counting away from this platform device.

>>>> +	struct gunyah_resource tx_ghrsc, rx_ghrsc;
>>>> +	struct gh_msgq msgq;
>>>> +	struct mbox_client msgq_client;
>>>> +	struct gh_rm_connection *active_rx_connection;
>>>> +	int last_tx_ret;
>>>> +
>>>> +	struct idr call_idr;
>>>> +	struct mutex call_idr_lock;
>>>> +
>>>> +	struct kmem_cache *cache;
>>>> +	struct mutex send_lock;
>>>> +	struct blocking_notifier_head nh;
>>>> +};
>>>
>>> This obviously is the "device" that your system works on, so what are
>>> the lifetime rules of it?  Why isn't is just a real 'struct device' in
>>> the system instead of a random memory blob with a pointer to a device?
>>>
>>> What controls the lifetime of this structure and where is the reference
>>> counting logic for it?
>>>
>>
>> The lifetime of the structure is bound by the platform device that above
>> struct device *dev points to. get_gh_rm and put_gh_rm increments the device
>> ref counter and ensures lifetime of the struct is also extended.
> 
> But this really is "your" device, not the platform device.  So make it a
> real one please as that is how the kernel's driver model works.  Don't
> hang "magic structures" off of a random struct device and have them
> control the lifetime rules of the parent without actually being a device
> themself.  This should make things simpler overall, not more complex,
> and allow you to expose things to userspace properly (right now your
> data is totally hidden.)

The "real" device I create here is the miscdev, so I think the 
recommendation here is to do refcounting off that miscdev. Is this the 
approach you were thinking of?

Thanks,
Elliot
