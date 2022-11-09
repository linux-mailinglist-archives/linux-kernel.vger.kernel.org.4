Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 325546232EC
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 19:49:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbiKIStu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 13:49:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbiKIStq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 13:49:46 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C855614099
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 10:49:42 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-367f94b9b16so170176617b3.11
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 10:49:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=05tcS3sAQNNzElcGvhYcBZhblO5ft3NSeZEHHXzfROg=;
        b=FrfJDilUGgqEU/9xZ+Sx8LJdZL5uNGHCI2s8HC7ZCFe709f+PQu2+EUpf7+hVKuye/
         c8mNJ8oEOMdgrGrCmMK7Yogk0cFIeax8K4SVFScGSYN+5uM/gxzjJWykyEv7IO1Erb7G
         oY3CkH1dU1SBAxSogNxpJq8MaD/fREJrv4LGWTr2fOVfIUCmu7Aidpvfj0Yt453x+n1P
         60wOo9fn3505b90GaT6vLmhfwGihiU03pR6pNi1Hw63c9YQ5QjPZYPPKflBa0yqm8g7l
         bSk2VA9zIDYZwCREZCRpMLDsYX15xZXt72ROcOSt3pNfspfwAePUifyKmJDtl/TXimBc
         vJDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=05tcS3sAQNNzElcGvhYcBZhblO5ft3NSeZEHHXzfROg=;
        b=iGoyglUVQRosS7l2OAeQSeBH1Go50HIvJBn6W65ia7kYRTrhsmI5qfR0Y8+Yeo6fZf
         44vHcFkiybasaN6T4DmU51w6LlYgbetBudE6WlRUxys700hLtd/NF0KZ5HteSMa08Hpn
         NertGiyUQWyylx1/4VpdMOWc/05NplBbDlTPFaQyfWmqvVUrzBljfRItjwrgDVcd9aYj
         LiZqy3voOAEMUoxCD5bLKt/DbLZZDyy9cnSWwR9Ap/0p1xtyJWYf6vi9PKT4iCS2hOa3
         y0VV2XIxmpDzhUvt9UU4n+EtCIM8Nf8yU2yeyi6NOBXQTKjCEFTLUefmpnMGF6X7eL/M
         9Tuw==
X-Gm-Message-State: ACrzQf1hRI/HI6/gETwh7XBAu4DhrHHmeT8ytdPEf7tRO2nTfK3vd2c5
        9kfLRzBXVUL3Ftsoghw6t9aCtnA/rzVt
X-Google-Smtp-Source: AMsMyM4LuD0xOiXFa9VTn835MwJvnx4tty3fk6NsDMzkkxI/Oa7orJu46gG+n077o2x4ODuIFKZ5ACHUDA0U
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:b06f:a254:5ce9:c442])
 (user=irogers job=sendgmr) by 2002:a25:ab33:0:b0:6be:a6ab:6955 with SMTP id
 u48-20020a25ab33000000b006bea6ab6955mr1110559ybi.230.1668019782047; Wed, 09
 Nov 2022 10:49:42 -0800 (PST)
Date:   Wed,  9 Nov 2022 10:49:02 -0800
In-Reply-To: <20221109184914.1357295-1-irogers@google.com>
Message-Id: <20221109184914.1357295-3-irogers@google.com>
Mime-Version: 1.0
References: <20221109184914.1357295-1-irogers@google.com>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Subject: [PATCH v2 02/14] tools lib subcmd: Add install target
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        bpf@vger.kernel.org, Nick Desaulniers <ndesaulniers@google.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Stephane Eranian <eranian@google.com>,
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
2.38.1.431.g37b22c650d-goog

