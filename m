Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60CE8627CAC
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 12:45:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236742AbiKNLpd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 06:45:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236643AbiKNLo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 06:44:56 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B97E222A3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 03:44:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C941AB80E7E
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 11:44:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B630CC433D7;
        Mon, 14 Nov 2022 11:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668426277;
        bh=yzR3ph3tC/ZTtl87MRZiAK+HvN3pbQqI4zL7+OyT63c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rFanZoErjcqgPwNAvJt7PwJs/ly5KORJkrpyeHltMdaoMimDBEyFT7yEHJ7rV4opP
         yg23KdpMK1C/eVt+Es0jX4d1NodxSIPh/VcYY7/XL5rxjOWAwY7r53gPogJNYd8oUA
         A4mYwfcd7xiJtCzdQCkDg/CKVCr/iwREjxWIo+osGihbofraaSDpaDMi5+m3E9qpnu
         3f/aG5tXJwmOb5j0HJj7hNM18pcA62C/8754bpiN3YNkUfGIyJiHkToYnYoBMlTns/
         lkvcOxO9IOBBJlvHIASy1xSTGF/K7rVvisBz/cE8g74RytEow0P7t0qt5vDuYSw5cP
         zRiSVadxg1McQ==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Huang Rui <ray.huang@amd.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>, x86@kernel.org,
        Martin Liska <mliska@suse.cz>, Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 17/46] amd, lto: Mark amd pmu and pstate functions as __visible_on_lto
Date:   Mon, 14 Nov 2022 12:43:15 +0100
Message-Id: <20221114114344.18650-18-jirislaby@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221114114344.18650-1-jirislaby@kernel.org>
References: <20221114114344.18650-1-jirislaby@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

Symbols referenced from assembler (either directly or e.f. from
DEFINE_STATIC_KEY()) need to be global and visible in gcc LTO because
they could end up in a different object file than the assembler. This
can lead to linker errors without this patch.

So mark amd_pmu_test_overflow_topbit() and all amd pstate functions as
__visible_on_lto.

Also the pstate ones have to be renamed so that they are unique.

[ml] fix amd_pmu_test_overflow_topbit() too
[js] use __visible_on_lto

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Huang Rui <ray.huang@amd.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: x86@kernel.org
Signed-off-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Martin Liska <mliska@suse.cz>
Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 arch/x86/events/amd/core.c   |  2 +-
 drivers/cpufreq/amd-pstate.c | 15 ++++++++-------
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index 8b70237c33f7..9dfdfd85b493 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -643,7 +643,7 @@ static inline void amd_pmu_ack_global_status(u64 status)
 	wrmsrl(MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR, status);
 }
 
-static bool amd_pmu_test_overflow_topbit(int idx)
+__visible_on_lto bool amd_pmu_test_overflow_topbit(int idx)
 {
 	u64 counter;
 
diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index ace7d50cf2ac..d0b67a60191d 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -66,7 +66,7 @@ MODULE_PARM_DESC(shared_mem,
 
 static struct cpufreq_driver amd_pstate_driver;
 
-static inline int pstate_enable(bool enable)
+__visible_on_lto int do_amd_pstate_enable(bool enable)
 {
 	return wrmsrl_safe(MSR_AMD_CPPC_ENABLE, enable);
 }
@@ -84,14 +84,14 @@ static int cppc_enable(bool enable)
 	return ret;
 }
 
-DEFINE_STATIC_CALL(amd_pstate_enable, pstate_enable);
+DEFINE_STATIC_CALL(amd_pstate_enable, do_amd_pstate_enable);
 
 static inline int amd_pstate_enable(bool enable)
 {
 	return static_call(amd_pstate_enable)(enable);
 }
 
-static int pstate_init_perf(struct amd_cpudata *cpudata)
+__visible_on_lto int do_amd_pstate_init_perf(struct amd_cpudata *cpudata)
 {
 	u64 cap1;
 	u32 highest_perf;
@@ -142,15 +142,16 @@ static int cppc_init_perf(struct amd_cpudata *cpudata)
 	return 0;
 }
 
-DEFINE_STATIC_CALL(amd_pstate_init_perf, pstate_init_perf);
+DEFINE_STATIC_CALL(amd_pstate_init_perf, do_amd_pstate_init_perf);
 
 static inline int amd_pstate_init_perf(struct amd_cpudata *cpudata)
 {
 	return static_call(amd_pstate_init_perf)(cpudata);
 }
 
-static void pstate_update_perf(struct amd_cpudata *cpudata, u32 min_perf,
-			       u32 des_perf, u32 max_perf, bool fast_switch)
+__visible_on_lto void do_amd_pstate_update_perf(struct amd_cpudata *cpudata,
+			       u32 min_perf, u32 des_perf, u32 max_perf,
+			       bool fast_switch)
 {
 	if (fast_switch)
 		wrmsrl(MSR_AMD_CPPC_REQ, READ_ONCE(cpudata->cppc_req_cached));
@@ -172,7 +173,7 @@ static void cppc_update_perf(struct amd_cpudata *cpudata,
 	cppc_set_perf(cpudata->cpu, &perf_ctrls);
 }
 
-DEFINE_STATIC_CALL(amd_pstate_update_perf, pstate_update_perf);
+DEFINE_STATIC_CALL(amd_pstate_update_perf, do_amd_pstate_update_perf);
 
 static inline void amd_pstate_update_perf(struct amd_cpudata *cpudata,
 					  u32 min_perf, u32 des_perf,
-- 
2.38.1

