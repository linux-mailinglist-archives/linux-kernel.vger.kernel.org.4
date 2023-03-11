Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B58826B5929
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 08:00:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbjCKHAM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 02:00:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230142AbjCKG7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 01:59:50 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98404DDF37
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 22:59:25 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5376fa4106eso77140017b3.7
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 22:59:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678517959;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UaJIIcBEzyZNOhgIC/lIx2fcWxamKUkNGMgdjyQDc5Y=;
        b=JbwMyb82arUwYsbpp+2CR3MOHnK4Bsgb7d87J6uyhp979D8l8HMxntJlXJ4Ze9lD8o
         iFmBbKwqDAo3XhKpHsyaZSNeXtsidCNlvJm0M4gN9mCD3eta1g0KxeorDAWq9p68P34H
         xeb/mr6jj4e0OdWAZrQOZphdhr2VY3Mdtb3Rj6aM9M/JVn0koMGGTASHDtYSHDlzwTUY
         3IyCYa58D7A0JflpKOIKrnlZTrtELd+rFMGtv4aiKRORbakk4zVXOML7dZQAJ7k3X2Hz
         VdhFBzRYTBm18iPXmY4AhKQIpdedyNTxP6bKwMYmVRtPEFAvg7WLEC32TfF36clrZ4+Z
         U3Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678517959;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UaJIIcBEzyZNOhgIC/lIx2fcWxamKUkNGMgdjyQDc5Y=;
        b=5ik1A2t+h9lzgJTLRyJl3s12rEhOlZrS6A+wMBJzhKKCJgyqKIJA/IlO3mDj5NcOrm
         rklBwTET4BCLnu+SPDMEIo/AXrDsAzwecryEoJxA2q1OwzFJYFWRASJe+FDHStHOyhG7
         Q71r+uCCSEgYvnlIKH7aaG1mnx/O265xU9DIyGzUM/kKmrxkTtJfwovMEKuG7uV0Itga
         hA6fTp8RUzen0lJEsBcKfQITUQHc3WX0GGuIZKboyOVzd+HSYZMG1wYms3ItAOzDqE/R
         Dl/xNNVnIgehOxdTE2/5mlZ3Cm0ZTNsvWCohUu6BcbqsiXP/yTdAICLUGJmxBk/XJB7/
         64VA==
X-Gm-Message-State: AO0yUKXUsgx/gzlXCFW0OaIO6LUfLIuArUFvy+hQeFbPDWARak4h6dSB
        nFcLNNaB7Db+GsQoDG1qDcxzUTvdZonS
X-Google-Smtp-Source: AK7set8r7y5C4YRsyVKjA7xb6uMrDtNqf2buJwznbMCVbDT8O9J9H12jt+MiPLw/Ik+0AdXWYz2LqVnm5lPL
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:a11d:a763:a328:f2d6])
 (user=irogers job=sendgmr) by 2002:a81:ac28:0:b0:536:55e5:2eaa with SMTP id
 k40-20020a81ac28000000b0053655e52eaamr18111377ywh.3.1678517959721; Fri, 10
 Mar 2023 22:59:19 -0800 (PST)
Date:   Fri, 10 Mar 2023 22:57:50 -0800
In-Reply-To: <20230311065753.3012826-1-irogers@google.com>
Message-Id: <20230311065753.3012826-11-irogers@google.com>
Mime-Version: 1.0
References: <20230311065753.3012826-1-irogers@google.com>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
Subject: [PATCH v1 10/13] perf build: Switch libpfm4 to opt-out rather than opt-in
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

If libpfm4 passes the feature test, it would be nice to have it
enabled rather than also requiring the LIBPFM4=1 build flag.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Makefile.config | 3 +--
 tools/perf/Makefile.perf   | 2 +-
 tools/perf/tests/make      | 4 ++--
 3 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index fdeca45cf15f..9754218bd418 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -1130,7 +1130,7 @@ ifdef LIBCLANGLLVM
   endif
 endif
 
-ifdef LIBPFM4
+ifndef NO_LIBPFM4
   $(call feature_check,libpfm4)
   ifeq ($(feature-libpfm4), 1)
     CFLAGS += -DHAVE_LIBPFM
@@ -1139,7 +1139,6 @@ ifdef LIBPFM4
     $(call detected,CONFIG_LIBPFM4)
   else
     msg := $(warning libpfm4 not found, disables libpfm4 support. Please install libpfm4-dev);
-    NO_LIBPFM4 := 1
   endif
 endif
 
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index a35bc995d5d8..3e06915f6bd0 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -122,7 +122,7 @@ include ../scripts/utilities.mak
 # generated from the kernel .tbl or unistd.h files and use, if available, libaudit
 # for doing the conversions to/from strings/id.
 #
-# Define LIBPFM4 to enable libpfm4 events extension.
+# Define NO_LIBPFM4 to disable libpfm4 events extension.
 #
 # Define NO_LIBDEBUGINFOD if you do not want support debuginfod
 #
diff --git a/tools/perf/tests/make b/tools/perf/tests/make
index c2f74ed43418..47c665659022 100644
--- a/tools/perf/tests/make
+++ b/tools/perf/tests/make
@@ -94,7 +94,7 @@ make_with_coresight := CORESIGHT=1
 make_no_sdt	    := NO_SDT=1
 make_no_syscall_tbl := NO_SYSCALL_TABLE=1
 make_with_clangllvm := LIBCLANGLLVM=1
-make_with_libpfm4   := LIBPFM4=1
+make_no_libpfm4     := NO_LIBPFM4=1
 make_with_gtk2      := GTK2=1
 make_tags           := tags
 make_cscope         := cscope
@@ -161,7 +161,7 @@ run += make_no_syscall_tbl
 run += make_with_babeltrace
 run += make_with_coresight
 run += make_with_clangllvm
-run += make_with_libpfm4
+run += make_no_libpfm4
 run += make_help
 run += make_doc
 run += make_perf_o
-- 
2.40.0.rc1.284.g88254d51c5-goog

