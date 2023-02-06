Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5631068C4FD
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 18:38:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbjBFRiw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 12:38:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjBFRit (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 12:38:49 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC7E2193E5;
        Mon,  6 Feb 2023 09:38:47 -0800 (PST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 316FPhIV029217;
        Mon, 6 Feb 2023 17:38:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=UyTBehJhGYTfTiCAHUGhkAFh1RJhUqMb5u/ze6LLsT8=;
 b=liVSF+i/JpGsqLdWVIaUNmoxX8og+EjEI/Q1nOX3GlMKBqfxGbPC6Rs6hruU3jUy2DNZ
 jAdskr6iUd2MrHnBM+amLCaXRhXx/bsqteEq46pIabd9ZSxc1q/CWEM9HjscH6xVDyqy
 ika6iKWGkpHA5W10mDfXsSgOoT8/3AugAPP+qvVnEm82KvI2XkkV/6aAHwopaK/LTAAB
 dhv0vkTx7/3UG5OLIUXulWZFimYlfPui7J36+4Bb3XX2nqVWtF1Q3s2cx3nZ7oWYsOsg
 QOe8YVLbxwdWG/NGthsAzJfiTR69bb0lqh0JtmdwDSCA7pCkW66ou6a2KYqvD++q6+WD Lg== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nhff2mak6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Feb 2023 17:38:31 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 316HcUsc011723
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 6 Feb 2023 17:38:30 GMT
Received: from [10.134.67.48] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 6 Feb 2023
 09:38:29 -0800
Message-ID: <873fff36-7556-95f3-19e8-d172e8b4e47d@quicinc.com>
Date:   Mon, 6 Feb 2023 09:38:29 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v9 10/27] gunyah: rsc_mgr: Add VM lifecycle RPC
To:     Alex Elder <elder@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Murali Nalajala <quic_mnalajal@quicinc.com>
CC:     Trilok Soni <quic_tsoni@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20230120224627.4053418-1-quic_eberman@quicinc.com>
 <20230120224627.4053418-11-quic_eberman@quicinc.com>
 <4db1c760-10d9-3a22-106a-dda141dd5381@linaro.org>
 <4a584563-1fb7-22fa-5e16-e0cf5e88b76b@linaro.org>
Content-Language: en-US
From:   Elliot Berman <quic_eberman@quicinc.com>
In-Reply-To: <4a584563-1fb7-22fa-5e16-e0cf5e88b76b@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: dCev1PMDFJFTF0gAvXXNwrKMZTuXYWCH
X-Proofpoint-GUID: dCev1PMDFJFTF0gAvXXNwrKMZTuXYWCH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-06_07,2023-02-06_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 spamscore=0 impostorscore=0 priorityscore=1501 bulkscore=0 mlxlogscore=999
 suspectscore=0 lowpriorityscore=0 mlxscore=0 phishscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302060153
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/6/2023 7:41 AM, Alex Elder wrote:
> On 2/2/23 6:46 AM, Srinivas Kandagatla wrote:
>>> +    ret = gh_rm_call(rm, message_id, &req_payload, 
>>> sizeof(req_payload), &resp, &resp_size);
>>> +    if (!ret && resp_size) {
>>
>> Am struggling to understand these type of checks in success case, when 
>> a command is not expecting any response why are we checking for 
>> response here, This sounds like a bug in either RM or hypervisor.
>>
>> Or Is this something that happens due to some firmware behaviour?
>> Could you elobrate on this.
> 
> What I think you're talking about is error checking even when
> it's very clear something "can't happen."  It's a pattern I've
> seen in Qualcomm downstream code, and I believe sometimes it
> is done as "best practice" to avoid warnings from security scans.
> (I might be wrong about this though.)

That's right reasoning.

> 
> I think your underlying point though is that we can just assume
> success means "truly successful," so there's no reason to do any
> additional sanity checks.  We *assume* the hardware is doing the
> correct thing (if it's not, we might as well assume it does
> *nothing* right). >
> So as a very general statement, I think all checks of this type
> should go away (and I think Srini would agree).
> 

I'll remove the checks.
