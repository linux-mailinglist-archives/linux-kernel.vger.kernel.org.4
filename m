Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D23DF700325
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 10:59:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240262AbjELI7P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 04:59:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239962AbjELI7N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 04:59:13 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFD092126
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 01:59:01 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3f41dceb93bso47351705e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 01:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1683881939; x=1686473939;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=auEBRN2lcyYVkA8p39p5E0HKp2AG0HFM1Iq4RKvNqy8=;
        b=PYILGPVm1u1SLjSKLQ/v0K85MTUz7HTUsHh0yWuNzPMqOQf4FDz9QA/C2q02gakYqK
         zmx8Tf7vp0TV9E5/JB6ovu0WM7d1DJBq1FKBmObHSRzZL7+vuUt5EGLSHqe3+pbA+yXD
         qpTxVkQH+7W3nnHQbnq1OJF66pxReOrxVuTgF9trd0+uS5VDQQkChoYW068XV6zQfg+J
         xFW/pbo+xwyO7B7QtRpmMb3Ilm28u3jBhL4EysnQSTP//Ho386dAG+PXnQ3RRa5YqMyf
         t1eLawZfxoaXmA4ZpZrxb/N8yh5o3vX4C9ZqZd6e2l/5S4n7J2yPblIpejEkWvGITNJQ
         LL4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683881939; x=1686473939;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=auEBRN2lcyYVkA8p39p5E0HKp2AG0HFM1Iq4RKvNqy8=;
        b=VM4upbjU2lvDp7SsfSL1xEb6FXQf4V8MTUzaBXBDRN3/bUpRUyWS/Y+/6fti8RkUe2
         cuE3OdLUPERPsP4BG0s7F876O2+vgdBHYWgkaMIvdNolPYwpV2OvgQpcVf7I6dBll0ze
         XdEZ/WBPNNZ3xlMqup+gv0p/RbOATI5kV3+W6KkIcMA2UnJHZQscqi7IhzASxmJ4gnHv
         uBYsx2rdw2d+B62oVbg2R+Oj8xZ2wnB1hn37mBmgFb+RkJ7JYNXVHVKVEnriA61clLSX
         tnQ7oJAUD95O6h1UYXxdjTLssNlvOlf7xtw82BQNR3xQtORy0voyO6i6QdrFcc2A8pN7
         n+jA==
X-Gm-Message-State: AC+VfDyOgdj9pRP78+uqVMKvcdcJ7oS//M6EHT1TQPMgmhoF7tf/Z6bV
        u2OfP9+IZ5fa/IBNDyra5qncew==
X-Google-Smtp-Source: ACHHUZ4w3XxL46CEpN2TpylBYb2q8VUzboEHRsNvqLVvI/kTnMUywknk6ML4Wc8wpJHP+1Taj6Oteg==
X-Received: by 2002:a1c:f007:0:b0:3f3:2b37:dd30 with SMTP id a7-20020a1cf007000000b003f32b37dd30mr16216356wmb.22.1683881938884;
        Fri, 12 May 2023 01:58:58 -0700 (PDT)
Received: from alex-rivos.home (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id p8-20020a056000018800b002f28de9f73bsm23131441wrx.55.2023.05.12.01.58.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 01:58:58 -0700 (PDT)
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atishp@atishpatra.org>,
        Anup Patel <anup@brainfault.org>,
        Will Deacon <will@kernel.org>, Rob Herring <robh@kernel.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH v2 05/10] riscv: Prepare for user-space perf event mmap support
Date:   Fri, 12 May 2023 10:53:16 +0200
Message-Id: <20230512085321.13259-6-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230512085321.13259-1-alexghiti@rivosinc.com>
References: <20230512085321.13259-1-alexghiti@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide all the necessary bits in the generic riscv pmu driver to be
able to mmap perf events in userspace: the heavy lifting lies in the
driver backend, namely the legacy and sbi implementations.

Note that arch_perf_update_userpage is almost a copy of arm64 code.

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/riscv/kernel/Makefile     |  2 +-
 arch/riscv/kernel/perf_event.c | 58 ++++++++++++++++++++++++++++++++++
 drivers/perf/riscv_pmu.c       | 41 ++++++++++++++++++++++++
 include/linux/perf/riscv_pmu.h |  4 +++
 4 files changed, 104 insertions(+), 1 deletion(-)
 create mode 100644 arch/riscv/kernel/perf_event.c

diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
index 4cf303a779ab..0d215fd9860d 100644
--- a/arch/riscv/kernel/Makefile
+++ b/arch/riscv/kernel/Makefile
@@ -70,7 +70,7 @@ obj-$(CONFIG_DYNAMIC_FTRACE)	+= mcount-dyn.o
 
 obj-$(CONFIG_TRACE_IRQFLAGS)	+= trace_irq.o
 
-obj-$(CONFIG_PERF_EVENTS)	+= perf_callchain.o
+obj-$(CONFIG_PERF_EVENTS)	+= perf_callchain.o perf_event.o
 obj-$(CONFIG_HAVE_PERF_REGS)	+= perf_regs.o
 obj-$(CONFIG_RISCV_SBI)		+= sbi.o
 ifeq ($(CONFIG_RISCV_SBI), y)
diff --git a/arch/riscv/kernel/perf_event.c b/arch/riscv/kernel/perf_event.c
new file mode 100644
index 000000000000..94174a0fc251
--- /dev/null
+++ b/arch/riscv/kernel/perf_event.c
@@ -0,0 +1,58 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <linux/sched_clock.h>
+
+void arch_perf_update_userpage(struct perf_event *event,
+			       struct perf_event_mmap_page *userpg, u64 now)
+{
+	struct clock_read_data *rd;
+	unsigned int seq;
+	u64 ns;
+
+	userpg->cap_user_time = 0;
+	userpg->cap_user_time_zero = 0;
+	userpg->cap_user_time_short = 0;
+	userpg->cap_user_rdpmc =
+		!!(event->hw.flags & PERF_EVENT_FLAG_USER_READ_CNT);
+
+	userpg->pmc_width = 64;
+
+	do {
+		rd = sched_clock_read_begin(&seq);
+
+		userpg->time_mult = rd->mult;
+		userpg->time_shift = rd->shift;
+		userpg->time_zero = rd->epoch_ns;
+		userpg->time_cycles = rd->epoch_cyc;
+		userpg->time_mask = rd->sched_clock_mask;
+
+		/*
+		 * Subtract the cycle base, such that software that
+		 * doesn't know about cap_user_time_short still 'works'
+		 * assuming no wraps.
+		 */
+		ns = mul_u64_u32_shr(rd->epoch_cyc, rd->mult, rd->shift);
+		userpg->time_zero -= ns;
+
+	} while (sched_clock_read_retry(seq));
+
+	userpg->time_offset = userpg->time_zero - now;
+
+	/*
+	 * time_shift is not expected to be greater than 31 due to
+	 * the original published conversion algorithm shifting a
+	 * 32-bit value (now specifies a 64-bit value) - refer
+	 * perf_event_mmap_page documentation in perf_event.h.
+	 */
+	if (userpg->time_shift == 32) {
+		userpg->time_shift = 31;
+		userpg->time_mult >>= 1;
+	}
+
+	/*
+	 * Internal timekeeping for enabled/running/stopped times
+	 * is always computed with the sched_clock.
+	 */
+	userpg->cap_user_time = 1;
+	userpg->cap_user_time_zero = 1;
+	userpg->cap_user_time_short = 1;
+}
diff --git a/drivers/perf/riscv_pmu.c b/drivers/perf/riscv_pmu.c
index ebca5eab9c9b..af69da268246 100644
--- a/drivers/perf/riscv_pmu.c
+++ b/drivers/perf/riscv_pmu.c
@@ -171,6 +171,8 @@ int riscv_pmu_event_set_period(struct perf_event *event)
 
 	local64_set(&hwc->prev_count, (u64)-left);
 
+	perf_event_update_userpage(event);
+
 	return overflow;
 }
 
@@ -267,6 +269,9 @@ static int riscv_pmu_event_init(struct perf_event *event)
 	hwc->idx = -1;
 	hwc->event_base = mapped_event;
 
+	if (rvpmu->event_init)
+		rvpmu->event_init(event);
+
 	if (!is_sampling_event(event)) {
 		/*
 		 * For non-sampling runs, limit the sample_period to half
@@ -283,6 +288,39 @@ static int riscv_pmu_event_init(struct perf_event *event)
 	return 0;
 }
 
+static int riscv_pmu_event_idx(struct perf_event *event)
+{
+	struct riscv_pmu *rvpmu = to_riscv_pmu(event->pmu);
+
+	if (!(event->hw.flags & PERF_EVENT_FLAG_USER_READ_CNT))
+		return 0;
+
+	if (rvpmu->csr_index)
+		return rvpmu->csr_index(event) + 1;
+
+	return 0;
+}
+
+static void riscv_pmu_event_mapped(struct perf_event *event, struct mm_struct *mm)
+{
+	struct riscv_pmu *rvpmu = to_riscv_pmu(event->pmu);
+
+	if (rvpmu->event_mapped) {
+		rvpmu->event_mapped(event, mm);
+		perf_event_update_userpage(event);
+	}
+}
+
+static void riscv_pmu_event_unmapped(struct perf_event *event, struct mm_struct *mm)
+{
+	struct riscv_pmu *rvpmu = to_riscv_pmu(event->pmu);
+
+	if (rvpmu->event_unmapped) {
+		rvpmu->event_unmapped(event, mm);
+		perf_event_update_userpage(event);
+	}
+}
+
 struct riscv_pmu *riscv_pmu_alloc(void)
 {
 	struct riscv_pmu *pmu;
@@ -307,6 +345,9 @@ struct riscv_pmu *riscv_pmu_alloc(void)
 	}
 	pmu->pmu = (struct pmu) {
 		.event_init	= riscv_pmu_event_init,
+		.event_mapped	= riscv_pmu_event_mapped,
+		.event_unmapped	= riscv_pmu_event_unmapped,
+		.event_idx	= riscv_pmu_event_idx,
 		.add		= riscv_pmu_add,
 		.del		= riscv_pmu_del,
 		.start		= riscv_pmu_start,
diff --git a/include/linux/perf/riscv_pmu.h b/include/linux/perf/riscv_pmu.h
index 9f70d94942e0..1452c8af3b67 100644
--- a/include/linux/perf/riscv_pmu.h
+++ b/include/linux/perf/riscv_pmu.h
@@ -55,6 +55,10 @@ struct riscv_pmu {
 	void		(*ctr_start)(struct perf_event *event, u64 init_val);
 	void		(*ctr_stop)(struct perf_event *event, unsigned long flag);
 	int		(*event_map)(struct perf_event *event, u64 *config);
+	void		(*event_init)(struct perf_event *event);
+	void		(*event_mapped)(struct perf_event *event, struct mm_struct *mm);
+	void		(*event_unmapped)(struct perf_event *event, struct mm_struct *mm);
+	uint8_t		(*csr_index)(struct perf_event *event);
 
 	struct cpu_hw_events	__percpu *hw_events;
 	struct hlist_node	node;
-- 
2.37.2

