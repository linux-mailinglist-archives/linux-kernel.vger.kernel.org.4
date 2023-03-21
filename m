Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F15486C3C91
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 22:20:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbjCUVUY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 17:20:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbjCUVUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 17:20:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F369123C66;
        Tue, 21 Mar 2023 14:20:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6363CB81A34;
        Tue, 21 Mar 2023 21:20:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 050A3C4339B;
        Tue, 21 Mar 2023 21:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679433609;
        bh=2wKTGNUgT01SGXFLp6S9vKpyw1vx+bPEoU6LrUlPCoA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=afJNVHSLfVF9NXtX2aGnfNrMnWmhHRxuNv5YPf7LxeA4iGNqKJvslIDoxOsO5/Y1a
         /IZzn/YMCMr9Uy9JFQWxtFSSgNKx6FqrQWg6vG8qjy80GgVGD9kohrJqQtr/3x9d4E
         wtUAvVdQQ+YG5uAo8mo1RpFmDh4TDu5aaS9I/fLnlj9aEwh7u+8mWsqAHd7h/NfBJP
         1alahMyHdPsI+O0ZxHUBY7z14Tl4u5rxS4mngU+FDGCTZRjuGFxiIxjbAZWtnbpONi
         rE3vkEGE78XLb9lp7RfRdiSyH/vZrHVCjeb10NNxfzO+AAp0WUnrOsjnHSVtBcM4zx
         yL/JUWshFRHAQ==
Received: by mail-lj1-f174.google.com with SMTP id s20so9740130ljp.1;
        Tue, 21 Mar 2023 14:20:08 -0700 (PDT)
X-Gm-Message-State: AO0yUKUJHXfOxCU7U+5HV0Q6Hh1BTh6aPMMT7n0NJk4PeeuXbOGyyZAv
        f3YOMQcRaw8K6/IL18WAyHnPuN3emR4Xgn49fgw=
X-Google-Smtp-Source: AK7set9cMksvnNvFHgVFeeZzQMkT0FpuXmgsrtAm/r6k8wBJPs0ghrW5lUIkiySJQ5jKLKwmJG4Uzz77x4dNkMRItTA=
X-Received: by 2002:a2e:82d7:0:b0:295:945d:b382 with SMTP id
 n23-20020a2e82d7000000b00295945db382mr1336079ljh.4.1679433607232; Tue, 21 Mar
 2023 14:20:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230316181555.9327-1-quic_johmoo@quicinc.com> <20230316181555.9327-2-quic_johmoo@quicinc.com>
In-Reply-To: <20230316181555.9327-2-quic_johmoo@quicinc.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 22 Mar 2023 06:19:28 +0900
X-Gmail-Original-Message-ID: <CAK7LNATFTOc_9qGMP4B8cRr4NY_NSpE8dMXPjEkJv+aqUj2_Lw@mail.gmail.com>
Message-ID: <CAK7LNATFTOc_9qGMP4B8cRr4NY_NSpE8dMXPjEkJv+aqUj2_Lw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] check-uapi: Introduce check-uapi.sh
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
        Elliot Berman <quic_eberman@quicinc.com>,
        Guru Das Srinagesh <quic_gurus@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 17, 2023 at 3:17=E2=80=AFAM John Moon <quic_johmoo@quicinc.com>=
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
> The script also includes the ability to check the compatibility of
> all UAPI headers across commits. This allows developers to inspect
> the stability of the UAPIs over time.
>
> Signed-off-by: John Moon <quic_johmoo@quicinc.com>



I think I pointed out that not all UAPI headers are checked-in.


I applied the following.
This will remove <asm/termios.h>.
So, definitely it is a UAPI breakage, but check_all=3Dtrue
mode succeeds.


 diff --git a/include/uapi/asm-generic/Kbuild b/include/uapi/asm-generic/Kb=
uild
 index ebb180aac74e..a9c88b0a8b3b 100644
 --- a/include/uapi/asm-generic/Kbuild
 +++ b/include/uapi/asm-generic/Kbuild
 @@ -31,6 +31,6 @@ mandatory-y +=3D stat.h
  mandatory-y +=3D statfs.h
  mandatory-y +=3D swab.h
  mandatory-y +=3D termbits.h
 -mandatory-y +=3D termios.h
 +#mandatory-y +=3D termios.h
  mandatory-y +=3D types.h
  mandatory-y +=3D unistd.h




Another false positive is a change outside the uapi directories.

For x86, syscall UAPI headers are generated in
arch/x86/entry/syscalls/.


You never know the compatibility of UAPI unless you check
all the headers that 'make headers_install' results in.


I am reluctant to read the whole code,
but I spotted possible bugs.





> +
> +readonly SUCCESS=3D0
> +readonly FAIL_ABI=3D1
> +readonly FAIL_PREREQ=3D2
> +readonly FAIL_COMPILE=3D3
> +readonly FAIL_ARCH=3D4
> +readonly FAIL=3D5
> +
> +# Print to stderr
> +eprintf() {
> +       # shellcheck disable=3DSC2059
> +       printf "$@" >&2
> +}
> +
> +# Print list of UAPI files to operate on
> +get_uapi_files() {
> +       local -r check_all=3D"$1"
> +       local -r base_ref=3D"$2"
> +       local -r ref=3D"$3"

local -r past_ref=3D"$3"



> +       local -r file_list=3D"${tmp_dir}/file_list.txt"
> +
> +       # Return already-processed list if it's available
> +       if [ -s "$file_list" ]; then
> +               cat "$file_list"
> +               return 0
> +       fi
> +
> +       if [ "$check_all" =3D "true" ]; then
> +               # Print all of the UAPI header files at the commit in que=
stion
> +               # Ignore the headers that we can't test.
> +               # shellcheck disable=3DSC2086,SC2046
> +               git ls-tree --full-tree --name-only -r "${base_ref:-HEAD}=
" -- "${UAPI_DIRS[@]}" \
> +                       | grep '.h$' \
> +                       | sed -e 's/^/M\t/g' \
> +                       | grep -v $({ get_no_header_list "$base_ref"; get=
_no_export_list; } | xargs -- printf '-e %s ') \
> +                       > "$file_list"
> +       else
> +               if [ -z "$base_ref" ] || [ -z "$ref" ]; then


[ -z "$ref" ] is always false.



> +                       # shellcheck disable=3DSC2086
> +                       git diff $GIT_ARGS > "$file_list"


This is a bug.

Think about this situation:

  $base_ref is empty, i.e. workspace
  $ref is not HEAD but a commit in the past.


"git diff" will return the diff
between the cache and the workspace.






> +               else
> +                       # shellcheck disable=3DSC2086
> +                       git diff "$ref" "$base_ref" $GIT_ARGS > "$file_li=
st"
> +               fi


Do you need this if...else...fi block in the first place?


   git diff $ref $base_ref $GIT_ARGS > "$file_list"


will naturally work correctly for all cases.
(do not quote $base_ref, which might be empty)




> +
> +               if mismatch_arch_files=3D$(grep -v "arch/${ARCH}" "$file_=
list" | grep -o "arch/.*\.h"); then
> +                       eprintf "warning - detected changes to following =
files, but can't check them with %s compiler:\n" "$ARCH"
> +                       for f in $mismatch_arch_files; do
> +                               eprintf "  - %s\n" "$f"
> +                               sed -i -e "\|${f}|d" "$file_list"
> +                               printf "warning - could not perform ABI c=
heck on %s with %s compiler\n" "$f" "$ARCH" \
> +                                       >> "${tmp_dir}/arch_mismatches.er=
ror"
> +                       done
> +                       eprintf "\nFiltering them out and performing part=
ial check on remaining files...\n"
> +                       if [ ! -s "$file_list" ]; then
> +                               eprintf "error - all files were filtered =
out, there's nothing to check!\n"
> +                               exit "$FAIL_ARCH"
> +                       fi
> +               fi
> +       fi
> +
> +       if [ ! -s "$file_list" ]; then
> +               return 1
> +       fi
> +
> +       cat "$file_list"
> +}
> +
> +# Compile the simple test app
> +do_compile() {
> +       local -r inc_dir=3D"$1"
> +       local -r header=3D"$2"
> +       local -r out=3D"$3"
> +       printf "int main(void) { return 0; }\n" | \
> +               "$CC" -c \
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
> +# Print the list of incompatible headers
> +get_no_header_list() {
> +       local -r ref=3D"${1:-HEAD}"
> +       # Start with the usr/include/Makefile to get a list of the header=
s
> +       # that don't compile using this method.
> +       {
> +               # shellcheck disable=3DSC2016
> +               printf 'all: ; @echo $(no-header-test)\n'
> +               cat "usr/include/Makefile"
> +       } | SRCARCH=3D"$ARCH" make -f - | tr " " "\n" | grep -v "asm-gene=
ric"
> +
> +       # The makefile also skips all asm-generic files, but prints "asm-=
generic/%"
> +       # which won't match the files in this script, so just print all t=
he asm-generic
> +       # headers manually.
> +       git ls-tree --full-tree --name-only -r "$ref" -- include/uapi/asm=
-generic \
> +               | grep '.h$' \
> +               | cut -d '/' -f 2-
> +
> +       # Finally, print all the architecture-specific headers that are _=
not_ for the
> +       # ARCH we're targeting
> +       git ls-tree --full-tree --name-only -r "$ref" -- arch/*/include/u=
api \
> +               | grep '.h$' \
> +               | grep -v "^arch/${ARCH}"
> +}
> +
> +# Print the list of headers that are not exported for this architecture
> +get_no_export_list() {
> +       {
> +               # shellcheck disable=3DSC2016
> +               printf 'all: ; @echo $(no-export-headers)\n'
> +               cat "include/uapi/Kbuild"
> +       } | SRCARCH=3D"$ARCH" srctree=3D"$KERNEL_SRC" make -f - | tr " " =
"\n" | sed '/^[[:space:]]*$/d'
> +}
> +
> +# Save the current git tree state, stashing if needed
> +save_tree_state() {
> +       printf "Saving current tree state... "
> +       current_ref=3D"$(git rev-parse HEAD)"
> +       readonly current_ref
> +       if ! git diff-index --quiet HEAD; then
> +               unstash=3D"true"
> +               git stash push --quiet
> +       fi
> +       printf "OK\n"
> +}
> +
> +# Restore the git tree state, unstashing if needed
> +restore_tree_state() {
> +       if [ -z "$current_ref" ]; then
> +               return 0
> +       fi
> +
> +       printf "Restoring current tree state... "
> +       git checkout --quiet "$current_ref"
> +       if [ "$unstash" =3D "true" ]; then
> +               git stash pop --quiet
> +               unstash=3D"false"
> +       fi
> +       printf "OK\n"
> +}
> +
> +# Install headers for both git refs
> +install_headers() {
> +       local -r check_all=3D"$1"
> +       local -r base_ref=3D"$2"
> +       local -r ref=3D"$3"
> +
> +       deviated_from_current_tree=3D"false"
> +       for inst_ref in "$base_ref" "$ref"; do


Bakeshed1: personally, I would use 'ref' as an iterator.

     for ref in "$base_ref" "$past_ref"; do

I see overall inconsistency between ref vs past_ref.





> +               if [ -n "$inst_ref" ]; then
> +                       if [ "$deviated_from_current_tree" =3D "false" ];=
 then
> +                               save_tree_state
> +                               trap 'rm -rf "$tmp_dir"; restore_tree_sta=
te;' EXIT


Bikeshed2:
Instead of updating the trap back-and-force,
I would create a function.


exit_handler () {
      if [ "$deviated_from_current_tree" =3D true ]; then
                restore_tree_state
      fi

      if [ -n "$tmp_dir" ]; then
                rm -rf "$tmp_dir"
      fi
}

trap exist_handler EXIT






> +                               deviated_from_current_tree=3D"true"
> +                       fi
> +                       # This script ($0) is already loaded into memory =
at this point,
> +                       # so this operation is safe
> +                       git checkout --quiet "$(git rev-parse "$inst_ref"=
)"
> +               fi
> +
> +               printf "Installing sanitized UAPI headers from %s... " "$=
{inst_ref:-dirty tree}"
> +               make ARCH=3D"$ARCH" INSTALL_HDR_PATH=3D"${tmp_dir}/${inst=
_ref}/usr" headers_install > /dev/null 2>&1


You can add -j${MAX_THREADS} for faster 'make headers_install'.








> +               printf "OK\n"
> +       done
> +
> +       restore_tree_state
> +       trap 'rm -rf "$tmp_dir"' EXIT
> +}
> +
> +# Check file list for UAPI compatibility
> +check_uapi_files() {
> +       local -r check_all=3D"$1"
> +       local -r base_ref=3D"$2"
> +       local -r ref=3D"$3"
> +
> +       install_headers "$check_all" "$base_ref" "$ref"
> +
> +       local passed=3D0;
> +       local failed=3D0;
> +       local -a threads=3D()
> +
> +       printf "Checking changes to UAPI headers between %s and %s\n" "$r=
ef" "${base_ref:-dirty tree}"
> +       while read -r status file; do
> +               if [ "${#threads[@]}" -ge "$MAX_THREADS" ]; then
> +                       if wait "${threads[0]}"; then
> +                               passed=3D$((passed + 1))
> +                       else
> +                               failed=3D$((failed + 1))
> +                       fi
> +                       threads=3D("${threads[@]:1}")
> +               fi
> +
> +               check_individual_file "$base_ref" "$ref" "$status" "$file=
" &
> +               threads+=3D("$!")
> +       done < <(get_uapi_files "$check_all" "$base_ref" "$ref")
> +
> +       for t in "${threads[@]}"; do
> +               if wait "$t"; then
> +                       passed=3D$((passed + 1))
> +               else
> +                       failed=3D$((failed + 1))
> +               fi
> +       done
> +
> +       if [ "$check_all" =3D "true" ]; then
> +               scope=3D$(printf "UAPI headers compatible with %s" "$ARCH=
")
> +       else
> +               scope=3D$(printf "UAPI headers modified between %s and %s=
" "$ref" "${base_ref:-dirty tree}")
> +       fi
> +
> +       total=3D"$((passed + failed))"
> +       if [ "$failed" -gt 0 ]; then
> +               eprintf "error - %d/%d %s appear _not_ to be backwards co=
mpatible\n" "$failed" "$total" "$scope"
> +       else
> +               printf "All %d %s appear to be backwards compatible\n" "$=
total" "$scope"
> +       fi
> +
> +       if [ "$check_all" =3D "true" ]; then
> +               printf "Note: UAPI headers for architectures other than %=
s were not checked\n" "$ARCH"
> +       fi
> +
> +       return "$failed"
> +}
> +
> +# Print the path to a given header in the tmp_dir
> +get_header() {
> +       local -r ref=3D"$1"
> +       local -r arch=3D"$2"
> +       local -r base=3D"$3"
> +
> +       if [ -z "$arch" ]; then
> +               printf "%s" "${tmp_dir}/${ref}/usr/${base}"
> +       else
> +               printf "%s" "${tmp_dir}/${ref}/usr/$(printf "%s" "$base" =
| cut -d '/' -f 3-)"
> +       fi
> +}
> +
> +# Check an individual file for UAPI compatibility
> +check_individual_file() {
> +       local -r base_ref=3D"$1"
> +       local -r ref=3D"$2"
> +       local -r status=3D"$3"
> +       local -r file=3D"$4"
> +
> +       local -r base=3D${file/uapi\//}
> +       local -r uapi_arch=3D"$(printf "%s" "$file" | grep -o 'arch/.*/ua=
pi' | cut -d '/' -f 2)"
> +       local -r base_header=3D$(get_header "$base_ref" "$uapi_arch" "$ba=
se")
> +       local -r ref_header=3D$(get_header "$ref" "$uapi_arch" "$base")
> +       local -r installed_base=3D"$(printf "%s" "$base_header" | grep -o=
 "usr/include/.*" | cut -d '/' -f 3-)"
> +
> +       if [ "$status" =3D "D" ]; then
> +               eprintf "error - UAPI header %s was incorrectly removed\n=
" "$file" | tee "${base_header}.error"
> +               return 1
> +       fi
> +
> +       # shellcheck disable=3DSC2076
> +       if [[ " $(get_no_header_list | xargs) " =3D~ " $installed_base " =
]]; then
> +               printf "warning - %s cannot be tested by this script (see=
 usr/include/Makefile)\n" "$file" | tee "${base_header}.error"
> +               return 1
> +       fi
> +
> +       # shellcheck disable=3DSC2076
> +       if [[ " $(get_no_export_list | xargs) " =3D~ " $installed_base " =
]]; then
> +               printf "warning - %s is not exported by the %s architectu=
re, so cannot be tested\n" "$file" "$ARCH" | tee "${base_header}.error"
> +               return 1
> +       fi
> +
> +       for h in "$base_header" "$ref_header"; do
> +               if [ ! -f "$h" ]; then
> +                       eprintf "error - %s does not exist - cannot compa=
re ABI\n" "$h" | tee "${h}.error"
> +                       return 1
> +               fi
> +       done
> +
> +       compare_abi "$file" "$base_header" "$ref_header" "$base_ref" "$re=
f"
> +}
> +
> +# Perform the A/B compilation and compare output ABI
> +compare_abi() {
> +       local -r file=3D"$1"
> +       local -r base_header=3D"$2"
> +       local -r ref_header=3D"$3"
> +       local -r base_ref=3D"$4"
> +       local -r ref=3D"$5"
> +       local -r log=3D"${tmp_dir}/log/$(basename "$file").log"
> +
> +       mkdir -p "$(dirname "$log")"
> +
> +       if ! do_compile "${tmp_dir}/${base_ref}/usr/include" "$base_heade=
r" "${base_header}.bin" 2> "$log"; then
> +               eprintf "error - couldn't compile version of UAPI header =
%s at %s\n" "$file" "$base_ref"
> +               cat "$log" >&2
> +               exit "$FAIL_COMPILE"
> +       fi
> +
> +       if ! do_compile "${tmp_dir}/${ref}/usr/include" "$ref_header" "${=
ref_header}.bin" 2> "$log"; then
> +               eprintf "error - couldn't compile version of UAPI header =
%s at %s\n" "$file" "$ref"
> +               cat "$log" >&2
> +               exit "$FAIL_COMPILE"
> +       fi
> +
> +       "$ABIDIFF" --non-reachable-types "${ref_header}.bin" "${base_head=
er}.bin" > "$log" && ret=3D"$?" || ret=3D"$?"
> +       if [ "$ret" -eq 0 ]; then
> +               if [ "$VERBOSE" =3D "true" ]; then
> +                       printf "No ABI differences detected in %s from %s=
 -> %s\n" "$file" "$ref" "${base_ref:-dirty tree}"
> +               fi
> +       else
> +               # Bits in abidiff's return code can be used to determine =
the type of error
> +               if [ $(("$ret" & 0x1)) -gt 0 ]; then
> +                       eprintf "error - abidiff did not run properly\n"
> +                       exit 1
> +               fi
> +
> +               # If the only changes were additions (not modifications t=
o existing APIs), then
> +               # there's no problem. Ignore these diffs.
> +               if grep "Unreachable types summary" "$log" | grep -q "0 r=
emoved" &&
> +                  grep "Unreachable types summary" "$log" | grep -q "0 c=
hanged"; then
> +                       return 0
> +               fi
> +               {
> +                       printf "!!! ABI differences detected in %s from %=
s -> %s !!!\n\n" "$file" "$ref" "${base_ref:-dirty tree}"
> +                       sed  -e '/summary:/d' -e '/changed type/d' -e '/^=
$/d' -e 's/^/  /g' "$log"
> +
> +                       if ! cmp "$ref_header" "$base_header" > /dev/null=
 2>&1; then
> +                               printf "\nHeader file diff (after headers=
_install):\n"
> +                               diff -Naur "$ref_header" "$base_header" \
> +                                       | sed -e "s|${ref_header}|${ref}/=
${file}|g" \
> +                                             -e "s|${base_header}|${base=
_ref:-dirty}/${file}|g"
> +                               printf "\n"
> +                       else
> +                               printf "\n%s did not change between %s an=
d %s...\n" "$file" "$ref" "${base_ref:-dirty tree}"
> +                               printf "It's possible a change to one of =
the headers it includes caused this error:\n"
> +                               grep '^#include' "$base_header"
> +                               printf "\n"
> +                       fi
> +               } | tee "${base_header}.error" >&2
> +               return 1
> +       fi
> +}
> +
> +min_version_is_satisfied() {
> +       local -r min_version=3D"$1"
> +       local -r version_installed=3D"$2"
> +
> +       printf "%s\n%s\n" "$min_version" "$version_installed" | sort -Vc =
> /dev/null 2>&1
> +}
> +
> +# Make sure we have the tools we need
> +check_deps() {
> +       ABIDIFF=3D"${ABIDIFF:-abidiff}"
> +       CC=3D"${CC:-gcc}"
> +       ARCH=3D"${ARCH:-$(uname -m)}"
> +       if [ "$ARCH" =3D "x86_64" ]; then
> +               ARCH=3D"x86"
> +       fi
> +
> +       local -r abidiff_min_version=3D"1.7"
> +       local -r libdw_min_version_if_clang=3D"0.171"
> +
> +       if ! command -v "$ABIDIFF" > /dev/null 2>&1; then
> +               eprintf "error - abidiff not found!\n"
> +               eprintf "Please install abigail-tools version %s or great=
er\n" "$abidiff_min_version"
> +               eprintf "See: https://sourceware.org/libabigail/manual/li=
babigail-overview.html\n"
> +               exit "$FAIL_PREREQ"
> +       fi
> +
> +       local -r abidiff_version=3D"$("$ABIDIFF" --version | cut -d ' ' -=
f 2)"
> +       if ! min_version_is_satisfied "$abidiff_min_version" "$abidiff_ve=
rsion"; then
> +               eprintf "error - abidiff version too old: %s\n" "$abidiff=
_version"
> +               eprintf "Please install abigail-tools version %s or great=
er\n" "$abidiff_min_version"
> +               eprintf "See: https://sourceware.org/libabigail/manual/li=
babigail-overview.html\n"
> +               exit "$FAIL_PREREQ"
> +       fi
> +
> +       if ! command -v "$CC" > /dev/null 2>&1; then
> +               eprintf 'error - %s not found\n' "$CC"
> +               exit "$FAIL_PREREQ"
> +       fi
> +
> +       if "$CC" --version | grep -q clang; then
> +               local -r libdw_version=3D"$(ldconfig -v 2>/dev/null | gre=
p -v SKIPPED | grep -m 1 -o 'libdw-[0-9]\+.[0-9]\+' | cut -c 7-)"
> +               if ! min_version_is_satisfied "$libdw_min_version_if_clan=
g" "$libdw_version"; then
> +                       eprintf "error - libdw version too old for use wi=
th clang: %s\n" "$libdw_version"
> +                       eprintf "Please install libdw from elfutils versi=
on %s or greater\n" "$libdw_min_version_if_clang"
> +                       eprintf "See: https://sourceware.org/elfutils/\n"
> +                       exit "$FAIL_PREREQ"
> +               fi
> +       fi
> +
> +       if [ ! -d "arch/${ARCH}" ]; then
> +               eprintf 'error - ARCH "%s" is not a subdirectory under ar=
ch/\n' "$ARCH"
> +               eprintf "Please set ARCH to one of:\n%s\n" "$(find arch -=
maxdepth 1 -mindepth 1 -type d -printf '%f ' | fmt)"
> +               exit "$FAIL_PREREQ"
> +       fi
> +}
> +
> +run() {
> +       local base_ref=3D"$1"
> +       local -r check_all=3D"$2"
> +       shift 2
> +       local -r orig_args=3D"$*"
> +       if [ -z "$KERNEL_SRC" ]; then
> +               KERNEL_SRC=3D"$(realpath "$(dirname "$0")"/..)"
> +       fi
> +
> +       cd "$KERNEL_SRC"
> +
> +       abi_error_log=3D"${abi_error_log:-${KERNEL_SRC}/abi_error_log.txt=
}"
> +
> +       tmp_dir=3D$(mktemp -d)
> +       trap 'rm -rf "$tmp_dir"' EXIT
> +
> +       check_deps
> +
> +       # Set of UAPI directories to check by default
> +       UAPI_DIRS=3D(include/uapi arch/*/include/uapi)
> +       GIT_ARGS=3D"--name-status --no-renames --format=3D --diff-filter=
=3Da -- ${UAPI_DIRS[*]/%/\/*.h}"
> +
> +       if ! git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
> +               eprintf "error - this script requires the kernel tree to =
be initialized with Git\n"
> +               exit "$FAIL_PREREQ"
> +       fi
> +
> +       # If there are no dirty UAPI files, use HEAD as base_ref
> +       # shellcheck disable=3DSC2086
> +       if [ -z "$base_ref" ] && git diff --exit-code $GIT_ARGS > /dev/nu=
ll 2>&1; then


I think this behavior is difficult to understand.

I think it is clearer to do 'git diff' for the entire tree
when you determine the base_ref.





> +               base_ref=3D"HEAD"
> +       fi
> +
> +       if [ -z "$past_ref" ]; then
> +               if [ -n "$base_ref" ]; then
> +                       past_ref=3D"${base_ref}^1"
> +               else
> +                       past_ref=3D"HEAD"
> +               fi
> +       fi



So, past_ref is set to either ${base_ref}^1 or HEAD here.


No quotes are needed for HEAD.

   past_ref=3DHEAD

is enough.



> +
> +       if [ -n "$past_ref" ] && ! git rev-parse --verify "$past_ref" > /=
dev/null 2>&1; then


[ -n "$past_ref" ] is always true since past_ref is set to something.








> +               printf 'error - invalid git reference "%s"\n' "$past_ref"
> +               exit "$FAIL_PREREQ"
> +       fi
> +
> +       if [ -n "$base_ref" ]; then
> +               if ! git merge-base --is-ancestor "$past_ref" "$base_ref"=
 > /dev/null 2>&1; then
> +                       printf 'error - "%s" is not an ancestor of base r=
ef "%s"\n' "$past_ref" "$base_ref"
> +                       exit "$FAIL_PREREQ"
> +               fi
> +       fi
> +
> +       if [ "$check_all" !=3D "true" ] && ! get_uapi_files "$check_all" =
"$base_ref" "$past_ref" > /dev/null; then
> +               printf "No changes to UAPI headers were applied between %=
s and %s\n" "$past_ref" "$base_ref"
> +               exit "$SUCCESS"
> +       fi
> +
> +       if ! check_uapi_files "$check_all" "$base_ref" "$past_ref"; then
> +               eprintf "error - UAPI header ABI check failed\n"
> +               {
> +                       printf 'Generated by "%s %s" from git ref %s\n\n'=
 "$0" "$orig_args" "$(git rev-parse "HEAD")"
> +                       find "$tmp_dir" -type f -name '*.error' -exec cat=
 {} +
> +               } > "$abi_error_log"
> +               eprintf "Failure summary saved to %s\n" "$abi_error_log"
> +               exit "$FAIL_ABI"
> +       fi
> +}
> +
> +main() {
> +       MAX_THREADS=3D$(nproc)
> +       VERBOSE=3D"false"
> +       local base_ref=3D""
> +       local check_all=3D"true"
> +       local quiet=3D"false"
> +       while getopts "hb:p:mj:l:qv" opt; do
> +               case $opt in
> +               h)
> +                       print_usage
> +                       exit "$SUCCESS"
> +                       ;;
> +               b)
> +                       base_ref=3D"$OPTARG"
> +                       ;;
> +               p)
> +                       past_ref=3D"$OPTARG"
> +                       ;;
> +               m)
> +                       check_all=3D"false"
> +                       ;;
> +               j)
> +                       MAX_THREADS=3D"$OPTARG"
> +                       ;;
> +               l)
> +                       abi_error_log=3D"$OPTARG"
> +                       ;;
> +               q)
> +                       quiet=3D"true"
> +                       ;;
> +               v)
> +                       VERBOSE=3D"true"
> +                       ;;
> +               *)
> +                       exit "$FAIL_PREREQ"
> +               esac
> +       done
> +
> +       if [ "$quiet" =3D "true" ]; then
> +               run "$base_ref" "$check_all" "$@" > /dev/null
> +       else
> +               run "$base_ref" "$check_all" "$@"
> +       fi
> +}
> +
> +main "$@"
> --
> 2.17.1
>


--
Best Regards
Masahiro Yamada
