Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DF5E73AF4D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 06:14:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230117AbjFWEOa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 00:14:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231383AbjFWEOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 00:14:23 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2AF72680
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 21:14:16 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-bd69ee0edacso340563276.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 21:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687493656; x=1690085656;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kRjGCz+vF43be6o3RIYGWYVIHqnGB09+FQ0CjWlIPEs=;
        b=msdMif6qPhE2iTBGvdqWZxlRMxkK5Elh3z1GXHL9DYY+WMqkmnw2j0sAf56zvtJ2TY
         15t2Ak700ZiSxEOd73G3IoCjXmQkaxTlgD15dupw2qMwHDfy0txlFWB/JbXIamBGLatp
         XSYUYijies3Xe5m3TNUwaQMof0zpElQvaWuodA7q/2uwsYI+yWoQRFpPmHABc3YE0Jyh
         Ttq1Z6zj7c7x28R75vYVb6pUEZmm707Uu8elYlLpMAyjD67pPiv0HbckIvoa7ZWDOnPA
         kMGax168qSbSuOC8sEnrWB8IlAQM0svs8vpXxL9ToA9c2x/oaHhnjNLvCBdu98eLERIC
         EO0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687493656; x=1690085656;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kRjGCz+vF43be6o3RIYGWYVIHqnGB09+FQ0CjWlIPEs=;
        b=NfkqT/qdymkSj2N7Ak+dZ7V9XKihnQIYSxS9FpMETGDVq0BFXDyG0z95CmzYGG14qd
         lUzg5DGmCcRVMkVMspNkeNyHbZTAISu8vg+3aQ/JFRnB1obN5D5caV0yVRJ32JAkqWzI
         ST4LKhS58grKa4WtnI54mt0ETAuwuaGSpnpl9O/m/IesiY8ytLQEkedGWmdgG3ZVsJZ+
         8j6D4sYlD2De+S1mIabkbg7Ts0foXf2JutSPR2VSzFjgfqdMAA1IMgcK+NWLg46gqDjY
         18lIrh4DEQceGMiZ8LXY6A6yW5CnGWEstV9s+G7uL04TuU62KiHbVphWJo3QIp3eQ+Uw
         QNCw==
X-Gm-Message-State: AC+VfDxmYV1Phc3sWKFBDWO8bStRvdNauSHgOsQ9dp2ACLnIhuHl81Ap
        mrQDzfjl8cKNDiu2CdQALSeo0WlJfDYc
X-Google-Smtp-Source: ACHHUZ7WU1tLGytanZMY0tt3kI63tE5Jq1LDbc0rRr7GIdXT+9clhw8zJw3ToBf/oHi7gvJ51UL2+ynHuWa6
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:6559:8968:cdfe:35b6])
 (user=irogers job=sendgmr) by 2002:a5b:88e:0:b0:be3:f84b:5aa with SMTP id
 e14-20020a5b088e000000b00be3f84b05aamr8962507ybq.6.1687493655925; Thu, 22 Jun
 2023 21:14:15 -0700 (PDT)
Date:   Thu, 22 Jun 2023 21:14:02 -0700
In-Reply-To: <20230623041405.4039475-1-irogers@google.com>
Message-Id: <20230623041405.4039475-2-irogers@google.com>
Mime-Version: 1.0
References: <20230623041405.4039475-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Subject: [PATCH v4 1/4] perf build: Add ability to build with a generated vmlinux.h
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
        James Clark <james.clark@arm.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Yang Jihong <yangjihong1@huawei.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit a887466562b4 ("perf bpf skels: Stop using vmlinux.h generated
from BTF, use subset of used structs + CO-RE") made it so that
vmlinux.h was uncondtionally included from
tools/perf/util/vmlinux.h. This change reverts part of that change (so
that vmlinux.h is once again generated) and makes it so that the
vmlinux.h used at build time is selected from the VMLINUX_H
variable. By default the VMLINUX_H variable is set to the vmlinux.h
added in change a887466562b4, but if GEN_VMLINUX_H=1 is passed on the
build command line then the previous generation behavior kicks in.

The build with GEN_VMLINUX_H=1 currently fails with:
```
util/bpf_skel/lock_contention.bpf.c:419:8: error: redefinition of 'rq'
struct rq {};
       ^
/tmp/perf/util/bpf_skel/.tmp/../vmlinux.h:45630:8: note: previous definition is here
struct rq {
       ^
1 error generated.
```

Signed-off-by: Ian Rogers <irogers@google.com>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Acked-by: Namhyung Kim <namhyung@kernel.org>
Acked-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/Makefile.config                       |  4 ++++
 tools/perf/Makefile.perf                         | 16 +++++++++++++++-
 tools/perf/util/bpf_skel/.gitignore              |  1 +
 tools/perf/util/bpf_skel/{ => vmlinux}/vmlinux.h |  0
 4 files changed, 20 insertions(+), 1 deletion(-)
 rename tools/perf/util/bpf_skel/{ => vmlinux}/vmlinux.h (100%)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 9c5aa14a44cf..78411252b72a 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -680,6 +680,10 @@ ifdef BUILD_BPF_SKEL
   CFLAGS += -DHAVE_BPF_SKEL
 endif
 
+ifndef GEN_VMLINUX_H
+  VMLINUX_H=$(src-perf)/util/bpf_skel/vmlinux/vmlinux.h
+endif
+
 dwarf-post-unwind := 1
 dwarf-post-unwind-text := BUG
 
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index b1e62a621f92..80d772cc5fcb 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -1084,7 +1084,21 @@ $(BPFTOOL): | $(SKEL_TMP_OUT)
 	$(Q)CFLAGS= $(MAKE) -C ../bpf/bpftool \
 		OUTPUT=$(SKEL_TMP_OUT)/ bootstrap
 
-$(SKEL_TMP_OUT)/%.bpf.o: util/bpf_skel/%.bpf.c $(LIBBPF) | $(SKEL_TMP_OUT)
+VMLINUX_BTF_PATHS ?= $(if $(O),$(O)/vmlinux)				\
+		     $(if $(KBUILD_OUTPUT),$(KBUILD_OUTPUT)/vmlinux)	\
+		     ../../vmlinux					\
+		     /sys/kernel/btf/vmlinux				\
+		     /boot/vmlinux-$(shell uname -r)
+VMLINUX_BTF ?= $(abspath $(firstword $(wildcard $(VMLINUX_BTF_PATHS))))
+
+$(SKEL_OUT)/vmlinux.h: $(VMLINUX_BTF) $(BPFTOOL)
+ifeq ($(VMLINUX_H),)
+	$(QUIET_GEN)$(BPFTOOL) btf dump file $< format c > $@
+else
+	$(Q)cp "$(VMLINUX_H)" $@
+endif
+
+$(SKEL_TMP_OUT)/%.bpf.o: util/bpf_skel/%.bpf.c $(LIBBPF) $(SKEL_OUT)/vmlinux.h | $(SKEL_TMP_OUT)
 	$(QUIET_CLANG)$(CLANG) -g -O2 -target bpf -Wall -Werror $(BPF_INCLUDE) $(TOOLS_UAPI_INCLUDE) \
 	  -c $(filter util/bpf_skel/%.bpf.c,$^) -o $@
 
diff --git a/tools/perf/util/bpf_skel/.gitignore b/tools/perf/util/bpf_skel/.gitignore
index 7a1c832825de..cd01455e1b53 100644
--- a/tools/perf/util/bpf_skel/.gitignore
+++ b/tools/perf/util/bpf_skel/.gitignore
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
 .tmp
 *.skel.h
+vmlinux.h
diff --git a/tools/perf/util/bpf_skel/vmlinux.h b/tools/perf/util/bpf_skel/vmlinux/vmlinux.h
similarity index 100%
rename from tools/perf/util/bpf_skel/vmlinux.h
rename to tools/perf/util/bpf_skel/vmlinux/vmlinux.h
-- 
2.41.0.162.gfafddb0af9-goog

