Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2972260780A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 15:14:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230383AbiJUNOr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 09:14:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230361AbiJUNN1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 09:13:27 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 86F9226D92A
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 06:13:10 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5B7F31042;
        Fri, 21 Oct 2022 06:13:16 -0700 (PDT)
Received: from merodach.members.linode.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B14323F792;
        Fri, 21 Oct 2022 06:13:07 -0700 (PDT)
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
Subject: [PATCH 15/18] x86/resctrl: Add cpu online callback for resctrl work
Date:   Fri, 21 Oct 2022 13:12:01 +0000
Message-Id: <20221021131204.5581-16-james.morse@arm.com>
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

The resctrl architecture specific code may need to create a domain when
a CPU comes online, it also needs to reset the CPUs PQR_ASSOC register.
The resctrl filesystem code needs to update the rdtgroup_default cpu
mask when cpus are brought online.

Currently this is all done in one function, resctrl_online_cpu().
This will need to be split into architecture and filesystem parts
before resctrl can be moved to /fs/.

Pull the rdtgroup_default update work out as a filesystem specific
cpu_online helper. resctrl_online_cpu() is the obvious name for this,
which means the version in core.c needs renaming.

resctrl_online_cpu() is called by the arch code once it has done the
work to add the new cpu to any domains.

In future patches, resctrl_online_cpu() will take the rdtgroup_mutex
itself.

Signed-off-by: James Morse <james.morse@arm.com>
---
 arch/x86/kernel/cpu/resctrl/core.c     | 11 ++++++-----
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 10 ++++++++++
 include/linux/resctrl.h                |  1 +
 3 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index de62b0b87ced..511ced743a79 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -584,19 +584,20 @@ static void clear_closid_rmid(int cpu)
 	wrmsr(IA32_PQR_ASSOC, 0, 0);
 }
 
-static int resctrl_online_cpu(unsigned int cpu)
+static int resctrl_arch_online_cpu(unsigned int cpu)
 {
 	struct rdt_resource *r;
+	int err;
 
 	mutex_lock(&rdtgroup_mutex);
 	for_each_capable_rdt_resource(r)
 		domain_add_cpu(cpu, r);
-	/* The cpu is set in default rdtgroup after online. */
-	cpumask_set_cpu(cpu, &rdtgroup_default.cpu_mask);
 	clear_closid_rmid(cpu);
+
+	err = resctrl_online_cpu(cpu);
 	mutex_unlock(&rdtgroup_mutex);
 
-	return 0;
+	return err;
 }
 
 static void clear_childcpus(struct rdtgroup *r, unsigned int cpu)
@@ -923,7 +924,7 @@ static int __init resctrl_late_init(void)
 
 	state = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN,
 				  "x86/resctrl/cat:online:",
-				  resctrl_online_cpu, resctrl_offline_cpu);
+				  resctrl_arch_online_cpu, resctrl_offline_cpu);
 	if (state < 0)
 		return state;
 
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 81ed458be70b..ef444a5690e9 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -3425,6 +3425,16 @@ int resctrl_online_domain(struct rdt_resource *r, struct rdt_domain *d)
 	return 0;
 }
 
+int resctrl_online_cpu(unsigned int cpu)
+{
+	lockdep_assert_held(&rdtgroup_mutex);
+
+	/* The cpu is set in default rdtgroup after online. */
+	cpumask_set_cpu(cpu, &rdtgroup_default.cpu_mask);
+
+	return 0;
+}
+
 /*
  * rdtgroup_init - rdtgroup initialization
  *
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 1f345d24e236..b140ee6de00e 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -219,6 +219,7 @@ u32 resctrl_arch_get_config(struct rdt_resource *r, struct rdt_domain *d,
 			    u32 closid, enum resctrl_conf_type type);
 int resctrl_online_domain(struct rdt_resource *r, struct rdt_domain *d);
 void resctrl_offline_domain(struct rdt_resource *r, struct rdt_domain *d);
+int resctrl_online_cpu(unsigned int cpu);
 
 /**
  * resctrl_arch_rmid_read() - Read the eventid counter corresponding to rmid
-- 
2.30.2

