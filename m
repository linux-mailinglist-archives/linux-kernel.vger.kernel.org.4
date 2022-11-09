Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 155986232F1
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 19:50:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231651AbiKISuJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 13:50:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231673AbiKISt7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 13:49:59 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1456217050
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 10:49:57 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id o2-20020a5b0502000000b006cade5e7c07so17704050ybp.10
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 10:49:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DP4kj7DiRL+xHUHvBLH3ge+vTpwFxXziF3rVwxkIDtE=;
        b=nYvq+SL0Spjx3Tz0Hp/FjWjdEbXMgRbK3pMAgdwoMnMdsPV9NVAv8NQRumPEkW2CdT
         7Ed4PVw9zmJMTMZPm9eWAmiAPSO6HSGMw+WnbOCGehZzlp2kEg6Mhi2D+VOhGx5dbN3W
         FenY5Q5AaDyYpxr3+fHT5hOp/uYTT5NT7b0BGqcJH85njZOzufE5EjTFYGUxqA/Ot/Qd
         e8qpGs+e9Yk0yy72dAu3sHSgF4yOiiMxIs3hWay7ZvUQRkErUvK+olBdYiAn7mkZtGjU
         VicdUDOt9EfDUeMo0N2FUxHvYO0j6ozd1n6gEdR320gUVJzVfvVUeeQyMa1nzciB4mtU
         FtOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DP4kj7DiRL+xHUHvBLH3ge+vTpwFxXziF3rVwxkIDtE=;
        b=TeppUjgkYQIzUg0T00G+ClrcKJndqC1uFBYii/evwFe2KY3Ba6lKgbgFj8rP6hSc1s
         Syv+XplWCcHXCALlwLTbqMSGkRioCJBmItcSkWk7j6GY3YtW13H1JbIYpamB9oU0uwOh
         ewuR4pHiy5K1W5qyAudfIFv71ZGehgwevNyfAfB7QafFvZM6lBRIvbWn20FKeRD9QDQm
         BE+TRe2Jph4bvlNXn21z0IqG0Ci+lKJnDt1Xait89wGXFT+Sn3th47vmahOC+J2M5Q6n
         YluO6RJ8RZo7K4usrtzQg4uHadF2L8jqwMawQxw6gxWjCXFfkU9ioKtmVaU6UDRdXxua
         NHxg==
X-Gm-Message-State: ANoB5pnC+oJryhg2hia3YBs/WIshikufWwGiM/6JRRTAmKAIYfja7vav
        SXyrQ66hIlUH/wn2YDcGB1h0g/Eo4fB2
X-Google-Smtp-Source: AA0mqf776vexvsO1Tb9gGLbX7UHKb+p7Y2EiSv6LhHFFKLSdtKbNiPoABCTWkVzGxwPK7DWOmOmCk7rQTWDu
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:b06f:a254:5ce9:c442])
 (user=irogers job=sendgmr) by 2002:a05:6902:728:b0:6dc:6bf7:bde1 with SMTP id
 l8-20020a056902072800b006dc6bf7bde1mr541469ybt.108.1668019797001; Wed, 09 Nov
 2022 10:49:57 -0800 (PST)
Date:   Wed,  9 Nov 2022 10:49:04 -0800
In-Reply-To: <20221109184914.1357295-1-irogers@google.com>
Message-Id: <20221109184914.1357295-5-irogers@google.com>
Mime-Version: 1.0
References: <20221109184914.1357295-1-irogers@google.com>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Subject: [PATCH v2 04/14] perf build: Install libapi locally when building
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        bpf@vger.kernel.org, Nick Desaulniers <ndesaulniers@google.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
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

The perf build currently has a '-Itools/lib' on the CC command
line. This causes issues as the libapi, libsubcmd, libtraceevent,
libbpf headers are all found via this path, making it impossible to
override include behavior. Change the libapi build mirroring the
libbpf and libsubcmd build, so that it is installed in a directory
along with its headers. A later change will modify the include
behavior.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/.gitignore    |  1 +
 tools/perf/Makefile.perf | 27 +++++++++++++++------------
 2 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/tools/perf/.gitignore b/tools/perf/.gitignore
index 626f5dd9a037..1932848343f3 100644
--- a/tools/perf/.gitignore
+++ b/tools/perf/.gitignore
@@ -38,6 +38,7 @@ trace/beauty/generated/
 pmu-events/pmu-events.c
 pmu-events/jevents
 feature/
+libapi/
 libbpf/
 libsubcmd/
 fixdep
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 4ec6b95a1c49..f8c712e26a69 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -241,7 +241,7 @@ sub-make: fixdep
 
 else # force_fixdep
 
-LIB_DIR         = $(srctree)/tools/lib/api/
+LIBAPI_DIR      = $(srctree)/tools/lib/api/
 TRACE_EVENT_DIR = $(srctree)/tools/lib/traceevent/
 LIBBPF_DIR      = $(srctree)/tools/lib/bpf/
 LIBSUBCMD_DIR   = $(srctree)/tools/lib/subcmd/
@@ -295,15 +295,9 @@ ifneq ($(OUTPUT),)
   TE_PATH=$(OUTPUT)
   PLUGINS_PATH=$(OUTPUT)
   LIBPERF_PATH=$(OUTPUT)
-ifneq ($(subdir),)
-  API_PATH=$(OUTPUT)/../lib/api/
-else
-  API_PATH=$(OUTPUT)
-endif
 else
   TE_PATH=$(TRACE_EVENT_DIR)
   PLUGINS_PATH=$(TRACE_EVENT_DIR)plugins/
-  API_PATH=$(LIB_DIR)
   LIBPERF_PATH=$(LIBPERF_DIR)
 endif
 
@@ -318,7 +312,14 @@ LIBTRACEEVENT_DYNAMIC_LIST = $(PLUGINS_PATH)libtraceevent-dynamic-list
 DYNAMIC_LIST_LDFLAGS               = -Xlinker --dynamic-list=$(LIBTRACEEVENT_DYNAMIC_LIST)
 LIBTRACEEVENT_DYNAMIC_LIST_LDFLAGS = $(if $(findstring -static,$(LDFLAGS)),,$(DYNAMIC_LIST_LDFLAGS))
 
-LIBAPI = $(API_PATH)libapi.a
+ifneq ($(OUTPUT),)
+  LIBAPI_OUTPUT = $(abspath $(OUTPUT))/libapi
+else
+  LIBAPI_OUTPUT = $(CURDIR)/libapi
+endif
+LIBAPI_DESTDIR = $(LIBAPI_OUTPUT)
+LIBAPI_INCLUDE = $(LIBAPI_DESTDIR)/include
+LIBAPI = $(LIBAPI_OUTPUT)/libapi.a
 export LIBAPI
 
 ifneq ($(OUTPUT),)
@@ -831,12 +832,14 @@ $(LIBTRACEEVENT)-clean:
 install-traceevent-plugins: libtraceevent_plugins
 	$(Q)$(MAKE) -C $(TRACE_EVENT_DIR) $(LIBTRACEEVENT_FLAGS) O=$(OUTPUT) install_plugins
 
-$(LIBAPI): FORCE
-	$(Q)$(MAKE) -C $(LIB_DIR) O=$(OUTPUT) $(OUTPUT)libapi.a
+$(LIBAPI): FORCE | $(LIBAPI_OUTPUT)
+	$(Q)$(MAKE) -C $(LIBAPI_DIR) O=$(LIBAPI_OUTPUT) \
+		DESTDIR=$(LIBAPI_DESTDIR) prefix= \
+		$@ install_headers
 
 $(LIBAPI)-clean:
 	$(call QUIET_CLEAN, libapi)
-	$(Q)$(MAKE) -C $(LIB_DIR) O=$(OUTPUT) clean >/dev/null
+	$(Q)$(RM) -r -- $(LIBAPI_OUTPUT)
 
 $(LIBBPF): FORCE | $(LIBBPF_OUTPUT)
 	$(Q)$(MAKE) -C $(LIBBPF_DIR) FEATURES_DUMP=$(FEATURE_DUMP_EXPORT) \
@@ -1047,7 +1050,7 @@ SKELETONS += $(SKEL_OUT)/bperf_cgroup.skel.h $(SKEL_OUT)/func_latency.skel.h
 SKELETONS += $(SKEL_OUT)/off_cpu.skel.h $(SKEL_OUT)/lock_contention.skel.h
 SKELETONS += $(SKEL_OUT)/kwork_trace.skel.h
 
-$(SKEL_TMP_OUT) $(LIBBPF_OUTPUT) $(LIBSUBCMD_OUTPUT):
+$(SKEL_TMP_OUT) $(LIBAPI_OUTPUT) $(LIBBPF_OUTPUT) $(LIBSUBCMD_OUTPUT):
 	$(Q)$(MKDIR) -p $@
 
 ifdef BUILD_BPF_SKEL
-- 
2.38.1.431.g37b22c650d-goog

