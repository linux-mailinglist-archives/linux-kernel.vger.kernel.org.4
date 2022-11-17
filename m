Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1EBE62E8B9
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 23:51:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232659AbiKQWu3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 17:50:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231146AbiKQWuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 17:50:15 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE9316710D
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 14:50:13 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-373569200ceso32866807b3.4
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 14:50:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5g4stZb5GhZxbwVvGKfu2i1DjHI8byuVQmgsHRcsgOA=;
        b=LHPRuEbvEA2rgcRwJLn55niGiqPobJ8yItLkMOoFhex+zXR35sPs1zvoctcWOXHW6q
         8SzA1FHfSDSiJwE2ebDYlCWjq5YtNoH1DdYCWdx2JyOkwrn6gvKTAK2qt36Qtx1PzV/m
         4ULpFYaKJCYLSSqMI1Pxuy7d6/fQ9Fmwv8N5WVUD/o0bMbsiuAKKTHVdp5K9lv09endd
         taxR7V4H1QgTEo1h/1P6qVOxLW5Nh9sI+WQ1FxfKlkvJKGi7Fkn3DLY4KV+dMxZiZ0ey
         EejFFryTUFGqnDMXZ2WjaYZm1OboySBe9RBq19J5z5mxYBKjsC+ukO7exjIA7FoowW4f
         sxsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5g4stZb5GhZxbwVvGKfu2i1DjHI8byuVQmgsHRcsgOA=;
        b=HLhEQLoGiVgJ8CTPOZycOaiCOQCISenfaXmOY5OmObQmTXHnXR0tRKEaZG15JPfRwn
         xFh0X6TWQ+Zs+mBR1zwZ2Lc4Vo1OEeMZ0cDt5oWyFeltBRvVGlxHKMmkwSFfCudrfLam
         IBhPznkAEEJxpTS91OvMAbpuzhbO9t82yWn/4riJLfcKyVpqG5qNAu3wWHtND8DXi+RA
         XdYIctDmTkr79V8U+pChU6uPY6tlFag3/tuZjk/eV/2mk4XxLwt+JiYqyCX5wVjshCw9
         Y3CgZPSojk6ZCQ4v7+0G//9YIDmgx6Zm5Ljlli1AC1D78aNrVowKUpf0GTr0OCByveMl
         aZHA==
X-Gm-Message-State: ANoB5pkd8iFTpbqkCFMO5a7aiqSlFZKHafiIu2eOfs3ZLQzFhmo57+rY
        43AlaUJS1qoeBLAFga/jHj47cjncOhVF
X-Google-Smtp-Source: AA0mqf7ZSsdxktgQi+Xfz0RyTIOCliXhrMouXEdSZzQCaz0F2Z2qQfw8Ff4MDPUGtjtdFWMKw2CtD7TMPjaa
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:3f1e:c462:d6b8:fba8])
 (user=irogers job=sendgmr) by 2002:a05:690c:788:b0:38f:b0ef:4700 with SMTP id
 bw8-20020a05690c078800b0038fb0ef4700mr4133986ywb.263.1668725413131; Thu, 17
 Nov 2022 14:50:13 -0800 (PST)
Date:   Thu, 17 Nov 2022 14:49:51 -0800
In-Reply-To: <20221117224952.358639-1-irogers@google.com>
Message-Id: <20221117224952.358639-2-irogers@google.com>
Mime-Version: 1.0
References: <20221117224952.358639-1-irogers@google.com>
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
Subject: [PATCH v1 1/2] perf build: Require libtraceevent from the system
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Steven Rostedt <rostedt@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Linux Trace Devel <linux-trace-devel@vger.kernel.org>
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,USER_IN_DEF_DKIM_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unconditionally require libtraceevent to come from the system. Force
the determination of the libtracefs version if it is present.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Makefile.config | 51 +++++++++-----------
 tools/perf/Makefile.perf   | 95 ++------------------------------------
 2 files changed, 28 insertions(+), 118 deletions(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 9cc3c48f3288..38dd686277c1 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -1182,34 +1182,29 @@ ifdef LIBPFM4
   endif
 endif
 
-ifdef LIBTRACEEVENT_DYNAMIC
-  $(call feature_check,libtraceevent)
-  ifeq ($(feature-libtraceevent), 1)
-    EXTLIBS += -ltraceevent
-    LIBTRACEEVENT_VERSION := $(shell $(PKG_CONFIG) --modversion libtraceevent)
-    LIBTRACEEVENT_VERSION_1 := $(word 1, $(subst ., ,$(LIBTRACEEVENT_VERSION)))
-    LIBTRACEEVENT_VERSION_2 := $(word 2, $(subst ., ,$(LIBTRACEEVENT_VERSION)))
-    LIBTRACEEVENT_VERSION_3 := $(word 3, $(subst ., ,$(LIBTRACEEVENT_VERSION)))
-    LIBTRACEEVENT_VERSION_CPP := $(shell expr $(LIBTRACEEVENT_VERSION_1) \* 255 \* 255 + $(LIBTRACEEVENT_VERSION_2) \* 255 + $(LIBTRACEEVENT_VERSION_3))
-    CFLAGS += -DLIBTRACEEVENT_VERSION=$(LIBTRACEEVENT_VERSION_CPP)
-  else
-    dummy := $(error Error: No libtraceevent devel library found, please install libtraceevent-devel);
-  endif
-endif
-
-ifdef LIBTRACEFS_DYNAMIC
-  $(call feature_check,libtracefs)
-  ifeq ($(feature-libtracefs), 1)
-    EXTLIBS += -ltracefs
-    LIBTRACEFS_VERSION := $(shell $(PKG_CONFIG) --modversion libtracefs)
-    LIBTRACEFS_VERSION_1 := $(word 1, $(subst ., ,$(LIBTRACEFS_VERSION)))
-    LIBTRACEFS_VERSION_2 := $(word 2, $(subst ., ,$(LIBTRACEFS_VERSION)))
-    LIBTRACEFS_VERSION_3 := $(word 3, $(subst ., ,$(LIBTRACEFS_VERSION)))
-    LIBTRACEFS_VERSION_CPP := $(shell expr $(LIBTRACEFS_VERSION_1) \* 255 \* 255 + $(LIBTRACEFS_VERSION_2) \* 255 + $(LIBTRACEFS_VERSION_3))
-    CFLAGS += -DLIBTRACEFS_VERSION=$(LIBTRACEFS_VERSION_CPP)
-  else
-    dummy := $(error Error: No libtracefs devel library found, please install libtracefs-dev);
-  endif
+# libtraceevent is a required dependency picked up from the system.
+$(call feature_check,libtraceevent)
+ifeq ($(feature-libtraceevent), 1)
+  EXTLIBS += -ltraceevent
+  LIBTRACEEVENT_VERSION := $(shell $(PKG_CONFIG) --modversion libtraceevent)
+  LIBTRACEEVENT_VERSION_1 := $(word 1, $(subst ., ,$(LIBTRACEEVENT_VERSION)))
+  LIBTRACEEVENT_VERSION_2 := $(word 2, $(subst ., ,$(LIBTRACEEVENT_VERSION)))
+  LIBTRACEEVENT_VERSION_3 := $(word 3, $(subst ., ,$(LIBTRACEEVENT_VERSION)))
+  LIBTRACEEVENT_VERSION_CPP := $(shell expr $(LIBTRACEEVENT_VERSION_1) \* 255 \* 255 + $(LIBTRACEEVENT_VERSION_2) \* 255 + $(LIBTRACEEVENT_VERSION_3))
+  CFLAGS += -DLIBTRACEEVENT_VERSION=$(LIBTRACEEVENT_VERSION_CPP)
+else
+  dummy := $(error Error: libtraceevent is missing, please install libtraceevent-dev)
+endif
+
+$(call feature_check,libtracefs)
+ifeq ($(feature-libtracefs), 1)
+  EXTLIBS += -ltracefs
+  LIBTRACEFS_VERSION := $(shell $(PKG_CONFIG) --modversion libtracefs)
+  LIBTRACEFS_VERSION_1 := $(word 1, $(subst ., ,$(LIBTRACEFS_VERSION)))
+  LIBTRACEFS_VERSION_2 := $(word 2, $(subst ., ,$(LIBTRACEFS_VERSION)))
+  LIBTRACEFS_VERSION_3 := $(word 3, $(subst ., ,$(LIBTRACEFS_VERSION)))
+  LIBTRACEFS_VERSION_CPP := $(shell expr $(LIBTRACEFS_VERSION_1) \* 255 \* 255 + $(LIBTRACEFS_VERSION_2) \* 255 + $(LIBTRACEFS_VERSION_3))
+  CFLAGS += -DLIBTRACEFS_VERSION=$(LIBTRACEFS_VERSION_CPP)
 endif
 
 # Among the variables below, these:
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 59c4e8f9b014..2e5617b64046 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -128,10 +128,6 @@ include ../scripts/utilities.mak
 #
 # Define BUILD_BPF_SKEL to enable BPF skeletons
 #
-# Define LIBTRACEEVENT_DYNAMIC to enable libtraceevent dynamic linking
-#
-# Define LIBTRACEFS_DYNAMIC to enable libtracefs dynamic linking
-#
 
 # As per kernel Makefile, avoid funny character set dependencies
 unexport LC_ALL
@@ -242,10 +238,6 @@ sub-make: fixdep
 else # force_fixdep
 
 LIBAPI_DIR      = $(srctree)/tools/lib/api/
-ifndef LIBTRACEEVENT_DYNAMIC
-LIBTRACEEVENT_DIR = $(srctree)/tools/lib/traceevent/
-LIBTRACEEVENT_PLUGINS_DIR = $(LIBTRACEEVENT_DIR)/plugins
-endif
 LIBBPF_DIR      = $(srctree)/tools/lib/bpf/
 LIBSUBCMD_DIR   = $(srctree)/tools/lib/subcmd/
 LIBSYMBOL_DIR   = $(srctree)/tools/lib/symbol/
@@ -295,31 +287,6 @@ SCRIPT_SH += perf-iostat.sh
 grep-libs = $(filter -l%,$(1))
 strip-libs = $(filter-out -l%,$(1))
 
-ifndef LIBTRACEEVENT_DYNAMIC
-ifneq ($(OUTPUT),)
-  LIBTRACEEVENT_OUTPUT = $(abspath $(OUTPUT))/libtraceevent
-else
-  LIBTRACEEVENT_OUTPUT = $(CURDIR)/libtraceevent
-endif
-LIBTRACEEVENT_PLUGINS_OUTPUT = $(LIBTRACEEVENT_OUTPUT)_plugins
-LIBTRACEEVENT_DESTDIR = $(LIBTRACEEVENT_OUTPUT)
-LIBTRACEEVENT_PLUGINS_DESTDIR = $(LIBTRACEEVENT_PLUGINS_OUTPUT)
-LIBTRACEEVENT_INCLUDE = $(LIBTRACEEVENT_DESTDIR)/include
-LIBTRACEEVENT = $(LIBTRACEEVENT_OUTPUT)/libtraceevent.a
-export LIBTRACEEVENT
-LIBTRACEEVENT_DYNAMIC_LIST = $(LIBTRACEEVENT_PLUGINS_OUTPUT)/libtraceevent-dynamic-list
-CFLAGS += -I$(LIBTRACEEVENT_OUTPUT)/include
-#
-# The static build has no dynsym table, so this does not work for
-# static build. Looks like linker starts to scream about that now
-# (in Fedora 26) so we need to switch it off for static build.
-DYNAMIC_LIST_LDFLAGS               = -Xlinker --dynamic-list=$(LIBTRACEEVENT_DYNAMIC_LIST)
-LIBTRACEEVENT_DYNAMIC_LIST_LDFLAGS = $(if $(findstring -static,$(LDFLAGS)),,$(DYNAMIC_LIST_LDFLAGS))
-else
-LIBTRACEEVENT_DYNAMIC_LIST =
-LIBTRACEEVENT_DYNAMIC_LIST_LDFLAGS =
-endif
-
 ifneq ($(OUTPUT),)
   LIBAPI_OUTPUT = $(abspath $(OUTPUT))/libapi
 else
@@ -381,11 +348,7 @@ export PYTHON_EXTBUILD_LIB PYTHON_EXTBUILD_TMP
 python-clean := $(call QUIET_CLEAN, python) $(RM) -r $(PYTHON_EXTBUILD) $(OUTPUT)python/perf*.so
 
 PYTHON_EXT_SRCS := $(shell grep -v ^\# util/python-ext-sources)
-ifndef LIBTRACEEVENT_DYNAMIC
-PYTHON_EXT_DEPS := util/python-ext-sources util/setup.py $(LIBTRACEEVENT) $(LIBAPI)
-else
 PYTHON_EXT_DEPS := util/python-ext-sources util/setup.py $(LIBAPI)
-endif
 
 SCRIPTS = $(patsubst %.sh,%,$(SCRIPT_SH))
 
@@ -430,9 +393,6 @@ ifndef NO_LIBBPF
     PERFLIBS += $(LIBBPF)
   endif
 endif
-ifndef LIBTRACEEVENT_DYNAMIC
-  PERFLIBS += $(LIBTRACEEVENT)
-endif
 
 # We choose to avoid "if .. else if .. else .. endif endif"
 # because maintaining the nesting to match is a pain.  If
@@ -682,9 +642,9 @@ all: shell_compatibility_test $(ALL_PROGRAMS) $(LANG_BINDINGS) $(OTHER_PROGRAMS)
 # Create python binding output directory if not already present
 _dummy := $(shell [ -d '$(OUTPUT)python' ] || mkdir -p '$(OUTPUT)python')
 
-$(OUTPUT)python/perf.so: $(PYTHON_EXT_SRCS) $(PYTHON_EXT_DEPS) $(LIBTRACEEVENT_DYNAMIC_LIST) $(LIBPERF)
+$(OUTPUT)python/perf.so: $(PYTHON_EXT_SRCS) $(PYTHON_EXT_DEPS) $(LIBPERF)
 	$(QUIET_GEN)LDSHARED="$(CC) -pthread -shared" \
-        CFLAGS='$(CFLAGS)' LDFLAGS='$(LDFLAGS) $(LIBTRACEEVENT_DYNAMIC_LIST_LDFLAGS)' \
+        CFLAGS='$(CFLAGS)' LDFLAGS='$(LDFLAGS)' \
 	  $(PYTHON_WORD) util/setup.py \
 	  --quiet build_ext; \
 	cp $(PYTHON_EXTBUILD_LIB)perf*.so $(OUTPUT)python/
@@ -710,8 +670,8 @@ $(PERF_IN): prepare FORCE
 $(PMU_EVENTS_IN): FORCE prepare
 	$(Q)$(MAKE) -f $(srctree)/tools/build/Makefile.build dir=pmu-events obj=pmu-events
 
-$(OUTPUT)perf: $(PERFLIBS) $(PERF_IN) $(PMU_EVENTS_IN) $(LIBTRACEEVENT_DYNAMIC_LIST)
-	$(QUIET_LINK)$(CC) $(CFLAGS) $(LDFLAGS) $(LIBTRACEEVENT_DYNAMIC_LIST_LDFLAGS) \
+$(OUTPUT)perf: $(PERFLIBS) $(PERF_IN) $(PMU_EVENTS_IN)
+	$(QUIET_LINK)$(CC) $(CFLAGS) $(LDFLAGS) \
 		$(PERF_IN) $(PMU_EVENTS_IN) $(LIBS) -o $@
 
 $(GTK_IN): FORCE
@@ -797,10 +757,6 @@ prepare: $(OUTPUT)PERF-VERSION-FILE $(OUTPUT)common-cmds.h archheaders $(drm_ioc
 	$(LIBSYMBOL) \
 	bpf-skel
 
-ifndef LIBTRACEEVENT_DYNAMIC
-prepare: $(LIBTRACEEVENT)
-endif
-
 $(OUTPUT)%.o: %.c prepare FORCE
 	$(Q)$(MAKE) -f $(srctree)/tools/build/Makefile.build dir=$(build-dir) $@
 
@@ -856,38 +812,6 @@ endif
 
 $(patsubst perf-%,%.o,$(PROGRAMS)): $(wildcard */*.h)
 
-ifndef LIBTRACEEVENT_DYNAMIC
-LIBTRACEEVENT_FLAGS += plugin_dir=$(plugindir_SQ) 'EXTRA_CFLAGS=$(EXTRA_CFLAGS)' 'LDFLAGS=$(filter-out -static,$(LDFLAGS))'
-
-$(LIBTRACEEVENT): FORCE | $(LIBTRACEEVENT_OUTPUT)
-	$(Q)$(MAKE) -C $(LIBTRACEEVENT_DIR) O=$(LIBTRACEEVENT_OUTPUT) \
-		DESTDIR=$(LIBTRACEEVENT_DESTDIR) prefix= \
-		$@ install_headers
-
-$(LIBTRACEEVENT)-clean:
-	$(call QUIET_CLEAN, libtraceevent)
-	$(Q)$(RM) -r -- $(LIBTRACEEVENT_OUTPUT)
-
-libtraceevent_plugins: FORCE | $(LIBTRACEEVENT_PLUGINS_OUTPUT)
-	$(Q)$(MAKE) -C $(LIBTRACEEVENT_PLUGINS_DIR) O=$(LIBTRACEEVENT_PLUGINS_OUTPUT) \
-		DESTDIR=$(LIBTRACEEVENT_PLUGINS_DESTDIR) prefix= \
-		plugins
-
-libtraceevent_plugins-clean:
-	$(call QUIET_CLEAN, libtraceevent_plugins)
-	$(Q)$(RM) -r -- $(LIBTRACEEVENT_PLUGINS_OUTPUT)
-
-$(LIBTRACEEVENT_DYNAMIC_LIST): libtraceevent_plugins
-	$(Q)$(MAKE) -C $(LIBTRACEEVENT_PLUGINS_DIR) O=$(LIBTRACEEVENT_PLUGINS_OUTPUT) \
-		DESTDIR=$(LIBTRACEEVENT_PLUGINS_DESTDIR) prefix= \
-		$(LIBTRACEEVENT_FLAGS) $@
-
-install-traceevent-plugins: libtraceevent_plugins
-	$(Q)$(MAKE) -C $(LIBTRACEEVENT_PLUGINS_DIR) O=$(LIBTRACEEVENT_PLUGINS_OUTPUT) \
-		DESTDIR=$(LIBTRACEEVENT_PLUGINS_DESTDIR) prefix= \
-		$(LIBTRACEEVENT_FLAGS) install
-endif
-
 $(LIBAPI): FORCE | $(LIBAPI_OUTPUT)
 	$(Q)$(MAKE) -C $(LIBAPI_DIR) O=$(LIBAPI_OUTPUT) \
 		DESTDIR=$(LIBAPI_DESTDIR) prefix= \
@@ -1120,11 +1044,6 @@ SKELETONS += $(SKEL_OUT)/kwork_trace.skel.h
 $(SKEL_TMP_OUT) $(LIBAPI_OUTPUT) $(LIBBPF_OUTPUT) $(LIBPERF_OUTPUT) $(LIBSUBCMD_OUTPUT) $(LIBSYMBOL_OUTPUT):
 	$(Q)$(MKDIR) -p $@
 
-ifndef LIBTRACEEVENT_DYNAMIC
-$(LIBTRACEEVENT_OUTPUT) $(LIBTRACEEVENT_PLUGINS_OUTPUT):
-	$(Q)$(MKDIR) -p $@
-endif
-
 ifdef BUILD_BPF_SKEL
 BPFTOOL := $(SKEL_TMP_OUT)/bootstrap/bpftool
 BPF_INCLUDE := -I$(SKEL_TMP_OUT)/.. -I$(LIBBPF_INCLUDE)
@@ -1207,10 +1126,6 @@ clean:: $(LIBAPI)-clean $(LIBBPF)-clean $(LIBSUBCMD)-clean $(LIBSYMBOL)-clean $(
 	$(call QUIET_CLEAN, Documentation) \
 	$(MAKE) -C $(DOC_DIR) O=$(OUTPUT) clean >/dev/null
 
-ifndef LIBTRACEEVENT_DYNAMIC
-clean:: $(LIBTRACEEVENT)-clean libtraceevent_plugins-clean
-endif
-
 #
 # To provide FEATURE-DUMP into $(FEATURE_DUMP_COPY)
 # file if defined, with no further action.
@@ -1228,6 +1143,6 @@ FORCE:
 .PHONY: all install clean config-clean strip install-gtk
 .PHONY: shell_compatibility_test please_set_SHELL_PATH_to_a_more_modern_shell
 .PHONY: .FORCE-PERF-VERSION-FILE TAGS tags cscope FORCE prepare
-.PHONY: libtraceevent_plugins archheaders
+.PHONY: archheaders
 
 endif # force_fixdep
-- 
2.38.1.584.g0f3c55d4c2-goog

