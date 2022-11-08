Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0519620A40
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 08:35:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233551AbiKHHfy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 02:35:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232641AbiKHHfs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 02:35:48 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF80D2EF52
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 23:35:45 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id e8-20020a5b0cc8000000b006bca0fa3ab6so13379545ybr.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 23:35:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=05tcS3sAQNNzElcGvhYcBZhblO5ft3NSeZEHHXzfROg=;
        b=Zg46QtP7hcn+P4fbi7N9yBIbX3ahfdclkZHaF/TnGZCqShkEQAWMz8WJFH+opdhDDp
         eYIhkkaTDXJ7XiNR87v75N/uwhgnwsQhhuzlvIsgB4VIz3GF86py59diJgouGb/YSlfS
         YfbQp7r4rXYLgS+7qiPfSqqHfFybuVnf6olvHf6PZnXtg1K3QEgo7CQA6v/WKbCtEBqZ
         40MvScHyvg2QbhmdyfY4eM8F/aZdXvP6H0kIukoTGEDuBtHr5UVpJX9F4IGVcV5YdfPn
         D/SIUvEuj/+wg+buoKXtv1MjWpe/ydZhBnKviqVonVtO+926/BJkhhbi8eORy7E5Nds3
         1kog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=05tcS3sAQNNzElcGvhYcBZhblO5ft3NSeZEHHXzfROg=;
        b=qHji4n6Hzrzp+XDRPc2EwIwW7BBkZPLYrg5tj2O51XdMIbjOjcYnyPIdUwYCkQcfhb
         16o9/vAR/ZZECn1PHe9Yga+Zj9Gt+eQLaQuEwR2mZtNq0nveyocityjX3KqDb29/XyCA
         suMgHH9ZiKELrNza+rgYgaM9jjEB1V58Aaj+UKIfrnRWbTJcKb14JvyXB+WmFbi+/ejW
         4cp6WHCKH5DX+O71OVpiwlcUN154QKzbDEKf6sONX5s5kmmpA/Y92YQxkAg4qQrqbTkZ
         i71Lu1DzmjrybdTYXdZ69L+5wy3/pQ1Dbk2wDbLokyxvjYayT/X+xxKEDMqj3EaTn2LJ
         M1mw==
X-Gm-Message-State: ACrzQf2N9UqSD1rr3/KydpekgmgsG76tvsGw2fsO0N/Kj5JBs/dPbCn2
        YkYfhXjAm8Ogh43zIArUAEX6BqO8okbZ
X-Google-Smtp-Source: AMsMyM5H6bu38+gvGtVWkxb2IyyE+GkPaEZYykvvSKX12o5MsTAtI/Zh+9ZFWbEm7+FUwl/0gzd6rhudStIk
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:a697:9013:186f:ed07])
 (user=irogers job=sendgmr) by 2002:a5b:c92:0:b0:688:436c:b2b with SMTP id
 i18-20020a5b0c92000000b00688436c0b2bmr52487113ybq.436.1667892945099; Mon, 07
 Nov 2022 23:35:45 -0800 (PST)
Date:   Mon,  7 Nov 2022 23:35:06 -0800
In-Reply-To: <20221108073518.1154450-1-irogers@google.com>
Message-Id: <20221108073518.1154450-3-irogers@google.com>
Mime-Version: 1.0
References: <20221108073518.1154450-1-irogers@google.com>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Subject: [PATCH v1 02/14] tools lib subcmd: Add install target
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
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
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

