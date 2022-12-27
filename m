Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB0A1656FCA
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 22:11:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231426AbiL0VKh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 16:10:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232820AbiL0VJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 16:09:22 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1797A396;
        Tue, 27 Dec 2022 13:07:34 -0800 (PST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BRKx1oH028995;
        Tue, 27 Dec 2022 21:06:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=1uhLU5AfBzQHfS2v22R1XGgfpb7X30fYPSm78dQqBO0=;
 b=ihTCo4qqNMz0jpHc8k6+p31Zm9UHg2BppgNNu7i+v83cYdtE6G3DPgsmebzWePVGutp9
 rb8vl9Bi7viJl2fQAk21SOsC9GLYAvZce6899TjAA+3kwI1cKrGrsbK8nnK8b+9Q9s73
 iPmqs4lM5kR0n3KjbUWLIv/ygLciT6i0z3qjrVa96O/dAQMlmhr3/4aYjoE6vl3SCfp1
 cDCJvO5WojXeRsKcKxXqmFSEfzJDAMhpTHfPICxOSqxYUOAGXoZkYTWG4OsXbjeBpYPw
 S7SLWzhgsOre7nYUNRlo9kNtDupxPRWkddHrhN3FZQeR4mpb98ftTYU2d9VkLfn7CvSq Rw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mr1r1guwx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Dec 2022 21:06:38 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2BRL6b7P008573
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Dec 2022 21:06:37 GMT
Received: from [10.110.31.102] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 27 Dec
 2022 13:06:36 -0800
Message-ID: <cd0b6275-ec26-d364-6a38-6607230d82cf@quicinc.com>
Date:   Tue, 27 Dec 2022 13:06:35 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [RFC PATCH 03/14] ASoC: qcom: Add USB backend ASoC driver for Q6
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>
CC:     <srinivas.kandagatla@linaro.org>, <mathias.nyman@intel.com>,
        <perex@perex.cz>, <lgirdwood@gmail.com>, <andersson@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <Thinh.Nguyen@synopsys.com>,
        <bgoswami@quicinc.com>, <tiwai@suse.com>, <robh+dt@kernel.org>,
        <agross@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <devicetree@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <quic_jackp@quicinc.com>, <quic_plai@quicinc.com>
References: <20221223233200.26089-1-quic_wcheng@quicinc.com>
 <20221223233200.26089-4-quic_wcheng@quicinc.com> <Y6bAQ8hDLkvrvjQQ@kroah.com>
 <Y6rtdy4NPfi/KOqd@sirena.org.uk> <Y6r26VfIfpE8zpPY@kroah.com>
 <Y6sLH+8nVFImL0Oo@sirena.org.uk>
From:   Wesley Cheng <quic_wcheng@quicinc.com>
In-Reply-To: <Y6sLH+8nVFImL0Oo@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: vi3zFIMNnJv1JDR_lUmFjx81nWldrRnX
X-Proofpoint-ORIG-GUID: vi3zFIMNnJv1JDR_lUmFjx81nWldrRnX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-27_16,2022-12-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 phishscore=0 mlxlogscore=506 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 spamscore=0 impostorscore=0 adultscore=0 malwarescore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2212270176
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark/Greg,

On 12/27/2022 7:11 AM, Mark Brown wrote:
> On Tue, Dec 27, 2022 at 02:45:13PM +0100, Greg KH wrote:
>> On Tue, Dec 27, 2022 at 01:04:55PM +0000, Mark Brown wrote:
>>> On Sat, Dec 24, 2022 at 10:02:59AM +0100, Greg KH wrote:
> 
>>>>> + * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
> 
>>>> All of the code in this patch series is older than 2022 as I know it has
>>>> been in shipping devices for many years.  Please use the proper
>>>> copyright year to make your lawyers happy...
> 
>>> Are you *positive* about this.  Based on some preparatory discussions
>>> the Qualcomm people had with Takashi and I it seemed like this was a new
>>> version of existing concepts.  I'm sure they had something already but
>>> it's not obvious to me that they're just posting the same code.
> 
>> I thought that this same code has been shipping in devices for a few
>> years now in the last few Samsung phone models.  Is this not the same
>> code that is in those devices?
> 
>> If not, why not, what happened to that codebase that makes it not worthy
>> of being submitted upstream?
> 
> I don't specifically know anything about that code but I'd expect that
> for out of tree code breaking new ground like this there'd be a strong
> likelyhood that there'd be design level issues and that's what the pre
> submission discussions were all about - how to fit the concept into the
> kernel subsystems in a way that might be maintainable.  There's also
> been the whole transition to their new DSP firmware going on.  It's
> possible that what was shipped was implemented in the same way with the
> same code but I'd not assume that this is the case without actually
> comparing the two.

It's correct that all the ASoC related patches are new, and didn't exist 
previously in QC products.  It is due to the fact that Android has a 
different ALSA userspace concept which allowed for a lot of the Q6 audio 
front end (AFE) communication to be done from userspace, I believe. 
This is the reason that we had to introduce this new ASoC based design.

I can't comment much more about the Android ALSA design, maybe @Patrick 
Lai can.

Thanks
Wesley Cheng
