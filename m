Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B79C2620A41
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 08:36:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233572AbiKHHgA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 02:36:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233554AbiKHHfy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 02:35:54 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86E431A80F
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 23:35:53 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-373569200ceso129652997b3.4
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 23:35:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=57Nc0nVeI1H4spNvFUvS/ZHB5odm1OzqWBvubdS35Rg=;
        b=q1y7M8F08KFmisImxwXGLfMu9zHVFtWByAk6fY0quima6z576qB4XY5GWJeV1hqTTG
         K+Wpk+IPOEcV7vLl0oyzVpLLTTyVlXmrqGjWTd/YinO15aoSV++Fm6AUmS/E2KPfTLaP
         nQZ/6FKa4CdoUNyDdhqW/9HlxIie2JBKTCG6cFzmP5dHOWAtBHYFjD2yNXHK0zfQNTPa
         SA+p+NRz7Ht7CRS7vYvEaqF07TfM1Nn8HYOFyG14oxNpVobENZYu2ewlD1+/8LpJIFeB
         YEg1VFd9TEU7cO3ZWi0LMjGmwYIsXc1kLKA47qelaEKgiDdVnsheHSdC7kXtBXqa2C6Z
         EnqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=57Nc0nVeI1H4spNvFUvS/ZHB5odm1OzqWBvubdS35Rg=;
        b=ZaEwc+P/yBCYgojuCAezyxfMX5XNr7kvLAAfUZsUADkG2BVlf6EQRwvl25m0qb5Rvb
         ZpySbZ8Y9W4dyqOkEjmpwpWl9zoQrl4RH5zSHTAAM2B+KsbivQtZhT+C7VhLn4tqIGkX
         QLUrnf2wK1RL9OOnvgTHodj9AXM5VwDRRHM2ixIO83mobK538uUmUPe85xKlXeOeBgV8
         zFpYsgLGwPyiRihzNYuhyvsr8fdeVYGPW8PN8Qax8pAheBpQKbDWNXoOTK5x1otbGjmM
         348eAaSu0xEHyFIsA4+TyTZpd4TDgvmqXiBtlqPzn2Hq16oa3dPTNF2G7eMkkSadVleC
         hGvw==
X-Gm-Message-State: ANoB5pkH9rB7THySWO4Ytx93qG+pawyqceO0WI0F68zozw8D410CbR5L
        bYu5MOSWRKVNIH/TwN7dmbGKXOSbjid2
X-Google-Smtp-Source: AA0mqf6Bo6YtDoVFCO70P0M19csP9p8AcvRav/ZUnhyUv/E1pmb2Y2wo0CcPgiGhiWxCzP1tvcwkDCM0+xhP
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:a697:9013:186f:ed07])
 (user=irogers job=sendgmr) by 2002:a05:6902:1208:b0:6d4:a2f7:44e0 with SMTP
 id s8-20020a056902120800b006d4a2f744e0mr16782234ybu.633.1667892952783; Mon,
 07 Nov 2022 23:35:52 -0800 (PST)
Date:   Mon,  7 Nov 2022 23:35:07 -0800
In-Reply-To: <20221108073518.1154450-1-irogers@google.com>
Message-Id: <20221108073518.1154450-4-irogers@google.com>
Mime-Version: 1.0
References: <20221108073518.1154450-1-irogers@google.com>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Subject: [PATCH v1 03/14] perf build: Install libsubcmd locally when building
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
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The perf build currently has a '-Itools/lib' on the CC command
line. This causes issues as the libapi, libsubcmd, libtraceevent,
libbpf headers are all found via this path, making it impossible to
override include behavior. Change the libsubcmd build mirroring the
libbpf build, so that it is installed in a directory along with its
headers. A later change will modify the include behavior.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/.gitignore    |  1 +
 tools/perf/Makefile.perf | 24 ++++++++++++++++--------
 2 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/tools/perf/.gitignore b/tools/perf/.gitignore
index a653311d9693..626f5dd9a037 100644
--- a/tools/perf/.gitignore
+++ b/tools/perf/.gitignore
@@ -39,6 +39,7 @@ pmu-events/pmu-events.c
 pmu-events/jevents
 feature/
 libbpf/
+libsubcmd/
 fixdep
 libtraceevent-dynamic-list
 Documentation/doc.dep
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index a432e59afc42..af62c6b9ed7a 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -244,7 +244,7 @@ else # force_fixdep
 LIB_DIR         = $(srctree)/tools/lib/api/
 TRACE_EVENT_DIR = $(srctree)/tools/lib/traceevent/
 LIBBPF_DIR      = $(srctree)/tools/lib/bpf/
-SUBCMD_DIR      = $(srctree)/tools/lib/subcmd/
+LIBSUBCMD_DIR   = $(srctree)/tools/lib/subcmd/
 LIBPERF_DIR     = $(srctree)/tools/lib/perf/
 DOC_DIR         = $(srctree)/tools/perf/Documentation/
 
@@ -294,7 +294,6 @@ strip-libs = $(filter-out -l%,$(1))
 ifneq ($(OUTPUT),)
   TE_PATH=$(OUTPUT)
   PLUGINS_PATH=$(OUTPUT)
-  SUBCMD_PATH=$(OUTPUT)
   LIBPERF_PATH=$(OUTPUT)
 ifneq ($(subdir),)
   API_PATH=$(OUTPUT)/../lib/api/
@@ -305,7 +304,6 @@ else
   TE_PATH=$(TRACE_EVENT_DIR)
   PLUGINS_PATH=$(TRACE_EVENT_DIR)plugins/
   API_PATH=$(LIB_DIR)
-  SUBCMD_PATH=$(SUBCMD_DIR)
   LIBPERF_PATH=$(LIBPERF_DIR)
 endif
 
@@ -332,7 +330,14 @@ LIBBPF_DESTDIR = $(LIBBPF_OUTPUT)
 LIBBPF_INCLUDE = $(LIBBPF_DESTDIR)/include
 LIBBPF = $(LIBBPF_OUTPUT)/libbpf.a
 
-LIBSUBCMD = $(SUBCMD_PATH)libsubcmd.a
+ifneq ($(OUTPUT),)
+  LIBSUBCMD_OUTPUT = $(abspath $(OUTPUT))/libsubcmd
+else
+  LIBSUBCMD_OUTPUT = $(CURDIR)/libsubcmd
+endif
+LIBSUBCMD_DESTDIR = $(LIBSUBCMD_OUTPUT)
+LIBSUBCMD_INCLUDE = $(LIBSUBCMD_DESTDIR)/include
+LIBSUBCMD = $(LIBSUBCMD_OUTPUT)/libsubcmd.a
 
 LIBPERF = $(LIBPERF_PATH)libperf.a
 export LIBPERF
@@ -849,11 +854,14 @@ $(LIBPERF)-clean:
 	$(call QUIET_CLEAN, libperf)
 	$(Q)$(MAKE) -C $(LIBPERF_DIR) O=$(OUTPUT) clean >/dev/null
 
-$(LIBSUBCMD): FORCE
-	$(Q)$(MAKE) -C $(SUBCMD_DIR) O=$(OUTPUT) $(OUTPUT)libsubcmd.a
+$(LIBSUBCMD): FORCE | $(LIBSUBCMD_OUTPUT)
+	$(Q)$(MAKE) -C $(LIBSUBCMD_DIR) O=$(LIBSUBCMD_OUTPUT) \
+		DESTDIR=$(LIBSUBCMD_DESTDIR) prefix= \
+		$@ install_headers
 
 $(LIBSUBCMD)-clean:
-	$(Q)$(MAKE) -C $(SUBCMD_DIR) O=$(OUTPUT) clean
+	$(call QUIET_CLEAN, libsubcmd)
+	$(Q)$(RM) -r -- $(LIBSUBCMD_OUTPUT)
 
 help:
 	@echo 'Perf make targets:'
@@ -1044,7 +1052,7 @@ SKELETONS += $(SKEL_OUT)/bperf_cgroup.skel.h $(SKEL_OUT)/func_latency.skel.h
 SKELETONS += $(SKEL_OUT)/off_cpu.skel.h $(SKEL_OUT)/lock_contention.skel.h
 SKELETONS += $(SKEL_OUT)/kwork_trace.skel.h
 
-$(SKEL_TMP_OUT) $(LIBBPF_OUTPUT):
+$(SKEL_TMP_OUT) $(LIBBPF_OUTPUT) $(LIBSUBCMD_OUTPUT):
 	$(Q)$(MKDIR) -p $@
 
 ifdef BUILD_BPF_SKEL
-- 
2.38.1.431.g37b22c650d-goog

