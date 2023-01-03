Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23F7365C433
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 17:50:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238070AbjACQuO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 11:50:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237897AbjACQuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 11:50:09 -0500
X-Greylist: delayed 331 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 03 Jan 2023 08:50:04 PST
Received: from fx601.security-mail.net (smtpout140.security-mail.net [85.31.212.146])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 883F326F6
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 08:50:04 -0800 (PST)
Received: from localhost (fx601.security-mail.net [127.0.0.1])
        by fx601.security-mail.net (Postfix) with ESMTP id 08763349565
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 17:44:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalray.eu;
        s=sec-sig-email; t=1672764275;
        bh=JS+HtC1lA+Kr4cSv3Wk7v/czT2LlzONqGLrjIUqd0ZM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=P7OnHLGdDuAwVIoykTDmozTpgqMpbvdwcOPDff/Px9emn117CBrlsWH8Hb0ctF3rl
         ttgEgwCccTAwU9NInZ07OO3qfTs5TuR59/NbBgrfN8HF7+7/cu49VdoiahjWkB/kXp
         uZ6CqM4F+V/9cjmdoHmR7AZ6FfGUiZJprp4i6ePg=
Received: from fx601 (fx601.security-mail.net [127.0.0.1]) by
 fx601.security-mail.net (Postfix) with ESMTP id B57DA3494AC; Tue,  3 Jan
 2023 17:44:34 +0100 (CET)
Received: from zimbra2.kalray.eu (unknown [217.181.231.53]) by
 fx601.security-mail.net (Postfix) with ESMTPS id DF14A349509; Tue,  3 Jan
 2023 17:44:33 +0100 (CET)
Received: from zimbra2.kalray.eu (localhost [127.0.0.1]) by
 zimbra2.kalray.eu (Postfix) with ESMTPS id A20EA27E03F6; Tue,  3 Jan 2023
 17:44:33 +0100 (CET)
Received: from localhost (localhost [127.0.0.1]) by zimbra2.kalray.eu
 (Postfix) with ESMTP id 830FE27E03F4; Tue,  3 Jan 2023 17:44:33 +0100 (CET)
Received: from zimbra2.kalray.eu ([127.0.0.1]) by localhost
 (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10026) with ESMTP id
 2jRb9Y1q8kDj; Tue,  3 Jan 2023 17:44:33 +0100 (CET)
Received: from junon.lin.mbt.kalray.eu (unknown [192.168.37.161]) by
 zimbra2.kalray.eu (Postfix) with ESMTPSA id 4B4D827E0404; Tue,  3 Jan 2023
 17:44:33 +0100 (CET)
X-Virus-Scanned: E-securemail
Secumail-id: <13d48.63b45b71.dbc59.0>
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra2.kalray.eu 830FE27E03F4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalray.eu;
 s=32AE1B44-9502-11E5-BA35-3734643DEF29; t=1672764273;
 bh=PCKi+35fzL0XO4WXU3FNRWj16reIt3EESho87ZWjCP0=;
 h=From:To:Date:Message-Id:MIME-Version;
 b=qFQPJVpR7FPztqL7TwrXUcLSem00UxLPcDBeG1+n+KOk0qObBPZstS0P8/YgTLJXQ
 PsSWcKMNvcw5fdmsFWrc1HVqcIryjM/oUCVWpKDghEBfd9GyWV95wShcAgD+tUpuqO
 mscbEsHokW2FzywOzg57VluGOPzA4A2wGO0tx/lI=
From:   Yann Sionneau <ysionneau@kalray.eu>
Cc:     Yann Sionneau <ysionneau@kalray.eu>, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Clement Leger <clement.leger@bootlin.com>,
        Jules Maselbas <jmaselbas@kalray.eu>,
        Julian Vetter <jvetter@kalray.eu>
Subject: [RFC PATCH 24/25] kvx: Add support for CPU Perf Monitors
Date:   Tue,  3 Jan 2023 17:43:58 +0100
Message-ID: <20230103164359.24347-25-ysionneau@kalray.eu>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230103164359.24347-1-ysionneau@kalray.eu>
References: <20230103164359.24347-1-ysionneau@kalray.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8
X-ALTERMIMEV2_out: done
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Each kvx core includes several Perf Monitors.
This commit adds the driver that handles those core PM.

CC: Will Deacon <will@kernel.org>
CC: Mark Rutland <mark.rutland@arm.com>
CC: Rob Herring <robh+dt@kernel.org>
CC: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC: Peter Zijlstra <peterz@infradead.org>
CC: Ingo Molnar <mingo@redhat.com>
CC: Arnaldo Carvalho de Melo <acme@kernel.org>
CC: Alexander Shishkin <alexander.shishkin@linux.intel.com>
CC: Jiri Olsa <jolsa@kernel.org>
CC: Namhyung Kim <namhyung@kernel.org>
CC: linux-arm-kernel@lists.infradead.org
CC: devicetree@vger.kernel.org
CC: linux-kernel@vger.kernel.org
CC: linux-perf-users@vger.kernel.org
Co-developed-by: Clement Leger <clement.leger@bootlin.com>
Signed-off-by: Clement Leger <clement.leger@bootlin.com>
Co-developed-by: Jules Maselbas <jmaselbas@kalray.eu>
Signed-off-by: Jules Maselbas <jmaselbas@kalray.eu>
Co-developed-by: Julian Vetter <jvetter@kalray.eu>
Signed-off-by: Julian Vetter <jvetter@kalray.eu>
Co-developed-by: Yann Sionneau <ysionneau@kalray.eu>
Signed-off-by: Yann Sionneau <ysionneau@kalray.eu>
---
 .../devicetree/bindings/perf/kalray-pm.txt    |  21 +
 arch/kvx/include/asm/perf_event.h             |  90 +++
 arch/kvx/kernel/perf_event.c                  | 609 ++++++++++++++++++
 3 files changed, 720 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/perf/kalray-pm.txt
 create mode 100644 arch/kvx/include/asm/perf_event.h
 create mode 100644 arch/kvx/kernel/perf_event.c

diff --git a/Documentation/devicetree/bindings/perf/kalray-pm.txt b/Documentation/devicetree/bindings/perf/kalray-pm.txt
new file mode 100644
index 000000000000..9ce00d703941
--- /dev/null
+++ b/Documentation/devicetree/bindings/perf/kalray-pm.txt
@@ -0,0 +1,21 @@
+* Kalray kvx Performance Monitors
+
+KVX core has several Performance Monitors for counting cpu and cache events.
+The KVX PM representation in the device tree should be done as under:
+
+Required properties:
+
+- compatible :
+	"kalray,kvx-core-pm"
+
+- interrupts : The interrupt number for kvx PM is 3.
+- interrupt-parent : The kvx core interrupt controller.
+- kalray,pm-num : Number of Performance Monitors the kvx core has.
+
+Example:
+core_pm {
+	compatible = "kalray,kvx-core-pm";
+	interrupts = <3>;
+	interrupt-parent = <&core_intc>;
+	kalray,pm-num = <4>;
+}
diff --git a/arch/kvx/include/asm/perf_event.h b/arch/kvx/include/asm/perf_event.h
new file mode 100644
index 000000000000..bb0147dfdf47
--- /dev/null
+++ b/arch/kvx/include/asm/perf_event.h
@@ -0,0 +1,90 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Yann Sionneau
+ *            Clement Leger
+ */
+
+#ifndef _ASM_KVX_PERF_EVENT_H
+#define _ASM_KVX_PERF_EVENT_H
+
+#include <linux/perf_event.h>
+
+/**
+ * struct cpu_hw_events - per-cpu structure to describe PM resource usage
+ * @n_events:	number of events currently existing
+ * @events:	events[i] is the event using PMi. NULL if PMi is not used.
+ */
+struct cpu_hw_events {
+	unsigned int n_events;
+	struct perf_event **events;
+};
+
+enum kvx_pmc_ie {
+	PMC_IE_DISABLED,
+	PMC_IE_ENABLED
+};
+
+enum kvx_pm_idx {
+	KVX_PM_1,
+	KVX_PM_2,
+	KVX_PM_3
+};
+
+enum kvx_pm_event_code {
+	KVX_PM_PCC,
+	KVX_PM_ICC,
+	KVX_PM_EBE,
+	KVX_PM_ENIE,
+	KVX_PM_ENSE,
+	KVX_PM_ICHE,
+	KVX_PM_ICME,
+	KVX_PM_ICMABE,
+	KVX_PM_MNGIC,
+	KVX_PM_MIMHE,
+	KVX_PM_MIMME,
+	KVX_PM_IATSC,
+	KVX_PM_FE,
+	KVX_PM_PBSC,
+	KVX_PM_PNVC,
+	KVX_PM_PSC,
+	KVX_PM_TADBE,
+	KVX_PM_TABE,
+	KVX_PM_TBE,
+	KVX_PM_MDMHE,
+	KVX_PM_MDMME,
+	KVX_PM_DATSC,
+	KVX_PM_DCLHE,
+	KVX_PM_DCHE,
+	KVX_PM_DCLME,
+	KVX_PM_DCME,
+	KVX_PM_DARSC,
+	KVX_PM_LDSC,
+	KVX_PM_DCNGC,
+	KVX_PM_DMAE,
+	KVX_PM_LCFSC,
+	KVX_PM_MNGDC,
+	KVX_PM_MACC,
+	KVX_PM_TACC,
+	KVX_PM_IWC,
+	KVX_PM_WISC,
+	KVX_PM_SISC,
+	KVX_PM_DDSC,
+	KVX_PM_SC,
+	KVX_PM_ELE,
+	KVX_PM_ELNBE,
+	KVX_PM_ELUE,
+	KVX_PM_ELUNBE,
+	KVX_PM_ESE,
+	KVX_PM_ESNBE,
+	KVX_PM_EAE,
+	KVX_PM_CIRE,
+	KVX_PM_CIE,
+	KVX_PM_SE,
+	KVX_PM_RE,
+	KVX_PM_FSC,
+	KVX_PM_MAX,
+	KVX_PM_UNSUPPORTED = KVX_PM_MAX,
+};
+
+#endif /* _ASM_KVX_PERF_EVENT_H */
diff --git a/arch/kvx/kernel/perf_event.c b/arch/kvx/kernel/perf_event.c
new file mode 100644
index 000000000000..bfc547e78aba
--- /dev/null
+++ b/arch/kvx/kernel/perf_event.c
@@ -0,0 +1,609 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Yann Sionneau
+ *            Clement Leger
+ */
+
+#include <linux/of.h>
+#include <linux/of_irq.h>
+#include <linux/kernel.h>
+#include <linux/perf_event.h>
+#include <linux/errno.h>
+#include <linux/platform_device.h>
+#include <asm/perf_event.h>
+
+static unsigned int pm_num;
+static unsigned int kvx_pm_irq;
+static DEFINE_PER_CPU(struct cpu_hw_events, cpu_hw_events);
+
+static const enum kvx_pm_event_code kvx_hw_event_map[] = {
+	[PERF_COUNT_HW_CPU_CYCLES] = KVX_PM_PCC,
+	[PERF_COUNT_HW_INSTRUCTIONS] = KVX_PM_ENIE,
+	[PERF_COUNT_HW_CACHE_REFERENCES] = KVX_PM_UNSUPPORTED,
+	[PERF_COUNT_HW_CACHE_MISSES] = KVX_PM_UNSUPPORTED,
+	[PERF_COUNT_HW_BRANCH_INSTRUCTIONS] = KVX_PM_TABE,
+	[PERF_COUNT_HW_BRANCH_MISSES] = KVX_PM_UNSUPPORTED,
+	[PERF_COUNT_HW_BUS_CYCLES] = KVX_PM_PCC,
+	[PERF_COUNT_HW_STALLED_CYCLES_FRONTEND] = KVX_PM_PSC,
+	[PERF_COUNT_HW_STALLED_CYCLES_BACKEND] = KVX_PM_UNSUPPORTED,
+	[PERF_COUNT_HW_REF_CPU_CYCLES] = KVX_PM_UNSUPPORTED,
+};
+
+#define C(_x)			PERF_COUNT_HW_CACHE_##_x
+
+static const enum kvx_pm_event_code
+			kvx_cache_map[C(MAX)][C(OP_MAX)][C(RESULT_MAX)] = {
+[C(L1D)] = {
+	[C(OP_READ)] = {
+		[C(RESULT_ACCESS)] = KVX_PM_UNSUPPORTED,
+		[C(RESULT_MISS)] = KVX_PM_DCLME,
+	},
+	[C(OP_WRITE)] = {
+		[C(RESULT_ACCESS)] = KVX_PM_UNSUPPORTED,
+		[C(RESULT_MISS)] = KVX_PM_UNSUPPORTED,
+	},
+	[C(OP_PREFETCH)] = {
+		[C(RESULT_ACCESS)] = KVX_PM_UNSUPPORTED,
+		[C(RESULT_MISS)] = KVX_PM_UNSUPPORTED,
+	},
+},
+[C(L1I)] = {
+	[C(OP_READ)] = {
+		[C(RESULT_ACCESS)] = KVX_PM_UNSUPPORTED,
+		[C(RESULT_MISS)] = KVX_PM_ICME,
+	},
+	[C(OP_WRITE)] = {
+		[C(RESULT_ACCESS)] = KVX_PM_UNSUPPORTED,
+		[C(RESULT_MISS)] = KVX_PM_UNSUPPORTED,
+	},
+	[C(OP_PREFETCH)] = {
+		[C(RESULT_ACCESS)] = KVX_PM_UNSUPPORTED,
+		[C(RESULT_MISS)] = KVX_PM_UNSUPPORTED,
+	},
+},
+[C(LL)] = {
+	[C(OP_READ)] = {
+		[C(RESULT_ACCESS)] = KVX_PM_UNSUPPORTED,
+		[C(RESULT_MISS)] = KVX_PM_UNSUPPORTED,
+	},
+	[C(OP_WRITE)] = {
+		[C(RESULT_ACCESS)] = KVX_PM_UNSUPPORTED,
+		[C(RESULT_MISS)] = KVX_PM_UNSUPPORTED,
+	},
+	[C(OP_PREFETCH)] = {
+		[C(RESULT_ACCESS)] = KVX_PM_UNSUPPORTED,
+		[C(RESULT_MISS)] = KVX_PM_UNSUPPORTED,
+	},
+},
+[C(DTLB)] = {
+	[C(OP_READ)] = {
+		[C(RESULT_ACCESS)] = KVX_PM_UNSUPPORTED,
+		[C(RESULT_MISS)] = KVX_PM_UNSUPPORTED,
+	},
+	[C(OP_WRITE)] = {
+		[C(RESULT_ACCESS)] = KVX_PM_UNSUPPORTED,
+		[C(RESULT_MISS)] = KVX_PM_UNSUPPORTED,
+	},
+	[C(OP_PREFETCH)] = {
+		[C(RESULT_ACCESS)] = KVX_PM_UNSUPPORTED,
+		[C(RESULT_MISS)] = KVX_PM_UNSUPPORTED,
+	},
+},
+[C(ITLB)] = {
+	[C(OP_READ)] = {
+		[C(RESULT_ACCESS)] = KVX_PM_UNSUPPORTED,
+		[C(RESULT_MISS)] = KVX_PM_MIMME,
+	},
+	[C(OP_WRITE)] = {
+		[C(RESULT_ACCESS)] = KVX_PM_UNSUPPORTED,
+		[C(RESULT_MISS)] = KVX_PM_UNSUPPORTED,
+	},
+	[C(OP_PREFETCH)] = {
+		[C(RESULT_ACCESS)] = KVX_PM_UNSUPPORTED,
+		[C(RESULT_MISS)] = KVX_PM_UNSUPPORTED,
+	},
+},
+[C(BPU)] = {
+	[C(OP_READ)] = {
+		[C(RESULT_ACCESS)] = KVX_PM_UNSUPPORTED,
+		[C(RESULT_MISS)] = KVX_PM_UNSUPPORTED,
+	},
+	[C(OP_WRITE)] = {
+		[C(RESULT_ACCESS)] = KVX_PM_UNSUPPORTED,
+		[C(RESULT_MISS)] = KVX_PM_UNSUPPORTED,
+	},
+	[C(OP_PREFETCH)] = {
+		[C(RESULT_ACCESS)] = KVX_PM_UNSUPPORTED,
+		[C(RESULT_MISS)] = KVX_PM_UNSUPPORTED,
+	},
+},
+[C(NODE)] = {
+	[C(OP_READ)] = {
+		[C(RESULT_ACCESS)] = KVX_PM_UNSUPPORTED,
+		[C(RESULT_MISS)] = KVX_PM_UNSUPPORTED,
+	},
+	[C(OP_WRITE)] = {
+		[C(RESULT_ACCESS)] = KVX_PM_UNSUPPORTED,
+		[C(RESULT_MISS)] = KVX_PM_UNSUPPORTED,
+	},
+	[C(OP_PREFETCH)] = {
+		[C(RESULT_ACCESS)] = KVX_PM_UNSUPPORTED,
+		[C(RESULT_MISS)] = KVX_PM_UNSUPPORTED,
+	},
+},
+};
+
+static u64 read_counter(struct perf_event *event)
+{
+	struct hw_perf_event *hwc = &event->hw;
+	unsigned int pm = hwc->idx;
+
+	if (pm > pm_num) {
+		WARN_ONCE(1, "This PM (%u) does not exist!\n", pm);
+		return 0;
+	}
+	return kvx_sfr_iget(KVX_SFR_PM1 + pm);
+}
+
+static void kvx_pmu_read(struct perf_event *event)
+{
+	struct hw_perf_event *hwc = &event->hw;
+	u64 delta, prev_raw_count, new_raw_count;
+
+	do {
+		prev_raw_count = local64_read(&hwc->prev_count);
+		new_raw_count = read_counter(event);
+	} while (local64_cmpxchg(&hwc->prev_count, prev_raw_count,
+				new_raw_count) != prev_raw_count);
+	/*
+	 * delta is the value to update the counter we maintain in the kernel.
+	 */
+	delta = (new_raw_count - prev_raw_count);
+	local64_add(delta, &event->count);
+}
+
+static void kvx_set_pmc_ie(unsigned int pm_num, enum kvx_pmc_ie ievalue)
+{
+	u64 shifted_value = ((u64)ievalue << KVX_SFR_PMC_PM1IE_SHIFT)
+			     & KVX_SFR_PMC_PM1IE_MASK;
+	u64 clr_mask = KVX_SFR_PMC_PM1IE_MASK << pm_num;
+	u64 set_mask = shifted_value << pm_num;
+
+	kvx_sfr_set_mask(PMC, clr_mask, set_mask);
+}
+
+static void kvx_set_pmc(unsigned int pm_num, enum kvx_pm_event_code pmc_value)
+{
+	u64 pm_shift = (pm_num + 1) * KVX_SFR_PMC_PM1C_SHIFT;
+	u64 clr_mask = KVX_SFR_PMC_PM0C_MASK << pm_shift;
+	u64 set_mask = pmc_value << pm_shift;
+
+	kvx_sfr_set_mask(PMC, clr_mask, set_mask);
+}
+
+static void give_pm_to_user(unsigned int pm)
+{
+	int pl_value = 1 << (KVX_SFR_MOW_PM0_SHIFT
+				+ KVX_SFR_MOW_PM0_WIDTH * (pm + 1));
+	int pl_clr_mask = 3 << (KVX_SFR_MOW_PM0_SHIFT
+				+ KVX_SFR_MOW_PM0_WIDTH * (pm + 1));
+	kvx_sfr_set_mask(MOW, pl_clr_mask, pl_value);
+}
+
+static void get_pm_back_to_kernel(unsigned int pm)
+{
+	int pl_value = 0;
+	int pl_clr_mask = 3 << (KVX_SFR_MOW_PM0_SHIFT
+				+ KVX_SFR_MOW_PM0_WIDTH * (pm + 1));
+	kvx_sfr_set_mask(MOW, pl_clr_mask, pl_value);
+}
+
+static void kvx_set_pm(enum kvx_pm_idx pm, u64 value)
+{
+	switch (pm) {
+	case KVX_PM_1:
+		kvx_sfr_set(PM1, value);
+		break;
+	case KVX_PM_2:
+		kvx_sfr_set(PM2, value);
+		break;
+	case KVX_PM_3:
+		kvx_sfr_set(PM3, value);
+		break;
+	default:
+		WARN_ONCE(1, "This PM (%u) does not exist!\n", pm);
+	}
+}
+
+static void kvx_stop_sampling_event(unsigned int pm)
+{
+	kvx_set_pmc_ie(pm, PMC_IE_DISABLED);
+}
+
+static u64 kvx_start_sampling_event(struct perf_event *event, unsigned int pm)
+{
+	u64 start_value;
+
+	if (event->attr.freq) {
+		pr_err_once("kvx_pm: Frequency sampling is not supported\n");
+		return 0;
+	}
+
+	/* PM counter will overflow after "sample_period" ticks */
+	start_value = (u64)(-event->attr.sample_period);
+
+	kvx_set_pmc(pm, KVX_PM_SE);
+	kvx_set_pm(pm, start_value);
+	kvx_set_pmc_ie(pm, PMC_IE_ENABLED);
+	return start_value;
+}
+
+static void kvx_pmu_start(struct perf_event *event, int flags)
+{
+	struct hw_perf_event *hwc = &event->hw;
+	struct perf_event_attr *attr = &event->attr;
+	u64 pm_config = hwc->config;
+	unsigned int pm = hwc->idx;
+	u64 start_value = 0;
+
+	if (WARN_ON_ONCE(!(event->hw.state & PERF_HES_STOPPED)))
+		return;
+
+	if (flags & PERF_EF_RELOAD)
+		WARN_ON_ONCE(!(event->hw.state & PERF_HES_UPTODATE));
+
+	hwc->state = 0;
+	perf_event_update_userpage(event);
+
+	if (is_sampling_event(event))
+		start_value = kvx_start_sampling_event(event, pm);
+
+	local64_set(&hwc->prev_count, start_value);
+	if (attr->exclude_kernel)
+		give_pm_to_user(pm);
+	if (!is_sampling_event(event))
+		kvx_set_pmc(pm, KVX_PM_RE);
+	kvx_set_pmc(pm, pm_config);
+}
+
+static void kvx_pmu_stop(struct perf_event *event, int flags)
+{
+	struct hw_perf_event *hwc = &event->hw;
+	struct perf_event_attr *attr = &event->attr;
+	unsigned int pm = hwc->idx;
+
+	if (is_sampling_event(event))
+		kvx_stop_sampling_event(pm);
+
+	kvx_set_pmc(pm, KVX_PM_SE);
+	if (attr->exclude_kernel)
+		get_pm_back_to_kernel(pm);
+
+	WARN_ON_ONCE(hwc->state & PERF_HES_STOPPED);
+	hwc->state |= PERF_HES_STOPPED;
+
+	if ((flags & PERF_EF_UPDATE) && !(hwc->state & PERF_HES_UPTODATE)) {
+		kvx_pmu_read(event);
+		hwc->state |= PERF_HES_UPTODATE;
+	}
+}
+
+static void kvx_pmu_del(struct perf_event *event, int flags)
+{
+	struct hw_perf_event *hwc = &event->hw;
+	struct cpu_hw_events *cpuc = &get_cpu_var(cpu_hw_events);
+
+	cpuc->events[hwc->idx] = NULL;
+	cpuc->n_events--;
+	put_cpu_var(cpu_hw_events);
+	kvx_pmu_stop(event, PERF_EF_UPDATE);
+	perf_event_update_userpage(event);
+}
+
+static int kvx_pmu_add(struct perf_event *event, int flags)
+{
+	struct hw_perf_event *hwc = &event->hw;
+	struct cpu_hw_events *cpuc = &get_cpu_var(cpu_hw_events);
+	unsigned int i, idx = -1;
+
+	if (cpuc->n_events >= pm_num) {
+		put_cpu_var(cpu_hw_events);
+		return -ENOSPC;
+	}
+
+	for (i = 0; i < pm_num; i++)
+		if (cpuc->events[i] == NULL)
+			idx = i;
+
+	BUG_ON(idx == -1);
+
+	hwc->idx = idx;
+	cpuc->events[idx] = event;
+	cpuc->n_events++;
+	put_cpu_var(cpu_hw_events);
+	hwc->state = PERF_HES_UPTODATE | PERF_HES_STOPPED;
+
+	if (flags & PERF_EF_START)
+		kvx_pmu_start(event, PERF_EF_RELOAD);
+
+	return 0;
+}
+
+static enum kvx_pm_event_code kvx_pmu_cache_event(u64 config)
+{
+	unsigned int type, op, result;
+	enum kvx_pm_event_code code;
+
+	type = (config >> 0) & 0xff;
+	op = (config >> 8) & 0xff;
+	result = (config >> 16) & 0xff;
+	if (type >= PERF_COUNT_HW_CACHE_MAX ||
+	    op >= PERF_COUNT_HW_CACHE_OP_MAX ||
+	    result >= PERF_COUNT_HW_CACHE_RESULT_MAX)
+		return KVX_PM_UNSUPPORTED;
+
+	code = kvx_cache_map[type][op][result];
+
+	return code;
+}
+
+static int kvx_pm_starting_cpu(unsigned int cpu)
+{
+	struct cpu_hw_events *cpuc = &per_cpu(cpu_hw_events, cpu);
+
+	cpuc->events = kmalloc_array(pm_num, sizeof(struct perf_event *),
+								 GFP_ATOMIC);
+	if (!cpuc->events)
+		return -ENOMEM;
+
+	memset(cpuc->events, 0, pm_num * sizeof(struct perf_event *));
+
+	enable_percpu_irq(kvx_pm_irq, IRQ_TYPE_NONE);
+	return 0;
+}
+
+static int kvx_pm_dying_cpu(unsigned int cpu)
+{
+	struct cpu_hw_events *cpuc = &get_cpu_var(cpu_hw_events);
+
+	disable_percpu_irq(kvx_pm_irq);
+	kfree(cpuc->events);
+	put_cpu_var(cpu_hw_events);
+	return 0;
+}
+
+static enum kvx_pm_event_code kvx_pmu_raw_events(u64 config)
+{
+	if (config >= KVX_PM_MAX)
+		return KVX_PM_UNSUPPORTED;
+
+	if (config == KVX_PM_SE || config == KVX_PM_RE)
+		return KVX_PM_UNSUPPORTED;
+
+	return config;
+}
+
+static int kvx_pmu_event_init(struct perf_event *event)
+{
+	struct perf_event_attr *attr = &event->attr;
+	struct hw_perf_event *hwc = &event->hw;
+	enum kvx_pm_event_code code;
+
+	if (attr->exclude_user && !attr->exclude_kernel) {
+		attr->exclude_user = 0;
+		pr_err_once("kvx_pm: Cannot exclude userspace from perf events and not kernelspace\n");
+	}
+
+	switch (attr->type) {
+	case PERF_TYPE_HARDWARE:
+		code = kvx_hw_event_map[attr->config];
+		break;
+	case PERF_TYPE_HW_CACHE:
+		code = kvx_pmu_cache_event(attr->config);
+		break;
+	case PERF_TYPE_RAW:
+		code = kvx_pmu_raw_events(attr->config);
+		break;
+	default:
+		return -ENOENT;
+	}
+
+	if (code == KVX_PM_UNSUPPORTED)
+		return -EOPNOTSUPP;
+
+	hwc->config = code;
+	hwc->idx = -1;
+
+	if (event->cpu >= 0 && !cpu_online(event->cpu))
+		return -ENODEV;
+
+	return 0;
+}
+
+static struct pmu pmu = {
+	.event_init	= kvx_pmu_event_init,
+	.add		= kvx_pmu_add,
+	.del		= kvx_pmu_del,
+	.start		= kvx_pmu_start,
+	.stop		= kvx_pmu_stop,
+	.read		= kvx_pmu_read,
+};
+
+static void kvx_pm_clear_sav(void)
+{
+	u64 clr_mask = KVX_SFR_PMC_SAV_MASK;
+	u64 set_mask = 0;
+
+	kvx_sfr_set_mask(PMC, clr_mask, set_mask);
+}
+
+static void kvx_pm_reload(struct perf_event *event)
+{
+	struct hw_perf_event *hwc = &event->hw;
+	u64 pm = hwc->idx;
+	u64 start_value = (u64)(-event->attr.sample_period);
+
+	kvx_set_pmc(pm, KVX_PM_SE);
+	kvx_set_pm(pm, start_value);
+}
+
+static bool kvx_pm_is_sav_set(void)
+{
+	return kvx_sfr_get(PMC) & KVX_SFR_PMC_SAV_MASK;
+}
+
+static int handle_pm_overflow(u8 pm_id, struct perf_event *event, u64 pmc,
+			      struct pt_regs *regs)
+{
+	u64 pm_ie_mask = KVX_SFR_PMC_PM0IE_MASK << (pm_id + 1);
+	u64 pmc_event_code_mask = KVX_SFR_PMC_PM0C_MASK <<
+					((pm_id + 1)
+					* KVX_SFR_PMC_PM1C_SHIFT);
+	struct hw_perf_event *hwc = &event->hw;
+	struct perf_sample_data data;
+	u64 sample_period;
+	u64 pm;
+
+	sample_period = event->attr.sample_period;
+	pm = kvx_sfr_iget(pm_id + KVX_SFR_PM1);
+
+	/*
+	 * check if this pm has just overflowed
+	 * ie: pm value is 0, pm interrupt is enabled
+	 * and pm is not stopped.
+	 */
+	if ((pm < local64_read(&hwc->prev_count)) && (pmc & pm_ie_mask)
+		&& ((pmc & pmc_event_code_mask) != KVX_PM_SE)) {
+		perf_sample_data_init(&data, 0, sample_period);
+		if (perf_event_overflow(event, &data, regs))
+			pmu.stop(event, 0);
+		else {
+			kvx_pmu_read(event);
+			if (is_sampling_event(event))
+				kvx_pm_reload(event);
+		}
+		return 1;
+	}
+
+	return 0;
+}
+
+irqreturn_t pm_irq_handler(int irq, void *dev_id)
+{
+	struct cpu_hw_events *cpuc = &get_cpu_var(cpu_hw_events);
+	struct pt_regs *regs;
+	enum kvx_pm_idx pm_id;
+	u64 pmc;
+	bool a_pm_overflowed = false;
+	irqreturn_t ret = IRQ_NONE;
+
+	regs = get_irq_regs();
+	pmc = kvx_sfr_get(PMC);
+
+	for (pm_id = KVX_PM_1; pm_id <= KVX_PM_3; pm_id++) {
+		struct perf_event *event = cpuc->events[pm_id];
+
+		if (!event)
+			continue;
+
+		if (handle_pm_overflow(pm_id, event, pmc, regs)) {
+			ret = IRQ_HANDLED;
+			a_pm_overflowed = true;
+		}
+	}
+
+	put_cpu_var(cpu_hw_events);
+
+	if (likely(kvx_pm_is_sav_set()))
+		kvx_pm_clear_sav();
+	else
+		pr_err_once("kvx_pm: PM triggered an IRQ but did not set pmc.sav\n");
+
+	if (unlikely(!a_pm_overflowed))
+		pr_err_once("kvx_pm: PM triggered an IRQ but no PM seemed to have overflowed\n");
+
+	if (ret == IRQ_HANDLED)
+		irq_work_run();
+	return ret;
+}
+
+static int kvx_pmu_device_probe(struct platform_device *pdev)
+{
+	int ret;
+	int statenum;
+	struct device *dev = &pdev->dev;
+
+	ret = of_property_read_u32(dev->of_node, "kalray,pm-num", &pm_num);
+	if (ret < 0) {
+		dev_err(dev, "Cannot read kalray,pm-num from device tree\n");
+		return -ENODEV;
+	}
+
+	/*
+	 * PM0 is reserved for cycle counting, that's why pm_num is
+	 * decremented.
+	 */
+	if (pm_num-- < 2) {
+		dev_err(dev, "Not enough PM to handle perf events, at least 2 are needed\n");
+		return -ENODEV;
+	}
+
+	kvx_pm_irq = platform_get_irq(pdev, 0);
+	if (!kvx_pm_irq) {
+		dev_err(dev, "Failed to parse pm irq\n");
+		return -ENODEV;
+	}
+
+	ret = request_percpu_irq(kvx_pm_irq, pm_irq_handler, "pm",
+				 this_cpu_ptr(&cpu_hw_events));
+	if (ret) {
+		dev_err(dev, "Failed to request pm irq\n");
+		return -ENODEV;
+	}
+
+	ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN,
+				"kvx/pm_handler:online",
+				kvx_pm_starting_cpu,
+				kvx_pm_dying_cpu);
+
+	if (ret <= 0) {
+		dev_err(dev, "Failed to setup cpuhp\n");
+		goto free_irq;
+	}
+	statenum = ret;
+
+	ret = perf_pmu_register(&pmu, "cpu", PERF_TYPE_RAW);
+	if (ret) {
+		dev_err(dev, "Failed to register CPU PM as PMU\n");
+		goto free_cpuhp_state;
+	}
+
+	return ret;
+
+free_cpuhp_state:
+	cpuhp_remove_state(statenum);
+free_irq:
+	free_percpu_irq(kvx_pm_irq, this_cpu_ptr(&cpu_hw_events));
+	return ret;
+}
+
+static const struct of_device_id kvx_pmu_of_device_ids[] = {
+	{.compatible = "kalray,kvx-core-pm"},
+	{},
+};
+
+static struct platform_driver kvx_pmu_driver = {
+	.driver		= {
+		.name	= "pmu",
+		.of_match_table = kvx_pmu_of_device_ids,
+	},
+	.probe		= kvx_pmu_device_probe,
+};
+
+static int __init kvx_pmu_driver_init(void)
+{
+	return platform_driver_register(&kvx_pmu_driver);
+}
+
+device_initcall(kvx_pmu_driver_init);
-- 
2.37.2





