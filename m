Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E804E5B8209
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 09:32:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbiINHcC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 03:32:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbiINHbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 03:31:53 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 686727171A
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 00:31:50 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id m10-20020a17090a730a00b001fa986fd8eeso18080970pjk.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 00:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=jc7xFT6mhtnxrIEcMacUso/5x0NDvllgocyZuMTs7Rc=;
        b=6VcGImYWSjqml2cSlokYPvwgthXECIOs37Mjs04Q/DenMtHS9gP1vL/El5NgBY56Tz
         Si9trp78ZA5dD11/pNy+izfOnvG/EKjO/2qMNHe5zNgm8SZsfVVnQgaqJiX6oRo9O8L6
         FLwqZQ8ualYx2JMrIHjHmFvx3+z9bPLieJOh9ptv+OldMugQm0CJdv+PRLXuZ9TriCVI
         +JN9zvSqpnwgo9NO2wZdOMkShnJwkrcGwnnKH6xjWEcgRpKzUj14Dx3lZh++3MzLL7DM
         ARFZSsY2TlO35kdd4KZxRqI5zyaNEFlLyC3mfcPv/ld+gdTKCND38XP2zEwOOah+f2Nr
         znLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=jc7xFT6mhtnxrIEcMacUso/5x0NDvllgocyZuMTs7Rc=;
        b=eCDptgKBrGpFU1Ifto7Ln2NOBMMuw+5swkvKpR19hV50NDicpcvQ15BN4tJ6zzushM
         SnVvzkqFIUjtISqTZCt/KFJd8wyCp7G5DMddMZHYxgb0ir3RofDkqpgRRtIQrvGtFYHq
         lPLkUgMLU9UPj5QVt1w4aOpxwOnSiTjpF01MOIShbalpZN8TZZ0MkAEEHWaK2rqTGfvn
         Knh5joNV6fRuaW2xpHuhcewkQSUycidMN+ZFUH6kydjHe+1xrIIo6bWB7t9cT1XwZ7MD
         rjL4MxoLEKKSsOWrvV2AzlRaTRJRikg8oyinMUZVCoyB6FnIr0yVhPc/1OTSanZb1vVZ
         isNQ==
X-Gm-Message-State: ACrzQf0W+BZ58N+Pu2aYneEILVUyOGjkxTSoRgPxn4ieo0uLfrPxSCBW
        FWV2n0vXPFy0rVVFWnqKJKBLsA==
X-Google-Smtp-Source: AMsMyM7NM3FoOoIfAL9hv+Njip2AbwzjblRZxDATyRfFMcTjFPnd+J48jJUZgpPNA0FjZTNUelAKtw==
X-Received: by 2002:a17:90b:3142:b0:202:eaca:8aed with SMTP id ip2-20020a17090b314200b00202eaca8aedmr3246114pjb.175.1663140709815;
        Wed, 14 Sep 2022 00:31:49 -0700 (PDT)
Received: from PXLDJ45XCM.bytedance.net ([61.120.150.76])
        by smtp.gmail.com with ESMTPSA id e2-20020a170902784200b001754cfb5e21sm9831042pln.96.2022.09.14.00.31.44
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 14 Sep 2022 00:31:49 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     gregkh@linuxfoundation.org, rafael@kernel.org,
        mike.kravetz@oracle.com, songmuchun@bytedance.com,
        akpm@linux-foundation.org, osalvador@suse.de, david@redhat.com,
        ying.huang@intel.com, aneesh.kumar@linux.ibm.com,
        rientjes@google.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        muchun.song@linux.dev
Subject: [PATCH v4 2/2] mm: hugetlb: eliminate memory-less nodes handling
Date:   Wed, 14 Sep 2022 15:26:03 +0800
Message-Id: <20220914072603.60293-3-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
In-Reply-To: <20220914072603.60293-1-songmuchun@bytedance.com>
References: <20220914072603.60293-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The memory-notify-based approach aims to handle meory-less nodes, however, it just adds
the complexity of code as pointed by David in thread [1].  The handling of memory-less
nodes is introduced by commit 4faf8d950ec4 ("hugetlb: handle memory hot-plug events").
From its commit message, we cannot find any necessity of handling this case. So, we can
simply register/unregister sysfs entries in register_node/unregister_node to simlify the
code.

BTW, hotplug callback added because in hugetlb_register_all_nodes() we register sysfs
nodes only for N_MEMORY nodes, seeing commit 9b5e5d0fdc91, which said it was a preparation
for handling memory-less nodes via memory hotplug. Since we want to remove memory hotplug,
so make sure we only register per-node sysfs for online (N_ONLINE) nodes in
hugetlb_register_all_nodes().

https://lore.kernel.org/linux-mm/60933ffc-b850-976c-78a0-0ee6e0ea9ef0@redhat.com/ [1]
Suggested-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Acked-by: David Hildenbrand <david@redhat.com>
---
v4:
 - Remove hugetlb_mark_sysfs_initialized() helper per David.

v3:
 - Fix 'struct node' is not declared reported by LTP.

v2:
 - Move declaration of function related to hugetlb to hugetlb.h (David).
 - Introduce hugetlb_sysfs_initialized() and call it from hugetlb_sysfs_init() (David).
 - Move hugetlb_register_all_nodes() into hugetlb_sysfs_init() (David).
 - Fix implicit-function-declaration reported by LKP.
 - Register per-node sysfs for online (N_ONLINE) nodes instead of N_MEMORY (Aneesh).

 drivers/base/node.c     |  8 ++++--
 include/linux/hugetlb.h | 14 ++++++++++
 mm/hugetlb.c            | 70 ++++++++++++++++++++-----------------------------
 3 files changed, 49 insertions(+), 43 deletions(-)

diff --git a/drivers/base/node.c b/drivers/base/node.c
index ed391cb09999..80b1e91b9608 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -20,6 +20,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/swap.h>
 #include <linux/slab.h>
+#include <linux/hugetlb.h>
 
 static struct bus_type node_subsys = {
 	.name = "node",
@@ -608,10 +609,12 @@ static int register_node(struct node *node, int num)
 	node->dev.groups = node_dev_groups;
 	error = device_register(&node->dev);
 
-	if (error)
+	if (error) {
 		put_device(&node->dev);
-	else
+	} else {
+		hugetlb_register_node(node);
 		compaction_register_node(node);
+	}
 
 	return error;
 }
@@ -625,6 +628,7 @@ static int register_node(struct node *node, int num)
  */
 void unregister_node(struct node *node)
 {
+	hugetlb_unregister_node(node);
 	compaction_unregister_node(node);
 	node_remove_accesses(node);
 	node_remove_caches(node);
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 890f7b6a2eff..a6fc49db0ce0 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -16,6 +16,7 @@
 struct ctl_table;
 struct user_struct;
 struct mmu_gather;
+struct node;
 
 #ifndef is_hugepd
 typedef struct { unsigned long pd; } hugepd_t;
@@ -935,6 +936,11 @@ static inline void huge_ptep_modify_prot_commit(struct vm_area_struct *vma,
 }
 #endif
 
+#ifdef CONFIG_NUMA
+void hugetlb_register_node(struct node *node);
+void hugetlb_unregister_node(struct node *node);
+#endif
+
 #else	/* CONFIG_HUGETLB_PAGE */
 struct hstate {};
 
@@ -1109,6 +1115,14 @@ static inline void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
 				   pte_t *ptep, pte_t pte)
 {
 }
+
+static inline void hugetlb_register_node(struct node *node)
+{
+}
+
+static inline void hugetlb_unregister_node(struct node *node)
+{
+}
 #endif	/* CONFIG_HUGETLB_PAGE */
 
 static inline spinlock_t *huge_pte_lock(struct hstate *h,
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 0a37e80730b7..d776d55a97b2 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3869,24 +3869,8 @@ static int hugetlb_sysfs_add_hstate(struct hstate *h, struct kobject *parent,
 	return 0;
 }
 
-static void __init hugetlb_sysfs_init(void)
-{
-	struct hstate *h;
-	int err;
-
-	hugepages_kobj = kobject_create_and_add("hugepages", mm_kobj);
-	if (!hugepages_kobj)
-		return;
-
-	for_each_hstate(h) {
-		err = hugetlb_sysfs_add_hstate(h, hugepages_kobj,
-					 hstate_kobjs, &hstate_attr_group);
-		if (err)
-			pr_err("HugeTLB: Unable to add hstate %s", h->name);
-	}
-}
-
 #ifdef CONFIG_NUMA
+static bool hugetlb_sysfs_initialized __ro_after_init;
 
 /*
  * node_hstate/s - associate per node hstate attributes, via their kobjects,
@@ -3942,7 +3926,7 @@ static struct hstate *kobj_to_node_hstate(struct kobject *kobj, int *nidp)
  * Unregister hstate attributes from a single node device.
  * No-op if no hstate attributes attached.
  */
-static void hugetlb_unregister_node(struct node *node)
+void hugetlb_unregister_node(struct node *node)
 {
 	struct hstate *h;
 	struct node_hstate *nhs = &node_hstates[node->dev.id];
@@ -3972,12 +3956,15 @@ static void hugetlb_unregister_node(struct node *node)
  * Register hstate attributes for a single node device.
  * No-op if attributes already registered.
  */
-static void hugetlb_register_node(struct node *node)
+void hugetlb_register_node(struct node *node)
 {
 	struct hstate *h;
 	struct node_hstate *nhs = &node_hstates[node->dev.id];
 	int err;
 
+	if (!hugetlb_sysfs_initialized)
+		return;
+
 	if (nhs->hugepages_kobj)
 		return;		/* already allocated */
 
@@ -3999,23 +3986,6 @@ static void hugetlb_register_node(struct node *node)
 	}
 }
 
-static int __meminit hugetlb_memory_callback(struct notifier_block *self,
-					     unsigned long action, void *arg)
-{
-	struct memory_notify *mnb = arg;
-	int nid = mnb->status_change_nid;
-
-	if (nid == NUMA_NO_NODE)
-		return NOTIFY_DONE;
-
-	if (action == MEM_GOING_ONLINE)
-		hugetlb_register_node(node_devices[nid]);
-	else if (action == MEM_CANCEL_ONLINE || action == MEM_OFFLINE)
-		hugetlb_unregister_node(node_devices[nid]);
-
-	return NOTIFY_OK;
-}
-
 /*
  * hugetlb init time:  register hstate attributes for all registered node
  * devices of nodes that have memory.  All on-line nodes should have
@@ -4025,11 +3995,8 @@ static void __init hugetlb_register_all_nodes(void)
 {
 	int nid;
 
-	get_online_mems();
-	hotplug_memory_notifier(hugetlb_memory_callback, 0);
-	for_each_node_state(nid, N_MEMORY)
+	for_each_online_node(nid)
 		hugetlb_register_node(node_devices[nid]);
-	put_online_mems();
 }
 #else	/* !CONFIG_NUMA */
 
@@ -4053,6 +4020,28 @@ static inline __init void hugetlb_cma_check(void)
 }
 #endif
 
+static void __init hugetlb_sysfs_init(void)
+{
+	struct hstate *h;
+	int err;
+
+	hugepages_kobj = kobject_create_and_add("hugepages", mm_kobj);
+	if (!hugepages_kobj)
+		return;
+
+	for_each_hstate(h) {
+		err = hugetlb_sysfs_add_hstate(h, hugepages_kobj,
+					 hstate_kobjs, &hstate_attr_group);
+		if (err)
+			pr_err("HugeTLB: Unable to add hstate %s", h->name);
+	}
+
+#ifdef CONFIG_NUMA
+	hugetlb_sysfs_initialized = true;
+#endif
+	hugetlb_register_all_nodes();
+}
+
 static int __init hugetlb_init(void)
 {
 	int i;
@@ -4107,7 +4096,6 @@ static int __init hugetlb_init(void)
 	report_hugepages();
 
 	hugetlb_sysfs_init();
-	hugetlb_register_all_nodes();
 	hugetlb_cgroup_file_init();
 
 #ifdef CONFIG_SMP
-- 
2.11.0

