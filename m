Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3275A718695
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 17:43:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234548AbjEaPnt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 11:43:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234496AbjEaPnq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 11:43:46 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 688BB12B
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 08:43:43 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-bacd408046cso11258867276.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 08:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685547822; x=1688139822;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=c6RoWGuqgh/i5AKV1X/lcbJgymB9kqZtmVb19l1xUr4=;
        b=5WhY/yX9GXWHddU8K4oE0HL+/e/97f/PZHG0GzFQaGPlzOoCTia2+C9OJep1OZbaVP
         V0ZY5KCCh0Hc0QWvTyLQOrUT7nOGhgbOk1sk6wHTXxud5BnRu+nexLJPe9o1CVvNvx8Q
         VihMfp0IKQD0SJZL0RLUHD4KpyhgNiJo3hLKzk2q9u4PDPiEcjnljNqsuAqsNB/ZQXDP
         fPpRMQMVl3eAqcXVIlAVwnWOKkvU8Q/bNriu7NJnpe5BsP6F2T/B4BX0rmp1OPw9qZU2
         ALIvuiga9IlgI7Rd8b+0a6gpOIvG28TfIPFY8bSISuD0pW2QhR3R4GT/mA32dAa0mJpd
         EHBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685547822; x=1688139822;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c6RoWGuqgh/i5AKV1X/lcbJgymB9kqZtmVb19l1xUr4=;
        b=RJ4uku09nHg0OBjCdbyA3K1KrVyHMAZd703u4h4cI0iu8rRjYQqu+35GNPzPi2gmdx
         MbKWCw6rxir471UMxyOxXy8xC12bu4bVZzH1RflAc+pNzx86vzW4nJyk417UPrxt58AA
         i2RstHsAUQAatRt5BTXNv645T03l+KWKb5qEsrFYYZAM41VXq5pEEAyz5DLj/NH5DEvI
         Nw4sCHMcv5sib3CjrphZaoG+QT8K3US72omn31ci/h5LKGE/uNX6i2KLYvd378RF2JvG
         O7KClRorCavxMDxdZFB3Ux6yJWcQ3gnaMN0vBSL1Dly3AT9Rt5g/Atmux87L4GXjLcgN
         bzKg==
X-Gm-Message-State: AC+VfDyXIFk5uTOmVvRVONCjDywINtUSXZ1nOxhwP/A8O2IzbPfm0Su8
        h5W8YPNEvbTOUPKdJKEYgLG5hbvB20sW
X-Google-Smtp-Source: ACHHUZ6bVN7OzA53dyf1soSO9CWxkWgI+a1PQ4ejPgj4NI2XtkvBYtz4nQNNMRkXJhTxIGCeAdZMdGjpk/zh
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:da6e:5e97:22c7:d7b5])
 (user=irogers job=sendgmr) by 2002:a05:6902:a8e:b0:b1d:5061:98e3 with SMTP id
 cd14-20020a0569020a8e00b00b1d506198e3mr3529212ybb.6.1685547822672; Wed, 31
 May 2023 08:43:42 -0700 (PDT)
Date:   Wed, 31 May 2023 08:43:32 -0700
Message-Id: <20230531154333.364167-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Subject: [PATCH v1 1/2] perf tests x86: Generate entire instruction struct in
 C files
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
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Generate the entire struct in the C files. Later changes will break
apart the struct and so two phases of output are necessary, this isn't
possible if part of the struct is declared in insn-x86.c.

The instructions rdpkru and wrpkru are already part of the source data
and so the duplicate values are removed from the structs in
insn-x86.c. erets and eretu won't assemble, so special case them for
x86-64.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../perf/arch/x86/tests/gen-insn-x86-dat.awk  |   6 +-
 tools/perf/arch/x86/tests/gen-insn-x86-dat.sh |   4 +-
 tools/perf/arch/x86/tests/insn-x86-dat-32.c   |  65 +++----
 tools/perf/arch/x86/tests/insn-x86-dat-64.c   | 163 +++++++++---------
 tools/perf/arch/x86/tests/insn-x86.c          |  23 ++-
 5 files changed, 138 insertions(+), 123 deletions(-)

diff --git a/tools/perf/arch/x86/tests/gen-insn-x86-dat.awk b/tools/perf/arch/x86/tests/gen-insn-x86-dat.awk
index 1a29f6379bde..5a7de9ff77e7 100644
--- a/tools/perf/arch/x86/tests/gen-insn-x86-dat.awk
+++ b/tools/perf/arch/x86/tests/gen-insn-x86-dat.awk
@@ -5,6 +5,7 @@
 #
 
 BEGIN {
+	print "// SPDX-License-Identifier: GPL-2.0"
 	print "/*"
 	print " * Generated by gen-insn-x86-dat.sh and gen-insn-x86-dat.awk"
 	print " * from insn-x86-dat-src.c for inclusion by insn-x86.c"
@@ -18,13 +19,16 @@ BEGIN {
 
 / Start here / {
 	going = 1
+	printf "static const struct test_data %s[] = {\n", struct_name
 }
 
 / Stop here / {
 	going = 0
+	print "{{0}, 0, 0, NULL, NULL, NULL},"
+	print "};"
 }
 
-/^\s*[0-9a-fA-F]+\:/ {
+/^[[:blank:]]*[0-9a-fA-F]+:/ {
 	if (going) {
 		colon_pos = index($0, ":")
 		useful_line = substr($0, colon_pos + 1)
diff --git a/tools/perf/arch/x86/tests/gen-insn-x86-dat.sh b/tools/perf/arch/x86/tests/gen-insn-x86-dat.sh
index 0d0a003a9c5e..c087b9695cba 100755
--- a/tools/perf/arch/x86/tests/gen-insn-x86-dat.sh
+++ b/tools/perf/arch/x86/tests/gen-insn-x86-dat.sh
@@ -19,7 +19,7 @@ echo "Compiling insn-x86-dat-src.c to 64-bit object"
 
 gcc -g -c insn-x86-dat-src.c
 
-objdump -dSw insn-x86-dat-src.o | awk -f gen-insn-x86-dat.awk > insn-x86-dat-64.c
+objdump -dSw insn-x86-dat-src.o | awk -v struct_name=test_data_64 -f gen-insn-x86-dat.awk > insn-x86-dat-64.c
 
 rm -f insn-x86-dat-src.o
 
@@ -27,7 +27,7 @@ echo "Compiling insn-x86-dat-src.c to 32-bit object"
 
 gcc -g -c -m32 insn-x86-dat-src.c
 
-objdump -dSw insn-x86-dat-src.o | awk -f gen-insn-x86-dat.awk > insn-x86-dat-32.c
+objdump -dSw insn-x86-dat-src.o | awk -v struct_name=test_data_32 -f gen-insn-x86-dat.awk > insn-x86-dat-32.c
 
 rm -f insn-x86-dat-src.o
 
diff --git a/tools/perf/arch/x86/tests/insn-x86-dat-32.c b/tools/perf/arch/x86/tests/insn-x86-dat-32.c
index ba429cadb18f..a4ad5a5d1cb6 100644
--- a/tools/perf/arch/x86/tests/insn-x86-dat-32.c
+++ b/tools/perf/arch/x86/tests/insn-x86-dat-32.c
@@ -5,8 +5,9 @@
  * Do not change this code.
 */
 
+static const struct test_data test_data_32[] = {
 {{0x0f, 0x31, }, 2, 0, "", "",
-"0f 31                \trdtsc  ",},
+"0f 31                \trdtsc",},
 {{0xc4, 0xe2, 0x7d, 0x13, 0xeb, }, 5, 0, "", "",
 "c4 e2 7d 13 eb       \tvcvtph2ps %xmm3,%ymm5",},
 {{0x62, 0x81, 0x78, 0x56, 0x34, 0x12, }, 6, 0, "", "",
@@ -1686,19 +1687,19 @@
 {{0x0f, 0x1b, 0x84, 0x08, 0x78, 0x56, 0x34, 0x12, }, 8, 0, "", "",
 "0f 1b 84 08 78 56 34 12 \tbndstx %bnd0,0x12345678(%eax,%ecx,1)",},
 {{0xf2, 0xe8, 0xfc, 0xff, 0xff, 0xff, }, 6, 0xfffffffc, "call", "unconditional",
-"f2 e8 fc ff ff ff    \tbnd call fce <main+0xfce>",},
+"f2 e8 fc ff ff ff    \tbnd call 14f7 <main+0x14f7>",},
 {{0xf2, 0xff, 0x10, }, 3, 0, "call", "indirect",
 "f2 ff 10             \tbnd call *(%eax)",},
 {{0xf2, 0xc3, }, 2, 0, "ret", "indirect",
-"f2 c3                \tbnd ret ",},
+"f2 c3                \tbnd ret",},
 {{0xf2, 0xe9, 0xfc, 0xff, 0xff, 0xff, }, 6, 0xfffffffc, "jmp", "unconditional",
-"f2 e9 fc ff ff ff    \tbnd jmp fd9 <main+0xfd9>",},
+"f2 e9 fc ff ff ff    \tbnd jmp 1502 <main+0x1502>",},
 {{0xf2, 0xe9, 0xfc, 0xff, 0xff, 0xff, }, 6, 0xfffffffc, "jmp", "unconditional",
-"f2 e9 fc ff ff ff    \tbnd jmp fdf <main+0xfdf>",},
+"f2 e9 fc ff ff ff    \tbnd jmp 1508 <main+0x1508>",},
 {{0xf2, 0xff, 0x21, }, 3, 0, "jmp", "indirect",
 "f2 ff 21             \tbnd jmp *(%ecx)",},
 {{0xf2, 0x0f, 0x85, 0xfc, 0xff, 0xff, 0xff, }, 7, 0xfffffffc, "jcc", "conditional",
-"f2 0f 85 fc ff ff ff \tbnd jne fe9 <main+0xfe9>",},
+"f2 0f 85 fc ff ff ff \tbnd jne 1512 <main+0x1512>",},
 {{0x0f, 0x3a, 0xcc, 0xc1, 0x00, }, 5, 0, "", "",
 "0f 3a cc c1 00       \tsha1rnds4 $0x0,%xmm1,%xmm0",},
 {{0x0f, 0x3a, 0xcc, 0xd7, 0x91, }, 5, 0, "", "",
@@ -2002,7 +2003,7 @@
 {{0x0f, 0xae, 0x38, }, 3, 0, "", "",
 "0f ae 38             \tclflush (%eax)",},
 {{0x0f, 0xae, 0xf8, }, 3, 0, "", "",
-"0f ae f8             \tsfence ",},
+"0f ae f8             \tsfence",},
 {{0x66, 0x0f, 0xae, 0x30, }, 4, 0, "", "",
 "66 0f ae 30          \tclwb   (%eax)",},
 {{0x66, 0x0f, 0xae, 0x35, 0x78, 0x56, 0x34, 0x12, }, 8, 0, "", "",
@@ -2012,7 +2013,7 @@
 {{0x0f, 0xae, 0x30, }, 3, 0, "", "",
 "0f ae 30             \txsaveopt (%eax)",},
 {{0x0f, 0xae, 0xf0, }, 3, 0, "", "",
-"0f ae f0             \tmfence ",},
+"0f ae f0             \tmfence",},
 {{0x0f, 0x1c, 0x00, }, 3, 0, "", "",
 "0f 1c 00             \tcldemote (%eax)",},
 {{0x0f, 0x1c, 0x05, 0x78, 0x56, 0x34, 0x12, }, 7, 0, "", "",
@@ -2038,17 +2039,17 @@
 {{0x0f, 0xc7, 0x9c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 8, 0, "", "",
 "0f c7 9c c8 78 56 34 12 \txrstors 0x12345678(%eax,%ecx,8)",},
 {{0xf3, 0x0f, 0xae, 0x20, }, 4, 0, "", "",
-"f3 0f ae 20          \tptwritel (%eax)",},
+"f3 0f ae 20          \tptwrite (%eax)",},
 {{0xf3, 0x0f, 0xae, 0x25, 0x78, 0x56, 0x34, 0x12, }, 8, 0, "", "",
-"f3 0f ae 25 78 56 34 12 \tptwritel 0x12345678",},
+"f3 0f ae 25 78 56 34 12 \tptwrite 0x12345678",},
 {{0xf3, 0x0f, 0xae, 0xa4, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 9, 0, "", "",
-"f3 0f ae a4 c8 78 56 34 12 \tptwritel 0x12345678(%eax,%ecx,8)",},
+"f3 0f ae a4 c8 78 56 34 12 \tptwrite 0x12345678(%eax,%ecx,8)",},
 {{0xf3, 0x0f, 0xae, 0x20, }, 4, 0, "", "",
-"f3 0f ae 20          \tptwritel (%eax)",},
+"f3 0f ae 20          \tptwrite (%eax)",},
 {{0xf3, 0x0f, 0xae, 0x25, 0x78, 0x56, 0x34, 0x12, }, 8, 0, "", "",
-"f3 0f ae 25 78 56 34 12 \tptwritel 0x12345678",},
+"f3 0f ae 25 78 56 34 12 \tptwrite 0x12345678",},
 {{0xf3, 0x0f, 0xae, 0xa4, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 9, 0, "", "",
-"f3 0f ae a4 c8 78 56 34 12 \tptwritel 0x12345678(%eax,%ecx,8)",},
+"f3 0f ae a4 c8 78 56 34 12 \tptwrite 0x12345678(%eax,%ecx,8)",},
 {{0x66, 0x0f, 0xae, 0xf3, }, 4, 0, "", "",
 "66 0f ae f3          \ttpause %ebx",},
 {{0x67, 0xf3, 0x0f, 0xae, 0xf0, }, 5, 0, "", "",
@@ -2094,11 +2095,11 @@
 {{0x0f, 0xae, 0xac, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 8, 0, "", "",
 "0f ae ac c8 78 56 34 12 \txrstor 0x12345678(%eax,%ecx,8)",},
 {{0x0f, 0xae, 0xe8, }, 3, 0, "", "",
-"0f ae e8             \tlfence ",},
+"0f ae e8             \tlfence",},
 {{0xf3, 0x0f, 0x1e, 0xc8, }, 4, 0, "", "",
 "f3 0f 1e c8          \trdsspd %eax",},
 {{0xf3, 0x0f, 0x01, 0xea, }, 4, 0, "", "",
-"f3 0f 01 ea          \tsaveprevssp ",},
+"f3 0f 01 ea          \tsaveprevssp",},
 {{0xf3, 0x0f, 0x01, 0x28, }, 4, 0, "", "",
 "f3 0f 01 28          \trstorssp (%eax)",},
 {{0xf3, 0x0f, 0x01, 0x2d, 0x78, 0x56, 0x34, 0x12, }, 8, 0, "", "",
@@ -2118,11 +2119,11 @@
 {{0x66, 0x0f, 0x38, 0xf5, 0x94, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 10, 0, "", "",
 "66 0f 38 f5 94 c8 78 56 34 12 \twrussd %edx,0x12345678(%eax,%ecx,8)",},
 {{0xf3, 0x0f, 0x01, 0xe8, }, 4, 0, "", "",
-"f3 0f 01 e8          \tsetssbsy ",},
+"f3 0f 01 e8          \tsetssbsy",},
 {{0x0f, 0x01, 0xee, }, 3, 0, "", "",
-"0f 01 ee             \trdpkru ",},
+"0f 01 ee             \trdpkru",},
 {{0x0f, 0x01, 0xef, }, 3, 0, "", "",
-"0f 01 ef             \twrpkru ",},
+"0f 01 ef             \twrpkru",},
 {{0xf3, 0x0f, 0xae, 0x30, }, 4, 0, "", "",
 "f3 0f ae 30          \tclrssbsy (%eax)",},
 {{0xf3, 0x0f, 0xae, 0x35, 0x78, 0x56, 0x34, 0x12, }, 8, 0, "", "",
@@ -2130,9 +2131,9 @@
 {{0xf3, 0x0f, 0xae, 0xb4, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 9, 0, "", "",
 "f3 0f ae b4 c8 78 56 34 12 \tclrssbsy 0x12345678(%eax,%ecx,8)",},
 {{0xf3, 0x0f, 0x1e, 0xfb, }, 4, 0, "", "",
-"f3 0f 1e fb          \tendbr32 ",},
+"f3 0f 1e fb          \tendbr32",},
 {{0xf3, 0x0f, 0x1e, 0xfa, }, 4, 0, "", "",
-"f3 0f 1e fa          \tendbr64 ",},
+"f3 0f 1e fa          \tendbr64",},
 {{0xff, 0xd0, }, 2, 0, "call", "indirect",
 "ff d0                \tcall   *%eax",},
 {{0xff, 0x10, }, 2, 0, "call", "indirect",
@@ -3110,18 +3111,24 @@
 {{0xf3, 0x0f, 0x3a, 0xf0, 0xc0, 0x00, }, 6, 0, "", "",
 "f3 0f 3a f0 c0 00    \threset $0x0",},
 {{0x0f, 0x01, 0xe8, }, 3, 0, "", "",
-"0f 01 e8             \tserialize ",},
+"0f 01 e8             \tserialize",},
 {{0xf2, 0x0f, 0x01, 0xe9, }, 4, 0, "", "",
-"f2 0f 01 e9          \txresldtrk ",},
+"f2 0f 01 e9          \txresldtrk",},
 {{0xf2, 0x0f, 0x01, 0xe8, }, 4, 0, "", "",
-"f2 0f 01 e8          \txsusldtrk ",},
+"f2 0f 01 e8          \txsusldtrk",},
 {{0x0f, 0x01, 0xcf, }, 3, 0, "", "",
-"0f 01 cf             \tencls  ",},
+"0f 01 cf             \tencls",},
 {{0x0f, 0x01, 0xd7, }, 3, 0, "", "",
-"0f 01 d7             \tenclu  ",},
+"0f 01 d7             \tenclu",},
 {{0x0f, 0x01, 0xc0, }, 3, 0, "", "",
-"0f 01 c0             \tenclv  ",},
+"0f 01 c0             \tenclv",},
 {{0x0f, 0x01, 0xc5, }, 3, 0, "", "",
-"0f 01 c5             \tpconfig ",},
+"0f 01 c5             \tpconfig",},
 {{0xf3, 0x0f, 0x09, }, 3, 0, "", "",
-"f3 0f 09             \twbnoinvd ",},
+"f3 0f 09             \twbnoinvd",},
+{{0x0f, 0x01, 0xee, }, 3, 0, "", "",
+"0f 01 ee             \trdpkru",},
+{{0x0f, 0x01, 0xef, }, 3, 0, "", "",
+"0f 01 ef             \twrpkru",},
+{{0}, 0, 0, NULL, NULL, NULL},
+};
diff --git a/tools/perf/arch/x86/tests/insn-x86-dat-64.c b/tools/perf/arch/x86/tests/insn-x86-dat-64.c
index 3a47e98fec33..077ad34a30f2 100644
--- a/tools/perf/arch/x86/tests/insn-x86-dat-64.c
+++ b/tools/perf/arch/x86/tests/insn-x86-dat-64.c
@@ -5,8 +5,9 @@
  * Do not change this code.
 */
 
+static const struct test_data test_data_64[] = {
 {{0x0f, 0x31, }, 2, 0, "", "",
-"0f 31                \trdtsc  ",},
+"0f 31                \trdtsc",},
 {{0xc4, 0xe2, 0x7d, 0x13, 0xeb, }, 5, 0, "", "",
 "c4 e2 7d 13 eb       \tvcvtph2ps %xmm3,%ymm5",},
 {{0x48, 0x0f, 0x41, 0xd8, }, 4, 0, "", "",
@@ -1742,19 +1743,19 @@
 {{0x0f, 0x1b, 0x84, 0x08, 0x78, 0x56, 0x34, 0x12, }, 8, 0, "", "",
 "0f 1b 84 08 78 56 34 12 \tbndstx %bnd0,0x12345678(%rax,%rcx,1)",},
 {{0xf2, 0xe8, 0x00, 0x00, 0x00, 0x00, }, 6, 0, "call", "unconditional",
-"f2 e8 00 00 00 00    \tbnd callq f22 <main+0xf22>",},
+"f2 e8 00 00 00 00    \tbnd call 16b5 <main+0x16b5>",},
 {{0x67, 0xf2, 0xff, 0x10, }, 4, 0, "call", "indirect",
-"67 f2 ff 10          \tbnd callq *(%eax)",},
+"67 f2 ff 10          \tbnd call *(%eax)",},
 {{0xf2, 0xc3, }, 2, 0, "ret", "indirect",
-"f2 c3                \tbnd retq ",},
+"f2 c3                \tbnd ret",},
 {{0xf2, 0xe9, 0x00, 0x00, 0x00, 0x00, }, 6, 0, "jmp", "unconditional",
-"f2 e9 00 00 00 00    \tbnd jmpq f2e <main+0xf2e>",},
+"f2 e9 00 00 00 00    \tbnd jmp 16c1 <main+0x16c1>",},
 {{0xf2, 0xe9, 0x00, 0x00, 0x00, 0x00, }, 6, 0, "jmp", "unconditional",
-"f2 e9 00 00 00 00    \tbnd jmpq f34 <main+0xf34>",},
+"f2 e9 00 00 00 00    \tbnd jmp 16c7 <main+0x16c7>",},
 {{0x67, 0xf2, 0xff, 0x21, }, 4, 0, "jmp", "indirect",
-"67 f2 ff 21          \tbnd jmpq *(%ecx)",},
+"67 f2 ff 21          \tbnd jmp *(%ecx)",},
 {{0xf2, 0x0f, 0x85, 0x00, 0x00, 0x00, 0x00, }, 7, 0, "jcc", "conditional",
-"f2 0f 85 00 00 00 00 \tbnd jne f3f <main+0xf3f>",},
+"f2 0f 85 00 00 00 00 \tbnd jne 16d2 <main+0x16d2>",},
 {{0x0f, 0x3a, 0xcc, 0xc1, 0x00, }, 5, 0, "", "",
 "0f 3a cc c1 00       \tsha1rnds4 $0x0,%xmm1,%xmm0",},
 {{0x0f, 0x3a, 0xcc, 0xd7, 0x91, }, 5, 0, "", "",
@@ -2134,7 +2135,7 @@
 {{0x41, 0x0f, 0xae, 0x38, }, 4, 0, "", "",
 "41 0f ae 38          \tclflush (%r8)",},
 {{0x0f, 0xae, 0xf8, }, 3, 0, "", "",
-"0f ae f8             \tsfence ",},
+"0f ae f8             \tsfence",},
 {{0x66, 0x0f, 0xae, 0x30, }, 4, 0, "", "",
 "66 0f ae 30          \tclwb   (%rax)",},
 {{0x66, 0x41, 0x0f, 0xae, 0x30, }, 5, 0, "", "",
@@ -2150,7 +2151,7 @@
 {{0x41, 0x0f, 0xae, 0x30, }, 4, 0, "", "",
 "41 0f ae 30          \txsaveopt (%r8)",},
 {{0x0f, 0xae, 0xf0, }, 3, 0, "", "",
-"0f ae f0             \tmfence ",},
+"0f ae f0             \tmfence",},
 {{0x0f, 0x1c, 0x00, }, 3, 0, "", "",
 "0f 1c 00             \tcldemote (%rax)",},
 {{0x41, 0x0f, 0x1c, 0x00, }, 4, 0, "", "",
@@ -2282,7 +2283,7 @@
 {{0x41, 0x0f, 0xae, 0xac, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 9, 0, "", "",
 "41 0f ae ac c8 78 56 34 12 \txrstor 0x12345678(%r8,%rcx,8)",},
 {{0x0f, 0xae, 0xe8, }, 3, 0, "", "",
-"0f ae e8             \tlfence ",},
+"0f ae e8             \tlfence",},
 {{0xf3, 0x0f, 0x1e, 0xc8, }, 4, 0, "", "",
 "f3 0f 1e c8          \trdsspd %eax",},
 {{0xf3, 0x41, 0x0f, 0x1e, 0xc8, }, 5, 0, "", "",
@@ -2292,7 +2293,7 @@
 {{0xf3, 0x49, 0x0f, 0x1e, 0xc8, }, 5, 0, "", "",
 "f3 49 0f 1e c8       \trdsspq %r8",},
 {{0xf3, 0x0f, 0x01, 0xea, }, 4, 0, "", "",
-"f3 0f 01 ea          \tsaveprevssp ",},
+"f3 0f 01 ea          \tsaveprevssp",},
 {{0xf3, 0x0f, 0x01, 0x28, }, 4, 0, "", "",
 "f3 0f 01 28          \trstorssp (%rax)",},
 {{0xf3, 0x41, 0x0f, 0x01, 0x28, }, 5, 0, "", "",
@@ -2344,11 +2345,11 @@
 {{0x66, 0x49, 0x0f, 0x38, 0xf5, 0x94, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
 "66 49 0f 38 f5 94 c8 78 56 34 12 \twrussq %rdx,0x12345678(%r8,%rcx,8)",},
 {{0xf3, 0x0f, 0x01, 0xe8, }, 4, 0, "", "",
-"f3 0f 01 e8          \tsetssbsy ",},
+"f3 0f 01 e8          \tsetssbsy",},
 {{0x0f, 0x01, 0xee, }, 3, 0, "", "",
-"0f 01 ee             \trdpkru ",},
+"0f 01 ee             \trdpkru",},
 {{0x0f, 0x01, 0xef, }, 3, 0, "", "",
-"0f 01 ef             \twrpkru ",},
+"0f 01 ef             \twrpkru",},
 {{0xf3, 0x0f, 0xae, 0x30, }, 4, 0, "", "",
 "f3 0f ae 30          \tclrssbsy (%rax)",},
 {{0xf3, 0x41, 0x0f, 0xae, 0x30, }, 5, 0, "", "",
@@ -2360,105 +2361,105 @@
 {{0xf3, 0x41, 0x0f, 0xae, 0xb4, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 10, 0, "", "",
 "f3 41 0f ae b4 c8 78 56 34 12 \tclrssbsy 0x12345678(%r8,%rcx,8)",},
 {{0xf3, 0x0f, 0x1e, 0xfb, }, 4, 0, "", "",
-"f3 0f 1e fb          \tendbr32 ",},
+"f3 0f 1e fb          \tendbr32",},
 {{0xf3, 0x0f, 0x1e, 0xfa, }, 4, 0, "", "",
-"f3 0f 1e fa          \tendbr64 ",},
+"f3 0f 1e fa          \tendbr64",},
 {{0xff, 0xd0, }, 2, 0, "call", "indirect",
-"ff d0                \tcallq  *%rax",},
+"ff d0                \tcall   *%rax",},
 {{0xff, 0x10, }, 2, 0, "call", "indirect",
-"ff 10                \tcallq  *(%rax)",},
+"ff 10                \tcall   *(%rax)",},
 {{0x41, 0xff, 0x10, }, 3, 0, "call", "indirect",
-"41 ff 10             \tcallq  *(%r8)",},
+"41 ff 10             \tcall   *(%r8)",},
 {{0xff, 0x14, 0x25, 0x78, 0x56, 0x34, 0x12, }, 7, 0, "call", "indirect",
-"ff 14 25 78 56 34 12 \tcallq  *0x12345678",},
+"ff 14 25 78 56 34 12 \tcall   *0x12345678",},
 {{0xff, 0x94, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 7, 0, "call", "indirect",
-"ff 94 c8 78 56 34 12 \tcallq  *0x12345678(%rax,%rcx,8)",},
+"ff 94 c8 78 56 34 12 \tcall   *0x12345678(%rax,%rcx,8)",},
 {{0x41, 0xff, 0x94, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 8, 0, "call", "indirect",
-"41 ff 94 c8 78 56 34 12 \tcallq  *0x12345678(%r8,%rcx,8)",},
+"41 ff 94 c8 78 56 34 12 \tcall   *0x12345678(%r8,%rcx,8)",},
 {{0xf2, 0xff, 0xd0, }, 3, 0, "call", "indirect",
-"f2 ff d0             \tbnd callq *%rax",},
+"f2 ff d0             \tbnd call *%rax",},
 {{0xf2, 0xff, 0x10, }, 3, 0, "call", "indirect",
-"f2 ff 10             \tbnd callq *(%rax)",},
+"f2 ff 10             \tbnd call *(%rax)",},
 {{0xf2, 0x41, 0xff, 0x10, }, 4, 0, "call", "indirect",
-"f2 41 ff 10          \tbnd callq *(%r8)",},
+"f2 41 ff 10          \tbnd call *(%r8)",},
 {{0xf2, 0xff, 0x14, 0x25, 0x78, 0x56, 0x34, 0x12, }, 8, 0, "call", "indirect",
-"f2 ff 14 25 78 56 34 12 \tbnd callq *0x12345678",},
+"f2 ff 14 25 78 56 34 12 \tbnd call *0x12345678",},
 {{0xf2, 0xff, 0x94, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 8, 0, "call", "indirect",
-"f2 ff 94 c8 78 56 34 12 \tbnd callq *0x12345678(%rax,%rcx,8)",},
+"f2 ff 94 c8 78 56 34 12 \tbnd call *0x12345678(%rax,%rcx,8)",},
 {{0xf2, 0x41, 0xff, 0x94, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 9, 0, "call", "indirect",
-"f2 41 ff 94 c8 78 56 34 12 \tbnd callq *0x12345678(%r8,%rcx,8)",},
+"f2 41 ff 94 c8 78 56 34 12 \tbnd call *0x12345678(%r8,%rcx,8)",},
 {{0x3e, 0xff, 0xd0, }, 3, 0, "call", "indirect",
-"3e ff d0             \tnotrack callq *%rax",},
+"3e ff d0             \tnotrack call *%rax",},
 {{0x3e, 0xff, 0x10, }, 3, 0, "call", "indirect",
-"3e ff 10             \tnotrack callq *(%rax)",},
+"3e ff 10             \tnotrack call *(%rax)",},
 {{0x3e, 0x41, 0xff, 0x10, }, 4, 0, "call", "indirect",
-"3e 41 ff 10          \tnotrack callq *(%r8)",},
+"3e 41 ff 10          \tnotrack call *(%r8)",},
 {{0x3e, 0xff, 0x14, 0x25, 0x78, 0x56, 0x34, 0x12, }, 8, 0, "call", "indirect",
-"3e ff 14 25 78 56 34 12 \tnotrack callq *0x12345678",},
+"3e ff 14 25 78 56 34 12 \tnotrack call *0x12345678",},
 {{0x3e, 0xff, 0x94, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 8, 0, "call", "indirect",
-"3e ff 94 c8 78 56 34 12 \tnotrack callq *0x12345678(%rax,%rcx,8)",},
+"3e ff 94 c8 78 56 34 12 \tnotrack call *0x12345678(%rax,%rcx,8)",},
 {{0x3e, 0x41, 0xff, 0x94, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 9, 0, "call", "indirect",
-"3e 41 ff 94 c8 78 56 34 12 \tnotrack callq *0x12345678(%r8,%rcx,8)",},
+"3e 41 ff 94 c8 78 56 34 12 \tnotrack call *0x12345678(%r8,%rcx,8)",},
 {{0x3e, 0xf2, 0xff, 0xd0, }, 4, 0, "call", "indirect",
-"3e f2 ff d0          \tnotrack bnd callq *%rax",},
+"3e f2 ff d0          \tnotrack bnd call *%rax",},
 {{0x3e, 0xf2, 0xff, 0x10, }, 4, 0, "call", "indirect",
-"3e f2 ff 10          \tnotrack bnd callq *(%rax)",},
+"3e f2 ff 10          \tnotrack bnd call *(%rax)",},
 {{0x3e, 0xf2, 0x41, 0xff, 0x10, }, 5, 0, "call", "indirect",
-"3e f2 41 ff 10       \tnotrack bnd callq *(%r8)",},
+"3e f2 41 ff 10       \tnotrack bnd call *(%r8)",},
 {{0x3e, 0xf2, 0xff, 0x14, 0x25, 0x78, 0x56, 0x34, 0x12, }, 9, 0, "call", "indirect",
-"3e f2 ff 14 25 78 56 34 12 \tnotrack bnd callq *0x12345678",},
+"3e f2 ff 14 25 78 56 34 12 \tnotrack bnd call *0x12345678",},
 {{0x3e, 0xf2, 0xff, 0x94, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 9, 0, "call", "indirect",
-"3e f2 ff 94 c8 78 56 34 12 \tnotrack bnd callq *0x12345678(%rax,%rcx,8)",},
+"3e f2 ff 94 c8 78 56 34 12 \tnotrack bnd call *0x12345678(%rax,%rcx,8)",},
 {{0x3e, 0xf2, 0x41, 0xff, 0x94, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 10, 0, "call", "indirect",
-"3e f2 41 ff 94 c8 78 56 34 12 \tnotrack bnd callq *0x12345678(%r8,%rcx,8)",},
+"3e f2 41 ff 94 c8 78 56 34 12 \tnotrack bnd call *0x12345678(%r8,%rcx,8)",},
 {{0xff, 0xe0, }, 2, 0, "jmp", "indirect",
-"ff e0                \tjmpq   *%rax",},
+"ff e0                \tjmp    *%rax",},
 {{0xff, 0x20, }, 2, 0, "jmp", "indirect",
-"ff 20                \tjmpq   *(%rax)",},
+"ff 20                \tjmp    *(%rax)",},
 {{0x41, 0xff, 0x20, }, 3, 0, "jmp", "indirect",
-"41 ff 20             \tjmpq   *(%r8)",},
+"41 ff 20             \tjmp    *(%r8)",},
 {{0xff, 0x24, 0x25, 0x78, 0x56, 0x34, 0x12, }, 7, 0, "jmp", "indirect",
-"ff 24 25 78 56 34 12 \tjmpq   *0x12345678",},
+"ff 24 25 78 56 34 12 \tjmp    *0x12345678",},
 {{0xff, 0xa4, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 7, 0, "jmp", "indirect",
-"ff a4 c8 78 56 34 12 \tjmpq   *0x12345678(%rax,%rcx,8)",},
+"ff a4 c8 78 56 34 12 \tjmp    *0x12345678(%rax,%rcx,8)",},
 {{0x41, 0xff, 0xa4, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 8, 0, "jmp", "indirect",
-"41 ff a4 c8 78 56 34 12 \tjmpq   *0x12345678(%r8,%rcx,8)",},
+"41 ff a4 c8 78 56 34 12 \tjmp    *0x12345678(%r8,%rcx,8)",},
 {{0xf2, 0xff, 0xe0, }, 3, 0, "jmp", "indirect",
-"f2 ff e0             \tbnd jmpq *%rax",},
+"f2 ff e0             \tbnd jmp *%rax",},
 {{0xf2, 0xff, 0x20, }, 3, 0, "jmp", "indirect",
-"f2 ff 20             \tbnd jmpq *(%rax)",},
+"f2 ff 20             \tbnd jmp *(%rax)",},
 {{0xf2, 0x41, 0xff, 0x20, }, 4, 0, "jmp", "indirect",
-"f2 41 ff 20          \tbnd jmpq *(%r8)",},
+"f2 41 ff 20          \tbnd jmp *(%r8)",},
 {{0xf2, 0xff, 0x24, 0x25, 0x78, 0x56, 0x34, 0x12, }, 8, 0, "jmp", "indirect",
-"f2 ff 24 25 78 56 34 12 \tbnd jmpq *0x12345678",},
+"f2 ff 24 25 78 56 34 12 \tbnd jmp *0x12345678",},
 {{0xf2, 0xff, 0xa4, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 8, 0, "jmp", "indirect",
-"f2 ff a4 c8 78 56 34 12 \tbnd jmpq *0x12345678(%rax,%rcx,8)",},
+"f2 ff a4 c8 78 56 34 12 \tbnd jmp *0x12345678(%rax,%rcx,8)",},
 {{0xf2, 0x41, 0xff, 0xa4, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 9, 0, "jmp", "indirect",
-"f2 41 ff a4 c8 78 56 34 12 \tbnd jmpq *0x12345678(%r8,%rcx,8)",},
+"f2 41 ff a4 c8 78 56 34 12 \tbnd jmp *0x12345678(%r8,%rcx,8)",},
 {{0x3e, 0xff, 0xe0, }, 3, 0, "jmp", "indirect",
-"3e ff e0             \tnotrack jmpq *%rax",},
+"3e ff e0             \tnotrack jmp *%rax",},
 {{0x3e, 0xff, 0x20, }, 3, 0, "jmp", "indirect",
-"3e ff 20             \tnotrack jmpq *(%rax)",},
+"3e ff 20             \tnotrack jmp *(%rax)",},
 {{0x3e, 0x41, 0xff, 0x20, }, 4, 0, "jmp", "indirect",
-"3e 41 ff 20          \tnotrack jmpq *(%r8)",},
+"3e 41 ff 20          \tnotrack jmp *(%r8)",},
 {{0x3e, 0xff, 0x24, 0x25, 0x78, 0x56, 0x34, 0x12, }, 8, 0, "jmp", "indirect",
-"3e ff 24 25 78 56 34 12 \tnotrack jmpq *0x12345678",},
+"3e ff 24 25 78 56 34 12 \tnotrack jmp *0x12345678",},
 {{0x3e, 0xff, 0xa4, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 8, 0, "jmp", "indirect",
-"3e ff a4 c8 78 56 34 12 \tnotrack jmpq *0x12345678(%rax,%rcx,8)",},
+"3e ff a4 c8 78 56 34 12 \tnotrack jmp *0x12345678(%rax,%rcx,8)",},
 {{0x3e, 0x41, 0xff, 0xa4, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 9, 0, "jmp", "indirect",
-"3e 41 ff a4 c8 78 56 34 12 \tnotrack jmpq *0x12345678(%r8,%rcx,8)",},
+"3e 41 ff a4 c8 78 56 34 12 \tnotrack jmp *0x12345678(%r8,%rcx,8)",},
 {{0x3e, 0xf2, 0xff, 0xe0, }, 4, 0, "jmp", "indirect",
-"3e f2 ff e0          \tnotrack bnd jmpq *%rax",},
+"3e f2 ff e0          \tnotrack bnd jmp *%rax",},
 {{0x3e, 0xf2, 0xff, 0x20, }, 4, 0, "jmp", "indirect",
-"3e f2 ff 20          \tnotrack bnd jmpq *(%rax)",},
+"3e f2 ff 20          \tnotrack bnd jmp *(%rax)",},
 {{0x3e, 0xf2, 0x41, 0xff, 0x20, }, 5, 0, "jmp", "indirect",
-"3e f2 41 ff 20       \tnotrack bnd jmpq *(%r8)",},
+"3e f2 41 ff 20       \tnotrack bnd jmp *(%r8)",},
 {{0x3e, 0xf2, 0xff, 0x24, 0x25, 0x78, 0x56, 0x34, 0x12, }, 9, 0, "jmp", "indirect",
-"3e f2 ff 24 25 78 56 34 12 \tnotrack bnd jmpq *0x12345678",},
+"3e f2 ff 24 25 78 56 34 12 \tnotrack bnd jmp *0x12345678",},
 {{0x3e, 0xf2, 0xff, 0xa4, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 9, 0, "jmp", "indirect",
-"3e f2 ff a4 c8 78 56 34 12 \tnotrack bnd jmpq *0x12345678(%rax,%rcx,8)",},
+"3e f2 ff a4 c8 78 56 34 12 \tnotrack bnd jmp *0x12345678(%rax,%rcx,8)",},
 {{0x3e, 0xf2, 0x41, 0xff, 0xa4, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 10, 0, "jmp", "indirect",
-"3e f2 41 ff a4 c8 78 56 34 12 \tnotrack bnd jmpq *0x12345678(%r8,%rcx,8)",},
+"3e f2 41 ff a4 c8 78 56 34 12 \tnotrack bnd jmp *0x12345678(%r8,%rcx,8)",},
 {{0xc4, 0xe2, 0x78, 0x49, 0x04, 0xc8, }, 6, 0, "", "",
 "c4 e2 78 49 04 c8    \tldtilecfg (%rax,%rcx,8)",},
 {{0xc4, 0xc2, 0x78, 0x49, 0x04, 0xc8, }, 6, 0, "", "",
@@ -2486,7 +2487,7 @@
 {{0xc4, 0xc2, 0x79, 0x4b, 0x14, 0xc8, }, 6, 0, "", "",
 "c4 c2 79 4b 14 c8    \ttileloaddt1 (%r8,%rcx,8),%tmm2",},
 {{0xc4, 0xe2, 0x78, 0x49, 0xc0, }, 5, 0, "", "",
-"c4 e2 78 49 c0       \ttilerelease ",},
+"c4 e2 78 49 c0       \ttilerelease",},
 {{0xc4, 0xe2, 0x7a, 0x4b, 0x0c, 0xc8, }, 6, 0, "", "",
 "c4 e2 7a 4b 0c c8    \ttilestored %tmm1,(%rax,%rcx,8)",},
 {{0xc4, 0xc2, 0x7a, 0x4b, 0x14, 0xc8, }, 6, 0, "", "",
@@ -2496,17 +2497,17 @@
 {{0xc4, 0xe2, 0x7b, 0x49, 0xf8, }, 5, 0, "", "",
 "c4 e2 7b 49 f8       \ttilezero %tmm7",},
 {{0xf3, 0x0f, 0x01, 0xee, }, 4, 0, "", "",
-"f3 0f 01 ee          \tclui   ",},
+"f3 0f 01 ee          \tclui",},
 {{0xf3, 0x0f, 0xc7, 0xf0, }, 4, 0, "", "",
 "f3 0f c7 f0          \tsenduipi %rax",},
 {{0xf3, 0x41, 0x0f, 0xc7, 0xf0, }, 5, 0, "", "",
 "f3 41 0f c7 f0       \tsenduipi %r8",},
 {{0xf3, 0x0f, 0x01, 0xef, }, 4, 0, "", "",
-"f3 0f 01 ef          \tstui   ",},
+"f3 0f 01 ef          \tstui",},
 {{0xf3, 0x0f, 0x01, 0xed, }, 4, 0, "", "",
-"f3 0f 01 ed          \ttestui ",},
+"f3 0f 01 ed          \ttestui",},
 {{0xf3, 0x0f, 0x01, 0xec, }, 4, 0, "", "",
-"f3 0f 01 ec          \tuiret  ",},
+"f3 0f 01 ec          \tuiret",},
 {{0x62, 0xf5, 0x6c, 0x48, 0x58, 0xcb, }, 6, 0, "", "",
 "62 f5 6c 48 58 cb    \tvaddph %zmm3,%zmm2,%zmm1",},
 {{0x62, 0xf5, 0x6c, 0x48, 0x58, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
@@ -3880,18 +3881,24 @@
 {{0xf3, 0x0f, 0x3a, 0xf0, 0xc0, 0x00, }, 6, 0, "", "",
 "f3 0f 3a f0 c0 00    \threset $0x0",},
 {{0x0f, 0x01, 0xe8, }, 3, 0, "", "",
-"0f 01 e8             \tserialize ",},
+"0f 01 e8             \tserialize",},
 {{0xf2, 0x0f, 0x01, 0xe9, }, 4, 0, "", "",
-"f2 0f 01 e9          \txresldtrk ",},
+"f2 0f 01 e9          \txresldtrk",},
 {{0xf2, 0x0f, 0x01, 0xe8, }, 4, 0, "", "",
-"f2 0f 01 e8          \txsusldtrk ",},
+"f2 0f 01 e8          \txsusldtrk",},
 {{0x0f, 0x01, 0xcf, }, 3, 0, "", "",
-"0f 01 cf             \tencls  ",},
+"0f 01 cf             \tencls",},
 {{0x0f, 0x01, 0xd7, }, 3, 0, "", "",
-"0f 01 d7             \tenclu  ",},
+"0f 01 d7             \tenclu",},
 {{0x0f, 0x01, 0xc0, }, 3, 0, "", "",
-"0f 01 c0             \tenclv  ",},
+"0f 01 c0             \tenclv",},
 {{0x0f, 0x01, 0xc5, }, 3, 0, "", "",
-"0f 01 c5             \tpconfig ",},
+"0f 01 c5             \tpconfig",},
 {{0xf3, 0x0f, 0x09, }, 3, 0, "", "",
-"f3 0f 09             \twbnoinvd ",},
+"f3 0f 09             \twbnoinvd",},
+{{0x0f, 0x01, 0xee, }, 3, 0, "", "",
+"0f 01 ee             \trdpkru",},
+{{0x0f, 0x01, 0xef, }, 3, 0, "", "",
+"0f 01 ef             \twrpkru",},
+{{0}, 0, 0, NULL, NULL, NULL},
+};
diff --git a/tools/perf/arch/x86/tests/insn-x86.c b/tools/perf/arch/x86/tests/insn-x86.c
index 7b5eb8baf0f2..447f7ba1eff3 100644
--- a/tools/perf/arch/x86/tests/insn-x86.c
+++ b/tools/perf/arch/x86/tests/insn-x86.c
@@ -18,21 +18,8 @@ struct test_data {
 	const char *asm_rep;
 };
 
-const struct test_data test_data_32[] = {
 #include "insn-x86-dat-32.c"
-	{{0x0f, 0x01, 0xee}, 3, 0, NULL, NULL, "0f 01 ee             \trdpkru"},
-	{{0x0f, 0x01, 0xef}, 3, 0, NULL, NULL, "0f 01 ef             \twrpkru"},
-	{{0}, 0, 0, NULL, NULL, NULL},
-};
-
-const struct test_data test_data_64[] = {
 #include "insn-x86-dat-64.c"
-	{{0x0f, 0x01, 0xee}, 3, 0, NULL, NULL, "0f 01 ee             \trdpkru"},
-	{{0x0f, 0x01, 0xef}, 3, 0, NULL, NULL, "0f 01 ef             \twrpkru"},
-	{{0xf2, 0x0f, 0x01, 0xca}, 4, 0, "erets", "indirect", "f2 0f 01 ca  \terets"},
-	{{0xf3, 0x0f, 0x01, 0xca}, 4, 0, "eretu", "indirect", "f3 0f 01 ca  \teretu"},
-	{{0}, 0, 0, NULL, NULL, NULL},
-};
 
 static int get_op(const char *op_str)
 {
@@ -156,6 +143,16 @@ static int test_data_set(const struct test_data *dat_set, int x86_64)
 		if (test_data_item(dat, x86_64))
 			ret = -1;
 	}
+	if (x86_64) {
+		const struct test_data eret[] = {
+			{{0xf2, 0x0f, 0x01, 0xca}, 4, 0,
+			 "erets", "indirect", "f2 0f 01 ca  \terets"},
+			{{0xf3, 0x0f, 0x01, 0xca}, 4, 0,
+			 "eretu", "indirect", "f3 0f 01 ca  \teretu"},
+		};
+		if (test_data_item(&eret[0], x86_64) || test_data_item(&eret[1], x86_64))
+			ret = -1;
+	}
 
 	return ret;
 }
-- 
2.41.0.rc0.172.g3f132b7071-goog

