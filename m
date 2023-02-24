Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07EB36A2056
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 18:15:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbjBXRPI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 12:15:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjBXRPG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 12:15:06 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2523312F3E;
        Fri, 24 Feb 2023 09:15:04 -0800 (PST)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31OF15tv006904;
        Fri, 24 Feb 2023 17:14:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=4DX+Ss95rJ/0e4IqY9IcRXeG1Ae0+xviDQHJIAilU2k=;
 b=kUhbmQpRxEoBrFb0Kt9OWa53lDpM2L3AksNdd7h1/aAyxCK/W6SS2AhQEdS29asowzoI
 PjK1pHHjjgsaJtJdLJBZ9tFuKpDBpVbl+IFG7sAjQOE6qymX7wdymRUMVEihjJoAG2b7
 ro/nmMGyJmp6MmMDf9rWXRu8X0Scnkpxfb+YWbRrcuimFA74J01SZW6kAYNz/Lfp51E+
 9YKLRd+XC9hGAkdmdkP3ANLU1ODfyjLjizlRxQq2KZTsPi0TF9TYQ/XGw6e+hI3FGU8I
 YxUfMTIz95YEbWfBnEaXZhIvnXO7moxeodzuFTFEHnkMhkmDvBGHYJwNf3XNrPJoY5T4 Zg== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nxugh923d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Feb 2023 17:14:37 +0000
Received: from nasanex01a.na.qualcomm.com ([10.52.223.231])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31OHEbu1016216
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Feb 2023 17:14:37 GMT
Received: from [10.110.82.3] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 24 Feb
 2023 09:14:36 -0800
Message-ID: <657d91c7-60ca-a64b-ad29-1d6dcc4b32ac@quicinc.com>
Date:   Fri, 24 Feb 2023 09:14:35 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [RFC PATCH 0/6] Add basic Minidump kernel driver support
Content-Language: en-US
To:     Mukesh Ojha <quic_mojha@quicinc.com>,
        Brian Masney <bmasney@redhat.com>
CC:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <keescook@chromium.org>,
        <tony.luck@intel.com>, <gpiccoli@igalia.com>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-hardening@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <1676978713-7394-1-git-send-email-quic_mojha@quicinc.com>
 <Y/deHzijzvuvCJ2M@x1> <47542dbb-8cf3-6eae-a38e-910d38bd960b@quicinc.com>
From:   Trilok Soni <quic_tsoni@quicinc.com>
In-Reply-To: <47542dbb-8cf3-6eae-a38e-910d38bd960b@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: yKk6EAcEmKYClVQn4YzHl-1FuharUGK_
X-Proofpoint-ORIG-GUID: yKk6EAcEmKYClVQn4YzHl-1FuharUGK_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-24_12,2023-02-24_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1011
 bulkscore=0 phishscore=0 mlxlogscore=999 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302240136
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/24/2023 2:40 AM, Mukesh Ojha wrote:
> Thanks Brian for your interest in this series.
> 
> On 2/23/2023 6:07 PM, Brian Masney wrote:
>> On Tue, Feb 21, 2023 at 04:55:07PM +0530, Mukesh Ojha wrote:
>>> Minidump is a best effort mechanism to collect useful and predefined 
>>> data
>>> for first level of debugging on end user devices running on Qualcomm 
>>> SoCs.
>>> It is built on the premise that System on Chip (SoC) or subsystem 
>>> part of
>>> SoC crashes, due to a range of hardware and software bugs. Hence, the
>>> ability to collect accurate data is only a best-effort. The data 
>>> collected
>>> could be invalid or corrupted, data collection itself could fail, and 
>>> so on.
>>>
>>> Qualcomm devices in engineering mode provides a mechanism for generating
>>> full system ramdumps for post mortem debugging. But in some cases it's
>>> however not feasible to capture the entire content of RAM. The minidump
>>> mechanism provides the means for selecting which snippets should be
>>> included in the ramdump.
>>>
>>> The core of minidump feature is part of Qualcomm's boot firmware code.
>>> It initializes shared memory (SMEM), which is a part of DDR and
>>> allocates a small section of SMEM to minidump table i.e also called
>>> global table of content (G-ToC). Each subsystem (APSS, ADSP, ...) has
>>> their own table of segments to be included in the minidump and all get
>>> their reference from G-ToC. Each segment/region has some details like
>>> name, physical address and it's size etc. and it could be anywhere
>>> scattered in the DDR.
>>>
>>> Existing upstream Qualcomm remoteproc driver[1] already supports 
>>> minidump
>>> feature for remoteproc instances like ADSP, MODEM, ... where predefined
>>> selective segments of subsystem region can be dumped as part of
>>> coredump collection which generates smaller size artifacts compared to
>>> complete coredump of subsystem on crash.
>>>
>>> [1]
>>> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/drivers/remoteproc/qcom_common.c#n142
>>>
>>> In addition to managing and querying the APSS minidump description,
>>> the Linux driver maintains a ELF header in a segment. This segment
>>> gets updated with section/program header whenever a new entry gets
>>> registered.
>>
>> I'd like to test this series plus your series that sets the multiple
>> download modes.
> 
> Sure, you are welcome, but for that you need a device running with 
> Qualcomm SoC and if it has a upstream support.
> 
> Also, testing of this patch needs some minimal out of tree patches and
> i can help you with that.
> 
>> Can you include documentation about how to actually use
>> this new feature?
> 
> Will surely do, Since this is still RFC, and i am doubtful on the path 
> of it in documentation directory.

This is RFC anyways, you can start w/ the directory which you think best 
fits here. The point here is to have the documentation file rather than 
path to be fixed.

You can start w/ Documentation/features/debug and let's see what others 
have any suggestion. Please add a file in your next revision without 
worrying about the path for now.

---Trilok Soni

