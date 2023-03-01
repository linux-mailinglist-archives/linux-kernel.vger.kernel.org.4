Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 529326A728C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 19:04:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbjCASEb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 13:04:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjCASE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 13:04:29 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 007C31990;
        Wed,  1 Mar 2023 10:04:27 -0800 (PST)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 321H5UYW003769;
        Wed, 1 Mar 2023 18:04:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Q0zdVJDzr22M4csdbIqednl0Qpg1rg7ayxs2WRyps/I=;
 b=AjuCYAkKdUR9NyWHt4x+5kAB+Zyj8Uon5tWafHvcNsdWinkDjTmhg7CWdMOG3IMa71PH
 2Hsp0XvVc/PkqrIZDGIHzvIDRRahJdazIOB4KBjW3PK99MMe4gVH0dJVadvVY2qYf5Kk
 Tzo2vV7GF0h9i2xXqA3QJ6v5R8kVLZKLAQUXB23T/o9IGhRveUmAjtOHiK4g/4Qo+L7e
 NmDL/pjg2LG3pWmv7zYfw1ACfRoxqlE4lwhitGOEMiV6zsGW2n6PYCOipnfP7udAWDxJ
 KMwIZeIaLh8JmM81HcgBZSgJVVDpjcXrIT7WVt5q9pJKHNOdG2lnmSZY80LyaVrE++ji Xg== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3p2aspr6s9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Mar 2023 18:04:02 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 321I419T029012
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 1 Mar 2023 18:04:01 GMT
Received: from [10.110.81.49] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 1 Mar 2023
 10:03:59 -0800
Message-ID: <41d287fa-3a0a-cac6-4595-ad47ef873d79@quicinc.com>
Date:   Wed, 1 Mar 2023 10:03:58 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 0/2] Validating UAPI backwards compatibility
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
Content-Language: en-US
From:   John Moon <quic_johmoo@quicinc.com>
In-Reply-To: <CAKwvOdmqShYae=DrwP1JZBYXAYZyDB0SaOkVCvCzQC60MaJcpw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: cbtX0ENhKptLgq19VBYYROGSZhnEkE_y
X-Proofpoint-ORIG-GUID: cbtX0ENhKptLgq19VBYYROGSZhnEkE_y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-01_13,2023-03-01_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 mlxscore=0 bulkscore=0 phishscore=0 mlxlogscore=999
 malwarescore=0 spamscore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2303010144
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/1/2023 9:50 AM, Nick Desaulniers wrote:
> On Tue, Feb 28, 2023 at 11:54 PM John Moon <quic_johmoo@quicinc.com> wrote:
>>
>> Currently, the script works with gcc. It generates output like this when
>> a backwards-incompatible change is made to a UAPI header:
>>
>>   !!! ABI differences detected in include/uapi/linux/acct.h (compared to
>>   file at HEAD^1) !!!
>>
>>       [C] 'struct acct' changed:
>>         type size changed from 512 to 544 (in bits)
>>         1 data member insertion:
>>           '__u32 new_val', at offset 512 (in bits) at acct.h:71:1
>>
>>   0/1 UAPI header file changes are backwards compatible
>>   UAPI header ABI check failed
>>
>> However, we have not had success with clang. It seems clang is more
>> aggressive in optimizing dead code away (no matter which options we
>> pass). Therefore, no ABI differences are found.
> 
> Hi John,
> Do you have the list of bugs you've filed upstream against clang wrt.
> information missing when using `-fno-eliminate-unused-debug-types`?
> 
> https://github.com/llvm/llvm-project/issues is the issue tracker.
> 
> Seeing a strong participant in both the Android and LLVM ecosystems
> supply scripts that lack clang support...raises eyebrows.

We have not filed a bug with upstream clang since we're not sure it's 
*not* and issue on our end. Giuliano Procida (CC'd) has tested the 
script with clang 13 and 14 and GCC 10, 11 and 12 and got the expected 
diff. If it's convenient for anyone testing this script to give it a 
whirl with clang and report back, it could help us determine if there's 
a real issue with clang support. :)
