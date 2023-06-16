Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B13A73285F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 09:07:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241642AbjFPHHY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 03:07:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244184AbjFPHGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 03:06:55 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C79D35A2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 00:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686899194; x=1718435194;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BOTZijuFBGgF9HYlGd8ChHaPOkRYQrtLy4cnXooPCAY=;
  b=QeAM6/Uqd9ekCb/ZZqpcQ9E4MVEG03ZS7zAWNQAZjDPNyjBzRbiYIDRW
   tHN5HNKQZ1FlIqUHgCRj0gRl2vaSUUWB2otP/90VKkls6XXt5voL0FBZr
   eppnR08iwM5nFxvMa1iCiQHxlAh8jOJ+ls73DnOvUiA6Z4de0N7KYK4wd
   MFWMp8zBSdrNIMu064EU82CeZRj/CZMyMAs5aLV/CFW4n3Lx8nrE0XOdC
   x0TyLUcSJmtg1GnVThU/ADltxkjhkwyZAMVhtidmnTIScIs+4SGR6xBqA
   Re/zLk5p4L/++hGJNlqoQRc2sSaWJTcNwdjJfOmaR/jCrRO9P5rb6V/FS
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="361668717"
X-IronPort-AV: E=Sophos;i="6.00,246,1681196400"; 
   d="scan'208";a="361668717"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2023 00:06:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="782783610"
X-IronPort-AV: E=Sophos;i="6.00,246,1681196400"; 
   d="scan'208";a="782783610"
Received: from cpeng15-mobl.ccr.corp.intel.com (HELO yhuang6-mobl2.ccr.corp.intel.com) ([10.255.31.216])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2023 00:06:08 -0700
From:   Huang Ying <ying.huang@intel.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
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
Subject: [RFC 1/4] memory tiering: add abstract distance calculation algorithms management
Date:   Fri, 16 Jun 2023 15:05:35 +0800
Message-Id: <20230616070538.190042-2-ying.huang@intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230616070538.190042-1-ying.huang@intel.com>
References: <20230616070538.190042-1-ying.huang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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
index e593e56e530b..fb5398e710cc 100644
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
@@ -593,6 +596,62 @@ void clear_node_memory_type(int node, struct memory_dev_type *memtype)
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

