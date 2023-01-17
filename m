Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E558670D33
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 00:23:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbjAQXXf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 18:23:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbjAQXXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 18:23:15 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB1426D6AC
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 13:14:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673990101; x=1705526101;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=K/ZjF4TAzlPHCqRT8yxzX2Lol7tx6j80ST1bZn8f9y0=;
  b=VX9PeA+UnPwlZowNXLdyDW4zhak56Q/u7Qqli1+TSW4viru+f+n0bLOw
   UPSF8NNtj0598z9Hf10payxjbFCEE/2pdbfA0+7rHS0VlFER0spmOaOYW
   uYeqhD3DP5zOkrGRqsBCjFM1i1ku9Kx3lXdMwzjELp8yeSWcUGpBXJfzf
   L5H1t7LTLPsGZchduOH+LjzNqyMErm6668tD6kVd4KUPgLRAfNcuksuFt
   +hsJTgUfFWdYElkRqISCjEbRxQKfLFRO7LlI1iR1GgfTuzUWhk37o4u7X
   W1bzNyjE/XmFBb3n07RAqwpM6ZPUzfgf79hZpsw7M+0jEkTDCQHnnW+VW
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10593"; a="324872753"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; 
   d="scan'208";a="324872753"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2023 13:14:56 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10593"; a="727913197"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; 
   d="scan'208";a="727913197"
Received: from rchatre-ws.ostc.intel.com ([10.54.69.144])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2023 13:14:56 -0800
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     fenghua.yu@intel.com, bp@alien8.de, dave.hansen@linux.intel.com,
        tglx@linutronix.de, mingo@redhat.com, x86@kernel.org
Cc:     hpa@zytor.com, james.morse@arm.com, jamie@nuviainc.com,
        linux-kernel@vger.kernel.org, shawnwang@linux.alibaba.com,
        reinette.chatre@intel.com
Subject: [PATCH v5] x86/resctrl: Clear staged_config[] before and after it is used
Date:   Tue, 17 Jan 2023 13:14:50 -0800
Message-Id: <2fad13f49fbe89687fc40e9a5a61f23a28d1507a.1673988935.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shawn Wang <shawnwang@linux.alibaba.com>

As a temporary storage, staged_config[] in rdt_domain should be cleared
before and after it is used. The stale value in staged_config[] could
cause an MSR access error.

Here is a reproducer on a system with 16 usable CLOSIDs for a 15-way L3
Cache (MBA should be disabled if the number of CLOSIDs for MB is less than
16.) :
	mount -t resctrl resctrl -o cdp /sys/fs/resctrl
	mkdir /sys/fs/resctrl/p{1..7}
	umount /sys/fs/resctrl/
	mount -t resctrl resctrl /sys/fs/resctrl
	mkdir /sys/fs/resctrl/p{1..8}

An error occurs when creating resource group named p8:
    unchecked MSR access error: WRMSR to 0xca0 (tried to write 0x00000000000007ff) at rIP: 0xffffffff82249142 (cat_wrmsr+0x32/0x60)
    Call Trace:
     <IRQ>
     __flush_smp_call_function_queue+0x11d/0x170
     __sysvec_call_function+0x24/0xd0
     sysvec_call_function+0x89/0xc0
     </IRQ>
     <TASK>
     asm_sysvec_call_function+0x16/0x20

When creating a new resource control group, hardware will be configured
by the following process:
    rdtgroup_mkdir()
      rdtgroup_mkdir_ctrl_mon()
        rdtgroup_init_alloc()
          resctrl_arch_update_domains()

resctrl_arch_update_domains() iterates and updates all resctrl_conf_type
whose have_new_ctrl is true. Since staged_config[] holds the same values as
when CDP was enabled, it will continue to update the CDP_CODE and CDP_DATA
configurations. When group p8 is created, get_config_index() called in
resctrl_arch_update_domains() will return 16 and 17 as the CLOSIDs for
CDP_CODE and CDP_DATA, which will be translated to an invalid register -
0xca0 in this scenario.

Fix it by clearing staged_config[] before and after it is used.

[reinette: re-order commit tags]

Fixes: 75408e43509e ("x86/resctrl: Allow different CODE/DATA configurations to be staged")
Suggested-by: Xin Hao <xhao@linux.alibaba.com>
Signed-off-by: Shawn Wang <shawnwang@linux.alibaba.com>
Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
Tested-by: Reinette Chatre <reinette.chatre@intel.com>
Cc: <stable@vger.kernel.org>
---
Changes since v4:
- Essentially a resubmit of v4, changes limited to commit tags.
- v4: https://lore.kernel.org/lkml/20221209024436.22170-1-shawnwang@linux.alibaba.com/
- No changes to patch.
- Only change in changelog is re-ordering of commit tags.
- Add Reinette's Tested-by, but change the Reviewed-by to Signed-off-by
  because of the change in hands of this submission.

Changes since v3:
- Update the commit message suggested by Reiniette Chatre.
- Rename resctrl_staged_configs_clear() to rdt_staged_configs_clear().
- Move rdt_staged_configs_clear() to arch/x86/kernel/cpu/resctrl/internal.h.

Changes since v2:
- Update the commit message suggested by Reiniette Chatre.
- Make the clearing work more robust.

Changes since v1:
- Move the clearing from schemata_list_destroy() to resctrl_arch_update_domains().
- Update the commit message suggested by Reiniette Chatre.
- Add stable tag suggested by James Morse.

 arch/x86/kernel/cpu/resctrl/ctrlmondata.c |  7 ++-----
 arch/x86/kernel/cpu/resctrl/internal.h    |  1 +
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 25 +++++++++++++++++++----
 3 files changed, 24 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index 1df0e3262bca..bcdc679dad4e 100644
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
@@ -373,7 +373,6 @@ ssize_t rdtgroup_schemata_write(struct kernfs_open_file *of,
 {
 	struct resctrl_schema *s;
 	struct rdtgroup *rdtgrp;
-	struct rdt_domain *dom;
 	struct rdt_resource *r;
 	char *tok, *resname;
 	int ret = 0;
@@ -402,10 +401,7 @@ ssize_t rdtgroup_schemata_write(struct kernfs_open_file *of,
 		goto out;
 	}
 
-	list_for_each_entry(s, &resctrl_schema_all, list) {
-		list_for_each_entry(dom, &s->res->domains, list)
-			memset(dom->staged_config, 0, sizeof(dom->staged_config));
-	}
+	rdt_staged_configs_clear();
 
 	while ((tok = strsep(&buf, "\n")) != NULL) {
 		resname = strim(strsep(&tok, ":"));
@@ -450,6 +446,7 @@ ssize_t rdtgroup_schemata_write(struct kernfs_open_file *of,
 	}
 
 out:
+	rdt_staged_configs_clear();
 	rdtgroup_kn_unlock(of->kn);
 	cpus_read_unlock();
 	return ret ?: nbytes;
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 5ebd28e6aa0c..f43eb7340ca5 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -527,5 +527,6 @@ bool has_busy_rmid(struct rdt_resource *r, struct rdt_domain *d);
 void __check_limbo(struct rdt_domain *d, bool force_free);
 void rdt_domain_reconfigure_cdp(struct rdt_resource *r);
 void __init thread_throttle_mode_init(void);
+void rdt_staged_configs_clear(void);
 
 #endif /* _ASM_X86_RESCTRL_INTERNAL_H */
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 5993da21d822..41e89fc49d77 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -78,6 +78,19 @@ void rdt_last_cmd_printf(const char *fmt, ...)
 	va_end(ap);
 }
 
+void rdt_staged_configs_clear(void)
+{
+	struct rdt_resource *r;
+	struct rdt_domain *dom;
+
+	lockdep_assert_held(&rdtgroup_mutex);
+
+	for_each_alloc_capable_rdt_resource(r) {
+		list_for_each_entry(dom, &r->domains, list)
+			memset(dom->staged_config, 0, sizeof(dom->staged_config));
+	}
+}
+
 /*
  * Trivial allocator for CLOSIDs. Since h/w only supports a small number,
  * we can keep a bitmap of free CLOSIDs in a single integer.
@@ -2851,7 +2864,9 @@ static int rdtgroup_init_alloc(struct rdtgroup *rdtgrp)
 {
 	struct resctrl_schema *s;
 	struct rdt_resource *r;
-	int ret;
+	int ret = 0;
+
+	rdt_staged_configs_clear();
 
 	list_for_each_entry(s, &resctrl_schema_all, list) {
 		r = s->res;
@@ -2862,20 +2877,22 @@ static int rdtgroup_init_alloc(struct rdtgroup *rdtgrp)
 		} else {
 			ret = rdtgroup_init_cat(s, rdtgrp->closid);
 			if (ret < 0)
-				return ret;
+				goto out;
 		}
 
 		ret = resctrl_arch_update_domains(r, rdtgrp->closid);
 		if (ret < 0) {
 			rdt_last_cmd_puts("Failed to initialize allocations\n");
-			return ret;
+			goto out;
 		}
 
 	}
 
 	rdtgrp->mode = RDT_MODE_SHAREABLE;
 
-	return 0;
+out:
+	rdt_staged_configs_clear();
+	return ret;
 }
 
 static int mkdir_rdt_prepare(struct kernfs_node *parent_kn,
-- 
2.34.1

