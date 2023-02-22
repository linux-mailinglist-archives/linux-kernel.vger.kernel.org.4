Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3CD369FD7A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 22:07:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232277AbjBVVHl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 16:07:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231989AbjBVVHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 16:07:39 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B3F04614E;
        Wed, 22 Feb 2023 13:07:08 -0800 (PST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31MKFfa5027264;
        Wed, 22 Feb 2023 21:06:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=ghLVfH1DSuvUTO9hndrKUMtNVE9U30cB1dyrB22VBjU=;
 b=XvKvhFKlqJq0r+q5wh64WgBfbvPudiXxFbATrJ9FqYJo7YIGZfe+nVPEAlJ9/ENNA0PH
 wCkShTB3vz6S5dU5QnDuDtBPXk3C2dCLHCDap7DrJbsr0oDayHqGAQR6lp42Piwmnplu
 sN/UHxR1FQvl9C8tMASbpUa3Y68s+NkaxjLOiFIseheyb72m3fVyIrJhBDEmeP+2QmRz
 q2gNGQtMw9H71KueIQevGiRG6KV5Hg/pTcShd1/s7EN+HwFArSNOSl8qlh8/rOClD1sX
 Q6eHNOI0qczST1LH4LMeRWjVXGjIS+qPLYUaML1zN3oHwr1jnls8hT1XrLnOo+FfhmqR xQ== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nw75tb1c0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Feb 2023 21:06:17 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31ML6GG0002920
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Feb 2023 21:06:16 GMT
Received: from [10.110.20.97] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 22 Feb
 2023 13:06:14 -0800
Message-ID: <6dffbb7f-cbf5-7bb5-7eba-643bf772e64b@quicinc.com>
Date:   Wed, 22 Feb 2023 13:06:14 -0800
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
 <CAK7LNAQMgsNiizzKuZD+3VvJ=hPygcJ8PwNE+Q6pnxzBmQezCA@mail.gmail.com>
From:   John Moon <quic_johmoo@quicinc.com>
In-Reply-To: <CAK7LNAQMgsNiizzKuZD+3VvJ=hPygcJ8PwNE+Q6pnxzBmQezCA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 5pfwC0N3udqo0ltR6qcfeZnTvtnISzQF
X-Proofpoint-ORIG-GUID: 5pfwC0N3udqo0ltR6qcfeZnTvtnISzQF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-22_09,2023-02-22_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 phishscore=0
 adultscore=0 priorityscore=1501 mlxscore=0 bulkscore=0 suspectscore=0
 clxscore=1015 impostorscore=0 mlxlogscore=999 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302220182
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/19/2023 1:36 AM, Masahiro Yamada wrote:
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
>> ---
>>   scripts/check-uapi.sh | 245 ++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 245 insertions(+)
>>   create mode 100755 scripts/check-uapi.sh
>>
>> diff --git a/scripts/check-uapi.sh b/scripts/check-uapi.sh
>> new file mode 100755
>> index 000000000..b9cd3a2d7
>> --- /dev/null
>> +++ b/scripts/check-uapi.sh
>> @@ -0,0 +1,245 @@
>> +#!/bin/bash
>> +# SPDX-License-Identifier: GPL-2.0-only
>> +
>> +# Script to check a patch for UAPI stability
>> +set -o errexit
>> +set -o pipefail
>> +
>> +print_usage() {
>> +       name=$(basename "$0")
>> +       cat << EOF
>> +$name - check for UAPI header stability across Git commits
>> +
>> +By default, the script will check to make sure the latest commit did
>> +not introduce ABI changes (HEAD^1). You can check against additional
>> +commits/tags with the -r option.
>> +
>> +Usage: $name [-r GIT_REF]
>> +
>> +Options:
>> +    -r GIT_REF     Compare current version of file to GIT_REF (e.g. -r v6.1)
>> +
>> +Environmental Args:
>> +    ABIDIFF        Custom path to abidiff binary
>> +    ARCH           Architecture to build with (e.g. ARCH=arm)
> 
> 
> ARCH is not used anywhere in this script.
> 
> 

Right, yes. We'll end up using it in the next rev for installing 
arch-specific headers.

> 
> 
> 
>> +    CC             C compiler (default is "gcc")
>> +    CROSS_COMPILE  Cross-compiling toochain prefix
> 
> CROSS_COMPILE is unneeded since the toolchain prefix
> is a part of CC
> 

Good point, will remove.

> 
> 
>> +EOF
>> +}
>> +
>> +# Get the file and sanitize it using the headers_install script
>> +get_header() {
>> +       local -r ref="$1"
>> +       local -r file="$2"
>> +       local -r out="$3"
>> +
>> +       if [ ! -x "${KERNEL_SRC}/scripts/unifdef" ]; then
>> +               if ! make -C "${KERNEL_SRC}/scripts" unifdef; then
> 
> 
> 
> I think
> 
>    if ! make -f /dev/null "${KERNEL_SRC}/scripts/unifdef"; then
> 
> ... clarifies what you are doing here
> because you are using make's built-in rule,
> and nothing in scripts/Makefile.
> 
> I do not understand the reason for using make
> if you do not use Makefile at all.
> 
> You are just compiling scripts/unifdef.c directly.
> 
> 

Agreed - will update.

> 
> 
> 
> 
> 
>> +                       errlog 'error - failed to build required dependency "scripts/unifdef"'
>> +                       exit 1
>> +               fi
>> +       fi
>> +
>> +       mkdir -p "$(dirname "$out")"
>> +       (
>> +               cd "$KERNEL_SRC"
>> +               git show "${ref}:${file}" > "${out}.in"
>> +               scripts/headers_install.sh "${out}.in" "$out"
>> +       )
> 
> 
> Unneeded sub-shell fork.
> 
>       git -C "$KERNEL_SRC" show "${ref}:${file}" > "${out}.in"
>       scripts/headers_install.sh "${out}.in" "$out"
> 
> 

Yes, will fix.

> 
> 
> 
> 
> 
> 
> 
> 
> 
>> +}
>> +
>> +# Compile the simple test app
>> +do_compile() {
>> +       local -r compiler="$1"
>> +       local -r inc_dir="$2"
>> +       local -r header="$3"
>> +       local -r out="$4"
>> +       echo "int main(int argc, char **argv) { return 0; }" | \
> 
> bikeshed:   'int main(void) { return 0; }' is enough.
> 

Agreed.

> 
>> +               "$compiler" -c \
> 
> 
> You can expand ${CC} here
> 
>                     "${CC:-gcc}" -c \
> 
> 
> I do not see anywhere else to use ${CC}.
> Remove the 'compiler' argument.
> 
> 

Yes, will do.

> 
> 
>> +                 -o "$out" \
>> +                 -x c \
>> +                 -O0 \
>> +                 -std=c90 \
>> +                 -fno-eliminate-unused-debug-types \
>> +                 -g \
>> +                 "-I$inc_dir" \
> 
> 
> "-I$inc_dir" is meaningless for most cases, unless
> two UAPI headers are changed in HEAD.
> 
> 
> In some cases, you cannot even compile the header.
> 
> Think about this case:
>    include/uapi/linux/foo.h includes <linux/bar.h>
> 
> linux/bar.h does not exist in this tmp directory.
> 
> You assume <linux/bar.h> comes from the user's build environment,
> presumably located under /usr/include/.
> 
> It does not necessarily new enough to compile
> include/uapi/linux/foo.h
> 
> So, this does not work.
> I believe you need to re-consider the approach.
> 
> 

This is a great point. I think a good approach here would be to install 
all the headers into $inc_dir so that cross-header dependencies like 
this use the correct versions from the current kernel.

I'll try this approach in the next rev.

> 
> 
> 
>> +                 -include "$header" \
>> +                 -
>> +}
>> +
>> +# Print to stderr
>> +errlog() {
>> +       echo "$@" >&2
>> +}
>> +
>> +# Grab the list of incompatible headers from the usr/include Makefile
>> +get_no_header_list() {
>> +       {
>> +               cat "${KERNEL_SRC}/usr/include/Makefile"
>> +               # shellcheck disable=SC2016
>> +               printf '\nall:\n\t@echo $(no-header-test)\n'
>> +       } | make -C "${KERNEL_SRC}/usr/include" -f - --just-print \
>> +         | grep '^echo' \
>> +         | cut -d ' ' -f 2-
>> +}
> 
> 
> Redundant.
> 
> 
> 
> get_no_header_list() {
>          {
>               echo 'all: ; @echo $(no-header-test)'
>               cat "${KERNEL_SRC}/usr/include/Makefile"
>          } | make -f -
> }
> 
> 
> should be equivalent, but you still cannot exclude
> include/uapi/asm-generic/*.h, though.
> 
> 

Yes, that's a better implementation. I'll also make sure that the 
asm-generic headers get included in the next rev.

> 
> 
> 
>> +
>> +# Check any changed files in this commit for UAPI compatibility
>> +check_changed_files() {
>> +       refs_to_check=("$@")
>> +
>> +       local passed=0;
>> +       local failed=0;
>> +
>> +       while read -r status file; do
>> +               local -r base=${file/uapi\//}
> 
> 
> The -r option is wrong since 'base' is updated
> in the second iteration.
> 
> 
> If this while loop gets two or more input lines,
> I see the following in the second iteration.
> 
> 
> ./scripts/check-uapi.sh: line 94: local: base: readonly variable
> 
> 

Nice catch, didn't find that in my testing. I will fix.

> 
> 
> 
> 
>> +
>> +               # Get the current version of the file and put it in the install dir
>> +               get_header "HEAD" "$file" "${tmp_dir}/usr/${base}"
> 
> 
> 
> Is '/usr' needed?
> 

Not strictly. Was just using it for "sanitization" in the temp dir. Will 
reconsider.

> 
> 
>> +
>> +               for ref in "${refs_to_check[@]}"; do
>> +                       if ! git rev-parse --verify "$ref" > /dev/null 2>&1; then
>> +                               echo "error - invalid ref \"$ref\""
>> +                               exit 1
>> +                       fi
>> +
>> +                       if check_uapi_for_file "$status" "$file" "$ref" "$base"; then
>> +                               passed=$((passed + 1))
>> +                       else
>> +                               failed=$((failed + 1))
>> +                       fi
>> +               done
>> +       done < <(cd "$KERNEL_SRC" && git show HEAD --name-status --format="" --diff-filter=a -- include/uapi/)
> 
> Redundant.
> 
> done < <(git -C "$KERNEL_SRC" show HEAD --name-status --format=""
> --diff-filter=a -- include/uapi/)
> 
> 
> 
> 
> Why are you checking only include/uapi/ ?
> UAPI headers exist in arch/*/include/uapi/
> 
> 

I hadn't considered those arch-specific headers. Will include them in 
the next rev.

> 
> 
> 
> 
> 
> 
> 
>> +
>> +       total=$((passed + failed))
>> +       if [ "$total" -eq 0 ]; then
>> +               errlog "No changes to UAPI headers detected in most recent commit"
>> +       else
>> +               errlog "${passed}/${total} UAPI header file changes are backwards compatible"
>> +       fi
>> +
>> +       return "$failed"
>> +}
>> +
>> +# Check UAPI compatibility for a given file
>> +check_uapi_for_file() {
>> +       local -r status="$1"
>> +       local -r file="$2"
>> +       local -r ref="$3"
>> +       local -r base="$4"
>> +
>> +       # shellcheck disable=SC2076
>> +       if [[ " $(get_no_header_list) " =~ " ${base/include\//} " ]]; then
>> +               errlog "$file cannot be tested by this script (see usr/include/Makefile)."
>> +               return 1
>> +       fi
>> +
>> +       if [ "$status" = "D" ]; then
>> +               errlog "UAPI header $file was incorrectly removed"
>> +               return 1
>> +       fi
> 
> If you look at git history, we sometimes do this.
> 
> e.g.
> 
> 1e6b57d6421f0343dd11619612e5ff8930cddf38
> 
> 
> 

I think the script should still fail in this case. If someone decides to 
ignore it and still remove the header file, that's fine. In general 
though, I'd expect a flag on my CI build if a supported UAPI header file 
was removed.

> 
> 
> 
> 
>> +
>> +       if [ "$status" = "R" ]; then
>> +               errlog "UAPI header $file was incorrectly renamed"
>> +               return 1
>> +       fi
> 
> 
> 
> I think this is unneeded if you add --no-renames to 'git show'.
> 
> I do not see any sense to distinguish removal and rename
> since it is what git detects from the similarity.
> 
> 
> 

Agreed, there's not really a distinction here. I'll add --no-renames and 
only check for removals.

> 
> 
> 
> 
> 
> 
> 
>> +
>> +       # Get the "previous" verison of the API header and put it in the install dir
>> +       get_header "$ref" "$file" "${tmp_dir}/usr/${base}.pre"
> 
> Is '/usr' needed?
> 
> 
>> +
>> +       compare_abi "${CROSS_COMPILE}${CC:-gcc}" "$file" "$base" "$ref"
> 
> CROSS_COMPILE is unneeded since it is included in ${CC}.
> 

Agreed, will remove.


> 
> 
> 
> 
> 
>> +}
>> +
>> +# Perform the A/B compilation and compare output ABI
>> +compare_abi() {
>> +       local -r compiler="$1"
>> +       local -r file="$2"
>> +       local -r base="$3"
>> +       local -r ref="$4"
>> +
>> +       pre_bin="${tmp_dir}/pre.bin"
>> +       post_bin="${tmp_dir}/post.bin"
>> +       log="${tmp_dir}/log"
>> +
>> +       if ! do_compile "$compiler" "${tmp_dir}/usr/include" "${tmp_dir}/usr/${base}.pre" "$pre_bin" 2> "$log"; then
>> +               errlog "Couldn't compile current version of UAPI header $file..."
>> +               cat "$log" >&2
>> +               return 1
>> +       fi
>> +
>> +       if ! do_compile "$compiler" "${tmp_dir}/usr/include" "${tmp_dir}/usr/${base}" "$post_bin" 2> "$log"; then
>> +               errlog "Couldn't compile new version of UAPI header $file..."
>> +               cat "$log" >&2
>> +               return 1
>> +       fi
>> +
>> +       if "$ABIDIFF" --non-reachable-types "$pre_bin" "$post_bin" > "$log"; then
>> +               echo "No ABI differences detected in $file (compared to file at $ref)"
>> +       else
>> +               errlog "!!! ABI differences detected in $file (compared to file at $ref) !!!"
>> +               echo >&2
>> +               sed  -e '/summary:/d' -e '/changed type/d' -e '/^$/d' -e 's/^/  /g' "$log" >&2
>> +               echo >&2
>> +               return 1
>> +       fi
>> +}
>> +
>> +# Make sure we have the tools we need
>> +check_deps() {
>> +       export ABIDIFF="${ABIDIFF:-abidiff}"
>> +
>> +       if ! command -v "$ABIDIFF" > /dev/null 2>&1; then
>> +               errlog "error - abidiff not found!"
>> +               errlog "Please install abigail-tools (version 1.7 or greater)"
>> +               errlog "See: https://sourceware.org/libabigail/manual/libabigail-overview.html"
>> +               exit 1
>> +       fi
>> +
>> +       read -r abidiff_maj abidiff_min _ < <("$ABIDIFF" --version | cut -d ' ' -f 2 | tr '.' ' ')
>> +       if [ "$abidiff_maj" -lt 1 ] || ([ "$abidiff_maj" -eq 1 ] && [ "$abidiff_min" -lt 7 ]); then
>> +               errlog "error - abidiff version too old: $("$ABIDIFF" --version)"
>> +               errlog "Please install abigail-tools (version 1.7 or greater)"
>> +               errlog "See: https://sourceware.org/libabigail/manual/libabigail-overview.html"
>> +               exit 1
>> +       fi
>> +}
>> +
>> +main() {
>> +       refs_to_check=( "HEAD^1" )
>> +       while getopts "hr:" opt; do
>> +               case $opt in
>> +               h)
>> +                       print_usage
>> +                       exit 0
>> +                       ;;
>> +               r)
>> +                       refs_to_check+=( "$OPTARG" )
>> +                       ;;
>> +               esac
>> +       done
>> +
>> +       check_deps
>> +
>> +       tmp_dir=$(mktemp -d)
>> +       trap 'rm -rf $tmp_dir' EXIT
>> +
>> +       if [ -z "$KERNEL_SRC" ]; then
>> +               KERNEL_SRC="$(realpath "$(dirname "$0")"/..)"
>> +       fi
>> +       export KERNEL_SRC
> 
> 
> Who will use KERNEL_SRC except this script?
> 
> 
> 
> 
> 
> 
>> +
>> +       if ! (cd "$KERNEL_SRC" && git rev-parse --is-inside-work-tree > /dev/null 2>&1); then
>> +               errlog "error - this script requires the kernel tree to be initialized with Git"
>> +               exit 1
>> +       fi
>> +
>> +       export ARCH
>> +       export CC
>> +       export CROSS_COMPILE
> 
> print_usage() says these three are taken from
> environment variables.
> 
> So, they are already exported, aren't they?
> 
> 
> 

Right, don't need to re-export these. Will remove.

> 
> 
> 
>> +
>> +       if ! check_changed_files "${refs_to_check[@]}"; then
>> +               errlog "UAPI header ABI check failed"
>> +               exit 1
>> +       fi
>> +}
>> +
>> +main "$@"
>> --
>> 2.17.1
>>
> --
> Best Regards
> Masahiro Yamada

Thanks so much for the thorough review. It is greatly appreciated!

- John
