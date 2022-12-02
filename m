Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34BD763FFAB
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 05:59:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232252AbiLBE7F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 23:59:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232285AbiLBE6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 23:58:37 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE582CBA4E
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 20:58:35 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id p69-20020a254248000000b006fdc6aaec4fso32883yba.20
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 20:58:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=29cYpp0Ewjs+gzHUrxa4ZZynn8ecl1yz6sJ+mMKI1iY=;
        b=mXGaeFXr8WJVLR4vcz/xlGw2zxIpwcainTmScK17G4ZIijqHnqfssAqOCCcjAfYvKp
         /ApAeoyZiQzcAjsKHYtHzT20CDlNzanVEBR8U4kSUuQ8bETvuRuj375aN+S79/TwM2N+
         R2EWHi5nyuTebWr/l5DOwk/qK6Lx0nKDcOYtlFh7q+Opmghp/coB2UIvPn/fkojNDOp/
         INqCX0SRSNLiTnIMtfhKu6WBeiUMcnuH3pJzmMvd/LgjQgYh7cGxzN5TDYOz46cNaR2B
         G9g/gQ2X6aYcqB+Ljpf4GIojOa5s/hxy5o72jSBq5izyOBhHf91URqqSjthT0z1aVdGP
         xobw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=29cYpp0Ewjs+gzHUrxa4ZZynn8ecl1yz6sJ+mMKI1iY=;
        b=cwNg4xSWiyB4kx8Zfdn5ROq3D2m3nXioaKxNoJawOtjI452Dra1qWbnt2ALrMJ25r8
         sLfYVkegdtJGmjO5Z1cGQ+6upYPLmkbFzWnwVZWtNS7aAqyMtrq2twcogS86aH3GTErC
         nfQREcIncZX6hZXnjprKbMn65i7p8b45Pi7h+0fuiTG42Xy1iUFxggbmSI2SK0vaaFyD
         K8Ul8SQA4iV83FEsu4QVHjlAYeylUSQyxHw8zPozcMdMkjtD7tv+peFr4SyJmSQKQdu1
         KS7gTlNu+CNTeZb0Iho1vCedU9fkHma9NAlPC2vhq5QYe2JiyPGvPwZ9yR8qVHKCaBEf
         MsjA==
X-Gm-Message-State: ANoB5pmOo1Sgu3OFPoAFg5wRRmhQawu/JyFjipwnW7tfV6pku7sxesWO
        YfM2aRnrK4quxHNJr21vCGCtb/CdLQkQ
X-Google-Smtp-Source: AA0mqf4a8Hcgp3HbqXnPSFZfXstIfd2OsG5QdtylWuWH8OSHOc+66jAvKk68VFoKMqwHWHZNALCK+xQV4z0z
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:e3b0:e3d1:6040:add2])
 (user=irogers job=sendgmr) by 2002:a81:38d5:0:b0:3d2:8530:f69a with SMTP id
 f204-20020a8138d5000000b003d28530f69amr12650101ywa.357.1669957115491; Thu, 01
 Dec 2022 20:58:35 -0800 (PST)
Date:   Thu,  1 Dec 2022 20:57:43 -0800
In-Reply-To: <20221202045743.2639466-1-irogers@google.com>
Message-Id: <20221202045743.2639466-6-irogers@google.com>
Mime-Version: 1.0
References: <20221202045743.2639466-1-irogers@google.com>
X-Mailer: git-send-email 2.39.0.rc0.267.gcb52ba06e7-goog
Subject: [PATCH 5/5] perf build: Fix python/perf.so library's name
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
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since Python 3.3 extensions have a suffix encoding platform and
version information. For example, the perf extension was previously
perf.so but now maybe perf.cpython-310-x86_64-linux-gnu.so. Compute
the extension using Python and then use this in the target name. Doing
this avoids the "perf.so" target always being rebuilt.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Makefile.config | 4 +++-
 tools/perf/Makefile.perf   | 2 +-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index b34288cb1900..ede04e07e9cb 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -871,6 +871,7 @@ define disable-python_code
   NO_LIBPYTHON := 1
 endef
 
+PYTHON_EXTENSION_SUFFIX := '.so'
 ifdef NO_LIBPYTHON
   $(call disable-python,Python support disabled by user)
 else
@@ -889,7 +890,8 @@ else
       else
          LDFLAGS += $(PYTHON_EMBED_LDFLAGS)
          EXTLIBS += $(PYTHON_EMBED_LIBADD)
-         LANG_BINDINGS += $(obj-perf)python/perf.so
+         PYTHON_EXTENSION_SUFFIX := $(shell $(PYTHON) -c 'from importlib import machinery; print(machinery.EXTENSION_SUFFIXES[0])')
+         LANG_BINDINGS += $(obj-perf)python/perf$(PYTHON_EXTENSION_SUFFIX)
          CFLAGS += -DHAVE_LIBPYTHON_SUPPORT
          $(call detected,CONFIG_LIBPYTHON)
       endif
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index f0e4daeef812..869856bdfdc9 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -642,7 +642,7 @@ all: shell_compatibility_test $(ALL_PROGRAMS) $(LANG_BINDINGS) $(OTHER_PROGRAMS)
 # Create python binding output directory if not already present
 _dummy := $(shell [ -d '$(OUTPUT)python' ] || mkdir -p '$(OUTPUT)python')
 
-$(OUTPUT)python/perf.so: $(PYTHON_EXT_SRCS) $(PYTHON_EXT_DEPS) $(LIBPERF)
+$(OUTPUT)python/perf$(PYTHON_EXTENSION_SUFFIX): $(PYTHON_EXT_SRCS) $(PYTHON_EXT_DEPS) $(LIBPERF)
 	$(QUIET_GEN)LDSHARED="$(CC) -pthread -shared" \
         CFLAGS='$(CFLAGS)' LDFLAGS='$(LDFLAGS)' \
 	  $(PYTHON_WORD) util/setup.py \
-- 
2.39.0.rc0.267.gcb52ba06e7-goog

