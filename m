Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C7C9607801
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 15:13:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230453AbiJUNNp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 09:13:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230382AbiJUNNQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 09:13:16 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DAFEF24CCAD
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 06:13:03 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7007C1DB5;
        Fri, 21 Oct 2022 06:13:08 -0700 (PDT)
Received: from merodach.members.linode.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C5A3B3F792;
        Fri, 21 Oct 2022 06:12:59 -0700 (PDT)
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
Subject: [PATCH 12/18] x86/resctrl: Move alloc/mon static keys into helpers
Date:   Fri, 21 Oct 2022 13:11:58 +0000
Message-Id: <20221021131204.5581-13-james.morse@arm.com>
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

resctrl enables three static keys depending on the features it has enabled.
Another architecture's context switch code may look different, any
static keys that control it should be buried behind helpers.

Move the alloc/mon logic into arch-specific helpers as a preparatory step
for making the rdt_enable_key's status something the arch code decides.

This means other architectures don't have to mirror the static keys.

Signed-off-by: James Morse <james.morse@arm.com>
---
 arch/x86/include/asm/resctrl.h         | 20 ++++++++++++++++++++
 arch/x86/kernel/cpu/resctrl/internal.h |  5 -----
 arch/x86/kernel/cpu/resctrl/rdtgroup.c |  8 ++++----
 3 files changed, 24 insertions(+), 9 deletions(-)

diff --git a/arch/x86/include/asm/resctrl.h b/arch/x86/include/asm/resctrl.h
index 4ce1376525e3..ae3a87100626 100644
--- a/arch/x86/include/asm/resctrl.h
+++ b/arch/x86/include/asm/resctrl.h
@@ -37,6 +37,26 @@ DECLARE_STATIC_KEY_FALSE(rdt_enable_key);
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
index a1f5bfdc62cc..f7ea5432cbdb 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -57,9 +57,6 @@ static inline struct rdt_fs_context *rdt_fc2context(struct fs_context *fc)
 	return container_of(kfc, struct rdt_fs_context, kfc);
 }
 
-DECLARE_STATIC_KEY_FALSE(rdt_enable_key);
-DECLARE_STATIC_KEY_FALSE(rdt_mon_enable_key);
-
 /**
  * struct mon_evt - Entry in the event list of a resource
  * @evtid:		event id
@@ -415,8 +412,6 @@ extern struct mutex rdtgroup_mutex;
 
 extern struct rdt_hw_resource rdt_resources_all[];
 extern struct rdtgroup rdtgroup_default;
-DECLARE_STATIC_KEY_FALSE(rdt_alloc_enable_key);
-
 extern struct dentry *debugfs_resctrl;
 
 enum resctrl_res_level {
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 89ce5ac7de35..bd2489bae7cf 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -2244,9 +2244,9 @@ static int rdt_get_tree(struct fs_context *fc)
 		goto out_psl;
 
 	if (rdt_alloc_capable)
-		static_branch_enable_cpuslocked(&rdt_alloc_enable_key);
+		resctrl_arch_enable_alloc();
 	if (rdt_mon_capable)
-		static_branch_enable_cpuslocked(&rdt_mon_enable_key);
+		resctrl_arch_enable_mon();
 
 	if (rdt_alloc_capable || rdt_mon_capable) {
 		static_branch_enable_cpuslocked(&rdt_enable_key);
@@ -2515,8 +2515,8 @@ static void rdt_kill_sb(struct super_block *sb)
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
2.30.2

