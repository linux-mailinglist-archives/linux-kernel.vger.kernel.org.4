Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEDF169FD09
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 21:34:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232614AbjBVUd7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 15:33:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjBVUd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 15:33:57 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8199B37F2A;
        Wed, 22 Feb 2023 12:33:52 -0800 (PST)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31MEJom3024513;
        Wed, 22 Feb 2023 20:33:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Mcyr/qacCOtUX0wSyyB4kPLw3dj7SgQhbe0s9XCqdao=;
 b=AytJsX4rL22s16TUFoYkKGujF6t3ARFe2IBPkhH0iMA3MPf0Pt9UHBGZekWZEJi08eau
 RZW6a0JmVyfuQbf6AMndn35y1UxhNBD21doSPPHUVf8ripey1ypr1+jRtIUp1lCSjOFT
 ahFXBtcjtw1UowWS7cUUAxdGtmSsO4FWTuPBN75dQprn1b8a71FHASOaWVrGYGdn+bj4
 JS5stMB2+CbbFmvc88Og5+mMOtB8kytgF2oKgV7/OYI1ahHoalv0KnYxjgyH462I/07u
 ywvlFq1pS+Yb7TQ0AG1Vq+jANXNyboAGB4xiFfYLkGFJvDrS79i8Pg4J38rcaGDrUz/E QA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nvvrrmqjj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Feb 2023 20:33:33 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31MKXWnD031975
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Feb 2023 20:33:32 GMT
Received: from [10.110.20.97] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 22 Feb
 2023 12:33:30 -0800
Message-ID: <f10b5d1f-4260-2b20-107a-9dbb8bc0e65f@quicinc.com>
Date:   Wed, 22 Feb 2023 12:33:29 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH RESEND 1/1] check-uapi: Introduce check-uapi.sh
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>
CC:     Masahiro Yamada <masahiroy@kernel.org>,
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
From:   John Moon <quic_johmoo@quicinc.com>
In-Reply-To: <Y/CJhzSJ5YKvD7my@kroah.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: oJ3UkuPUoNihPNO34DoKHj7_nk7IcfjG
X-Proofpoint-ORIG-GUID: oJ3UkuPUoNihPNO34DoKHj7_nk7IcfjG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-22_08,2023-02-22_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 bulkscore=0 phishscore=0 mlxscore=0 suspectscore=0 lowpriorityscore=0
 mlxlogscore=439 priorityscore=1501 adultscore=0 clxscore=1011
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302220177
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/18/2023 12:17 AM, Greg Kroah-Hartman wrote:
> On Fri, Feb 17, 2023 at 12:22:34PM -0800, John Moon wrote:
>> While the kernel community has been good at maintaining backwards
>> compatibility with kernel UAPIs, it would be helpful to have a tool
>> to check if a patch introduces changes that break backwards
>> compatibility.
>>
>> To that end, introduce check-uapi.sh: a simple shell script that
>> checks for changes to UAPI headers using libabigail.
>>
>> libabigail is "a framework which aims at helping developers and
>> software distributors to spot some ABI-related issues like interface
>> incompatibility in ELF shared libraries by performing a static
>> analysis of the ELF binaries at hand."
>>
>> The script uses one of libabigail's tools, "abidiff", to compile the
>> changed header before and after the patch to detect any changes.
>>
>> abidiff "compares the ABI of two shared libraries in ELF format. It
>> emits a meaningful report describing the differences between the two
>> ABIs."
>>
>> Signed-off-by: John Moon <quic_johmoo@quicinc.com>
>> ---
>>   scripts/check-uapi.sh | 245 ++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 245 insertions(+)
>>   create mode 100755 scripts/check-uapi.sh
> 
> Ok, this is very cool, thank you so much for doing this.
> 
> I know Randy Dunlap was also looking into this previously, so I've cc:ed
> him and bounced him the original.
> 

Okay, will keep him in the loop!

> I tried this out, and at first glance, this felt like it was just "too
> fast" in that nothing actually was being tested.  So I manually added a
> field to a structure I know would break the abi, and:
> 
> 	$ ./scripts/check-uapi.sh
> 	!!! ABI differences detected in include/uapi/linux/usb/ch9.h (compared to file at HEAD^1) !!!
> 
> 	    [C] 'struct usb_ctrlrequest' changed:
> 	      type size changed from 64 to 72 (in bits)
> 	      1 data member insertion:
> 		'__u8 abi_break', at offset 16 (in bits) at ch9.h:216:1
> 	      3 data member changes:
> 		'__le16 wValue' offset changed from 16 to 24 (in bits) (by +8 bits)
> 		'__le16 wIndex' offset changed from 32 to 40 (in bits) (by +8 bits)
> 		'__le16 wLength' offset changed from 48 to 56 (in bits) (by +8 bits)
> 
> 	0/1 UAPI header file changes are backwards compatible
> 	UAPI header ABI check failed
> 
> So it worked!
> 
> There is a mismatch of different bash coding styles in the document, which
> isn't a big deal, and one warning produced by the `shellcheck` tool, but that
> can all be fixed up later.  I'll go queue this up now, as a starting point for
> people to play with, thanks!
> 

Will resolve all shellcheck warnings in next rev. Not sure about the 
coding style differences you're referring to - is there a shell script 
coding style document?

> Also, it would be nice to be able to check if the current tree with changes in
> it (not checked in, just modified) breaks the abi, without having to go and
> check the change in.  But again, future fixups for people to do!
> 

Should be straightforward to add. Since I'm making another rev, I'll 
take care of this as well.

> thanks,
> 
> greg k-h
