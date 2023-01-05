Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2172F65E73D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 10:03:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232008AbjAEJDK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 04:03:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231910AbjAEJCd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 04:02:33 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9593250066
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 01:02:32 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 195-20020a2505cc000000b0071163981d18so36469508ybf.13
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 01:02:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gVMnA3Yba2vBCG/rrA8tRkVdPMnJ5tlbhWykIgv9gDY=;
        b=cyUVgkg2LrWNWl0sdLVkr39/f4zMFUDi5twbEV0MjD8DMoZTIXLIJeh+o8WC/FcLfM
         OOF3VoiMBL/u+++aQU870Rb1fy+avLKjOnXakh+mWWaoJUWJN+ghT2bv+O3nNk4q5gEw
         HB2mSh8dMXbqWTL9plMEWe+z/gyL4dKQR406hAPac7K2Btu67B2qCP0HPja5AUjx/pPi
         dzF/2urVtfo/CQxRUrG7NTETNCka/FED1iOA2erccE5ljW7qgbi+sGSFzrFCm5m1cXui
         UvVhE58brTFs4adT5qGngtBGxG7zX7c+rG04jkGbZqrN1UaYAE7CFcb2KjT+oxMuwM7t
         4ngA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gVMnA3Yba2vBCG/rrA8tRkVdPMnJ5tlbhWykIgv9gDY=;
        b=cbGirZtkR81aM8KuEWlUqKAw6wGI/LLJTGLgD5Hwh8UrnLxX1w2PNQX9SQkIdj3al9
         tGZPAxlTUnGhBkoyIuwlvJU1oNOyCoZxLMoAih2MIaYuiXScQ3S/Loj9mxEYue2baJ6X
         B4vy0X7F1DEpObAt/XszgzHSxWbHuwiWTOpMZk8xbvC+z+M1wh5P7oKW6mH+iQF0PHrL
         QEtKaSmOCioTQFPU0AoDlQ8zBrCVoDBKmaPOJ3vjWe0hM2DagBc1j5B0OeZN8KSARb2N
         P59cQD4I5fIncDShZtzJVofULUTwnibjgvLE/IbqcaLV+wP/gFy6VDJzoGz7pZkDZT/h
         2NUg==
X-Gm-Message-State: AFqh2kpw3pAc8fwrU/sHsZB1r5O7ZF/aHNdcgsJvmA7zY9CgYdVjiHO/
        juBsFIXhQH5xYY2fCThAht+cTaEBxeFd
X-Google-Smtp-Source: AMrXdXu8hlr+rsXN67i0o8MgiT5jGdKE+g5eF7FEHXVVm0+3ulRvnaeBhKsam+0eLeUJMnomrNrPo/rz2FVv
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:8775:c864:37e:2f9b])
 (user=irogers job=sendgmr) by 2002:a81:6954:0:b0:4b2:fa7c:8836 with SMTP id
 e81-20020a816954000000b004b2fa7c8836mr910044ywc.195.1672909351913; Thu, 05
 Jan 2023 01:02:31 -0800 (PST)
Date:   Thu,  5 Jan 2023 01:01:55 -0800
In-Reply-To: <20230105090155.357604-1-irogers@google.com>
Message-Id: <20230105090155.357604-4-irogers@google.com>
Mime-Version: 1.0
References: <20230105090155.357604-1-irogers@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Subject: [PATCH v3 3/3] objtool: Alter how HOSTCC is forced
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
the objtool CFLAGS are determined with the exception of
EXTRA_WARNINGS. HOSTCFLAGS is added to these so that command line
flags can add to the CFLAGS.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/objtool/Makefile | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/tools/objtool/Makefile b/tools/objtool/Makefile
index 61a00b7acae9..49956f4f58b9 100644
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
@@ -37,12 +33,19 @@ INCLUDES := -I$(srctree)/tools/include \
 	    -I$(srctree)/tools/objtool/arch/$(SRCARCH)/include \
 	    -I$(LIBSUBCMD_OUTPUT)/include
 WARNINGS := $(EXTRA_WARNINGS) -Wno-switch-default -Wno-switch-enum -Wno-packed -Wno-nested-externs
-CFLAGS   := -Werror $(WARNINGS) $(KBUILD_HOSTCFLAGS) -g $(INCLUDES) $(LIBELF_FLAGS)
-LDFLAGS  += $(LIBELF_LIBS) $(LIBSUBCMD) $(KBUILD_HOSTLDFLAGS)
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
2.39.0.314.g84b9a713c41-goog

