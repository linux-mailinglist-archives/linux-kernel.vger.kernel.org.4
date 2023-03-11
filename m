Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ACB56B5925
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 07:59:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbjCKG7i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 01:59:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbjCKG73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 01:59:29 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82ED111D0A6
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 22:58:57 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 204-20020a2514d5000000b00a3637aea9e1so8185121ybu.17
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 22:58:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678517937;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1pq+mKZowelrihgZxRhsuEZHUM4AjdLByKfzOTWop3w=;
        b=WCpB1voDzndaohurNNZYQGv0vrqsEJxdv42rkVIZwjJfH7whmhOKEBaX1/oAFnc74Z
         zcO5YSNux0MCfvJfD8ZHjPWUeYjHzNGqUczp4XQaT16TZ+PIRtBs6x7K4zv7OVhY0xSk
         5gH5mQiBKsjvMd82GAPqiULNfojeP7aVd6i/lK1KQSJERsjQe78tBuapzfeUT6vp+gNH
         LfBvxdKgQwhCP8xtS2L9sxnh0OvBnSTj9RYS2SQFuWrl7V10lsdoizZdl4+nilttIthq
         rq+yeLwFjlivAk+KJslhScF8GXvNDH+922JgCOkqH9J0oxNVqjZWOWe61IwvvU7dd6gJ
         lXkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678517937;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1pq+mKZowelrihgZxRhsuEZHUM4AjdLByKfzOTWop3w=;
        b=umXD6DCKdqav0acLpiXwZPcm8Qf7ddsnEn4F6AsgS1zIp+2uZDckNgfNqi4/XJPSlp
         ihSY5vSzPyriJxIHKQrbaqucG5kJABmPitalZcBtfnqY+5ssf2+Ml2sYdK+jyp9Zq6EZ
         no2+SPAUL75LarycbobZSF77wkpEQ/eNd0lazHlbyYbxwwjYVluYF1jlPpZjzWUX766G
         JLpXCRz35+h9QOZS4l8JYzRKAto4k4lVDgahy3WQO/2Iuk6F69pp427g9IWkoiaMEmNW
         DK4sU0dqPL9Oc6OMAuHPQjFvcOf5PuKpeShbt1L4rdJsKuyTKoX0Dq6Sbf9lPHTu8Q0Y
         pQaw==
X-Gm-Message-State: AO0yUKWYsR2V8dDi9hwASq5tNB+jnvNk8fuSU8WUCQiIpgwk911ZvlKg
        /RqhR7gZU/v16Mb/AJ74nFPzZ8pVnpJm
X-Google-Smtp-Source: AK7set8aUqc8K5cZUVUsFpXNndv1liCiw25sradrgvIfHuLhCd2KbosYVbgxeqUpBlh9ZgLyL4l4p2TpvgWe
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:a11d:a763:a328:f2d6])
 (user=irogers job=sendgmr) by 2002:a05:6902:185:b0:acd:7374:f15b with SMTP id
 t5-20020a056902018500b00acd7374f15bmr17294166ybh.13.1678517937040; Fri, 10
 Mar 2023 22:58:57 -0800 (PST)
Date:   Fri, 10 Mar 2023 22:57:47 -0800
In-Reply-To: <20230311065753.3012826-1-irogers@google.com>
Message-Id: <20230311065753.3012826-8-irogers@google.com>
Mime-Version: 1.0
References: <20230311065753.3012826-1-irogers@google.com>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
Subject: [PATCH v1 07/13] perf build: Make binutil libraries opt in
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

binutils is GPLv3 so distributions cannot ship perf linked against
libbfd and libiberty as the licenses are incompatible. Rather than
defaulting the build to opting in to libbfd and libiberty support and
opting out via NO_LIBBFD=1 and NO_DEMANGLE=1, make building against
the libraries optional and enabled with BUILD_NONDISTRO=1.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Makefile.config | 25 ++++++++++---------------
 tools/perf/Makefile.perf   |  2 ++
 tools/perf/tests/make      |  2 ++
 3 files changed, 14 insertions(+), 15 deletions(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 2557654d8e29..5756498248e0 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -882,7 +882,7 @@ ifneq ($(NO_JEVENTS),1)
   endif
 endif
 
-ifndef NO_LIBBFD
+ifdef BUILD_NONDISTRO
   ifeq ($(feature-libbfd), 1)
     EXTLIBS += -lbfd -lopcodes
   else
@@ -905,6 +905,7 @@ ifndef NO_LIBBFD
     $(call feature_check,disassembler-init-styled)
   endif
 
+  CFLAGS += -DHAVE_LIBBFD_SUPPORT
   ifeq ($(feature-libbfd-buildid), 1)
     CFLAGS += -DHAVE_LIBBFD_BUILDID_SUPPORT
   else
@@ -915,32 +916,26 @@ endif
 ifdef NO_DEMANGLE
   CFLAGS += -DNO_DEMANGLE
 else
-  ifdef HAVE_CPLUS_DEMANGLE_SUPPORT
-    EXTLIBS += -liberty
-  else
+  ifdef BUILD_NONDISTRO
     ifeq ($(filter -liberty,$(EXTLIBS)),)
-      $(call feature_check,cplus-demangle)
-
-      # we dont have neither HAVE_CPLUS_DEMANGLE_SUPPORT
-      # or any of 'bfd iberty z' trinity
-      ifeq ($(feature-cplus-demangle), 1)
+      ifdef HAVE_CPLUS_DEMANGLE_SUPPORT
         EXTLIBS += -liberty
       else
-        msg := $(warning No bfd.h/libbfd found, please install binutils-dev[el]/zlib-static/libiberty-dev to gain symbol demangling)
-        CFLAGS += -DNO_DEMANGLE
+        $(call feature_check,cplus-demangle)
+        ifeq ($(feature-cplus-demangle), 1)
+          EXTLIBS += -liberty
+        endif
       endif
     endif
   endif
 
   ifneq ($(filter -liberty,$(EXTLIBS)),)
     CFLAGS += -DHAVE_CPLUS_DEMANGLE_SUPPORT
+  else
+    CFLAGS += -DNO_DEMANGLE
   endif
 endif
 
-ifneq ($(filter -lbfd,$(EXTLIBS)),)
-  CFLAGS += -DHAVE_LIBBFD_SUPPORT
-endif
-
 ifndef NO_ZLIB
   ifeq ($(feature-zlib), 1)
     CFLAGS += -DHAVE_ZLIB_SUPPORT
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 283ee4f56234..a35bc995d5d8 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -128,6 +128,8 @@ include ../scripts/utilities.mak
 #
 # Define NO_BPF_SKEL to disable BPF skeletons
 #
+# Define BUILD_NONDISTRO to enable building an linking against libbfd and
+# libiberty distribution license incompatible libraries.
 
 # As per kernel Makefile, avoid funny character set dependencies
 unexport LC_ALL
diff --git a/tools/perf/tests/make b/tools/perf/tests/make
index deb37fb982e9..c2f74ed43418 100644
--- a/tools/perf/tests/make
+++ b/tools/perf/tests/make
@@ -68,6 +68,7 @@ python_perf_so := $(shell $(MAKE) python_perf_target|grep "Target is:"|awk '{pri
 make_clean_all      := clean all
 make_python_perf_so := $(python_perf_so)
 make_debug          := DEBUG=1
+make_nondistro      := BUILD_NONDISTRO=1
 make_no_libperl     := NO_LIBPERL=1
 make_no_libpython   := NO_LIBPYTHON=1
 make_no_scripts     := NO_LIBPYTHON=1 NO_LIBPERL=1
@@ -134,6 +135,7 @@ MAKE_F := $(MAKE) -f $(MK)
 endif
 run += make_python_perf_so
 run += make_debug
+run += make_nondistro
 run += make_no_libperl
 run += make_no_libpython
 run += make_no_scripts
-- 
2.40.0.rc1.284.g88254d51c5-goog

