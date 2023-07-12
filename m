Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F20E750066
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 09:49:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231601AbjGLHtX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 03:49:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231509AbjGLHtV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 03:49:21 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61D101989
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 00:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689148160; x=1720684160;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oyCI5HLzYg6B8dSBk9eHwDqLZtZfH++WogxlpW3EVlc=;
  b=CCpea1Y8JfChiLzEwYeKGOmHDwb7XucutXG4QLfEsEaf1m1rNVgnxtKv
   I3uXTkOvgp+lO31+P6Ajph3aVW+78UCIkCX04A/b1J/S3ThvwNvKYImNA
   QA/HhLDSFyWKRV/ATkeEmjKa2d48tnHgFPZpBZZoYoXaHxmRnm201dNAS
   J7uucV7RTixgu3uAYudGzP29djiS6hvzC9cbc+R4u5uypOlp5vxCLLbBC
   JXnggtsScB541RZqAZ1TLVGVN2HfrXDyw40kPOq2v1RT3TAuxxmf9fDiP
   01NFSiI1c0N6/l7pLpAESyPGtDxTnZVA1KJilbhdhEIRbNeUb4840EVue
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="354734516"
X-IronPort-AV: E=Sophos;i="6.01,199,1684825200"; 
   d="scan'208";a="354734516"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2023 00:49:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="698744859"
X-IronPort-AV: E=Sophos;i="6.01,199,1684825200"; 
   d="scan'208";a="698744859"
Received: from yhuang6-mobl2.sh.intel.com ([10.238.6.30])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2023 00:49:16 -0700
From:   Huang Ying <ying.huang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Huang Ying <ying.huang@intel.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Wei Xu <weixugc@google.com>,
        Alistair Popple <apopple@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Michal Hocko <mhocko@kernel.org>,
        Yang Shi <shy828301@gmail.com>,
        Rafael J Wysocki <rafael.j.wysocki@intel.com>
Subject: [PATCH 1/4] memory tiering: add abstract distance calculation algorithms management
Date:   Wed, 12 Jul 2023 15:48:57 +0800
Message-Id: <20230712074900.404064-2-ying.huang@intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230712074900.404064-1-ying.huang@intel.com>
References: <20230712074900.404064-1-ying.huang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The abstract distance may be calculated by various drivers, such as
ACPI HMAT, CXL CDAT, etc.  While it may be used by various code which
hot-add memory node, such as dax/kmem etc.  To decouple the algorithm
users and the providers, the abstract distance calculation algorithms
management mechanism is implemented in this patch.  It provides
interface for the providers to register the implementation, and
interface for the users.

Multiple algorithm implementations can cooperate via calculating
abstract distance for different memory nodes.  The preference of
algorithm implementations can be specified via
priority (notifier_block.priority).

Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Cc: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Cc: Wei Xu <weixugc@google.com>
Cc: Alistair Popple <apopple@nvidia.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Yang Shi <shy828301@gmail.com>
Cc: Rafael J Wysocki <rafael.j.wysocki@intel.com>
---
 include/linux/memory-tiers.h | 19 ++++++++++++
 mm/memory-tiers.c            | 59 ++++++++++++++++++++++++++++++++++++
 2 files changed, 78 insertions(+)

diff --git a/include/linux/memory-tiers.h b/include/linux/memory-tiers.h
index fc9647b1b4f9..c6429e624244 100644
--- a/include/linux/memory-tiers.h
+++ b/include/linux/memory-tiers.h
@@ -6,6 +6,7 @@
 #include <linux/nodemask.h>
 #include <linux/kref.h>
 #include <linux/mmzone.h>
+#include <linux/notifier.h>
 /*
  * Each tier cover a abstrace distance chunk size of 128
  */
@@ -36,6 +37,9 @@ struct memory_dev_type *alloc_memory_type(int adistance);
 void destroy_memory_type(struct memory_dev_type *memtype);
 void init_node_memory_type(int node, struct memory_dev_type *default_type);
 void clear_node_memory_type(int node, struct memory_dev_type *memtype);
+int register_mt_adistance_algorithm(struct notifier_block *nb);
+int unregister_mt_adistance_algorithm(struct notifier_block *nb);
+int mt_calc_adistance(int node, int *adist);
 #ifdef CONFIG_MIGRATION
 int next_demotion_node(int node);
 void node_get_allowed_targets(pg_data_t *pgdat, nodemask_t *targets);
@@ -97,5 +101,20 @@ static inline bool node_is_toptier(int node)
 {
 	return true;
 }
+
+static inline int register_mt_adistance_algorithm(struct notifier_block *nb)
+{
+	return 0;
+}
+
+static inline int unregister_mt_adistance_algorithm(struct notifier_block *nb)
+{
+	return 0;
+}
+
+static inline int mt_calc_adistance(int node, int *adist)
+{
+	return NOTIFY_DONE;
+}
 #endif	/* CONFIG_NUMA */
 #endif  /* _LINUX_MEMORY_TIERS_H */
diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
index a516e303e304..1e55fbe2ad51 100644
--- a/mm/memory-tiers.c
+++ b/mm/memory-tiers.c
@@ -5,6 +5,7 @@
 #include <linux/kobject.h>
 #include <linux/memory.h>
 #include <linux/memory-tiers.h>
+#include <linux/notifier.h>
 
 #include "internal.h"
 
@@ -105,6 +106,8 @@ static int top_tier_adistance;
 static struct demotion_nodes *node_demotion __read_mostly;
 #endif /* CONFIG_MIGRATION */
 
+static BLOCKING_NOTIFIER_HEAD(mt_adistance_algorithms);
+
 static inline struct memory_tier *to_memory_tier(struct device *device)
 {
 	return container_of(device, struct memory_tier, dev);
@@ -592,6 +595,62 @@ void clear_node_memory_type(int node, struct memory_dev_type *memtype)
 }
 EXPORT_SYMBOL_GPL(clear_node_memory_type);
 
+/**
+ * register_mt_adistance_algorithm() - Register memory tiering abstract distance algorithm
+ * @nb: The notifier block which describe the algorithm
+ *
+ * Return: 0 on success, errno on error.
+ *
+ * Every memory tiering abstract distance algorithm provider needs to
+ * register the algorithm with register_mt_adistance_algorithm().  To
+ * calculate the abstract distance for a specified memory node, the
+ * notifier function will be called unless some high priority
+ * algorithm has provided result.  The prototype of the notifier
+ * function is as follows,
+ *
+ *   int (*algorithm_notifier)(struct notifier_block *nb,
+ *                             unsigned long nid, void *data);
+ *
+ * Where "nid" specifies the memory node, "data" is the pointer to the
+ * returned abstract distance (that is, "int *adist").  If the
+ * algorithm provides the result, NOTIFY_STOP should be returned.
+ * Otherwise, return_value & %NOTIFY_STOP_MASK == 0 to allow the next
+ * algorithm in the chain to provide the result.
+ */
+int register_mt_adistance_algorithm(struct notifier_block *nb)
+{
+	return blocking_notifier_chain_register(&mt_adistance_algorithms, nb);
+}
+EXPORT_SYMBOL_GPL(register_mt_adistance_algorithm);
+
+/**
+ * unregister_mt_adistance_algorithm() - Unregister memory tiering abstract distance algorithm
+ * @nb: the notifier block which describe the algorithm
+ *
+ * Return: 0 on success, errno on error.
+ */
+int unregister_mt_adistance_algorithm(struct notifier_block *nb)
+{
+	return blocking_notifier_chain_unregister(&mt_adistance_algorithms, nb);
+}
+EXPORT_SYMBOL_GPL(unregister_mt_adistance_algorithm);
+
+/**
+ * mt_calc_adistance() - Calculate abstract distance with registered algorithms
+ * @node: the node to calculate abstract distance for
+ * @adist: the returned abstract distance
+ *
+ * Return: if return_value & %NOTIFY_STOP_MASK != 0, then some
+ * abstract distance algorithm provides the result, and return it via
+ * @adist.  Otherwise, no algorithm can provide the result and @adist
+ * will be kept as it is.
+ */
+int mt_calc_adistance(int node, int *adist)
+{
+	return blocking_notifier_call_chain(&mt_adistance_algorithms, node, adist);
+}
+EXPORT_SYMBOL_GPL(mt_calc_adistance);
+
 static int __meminit memtier_hotplug_callback(struct notifier_block *self,
 					      unsigned long action, void *_arg)
 {
-- 
2.39.2

