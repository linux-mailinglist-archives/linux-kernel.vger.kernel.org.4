Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F87F6A77C7
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 00:38:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbjCAXiq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 18:38:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbjCAXiN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 18:38:13 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 754B93B3CB
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 15:38:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677713885; x=1709249885;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=btyWt/qyY31uspGHtLUS5h0GneCtSdCDc61owotTsK4=;
  b=A+xZZ4dONmyFBxhBz8CvYHZFjQ++OJeOSRNFyyrYvSMYJoIgXM8D/cVy
   5uoZtGkufpxe+HiXVhLLkpNY0cIUwDeHD8MHPtqGxmmaSyyhK0ws92JEZ
   AxIrm/JIV0JJPvSRBpNSj5Wh0VVSDSFZskXCKjZJzP94pLQ1QBPDmEyit
   mqXDEW5l9eqwbp19C20g43nXlQU4AJCns9uOPia1v+Y/qIDimIHCfyuLW
   W0d9QanCcfAu3yDzRx+PG32V0k4naM7t0HPnkUcSYw5WhchB1rryrm/1P
   xvpUK9B4toDkbtuk32Dp4FmIpssBNT6AkqYsKQYbBgZiGbA64viOx3yDl
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="420818728"
X-IronPort-AV: E=Sophos;i="5.98,225,1673942400"; 
   d="scan'208";a="420818728"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2023 15:37:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="738826826"
X-IronPort-AV: E=Sophos;i="5.98,225,1673942400"; 
   d="scan'208";a="738826826"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmsmga008.fm.intel.com with ESMTP; 01 Mar 2023 15:37:57 -0800
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     Tony Luck <tony.luck@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Len Brown <len.brown@intel.com>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Ricardo Neri <ricardo.neri@intel.com>,
        linuxppc-dev@lists.ozlabs.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v7 10/24] iommu/amd: Enable NMIPass when allocating an NMI
Date:   Wed,  1 Mar 2023 15:47:39 -0800
Message-Id: <20230301234753.28582-11-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230301234753.28582-1-ricardo.neri-calderon@linux.intel.com>
References: <20230301234753.28582-1-ricardo.neri-calderon@linux.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As per the AMD I/O Virtualization Technology (IOMMU) Specification, the
AMD IOMMU only remaps fixed and arbitrated MSIs. NMIs are controlled
by the NMIPass bit of a Device Table Entry. When set, the IOMMU passes
through NMI interrupt messages unmapped. Otherwise, they are aborted.

Also, Section 2.2.5 Table 19 states that the IOMMU will abort NMIs when the
destination mode is logical.

Update the NMIPass setting of a device's DTE when an NMI is being
allocated. Only do so when the destination mode of the APIC is not logical.

Cc: Andi Kleen <ak@linux.intel.com>
Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: Stephane Eranian <eranian@google.com>
Cc: iommu@lists.linux-foundation.org
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
Changes since v6:
 * Removed check for nr_irqs in irq_remapping_alloc(). Allocation had
   been rejected already in the root domain. (Thomas)

Changes since v5:
 * Introduced this patch

Changes since v4:
 * N/A

Changes since v3:
 * N/A

Changes since v2:
 * N/A

Changes since v1:
 * N/A
---
 drivers/iommu/amd/iommu.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 5a505ba5467e..9bf71e7335f5 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -3299,6 +3299,10 @@ static int irq_remapping_alloc(struct irq_domain *domain, unsigned int virq,
 	if (nr_irqs > 1 && info->type != X86_IRQ_ALLOC_TYPE_PCI_MSI)
 		return -EINVAL;
 
+	/* NMIs are aborted when the destination mode is logical. */
+	if (info->flags & X86_IRQ_ALLOC_AS_NMI && apic->dest_mode_logical)
+		return -EPERM;
+
 	sbdf = get_devid(info);
 	if (sbdf < 0)
 		return -EINVAL;
@@ -3348,6 +3352,13 @@ static int irq_remapping_alloc(struct irq_domain *domain, unsigned int virq,
 		goto out_free_parent;
 	}
 
+	if (info->flags & X86_IRQ_ALLOC_AS_NMI) {
+		if (!get_dev_entry_bit(iommu, devid, DEV_ENTRY_NMI_PASS)) {
+			set_dev_entry_bit(iommu, devid, DEV_ENTRY_NMI_PASS);
+			iommu_flush_dte(iommu, devid);
+		}
+	}
+
 	for (i = 0; i < nr_irqs; i++) {
 		irq_data = irq_domain_get_irq_data(domain, virq + i);
 		cfg = irq_data ? irqd_cfg(irq_data) : NULL;
-- 
2.25.1

