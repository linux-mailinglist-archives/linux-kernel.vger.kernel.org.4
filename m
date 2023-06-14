Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FA82711320
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 20:05:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241442AbjEYSEh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 14:04:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231791AbjEYSEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 14:04:06 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C8F231707
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 11:03:44 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8A6301655;
        Thu, 25 May 2023 11:04:14 -0700 (PDT)
Received: from merodach.members.linode.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C0D7C3F6C4;
        Thu, 25 May 2023 11:03:26 -0700 (PDT)
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
Subject: [PATCH v4 20/24] x86/resctrl: Add cpu online callback for resctrl work
Date:   Thu, 25 May 2023 18:02:05 +0000
Message-Id: <20230525180209.19497-21-james.morse@arm.com>
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

Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
Signed-off-by: James Morse <james.morse@arm.com>
---
Changes since v3:
 * Renamed err to ret
---
 arch/x86/kernel/cpu/resctrl/core.c     | 11 ++++++-----
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 10 ++++++++++
 include/linux/resctrl.h                |  1 +
 3 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 4bea032d072e..e00f3542e60e 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -603,19 +603,20 @@ static void clear_closid_rmid(int cpu)
 	wrmsr(MSR_IA32_PQR_ASSOC, 0, RESCTRL_RESERVED_CLOSID);
 }
 
-static int resctrl_online_cpu(unsigned int cpu)
+static int resctrl_arch_online_cpu(unsigned int cpu)
 {
 	struct rdt_resource *r;
+	int ret;
 
 	mutex_lock(&rdtgroup_mutex);
 	for_each_capable_rdt_resource(r)
 		domain_add_cpu(cpu, r);
-	/* The cpu is set in default rdtgroup after online. */
-	cpumask_set_cpu(cpu, &rdtgroup_default.cpu_mask);
 	clear_closid_rmid(cpu);
+
+	ret = resctrl_online_cpu(cpu);
 	mutex_unlock(&rdtgroup_mutex);
 
-	return 0;
+	return ret;
 }
 
 static void clear_childcpus(struct rdtgroup *r, unsigned int cpu)
@@ -965,7 +966,7 @@ static int __init resctrl_late_init(void)
 
 	state = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN,
 				  "x86/resctrl/cat:online:",
-				  resctrl_online_cpu, resctrl_offline_cpu);
+				  resctrl_arch_online_cpu, resctrl_offline_cpu);
 	if (state < 0)
 		return state;
 
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 5330c0bdeffc..7c3de5ea0482 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -3725,6 +3725,16 @@ int resctrl_online_domain(struct rdt_resource *r, struct rdt_domain *d)
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
index 0dcb5cfde609..ecd41762d61a 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -222,6 +222,7 @@ u32 resctrl_arch_get_config(struct rdt_resource *r, struct rdt_domain *d,
 			    u32 closid, enum resctrl_conf_type type);
 int resctrl_online_domain(struct rdt_resource *r, struct rdt_domain *d);
 void resctrl_offline_domain(struct rdt_resource *r, struct rdt_domain *d);
+int resctrl_online_cpu(unsigned int cpu);
 
 /**
  * resctrl_arch_rmid_read() - Read the eventid counter corresponding to rmid
-- 
2.39.2

