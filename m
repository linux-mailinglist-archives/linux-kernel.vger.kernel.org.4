Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A448D73C3CF
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 00:10:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232124AbjFWWKK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 18:10:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230501AbjFWWKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 18:10:08 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAE1226BB;
        Fri, 23 Jun 2023 15:10:04 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35NLubCx013575;
        Fri, 23 Jun 2023 22:09:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=sYLynX14PW0AuZ+HAmvfmZhv83S4/xOwpII0tHUGA+w=;
 b=Im1EmK/HXPIRWJx1d9eBVsx3fb3xTf4/umhS8m4WuEtAbWg6f8M6PMk1Rh0vGR9thHz6
 IB+55F8GD1IS7Ex8lRFWnjPRv4Hkm67441rGmsKPdAKWs73hPbyiKtRO7UcI8qOq5L+h
 wYfPeiZHfGig0KhWuXmCiPGoNhgdvXV6/RM7G4GFuIMBwWjEcEqcy5iMHbmf2SBSj56q
 oHdTn2qvbidwihpffhetQqcaYVupLOdS6xhdPxZ3N8xs8yMhRhV6hGZVgRRMWwiCFdQo
 TyP4te8cW0vx6XSCLTVp0e7sKkrXdMNLsPZIGjDOW4Lo316jv0XeZL17rpDTFS2/bJAk PA== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rcurrjydt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Jun 2023 22:09:48 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35NM9l20018103
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Jun 2023 22:09:47 GMT
Received: from [10.226.59.182] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Fri, 23 Jun
 2023 15:09:47 -0700
Message-ID: <58cb3bf6-5ffd-194b-1455-4e5bb045fc34@quicinc.com>
Date:   Fri, 23 Jun 2023 16:09:46 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH 10/26] bus: mhi: host: use array_size
Content-Language: en-US
To:     Julia Lawall <julia.lawall@inria.fr>
CC:     Manivannan Sadhasivam <mani@kernel.org>, <keescook@chromium.org>,
        <kernel-janitors@vger.kernel.org>, <mhi@lists.linux.dev>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230623211457.102544-1-Julia.Lawall@inria.fr>
 <20230623211457.102544-11-Julia.Lawall@inria.fr>
 <3b4ff79b-93b4-cf56-1488-113905b3981d@quicinc.com>
 <alpine.DEB.2.22.394.2306232340510.3129@hadrien>
From:   Jeffrey Hugo <quic_jhugo@quicinc.com>
In-Reply-To: <alpine.DEB.2.22.394.2306232340510.3129@hadrien>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 89SlzKgXzXFHeBTr0RSqxh6rVvMRegXP
X-Proofpoint-ORIG-GUID: 89SlzKgXzXFHeBTr0RSqxh6rVvMRegXP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-23_12,2023-06-22_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0 spamscore=0
 adultscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306230200
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/23/2023 3:45 PM, Julia Lawall wrote:
> 
> 
> On Fri, 23 Jun 2023, Jeffrey Hugo wrote:
> 
>> On 6/23/2023 3:14 PM, Julia Lawall wrote:
>>> Use array_size to protect against multiplication overflows.
>>>
>>> The changes were done using the following Coccinelle semantic patch:
>>>
>>> // <smpl>
>>> @@
>>>       expression E1, E2;
>>>       constant C1, C2;
>>>       identifier alloc = {vmalloc,vzalloc};
>>> @@
>>>       (
>>>         alloc(C1 * C2,...)
>>> |
>>>         alloc(
>>> -           (E1) * (E2)
>>> +           array_size(E1, E2)
>>>         ,...)
>>> )
>>> // </smpl>
>>>
>>> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>
>>>
>>> ---
>>>    drivers/bus/mhi/host/init.c |    4 ++--
>>>    1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/bus/mhi/host/init.c b/drivers/bus/mhi/host/init.c
>>> index f72fcb66f408..34a543a67068 100644
>>> --- a/drivers/bus/mhi/host/init.c
>>> +++ b/drivers/bus/mhi/host/init.c
>>> @@ -759,8 +759,8 @@ static int parse_ch_cfg(struct mhi_controller
>>> *mhi_cntrl,
>>>    	 * so to avoid any memory possible allocation failures, vzalloc is
>>>    	 * used here
>>>    	 */
>>> -	mhi_cntrl->mhi_chan = vzalloc(mhi_cntrl->max_chan *
>>> -				      sizeof(*mhi_cntrl->mhi_chan));
>>> +	mhi_cntrl->mhi_chan = vzalloc(array_size(mhi_cntrl->max_chan,
>>> +				      sizeof(*mhi_cntrl->mhi_chan)));
>>>    	if (!mhi_cntrl->mhi_chan)
>>>    		return -ENOMEM;
>>>
>>>
>>
>> This doesn't seem like a good fix.
>>
>> If we've overflowed the multiplication, I don't think we should continue, and
>> the function should return an error.  array_size() is going to return
>> SIZE_MAX, and it looks like it is possible that vzalloc() may be able to
>> allocate that successfully in some scenarios. However, that is going to be
>> less memory than parse_ch_cfg() expected to allocate, so later on I expect the
>> function will still corrupt memory - basically the same result as what the
>> unchecked overflow would do.
>>
>> I'm not convinced the semantic patch is bringing value as I suspect most of
>> the code being patched is in the same situation.
> 
> OK, this just brings the code in line with all the calls updated by Kees's
> original patch, cited in the cover letter, which were all the
> calls containing a multiplication that existed at the time.
> 
> 42bc47b35320 ("treewide: Use array_size() in vmalloc()")
> fad953ce0b22 ("treewide: Use array_size() in vzalloc()")

Eh.  I "git show fad953ce0b22" and it doesn't really tell me much.  The 
commit asserts that uses of vzalloc() and multiplication need 
array_size(), but doesn't really explain why.

This looks like a brute force automated update with no thought and I 
fear the result of this change is the conclusion that we've solved 
multiplication overflow, when it doesn't look like we've really done 
much.  Sure, the multiplication gets capped, but can the code actually 
handle that?

I should probably run the numbers, but with the relevant spec capping 
the number of channels at 256, I don't think we can realistically 
approach overflow, even on a 32-bit system.  However, having correct 
code that is inherently safe seems like a good idea and so I feel this 
function has an issue.  I just don't think this automated conversion 
meaningfully does anything to improve the code here.

Kees, would you please chime in and educate me here?  I feel like I'm 
missing something important here.

-Jeff
