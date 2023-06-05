Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF0EE72315E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 22:28:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232807AbjFEU2V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 16:28:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232654AbjFEU2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 16:28:18 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0634FF3
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 13:28:16 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-bacfa4eefcbso11567096276.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jun 2023 13:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685996895; x=1688588895;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hLjmrLz/hP83JFzqDViYQdWWK3BpFSisxk7JtaBYtgg=;
        b=JHcO2nxCY2NmHNHp9sTdROmKWR1yNZtWwu+HuzoIiIxKt+rIf3XD/ppPXvvTVddP9c
         YTAvGVjQaHXu/HPhqavbA4wROH/ilyQO0nSTVoNl0qvdKR6Ma6pEHhfHLJE6vl802xrb
         Sq0Nywm+xWoK0daLtzTU+LujMtdTSDnqtK/6mVceapvhF44yEPovNeDJl8ihmTqvkU12
         yjnLYnywjjfov4E+eFG0xjnfzWx2VJqr255zwq71Iv61hl9DEKfenKkW6nZ9QGVtmu9+
         uTEynVv4SjIOW1pILgMPp65Le858DcvSmINsnpJKvFP2tnk9RJOl5Cc30DiLWkBEomm8
         f6tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685996895; x=1688588895;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hLjmrLz/hP83JFzqDViYQdWWK3BpFSisxk7JtaBYtgg=;
        b=goCEvf+8K1crkjPc2k+uxrBPpC35dK8EA0yPkxYs66QZudYakiZ/dL4LGe5frjlwAh
         z8gIw60RRGxOBvUkDMIja/meesT8r1kSsWDAKxZurffs6mlxK91aMLHHGMTfB0zICdpM
         q2yE2P/ExaCnK55+AZ9lUsl2gXPJu9dMJnKeo5qBQz3k4CgmvI0z/0ZFdjl59QBJa9Sv
         D3eZSth30onjpeDnK+mVtHv8DiDWbdiZQyjfW05bHlRZDs5p9YQGOdqzQhr8EBwTsPsF
         frOhH37OBq1VrYm5mJbwwh8yHWrcGWXAD2zdCPfnalTpZE97c8TfVqpepZ3MXC1kS5u3
         glrw==
X-Gm-Message-State: AC+VfDx1kHmfSk70IvMrXiGae1qwNPwtR+WSYhVv9tc6vLbEvIbC0Wry
        r96+Kg3UE2xdmfxtaRtsxunOe1EMsGIt
X-Google-Smtp-Source: ACHHUZ5PZa7BZYmMZzeOqH54Srg4/kt01xsgYTP9dOMIjyql6sSCb+sB1HON6zg2g6KNg0/5AxMS70NaMXQT
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:bed9:39b9:3df1:2828])
 (user=irogers job=sendgmr) by 2002:a25:b7ce:0:b0:bb1:569c:f381 with SMTP id
 u14-20020a25b7ce000000b00bb1569cf381mr88075ybj.1.1685996895273; Mon, 05 Jun
 2023 13:28:15 -0700 (PDT)
Date:   Mon,  5 Jun 2023 13:27:09 -0700
In-Reply-To: <20230605202712.1690876-1-irogers@google.com>
Message-Id: <20230605202712.1690876-2-irogers@google.com>
Mime-Version: 1.0
References: <20230605202712.1690876-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Subject: [PATCH v2 1/4] perf build: Add ability to build with a generated vmlinux.h
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
---
 tools/perf/Makefile.config                       |  4 ++++
 tools/perf/Makefile.perf                         | 16 +++++++++++++++-
 tools/perf/util/bpf_skel/.gitignore              |  1 +
 tools/perf/util/bpf_skel/{ => vmlinux}/vmlinux.h |  0
 4 files changed, 20 insertions(+), 1 deletion(-)
 rename tools/perf/util/bpf_skel/{ => vmlinux}/vmlinux.h (100%)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index a794d9eca93d..08d4e7eaa721 100644
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
index f48794816d82..f1840af195c0 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -1080,7 +1080,21 @@ $(BPFTOOL): | $(SKEL_TMP_OUT)
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
2.41.0.rc0.172.g3f132b7071-goog

