Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5813073D1A4
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 17:18:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230308AbjFYPSP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 11:18:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbjFYPSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 11:18:06 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F20441B7
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 08:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687706285; x=1719242285;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GBzP0QOzSLMJvNAZUflo7PPRyVHgUMz92AyAiFJMx5k=;
  b=P0eNZqAqEvl8Wejz0ZK7AS6ZMpMpaB4JoMHlyKeIfW1+kBpv7H9BjrlU
   kbRggPqXdmQf1pVwmtNAwzC/gglsZi1AhjW47a6SJI5RTK9pnzRjBOzJ+
   20RqNM5NZbWDR8BIkS8iJdA2piQ8csLlO9Gu+8yOrcIjvijcp2oGgSl5I
   qiyXxGGtR9a8QUWFDFsz7u4yiKjWN8wCbfmCEXykwfFm7vmVLfeQHoOg3
   Us9oSHD4R+JDyYmQHw8gSs9QpCqCC0MCHWzWe2mpdRsOTR2cL76NR7/Nt
   Nv+mqWqWSaKp8kUXnWCVAA/yAdu6ky45vfNjSs/L3h7iTiA+59yv1jHB7
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10752"; a="391255066"
X-IronPort-AV: E=Sophos;i="6.01,157,1684825200"; 
   d="scan'208";a="391255066"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2023 08:18:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10752"; a="840004527"
X-IronPort-AV: E=Sophos;i="6.01,157,1684825200"; 
   d="scan'208";a="840004527"
Received: from cascade.sh.intel.com ([10.239.48.162])
  by orsmga004.jf.intel.com with ESMTP; 25 Jun 2023 08:18:03 -0700
From:   Jingqi Liu <Jingqi.liu@intel.com>
To:     iommu@lists.linux.dev, Lu Baolu <baolu.lu@linux.intel.com>,
        Tian Kevin <kevin.tian@intel.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     linux-kernel@vger.kernel.org, Jingqi Liu <Jingqi.liu@intel.com>
Subject: [PATCH 2/5] iommu/vt-d: debugfs: Support specifying source identifier and PASID
Date:   Sun, 25 Jun 2023 23:04:39 +0800
Message-Id: <20230625150442.42197-3-Jingqi.liu@intel.com>
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

The original debugfs only dumps IOMMU page tables of all domains.
Usually developers want to dump the specified page table instead of all.

This patch supports users to specify the source identifier and PASID to
dump the specific page table.

For a device that only supports legacy mode, specify the source
identifier to dump its page table. For a device that supports scalable
mode, specify a {source identifier, PASID} pair to dump its page table.

Switch to dump all page tables by specifying "auto".

Examples are as follows:

1) Specify device "00:1f.0" that only supports legacy mode.
$ sudo echo 00:1f.0 >
/sys/kernel/debug/iommu/intel/domain_translation_struct

2) Specify device "00:0a.0" with PASID "1".
$ sudo echo 00:0a.0,1 >
/sys/kernel/debug/iommu/intel/domain_translation_struct

3) Specify all page tables:
$ sudo echo "auto" >
/sys/kernel/debug/iommu/intel/domain_translation_struct

Signed-off-by: Jingqi Liu <Jingqi.liu@intel.com>
---
 drivers/iommu/intel/debugfs.c | 86 ++++++++++++++++++++++++++++++++++-
 1 file changed, 85 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/debugfs.c b/drivers/iommu/intel/debugfs.c
index 072cfef19175..6d02cd91718a 100644
--- a/drivers/iommu/intel/debugfs.c
+++ b/drivers/iommu/intel/debugfs.c
@@ -32,6 +32,13 @@ struct iommu_regset {
 	const char *regs;
 };
 
+#define BUF_SIZE               64
+
+static struct show_domain_info {
+	struct pci_dev *pdev;
+	ioasid_t pasid;
+} *show_domain_info;
+
 #define DEBUG_BUFFER_SIZE	1024
 static char debug_buf[DEBUG_BUFFER_SIZE];
 
@@ -392,6 +399,82 @@ static int domain_translation_struct_show(struct seq_file *m, void *unused)
 				show_device_domain_translation);
 }
 
+static ssize_t domain_translation_struct_write(struct file *filp,
+		                               const char __user *ubuf,
+					       size_t cnt, loff_t *ppos)
+{
+	char buf[BUF_SIZE], *srcid_ptr = NULL, *pasid_ptr = NULL;
+	unsigned int seg, bus, slot, func;
+	struct pci_dev *pdev = NULL;
+	u32 pasid = INVALID_IOASID;
+	char *key, *pbuf;
+	int i = 0;
+
+	if (cnt >= BUF_SIZE)
+		return -EINVAL;
+
+	if (copy_from_user(buf, ubuf, cnt))
+		return -EFAULT;
+
+	buf[cnt - 1] = 0;
+	if (!strcmp(buf, "auto")) {
+		if (show_domain_info)
+			show_domain_info->pdev = NULL;
+		*ppos += cnt;
+		return cnt;
+	}
+
+	pbuf = buf;
+
+	/* Seperate the input: one {source identifier, PASID} pair */
+	while ((key = strsep(&pbuf, ", ")) != NULL) {
+		if (!*key)
+			continue;
+		if (i >= 2) /* too many fields */
+			return -EINVAL;
+		if (i++ == 0)
+			srcid_ptr = key;
+		else
+			pasid_ptr = key;
+	}
+
+	if (!srcid_ptr) /* no source identifier */
+		return -EINVAL;
+
+	/*
+	 * The string of source identifier must be of the form:
+	 * [<domain>:]<bus>:<device>.<func>
+	 */
+	i = sscanf(srcid_ptr, "%x:%x:%x.%x", &seg, &bus, &slot, &func);
+	if (i != 4) {
+		seg = 0;
+		i = sscanf(srcid_ptr, "%x:%x.%x", &bus, &slot, &func);
+		if (i != 3)
+			return -EINVAL;
+	}
+
+	pdev = pci_get_domain_bus_and_slot(seg, bus, PCI_DEVFN(slot, func));
+	if (!pdev)
+		return -EINVAL;
+
+	if (pasid_ptr &&
+	    ((kstrtou32(pasid_ptr, 0, &pasid) < 0) || (pasid >= PASID_MAX)))
+		return -EINVAL;
+
+	if (!show_domain_info) {
+		show_domain_info = kzalloc(sizeof(*show_domain_info),
+				           GFP_KERNEL);
+		if (!show_domain_info)
+			return -EINVAL;
+	}
+
+	show_domain_info->pdev = pdev;
+	show_domain_info->pasid = pasid;
+
+	*ppos += cnt;
+	return cnt;
+}
+
 static int domain_translation_struct_open(struct inode *inode,
 					  struct file *filp)
 {
@@ -406,6 +489,7 @@ static int domain_translation_struct_open(struct inode *inode,
 
 static const struct file_operations domain_translation_struct_fops = {
 	.open		= domain_translation_struct_open,
+	.write		= domain_translation_struct_write,
 	.read		= seq_read,
 	.llseek		= seq_lseek,
 	.release	= single_release,
@@ -691,7 +775,7 @@ void __init intel_iommu_debugfs_init(void)
 			    &iommu_regset_fops);
 	debugfs_create_file("dmar_translation_struct", 0444, intel_iommu_debug,
 			    NULL, &dmar_translation_struct_fops);
-	debugfs_create_file("domain_translation_struct", 0444,
+	debugfs_create_file("domain_translation_struct", 0644,
 			    intel_iommu_debug, NULL,
 			    &domain_translation_struct_fops);
 	debugfs_create_file("invalidation_queue", 0444, intel_iommu_debug,
-- 
2.21.3

