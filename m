Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AC856A77C3
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 00:38:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbjCAXie (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 18:38:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbjCAXiF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 18:38:05 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29FD4231CB
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 15:38:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677713884; x=1709249884;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=YMNfvnXnJB4uXk1mrYyUpmBPZvcLm4WxebEkvmrXwQo=;
  b=CJBa25oGEJxn4LTL8jAHNfe+jUoQGurN/0j6HEqERjU73wurLFNEfO8K
   TD6qA7BPuSaIUsD9Ug2juta3xaytRHr/1clN0XpsA4WTYGV/ehA26YyKe
   TlO4Q6gbhUEAWY63mZSuNz4DcSilXKm18YqypHc0mQcdOfvOPG92M10K6
   aplnVMwR45TnNpwiV3+U3vroDcbykfyHbe36k/KXtS65oFz+5SbDIuqLs
   nDczT0mjMFF29kh4PZ6DpRp0X1xdUe7dz4nGfVt1zu/bV88d/Tx0/T8iR
   4uCf2owDlnNmujkPLwePebOb4/DnkUSgO9BUXHRNi+l+a1H+BOvFQxPZT
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="420818734"
X-IronPort-AV: E=Sophos;i="5.98,225,1673942400"; 
   d="scan'208";a="420818734"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2023 15:37:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="738826831"
X-IronPort-AV: E=Sophos;i="5.98,225,1673942400"; 
   d="scan'208";a="738826831"
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
Subject: [PATCH v7 11/24] iommu/amd: Compose MSI messages for NMIs in non-IR format
Date:   Wed,  1 Mar 2023 15:47:40 -0800
Message-Id: <20230301234753.28582-12-ricardo.neri-calderon@linux.intel.com>
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

If NMIPass is enabled in a Device Table Entry, the IOMMU lets NMI interrupt
messages pass through unmapped. The contents of the MSI message, not an
IRTE, determine how and where the NMI is delivered.

The IOMMU driver owns the MSI message of the NMI. Compose it using the non-
interrupt-remapping format. Let descendant irqchips write the composed
message.

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
 * Reworded changelog to remove acronyms. (Thomas)
 * Removed confusing comment regarding interrupt vector cleanup after
   changing the affinity of an interrupt. (Thomas)

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
 drivers/iommu/amd/iommu.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 9bf71e7335f5..c6b0c365bf33 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -3254,7 +3254,16 @@ static void irq_remapping_prepare_irte(struct amd_ir_data *data,
 	case X86_IRQ_ALLOC_TYPE_HPET:
 	case X86_IRQ_ALLOC_TYPE_PCI_MSI:
 	case X86_IRQ_ALLOC_TYPE_PCI_MSIX:
-		fill_msi_msg(&data->msi_entry, irte_info->index);
+		if (irq_cfg->delivery_mode == APIC_DELIVERY_MODE_NMI)
+			/*
+			 * The IOMMU lets NMIs pass through unmapped. Thus, the
+			 * MSI message, not the IRTE, determines the interrupt
+			 * configuration. Since we own the MSI message,
+			 * compose it.
+			 */
+			__irq_msi_compose_msg(irq_cfg, &data->msi_entry, true);
+		else
+			fill_msi_msg(&data->msi_entry, irte_info->index);
 		break;
 
 	default:
@@ -3643,6 +3652,15 @@ static int amd_ir_set_affinity(struct irq_data *data,
 	 */
 	send_cleanup_vector(cfg);
 
+	/*
+	 * When the delivery mode of an interrupt is NMI, the IOMMU lets the NMI
+	 * interrupt messages pass through unmapped. Changes in the destination
+	 * must be reflected in the MSI message, not the IRTE. Descendant
+	 * irqchips must set the affinity and write the MSI message.
+	 */
+	if (cfg->delivery_mode == APIC_DELIVERY_MODE_NMI)
+		return IRQ_SET_MASK_OK;
+
 	return IRQ_SET_MASK_OK_DONE;
 }
 
-- 
2.25.1

