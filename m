Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6D6873F48D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 08:33:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbjF0GdE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 02:33:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbjF0GdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 02:33:01 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6612E5A;
        Mon, 26 Jun 2023 23:33:00 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-668704a5b5bso3833160b3a.0;
        Mon, 26 Jun 2023 23:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687847580; x=1690439580;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=ehmbUEpgbaPxTlOJARi3abmL78zdkNcEfVy/qADnbcM=;
        b=AToRD3ykPoY/AN8fvJ/dx+eeMxKOReHuGXxTSshorr42HPQAI8EZr/j6cnARnBZeEG
         jdqcI6BeazSy8KnVxwdKKr/AmGORy1wc/BkPoIqMR0fE7I6aNUXAnhGJ9CS5jzj6eBLi
         pXjxSMHi4RBBZAv+BPXAE/delZ/R1cdfazYcUMw0PjlK17A5aon+9nfZObsWb3LsiLbo
         5NkFziYZlOOtrmgjIyZElABW10i3uHuhvff4gw7hL7nkH1jOSBiB6Vbi0bK6CoDMYhmT
         nH7zJ4DBa6Iba44XxWeFcm7C1Y74kmwLRDuu3q2tPtZNqoa8JsQdVjqLAMpaLeym2Z5A
         LMYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687847580; x=1690439580;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ehmbUEpgbaPxTlOJARi3abmL78zdkNcEfVy/qADnbcM=;
        b=Hiv85xlfedM15IQtqggUWVOPwjjk2TV3M0tOVfjFlLn5Mx3IWQZ8uXBmIp9PhXv2AH
         VZecFPmc5Qoou6vmsJ1T+e9rDoHNaz54/q+yrhIauzcSkLn31kEgE6GrNzOW3fiQSr04
         fR6pzacvMq+Lr4i93UUA+/4+TDqWVtoE5t8KWK5xCt8FzHcLocxzW2Ens8vo4abxb5hs
         mejHoBMWeJir4OzKmNmcouHSkV2nK/FHJ5nSSCT2lNuCd/yx2AG/unQJpe8rR2vYQoAf
         osqhdH3S4bvWXNpvssUlVTg3DLYlL18xEASG475xQy/qZ1pFF3Xqj7L8++GtZeq+S0pK
         Fw1w==
X-Gm-Message-State: AC+VfDzujk99UXTaD/R9qjqb6bXW8iZbdTldJuAxP7y3z1n4IliYM8iK
        9tgPj9jZmAMhTPwffggmIWc=
X-Google-Smtp-Source: ACHHUZ5wNhHnqaq4167hCYZOqyRIuyVddabXOsqeV8f0cER2+oATvXvcfEKXnKh4h+auiqEPp+nlWw==
X-Received: by 2002:a05:6a20:748d:b0:126:92de:b893 with SMTP id p13-20020a056a20748d00b0012692deb893mr9777862pzd.31.1687847580168;
        Mon, 26 Jun 2023 23:33:00 -0700 (PDT)
Received: from moohyul.svl.corp.google.com ([2620:15c:2a3:200:1663:6fac:d111:59cf])
        by smtp.gmail.com with ESMTPSA id d25-20020aa78159000000b0064378c52398sm4709694pfn.25.2023.06.26.23.32.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 23:32:59 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: [PATCH] perf test: Fix a compile error on pe-file-parsing.c
Date:   Mon, 26 Jun 2023 23:32:57 -0700
Message-ID: <20230627063257.549005-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The dso__find_symbol_by_name() should be have idx pointer argument.
Found during the build-test.

  $ make build-test
  ...
    CC      /tmp/tmp.6JwPK1xbWG/tests/pe-file-parsing.o
  tests/pe-file-parsing.c: In function ‘run_dir’:
  tests/pe-file-parsing.c:64:15: error: too few arguments to function ‘dso__find_symbol_by_name’
     64 |         sym = dso__find_symbol_by_name(dso, "main");
        |               ^~~~~~~~~~~~~~~~~~~~~~~~
  In file included from tests/pe-file-parsing.c:16:
  /usr/local/google/home/namhyung/project/linux/tools/perf/util/symbol.h:135:16: note: declared here
    135 | struct symbol *dso__find_symbol_by_name(struct dso *dso, const char *name, size_t *idx);
        |                ^~~~~~~~~~~~~~~~~~~~~~~~

Fixes: 259dce914e93 ("perf symbol: Remove symbol_name_rb_node")
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/Makefile.config         | 13 ++++++++++---
 tools/perf/tests/pe-file-parsing.c |  3 ++-
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 78411252b72a..0609c19caabd 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -315,6 +315,9 @@ FEATURE_CHECK_LDFLAGS-libpython := $(PYTHON_EMBED_LDOPTS)
 
 FEATURE_CHECK_LDFLAGS-libaio = -lrt
 
+FEATURE_CHECK_LDFLAGS-disassembler-four-args = -lbfd -lopcodes -ldl
+FEATURE_CHECK_LDFLAGS-disassembler-init-styled = -lbfd -lopcodes -ldl
+
 CORE_CFLAGS += -fno-omit-frame-pointer
 CORE_CFLAGS += -ggdb3
 CORE_CFLAGS += -funwind-tables
@@ -344,8 +347,8 @@ ifneq ($(TCMALLOC),)
 endif
 
 ifeq ($(FEATURES_DUMP),)
-# We will display at the end of this Makefile.config, using $(call feature_display_entries),
-# as we may retry some feature detection here.
+# We will display at the end of this Makefile.config, using $(call feature_display_entries)
+# As we may retry some feature detection here, see the disassembler-four-args case, for instance
   FEATURE_DISPLAY_DEFERRED := 1
 include $(srctree)/tools/build/Makefile.feature
 else
@@ -907,9 +910,13 @@ ifdef BUILD_NONDISTRO
 
     ifeq ($(feature-libbfd-liberty), 1)
       EXTLIBS += -lbfd -lopcodes -liberty
+      FEATURE_CHECK_LDFLAGS-disassembler-four-args += -liberty -ldl
+      FEATURE_CHECK_LDFLAGS-disassembler-init-styled += -liberty -ldl
     else
       ifeq ($(feature-libbfd-liberty-z), 1)
         EXTLIBS += -lbfd -lopcodes -liberty -lz
+        FEATURE_CHECK_LDFLAGS-disassembler-four-args += -liberty -lz -ldl
+        FEATURE_CHECK_LDFLAGS-disassembler-init-styled += -liberty -lz -ldl
       endif
     endif
     $(call feature_check,disassembler-four-args)
@@ -1333,6 +1340,6 @@ endif
 
 # re-generate FEATURE-DUMP as we may have called feature_check, found out
 # extra libraries to add to LDFLAGS of some other test and then redo those
-# tests.
+# tests, see the block about libbfd, disassembler-four-args, for instance.
 $(shell rm -f $(FEATURE_DUMP_FILENAME))
 $(foreach feat,$(FEATURE_TESTS),$(shell echo "$(call feature_assign,$(feat))" >> $(FEATURE_DUMP_FILENAME)))
diff --git a/tools/perf/tests/pe-file-parsing.c b/tools/perf/tests/pe-file-parsing.c
index c09a9fae1689..fff58b220c07 100644
--- a/tools/perf/tests/pe-file-parsing.c
+++ b/tools/perf/tests/pe-file-parsing.c
@@ -34,6 +34,7 @@ static int run_dir(const char *d)
 	struct dso *dso;
 	struct symbol *sym;
 	int ret;
+	size_t idx;
 
 	scnprintf(filename, PATH_MAX, "%s/pe-file.exe", d);
 	ret = filename__read_build_id(filename, &bid);
@@ -61,7 +62,7 @@ static int run_dir(const char *d)
 	TEST_ASSERT_VAL("Failed to load symbols", ret == 0);
 
 	dso__sort_by_name(dso);
-	sym = dso__find_symbol_by_name(dso, "main");
+	sym = dso__find_symbol_by_name(dso, "main", &idx);
 	TEST_ASSERT_VAL("Failed to find main", sym);
 	dso__delete(dso);
 
-- 
2.41.0.162.gfafddb0af9-goog

