Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DB2A69BB61
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 19:22:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbjBRSWc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Feb 2023 13:22:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjBRSWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Feb 2023 13:22:30 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1750116ADA;
        Sat, 18 Feb 2023 10:22:29 -0800 (PST)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31II99We026414;
        Sat, 18 Feb 2023 18:22:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=mg5gbA9rOktRLelram4R8AvwoNWEaVjJD5Rdl+HzMKg=;
 b=gHoy8l7WD4tEUaCpFRgKX/rQk2tOSQdUmDObcuByfUbe/+prfqnZpLDagOlCr76CFf7x
 WgUy3Y9LENDTREoxxVcJ/d13qrhmVFdFR6Lmm2gwjceshmT0CxPWA3phIfkYpsFwRiU9
 WSDBCc+Vg/eIOjai2wNzBMadZqsPBol7cWrqDmQX8SdsWgKvXcfnvRn3FpvHVdIVBnim
 eI9946ag2FvBaD9YsZJo5zlfPokDs6LWiu98My6u3+2WcFEir4dTOFV83zxhb8zLTw9i
 zbaqS7NnDKrqAXBwsHuv+yGlJgM2es+8gpy4V44MxtMtRoGLjhdyaBUCd4Nspgmb1YGO QQ== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ntqygs40p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 18 Feb 2023 18:22:11 +0000
Received: from nasanex01a.na.qualcomm.com ([10.52.223.231])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31IIMA6I003817
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 18 Feb 2023 18:22:11 GMT
Received: from [10.110.56.158] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Sat, 18 Feb
 2023 10:22:09 -0800
Message-ID: <ca30cded-4ea4-8c70-61ad-5d0d99b123d3@quicinc.com>
Date:   Sat, 18 Feb 2023 10:22:09 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH RESEND 1/1] check-uapi: Introduce check-uapi.sh
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        John Moon <quic_johmoo@quicinc.com>,
        Randy Dunlap <rdunlap@infradead.org>
CC:     Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Nicolas Schier" <nicolas@fjasle.eu>,
        <linux-kbuild@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        "Todd Kjos" <tkjos@google.com>,
        Matthias Maennich <maennich@google.com>,
        "Giuliano Procida" <gprocida@google.com>,
        <kernel-team@android.com>, Jordan Crouse <jorcrous@amazon.com>
References: <20230217202234.32260-1-quic_johmoo@quicinc.com>
 <20230217202234.32260-2-quic_johmoo@quicinc.com> <Y/CJhzSJ5YKvD7my@kroah.com>
 <Y/CM9JtK0914YUE0@kroah.com>
Content-Language: en-US
From:   Trilok Soni <quic_tsoni@quicinc.com>
In-Reply-To: <Y/CM9JtK0914YUE0@kroah.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 2tzCzwN1XpuVqFXBoZh8jrY-4EbeM-iI
X-Proofpoint-ORIG-GUID: 2tzCzwN1XpuVqFXBoZh8jrY-4EbeM-iI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-18_13,2023-02-17_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 mlxlogscore=637 spamscore=0 priorityscore=1501
 phishscore=0 malwarescore=0 clxscore=1011 mlxscore=0 adultscore=0
 suspectscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302180168
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/18/2023 12:31 AM, Greg Kroah-Hartman wrote:
> On Sat, Feb 18, 2023 at 09:17:12AM +0100, Greg Kroah-Hartman wrote:
>> On Fri, Feb 17, 2023 at 12:22:34PM -0800, John Moon wrote:
>>> While the kernel community has been good at maintaining backwards
>>> compatibility with kernel UAPIs, it would be helpful to have a tool
>>> to check if a patch introduces changes that break backwards
>>> compatibility.
>>>
>>> To that end, introduce check-uapi.sh: a simple shell script that
>>> checks for changes to UAPI headers using libabigail.
>>>
>>> libabigail is "a framework which aims at helping developers and
>>> software distributors to spot some ABI-related issues like interface
>>> incompatibility in ELF shared libraries by performing a static
>>> analysis of the ELF binaries at hand."
>>>
>>> The script uses one of libabigail's tools, "abidiff", to compile the
>>> changed header before and after the patch to detect any changes.
>>>
>>> abidiff "compares the ABI of two shared libraries in ELF format. It
>>> emits a meaningful report describing the differences between the two
>>> ABIs."
>>>
>>> Signed-off-by: John Moon <quic_johmoo@quicinc.com>
>>> ---
>>>   scripts/check-uapi.sh | 245 ++++++++++++++++++++++++++++++++++++++++++
>>>   1 file changed, 245 insertions(+)
>>>   create mode 100755 scripts/check-uapi.sh
>>
>> Ok, this is very cool, thank you so much for doing this.
>>
>> I know Randy Dunlap was also looking into this previously, so I've cc:ed
>> him and bounced him the original.
>>
>> I tried this out, and at first glance, this felt like it was just "too
>> fast" in that nothing actually was being tested.  So I manually added a
>> field to a structure I know would break the abi, and:
>>
>> 	$ ./scripts/check-uapi.sh
>> 	!!! ABI differences detected in include/uapi/linux/usb/ch9.h (compared to file at HEAD^1) !!!
>>
>> 	    [C] 'struct usb_ctrlrequest' changed:
>> 	      type size changed from 64 to 72 (in bits)
>> 	      1 data member insertion:
>> 		'__u8 abi_break', at offset 16 (in bits) at ch9.h:216:1
>> 	      3 data member changes:
>> 		'__le16 wValue' offset changed from 16 to 24 (in bits) (by +8 bits)
>> 		'__le16 wIndex' offset changed from 32 to 40 (in bits) (by +8 bits)
>> 		'__le16 wLength' offset changed from 48 to 56 (in bits) (by +8 bits)
>>
>> 	0/1 UAPI header file changes are backwards compatible
>> 	UAPI header ABI check failed
>>
>> So it worked!
> 
> Ok, I take it back, it doesn't seem to work :(
> 
> It only "catches" a change from the last commit, but if you have an
> intermediate commit (i.e change something in HEAD^ but not HEAD), it
> does not detect it at all.
> 
> And if you give it an old version, it doesn't check that either (hint,
> try passing in a very old kernel version, that returns instantly and
> doesn't actually build anything).
> 
> So it's a good first cut as an example, but as it doesn't really work
> correctly yet, we can't take it.  Care to fix it up to work so that it
> can be usable?

These first patches were to introduce the tool w/ the one scenario only, 
and thanks for trying it out. We can fix it and add your suggestions.

---Trilok Soni
