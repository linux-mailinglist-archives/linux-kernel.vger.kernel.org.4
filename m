Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36FAA70A4C3
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 04:57:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231338AbjETC46 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 22:56:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231452AbjETC4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 22:56:54 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3EBFE54
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 19:56:25 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1ae875bf125so7935065ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 19:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684551385; x=1687143385;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4I7s+qmJYBYI1fLm0w6VOesYnXvgxr3WYm7dFpfRIoU=;
        b=GCAPdZ64C9vz5vLjvuX58OXtcTqkVp7vX2LVP76fRYGBO/USp71ZN11auaLU36sJ7D
         +9LLOmiMn8Y959F+0BSy0/1mt6LWtr8yX/dsuOQ/lcwtz1FFfZj7W859vBKqYpVkSCOI
         8+XyziEcN8cSDayn+wAAjqdSc1eWgUPgbQDYACljd7eX0XPt1fPzsisb5jwua8lhoMWR
         GtH6XUPkDCWisAQ8PpFhVA4wuJNuwUS1dvtzl1RWdot/8ZyQrck3imUpJlfK1AxOWNFr
         SdvuDz65YrxKJebJqcbEExPeqbJSeBppuKXvV+u22U6duOdxLE8X/H95etP3ffr8DuvQ
         70Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684551385; x=1687143385;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4I7s+qmJYBYI1fLm0w6VOesYnXvgxr3WYm7dFpfRIoU=;
        b=PCi4e+lzoJR0hfW3fjbYSDPKegY3u6FXKFo5SIBJdzD4uR6Kv54kIW1YK+/ZOL9FSf
         1W1zvhEx7A0J5+0wGzW3LL9adrLg/yy4bAOOBvV4uu4ml/SuXgZ83ywtz+aor+zB2LEs
         GBcpuvuuRSvDPLvawG/aw3Gc+S0Zdf4EIZ2nj0SfAdy1PeUkqSvIVdtCFNsyL+rZMT+8
         W66Ywl8aBqsp12DI6mp1HJJ0pj3nDSbj/b5bNm9Qk7M83dzoEeZp9hvpkf/A7x/6F64v
         HtgPzpY653QtRDKDxTf94l3k8eSsqBog4TntWOMhKsbhhHOsXm62J8QcP3eFe4iNBSif
         U1ZA==
X-Gm-Message-State: AC+VfDyxHn7qnx0syRG8jxmWqWDkWBufh6F+j3FMJUFUjDTTs7X51VR4
        nkC0VnfP9yZEfeEnh2CUcob1mw==
X-Google-Smtp-Source: ACHHUZ4QDSj1/rLx/gOlwRttNzGb9xSN5ZInrcrrf5vrh7TbdtA881pKAdo5H+DQDVa7+Xrlnixa/A==
X-Received: by 2002:a17:902:d34a:b0:1a9:f425:5409 with SMTP id l10-20020a170902d34a00b001a9f4255409mr3590297plk.49.1684551385369;
        Fri, 19 May 2023 19:56:25 -0700 (PDT)
Received: from leoy-yangtze.lan ([156.59.236.113])
        by smtp.gmail.com with ESMTPSA id b6-20020a170902d50600b001a95aef9728sm346100plg.19.2023.05.19.19.56.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 19:56:24 -0700 (PDT)
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
        Eric Lin <eric.lin@sifive.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Qi Liu <liuqi115@huawei.com>,
        Sandipan Das <sandipan.das@amd.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-csky@vger.kernel.org,
        linux-riscv@lists.infradead.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v1 5/5] perf parse-regs: Move out arch specific header from util/perf_regs.h
Date:   Sat, 20 May 2023 10:55:37 +0800
Message-Id: <20230520025537.1811986-6-leo.yan@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230520025537.1811986-1-leo.yan@linaro.org>
References: <20230520025537.1811986-1-leo.yan@linaro.org>
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
 tools/perf/arch/arm/util/perf_regs.c        | 1 +
 tools/perf/arch/arm/util/unwind-libdw.c     | 1 +
 tools/perf/arch/arm64/util/machine.c        | 1 +
 tools/perf/arch/arm64/util/perf_regs.c      | 1 +
 tools/perf/arch/arm64/util/unwind-libdw.c   | 1 +
 tools/perf/arch/csky/util/perf_regs.c       | 1 +
 tools/perf/arch/csky/util/unwind-libdw.c    | 1 +
 tools/perf/arch/mips/util/perf_regs.c       | 1 +
 tools/perf/arch/powerpc/util/perf_regs.c    | 1 +
 tools/perf/arch/powerpc/util/unwind-libdw.c | 1 +
 tools/perf/arch/riscv/util/perf_regs.c      | 1 +
 tools/perf/arch/riscv/util/unwind-libdw.c   | 1 +
 tools/perf/arch/s390/util/perf_regs.c       | 1 +
 tools/perf/arch/s390/util/unwind-libdw.c    | 1 +
 tools/perf/arch/x86/util/perf_regs.c        | 1 +
 tools/perf/arch/x86/util/unwind-libdw.c     | 1 +
 tools/perf/util/perf_regs.h                 | 2 --
 17 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/tools/perf/arch/arm/util/perf_regs.c b/tools/perf/arch/arm/util/perf_regs.c
index 0d669dba08c4..244c1d0a46ac 100644
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
index 4490c1b5ea51..34d957c750f7 100644
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
index 35755811316e..053ecbbc7b2f 100644
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
diff --git a/tools/perf/arch/mips/util/perf_regs.c b/tools/perf/arch/mips/util/perf_regs.c
index 2d2bfbb96182..751413b86ebf 100644
--- a/tools/perf/arch/mips/util/perf_regs.c
+++ b/tools/perf/arch/mips/util/perf_regs.c
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
+#include "perf_regs.h"
 #include "../../util/perf_regs.h"
 
 const struct sample_reg sample_reg_masks[] = {
diff --git a/tools/perf/arch/powerpc/util/perf_regs.c b/tools/perf/arch/powerpc/util/perf_regs.c
index e48622d1bc59..3d0f7c238a33 100644
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
index a2aaa46ef741..7b8fafd0598a 100644
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
index 8d79f8c50f4c..0a6358cedb93 100644
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
index a7e21f2a8964..aaf7f606606b 100644
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
index 43b5a6d40e58..894d527edebe 100644
--- a/tools/perf/util/perf_regs.h
+++ b/tools/perf/util/perf_regs.h
@@ -32,8 +32,6 @@ uint64_t arch__reg_sp(void);
 #ifdef HAVE_PERF_REGS_SUPPORT
 extern const struct sample_reg sample_reg_masks[];
 
-#include <perf_regs.h>
-
 #define DWARF_MINIMAL_REGS ((1ULL << arch__reg_ip()) | (1ULL << arch__reg_sp()))
 
 const char *perf_reg_name(int id, const char *arch);
-- 
2.39.2

