Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 647976232F5
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 19:50:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231685AbiKISuU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 13:50:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbiKISuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 13:50:08 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A249215A37
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 10:50:06 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id h4-20020a5b02c4000000b006bc192d672bso17634853ybp.22
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 10:50:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=eFNI6w+UKBLfbnLBHtzzqBJiAuVx/AtWIkrQTsC6Hro=;
        b=h4lvMtCWCTVDSELj55kvnLQCb5oBnzuw+M44Y5aAWbANhizAyyFGC5rZAM4Hiupzs4
         akW+s1CKqsMLyjphDV7Ul84LU+H8Z5lPTX79adM/XnfUv/DknPbANTP7m8SJknpuh6xm
         w5ehaf5zMMBp/J+oUPdrUXcHrUfCwHV178BIQUOKi9gD1iF5HtggNPCHT3Xks6QppIW7
         Mk0bgcm7LdrNTUdUcAJuOItFPmEgj5ZI2Pizmpoy9xE0DSH7f+GoUoo3C6iBLTnz5Yd2
         l7qZOCzjNAsZfeJrGt54wiZ1Kzot4TIlTq0KUfnGU2RUXCR2fIpkmzMTyfMgNg/Tc7tl
         0CHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eFNI6w+UKBLfbnLBHtzzqBJiAuVx/AtWIkrQTsC6Hro=;
        b=GrheaSY/CddqI6uU3iKAm2zkUL35XvE2myE+NfkPQMMnPuhtcmkjuH022NvnRIOXbh
         6HXpa958ukBOGyQ7Hjv8A6BDgCBULIR8FP+ZsA0YdQRqFZ+n1sn8PLeE7r7XObkeTiKY
         hZOIAcHndUixAS8FQpNdYz4DG17erqutrmiXzytN3U+GJmCQb1gSrYwZV9RI6r87S3H1
         ZiOv5mQ2dyF4ltu7KasRfiO29F8wfVTk5xUGKNL17WEzjsxswC3DhG0xIRIGthbOErmL
         s1ICv31iV4V7Z9rsW07ObHxVkuMU7VtlraXqf8AhHa9LR34snTcCYS2LJq0cVuKO0ERe
         8UBw==
X-Gm-Message-State: ANoB5pnieW36fyXE5zG6J3udM3lTGJETBLtnHXJXhFtx4dhh1klJL9ec
        53lhxhfUl2q2PWA5fju4NodV1zNVkxvr
X-Google-Smtp-Source: AA0mqf4GLV/l6ulLOIZSMSZlFM/5nQe7KSUuCKe+SvRL2TfnLFFNBQnTLggBQ+/D+c95KTFqgTlDhOO8PXiA
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:b06f:a254:5ce9:c442])
 (user=irogers job=sendgmr) by 2002:a25:ce51:0:b0:6da:635e:2071 with SMTP id
 x78-20020a25ce51000000b006da635e2071mr6748633ybe.54.1668019805933; Wed, 09
 Nov 2022 10:50:05 -0800 (PST)
Date:   Wed,  9 Nov 2022 10:49:05 -0800
In-Reply-To: <20221109184914.1357295-1-irogers@google.com>
Message-Id: <20221109184914.1357295-6-irogers@google.com>
Mime-Version: 1.0
References: <20221109184914.1357295-1-irogers@google.com>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Subject: [PATCH v2 05/14] perf build: Install libperf locally when building
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
override include behavior. Change the libperf build mirroring the
libbpf, libsubcmd and libapi build, so that it is installed in a
directory along with its headers. A later change will modify the
include behavior.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/.gitignore    |  1 +
 tools/perf/Makefile.perf | 21 ++++++++++++++-------
 2 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/tools/perf/.gitignore b/tools/perf/.gitignore
index 1932848343f3..43f6621ef05e 100644
--- a/tools/perf/.gitignore
+++ b/tools/perf/.gitignore
@@ -40,6 +40,7 @@ pmu-events/jevents
 feature/
 libapi/
 libbpf/
+libperf/
 libsubcmd/
 fixdep
 libtraceevent-dynamic-list
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index f8c712e26a69..57aec5a97270 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -294,11 +294,9 @@ strip-libs = $(filter-out -l%,$(1))
 ifneq ($(OUTPUT),)
   TE_PATH=$(OUTPUT)
   PLUGINS_PATH=$(OUTPUT)
-  LIBPERF_PATH=$(OUTPUT)
 else
   TE_PATH=$(TRACE_EVENT_DIR)
   PLUGINS_PATH=$(TRACE_EVENT_DIR)plugins/
-  LIBPERF_PATH=$(LIBPERF_DIR)
 endif
 
 LIBTRACEEVENT = $(TE_PATH)libtraceevent.a
@@ -340,7 +338,14 @@ LIBSUBCMD_DESTDIR = $(LIBSUBCMD_OUTPUT)
 LIBSUBCMD_INCLUDE = $(LIBSUBCMD_DESTDIR)/include
 LIBSUBCMD = $(LIBSUBCMD_OUTPUT)/libsubcmd.a
 
-LIBPERF = $(LIBPERF_PATH)libperf.a
+ifneq ($(OUTPUT),)
+  LIBPERF_OUTPUT = $(abspath $(OUTPUT))/libperf
+else
+  LIBPERF_OUTPUT = $(CURDIR)/libperf
+endif
+LIBPERF_DESTDIR = $(LIBPERF_OUTPUT)
+LIBPERF_INCLUDE = $(LIBPERF_DESTDIR)/include
+LIBPERF = $(LIBPERF_OUTPUT)/libperf.a
 export LIBPERF
 
 # python extension build directories
@@ -850,12 +855,14 @@ $(LIBBPF)-clean:
 	$(call QUIET_CLEAN, libbpf)
 	$(Q)$(RM) -r -- $(LIBBPF_OUTPUT)
 
-$(LIBPERF): FORCE
-	$(Q)$(MAKE) -C $(LIBPERF_DIR) EXTRA_CFLAGS="$(LIBPERF_CFLAGS)" O=$(OUTPUT) $(OUTPUT)libperf.a
+$(LIBPERF): FORCE | $(LIBPERF_OUTPUT)
+	$(Q)$(MAKE) -C $(LIBPERF_DIR) O=$(LIBPERF_OUTPUT) \
+		DESTDIR=$(LIBPERF_DESTDIR) prefix= \
+		$@ install_headers
 
 $(LIBPERF)-clean:
 	$(call QUIET_CLEAN, libperf)
-	$(Q)$(MAKE) -C $(LIBPERF_DIR) O=$(OUTPUT) clean >/dev/null
+	$(Q)$(RM) -r -- $(LIBPERF_OUTPUT)
 
 $(LIBSUBCMD): FORCE | $(LIBSUBCMD_OUTPUT)
 	$(Q)$(MAKE) -C $(LIBSUBCMD_DIR) O=$(LIBSUBCMD_OUTPUT) \
@@ -1050,7 +1057,7 @@ SKELETONS += $(SKEL_OUT)/bperf_cgroup.skel.h $(SKEL_OUT)/func_latency.skel.h
 SKELETONS += $(SKEL_OUT)/off_cpu.skel.h $(SKEL_OUT)/lock_contention.skel.h
 SKELETONS += $(SKEL_OUT)/kwork_trace.skel.h
 
-$(SKEL_TMP_OUT) $(LIBAPI_OUTPUT) $(LIBBPF_OUTPUT) $(LIBSUBCMD_OUTPUT):
+$(SKEL_TMP_OUT) $(LIBAPI_OUTPUT) $(LIBBPF_OUTPUT) $(LIBPERF_OUTPUT) $(LIBSUBCMD_OUTPUT):
 	$(Q)$(MKDIR) -p $@
 
 ifdef BUILD_BPF_SKEL
-- 
2.38.1.431.g37b22c650d-goog

