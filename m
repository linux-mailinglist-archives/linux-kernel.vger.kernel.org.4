Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 354BD73D1A8
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 17:18:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbjFYPSa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 11:18:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230254AbjFYPSM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 11:18:12 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFEF41BE
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 08:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687706290; x=1719242290;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MWvly+gTVz1Bc7knQ7hqBn1J0RvVjUjDzsQTS3OHj+c=;
  b=XaR/Kx0r/Ud++EzlBr2hzv3B9D6Td/FK/jtukZfcYDy4hT52gLqnAfbY
   xOGUmd+yiPmLAFA50tN+GmXlKWvZlwX8Xf+blAuVutuR83IEo7bnfmM41
   zUzS0Z47W3XOakcqAygR/KKkcetcN5WQuprhrEp4Oz9P7Qnkhk8JoNXU7
   pQqv3fFhvtiNtzJ34TEmhhBqeKFFSDW7wcw4PZTUhZddUuuZVu77bqTCG
   U3RZ2WR5qf0bS8r1lVcinikh5I4ovwv5g2BdgzuOSOeN1Wv35wwMe7mvJ
   NJiPz3b1NaxN51AdFKj+k+73f+wo6B24qbi3wzZ94btEQQty6JAzDHAaA
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10752"; a="391255084"
X-IronPort-AV: E=Sophos;i="6.01,157,1684825200"; 
   d="scan'208";a="391255084"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2023 08:18:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10752"; a="840004538"
X-IronPort-AV: E=Sophos;i="6.01,157,1684825200"; 
   d="scan'208";a="840004538"
Received: from cascade.sh.intel.com ([10.239.48.162])
  by orsmga004.jf.intel.com with ESMTP; 25 Jun 2023 08:18:08 -0700
From:   Jingqi Liu <Jingqi.liu@intel.com>
To:     iommu@lists.linux.dev, Lu Baolu <baolu.lu@linux.intel.com>,
        Tian Kevin <kevin.tian@intel.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     linux-kernel@vger.kernel.org, Jingqi Liu <Jingqi.liu@intel.com>
Subject: [PATCH 4/5] iommu/vt-d: debugfs: Support dumping a specified page table
Date:   Sun, 25 Jun 2023 23:04:41 +0800
Message-Id: <20230625150442.42197-5-Jingqi.liu@intel.com>
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

The original debugfs only dumps all page tables without pasid. With
pasid supported, the page table with pasid also needs to be dumped.

This patch supports dumping a specified page table or all page tables in
legacy mode or scalable mode.

For legacy mode, according to bus number and DEVFN, traverse the root
table and context table to get the pointer of page table in the context
table entry, then dump the page table.

For scalable mode, according to bus number, DEVFN and pasid, traverse
the root table, context table, pasid directory and pasid table to get
the pointer of page table in the pasid table entry, then dump it.

Examples are as follows:
1) Dump the page table of device "00:1f.0" that only supports legacy mode.
$ sudo echo 00:1f.0 >
/sys/kernel/debug/iommu/intel/domain_translation_struct
$ sudo cat /sys/kernel/debug/iommu/intel/domain_translation_struct

2) Dump the page table of device "00:0a.0" with PASID "1".
$ sudo echo 00:0a.0,1 >
/sys/kernel/debug/iommu/intel/domain_translation_struct
$ sudo cat /sys/kernel/debug/iommu/intel/domain_translation_struct

3) Dump all page tables.
$ sudo echo "auto" >
/sys/kernel/debug/iommu/intel/domain_translation_struct
$ sudo cat /sys/kernel/debug/iommu/intel/domain_translation_struct

Signed-off-by: Jingqi Liu <Jingqi.liu@intel.com>
---
 drivers/iommu/intel/debugfs.c | 191 ++++++++++++++++++++++++++++------
 1 file changed, 159 insertions(+), 32 deletions(-)

diff --git a/drivers/iommu/intel/debugfs.c b/drivers/iommu/intel/debugfs.c
index 212d33598de9..e4d3b7836076 100644
--- a/drivers/iommu/intel/debugfs.c
+++ b/drivers/iommu/intel/debugfs.c
@@ -404,56 +404,183 @@ static void dump_translation_page_table(struct seq_file *m)
 	return;
 }
 
-static int __show_device_domain_translation(struct device *dev, void *data)
+/*
+ * Dump the page table with the specified device and pasid.
+ * For legacy mode, search root and context tables to find
+ * the page table.
+ * For scalable mode, search root, context, pasid directory
+ * and pasid tables to find the page table.
+ * If not specify device, it will traverse all devices and
+ * pasid tables, and then dump all page tables.
+ */
+static int show_device_domain_translation(struct show_domain_info *sinfo,
+		                          void *data)
 {
-	struct dmar_domain *domain;
+	bool walk_tbl = false, found = false;
+	u16 s_devfn = 0, e_devfn = 255, devfn;
+	u16 s_bus = 0, e_bus = 255, bus, seg;
+	struct dmar_drhd_unit *drhd;
+	struct intel_iommu *iommu;
 	struct seq_file *m = data;
-	u64 path[6] = { 0 };
+	bool scalable;
 
-	domain = to_dmar_domain(iommu_get_domain_for_dev(dev));
-	if (!domain)
-		return 0;
+	if (sinfo && sinfo->pdev) {
+		s_bus = sinfo->pdev->bus->number;
+		e_bus = sinfo->pdev->bus->number;
+		s_devfn = sinfo->pdev->devfn;
+		e_devfn = sinfo->pdev->devfn;
+		seg = pci_domain_nr(sinfo->pdev->bus);
+	} else
+		walk_tbl = true;
 
-	seq_printf(m, "Device %s @0x%llx\n", dev_name(dev),
-		   (u64)virt_to_phys(domain->pgd));
-	seq_puts(m, "IOVA_PFN\t\tPML5E\t\t\tPML4E\t\t\tPDPE\t\t\tPDE\t\t\tPTE\n");
-
-	pgtable_walk_level(m, domain->pgd, domain->agaw + 2, 0, path);
-	seq_putc(m, '\n');
+	rcu_read_lock();
+	for_each_active_iommu(iommu, drhd) {
+		struct context_entry *context;
+		u64 pgd, path[6] = { 0 };
+		u32 sts, agaw;
 
-	/* Don't iterate */
-	return 1;
-}
+		if (sinfo && sinfo->pdev && (seg != iommu->segment))
+			continue;
 
-static int show_device_domain_translation(struct device *dev, void *data)
-{
-	struct iommu_group *group;
+		sts = dmar_readl(iommu->reg + DMAR_GSTS_REG);
+		if (!(sts & DMA_GSTS_TES)) {
+			seq_printf(m, "DMA Remapping is not enabled on %s\n",
+				   iommu->name);
+			continue;
+		}
+		if (dmar_readq(iommu->reg + DMAR_RTADDR_REG) & DMA_RTADDR_SMT)
+			scalable = true;
+		else
+			scalable = false;
 
-	group = iommu_group_get(dev);
-	if (group) {
 		/*
-		 * The group->mutex is held across the callback, which will
-		 * block calls to iommu_attach/detach_group/device. Hence,
+		 * The iommu->lock is held across the callback, which will
+		 * block calls to domain_attach/domain_detach. Hence,
 		 * the domain of the device will not change during traversal.
 		 *
-		 * All devices in an iommu group share a single domain, hence
-		 * we only dump the domain of the first device. Even though,
-		 * this code still possibly races with the iommu_unmap()
-		 * interface. This could be solved by RCU-freeing the page
-		 * table pages in the iommu_unmap() path.
+		 * Traversing page table possibly races with the iommu_unmap()
+		 * interface. This could be solved by incrementing the
+		 * reference count of page table page before traversal and
+		 * decrementing the reference count after traversal.
 		 */
-		iommu_group_for_each_dev(group, data,
-					 __show_device_domain_translation);
-		iommu_group_put(group);
+		spin_lock(&iommu->lock);
+		for (bus = s_bus; bus <= e_bus; bus++) {
+			for (devfn = s_devfn; devfn <= e_devfn; devfn++) {
+				context = iommu_context_addr(iommu, bus, devfn, 0);
+				if (!context || !context_present(context))
+					continue;
+
+				if (!scalable) { /* legacy mode */
+					pgd = context->lo & VTD_PAGE_MASK;
+					agaw = context->hi & 7;
+
+					seq_printf(m, "Device %04x:%02x:%02x.%x @0x%llx\n",
+						   iommu->segment, bus, PCI_SLOT(devfn), PCI_FUNC(devfn), pgd);
+					seq_printf(m, "%-17s\t%-18s\t%-18s\t%-18s\t%-18s\t%-s\n",
+						   "IOVA_PFN", "PML5E", "PML4E", "PDPE", "PDE", "PTE");
+					pgtable_walk_level(m, phys_to_virt(pgd), agaw + 2, 0, path);
+					seq_putc(m, '\n');
+
+					found = true;
+				} else { /* scalable mode */
+					struct tbl_walk tbl_wlk = {0};
+					struct pasid_dir_entry *dir_tbl, *dir_entry;
+					struct pasid_entry *pasid_tbl, *pasid_tbl_entry;
+					u16 pasid_dir_size, dir_idx, tbl_idx;
+					u64 pasid_dir_ptr;
+
+					tbl_wlk.segment = iommu->segment;
+					tbl_wlk.bus = bus;
+					tbl_wlk.devfn = devfn;
+					tbl_wlk.rt_entry = &iommu->root_entry[bus];
+					tbl_wlk.ctx_entry = context;
+					tbl_wlk.dump_page_table = true;
+					m->private = &tbl_wlk;
+
+					pasid_dir_ptr = context->lo & VTD_PAGE_MASK;
+					pasid_dir_size = get_pasid_dir_size(context);
+
+					if (walk_tbl) {
+						pasid_dir_walk(m, pasid_dir_ptr, pasid_dir_size);
+						continue;
+					}
+
+					if (sinfo && sinfo->pasid == INVALID_IOASID) {
+						spin_unlock(&iommu->lock);
+						goto unlock_out;
+					}
+
+					/* Dump specified device domain mappings with PASID. */
+					dir_idx = sinfo->pasid >> PASID_PDE_SHIFT;
+					tbl_idx = sinfo->pasid & PASID_PTE_MASK;
+
+					dir_tbl = phys_to_virt(pasid_dir_ptr);
+					dir_entry = &dir_tbl[dir_idx];
+
+					pasid_tbl = get_pasid_table_from_pde(dir_entry);
+					if (!pasid_tbl)
+						continue;
+
+					pasid_tbl_entry = &pasid_tbl[tbl_idx];
+					if (!pasid_pte_is_present(pasid_tbl_entry))
+						continue;
+
+					tbl_wlk.pasid = sinfo->pasid;
+					tbl_wlk.pasid_tbl_entry = pasid_tbl_entry;
+					dump_translation_page_table(m);
+
+					found = true;
+				}
+			}
+		}
+
+		spin_unlock(&iommu->lock);
+		if (!walk_tbl && found)
+			break;
 	}
 
+unlock_out:
+	rcu_read_unlock();
+
+	if (!walk_tbl && !found && (sinfo->pasid != INVALID_IOASID))
+		seq_printf(m, "No mappings found on device %s with pasid %x.\n",
+			   dev_name(&sinfo->pdev->dev), sinfo->pasid);
 	return 0;
 }
 
 static int domain_translation_struct_show(struct seq_file *m, void *unused)
 {
-	return bus_for_each_dev(&pci_bus_type, NULL, m,
-				show_device_domain_translation);
+	int ret;
+
+	if (show_domain_info && show_domain_info->pdev) {
+		struct device_domain_info *info =
+			dev_iommu_priv_get(&show_domain_info->pdev->dev);
+
+		if (info) {
+			/*
+			 * The domain has already exited, and will
+			 * switch to the default domain next.
+			 */
+			if (!info->domain)
+				return 0;
+
+			if (info->pasid_enabled &&
+			    (show_domain_info->pasid == INVALID_IOASID))
+				show_domain_info->pasid = PASID_RID2PASID;
+			else if (!info->pasid_enabled &&
+			         (show_domain_info->pasid != INVALID_IOASID)) {
+				seq_printf(m, "Device %s does not support PASID.\n",
+				           dev_name(&show_domain_info->pdev->dev));
+				return 0;
+			}
+		} else
+			show_domain_info->pasid = PASID_RID2PASID;
+
+		ret = show_device_domain_translation(show_domain_info, m);
+	} else
+		ret = show_device_domain_translation(NULL, m);
+
+	return ret;
 }
 
 static ssize_t domain_translation_struct_write(struct file *filp,
-- 
2.21.3

