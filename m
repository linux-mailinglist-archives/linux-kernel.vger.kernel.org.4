Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76476724AC1
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 20:02:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238857AbjFFSCa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 14:02:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233537AbjFFSC2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 14:02:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FBFE1701;
        Tue,  6 Jun 2023 11:02:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3181D6341A;
        Tue,  6 Jun 2023 18:02:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 246EFC433D2;
        Tue,  6 Jun 2023 18:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686074542;
        bh=onHAjZyWsUriZATz1Aw7WNVIJCmUV4G891lcniYLph0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=affmfcdYmsYpko+guTUTe99U0EfNCQCfqgVoqgIh6wcpX2B0dQYeIXeOAfBV4PZbs
         x0OcFV8Wlf5HQxkTyywYf1jRl3mqd1ITZ0oyUjQx8wTHebcAMbzxdCj55TdZYK8ZyK
         URyuKNUpyi76dhdMTUZszb+FHqkrqgp3tA9WHQ8rwtk8qn/LgGSJPfxYI2K3FgtnuS
         LfZu6o0FGrYtacPOTe/m+XGHk81dm2jaRHmbgN3pN/hfUbD9y6PdcSmh2h5cz0Z28T
         kxQHfdaknyAITaH/sMuK/vYITQriINr2eNhppArWCfZKvRYlA9Y5A+utmBH8YaIDqD
         hIJIzQHVnZYFA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 9EA0540692; Tue,  6 Jun 2023 15:02:19 -0300 (-03)
Date:   Tue, 6 Jun 2023 15:02:19 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] tools headers: Make the difference output easier to
 read
Message-ID: <ZH90q0wI1C1bJvcq@kernel.org>
References: <20230605203425.1696844-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230605203425.1696844-1-irogers@google.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Jun 05, 2023 at 01:34:25PM -0700, Ian Rogers escreveu:
> Add failures to an array and display it before exiting.
> 
> Before:
> ```
> Warning: Kernel ABI header at 'tools/include/uapi/linux/perf_event.h' differs from latest version at 'include/uapi/linux/perf_event.h'
> diff -u tools/include/uapi/linux/perf_event.h include/uapi/linux/perf_event.h
> Warning: Kernel ABI header at 'tools/arch/arm64/include/uapi/asm/perf_regs.h' differs from latest version at 'arch/arm64/include/uapi/asm/perf_regs.h'
> diff -u tools/arch/arm64/include/uapi/asm/perf_regs.h arch/arm64/include/uapi/asm/perf_regs.h
> Warning: Kernel ABI header at 'tools/arch/arm64/include/asm/cputype.h' differs from latest version at 'arch/arm64/include/asm/cputype.h'
> diff -u tools/arch/arm64/include/asm/cputype.h arch/arm64/include/asm/cputype.h
> ...
> ```
> 
> After:
> ```
> Warning: Kernel ABI header differences:
>   diff -u tools/include/uapi/linux/perf_event.h include/uapi/linux/perf_event.h
>   diff -u tools/arch/arm64/include/uapi/asm/perf_regs.h arch/arm64/include/uapi/asm/perf_regs.h
>   diff -u tools/arch/arm64/include/asm/cputype.h arch/arm64/include/asm/cputype.h
> ...
> ```
> 
> The aim is to make the warnings easier to read and distinguish from
> other Makefile warnings messages.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>

Thanks, applied.

- Arnaldo

 
> v2. Is a rebase, avoids the warning message if there are no diffs,
>     adds diff to the output for easier copy and paste.
> v3. Remove an inadvertently added debug statement.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/check-headers.sh | 232 ++++++++++++++++++++----------------
>  1 file changed, 128 insertions(+), 104 deletions(-)
> 
> diff --git a/tools/perf/check-headers.sh b/tools/perf/check-headers.sh
> index 6f831ee2f60f..a0f1d8adce60 100755
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
> -arch/loongarch/include/uapi/asm/perf_regs.h
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
> +  "arch/loongarch/include/uapi/asm/perf_regs.h"
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
> @@ -169,3 +184,12 @@ check_2 tools/perf/util/hashmap.h tools/lib/bpf/hashmap.h
>  check_2 tools/perf/util/hashmap.c tools/lib/bpf/hashmap.c
>  
>  cd tools/perf
> +
> +if [ ${#FAILURES[@]} -gt 0 ]
> +then
> +  echo -e "${YELLOW}Warning${NC}: Kernel ABI header differences:"
> +  for i in "${FAILURES[@]}"
> +  do
> +    echo "  diff -u $i"
> +  done
> +fi
> -- 
> 2.41.0.rc0.172.g3f132b7071-goog
> 

-- 

- Arnaldo
