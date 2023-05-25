Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4747711313
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 20:04:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241195AbjEYSDt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 14:03:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241046AbjEYSD0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 14:03:26 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6B2F619D
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 11:03:06 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 316781655;
        Thu, 25 May 2023 11:03:51 -0700 (PDT)
Received: from merodach.members.linode.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 65FF83F6C4;
        Thu, 25 May 2023 11:03:03 -0700 (PDT)
From:   James Morse <james.morse@arm.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        James Morse <james.morse@arm.com>,
        shameerali.kolothum.thodi@huawei.com,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        carl@os.amperecomputing.com, lcherian@marvell.com,
        bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
        xingxin.hx@openanolis.org, baolin.wang@linux.alibaba.com,
        Jamie Iles <quic_jiles@quicinc.com>,
        Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
        dfustini@baylibre.com
Subject: [PATCH v4 12/24] x86/resctrl: Make resctrl_arch_rmid_read() retry when it is interrupted
Date:   Thu, 25 May 2023 18:01:57 +0000
Message-Id: <20230525180209.19497-13-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230525180209.19497-1-james.morse@arm.com>
References: <20230525180209.19497-1-james.morse@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

resctrl_arch_rmid_read() could be called by resctrl in process context,
and then called by the PMU driver from irq context on the same CPU.
This could cause struct arch_mbm_state's prev_msr value to go backwards,
leading to the chunks value being incremented multiple times.

The struct arch_mbm_state holds both the previous msr value, and a count
of the number of chunks. These two fields need to be updated atomically.

Read the prev_msr before accessing the hardware, and cmpxchg() the value
back. If the value has changed, the whole thing is re-attempted.

Signed-off-by: James Morse <james.morse@arm.com>
---
 arch/x86/kernel/cpu/resctrl/internal.h |  5 +++--
 arch/x86/kernel/cpu/resctrl/monitor.c  | 28 +++++++++++++++++++-------
 2 files changed, 24 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 6f18cf26988c..7960366b9434 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -2,6 +2,7 @@
 #ifndef _ASM_X86_RESCTRL_INTERNAL_H
 #define _ASM_X86_RESCTRL_INTERNAL_H
 
+#include <linux/atomic.h>
 #include <linux/resctrl.h>
 #include <linux/sched.h>
 #include <linux/kernfs.h>
@@ -338,8 +339,8 @@ struct mbm_state {
  *		find this struct.
  */
 struct arch_mbm_state {
-	u64	chunks;
-	u64	prev_msr;
+	atomic64_t	chunks;
+	atomic64_t	prev_msr;
 };
 
 /**
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index e267869d60d5..1f470e55d555 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -225,13 +225,15 @@ void resctrl_arch_reset_rmid(struct rdt_resource *r, struct rdt_domain *d,
 {
 	struct rdt_hw_domain *hw_dom = resctrl_to_arch_dom(d);
 	struct arch_mbm_state *am;
+	u64 msr_val;
 
 	am = get_arch_mbm_state(hw_dom, rmid, eventid);
 	if (am) {
 		memset(am, 0, sizeof(*am));
 
 		/* Record any initial, non-zero count value. */
-		__rmid_read(rmid, eventid, &am->prev_msr);
+		__rmid_read(rmid, eventid, &msr_val);
+		atomic64_set(&am->prev_msr, msr_val);
 	}
 }
 
@@ -266,23 +268,35 @@ int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_domain *d,
 {
 	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
 	struct rdt_hw_domain *hw_dom = resctrl_to_arch_dom(d);
+	u64 start_msr_val, old_msr_val, msr_val, chunks;
 	struct arch_mbm_state *am;
-	u64 msr_val, chunks;
-	int ret;
+	int ret = 0;
 
 	if (!cpumask_test_cpu(smp_processor_id(), &d->cpu_mask))
 		return -EINVAL;
 
+interrupted:
+	am = get_arch_mbm_state(hw_dom, rmid, eventid);
+	if (am)
+		start_msr_val = atomic64_read(&am->prev_msr);
+
 	ret = __rmid_read(rmid, eventid, &msr_val);
 	if (ret)
 		return ret;
 
 	am = get_arch_mbm_state(hw_dom, rmid, eventid);
 	if (am) {
-		am->chunks += mbm_overflow_count(am->prev_msr, msr_val,
-						 hw_res->mbm_width);
-		chunks = get_corrected_mbm_count(rmid, am->chunks);
-		am->prev_msr = msr_val;
+		old_msr_val = atomic64_cmpxchg(&am->prev_msr, start_msr_val,
+					       msr_val);
+		if (old_msr_val != start_msr_val)
+			goto interrupted;
+
+		chunks = mbm_overflow_count(start_msr_val, msr_val,
+					    hw_res->mbm_width);
+		atomic64_add(chunks, &am->chunks);
+
+		chunks = get_corrected_mbm_count(rmid,
+						 atomic64_read(&am->chunks));
 	} else {
 		chunks = msr_val;
 	}
-- 
2.39.2

