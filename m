Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2851F65E73A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 10:03:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231783AbjAEJCu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 04:02:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231766AbjAEJCQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 04:02:16 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D990DCE5
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 01:02:15 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id v13-20020a25ab8d000000b007b54623bf71so931467ybi.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 01:02:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DpWkZKk39/eacUAN3ZgYzWujc2fjIBkDhCf4XLMsvxE=;
        b=bq34XRJBjaA7mS5pbSs4ua8HLD37IrJe3Xy9FCGoPRS0ZbgdzN5KSoA0tuHSlcDaal
         tsCrnR3iyBORSY55MxAAO95DHfSPyguQjOYIk5w3Sqdt+EwEfQ++rlbMcxqOpxa5sCA8
         HBwjlxzXXhjnxms8ZhbMObirCzEODalfNBde0pMtLWqdqrNPkN356SoQEu4Dh/d10voL
         1J8DVmwIKTbpXOhiBVzOjNYM3x7Wt/tKmUtlOmaVtLqaBmPm+mhswD7saXwVtnbD8aOt
         t+QsSZWzOWGZDFIfwS4JSR0+sz4FZBy5NzTyoNGb/p4iNSHMFPcl9yRy2rqK7Ix4xyif
         wI/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DpWkZKk39/eacUAN3ZgYzWujc2fjIBkDhCf4XLMsvxE=;
        b=IxF3t+op87wERBTUhlLLqLMb9YZ++FbxaKc3Zysn9xlSvN/OuYz3Hf8t2A72QungsC
         z6JjAjUYXemFzonrXXp9y9jndiZrSGBPpEBeDDaowMmP822MZVIoR5ZXQGQqGrp8z9FN
         00JBKHME2fYutvf0W3INBRklYzXXTWThQ6xSdLeWnYYAmSHqcksU7IYbSatMayf3P5OS
         q+aqdQBmojAbVk1OD3Ay9nkYU0sB10Kqtuix/PEM5j3sPqFXR5WiZGonhVDmZ+UFkz30
         kNLanobso7cxcWtAmnQ2tMNEWfH32cpcMUNIfrlvtccBGkHRuuFUPXCTf9cxPYgtYDQf
         sUYg==
X-Gm-Message-State: AFqh2krNtP4R2oa1iOgOwSSNDtgV5/B1OmBkT1wXm9G1z3CvNUqnhWX8
        L1mtolDniaVKuVUd/3oItgCUEgNoOOWG
X-Google-Smtp-Source: AMrXdXtApMqDcsv4OilzV3AXaN+Kg7gN0cxjchQ6nOCOq7RlDaA8NCq7Yr5hwLjAwpiS668psNAm1iQuWFuU
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:8775:c864:37e:2f9b])
 (user=irogers job=sendgmr) by 2002:a25:550a:0:b0:708:522d:cd52 with SMTP id
 j10-20020a25550a000000b00708522dcd52mr5582240ybb.312.1672909335154; Thu, 05
 Jan 2023 01:02:15 -0800 (PST)
Date:   Thu,  5 Jan 2023 01:01:53 -0800
In-Reply-To: <20230105090155.357604-1-irogers@google.com>
Message-Id: <20230105090155.357604-2-irogers@google.com>
Mime-Version: 1.0
References: <20230105090155.357604-1-irogers@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Subject: [PATCH v3 1/3] objtool: Install libsubcmd in build
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

Including from tools/lib can create inadvertent dependencies. Install
libsubcmd in the objtool build and then include the headers from
there.

Signed-off-by: Ian Rogers <irogers@google.com>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Tested-by: Nick Desaulniers <ndesaulniers@google.com>
---
 tools/objtool/Build    |  2 --
 tools/objtool/Makefile | 33 +++++++++++++++++++++++++--------
 2 files changed, 25 insertions(+), 10 deletions(-)

diff --git a/tools/objtool/Build b/tools/objtool/Build
index 33f2ee5a46d3..a3cdf8af6635 100644
--- a/tools/objtool/Build
+++ b/tools/objtool/Build
@@ -16,8 +16,6 @@ objtool-y += libctype.o
 objtool-y += str_error_r.o
 objtool-y += librbtree.o
 
-CFLAGS += -I$(srctree)/tools/lib
-
 $(OUTPUT)libstring.o: ../lib/string.c FORCE
 	$(call rule_mkdir)
 	$(call if_changed_dep,cc_o_c)
diff --git a/tools/objtool/Makefile b/tools/objtool/Makefile
index a3a9cc24e0e3..fd9b3e3113c6 100644
--- a/tools/objtool/Makefile
+++ b/tools/objtool/Makefile
@@ -12,9 +12,15 @@ srctree := $(patsubst %/,%,$(dir $(CURDIR)))
 srctree := $(patsubst %/,%,$(dir $(srctree)))
 endif
 
-SUBCMD_SRCDIR		= $(srctree)/tools/lib/subcmd/
-LIBSUBCMD_OUTPUT	= $(or $(OUTPUT),$(CURDIR)/)
-LIBSUBCMD		= $(LIBSUBCMD_OUTPUT)libsubcmd.a
+LIBSUBCMD_DIR = $(srctree)/tools/lib/subcmd/
+ifneq ($(OUTPUT),)
+  LIBSUBCMD_OUTPUT = $(abspath $(OUTPUT))/libsubcmd
+else
+  LIBSUBCMD_OUTPUT = $(CURDIR)/libsubcmd
+endif
+LIBSUBCMD_DESTDIR = $(LIBSUBCMD_OUTPUT)
+LIBSUBCMD = $(LIBSUBCMD_OUTPUT)/libsubcmd.a
+CFLAGS += -I$(LIBSUBCMD_OUTPUT)/include
 
 OBJTOOL    := $(OUTPUT)objtool
 OBJTOOL_IN := $(OBJTOOL)-in.o
@@ -28,7 +34,8 @@ INCLUDES := -I$(srctree)/tools/include \
 	    -I$(srctree)/tools/arch/$(HOSTARCH)/include/uapi \
 	    -I$(srctree)/tools/arch/$(SRCARCH)/include	\
 	    -I$(srctree)/tools/objtool/include \
-	    -I$(srctree)/tools/objtool/arch/$(SRCARCH)/include
+	    -I$(srctree)/tools/objtool/arch/$(SRCARCH)/include \
+	    -I$(LIBSUBCMD_OUTPUT)/include
 WARNINGS := $(EXTRA_WARNINGS) -Wno-switch-default -Wno-switch-enum -Wno-packed -Wno-nested-externs
 CFLAGS   := -Werror $(WARNINGS) $(KBUILD_HOSTCFLAGS) -g $(INCLUDES) $(LIBELF_FLAGS)
 LDFLAGS  += $(LIBELF_LIBS) $(LIBSUBCMD) $(KBUILD_HOSTLDFLAGS)
@@ -38,6 +45,7 @@ elfshdr := $(shell echo '$(pound)include <libelf.h>' | $(CC) $(CFLAGS) -x c -E -
 CFLAGS += $(if $(elfshdr),,-DLIBELF_USE_DEPRECATED)
 
 AWK = awk
+MKDIR = mkdir
 
 BUILD_ORC := n
 
@@ -57,13 +65,22 @@ $(OBJTOOL): $(LIBSUBCMD) $(OBJTOOL_IN)
 	$(QUIET_LINK)$(CC) $(OBJTOOL_IN) $(LDFLAGS) -o $@
 
 
-$(LIBSUBCMD): fixdep FORCE
-	$(Q)$(MAKE) -C $(SUBCMD_SRCDIR) OUTPUT=$(LIBSUBCMD_OUTPUT)
+$(LIBSUBCMD_OUTPUT):
+	@$(MKDIR) -p $@
+
+$(LIBSUBCMD): fixdep FORCE $(LIBSUBCMD_OUTPUT)
+	@$(MAKE) -C $(LIBSUBCMD_DIR) O=$(LIBSUBCMD_OUTPUT) \
+		DESTDIR=$(LIBSUBCMD_DESTDIR) prefix= subdir= \
+		$@ install_headers
+
+$(LIBSUBCMD)-clean:
+	$(call QUIET_CLEAN, libsubcmd)
+	$(Q)$(RM) -r -- $(LIBSUBCMD_OUTPUT)
 
-clean:
+clean: $(LIBSUBCMD)-clean
 	$(call QUIET_CLEAN, objtool) $(RM) $(OBJTOOL)
 	$(Q)find $(OUTPUT) -name '*.o' -delete -o -name '\.*.cmd' -delete -o -name '\.*.d' -delete
-	$(Q)$(RM) $(OUTPUT)arch/x86/lib/inat-tables.c $(OUTPUT)fixdep $(LIBSUBCMD)
+	$(Q)$(RM) $(OUTPUT)arch/x86/lib/inat-tables.c $(OUTPUT)fixdep
 
 FORCE:
 
-- 
2.39.0.314.g84b9a713c41-goog

