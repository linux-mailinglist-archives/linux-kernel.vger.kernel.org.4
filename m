Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 113F374377A
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 10:37:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232213AbjF3IhT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 04:37:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232321AbjF3Igu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 04:36:50 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CAFC1BCA
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 01:36:48 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3fbc59de0e2so6807415e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 01:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1688114206; x=1690706206;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XbFrV/q7Aw3mH90ZjkDcoZb78N1NQiIc7nnyXH9eDMc=;
        b=lk4ROx+445tjGoiFoANbfoxzkU/tTN0mTJrJx7aWYCV262XC66c5hSNLo6pJryncjC
         FaAZsSwUMZVVIGrUk2nq0JvLfgk4zShuHsZDCgmzBUpYcbFKpkHwLDlg4Wz8ysOW83Ko
         TieV7rqnvdXVDf+yeoLeOYUADZ7zHQZZ/CwEFEBNhZX26aXYy7qI3gFc/m2tmtWQbpLw
         Mn/N/+AzNfGZ4garHVqizQAh0/Pl5TdSiegTXP2bCOYPbaf4BDsq6xtDmz2sDKuV24dc
         +6SoRTE7RPAHsY8jra+nTGvLlPBQTB7lgBxh4sXnbvIY0pskHqVSaJdDVxiZIe8M172Q
         97sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688114206; x=1690706206;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XbFrV/q7Aw3mH90ZjkDcoZb78N1NQiIc7nnyXH9eDMc=;
        b=KdFip7pfb19k6LCNCYM9CkScxwQGs0Pp9+JDb+G30bXiqob5wrdf/wSa6zgLUH0OCV
         vyZU/O0/A0WlpdaajIcNE8GCOQJJXbuJ9PmMPUuzd2qtYqCq+P8MvJHvGrFYaGAfbhpR
         o5GXSy5qS513ZDTgtt4QMdwisxcynkSoWvGWgJjJhqBjj3M5Gpo2ZvvmHSqBE2oyZ/iw
         0Nk8kI5EZls0zzC1LZtVggSQL8QmyfFUfWMquIoBeH5E4XumFfHYndqmSI1zyoQrdxtc
         gC/IwEh33pKCOxSgCRzO1bvhajLL09lA4cJhdyt+52MgFte/+SpqvRy3o29zsIf1/S6c
         iX9A==
X-Gm-Message-State: AC+VfDx65DbHYpetks/Hdtlj+wXY+ktoM1gMaPof5w6RE28PXL+NAcU/
        xmhhONZgjV0lIdo6cGaCPStfLA==
X-Google-Smtp-Source: ACHHUZ5E6Ts0FdjdtogyYoZnx3gLffIu8xGsaINIU3rFCRVUCOnwwLWUUeKyhOEVWUyaOE/vpwyl5Q==
X-Received: by 2002:a1c:7706:0:b0:3fb:b61f:c719 with SMTP id t6-20020a1c7706000000b003fbb61fc719mr1388538wmi.33.1688114206421;
        Fri, 30 Jun 2023 01:36:46 -0700 (PDT)
Received: from alex-rivos.ba.rivosinc.com (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id 12-20020a05600c028c00b003fbaade072dsm8024200wmk.23.2023.06.30.01.36.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jun 2023 01:36:45 -0700 (PDT)
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
Subject: [PATCH v3 05/10] riscv: Prepare for user-space perf event mmap support
Date:   Fri, 30 Jun 2023 10:30:08 +0200
Message-Id: <20230630083013.102334-6-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230630083013.102334-1-alexghiti@rivosinc.com>
References: <20230630083013.102334-1-alexghiti@rivosinc.com>
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
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
 drivers/perf/riscv_pmu.c       | 106 +++++++++++++++++++++++++++++++++
 include/linux/perf/riscv_pmu.h |   4 ++
 2 files changed, 110 insertions(+)

diff --git a/drivers/perf/riscv_pmu.c b/drivers/perf/riscv_pmu.c
index ebca5eab9c9b..e1b0992f34df 100644
--- a/drivers/perf/riscv_pmu.c
+++ b/drivers/perf/riscv_pmu.c
@@ -14,9 +14,74 @@
 #include <linux/perf/riscv_pmu.h>
 #include <linux/printk.h>
 #include <linux/smp.h>
+#include <linux/sched_clock.h>
 
 #include <asm/sbi.h>
 
+static bool riscv_perf_user_access(struct perf_event *event)
+{
+	return ((event->attr.type == PERF_TYPE_HARDWARE) ||
+		(event->attr.type == PERF_TYPE_HW_CACHE) ||
+		(event->attr.type == PERF_TYPE_RAW)) &&
+		!!(event->hw.flags & PERF_EVENT_FLAG_USER_READ_CNT);
+}
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
+	userpg->cap_user_rdpmc = riscv_perf_user_access(event);
+
+	if (userpg->cap_user_rdpmc)
+		userpg->pmc_width = 64;
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
+
 static unsigned long csr_read_num(int csr_num)
 {
 #define switchcase_csr_read(__csr_num, __val)		{\
@@ -171,6 +236,8 @@ int riscv_pmu_event_set_period(struct perf_event *event)
 
 	local64_set(&hwc->prev_count, (u64)-left);
 
+	perf_event_update_userpage(event);
+
 	return overflow;
 }
 
@@ -267,6 +334,9 @@ static int riscv_pmu_event_init(struct perf_event *event)
 	hwc->idx = -1;
 	hwc->event_base = mapped_event;
 
+	if (rvpmu->event_init)
+		rvpmu->event_init(event);
+
 	if (!is_sampling_event(event)) {
 		/*
 		 * For non-sampling runs, limit the sample_period to half
@@ -283,6 +353,39 @@ static int riscv_pmu_event_init(struct perf_event *event)
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
@@ -307,6 +410,9 @@ struct riscv_pmu *riscv_pmu_alloc(void)
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
index 5deeea0be7cb..43282e22ebe1 100644
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
2.39.2

