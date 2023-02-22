Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C10C69FD0F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 21:36:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232640AbjBVUgz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 15:36:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjBVUgx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 15:36:53 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B185B38B47;
        Wed, 22 Feb 2023 12:36:51 -0800 (PST)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31MKHFaW025113;
        Wed, 22 Feb 2023 20:36:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=q+p36bgnMXz0IoubZ/SIM3T/mm8Ry140pVIkXQNQ0pk=;
 b=G17L7ChrGI4lzEdqIx2UnnrQyLIE4pMVU5q7Z5S+4TehTDLYEljqkyHpAgfqSGMHxKcG
 +su6d8JKdJ9ATn5EXcv37GfSc/MJo6dJSx7sORZSqJDIWmBbnEjVpcEOH0K8Fs/eKxiT
 FkY0sGoDajGzX9x7qKhqS47+4jpljLCxuAvEnnH5Zzf1CD9fbCN6yOa2zTrVW2D+iCeq
 vpLG9OnYzeAGpTvRLZfBoW8UcxhfLd0ElEYOKJQNuuoK91NHsEPMSgaM55yS6ebOBPJ5
 muVjlnn3D1V20SDtANSjgytCiAEG5luin9h0ZoUvI3qtLxgEQMIZYlwGhrmSgKBSHkYH UQ== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nwfh01v8s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Feb 2023 20:36:37 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31MKaalx003389
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Feb 2023 20:36:36 GMT
Received: from [10.110.20.97] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 22 Feb
 2023 12:36:35 -0800
Message-ID: <4f17cc0e-394a-90f9-bc43-b48fdd703c24@quicinc.com>
Date:   Wed, 22 Feb 2023 12:36:34 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH RESEND 1/1] check-uapi: Introduce check-uapi.sh
Content-Language: en-US
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Randy Dunlap <rdunlap@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Nicolas Schier" <nicolas@fjasle.eu>,
        <linux-kbuild@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        "Bjorn Andersson" <andersson@kernel.org>,
        Todd Kjos <tkjos@google.com>,
        "Matthias Maennich" <maennich@google.com>,
        Giuliano Procida <gprocida@google.com>,
        <kernel-team@android.com>, Jordan Crouse <jorcrous@amazon.com>
References: <20230217202234.32260-1-quic_johmoo@quicinc.com>
 <20230217202234.32260-2-quic_johmoo@quicinc.com> <Y/CJhzSJ5YKvD7my@kroah.com>
 <Y/CM9JtK0914YUE0@kroah.com>
 <CAK7LNASbPi9KgygdZ4XqWEXfK1xunYoWGJwbA2maKuJ=KuyR2Q@mail.gmail.com>
From:   John Moon <quic_johmoo@quicinc.com>
In-Reply-To: <CAK7LNASbPi9KgygdZ4XqWEXfK1xunYoWGJwbA2maKuJ=KuyR2Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: r66sDeTYWlkzosfnIZanmIcy5EUXOgXi
X-Proofpoint-GUID: r66sDeTYWlkzosfnIZanmIcy5EUXOgXi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-22_08,2023-02-22_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 bulkscore=0 mlxlogscore=850 phishscore=0
 impostorscore=0 mlxscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 spamscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302220178
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/19/2023 12:52 AM, Masahiro Yamada wrote:
> On Sat, Feb 18, 2023 at 5:31 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
>>
>> On Sat, Feb 18, 2023 at 09:17:12AM +0100, Greg Kroah-Hartman wrote:
>>> On Fri, Feb 17, 2023 at 12:22:34PM -0800, John Moon wrote:
>>>> While the kernel community has been good at maintaining backwards
>>>> compatibility with kernel UAPIs, it would be helpful to have a tool
>>>> to check if a patch introduces changes that break backwards
>>>> compatibility.
>>>>
>>>> To that end, introduce check-uapi.sh: a simple shell script that
>>>> checks for changes to UAPI headers using libabigail.
>>>>
>>>> libabigail is "a framework which aims at helping developers and
>>>> software distributors to spot some ABI-related issues like interface
>>>> incompatibility in ELF shared libraries by performing a static
>>>> analysis of the ELF binaries at hand."
>>>>
>>>> The script uses one of libabigail's tools, "abidiff", to compile the
>>>> changed header before and after the patch to detect any changes.
>>>>
>>>> abidiff "compares the ABI of two shared libraries in ELF format. It
>>>> emits a meaningful report describing the differences between the two
>>>> ABIs."
>>>>
>>>> Signed-off-by: John Moon <quic_johmoo@quicinc.com>
>>>> ---
>>>>   scripts/check-uapi.sh | 245 ++++++++++++++++++++++++++++++++++++++++++
>>>>   1 file changed, 245 insertions(+)
>>>>   create mode 100755 scripts/check-uapi.sh
>>>
>>> Ok, this is very cool, thank you so much for doing this.
>>>
>>> I know Randy Dunlap was also looking into this previously, so I've cc:ed
>>> him and bounced him the original.
>>>
>>> I tried this out, and at first glance, this felt like it was just "too
>>> fast" in that nothing actually was being tested.  So I manually added a
>>> field to a structure I know would break the abi, and:
>>>
>>>        $ ./scripts/check-uapi.sh
>>>        !!! ABI differences detected in include/uapi/linux/usb/ch9.h (compared to file at HEAD^1) !!!
>>>
>>>            [C] 'struct usb_ctrlrequest' changed:
>>>              type size changed from 64 to 72 (in bits)
>>>              1 data member insertion:
>>>                '__u8 abi_break', at offset 16 (in bits) at ch9.h:216:1
>>>              3 data member changes:
>>>                '__le16 wValue' offset changed from 16 to 24 (in bits) (by +8 bits)
>>>                '__le16 wIndex' offset changed from 32 to 40 (in bits) (by +8 bits)
>>>                '__le16 wLength' offset changed from 48 to 56 (in bits) (by +8 bits)
>>>
>>>        0/1 UAPI header file changes are backwards compatible
>>>        UAPI header ABI check failed
>>>
>>> So it worked!
>>
>> Ok, I take it back, it doesn't seem to work :(
>>
>> It only "catches" a change from the last commit, but if you have an
>> intermediate commit (i.e change something in HEAD^ but not HEAD), it
>> does not detect it at all.
>>
>> And if you give it an old version, it doesn't check that either (hint,
>> try passing in a very old kernel version, that returns instantly and
>> doesn't actually build anything).

I'll make an update to improve this behavior. Should be able to specify 
the commit in which a change is made and which past commits to check 
against.

>>
>> So it's a good first cut as an example, but as it doesn't really work
>> correctly yet, we can't take it.  Care to fix it up to work so that it
>> can be usable?
>>
>> thanks,
>>
>> greg k-h
> 
> 
> 
> This tool does not even work with changes in HEAD.
> 
> I attached two test-case patches.
> 
> This patch does not mention any requirement for
> the build host, but neither of them works for me,
> on Ubuntu 22.04.
> 
> I guess people will find more bad cases
> if they use older distros as the build host.
> (I know why it does not work, though)
> 
> 
> 
> 
> For patch 0001:
> 
> $ ./scripts/check-uapi.sh
> Couldn't compile current version of UAPI header
> include/uapi/linux/cec-funcs.h...
> In file included from <command-line>:
> /tmp/tmp.gYBwfiWTqX/usr/include/linux/cec-funcs.h.pre: In function
> ‘cec_msg_set_audio_volume_level’:
> /tmp/tmp.gYBwfiWTqX/usr/include/linux/cec-funcs.h.pre:1575:23: error:
> ‘CEC_MSG_SET_AUDIO_VOLUME_LEVEL’ undeclared (first use in this
> function)
>   1575 |         msg->msg[1] = CEC_MSG_SET_AUDIO_VOLUME_LEVEL;
>        |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> /tmp/tmp.gYBwfiWTqX/usr/include/linux/cec-funcs.h.pre:1575:23: note:
> each undeclared identifier is reported only once for each function it
> appears in
> 0/1 UAPI header file changes are backwards compatible
> UAPI header ABI check failed
> 
> 
> 
> For patch 0002:
> 
> $ ./scripts/check-uapi.sh
> Couldn't compile current version of UAPI header include/uapi/linux/signal.h...
> In file included from /tmp/tmp.wm5RykUr3y/usr/include/linux/signal.h.pre:5,
>                   from <command-line>:
> /usr/include/x86_64-linux-gnu/asm/signal.h:103:9: error: unknown type
> name ‘size_t’
>    103 |         size_t ss_size;
>        |         ^~~~~~
> 0/1 UAPI header file changes are backwards compatible
> UAPI header ABI check failed
> 

Thanks for the example patches! We understand the issue and I think 
there's a simple solution. We can install all of the current UAPI 
headers into the tmp directory and include those. That way, the user's 
system headers shouldn't enter into the equation.

> 
> 
> 
> 
> 
> BTW, I recommend you to not pick up a patch before having
> any reviewer read the code.
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> --
> Best Regards
> Masahiro Yamada
