Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FDEE6DFCEC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 19:48:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbjDLRsi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 13:48:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjDLRsf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 13:48:35 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1F46EB;
        Wed, 12 Apr 2023 10:48:30 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33CA99Mq022716;
        Wed, 12 Apr 2023 17:48:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=EyLhPn//btq9T0BetjGBN+pTDY5gSmiuWU+VuI7EBnQ=;
 b=DT6s9HosGa1Q11OBaTx2/dpm4+AwI4tlNOpu8NjJvJp9ObNqW/9eqa16CYyVBtPktObP
 HP8wcf133TT2F7cPTTvL56SdGzsVdQ4YsElC4auyNDtppvXqkyqjRDN65evaliWo0Aca
 gUsVGHEE4LSbkICr3vf5vqJ1TaYH1soRT2Uo/dMEw5V4GLawEuR5hfYWrw5T+6o2/vhy
 Xou3XMdxBmQ3Rs37u/srgYSWoXvSdpNDemqJdurPJFAP3F9UbWj4KwrohKH/xkZvaEkj
 F9XEezVWEu1blY3elv4mDOTpqbGCFhBXGbYceMZYAJ9JaH0NJZIv7VH20E0tuY2215lQ jg== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pwqn1he21-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Apr 2023 17:48:21 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33CHmKwN008631
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Apr 2023 17:48:20 GMT
Received: from [10.110.115.18] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Wed, 12 Apr
 2023 10:48:18 -0700
Message-ID: <8310d7ce-7ac0-05a6-b95a-c18a498f7644@quicinc.com>
Date:   Wed, 12 Apr 2023 10:48:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [Freedreno] [PATCH] drm/msm/dpu: add DSC range checking during
 resource reservation
Content-Language: en-US
To:     Marijn Suijten <marijn.suijten@somainline.org>
CC:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        <freedreno@lists.freedesktop.org>, <quic_sbillaka@quicinc.com>,
        <airlied@gmail.com>, <andersson@kernel.org>, <robdclark@gmail.com>,
        <dri-devel@lists.freedesktop.org>, <dianders@chromium.org>,
        <vkoul@kernel.org>, <agross@kernel.org>, <daniel@ffwll.ch>,
        <linux-arm-msm@vger.kernel.org>, <swboyd@chromium.org>,
        <sean@poorly.run>, <linux-kernel@vger.kernel.org>
References: <1681247380-1607-1-git-send-email-quic_khsieh@quicinc.com>
 <qvgbm3wimai3jytnikbcixipvwqn2uywqpg4mn6mjh5atergfx@wa4edsrp7y22>
 <96416911-bca3-b007-b036-1c4463e83aaa@quicinc.com>
 <24c5aa23-9b3c-787c-10aa-e9d5ad91512b@linaro.org>
 <49479b93-b364-d882-7a77-08223a94ed36@quicinc.com>
 <tczt5alqbadkodgorqm4pljpqkn5bc4efpxiy3em7bgu7gqaka@3cdszu4k6rhk>
From:   Abhinav Kumar <quic_abhinavk@quicinc.com>
In-Reply-To: <tczt5alqbadkodgorqm4pljpqkn5bc4efpxiy3em7bgu7gqaka@3cdszu4k6rhk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: cfDe27o5uOMI5L-02-GKp4b40WpZrkSQ
X-Proofpoint-ORIG-GUID: cfDe27o5uOMI5L-02-GKp4b40WpZrkSQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-12_08,2023-04-12_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 lowpriorityscore=0 phishscore=0 adultscore=0 bulkscore=0 suspectscore=0
 impostorscore=0 clxscore=1015 mlxlogscore=999 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304120153
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/12/2023 12:38 AM, Marijn Suijten wrote:
> On 2023-04-11 18:50:24, Abhinav Kumar wrote:
>>
>>
>> On 4/11/2023 6:06 PM, Dmitry Baryshkov wrote:
>>> On 12/04/2023 01:32, Abhinav Kumar wrote:
>>>> Hi Marijn
>>>>
>>>> On 4/11/2023 3:24 PM, Marijn Suijten wrote:
>>>>> Again, don't forget to include previous reviewers in cc, please :)
>>>>>
>>>>> On 2023-04-11 14:09:40, Kuogee Hsieh wrote:
>>>>>> Perform DSC range checking to make sure correct DSC is requested before
>>>>>> reserve resource for it.
>>>
>>> nit: reserving
>>>
>>>>>
>>>>> This isn't performing any range checking for resource reservations /
>>>>> requests: this is only validating the constants written in our catalog
>>>>> and seems rather useless.  It isn't fixing any real bug either, so the
>>>>> Fixes: tag below seems extraneous.
>>>>>
>>>>> Given prior comments from Abhinav that "the kernel should be trusted",
>>>>> we should remove this validation for all the other blocks instead.
>>>>>
>>>>
>>>> The purpose of this check is that today all our blocks in RM use the
>>>> DSC_* enum as the size.
>>>>
>>>> struct dpu_hw_blk *dsc_blks[DSC_MAX - DSC_0];
>>>>
>>>> If the device tree ends up with more DSC blocks than the DSC_* enum,
>>>> how can we avoid this issue today? Not because its a bug in device
>>>> tree but how many static number of DSCs are hard-coded in RM.
>>>
>>> We don't have these blocks in device tree. And dpu_hw_catalog shouldn't
>>> use indices outside of enum dpu_dsc.
>>>
>>
>> ah, my bad, i should have said catalog here. Okay so the expectation is
>> that dpu_hw_catalog.c will program the indices to match the RM limits.
>>
>> I still stand by the fact that the hardware capabilities coming from
>> catalog should be trusted but this is just the SW index.
> 
> These come from the catalog.  Here's how it looks for sdm845:
> 
> 	static struct dpu_dsc_cfg sdm845_dsc[] = {
> 		DSC_BLK("dsc_0", DSC_0, 0x80000, 0),
> 		DSC_BLK("dsc_1", DSC_1, 0x80400, 0),
> 		DSC_BLK("dsc_2", DSC_2, 0x80800, 0),
> 		DSC_BLK("dsc_3", DSC_3, 0x80c00, 0),
> 	};
> 
> The only way to trigger this newly introduced range check is by omitting
> the DSC_x constants and manually writing e.g. an out-of-range value 10
> here, or setting DSC_NONE.  This is only allowed for interfaces.
> 

Correct, its just working on an implicit understanding that the indices 
in the catalog which might still be right stick to the RM limits.

Thats why this is not bad to have.

> As we trust the kernel, hence this config, the if introduced here (and
> already present for other blocks) has pretty much no effect.
> 
>>> Marijn proposed to pass struct dpu_foo_cfg directly to
>>> dpu_hw_foo_init(). This will allow us to drop these checks completely.
>>>
>>
>> Ah okay, sure, would like to see that then uniformly get rid of these
>> checks.
> 
> This suggested change won't make a difference to the range check
> introduced here.  The range-check validates that the catalog sets `id`
> to a sensible value (since we do not use array indices for this, we
> could even decide to do so via `[DSC_0] = (struct dpu_dsc_cfg){ ... }`
> if we so desire in the future).
> 
> It'll only get rid of the `_xxx_offset` functions looping through the
> arrays in the catalog again, to find a catalog pointer with matching
> `id` while we aleady have exactly that pointer here via &cat->dsc[i].
> 
> The only semantic difference incurred by the change is when the same
> `id` value is (erroneously) used multiple times in an array: the current
> implementation will always find and return the first block while the
> suggestion will make sure all blocks are used.
> But again, reusing an `id` is an error and shouldn't happen.
> 
>>> For the time being, I think it might be better to add these checks for
>>> DSC for the sake of uniformity.
>>>
>>
>> Yes, i think so too.
> 
> I'd rather see a separate patch removing them then, as my suggestion
> won't affect the legality of the range check.
> 

I think kuogee just added this to keep it consistent with other checks 
present in the RM. So I didnt see any harm with that.

If he did see an issue, i will let him report that here.

Otherwise, I dont want to spend more time discussing this bounds check 
when other blocks already have it.

So, upto you guys to fight it out.

> - Marijn
