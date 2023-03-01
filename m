Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 259BB6A7433
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 20:24:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbjCATYp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 14:24:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjCATYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 14:24:44 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBD4223309;
        Wed,  1 Mar 2023 11:24:42 -0800 (PST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 321I17SW027768;
        Wed, 1 Mar 2023 19:24:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : from : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=4hmOo7FaxBhqe/Ieuk7y0ebkwJe77i4ZNugorKt2Xhg=;
 b=WaNJFqzC2cxdlZb75wtixAFM+TZW7sdI5Lal8fCe1SS32EkqD6MFH+OKNBVBqsjGFtEA
 nVfpX5fsEJz7CBmyBEpLvOylW+AAjAvi6KuRqG6MOPL27H5iMm6QpCqFW2pyfDWSRVOF
 qbQfqxIVbn1TyPUAz3ovrr9m9kjb6gKjlpgLBhRz+LZtdiXwWdaK7zTUGbpptM/d6KTz
 4UOZVUM5uZKd6KSVK3FeitfB3XksUaJckVGlwh8zC3/WALd8u7mhwSgBENDq15wSczMR
 2BEWZsPLWcGGu/Zj853RXbK5C3BWP/AG6RHvzmGQpyOYVrhS4xoCaKDG2uG0xa3YgI4U mw== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3p1vgejx8k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Mar 2023 19:24:20 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 321JOICF004277
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 1 Mar 2023 19:24:18 GMT
Received: from [10.110.81.49] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 1 Mar 2023
 11:24:16 -0800
Message-ID: <0c92e7b8-e415-8ad5-14e7-d94f18c3fa25@quicinc.com>
Date:   Wed, 1 Mar 2023 11:24:15 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 0/2] Validating UAPI backwards compatibility
Content-Language: en-US
From:   John Moon <quic_johmoo@quicinc.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
CC:     Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        <linux-kbuild@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Todd Kjos <tkjos@google.com>,
        Matthias Maennich <maennich@google.com>,
        Giuliano Procida <gprocida@google.com>,
        <kernel-team@android.com>, <libabigail@sourceware.org>,
        Jordan Crouse <jorcrous@amazon.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        "Satya Durga Srinivasu Prabhala" <quic_satyap@quicinc.com>,
        Elliot Berman <quic_eberman@quicinc.com>
References: <20230301075402.4578-1-quic_johmoo@quicinc.com>
 <CAKwvOdmqShYae=DrwP1JZBYXAYZyDB0SaOkVCvCzQC60MaJcpw@mail.gmail.com>
 <41d287fa-3a0a-cac6-4595-ad47ef873d79@quicinc.com>
In-Reply-To: <41d287fa-3a0a-cac6-4595-ad47ef873d79@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: E0zizhCDS3g96j56kAD31RGiXuL1t5pO
X-Proofpoint-ORIG-GUID: E0zizhCDS3g96j56kAD31RGiXuL1t5pO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-01_14,2023-03-01_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 phishscore=0 priorityscore=1501 suspectscore=0 adultscore=0
 bulkscore=0 impostorscore=0 mlxlogscore=999 spamscore=0 clxscore=1015
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303010155
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/1/2023 10:03 AM, John Moon wrote:
> On 3/1/2023 9:50 AM, Nick Desaulniers wrote:
>> On Tue, Feb 28, 2023 at 11:54 PM John Moon <quic_johmoo@quicinc.com> 
>> wrote:
>>>
>>> Currently, the script works with gcc. It generates output like this when
>>> a backwards-incompatible change is made to a UAPI header:
>>>
>>>   !!! ABI differences detected in include/uapi/linux/acct.h (compared to
>>>   file at HEAD^1) !!!
>>>
>>>       [C] 'struct acct' changed:
>>>         type size changed from 512 to 544 (in bits)
>>>         1 data member insertion:
>>>           '__u32 new_val', at offset 512 (in bits) at acct.h:71:1
>>>
>>>   0/1 UAPI header file changes are backwards compatible
>>>   UAPI header ABI check failed
>>>
>>> However, we have not had success with clang. It seems clang is more
>>> aggressive in optimizing dead code away (no matter which options we
>>> pass). Therefore, no ABI differences are found.
>>
>> Hi John,
>> Do you have the list of bugs you've filed upstream against clang wrt.
>> information missing when using `-fno-eliminate-unused-debug-types`?
>>
>> https://github.com/llvm/llvm-project/issues is the issue tracker.
>>
>> Seeing a strong participant in both the Android and LLVM ecosystems
>> supply scripts that lack clang support...raises eyebrows.
> 
> We have not filed a bug with upstream clang since we're not sure it's 
> *not* and issue on our end. Giuliano Procida (CC'd) has tested the 
> script with clang 13 and 14 and GCC 10, 11 and 12 and got the expected 
> diff. If it's convenient for anyone testing this script to give it a 
> whirl with clang and report back, it could help us determine if there's 
> a real issue with clang support. :)

With some additional internal testing, we've found that clang does not 
work with this script on Ubuntu 18.04, but does work on Ubuntu 20.04. 
This is controlling for the clang version and different installation 
sources. The same clang-15 binary run on an 18.04 host fails while 
working on 20.04.

We'll investigate some more internally and potentially file a bug with 
upstream clang.
