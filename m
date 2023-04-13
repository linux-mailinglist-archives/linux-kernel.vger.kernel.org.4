Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B453C6E134B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 19:16:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbjDMRQL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 13:16:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbjDMRQE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 13:16:04 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FD357D85;
        Thu, 13 Apr 2023 10:16:03 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33DGiaTe013665;
        Thu, 13 Apr 2023 17:15:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=MtdHblHL0dRtEAb/ZgyYrCdFyTXsfm/IBpdoXkGNRMw=;
 b=Z2kaNPMGF/E/2vHrFAEUUt7zTcKgIy1Jrc+W0OnMTWDFPZ6R8FAvUz1TDTiC5CJ3sxf5
 joE6GgL22KjQuUkusFlkdXvTv4F4Gv1wSDu/mwk/TRIO2tp8ExR2I2UBj6MotYVsMWFa
 0MVyMw9p0KfQtE0mBU/ToMm6V30pjqTPcTX41hDMbWZeE6b/mJuQh6pNq6wOTeBTfkX5
 gWcDFFlkshEGuyJ8nhcYGyJFOQWWO3ny85L8vQ9PM/hCiGe/IpitHmrPb43S+Nl2aMld
 u/TnMqm+19zz+OlwDBF8OXa/be6VaCOUyQww84LyzcdlTnUna2KXFoIAvYYfoDVnU23l Pw== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pxked0c3f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Apr 2023 17:15:28 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33DHFR8U029863
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Apr 2023 17:15:27 GMT
Received: from [10.110.32.64] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Thu, 13 Apr
 2023 10:15:25 -0700
Message-ID: <d2c09763-db80-8f67-4b80-dd33384ee533@quicinc.com>
Date:   Thu, 13 Apr 2023 10:15:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v5 1/2] check-uapi: Introduce check-uapi.sh
Content-Language: en-US
To:     Mark Wielaard <mark@klomp.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
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
 <718c102205750a00b86e8d33748e9bfb3c485ee1.camel@klomp.org>
From:   John Moon <quic_johmoo@quicinc.com>
In-Reply-To: <718c102205750a00b86e8d33748e9bfb3c485ee1.camel@klomp.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: hSrVce4FG3DcLfPp4vEbqkODtZT23yTG
X-Proofpoint-ORIG-GUID: hSrVce4FG3DcLfPp4vEbqkODtZT23yTG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-13_12,2023-04-13_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 phishscore=0 bulkscore=0 spamscore=0 malwarescore=0 suspectscore=0
 adultscore=0 priorityscore=1501 clxscore=1011 mlxlogscore=999
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304130152
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/13/2023 7:37 AM, Mark Wielaard wrote:
> Hi,
> 
> On Wed, 2023-04-12 at 09:37 -0700, John Moon via Libabigail wrote:
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
>> Yes, understood that method would miss certain classes of breakages. I
>> was suggesting it as a way to improve the signal-to-noise ratio of the
>> tool since we don't currently have an algorithm for determining
>> breakages with 100% accuracy.
> 
> Note that you can check the exit code of libabigail's abidiff to see
> whether something is an incompatible abi change or not, see:
> https://sourceware.org/libabigail/manual/abidiff.html#return-values
> 
> You can also of course use suppressions to instruct abidiff to avoid
> reporting changes involving certain ABI artifacts:
> https://sourceware.org/libabigail/manual/libabigail-concepts.html#suppr-spec-label
> 
> Cheers,
> 
> Mark

Checking the ABIDIFF_ABI_INCOMPATIBLE_CHANGE flag in the return code is 
a good idea, but checking it doesn't change what the tool is currently 
outputting (i.e. the flag is set for all the changes currently 
reported). I think this is because of some filtering we're doing based 
on grepping stdout, but checking the return code would be more stable.

The suppressions may work for some cases, but I fear they would be too 
eager in other cases. Looking at the docs, I'm not sure how we could 
express something like:

"suppress changed enumerators if they end in 'MAX' or 'LAST' and appear 
at the end of the enumeration"

or

"suppress data member insertions into a struct if the last member in the 
struct has its size reduced by sizeof(new_member) and is named 'pad' or 
'reserved'"

They're complicated cases to detect in a general way.

Thanks,
John
