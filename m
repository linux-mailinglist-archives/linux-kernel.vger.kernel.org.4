Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B298E6B5920
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 07:58:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbjCKG6c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 01:58:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230022AbjCKG6X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 01:58:23 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15C9B1CACF
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 22:58:21 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-536c02ed619so77481407b3.8
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 22:58:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678517901;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=RBPfmbzctqVIG9gwCAzW6yooPI1omXt9V9PytRIeuNs=;
        b=QIy+Zsx8m6qoDCdnldf0taLwai2+eVaQBBo50mkDUf1VKm2OpzfMRAtYZUfFENXA6z
         thQnedSb9es+j5EYkRMqJ7s9vBI1/ZODxhOEnJ4xp5KtjpkgsVDyDOQq25CjNENVZmNF
         U3c8y7gBp6qI97MFVXOehWtTzBmuZQCBXSxYoqydOH89iXMaTfJM0iKrdUBDT34L7U4D
         7VV2rJYTEwBI6qR1ngadiisg3L/a5CPArbU3eygofpA+uxpus6gLBVVNQPj4E2yPx2k/
         lC6FCcLswyZoOqX6gAGX62Tj3YutR7bIv4/aGAB1yC2qAAa8tFqxXbCnBLQSBe04+Foz
         vT6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678517901;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RBPfmbzctqVIG9gwCAzW6yooPI1omXt9V9PytRIeuNs=;
        b=YTpBRfrPgM0cRmcK0bbaKrBMgefemGAzsLXuOU/vksCIjkaqxO125DUYWjiQzpZ4Cv
         v83n0J1ZaXcj4v0RpD06x8bvunbSAQ0HFGB1xIn3mBWIyzspxF2Ruchdsst81ohHssM1
         d/liz5wfi7aqX2S37ULs0Y4gJeho18iecVxNnhAegaQvQkTZYj+fXKGhYqaHy4mgweUV
         Cal3eD+IKP2iYLeS6D1gBF2TfV/+LCD/Z7skNUFOT72wERNwcHfMwL6SGOK5I1ykymXu
         DQ72rVapQc8miZn5D6R9AHrf1A8RT/mo0andXAt+GvHT4JnsidWOKrvMoj11+cV1IICh
         9nNA==
X-Gm-Message-State: AO0yUKUL4Wr0AsXpQIHixPEboiT/rHV5GKlmYi2z5mQJB/8GtFgZocZX
        S72wihfFFENjUFp/I76OICC4tjQtCW+V
X-Google-Smtp-Source: AK7set8nKWk1NpypLpltvL4S8pwGpmKJvYspdMoxC8WtqcM318/ZIatbP70iCt8VS2bf5Drd8d+q6hUyIxXV
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:a11d:a763:a328:f2d6])
 (user=irogers job=sendgmr) by 2002:a0d:ea0c:0:b0:4fd:56f3:fdad with SMTP id
 t12-20020a0dea0c000000b004fd56f3fdadmr9ywe.57.1678517900896; Fri, 10 Mar 2023
 22:58:20 -0800 (PST)
Date:   Fri, 10 Mar 2023 22:57:42 -0800
In-Reply-To: <20230311065753.3012826-1-irogers@google.com>
Message-Id: <20230311065753.3012826-3-irogers@google.com>
Mime-Version: 1.0
References: <20230311065753.3012826-1-irogers@google.com>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
Subject: [PATCH v1 02/13] perf build: Make BUILD_BPF_SKEL default, rename to NO_BPF_SKEL
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
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
        "=?UTF-8?q?Martin=20Li=C5=A1ka?=" <mliska@suse.cz>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        llvm@lists.linux.dev
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

BPF skeleton support is now key to a number of perf features. Rather
than making it so that BPF support must be enabled for the build, make
this the default and error if the build lacks a clang and libbpf that
are sufficient. To avoid the error and build without BPF skeletons the
NO_BPF_SKEL=1 flag can be used. Add a build-options flag to 'perf
version' to enable detection of the BPF skeleton support and use this
in the offcpu shell test.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Makefile.config              | 19 ++++++++++++-------
 tools/perf/Makefile.perf                |  8 ++++----
 tools/perf/builtin-lock.c               |  2 +-
 tools/perf/builtin-record.c             |  2 +-
 tools/perf/builtin-version.c            |  1 +
 tools/perf/tests/shell/record_offcpu.sh |  2 +-
 6 files changed, 20 insertions(+), 14 deletions(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 5f11834f189e..33d62d542fd5 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -415,6 +415,7 @@ ifdef NO_LIBELF
   NO_LIBUNWIND := 1
   NO_LIBDW_DWARF_UNWIND := 1
   NO_LIBBPF := 1
+  NO_BPF_SKEL := 1
   NO_JVMTI := 1
 else
   ifeq ($(feature-libelf), 0)
@@ -662,18 +663,22 @@ ifndef NO_LIBBPF
     msg := $(warning BPF API too old. Please install recent kernel headers. BPF support in 'perf record' is disabled.)
     NO_LIBBPF := 1
   endif
+else
+  NO_BPF_SKEL := 1
 endif
 
-ifdef BUILD_BPF_SKEL
+ifndef NO_BPF_SKEL
   $(call feature_check,clang-bpf-co-re)
   ifeq ($(feature-clang-bpf-co-re), 0)
-    dummy := $(error Error: clang too old/not installed. Please install recent clang to build with BUILD_BPF_SKEL)
-  endif
-  ifeq ($(filter -DHAVE_LIBBPF_SUPPORT, $(CFLAGS)),)
-    dummy := $(error Error: BPF skeleton support requires libbpf)
+    dummy := $(error: ERROR: BPF skeletons unsupported. clang too old/not installed or build with NO_BPF_SKEL=1.)
+  else
+    ifeq ($(filter -DHAVE_LIBBPF_SUPPORT, $(CFLAGS)),)
+      dummy := $(error: ERROR: BPF skeletons unsupported. BPF skeleton support requires libbpf or build with NO_BPF_SKEL=1.)
+    else
+      $(call detected,CONFIG_PERF_BPF_SKEL)
+      CFLAGS += -DHAVE_BPF_SKEL
+    endif
   endif
-  $(call detected,CONFIG_PERF_BPF_SKEL)
-  CFLAGS += -DHAVE_BPF_SKEL
 endif
 
 dwarf-post-unwind := 1
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 2fcee585b225..283ee4f56234 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -126,7 +126,7 @@ include ../scripts/utilities.mak
 #
 # Define NO_LIBDEBUGINFOD if you do not want support debuginfod
 #
-# Define BUILD_BPF_SKEL to enable BPF skeletons
+# Define NO_BPF_SKEL to disable BPF skeletons
 #
 
 # As per kernel Makefile, avoid funny character set dependencies
@@ -1055,7 +1055,7 @@ SKELETONS += $(SKEL_OUT)/kwork_trace.skel.h
 $(SKEL_TMP_OUT) $(LIBAPI_OUTPUT) $(LIBBPF_OUTPUT) $(LIBPERF_OUTPUT) $(LIBSUBCMD_OUTPUT) $(LIBSYMBOL_OUTPUT):
 	$(Q)$(MKDIR) -p $@
 
-ifdef BUILD_BPF_SKEL
+ifndef NO_BPF_SKEL
 BPFTOOL := $(SKEL_TMP_OUT)/bootstrap/bpftool
 BPF_INCLUDE := -I$(SKEL_TMP_OUT)/.. -I$(LIBBPF_INCLUDE)
 
@@ -1088,11 +1088,11 @@ bpf-skel: $(SKELETONS)
 
 .PRECIOUS: $(SKEL_TMP_OUT)/%.bpf.o
 
-else # BUILD_BPF_SKEL
+else # NO_BPF_SKEL
 
 bpf-skel:
 
-endif # BUILD_BPF_SKEL
+endif # NO_BPF_SKEL
 
 bpf-skel-clean:
 	$(call QUIET_CLEAN, bpf-skel) $(RM) -r $(SKEL_TMP_OUT) $(SKELETONS)
diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index 054997edd98b..240d49a85524 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -2371,7 +2371,7 @@ int cmd_lock(int argc, const char **argv)
 
 #ifndef HAVE_BPF_SKEL
 		set_option_nobuild(contention_options, 'b', "use-bpf",
-				   "no BUILD_BPF_SKEL=1", false);
+				   "NO_BPF_SKEL=1", false);
 #endif
 		if (argc) {
 			argc = parse_options(argc, argv, contention_options,
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 8374117e66f6..495627437f97 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -3971,7 +3971,7 @@ int cmd_record(int argc, const char **argv)
 
 #ifndef HAVE_BPF_SKEL
 # define set_nobuild(s, l, m, c) set_option_nobuild(record_options, s, l, m, c)
-	set_nobuild('\0', "off-cpu", "no BUILD_BPF_SKEL=1", true);
+	set_nobuild('\0', "off-cpu", "NO_BPF_SKEL=1", true);
 # undef set_nobuild
 #endif
 
diff --git a/tools/perf/builtin-version.c b/tools/perf/builtin-version.c
index a886929ec6e5..0d9cda238c07 100644
--- a/tools/perf/builtin-version.c
+++ b/tools/perf/builtin-version.c
@@ -83,6 +83,7 @@ static void library_status(void)
 	STATUS(HAVE_ZSTD_SUPPORT, zstd);
 	STATUS(HAVE_LIBPFM, libpfm4);
 	STATUS(HAVE_LIBTRACEEVENT, libtraceevent);
+	STATUS(HAVE_BPF_SKEL, BPF skeletons);
 }
 
 int cmd_version(int argc, const char **argv)
diff --git a/tools/perf/tests/shell/record_offcpu.sh b/tools/perf/tests/shell/record_offcpu.sh
index e01973d4e0fb..24f81ff85793 100755
--- a/tools/perf/tests/shell/record_offcpu.sh
+++ b/tools/perf/tests/shell/record_offcpu.sh
@@ -28,7 +28,7 @@ test_offcpu_priv() {
     err=2
     return
   fi
-  if perf record --off-cpu -o /dev/null --quiet true 2>&1 | grep BUILD_BPF_SKEL
+  if perf version --build-options 2>&1 | grep HAVE_BPF_SKEL | grep -q OFF
   then
     echo "off-cpu test [Skipped missing BPF support]"
     err=2
-- 
2.40.0.rc1.284.g88254d51c5-goog

