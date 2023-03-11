Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 363D86B591F
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 07:58:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbjCKG61 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 01:58:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbjCKG6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 01:58:16 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AB8C1E5D6
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 22:58:15 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-536d63d17dbso77973997b3.22
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 22:58:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678517894;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hwwywuV0dZU1czvMnaqVuf21dNJ0Sgzpp/JikcaGwIM=;
        b=iyrOLKNXgp5pumM5DPnUpRoFROT7RshhOsI0yeo95KWRoGMdlcNQFCDjSYJF/fd4gd
         7hu12qdHoHdYgm5zqyEXci3bfX0dydaKiArEDp0hM+neBf5ZBCosEv8IMARvBPjkqvmb
         yyD03otq1Y3WrtRW1ipFvMJEFdzz4bTnUoWXEjLsUOaY2TTFbdm4WovCLsZ2ZMDxdDWx
         ahYVziJPegDQKv0SeE+vgbJ/BrG1XcS0IJjpZIdltdzjzWegZRCUU4PBAwH//URFsDzl
         qYjgfQT96MzCh+0XPNa8h0mKffrqvjZKoqCnZjWCb3uAKrC7+1bdEynScYjzx9wmJgNd
         WA5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678517894;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hwwywuV0dZU1czvMnaqVuf21dNJ0Sgzpp/JikcaGwIM=;
        b=Ur5sZUQa3SSeFvnF84OBELoxeiz8nYNwrRs20/ZDwtkwXX1if4a+smObFX/0GZj+2A
         o9nMdy+vz50VCMpCOSUCilhYGxbMYztm13egvnQufEiq1bbgzwdq3KWsESBsJ12OCLQg
         sqlOs4gu4Sg/NsbRAUWk8mvny2K5H//5D8K11Rdt8iUPwiI0sF+WXaPuslQUUE49CUSt
         /bu4KEQLPLTtd2T8cRRnWMq8u/ZzNKEae2o0zbEABXFY6C2a3f8Phfr3KR+8Ni3YzhOO
         LYs5oAEccAXk4kwwi4uxRWY9aaFpdPgef3MCI75SWXc5xIahZHakwOu+Z9Ulnwdht6A9
         iEvg==
X-Gm-Message-State: AO0yUKXBxlWPdOFVR/RFR+ECs1eJiCLZNB6HdjzLoQr72ffbxaD+29Yd
        ZnfamJdaErFxklMB9TGzLwry2mqiZKCo
X-Google-Smtp-Source: AK7set/zGiooCzj2OYBw/Kwkd+hENEaJ42PWysldu6pOmjd3+QpAqaf5IiY56xK1QlQisJb8LjrjQIF7eeVF
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:a11d:a763:a328:f2d6])
 (user=irogers job=sendgmr) by 2002:a05:6902:251:b0:9f1:6c48:f95f with SMTP id
 k17-20020a056902025100b009f16c48f95fmr6264375ybs.5.1678517894743; Fri, 10 Mar
 2023 22:58:14 -0800 (PST)
Date:   Fri, 10 Mar 2023 22:57:41 -0800
In-Reply-To: <20230311065753.3012826-1-irogers@google.com>
Message-Id: <20230311065753.3012826-2-irogers@google.com>
Mime-Version: 1.0
References: <20230311065753.3012826-1-irogers@google.com>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
Subject: [PATCH v1 01/13] perf build: Support python/perf.so testing
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
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a build target to echo the python/perf.so's name from
Makefile.perf. Use it in tests/make so the correct target is built and
tested for.

Fixes: caec54705adb ("perf build: Fix python/perf.so library's name")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Makefile.perf | 7 +++++--
 tools/perf/tests/make    | 5 +++--
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index bac9272682b7..2fcee585b225 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -647,13 +647,16 @@ all: shell_compatibility_test $(ALL_PROGRAMS) $(LANG_BINDINGS) $(OTHER_PROGRAMS)
 # Create python binding output directory if not already present
 _dummy := $(shell [ -d '$(OUTPUT)python' ] || mkdir -p '$(OUTPUT)python')
 
-$(OUTPUT)python/perf$(PYTHON_EXTENSION_SUFFIX): $(PYTHON_EXT_SRCS) $(PYTHON_EXT_DEPS) $(LIBPERF)
+$(OUTPUT)python/perf$(PYTHON_EXTENSION_SUFFIX): $(PYTHON_EXT_SRCS) $(PYTHON_EXT_DEPS) $(LIBPERF) $(LIBSUBCMD)
 	$(QUIET_GEN)LDSHARED="$(CC) -pthread -shared" \
         CFLAGS='$(CFLAGS)' LDFLAGS='$(LDFLAGS)' \
 	  $(PYTHON_WORD) util/setup.py \
 	  --quiet build_ext; \
 	cp $(PYTHON_EXTBUILD_LIB)perf*.so $(OUTPUT)python/
 
+python_perf_target:
+	@echo "Target is: $(OUTPUT)python/perf$(PYTHON_EXTENSION_SUFFIX)"
+
 please_set_SHELL_PATH_to_a_more_modern_shell:
 	$(Q)$$(:)
 
@@ -1152,7 +1155,7 @@ FORCE:
 .PHONY: all install clean config-clean strip install-gtk
 .PHONY: shell_compatibility_test please_set_SHELL_PATH_to_a_more_modern_shell
 .PHONY: .FORCE-PERF-VERSION-FILE TAGS tags cscope FORCE prepare
-.PHONY: archheaders
+.PHONY: archheaders python_perf_target
 
 endif # force_fixdep
 
diff --git a/tools/perf/tests/make b/tools/perf/tests/make
index 009d6efb673c..deb37fb982e9 100644
--- a/tools/perf/tests/make
+++ b/tools/perf/tests/make
@@ -62,10 +62,11 @@ lib = lib
 endif
 
 has = $(shell which $1 2>/dev/null)
+python_perf_so := $(shell $(MAKE) python_perf_target|grep "Target is:"|awk '{print $$3}')
 
 # standard single make variable specified
 make_clean_all      := clean all
-make_python_perf_so := python/perf.so
+make_python_perf_so := $(python_perf_so)
 make_debug          := DEBUG=1
 make_no_libperl     := NO_LIBPERL=1
 make_no_libpython   := NO_LIBPYTHON=1
@@ -204,7 +205,7 @@ test_make_doc    := $(test_ok)
 test_make_help_O := $(test_ok)
 test_make_doc_O  := $(test_ok)
 
-test_make_python_perf_so := test -f $(PERF_O)/python/perf.so
+test_make_python_perf_so := test -f $(PERF_O)/$(python_perf_so)
 
 test_make_perf_o           := test -f $(PERF_O)/perf.o
 test_make_util_map_o       := test -f $(PERF_O)/util/map.o
-- 
2.40.0.rc1.284.g88254d51c5-goog

