Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5A936AB186
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Mar 2023 18:09:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbjCERJM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Mar 2023 12:09:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjCERJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Mar 2023 12:09:11 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D50FEEB60;
        Sun,  5 Mar 2023 09:09:08 -0800 (PST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 325GjDIw018482;
        Sun, 5 Mar 2023 17:08:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=1njsHmqyQTdoddQCPxcxlkPisxjoXRxh6bMmERz5WC8=;
 b=JMYDEgf/NsxKhPd6NoNIJi9H3KMZCpFEqZN/lQwMb0CnT8MIIfQ2IspF3xDfuvaGTRCm
 KuvQCBBUChnL5UGyD4gCHIvrUCxtKQj0VUUFpjaMQPasOkso4UMDL2gRddqQ3CFzCmDg
 AFO8GpsoTyB1dM1C8GqP0kdL4fYykTIElTMorKwUMOO4zjf+DWUuxFn6zAjIrLvmXEt7
 wxj8WxFPju5wvA3tMEeGnOzo90HOkmmDlCYaxFLtn364QTHGUjQUyRPe+b7pgUkUq8sj
 WE3ZzJHYw5v7p2suo4DS3s48Mj/gVnlbOvqN1pCud8ftodvjJX+o0RkFNeXKqx8Ukxcq jw== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3p41872gqd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 05 Mar 2023 17:08:26 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 325H8PoQ029890
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 5 Mar 2023 17:08:25 GMT
Received: from [10.110.39.221] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Sun, 5 Mar 2023
 09:08:23 -0800
Message-ID: <d193d7e3-8fa5-d66b-d184-aac9239da417@quicinc.com>
Date:   Sun, 5 Mar 2023 09:08:21 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 1/2] check-uapi: Introduce check-uapi.sh
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
        Elliot Berman <quic_eberman@quicinc.com>
References: <20230301075402.4578-1-quic_johmoo@quicinc.com>
 <20230301075402.4578-2-quic_johmoo@quicinc.com>
 <CAK7LNAS-TSKYi8JGGZVa7YrLqLR+SjM-gYkd6ND=hAzGAxK1tg@mail.gmail.com>
Content-Language: en-US
From:   John Moon <quic_johmoo@quicinc.com>
In-Reply-To: <CAK7LNAS-TSKYi8JGGZVa7YrLqLR+SjM-gYkd6ND=hAzGAxK1tg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: L4X44KqPhqs_YGFWhypV28aa1heWff5X
X-Proofpoint-ORIG-GUID: L4X44KqPhqs_YGFWhypV28aa1heWff5X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-05_06,2023-03-03_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 priorityscore=1501 mlxscore=0 phishscore=0 lowpriorityscore=0
 malwarescore=0 mlxlogscore=999 bulkscore=0 suspectscore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303050151
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/4/2023 8:22 PM, Masahiro Yamada wrote:
> On Wed, Mar 1, 2023 at 4:54 PM John Moon <quic_johmoo@quicinc.com> wrote:
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
>> The script also includes the ability to check the compatibilty of
>> all UAPI headers across commits. This allows developers to inspect
>> the stability of the UAPIs over time.
> 
> 
> Let's see more test cases.
> 
> 
> [Case 1]
> 
> I think d759be8953febb6e5b5376c7d9bbf568864c6e2d
> is a trivial/good cleanup.
> Apparently, it still exports equivalent headers,
> but this tool reports "incorrectly removed".
> 
> 
> 
> $ ./scripts/check-uapi.sh -b d759be8953
> Saving current tree state... OK
> Installing sanitized UAPI headers from d759be8953... OK
> Installing sanitized UAPI headers from d759be8953^1... OK
> Restoring current tree state... OK
> Checking changes to UAPI headers starting from d759be8953
> error - UAPI header arch/alpha/include/uapi/asm/poll.h was incorrectly removed
> error - UAPI header arch/ia64/include/uapi/asm/poll.h was incorrectly removed
> error - UAPI header arch/x86/include/uapi/asm/poll.h was incorrectly removed
> /tmp/tmp.ixUIBlntUP/d759be8953/x86/usr/include/asm/Kbuild does not
> exist - cannot compare ABI
> /tmp/tmp.ixUIBlntUP/d759be8953/alpha/usr/include/asm/Kbuild does not
> exist - cannot compare ABI
> /tmp/tmp.ixUIBlntUP/d759be8953/ia64/usr/include/asm/Kbuild does not
> exist - cannot compare ABI
> error - 6/6 UAPI headers modified between d759be8953^1 and d759be8953
> are not backwards compatible
> error - UAPI header ABI check failed
> Failure summary saved to /home/masahiro/ref/linux/abi_error_log.txt
> 
> 

This is an interesting test case. Thanks for bringing it up. I don't 
know if there's a way for the script to filter out these kinds of 
changes, so it may just need to be noted under possible false positives 
in the document.

It also reveals that the script isn't filtering out non-headers from the 
git diffs... I'll fix that in v3.

> 
> [Case 2]
> 
> This tool compiles only changed headers.
> Does it detect ABI change?
> 
> I believe the users of the headers must be compiled.
> 
> 
> 
> Think about this case.
> 
> 
> $ cat foo-typedef.h
> typedef int foo_cap_type;
> 
> 
> $ cat foo.h
> #include "foo-typedef.h"
> 
> struct foo {
>         foo_cap_type capability;
> };
> 
> 
> 
> Then, change the first header to
>    typedef long long foo_cap_type;
> 
> abidiff will never notice the ABI change
> until it compiles "foo.h" instead of "foo-typedef.h"
>  >
> 
> For testing, I applied the following patch.
> 
> 
>   --- a/include/uapi/linux/types.h
>   +++ b/include/uapi/linux/types.h
>   @@ -52,7 +52,7 @@ typedef __u32 __bitwise __wsum;
>    #define __aligned_be64 __be64 __attribute__((aligned(8)))
>    #define __aligned_le64 __le64 __attribute__((aligned(8)))
> 
>   -typedef unsigned __bitwise __poll_t;
>   +typedef unsigned short __bitwise __poll_t;
> 
>    #endif /*  __ASSEMBLY__ */
>    #endif /* _UAPI_LINUX_TYPES_H */
> 
> 
> 
> 
> I believe this is an ABI change because this will change
> 'struct epoll_event' in the include/uapi/linux/eventpoll.h
> but the tool happily reports it is backwards compatible.
> 
> 
> $ ./scripts/check-uapi.sh
> Saving current tree state... OK
> Installing sanitized UAPI headers from HEAD... OK
> Installing sanitized UAPI headers from HEAD^1... OK
> Restoring current tree state... OK
> Checking changes to UAPI headers starting from HEAD
> No ABI differences detected in include/uapi/linux/types.h from HEAD^1 -> HEAD
> All 1 UAPI headers modified between HEAD^1 and HEAD are backwards compatible!
> 
> 

You're correct, this case is missed when only checking modified headers. 
With the same patch, if I pass "-a" to the script, it does catch the change:

% ./scripts/check-uapi.sh -a
--- snip ---
error - 1/1328 UAPI headers modified between HEAD and dirty tree are not 
backwards compatible
error - UAPI header ABI check failed


% cat abi_error_log.txt
Generated by "./scripts/check-uapi.sh -a" from git ref 
94b1166f7954f1136f307dafbaad5f9d871b73bf

!!! ABI differences detected in include/uapi/linux/eventpoll.h from HEAD 
-> dirty tree !!!

     [C] 'struct epoll_event' changed:
       type size changed from 96 to 80 (in bits)
       2 data member changes:
         type of '__poll_t events' changed:
           underlying type 'unsigned int' changed:
             type name changed from 'unsigned int' to 'unsigned short int'
             type size changed from 32 to 16 (in bits)
         '__u64 data' offset changed from 32 to 16 (in bits) (by -16 bits)

Perhaps in the next revision we could add some way to detect these 
dependencies (e.g. if foo.h includes bar.h, and bar.h was modified, we 
should check foo.h). However, the time savings may not be worth the 
complicated and potentially fragile dependency detection.

For now, "-a" should catch this, and it only took about 1 minute to run 
through all the headers on my 8-core machine, so it should be a 
resonable test step for a CI system.

> 
> 
> 
> I would not use such a tool that contains both false positives
> and false negatives, but you may notice this is more difficult
> than you had expected.
> 

Right, it certainly has its shortcomings. I appreciate you helping us 
find and address them! Even in its current state, I believe the script 
has value for developers and reviewers. :)

> I do not know if further review is worthwhile since this does not work
> but I added some more in-line comments.
> 
> 
> 
> 
> 
> 
>> +
>> +# Some UAPI headers require an architecture-specific compiler to build properly.
>> +ARCH_SPECIFIC_CC_NEEDED=(
>> +       "arch/hexagon/include/uapi/asm/sigcontext.h"
>> +       "arch/ia64/include/uapi/asm/intel_intrin.h"
>> +       "arch/ia64/include/uapi/asm/setup.h"
>> +       "arch/ia64/include/uapi/asm/sigcontext.h"
>> +       "arch/mips/include/uapi/asm/bitfield.h"
>> +       "arch/mips/include/uapi/asm/byteorder.h"
>> +       "arch/mips/include/uapi/asm/inst.h"
>> +       "arch/sparc/include/uapi/asm/fbio.h"
>> +       "arch/sparc/include/uapi/asm/uctx.h"
>> +       "arch/xtensa/include/uapi/asm/byteorder.h"
>> +       "arch/xtensa/include/uapi/asm/msgbuf.h"
>> +       "arch/xtensa/include/uapi/asm/sembuf.h"
>> +)
> 
> 
> Yes, arch/*/include/ must be compiled by the target compiler.
> If you compile them by the host compiler, it is unpredictable (i.e. wrong).
> 
> BTW, was this blacklist detected on a x86 host?
> 

Yes.

> If you do this on an ARM/ARM64 host, some headers
> under arch/x86/include/uapi/ might be blacklisted?
> 

Good point - I missed those!

> 
> 
>> +# Compile the simple test app
>> +do_compile() {
>> +       local -r inc_dir="$1"
>> +       local -r header="$2"
>> +       local -r out="$3"
>> +       printf "int main(void) { return 0; }\n" | \
>> +               "${CC:-gcc}" -c \
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
>> +# Print the list of incompatible headers from the usr/include Makefile
>> +get_no_header_list() {
>> +       {
>> +               # shellcheck disable=SC2016
>> +               printf 'all: ; @echo $(no-header-test)\n'
>> +               cat "usr/include/Makefile"
> 
> You must pass SRCARCH=$arch.
> 
> Otherwise,
> 
> ifeq ($(SRCARCH),...)
>    ...
> endif
> 
> are all skipped.
> 
> 

Thanks for the tip, that explains it. Should be able to address this in v3.

> 
> 
> 
>> +       } | make -f - | tr " " "\n" | grep -v "asm-generic"
>> +
>> +       # One additional header file is not building correctly
>> +       # with this method.
>> +       # TODO: why can't we build this one?
>> +       printf "asm-generic/ucontext.h\n"
> 
> 
> Answer - it is not intended for standalone compiling in the first place.
> 
> <asm-generic/*.h> should be included from <asm/*.h>.
> 
> Userspace never ever includes <asm-generic/*.h> directly.
> (If it does, it is a bug in the userspace program)
> 
> I am afraid you read user/include/Makefile wrongly.
> 
> 

Understood. I think I had misinterpreted one of your comments on v1, but 
now I'm clear. Will address in v3.

> 
> 
>> +
>> +# Install headers for every arch and ref we need
>> +install_headers() {
>> +       local -r check_all="$1"
>> +       local -r base_ref="$2"
>> +       local -r ref="$3"
>> +
>> +       local arch_list=()
>> +       while read -r status file; do
>> +               if arch="$(printf "%s" "$file" | grep -o 'arch/.*/uapi' | cut -d '/' -f 2)"; then
>> +                       # shellcheck disable=SC2076
>> +                       if ! [[ " ${arch_list[*]} " =~ " $arch " ]]; then
>> +                               arch_list+=("$arch")
>> +                       fi
>> +               fi
>> +       done < <(get_uapi_files "$check_all" "$base_ref" "$ref")
>> +
>> +       deviated_from_current_tree="false"
>> +       for inst_ref in "$base_ref" "$ref"; do
>> +               if [ -n "$inst_ref" ]; then
>> +                       if [ "$deviated_from_current_tree" = "false" ]; then
>> +                               save_tree_state
>> +                               trap 'rm -rf "$tmp_dir"; restore_tree_state;' EXIT
>> +                               deviated_from_current_tree="true"
>> +                       fi
>> +                       git checkout --quiet "$(git rev-parse "$inst_ref")"
> 
> 
> I might be wrong, but I was worried when I looked at this line
> because git-checkout may change the running code
> if check-uapi.sh is changed between ref and base_ref.
> 
> If bash always loads all code into memory before running
> it is safe but I do not know how it works.
> 
> 
> If this is safe, some comments might be worthwhile:
> 
>      # 'git checkout' may update this script itself while running,
>      # but it is OK because ...
> 

Yes, my understanding is that since the script is all encapsulated in 
functions, the shell has loaded all of the functions before execution 
starts. My testing has shown this to be safe as well. Will add a comment 
in v3.

> 
> 
> 
> 
>> +
>> +# Make sure we have the tools we need
>> +check_deps() {
>> +       export ABIDIFF="${ABIDIFF:-abidiff}"
>> +
>> +       if ! command -v "$ABIDIFF" > /dev/null 2>&1; then
>> +               eprintf "error - abidiff not found!\n"
>> +               eprintf "Please install abigail-tools (version 1.7 or greater)\n"
>> +               eprintf "See: https://sourceware.org/libabigail/manual/libabigail-overview.html\n"
>> +               exit 1
>> +       fi
>> +
>> +       read -r abidiff_maj abidiff_min _unused < <("$ABIDIFF" --version | cut -d ' ' -f 2 | tr '.' ' ')
>> +       if [ "$abidiff_maj" -lt 1 ] || { [ "$abidiff_maj" -eq 1 ] && [ "$abidiff_min" -lt 7 ]; }; then
> 
> 
> This is up to you, but I think "sort -V" would be cleaner.
> (see Documentation/devicetree/bindings/Makefile for example)
> 
> 

Noted.

> 
> 
>> +       fi
>> +
>> +       if [ ! -x "scripts/unifdef" ]; then
>> +               if ! make -f /dev/null scripts/unifdef; then
> 
> Previously, I wanted to point out that using Make is meaningless,
> and using gcc directly is better.
> 
> 
> But, is this still necessary?
> 
> V2 uses 'make headers_install' to install all headers.
> scripts/unifdef is not used anywhere in this script.
> 
> 

Ah, you're right it is not necessary. Previously, we were calling 
headers_install.sh directly, so make wasn't there to supply the unifdef 
dependency. Will remove this in v3.

> 
> 
> 
> 
>> +
>> +       abi_error_log="${abi_error_log:-${KERNEL_SRC}/abi_error_log.txt}"
>> +
>> +       check_deps
>> +
>> +       tmp_dir=$(mktemp -d)
>> +       trap 'rm -rf "$tmp_dir"' EXIT
>> +
>> +       # Set of UAPI directories to check by default
>> +       UAPI_DIRS=(include/uapi arch/*/include/uapi)
>> +
>> +       if ! git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
>> +               eprintf "error - this script requires the kernel tree to be initialized with Git\n"
>> +               exit 1
>> +       fi
>> +
>> +       # If there are no dirty UAPI files, use HEAD as base_ref
>> +       if [ -z "$base_ref" ] && [ "$(get_uapi_files "" "" | wc -l)" -eq 0 ]; then
>> +               base_ref="HEAD"
>> +       fi
>> +
>> +       if [ -z "$ref_to_check" ]; then
>> +               if [ -n "$base_ref" ]; then
>> +                       ref_to_check="${base_ref}^1"
>> +               else
>> +                       ref_to_check="HEAD"
>> +               fi
>> +       fi
> 
> 
> I think this is because I am not good at English, but
> I was so confused between 'base_ref' vs 'ref_to_check'.
> I do not get which one is the ancestor from the names.
> 
> I thought 'ref_a' and 'ref_b' would be less confusing,
> but I hope somebody will come up with better naming
> than that.
> 

Agreed, I think this is a confusing case for native English-speakers too. :)

I want to indicate that one ref has to come after the other in the Git 
tree. Maybe "base_ref" and "past_ref"? We'll think on it.

> 
> 
> 
> --
> Best Regards
> 
> 
> 
> 
> 
> Masahiro Yamada

Thank you again for the detailed review!
