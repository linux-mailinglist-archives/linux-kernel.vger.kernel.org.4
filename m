Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B813B6DB4EF
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 22:10:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231700AbjDGUKO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 16:10:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231728AbjDGUJt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 16:09:49 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66931CA2D;
        Fri,  7 Apr 2023 13:09:43 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 337Jiwb0029048;
        Fri, 7 Apr 2023 20:09:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Oue0184In+1WXLod3+6ssUfkgG2cv48XML0xIhs6V1I=;
 b=GWJ2cCaFaVBEXCd7Fnlh7tUpyoI8kHM1n/FJthSrR4usvAaxp2vEe0dLd9BJawMWvuzh
 3Jatv2t8W34Dy8OXqMeYy4ucfqnFSUAuU0vLs0D7ONtyI0KP6zXIeSfxbO60Zf/3R3JD
 MgzsbA2P9qB/hIgCcFYWHQtjymKVwyY1GTaMMZsuqHdskVLjVroiBVM//yIFIIo82OF1
 0bv8dWtcvTtm1r//Ku7RyKU9xlzQQm8REy6fNSbeyeQ90vkhGmQdtVRwgE8dsuu0Q0ER
 eekIPUrVRFezRuE/DoUr3eKZWfcf4VYPnt8QV6z/HxRH2AvM8abgvSbACT+Re18GgU5X iA== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ptcrn1rbj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Apr 2023 20:09:16 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 337K9FFf029562
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 7 Apr 2023 20:09:15 GMT
Received: from [10.110.116.85] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Fri, 7 Apr 2023
 13:09:13 -0700
Message-ID: <9529ba0b-4031-c91c-e231-86ee1c845539@quicinc.com>
Date:   Fri, 7 Apr 2023 13:09:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v4 1/2] check-uapi: Introduce check-uapi.sh
Content-Language: en-US
To:     Masahiro Yamada <masahiroy@kernel.org>
CC:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
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
        Elliot Berman <quic_eberman@quicinc.com>,
        Guru Das Srinagesh <quic_gurus@quicinc.com>
References: <20230327174140.8169-1-quic_johmoo@quicinc.com>
 <20230327174140.8169-2-quic_johmoo@quicinc.com>
 <CAK7LNATFzdb37ZpOkYOP0rGBBjMhad6p76CXJg7kZsNkhpoBXg@mail.gmail.com>
From:   John Moon <quic_johmoo@quicinc.com>
In-Reply-To: <CAK7LNATFzdb37ZpOkYOP0rGBBjMhad6p76CXJg7kZsNkhpoBXg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: fIdeXfPC_7ksN8uDDFcLhnwfm32E-YFL
X-Proofpoint-GUID: fIdeXfPC_7ksN8uDDFcLhnwfm32E-YFL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-07_12,2023-04-06_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 bulkscore=0 mlxscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 phishscore=0 spamscore=0 mlxlogscore=635 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304070181
X-Spam-Status: No, score=-2.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/7/2023 12:27 PM, Masahiro Yamada wrote:
> On Tue, Mar 28, 2023 at 2:42 AM John Moon <quic_johmoo@quicinc.com> wrote:
>>
>> While the kernel community has been good at maintaining backwards
>> compatibility with kernel UAPIs, it would be helpful to have a tool
>> to check if a commit introduces changes that break backwards
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
>> changed header before and after the commit to detect any changes.
>>
>> abidiff "compares the ABI of two shared libraries in ELF format. It
>> emits a meaningful report describing the differences between the two
>> ABIs."
>>
>> The script also includes the ability to check the compatibility of
>> all UAPI headers across commits. This allows developers to inspect
>> the stability of the UAPIs over time.
>>
>> Signed-off-by: John Moon <quic_johmoo@quicinc.com>
>> ---
>>      - Refactored to exclusively check headers installed by make
>>        headers_install. This simplified the code dramatically and removed
>>        the need to perform complex git diffs.
>>      - Removed the "-m" flag. Since we're checking all installed headers
>>        every time, a flag to check only modified files didn't make sense.
>>      - Added info message when usr/include/Makefile is not present that
>>        it's likely because that file was only introduced in v5.3.
>>      - Changed default behavior of log file. Now, the script will not
>>        create a log file unless you pass "-l <file>".
>>      - Simplified exit handler.
>>      - Added -j $MAX_THREADS to make headers_install to improve speed.
>>      - Cleaned up variable references.
>>
>>   scripts/check-uapi.sh | 488 ++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 488 insertions(+)
>>   create mode 100755 scripts/check-uapi.sh
>>
> 
>> +
>> +# Install headers for both git refs
>> +install_headers() {
>> +       local -r base_ref="$1"
>> +       local -r past_ref="$2"
>> +
>> +       DEVIATED_FROM_CURRENT_TREE="false"
>> +       for ref in "$base_ref" "$past_ref"; do
>> +               if [ -n "$ref" ]; then
>> +                       if [ "$DEVIATED_FROM_CURRENT_TREE" = "false" ]; then
>> +                               save_tree_state
>> +                               DEVIATED_FROM_CURRENT_TREE="true"
>> +                       fi
>> +                       # This script ($0) is already loaded into memory at this point,
>> +                       # so this operation is safe
>> +                       git checkout --quiet "$(git rev-parse "$ref")"
>> +               fi
>> +
>> +               printf "Installing sanitized UAPI headers from %s... " "${ref:-dirty tree}"
>> +               make -j "$MAX_THREADS" ARCH="$ARCH" INSTALL_HDR_PATH="${TMP_DIR}/${ref}/usr" headers_install > /dev/null 2>&1
> 
> 
> You suppressed stderr.
> 
> If 'make headers_install' fails, users see a sudden death
> with no clue.
> 

Good point, will remove that suppression.
