Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD2D86A00E9
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 02:55:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233048AbjBWBzh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 20:55:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbjBWBzg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 20:55:36 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7064113FF;
        Wed, 22 Feb 2023 17:55:34 -0800 (PST)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31N1C773023643;
        Thu, 23 Feb 2023 01:55:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=3tFARqURuZ0F1rOR81RT4P4rlziCK2DZUB77v3kvH7M=;
 b=AMGNodXn4Y29uW5OlaNtyn9tzLIbKVI36n0RUEmh+0TQAaoCOVY4hO4UwUadhSqfrR7H
 4H1pFG+wxD8ufh2dzQvpIApoHE4oavkUpqIUZH6dxd266GbRnkiohSiihoK755YgZZsR
 SddGexoYxswWbqGfuKtgYJTq0Hb2fDl/oB+VlduiMLMt3vvAtM+3ZJxXD0R1yFokD1fJ
 YgiDz+iVZ4IQj6dFTRPqA7phk6zaQDcAzxE5/pt90olazG/aNpaEhU6li7EbNjE84FvM
 +zw42R3Xg+K9U6Fcw9mOHVSUeikL9bPx5prOP+HN6N9M2JsJolEoTaAprVJlknLEQHDn KA== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nwfh02gqc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Feb 2023 01:55:18 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31N1tII2021720
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Feb 2023 01:55:18 GMT
Received: from [10.134.67.48] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 22 Feb
 2023 17:55:17 -0800
Message-ID: <74c19e48-481a-7be9-e287-ca1f7a659c21@quicinc.com>
Date:   Wed, 22 Feb 2023 17:55:17 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v10 15/26] gunyah: rsc_mgr: Add platform ops on
 mem_lend/mem_reclaim
Content-Language: en-US
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
 <20230214212448.3318756-1-quic_eberman@quicinc.com>
 <963d84e8-7b91-c278-1978-4e73d73f7c6f@linaro.org>
 <7aa025a1-b211-f04c-9169-236102fe27fe@quicinc.com>
 <dea710b6-b627-08e9-3d26-d73e6be2e852@linaro.org>
From:   Elliot Berman <quic_eberman@quicinc.com>
In-Reply-To: <dea710b6-b627-08e9-3d26-d73e6be2e852@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Zxazv_018zfZqQGMD80Fr5WUnEbIOd2X
X-Proofpoint-GUID: Zxazv_018zfZqQGMD80Fr5WUnEbIOd2X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-22_12,2023-02-22_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 bulkscore=0 mlxlogscore=999 phishscore=0
 impostorscore=0 mlxscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 spamscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302230015
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/22/2023 2:21 AM, Srinivas Kandagatla wrote:
> 
> 
> On 21/02/2023 21:22, Elliot Berman wrote:
>>
>>
>> On 2/21/2023 6:51 AM, Srinivas Kandagatla wrote:
>>>
>>>
>>> On 14/02/2023 21:24, Elliot Berman wrote:
>> [snip]
>>>> +
>>>> +static struct gunyah_rm_platform_ops *rm_platform_ops;
>>>> +static DECLARE_RWSEM(rm_platform_ops_lock);
>>>
>>> Why do we need this read/write lock or this global rm_platform_ops 
>>> here, AFAIU, there will be only one instance of platform_ops per 
>>> platform.
>>>
>>> This should be a core part of the gunyah and its driver early setup, 
>>> that should give us pretty much lock less behaviour.
>>>
>>> We should be able to determine by Hypervisor UUID that its on 
>>> Qualcomm platform or not, during early gunyah setup which should help 
>>> us setup the platfrom ops accordingly.
>>>
>>> This should also help cleanup some of the gunyah code that was added 
>>> futher down in this patchset.
>>
>> I'm guessing the direction to take is:
>>
>>    config GUNYAH
>>      select QCOM_SCM if ARCH_QCOM
> 
> This is how other kernel drivers use SCM.
> 
>>
>> and have vm_mgr call directly into qcom_scm driver if the UID matches?
> 
> Yes that is the plan, we could have these callbacks as part key data 
> structure like struct gh_rm and update it at very early in setup stage 
> based on UUID match.
> 
> 
>>
>> We have an Android requirement to enable CONFIG_GUNYAH=y and 
>> CONFIG_QCOM_SCM=m, but it wouldn't be possible with this design. The 
> 
> Am not sure how this will work, if gunyah for QCOM Platform is depended 
> on SCM then there is no way that gunyah could be a inbuilt and make scm 
> a module. >
> On the other hand with the existing design gunyah will not be functional 
> until scm driver is loaded and platform hooks are registered. This 
> runtime dependency design does not express the dependency correctly and 
> the only way to know if gunyah is functional is keep trying which can 
> only work after scm driver is probed.
> 
> This also raises the design question on how much of platform hooks 
> dependency is captured at gunyah core and api level, with state of 
> current code /dev/gunyah will be created even without platform hooks and 
> let the userspace use it which then only fail at hyp call level.
> 
> Other issue with current design is, scm module can be unloaded under the 
> hood leaving gunyah with NULL pointers to those platform hook functions. 


This is not possible because SCM module can't be unloaded (except with 
CONFIG_MODULE_FORCE_UNLOAD). I can also increase refcount of qcom_scm.ko 
module to be more correct.

> This is the kind of issues we could see if the dependency is not 
> expressed from bottom up. >
> The current design is not really capturing the depended components 
> accurately.
> 
> Considering platform hooks as a core resource to gunyah on Qualcomm 
> platform is something that needs attention. If we can fix that then it 
> might be doable to have QCOM_SCM=m and CONFIG_GUNYAH=y.
> 

I'm open to ideas. I don't see this as being a real-world issue because 
default defconfig has QCOM_SCM=y and all Qualcomm platforms enable 
QCOM_SCM at least as =m.

Thanks,
Elliot

> 
> --srini
>> platform hooks implementation allows GUNYAH and QCOM_SCM to be enabled 
>> without setting lower bound of the other.
>>
>> - Elliot
