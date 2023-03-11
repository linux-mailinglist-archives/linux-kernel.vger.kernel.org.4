Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DFC86B5927
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 08:00:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbjCKG7z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 01:59:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbjCKG7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 01:59:46 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBBB5144845
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 22:59:14 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id h3-20020a25d003000000b00a1a201a745aso8194141ybg.22
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 22:59:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678517952;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TM6MVHcCvuJekzTOoSVMhLDs6+EBUa5GfqRq4fZc+Ec=;
        b=HdhM8KBj3naBHJmHM7igItQ5pBTYYwK7qACdj0h9KiPaEWKZLsUQBg7f1POy+kvwR0
         XAIB8LuFlxWvu5TJMnOKluFvecDnp4+Xw8uQugf394yiK26eDGIZZqr7zTQUjPBdFLul
         1ff2oQ0gCAQDA25UdC3vYZNsEI3KK1fWX0PwAZRays8oDpkiKTfFz5wYtByAr9wryMG4
         a9W8QMUejxImdACl7uh8gRxo2ihfKbxsJysnghExmev5iG4I7yWGlAqOThA+lLRGYcvb
         tceKy1NLHq1aJo1vvHH9YBqDy9NL/LVKMRu4baJXtD8QlnkxKOs5DQDOn5p5mPfW2kc4
         wNvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678517952;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TM6MVHcCvuJekzTOoSVMhLDs6+EBUa5GfqRq4fZc+Ec=;
        b=7FcWiXggURg0v1ygcdzfak3alPxZv45+YxxByfKzabQSzpUhsAJ6qv368NDrLDf3P0
         pp9bt9YWP8AkXcdGY670VYekVW3GnKKvWNOw3EuujBZAZ8iPbXMhwnKFy1vfFObuzbR3
         GRl/2qcfLt9DXKQwpNRW74pSMzE7Rf9dvzpEwi5emHDIdnfr27zljOdvT2xgvLNSbjZd
         hamfU6V1ZG1EOSWYQOW4SltZyDjKUKjO9vjdjl75MRRXIE8zbIIY74oeBkLBV4yKg9V2
         dXTJJnlOtP4JAJYQ23AxaDpeAbAm+/ZIyBtlg8svoKc58dCyk+HLKcBq8sYzvWIfUIdd
         MWtQ==
X-Gm-Message-State: AO0yUKUF8TxexQMzaqd7jMQpR1YmxRQ+IeN5eDafWf2pSueK3wt2Q7YZ
        ZvVP9cPGOfglab8IsUTNqoipS2RVPQBJ
X-Google-Smtp-Source: AK7set+xqAyh5y8tXjMnLJd5UbnjPtT6qg4NLqQvGdWP2Kx9rtxLaD23Nwdq9QQHOj7sVLVD/G9RUtoTx0mU
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:a11d:a763:a328:f2d6])
 (user=irogers job=sendgmr) by 2002:a5b:83:0:b0:a17:c04e:bf7c with SMTP id
 b3-20020a5b0083000000b00a17c04ebf7cmr17133991ybp.11.1678517952523; Fri, 10
 Mar 2023 22:59:12 -0800 (PST)
Date:   Fri, 10 Mar 2023 22:57:49 -0800
In-Reply-To: <20230311065753.3012826-1-irogers@google.com>
Message-Id: <20230311065753.3012826-10-irogers@google.com>
Mime-Version: 1.0
References: <20230311065753.3012826-1-irogers@google.com>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
Subject: [PATCH v1 09/13] perf symbol: Add abi::__cxa_demangle C++ demangling support
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

Refactor C++ demangling out of symbol-elf into its own files similar
to other languages. Add abi::__cxa_demangle support. As the other
demanglers are not shippable with distributions, this brings back C++
demangling in a common case. It isn't perfect as the support for
optionally demangling arguments and modifiers isn't present.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Makefile.config       | 29 +++++++++---------
 tools/perf/util/Build            |  1 +
 tools/perf/util/demangle-cxx.cpp | 50 ++++++++++++++++++++++++++++++++
 tools/perf/util/demangle-cxx.h   | 16 ++++++++++
 tools/perf/util/symbol-elf.c     | 37 +++++------------------
 5 files changed, 88 insertions(+), 45 deletions(-)
 create mode 100644 tools/perf/util/demangle-cxx.cpp
 create mode 100644 tools/perf/util/demangle-cxx.h

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 5756498248e0..fdeca45cf15f 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -906,6 +906,7 @@ ifdef BUILD_NONDISTRO
   endif
 
   CFLAGS += -DHAVE_LIBBFD_SUPPORT
+  CXXFLAGS += -DHAVE_LIBBFD_SUPPORT
   ifeq ($(feature-libbfd-buildid), 1)
     CFLAGS += -DHAVE_LIBBFD_BUILDID_SUPPORT
   else
@@ -913,26 +914,24 @@ ifdef BUILD_NONDISTRO
   endif
 endif
 
-ifdef NO_DEMANGLE
-  CFLAGS += -DNO_DEMANGLE
-else
+ifndef NO_DEMANGLE
+  $(call feature_check,cxa-demangle)
+  ifeq ($(feature-cxa-demangle), 1)
+    EXTLIBS += -lstdc++
+    CFLAGS += -DHAVE_CXA_DEMANGLE_SUPPORT
+    CXXFLAGS += -DHAVE_CXA_DEMANGLE_SUPPORT
+  endif
   ifdef BUILD_NONDISTRO
     ifeq ($(filter -liberty,$(EXTLIBS)),)
-      ifdef HAVE_CPLUS_DEMANGLE_SUPPORT
+      $(call feature_check,cplus-demangle)
+      ifeq ($(feature-cplus-demangle), 1)
         EXTLIBS += -liberty
-      else
-        $(call feature_check,cplus-demangle)
-        ifeq ($(feature-cplus-demangle), 1)
-          EXTLIBS += -liberty
-        endif
       endif
     endif
-  endif
-
-  ifneq ($(filter -liberty,$(EXTLIBS)),)
-    CFLAGS += -DHAVE_CPLUS_DEMANGLE_SUPPORT
-  else
-    CFLAGS += -DNO_DEMANGLE
+    ifneq ($(filter -liberty,$(EXTLIBS)),)
+      CFLAGS += -DHAVE_CPLUS_DEMANGLE_SUPPORT
+      CXXFLAGS += -DHAVE_CPLUS_DEMANGLE_SUPPORT
+    endif
   endif
 endif
 
diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 918b501f9bd8..8607575183a9 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -211,6 +211,7 @@ perf-$(CONFIG_ZSTD) += zstd.o
 
 perf-$(CONFIG_LIBCAP) += cap.o
 
+perf-y += demangle-cxx.o
 perf-y += demangle-ocaml.o
 perf-y += demangle-java.o
 perf-y += demangle-rust.o
diff --git a/tools/perf/util/demangle-cxx.cpp b/tools/perf/util/demangle-cxx.cpp
new file mode 100644
index 000000000000..8708bcafd370
--- /dev/null
+++ b/tools/perf/util/demangle-cxx.cpp
@@ -0,0 +1,50 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "demangle-cxx.h"
+#include <stdlib.h>
+#include <string.h>
+#include <linux/compiler.h>
+
+#ifdef HAVE_LIBBFD_SUPPORT
+#define PACKAGE 'perf'
+#include <bfd.h>
+#endif
+
+#ifdef HAVE_CXA_DEMANGLE_SUPPORT
+#include <cxxabi.h>
+#endif
+
+#if defined(HAVE_LIBBFD_SUPPORT) || defined(HAVE_CPLUS_DEMANGLE_SUPPORT)
+#ifndef DMGL_PARAMS
+#define DMGL_PARAMS     (1 << 0)  /* Include function args */
+#define DMGL_ANSI       (1 << 1)  /* Include const, volatile, etc */
+#endif
+#endif
+
+/*
+ * Demangle C++ function signature
+ *
+ * Note: caller is responsible for freeing demangled string
+ */
+extern "C"
+char *cxx_demangle_sym(const char *str, bool params __maybe_unused,
+                       bool modifiers __maybe_unused)
+{
+#ifdef HAVE_LIBBFD_SUPPORT
+        int flags = (params ? DMGL_PARAMS : 0) | (modifiers ? DMGL_ANSI : 0);
+
+        return bfd_demangle(NULL, str, flags);
+#elif defined(HAVE_CPLUS_DEMANGLE_SUPPORT)
+        int flags = (params ? DMGL_PARAMS : 0) | (modifiers ? DMGL_ANSI : 0);
+
+        return cplus_demangle(str, flags);
+#elif defined(HAVE_CXA_DEMANGLE_SUPPORT)
+        size_t len = strlen(str);
+        char *output = (char*)malloc(len);
+        int status;
+
+        output = abi::__cxa_demangle(str, output, &len, &status);
+        return output;
+#else
+        return NULL;
+#endif
+}
diff --git a/tools/perf/util/demangle-cxx.h b/tools/perf/util/demangle-cxx.h
new file mode 100644
index 000000000000..26b5b66c0b4e
--- /dev/null
+++ b/tools/perf/util/demangle-cxx.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __PERF_DEMANGLE_CXX
+#define __PERF_DEMANGLE_CXX 1
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+char *cxx_demangle_sym(const char *str, bool params, bool modifiers);
+
+#ifdef __cplusplus
+}
+#endif
+
+
+#endif /* __PERF_DEMANGLE_CXX */
diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index 41882ae8452e..c0a2de42c51b 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -12,6 +12,7 @@
 #include "maps.h"
 #include "symbol.h"
 #include "symsrc.h"
+#include "demangle-cxx.h"
 #include "demangle-ocaml.h"
 #include "demangle-java.h"
 #include "demangle-rust.h"
@@ -25,6 +26,11 @@
 #include <symbol/kallsyms.h>
 #include <internal/lib.h>
 
+#ifdef HAVE_LIBBFD_SUPPORT
+#define PACKAGE 'perf'
+#include <bfd.h>
+#endif
+
 #ifndef EM_AARCH64
 #define EM_AARCH64	183  /* ARM 64 bit */
 #endif
@@ -45,34 +51,6 @@
 
 typedef Elf64_Nhdr GElf_Nhdr;
 
-#ifndef DMGL_PARAMS
-#define DMGL_NO_OPTS     0              /* For readability... */
-#define DMGL_PARAMS      (1 << 0)       /* Include function args */
-#define DMGL_ANSI        (1 << 1)       /* Include const, volatile, etc */
-#endif
-
-#ifdef HAVE_LIBBFD_SUPPORT
-#define PACKAGE 'perf'
-#include <bfd.h>
-#else
-#ifdef HAVE_CPLUS_DEMANGLE_SUPPORT
-extern char *cplus_demangle(const char *, int);
-
-static inline char *bfd_demangle(void __maybe_unused *v, const char *c, int i)
-{
-	return cplus_demangle(c, i);
-}
-#else
-#ifdef NO_DEMANGLE
-static inline char *bfd_demangle(void __maybe_unused *v,
-				 const char __maybe_unused *c,
-				 int __maybe_unused i)
-{
-	return NULL;
-}
-#endif
-#endif
-#endif
 
 #ifndef HAVE_ELF_GETPHDRNUM_SUPPORT
 static int elf_getphdrnum(Elf *elf, size_t *dst)
@@ -295,7 +273,6 @@ static bool want_demangle(bool is_kernel_sym)
 
 static char *demangle_sym(struct dso *dso, int kmodule, const char *elf_name)
 {
-	int demangle_flags = verbose > 0 ? (DMGL_PARAMS | DMGL_ANSI) : DMGL_NO_OPTS;
 	char *demangled = NULL;
 
 	/*
@@ -306,7 +283,7 @@ static char *demangle_sym(struct dso *dso, int kmodule, const char *elf_name)
 	if (!want_demangle(dso->kernel || kmodule))
 	    return demangled;
 
-	demangled = bfd_demangle(NULL, elf_name, demangle_flags);
+	demangled = cxx_demangle_sym(elf_name, verbose > 0, verbose > 0);
 	if (demangled == NULL) {
 		demangled = ocaml_demangle_sym(elf_name);
 		if (demangled == NULL) {
-- 
2.40.0.rc1.284.g88254d51c5-goog

