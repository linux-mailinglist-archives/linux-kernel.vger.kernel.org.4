Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04BD66AAE2C
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Mar 2023 05:23:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbjCEEXk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Mar 2023 23:23:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjCEEXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Mar 2023 23:23:38 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF65DE398;
        Sat,  4 Mar 2023 20:23:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5B6A6609D1;
        Sun,  5 Mar 2023 04:23:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4E11C433D2;
        Sun,  5 Mar 2023 04:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677990215;
        bh=HwJt5mpBZJMxFs1RlZjUGZfSXgYdqwCBDagGksgbQ0s=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=gZnLama2iTRp+LQSMVII+rFRur7AmzIXcUA99GKzGrp3mlLHCNRCpmyhsqGVmUUfu
         F2HZo3e7+2RVhbL33Cv01AFjtoqGC3H8JUz+wlZ80C5K52y5dcJmIoPTN6oUbkrpC9
         vLDLawKREFs0UxSTp8aac9gwxhYXJiprgIeTiGvzBOX35KnS7Wtqyd9fdWMGJrBOSr
         CuncrR97+pZfi123RZX76HmezbrdgUUQkqLaDvjtOTlTGY3R+OcTzW9FOK1CziJEmr
         J9ZzmOqeSFpsA3TtkOhRkGfX4rjc2H77GyR8tuzkJEYe/XyVhRGzWtIQg3WH4P0uCr
         Qr9t2ccc/gfFQ==
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-1755e639b65so7846044fac.3;
        Sat, 04 Mar 2023 20:23:35 -0800 (PST)
X-Gm-Message-State: AO0yUKVEUhLxLJSm5hbw9NJc7dGZQS2pS5edvr5U8b+3f8u1QKUDiynd
        hPfuzilzbuC5p6Df1nVWdgcRIeXwzlYDqV70s/o=
X-Google-Smtp-Source: AK7set9kkFFqCPqikkVIe4pdlC40E/wq4stOOBxM0/3m3r5LTyDsUvr+e/WCz9grH7Kw4zwA9AYARFGUyPdRNouCRPw=
X-Received: by 2002:a05:6870:954c:b0:16a:17d9:b66d with SMTP id
 v12-20020a056870954c00b0016a17d9b66dmr2237971oal.8.1677990214838; Sat, 04 Mar
 2023 20:23:34 -0800 (PST)
MIME-Version: 1.0
References: <20230301075402.4578-1-quic_johmoo@quicinc.com> <20230301075402.4578-2-quic_johmoo@quicinc.com>
In-Reply-To: <20230301075402.4578-2-quic_johmoo@quicinc.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 5 Mar 2023 13:22:58 +0900
X-Gmail-Original-Message-ID: <CAK7LNAS-TSKYi8JGGZVa7YrLqLR+SjM-gYkd6ND=hAzGAxK1tg@mail.gmail.com>
Message-ID: <CAK7LNAS-TSKYi8JGGZVa7YrLqLR+SjM-gYkd6ND=hAzGAxK1tg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] check-uapi: Introduce check-uapi.sh
To:     John Moon <quic_johmoo@quicinc.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Todd Kjos <tkjos@google.com>,
        Matthias Maennich <maennich@google.com>,
        Giuliano Procida <gprocida@google.com>,
        kernel-team@android.com, libabigail@sourceware.org,
        Jordan Crouse <jorcrous@amazon.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>,
        Elliot Berman <quic_eberman@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 1, 2023 at 4:54=E2=80=AFPM John Moon <quic_johmoo@quicinc.com> =
wrote:
>
> While the kernel community has been good at maintaining backwards
> compatibility with kernel UAPIs, it would be helpful to have a tool
> to check if a commit introduces changes that break backwards
> compatibility.
>
> To that end, introduce check-uapi.sh: a simple shell script that
> checks for changes to UAPI headers using libabigail.
>
> libabigail is "a framework which aims at helping developers and
> software distributors to spot some ABI-related issues like interface
> incompatibility in ELF shared libraries by performing a static
> analysis of the ELF binaries at hand."
>
> The script uses one of libabigail's tools, "abidiff", to compile the
> changed header before and after the commit to detect any changes.
>
> abidiff "compares the ABI of two shared libraries in ELF format. It
> emits a meaningful report describing the differences between the two
> ABIs."
>
> The script also includes the ability to check the compatibilty of
> all UAPI headers across commits. This allows developers to inspect
> the stability of the UAPIs over time.


Let's see more test cases.


[Case 1]

I think d759be8953febb6e5b5376c7d9bbf568864c6e2d
is a trivial/good cleanup.
Apparently, it still exports equivalent headers,
but this tool reports "incorrectly removed".



$ ./scripts/check-uapi.sh -b d759be8953
Saving current tree state... OK
Installing sanitized UAPI headers from d759be8953... OK
Installing sanitized UAPI headers from d759be8953^1... OK
Restoring current tree state... OK
Checking changes to UAPI headers starting from d759be8953
error - UAPI header arch/alpha/include/uapi/asm/poll.h was incorrectly remo=
ved
error - UAPI header arch/ia64/include/uapi/asm/poll.h was incorrectly remov=
ed
error - UAPI header arch/x86/include/uapi/asm/poll.h was incorrectly remove=
d
/tmp/tmp.ixUIBlntUP/d759be8953/x86/usr/include/asm/Kbuild does not
exist - cannot compare ABI
/tmp/tmp.ixUIBlntUP/d759be8953/alpha/usr/include/asm/Kbuild does not
exist - cannot compare ABI
/tmp/tmp.ixUIBlntUP/d759be8953/ia64/usr/include/asm/Kbuild does not
exist - cannot compare ABI
error - 6/6 UAPI headers modified between d759be8953^1 and d759be8953
are not backwards compatible
error - UAPI header ABI check failed
Failure summary saved to /home/masahiro/ref/linux/abi_error_log.txt



[Case 2]

This tool compiles only changed headers.
Does it detect ABI change?

I believe the users of the headers must be compiled.



Think about this case.


$ cat foo-typedef.h
typedef int foo_cap_type;


$ cat foo.h
#include "foo-typedef.h"

struct foo {
       foo_cap_type capability;
};



Then, change the first header to
  typedef long long foo_cap_type;

abidiff will never notice the ABI change
until it compiles "foo.h" instead of "foo-typedef.h"



For testing, I applied the following patch.


 --- a/include/uapi/linux/types.h
 +++ b/include/uapi/linux/types.h
 @@ -52,7 +52,7 @@ typedef __u32 __bitwise __wsum;
  #define __aligned_be64 __be64 __attribute__((aligned(8)))
  #define __aligned_le64 __le64 __attribute__((aligned(8)))

 -typedef unsigned __bitwise __poll_t;
 +typedef unsigned short __bitwise __poll_t;

  #endif /*  __ASSEMBLY__ */
  #endif /* _UAPI_LINUX_TYPES_H */




I believe this is an ABI change because this will change
'struct epoll_event' in the include/uapi/linux/eventpoll.h
but the tool happily reports it is backwards compatible.


$ ./scripts/check-uapi.sh
Saving current tree state... OK
Installing sanitized UAPI headers from HEAD... OK
Installing sanitized UAPI headers from HEAD^1... OK
Restoring current tree state... OK
Checking changes to UAPI headers starting from HEAD
No ABI differences detected in include/uapi/linux/types.h from HEAD^1 -> HE=
AD
All 1 UAPI headers modified between HEAD^1 and HEAD are backwards compatibl=
e!





I would not use such a tool that contains both false positives
and false negatives, but you may notice this is more difficult
than you had expected.

I do not know if further review is worthwhile since this does not work
but I added some more in-line comments.






> +
> +# Some UAPI headers require an architecture-specific compiler to build p=
roperly.
> +ARCH_SPECIFIC_CC_NEEDED=3D(
> +       "arch/hexagon/include/uapi/asm/sigcontext.h"
> +       "arch/ia64/include/uapi/asm/intel_intrin.h"
> +       "arch/ia64/include/uapi/asm/setup.h"
> +       "arch/ia64/include/uapi/asm/sigcontext.h"
> +       "arch/mips/include/uapi/asm/bitfield.h"
> +       "arch/mips/include/uapi/asm/byteorder.h"
> +       "arch/mips/include/uapi/asm/inst.h"
> +       "arch/sparc/include/uapi/asm/fbio.h"
> +       "arch/sparc/include/uapi/asm/uctx.h"
> +       "arch/xtensa/include/uapi/asm/byteorder.h"
> +       "arch/xtensa/include/uapi/asm/msgbuf.h"
> +       "arch/xtensa/include/uapi/asm/sembuf.h"
> +)


Yes, arch/*/include/ must be compiled by the target compiler.
If you compile them by the host compiler, it is unpredictable (i.e. wrong).

BTW, was this blacklist detected on a x86 host?

If you do this on an ARM/ARM64 host, some headers
under arch/x86/include/uapi/ might be blacklisted?



> +# Compile the simple test app
> +do_compile() {
> +       local -r inc_dir=3D"$1"
> +       local -r header=3D"$2"
> +       local -r out=3D"$3"
> +       printf "int main(void) { return 0; }\n" | \
> +               "${CC:-gcc}" -c \
> +                 -o "$out" \
> +                 -x c \
> +                 -O0 \
> +                 -std=3Dc90 \
> +                 -fno-eliminate-unused-debug-types \
> +                 -g \
> +                 "-I${inc_dir}" \
> +                 -include "$header" \
> +                 -
> +}
> +
> +# Print the list of incompatible headers from the usr/include Makefile
> +get_no_header_list() {
> +       {
> +               # shellcheck disable=3DSC2016
> +               printf 'all: ; @echo $(no-header-test)\n'
> +               cat "usr/include/Makefile"

You must pass SRCARCH=3D$arch.

Otherwise,

ifeq ($(SRCARCH),...)
  ...
endif

are all skipped.





> +       } | make -f - | tr " " "\n" | grep -v "asm-generic"
> +
> +       # One additional header file is not building correctly
> +       # with this method.
> +       # TODO: why can't we build this one?
> +       printf "asm-generic/ucontext.h\n"


Answer - it is not intended for standalone compiling in the first place.

<asm-generic/*.h> should be included from <asm/*.h>.

Userspace never ever includes <asm-generic/*.h> directly.
(If it does, it is a bug in the userspace program)

I am afraid you read user/include/Makefile wrongly.




> +
> +# Install headers for every arch and ref we need
> +install_headers() {
> +       local -r check_all=3D"$1"
> +       local -r base_ref=3D"$2"
> +       local -r ref=3D"$3"
> +
> +       local arch_list=3D()
> +       while read -r status file; do
> +               if arch=3D"$(printf "%s" "$file" | grep -o 'arch/.*/uapi'=
 | cut -d '/' -f 2)"; then
> +                       # shellcheck disable=3DSC2076
> +                       if ! [[ " ${arch_list[*]} " =3D~ " $arch " ]]; th=
en
> +                               arch_list+=3D("$arch")
> +                       fi
> +               fi
> +       done < <(get_uapi_files "$check_all" "$base_ref" "$ref")
> +
> +       deviated_from_current_tree=3D"false"
> +       for inst_ref in "$base_ref" "$ref"; do
> +               if [ -n "$inst_ref" ]; then
> +                       if [ "$deviated_from_current_tree" =3D "false" ];=
 then
> +                               save_tree_state
> +                               trap 'rm -rf "$tmp_dir"; restore_tree_sta=
te;' EXIT
> +                               deviated_from_current_tree=3D"true"
> +                       fi
> +                       git checkout --quiet "$(git rev-parse "$inst_ref"=
)"


I might be wrong, but I was worried when I looked at this line
because git-checkout may change the running code
if check-uapi.sh is changed between ref and base_ref.

If bash always loads all code into memory before running
it is safe but I do not know how it works.


If this is safe, some comments might be worthwhile:

    # 'git checkout' may update this script itself while running,
    # but it is OK because ...





> +
> +# Make sure we have the tools we need
> +check_deps() {
> +       export ABIDIFF=3D"${ABIDIFF:-abidiff}"
> +
> +       if ! command -v "$ABIDIFF" > /dev/null 2>&1; then
> +               eprintf "error - abidiff not found!\n"
> +               eprintf "Please install abigail-tools (version 1.7 or gre=
ater)\n"
> +               eprintf "See: https://sourceware.org/libabigail/manual/li=
babigail-overview.html\n"
> +               exit 1
> +       fi
> +
> +       read -r abidiff_maj abidiff_min _unused < <("$ABIDIFF" --version =
| cut -d ' ' -f 2 | tr '.' ' ')
> +       if [ "$abidiff_maj" -lt 1 ] || { [ "$abidiff_maj" -eq 1 ] && [ "$=
abidiff_min" -lt 7 ]; }; then


This is up to you, but I think "sort -V" would be cleaner.
(see Documentation/devicetree/bindings/Makefile for example)




> +       fi
> +
> +       if [ ! -x "scripts/unifdef" ]; then
> +               if ! make -f /dev/null scripts/unifdef; then

Previously, I wanted to point out that using Make is meaningless,
and using gcc directly is better.


But, is this still necessary?

V2 uses 'make headers_install' to install all headers.
scripts/unifdef is not used anywhere in this script.






> +
> +       abi_error_log=3D"${abi_error_log:-${KERNEL_SRC}/abi_error_log.txt=
}"
> +
> +       check_deps
> +
> +       tmp_dir=3D$(mktemp -d)
> +       trap 'rm -rf "$tmp_dir"' EXIT
> +
> +       # Set of UAPI directories to check by default
> +       UAPI_DIRS=3D(include/uapi arch/*/include/uapi)
> +
> +       if ! git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
> +               eprintf "error - this script requires the kernel tree to =
be initialized with Git\n"
> +               exit 1
> +       fi
> +
> +       # If there are no dirty UAPI files, use HEAD as base_ref
> +       if [ -z "$base_ref" ] && [ "$(get_uapi_files "" "" | wc -l)" -eq =
0 ]; then
> +               base_ref=3D"HEAD"
> +       fi
> +
> +       if [ -z "$ref_to_check" ]; then
> +               if [ -n "$base_ref" ]; then
> +                       ref_to_check=3D"${base_ref}^1"
> +               else
> +                       ref_to_check=3D"HEAD"
> +               fi
> +       fi


I think this is because I am not good at English, but
I was so confused between 'base_ref' vs 'ref_to_check'.
I do not get which one is the ancestor from the names.

I thought 'ref_a' and 'ref_b' would be less confusing,
but I hope somebody will come up with better naming
than that.




--
Best Regards





Masahiro Yamada
