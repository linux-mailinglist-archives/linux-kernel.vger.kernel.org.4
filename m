Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5AE371131C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 20:04:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239334AbjEYSE1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 14:04:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238954AbjEYSD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 14:03:56 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 15E17E78
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 11:03:33 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B48211650;
        Thu, 25 May 2023 11:04:08 -0700 (PDT)
Received: from merodach.members.linode.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EAE043F6C4;
        Thu, 25 May 2023 11:03:20 -0700 (PDT)
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
Subject: [PATCH v4 18/24] x86/resctrl: Make rdt_enable_key the arch's decision to switch
Date:   Thu, 25 May 2023 18:02:03 +0000
Message-Id: <20230525180209.19497-19-james.morse@arm.com>
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
index 83ec2b5791f0..839b701cf7bd 100644
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
index 9e65248908d6..501b68b95aef 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -2533,10 +2533,8 @@ static int rdt_get_tree(struct fs_context *fc)
 	if (rdt_mon_capable)
 		resctrl_arch_enable_mon();
 
-	if (rdt_alloc_capable || rdt_mon_capable) {
-		static_branch_enable_cpuslocked(&rdt_enable_key);
+	if (rdt_alloc_capable || rdt_mon_capable)
 		resctrl_mounted = true;
-	}
 
 	if (is_mbm_enabled()) {
 		r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
@@ -2804,9 +2802,10 @@ static void rdt_kill_sb(struct super_block *sb)
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

