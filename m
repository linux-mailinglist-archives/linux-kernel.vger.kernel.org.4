Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D15D77234D9
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 03:48:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232173AbjFFBsN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 21:48:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232224AbjFFBsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 21:48:05 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 501CE10DD
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 18:47:39 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-652a6cf1918so2652841b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jun 2023 18:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686016037; x=1688608037;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N+507jsXO1BnVewAsLkwzOZpkiaji1CsapmTp9yyUaM=;
        b=dIxbCIi0rJbSLxPR/xfTQsCM+M6jm4HaUgLS+0uDUowhc7bgpH7HzmYEH+r/3F82JE
         Z+O3HYuNoF2wk2r9DwHjkLbLwlRLhDt+FqAxsOa7YI8yuTuFwhnDia/M0RW/UrEz/F6J
         4G8Sdh6Fyn7qpG7+jlBs2DbK1WO3e5X/djFyNZcEXfSjPg5M84z/JXAOY+gosf0ZlzSO
         ditxWwuhEnAQlT77aoag2kWVU7cff8H/I6VbV+AQTQkBqaLDQzZQE+2ES1eN4vZ80B36
         MtBklXlYuEq6QxkzSfoIRdvmKuFnkis40PTVm8FiOR+8o5Mxjj3q2zYJL2L5xPFGbThz
         0ohg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686016037; x=1688608037;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N+507jsXO1BnVewAsLkwzOZpkiaji1CsapmTp9yyUaM=;
        b=UrnDGQMTJNEqDQTkxce0MnhHs1M3ULuwJ79Pl1uxKQg9yki4xBEr+r/qZCFrRpPpxx
         arQd8F3i26Pl11XR0CDoY5N9btOytbn/y7jIF6WLqOliwmutDgwEy7ofH04vRb4SEnVD
         WOH1K8T48SpBV7tUZ9zRo/atdvs8GQa0yaxf0IWKGFeH6ZTKdyab1PwihmMhiGh9ja6A
         c56kOfjVffL6tB9jPigIkH7d92CTXqhYwEDii4Il8VFJVUuHSfauXWKgZMq0pJfLsRcZ
         9usfMrOG/RD8zIpDiEefC7u9o2jcBGNsVZToRQtdUi7hjj3+Ksd4qkQDuuUUt8JAn53h
         zYzQ==
X-Gm-Message-State: AC+VfDwccJPv/L60VTI1jPL3PKXMMGXvn2Z/cAwdDlpXg16UX0yq10JY
        RdmrhVMmNIjMuYARTj7ZsoNdNJ2cdrkoZ1J+2jGdJISu
X-Google-Smtp-Source: ACHHUZ5wNp+vHV2+xqeEpakEuvMMeVGxroHVvlVQpo9lYy5LiPQ7V3r7CA3CKHEXyKL2AYHAW29eDA==
X-Received: by 2002:a05:6a20:549c:b0:116:9255:88eb with SMTP id i28-20020a056a20549c00b00116925588ebmr602780pzk.46.1686016036830;
        Mon, 05 Jun 2023 18:47:16 -0700 (PDT)
Received: from leoy-huanghe.lan ([240e:389:8603:ad00:6600:a29f:6ab:1788])
        by smtp.gmail.com with ESMTPSA id s10-20020a170902a50a00b001a64851087bsm7197805plq.272.2023.06.05.18.47.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 18:47:16 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Guo Ren <guoren@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Huacai Chen <chenhuacai@kernel.org>,
        Ming Wang <wangming01@loongson.cn>,
        Eric Lin <eric.lin@sifive.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Sandipan Das <sandipan.das@amd.com>,
        Ivan Babrou <ivan@cloudflare.com>,
        Fangrui Song <maskray@google.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-csky@vger.kernel.org,
        linux-riscv@lists.infradead.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v2 6/6] perf parse-regs: Move out arch specific header from util/perf_regs.h
Date:   Tue,  6 Jun 2023 09:45:59 +0800
Message-Id: <20230606014559.21783-7-leo.yan@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230606014559.21783-1-leo.yan@linaro.org>
References: <20230606014559.21783-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

util/perf_regs.h includes another perf_regs.h:

  #include <perf_regs.h>

Here it includes architecture specific header, for example, if we build
arm64 target, the header tools/perf/arch/arm64/include/perf_regs.h is
included.

We use this implicit way to include architecture specific header, which
is not directive; furthermore, util/perf_regs.c is coupled with the
architecture specific definitions.

This patch moves out arch specific header from util/perf_regs.h for
generalizing the 'util' folder, as a result, the source files in 'arch'
folder explicitly include architecture's perf_regs.h.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/arch/arm/util/perf_regs.c          | 1 +
 tools/perf/arch/arm/util/unwind-libdw.c       | 1 +
 tools/perf/arch/arm64/util/machine.c          | 1 +
 tools/perf/arch/arm64/util/perf_regs.c        | 1 +
 tools/perf/arch/arm64/util/unwind-libdw.c     | 1 +
 tools/perf/arch/csky/util/perf_regs.c         | 1 +
 tools/perf/arch/csky/util/unwind-libdw.c      | 1 +
 tools/perf/arch/loongarch/util/perf_regs.c    | 1 +
 tools/perf/arch/loongarch/util/unwind-libdw.c | 1 +
 tools/perf/arch/mips/util/perf_regs.c         | 1 +
 tools/perf/arch/powerpc/util/perf_regs.c      | 1 +
 tools/perf/arch/powerpc/util/unwind-libdw.c   | 1 +
 tools/perf/arch/riscv/util/perf_regs.c        | 1 +
 tools/perf/arch/riscv/util/unwind-libdw.c     | 1 +
 tools/perf/arch/s390/util/perf_regs.c         | 1 +
 tools/perf/arch/s390/util/unwind-libdw.c      | 1 +
 tools/perf/arch/x86/util/perf_regs.c          | 1 +
 tools/perf/arch/x86/util/unwind-libdw.c       | 1 +
 tools/perf/util/perf_regs.h                   | 2 --
 19 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/tools/perf/arch/arm/util/perf_regs.c b/tools/perf/arch/arm/util/perf_regs.c
index d9d4777bf7f9..2c56e8b56ddf 100644
--- a/tools/perf/arch/arm/util/perf_regs.c
+++ b/tools/perf/arch/arm/util/perf_regs.c
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
+#include "perf_regs.h"
 #include "../../../util/perf_regs.h"
 
 const struct sample_reg sample_reg_masks[] = {
diff --git a/tools/perf/arch/arm/util/unwind-libdw.c b/tools/perf/arch/arm/util/unwind-libdw.c
index 1834a0cd9ce3..4e02cef461e3 100644
--- a/tools/perf/arch/arm/util/unwind-libdw.c
+++ b/tools/perf/arch/arm/util/unwind-libdw.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <elfutils/libdwfl.h>
+#include "perf_regs.h"
 #include "../../../util/unwind-libdw.h"
 #include "../../../util/perf_regs.h"
 #include "../../../util/sample.h"
diff --git a/tools/perf/arch/arm64/util/machine.c b/tools/perf/arch/arm64/util/machine.c
index 235a0a1e1ec7..ba1144366e85 100644
--- a/tools/perf/arch/arm64/util/machine.c
+++ b/tools/perf/arch/arm64/util/machine.c
@@ -6,6 +6,7 @@
 #include "debug.h"
 #include "symbol.h"
 #include "callchain.h"
+#include "perf_regs.h"
 #include "record.h"
 #include "util/perf_regs.h"
 
diff --git a/tools/perf/arch/arm64/util/perf_regs.c b/tools/perf/arch/arm64/util/perf_regs.c
index 76e2e30702cd..1b79d8eab22f 100644
--- a/tools/perf/arch/arm64/util/perf_regs.c
+++ b/tools/perf/arch/arm64/util/perf_regs.c
@@ -6,6 +6,7 @@
 #include <linux/kernel.h>
 #include <linux/zalloc.h>
 
+#include "perf_regs.h"
 #include "../../../perf-sys.h"
 #include "../../../util/debug.h"
 #include "../../../util/event.h"
diff --git a/tools/perf/arch/arm64/util/unwind-libdw.c b/tools/perf/arch/arm64/util/unwind-libdw.c
index 09385081bb03..e056d50ab42e 100644
--- a/tools/perf/arch/arm64/util/unwind-libdw.c
+++ b/tools/perf/arch/arm64/util/unwind-libdw.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <elfutils/libdwfl.h>
+#include "perf_regs.h"
 #include "../../../util/unwind-libdw.h"
 #include "../../../util/perf_regs.h"
 #include "../../../util/sample.h"
diff --git a/tools/perf/arch/csky/util/perf_regs.c b/tools/perf/arch/csky/util/perf_regs.c
index b17fc30abb29..c0877c264d49 100644
--- a/tools/perf/arch/csky/util/perf_regs.c
+++ b/tools/perf/arch/csky/util/perf_regs.c
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
+#include "perf_regs.h"
 #include "../../util/perf_regs.h"
 
 const struct sample_reg sample_reg_masks[] = {
diff --git a/tools/perf/arch/csky/util/unwind-libdw.c b/tools/perf/arch/csky/util/unwind-libdw.c
index 4bb4a06776e4..79df4374ab18 100644
--- a/tools/perf/arch/csky/util/unwind-libdw.c
+++ b/tools/perf/arch/csky/util/unwind-libdw.c
@@ -2,6 +2,7 @@
 // Copyright (C) 2019 Hangzhou C-SKY Microsystems co.,ltd.
 
 #include <elfutils/libdwfl.h>
+#include "perf_regs.h"
 #include "../../util/unwind-libdw.h"
 #include "../../util/perf_regs.h"
 #include "../../util/event.h"
diff --git a/tools/perf/arch/loongarch/util/perf_regs.c b/tools/perf/arch/loongarch/util/perf_regs.c
index d9d4777bf7f9..2c56e8b56ddf 100644
--- a/tools/perf/arch/loongarch/util/perf_regs.c
+++ b/tools/perf/arch/loongarch/util/perf_regs.c
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
+#include "perf_regs.h"
 #include "../../../util/perf_regs.h"
 
 const struct sample_reg sample_reg_masks[] = {
diff --git a/tools/perf/arch/loongarch/util/unwind-libdw.c b/tools/perf/arch/loongarch/util/unwind-libdw.c
index a9415385230a..7b3b9a4b21f8 100644
--- a/tools/perf/arch/loongarch/util/unwind-libdw.c
+++ b/tools/perf/arch/loongarch/util/unwind-libdw.c
@@ -2,6 +2,7 @@
 /* Copyright (C) 2020-2023 Loongson Technology Corporation Limited */
 
 #include <elfutils/libdwfl.h>
+#include "perf_regs.h"
 #include "../../util/unwind-libdw.h"
 #include "../../util/perf_regs.h"
 #include "../../util/sample.h"
diff --git a/tools/perf/arch/mips/util/perf_regs.c b/tools/perf/arch/mips/util/perf_regs.c
index b17fc30abb29..c0877c264d49 100644
--- a/tools/perf/arch/mips/util/perf_regs.c
+++ b/tools/perf/arch/mips/util/perf_regs.c
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
+#include "perf_regs.h"
 #include "../../util/perf_regs.h"
 
 const struct sample_reg sample_reg_masks[] = {
diff --git a/tools/perf/arch/powerpc/util/perf_regs.c b/tools/perf/arch/powerpc/util/perf_regs.c
index 1d264bf55955..b38aa056eea0 100644
--- a/tools/perf/arch/powerpc/util/perf_regs.c
+++ b/tools/perf/arch/powerpc/util/perf_regs.c
@@ -4,6 +4,7 @@
 #include <regex.h>
 #include <linux/zalloc.h>
 
+#include "perf_regs.h"
 #include "../../../util/perf_regs.h"
 #include "../../../util/debug.h"
 #include "../../../util/event.h"
diff --git a/tools/perf/arch/powerpc/util/unwind-libdw.c b/tools/perf/arch/powerpc/util/unwind-libdw.c
index e616642c754c..e9a5a8bb67d9 100644
--- a/tools/perf/arch/powerpc/util/unwind-libdw.c
+++ b/tools/perf/arch/powerpc/util/unwind-libdw.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <elfutils/libdwfl.h>
 #include <linux/kernel.h>
+#include "perf_regs.h"
 #include "../../../util/unwind-libdw.h"
 #include "../../../util/perf_regs.h"
 #include "../../../util/sample.h"
diff --git a/tools/perf/arch/riscv/util/perf_regs.c b/tools/perf/arch/riscv/util/perf_regs.c
index b17fc30abb29..c0877c264d49 100644
--- a/tools/perf/arch/riscv/util/perf_regs.c
+++ b/tools/perf/arch/riscv/util/perf_regs.c
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
+#include "perf_regs.h"
 #include "../../util/perf_regs.h"
 
 const struct sample_reg sample_reg_masks[] = {
diff --git a/tools/perf/arch/riscv/util/unwind-libdw.c b/tools/perf/arch/riscv/util/unwind-libdw.c
index 54a198714eb8..5c98010d8b59 100644
--- a/tools/perf/arch/riscv/util/unwind-libdw.c
+++ b/tools/perf/arch/riscv/util/unwind-libdw.c
@@ -2,6 +2,7 @@
 /* Copyright (C) 2019 Hangzhou C-SKY Microsystems co.,ltd. */
 
 #include <elfutils/libdwfl.h>
+#include "perf_regs.h"
 #include "../../util/unwind-libdw.h"
 #include "../../util/perf_regs.h"
 #include "../../util/sample.h"
diff --git a/tools/perf/arch/s390/util/perf_regs.c b/tools/perf/arch/s390/util/perf_regs.c
index b17fc30abb29..c0877c264d49 100644
--- a/tools/perf/arch/s390/util/perf_regs.c
+++ b/tools/perf/arch/s390/util/perf_regs.c
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
+#include "perf_regs.h"
 #include "../../util/perf_regs.h"
 
 const struct sample_reg sample_reg_masks[] = {
diff --git a/tools/perf/arch/s390/util/unwind-libdw.c b/tools/perf/arch/s390/util/unwind-libdw.c
index 7d92452d5287..f50fb6dbb35c 100644
--- a/tools/perf/arch/s390/util/unwind-libdw.c
+++ b/tools/perf/arch/s390/util/unwind-libdw.c
@@ -5,6 +5,7 @@
 #include "../../util/event.h"
 #include "../../util/sample.h"
 #include "dwarf-regs-table.h"
+#include "perf_regs.h"
 
 
 bool libdw__arch_set_initial_registers(Dwfl_Thread *thread, void *arg)
diff --git a/tools/perf/arch/x86/util/perf_regs.c b/tools/perf/arch/x86/util/perf_regs.c
index 218747a8b039..b813502a2727 100644
--- a/tools/perf/arch/x86/util/perf_regs.c
+++ b/tools/perf/arch/x86/util/perf_regs.c
@@ -5,6 +5,7 @@
 #include <linux/kernel.h>
 #include <linux/zalloc.h>
 
+#include "perf_regs.h"
 #include "../../../perf-sys.h"
 #include "../../../util/perf_regs.h"
 #include "../../../util/debug.h"
diff --git a/tools/perf/arch/x86/util/unwind-libdw.c b/tools/perf/arch/x86/util/unwind-libdw.c
index ef71e8bf80bf..edb77e20e083 100644
--- a/tools/perf/arch/x86/util/unwind-libdw.c
+++ b/tools/perf/arch/x86/util/unwind-libdw.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <elfutils/libdwfl.h>
+#include "perf_regs.h"
 #include "../../../util/unwind-libdw.h"
 #include "../../../util/perf_regs.h"
 #include "util/sample.h"
diff --git a/tools/perf/util/perf_regs.h b/tools/perf/util/perf_regs.h
index 8583c52572b1..4f6a3c1ba901 100644
--- a/tools/perf/util/perf_regs.h
+++ b/tools/perf/util/perf_regs.h
@@ -30,8 +30,6 @@ uint64_t arch__user_reg_mask(void);
 #ifdef HAVE_PERF_REGS_SUPPORT
 extern const struct sample_reg sample_reg_masks[];
 
-#include <perf_regs.h>
-
 #define DWARF_MINIMAL_REGS(arch)	\
 	((1ULL << perf_arch_reg_ip(arch)) | (1ULL << perf_arch_reg_sp(arch)))
 
-- 
2.34.1

