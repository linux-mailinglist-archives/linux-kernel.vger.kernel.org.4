Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9209B6C41B2
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 05:46:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbjCVEqc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 00:46:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjCVEqa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 00:46:30 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC41058C3C;
        Tue, 21 Mar 2023 21:46:27 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32M41MjR026969;
        Wed, 22 Mar 2023 04:45:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=oH79mtNU8C/BJ6DXARe718Nl1KQgKoBrVcaEb9hmltM=;
 b=nj8wLIv8rcKU1umyN02VReMBvhHPOIltqETILhccAPloWTdvs0HFwX+Xpticy7D6C7Rp
 iQRAD9OxpdLysJvu3xpIwH04x3Eu10fvna41Fb40as7klvInpfWAWnMjuxYrLFL3mkSD
 LygM/nEX4eijue2xeTpvAAsE1LDD9CB5fSv84YjGNEMEDm/XGKmUAj2PG1jj3RT7WiwW
 ni+DCCr0eHrGoI2kOdUpWuFWGGH6Dpg7ZVnIDdcYg9jvcaaeveAFPYZ2uPAhe4uVPyrR
 VJEMEcyo7Qh+GP4ZZNenbWaY0fsz8dPq2wU94nDv2dq+QYA3w39ifV7dz3Iyi7A5S5ip TQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pfpfgrhuf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Mar 2023 04:45:56 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32M4jtEu007644
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Mar 2023 04:45:55 GMT
Received: from [10.110.27.2] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 21 Mar
 2023 21:45:52 -0700
Message-ID: <89d702ff-bc10-5904-e489-a4097b3f38c4@quicinc.com>
Date:   Tue, 21 Mar 2023 21:45:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v3 1/2] check-uapi: Introduce check-uapi.sh
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
References: <20230316181555.9327-1-quic_johmoo@quicinc.com>
 <20230316181555.9327-2-quic_johmoo@quicinc.com>
 <CAK7LNATFTOc_9qGMP4B8cRr4NY_NSpE8dMXPjEkJv+aqUj2_Lw@mail.gmail.com>
Content-Language: en-US
From:   John Moon <quic_johmoo@quicinc.com>
In-Reply-To: <CAK7LNATFTOc_9qGMP4B8cRr4NY_NSpE8dMXPjEkJv+aqUj2_Lw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 7ef9tB7McqKPA-My_5rXj7RW4_6GUP4g
X-Proofpoint-ORIG-GUID: 7ef9tB7McqKPA-My_5rXj7RW4_6GUP4g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-21_11,2023-03-21_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 mlxlogscore=999 spamscore=0 suspectscore=0 impostorscore=0 bulkscore=0
 phishscore=0 priorityscore=1501 clxscore=1015 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303150002
 definitions=main-2303220034
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/21/2023 2:19 PM, Masahiro Yamada wrote:

> 
> I think I pointed out that not all UAPI headers are checked-in.
> 
> 
> I applied the following.
> This will remove <asm/termios.h>.
> So, definitely it is a UAPI breakage, but check_all=true
> mode succeeds.
> 
> 
>   diff --git a/include/uapi/asm-generic/Kbuild b/include/uapi/asm-generic/Kbuild
>   index ebb180aac74e..a9c88b0a8b3b 100644
>   --- a/include/uapi/asm-generic/Kbuild
>   +++ b/include/uapi/asm-generic/Kbuild
>   @@ -31,6 +31,6 @@ mandatory-y += stat.h
>    mandatory-y += statfs.h
>    mandatory-y += swab.h
>    mandatory-y += termbits.h
>   -mandatory-y += termios.h
>   +#mandatory-y += termios.h
>    mandatory-y += types.h
>    mandatory-y += unistd.h
> 
> 
> 
> 
> Another false positive is a change outside the uapi directories.
> 
> For x86, syscall UAPI headers are generated in
> arch/x86/entry/syscalls/.
> 
> 
> You never know the compatibility of UAPI unless you check
> all the headers that 'make headers_install' results in.
> 

Excellent points. We'll make another pass looking exclusively at the 
"make headers_install" trees for the two refs. That should be more 
reliable, require less code, and catch issues like these.

> 
> I am reluctant to read the whole code,
> but I spotted possible bugs.
> 
> 
> 
> 
> 
>> +
>> +readonly SUCCESS=0
>> +readonly FAIL_ABI=1
>> +readonly FAIL_PREREQ=2
>> +readonly FAIL_COMPILE=3
>> +readonly FAIL_ARCH=4
>> +readonly FAIL=5
>> +
>> +# Print to stderr
>> +eprintf() {
>> +       # shellcheck disable=SC2059
>> +       printf "$@" >&2
>> +}
>> +
>> +# Print list of UAPI files to operate on
>> +get_uapi_files() {
>> +       local -r check_all="$1"
>> +       local -r base_ref="$2"
>> +       local -r ref="$3"
> 
> local -r past_ref="$3"
> 
> 
> 
>> +       local -r file_list="${tmp_dir}/file_list.txt"
>> +
>> +       # Return already-processed list if it's available
>> +       if [ -s "$file_list" ]; then
>> +               cat "$file_list"
>> +               return 0
>> +       fi
>> +
>> +       if [ "$check_all" = "true" ]; then
>> +               # Print all of the UAPI header files at the commit in question
>> +               # Ignore the headers that we can't test.
>> +               # shellcheck disable=SC2086,SC2046
>> +               git ls-tree --full-tree --name-only -r "${base_ref:-HEAD}" -- "${UAPI_DIRS[@]}" \
>> +                       | grep '.h$' \
>> +                       | sed -e 's/^/M\t/g' \
>> +                       | grep -v $({ get_no_header_list "$base_ref"; get_no_export_list; } | xargs -- printf '-e %s ') \
>> +                       > "$file_list"
>> +       else
>> +               if [ -z "$base_ref" ] || [ -z "$ref" ]; then
> 
> 
> [ -z "$ref" ] is always false.
> 
> 
> 
>> +                       # shellcheck disable=SC2086
>> +                       git diff $GIT_ARGS > "$file_list"
> 
> 
> This is a bug.
> 
> Think about this situation:
> 
>    $base_ref is empty, i.e. workspace
>    $ref is not HEAD but a commit in the past.
> 
> 
> "git diff" will return the diff
> between the cache and the workspace.
> 
> 
> 
> 
> 
> 
>> +               else
>> +                       # shellcheck disable=SC2086
>> +                       git diff "$ref" "$base_ref" $GIT_ARGS > "$file_list"
>> +               fi
> 
> 
> Do you need this if...else...fi block in the first place?
> 
> 
>     git diff $ref $base_ref $GIT_ARGS > "$file_list"
> 
> 
> will naturally work correctly for all cases.
> (do not quote $base_ref, which might be empty)
> 
> 

Great suggestion, that's far more elegant. Thank you!

> 
> 
>> +
>> +               if mismatch_arch_files=$(grep -v "arch/${ARCH}" "$file_list" | grep -o "arch/.*\.h"); then
>> +                       eprintf "warning - detected changes to following files, but can't check them with %s compiler:\n" "$ARCH"
>> +                       for f in $mismatch_arch_files; do
>> +                               eprintf "  - %s\n" "$f"
>> +                               sed -i -e "\|${f}|d" "$file_list"
>> +                               printf "warning - could not perform ABI check on %s with %s compiler\n" "$f" "$ARCH" \
>> +                                       >> "${tmp_dir}/arch_mismatches.error"
>> +                       done
>> +                       eprintf "\nFiltering them out and performing partial check on remaining files...\n"
>> +                       if [ ! -s "$file_list" ]; then
>> +                               eprintf "error - all files were filtered out, there's nothing to check!\n"
>> +                               exit "$FAIL_ARCH"
>> +                       fi
>> +               fi
>> +       fi
>> +
>> +       if [ ! -s "$file_list" ]; then
>> +               return 1
>> +       fi
>> +
>> +       cat "$file_list"
>> +}
>> +
>> +# Compile the simple test app
>> +do_compile() {
>> +       local -r inc_dir="$1"
>> +       local -r header="$2"
>> +       local -r out="$3"
>> +       printf "int main(void) { return 0; }\n" | \
>> +               "$CC" -c \
>> +                 -o "$out" \
>> +                 -x c \
>> +                 -O0 \
>> +                 -std=c90 \
>> +                 -fno-eliminate-unused-debug-types \
>> +                 -g \
>> +                 "-I${inc_dir}" \
>> +                 -include "$header" \
>> +                 -
>> +}
>> +
>> +# Print the list of incompatible headers
>> +get_no_header_list() {
>> +       local -r ref="${1:-HEAD}"
>> +       # Start with the usr/include/Makefile to get a list of the headers
>> +       # that don't compile using this method.
>> +       {
>> +               # shellcheck disable=SC2016
>> +               printf 'all: ; @echo $(no-header-test)\n'
>> +               cat "usr/include/Makefile"
>> +       } | SRCARCH="$ARCH" make -f - | tr " " "\n" | grep -v "asm-generic"
>> +
>> +       # The makefile also skips all asm-generic files, but prints "asm-generic/%"
>> +       # which won't match the files in this script, so just print all the asm-generic
>> +       # headers manually.
>> +       git ls-tree --full-tree --name-only -r "$ref" -- include/uapi/asm-generic \
>> +               | grep '.h$' \
>> +               | cut -d '/' -f 2-
>> +
>> +       # Finally, print all the architecture-specific headers that are _not_ for the
>> +       # ARCH we're targeting
>> +       git ls-tree --full-tree --name-only -r "$ref" -- arch/*/include/uapi \
>> +               | grep '.h$' \
>> +               | grep -v "^arch/${ARCH}"
>> +}
>> +
>> +# Print the list of headers that are not exported for this architecture
>> +get_no_export_list() {
>> +       {
>> +               # shellcheck disable=SC2016
>> +               printf 'all: ; @echo $(no-export-headers)\n'
>> +               cat "include/uapi/Kbuild"
>> +       } | SRCARCH="$ARCH" srctree="$KERNEL_SRC" make -f - | tr " " "\n" | sed '/^[[:space:]]*$/d'
>> +}
>> +
>> +# Save the current git tree state, stashing if needed
>> +save_tree_state() {
>> +       printf "Saving current tree state... "
>> +       current_ref="$(git rev-parse HEAD)"
>> +       readonly current_ref
>> +       if ! git diff-index --quiet HEAD; then
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
>> +       if [ "$unstash" = "true" ]; then
>> +               git stash pop --quiet
>> +               unstash="false"
>> +       fi
>> +       printf "OK\n"
>> +}
>> +
>> +# Install headers for both git refs
>> +install_headers() {
>> +       local -r check_all="$1"
>> +       local -r base_ref="$2"
>> +       local -r ref="$3"
>> +
>> +       deviated_from_current_tree="false"
>> +       for inst_ref in "$base_ref" "$ref"; do
> 
> 
> Bakeshed1: personally, I would use 'ref' as an iterator.
> 
>       for ref in "$base_ref" "$past_ref"; do
> 
> I see overall inconsistency between ref vs past_ref.
> 
> 

Right, I will clean that up in v4.

> 
> 
> 
>> +               if [ -n "$inst_ref" ]; then
>> +                       if [ "$deviated_from_current_tree" = "false" ]; then
>> +                               save_tree_state
>> +                               trap 'rm -rf "$tmp_dir"; restore_tree_state;' EXIT
> 
> 
> Bikeshed2:
> Instead of updating the trap back-and-force,
> I would create a function.
> 
> 
> exit_handler () {
>        if [ "$deviated_from_current_tree" = true ]; then
>                  restore_tree_state
>        fi
> 
>        if [ -n "$tmp_dir" ]; then
>                  rm -rf "$tmp_dir"
>        fi
> }
> 
> trap exist_handler EXIT
> 
> 

Good idea, will add in v4.

> 
> 
> 
> 
>> +                               deviated_from_current_tree="true"
>> +                       fi
>> +                       # This script ($0) is already loaded into memory at this point,
>> +                       # so this operation is safe
>> +                       git checkout --quiet "$(git rev-parse "$inst_ref")"
>> +               fi
>> +
>> +               printf "Installing sanitized UAPI headers from %s... " "${inst_ref:-dirty tree}"
>> +               make ARCH="$ARCH" INSTALL_HDR_PATH="${tmp_dir}/${inst_ref}/usr" headers_install > /dev/null 2>&1
> 
> 
> You can add -j${MAX_THREADS} for faster 'make headers_install'.
> 
> 

Thanks for the tip. Will add in v4.

> 
> 
> 
> 
> 
> 
>> +               printf "OK\n"
>> +       done
>> +
>> +       restore_tree_state
>> +       trap 'rm -rf "$tmp_dir"' EXIT
>> +}
>> +
>> +# Check file list for UAPI compatibility
>> +check_uapi_files() {
>> +       local -r check_all="$1"
>> +       local -r base_ref="$2"
>> +       local -r ref="$3"
>> +
>> +       install_headers "$check_all" "$base_ref" "$ref"
>> +
>> +       local passed=0;
>> +       local failed=0;
>> +       local -a threads=()
>> +
>> +       printf "Checking changes to UAPI headers between %s and %s\n" "$ref" "${base_ref:-dirty tree}"
>> +       while read -r status file; do
>> +               if [ "${#threads[@]}" -ge "$MAX_THREADS" ]; then
>> +                       if wait "${threads[0]}"; then
>> +                               passed=$((passed + 1))
>> +                       else
>> +                               failed=$((failed + 1))
>> +                       fi
>> +                       threads=("${threads[@]:1}")
>> +               fi
>> +
>> +               check_individual_file "$base_ref" "$ref" "$status" "$file" &
>> +               threads+=("$!")
>> +       done < <(get_uapi_files "$check_all" "$base_ref" "$ref")
>> +
>> +       for t in "${threads[@]}"; do
>> +               if wait "$t"; then
>> +                       passed=$((passed + 1))
>> +               else
>> +                       failed=$((failed + 1))
>> +               fi
>> +       done
>> +
>> +       if [ "$check_all" = "true" ]; then
>> +               scope=$(printf "UAPI headers compatible with %s" "$ARCH")
>> +       else
>> +               scope=$(printf "UAPI headers modified between %s and %s" "$ref" "${base_ref:-dirty tree}")
>> +       fi
>> +
>> +       total="$((passed + failed))"
>> +       if [ "$failed" -gt 0 ]; then
>> +               eprintf "error - %d/%d %s appear _not_ to be backwards compatible\n" "$failed" "$total" "$scope"
>> +       else
>> +               printf "All %d %s appear to be backwards compatible\n" "$total" "$scope"
>> +       fi
>> +
>> +       if [ "$check_all" = "true" ]; then
>> +               printf "Note: UAPI headers for architectures other than %s were not checked\n" "$ARCH"
>> +       fi
>> +
>> +       return "$failed"
>> +}
>> +
>> +# Print the path to a given header in the tmp_dir
>> +get_header() {
>> +       local -r ref="$1"
>> +       local -r arch="$2"
>> +       local -r base="$3"
>> +
>> +       if [ -z "$arch" ]; then
>> +               printf "%s" "${tmp_dir}/${ref}/usr/${base}"
>> +       else
>> +               printf "%s" "${tmp_dir}/${ref}/usr/$(printf "%s" "$base" | cut -d '/' -f 3-)"
>> +       fi
>> +}
>> +
>> +# Check an individual file for UAPI compatibility
>> +check_individual_file() {
>> +       local -r base_ref="$1"
>> +       local -r ref="$2"
>> +       local -r status="$3"
>> +       local -r file="$4"
>> +
>> +       local -r base=${file/uapi\//}
>> +       local -r uapi_arch="$(printf "%s" "$file" | grep -o 'arch/.*/uapi' | cut -d '/' -f 2)"
>> +       local -r base_header=$(get_header "$base_ref" "$uapi_arch" "$base")
>> +       local -r ref_header=$(get_header "$ref" "$uapi_arch" "$base")
>> +       local -r installed_base="$(printf "%s" "$base_header" | grep -o "usr/include/.*" | cut -d '/' -f 3-)"
>> +
>> +       if [ "$status" = "D" ]; then
>> +               eprintf "error - UAPI header %s was incorrectly removed\n" "$file" | tee "${base_header}.error"
>> +               return 1
>> +       fi
>> +
>> +       # shellcheck disable=SC2076
>> +       if [[ " $(get_no_header_list | xargs) " =~ " $installed_base " ]]; then
>> +               printf "warning - %s cannot be tested by this script (see usr/include/Makefile)\n" "$file" | tee "${base_header}.error"
>> +               return 1
>> +       fi
>> +
>> +       # shellcheck disable=SC2076
>> +       if [[ " $(get_no_export_list | xargs) " =~ " $installed_base " ]]; then
>> +               printf "warning - %s is not exported by the %s architecture, so cannot be tested\n" "$file" "$ARCH" | tee "${base_header}.error"
>> +               return 1
>> +       fi
>> +
>> +       for h in "$base_header" "$ref_header"; do
>> +               if [ ! -f "$h" ]; then
>> +                       eprintf "error - %s does not exist - cannot compare ABI\n" "$h" | tee "${h}.error"
>> +                       return 1
>> +               fi
>> +       done
>> +
>> +       compare_abi "$file" "$base_header" "$ref_header" "$base_ref" "$ref"
>> +}
>> +
>> +# Perform the A/B compilation and compare output ABI
>> +compare_abi() {
>> +       local -r file="$1"
>> +       local -r base_header="$2"
>> +       local -r ref_header="$3"
>> +       local -r base_ref="$4"
>> +       local -r ref="$5"
>> +       local -r log="${tmp_dir}/log/$(basename "$file").log"
>> +
>> +       mkdir -p "$(dirname "$log")"
>> +
>> +       if ! do_compile "${tmp_dir}/${base_ref}/usr/include" "$base_header" "${base_header}.bin" 2> "$log"; then
>> +               eprintf "error - couldn't compile version of UAPI header %s at %s\n" "$file" "$base_ref"
>> +               cat "$log" >&2
>> +               exit "$FAIL_COMPILE"
>> +       fi
>> +
>> +       if ! do_compile "${tmp_dir}/${ref}/usr/include" "$ref_header" "${ref_header}.bin" 2> "$log"; then
>> +               eprintf "error - couldn't compile version of UAPI header %s at %s\n" "$file" "$ref"
>> +               cat "$log" >&2
>> +               exit "$FAIL_COMPILE"
>> +       fi
>> +
>> +       "$ABIDIFF" --non-reachable-types "${ref_header}.bin" "${base_header}.bin" > "$log" && ret="$?" || ret="$?"
>> +       if [ "$ret" -eq 0 ]; then
>> +               if [ "$VERBOSE" = "true" ]; then
>> +                       printf "No ABI differences detected in %s from %s -> %s\n" "$file" "$ref" "${base_ref:-dirty tree}"
>> +               fi
>> +       else
>> +               # Bits in abidiff's return code can be used to determine the type of error
>> +               if [ $(("$ret" & 0x1)) -gt 0 ]; then
>> +                       eprintf "error - abidiff did not run properly\n"
>> +                       exit 1
>> +               fi
>> +
>> +               # If the only changes were additions (not modifications to existing APIs), then
>> +               # there's no problem. Ignore these diffs.
>> +               if grep "Unreachable types summary" "$log" | grep -q "0 removed" &&
>> +                  grep "Unreachable types summary" "$log" | grep -q "0 changed"; then
>> +                       return 0
>> +               fi
>> +               {
>> +                       printf "!!! ABI differences detected in %s from %s -> %s !!!\n\n" "$file" "$ref" "${base_ref:-dirty tree}"
>> +                       sed  -e '/summary:/d' -e '/changed type/d' -e '/^$/d' -e 's/^/  /g' "$log"
>> +
>> +                       if ! cmp "$ref_header" "$base_header" > /dev/null 2>&1; then
>> +                               printf "\nHeader file diff (after headers_install):\n"
>> +                               diff -Naur "$ref_header" "$base_header" \
>> +                                       | sed -e "s|${ref_header}|${ref}/${file}|g" \
>> +                                             -e "s|${base_header}|${base_ref:-dirty}/${file}|g"
>> +                               printf "\n"
>> +                       else
>> +                               printf "\n%s did not change between %s and %s...\n" "$file" "$ref" "${base_ref:-dirty tree}"
>> +                               printf "It's possible a change to one of the headers it includes caused this error:\n"
>> +                               grep '^#include' "$base_header"
>> +                               printf "\n"
>> +                       fi
>> +               } | tee "${base_header}.error" >&2
>> +               return 1
>> +       fi
>> +}
>> +
>> +min_version_is_satisfied() {
>> +       local -r min_version="$1"
>> +       local -r version_installed="$2"
>> +
>> +       printf "%s\n%s\n" "$min_version" "$version_installed" | sort -Vc > /dev/null 2>&1
>> +}
>> +
>> +# Make sure we have the tools we need
>> +check_deps() {
>> +       ABIDIFF="${ABIDIFF:-abidiff}"
>> +       CC="${CC:-gcc}"
>> +       ARCH="${ARCH:-$(uname -m)}"
>> +       if [ "$ARCH" = "x86_64" ]; then
>> +               ARCH="x86"
>> +       fi
>> +
>> +       local -r abidiff_min_version="1.7"
>> +       local -r libdw_min_version_if_clang="0.171"
>> +
>> +       if ! command -v "$ABIDIFF" > /dev/null 2>&1; then
>> +               eprintf "error - abidiff not found!\n"
>> +               eprintf "Please install abigail-tools version %s or greater\n" "$abidiff_min_version"
>> +               eprintf "See: https://sourceware.org/libabigail/manual/libabigail-overview.html\n"
>> +               exit "$FAIL_PREREQ"
>> +       fi
>> +
>> +       local -r abidiff_version="$("$ABIDIFF" --version | cut -d ' ' -f 2)"
>> +       if ! min_version_is_satisfied "$abidiff_min_version" "$abidiff_version"; then
>> +               eprintf "error - abidiff version too old: %s\n" "$abidiff_version"
>> +               eprintf "Please install abigail-tools version %s or greater\n" "$abidiff_min_version"
>> +               eprintf "See: https://sourceware.org/libabigail/manual/libabigail-overview.html\n"
>> +               exit "$FAIL_PREREQ"
>> +       fi
>> +
>> +       if ! command -v "$CC" > /dev/null 2>&1; then
>> +               eprintf 'error - %s not found\n' "$CC"
>> +               exit "$FAIL_PREREQ"
>> +       fi
>> +
>> +       if "$CC" --version | grep -q clang; then
>> +               local -r libdw_version="$(ldconfig -v 2>/dev/null | grep -v SKIPPED | grep -m 1 -o 'libdw-[0-9]\+.[0-9]\+' | cut -c 7-)"
>> +               if ! min_version_is_satisfied "$libdw_min_version_if_clang" "$libdw_version"; then
>> +                       eprintf "error - libdw version too old for use with clang: %s\n" "$libdw_version"
>> +                       eprintf "Please install libdw from elfutils version %s or greater\n" "$libdw_min_version_if_clang"
>> +                       eprintf "See: https://sourceware.org/elfutils/\n"
>> +                       exit "$FAIL_PREREQ"
>> +               fi
>> +       fi
>> +
>> +       if [ ! -d "arch/${ARCH}" ]; then
>> +               eprintf 'error - ARCH "%s" is not a subdirectory under arch/\n' "$ARCH"
>> +               eprintf "Please set ARCH to one of:\n%s\n" "$(find arch -maxdepth 1 -mindepth 1 -type d -printf '%f ' | fmt)"
>> +               exit "$FAIL_PREREQ"
>> +       fi
>> +}
>> +
>> +run() {
>> +       local base_ref="$1"
>> +       local -r check_all="$2"
>> +       shift 2
>> +       local -r orig_args="$*"
>> +       if [ -z "$KERNEL_SRC" ]; then
>> +               KERNEL_SRC="$(realpath "$(dirname "$0")"/..)"
>> +       fi
>> +
>> +       cd "$KERNEL_SRC"
>> +
>> +       abi_error_log="${abi_error_log:-${KERNEL_SRC}/abi_error_log.txt}"
>> +
>> +       tmp_dir=$(mktemp -d)
>> +       trap 'rm -rf "$tmp_dir"' EXIT
>> +
>> +       check_deps
>> +
>> +       # Set of UAPI directories to check by default
>> +       UAPI_DIRS=(include/uapi arch/*/include/uapi)
>> +       GIT_ARGS="--name-status --no-renames --format= --diff-filter=a -- ${UAPI_DIRS[*]/%/\/*.h}"
>> +
>> +       if ! git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
>> +               eprintf "error - this script requires the kernel tree to be initialized with Git\n"
>> +               exit "$FAIL_PREREQ"
>> +       fi
>> +
>> +       # If there are no dirty UAPI files, use HEAD as base_ref
>> +       # shellcheck disable=SC2086
>> +       if [ -z "$base_ref" ] && git diff --exit-code $GIT_ARGS > /dev/null 2>&1; then
> 
> 
> I think this behavior is difficult to understand.
> 
> I think it is clearer to do 'git diff' for the entire tree
> when you determine the base_ref.
> 
> 

Okay. With the model of only looking at "make headers_install" output, I 
imagine this bit will change anyway.

> 
> 
> 
>> +               base_ref="HEAD"
>> +       fi
>> +
>> +       if [ -z "$past_ref" ]; then
>> +               if [ -n "$base_ref" ]; then
>> +                       past_ref="${base_ref}^1"
>> +               else
>> +                       past_ref="HEAD"
>> +               fi
>> +       fi
> 
> 
> 
> So, past_ref is set to either ${base_ref}^1 or HEAD here.
> 
> 
> No quotes are needed for HEAD.
> 
>     past_ref=HEAD
> 
> is enough.
> 
> 
> 
>> +
>> +       if [ -n "$past_ref" ] && ! git rev-parse --verify "$past_ref" > /dev/null 2>&1; then
> 
> 
> [ -n "$past_ref" ] is always true since past_ref is set to something.
> 
> 

Good point, must have missed this in an earlier refactor. Will fix in v4.

> 
> 
> 
> 
> 
> 
>> +               printf 'error - invalid git reference "%s"\n' "$past_ref"
>> +               exit "$FAIL_PREREQ"
>> +       fi
>> +
>> +       if [ -n "$base_ref" ]; then
>> +               if ! git merge-base --is-ancestor "$past_ref" "$base_ref" > /dev/null 2>&1; then
>> +                       printf 'error - "%s" is not an ancestor of base ref "%s"\n' "$past_ref" "$base_ref"
>> +                       exit "$FAIL_PREREQ"
>> +               fi
>> +       fi
>> +
>> +       if [ "$check_all" != "true" ] && ! get_uapi_files "$check_all" "$base_ref" "$past_ref" > /dev/null; then
>> +               printf "No changes to UAPI headers were applied between %s and %s\n" "$past_ref" "$base_ref"
>> +               exit "$SUCCESS"
>> +       fi
>> +
>> +       if ! check_uapi_files "$check_all" "$base_ref" "$past_ref"; then
>> +               eprintf "error - UAPI header ABI check failed\n"
>> +               {
>> +                       printf 'Generated by "%s %s" from git ref %s\n\n' "$0" "$orig_args" "$(git rev-parse "HEAD")"
>> +                       find "$tmp_dir" -type f -name '*.error' -exec cat {} +
>> +               } > "$abi_error_log"
>> +               eprintf "Failure summary saved to %s\n" "$abi_error_log"
>> +               exit "$FAIL_ABI"
>> +       fi
>> +}
>> +
>> +main() {
>> +       MAX_THREADS=$(nproc)
>> +       VERBOSE="false"
>> +       local base_ref=""
>> +       local check_all="true"
>> +       local quiet="false"
>> +       while getopts "hb:p:mj:l:qv" opt; do
>> +               case $opt in
>> +               h)
>> +                       print_usage
>> +                       exit "$SUCCESS"
>> +                       ;;
>> +               b)
>> +                       base_ref="$OPTARG"
>> +                       ;;
>> +               p)
>> +                       past_ref="$OPTARG"
>> +                       ;;
>> +               m)
>> +                       check_all="false"
>> +                       ;;
>> +               j)
>> +                       MAX_THREADS="$OPTARG"
>> +                       ;;
>> +               l)
>> +                       abi_error_log="$OPTARG"
>> +                       ;;
>> +               q)
>> +                       quiet="true"
>> +                       ;;
>> +               v)
>> +                       VERBOSE="true"
>> +                       ;;
>> +               *)
>> +                       exit "$FAIL_PREREQ"
>> +               esac
>> +       done
>> +
>> +       if [ "$quiet" = "true" ]; then
>> +               run "$base_ref" "$check_all" "$@" > /dev/null
>> +       else
>> +               run "$base_ref" "$check_all" "$@"
>> +       fi
>> +}
>> +
>> +main "$@"
>> --
>> 2.17.1
>>
> 
> 
> --
> Best Regards
> Masahiro Yamada

Thanks for the review!
