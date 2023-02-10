Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89C59692414
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 18:10:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233041AbjBJRKS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 12:10:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232842AbjBJRKR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 12:10:17 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 969E661D23;
        Fri, 10 Feb 2023 09:10:11 -0800 (PST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31AFbtWJ007873;
        Fri, 10 Feb 2023 17:09:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=BoCl8LyQ/yghiXgI78D3CVAxPcPSQ8XSOsWHMbDFuns=;
 b=ZDA6pZJ7fVVkgdnkYrkN3y6wEm+CS3uAwguXngUy3SF30KiUgLsehBMMv/ua0x+GBTfp
 MuXzq8yDgll6RaUwiBIICyyQvWrpPg0tVNTG05EwWgl6AeTnsdZvqOeDIiVRHFcW5hcQ
 qaWzBlx6XTyJUbtxA3g1I7Lxsj28FXVgHwJJoeRR7qGhMbQaAF7fnSO3E3ozpYOHLWsM
 YeUyL0tmUc2yhC8IuClDJDUyHIKKhWxrThqBylZUTAtqGF3z7LHlinN04vo4oYLjD+QY
 RWIBEqNK7Zui8KUgE9rrQ+ryaMVO9LlGQFjq6e84FS6Cz2ZQuT042DiLfKyTitg/NUT5 cw== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nn61jjmja-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Feb 2023 17:09:49 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31AH9mro000388
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Feb 2023 17:09:48 GMT
Received: from [10.110.1.177] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Fri, 10 Feb
 2023 09:09:47 -0800
Message-ID: <034325f3-e0a0-4371-f83b-affb5a9ca598@quicinc.com>
Date:   Fri, 10 Feb 2023 09:09:46 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v9 24/27] virt: gunyah: Add proxy-scheduled vCPUs
To:     Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>
CC:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Alex Elder <elder@linaro.org>,
        Murali Nalajala <quic_mnalajal@quicinc.com>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Will Deacon" <will@kernel.org>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        "Carl van Schaik" <quic_cvanscha@quicinc.com>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Marc Zyngier <maz@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20230120224627.4053418-1-quic_eberman@quicinc.com>
 <20230120224627.4053418-25-quic_eberman@quicinc.com>
 <20230209103955.GJ332@quicinc.com> <20230210065424.GK332@quicinc.com>
Content-Language: en-US
From:   Elliot Berman <quic_eberman@quicinc.com>
In-Reply-To: <20230210065424.GK332@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: GqV90KfA86PKkLr0euUHhO0khEme7sST
X-Proofpoint-GUID: GqV90KfA86PKkLr0euUHhO0khEme7sST
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-10_11,2023-02-09_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 malwarescore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1015
 bulkscore=0 spamscore=0 adultscore=0 suspectscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302100143
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/9/2023 10:54 PM, Srivatsa Vaddagiri wrote:
> * Srivatsa Vaddagiri <quic_svaddagi@quicinc.com> [2023-02-09 16:10:06]:
> 
>> * Elliot Berman <quic_eberman@quicinc.com> [2023-01-20 14:46:23]:
>>
>>> +static void gh_handle_mmio_return(struct gunyah_vcpu *vcpu, u64 *state)
>>> +{
>>> +	if (!vcpu->vcpu_run->mmio.is_write)
>>> +		memcpy(&state[0], vcpu->vcpu_run->mmio.data, vcpu->vcpu_run->mmio.len);
>>
>> Would be good to do a bound check on length of memcpy I think (in case
>> vcpu_run_resp->state_data[1] is wrong for example).

I think this is the right place to ensure right value is passed. Right 
now, vcpu_run->mmio.len is user accessible and easily provides ability 
for buffer overrun if unchecked. I'm now preserving the length Gunyah 
requested in internal vcpu structure. Userspace can write whatever they 
want to the mmio request, but it won't change the number of bytes that 
we copy from user.

> 
> Sorry I meant to comment that for the other memcpy you had!
> 
> +               memcpy(vcpu->vcpu_run->mmio.data, &vcpu_run_resp->state_data[2],
> +                       vcpu_run_resp->state_data[1]);
> 
> 

Per Srini and Alex, we can trust the values hypervisor sends, so I 
think we can skip this check.

https://lore.kernel.org/all/4a584563-1fb7-22fa-5e16-e0cf5e88b76b@linaro.org/

Thanks,
Elliot
