Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0A5073D1A5
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 17:18:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbjFYPSG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 11:18:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbjFYPSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 11:18:04 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 968211B9
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 08:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687706283; x=1719242283;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mN/2WK8J7n2rewlZ5IincQ/OigkXaXVK51epQ2blgdQ=;
  b=HMzrtJ+NE/XMqkhhKJAxwHNriLzW71B4XhiL10MGRytkgSDV3sIQ9ENl
   VRK6AX0fUG3X+YuoZEDtmShUlpObQg8PasedvcQ0ByZ9gO2/0hqSDxrW3
   fPKJON1D5z1lLxDU9SeZ6vF7Df+jannAmCz8C/InnWOlwCK1LZy16eXL9
   by1xDaFUs4wUY+KF3OqfbEPQ6Z0tT3iOZMr8uCLKhepcRJwT1fk+gPZHO
   /3SXk7dvaw7vmKDqoAt6rq7UAAjU0P0jv5VEo4ReLmYnOZ3NkjYGCEYEc
   0WHc+WggR6tifyawVF1SvGBvR4cEiAO+Kk/NnYFw4dt7oDhwMvAy//4mO
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10752"; a="391255057"
X-IronPort-AV: E=Sophos;i="6.01,157,1684825200"; 
   d="scan'208";a="391255057"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2023 08:18:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10752"; a="840004517"
X-IronPort-AV: E=Sophos;i="6.01,157,1684825200"; 
   d="scan'208";a="840004517"
Received: from cascade.sh.intel.com ([10.239.48.162])
  by orsmga004.jf.intel.com with ESMTP; 25 Jun 2023 08:18:01 -0700
From:   Jingqi Liu <Jingqi.liu@intel.com>
To:     iommu@lists.linux.dev, Lu Baolu <baolu.lu@linux.intel.com>,
        Tian Kevin <kevin.tian@intel.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     linux-kernel@vger.kernel.org, Jingqi Liu <Jingqi.liu@intel.com>
Subject: [PATCH 1/5] iommu/vt-d: debugfs: Define domain_translation_struct file ops
Date:   Sun, 25 Jun 2023 23:04:38 +0800
Message-Id: <20230625150442.42197-2-Jingqi.liu@intel.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20230625150442.42197-1-Jingqi.liu@intel.com>
References: <20230625150442.42197-1-Jingqi.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Define domain_translation_struct file_operations instead of using
DEFINE_SHOW_ATTRIBUTE() in order to specify source identifier and pasid
to dump the specified page table.

Signed-off-by: Jingqi Liu <Jingqi.liu@intel.com>
---
 drivers/iommu/intel/debugfs.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/debugfs.c b/drivers/iommu/intel/debugfs.c
index 1f925285104e..072cfef19175 100644
--- a/drivers/iommu/intel/debugfs.c
+++ b/drivers/iommu/intel/debugfs.c
@@ -391,7 +391,25 @@ static int domain_translation_struct_show(struct seq_file *m, void *unused)
 	return bus_for_each_dev(&pci_bus_type, NULL, m,
 				show_device_domain_translation);
 }
-DEFINE_SHOW_ATTRIBUTE(domain_translation_struct);
+
+static int domain_translation_struct_open(struct inode *inode,
+					  struct file *filp)
+{
+	/*
+	 * Allocate one 1Mbyte buffer to save sequential file output,
+	 * since the default size of input buffer is 1Mbyte when the
+	 * user reads.
+	 */
+	return single_open_size(filp, domain_translation_struct_show,
+				inode->i_private, SZ_1M);
+}
+
+static const struct file_operations domain_translation_struct_fops = {
+	.open		= domain_translation_struct_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
 
 static void invalidation_queue_entry_show(struct seq_file *m,
 					  struct intel_iommu *iommu)
-- 
2.21.3

