Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67A206DB4E0
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 22:09:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231202AbjDGUJ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 16:09:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231210AbjDGUJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 16:09:17 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6829BDDC;
        Fri,  7 Apr 2023 13:09:02 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 337JmN7F007066;
        Fri, 7 Apr 2023 20:08:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=0i4E0u1XrBmYLxbZU4JAuV5AftLWTvm18wKoplfBlyQ=;
 b=KIqxzP30AS/HBh4IyZlRK4JRmDdbUPPehWf77ln+GD16+tUvTjdOZLA/GykPzdc5aCYc
 +rB9Dw9ZMeIUfDlP6Ok/qk3nrIJD/6A1IXaTW8PlTpodtBDnFv7r7WNpVxKteMlOnPOS
 3xIxtn6C3U7MZjkIRC6L0KWKduKVaGb8TivX4oMFtMncxSCJeiupC3MeBhRR8LEZbwvG
 /nG/+tkYLLckof3QnYFACS3ICD7do+Sxfz41m6VYXbiOWXR8cLYk9zRcZjsoIfoG01QI
 YNi3NKfJiBG9euhAboqOhnZGmERH8YNeyit437fQ+qxX+jq2ePu15lANeNia7mOCdoZD eA== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ptb241yer-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Apr 2023 20:08:39 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 337K8bAW003467
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 7 Apr 2023 20:08:37 GMT
Received: from [10.110.116.85] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Fri, 7 Apr 2023
 13:08:35 -0700
Message-ID: <98faa8f0-4b84-0d34-f3e8-06aee6bb7511@quicinc.com>
Date:   Fri, 7 Apr 2023 13:08:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v4 1/2] check-uapi: Introduce check-uapi.sh
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
 <CAK7LNAQ26HVA-oMwOqAg-diZ7dRa_41hjmRb88Vcv-GcQsFfqg@mail.gmail.com>
Content-Language: en-US
From:   John Moon <quic_johmoo@quicinc.com>
In-Reply-To: <CAK7LNAQ26HVA-oMwOqAg-diZ7dRa_41hjmRb88Vcv-GcQsFfqg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: kgvN6zU9XNRNiSHXP1POHFzxZxKBGNO0
X-Proofpoint-GUID: kgvN6zU9XNRNiSHXP1POHFzxZxKBGNO0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-07_12,2023-04-06_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 spamscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015 mlxscore=0
 bulkscore=0 mlxlogscore=797 impostorscore=0 priorityscore=1501
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304070180
X-Spam-Status: No, score=-2.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/7/2023 12:19 PM, Masahiro Yamada wrote:
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
>> +# Save the current git tree state, stashing if needed
>> +save_tree_state() {
>> +       printf "Saving current tree state... "
>> +       current_ref="$(git rev-parse HEAD)"
>> +       readonly current_ref
>> +       if tree_is_dirty; then
>> +               unstash="true"
>> +               git stash push --quiet
>> +       fi
>> +       printf "OK\n"
>> +}
>> +
>> +# Restore the git tree state, unstashing if needed
>> +restore_tree_state() {
>> +       if [ -z "$current_ref" ]; then
>> +               return 0
>> +       fi
>> +
>> +       printf "Restoring current tree state... "
>> +       git checkout --quiet "$current_ref"
> 
> 
> This does not restore the original state.
> 
> I was on a branch before running this script.
> After everything is finished, I am on a detached commit
> because $current_ref is not a branch.
> 
> 

Good point. I think doing this should address:

current_ref="$(git symbolic-ref --short HEAD 2> /dev/null || git rev 
parse HEAD)"

Will fix in v5.

> 
> 
>> +       if ! do_compile "$(get_header_tree "$past_ref")/include" "$past_header" "${past_header}.bin" 2> "$log"; then
>> +               eprintf "error - couldn't compile version of UAPI header %s at %s\n" "$file" "$past_ref"
>> +               cat "$log" >&2
>> +               exit "$FAIL_COMPILE"
>> +       fi
>> +
>> +       "$ABIDIFF" --non-reachable-types "${past_header}.bin" "${base_header}.bin" > "$log" && ret="$?" || ret="$?"
> 
> 
> [bikeshed] I might want to write like this:
> 
>     ret=0
>     "$ABIDIFF" --non-reachable-types "${past_header}.bin"
> "${base_header}.bin" > "$log" || ret="$?"
> 
> 
> 

Sure, will do.

> 
> 
> 
> 
>> +
>> +
>> +       if [ "$quiet" = "true" ]; then
>> +               run "$base_ref" "$past_ref" "$abi_error_log" "$@" > /dev/null
>> +       else
>> +               run "$base_ref" "$past_ref" "$abi_error_log" "$@"
>> +       fi
> 
> 
> 
>      if [ "$quiet" = "true" ]; then
>              exec > /dev/null
>      fi
> 
>      run "$base_ref" "$past_ref" "$abi_error_log" "$@"
> 
> 
> 
> is more elegant because this is the last line of main()
> and exit_handler() does not print anything.
> 
> 
> 

Agreed, will do.

> 
> 
> 
