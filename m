Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B569692CA9
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 02:47:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbjBKBrU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 20:47:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbjBKBrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 20:47:03 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D258E880E7;
        Fri, 10 Feb 2023 17:46:48 -0800 (PST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31B1HZwW010525;
        Sat, 11 Feb 2023 01:46:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=ovVXzjycqxUA6SGDxu1JDmwdG8E+VKO3ntc2Oj96djc=;
 b=M57h//r82ftNagm1cp47l/+DAnRN3QD2Z7ikldmDJLOjGp9IP79HtcUuueM9QoiVGuur
 HTLrJ8k+NfYbqsDo27osfgADNoTS/48eBkVcv2ETMpbouC4EKFAj5TOk9E/GfehLZ8zD
 gN6fdacUB7L3FFLv70PvAQ9aqXvkO7ufjYchEXbCzZKYAHExtCgqqVQKdwZ90zUyJeny
 +MuXWJzh93QkJDVacaZMU99GYTT5eCMs6ysgg29MJrO+IBTYp5EPo1Bt2ZxsYJubEDFN
 6k6jwnDCg3vvK9dodRPgxYQvreGUMYEbDM9tZ6qlqXHjGieIxZDzqLwV252IIEuJnWM4 Gg== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nnurwrjyv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 11 Feb 2023 01:46:28 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31B1kRj1007178
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 11 Feb 2023 01:46:27 GMT
Received: from [10.110.94.147] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Fri, 10 Feb
 2023 17:46:26 -0800
Message-ID: <15cd8816-b474-0535-d854-41982d3bbe5c@quicinc.com>
Date:   Fri, 10 Feb 2023 17:46:22 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: [PATCH] psi: reduce min window size to 50ms
Content-Language: en-US
To:     Suren Baghdasaryan <surenb@google.com>
CC:     David Hildenbrand <david@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Mike Rapoport <rppt@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        <mark.rutland@arm.com>, <will@kernel.org>,
        <virtualization@lists.linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Sukadev Bhattiprolu <quic_sukadev@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
        Patrick Daly <quic_pdaly@quicinc.com>
References: <cover.1676067791.git.quic_sudaraja@quicinc.com>
 <CAJuCfpHWQ8NV=iR3BN+pt1c8FynCnRqyyriHb1gLxFgiNVrwjA@mail.gmail.com>
 <e944536f-a04c-5528-601e-d7f505a761e8@quicinc.com>
 <CAJuCfpGLkkS2yx0d9+2nYtEtxANSH5H3EgCmWZax4N-ieEBG7g@mail.gmail.com>
From:   Sudarshan Rajagopalan <quic_sudaraja@quicinc.com>
In-Reply-To: <CAJuCfpGLkkS2yx0d9+2nYtEtxANSH5H3EgCmWZax4N-ieEBG7g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: w1bZUMTXn1oTZjCT0yhno0szVJq29L-U
X-Proofpoint-ORIG-GUID: w1bZUMTXn1oTZjCT0yhno0szVJq29L-U
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-10_17,2023-02-09_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 spamscore=0 mlxscore=0 adultscore=0 clxscore=1015
 suspectscore=0 malwarescore=0 phishscore=0 lowpriorityscore=0
 impostorscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2302110013
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/10/2023 5:09 PM, Suren Baghdasaryan wrote:
> On Fri, Feb 10, 2023 at 4:45 PM Sudarshan Rajagopalan
> <quic_sudaraja@quicinc.com> wrote:
>>
>> On 2/10/2023 3:03 PM, Suren Baghdasaryan wrote:
>>> On Fri, Feb 10, 2023 at 2:31 PM Sudarshan Rajagopalan
>>> <quic_sudaraja@quicinc.com> wrote:
>>>> The PSI mechanism is useful tool to monitor pressure stall
>>>> information in the system. Currently, the minimum window size
>>>> is set to 500ms. May we know what is the rationale for this?
>>> The limit was set to avoid regressions in performance and power
>>> consumption if the window is set too small and the system ends up
>>> polling too frequently. That said, the limit was chosen based on
>>> results of specific experiments which might not represent all
>> Rightly as you said, the effect on power and performance depends on type
>> of the system - embedded systems, or Android mobile, or commercial VMs
>> or servers. With higher PSI sampling, it may not be much of power impact
>> to embedded systems with low-tier chipsets or performance impact to
>> powerful servers.
>>
>>> usecases. If you want to change this limit, you would need to describe
>>> why the new limit is inherently better than the current one (why not
>>> higher, why not lower).
>> This is in regards to the userspace daemon [1] that we are working on,
>> that dynamically resizes the VM memory based on PSI memory pressure
>> events. With current min window size of 500ms, the PSI monitor sampling
>> period would be 50ms. So to detect increase in memory demand in system
>> and plug-in memory into VM when pressure goes up, the minimum time the
>> process needs to stall for is 50ms before a event can be generated and
>> sent out to userspace and the daemon can do actions.
>>
>> This again I'm talking w.r.t. lightweight embedded systems, where even
>> background kswapd/kcompd (which I'm calling it as natural memory
>> pressure) in the system would be less than 5-10ms stall. So any stall
>> more than 5-10ms would "hint" us that a memory consuming usecase has
>> ranB  and memory may need to be plugged in.
>>
>> So in these cases, having as low as 5ms psimon sampling time would give
>> us faster reaction time and daemon can be responsive more quickly. In
>> general, this will reduce the malloc latencies significantly.
>>
>> Pasting here the same excerpt I mentioned in [1].
> My question is: why do you think 5ms is the optimal limit here? I want
> to avoid a race to the bottom where next time someone can argue that
> they would like to detect a stall within a lower period than 5ms.
> Technically the limit can be as small as one wants but at some point I
> think we should consider the possibility of this being used for a DoS
> attack.

Well the optimal limit should be something which is least destructive? I 
do understand about possibility of DoS attacks, but wouldn't that still 
be possible with 500ms window today? Which will atleast be 1/10th less 
severe compared to 50ms window. The way I see it is - min pressure 
sampling should be such that even the least pressure stall which we 
think is significant should be captured (this could be 5ms or 50ms at 
present) while balancing the power and performance impact across all 
usecases.

At present, Android's LMKD sets 1000ms as window for which it considers 
100ms sampling to be significant. And here, with psi_daemon usecase we 
are saying 5ms sampling would be significant. So there's no actual 
optimal limit, but we must limit as much possible without effecting 
power or performance as a whole. Also, this is just the "minimum 
allowable" window, and system admins can configure it as per the system 
type/requirement.

Also, about possible DoS attacks - file permissions for 
/proc/pressure/... can be set such that not any random user can register 
to psi events right?

>
>> "
>>
>> 4. Detecting increase in memory demand b   when a certain usecase starts
>> in VM that does memory allocations, it will stall causing PSI mechanism
>> to generate a memory pressure event to userspace. To simply put, when
>> pressure increases certain set threshold, it can make educated guess
>> that a memory requiring usecase has ran and VM system needs memory to be
>> added.
>>
>> "
>>
>> [1]
>> https://lore.kernel.org/linux-arm-kernel/1bf30145-22a5-cc46-e583-25053460b105@redhat.com/T/#m95ccf038c568271e759a277a08b8e44e51e8f90b
>>
>>> Thanks,
>>> Suren.
>>>
>>>> For lightweight systems such as Linux Embedded Systems, PSI
>>>> can be used to monitor and track memory pressure building up
>>>> in the system and respond quickly to such memory demands.
>>>> Example, the Linux Embedded Systems could be a secondary VM
>>>> system which requests for memory from Primary host. With 500ms
>>>> window size, the sampling period is 50ms (one-tenth of windwo
>>>> size). So the minimum amount of time the process needs to stall,
>>>> so that a PSI event can be generated and actions can be done
>>>> is 50ms. This reaction time can be much reduced by reducing the
>>>> sampling time (by reducing window size), so that responses to
>>>> such memory pressures in system can be serviced much quicker.
>>>>
>>>> Please let us know your thoughts on reducing window size to 50ms.
>>>>
>>>> Sudarshan Rajagopalan (1):
>>>>     psi: reduce min window size to 50ms
>>>>
>>>>    kernel/sched/psi.c | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> --
>>>> 2.7.4
>>>>
