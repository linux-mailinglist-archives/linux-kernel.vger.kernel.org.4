Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FC4966A174
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 19:03:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230474AbjAMSD1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 13:03:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbjAMSBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 13:01:38 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 79CCE2672
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 09:56:18 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 489A61763;
        Fri, 13 Jan 2023 09:57:00 -0800 (PST)
Received: from merodach.members.linode.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 996803FA58;
        Fri, 13 Jan 2023 09:56:15 -0800 (PST)
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
Subject: [PATCH v2 13/18] x86/resctrl: Make rdt_enable_key the arch's decision to switch
Date:   Fri, 13 Jan 2023 17:54:54 +0000
Message-Id: <20230113175459.14825-14-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230113175459.14825-1-james.morse@arm.com>
References: <20230113175459.14825-1-james.morse@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rdt_enable_key is switched when resctrl is mounted. It was also previously
used to prevent a second mount of the filesystem.

Any other architecture that wants to support resctrl has to provide
identical static keys.

Now that we have helpers for enablign and disabling the alloc/mon keys,
resctrl doesn't need to switch this extra key, it can be done by the arch
code. Use the static-key increment and decrement helpers, and change
resctrl to ensure the calls are balanced.

Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
Signed-off-by: James Morse <james.morse@arm.com>
---
 arch/x86/include/asm/resctrl.h         |  4 ++++
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 11 +++++------
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/resctrl.h b/arch/x86/include/asm/resctrl.h
index d6889aea5496..5b5ae6d8a343 100644
--- a/arch/x86/include/asm/resctrl.h
+++ b/arch/x86/include/asm/resctrl.h
@@ -45,21 +45,25 @@ DECLARE_STATIC_KEY_FALSE(rdt_mon_enable_key);
 static inline void resctrl_arch_enable_alloc(void)
 {
 	static_branch_enable_cpuslocked(&rdt_alloc_enable_key);
+	static_branch_inc_cpuslocked(&rdt_enable_key);
 }
 
 static inline void resctrl_arch_disable_alloc(void)
 {
 	static_branch_disable_cpuslocked(&rdt_alloc_enable_key);
+	static_branch_dec_cpuslocked(&rdt_enable_key);
 }
 
 static inline void resctrl_arch_enable_mon(void)
 {
 	static_branch_enable_cpuslocked(&rdt_mon_enable_key);
+	static_branch_inc_cpuslocked(&rdt_enable_key);
 }
 
 static inline void resctrl_arch_disable_mon(void)
 {
 	static_branch_disable_cpuslocked(&rdt_mon_enable_key);
+	static_branch_dec_cpuslocked(&rdt_enable_key);
 }
 
 /*
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index bbad906f573a..0e22f8361392 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -2247,10 +2247,8 @@ static int rdt_get_tree(struct fs_context *fc)
 	if (rdt_mon_capable)
 		resctrl_arch_enable_mon();
 
-	if (rdt_alloc_capable || rdt_mon_capable) {
-		static_branch_enable_cpuslocked(&rdt_enable_key);
+	if (rdt_alloc_capable || rdt_mon_capable)
 		resctrl_mounted = true;
-	}
 
 	if (is_mbm_enabled()) {
 		r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
@@ -2514,9 +2512,10 @@ static void rdt_kill_sb(struct super_block *sb)
 	rdt_pseudo_lock_release();
 	rdtgroup_default.mode = RDT_MODE_SHAREABLE;
 	schemata_list_destroy();
-	resctrl_arch_disable_alloc();
-	resctrl_arch_disable_mon();
-	static_branch_disable_cpuslocked(&rdt_enable_key);
+	if (rdt_alloc_capable)
+		resctrl_arch_disable_alloc();
+	if (rdt_mon_capable)
+		resctrl_arch_disable_mon();
 	resctrl_mounted = false;
 	kernfs_kill_sb(sb);
 	mutex_unlock(&rdtgroup_mutex);
-- 
2.30.2

