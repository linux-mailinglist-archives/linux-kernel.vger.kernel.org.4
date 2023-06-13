Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C05372EA47
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 19:54:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238415AbjFMRy3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 13:54:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjFMRy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 13:54:26 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 503291980;
        Tue, 13 Jun 2023 10:54:25 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35DAcQUT005633;
        Tue, 13 Jun 2023 17:54:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=FhHkLfZLOO4yubpLLOyR5XbfFkbOYFd4xCfqu/OhtOM=;
 b=WLBdAf4s58gCWraHEtcEbi+333ggNU+wSCE5XiFjnaS8jpvIAsWxBJSNiBxv0UodIaN/
 BEz2YDZDHPpyoneYq2uItCzMI1Y4EEiV0LmKu/7boadOEbE5VVP1QF2XV07cwLfi+uMT
 vFzYtChsr13HHcUBZ3qgsCzsrJYdsrHZ+6Pr27JpvK+JeDEpKHSalDXfT6979rl+gQqB
 8Q/4AcsVHFUQSCyEA6CKsoRfUFw1dl3g2aTZKNcfzImXyzo7K03HpFqi3TOYmBlhvtG5
 WdLHivwDzAxRw5R1AtJL0psbPiNRrSlR3eDVQgmWC/8SkOFS2DsSUCkxA0K4aVxWl9Gg Vw== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r6nqh17wm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Jun 2023 17:54:08 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35DHs6ds018982
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Jun 2023 17:54:06 GMT
Received: from [10.71.108.253] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Tue, 13 Jun
 2023 10:54:05 -0700
Message-ID: <e907ce20-b523-eedc-9883-18a5484464be@quicinc.com>
Date:   Tue, 13 Jun 2023 10:54:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v13 10/24] gunyah: vm_mgr: Add/remove user memory regions
To:     Will Deacon <will@kernel.org>
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
        "Arnd Bergmann" <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "Bagas Sanjaya" <bagasdotme@gmail.com>,
        Andy Gross <agross@kernel.org>,
        "Catalin Marinas" <catalin.marinas@arm.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <qperret@google.com>,
        <quic_cgoldswo@quicinc.com>, <quic_pdaly@quicinc.com>
References: <20230509204801.2824351-1-quic_eberman@quicinc.com>
 <20230509204801.2824351-11-quic_eberman@quicinc.com>
 <20230519115948.GB2637@willie-the-truck>
 <e22c31bd-10ed-f242-3e72-debf40e01e3c@quicinc.com>
 <20230605141839.GD21212@willie-the-truck>
Content-Language: en-US
From:   Elliot Berman <quic_eberman@quicinc.com>
In-Reply-To: <20230605141839.GD21212@willie-the-truck>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: RRoR3Wi9gjSZJW0Y14gRHykPVltqrZeH
X-Proofpoint-ORIG-GUID: RRoR3Wi9gjSZJW0Y14gRHykPVltqrZeH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-13_20,2023-06-12_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 malwarescore=0 mlxlogscore=607 bulkscore=0
 suspectscore=0 mlxscore=0 priorityscore=1501 impostorscore=0 spamscore=0
 phishscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306130158
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/5/2023 7:18 AM, Will Deacon wrote:
> Hi Elliot,
> 
> [+Quentin since he's looked at the MMU notifiers]
> 
> Sorry for the slow response, I got buried in email during a week away.
> 
> On Fri, May 19, 2023 at 10:02:29AM -0700, Elliot Berman wrote:
>> On 5/19/2023 4:59 AM, Will Deacon wrote:
>>> On Tue, May 09, 2023 at 01:47:47PM -0700, Elliot Berman wrote:
>>>> +	ret = account_locked_vm(ghvm->mm, mapping->npages, true);
>>>> +	if (ret)
>>>> +		goto free_mapping;
>>>> +
>>>> +	mapping->pages = kcalloc(mapping->npages, sizeof(*mapping->pages), GFP_KERNEL_ACCOUNT);
>>>> +	if (!mapping->pages) {
>>>> +		ret = -ENOMEM;
>>>> +		mapping->npages = 0; /* update npages for reclaim */
>>>> +		goto unlock_pages;
>>>> +	}
>>>> +
>>>> +	gup_flags = FOLL_LONGTERM;
>>>> +	if (region->flags & GH_MEM_ALLOW_WRITE)
>>>> +		gup_flags |= FOLL_WRITE;
>>>> +
>>>> +	pinned = pin_user_pages_fast(region->userspace_addr, mapping->npages,
>>>> +					gup_flags, mapping->pages);
>>>> +	if (pinned < 0) {
>>>> +		ret = pinned;
>>>> +		goto free_pages;
>>>> +	} else if (pinned != mapping->npages) {
>>>> +		ret = -EFAULT;
>>>> +		mapping->npages = pinned; /* update npages for reclaim */
>>>> +		goto unpin_pages;
>>>> +	}
>>>
>>> Sorry if I missed it, but I still don't see where you reject file mappings
>>> here.
>>>
>>
>> Sure, I can reject file mappings. I didn't catch that was the ask previously
>> and thought it was only a comment about behavior of file mappings.
> 
> I thought the mention of filesystem corruption was clear enough! It's
> definitely something we shouldn't allow.
> 

I tried preventing file mappings but this breaks memfd used by crosvm. I 
didn't understand the vector you were tracking for filesystem 
corruption. I ran a few basic experiments with real filesystem backed 
memory mappings and didn't observe corruption, but maybe my experiments 
weren't right.

[snip; response to other comments in 
https://lore.kernel.org/all/3bd86221-ee2e-d157-009b-11f6ada98537@quicinc.com/]
