Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F8B56077FD
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 15:13:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbiJUNN0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 09:13:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbiJUNNL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 09:13:11 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9DA2D230A87
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 06:12:52 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E3DB61477;
        Fri, 21 Oct 2022 06:12:57 -0700 (PDT)
Received: from merodach.members.linode.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4556E3F792;
        Fri, 21 Oct 2022 06:12:49 -0700 (PDT)
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
        Jamie Iles <quic_jiles@quicinc.com>,
        Xin Hao <xhao@linux.alibaba.com>, xingxin.hx@openanolis.org,
        baolin.wang@linux.alibaba.com, peternewman@google.com
Subject: [PATCH 08/18] x86/resctrl: Queue mon_event_read() instead of sending an IPI
Date:   Fri, 21 Oct 2022 13:11:54 +0000
Message-Id: <20221021131204.5581-9-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20221021131204.5581-1-james.morse@arm.com>
References: <20221021131204.5581-1-james.morse@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

x86 is blessed with an abundance of monitors, one per RMID, that can be
read from any CPU in the domain. MPAMs monitors reside in the MMIO MSC,
the number implemented is up to the manufacturer. This means when there are
fewer monitors than needed, they need to be allocated and freed.

Worse, the domain may be broken up into slices, and the MMIO accesses
for each slice may need performing from different CPUs.

These two details mean MPAMs monitor code needs to be able to sleep, and
IPI another CPU in the domain to read from a resource that has been sliced.

mon_event_read() already invokes mon_event_count() via IPI, which means
this isn't possible.

Change mon_event_read() to schedule mon_event_count() on a remote CPU and
wait, instead of sending an IPI. This function is only used in response to
a user-space filesystem request (not the timing sensitive overflow code).

This allows MPAM to hide the slice behaviour from resctrl, and to keep
the monitor-allocation in monitor.c.

Signed-off-by: James Morse <james.morse@arm.com>
---
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 7 +++++--
 arch/x86/kernel/cpu/resctrl/internal.h    | 2 +-
 arch/x86/kernel/cpu/resctrl/monitor.c     | 6 ++++--
 3 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index 1dafbdc5ac31..842266d1d148 100644
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
@@ -533,8 +533,11 @@ void mon_event_read(struct rmid_read *rr, struct rdt_resource *r,
 		    struct rdt_domain *d, struct rdtgroup *rdtgrp,
 		    int evtid, int first)
 {
+	/* When picking a cpu from cpu_mask, ensure it can't race with cpuhp */
+	lockdep_assert_held(&rdtgroup_mutex);
+
 	/*
-	 * setup the parameters to send to the IPI to read the data.
+	 * setup the parameters to pass to mon_event_count() to read the data.
 	 */
 	rr->rgrp = rdtgrp;
 	rr->evtid = evtid;
@@ -543,7 +546,7 @@ void mon_event_read(struct rmid_read *rr, struct rdt_resource *r,
 	rr->val = 0;
 	rr->first = first;
 
-	smp_call_function_any(&d->cpu_mask, mon_event_count, rr, 1);
+	smp_call_on_cpu(cpumask_any(&d->cpu_mask), mon_event_count, rr, false);
 }
 
 int rdtgroup_mondata_show(struct seq_file *m, void *arg)
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index faec12025a58..4d2f4524fe87 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -524,7 +524,7 @@ void closid_free(int closid);
 int alloc_rmid(u32 closid);
 void free_rmid(u32 closid, u32 rmid);
 int rdt_get_mon_l3_config(struct rdt_resource *r);
-void mon_event_count(void *info);
+int mon_event_count(void *info);
 int rdtgroup_mondata_show(struct seq_file *m, void *arg);
 void mon_event_read(struct rmid_read *rr, struct rdt_resource *r,
 		    struct rdt_domain *d, struct rdtgroup *rdtgrp,
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 99854ef4dee4..2ca76cddb170 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -502,10 +502,10 @@ static void mbm_bw_count(u32 closid, u32 rmid, struct rmid_read *rr)
 }
 
 /*
- * This is called via IPI to read the CQM/MBM counters
+ * This is scheduled by mon_event_read() to read the CQM/MBM counters
  * on a domain.
  */
-void mon_event_count(void *info)
+int mon_event_count(void *info)
 {
 	struct rdtgroup *rdtgrp, *entry;
 	struct rmid_read *rr = info;
@@ -538,6 +538,8 @@ void mon_event_count(void *info)
 	 */
 	if (ret == 0)
 		rr->err = 0;
+
+	return 0;
 }
 
 /*
-- 
2.30.2

