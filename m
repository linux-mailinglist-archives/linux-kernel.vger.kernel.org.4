Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E796A69FD15
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 21:39:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232686AbjBVUjH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 15:39:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231536AbjBVUjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 15:39:06 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96A9F1A660;
        Wed, 22 Feb 2023 12:39:04 -0800 (PST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31MJxB27002486;
        Wed, 22 Feb 2023 20:38:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=abYnOhN9a4c7+vHYeCNsPbbdLiLEUj6u9+3F3SJQ36o=;
 b=DAsgKcJ7fYe3/1hpDCCWSQJbPp7Yb6PCfAw0yoCFAvDmSIXaGkGrNrs3CNo7T3N/8Y4E
 X3zinNCPB4o8jBn43b3kBGkxBKPCT1FZ+WnEeLijZTCmjmnloQfnmBAUUmg22zZ25vR5
 oyG0nwviV9oqUFEJBMHCyOrXz6YCw4SpQSpqXOzP7Xn7fImI2YUYrDy8dCY2YtRCLf+t
 mMJo8WEgjhAZgov7TOf0nCRWpaOckKgjghKrOI6hPFPt5grh3VxUqeMRd9FHJt2UQiDA
 sqjVbhKOr8Atv0BrUVIFUSGPfZSrl+4/hSC3ZlxQsyELICvIQjLSn0GZLFG9THv2Bl+f MQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nwdkrt7du-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Feb 2023 20:38:56 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31MKcsYW004315
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Feb 2023 20:38:55 GMT
Received: from [10.110.20.97] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 22 Feb
 2023 12:38:53 -0800
Message-ID: <32029b6b-4427-d695-63ea-dfdbf6590a6a@quicinc.com>
Date:   Wed, 22 Feb 2023 12:38:52 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH RESEND 1/1] check-uapi: Introduce check-uapi.sh
Content-Language: en-US
To:     Masahiro Yamada <masahiroy@kernel.org>
CC:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        <linux-kbuild@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>,
        "Trilok Soni" <quic_tsoni@quicinc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Andersson <andersson@kernel.org>,
        "Todd Kjos" <tkjos@google.com>,
        Matthias Maennich <maennich@google.com>,
        "Giuliano Procida" <gprocida@google.com>,
        <kernel-team@android.com>, Jordan Crouse <jorcrous@amazon.com>
References: <20230217202234.32260-1-quic_johmoo@quicinc.com>
 <20230217202234.32260-2-quic_johmoo@quicinc.com>
 <CAK7LNASf_RQGM6QYwvUN+FLq-v3jK66Pk5jW9M-vM1V4K0xH8g@mail.gmail.com>
From:   John Moon <quic_johmoo@quicinc.com>
In-Reply-To: <CAK7LNASf_RQGM6QYwvUN+FLq-v3jK66Pk5jW9M-vM1V4K0xH8g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: kiiIAufiudcyTTcZxlbup_pN5IsVgGx5
X-Proofpoint-ORIG-GUID: kiiIAufiudcyTTcZxlbup_pN5IsVgGx5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-22_08,2023-02-22_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=905 clxscore=1015
 suspectscore=0 mlxscore=0 priorityscore=1501 phishscore=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 spamscore=0 impostorscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302220178
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/18/2023 9:25 PM, Masahiro Yamada wrote:
> On Sat, Feb 18, 2023 at 5:23 AM John Moon <quic_johmoo@quicinc.com> wrote:
>>
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
> 
> 
> 
> 
> BTW, the patch is prefixed with 'RESEND', but it contains
> several diff lines against the previous submission [1].
> 
> People would submit this as v2 with changes mentioned under '---'.
> 

Sorry about that, I'm still learning the etiquette. :)

I will mark the patch rev as v2 after addressing your comments.

> 
> [1]: https://patchwork.kernel.org/project/linux-kbuild/patch/20230217202234.32260-2-quic_johmoo@quicinc.com/
> 
> 
> 
> 
> 
> 
> diff --git a/scripts/check-uapi.sh b/scripts/check-uapi.sh
> index 209c6793a4d0..b9cd3a2d7805 100755
> --- a/scripts/check-uapi.sh
> +++ b/scripts/check-uapi.sh
> @@ -3,6 +3,7 @@
> 
>   # Script to check a patch for UAPI stability
>   set -o errexit
> +set -o pipefail
> 
>   print_usage() {
>          name=$(basename "$0")
> @@ -34,7 +35,7 @@ get_header() {
> 
>          if [ ! -x "${KERNEL_SRC}/scripts/unifdef" ]; then
>                  if ! make -C "${KERNEL_SRC}/scripts" unifdef; then
> -                       echo 'error - failed to build required
> dependency "scripts/unifdef"'
> +                       errlog 'error - failed to build required
> dependency "scripts/unifdef"'
>                          exit 1
>                  fi
>          fi
> @@ -111,7 +112,7 @@ check_changed_files() {
> 
>          total=$((passed + failed))
>          if [ "$total" -eq 0 ]; then
> -               errlog "No changes to UAPI headers detected"
> +               errlog "No changes to UAPI headers detected in most
> recent commit"
>          else
>                  errlog "${passed}/${total} UAPI header file changes
> are backwards compatible"
>          fi
> @@ -190,16 +191,15 @@ check_deps() {
>                  errlog "error - abidiff not found!"
>                  errlog "Please install abigail-tools (version 1.7 or greater)"
>                  errlog "See:
> https://sourceware.org/libabigail/manual/libabigail-overview.html"
> -               exit 2
> +               exit 1
>          fi
> 
> -       local -r abidiff_maj=$("$ABIDIFF" --version | cut -d ' ' -f 2
> | cut -d '.' -f 1)
> -       local -r abidiff_min=$("$ABIDIFF" --version | cut -d ' ' -f 2
> | cut -d '.' -f 1)
> +       read -r abidiff_maj abidiff_min _ < <("$ABIDIFF" --version |
> cut -d ' ' -f 2 | tr '.' ' ')
>          if [ "$abidiff_maj" -lt 1 ] || ([ "$abidiff_maj" -eq 1 ] && [
> "$abidiff_min" -lt 7 ]); then
> -               errlog "error - installed abidiff version too old:
> $("$ABIDIFF" --version)"
> +               errlog "error - abidiff version too old: $("$ABIDIFF"
> --version)"
>                  errlog "Please install abigail-tools (version 1.7 or greater)"
>                  errlog "See:
> https://sourceware.org/libabigail/manual/libabigail-overview.html"
> -               exit 2
> +               exit 1
>          fi
>   }
> 
> @@ -220,13 +220,18 @@ main() {
>          check_deps
> 
>          tmp_dir=$(mktemp -d)
> -       #trap 'rm -rf $tmp_dir' EXIT
> +       trap 'rm -rf $tmp_dir' EXIT
> 
>          if [ -z "$KERNEL_SRC" ]; then
>                  KERNEL_SRC="$(realpath "$(dirname "$0")"/..)"
>          fi
>          export KERNEL_SRC
> 
> +       if ! (cd "$KERNEL_SRC" && git rev-parse --is-inside-work-tree
>> /dev/null 2>&1); then
> +               errlog "error - this script requires the kernel tree
> to be initialized with Git"
> +               exit 1
> +       fi
> +
>          export ARCH
>          export CC
>          export CROSS_COMPILE
> 
> 
> 
> 
> 
> 
