Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D56F633129
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 01:12:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232059AbiKVAL7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 19:11:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbiKVALu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 19:11:50 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 241D6B4806
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 16:11:50 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id e15-20020a5b0ccf000000b006ed1704b40cso2811850ybr.5
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 16:11:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YA3p4eZ27kBAmptCpOS+nsvy69bweIx+1O3zQnoMBQo=;
        b=qIcwx0y/rn5zB6cQ9qMsMkZjvI5gpRES2VmQc7R5/U0FH5cNytRN8b6HgZWP3lqmhc
         3L11/ejja/s1KmjigNlyciVn59RY0Tzyx4JFjENh/0tSrdO7la6uMQQ8fYABbxTF1cpP
         g2Z2Be+xQdwbxhEQ7k8eTL1ABOQIOxL4R/CclCu1ZWnwkXM62+Uxy+O97ODM1T+MYf5k
         QLbEfwwu37ZtEy//NZ/93+KtTDebZ9CYFqXpucRX5IthEnNuoaywD6RGBzV0Q/sbY2sk
         gsEmMRnRuI9fa4JFwG1mu7Jpzq7Qt6+e7rBI0VNZHyaiZjsDYdavm5iF0NnMdBOrHWaW
         eybQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YA3p4eZ27kBAmptCpOS+nsvy69bweIx+1O3zQnoMBQo=;
        b=IsNlvQTLh2m+XAUy4T15YOPG+UoNBqKnC5vwxGini7tuTkQcaiHd1A4H+sWFrXeBQ6
         r8iM5TWDuAmIjtp8Pti7oM7tze7CSbnMcap6v95mWWL2HRxT3BH/g6m/tT4EMyd5FX9p
         /r8/UqM0IX8aFG+PxmJpSeeC0LgMKfS/OoqXIcYsj7bWruH5R05yELxDV7GtDmUMlcxM
         TqQBd7EdVF25QPVb25+l9IReS6ak53dPZElOl/47Hz8mOhQpvIi/gLRXk6uWxVQhVeyj
         p/xB823ZDgSUiht1sJd5yAJpZ/YXKeX1cTVcwiysCnDPcU1DYSsByENVjzGnpJfE7iAM
         qbYQ==
X-Gm-Message-State: ANoB5pmGNfdF57Sk7DnHcefplmQ7GAiEL7oeBgInuWh8b8CkW8K/Cani
        2dan4LDqsAUiNrIlN8Qwlg9MP5zgjyzY
X-Google-Smtp-Source: AA0mqf4BS0Iplv3tMhM7diNXfnB9SxiuAIYsorqowoyPYfBWehAFmqEcsHlkfrTUVGaCpAGr/FkEYsE5ydyS
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:2107:a1f5:8582:5608])
 (user=irogers job=sendgmr) by 2002:a25:4288:0:b0:6dd:39f6:da9 with SMTP id
 p130-20020a254288000000b006dd39f60da9mr10107180yba.509.1669075909376; Mon, 21
 Nov 2022 16:11:49 -0800 (PST)
Date:   Mon, 21 Nov 2022 16:11:22 -0800
In-Reply-To: <20221122001125.765003-1-irogers@google.com>
Message-Id: <20221122001125.765003-2-irogers@google.com>
Mime-Version: 1.0
References: <20221122001125.765003-1-irogers@google.com>
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
Subject: [PATCH v2 1/4] tools lib subcmd: Add install target
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

This allows libsubcmd to be installed as a dependency.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/subcmd/Makefile | 49 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/tools/lib/subcmd/Makefile b/tools/lib/subcmd/Makefile
index 8f1a09cdfd17..e96566f8991c 100644
--- a/tools/lib/subcmd/Makefile
+++ b/tools/lib/subcmd/Makefile
@@ -17,6 +17,15 @@ RM = rm -f
 
 MAKEFLAGS += --no-print-directory
 
+INSTALL = install
+
+# Use DESTDIR for installing into a different root directory.
+# This is useful for building a package. The program will be
+# installed in this directory as if it was the root directory.
+# Then the build tool can move it later.
+DESTDIR ?=
+DESTDIR_SQ = '$(subst ','\'',$(DESTDIR))'
+
 LIBFILE = $(OUTPUT)libsubcmd.a
 
 CFLAGS := -ggdb3 -Wall -Wextra -std=gnu99 -fPIC
@@ -48,6 +57,18 @@ CFLAGS += $(EXTRA_WARNINGS) $(EXTRA_CFLAGS)
 
 SUBCMD_IN := $(OUTPUT)libsubcmd-in.o
 
+ifeq ($(LP64), 1)
+  libdir_relative = lib64
+else
+  libdir_relative = lib
+endif
+
+prefix ?=
+libdir = $(prefix)/$(libdir_relative)
+
+# Shell quotes
+libdir_SQ = $(subst ','\'',$(libdir))
+
 all:
 
 export srctree OUTPUT CC LD CFLAGS V
@@ -61,6 +82,34 @@ $(SUBCMD_IN): FORCE
 $(LIBFILE): $(SUBCMD_IN)
 	$(QUIET_AR)$(RM) $@ && $(AR) rcs $@ $(SUBCMD_IN)
 
+define do_install_mkdir
+	if [ ! -d '$(DESTDIR_SQ)$1' ]; then             \
+		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$1'; \
+	fi
+endef
+
+define do_install
+	if [ ! -d '$(DESTDIR_SQ)$2' ]; then             \
+		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$2'; \
+	fi;                                             \
+	$(INSTALL) $1 $(if $3,-m $3,) '$(DESTDIR_SQ)$2'
+endef
+
+install_lib: $(LIBFILE)
+	$(call QUIET_INSTALL, $(LIBFILE)) \
+		$(call do_install_mkdir,$(libdir_SQ)); \
+		cp -fpR $(LIBFILE) $(DESTDIR)$(libdir_SQ)
+
+install_headers:
+	$(call QUIET_INSTALL, headers) \
+		$(call do_install,exec-cmd.h,$(prefix)/include/subcmd,644); \
+		$(call do_install,help.h,$(prefix)/include/subcmd,644); \
+		$(call do_install,pager.h,$(prefix)/include/subcmd,644); \
+		$(call do_install,parse-options.h,$(prefix)/include/subcmd,644); \
+		$(call do_install,run-command.h,$(prefix)/include/subcmd,644);
+
+install: install_lib install_headers
+
 clean:
 	$(call QUIET_CLEAN, libsubcmd) $(RM) $(LIBFILE); \
 	find $(or $(OUTPUT),.) -name \*.o -or -name \*.o.cmd -or -name \*.o.d | xargs $(RM)
-- 
2.38.1.584.g0f3c55d4c2-goog

