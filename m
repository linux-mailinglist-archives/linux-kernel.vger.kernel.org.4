Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A290B67D513
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 20:07:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232397AbjAZTHg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 14:07:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232380AbjAZTHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 14:07:23 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1002D6810E
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 11:07:14 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id u186-20020a2560c3000000b007c8e2cf3668so2862372ybb.14
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 11:07:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8+gYGtqL2SRpdZUrbarcTj/VyrfCH7sXhTEO9COsfhA=;
        b=NVYUr+Uqf3LXuiY2vufck3b8NGaYASFbpX9cUq+Y3vSlnWt2MQrtxr5AawvrcLWisL
         NstcVu8PTp8LcmDng0BrP/LHuuIwpysNYOYw1GRCCHVvYufydYd8QofUm29SVFVAFWgr
         8J3H2YNlpa9sS+ddOaMGmYaTYrLRczvAJbJ9F3ZviiVLhwgoEmlUhDmaBNdIQEqg1lTd
         tOblDzgIFRdaf/3Htpzx5Hu1OtX0PvHLv4ZTHFeMJhMbvQIbi8V+A1m/LSix1DRgMgcT
         sC16ewzP7A6tErnLqVq+FpwJu3cxJkuKZzrSQnQLUbY7iUI7+sROPYGXWqPSqTshBlhY
         tM2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8+gYGtqL2SRpdZUrbarcTj/VyrfCH7sXhTEO9COsfhA=;
        b=QTSvvMBxurvFrQnoe/51YG19EnHf8HQywPh1azzrCHyDZ4Z2M2f1YUFwv8CuZ3Dy8y
         PQiSKAhLuSlj9DA0PJ+VnTUSiAJpr7zBV+Pxki/s1x/9D+W1rW6uzVSjbja2iiD1hfZ8
         WvfR43oavj4mNH87hZjaQkMHOL8JKAN+TSMJ1JmRbiWexzf+3/0RBhCHXnKGApbVCaX5
         NlYfFYe7UHvjRwwzPA6gRG9O0lwtYnQ6qZ2NxZ/MYYuOIYRhJMA0slOU10RFRhY62veD
         NCIdYQRUXM2gTVBwzO0zRpZdRu4WsB89pbXZPAlds0soonk/3JTP9xvrNGCKRGh8rPRZ
         11eA==
X-Gm-Message-State: AFqh2kobhftKTXYbcdZx7bzJy2MyxswhD6lSuLaoS/kV3kWVvNZrNjP+
        yJ0tGg0SOPttGEZ12rLv3Acnx/yihKPS
X-Google-Smtp-Source: AMrXdXtudaBVFWg4qUncYz8rcrZjJtg9DTzzyU9zA2GA1yz0akWAMZBB/rWGPj2/alDYiJ3Vlbum5DqAAJ8n
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:568d:4d98:b468:b025])
 (user=irogers job=sendgmr) by 2002:a81:78cc:0:b0:364:2f5d:5eb6 with SMTP id
 t195-20020a8178cc000000b003642f5d5eb6mr6102751ywc.215.1674760033313; Thu, 26
 Jan 2023 11:07:13 -0800 (PST)
Date:   Thu, 26 Jan 2023 11:06:04 -0800
In-Reply-To: <20230126190606.40739-1-irogers@google.com>
Message-Id: <20230126190606.40739-2-irogers@google.com>
Mime-Version: 1.0
References: <20230126190606.40739-1-irogers@google.com>
X-Mailer: git-send-email 2.39.1.456.gfc5497dd1b-goog
Subject: [PATCH v4 1/3] objtool: Install libsubcmd in build
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
---
 tools/objtool/.gitignore |  1 +
 tools/objtool/Build      |  2 --
 tools/objtool/Makefile   | 31 +++++++++++++++++++++++--------
 3 files changed, 24 insertions(+), 10 deletions(-)

diff --git a/tools/objtool/.gitignore b/tools/objtool/.gitignore
index 14236db3677f..4faa4dd72f35 100644
--- a/tools/objtool/.gitignore
+++ b/tools/objtool/.gitignore
@@ -2,3 +2,4 @@
 arch/x86/lib/inat-tables.c
 /objtool
 fixdep
+libsubcmd/
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
index a3a9cc24e0e3..0bfdb9da8729 100644
--- a/tools/objtool/Makefile
+++ b/tools/objtool/Makefile
@@ -12,9 +12,13 @@ srctree := $(patsubst %/,%,$(dir $(CURDIR)))
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
+LIBSUBCMD = $(LIBSUBCMD_OUTPUT)/libsubcmd.a
 
 OBJTOOL    := $(OUTPUT)objtool
 OBJTOOL_IN := $(OBJTOOL)-in.o
@@ -28,7 +32,8 @@ INCLUDES := -I$(srctree)/tools/include \
 	    -I$(srctree)/tools/arch/$(HOSTARCH)/include/uapi \
 	    -I$(srctree)/tools/arch/$(SRCARCH)/include	\
 	    -I$(srctree)/tools/objtool/include \
-	    -I$(srctree)/tools/objtool/arch/$(SRCARCH)/include
+	    -I$(srctree)/tools/objtool/arch/$(SRCARCH)/include \
+	    -I$(LIBSUBCMD_OUTPUT)/include
 WARNINGS := $(EXTRA_WARNINGS) -Wno-switch-default -Wno-switch-enum -Wno-packed -Wno-nested-externs
 CFLAGS   := -Werror $(WARNINGS) $(KBUILD_HOSTCFLAGS) -g $(INCLUDES) $(LIBELF_FLAGS)
 LDFLAGS  += $(LIBELF_LIBS) $(LIBSUBCMD) $(KBUILD_HOSTLDFLAGS)
@@ -38,6 +43,7 @@ elfshdr := $(shell echo '$(pound)include <libelf.h>' | $(CC) $(CFLAGS) -x c -E -
 CFLAGS += $(if $(elfshdr),,-DLIBELF_USE_DEPRECATED)
 
 AWK = awk
+MKDIR = mkdir
 
 BUILD_ORC := n
 
@@ -57,13 +63,22 @@ $(OBJTOOL): $(LIBSUBCMD) $(OBJTOOL_IN)
 	$(QUIET_LINK)$(CC) $(OBJTOOL_IN) $(LDFLAGS) -o $@
 
 
-$(LIBSUBCMD): fixdep FORCE
-	$(Q)$(MAKE) -C $(SUBCMD_SRCDIR) OUTPUT=$(LIBSUBCMD_OUTPUT)
+$(LIBSUBCMD_OUTPUT):
+	@$(MKDIR) -p $@
+
+$(LIBSUBCMD): fixdep FORCE $(LIBSUBCMD_OUTPUT)
+	@$(MAKE) -C $(LIBSUBCMD_DIR) O=$(LIBSUBCMD_OUTPUT) \
+		DESTDIR=$(LIBSUBCMD_OUTPUT) prefix= subdir= \
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
2.39.1.456.gfc5497dd1b-goog

