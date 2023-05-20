Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 671DA70A4BE
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 04:56:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231268AbjETC4Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 22:56:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231313AbjETC4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 22:56:19 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B777610C6
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 19:56:05 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-51b4ef5378bso3665540a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 19:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684551365; x=1687143365;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NdjFM4dLH/3Dvg/h6tIt5S0f0cR4Hqz/fqP9xWQOSCY=;
        b=LLoQFboo3HEEqlewtWhwNdaOnxlOcR1QNDw1LOON+5GMzJyWQnzZ5U5PGo0x1NqCZZ
         dcdeYmnvswHKHtZTg6gfDYvsqHsXjpdmsduh9uvhdqWSnYn79hyPxcJO0RfJzPTJKWfb
         rU/QCzBtesM91Iq3xlIvYXmecjT41jCXqVqSAypQTNxheaBvwdI7lPv7XPZ7d+r6yfee
         uoSUCKH7ZF1gWhwKw04zLbd9M9VTiCOAOrvDQ4Txu3OOYomnY6uYaUc9WH7hz5fLTZhx
         ppBKxxv7H1YL/MrBAjT2sbYzgN3EkUe86IAmr5JAb8m/Ibu0yKdei3Xftn4kMgLAyLMZ
         n8RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684551365; x=1687143365;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NdjFM4dLH/3Dvg/h6tIt5S0f0cR4Hqz/fqP9xWQOSCY=;
        b=awOj+wFK/3XIy/TIjpne1hHJnffRwtS8biA53heWcx5PkdkRAoecT62dJObIIZTPzL
         Wy2pbdsa4Cin/xxZqDFO4g1jTohbD57YfX+qXuNk5A00MuxyRyQmAG3u/XCZNhfpEvjb
         fDDWwjNTTqYeEvcr3R5i+/ymDu0n+06fYDlF7OiLP+iWaaED9AEw7bthawDHKM5CKdkG
         5JkMpDDYn0njE56MyDWQmPCCD6VjwO4rm8nhT7baVht151D9CQXA0Rnb3s5II8KcgDZo
         nsPPpi1U1g6asntjOkxAbFEY7s4tryq6f31YpUqa6XYnocGRO2m4PLX5bQQwGCXgoaxf
         8+IQ==
X-Gm-Message-State: AC+VfDyc4VKWet4q9kvm0rCpLkDUXqwZ1im33/9V846APe8cYDCjUzm6
        BR85K0rGNAO+mobte9XIrVQaqw==
X-Google-Smtp-Source: ACHHUZ4ZcwvCIjenJ+1wG5YTMVBIlnUcq1xZpfG2+i3fFZy55N6Mb0f1cM/i626B7qLb8kKPF2UxrA==
X-Received: by 2002:a17:902:b718:b0:1ae:4d1c:129f with SMTP id d24-20020a170902b71800b001ae4d1c129fmr3877077pls.54.1684551364848;
        Fri, 19 May 2023 19:56:04 -0700 (PDT)
Received: from leoy-yangtze.lan ([156.59.236.113])
        by smtp.gmail.com with ESMTPSA id b6-20020a170902d50600b001a95aef9728sm346100plg.19.2023.05.19.19.55.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 19:56:04 -0700 (PDT)
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
Subject: [PATCH v1 2/5] perf parse-regs: Introduce functions arch__reg_{ip|sp}()
Date:   Sat, 20 May 2023 10:55:34 +0800
Message-Id: <20230520025537.1811986-3-leo.yan@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230520025537.1811986-1-leo.yan@linaro.org>
References: <20230520025537.1811986-1-leo.yan@linaro.org>
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

Ideally, we want util/perf_regs.c to be general enough and doesn't bind
with specific architecture.

But since util/perf_regs.c uses the macros PERF_REG_IP and PERF_REG_SP
which are defined by architecture, thus util/perf_regs.c is dependent on
architecture header (see util/perf_regs.h includes "<perf_regs.h>", here
perf_regs.h is architecture specific header).

As a step to generalize util/perf_regs.c, this commit introduces weak
functions arch__reg_ip() and arch__reg_sp() and every architecture can
define their own functions; thus, util/perf_regs.c doesn't need to use
PERF_REG_IP and PERF_REG_SP anymore.

This is a preparation to get rid of architecture specific header from
util/perf_regs.h.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/arch/arm/util/perf_regs.c     | 10 ++++++++++
 tools/perf/arch/arm64/util/perf_regs.c   | 10 ++++++++++
 tools/perf/arch/csky/util/perf_regs.c    | 10 ++++++++++
 tools/perf/arch/mips/util/perf_regs.c    | 10 ++++++++++
 tools/perf/arch/powerpc/util/perf_regs.c | 10 ++++++++++
 tools/perf/arch/riscv/util/perf_regs.c   | 10 ++++++++++
 tools/perf/arch/s390/util/perf_regs.c    | 10 ++++++++++
 tools/perf/arch/x86/util/perf_regs.c     | 10 ++++++++++
 tools/perf/util/perf_regs.c              | 10 ++++++++++
 tools/perf/util/perf_regs.h              |  4 +++-
 tools/perf/util/unwind-libdw.c           |  2 +-
 tools/perf/util/unwind.h                 |  4 ++--
 12 files changed, 96 insertions(+), 4 deletions(-)

diff --git a/tools/perf/arch/arm/util/perf_regs.c b/tools/perf/arch/arm/util/perf_regs.c
index 2833e101a7c6..37aa3a2091bd 100644
--- a/tools/perf/arch/arm/util/perf_regs.c
+++ b/tools/perf/arch/arm/util/perf_regs.c
@@ -4,3 +4,13 @@
 const struct sample_reg sample_reg_masks[] = {
 	SMPL_REG_END
 };
+
+uint64_t arch__reg_ip(void)
+{
+	return PERF_REG_ARM_PC;
+}
+
+uint64_t arch__reg_sp(void)
+{
+	return PERF_REG_ARM_SP;
+}
diff --git a/tools/perf/arch/arm64/util/perf_regs.c b/tools/perf/arch/arm64/util/perf_regs.c
index 006692c9b040..dbe7f00b222b 100644
--- a/tools/perf/arch/arm64/util/perf_regs.c
+++ b/tools/perf/arch/arm64/util/perf_regs.c
@@ -169,3 +169,13 @@ uint64_t arch__user_reg_mask(void)
 	}
 	return PERF_REGS_MASK;
 }
+
+uint64_t arch__reg_ip(void)
+{
+	return PERF_REG_ARM64_PC;
+}
+
+uint64_t arch__reg_sp(void)
+{
+	return PERF_REG_ARM64_SP;
+}
diff --git a/tools/perf/arch/csky/util/perf_regs.c b/tools/perf/arch/csky/util/perf_regs.c
index 2864e2e3776d..d230d7e640fd 100644
--- a/tools/perf/arch/csky/util/perf_regs.c
+++ b/tools/perf/arch/csky/util/perf_regs.c
@@ -4,3 +4,13 @@
 const struct sample_reg sample_reg_masks[] = {
 	SMPL_REG_END
 };
+
+uint64_t arch__reg_ip(void)
+{
+	return PERF_REG_CSKY_PC;
+}
+
+uint64_t arch__reg_sp(void)
+{
+	return PERF_REG_CSKY_SP;
+}
diff --git a/tools/perf/arch/mips/util/perf_regs.c b/tools/perf/arch/mips/util/perf_regs.c
index 2864e2e3776d..64882ebc9287 100644
--- a/tools/perf/arch/mips/util/perf_regs.c
+++ b/tools/perf/arch/mips/util/perf_regs.c
@@ -4,3 +4,13 @@
 const struct sample_reg sample_reg_masks[] = {
 	SMPL_REG_END
 };
+
+uint64_t arch__reg_ip(void)
+{
+	return PERF_REG_MIPS_PC;
+}
+
+uint64_t arch__reg_sp(void)
+{
+	return PERF_REG_MIPS_R29;
+}
diff --git a/tools/perf/arch/powerpc/util/perf_regs.c b/tools/perf/arch/powerpc/util/perf_regs.c
index 8d07a78e742a..c84cd79986a8 100644
--- a/tools/perf/arch/powerpc/util/perf_regs.c
+++ b/tools/perf/arch/powerpc/util/perf_regs.c
@@ -226,3 +226,13 @@ uint64_t arch__intr_reg_mask(void)
 	}
 	return mask;
 }
+
+uint64_t arch__reg_ip(void)
+{
+	return PERF_REG_POWERPC_NIP;
+}
+
+uint64_t arch__reg_sp(void)
+{
+	return PERF_REG_POWERPC_R1;
+}
diff --git a/tools/perf/arch/riscv/util/perf_regs.c b/tools/perf/arch/riscv/util/perf_regs.c
index 2864e2e3776d..13bbddd139d0 100644
--- a/tools/perf/arch/riscv/util/perf_regs.c
+++ b/tools/perf/arch/riscv/util/perf_regs.c
@@ -4,3 +4,13 @@
 const struct sample_reg sample_reg_masks[] = {
 	SMPL_REG_END
 };
+
+uint64_t arch__reg_ip(void)
+{
+	return PERF_REG_RISCV_PC;
+}
+
+uint64_t arch__reg_sp(void)
+{
+	return PERF_REG_RISCV_SP;
+}
diff --git a/tools/perf/arch/s390/util/perf_regs.c b/tools/perf/arch/s390/util/perf_regs.c
index 2864e2e3776d..9b2297471090 100644
--- a/tools/perf/arch/s390/util/perf_regs.c
+++ b/tools/perf/arch/s390/util/perf_regs.c
@@ -4,3 +4,13 @@
 const struct sample_reg sample_reg_masks[] = {
 	SMPL_REG_END
 };
+
+uint64_t arch__reg_ip(void)
+{
+	return PERF_REG_S390_PC;
+}
+
+uint64_t arch__reg_sp(void)
+{
+	return PERF_REG_S390_R15;
+}
diff --git a/tools/perf/arch/x86/util/perf_regs.c b/tools/perf/arch/x86/util/perf_regs.c
index 0ed177991ad0..c752a6e9cba6 100644
--- a/tools/perf/arch/x86/util/perf_regs.c
+++ b/tools/perf/arch/x86/util/perf_regs.c
@@ -312,3 +312,13 @@ uint64_t arch__intr_reg_mask(void)
 
 	return PERF_REGS_MASK;
 }
+
+uint64_t arch__reg_ip(void)
+{
+	return PERF_REG_X86_IP;
+}
+
+uint64_t arch__reg_sp(void)
+{
+	return PERF_REG_X86_SP;
+}
diff --git a/tools/perf/util/perf_regs.c b/tools/perf/util/perf_regs.c
index 8720ec6cf147..334c9a2b785d 100644
--- a/tools/perf/util/perf_regs.c
+++ b/tools/perf/util/perf_regs.c
@@ -20,6 +20,16 @@ uint64_t __weak arch__user_reg_mask(void)
 	return PERF_REGS_MASK;
 }
 
+uint64_t __weak arch__reg_ip(void)
+{
+	return 0;
+}
+
+uint64_t __weak arch__reg_sp(void)
+{
+	return 0;
+}
+
 #ifdef HAVE_PERF_REGS_SUPPORT
 
 const char *perf_reg_name(int id, const char *arch)
diff --git a/tools/perf/util/perf_regs.h b/tools/perf/util/perf_regs.h
index ab4ec3f2a170..0a1460aaad37 100644
--- a/tools/perf/util/perf_regs.h
+++ b/tools/perf/util/perf_regs.h
@@ -26,13 +26,15 @@ enum {
 int arch_sdt_arg_parse_op(char *old_op, char **new_op);
 uint64_t arch__intr_reg_mask(void);
 uint64_t arch__user_reg_mask(void);
+uint64_t arch__reg_ip(void);
+uint64_t arch__reg_sp(void);
 
 #ifdef HAVE_PERF_REGS_SUPPORT
 extern const struct sample_reg sample_reg_masks[];
 
 #include <perf_regs.h>
 
-#define DWARF_MINIMAL_REGS ((1ULL << PERF_REG_IP) | (1ULL << PERF_REG_SP))
+#define DWARF_MINIMAL_REGS ((1ULL << arch__reg_ip()) | (1ULL << arch__reg_sp()))
 
 const char *perf_reg_name(int id, const char *arch);
 int perf_reg_value(u64 *valp, struct regs_dump *regs, int id);
diff --git a/tools/perf/util/unwind-libdw.c b/tools/perf/util/unwind-libdw.c
index bdccfc511b7e..f308f2ea512b 100644
--- a/tools/perf/util/unwind-libdw.c
+++ b/tools/perf/util/unwind-libdw.c
@@ -252,7 +252,7 @@ int unwind__get_entries(unwind_entry_cb_t cb, void *arg,
 	if (!ui->dwfl)
 		goto out;
 
-	err = perf_reg_value(&ip, &data->user_regs, PERF_REG_IP);
+	err = perf_reg_value(&ip, &data->user_regs, arch__reg_ip());
 	if (err)
 		goto out;
 
diff --git a/tools/perf/util/unwind.h b/tools/perf/util/unwind.h
index b2a03fa5289b..0a98ea9d8c94 100644
--- a/tools/perf/util/unwind.h
+++ b/tools/perf/util/unwind.h
@@ -43,11 +43,11 @@ int unwind__get_entries(unwind_entry_cb_t cb, void *arg,
 #endif
 
 #ifndef LIBUNWIND__ARCH_REG_SP
-#define LIBUNWIND__ARCH_REG_SP PERF_REG_SP
+#define LIBUNWIND__ARCH_REG_SP arch__reg_sp()
 #endif
 
 #ifndef LIBUNWIND__ARCH_REG_IP
-#define LIBUNWIND__ARCH_REG_IP PERF_REG_IP
+#define LIBUNWIND__ARCH_REG_IP arch__reg_ip()
 #endif
 
 int LIBUNWIND__ARCH_REG_ID(int regnum);
-- 
2.39.2

