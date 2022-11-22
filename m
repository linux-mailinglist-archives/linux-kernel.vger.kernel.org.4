Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F004263312E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 01:13:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232132AbiKVAMz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 19:12:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232163AbiKVAMP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 19:12:15 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89CD4B7EBA
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 16:12:12 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-352e29ff8c2so128265417b3.21
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 16:12:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=f2OEVX8RYPyAcopuDfdaWLt0cg7xaISJPygwT0E0ouc=;
        b=c4MiccdF0m/dJ6gtmkt+leDsOcrSbyKkmprTSa4NTl6g3KAnmRAuF+gGso2easyZsV
         FnnkY2OmhIJN4f2BPS0ybe5jTSitq97A6wqCQKnrQFSfSYi2zSLGqRV1VY9kDsvqoP2R
         t7vrJ0f66IXcQXWLOe03yZNMU4fE8eO1zdHeOlGgNEGBe+TNLpWksnss3EZ6dw5crZh1
         gZplgnn9sPsj3eomSopOQzM21GLPpdCGWhE8wt8wWd30fGqgGk1Ez78i9ETM/bve4hbZ
         NYmLcH2qQd6Co5l6aHL5H7Qkns5w5OP9pjxxeoqiSG1Qbl0VgAM0kCgmBYat/D1EGHzn
         5h0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f2OEVX8RYPyAcopuDfdaWLt0cg7xaISJPygwT0E0ouc=;
        b=rVGn/FUB86yaye5dFFNC3UtWeWgWJRqkwZziSZ/uImmEZKHLLBZog2olLqeh3n3oxH
         YHGuYVsuXAwiCpMkht0KZ3NnyVIO+bhIb9xH8ZiYw+d0CjiD8UKmSGgLb9IcpQN8oTqF
         /hRtekxdnTLqJasRzHZII3ruB1iIFfynV3Vk/l/4Qcptb9Au/1pbdcTp6rW3uDeK9wnw
         PuZBcrFVlTzKnXVdosWSz0/eEHNflQjA+6jW8Iqghu2YBLtObOUrMV8X1qeVU0HrnET3
         qDjDqk258HmhAtQU/0zzCrZF7YZX5jXSGO4I+IwEXHgZjP19EFhyuoiIG/Pr8NJ6HGKR
         +v4w==
X-Gm-Message-State: ANoB5pnvj/b2AQkFFg9vHnxg/b11tXT//9zOO7FNT3b94TP1EKOeuUQ6
        MVPSJi0a2UwbzrB2V6VV8LVEhYkEOy7R
X-Google-Smtp-Source: AA0mqf6ifB1D27FOoWwlyBAZ6UUO1Cn1HmiU7JlNMhn9b8OXE1+2jtqZr/Gg9ZLVkC4H4FmMym0nmtMkpMBk
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:2107:a1f5:8582:5608])
 (user=irogers job=sendgmr) by 2002:a81:25d8:0:b0:373:4467:e0c6 with SMTP id
 l207-20020a8125d8000000b003734467e0c6mr1500249ywl.340.1669075931876; Mon, 21
 Nov 2022 16:12:11 -0800 (PST)
Date:   Mon, 21 Nov 2022 16:11:25 -0800
In-Reply-To: <20221122001125.765003-1-irogers@google.com>
Message-Id: <20221122001125.765003-5-irogers@google.com>
Mime-Version: 1.0
References: <20221122001125.765003-1-irogers@google.com>
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
Subject: [PATCH v2 4/4] objtool: Alter how HOSTCC is forced
From:   Ian Rogers <irogers@google.com>
To:     Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Cc:     Stephane Eranian <eranian@google.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
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

HOSTCC is always wanted when building objtool. Setting CC to HOSTCC
happens after tools/scripts/Makefile.include is included, meaning
flags are set assuming say CC is gcc, but then it can be later set to
HOSTCC which may be clang. tools/scripts/Makefile.include is needed
for host set up and common macros in objtool's Makefile. Rather than
override CC to HOSTCC, just pass CC as HOSTCC to Makefile.build, the
libsubcmd builds and the linkage step. This means the Makefiles don't
see things like CC changing and tool flag determination, and similar,
work properly. To avoid mixing CFLAGS from different compilers just
the objtool CFLAGS are determined. HOSTCFLAGS is added to these so
that command line flags can add to the CFLAGS.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/objtool/Makefile | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/tools/objtool/Makefile b/tools/objtool/Makefile
index 61a00b7acae9..e550a98e2dd9 100644
--- a/tools/objtool/Makefile
+++ b/tools/objtool/Makefile
@@ -2,16 +2,12 @@
 include ../scripts/Makefile.include
 include ../scripts/Makefile.arch
 
-# always use the host compiler
-AR	 = $(HOSTAR)
-CC	 = $(HOSTCC)
-LD	 = $(HOSTLD)
-
 ifeq ($(srctree),)
 srctree := $(patsubst %/,%,$(dir $(CURDIR)))
 srctree := $(patsubst %/,%,$(dir $(srctree)))
 endif
 
+MAKE = make -S
 LIBSUBCMD_DIR = $(srctree)/tools/lib/subcmd/
 ifneq ($(OUTPUT),)
   LIBSUBCMD_OUTPUT = $(abspath $(OUTPUT))/libsubcmd
@@ -36,13 +32,20 @@ INCLUDES := -I$(srctree)/tools/include \
 	    -I$(srctree)/tools/objtool/include \
 	    -I$(srctree)/tools/objtool/arch/$(SRCARCH)/include \
 	    -I$(LIBSUBCMD_OUTPUT)/include
-WARNINGS := $(EXTRA_WARNINGS) -Wno-switch-default -Wno-switch-enum -Wno-packed -Wno-nested-externs
-CFLAGS   := -Werror $(WARNINGS) $(KBUILD_HOSTCFLAGS) -g $(INCLUDES) $(LIBELF_FLAGS)
-LDFLAGS  += $(LIBELF_LIBS) $(LIBSUBCMD) $(KBUILD_HOSTLDFLAGS)
+WARNINGS := -Wno-switch-default -Wno-switch-enum -Wno-packed -Wno-nested-externs
+OBJTOOL_CFLAGS := -Werror $(WARNINGS) -g $(INCLUDES) $(LIBELF_FLAGS) $(HOSTCFLAGS)
+OBJTOOL_LDFLAGS := $(LIBELF_LIBS) $(LIBSUBCMD)
 
 # Allow old libelf to be used:
 elfshdr := $(shell echo '$(pound)include <libelf.h>' | $(CC) $(CFLAGS) -x c -E - | grep elf_getshdr)
-CFLAGS += $(if $(elfshdr),,-DLIBELF_USE_DEPRECATED)
+OBJTOOL_CFLAGS += $(if $(elfshdr),,-DLIBELF_USE_DEPRECATED)
+
+# Always want host compilation.
+HOST_OVERRIDES := CC="$(HOSTCC)" EXTRA_CFLAGS="$(OBJTOOL_CFLAGS)" \
+		  LD="$(HOSTLD)" AR="$(HOSTAR)"
+BUILD_HOST_OVERRIDES := CC="$(HOSTCC)" CFLAGS="$(OBJTOOL_CFLAGS)" \
+			LD="$(HOSTLD)" LDFLAGS="$(OBJTOOL_LDFLAGS)" \
+			AR="$(HOSTAR)"
 
 AWK = awk
 MKDIR = mkdir
@@ -65,10 +68,11 @@ include $(srctree)/tools/build/Makefile.include
 
 $(OBJTOOL_IN): fixdep FORCE
 	$(Q)$(CONFIG_SHELL) ./sync-check.sh
-	$(Q)$(MAKE) $(build)=objtool
+	$(Q)$(MAKE) $(build)=objtool $(BUILD_HOST_OVERRIDES)
+
 
 $(OBJTOOL): $(LIBSUBCMD) $(OBJTOOL_IN)
-	$(QUIET_LINK)$(CC) $(OBJTOOL_IN) $(LDFLAGS) -o $@
+	$(QUIET_LINK)$(HOSTCC) $(OBJTOOL_IN) $(KBUILD_HOSTLDFLAGS) $(OBJTOOL_LDFLAGS) -o $@
 
 
 $(LIBSUBCMD_OUTPUT):
@@ -77,6 +81,7 @@ $(LIBSUBCMD_OUTPUT):
 $(LIBSUBCMD): fixdep FORCE $(LIBSUBCMD_OUTPUT)
 	$(Q)$(MAKE) -C $(LIBSUBCMD_DIR) O=$(LIBSUBCMD_OUTPUT) \
 		DESTDIR=$(LIBSUBCMD_DESTDIR) prefix= subdir= \
+		$(HOST_OVERRIDES) \
 		$@ install_headers
 
 $(LIBSUBCMD)-clean:
-- 
2.38.1.584.g0f3c55d4c2-goog

