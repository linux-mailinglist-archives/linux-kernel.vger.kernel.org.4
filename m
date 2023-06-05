Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BE6A722F6F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 21:14:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235188AbjFETN7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 15:13:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235112AbjFETN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 15:13:56 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84617F2
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 12:13:53 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-ba8337a5861so11482369276.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jun 2023 12:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685992433; x=1688584433;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=C53eUO19S7JsdLagJJh4TshALuTBea05MBSTwq1dxu8=;
        b=A6hcQaIdLcwkH1jMu5VfqAL6vokLi6HCvikNwvJsycwIr0A8tdKv80INs1Ot2mK8Ts
         tRAxcukpG7BEwVsGan8Ci+8u8ifhiwIpL7od1+INMH/RO1U2LgP7Uw1XrDZT9LDmz2dN
         tRfLTAorhYW8NbCsxP0Zz2k4mJPpUSt8Pa9utiL6nDVaapWAii4S0uaac9UI7/vy/Snh
         YBB/DYFVHAzCDfPes3JMy3qqZpt1aHJQd6UrIqkdk2KYAwypErUFCRJl1Ljc8Y5M3Eo9
         EIj767grfV72uMNFgta01H8/fxSo36CjEnpObn40T/nv89z9pNXKfIMr4cnNjuOxX4bq
         uhdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685992433; x=1688584433;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C53eUO19S7JsdLagJJh4TshALuTBea05MBSTwq1dxu8=;
        b=XpwUX/Cz4NC7c3HG3xm2slTgbbANV3ZkLgT5kX7cWqOHEEhIKDZxX+GeaPXHVAyniu
         mPiQin65o91xigY5OGxs0aESQDzcw3ZKcubjsx/crrmOtkhIK/HYsI75eMJ2LYbcvI54
         rBlKPDFGbdOiknWLftrNYEqnHgIgSH/JGMDDEOlse2SQqvwwT2Il0wluQSZpJwkB/NE9
         CbsJ/0TG/IYJ95k+JaR4h4Nu80yuvT3efZZ9AlgvEdgnLnZ9nUTPgRrOaw4eAgKYTz/c
         S0aZX2kGuegsOiwvsHaRYvN5VNb8x5wpsOGtd1MVzeuoU0w7ajgPK1kHndCxwKCeuBc2
         LbOw==
X-Gm-Message-State: AC+VfDycIDWiTSnxkYsB9P9Uo1imJvTSm1CXTRhbl0kXXN7lE4TkRUzh
        0pSFrPKnQqumikyohbJmosN8OPXVE2az
X-Google-Smtp-Source: ACHHUZ7z/aA5G9qDKq6Nr3/X1tiThosU1Efjf+EQaCY27rKWt7yxOYtvrmok4i7MvKGSjJIkf/NyjkMEpI+t
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:bed9:39b9:3df1:2828])
 (user=irogers job=sendgmr) by 2002:a05:6902:724:b0:bab:e88b:1d8b with SMTP id
 l4-20020a056902072400b00babe88b1d8bmr8913754ybt.6.1685992432695; Mon, 05 Jun
 2023 12:13:52 -0700 (PDT)
Date:   Mon,  5 Jun 2023 12:13:46 -0700
Message-Id: <20230605191346.1600336-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Subject: [PATCH v2] tools headers: Make the difference output easier to read
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add failures to an array and display it before exiting.

Before:
```
Warning: Kernel ABI header at 'tools/include/uapi/linux/perf_event.h' differs from latest version at 'include/uapi/linux/perf_event.h'
diff -u tools/include/uapi/linux/perf_event.h include/uapi/linux/perf_event.h
Warning: Kernel ABI header at 'tools/arch/arm64/include/uapi/asm/perf_regs.h' differs from latest version at 'arch/arm64/include/uapi/asm/perf_regs.h'
diff -u tools/arch/arm64/include/uapi/asm/perf_regs.h arch/arm64/include/uapi/asm/perf_regs.h
Warning: Kernel ABI header at 'tools/arch/arm64/include/asm/cputype.h' differs from latest version at 'arch/arm64/include/asm/cputype.h'
diff -u tools/arch/arm64/include/asm/cputype.h arch/arm64/include/asm/cputype.h
...
```

After:
```
Warning: Kernel ABI header differences:
  diff -u tools/include/uapi/linux/perf_event.h include/uapi/linux/perf_event.h
  diff -u tools/arch/arm64/include/uapi/asm/perf_regs.h arch/arm64/include/uapi/asm/perf_regs.h
  diff -u tools/arch/arm64/include/asm/cputype.h arch/arm64/include/asm/cputype.h
...
```

The aim is to make the warnings easier to read and distinguish from
other Makefile warnings messages.

Signed-off-by: Ian Rogers <irogers@google.com>

v2. Is a rebase, avoids the warning message if there are no diffs,
    adds diff to the output for easier copy and paste.
---
 tools/perf/check-headers.sh | 233 ++++++++++++++++++++----------------
 1 file changed, 129 insertions(+), 104 deletions(-)

diff --git a/tools/perf/check-headers.sh b/tools/perf/check-headers.sh
index 6f831ee2f60f..bcad6a7d8e5d 100755
--- a/tools/perf/check-headers.sh
+++ b/tools/perf/check-headers.sh
@@ -1,113 +1,122 @@
-#!/bin/sh
+#!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
 
-FILES='
-include/uapi/linux/const.h
-include/uapi/drm/drm.h
-include/uapi/drm/i915_drm.h
-include/uapi/linux/fadvise.h
-include/uapi/linux/fcntl.h
-include/uapi/linux/fs.h
-include/uapi/linux/fscrypt.h
-include/uapi/linux/kcmp.h
-include/uapi/linux/kvm.h
-include/uapi/linux/in.h
-include/uapi/linux/mount.h
-include/uapi/linux/openat2.h
-include/uapi/linux/perf_event.h
-include/uapi/linux/prctl.h
-include/uapi/linux/sched.h
-include/uapi/linux/stat.h
-include/uapi/linux/usbdevice_fs.h
-include/uapi/linux/vhost.h
-include/uapi/sound/asound.h
-include/linux/bits.h
-include/vdso/bits.h
-include/linux/const.h
-include/vdso/const.h
-include/linux/hash.h
-include/linux/list-sort.h
-include/uapi/linux/hw_breakpoint.h
-arch/x86/include/asm/disabled-features.h
-arch/x86/include/asm/required-features.h
-arch/x86/include/asm/cpufeatures.h
-arch/x86/include/asm/inat_types.h
-arch/x86/include/asm/emulate_prefix.h
-arch/x86/include/asm/irq_vectors.h
-arch/x86/include/asm/msr-index.h
-arch/x86/include/uapi/asm/prctl.h
-arch/x86/lib/x86-opcode-map.txt
-arch/x86/tools/gen-insn-attr-x86.awk
-arch/arm/include/uapi/asm/perf_regs.h
-arch/arm64/include/uapi/asm/perf_regs.h
-arch/loongarch/include/uapi/asm/perf_regs.h
-arch/mips/include/uapi/asm/perf_regs.h
-arch/powerpc/include/uapi/asm/perf_regs.h
-arch/s390/include/uapi/asm/perf_regs.h
-arch/x86/include/uapi/asm/perf_regs.h
-arch/x86/include/uapi/asm/kvm.h
-arch/x86/include/uapi/asm/kvm_perf.h
-arch/x86/include/uapi/asm/svm.h
-arch/x86/include/uapi/asm/unistd.h
-arch/x86/include/uapi/asm/vmx.h
-arch/powerpc/include/uapi/asm/kvm.h
-arch/s390/include/uapi/asm/kvm.h
-arch/s390/include/uapi/asm/kvm_perf.h
-arch/s390/include/uapi/asm/sie.h
-arch/arm/include/uapi/asm/kvm.h
-arch/arm64/include/uapi/asm/kvm.h
-arch/arm64/include/uapi/asm/unistd.h
-arch/alpha/include/uapi/asm/errno.h
-arch/mips/include/asm/errno.h
-arch/mips/include/uapi/asm/errno.h
-arch/parisc/include/uapi/asm/errno.h
-arch/powerpc/include/uapi/asm/errno.h
-arch/sparc/include/uapi/asm/errno.h
-arch/x86/include/uapi/asm/errno.h
-include/asm-generic/bitops/arch_hweight.h
-include/asm-generic/bitops/const_hweight.h
-include/asm-generic/bitops/__fls.h
-include/asm-generic/bitops/fls.h
-include/asm-generic/bitops/fls64.h
-include/linux/coresight-pmu.h
-include/uapi/asm-generic/errno.h
-include/uapi/asm-generic/errno-base.h
-include/uapi/asm-generic/ioctls.h
-include/uapi/asm-generic/mman-common.h
-include/uapi/asm-generic/unistd.h
-'
-
-SYNC_CHECK_FILES='
-arch/x86/include/asm/inat.h
-arch/x86/include/asm/insn.h
-arch/x86/lib/inat.c
-arch/x86/lib/insn.c
-'
+YELLOW='\033[0;33m'
+NC='\033[0m' # No Color
+
+declare -a FILES
+FILES=(
+  "include/uapi/linux/const.h"
+  "include/uapi/drm/drm.h"
+  "include/uapi/drm/i915_drm.h"
+  "include/uapi/linux/fadvise.h"
+  "include/uapi/linux/fcntl.h"
+  "include/uapi/linux/fs.h"
+  "include/uapi/linux/fscrypt.h"
+  "include/uapi/linux/kcmp.h"
+  "include/uapi/linux/kvm.h"
+  "include/uapi/linux/in.h"
+  "include/uapi/linux/mount.h"
+  "include/uapi/linux/openat2.h"
+  "include/uapi/linux/perf_event.h"
+  "include/uapi/linux/prctl.h"
+  "include/uapi/linux/sched.h"
+  "include/uapi/linux/stat.h"
+  "include/uapi/linux/usbdevice_fs.h"
+  "include/uapi/linux/vhost.h"
+  "include/uapi/sound/asound.h"
+  "include/linux/bits.h"
+  "include/vdso/bits.h"
+  "include/linux/const.h"
+  "include/vdso/const.h"
+  "include/linux/hash.h"
+  "include/linux/list-sort.h"
+  "include/uapi/linux/hw_breakpoint.h"
+  "arch/x86/include/asm/disabled-features.h"
+  "arch/x86/include/asm/required-features.h"
+  "arch/x86/include/asm/cpufeatures.h"
+  "arch/x86/include/asm/inat_types.h"
+  "arch/x86/include/asm/emulate_prefix.h"
+  "arch/x86/include/asm/irq_vectors.h"
+  "arch/x86/include/asm/msr-index.h"
+  "arch/x86/include/uapi/asm/prctl.h"
+  "arch/x86/lib/x86-opcode-map.txt"
+  "arch/x86/tools/gen-insn-attr-x86.awk"
+  "arch/arm/include/uapi/asm/perf_regs.h"
+  "arch/arm64/include/uapi/asm/perf_regs.h"
+  "arch/loongarch/include/uapi/asm/perf_regs.h"
+  "arch/mips/include/uapi/asm/perf_regs.h"
+  "arch/powerpc/include/uapi/asm/perf_regs.h"
+  "arch/s390/include/uapi/asm/perf_regs.h"
+  "arch/x86/include/uapi/asm/perf_regs.h"
+  "arch/x86/include/uapi/asm/kvm.h"
+  "arch/x86/include/uapi/asm/kvm_perf.h"
+  "arch/x86/include/uapi/asm/svm.h"
+  "arch/x86/include/uapi/asm/unistd.h"
+  "arch/x86/include/uapi/asm/vmx.h"
+  "arch/powerpc/include/uapi/asm/kvm.h"
+  "arch/s390/include/uapi/asm/kvm.h"
+  "arch/s390/include/uapi/asm/kvm_perf.h"
+  "arch/s390/include/uapi/asm/sie.h"
+  "arch/arm/include/uapi/asm/kvm.h"
+  "arch/arm64/include/uapi/asm/kvm.h"
+  "arch/arm64/include/uapi/asm/unistd.h"
+  "arch/alpha/include/uapi/asm/errno.h"
+  "arch/mips/include/asm/errno.h"
+  "arch/mips/include/uapi/asm/errno.h"
+  "arch/parisc/include/uapi/asm/errno.h"
+  "arch/powerpc/include/uapi/asm/errno.h"
+  "arch/sparc/include/uapi/asm/errno.h"
+  "arch/x86/include/uapi/asm/errno.h"
+  "include/asm-generic/bitops/arch_hweight.h"
+  "include/asm-generic/bitops/const_hweight.h"
+  "include/asm-generic/bitops/__fls.h"
+  "include/asm-generic/bitops/fls.h"
+  "include/asm-generic/bitops/fls64.h"
+  "include/linux/coresight-pmu.h"
+  "include/uapi/asm-generic/errno.h"
+  "include/uapi/asm-generic/errno-base.h"
+  "include/uapi/asm-generic/ioctls.h"
+  "include/uapi/asm-generic/mman-common.h"
+  "include/uapi/asm-generic/unistd.h"
+)
+
+declare -a SYNC_CHECK_FILES
+SYNC_CHECK_FILES=(
+  "arch/x86/include/asm/inat.h"
+  "arch/x86/include/asm/insn.h"
+  "arch/x86/lib/inat.c"
+  "arch/x86/lib/insn.c"
+)
 
 # These copies are under tools/perf/trace/beauty/ as they are not used to in
 # building object files only by scripts in tools/perf/trace/beauty/ to generate
 # tables that then gets included in .c files for things like id->string syscall
 # tables (and the reverse lookup as well: string -> id)
 
-BEAUTY_FILES='
-include/linux/socket.h
-'
+declare -a BEAUTY_FILES
+BEAUTY_FILES=(
+  "include/linux/socket.h"
+)
+
+declare -a FAILURES
 
 check_2 () {
-  file1=$1
-  file2=$2
+  tools_file=$1
+  orig_file=$2
 
   shift
   shift
 
-  cmd="diff $* $file1 $file2 > /dev/null"
+  cmd="diff $* $tools_file $orig_file > /dev/null"
 
-  test -f $file2 && {
-    eval $cmd || {
-      echo "Warning: Kernel ABI header at '$file1' differs from latest version at '$file2'" >&2
-      echo diff -u $file1 $file2
-    }
-  }
+  if [ -f "$orig_file" ] && ! eval "$cmd"
+  then
+    echo "$tools_file $orig_file"
+    FAILURES+=(
+      "$tools_file $orig_file"
+    )
+  fi
 }
 
 check () {
@@ -115,7 +124,7 @@ check () {
 
   shift
 
-  check_2 tools/$file $file $*
+  check_2 "tools/$file" "$file" $*
 }
 
 beauty_check () {
@@ -123,23 +132,29 @@ beauty_check () {
 
   shift
 
-  check_2 tools/perf/trace/beauty/$file $file $*
+  check_2 "tools/perf/trace/beauty/$file" "$file" $*
 }
 
 # Check if we have the kernel headers (tools/perf/../../include), else
 # we're probably on a detached tarball, so no point in trying to check
 # differences.
-test -d ../../include || exit 0
+if ! [ -d ../../include ]
+then
+  echo -e "${YELLOW}Warning${NC}: Skipped check-headers due to missing ../../include"
+  exit 0
+fi
 
 cd ../..
 
 # simple diff check
-for i in $FILES; do
-  check $i -B
+for i in "${FILES[@]}"
+do
+  check "$i" -B
 done
 
-for i in $SYNC_CHECK_FILES; do
-  check $i '-I "^.*\/\*.*__ignore_sync_check__.*\*\/.*$"'
+for i in "${SYNC_CHECK_FILES[@]}"
+do
+  check "$i" '-I "^.*\/\*.*__ignore_sync_check__.*\*\/.*$"'
 done
 
 # diff with extra ignore lines
@@ -160,8 +175,9 @@ check_2 tools/perf/arch/powerpc/entry/syscalls/syscall.tbl arch/powerpc/kernel/s
 check_2 tools/perf/arch/s390/entry/syscalls/syscall.tbl arch/s390/kernel/syscalls/syscall.tbl
 check_2 tools/perf/arch/mips/entry/syscalls/syscall_n64.tbl arch/mips/kernel/syscalls/syscall_n64.tbl
 
-for i in $BEAUTY_FILES; do
-  beauty_check $i -B
+for i in "${BEAUTY_FILES[@]}"
+do
+  beauty_check "$i" -B
 done
 
 # check duplicated library files
@@ -169,3 +185,12 @@ check_2 tools/perf/util/hashmap.h tools/lib/bpf/hashmap.h
 check_2 tools/perf/util/hashmap.c tools/lib/bpf/hashmap.c
 
 cd tools/perf
+
+if [ ${#FAILURES[@]} -gt 0 ]
+then
+  echo -e "${YELLOW}Warning${NC}: Kernel ABI header differences:"
+  for i in "${FAILURES[@]}"
+  do
+    echo "  diff -u $i"
+  done
+fi
-- 
2.41.0.rc0.172.g3f132b7071-goog

