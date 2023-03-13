Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80EDE6B81C0
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 20:35:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbjCMTft (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 15:35:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbjCMTfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 15:35:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C144F746FC;
        Mon, 13 Mar 2023 12:35:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5B59F6149D;
        Mon, 13 Mar 2023 19:35:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57CCAC433EF;
        Mon, 13 Mar 2023 19:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678736144;
        bh=pb3jqIowhbh7iEOOz6VvRnBRFRPGyvH7UTXrxnizsak=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=piMJkaptslG6cNRNg1uhcgBYPi1ZhcJoBzh/OpYd29e4SekP6qIu1/hhwrFUP/rKy
         8S+dj0o5E7P9kgUFG2WtdN/phvZr/c/IV0JS1LZt1+bCSMYUIDWTECz3M9fGNiSWsy
         4YyDkE4unpn6m7bMJ3LOrUdi77D6XvjgW5sc1U1AQwORLU0Gfypq6MMdTP+pDKDR5v
         zl6KroNDU0PO2l+NEk5iVloIVFBkB+uq+BkuJK+kO/LxHRIne05gZUr7jgxhLpN+gm
         WMV6BQfAc2V9il2oEtDOgsfUHOK409qyfYglWT9/I4XNueHsIV1UNmJU3AAD+UJxQw
         RlM3S27uTqAAA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 0F2134049F; Mon, 13 Mar 2023 16:35:42 -0300 (-03)
Date:   Mon, 13 Mar 2023 16:35:42 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Quentin Monnet <quentin@isovalent.com>,
        Andres Freund <andres@anarazel.de>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Pavithra Gurushankar <gpavithrasha@gmail.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        Martin =?utf-8?B?TGnFoWth?= <mliska@suse.cz>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        llvm@lists.linux.dev, Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v1 12/13] tools headers: Make the difference output
 easier to read
Message-ID: <ZA97DiLTzFyFpKVE@kernel.org>
References: <20230311065753.3012826-1-irogers@google.com>
 <20230311065753.3012826-13-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230311065753.3012826-13-irogers@google.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Mar 10, 2023 at 10:57:52PM -0800, Ian Rogers escreveu:
> Add failures to an array and display it before exiting. Before:
> 
> ```
> Warning: Kernel ABI header at 'tools/include/uapi/linux/fcntl.h' differs from latest version at 'include/uapi/linux/fcntl.h'
> diff -u tools/include/uapi/linux/fcntl.h include/uapi/linux/fcntl.h
> Warning: Kernel ABI header at 'tools/include/uapi/linux/kvm.h' differs from latest version at 'include/uapi/linux/kvm.h'
> diff -u tools/include/uapi/linux/kvm.h include/uapi/linux/kvm.h
> ...
> ```
> 
> After:
> ```
> Warning: Kernel ABI header differences:
>   tools/include/uapi/linux/fcntl.h include/uapi/linux/fcntl.h
>   tools/include/uapi/linux/kvm.h include/uapi/linux/kvm.h

I use that diff line to cut and paste, check the errors, etc.

- Arnaldo

> ...
> ```
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/check-headers.sh | 229 ++++++++++++++++++++----------------
>  1 file changed, 125 insertions(+), 104 deletions(-)
> 
> diff --git a/tools/perf/check-headers.sh b/tools/perf/check-headers.sh
> index eacca9a874e2..f848b425d936 100755
> --- a/tools/perf/check-headers.sh
> +++ b/tools/perf/check-headers.sh
> @@ -1,113 +1,121 @@
> -#!/bin/sh
> +#!/bin/bash
>  # SPDX-License-Identifier: GPL-2.0
>  
> -FILES='
> -include/uapi/linux/const.h
> -include/uapi/drm/drm.h
> -include/uapi/drm/i915_drm.h
> -include/uapi/linux/fadvise.h
> -include/uapi/linux/fcntl.h
> -include/uapi/linux/fs.h
> -include/uapi/linux/fscrypt.h
> -include/uapi/linux/kcmp.h
> -include/uapi/linux/kvm.h
> -include/uapi/linux/in.h
> -include/uapi/linux/mount.h
> -include/uapi/linux/openat2.h
> -include/uapi/linux/perf_event.h
> -include/uapi/linux/prctl.h
> -include/uapi/linux/sched.h
> -include/uapi/linux/stat.h
> -include/uapi/linux/usbdevice_fs.h
> -include/uapi/linux/vhost.h
> -include/uapi/sound/asound.h
> -include/linux/bits.h
> -include/vdso/bits.h
> -include/linux/const.h
> -include/vdso/const.h
> -include/linux/hash.h
> -include/linux/list-sort.h
> -include/uapi/linux/hw_breakpoint.h
> -arch/x86/include/asm/disabled-features.h
> -arch/x86/include/asm/required-features.h
> -arch/x86/include/asm/cpufeatures.h
> -arch/x86/include/asm/inat_types.h
> -arch/x86/include/asm/emulate_prefix.h
> -arch/x86/include/asm/irq_vectors.h
> -arch/x86/include/asm/msr-index.h
> -arch/x86/include/uapi/asm/prctl.h
> -arch/x86/lib/x86-opcode-map.txt
> -arch/x86/tools/gen-insn-attr-x86.awk
> -arch/arm/include/uapi/asm/perf_regs.h
> -arch/arm64/include/uapi/asm/perf_regs.h
> -arch/mips/include/uapi/asm/perf_regs.h
> -arch/powerpc/include/uapi/asm/perf_regs.h
> -arch/s390/include/uapi/asm/perf_regs.h
> -arch/x86/include/uapi/asm/perf_regs.h
> -arch/x86/include/uapi/asm/kvm.h
> -arch/x86/include/uapi/asm/kvm_perf.h
> -arch/x86/include/uapi/asm/svm.h
> -arch/x86/include/uapi/asm/unistd.h
> -arch/x86/include/uapi/asm/vmx.h
> -arch/powerpc/include/uapi/asm/kvm.h
> -arch/s390/include/uapi/asm/kvm.h
> -arch/s390/include/uapi/asm/kvm_perf.h
> -arch/s390/include/uapi/asm/ptrace.h
> -arch/s390/include/uapi/asm/sie.h
> -arch/arm/include/uapi/asm/kvm.h
> -arch/arm64/include/uapi/asm/kvm.h
> -arch/arm64/include/uapi/asm/unistd.h
> -arch/alpha/include/uapi/asm/errno.h
> -arch/mips/include/asm/errno.h
> -arch/mips/include/uapi/asm/errno.h
> -arch/parisc/include/uapi/asm/errno.h
> -arch/powerpc/include/uapi/asm/errno.h
> -arch/sparc/include/uapi/asm/errno.h
> -arch/x86/include/uapi/asm/errno.h
> -include/asm-generic/bitops/arch_hweight.h
> -include/asm-generic/bitops/const_hweight.h
> -include/asm-generic/bitops/__fls.h
> -include/asm-generic/bitops/fls.h
> -include/asm-generic/bitops/fls64.h
> -include/linux/coresight-pmu.h
> -include/uapi/asm-generic/errno.h
> -include/uapi/asm-generic/errno-base.h
> -include/uapi/asm-generic/ioctls.h
> -include/uapi/asm-generic/mman-common.h
> -include/uapi/asm-generic/unistd.h
> -'
> -
> -SYNC_CHECK_FILES='
> -arch/x86/include/asm/inat.h
> -arch/x86/include/asm/insn.h
> -arch/x86/lib/inat.c
> -arch/x86/lib/insn.c
> -'
> +YELLOW='\033[0;33m'
> +NC='\033[0m' # No Color
> +
> +declare -a FILES
> +FILES=(
> +  "include/uapi/linux/const.h"
> +  "include/uapi/drm/drm.h"
> +  "include/uapi/drm/i915_drm.h"
> +  "include/uapi/linux/fadvise.h"
> +  "include/uapi/linux/fcntl.h"
> +  "include/uapi/linux/fs.h"
> +  "include/uapi/linux/fscrypt.h"
> +  "include/uapi/linux/kcmp.h"
> +  "include/uapi/linux/kvm.h"
> +  "include/uapi/linux/in.h"
> +  "include/uapi/linux/mount.h"
> +  "include/uapi/linux/openat2.h"
> +  "include/uapi/linux/perf_event.h"
> +  "include/uapi/linux/prctl.h"
> +  "include/uapi/linux/sched.h"
> +  "include/uapi/linux/stat.h"
> +  "include/uapi/linux/usbdevice_fs.h"
> +  "include/uapi/linux/vhost.h"
> +  "include/uapi/sound/asound.h"
> +  "include/linux/bits.h"
> +  "include/vdso/bits.h"
> +  "include/linux/const.h"
> +  "include/vdso/const.h"
> +  "include/linux/hash.h"
> +  "include/linux/list-sort.h"
> +  "include/uapi/linux/hw_breakpoint.h"
> +  "arch/x86/include/asm/disabled-features.h"
> +  "arch/x86/include/asm/required-features.h"
> +  "arch/x86/include/asm/cpufeatures.h"
> +  "arch/x86/include/asm/inat_types.h"
> +  "arch/x86/include/asm/emulate_prefix.h"
> +  "arch/x86/include/asm/irq_vectors.h"
> +  "arch/x86/include/asm/msr-index.h"
> +  "arch/x86/include/uapi/asm/prctl.h"
> +  "arch/x86/lib/x86-opcode-map.txt"
> +  "arch/x86/tools/gen-insn-attr-x86.awk"
> +  "arch/arm/include/uapi/asm/perf_regs.h"
> +  "arch/arm64/include/uapi/asm/perf_regs.h"
> +  "arch/mips/include/uapi/asm/perf_regs.h"
> +  "arch/powerpc/include/uapi/asm/perf_regs.h"
> +  "arch/s390/include/uapi/asm/perf_regs.h"
> +  "arch/x86/include/uapi/asm/perf_regs.h"
> +  "arch/x86/include/uapi/asm/kvm.h"
> +  "arch/x86/include/uapi/asm/kvm_perf.h"
> +  "arch/x86/include/uapi/asm/svm.h"
> +  "arch/x86/include/uapi/asm/unistd.h"
> +  "arch/x86/include/uapi/asm/vmx.h"
> +  "arch/powerpc/include/uapi/asm/kvm.h"
> +  "arch/s390/include/uapi/asm/kvm.h"
> +  "arch/s390/include/uapi/asm/kvm_perf.h"
> +  "arch/s390/include/uapi/asm/ptrace.h"
> +  "arch/s390/include/uapi/asm/sie.h"
> +  "arch/arm/include/uapi/asm/kvm.h"
> +  "arch/arm64/include/uapi/asm/kvm.h"
> +  "arch/arm64/include/uapi/asm/unistd.h"
> +  "arch/alpha/include/uapi/asm/errno.h"
> +  "arch/mips/include/asm/errno.h"
> +  "arch/mips/include/uapi/asm/errno.h"
> +  "arch/parisc/include/uapi/asm/errno.h"
> +  "arch/powerpc/include/uapi/asm/errno.h"
> +  "arch/sparc/include/uapi/asm/errno.h"
> +  "arch/x86/include/uapi/asm/errno.h"
> +  "include/asm-generic/bitops/arch_hweight.h"
> +  "include/asm-generic/bitops/const_hweight.h"
> +  "include/asm-generic/bitops/__fls.h"
> +  "include/asm-generic/bitops/fls.h"
> +  "include/asm-generic/bitops/fls64.h"
> +  "include/linux/coresight-pmu.h"
> +  "include/uapi/asm-generic/errno.h"
> +  "include/uapi/asm-generic/errno-base.h"
> +  "include/uapi/asm-generic/ioctls.h"
> +  "include/uapi/asm-generic/mman-common.h"
> +  "include/uapi/asm-generic/unistd.h"
> +)
> +
> +declare -a SYNC_CHECK_FILES
> +SYNC_CHECK_FILES=(
> +  "arch/x86/include/asm/inat.h"
> +  "arch/x86/include/asm/insn.h"
> +  "arch/x86/lib/inat.c"
> +  "arch/x86/lib/insn.c"
> +)
>  
>  # These copies are under tools/perf/trace/beauty/ as they are not used to in
>  # building object files only by scripts in tools/perf/trace/beauty/ to generate
>  # tables that then gets included in .c files for things like id->string syscall
>  # tables (and the reverse lookup as well: string -> id)
>  
> -BEAUTY_FILES='
> -include/linux/socket.h
> -'
> +declare -a BEAUTY_FILES
> +BEAUTY_FILES=(
> +  "include/linux/socket.h"
> +)
> +
> +declare -a FAILURES
>  
>  check_2 () {
> -  file1=$1
> -  file2=$2
> +  tools_file=$1
> +  orig_file=$2
>  
>    shift
>    shift
>  
> -  cmd="diff $* $file1 $file2 > /dev/null"
> +  cmd="diff $* $tools_file $orig_file > /dev/null"
>  
> -  test -f $file2 && {
> -    eval $cmd || {
> -      echo "Warning: Kernel ABI header at '$file1' differs from latest version at '$file2'" >&2
> -      echo diff -u $file1 $file2
> -    }
> -  }
> +  if [ -f "$orig_file" ] && ! eval "$cmd"
> +  then
> +    FAILURES+=(
> +      "$tools_file $orig_file"
> +    )
> +  fi
>  }
>  
>  check () {
> @@ -115,7 +123,7 @@ check () {
>  
>    shift
>  
> -  check_2 tools/$file $file $*
> +  check_2 "tools/$file" "$file" $*
>  }
>  
>  beauty_check () {
> @@ -123,23 +131,29 @@ beauty_check () {
>  
>    shift
>  
> -  check_2 tools/perf/trace/beauty/$file $file $*
> +  check_2 "tools/perf/trace/beauty/$file" "$file" $*
>  }
>  
>  # Check if we have the kernel headers (tools/perf/../../include), else
>  # we're probably on a detached tarball, so no point in trying to check
>  # differences.
> -test -d ../../include || exit 0
> +if ! [ -d ../../include ]
> +then
> +  echo -e "${YELLOW}Warning${NC}: Skipped check-headers due to missing ../../include"
> +  exit 0
> +fi
>  
>  cd ../..
>  
>  # simple diff check
> -for i in $FILES; do
> -  check $i -B
> +for i in "${FILES[@]}"
> +do
> +  check "$i" -B
>  done
>  
> -for i in $SYNC_CHECK_FILES; do
> -  check $i '-I "^.*\/\*.*__ignore_sync_check__.*\*\/.*$"'
> +for i in "${SYNC_CHECK_FILES[@]}"
> +do
> +  check "$i" '-I "^.*\/\*.*__ignore_sync_check__.*\*\/.*$"'
>  done
>  
>  # diff with extra ignore lines
> @@ -160,8 +174,9 @@ check_2 tools/perf/arch/powerpc/entry/syscalls/syscall.tbl arch/powerpc/kernel/s
>  check_2 tools/perf/arch/s390/entry/syscalls/syscall.tbl arch/s390/kernel/syscalls/syscall.tbl
>  check_2 tools/perf/arch/mips/entry/syscalls/syscall_n64.tbl arch/mips/kernel/syscalls/syscall_n64.tbl
>  
> -for i in $BEAUTY_FILES; do
> -  beauty_check $i -B
> +for i in "${BEAUTY_FILES[@]}"
> +do
> +  beauty_check "$i" -B
>  done
>  
>  # check duplicated library files
> @@ -169,3 +184,9 @@ check_2 tools/perf/util/hashmap.h tools/lib/bpf/hashmap.h
>  check_2 tools/perf/util/hashmap.c tools/lib/bpf/hashmap.c
>  
>  cd tools/perf
> +
> +echo -e "${YELLOW}Warning${NC}: Kernel ABI header differences:"
> +for i in "${FAILURES[@]}"
> +do
> +  echo "  $i"
> +done
> -- 
> 2.40.0.rc1.284.g88254d51c5-goog
> 

-- 

- Arnaldo
