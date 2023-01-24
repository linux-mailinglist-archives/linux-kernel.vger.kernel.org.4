Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 862BD679132
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 07:43:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232889AbjAXGnj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 01:43:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231772AbjAXGnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 01:43:37 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D9432BF0E
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 22:43:36 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id r8-20020a252b08000000b007b989d5e105so15405551ybr.11
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 22:43:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OrTgrRLylW19wsfnugIU2K6YrtxXGRZd048ZOU/pB04=;
        b=pGDB8zVceKFlAS71Zz2UIMzSTQ4gkNUHMXGEOOgIEFvWN0QfHGKR1EV33cVWAkWQjG
         woDMqzbLFCY1E6XDLMmnBI8JsnCKPKPe7xTszD9MYDJHzAQlYwSOrNHCHirqLCQ3XU8+
         eCogsW/0aUEBQdO048bEyFvtiyWf589/HKoMeunnD/cqQOWpFkohB0DCWwvJcJn99SmB
         FKFQl98vRJxPkJ4BG/3UqE9ggBKNZXP44erXVR/8H6dmdGQYQn/61LsfLWhgnkyq5Dxn
         R3HWjl+s6baDiEDgWU0SJ6bqr41FZZ2rV8v+w1CV0kL1mSgTnWXbKHpwuAIu2xjbugpu
         wNbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OrTgrRLylW19wsfnugIU2K6YrtxXGRZd048ZOU/pB04=;
        b=jjVejQmdHDoKF7SV8tsZ5cq/Yq3rHSrOGH+A5RgEgyyZUCEffzvFZ4Pg6sSowBcQe6
         eDtWIUYYalfm/ij1gpfLuu9qyeBPB2lVAX2jXO1T+I7R3qBnctzvIFRk5WQmNooEURL5
         URgKo5UMxFSvsDL0S+vHcp3XWBh3jJPznj2q6rDxWHG16mVyeeR0Hira780qn1GY27fB
         wmvKsykxn66wb2AI1rWOQgCjLoob9MZcmOkSXwQGQmeMA35Zmefhpwc9K9r4Nrmk6Zay
         cyZThtg9TuCGWrM4g98TXcAgLfqKorVyzZBRRjpHrz0DuHy8cuiQXSHJ/E/szII6tF+N
         r9CA==
X-Gm-Message-State: AFqh2krg6WphWj5EeFjNP9OwlOMgrHAra4j/Sn6FWPZLFqTUfgO/3RUv
        sLv8yVNSI8bu/tR9SWSUWo/NkruMydHg
X-Google-Smtp-Source: AMrXdXu7sfn5ygCbiyFGXP1ACqzBFw2leq+yHhsBrzUhl/zVPTuZ0/Vo0X3uKu3r8+1yk07nvO3wXfbK21H4
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:460d:1b4a:acb8:ae9a])
 (user=irogers job=sendgmr) by 2002:a81:7307:0:b0:464:4ea1:3baa with SMTP id
 o7-20020a817307000000b004644ea13baamr2791679ywc.302.1674542615810; Mon, 23
 Jan 2023 22:43:35 -0800 (PST)
Date:   Mon, 23 Jan 2023 22:43:23 -0800
Message-Id: <20230124064324.672022-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.0.246.g2a6d74b583-goog
Subject: [PATCH v4 1/2] tools/resolve_btfids: Install subcmd headers
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
index f7375a119f54..1fe0082b2ecc 100644
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
@@ -63,7 +71,7 @@ CFLAGS += -g \
           -I$(srctree)/tools/include \
           -I$(srctree)/tools/include/uapi \
           -I$(LIBBPF_INCLUDE) \
-          -I$(SUBCMD_SRC) \
+          -I$(SUBCMD_INCLUDE) \
           $(LIBELF_FLAGS)
 
 LIBS = $(LIBELF_LIBS) -lz
@@ -71,7 +79,7 @@ LIBS = $(LIBELF_LIBS) -lz
 export srctree OUTPUT CFLAGS Q
 include $(srctree)/tools/build/Makefile.include
 
-$(BINARY_IN): $(BPFOBJ) fixdep FORCE | $(OUTPUT)
+$(BINARY_IN): fixdep FORCE prepare | $(OUTPUT)
 	$(Q)$(MAKE) $(build)=resolve_btfids
 
 $(BINARY): $(BPFOBJ) $(SUBCMDOBJ) $(BINARY_IN)
@@ -83,7 +91,8 @@ clean_objects := $(wildcard $(OUTPUT)/*.o                \
                             $(OUTPUT)/.*.o.d             \
                             $(LIBBPF_OUT)                \
                             $(LIBBPF_DESTDIR)            \
-                            $(OUTPUT)/libsubcmd          \
+                            $(SUBCMD_OUT)                \
+                            $(SUBCMD_DESTDIR)            \
                             $(OUTPUT)/resolve_btfids)
 
 ifneq ($(clean_objects),)
@@ -100,4 +109,4 @@ tags:
 
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
2.39.0.246.g2a6d74b583-goog

