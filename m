Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F9F7637924
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 13:43:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbiKXMnE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 07:43:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbiKXMmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 07:42:53 -0500
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC375EB2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 04:42:50 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=shawnwang@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0VVbIv-z_1669293757;
Received: from localhost(mailfrom:shawnwang@linux.alibaba.com fp:SMTPD_---0VVbIv-z_1669293757)
          by smtp.aliyun-inc.com;
          Thu, 24 Nov 2022 20:42:46 +0800
From:   Shawn Wang <shawnwang@linux.alibaba.com>
To:     fenghua.yu@intel.com, reinette.chatre@intel.com
Cc:     bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        james.morse@arm.com, jamie@nuviainc.com,
        linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de,
        x86@kernel.org
Subject: [PATCH v3] x86/resctrl: Clear staged_config[] before and after it is used
Date:   Thu, 24 Nov 2022 20:42:37 +0800
Message-Id: <20221124124237.65480-1-shawnwang@linux.alibaba.com>
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
    [ 6180.939345] unchecked MSR access error: WRMSR to 0xca0 (tried to write
    0x00000000000007ff) at rIP: 0xffffffff82249142 (cat_wrmsr+0x32/0x60)
    [ 6180.951983] Call Trace:
    [ 6180.954516]  <IRQ>
    [ 6180.956619]  __flush_smp_call_function_queue+0x11d/0x170
    [ 6180.962028]  __sysvec_call_function+0x24/0xd0
    [ 6180.966485]  sysvec_call_function+0x89/0xc0
    [ 6180.970760]  </IRQ>
    [ 6180.972947]  <TASK>
    [ 6180.975131]  asm_sysvec_call_function+0x16/0x20

When creating a new resource control group, hardware will be configured
by resctrl_arch_update_domains():
rdtgroup_mkdir()->rdtgroup_mkdir_ctrl_mon()->rdtgroup_init_alloc()->resctrl_arch_update_domains()

resctrl_arch_update_domains() iterates and updates all resctrl_conf_type
whose have_new_ctrl is true. Since staged_config[] holds the same values as
when CDP was enabled, it will continue to update the CDP_CODE and CDP_DATA
configurations. When group p8 is created, get_config_index() called in
resctrl_arch_update_domains() will return 16 and 17 as the CLOSIDs for
CDP_CODE and CDP_DATA, which will be translated to an invalid register -
0xca0 in this scenario.

Fix it by clearing staged_config[] before and after it is used.

Fixes: 75408e43509ed ("x86/resctrl: Allow different CODE/DATA configurations to be staged")
Cc: <stable@vger.kernel.org>
Signed-off-by: Shawn Wang <shawnwang@linux.alibaba.com>
Suggested-by: Xin Hao <xhao@linux.alibaba.com>
---
Changes since v2:
- Update the commit message suggested by Reiniette Chatre.
- Make the clearing work more robust.

Changes since v1:
- Move the clearing from schemata_list_destroy() to resctrl_arch_update_domains().
- Update the commit message suggested by Reiniette Chatre.
- Add stable tag suggested by James Morse.
---
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c |  7 ++-----
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 23 +++++++++++++++++++----
 include/linux/resctrl.h                   |  2 ++
 3 files changed, 23 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index 1dafbdc5ac31..93d1f11a1f19 100644
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
+	resctrl_staged_configs_clear();
 
 	while ((tok = strsep(&buf, "\n")) != NULL) {
 		resname = strim(strsep(&tok, ":"));
@@ -451,6 +447,7 @@ ssize_t rdtgroup_schemata_write(struct kernfs_open_file *of,
 	}
 
 out:
+	resctrl_staged_configs_clear();
 	rdtgroup_kn_unlock(of->kn);
 	cpus_read_unlock();
 	return ret ?: nbytes;
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index e5a48f05e787..fa00eafd3cd8 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -2841,7 +2841,9 @@ static int rdtgroup_init_alloc(struct rdtgroup *rdtgrp)
 {
 	struct resctrl_schema *s;
 	struct rdt_resource *r;
-	int ret;
+	int ret = 0;
+
+	resctrl_staged_configs_clear();
 
 	list_for_each_entry(s, &resctrl_schema_all, list) {
 		r = s->res;
@@ -2852,20 +2854,22 @@ static int rdtgroup_init_alloc(struct rdtgroup *rdtgrp)
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
+	resctrl_staged_configs_clear();
+	return ret;
 }
 
 static int mkdir_rdt_prepare(struct kernfs_node *parent_kn,
@@ -3380,6 +3384,17 @@ int resctrl_online_domain(struct rdt_resource *r, struct rdt_domain *d)
 	return 0;
 }
 
+void resctrl_staged_configs_clear(void)
+{
+	struct rdt_resource *r;
+	struct rdt_domain *dom;
+
+	for_each_alloc_capable_rdt_resource(r) {
+		list_for_each_entry(dom, &r->domains, list)
+			memset(dom->staged_config, 0, sizeof(dom->staged_config));
+	}
+}
+
 /*
  * rdtgroup_init - rdtgroup initialization
  *
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 0cf5b20c6ddf..2f7af447eaf2 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -250,6 +250,8 @@ int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_domain *d,
 void resctrl_arch_reset_rmid(struct rdt_resource *r, struct rdt_domain *d,
 			     u32 rmid, enum resctrl_event_id eventid);
 
+void resctrl_staged_configs_clear(void);
+
 extern unsigned int resctrl_rmid_realloc_threshold;
 extern unsigned int resctrl_rmid_realloc_limit;
 
-- 
2.27.0

