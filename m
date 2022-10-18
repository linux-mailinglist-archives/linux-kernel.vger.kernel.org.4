Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 020846023BB
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 07:26:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbiJRF0K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 01:26:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbiJRF0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 01:26:09 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57C2272846
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 22:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666070768; x=1697606768;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=y2RqQYPqokfPxKDpaiZB+BcZNoeDLOFn+N6zZNXnkDQ=;
  b=Akk6ViUi01foHqe4SVTfDAlb0VsXTr6cU2db0zoZg6znX1h3SYAzrNQd
   SmoFhqbZMVM+yIseyvgHu4vOTZBFoEVFY9PnOVUi6BestehdQBQDcmPBK
   Bom+TvtFtwwqUQngpSNncPH1Ck38R8ca704v0Ws7EEyhFZ+4Q/MBAC0zV
   oW4sFOcr4/Xhzb2ukCkpe9DyF0wMV8z65ZMQ49gAt2daOj3PVwN3/tiQk
   Hm5rAgoAhh+BDFcUYLTskworCFp7s0cHP7bo+GsXWGdvc9dX3XP6DUGnX
   VYAmFjPFFqAVxkLtFMJ643zOqu94YenDvPcNnX2em+z3dQKz0o9wSi84j
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10503"; a="392303383"
X-IronPort-AV: E=Sophos;i="5.95,193,1661842800"; 
   d="scan'208";a="392303383"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2022 22:26:08 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10503"; a="771043863"
X-IronPort-AV: E=Sophos;i="5.95,193,1661842800"; 
   d="scan'208";a="771043863"
Received: from yhuang6-mobl2.sh.intel.com ([10.238.6.69])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2022 22:26:02 -0700
From:   Huang Ying <ying.huang@intel.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Huang Ying <ying.huang@intel.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Alistair Popple <apopple@nvidia.com>,
        Bharata B Rao <bharata@amd.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Hesham Almatary <hesham.almatary@huawei.com>,
        Jagdish Gediya <jvgediya.oss@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Michal Hocko <mhocko@kernel.org>,
        Tim Chen <tim.c.chen@intel.com>, Wei Xu <weixugc@google.com>,
        Yang Shi <shy828301@gmail.com>
Subject: [RFC] memory tier, sysfs: rename attribute "nodes" to "nodes_list"
Date:   Tue, 18 Oct 2022 13:25:41 +0800
Message-Id: <20221018052541.265708-1-ying.huang@intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In sysfs, we use attribute name "cpus" for cpu mask and "cpus_list"
for cpu list.  For example, in my system,

 $ cat /sys/devices/system/cpu/cpu2/topology/core_cpus
 0,00100004
 $ cat /sys/devices/system/cpu/cpu2/topology/core_cpus_list
 2,20

It looks reasonable to use "nodes" for node mask and "nodes_list" for
node list.  So, rename the attribute to follow the naming convention.

Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Cc: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Cc: Alistair Popple <apopple@nvidia.com>
Cc: Bharata B Rao <bharata@amd.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: Hesham Almatary <hesham.almatary@huawei.com>
Cc: Jagdish Gediya <jvgediya.oss@gmail.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Tim Chen <tim.c.chen@intel.com>
Cc: Wei Xu <weixugc@google.com>
Cc: Yang Shi <shy828301@gmail.com>
---
 Documentation/ABI/testing/sysfs-kernel-mm-memory-tiers | 4 ++--
 mm/memory-tiers.c                                      | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-memory-tiers b/Documentation/ABI/testing/sysfs-kernel-mm-memory-tiers
index 45985e411f13..af07e166f559 100644
--- a/Documentation/ABI/testing/sysfs-kernel-mm-memory-tiers
+++ b/Documentation/ABI/testing/sysfs-kernel-mm-memory-tiers
@@ -10,7 +10,7 @@ Description:	A collection of all the memory tiers allocated.
 
 
 What:		/sys/devices/virtual/memory_tiering/memory_tierN/
-		/sys/devices/virtual/memory_tiering/memory_tierN/nodes
+		/sys/devices/virtual/memory_tiering/memory_tierN/nodes_list
 Date:		August 2022
 Contact:	Linux memory management mailing list <linux-mm@kvack.org>
 Description:	Directory with details of a specific memory tier
@@ -21,5 +21,5 @@ Description:	Directory with details of a specific memory tier
 		A smaller value of N implies a higher (faster) memory tier in the
 		hierarchy.
 
-		nodes: NUMA nodes that are part of this memory tier.
+		nodes_list: NUMA nodes that are part of this memory tier.
 
diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
index f116b7b6333e..8dbfe9ec87d5 100644
--- a/mm/memory-tiers.c
+++ b/mm/memory-tiers.c
@@ -131,8 +131,8 @@ static void memory_tier_device_release(struct device *dev)
 	kfree(tier);
 }
 
-static ssize_t nodes_show(struct device *dev,
-			  struct device_attribute *attr, char *buf)
+static ssize_t nodes_list_show(struct device *dev,
+			       struct device_attribute *attr, char *buf)
 {
 	int ret;
 	nodemask_t nmask;
@@ -143,10 +143,10 @@ static ssize_t nodes_show(struct device *dev,
 	mutex_unlock(&memory_tier_lock);
 	return ret;
 }
-static DEVICE_ATTR_RO(nodes);
+static DEVICE_ATTR_RO(nodes_list);
 
 static struct attribute *memtier_dev_attrs[] = {
-	&dev_attr_nodes.attr,
+	&dev_attr_nodes_list.attr,
 	NULL
 };
 
-- 
2.35.1

