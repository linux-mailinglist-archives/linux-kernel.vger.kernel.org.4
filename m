Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 345AF6C1E6E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 18:46:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230053AbjCTRqk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 13:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbjCTRqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 13:46:01 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 24EE63A4DC
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 10:41:58 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 91656169E;
        Mon, 20 Mar 2023 10:28:31 -0700 (PDT)
Received: from merodach.members.linode.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 18FBB3F67D;
        Mon, 20 Mar 2023 10:27:44 -0700 (PDT)
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
        Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com
Subject: [PATCH v3 13/19] x86/resctrl: Move alloc/mon static keys into helpers
Date:   Mon, 20 Mar 2023 17:26:14 +0000
Message-Id: <20230320172620.18254-14-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230320172620.18254-1-james.morse@arm.com>
References: <20230320172620.18254-1-james.morse@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

resctrl enables three static keys depending on the features it has enabled.
Another architecture's context switch code may look different, any
static keys that control it should be buried behind helpers.

Move the alloc/mon logic into arch-specific helpers as a preparatory step
for making the rdt_enable_key's status something the arch code decides.

This means other architectures don't have to mirror the static keys.

Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
Signed-off-by: James Morse <james.morse@arm.com>
---
 arch/x86/include/asm/resctrl.h         | 20 ++++++++++++++++++++
 arch/x86/kernel/cpu/resctrl/internal.h |  5 -----
 arch/x86/kernel/cpu/resctrl/rdtgroup.c |  8 ++++----
 3 files changed, 24 insertions(+), 9 deletions(-)

diff --git a/arch/x86/include/asm/resctrl.h b/arch/x86/include/asm/resctrl.h
index 1c87f1626456..5fdfcd5f943e 100644
--- a/arch/x86/include/asm/resctrl.h
+++ b/arch/x86/include/asm/resctrl.h
@@ -42,6 +42,26 @@ DECLARE_STATIC_KEY_FALSE(rdt_enable_key);
 DECLARE_STATIC_KEY_FALSE(rdt_alloc_enable_key);
 DECLARE_STATIC_KEY_FALSE(rdt_mon_enable_key);
 
+static inline void resctrl_arch_enable_alloc(void)
+{
+	static_branch_enable_cpuslocked(&rdt_alloc_enable_key);
+}
+
+static inline void resctrl_arch_disable_alloc(void)
+{
+	static_branch_disable_cpuslocked(&rdt_alloc_enable_key);
+}
+
+static inline void resctrl_arch_enable_mon(void)
+{
+	static_branch_enable_cpuslocked(&rdt_mon_enable_key);
+}
+
+static inline void resctrl_arch_disable_mon(void)
+{
+	static_branch_disable_cpuslocked(&rdt_mon_enable_key);
+}
+
 /*
  * __resctrl_sched_in() - Writes the task's CLOSid/RMID to IA32_PQR_MSR
  *
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 7d5188e8bec3..c83bd581c1d5 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -92,9 +92,6 @@ static inline struct rdt_fs_context *rdt_fc2context(struct fs_context *fc)
 	return container_of(kfc, struct rdt_fs_context, kfc);
 }
 
-DECLARE_STATIC_KEY_FALSE(rdt_enable_key);
-DECLARE_STATIC_KEY_FALSE(rdt_mon_enable_key);
-
 /**
  * struct mon_evt - Entry in the event list of a resource
  * @evtid:		event id
@@ -452,8 +449,6 @@ extern struct mutex rdtgroup_mutex;
 
 extern struct rdt_hw_resource rdt_resources_all[];
 extern struct rdtgroup rdtgroup_default;
-DECLARE_STATIC_KEY_FALSE(rdt_alloc_enable_key);
-
 extern struct dentry *debugfs_resctrl;
 
 enum resctrl_res_level {
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 5176a85f281c..c6c31efb85ac 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -2510,9 +2510,9 @@ static int rdt_get_tree(struct fs_context *fc)
 		goto out_psl;
 
 	if (rdt_alloc_capable)
-		static_branch_enable_cpuslocked(&rdt_alloc_enable_key);
+		resctrl_arch_enable_alloc();
 	if (rdt_mon_capable)
-		static_branch_enable_cpuslocked(&rdt_mon_enable_key);
+		resctrl_arch_enable_mon();
 
 	if (rdt_alloc_capable || rdt_mon_capable) {
 		static_branch_enable_cpuslocked(&rdt_enable_key);
@@ -2785,8 +2785,8 @@ static void rdt_kill_sb(struct super_block *sb)
 	rdt_pseudo_lock_release();
 	rdtgroup_default.mode = RDT_MODE_SHAREABLE;
 	schemata_list_destroy();
-	static_branch_disable_cpuslocked(&rdt_alloc_enable_key);
-	static_branch_disable_cpuslocked(&rdt_mon_enable_key);
+	resctrl_arch_disable_alloc();
+	resctrl_arch_disable_mon();
 	static_branch_disable_cpuslocked(&rdt_enable_key);
 	resctrl_mounted = false;
 	kernfs_kill_sb(sb);
-- 
2.39.2

