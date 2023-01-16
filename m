Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98B5F66D129
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 22:58:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233847AbjAPV6M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 16:58:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234608AbjAPV6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 16:58:11 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81967241FB
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 13:58:10 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id mh11-20020a17090b4acb00b002271dde7ec6so4638956pjb.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 13:58:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=B3Ud16zHjfzs1yDtdBOr0IHKeq4LI90N49HbHwsKBVo=;
        b=V/jI1wdMtDH79NoMgvZ02I7d05HtyPtxA6BV0pCpSpsdpG2DNlNXj3whT94SF27JCC
         4aA9HDu6eubdmaggQcRHm1qL5flQNQG3PyKikqi1azVf7tS4zYU5QYAScaCPqIENtpZN
         2GgDi2BtKyE16wMUL1gilrZPBQgEkgYTMfth4nsIjd/YPb5mKTrr78TU4JjM+JxoLr34
         FMKXgxbJVbMnWXb84vSFH6DzER4yV3+EfXnQtB/KDVITzGuaOtKSqXusUKGjPw5Oz8m5
         4U2KZ6+CVG08+hlgrAenltjQsfd07Kl6BMiWykDAV4tkicm83+slZAuvvqYOiwdn0DWy
         FX0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B3Ud16zHjfzs1yDtdBOr0IHKeq4LI90N49HbHwsKBVo=;
        b=1sUgKDvSx9Giu1WSrOzbQTM6gQV26ohxn2x64duZfGwLqHhNjjs8oCkCpBS04QK3ZN
         ZVWsf3CVBBuzFKFYZYGCjGjXBpoe9Uo5Hx/GAB4vGPx9bM4LhsQhiMGqg7bBuQDey+ah
         7/nj6fy9nJYmDnXMqrmdyXfvm7o0qGickI4lhfkXoMxoo5vlNoHIK0TftbeO2ubx30Ua
         URMFMBHhQ0Rwi+KrOabfODeC47zFCAly6PrlC/lclIz6bBh6nkjbs/b4uPeFAFcH9m/J
         V1TSnkCbBp1Uh8mJx8bh62akBhgkSeBBnGcvP/laGH3dF0F2Qqo7ouOGAhaEPbgy3arT
         Ek/A==
X-Gm-Message-State: AFqh2kpa7wr7hE4t3JQHC5gVxwdcUQTTCU0636s+7dzhOVxclquH13ht
        uHb09jIq2wRszdbhThTvk83uPkEcwWgq
X-Google-Smtp-Source: AMrXdXvvJvIY2W81/DG4CZ0ccwL+9tOXxprMa7CzsMAqi6D9IlauqUep6nS4wgBJyB5WpcteaNjgU9PddIx2
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:5088:3695:f3a5:d639])
 (user=irogers job=sendgmr) by 2002:a05:6a00:1c9d:b0:58a:f2e5:db46 with SMTP
 id y29-20020a056a001c9d00b0058af2e5db46mr80189pfw.61.1673906290006; Mon, 16
 Jan 2023 13:58:10 -0800 (PST)
Date:   Mon, 16 Jan 2023 13:57:50 -0800
Message-Id: <20230116215751.633675-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Subject: [PATCH v2 1/2] tools/resolve_btfids: Install subcmd headers
From:   Ian Rogers <irogers@google.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Connor OBrien <connoro@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
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

Previously tools/lib/subcmd was added to the include path, switch to
installing the headers and then including from that directory. This
avoids dependencies on headers internal to tools/lib/subcmd. Add the
missing subcmd directory to the affected #include.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/bpf/resolve_btfids/Makefile | 19 ++++++++++++++-----
 tools/bpf/resolve_btfids/main.c   |  2 +-
 2 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/tools/bpf/resolve_btfids/Makefile b/tools/bpf/resolve_btfids/Makefile
index 19a3112e271a..76b737b2560d 100644
--- a/tools/bpf/resolve_btfids/Makefile
+++ b/tools/bpf/resolve_btfids/Makefile
@@ -35,21 +35,29 @@ SUBCMD_SRC := $(srctree)/tools/lib/subcmd/
 BPFOBJ     := $(OUTPUT)/libbpf/libbpf.a
 LIBBPF_OUT := $(abspath $(dir $(BPFOBJ)))/
 SUBCMDOBJ  := $(OUTPUT)/libsubcmd/libsubcmd.a
+SUBCMD_OUT := $(abspath $(dir $(SUBCMDOBJ)))/
 
 LIBBPF_DESTDIR := $(LIBBPF_OUT)
 LIBBPF_INCLUDE := $(LIBBPF_DESTDIR)include
 
+SUBCMD_DESTDIR := $(SUBCMD_OUT)
+SUBCMD_INCLUDE := $(SUBCMD_DESTDIR)include
+
 BINARY     := $(OUTPUT)/resolve_btfids
 BINARY_IN  := $(BINARY)-in.o
 
 all: $(BINARY)
 
+prepare: $(BPFOBJ) $(SUBCMDOBJ)
+
 $(OUTPUT) $(OUTPUT)/libsubcmd $(LIBBPF_OUT):
 	$(call msg,MKDIR,,$@)
 	$(Q)mkdir -p $(@)
 
 $(SUBCMDOBJ): fixdep FORCE | $(OUTPUT)/libsubcmd
-	$(Q)$(MAKE) -C $(SUBCMD_SRC) OUTPUT=$(abspath $(dir $@))/ $(abspath $@)
+	$(Q)$(MAKE) -C $(SUBCMD_SRC) OUTPUT=$(SUBCMD_OUT) \
+		    DESTDIR=$(SUBCMD_DESTDIR) prefix= \
+		    $(abspath $@) install_headers
 
 $(BPFOBJ): $(wildcard $(LIBBPF_SRC)/*.[ch] $(LIBBPF_SRC)/Makefile) | $(LIBBPF_OUT)
 	$(Q)$(MAKE) $(submake_extras) -C $(LIBBPF_SRC) OUTPUT=$(LIBBPF_OUT)    \
@@ -60,14 +68,14 @@ CFLAGS += -g \
           -I$(srctree)/tools/include \
           -I$(srctree)/tools/include/uapi \
           -I$(LIBBPF_INCLUDE) \
-          -I$(SUBCMD_SRC)
+          -I$(SUBCMD_INCLUDE)
 
 LIBS = -lelf -lz
 
 export srctree OUTPUT CFLAGS Q
 include $(srctree)/tools/build/Makefile.include
 
-$(BINARY_IN): $(BPFOBJ) fixdep FORCE | $(OUTPUT)
+$(BINARY_IN): fixdep FORCE prepare | $(OUTPUT)
 	$(Q)$(MAKE) $(build)=resolve_btfids
 
 $(BINARY): $(BPFOBJ) $(SUBCMDOBJ) $(BINARY_IN)
@@ -79,7 +87,8 @@ clean_objects := $(wildcard $(OUTPUT)/*.o                \
                             $(OUTPUT)/.*.o.d             \
                             $(LIBBPF_OUT)                \
                             $(LIBBPF_DESTDIR)            \
-                            $(OUTPUT)/libsubcmd          \
+                            $(SUBCMD_OUT)                \
+                            $(SUBCMD_DESTDIR)            \
                             $(OUTPUT)/resolve_btfids)
 
 ifneq ($(clean_objects),)
@@ -96,4 +105,4 @@ tags:
 
 FORCE:
 
-.PHONY: all FORCE clean tags
+.PHONY: all FORCE clean tags prepare
diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/main.c
index 80cd7843c677..77058174082d 100644
--- a/tools/bpf/resolve_btfids/main.c
+++ b/tools/bpf/resolve_btfids/main.c
@@ -75,7 +75,7 @@
 #include <linux/err.h>
 #include <bpf/btf.h>
 #include <bpf/libbpf.h>
-#include <parse-options.h>
+#include <subcmd/parse-options.h>
 
 #define BTF_IDS_SECTION	".BTF_ids"
 #define BTF_ID		"__BTF_ID__"
-- 
2.39.0.314.g84b9a713c41-goog

