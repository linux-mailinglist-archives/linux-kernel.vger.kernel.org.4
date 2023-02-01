Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAB6E685CDB
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 02:50:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231476AbjBABug (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 20:50:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231433AbjBABue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 20:50:34 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F27BD19F0D
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 17:50:32 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5063c0b909eso183713537b3.7
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 17:50:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xdDlsYqmeKUXi1m/okS37mLJa+8YvjWUBaTgXlbztPE=;
        b=NjDYjH9h61xsRUkP1cMK6GH/YJOE/Ugf+FYRQmlIy6/pU9YfGeWWMtVYSz3bSqYFXf
         OnxmZLq6YmvL4A6u3cXYcmfs981RefJnJFfw4TjFSdZYVBSv0D6JkmIRk+slznlJs2N7
         wzUp3xH9l7ir6KMUkp4+oELZU4hUm5VqOMcEyu8J2VVWc7P8fTCsmnM6wDnKa6uJ5yjG
         UOFFlmWkrExXx/yz4nox+NsZ0AZFKmbz20kvR9juq0khDxynOHBQ6jZze+WDohgtCRjJ
         63IdzIR0bEklXdmrsRRUcs8jmr9QaTLq9aeolM21CGZW6xH9ZemOMdjCws8iji17SGHE
         weQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xdDlsYqmeKUXi1m/okS37mLJa+8YvjWUBaTgXlbztPE=;
        b=v6dbb5ZTiMioUvc2qdngOxysc24mVci7JfyudfZ7kx0qcErtOxqnXjPrSt9Pcd5AxS
         8wMVaHIkiLnRfkQNQ3Lm0QztK6zermeo7j6OryQIyOYPFqxzRrvWlLUhq6fUEC+OBse7
         ie3i23aY+6+KPi+j9PscTTG8AutZ1j833O9ufrPk8/4muJy+B2g3Xx8bsA4Glya3FCa5
         f5vekmTl0bfS/o7rVqemx6VWdxPsdZh6HMBaWu6mVZQdQCvYugnG/e9peGDyjxzPB9Ze
         bQOSdZyyxDQJ6Y61mxM6YVaj7ar4i1w/axzJRxovfJuPlVSYPNkKrxbjQsZ9/k2LJJUo
         tLtw==
X-Gm-Message-State: AO0yUKXqQ9Ig5dj43naTrtx1Nm8D9Z9oBO3ka3rm536SmRZfSPlRlB+m
        yEFykTRw/ngtyAhRZfvwVwTOLU2qzjsR
X-Google-Smtp-Source: AK7set+6G7w93iKvh3pK8d4Pn09fp4vjG7pahxdlFvN/m3ZzAOPWx2J7sdTsm/hJEeolIHRv+ZBD+dSqPMMX
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:fc49:772b:8c4f:d691])
 (user=irogers job=sendgmr) by 2002:a81:8d09:0:b0:4df:ab25:431 with SMTP id
 d9-20020a818d09000000b004dfab250431mr52684ywg.312.1675216232233; Tue, 31 Jan
 2023 17:50:32 -0800 (PST)
Date:   Tue, 31 Jan 2023 17:50:15 -0800
Message-Id: <20230201015015.359535-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.1.456.gfc5497dd1b-goog
Subject: [PATCH v1] tools/resolve_btfids: Tidy host CFLAGS forcing
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

Avoid passing CROSS_COMPILE to submakes and ensure CFLAGS is forced to
HOSTCFLAGS for submake builds. This fixes problems with cross
compilation.

Tidy to not unnecessarily modify/export CFLAGS, make the override for
prepare and build clearer.

Fixes: 13e07691a16f ("tools/resolve_btfids: Alter how HOSTCC is forced")
Reported-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/bpf/resolve_btfids/Makefile | 49 ++++++++++++++++---------------
 1 file changed, 26 insertions(+), 23 deletions(-)

diff --git a/tools/bpf/resolve_btfids/Makefile b/tools/bpf/resolve_btfids/Makefile
index daed388aa5d7..c9b6cf1fb844 100644
--- a/tools/bpf/resolve_btfids/Makefile
+++ b/tools/bpf/resolve_btfids/Makefile
@@ -17,12 +17,7 @@ else
   MAKEFLAGS=--no-print-directory
 endif
 
-# always use the host compiler
-HOST_OVERRIDES := AR="$(HOSTAR)" CC="$(HOSTCC)" LD="$(HOSTLD)" ARCH="$(HOSTARCH)" \
-		  EXTRA_CFLAGS="$(HOSTCFLAGS) $(KBUILD_HOSTCFLAGS)"
-
 RM      ?= rm
-CROSS_COMPILE =
 
 OUTPUT ?= $(srctree)/tools/bpf/resolve_btfids/
 
@@ -43,6 +38,29 @@ SUBCMD_INCLUDE := $(SUBCMD_DESTDIR)include
 BINARY     := $(OUTPUT)/resolve_btfids
 BINARY_IN  := $(BINARY)-in.o
 
+LIBELF_FLAGS := $(shell $(HOSTPKG_CONFIG) libelf --cflags 2>/dev/null)
+LIBELF_LIBS  := $(shell $(HOSTPKG_CONFIG) libelf --libs 2>/dev/null || echo -lelf)
+
+RESOLVE_BTFIDS_CFLAGS = -g \
+          -I$(srctree)/tools/include \
+          -I$(srctree)/tools/include/uapi \
+          -I$(LIBBPF_INCLUDE) \
+          -I$(SUBCMD_INCLUDE) \
+          $(LIBELF_FLAGS)
+
+# Overrides for the prepare step libraries.
+HOST_OVERRIDES_PREPARE := AR="$(HOSTAR)" CC="$(HOSTCC)" LD="$(HOSTLD)" \
+	  ARCH="$(HOSTARCH)" CROSS_COMPILE=""
+
+# Overrides for Makefile.build C targets.
+HOST_OVERRIDES_BUILD := $(HOST_OVERRIDES_PREPARE) \
+	  CFLAGS="$(HOSTCFLAGS) $(KBUILD_HOSTCFLAGS) $(RESOLVE_BTFIDS_CFLAGS)" \
+
+LIBS = $(LIBELF_LIBS) -lz
+
+export srctree OUTPUT Q
+include $(srctree)/tools/build/Makefile.include
+
 all: $(BINARY)
 
 prepare: $(BPFOBJ) $(SUBCMDOBJ)
@@ -53,31 +71,16 @@ $(OUTPUT) $(OUTPUT)/libsubcmd $(LIBBPF_OUT):
 
 $(SUBCMDOBJ): fixdep FORCE | $(OUTPUT)/libsubcmd
 	$(Q)$(MAKE) -C $(SUBCMD_SRC) OUTPUT=$(SUBCMD_OUT) \
-		    DESTDIR=$(SUBCMD_DESTDIR) $(HOST_OVERRIDES) prefix= subdir= \
+		    DESTDIR=$(SUBCMD_DESTDIR) $(HOST_OVERRIDES_PREPARE) prefix= subdir= \
 		    $(abspath $@) install_headers
 
 $(BPFOBJ): $(wildcard $(LIBBPF_SRC)/*.[ch] $(LIBBPF_SRC)/Makefile) | $(LIBBPF_OUT)
 	$(Q)$(MAKE) $(submake_extras) -C $(LIBBPF_SRC) OUTPUT=$(LIBBPF_OUT)    \
-		    DESTDIR=$(LIBBPF_DESTDIR) $(HOST_OVERRIDES) prefix= subdir= \
+		    DESTDIR=$(LIBBPF_DESTDIR) $(HOST_OVERRIDES_PREPARE) prefix= subdir= \
 		    $(abspath $@) install_headers
 
-LIBELF_FLAGS := $(shell $(HOSTPKG_CONFIG) libelf --cflags 2>/dev/null)
-LIBELF_LIBS  := $(shell $(HOSTPKG_CONFIG) libelf --libs 2>/dev/null || echo -lelf)
-
-CFLAGS += -g \
-          -I$(srctree)/tools/include \
-          -I$(srctree)/tools/include/uapi \
-          -I$(LIBBPF_INCLUDE) \
-          -I$(SUBCMD_INCLUDE) \
-          $(LIBELF_FLAGS)
-
-LIBS = $(LIBELF_LIBS) -lz
-
-export srctree OUTPUT CFLAGS Q
-include $(srctree)/tools/build/Makefile.include
-
 $(BINARY_IN): fixdep FORCE prepare | $(OUTPUT)
-	$(Q)$(MAKE) $(build)=resolve_btfids $(HOST_OVERRIDES)
+	$(Q)$(MAKE) $(build)=resolve_btfids $(HOST_OVERRIDES_BUILD)
 
 $(BINARY): $(BPFOBJ) $(SUBCMDOBJ) $(BINARY_IN)
 	$(call msg,LINK,$@)
-- 
2.39.1.456.gfc5497dd1b-goog

