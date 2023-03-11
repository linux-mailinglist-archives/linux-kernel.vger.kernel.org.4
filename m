Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCDFD6B5926
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 07:59:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbjCKG7w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 01:59:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230095AbjCKG7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 01:59:42 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AE8F11F2ED
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 22:59:06 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id j125-20020a25d283000000b008f257b16d71so8095164ybg.15
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 22:59:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678517945;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TeLjpZEBElZPq770pHQ3cqTtDu48PrMd6iajkLxZXoU=;
        b=Ua++G/pPd+SVDJwvl19ZJsDG1Or/TZ/BFSKNdrAmYWdlWCZ/iFomFaBUwI0T5lTgOm
         xWfKU5/Bwli59xtjTjo+LvLnIbOmWR8cgnp7hb1NjIlSzo+khMAZRqdJ7g6wNgAZ//6K
         oZdtIP7+Kdy3nvqTB6B04pijjfOeie0Hf1QccsJhVwceP78G/J1wbT+FQNpjgHIfl+OH
         FWBtsQo9zfspq9m+CreQOdsqyBGbr0Q2nNsJRtvkSqrHutbXWoGADqwcJbESnMQDEnv1
         oiiRTPBevzcT/2RXis5IoSDZyeRElEE8Uf3/yhtx94aYTkUDApVo7blkQ5nkkY/NTzAm
         cpBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678517945;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TeLjpZEBElZPq770pHQ3cqTtDu48PrMd6iajkLxZXoU=;
        b=F32wmOb3zXyFXhxLYhWh8BlBjLEp6X0i8UZXSI/ZMU6XFuwMZ1lh/oPHTWpzjRlLHL
         46l17gYoI2piECEw1kvdMeQEI+KybATjVvlKLHBURZNG3TGQVV4a9lWsi+nSUKwECGfk
         ALKYi71OfhvYPzx294V2/RjoytoWrNxXL5sRAXNg8Wgz/2VYCD2A6cNwYXFWhYp02nNr
         cmEF/CTpwoKuZgpUJ++OzOnZB2hXzSzed8kUay+fvhGyRGUKBGcpJqesoypOO/g9IQ2n
         CF1sqCqSsnDC1dBBfsgTy+k/e6r/iqpzIGfTAgPNiob1Ve5n7uPtbYe1yYwNLh+1GA7j
         j2ww==
X-Gm-Message-State: AO0yUKWZm5WXCsvADsZAn+YW9e81KVagJgk8wvgkxFD7Sm+AhQFaU7uf
        Z/1oPxqX8Ubv6p9x0RMEOAJXcnueHyE0
X-Google-Smtp-Source: AK7set/6+p+yFgDiDQyRYorbvgodf9XCwu4OA2mDN8JFQ4h3Y3vVuSxNelxVt3B5EzESzr56CUvMk0R6m5mw
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:a11d:a763:a328:f2d6])
 (user=irogers job=sendgmr) by 2002:a81:4328:0:b0:541:642f:709c with SMTP id
 q40-20020a814328000000b00541642f709cmr2ywa.388.1678517944974; Fri, 10 Mar
 2023 22:59:04 -0800 (PST)
Date:   Fri, 10 Mar 2023 22:57:48 -0800
In-Reply-To: <20230311065753.3012826-1-irogers@google.com>
Message-Id: <20230311065753.3012826-9-irogers@google.com>
Mime-Version: 1.0
References: <20230311065753.3012826-1-irogers@google.com>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
Subject: [PATCH v1 08/13] tools build: Add feature test for abi::__cxa_demangle
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Quentin Monnet <quentin@isovalent.com>,
        Andres Freund <andres@anarazel.de>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Pavithra Gurushankar <gpavithrasha@gmail.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        "=?UTF-8?q?Martin=20Li=C5=A1ka?=" <mliska@suse.cz>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        llvm@lists.linux.dev
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

cxxabi.h is part of libsdtc++ and LLVM's libcxx, providing
abi::__cxa_demangle a portable C++ demangler. Add a feature test to
detect that the function is available.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/build/Makefile.feature              |  1 +
 tools/build/feature/Makefile              |  4 ++++
 tools/build/feature/test-cxa-demangle.cpp | 17 +++++++++++++++++
 3 files changed, 22 insertions(+)
 create mode 100644 tools/build/feature/test-cxa-demangle.cpp

diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
index 38f8851bd7cb..214622d7537c 100644
--- a/tools/build/Makefile.feature
+++ b/tools/build/Makefile.feature
@@ -80,6 +80,7 @@ FEATURE_TESTS_EXTRA :=                  \
          compile-32                     \
          compile-x32                    \
          cplus-demangle                 \
+         cxa-demangle                   \
          gtk2                           \
          gtk2-infobar                   \
          hello                          \
diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index dc9323e01e42..0a3b9281f8b0 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -23,6 +23,7 @@ FILES=                                          \
          test-libbfd-liberty.bin                \
          test-libbfd-liberty-z.bin              \
          test-cplus-demangle.bin                \
+         test-cxa-demangle.bin                  \
          test-libcap.bin			\
          test-libelf.bin                        \
          test-libelf-getphdrnum.bin             \
@@ -262,6 +263,9 @@ $(OUTPUT)test-libbfd-liberty-z.bin:
 $(OUTPUT)test-cplus-demangle.bin:
 	$(BUILD) -liberty
 
+$(OUTPUT)test-cxa-demangle.bin:
+	$(BUILDXX)
+
 $(OUTPUT)test-backtrace.bin:
 	$(BUILD)
 
diff --git a/tools/build/feature/test-cxa-demangle.cpp b/tools/build/feature/test-cxa-demangle.cpp
new file mode 100644
index 000000000000..a3e712f65c37
--- /dev/null
+++ b/tools/build/feature/test-cxa-demangle.cpp
@@ -0,0 +1,17 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <stdio.h>
+#include <stdlib.h>
+#include <cxxabi.h>
+
+int main(void)
+{
+  size_t len = 256;
+  char *output = (char*)malloc(len);
+        int status;
+
+        output = abi::__cxa_demangle("FieldName__9ClassNameFd", output, &len, &status);
+
+        printf("demangled symbol: {%s}\n", output);
+
+        return 0;
+}
-- 
2.40.0.rc1.284.g88254d51c5-goog

