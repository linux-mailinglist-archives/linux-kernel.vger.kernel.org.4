Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 209DE605534
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 03:51:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231479AbiJTBve (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 21:51:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230463AbiJTBvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 21:51:32 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29971160ECA
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 18:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666230691; x=1697766691;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=jqVvHxPo050Zb28QPRhB5MKlDfuC+lZT57Gtdn8Tgy4=;
  b=D+dVk04IJhrjiVbY5hGN50z0dES/OQ4kdyuBdZqKHkt84J8qrCCXQ3M+
   XHDIecGdniKW/kWnQdCdJbdOgOnu6LEN03QYaZmMF5Hjv4ROWqUtrR+OB
   /3SVKo3LLil3bKBau0rS0FZu+MPel3Ojgek0PO+DG8EWGrMfkr5Ji2BFj
   fWiXCXbE7B4XkFHtMk6DaX3wi5v1ZgVIqozH9Ce2L1YktUW7pK+o7PeKy
   K1v3PelaqAFo/DQU9Za9EFeKwGTdq66JEjk0n0rkGNOEWspPenSp4Egr0
   PPggtfgRQv82Bp7F/mmm7gzzThuvT5n93AvGelIyfUNSX/yk1pk4qlF3p
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10505"; a="307679133"
X-IronPort-AV: E=Sophos;i="5.95,196,1661842800"; 
   d="scan'208";a="307679133"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2022 18:51:30 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10505"; a="772070468"
X-IronPort-AV: E=Sophos;i="5.95,196,1661842800"; 
   d="scan'208";a="772070468"
Received: from yhuang6-mobl2.sh.intel.com ([10.238.6.69])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2022 18:51:26 -0700
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
Subject: [PATCH] memory tier, sysfs: rename attribute "nodes" to "nodelist"
Date:   Thu, 20 Oct 2022 09:51:22 +0800
Message-Id: <20221020015122.290097-1-ying.huang@intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In sysfs, we use attribute name "cpumap" or "cpus" for cpu mask and
"cpulist" or "cpus_list" for cpu list.  For example, in my system,

 $ cat /sys/devices/system/node/node0/cpumap
 f,ffffffff
 $ cat /sys/devices/system/cpu/cpu2/topology/core_cpus
 0,00100004
 $ cat cat /sys/devices/system/node/node0/cpulist
 0-35
 $ cat /sys/devices/system/cpu/cpu2/topology/core_cpus_list
 2,20

It looks reasonable to use "nodemap" for node mask and "nodelist" for
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
index 45985e411f13..721a05b90109 100644
--- a/Documentation/ABI/testing/sysfs-kernel-mm-memory-tiers
+++ b/Documentation/ABI/testing/sysfs-kernel-mm-memory-tiers
@@ -10,7 +10,7 @@ Description:	A collection of all the memory tiers allocated.
 
 
 What:		/sys/devices/virtual/memory_tiering/memory_tierN/
-		/sys/devices/virtual/memory_tiering/memory_tierN/nodes
+		/sys/devices/virtual/memory_tiering/memory_tierN/nodelist
 Date:		August 2022
 Contact:	Linux memory management mailing list <linux-mm@kvack.org>
 Description:	Directory with details of a specific memory tier
@@ -21,5 +21,5 @@ Description:	Directory with details of a specific memory tier
 		A smaller value of N implies a higher (faster) memory tier in the
 		hierarchy.
 
-		nodes: NUMA nodes that are part of this memory tier.
+		nodelist: NUMA nodes that are part of this memory tier.
 
diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
index f116b7b6333e..fa8c9d07f9ce 100644
--- a/mm/memory-tiers.c
+++ b/mm/memory-tiers.c
@@ -131,8 +131,8 @@ static void memory_tier_device_release(struct device *dev)
 	kfree(tier);
 }
 
-static ssize_t nodes_show(struct device *dev,
-			  struct device_attribute *attr, char *buf)
+static ssize_t nodelist_show(struct device *dev,
+			     struct device_attribute *attr, char *buf)
 {
 	int ret;
 	nodemask_t nmask;
@@ -143,10 +143,10 @@ static ssize_t nodes_show(struct device *dev,
 	mutex_unlock(&memory_tier_lock);
 	return ret;
 }
-static DEVICE_ATTR_RO(nodes);
+static DEVICE_ATTR_RO(nodelist);
 
 static struct attribute *memtier_dev_attrs[] = {
-	&dev_attr_nodes.attr,
+	&dev_attr_nodelist.attr,
 	NULL
 };
 
-- 
2.35.1

