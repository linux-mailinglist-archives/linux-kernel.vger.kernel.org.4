Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 877B567D515
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 20:07:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232391AbjAZTHx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 14:07:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230221AbjAZTHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 14:07:49 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26B056ACB9
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 11:07:29 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id a62-20020a25ca41000000b0080b838a5199so2853931ybg.6
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 11:07:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=J2pcP69LZTMAGIqNu0kBA1pDv1CbJMJ6T2ufALbnNrU=;
        b=pXe/uQ1qDwqsEkXeC8cn2A3Ig5yiMlN2CYSEtYX66/pwv/plFMLJJ+/g5ihcr0bNNg
         l3NUR0pa1SPKeTLGI5HEs5SOD6k7dIH+H62DdoJShBp1QdJDzXFbgNfhjygVhQcVfLro
         OYc2ok/D5SlYyhkWCP3gaOI12wN5sXvoIZJwR1oY03stXoOJk3d5nru1KuoNFxlBbb9o
         KrHER9mbu8XcfF7erXoH8hgx/0vt1r2Bo6iMFFzYWrAnvqz9A7Tl1vnlpxEow3QXbNUY
         3K8Z3t6XNvFZ3ZeixA8FtLKUKF9qxT7jwZB6tbHbZDPigop7U/YPuS6APny/iAe5s93y
         SkFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J2pcP69LZTMAGIqNu0kBA1pDv1CbJMJ6T2ufALbnNrU=;
        b=DUkxyVJLGmpFy/XfuurD1Fyeg4Ukg2UsP2BI3txC5eMilRC4IEyWp4nZ1gbxU7MFBB
         GvTK7ReGvKhJOINv2Al/ICWSBEwAIlntixj5tOkRe0j8IoY8GJcc+Tpj+BBMB6Q9qQRY
         u4CGnKN5jjy+AwVT40ewLOlQ6iKFECCJE5XVzRigqzPt5cUwrkgQsp3R9EhVmTqBQzwm
         IHi7ZoRFlUe8LfPK3aezHrUtlAPGaUvTKBRmIC3xulte0w3HLStEps7a6/IP+efYEAcv
         y7mRotxtEUhRPIbaIUzO3qD+vBtMUHOcJcqvAB/TYXaLkmofOjv1+8BWRYvTmyBq4Ip9
         B21A==
X-Gm-Message-State: AFqh2kpPHDpwhkTCV2gEPnKJhZtWfZ+N15d8x+vlSYJNES+d23riV5ZM
        rWmmR5ejrhDSeAyygrHDAtMnUKffNi6R
X-Google-Smtp-Source: AMrXdXvSzGwKZ8nnO2G1/GyZ8RLzPyBqRL0rlrAoXXb/Xt4w3MTDSafE+fiH/pRHfQ4J+/s9TSQUoOhPqYPk
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:568d:4d98:b468:b025])
 (user=irogers job=sendgmr) by 2002:a81:ee03:0:b0:4ec:8f55:59f7 with SMTP id
 l3-20020a81ee03000000b004ec8f5559f7mr4315545ywm.317.1674760049111; Thu, 26
 Jan 2023 11:07:29 -0800 (PST)
Date:   Thu, 26 Jan 2023 11:06:06 -0800
In-Reply-To: <20230126190606.40739-1-irogers@google.com>
Message-Id: <20230126190606.40739-4-irogers@google.com>
Mime-Version: 1.0
References: <20230126190606.40739-1-irogers@google.com>
X-Mailer: git-send-email 2.39.1.456.gfc5497dd1b-goog
Subject: [PATCH v4 3/3] objtool: Alter how HOSTCC is forced
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
flags (like CFLAGS) are set assuming say CC is gcc, but then it can be
later set to HOSTCC which may be clang. tools/scripts/Makefile.include
is needed for host set up and common macros in objtool's
Makefile. Rather than override the CC variable to HOSTCC, just pass CC
as HOSTCC to the sub-makes of Makefile.build, the libsubcmd builds and
also to the linkage step.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/objtool/Makefile | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/tools/objtool/Makefile b/tools/objtool/Makefile
index f0651eac06e6..bbf8ec440430 100644
--- a/tools/objtool/Makefile
+++ b/tools/objtool/Makefile
@@ -2,11 +2,6 @@
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
@@ -34,13 +29,18 @@ INCLUDES := -I$(srctree)/tools/include \
 	    -I$(srctree)/tools/objtool/include \
 	    -I$(srctree)/tools/objtool/arch/$(SRCARCH)/include \
 	    -I$(LIBSUBCMD_OUTPUT)/include
+# Note, EXTRA_WARNINGS here was determined for CC and not HOSTCC, it
+# is passed here to match a legacy behavior.
 WARNINGS := $(EXTRA_WARNINGS) -Wno-switch-default -Wno-switch-enum -Wno-packed -Wno-nested-externs
-CFLAGS   := -Werror $(WARNINGS) $(KBUILD_HOSTCFLAGS) -g $(INCLUDES) $(LIBELF_FLAGS)
-LDFLAGS  += $(LIBELF_LIBS) $(LIBSUBCMD) $(KBUILD_HOSTLDFLAGS)
+OBJTOOL_CFLAGS := -Werror $(WARNINGS) $(KBUILD_HOSTCFLAGS) -g $(INCLUDES) $(LIBELF_FLAGS)
+OBJTOOL_LDFLAGS := $(LIBELF_LIBS) $(LIBSUBCMD) $(KBUILD_HOSTLDFLAGS)
 
 # Allow old libelf to be used:
 elfshdr := $(shell echo '$(pound)include <libelf.h>' | $(CC) $(CFLAGS) -x c -E - | grep elf_getshdr)
-CFLAGS += $(if $(elfshdr),,-DLIBELF_USE_DEPRECATED)
+OBJTOOL_CFLAGS += $(if $(elfshdr),,-DLIBELF_USE_DEPRECATED)
+
+# Always want host compilation.
+HOST_OVERRIDES := CC="$(HOSTCC)" LD="$(HOSTLD)" AR="$(HOSTAR)"
 
 AWK = awk
 MKDIR = mkdir
@@ -63,10 +63,12 @@ include $(srctree)/tools/build/Makefile.include
 
 $(OBJTOOL_IN): fixdep FORCE
 	$(Q)$(CONFIG_SHELL) ./sync-check.sh
-	$(Q)$(MAKE) $(build)=objtool
+	$(Q)$(MAKE) $(build)=objtool $(HOST_OVERRIDES) CFLAGS="$(OBJTOOL_CFLAGS)" \
+		LDFLAGS="$(OBJTOOL_LDFLAGS)"
+
 
 $(OBJTOOL): $(LIBSUBCMD) $(OBJTOOL_IN)
-	$(QUIET_LINK)$(CC) $(OBJTOOL_IN) $(LDFLAGS) -o $@
+	$(QUIET_LINK)$(HOSTCC) $(OBJTOOL_IN) $(OBJTOOL_LDFLAGS) -o $@
 
 
 $(LIBSUBCMD_OUTPUT):
@@ -75,6 +77,7 @@ $(LIBSUBCMD_OUTPUT):
 $(LIBSUBCMD): fixdep FORCE $(LIBSUBCMD_OUTPUT)
 	$(Q)$(MAKE) -C $(LIBSUBCMD_DIR) O=$(LIBSUBCMD_OUTPUT) \
 		DESTDIR=$(LIBSUBCMD_OUTPUT) prefix= subdir= \
+		$(HOST_OVERRIDES) EXTRA_CFLAGS="$(OBJTOOL_CFLAGS)" \
 		$@ install_headers
 
 $(LIBSUBCMD)-clean:
-- 
2.39.1.456.gfc5497dd1b-goog

