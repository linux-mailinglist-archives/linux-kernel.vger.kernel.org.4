Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 319EE62E7B2
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 23:05:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241155AbiKQWFk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 17:05:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241053AbiKQWFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 17:05:12 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 886A82717C
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 14:03:56 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id t9-20020a5b03c9000000b006cff5077dc9so2781289ybp.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 14:03:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=i6w8X/FEX+k6lmFIXTs91E3JTRcJpHgBrrHWmdWICRc=;
        b=X56mfUl5VlxMRsxDJ+e6Lep8lObttWYXeSv/UmVLRoqcg/lv00Qobno67OYOrhLGUF
         xtW4JDNUG4OtFy55LevzS3U8QmO2uc4ypJfAJgWqIc3nRZ43rUUy9xdbLhvztkUdA13d
         4LZa2EjXLp6ANOFEKFLckDnWI4lAK8pbteZCX3hjj2YhUhxIp21xRo9oqeAqc7ws7PYS
         nh3MEupBip9D43sbicqnwuphQ6DAEo3rFR4FN0N+Wy7kBEkE7ow4gUOqS2O1GHm8zYFU
         btyQCAs/UVNymMnMAHPI7Imawr0j+AhJ+hcwC9yAQvXR/nYPp3Wx/V+LOEnss1gbgHTX
         zPbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i6w8X/FEX+k6lmFIXTs91E3JTRcJpHgBrrHWmdWICRc=;
        b=nxmc0RfPRi3dXUfr8LLiCCwNGkW6j7R9pHgKPOQ6z/PPvj7i2cl+iQ2SCjzqOkbOWn
         Q+qLqgMQUzfJ6frn+nJC15EvGt8qCEPHt5KExOnFrb/FiAvSYsd60qJh7PjQSmDhMASn
         wyHJz/aIsMBbjaPHGRAbrY1jbugES8gHoIzrzCfuoJSyooSuHN+7VnDHReJrR98xqixr
         Hl00Kh9JWdAly5jZje9yzsDIK9C53N6abXRJPBLzL+spnDXIK6xjw3y1b0j6fSXZLPNm
         LCGFJvyKOrGzFd/cOFv9da97KpNmIiboaz0nWtp1HNDhExvDWqaWfYUGR+74ru8J/tjs
         rbVw==
X-Gm-Message-State: ANoB5plnwonMxTzIYKgLPTL28QwaD5L9dG9HYwMl6n35ed9HApYkvts/
        2pXBgOnK+AV8ebaTAmyMIdDoFYcPfEqU
X-Google-Smtp-Source: AA0mqf67V7IBHCqmtKbDPYtqagmDcQh81uq92hr427gBeUYQBRW5NO1fXnegFgjnnTEGt3OeyOh0+u+qrOOL
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:3f1e:c462:d6b8:fba8])
 (user=irogers job=sendgmr) by 2002:a25:bd52:0:b0:6e6:8497:ad31 with SMTP id
 p18-20020a25bd52000000b006e68497ad31mr4148339ybm.165.1668722635804; Thu, 17
 Nov 2022 14:03:55 -0800 (PST)
Date:   Thu, 17 Nov 2022 14:03:37 -0800
In-Reply-To: <20221117220339.341290-1-irogers@google.com>
Message-Id: <20221117220339.341290-2-irogers@google.com>
Mime-Version: 1.0
References: <20221117220339.341290-1-irogers@google.com>
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
Subject: [PATCH v1 1/3] objtool: Install libsubcmd in build
From:   Ian Rogers <irogers@google.com>
To:     Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
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
index a3a9cc24e0e3..a3b55c807a51 100644
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
+		DESTDIR=$(LIBSUBCMD_DESTDIR) prefix= \
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
2.38.1.584.g0f3c55d4c2-goog

