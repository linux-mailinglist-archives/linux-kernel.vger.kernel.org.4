Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3846A6C1E7B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 18:48:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230240AbjCTRsN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 13:48:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230115AbjCTRrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 13:47:19 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 622983B21D
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 10:42:48 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 612D51BB0;
        Mon, 20 Mar 2023 10:28:34 -0700 (PDT)
Received: from merodach.members.linode.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DD8FF3F67D;
        Mon, 20 Mar 2023 10:27:47 -0700 (PDT)
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
Subject: [PATCH v3 14/19] x86/resctrl: Make rdt_enable_key the arch's decision to switch
Date:   Mon, 20 Mar 2023 17:26:15 +0000
Message-Id: <20230320172620.18254-15-james.morse@arm.com>
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

rdt_enable_key is switched when resctrl is mounted. It was also previously
used to prevent a second mount of the filesystem.

Any other architecture that wants to support resctrl has to provide
identical static keys.

Now that there are helpers for enabling and disabling the alloc/mon keys,
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
index 5fdfcd5f943e..147af2b43385 100644
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
index c6c31efb85ac..2ca8981c7d0d 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -2514,10 +2514,8 @@ static int rdt_get_tree(struct fs_context *fc)
 	if (rdt_mon_capable)
 		resctrl_arch_enable_mon();
 
-	if (rdt_alloc_capable || rdt_mon_capable) {
-		static_branch_enable_cpuslocked(&rdt_enable_key);
+	if (rdt_alloc_capable || rdt_mon_capable)
 		resctrl_mounted = true;
-	}
 
 	if (is_mbm_enabled()) {
 		r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
@@ -2785,9 +2783,10 @@ static void rdt_kill_sb(struct super_block *sb)
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
2.39.2

