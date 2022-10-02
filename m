Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C74E5F22CA
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Oct 2022 12:56:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbiJBK4o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Oct 2022 06:56:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbiJBK4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Oct 2022 06:56:39 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 885294B0D5
        for <linux-kernel@vger.kernel.org>; Sun,  2 Oct 2022 03:56:38 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id ay36so5409423wmb.0
        for <linux-kernel@vger.kernel.org>; Sun, 02 Oct 2022 03:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date;
        bh=FkxG3mDaFMlIVViAmYgmtnKDeZSqlX7aYvVpOT7KfYY=;
        b=PtZNBSlWmMQpkOt2PbSlZn7HH10KNkc3xENzkpWHP426TJ3D0GTilusQKInx3ETR2P
         /XyzQf1LnUUkqHCalG1ZkBUgB+/QgwvIam1gL2mzAwsrTSatEg3uVDidjdyR4TKRy0Mg
         wWqCEso2UXq1ne6tYmSZiXLa9wxSB800t/WCI1PXXJlfvpUSmplT4Jn7V8q7YzpcdGSy
         hDoMuqTRXh/8O8+myZSj34dYxYf6GmxOErvZ/38lHrhPOCJQGa+YAS8LjvQWk6J/q00q
         1e8e3HLQz+vO4dMSmAIMO73cWJDg7wzzmfgcQs4C+ybUpDDmc139LyQWyglbHD0pTc9o
         QwKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date;
        bh=FkxG3mDaFMlIVViAmYgmtnKDeZSqlX7aYvVpOT7KfYY=;
        b=F1aKai3PQg/OjvOoU6FjAd0LxFor/hyLpnnVqZOjdT2epj4V29pCQjOHgZI/C08+j+
         LVGplLC9UqsuiVAJ/4Sc3Li7gekOF1aPUVWzQUi4ifWu9XXTTr/XfNj2CWkmF8f29vH/
         ZoHUgah14PZ9HgwIFjT4NjpzjrvWaoxqcTYlfWalnOLehlzA3YVEDo5vH6N+T13RCFJ0
         4WCG3qWuFrFbaU8dHWIVHZHcqgxiIRMlWMKQCgYOLQCZ8CNMQWx7RO0xBLtqs/xEk3+C
         /d++x6ikn+NO1tI92BD9jaYuoWhj595VEaUVFKd10BJf0+NNFW8/Fcy24oEa6/FZr+Kw
         plyQ==
X-Gm-Message-State: ACrzQf23LbJsJfgEw8atwZBjoeOO2Rrnf90CwNx+p4Vd9SgxBHsVwEvj
        nq05kgcvxLgCDbnd09bKOC1Pzep86pw=
X-Google-Smtp-Source: AMsMyM7yX1c4X3t+1EE4uAB4khTWyqWwqmPM0Le5aesBIqV4ZqKLsL/wr3zMGDqyxx9ihz7ZUBYhSQ==
X-Received: by 2002:a05:600c:4c96:b0:3b5:52d6:1573 with SMTP id g22-20020a05600c4c9600b003b552d61573mr3952584wmp.9.1664708196948;
        Sun, 02 Oct 2022 03:56:36 -0700 (PDT)
Received: from gmail.com (195-38-113-168.pool.digikabel.hu. [195.38.113.168])
        by smtp.gmail.com with ESMTPSA id j19-20020a05600c1c1300b003a5ca627333sm14260647wms.8.2022.10.02.03.56.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Oct 2022 03:56:36 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Sun, 2 Oct 2022 12:56:34 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Subject: [GIT PULL] perf fixes
Message-ID: <YzluYmeYjbxCr8wd@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest perf/urgent git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-2022-10-02

   # HEAD: 6b959ba22d34ca793ffdb15b5715457c78e38b1a perf/core: Fix reentry problem in perf_output_read_group()

Misc fixes:

 - Fix a PMU enumeration/initialization bug on Intel Alder Lake CPUs.
 - Fix KVM guest PEBS register handling.
 - Fix race/reentry bug in perf_output_read_group() reading of PMU counters.

 Thanks,

	Ingo

------------------>
Kan Liang (1):
      perf/x86/intel: Fix unchecked MSR access error for Alder Lake N

Like Xu (1):
      perf/x86/core: Completely disable guest PEBS via guest's global_ctrl

Yang Jihong (1):
      perf/core: Fix reentry problem in perf_output_read_group()


 arch/x86/events/intel/core.c | 43 +++++++++++++++++++++++++++++++++++++++++--
 arch/x86/events/intel/ds.c   |  9 +++++++--
 arch/x86/events/perf_event.h |  2 ++
 kernel/events/core.c         |  9 +++++++++
 4 files changed, 59 insertions(+), 4 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index cb98a05ee743..c20d8cd47c48 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2102,6 +2102,15 @@ static struct extra_reg intel_tnt_extra_regs[] __read_mostly = {
 	EVENT_EXTRA_END
 };
 
+EVENT_ATTR_STR(mem-loads,	mem_ld_grt,	"event=0xd0,umask=0x5,ldlat=3");
+EVENT_ATTR_STR(mem-stores,	mem_st_grt,	"event=0xd0,umask=0x6");
+
+static struct attribute *grt_mem_attrs[] = {
+	EVENT_PTR(mem_ld_grt),
+	EVENT_PTR(mem_st_grt),
+	NULL
+};
+
 static struct extra_reg intel_grt_extra_regs[] __read_mostly = {
 	/* must define OFFCORE_RSP_X first, see intel_fixup_er() */
 	INTEL_UEVENT_EXTRA_REG(0x01b7, MSR_OFFCORE_RSP_0, 0x3fffffffffull, RSP_0),
@@ -4052,8 +4061,9 @@ static struct perf_guest_switch_msr *intel_guest_get_msrs(int *nr, void *data)
 		/* Disable guest PEBS if host PEBS is enabled. */
 		arr[pebs_enable].guest = 0;
 	} else {
-		/* Disable guest PEBS for cross-mapped PEBS counters. */
+		/* Disable guest PEBS thoroughly for cross-mapped PEBS counters. */
 		arr[pebs_enable].guest &= ~kvm_pmu->host_cross_mapped_mask;
+		arr[global_ctrl].guest &= ~kvm_pmu->host_cross_mapped_mask;
 		/* Set hw GLOBAL_CTRL bits for PEBS counter when it runs for guest */
 		arr[global_ctrl].guest |= arr[pebs_enable].guest;
 	}
@@ -5974,6 +5984,36 @@ __init int intel_pmu_init(void)
 		name = "Tremont";
 		break;
 
+	case INTEL_FAM6_ALDERLAKE_N:
+		x86_pmu.mid_ack = true;
+		memcpy(hw_cache_event_ids, glp_hw_cache_event_ids,
+		       sizeof(hw_cache_event_ids));
+		memcpy(hw_cache_extra_regs, tnt_hw_cache_extra_regs,
+		       sizeof(hw_cache_extra_regs));
+		hw_cache_event_ids[C(ITLB)][C(OP_READ)][C(RESULT_ACCESS)] = -1;
+
+		x86_pmu.event_constraints = intel_slm_event_constraints;
+		x86_pmu.pebs_constraints = intel_grt_pebs_event_constraints;
+		x86_pmu.extra_regs = intel_grt_extra_regs;
+
+		x86_pmu.pebs_aliases = NULL;
+		x86_pmu.pebs_prec_dist = true;
+		x86_pmu.pebs_block = true;
+		x86_pmu.lbr_pt_coexist = true;
+		x86_pmu.flags |= PMU_FL_HAS_RSP_1;
+		x86_pmu.flags |= PMU_FL_INSTR_LATENCY;
+
+		intel_pmu_pebs_data_source_grt();
+		x86_pmu.pebs_latency_data = adl_latency_data_small;
+		x86_pmu.get_event_constraints = tnt_get_event_constraints;
+		x86_pmu.limit_period = spr_limit_period;
+		td_attr = tnt_events_attrs;
+		mem_attr = grt_mem_attrs;
+		extra_attr = nhm_format_attr;
+		pr_cont("Gracemont events, ");
+		name = "gracemont";
+		break;
+
 	case INTEL_FAM6_WESTMERE:
 	case INTEL_FAM6_WESTMERE_EP:
 	case INTEL_FAM6_WESTMERE_EX:
@@ -6316,7 +6356,6 @@ __init int intel_pmu_init(void)
 
 	case INTEL_FAM6_ALDERLAKE:
 	case INTEL_FAM6_ALDERLAKE_L:
-	case INTEL_FAM6_ALDERLAKE_N:
 	case INTEL_FAM6_RAPTORLAKE:
 	case INTEL_FAM6_RAPTORLAKE_P:
 		/*
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index de1f55d51784..ac973c6f82ad 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -110,13 +110,18 @@ void __init intel_pmu_pebs_data_source_skl(bool pmem)
 	__intel_pmu_pebs_data_source_skl(pmem, pebs_data_source);
 }
 
-static void __init intel_pmu_pebs_data_source_grt(u64 *data_source)
+static void __init __intel_pmu_pebs_data_source_grt(u64 *data_source)
 {
 	data_source[0x05] = OP_LH | P(LVL, L3) | LEVEL(L3) | P(SNOOP, HIT);
 	data_source[0x06] = OP_LH | P(LVL, L3) | LEVEL(L3) | P(SNOOP, HITM);
 	data_source[0x08] = OP_LH | P(LVL, L3) | LEVEL(L3) | P(SNOOPX, FWD);
 }
 
+void __init intel_pmu_pebs_data_source_grt(void)
+{
+	__intel_pmu_pebs_data_source_grt(pebs_data_source);
+}
+
 void __init intel_pmu_pebs_data_source_adl(void)
 {
 	u64 *data_source;
@@ -127,7 +132,7 @@ void __init intel_pmu_pebs_data_source_adl(void)
 
 	data_source = x86_pmu.hybrid_pmu[X86_HYBRID_PMU_ATOM_IDX].pebs_data_source;
 	memcpy(data_source, pebs_data_source, sizeof(pebs_data_source));
-	intel_pmu_pebs_data_source_grt(data_source);
+	__intel_pmu_pebs_data_source_grt(data_source);
 }
 
 static u64 precise_store_data(u64 status)
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index ba3d24a6a4ec..266143abcbd8 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -1516,6 +1516,8 @@ void intel_pmu_pebs_data_source_skl(bool pmem);
 
 void intel_pmu_pebs_data_source_adl(void);
 
+void intel_pmu_pebs_data_source_grt(void);
+
 int intel_pmu_setup_lbr_filter(struct perf_event *event);
 
 void intel_pt_interrupt(void);
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 2621fd24ad26..ff4bffc502c6 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -6893,9 +6893,16 @@ static void perf_output_read_group(struct perf_output_handle *handle,
 {
 	struct perf_event *leader = event->group_leader, *sub;
 	u64 read_format = event->attr.read_format;
+	unsigned long flags;
 	u64 values[6];
 	int n = 0;
 
+	/*
+	 * Disabling interrupts avoids all counter scheduling
+	 * (context switches, timer based rotation and IPIs).
+	 */
+	local_irq_save(flags);
+
 	values[n++] = 1 + leader->nr_siblings;
 
 	if (read_format & PERF_FORMAT_TOTAL_TIME_ENABLED)
@@ -6931,6 +6938,8 @@ static void perf_output_read_group(struct perf_output_handle *handle,
 
 		__output_copy(handle, values, n * sizeof(u64));
 	}
+
+	local_irq_restore(flags);
 }
 
 #define PERF_FORMAT_TOTAL_TIMES (PERF_FORMAT_TOTAL_TIME_ENABLED|\
