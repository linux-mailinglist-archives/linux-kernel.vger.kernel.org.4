Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFFF5711326
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 20:05:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241352AbjEYSFl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 14:05:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241309AbjEYSFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 14:05:19 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F32451731
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 11:04:29 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 529A51692;
        Thu, 25 May 2023 11:04:23 -0700 (PDT)
Received: from merodach.members.linode.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8A1813F6C4;
        Thu, 25 May 2023 11:03:35 -0700 (PDT)
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
Subject: [PATCH v4 23/24] x86/resctrl: Move domain helper migration into resctrl_offline_cpu()
Date:   Thu, 25 May 2023 18:02:08 +0000
Message-Id: <20230525180209.19497-24-james.morse@arm.com>
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

When a CPU is taken offline the resctrl filesystem code needs to check
if it was the CPU nominated to perform the periodic overflow and limbo
work. If so, another CPU needs to be chosen to do this work.

This is currently done in core.c, mixed in with the code that removes
the CPU from the domain's mask, and potentially free()s the domain.

Move the migration of the overflow and limbo helpers into the filesystem
code, into resctrl_offline_cpu(). As resctrl_offline_cpu() runs before
the architecture code has removed the CPU from the domain mask, the
callers need to be told which CPU is being removed, to avoid picking
it as the new CPU. This uses the exclude_cpu feature previously
added.

Signed-off-by: James Morse <james.morse@arm.com>
---
 arch/x86/kernel/cpu/resctrl/core.c     | 16 ----------------
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 15 +++++++++++++++
 2 files changed, 15 insertions(+), 16 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 9128a9710537..edc0dd123317 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -578,22 +578,6 @@ static void domain_remove_cpu(int cpu, struct rdt_resource *r)
 
 		return;
 	}
-
-	if (r == &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl) {
-		if (is_mbm_enabled() && cpu == d->mbm_work_cpu) {
-			cancel_delayed_work(&d->mbm_over);
-			/*
-			 * temporary: exclude_cpu=-1 as this CPU has already
-			 * been removed by cpumask_clear_cpu()d
-			 */
-			mbm_setup_overflow_handler(d, 0, RESCTRL_PICK_ANY_CPU);
-		}
-		if (is_llc_occupancy_enabled() && cpu == d->cqm_work_cpu &&
-		    has_busy_rmid(r, d)) {
-			cancel_delayed_work(&d->cqm_limbo);
-			cqm_setup_limbo_handler(d, 0, RESCTRL_PICK_ANY_CPU);
-		}
-	}
 }
 
 static void clear_closid_rmid(int cpu)
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 08b426f52f6d..3a8e2c98b611 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -3749,7 +3749,9 @@ static void clear_childcpus(struct rdtgroup *r, unsigned int cpu)
 
 void resctrl_offline_cpu(unsigned int cpu)
 {
+	struct rdt_domain *d;
 	struct rdtgroup *rdtgrp;
+	struct rdt_resource *l3 = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
 
 	lockdep_assert_held(&rdtgroup_mutex);
 
@@ -3759,6 +3761,19 @@ void resctrl_offline_cpu(unsigned int cpu)
 			break;
 		}
 	}
+
+	d = get_domain_from_cpu(cpu, l3);
+	if (d) {
+		if (is_mbm_enabled() && cpu == d->mbm_work_cpu) {
+			cancel_delayed_work(&d->mbm_over);
+			mbm_setup_overflow_handler(d, 0, cpu);
+		}
+		if (is_llc_occupancy_enabled() && cpu == d->cqm_work_cpu &&
+		    has_busy_rmid(l3, d)) {
+			cancel_delayed_work(&d->cqm_limbo);
+			cqm_setup_limbo_handler(d, 0, cpu);
+		}
+	}
 }
 
 /*
-- 
2.39.2

