Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 032157234B8
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 03:46:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233924AbjFFBqx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 21:46:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233923AbjFFBqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 21:46:51 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEA9111A
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 18:46:43 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-565a6837a0bso60425417b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jun 2023 18:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686016003; x=1688608003;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hEUFNMzfqFzxFoJd7U1v/KQDElpKa5YtXy/vXslzPbA=;
        b=LA9N6eC3cyCwTKRQ4W5MpfBUJWmmUbHbV+FJ03f8x/kD7xCpL9FrNObUCWAOHz0bIP
         hg3+oDXGhm2PSAdyTZLnE4OalEdP94UHCw3+9v/6mI5ZJd6gCIFbuju0hUisUKKQGIZp
         Pfm/MYWXvbmNQVEb+6yj9DBAKzpaNzrIul++AW9r3l60OYl80UttFvJrHTLz2n2RHnZj
         a8DruiAPI5/ehkUzO1EDjl8DMkSVtJFUrOMRPsSXcCNymW6i1HWYV3cG8L8N22mmp92m
         t/VbIvBeyojx5/Q7/IWIBvCu2XXGo7cmldR/YSFUNoFxfQ7528CYGxoWHXN1Feh6vylu
         4FiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686016003; x=1688608003;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hEUFNMzfqFzxFoJd7U1v/KQDElpKa5YtXy/vXslzPbA=;
        b=ZxmX3TquqDJb9Lyxc2Lviyo/Q6mbTfZeUqfXKfM76HzpESL2bNLCOmBcV4qob5KHP1
         plSlvNmZsW1UJMIcGkOW67W8PKdZwpWqSiH7Sgm9J9MSgtPEWmTwZsZmCQBiEuPnnxEi
         cmhnQrhw9ZbkzmmPiks0cWPTiKapGG+XizquylE/J4l6933lbdlcpbnxHml9nFurG4BK
         GFfiVkxEhpJqvyo5lGAuc+XEee+vYxO4ryST6GQa2maSQT7laTvmJRKduB0jfJNsaAWA
         rx5OE22J6KKSCIooEcAPVHzvhIOkg0S35ksQpiSKyfk7giu5iVMgC1b9j8Piyc4+rX/x
         2dsQ==
X-Gm-Message-State: AC+VfDxvm//89ZzdE/Yb0sxMB6AY7kvOYLnZGY7zy+dBmIHBhsaC/g3d
        hKUs+nNagH6M0ISLo2BaYTjiOQ==
X-Google-Smtp-Source: ACHHUZ7maH3siosah4nPbJbjCHedUNuOhM+xAOF1/WJ25pQnl9KDQ8bh56nVXlW/wMvVZL77G0B1fQ==
X-Received: by 2002:a81:4e58:0:b0:568:fdc2:5af7 with SMTP id c85-20020a814e58000000b00568fdc25af7mr288740ywb.50.1686016002707;
        Mon, 05 Jun 2023 18:46:42 -0700 (PDT)
Received: from leoy-huanghe.lan ([240e:389:8603:ad00:6600:a29f:6ab:1788])
        by smtp.gmail.com with ESMTPSA id s10-20020a170902a50a00b001a64851087bsm7197805plq.272.2023.06.05.18.46.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 18:46:42 -0700 (PDT)
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
Subject: [PATCH v2 2/6] perf parse-regs: Introduce functions perf_arch_reg_{ip|sp}()
Date:   Tue,  6 Jun 2023 09:45:55 +0800
Message-Id: <20230606014559.21783-3-leo.yan@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230606014559.21783-1-leo.yan@linaro.org>
References: <20230606014559.21783-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current code uses macros PERF_REG_IP and PERF_REG_SP for parsing
registers and we build perf with these macros statically, which means it
only can correctly analyze CPU registers for the native architecture and
fails to support cross analysis (e.g. we build perf on x86 and cannot
analyze Arm64's registers).

We need to generalize util/perf_regs.c for support multi architectures,
as a first step, this commit introduces new functions perf_arch_reg_ip()
and perf_arch_reg_sp(), these two functions dynamically return IP and SP
register index respectively according to the parameter "arch".

Every architecture has its own functions (like __perf_reg_ip_arm64 and
__perf_reg_sp_arm64), these architecture specific functions are defined
in each arch source file under folder util/perf-regs-arch; at the end
all of them are built into the tool for cross analysis.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/util/evsel.c                       |  6 ++-
 .../util/perf-regs-arch/perf_regs_aarch64.c   | 10 ++++
 .../perf/util/perf-regs-arch/perf_regs_arm.c  | 10 ++++
 .../perf/util/perf-regs-arch/perf_regs_csky.c | 10 ++++
 .../util/perf-regs-arch/perf_regs_loongarch.c | 10 ++++
 .../perf/util/perf-regs-arch/perf_regs_mips.c | 10 ++++
 .../util/perf-regs-arch/perf_regs_powerpc.c   | 10 ++++
 .../util/perf-regs-arch/perf_regs_riscv.c     | 10 ++++
 .../perf/util/perf-regs-arch/perf_regs_s390.c | 10 ++++
 .../perf/util/perf-regs-arch/perf_regs_x86.c  | 10 ++++
 tools/perf/util/perf_regs.c                   | 52 +++++++++++++++++++
 tools/perf/util/perf_regs.h                   | 36 ++++++++++++-
 12 files changed, 180 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 46da3f0bb47e..dfba2bc79cfc 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -844,6 +844,7 @@ static void __evsel__config_callchain(struct evsel *evsel, struct record_opts *o
 {
 	bool function = evsel__is_function_event(evsel);
 	struct perf_event_attr *attr = &evsel->core.attr;
+	const char *arch = perf_env__arch(evsel__env(evsel));
 
 	evsel__set_sample_bit(evsel, CALLCHAIN);
 
@@ -876,8 +877,9 @@ static void __evsel__config_callchain(struct evsel *evsel, struct record_opts *o
 		if (!function) {
 			evsel__set_sample_bit(evsel, REGS_USER);
 			evsel__set_sample_bit(evsel, STACK_USER);
-			if (opts->sample_user_regs && DWARF_MINIMAL_REGS != PERF_REGS_MASK) {
-				attr->sample_regs_user |= DWARF_MINIMAL_REGS;
+			if (opts->sample_user_regs &&
+			    DWARF_MINIMAL_REGS(arch) != PERF_REGS_MASK) {
+				attr->sample_regs_user |= DWARF_MINIMAL_REGS(arch);
 				pr_warning("WARNING: The use of --call-graph=dwarf may require all the user registers, "
 					   "specifying a subset with --user-regs may render DWARF unwinding unreliable, "
 					   "so the minimal registers set (IP, SP) is explicitly forced.\n");
diff --git a/tools/perf/util/perf-regs-arch/perf_regs_aarch64.c b/tools/perf/util/perf-regs-arch/perf_regs_aarch64.c
index c02c045af46e..696566c54768 100644
--- a/tools/perf/util/perf-regs-arch/perf_regs_aarch64.c
+++ b/tools/perf/util/perf-regs-arch/perf_regs_aarch64.c
@@ -83,4 +83,14 @@ const char *__perf_reg_name_arm64(int id)
 	return NULL;
 }
 
+uint64_t __perf_reg_ip_arm64(void)
+{
+	return PERF_REG_ARM64_PC;
+}
+
+uint64_t __perf_reg_sp_arm64(void)
+{
+	return PERF_REG_ARM64_SP;
+}
+
 #endif
diff --git a/tools/perf/util/perf-regs-arch/perf_regs_arm.c b/tools/perf/util/perf-regs-arch/perf_regs_arm.c
index e8b0fcd72f34..700fd07cd2aa 100644
--- a/tools/perf/util/perf-regs-arch/perf_regs_arm.c
+++ b/tools/perf/util/perf-regs-arch/perf_regs_arm.c
@@ -47,4 +47,14 @@ const char *__perf_reg_name_arm(int id)
 	return NULL;
 }
 
+uint64_t __perf_reg_ip_arm(void)
+{
+	return PERF_REG_ARM_PC;
+}
+
+uint64_t __perf_reg_sp_arm(void)
+{
+	return PERF_REG_ARM_SP;
+}
+
 #endif
diff --git a/tools/perf/util/perf-regs-arch/perf_regs_csky.c b/tools/perf/util/perf-regs-arch/perf_regs_csky.c
index e343b1cef7ba..a2841094e096 100644
--- a/tools/perf/util/perf-regs-arch/perf_regs_csky.c
+++ b/tools/perf/util/perf-regs-arch/perf_regs_csky.c
@@ -87,4 +87,14 @@ const char *__perf_reg_name_csky(int id)
 	return NULL;
 }
 
+uint64_t __perf_reg_ip_csky(void)
+{
+	return PERF_REG_CSKY_PC;
+}
+
+uint64_t __perf_reg_sp_csky(void)
+{
+	return PERF_REG_CSKY_SP;
+}
+
 #endif
diff --git a/tools/perf/util/perf-regs-arch/perf_regs_loongarch.c b/tools/perf/util/perf-regs-arch/perf_regs_loongarch.c
index 6f937464067b..a9ba0f934123 100644
--- a/tools/perf/util/perf-regs-arch/perf_regs_loongarch.c
+++ b/tools/perf/util/perf-regs-arch/perf_regs_loongarch.c
@@ -78,4 +78,14 @@ const char *__perf_reg_name_loongarch(int id)
 	return NULL;
 }
 
+uint64_t __perf_reg_ip_loongarch(void)
+{
+	return PERF_REG_LOONGARCH_PC;
+}
+
+uint64_t __perf_reg_sp_loongarch(void)
+{
+	return PERF_REG_LOONGARCH_R3;
+}
+
 #endif
diff --git a/tools/perf/util/perf-regs-arch/perf_regs_mips.c b/tools/perf/util/perf-regs-arch/perf_regs_mips.c
index f48fbca2f947..5a45830cfbf5 100644
--- a/tools/perf/util/perf-regs-arch/perf_regs_mips.c
+++ b/tools/perf/util/perf-regs-arch/perf_regs_mips.c
@@ -74,4 +74,14 @@ const char *__perf_reg_name_mips(int id)
 	return NULL;
 }
 
+uint64_t __perf_reg_ip_mips(void)
+{
+	return PERF_REG_MIPS_PC;
+}
+
+uint64_t __perf_reg_sp_mips(void)
+{
+	return PERF_REG_MIPS_R29;
+}
+
 #endif
diff --git a/tools/perf/util/perf-regs-arch/perf_regs_powerpc.c b/tools/perf/util/perf-regs-arch/perf_regs_powerpc.c
index dda1b4b169fc..1f0d682db74a 100644
--- a/tools/perf/util/perf-regs-arch/perf_regs_powerpc.c
+++ b/tools/perf/util/perf-regs-arch/perf_regs_powerpc.c
@@ -132,4 +132,14 @@ const char *__perf_reg_name_powerpc(int id)
 	return NULL;
 }
 
+uint64_t __perf_reg_ip_powerpc(void)
+{
+	return PERF_REG_POWERPC_NIP;
+}
+
+uint64_t __perf_reg_sp_powerpc(void)
+{
+	return PERF_REG_POWERPC_R1;
+}
+
 #endif
diff --git a/tools/perf/util/perf-regs-arch/perf_regs_riscv.c b/tools/perf/util/perf-regs-arch/perf_regs_riscv.c
index c504b047cac2..e432630be4c5 100644
--- a/tools/perf/util/perf-regs-arch/perf_regs_riscv.c
+++ b/tools/perf/util/perf-regs-arch/perf_regs_riscv.c
@@ -79,4 +79,14 @@ const char *__perf_reg_name_riscv(int id)
 	return NULL;
 }
 
+uint64_t __perf_reg_ip_riscv(void)
+{
+	return PERF_REG_RISCV_PC;
+}
+
+uint64_t __perf_reg_sp_riscv(void)
+{
+	return PERF_REG_RISCV_SP;
+}
+
 #endif
diff --git a/tools/perf/util/perf-regs-arch/perf_regs_s390.c b/tools/perf/util/perf-regs-arch/perf_regs_s390.c
index e71e2302394c..1c7a46db778c 100644
--- a/tools/perf/util/perf-regs-arch/perf_regs_s390.c
+++ b/tools/perf/util/perf-regs-arch/perf_regs_s390.c
@@ -83,4 +83,14 @@ const char *__perf_reg_name_s390(int id)
 	return NULL;
 }
 
+uint64_t __perf_reg_ip_s390(void)
+{
+	return PERF_REG_S390_PC;
+}
+
+uint64_t __perf_reg_sp_s390(void)
+{
+	return PERF_REG_S390_R15;
+}
+
 #endif
diff --git a/tools/perf/util/perf-regs-arch/perf_regs_x86.c b/tools/perf/util/perf-regs-arch/perf_regs_x86.c
index eb5d249afa70..873c620f0634 100644
--- a/tools/perf/util/perf-regs-arch/perf_regs_x86.c
+++ b/tools/perf/util/perf-regs-arch/perf_regs_x86.c
@@ -85,4 +85,14 @@ const char *__perf_reg_name_x86(int id)
 	return NULL;
 }
 
+uint64_t __perf_reg_ip_x86(void)
+{
+	return PERF_REG_X86_IP;
+}
+
+uint64_t __perf_reg_sp_x86(void)
+{
+	return PERF_REG_X86_SP;
+}
+
 #endif
diff --git a/tools/perf/util/perf_regs.c b/tools/perf/util/perf_regs.c
index 5af1b95c3d01..23584efd4886 100644
--- a/tools/perf/util/perf_regs.c
+++ b/tools/perf/util/perf_regs.c
@@ -3,6 +3,7 @@
 #include <string.h>
 #include "perf_regs.h"
 #include "util/sample.h"
+#include "debug.h"
 
 int __weak arch_sdt_arg_parse_op(char *old_op __maybe_unused,
 				 char **new_op __maybe_unused)
@@ -74,4 +75,55 @@ int perf_reg_value(u64 *valp, struct regs_dump *regs, int id)
 	*valp = regs->cache_regs[id];
 	return 0;
 }
+
+uint64_t perf_arch_reg_ip(const char *arch)
+{
+	if (!strcmp(arch, "arm"))
+		return __perf_reg_ip_arm();
+	else if (!strcmp(arch, "arm64"))
+		return __perf_reg_ip_arm64();
+	else if (!strcmp(arch, "csky"))
+		return __perf_reg_ip_csky();
+	else if (!strcmp(arch, "loongarch"))
+		return __perf_reg_ip_loongarch();
+	else if (!strcmp(arch, "mips"))
+		return __perf_reg_ip_mips();
+	else if (!strcmp(arch, "powerpc"))
+		return __perf_reg_ip_powerpc();
+	else if (!strcmp(arch, "riscv"))
+		return __perf_reg_ip_riscv();
+	else if (!strcmp(arch, "s390"))
+		return __perf_reg_ip_s390();
+	else if (!strcmp(arch, "x86"))
+		return __perf_reg_ip_x86();
+
+	pr_err("Fail to find IP register for arch %s, returns 0\n", arch);
+	return 0;
+}
+
+uint64_t perf_arch_reg_sp(const char *arch)
+{
+	if (!strcmp(arch, "arm"))
+		return __perf_reg_sp_arm();
+	else if (!strcmp(arch, "arm64"))
+		return __perf_reg_sp_arm64();
+	else if (!strcmp(arch, "csky"))
+		return __perf_reg_sp_csky();
+	else if (!strcmp(arch, "loongarch"))
+		return __perf_reg_sp_loongarch();
+	else if (!strcmp(arch, "mips"))
+		return __perf_reg_sp_mips();
+	else if (!strcmp(arch, "powerpc"))
+		return __perf_reg_sp_powerpc();
+	else if (!strcmp(arch, "riscv"))
+		return __perf_reg_sp_riscv();
+	else if (!strcmp(arch, "s390"))
+		return __perf_reg_sp_s390();
+	else if (!strcmp(arch, "x86"))
+		return __perf_reg_sp_x86();
+
+	pr_err("Fail to find SP register for arch %s, returns 0\n", arch);
+	return 0;
+}
+
 #endif
diff --git a/tools/perf/util/perf_regs.h b/tools/perf/util/perf_regs.h
index 6b19a2867171..790c1a26bbfe 100644
--- a/tools/perf/util/perf_regs.h
+++ b/tools/perf/util/perf_regs.h
@@ -32,25 +32,46 @@ extern const struct sample_reg sample_reg_masks[];
 
 #include <perf_regs.h>
 
-#define DWARF_MINIMAL_REGS ((1ULL << PERF_REG_IP) | (1ULL << PERF_REG_SP))
+#define DWARF_MINIMAL_REGS(arch)	\
+	((1ULL << perf_arch_reg_ip(arch)) | (1ULL << perf_arch_reg_sp(arch)))
 
 const char *perf_reg_name(int id, const char *arch);
 int perf_reg_value(u64 *valp, struct regs_dump *regs, int id);
+uint64_t perf_arch_reg_ip(const char *arch);
+uint64_t perf_arch_reg_sp(const char *arch);
 const char *__perf_reg_name_arm64(int id);
+uint64_t __perf_reg_ip_arm64(void);
+uint64_t __perf_reg_sp_arm64(void);
 const char *__perf_reg_name_arm(int id);
+uint64_t __perf_reg_ip_arm(void);
+uint64_t __perf_reg_sp_arm(void);
 const char *__perf_reg_name_csky(int id);
+uint64_t __perf_reg_ip_csky(void);
+uint64_t __perf_reg_sp_csky(void);
 const char *__perf_reg_name_loongarch(int id);
+uint64_t __perf_reg_ip_loongarch(void);
+uint64_t __perf_reg_sp_loongarch(void);
 const char *__perf_reg_name_mips(int id);
+uint64_t __perf_reg_ip_mips(void);
+uint64_t __perf_reg_sp_mips(void);
 const char *__perf_reg_name_powerpc(int id);
+uint64_t __perf_reg_ip_powerpc(void);
+uint64_t __perf_reg_sp_powerpc(void);
 const char *__perf_reg_name_riscv(int id);
+uint64_t __perf_reg_ip_riscv(void);
+uint64_t __perf_reg_sp_riscv(void);
 const char *__perf_reg_name_s390(int id);
+uint64_t __perf_reg_ip_s390(void);
+uint64_t __perf_reg_sp_s390(void);
 const char *__perf_reg_name_x86(int id);
+uint64_t __perf_reg_ip_x86(void);
+uint64_t __perf_reg_sp_x86(void);
 
 #else
 #define PERF_REGS_MASK	0
 #define PERF_REGS_MAX	0
 
-#define DWARF_MINIMAL_REGS PERF_REGS_MASK
+#define DWARF_MINIMAL_REGS(arch)	PERF_REGS_MASK
 
 static inline const char *perf_reg_name(int id __maybe_unused, const char *arch __maybe_unused)
 {
@@ -63,5 +84,16 @@ static inline int perf_reg_value(u64 *valp __maybe_unused,
 {
 	return 0;
 }
+
+static inline uint64_t perf_arch_reg_ip(const char *arch __maybe_unused)
+{
+	return 0;
+}
+
+static inline uint64_t perf_arch_reg_sp(const char *arch __maybe_unused)
+{
+	return 0;
+}
+
 #endif /* HAVE_PERF_REGS_SUPPORT */
 #endif /* __PERF_REGS_H */
-- 
2.34.1

