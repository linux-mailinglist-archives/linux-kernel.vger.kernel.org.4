Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D9D55B3279
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 10:59:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231408AbiIII5i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 04:57:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230368AbiIII5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 04:57:01 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA4FB138818;
        Fri,  9 Sep 2022 01:55:32 -0700 (PDT)
Received: from kwepemi500013.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MP8qZ3ZXXzmV7c;
        Fri,  9 Sep 2022 16:51:38 +0800 (CST)
Received: from M910t.huawei.com (10.110.54.157) by
 kwepemi500013.china.huawei.com (7.221.188.120) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 9 Sep 2022 16:55:15 +0800
From:   Changbin Du <changbin.du@huawei.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
CC:     Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
        Hui Wang <hw.huiwang@huawei.com>, <changbin.du@gmail.com>,
        Changbin Du <changbin.du@huawei.com>
Subject: [PATCH 1/3] perf: build: introduce the libcapstone
Date:   Fri, 9 Sep 2022 16:48:19 +0800
Message-ID: <20220909084821.7894-2-changbin.du@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220909084821.7894-1-changbin.du@huawei.com>
References: <20220909084821.7894-1-changbin.du@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.110.54.157]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemi500013.china.huawei.com (7.221.188.120)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Later we will use libcapstone to disassemble instructions of samples.

Signed-off-by: Changbin Du <changbin.du@huawei.com>
---
 tools/build/Makefile.feature           |  2 ++
 tools/build/feature/Makefile           |  4 ++++
 tools/build/feature/test-all.c         |  4 ++++
 tools/build/feature/test-libcapstone.c | 11 +++++++++++
 tools/perf/Makefile.config             | 21 +++++++++++++++++++++
 tools/perf/Makefile.perf               |  3 +++
 6 files changed, 45 insertions(+)
 create mode 100644 tools/build/feature/test-libcapstone.c

diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
index fc6ce0b2535a..3d90cf3ec072 100644
--- a/tools/build/Makefile.feature
+++ b/tools/build/Makefile.feature
@@ -84,6 +84,7 @@ FEATURE_TESTS_EXTRA :=                  \
          gtk2-infobar                   \
          hello                          \
          libbabeltrace                  \
+         libcapstone                    \
          libbfd-liberty                 \
          libbfd-liberty-z               \
          libopencsd                     \
@@ -130,6 +131,7 @@ FEATURE_DISPLAY ?=              \
          libcrypto              \
          libunwind              \
          libdw-dwarf-unwind     \
+         libcapstone            \
          zlib                   \
          lzma                   \
          get_cpuid              \
diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index 04b07ff88234..9ada4f8f07b1 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -52,6 +52,7 @@ FILES=                                          \
          test-timerfd.bin                       \
          test-libdw-dwarf-unwind.bin            \
          test-libbabeltrace.bin                 \
+         test-libcapstone.bin			\
          test-compile-32.bin                    \
          test-compile-x32.bin                   \
          test-zlib.bin                          \
@@ -280,6 +281,9 @@ $(OUTPUT)test-libdw-dwarf-unwind.bin:
 $(OUTPUT)test-libbabeltrace.bin:
 	$(BUILD) # -lbabeltrace provided by $(FEATURE_CHECK_LDFLAGS-libbabeltrace)
 
+$(OUTPUT)test-libcapstone.bin:
+	$(BUILD) # -lcapstone provided by $(FEATURE_CHECK_LDFLAGS-libcapstone)
+
 $(OUTPUT)test-compile-32.bin:
 	$(CC) -m32 -o $@ test-compile.c
 
diff --git a/tools/build/feature/test-all.c b/tools/build/feature/test-all.c
index 957c02c7b163..2614f0c7d513 100644
--- a/tools/build/feature/test-all.c
+++ b/tools/build/feature/test-all.c
@@ -130,6 +130,10 @@
 #undef main
 #endif
 
+#define main main_test_libcapstone
+# include "test-libcapstone.c"
+#undef main
+
 #define main main_test_lzma
 # include "test-lzma.c"
 #undef main
diff --git a/tools/build/feature/test-libcapstone.c b/tools/build/feature/test-libcapstone.c
new file mode 100644
index 000000000000..fbe8dba189e9
--- /dev/null
+++ b/tools/build/feature/test-libcapstone.c
@@ -0,0 +1,11 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <capstone/capstone.h>
+
+int main(void)
+{
+	csh handle;
+
+	cs_open(CS_ARCH_X86, CS_MODE_64, &handle);
+	return 0;
+}
diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 2171f02daf59..7e2073e6927e 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -180,6 +180,15 @@ endif
 FEATURE_CHECK_CFLAGS-libbabeltrace := $(LIBBABELTRACE_CFLAGS)
 FEATURE_CHECK_LDFLAGS-libbabeltrace := $(LIBBABELTRACE_LDFLAGS) -lbabeltrace-ctf
 
+# for linking with debug library, run like:
+# make DEBUG=1 LIBCAPSTONE_DIR=/opt/capstone/
+ifdef LIBCAPSTONE_DIR
+  LIBCAPSTONE_CFLAGS  := -I$(LIBCAPSTONE_DIR)/include
+  LIBCAPSTONE_LDFLAGS := -L$(LIBCAPSTONE_DIR)/
+endif
+FEATURE_CHECK_CFLAGS-libcapstone := $(LIBCAPSTONE_CFLAGS)
+FEATURE_CHECK_LDFLAGS-libcapstone := $(LIBCAPSTONE_LDFLAGS) -lcapstone
+
 ifdef LIBZSTD_DIR
   LIBZSTD_CFLAGS  := -I$(LIBZSTD_DIR)/lib
   LIBZSTD_LDFLAGS := -L$(LIBZSTD_DIR)/lib
@@ -1082,6 +1091,18 @@ ifndef NO_LIBBABELTRACE
   endif
 endif
 
+ifndef NO_CAPSTONE
+  $(call feature_check,libcapstone)
+  ifeq ($(feature-libcapstone), 1)
+    CFLAGS += -DHAVE_LIBCAPSTONE_SUPPORT $(LIBCAPSTONE_CFLAGS)
+    LDFLAGS += $(LICAPSTONE_LDFLAGS)
+    EXTLIBS += -lcapstone
+    $(call detected,CONFIG_LIBCAPSTONE)
+  else
+    msg := $(warning No libcapstone found, disables disasm engine support for 'perf script', please install libcapstone-dev/capstone-devel);
+  endif
+endif
+
 ifndef NO_AUXTRACE
   ifeq ($(SRCARCH),x86)
     ifeq ($(feature-get_cpuid), 0)
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index e5921b347153..cfdfe3f17723 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -82,6 +82,9 @@ include ../scripts/utilities.mak
 # Define NO_LIBBABELTRACE if you do not want libbabeltrace support
 # for CTF data format.
 #
+# Define NO_CAPSTONE if you do not want libcapstone support
+# for disasm engine.
+#
 # Define NO_LZMA if you do not want to support compressed (xz) kernel modules
 #
 # Define NO_AUXTRACE if you do not want AUX area tracing support
-- 
2.17.1

