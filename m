Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 593BE6AFF62
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 08:01:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbjCHHBA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 02:01:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbjCHHAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 02:00:49 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24DF0A1FF8;
        Tue,  7 Mar 2023 23:00:47 -0800 (PST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3283Pm9B004259;
        Wed, 8 Mar 2023 07:00:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : from : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=yo0swHo5+4sRaFUSjMiXCjNEn1jfJ3ZW8sRs62LZQdc=;
 b=cxN+Xo7cG3ukG6Q4CVNdGkq909wB1Jl+O/VzJuFWG2Aj44myzmgAJDY1G9eYhLPKca+c
 /BVFF7UsOtLxT/P+wMaSEkJE8mf9zniRtjumvkVhXMv0tjLKKUbAh86B3/f9vVsafEhD
 dL0+6IojGtUW37z9r/HlufIuEpM8IKudaFki7xlG2PMgcx/hirab5Tt5yv5aocELcpNR
 6Wi9n8r1sRIoXPyWZ/Lmj1ttjNS3eXd/43rR8t8oClSFZqLFb7/5i3VasyxX9ny8rFGl
 n8eIB3frz2QNitWhiCOoP3jb0X6URDy8g1T/eqvfZoNgJr3/Qxann/6Ubt68li3HAt7W fA== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3p6fej0ssk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Mar 2023 07:00:05 +0000
Received: from nasanex01a.na.qualcomm.com ([10.52.223.231])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 328704IB017604
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 8 Mar 2023 07:00:04 GMT
Received: from [10.213.73.166] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 7 Mar 2023
 23:00:01 -0800
Message-ID: <9477d392-aedd-3187-762d-8e19fdc41c29@quicinc.com>
Date:   Wed, 8 Mar 2023 12:29:57 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH V6] arm64: perf: Make exporting of pmu events configurable
Content-Language: en-US
From:   Srinivasarao Pathipati <quic_c_spathi@quicinc.com>
To:     Will Deacon <will@kernel.org>
CC:     <mark.rutland@arm.com>, <peterz@infradead.org>, <mingo@redhat.com>,
        <acme@kernel.org>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>,
        <catalin.marinas@arm.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1654779589-19937-1-git-send-email-quic_c_spathi@quicinc.com>
 <20220624121825.GB18561@willie-the-truck>
 <ac0ef25b-b9a9-b4d5-381c-4e970a258cc9@quicinc.com>
In-Reply-To: <ac0ef25b-b9a9-b4d5-381c-4e970a258cc9@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ykY-PixxMzbm3OpccFuJ0u0TtWJjnYvQ
X-Proofpoint-ORIG-GUID: ykY-PixxMzbm3OpccFuJ0u0TtWJjnYvQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-08_02,2023-03-07_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 mlxscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 impostorscore=0 clxscore=1011 phishscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303080059
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/13/2022 9:35 AM, Srinivasarao Pathipati wrote:
>
> On 6/24/2022 5:48 PM, Will Deacon wrote:
>> On Thu, Jun 09, 2022 at 06:29:49PM +0530, Srinivasarao Pathipati wrote:
>>> The PMU export bit (PMCR_EL0.X) is getting reset during pmu reset,
>>> Make it configurable using sysctls to enable/disable at runtime.
>>>
>>> Signed-off-by: Srinivasarao Pathipati <quic_c_spathi@quicinc.com>
>>> ---
>>> Changes since V5:
>>>     - removed configuring with kernel parameters.
>>> Changes since V4:
>>>     - Registering sysctls dynamically for only arm64 as suggested by 
>>> Will
>>>     - Not removed the code to configure with kernel parameters
>>>       as the sysctl's kernel parameter(sysctl.kernel.export_pmu_events)
>>>       is not working at early bootup. pmu_reset() getting called before
>>>       sysctl's kernel parameter is set.
>>> Changes since V3:
>>>     - export bit is now configurable with sysctl
>>>     - enabling export bit on reset instead of retaining
>>>
>>> Changes since V2:
>>>     Done below changes as per Will's comments
>>>     - enabling pmcr_x now configurable with kernel parameters and
>>>       by default it is disabled.
>>>
>>> Changes since V1:
>>>     - Preserving only PMCR_X bit as per Robin Murphy's comment.
>>>
>>> ---
>>>   Documentation/admin-guide/sysctl/kernel.rst | 11 +++++++++++
>>>   arch/arm64/kernel/perf_event.c              | 13 +++++++++++++
>>>   2 files changed, 24 insertions(+)
>>>
>>> diff --git a/Documentation/admin-guide/sysctl/kernel.rst 
>>> b/Documentation/admin-guide/sysctl/kernel.rst
>>> index ddccd10..c2ecd84 100644
>>> --- a/Documentation/admin-guide/sysctl/kernel.rst
>>> +++ b/Documentation/admin-guide/sysctl/kernel.rst
>>> @@ -267,6 +267,17 @@ domain names are in general different. For a 
>>> detailed discussion
>>>   see the ``hostname(1)`` man page.
>>>     +export_pmu_events (arm64 only)
>>> +==============================
>>> +
>>> +Controls the PMU export bit (PMCR_EL0.X), which enables the 
>>> exporting of
>>> +events over an IMPLEMENTATION DEFINED PMU event export bus to 
>>> another device.
>>> +
>>> +0: disables exporting of events (default).
>>> +
>>> +1: enables exporting of events.
>>> +
>>> +
>>>   firmware_config
>>>   ===============
>>>   diff --git a/arch/arm64/kernel/perf_event.c 
>>> b/arch/arm64/kernel/perf_event.c
>>> index cb69ff1..a8c32a0 100644
>>> --- a/arch/arm64/kernel/perf_event.c
>>> +++ b/arch/arm64/kernel/perf_event.c
>>> @@ -298,6 +298,7 @@ PMU_FORMAT_ATTR(long, "config1:0");
>>>   PMU_FORMAT_ATTR(rdpmc, "config1:1");
>>>     static int sysctl_perf_user_access __read_mostly;
>>> +static int sysctl_export_pmu_events __read_mostly;
>>>     static inline bool armv8pmu_event_is_64bit(struct perf_event 
>>> *event)
>>>   {
>>> @@ -1047,6 +1048,9 @@ static void armv8pmu_reset(void *info)
>>>       if (armv8pmu_has_long_event(cpu_pmu))
>>>           pmcr |= ARMV8_PMU_PMCR_LP;
>>>   +    if (sysctl_export_pmu_events)
>>> +        pmcr |= ARMV8_PMU_PMCR_X;
>> I think we need to do this in armv8pmu_start() rather than 
>> armv8pmu_reset(),
>> otherwise any changes to the sysctl at runtime won't take effect 
>> unless you
>> do something like re-online the CPU.
>>
>> Will
>
> Hi Will ,
>
> We think it may not work.   Say for example pmu->reset is called which 
> disables the exporting of events,
> and pmu->start not called. This would lead to missing of events.
>
> How about enabling it in both reset and start functions? do you see 
> any issue?
>
> --Srinivas

Hi Will ,

Could you please suggest ,better way to fix this.

