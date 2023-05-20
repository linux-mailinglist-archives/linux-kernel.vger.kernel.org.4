Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3932370A4B9
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 04:56:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231178AbjETC4J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 22:56:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbjETC4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 22:56:06 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 080D4E7C
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 19:55:58 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-64d1e96c082so1852401b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 19:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684551358; x=1687143358;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k+pFsWdDbgYeBVQTD1I0GAGnn5e5tXnYflu5DAZrs18=;
        b=lq+5D7HC3eX3OE2WgbdQvBfubqb5AmPOeTazyPR6/f44K6ajeyFHxAwtoByjUpjSfH
         NrJFpRhUyhPsOyExXrgfFK2gkOELqPc9v9QEmPNstsZm+hyI5F1xal5z64wVncHfU7D2
         6/EJUb7u1p5Iy7KrbO3Js5Vs7uRiaiyIs7mstrYo3zQZY89vbp/zdPJdjSCVzFoPbcxF
         LGOFXd/9Uo0V4fEEeC479iN+CfDiw0NpNn8H7orBJcMSpUQpgOCBJSBnJGxcLqnDxju4
         I4GPKxdTgrMYNoNH1+RTYUoa/YzzHxqIgmKd3sZ9U5ir340WfhAiy+ZlMuZCCyiAlnq+
         ULTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684551358; x=1687143358;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k+pFsWdDbgYeBVQTD1I0GAGnn5e5tXnYflu5DAZrs18=;
        b=htKmjJfh12fdzd6bIk/MliUf0fIEgHvybAUMxlKq4ICYCw3uKXefvWHx3OsV/RhOBN
         nWtuQTHiYt3tL2K8QejE1MJIsnJBaCsSBVX4M/g7pgdcBUa++BAkO+hWkzmDoUeOHxTz
         LByP7YUDpbnHBt82X3dLFMnuE44LlRX5EDnn0bt18UK9kHytNJy4Oh/uMfUMGdSGAZvI
         S1iN7/r+7+xW66tqs9GSsxfKcnD1ceVHAdEgX9nAZy0CrQ9UZleIBMSEXQDLYalzk0E7
         PXocWKxzsQClwuYCShy4/gBdrHc6ucr0aRfAk3jksvbwXTy3SwNz4sX5dTaJwp73wUEg
         la5Q==
X-Gm-Message-State: AC+VfDy8hRhIe/M16Ew4VYuF9iNr2EYh7k0ZkUQl85SO6u8VcVANOtfW
        xR/+FKX8W92D8aZwdpWO1mvYRA==
X-Google-Smtp-Source: ACHHUZ6No0hJ2x2ygVZbkFwvpBGDqu82k8lTQnwuVFLlR0xrbGM5s9AujWB2MwZYJtrCaYyXR9lo6g==
X-Received: by 2002:a17:902:7785:b0:1a1:dd2a:fe6c with SMTP id o5-20020a170902778500b001a1dd2afe6cmr4261259pll.53.1684551358021;
        Fri, 19 May 2023 19:55:58 -0700 (PDT)
Received: from leoy-yangtze.lan ([156.59.236.113])
        by smtp.gmail.com with ESMTPSA id b6-20020a170902d50600b001a95aef9728sm346100plg.19.2023.05.19.19.55.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 19:55:57 -0700 (PDT)
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
Subject: [PATCH v1 1/5] perf parse-regs: Refactor arch register parsing functions
Date:   Sat, 20 May 2023 10:55:33 +0800
Message-Id: <20230520025537.1811986-2-leo.yan@linaro.org>
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

Every architecture has a specific register parsing function for
returning register name based on register index, to support cross
analysis (e.g. we use perf x86 binary to parse Arm64's perf data), we
build all these register parsing functions into the tool, this is why
we place all related functions into util/perf_regs.c.

Unfortunately, since util/perf_regs.c needs to include every arch's
perf_regs.h, this easily introduces duplicated definitions coming from
multiple headers, finally it's fragile for building and difficult for
maintenance.

We cannot simply move these register parsing functions into the
corresponding 'arch' folder, the folder is only conditionally built
based on the target architecture.

Therefore, this commit creates a new folder util/perf-regs-arch/ and
uses a dedicated source file to keep every architecture's register
parsing function to avoid definition conflicts.

This is only a refactoring, no functionality change is expected.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/util/Build                         |   1 +
 tools/perf/util/perf-regs-arch/Build          |   8 +
 .../util/perf-regs-arch/perf_regs_aarch64.c   |  86 +++
 .../perf/util/perf-regs-arch/perf_regs_arm.c  |  50 ++
 .../perf/util/perf-regs-arch/perf_regs_csky.c |  90 +++
 .../perf/util/perf-regs-arch/perf_regs_mips.c |  77 +++
 .../util/perf-regs-arch/perf_regs_powerpc.c   | 135 ++++
 .../util/perf-regs-arch/perf_regs_riscv.c     |  82 +++
 .../perf/util/perf-regs-arch/perf_regs_s390.c |  86 +++
 .../perf/util/perf-regs-arch/perf_regs_x86.c  |  88 +++
 tools/perf/util/perf_regs.c                   | 642 ------------------
 tools/perf/util/perf_regs.h                   |   8 +
 12 files changed, 711 insertions(+), 642 deletions(-)
 create mode 100644 tools/perf/util/perf-regs-arch/Build
 create mode 100644 tools/perf/util/perf-regs-arch/perf_regs_aarch64.c
 create mode 100644 tools/perf/util/perf-regs-arch/perf_regs_arm.c
 create mode 100644 tools/perf/util/perf-regs-arch/perf_regs_csky.c
 create mode 100644 tools/perf/util/perf-regs-arch/perf_regs_mips.c
 create mode 100644 tools/perf/util/perf-regs-arch/perf_regs_powerpc.c
 create mode 100644 tools/perf/util/perf-regs-arch/perf_regs_riscv.c
 create mode 100644 tools/perf/util/perf-regs-arch/perf_regs_s390.c
 create mode 100644 tools/perf/util/perf-regs-arch/perf_regs_x86.c

diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index bd18fe5f2719..82b2d6b8d68c 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -28,6 +28,7 @@ perf-y += parse-events-hybrid.o
 perf-y += print-events.o
 perf-y += tracepoint.o
 perf-y += perf_regs.o
+perf-y += perf-regs-arch/
 perf-y += path.o
 perf-y += print_binary.o
 perf-y += rlimit.o
diff --git a/tools/perf/util/perf-regs-arch/Build b/tools/perf/util/perf-regs-arch/Build
new file mode 100644
index 000000000000..5f1ac8063548
--- /dev/null
+++ b/tools/perf/util/perf-regs-arch/Build
@@ -0,0 +1,8 @@
+perf-y += perf_regs_aarch64.o
+perf-y += perf_regs_arm.o
+perf-y += perf_regs_csky.o
+perf-y += perf_regs_mips.o
+perf-y += perf_regs_powerpc.o
+perf-y += perf_regs_riscv.o
+perf-y += perf_regs_s390.o
+perf-y += perf_regs_x86.o
diff --git a/tools/perf/util/perf-regs-arch/perf_regs_aarch64.c b/tools/perf/util/perf-regs-arch/perf_regs_aarch64.c
new file mode 100644
index 000000000000..c02c045af46e
--- /dev/null
+++ b/tools/perf/util/perf-regs-arch/perf_regs_aarch64.c
@@ -0,0 +1,86 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#ifdef HAVE_PERF_REGS_SUPPORT
+
+#include "../perf_regs.h"
+#include "../../../arch/arm64/include/uapi/asm/perf_regs.h"
+
+const char *__perf_reg_name_arm64(int id)
+{
+	switch (id) {
+	case PERF_REG_ARM64_X0:
+		return "x0";
+	case PERF_REG_ARM64_X1:
+		return "x1";
+	case PERF_REG_ARM64_X2:
+		return "x2";
+	case PERF_REG_ARM64_X3:
+		return "x3";
+	case PERF_REG_ARM64_X4:
+		return "x4";
+	case PERF_REG_ARM64_X5:
+		return "x5";
+	case PERF_REG_ARM64_X6:
+		return "x6";
+	case PERF_REG_ARM64_X7:
+		return "x7";
+	case PERF_REG_ARM64_X8:
+		return "x8";
+	case PERF_REG_ARM64_X9:
+		return "x9";
+	case PERF_REG_ARM64_X10:
+		return "x10";
+	case PERF_REG_ARM64_X11:
+		return "x11";
+	case PERF_REG_ARM64_X12:
+		return "x12";
+	case PERF_REG_ARM64_X13:
+		return "x13";
+	case PERF_REG_ARM64_X14:
+		return "x14";
+	case PERF_REG_ARM64_X15:
+		return "x15";
+	case PERF_REG_ARM64_X16:
+		return "x16";
+	case PERF_REG_ARM64_X17:
+		return "x17";
+	case PERF_REG_ARM64_X18:
+		return "x18";
+	case PERF_REG_ARM64_X19:
+		return "x19";
+	case PERF_REG_ARM64_X20:
+		return "x20";
+	case PERF_REG_ARM64_X21:
+		return "x21";
+	case PERF_REG_ARM64_X22:
+		return "x22";
+	case PERF_REG_ARM64_X23:
+		return "x23";
+	case PERF_REG_ARM64_X24:
+		return "x24";
+	case PERF_REG_ARM64_X25:
+		return "x25";
+	case PERF_REG_ARM64_X26:
+		return "x26";
+	case PERF_REG_ARM64_X27:
+		return "x27";
+	case PERF_REG_ARM64_X28:
+		return "x28";
+	case PERF_REG_ARM64_X29:
+		return "x29";
+	case PERF_REG_ARM64_SP:
+		return "sp";
+	case PERF_REG_ARM64_LR:
+		return "lr";
+	case PERF_REG_ARM64_PC:
+		return "pc";
+	case PERF_REG_ARM64_VG:
+		return "vg";
+	default:
+		return NULL;
+	}
+
+	return NULL;
+}
+
+#endif
diff --git a/tools/perf/util/perf-regs-arch/perf_regs_arm.c b/tools/perf/util/perf-regs-arch/perf_regs_arm.c
new file mode 100644
index 000000000000..e8b0fcd72f34
--- /dev/null
+++ b/tools/perf/util/perf-regs-arch/perf_regs_arm.c
@@ -0,0 +1,50 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#ifdef HAVE_PERF_REGS_SUPPORT
+
+#include "../perf_regs.h"
+#include "../../../arch/arm/include/uapi/asm/perf_regs.h"
+
+const char *__perf_reg_name_arm(int id)
+{
+	switch (id) {
+	case PERF_REG_ARM_R0:
+		return "r0";
+	case PERF_REG_ARM_R1:
+		return "r1";
+	case PERF_REG_ARM_R2:
+		return "r2";
+	case PERF_REG_ARM_R3:
+		return "r3";
+	case PERF_REG_ARM_R4:
+		return "r4";
+	case PERF_REG_ARM_R5:
+		return "r5";
+	case PERF_REG_ARM_R6:
+		return "r6";
+	case PERF_REG_ARM_R7:
+		return "r7";
+	case PERF_REG_ARM_R8:
+		return "r8";
+	case PERF_REG_ARM_R9:
+		return "r9";
+	case PERF_REG_ARM_R10:
+		return "r10";
+	case PERF_REG_ARM_FP:
+		return "fp";
+	case PERF_REG_ARM_IP:
+		return "ip";
+	case PERF_REG_ARM_SP:
+		return "sp";
+	case PERF_REG_ARM_LR:
+		return "lr";
+	case PERF_REG_ARM_PC:
+		return "pc";
+	default:
+		return NULL;
+	}
+
+	return NULL;
+}
+
+#endif
diff --git a/tools/perf/util/perf-regs-arch/perf_regs_csky.c b/tools/perf/util/perf-regs-arch/perf_regs_csky.c
new file mode 100644
index 000000000000..e343b1cef7ba
--- /dev/null
+++ b/tools/perf/util/perf-regs-arch/perf_regs_csky.c
@@ -0,0 +1,90 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#ifdef HAVE_PERF_REGS_SUPPORT
+
+#include "../perf_regs.h"
+#include "../../arch/csky/include/uapi/asm/perf_regs.h"
+
+const char *__perf_reg_name_csky(int id)
+{
+	switch (id) {
+	case PERF_REG_CSKY_A0:
+		return "a0";
+	case PERF_REG_CSKY_A1:
+		return "a1";
+	case PERF_REG_CSKY_A2:
+		return "a2";
+	case PERF_REG_CSKY_A3:
+		return "a3";
+	case PERF_REG_CSKY_REGS0:
+		return "regs0";
+	case PERF_REG_CSKY_REGS1:
+		return "regs1";
+	case PERF_REG_CSKY_REGS2:
+		return "regs2";
+	case PERF_REG_CSKY_REGS3:
+		return "regs3";
+	case PERF_REG_CSKY_REGS4:
+		return "regs4";
+	case PERF_REG_CSKY_REGS5:
+		return "regs5";
+	case PERF_REG_CSKY_REGS6:
+		return "regs6";
+	case PERF_REG_CSKY_REGS7:
+		return "regs7";
+	case PERF_REG_CSKY_REGS8:
+		return "regs8";
+	case PERF_REG_CSKY_REGS9:
+		return "regs9";
+	case PERF_REG_CSKY_SP:
+		return "sp";
+	case PERF_REG_CSKY_LR:
+		return "lr";
+	case PERF_REG_CSKY_PC:
+		return "pc";
+#if defined(__CSKYABIV2__)
+	case PERF_REG_CSKY_EXREGS0:
+		return "exregs0";
+	case PERF_REG_CSKY_EXREGS1:
+		return "exregs1";
+	case PERF_REG_CSKY_EXREGS2:
+		return "exregs2";
+	case PERF_REG_CSKY_EXREGS3:
+		return "exregs3";
+	case PERF_REG_CSKY_EXREGS4:
+		return "exregs4";
+	case PERF_REG_CSKY_EXREGS5:
+		return "exregs5";
+	case PERF_REG_CSKY_EXREGS6:
+		return "exregs6";
+	case PERF_REG_CSKY_EXREGS7:
+		return "exregs7";
+	case PERF_REG_CSKY_EXREGS8:
+		return "exregs8";
+	case PERF_REG_CSKY_EXREGS9:
+		return "exregs9";
+	case PERF_REG_CSKY_EXREGS10:
+		return "exregs10";
+	case PERF_REG_CSKY_EXREGS11:
+		return "exregs11";
+	case PERF_REG_CSKY_EXREGS12:
+		return "exregs12";
+	case PERF_REG_CSKY_EXREGS13:
+		return "exregs13";
+	case PERF_REG_CSKY_EXREGS14:
+		return "exregs14";
+	case PERF_REG_CSKY_TLS:
+		return "tls";
+	case PERF_REG_CSKY_HI:
+		return "hi";
+	case PERF_REG_CSKY_LO:
+		return "lo";
+#endif
+	default:
+		return NULL;
+	}
+
+	return NULL;
+}
+
+#endif
diff --git a/tools/perf/util/perf-regs-arch/perf_regs_mips.c b/tools/perf/util/perf-regs-arch/perf_regs_mips.c
new file mode 100644
index 000000000000..f48fbca2f947
--- /dev/null
+++ b/tools/perf/util/perf-regs-arch/perf_regs_mips.c
@@ -0,0 +1,77 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#ifdef HAVE_PERF_REGS_SUPPORT
+
+#include "../perf_regs.h"
+#include "../../../arch/mips/include/uapi/asm/perf_regs.h"
+
+const char *__perf_reg_name_mips(int id)
+{
+	switch (id) {
+	case PERF_REG_MIPS_PC:
+		return "PC";
+	case PERF_REG_MIPS_R1:
+		return "$1";
+	case PERF_REG_MIPS_R2:
+		return "$2";
+	case PERF_REG_MIPS_R3:
+		return "$3";
+	case PERF_REG_MIPS_R4:
+		return "$4";
+	case PERF_REG_MIPS_R5:
+		return "$5";
+	case PERF_REG_MIPS_R6:
+		return "$6";
+	case PERF_REG_MIPS_R7:
+		return "$7";
+	case PERF_REG_MIPS_R8:
+		return "$8";
+	case PERF_REG_MIPS_R9:
+		return "$9";
+	case PERF_REG_MIPS_R10:
+		return "$10";
+	case PERF_REG_MIPS_R11:
+		return "$11";
+	case PERF_REG_MIPS_R12:
+		return "$12";
+	case PERF_REG_MIPS_R13:
+		return "$13";
+	case PERF_REG_MIPS_R14:
+		return "$14";
+	case PERF_REG_MIPS_R15:
+		return "$15";
+	case PERF_REG_MIPS_R16:
+		return "$16";
+	case PERF_REG_MIPS_R17:
+		return "$17";
+	case PERF_REG_MIPS_R18:
+		return "$18";
+	case PERF_REG_MIPS_R19:
+		return "$19";
+	case PERF_REG_MIPS_R20:
+		return "$20";
+	case PERF_REG_MIPS_R21:
+		return "$21";
+	case PERF_REG_MIPS_R22:
+		return "$22";
+	case PERF_REG_MIPS_R23:
+		return "$23";
+	case PERF_REG_MIPS_R24:
+		return "$24";
+	case PERF_REG_MIPS_R25:
+		return "$25";
+	case PERF_REG_MIPS_R28:
+		return "$28";
+	case PERF_REG_MIPS_R29:
+		return "$29";
+	case PERF_REG_MIPS_R30:
+		return "$30";
+	case PERF_REG_MIPS_R31:
+		return "$31";
+	default:
+		break;
+	}
+	return NULL;
+}
+
+#endif
diff --git a/tools/perf/util/perf-regs-arch/perf_regs_powerpc.c b/tools/perf/util/perf-regs-arch/perf_regs_powerpc.c
new file mode 100644
index 000000000000..dda1b4b169fc
--- /dev/null
+++ b/tools/perf/util/perf-regs-arch/perf_regs_powerpc.c
@@ -0,0 +1,135 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#ifdef HAVE_PERF_REGS_SUPPORT
+
+#include "../perf_regs.h"
+#include "../../../arch/powerpc/include/uapi/asm/perf_regs.h"
+
+const char *__perf_reg_name_powerpc(int id)
+{
+	switch (id) {
+	case PERF_REG_POWERPC_R0:
+		return "r0";
+	case PERF_REG_POWERPC_R1:
+		return "r1";
+	case PERF_REG_POWERPC_R2:
+		return "r2";
+	case PERF_REG_POWERPC_R3:
+		return "r3";
+	case PERF_REG_POWERPC_R4:
+		return "r4";
+	case PERF_REG_POWERPC_R5:
+		return "r5";
+	case PERF_REG_POWERPC_R6:
+		return "r6";
+	case PERF_REG_POWERPC_R7:
+		return "r7";
+	case PERF_REG_POWERPC_R8:
+		return "r8";
+	case PERF_REG_POWERPC_R9:
+		return "r9";
+	case PERF_REG_POWERPC_R10:
+		return "r10";
+	case PERF_REG_POWERPC_R11:
+		return "r11";
+	case PERF_REG_POWERPC_R12:
+		return "r12";
+	case PERF_REG_POWERPC_R13:
+		return "r13";
+	case PERF_REG_POWERPC_R14:
+		return "r14";
+	case PERF_REG_POWERPC_R15:
+		return "r15";
+	case PERF_REG_POWERPC_R16:
+		return "r16";
+	case PERF_REG_POWERPC_R17:
+		return "r17";
+	case PERF_REG_POWERPC_R18:
+		return "r18";
+	case PERF_REG_POWERPC_R19:
+		return "r19";
+	case PERF_REG_POWERPC_R20:
+		return "r20";
+	case PERF_REG_POWERPC_R21:
+		return "r21";
+	case PERF_REG_POWERPC_R22:
+		return "r22";
+	case PERF_REG_POWERPC_R23:
+		return "r23";
+	case PERF_REG_POWERPC_R24:
+		return "r24";
+	case PERF_REG_POWERPC_R25:
+		return "r25";
+	case PERF_REG_POWERPC_R26:
+		return "r26";
+	case PERF_REG_POWERPC_R27:
+		return "r27";
+	case PERF_REG_POWERPC_R28:
+		return "r28";
+	case PERF_REG_POWERPC_R29:
+		return "r29";
+	case PERF_REG_POWERPC_R30:
+		return "r30";
+	case PERF_REG_POWERPC_R31:
+		return "r31";
+	case PERF_REG_POWERPC_NIP:
+		return "nip";
+	case PERF_REG_POWERPC_MSR:
+		return "msr";
+	case PERF_REG_POWERPC_ORIG_R3:
+		return "orig_r3";
+	case PERF_REG_POWERPC_CTR:
+		return "ctr";
+	case PERF_REG_POWERPC_LINK:
+		return "link";
+	case PERF_REG_POWERPC_XER:
+		return "xer";
+	case PERF_REG_POWERPC_CCR:
+		return "ccr";
+	case PERF_REG_POWERPC_SOFTE:
+		return "softe";
+	case PERF_REG_POWERPC_TRAP:
+		return "trap";
+	case PERF_REG_POWERPC_DAR:
+		return "dar";
+	case PERF_REG_POWERPC_DSISR:
+		return "dsisr";
+	case PERF_REG_POWERPC_SIER:
+		return "sier";
+	case PERF_REG_POWERPC_MMCRA:
+		return "mmcra";
+	case PERF_REG_POWERPC_MMCR0:
+		return "mmcr0";
+	case PERF_REG_POWERPC_MMCR1:
+		return "mmcr1";
+	case PERF_REG_POWERPC_MMCR2:
+		return "mmcr2";
+	case PERF_REG_POWERPC_MMCR3:
+		return "mmcr3";
+	case PERF_REG_POWERPC_SIER2:
+		return "sier2";
+	case PERF_REG_POWERPC_SIER3:
+		return "sier3";
+	case PERF_REG_POWERPC_PMC1:
+		return "pmc1";
+	case PERF_REG_POWERPC_PMC2:
+		return "pmc2";
+	case PERF_REG_POWERPC_PMC3:
+		return "pmc3";
+	case PERF_REG_POWERPC_PMC4:
+		return "pmc4";
+	case PERF_REG_POWERPC_PMC5:
+		return "pmc5";
+	case PERF_REG_POWERPC_PMC6:
+		return "pmc6";
+	case PERF_REG_POWERPC_SDAR:
+		return "sdar";
+	case PERF_REG_POWERPC_SIAR:
+		return "siar";
+	default:
+		break;
+	}
+	return NULL;
+}
+
+#endif
diff --git a/tools/perf/util/perf-regs-arch/perf_regs_riscv.c b/tools/perf/util/perf-regs-arch/perf_regs_riscv.c
new file mode 100644
index 000000000000..c504b047cac2
--- /dev/null
+++ b/tools/perf/util/perf-regs-arch/perf_regs_riscv.c
@@ -0,0 +1,82 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#ifdef HAVE_PERF_REGS_SUPPORT
+
+#include "../perf_regs.h"
+#include "../../../arch/riscv/include/uapi/asm/perf_regs.h"
+
+const char *__perf_reg_name_riscv(int id)
+{
+	switch (id) {
+	case PERF_REG_RISCV_PC:
+		return "pc";
+	case PERF_REG_RISCV_RA:
+		return "ra";
+	case PERF_REG_RISCV_SP:
+		return "sp";
+	case PERF_REG_RISCV_GP:
+		return "gp";
+	case PERF_REG_RISCV_TP:
+		return "tp";
+	case PERF_REG_RISCV_T0:
+		return "t0";
+	case PERF_REG_RISCV_T1:
+		return "t1";
+	case PERF_REG_RISCV_T2:
+		return "t2";
+	case PERF_REG_RISCV_S0:
+		return "s0";
+	case PERF_REG_RISCV_S1:
+		return "s1";
+	case PERF_REG_RISCV_A0:
+		return "a0";
+	case PERF_REG_RISCV_A1:
+		return "a1";
+	case PERF_REG_RISCV_A2:
+		return "a2";
+	case PERF_REG_RISCV_A3:
+		return "a3";
+	case PERF_REG_RISCV_A4:
+		return "a4";
+	case PERF_REG_RISCV_A5:
+		return "a5";
+	case PERF_REG_RISCV_A6:
+		return "a6";
+	case PERF_REG_RISCV_A7:
+		return "a7";
+	case PERF_REG_RISCV_S2:
+		return "s2";
+	case PERF_REG_RISCV_S3:
+		return "s3";
+	case PERF_REG_RISCV_S4:
+		return "s4";
+	case PERF_REG_RISCV_S5:
+		return "s5";
+	case PERF_REG_RISCV_S6:
+		return "s6";
+	case PERF_REG_RISCV_S7:
+		return "s7";
+	case PERF_REG_RISCV_S8:
+		return "s8";
+	case PERF_REG_RISCV_S9:
+		return "s9";
+	case PERF_REG_RISCV_S10:
+		return "s10";
+	case PERF_REG_RISCV_S11:
+		return "s11";
+	case PERF_REG_RISCV_T3:
+		return "t3";
+	case PERF_REG_RISCV_T4:
+		return "t4";
+	case PERF_REG_RISCV_T5:
+		return "t5";
+	case PERF_REG_RISCV_T6:
+		return "t6";
+	default:
+		return NULL;
+	}
+
+	return NULL;
+}
+
+#endif
diff --git a/tools/perf/util/perf-regs-arch/perf_regs_s390.c b/tools/perf/util/perf-regs-arch/perf_regs_s390.c
new file mode 100644
index 000000000000..e71e2302394c
--- /dev/null
+++ b/tools/perf/util/perf-regs-arch/perf_regs_s390.c
@@ -0,0 +1,86 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#ifdef HAVE_PERF_REGS_SUPPORT
+
+#include "../perf_regs.h"
+#include "../../../arch/s390/include/uapi/asm/perf_regs.h"
+
+const char *__perf_reg_name_s390(int id)
+{
+	switch (id) {
+	case PERF_REG_S390_R0:
+		return "R0";
+	case PERF_REG_S390_R1:
+		return "R1";
+	case PERF_REG_S390_R2:
+		return "R2";
+	case PERF_REG_S390_R3:
+		return "R3";
+	case PERF_REG_S390_R4:
+		return "R4";
+	case PERF_REG_S390_R5:
+		return "R5";
+	case PERF_REG_S390_R6:
+		return "R6";
+	case PERF_REG_S390_R7:
+		return "R7";
+	case PERF_REG_S390_R8:
+		return "R8";
+	case PERF_REG_S390_R9:
+		return "R9";
+	case PERF_REG_S390_R10:
+		return "R10";
+	case PERF_REG_S390_R11:
+		return "R11";
+	case PERF_REG_S390_R12:
+		return "R12";
+	case PERF_REG_S390_R13:
+		return "R13";
+	case PERF_REG_S390_R14:
+		return "R14";
+	case PERF_REG_S390_R15:
+		return "R15";
+	case PERF_REG_S390_FP0:
+		return "FP0";
+	case PERF_REG_S390_FP1:
+		return "FP1";
+	case PERF_REG_S390_FP2:
+		return "FP2";
+	case PERF_REG_S390_FP3:
+		return "FP3";
+	case PERF_REG_S390_FP4:
+		return "FP4";
+	case PERF_REG_S390_FP5:
+		return "FP5";
+	case PERF_REG_S390_FP6:
+		return "FP6";
+	case PERF_REG_S390_FP7:
+		return "FP7";
+	case PERF_REG_S390_FP8:
+		return "FP8";
+	case PERF_REG_S390_FP9:
+		return "FP9";
+	case PERF_REG_S390_FP10:
+		return "FP10";
+	case PERF_REG_S390_FP11:
+		return "FP11";
+	case PERF_REG_S390_FP12:
+		return "FP12";
+	case PERF_REG_S390_FP13:
+		return "FP13";
+	case PERF_REG_S390_FP14:
+		return "FP14";
+	case PERF_REG_S390_FP15:
+		return "FP15";
+	case PERF_REG_S390_MASK:
+		return "MASK";
+	case PERF_REG_S390_PC:
+		return "PC";
+	default:
+		return NULL;
+	}
+
+	return NULL;
+}
+
+#endif
diff --git a/tools/perf/util/perf-regs-arch/perf_regs_x86.c b/tools/perf/util/perf-regs-arch/perf_regs_x86.c
new file mode 100644
index 000000000000..eb5d249afa70
--- /dev/null
+++ b/tools/perf/util/perf-regs-arch/perf_regs_x86.c
@@ -0,0 +1,88 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#ifdef HAVE_PERF_REGS_SUPPORT
+
+#include "../perf_regs.h"
+#include "../../../arch/x86/include/uapi/asm/perf_regs.h"
+
+const char *__perf_reg_name_x86(int id)
+{
+	switch (id) {
+	case PERF_REG_X86_AX:
+		return "AX";
+	case PERF_REG_X86_BX:
+		return "BX";
+	case PERF_REG_X86_CX:
+		return "CX";
+	case PERF_REG_X86_DX:
+		return "DX";
+	case PERF_REG_X86_SI:
+		return "SI";
+	case PERF_REG_X86_DI:
+		return "DI";
+	case PERF_REG_X86_BP:
+		return "BP";
+	case PERF_REG_X86_SP:
+		return "SP";
+	case PERF_REG_X86_IP:
+		return "IP";
+	case PERF_REG_X86_FLAGS:
+		return "FLAGS";
+	case PERF_REG_X86_CS:
+		return "CS";
+	case PERF_REG_X86_SS:
+		return "SS";
+	case PERF_REG_X86_DS:
+		return "DS";
+	case PERF_REG_X86_ES:
+		return "ES";
+	case PERF_REG_X86_FS:
+		return "FS";
+	case PERF_REG_X86_GS:
+		return "GS";
+	case PERF_REG_X86_R8:
+		return "R8";
+	case PERF_REG_X86_R9:
+		return "R9";
+	case PERF_REG_X86_R10:
+		return "R10";
+	case PERF_REG_X86_R11:
+		return "R11";
+	case PERF_REG_X86_R12:
+		return "R12";
+	case PERF_REG_X86_R13:
+		return "R13";
+	case PERF_REG_X86_R14:
+		return "R14";
+	case PERF_REG_X86_R15:
+		return "R15";
+
+#define XMM(x) \
+	case PERF_REG_X86_XMM ## x:	\
+	case PERF_REG_X86_XMM ## x + 1:	\
+		return "XMM" #x;
+	XMM(0)
+	XMM(1)
+	XMM(2)
+	XMM(3)
+	XMM(4)
+	XMM(5)
+	XMM(6)
+	XMM(7)
+	XMM(8)
+	XMM(9)
+	XMM(10)
+	XMM(11)
+	XMM(12)
+	XMM(13)
+	XMM(14)
+	XMM(15)
+#undef XMM
+	default:
+		return NULL;
+	}
+
+	return NULL;
+}
+
+#endif
diff --git a/tools/perf/util/perf_regs.c b/tools/perf/util/perf_regs.c
index 57a567ee2cea..8720ec6cf147 100644
--- a/tools/perf/util/perf_regs.c
+++ b/tools/perf/util/perf_regs.c
@@ -22,648 +22,6 @@ uint64_t __weak arch__user_reg_mask(void)
 
 #ifdef HAVE_PERF_REGS_SUPPORT
 
-#define perf_event_arm_regs perf_event_arm64_regs
-#include "../../arch/arm64/include/uapi/asm/perf_regs.h"
-#undef perf_event_arm_regs
-
-#include "../../arch/arm/include/uapi/asm/perf_regs.h"
-#include "../../arch/csky/include/uapi/asm/perf_regs.h"
-#include "../../arch/mips/include/uapi/asm/perf_regs.h"
-#include "../../arch/powerpc/include/uapi/asm/perf_regs.h"
-#include "../../arch/riscv/include/uapi/asm/perf_regs.h"
-#include "../../arch/s390/include/uapi/asm/perf_regs.h"
-#include "../../arch/x86/include/uapi/asm/perf_regs.h"
-
-static const char *__perf_reg_name_arm64(int id)
-{
-	switch (id) {
-	case PERF_REG_ARM64_X0:
-		return "x0";
-	case PERF_REG_ARM64_X1:
-		return "x1";
-	case PERF_REG_ARM64_X2:
-		return "x2";
-	case PERF_REG_ARM64_X3:
-		return "x3";
-	case PERF_REG_ARM64_X4:
-		return "x4";
-	case PERF_REG_ARM64_X5:
-		return "x5";
-	case PERF_REG_ARM64_X6:
-		return "x6";
-	case PERF_REG_ARM64_X7:
-		return "x7";
-	case PERF_REG_ARM64_X8:
-		return "x8";
-	case PERF_REG_ARM64_X9:
-		return "x9";
-	case PERF_REG_ARM64_X10:
-		return "x10";
-	case PERF_REG_ARM64_X11:
-		return "x11";
-	case PERF_REG_ARM64_X12:
-		return "x12";
-	case PERF_REG_ARM64_X13:
-		return "x13";
-	case PERF_REG_ARM64_X14:
-		return "x14";
-	case PERF_REG_ARM64_X15:
-		return "x15";
-	case PERF_REG_ARM64_X16:
-		return "x16";
-	case PERF_REG_ARM64_X17:
-		return "x17";
-	case PERF_REG_ARM64_X18:
-		return "x18";
-	case PERF_REG_ARM64_X19:
-		return "x19";
-	case PERF_REG_ARM64_X20:
-		return "x20";
-	case PERF_REG_ARM64_X21:
-		return "x21";
-	case PERF_REG_ARM64_X22:
-		return "x22";
-	case PERF_REG_ARM64_X23:
-		return "x23";
-	case PERF_REG_ARM64_X24:
-		return "x24";
-	case PERF_REG_ARM64_X25:
-		return "x25";
-	case PERF_REG_ARM64_X26:
-		return "x26";
-	case PERF_REG_ARM64_X27:
-		return "x27";
-	case PERF_REG_ARM64_X28:
-		return "x28";
-	case PERF_REG_ARM64_X29:
-		return "x29";
-	case PERF_REG_ARM64_SP:
-		return "sp";
-	case PERF_REG_ARM64_LR:
-		return "lr";
-	case PERF_REG_ARM64_PC:
-		return "pc";
-	case PERF_REG_ARM64_VG:
-		return "vg";
-	default:
-		return NULL;
-	}
-
-	return NULL;
-}
-
-static const char *__perf_reg_name_arm(int id)
-{
-	switch (id) {
-	case PERF_REG_ARM_R0:
-		return "r0";
-	case PERF_REG_ARM_R1:
-		return "r1";
-	case PERF_REG_ARM_R2:
-		return "r2";
-	case PERF_REG_ARM_R3:
-		return "r3";
-	case PERF_REG_ARM_R4:
-		return "r4";
-	case PERF_REG_ARM_R5:
-		return "r5";
-	case PERF_REG_ARM_R6:
-		return "r6";
-	case PERF_REG_ARM_R7:
-		return "r7";
-	case PERF_REG_ARM_R8:
-		return "r8";
-	case PERF_REG_ARM_R9:
-		return "r9";
-	case PERF_REG_ARM_R10:
-		return "r10";
-	case PERF_REG_ARM_FP:
-		return "fp";
-	case PERF_REG_ARM_IP:
-		return "ip";
-	case PERF_REG_ARM_SP:
-		return "sp";
-	case PERF_REG_ARM_LR:
-		return "lr";
-	case PERF_REG_ARM_PC:
-		return "pc";
-	default:
-		return NULL;
-	}
-
-	return NULL;
-}
-
-static const char *__perf_reg_name_csky(int id)
-{
-	switch (id) {
-	case PERF_REG_CSKY_A0:
-		return "a0";
-	case PERF_REG_CSKY_A1:
-		return "a1";
-	case PERF_REG_CSKY_A2:
-		return "a2";
-	case PERF_REG_CSKY_A3:
-		return "a3";
-	case PERF_REG_CSKY_REGS0:
-		return "regs0";
-	case PERF_REG_CSKY_REGS1:
-		return "regs1";
-	case PERF_REG_CSKY_REGS2:
-		return "regs2";
-	case PERF_REG_CSKY_REGS3:
-		return "regs3";
-	case PERF_REG_CSKY_REGS4:
-		return "regs4";
-	case PERF_REG_CSKY_REGS5:
-		return "regs5";
-	case PERF_REG_CSKY_REGS6:
-		return "regs6";
-	case PERF_REG_CSKY_REGS7:
-		return "regs7";
-	case PERF_REG_CSKY_REGS8:
-		return "regs8";
-	case PERF_REG_CSKY_REGS9:
-		return "regs9";
-	case PERF_REG_CSKY_SP:
-		return "sp";
-	case PERF_REG_CSKY_LR:
-		return "lr";
-	case PERF_REG_CSKY_PC:
-		return "pc";
-#if defined(__CSKYABIV2__)
-	case PERF_REG_CSKY_EXREGS0:
-		return "exregs0";
-	case PERF_REG_CSKY_EXREGS1:
-		return "exregs1";
-	case PERF_REG_CSKY_EXREGS2:
-		return "exregs2";
-	case PERF_REG_CSKY_EXREGS3:
-		return "exregs3";
-	case PERF_REG_CSKY_EXREGS4:
-		return "exregs4";
-	case PERF_REG_CSKY_EXREGS5:
-		return "exregs5";
-	case PERF_REG_CSKY_EXREGS6:
-		return "exregs6";
-	case PERF_REG_CSKY_EXREGS7:
-		return "exregs7";
-	case PERF_REG_CSKY_EXREGS8:
-		return "exregs8";
-	case PERF_REG_CSKY_EXREGS9:
-		return "exregs9";
-	case PERF_REG_CSKY_EXREGS10:
-		return "exregs10";
-	case PERF_REG_CSKY_EXREGS11:
-		return "exregs11";
-	case PERF_REG_CSKY_EXREGS12:
-		return "exregs12";
-	case PERF_REG_CSKY_EXREGS13:
-		return "exregs13";
-	case PERF_REG_CSKY_EXREGS14:
-		return "exregs14";
-	case PERF_REG_CSKY_TLS:
-		return "tls";
-	case PERF_REG_CSKY_HI:
-		return "hi";
-	case PERF_REG_CSKY_LO:
-		return "lo";
-#endif
-	default:
-		return NULL;
-	}
-
-	return NULL;
-}
-
-static const char *__perf_reg_name_mips(int id)
-{
-	switch (id) {
-	case PERF_REG_MIPS_PC:
-		return "PC";
-	case PERF_REG_MIPS_R1:
-		return "$1";
-	case PERF_REG_MIPS_R2:
-		return "$2";
-	case PERF_REG_MIPS_R3:
-		return "$3";
-	case PERF_REG_MIPS_R4:
-		return "$4";
-	case PERF_REG_MIPS_R5:
-		return "$5";
-	case PERF_REG_MIPS_R6:
-		return "$6";
-	case PERF_REG_MIPS_R7:
-		return "$7";
-	case PERF_REG_MIPS_R8:
-		return "$8";
-	case PERF_REG_MIPS_R9:
-		return "$9";
-	case PERF_REG_MIPS_R10:
-		return "$10";
-	case PERF_REG_MIPS_R11:
-		return "$11";
-	case PERF_REG_MIPS_R12:
-		return "$12";
-	case PERF_REG_MIPS_R13:
-		return "$13";
-	case PERF_REG_MIPS_R14:
-		return "$14";
-	case PERF_REG_MIPS_R15:
-		return "$15";
-	case PERF_REG_MIPS_R16:
-		return "$16";
-	case PERF_REG_MIPS_R17:
-		return "$17";
-	case PERF_REG_MIPS_R18:
-		return "$18";
-	case PERF_REG_MIPS_R19:
-		return "$19";
-	case PERF_REG_MIPS_R20:
-		return "$20";
-	case PERF_REG_MIPS_R21:
-		return "$21";
-	case PERF_REG_MIPS_R22:
-		return "$22";
-	case PERF_REG_MIPS_R23:
-		return "$23";
-	case PERF_REG_MIPS_R24:
-		return "$24";
-	case PERF_REG_MIPS_R25:
-		return "$25";
-	case PERF_REG_MIPS_R28:
-		return "$28";
-	case PERF_REG_MIPS_R29:
-		return "$29";
-	case PERF_REG_MIPS_R30:
-		return "$30";
-	case PERF_REG_MIPS_R31:
-		return "$31";
-	default:
-		break;
-	}
-	return NULL;
-}
-
-static const char *__perf_reg_name_powerpc(int id)
-{
-	switch (id) {
-	case PERF_REG_POWERPC_R0:
-		return "r0";
-	case PERF_REG_POWERPC_R1:
-		return "r1";
-	case PERF_REG_POWERPC_R2:
-		return "r2";
-	case PERF_REG_POWERPC_R3:
-		return "r3";
-	case PERF_REG_POWERPC_R4:
-		return "r4";
-	case PERF_REG_POWERPC_R5:
-		return "r5";
-	case PERF_REG_POWERPC_R6:
-		return "r6";
-	case PERF_REG_POWERPC_R7:
-		return "r7";
-	case PERF_REG_POWERPC_R8:
-		return "r8";
-	case PERF_REG_POWERPC_R9:
-		return "r9";
-	case PERF_REG_POWERPC_R10:
-		return "r10";
-	case PERF_REG_POWERPC_R11:
-		return "r11";
-	case PERF_REG_POWERPC_R12:
-		return "r12";
-	case PERF_REG_POWERPC_R13:
-		return "r13";
-	case PERF_REG_POWERPC_R14:
-		return "r14";
-	case PERF_REG_POWERPC_R15:
-		return "r15";
-	case PERF_REG_POWERPC_R16:
-		return "r16";
-	case PERF_REG_POWERPC_R17:
-		return "r17";
-	case PERF_REG_POWERPC_R18:
-		return "r18";
-	case PERF_REG_POWERPC_R19:
-		return "r19";
-	case PERF_REG_POWERPC_R20:
-		return "r20";
-	case PERF_REG_POWERPC_R21:
-		return "r21";
-	case PERF_REG_POWERPC_R22:
-		return "r22";
-	case PERF_REG_POWERPC_R23:
-		return "r23";
-	case PERF_REG_POWERPC_R24:
-		return "r24";
-	case PERF_REG_POWERPC_R25:
-		return "r25";
-	case PERF_REG_POWERPC_R26:
-		return "r26";
-	case PERF_REG_POWERPC_R27:
-		return "r27";
-	case PERF_REG_POWERPC_R28:
-		return "r28";
-	case PERF_REG_POWERPC_R29:
-		return "r29";
-	case PERF_REG_POWERPC_R30:
-		return "r30";
-	case PERF_REG_POWERPC_R31:
-		return "r31";
-	case PERF_REG_POWERPC_NIP:
-		return "nip";
-	case PERF_REG_POWERPC_MSR:
-		return "msr";
-	case PERF_REG_POWERPC_ORIG_R3:
-		return "orig_r3";
-	case PERF_REG_POWERPC_CTR:
-		return "ctr";
-	case PERF_REG_POWERPC_LINK:
-		return "link";
-	case PERF_REG_POWERPC_XER:
-		return "xer";
-	case PERF_REG_POWERPC_CCR:
-		return "ccr";
-	case PERF_REG_POWERPC_SOFTE:
-		return "softe";
-	case PERF_REG_POWERPC_TRAP:
-		return "trap";
-	case PERF_REG_POWERPC_DAR:
-		return "dar";
-	case PERF_REG_POWERPC_DSISR:
-		return "dsisr";
-	case PERF_REG_POWERPC_SIER:
-		return "sier";
-	case PERF_REG_POWERPC_MMCRA:
-		return "mmcra";
-	case PERF_REG_POWERPC_MMCR0:
-		return "mmcr0";
-	case PERF_REG_POWERPC_MMCR1:
-		return "mmcr1";
-	case PERF_REG_POWERPC_MMCR2:
-		return "mmcr2";
-	case PERF_REG_POWERPC_MMCR3:
-		return "mmcr3";
-	case PERF_REG_POWERPC_SIER2:
-		return "sier2";
-	case PERF_REG_POWERPC_SIER3:
-		return "sier3";
-	case PERF_REG_POWERPC_PMC1:
-		return "pmc1";
-	case PERF_REG_POWERPC_PMC2:
-		return "pmc2";
-	case PERF_REG_POWERPC_PMC3:
-		return "pmc3";
-	case PERF_REG_POWERPC_PMC4:
-		return "pmc4";
-	case PERF_REG_POWERPC_PMC5:
-		return "pmc5";
-	case PERF_REG_POWERPC_PMC6:
-		return "pmc6";
-	case PERF_REG_POWERPC_SDAR:
-		return "sdar";
-	case PERF_REG_POWERPC_SIAR:
-		return "siar";
-	default:
-		break;
-	}
-	return NULL;
-}
-
-static const char *__perf_reg_name_riscv(int id)
-{
-	switch (id) {
-	case PERF_REG_RISCV_PC:
-		return "pc";
-	case PERF_REG_RISCV_RA:
-		return "ra";
-	case PERF_REG_RISCV_SP:
-		return "sp";
-	case PERF_REG_RISCV_GP:
-		return "gp";
-	case PERF_REG_RISCV_TP:
-		return "tp";
-	case PERF_REG_RISCV_T0:
-		return "t0";
-	case PERF_REG_RISCV_T1:
-		return "t1";
-	case PERF_REG_RISCV_T2:
-		return "t2";
-	case PERF_REG_RISCV_S0:
-		return "s0";
-	case PERF_REG_RISCV_S1:
-		return "s1";
-	case PERF_REG_RISCV_A0:
-		return "a0";
-	case PERF_REG_RISCV_A1:
-		return "a1";
-	case PERF_REG_RISCV_A2:
-		return "a2";
-	case PERF_REG_RISCV_A3:
-		return "a3";
-	case PERF_REG_RISCV_A4:
-		return "a4";
-	case PERF_REG_RISCV_A5:
-		return "a5";
-	case PERF_REG_RISCV_A6:
-		return "a6";
-	case PERF_REG_RISCV_A7:
-		return "a7";
-	case PERF_REG_RISCV_S2:
-		return "s2";
-	case PERF_REG_RISCV_S3:
-		return "s3";
-	case PERF_REG_RISCV_S4:
-		return "s4";
-	case PERF_REG_RISCV_S5:
-		return "s5";
-	case PERF_REG_RISCV_S6:
-		return "s6";
-	case PERF_REG_RISCV_S7:
-		return "s7";
-	case PERF_REG_RISCV_S8:
-		return "s8";
-	case PERF_REG_RISCV_S9:
-		return "s9";
-	case PERF_REG_RISCV_S10:
-		return "s10";
-	case PERF_REG_RISCV_S11:
-		return "s11";
-	case PERF_REG_RISCV_T3:
-		return "t3";
-	case PERF_REG_RISCV_T4:
-		return "t4";
-	case PERF_REG_RISCV_T5:
-		return "t5";
-	case PERF_REG_RISCV_T6:
-		return "t6";
-	default:
-		return NULL;
-	}
-
-	return NULL;
-}
-
-static const char *__perf_reg_name_s390(int id)
-{
-	switch (id) {
-	case PERF_REG_S390_R0:
-		return "R0";
-	case PERF_REG_S390_R1:
-		return "R1";
-	case PERF_REG_S390_R2:
-		return "R2";
-	case PERF_REG_S390_R3:
-		return "R3";
-	case PERF_REG_S390_R4:
-		return "R4";
-	case PERF_REG_S390_R5:
-		return "R5";
-	case PERF_REG_S390_R6:
-		return "R6";
-	case PERF_REG_S390_R7:
-		return "R7";
-	case PERF_REG_S390_R8:
-		return "R8";
-	case PERF_REG_S390_R9:
-		return "R9";
-	case PERF_REG_S390_R10:
-		return "R10";
-	case PERF_REG_S390_R11:
-		return "R11";
-	case PERF_REG_S390_R12:
-		return "R12";
-	case PERF_REG_S390_R13:
-		return "R13";
-	case PERF_REG_S390_R14:
-		return "R14";
-	case PERF_REG_S390_R15:
-		return "R15";
-	case PERF_REG_S390_FP0:
-		return "FP0";
-	case PERF_REG_S390_FP1:
-		return "FP1";
-	case PERF_REG_S390_FP2:
-		return "FP2";
-	case PERF_REG_S390_FP3:
-		return "FP3";
-	case PERF_REG_S390_FP4:
-		return "FP4";
-	case PERF_REG_S390_FP5:
-		return "FP5";
-	case PERF_REG_S390_FP6:
-		return "FP6";
-	case PERF_REG_S390_FP7:
-		return "FP7";
-	case PERF_REG_S390_FP8:
-		return "FP8";
-	case PERF_REG_S390_FP9:
-		return "FP9";
-	case PERF_REG_S390_FP10:
-		return "FP10";
-	case PERF_REG_S390_FP11:
-		return "FP11";
-	case PERF_REG_S390_FP12:
-		return "FP12";
-	case PERF_REG_S390_FP13:
-		return "FP13";
-	case PERF_REG_S390_FP14:
-		return "FP14";
-	case PERF_REG_S390_FP15:
-		return "FP15";
-	case PERF_REG_S390_MASK:
-		return "MASK";
-	case PERF_REG_S390_PC:
-		return "PC";
-	default:
-		return NULL;
-	}
-
-	return NULL;
-}
-
-static const char *__perf_reg_name_x86(int id)
-{
-	switch (id) {
-	case PERF_REG_X86_AX:
-		return "AX";
-	case PERF_REG_X86_BX:
-		return "BX";
-	case PERF_REG_X86_CX:
-		return "CX";
-	case PERF_REG_X86_DX:
-		return "DX";
-	case PERF_REG_X86_SI:
-		return "SI";
-	case PERF_REG_X86_DI:
-		return "DI";
-	case PERF_REG_X86_BP:
-		return "BP";
-	case PERF_REG_X86_SP:
-		return "SP";
-	case PERF_REG_X86_IP:
-		return "IP";
-	case PERF_REG_X86_FLAGS:
-		return "FLAGS";
-	case PERF_REG_X86_CS:
-		return "CS";
-	case PERF_REG_X86_SS:
-		return "SS";
-	case PERF_REG_X86_DS:
-		return "DS";
-	case PERF_REG_X86_ES:
-		return "ES";
-	case PERF_REG_X86_FS:
-		return "FS";
-	case PERF_REG_X86_GS:
-		return "GS";
-	case PERF_REG_X86_R8:
-		return "R8";
-	case PERF_REG_X86_R9:
-		return "R9";
-	case PERF_REG_X86_R10:
-		return "R10";
-	case PERF_REG_X86_R11:
-		return "R11";
-	case PERF_REG_X86_R12:
-		return "R12";
-	case PERF_REG_X86_R13:
-		return "R13";
-	case PERF_REG_X86_R14:
-		return "R14";
-	case PERF_REG_X86_R15:
-		return "R15";
-
-#define XMM(x) \
-	case PERF_REG_X86_XMM ## x:	\
-	case PERF_REG_X86_XMM ## x + 1:	\
-		return "XMM" #x;
-	XMM(0)
-	XMM(1)
-	XMM(2)
-	XMM(3)
-	XMM(4)
-	XMM(5)
-	XMM(6)
-	XMM(7)
-	XMM(8)
-	XMM(9)
-	XMM(10)
-	XMM(11)
-	XMM(12)
-	XMM(13)
-	XMM(14)
-	XMM(15)
-#undef XMM
-	default:
-		return NULL;
-	}
-
-	return NULL;
-}
-
 const char *perf_reg_name(int id, const char *arch)
 {
 	const char *reg_name = NULL;
diff --git a/tools/perf/util/perf_regs.h b/tools/perf/util/perf_regs.h
index ce1127af05e4..ab4ec3f2a170 100644
--- a/tools/perf/util/perf_regs.h
+++ b/tools/perf/util/perf_regs.h
@@ -36,6 +36,14 @@ extern const struct sample_reg sample_reg_masks[];
 
 const char *perf_reg_name(int id, const char *arch);
 int perf_reg_value(u64 *valp, struct regs_dump *regs, int id);
+const char *__perf_reg_name_arm64(int id);
+const char *__perf_reg_name_arm(int id);
+const char *__perf_reg_name_csky(int id);
+const char *__perf_reg_name_mips(int id);
+const char *__perf_reg_name_powerpc(int id);
+const char *__perf_reg_name_riscv(int id);
+const char *__perf_reg_name_s390(int id);
+const char *__perf_reg_name_x86(int id);
 
 #else
 #define PERF_REGS_MASK	0
-- 
2.39.2

