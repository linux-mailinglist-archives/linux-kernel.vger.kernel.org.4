Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B52FC647C5B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 03:44:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbiLICos (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 21:44:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiLICoq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 21:44:46 -0500
Received: from out30-42.freemail.mail.aliyun.com (out30-42.freemail.mail.aliyun.com [115.124.30.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AF4485D20
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 18:44:44 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=shawnwang@linux.alibaba.com;NM=0;PH=DS;RN=11;SR=0;TI=SMTPD_---0VWse5FO_1670553876;
Received: from localhost(mailfrom:shawnwang@linux.alibaba.com fp:SMTPD_---0VWse5FO_1670553876)
          by smtp.aliyun-inc.com;
          Fri, 09 Dec 2022 10:44:41 +0800
From:   Shawn Wang <shawnwang@linux.alibaba.com>
To:     reinette.chatre@intel.com, fenghua.yu@intel.com
Cc:     bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        james.morse@arm.com, jamie@nuviainc.com,
        linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de,
        x86@kernel.org
Subject: [PATCH v4] x86/resctrl: Clear staged_config[] before and after it is used
Date:   Fri,  9 Dec 2022 10:44:36 +0800
Message-Id: <20221209024436.22170-1-shawnwang@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Fixes: 75408e43509e ("x86/resctrl: Allow different CODE/DATA configurations to be staged")
Cc: <stable@vger.kernel.org>
Signed-off-by: Shawn Wang <shawnwang@linux.alibaba.com>
Suggested-by: Xin Hao <xhao@linux.alibaba.com>
---
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
---
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c |  7 ++-----
 arch/x86/kernel/cpu/resctrl/internal.h    |  1 +
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 25 +++++++++++++++++++----
 3 files changed, 24 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index 1dafbdc5ac31..84f23327caed 100644
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
@@ -374,7 +374,6 @@ ssize_t rdtgroup_schemata_write(struct kernfs_open_file *of,
 {
 	struct resctrl_schema *s;
 	struct rdtgroup *rdtgrp;
-	struct rdt_domain *dom;
 	struct rdt_resource *r;
 	char *tok, *resname;
 	int ret = 0;
@@ -403,10 +402,7 @@ ssize_t rdtgroup_schemata_write(struct kernfs_open_file *of,
 		goto out;
 	}
 
-	list_for_each_entry(s, &resctrl_schema_all, list) {
-		list_for_each_entry(dom, &s->res->domains, list)
-			memset(dom->staged_config, 0, sizeof(dom->staged_config));
-	}
+	rdt_staged_configs_clear();
 
 	while ((tok = strsep(&buf, "\n")) != NULL) {
 		resname = strim(strsep(&tok, ":"));
@@ -451,6 +447,7 @@ ssize_t rdtgroup_schemata_write(struct kernfs_open_file *of,
 	}
 
 out:
+	rdt_staged_configs_clear();
 	rdtgroup_kn_unlock(of->kn);
 	cpus_read_unlock();
 	return ret ?: nbytes;
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 5f7128686cfd..0b5c6c76f6f7 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -537,5 +537,6 @@ bool has_busy_rmid(struct rdt_resource *r, struct rdt_domain *d);
 void __check_limbo(struct rdt_domain *d, bool force_free);
 void rdt_domain_reconfigure_cdp(struct rdt_resource *r);
 void __init thread_throttle_mode_init(void);
+void rdt_staged_configs_clear(void);
 
 #endif /* _ASM_X86_RESCTRL_INTERNAL_H */
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index e5a48f05e787..fee8ed86b31c 100644
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
@@ -2841,7 +2854,9 @@ static int rdtgroup_init_alloc(struct rdtgroup *rdtgrp)
 {
 	struct resctrl_schema *s;
 	struct rdt_resource *r;
-	int ret;
+	int ret = 0;
+
+	rdt_staged_configs_clear();
 
 	list_for_each_entry(s, &resctrl_schema_all, list) {
 		r = s->res;
@@ -2852,20 +2867,22 @@ static int rdtgroup_init_alloc(struct rdtgroup *rdtgrp)
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
2.27.0

