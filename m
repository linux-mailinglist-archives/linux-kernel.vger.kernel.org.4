Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC3AD6E132D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 19:08:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbjDMRIE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 13:08:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbjDMRIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 13:08:00 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F04CA5C1;
        Thu, 13 Apr 2023 10:07:53 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33DEQxxJ026211;
        Thu, 13 Apr 2023 17:07:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=eXzOsmS48zBA7vCI/59yOahJFg+c+A8hLhtUEz0TBiQ=;
 b=TEYcDi5l2vIa8WILe7i/BA+zMO2064uve8pSmVE/5quwCFLsI+k6sbBWip6M9o8/dKwS
 TXIPUNVZ6Tqk6Gq6QevLJxTteuIph79v41X+RRlmiz18VSTXVHRW2UGUJZrKNdn4wZAL
 DKJuKpGdij650uWDDugc3XPKmardhrqNjXT2JfbleSNsQznRDI9o/4H2mkeJexGOiLF0
 1pMyRx+iFWhPqqyLzKjYS8GPEIWfjRk7ZpbRDzttvjvuHYOMBEBO/GBfu2abLyj9oKD8
 IDLtuf9yc9hLIqyW3XjuPEDnNR19t6/B7YY1pkeWgYKHUe6IjmYUwiLX/dUyNUIhtAn0 uA== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3px3ret52s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Apr 2023 17:07:27 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33DH7QOB007829
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Apr 2023 17:07:26 GMT
Received: from [10.110.32.64] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Thu, 13 Apr
 2023 10:07:24 -0700
Message-ID: <dc2f4e9d-2e7e-a4af-5513-1d25eaba40a8@quicinc.com>
Date:   Thu, 13 Apr 2023 10:07:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v5 1/2] check-uapi: Introduce check-uapi.sh
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Nicolas Schier" <nicolas@fjasle.eu>,
        <linux-kbuild@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Arnd Bergmann" <arnd@arndb.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Todd Kjos <tkjos@google.com>,
        Matthias Maennich <maennich@google.com>,
        Giuliano Procida <gprocida@google.com>,
        <kernel-team@android.com>, <libabigail@sourceware.org>,
        Jordan Crouse <jorcrous@amazon.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>,
        Elliot Berman <quic_eberman@quicinc.com>,
        "Guru Das Srinagesh" <quic_gurus@quicinc.com>
References: <20230407203456.27141-1-quic_johmoo@quicinc.com>
 <20230407203456.27141-2-quic_johmoo@quicinc.com>
 <CAK7LNAQQmoyUx+0Jk3c7iqY20KokrHEOPwHNb2doZOOA8RWBDA@mail.gmail.com>
 <2023041015-lunar-dandelion-1b4e@gregkh>
 <ae44540f-8947-8efb-fb8d-45a84bd3fef3@quicinc.com>
 <2023041136-donator-faceplate-5f91@gregkh>
 <bcdcee9b-f213-bc3c-d300-92a1e0138187@quicinc.com>
 <2023041209-armed-overlaid-3d3d@gregkh>
 <d34a6b09-8244-49e2-2d7a-eee5fd5ca5b7@quicinc.com>
 <2023041216-antitoxic-finch-dd14@gregkh>
From:   John Moon <quic_johmoo@quicinc.com>
In-Reply-To: <2023041216-antitoxic-finch-dd14@gregkh>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 3oSslZBvmsVxrNgSIzdBVi4hKE8hqLqN
X-Proofpoint-GUID: 3oSslZBvmsVxrNgSIzdBVi4hKE8hqLqN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-13_12,2023-04-13_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 impostorscore=0 mlxscore=0 adultscore=0 malwarescore=0 bulkscore=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304130151
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/12/2023 9:43 AM, Greg Kroah-Hartman wrote:
> On Wed, Apr 12, 2023 at 09:37:16AM -0700, John Moon wrote:
>> On 4/11/2023 11:14 PM, Greg Kroah-Hartman wrote:
>>>> Would you find the tool more useful if it simply filtered out all instances
>>>> where the size of the type did not change? This would filter out the
>>>> following which the tool currently flags:
>>>>
>>>> - enum expansions
>>>> - reserved field expansions
>>>> - expansions of a struct with a flex array at the end
>>>> - type changes
>>>> - re-ordering of existing members
>>>> - ...others?
>>>
>>> Obviously not, as some of those are real breakages, and some are not at
>>> all.
>>>
>>> Please understand what is an abi breakage.  Adding new enums is not.
>>> Using a reserved field is not.  Reording existing members IS.
>>>
>>
>> Yes, understood that method would miss certain classes of breakages. I was
>> suggesting it as a way to improve the signal-to-noise ratio of the tool
>> since we don't currently have an algorithm for determining breakages with
>> 100% accuracy.
> 
> Why not?  You know the different types of things here based on the
> differences between the dwarf data, and they fall into different
> categories, and those different categories mean different things.
> 
> If you have questions as to which type of change is allowed and which is
> not, just ask us, the rules are not complex, nor impossible to describe,
> otherwise we wouldn't have a stable api at all, right?
> 

Right, it's currently a limitation of parsing the abidiff output.

Even in trivial situations like an enum expansion, the tool knows that a 
variant was added and another variant had its offset changed. There's 
not a good way to say for sure that the variant whose offset changed is 
a "*_MAX" variant. So if we simply ignored enum expansion, we'd miss 
breakages like this:

enum foo {
	FLAG_A,
+       FLAG_B,
	FLAG_C,
	FLAG_MAX
}

Maybe we can ignore an enum expansion if only the last variant's offset 
changed, but then we'd miss cases where enums don't have a MAX variant. 
Maybe we could limit the check to last variant's offset whose name 
contains string "MAX", but what if someone calls it "LAST" instead? It 
gets fragile.

Or situations like expanding into reserved fields. How can we detect the 
difference between this:

struct foo {
	__u32 x;
	__u32 y;
+       __u32 z;
+       __u8  padding[12];
-	__u8  padding[16];
}

And this:

struct foo {
	__u32 x;
	__u32 y;
+       __u32 z;
+       char  codename[4]; /* Takes "NAME" */
-	char  codename[8]; /* Takes "CODENAME" */
}

Maybe we grep for "pad" or "reserved", but again... fragile.

Another idea is to add some sort of in-line comment to give the checker 
a hint that the field is intentionally unstable. It could be implicit 
for "*_MAX" enum variants or "*padding" at the end of structs, but if 
you wanted to have something like "end[]" (like in the rseq change), you 
could add /* ABI-unstable */ next to it and the script would ignore it.

Beyond those issues, we have non-trivial situations like when it's safe 
to add members to a struct. We know the kernel will zero-extend 
mismatches between kernel and userspace, but how do we know the driver 
properly handles the case of an old userspace passing an old struct?

So far, we've erred on the side of flagging it if it _could_ be a break 
and relied on the reviewer to make the final determination.





