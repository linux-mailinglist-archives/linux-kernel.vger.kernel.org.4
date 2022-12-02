Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F192663FFA9
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 05:59:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232244AbiLBE7A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 23:59:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232203AbiLBE6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 23:58:34 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9B36D754E
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 20:58:29 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id p69-20020a254248000000b006fdc6aaec4fso32630yba.20
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 20:58:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fILq8A5qrz+unrhULUsXFNDjXn/1W1i4JLQUQRTfzvo=;
        b=acO/rNicqUru8CkyXkWALo/Fo2ksQ8hWFQGgauAkCDH9CYAjhXMx2G6uXmAEFKIYU1
         FEDkyb6VhGSOK4t1tK46XWBuCchhlS1aJSGEKIH79Q+G/OhDs4MXMewZmk34Rn8E1vM/
         mSRisawQckSeTp2MkhOMqYTigFB1Z9FMDVqpWaX9U4M39HG23S3FBx4aLE4ndNeqEnCI
         2BRkONxouTflHYDQgx1iDO6qwz3B2MTCqeeRsAc8W36Zm+6Dhabs1ZY+Fmqatd0/KZZx
         M1DWpDDg0SjO4hCaqS04mv5+k9MacTqZ3R0iYJO3mfBnIj0cw0trCdA7okWKg6xa1xsf
         YqBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fILq8A5qrz+unrhULUsXFNDjXn/1W1i4JLQUQRTfzvo=;
        b=Q/ed+XZcCWPuNDox46E6nlL0L6519akv5SVWpbIL9DI9lm2j49ltVACC3IVAlCjgoQ
         /vSUrJ5qnsUnmhXxbT33QJyqNfue9rI3XN88I/V44+CLsq4EfVC22imBm0kK3Xy1vizf
         Hy4qoRw7Ic0lqfUy7mP3fNoRlObQ153NKjBHueERV5zTNWo0FwZ/MspObLLH5KIQ32e4
         wvN2+yIStQaKZodE9EJysM/+akUFg86weQ33YOZl0lzoU6/x5sPRXXJlFPbT8bSXxWjd
         8B2MZnjrHp/EMERyMwr06+ZmIszDBkmfyE6QHFSmX4cHWn0Rh3PLwqEigZVHpXtq2txo
         B3rA==
X-Gm-Message-State: ANoB5pmkxOZF5YnS1mYtGM3qa4F+r20orgNw6/8fg3KthZOhrGDuZoJF
        eprMlX/2CltPlVa1yNrm/V9D9ieFmYlZ
X-Google-Smtp-Source: AA0mqf6J88v0jQ/vpUt8gWXuYLzszh3xJz4A/psqOw9CH17kaOd1Hvy7pJ8mWpeUGZogqM+Y2HcWcehDaIV6
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:e3b0:e3d1:6040:add2])
 (user=irogers job=sendgmr) by 2002:a05:690c:8:b0:391:c415:f872 with SMTP id
 bc8-20020a05690c000800b00391c415f872mr47275258ywb.318.1669957108981; Thu, 01
 Dec 2022 20:58:28 -0800 (PST)
Date:   Thu,  1 Dec 2022 20:57:42 -0800
In-Reply-To: <20221202045743.2639466-1-irogers@google.com>
Message-Id: <20221202045743.2639466-5-irogers@google.com>
Mime-Version: 1.0
References: <20221202045743.2639466-1-irogers@google.com>
X-Mailer: git-send-email 2.39.0.rc0.267.gcb52ba06e7-goog
Subject: [PATCH 4/5] tools lib symbol: Add dependency test to install_headers
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        bpf@vger.kernel.org, llvm@lists.linux.dev
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

Compute the headers to be installed from their source headers and make
each have its own build target to install it. Using dependencies
avoids headers being reinstalled and getting a new timestamp which
then causes files that depend on the header to be rebuilt.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/symbol/Makefile | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/tools/lib/symbol/Makefile b/tools/lib/symbol/Makefile
index ea8707b3442a..13d43c6f92b4 100644
--- a/tools/lib/symbol/Makefile
+++ b/tools/lib/symbol/Makefile
@@ -89,10 +89,10 @@ define do_install_mkdir
 endef
 
 define do_install
-	if [ ! -d '$(DESTDIR_SQ)$2' ]; then             \
-		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$2'; \
-	fi;                                             \
-	$(INSTALL) $1 $(if $3,-m $3,) '$(DESTDIR_SQ)$2'
+	if [ ! -d '$2' ]; then             \
+		$(INSTALL) -d -m 755 '$2'; \
+	fi;                                \
+	$(INSTALL) $1 $(if $3,-m $3,) '$2'
 endef
 
 install_lib: $(LIBFILE)
@@ -100,9 +100,16 @@ install_lib: $(LIBFILE)
 		$(call do_install_mkdir,$(libdir_SQ)); \
 		cp -fpR $(LIBFILE) $(DESTDIR)$(libdir_SQ)
 
-install_headers:
-	$(call QUIET_INSTALL, libsymbol_headers) \
-		$(call do_install,kallsyms.h,$(prefix)/include/symbol,644);
+HDRS := kallsyms.h
+INSTALL_HDRS_PFX := $(DESTDIR)$(prefix)/include/symbol
+INSTALL_HDRS := $(addprefix $(INSTALL_HDRS_PFX)/, $(HDRS))
+
+$(INSTALL_HDRS): $(INSTALL_HDRS_PFX)/%.h: %.h
+	$(call QUIET_INSTALL, $@) \
+		$(call do_install,$<,$(INSTALL_HDRS_PFX)/,644)
+
+install_headers: $(INSTALL_HDRS)
+	$(call QUIET_INSTALL, libsymbol_headers)
 
 install: install_lib install_headers
 
-- 
2.39.0.rc0.267.gcb52ba06e7-goog

