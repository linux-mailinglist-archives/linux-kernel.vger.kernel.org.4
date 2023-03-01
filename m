Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFF596A77BD
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 00:38:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbjCAXiP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 18:38:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjCAXiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 18:38:03 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21456191
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 15:38:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677713882; x=1709249882;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=X+fPhGM+miLCMioUQX1fq5QvQADp974IGsVIuBa8IIM=;
  b=Aql3E/ZuO4ARPqEBFylMJIskEl/mwYpErfaS7ZlfOX0oX67sUtAA8RYr
   iZQWNXj2ZEHYfxAXbTvJtX4BpjRGycs4demGZ7p+BRFcd6mv0T2L1S/iC
   nDMBZXynt5uPwD+/2YEFjWYwXB/Vgwbct0936YK5Lm49SYseYo2FVlpF1
   j74CQlOjyL0pbnbIR4ezJQmA2li6Ug5nOHRwQyUzms5TVbn59ySHr8bHD
   fOcfxB0nxQ5xM2YFf7MowjPvr1kqCYbKZlQS1Wrqs7P49yRqVQ7ikCJE5
   UTCSvTk3BtwtkZwxggOynuUZBTXJ6Cqri3OOYqyaKyfLxvz3eYahGSacx
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="420818700"
X-IronPort-AV: E=Sophos;i="5.98,225,1673942400"; 
   d="scan'208";a="420818700"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2023 15:37:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="738826807"
X-IronPort-AV: E=Sophos;i="5.98,225,1673942400"; 
   d="scan'208";a="738826807"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmsmga008.fm.intel.com with ESMTP; 01 Mar 2023 15:37:56 -0800
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
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v7 06/24] iommu/vt-d: Clear the redirection hint when the destination mode is physical
Date:   Wed,  1 Mar 2023 15:47:35 -0800
Message-Id: <20230301234753.28582-7-ricardo.neri-calderon@linux.intel.com>
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

When the destination mode of an interrupt is physical APICID, the interrupt
is delivered only to the single CPU of which the physical APICID is
specified in the destination ID field. The redirection hint is meaningless.

Furthermore, on certain processors, the IOMMU does not deliver the
interrupt when the delivery mode is NMI, the redirection hint is set, and
the destination mode is physical. Clearing the redirection hint ensures
that the NMI is delivered.

Cc: Andi Kleen <ak@linux.intel.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>
Cc: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Stephane Eranian <eranian@google.com>
Cc: iommu@lists.linux-foundation.org
Cc: linuxppc-dev@lists.ozlabs.org
Suggested-by: Ashok Raj <ashok.raj@intel.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
Changes since v6:
 * None

Changes since v5:
 * Introduced this patch.

Changes since v4:
 * N/A

Changes since v3:
 * N/A

Changes since v2:
 * N/A

Changes since v1:
 * N/A
---
 drivers/iommu/intel/irq_remapping.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/irq_remapping.c b/drivers/iommu/intel/irq_remapping.c
index 6d01fa078c36..2d68f94ae0ee 100644
--- a/drivers/iommu/intel/irq_remapping.c
+++ b/drivers/iommu/intel/irq_remapping.c
@@ -1123,7 +1123,17 @@ static void prepare_irte(struct irte *irte, int vector, unsigned int dest)
 	irte->dlvry_mode = apic->delivery_mode;
 	irte->vector = vector;
 	irte->dest_id = IRTE_DEST(dest);
-	irte->redir_hint = 1;
+
+	/*
+	 * When using the destination mode of physical APICID, only the
+	 * processor specified in @dest receives the interrupt. The redirection
+	 * hint is meaningless.
+	 *
+	 * Furthermore, on some processors, NMIs with physical delivery mode
+	 * and the redirection hint set are delivered as regular interrupts
+	 * or not delivered at all.
+	 */
+	irte->redir_hint = apic->dest_mode_logical;
 }
 
 struct irq_remap_ops intel_irq_remap_ops = {
-- 
2.25.1

