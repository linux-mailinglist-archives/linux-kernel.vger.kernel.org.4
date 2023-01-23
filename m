Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D79C6788DE
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 21:58:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232514AbjAWU6J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 15:58:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232315AbjAWU6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 15:58:01 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60FE5527F;
        Mon, 23 Jan 2023 12:57:44 -0800 (PST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30NJKJoI009387;
        Mon, 23 Jan 2023 20:37:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=M1OdZXzC4tuzMgoDsAYRcIKnYJQl0s4E22LnKPyWwhc=;
 b=jPHIgOp8WiJsF8FDCWXmaLhTbAiAC130WTHWWIQ2QKurPi5O0QuGh/FqEkipSgXuCTAf
 G9NNAnfrpW4h5HBvejNkvcaB8tFN5anHHhaWJW/0+elDr7sywUPSpRlzUBEr7NCbKJ6v
 fDeebUNQnCUG28guD0l+r/0yVWndjID47eUXASxgGPuHA9hhzp/ZZO/fjmAAff0trC/+
 OAJFQSZ6N0bgMC5bkFXPoNdnw+VyNUtO+rCGvn1LOX32WzHOPQ7UjgrPJwE3yPGykqUP
 eyu30+Ou2JQW/ksnkrwxWM01+XfvpkYECRuRjfCvi2lITnuPxSv7Xqe8+ZsB9DllzJXf cw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n89fm3t26-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Jan 2023 20:37:29 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30NKbSJg021886
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Jan 2023 20:37:28 GMT
Received: from [10.38.245.0] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 23 Jan
 2023 12:37:26 -0800
Message-ID: <6dd7b0b0-f6fb-9de4-c365-d6cbfe04f2c0@quicinc.com>
Date:   Mon, 23 Jan 2023 12:37:05 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH] interconnect: Skip call into provider if initial bw is
 zero
Content-Language: en-US
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Vivek Aknurwar <quic_viveka@quicinc.com>, <djakov@kernel.org>
CC:     <quic_okukatla@quicinc.com>, <linux-pm@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1673647679-15216-1-git-send-email-quic_viveka@quicinc.com>
 <83a7bfed-3b16-3d01-b1b2-f197252bd0b1@linaro.org>
 <5e1f37ba-494a-19d2-e412-7631508ab142@linaro.org>
 <151790dd-02e5-a1f5-aab5-360f39e21c57@quicinc.com>
 <35dcb764-e340-5fe7-6637-cdb5f84266ce@linaro.org>
From:   Mike Tipton <quic_mdtipton@quicinc.com>
In-Reply-To: <35dcb764-e340-5fe7-6637-cdb5f84266ce@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 3aBFXYOBaWUZ2lZ7QI6AZyDGu69LlIaF
X-Proofpoint-GUID: 3aBFXYOBaWUZ2lZ7QI6AZyDGu69LlIaF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-23_12,2023-01-23_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1011
 malwarescore=0 bulkscore=0 phishscore=0 lowpriorityscore=0 mlxlogscore=999
 mlxscore=0 priorityscore=1501 adultscore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301230196
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/19/2023 3:56 PM, Bryan O'Donoghue wrote:
> On 19/01/2023 22:18, Vivek Aknurwar wrote:
>> Hi Bryan,
>> Thanks for taking time to review the patch.
>>
>> On 1/13/2023 5:40 PM, Bryan O'Donoghue wrote:
>>> On 14/01/2023 01:24, Bryan O'Donoghue wrote:
>>>> On 13/01/2023 22:07, Vivek Aknurwar wrote:
>>>>> Currently framework sets bw even when init bw requirements are zero 
>>>>> during
>>>>> provider registration, thus resulting bulk of set bw to hw.
>>>>> Avoid this behaviour by skipping provider set bw calls if init bw 
>>>>> is zero.
>>>>>
>>>>> Signed-off-by: Vivek Aknurwar <quic_viveka@quicinc.com>
>>>>> ---
>>>>>   drivers/interconnect/core.c | 17 ++++++++++-------
>>>>>   1 file changed, 10 insertions(+), 7 deletions(-)
>>>>>
>>>>> diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
>>>>> index 25debde..43ed595 100644
>>>>> --- a/drivers/interconnect/core.c
>>>>> +++ b/drivers/interconnect/core.c
>>>>> @@ -977,14 +977,17 @@ void icc_node_add(struct icc_node *node, 
>>>>> struct icc_provider *provider)
>>>>>       node->avg_bw = node->init_avg;
>>>>>       node->peak_bw = node->init_peak;
>>>>> -    if (provider->pre_aggregate)
>>>>> -        provider->pre_aggregate(node);
>>>>> -
>>>>> -    if (provider->aggregate)
>>>>> -        provider->aggregate(node, 0, node->init_avg, node->init_peak,
>>>>> -                    &node->avg_bw, &node->peak_bw);
>>>>> +    if (node->avg_bw || node->peak_bw) {
>>>>> +        if (provider->pre_aggregate)
>>>>> +            provider->pre_aggregate(node);
>>>>> +
>>>>> +        if (provider->aggregate)
>>>>> +            provider->aggregate(node, 0, node->init_avg, 
>>>>> node->init_peak,
>>>>> +                        &node->avg_bw, &node->peak_bw);
>>>>> +        if (provider->set)
>>>>> +            provider->set(node, node);
>>>>> +    }
>>>>> -    provider->set(node, node);
>>>>>       node->avg_bw = 0;
>>>>>       node->peak_bw = 0;
>>>>
>>>> I have the same comment/question for this patch that I had for the 
>>>> qcom arch specific version of it. This patch seems to be doing at a 
>>>> higher level what the patch below was doing at a lower level.
>>>>
>>>> https://lore.kernel.org/lkml/1039a507-c4cd-e92f-dc29-1e2169ce5078@linaro.org/T/#m0c90588d0d1e2ab88c39be8f5f3a8f0b61396349
>>>>
>>>> what happens to earlier silicon - qcom silicon which previously made 
>>>> explicit zero requests ?
>>
>> This patch is to optimize and avoid all those bw 0 requests on each 
>> node addition during probe (which results in rpmh remote calls) for 
>> upcoming targets.
> 
> So why not change it just for rpmh ?
> 
> You are changing it for rpm here, as well as for Samsung and NXP 
> interconnects.
> 

This isn't actually changing it for all providers. Only for those that 
define the get_bw() callback. Right now that's only qcom/msm8974 and 
imx/imx. If get_bw() isn't defined, then icc_node_add() defaults to 
INT_MAX. So, the logical behavior in that case is unchanged. Which means 
this isn't even changing the behavior for rpmh yet, either.

We're also working on changes to align our downstream, qcom-specific, 
rpmh-specific sync-state approach with the common upstream approach. 
Part of which includes adding a get_bw() callback for rpmh that only 
returns non-zero BW for nodes already enabled from bootloaders or are 
otherwise marked as critical for HLOS operation (i.e. keepalive). 
Currently, the upstream rpmh driver doesn't define get_bw(), which means 
the framework votes INT_MAX for everything even if most of the nodes 
aren't needed yet.

Currently, with the upstream rpmh-based drivers this is just a 
performance/power optimization issue. It doesn't cause any functional 
failures. However, downstream we have additional nodes that use separate 
BCM voters than just the "apps" voter. These secondary voters aren't 
accessible when the providers probe, since they require additional 
regulator dependencies to be met first. We rely on the client voting for 
the required regulators before voting to interconnect for these nodes. 
So, we need to prevent the framework from calling our set() callbacks 
when adding these secondary nodes, otherwise it'll cause bus errors and 
crash the kernel. It's not always safe to assume that every node is 
immediately capable of being voted for when it's added.

We currently work around this by "stubbing" our pre_aggregate, 
aggregate, and set() callbacks when adding the nodes and only set them 
to the real callbacks after we've finished adding everything. But that 
stops being a valid workaround when we move to the upstream sync-state 
approach, since we're relying on the set() callback from icc_node_add() 
for placing the initial proxy votes for "keepalive" and other nodes 
already enable from boot.

I'm sure the secondary voters will make their way upstream some day, but 
not clear when yet. There are no upstream drivers in a state ready to 
use them yet anyway. But the other changes we're working on to add 
get_bw() to icc-rpmh providers to reduce the number of unnecessary calls 
during probe could go in sooner as an optimization.

It's not easy to implement this purely on the provider side, since we 
can't just always ignore zero votes. We need to honor zero votes that 
are made post-init so that things actually turn off. Thus, any logic 
that short-circuits the zero requests would need to be done only for the 
very first request. Each node would have to track if it's been called 
once already. And we'd have to spread that logic across pre_aggregate, 
aggregate, and set. There's isn't just one simple place to implement 
this on the provider side. This is much more easily handled on the 
framework side.


> Taking rpm as an example, for certain generations of silicon we make an 
> explicit zero call.
> 
> https://git.codelinaro.org/clo/la/kernel/msm-3.18/-/blob/LA.BR.1.2.9-00810-8x09.0/drivers/platform/msm/msm_bus/msm_bus_bimc.c#L1367
> 
> Here's the original RPM commit that sets a zero
> 
> https://git.codelinaro.org/clo/la/kernel/msm-3.18/-/commit/d91d108656a7a44a6dfcfb318a25d39c5418e54b
> >>>> 
https://lore.kernel.org/lkml/1039a507-c4cd-e92f-dc29-1e2169ce5078@linaro.org/T/#m589e8280de470e038249bb362634221771d845dd
>>>>
>>>> https://lkml.org/lkml/2023/1/3/1232
>>>>
>>>> Isn't it a better idea to let lower layer drivers differentiate what 
>>>> they do ?
>>
>> AFAIU lower layer driver can/should not differentiate between normal 
>> flow calls vs made as a result from probe/initialization of driver. 
>> Hence even bw 0 request is honored as like client in general wish to 
>> vote 0 as in an normal use case.
> 
> But surely if I vote zero, then I mean to vote zero ?
> 
> Do we know that for every architecture and for every different supported 
> that ignoring a zero vote is the right thing to do ?
> 
> I don't think we do know that.
> 

Relying on the existing behavior of icc_node_add() calling set() when 
the node's BW is already zero should be generally unnecessary. If the 
node is already physically disabled in HW, then disabling again should 
be a don't-care. And if the node is already physically enabled in HW, 
then get_bw() should logically return something non-zero for it. 
get_bw() is supposed to return the *current* BW. It's not always 
possible to know exactly what the BW is, so often the distinction may 
just be between zero and INT_MAX. But ultimately it would ideally return 
the actual current BW vote, such that the initial votes placed by 
icc_node_add() match the preexisting votes from boot and don't 
unnecessarily enable or dramatically increase BW of many nodes 
irrelevant for early kernel boot.

If the provider simply has no idea, then it can choose not to define the 
get_bw() callback and the framework will assume INT_MAX for everything. 
But if the provider wants to optimize the initial BW voting, it can 
define the get_bw() callback to inform the framework which nodes are 
already enabled and require proxy voting.

And relying on icc_node_add() calling set() for zero BW should also be 
unnecessary for cleaning up nodes enabled from boot that are no longer 
necessary. Because in either case if get_bw() returns non-zero or 
get_bw() isn't defined at all, then the framework has non-zero initial 
BW for them. And if no consumers explicitly vote for them, then they'll 
be disabled in icc_sync_state(). Sync-state is the proper place to 
disable resources no longer needed from boot.

> https://lore.kernel.org/linux-arm-msm/20230116132152.405535-1-konrad.dybcio@linaro.org/
> 
> I think for older rpm this is a departure from long existing logic.
> 
> Maybe its entirely benign but, IMO you should be proposing this change 
> at the rpmh level only, not at the top level across multiple different 
> interconnect arches.
> 
> ---
> bod
