Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 343B1670BD3
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 23:43:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbjAQWns (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 17:43:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbjAQWmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 17:42:43 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC1CC474C6;
        Tue, 17 Jan 2023 14:29:48 -0800 (PST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30HMQfer016497;
        Tue, 17 Jan 2023 22:29:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=L3lrNdGwPI64g1imGZgAD0hLzBBqC1j4gjf4j57+EE0=;
 b=YHlZxMt+7XD299eEHaW9sYS2VYx8EpJ0BYWQcEHJLxs+Fv6mgxcywKxjVK784CBg02W/
 Aw6sP1cZUsYQhDs/AhtQchbMMHgVeqHJQhEt7dLZgLOwJptqrIE9tu28q5Hph1Hs3OBV
 kXNhaalYKkK9V2zn1TpYv+Tddcu5eDHkxbdrxogNkdVdj0802bm3tnCRkz61IvUz3042
 Sb5Uc3UsXn6Tn1poIKZj+cP5XxgkhrXTPQmgiAZmnkV/WaEjABcJC4bH8nd2+zmQJ2B8
 0cKW1ahfwIB94Sd61ODebkpLrJBp9V3xKDJhORs2VYUA8KJbwTdS5zj/cTVfkXupYd+S uA== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n55cxbcfr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Jan 2023 22:29:33 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30HMTW46019089
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Jan 2023 22:29:32 GMT
Received: from [10.134.67.48] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 17 Jan
 2023 14:29:31 -0800
Message-ID: <59bddf7a-f420-cccd-8029-65052f834c62@quicinc.com>
Date:   Tue, 17 Jan 2023 14:29:31 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v8 05/28] virt: gunyah: Add hypercalls to identify Gunyah
To:     Alex Elder <elder@linaro.org>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Will Deacon" <will@kernel.org>,
        Murali Nalajala <quic_mnalajal@quicinc.com>
CC:     Trilok Soni <quic_tsoni@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "Bagas Sanjaya" <bagasdotme@gmail.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        "Sudeep Holla" <sudeep.holla@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "Lorenzo Pieralisi" <lpieralisi@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-acpi@vger.kernel.org>
References: <20221219225850.2397345-1-quic_eberman@quicinc.com>
 <20221219225850.2397345-6-quic_eberman@quicinc.com>
 <63bbc640-9b0c-95af-3d35-291da0323db3@linaro.org>
 <4e8a7fdf-8c91-cf2f-d369-c67b7584f580@quicinc.com>
 <b2819f68-8672-4909-c787-d1bdbd35da2e@linaro.org>
Content-Language: en-US
From:   Elliot Berman <quic_eberman@quicinc.com>
In-Reply-To: <b2819f68-8672-4909-c787-d1bdbd35da2e@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: miyKeSpHg7UHbXYqZwTyLjr8gHpRWoe-
X-Proofpoint-ORIG-GUID: miyKeSpHg7UHbXYqZwTyLjr8gHpRWoe-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-17_10,2023-01-17_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 suspectscore=0 priorityscore=1501 mlxscore=0 spamscore=0 bulkscore=0
 mlxlogscore=917 malwarescore=0 lowpriorityscore=0 impostorscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301170179
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/17/2023 11:20 AM, Alex Elder wrote:
> On 1/10/23 11:56 AM, Elliot Berman wrote:
>>>> There are two calls to help identify Gunyah:
>>>>
>>>> 1. gh_hypercall_get_uid() returns a UID when running under a Gunyah
>>>>     hypervisor.
>>>> 2. gh_hypercall_hyp_identify() returns build information and a set of
>>>>     feature flags that are supported by Gunyah.
>>>
>>> The first is a "service", while the second is a "hypercall".
>>> Can you explain the distinction?  The sentence at the top
>>> refers to both as "hypercalls".
>>>
>>
>> I learned more details about this to answer your question. "get_uid()" 
>> is a standardized call that is ARM_SMCCC_VENDOR_HYP_CALL_UID_FUNC_ID 
>> defined in include/arm-smccc.h. I'll use that.
> 
> You didn't really explain the distinction between hypercall
> and service in Gunyah.  Both are encoded as "vendor specific
> hypervisor service calls" according to the SVCCC specification.
> I haven't found where ARM_SMCCC_VENDOR_HYP_CALL_UID_FUNC_ID
> gets handled, but I accept your answer that it's basically
> a standard call.  The "get UID" is the only one that's defined
> as a Gunyah "service"; the rest are hypercalls.
> 

This came from a Gunyah implementation detail that separates standard 
(service) calls from the non-standard calls. I was following the 
distinction from Gunyah code not realizing that it's actually a 
standardized call that Linux would already have support for.

Thanks,
Elliot

> It's not a big deal, I just noticed the difference and was
> curious about it.
> 
>                      -Alex
