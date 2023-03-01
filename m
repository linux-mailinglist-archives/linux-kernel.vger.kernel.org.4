Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32DB56A77C6
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 00:38:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbjCAXin (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 18:38:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbjCAXiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 18:38:12 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2150E360B1
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 15:38:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677713885; x=1709249885;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=gdPe6IuTUA94m909UzTKj74jsvfoBAZ0rK9kosJdsBc=;
  b=LL5Fuxxn3JBVOQBoviJ+2jlCjC2uPVHazuNPLgPDXLhmNsNx5T8bBT1u
   wd3GGjdNVsoGULQOEAleRJbhTNdnhIi2iXbf5ZeQL17B9UswUOHXpzADD
   /a8Y33wxmGmdl4wq4cuvcuJx4RadsIwriOsOc5XA45RmmydYCZ10HQLna
   jmilN4AJy9dLSr4kki90K6/u0dHR7fJ5XLSPJcvohaZe2mkgVILLqBYVD
   hwMLi0fS6IRmBv47RuRrjpuyBa1S0hdVhPkKRukrp9TvYLdgxd7xuUHxL
   fvIQOFrJCaEThcE0mvLDMusDIrT2sMUsmI97dw+VmEm2aU40+jNdOTXyl
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="420818753"
X-IronPort-AV: E=Sophos;i="5.98,225,1673942400"; 
   d="scan'208";a="420818753"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2023 15:37:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="738826842"
X-IronPort-AV: E=Sophos;i="5.98,225,1673942400"; 
   d="scan'208";a="738826842"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmsmga008.fm.intel.com with ESMTP; 01 Mar 2023 15:37:58 -0800
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
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Subject: [PATCH v7 14/24] x86/hpet: Prepare IRQ assignments to use the X86_ALLOC_AS_NMI flag
Date:   Wed,  1 Mar 2023 15:47:43 -0800
Message-Id: <20230301234753.28582-15-ricardo.neri-calderon@linux.intel.com>
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

The flag X86_ALLOC_AS_NMI indicates that the interrupts to be allocated in
an interrupt domain need to be configured as NMIs. Add an as_nmi argument
to hpet_assign_irq(). The HPET clock events do not need NMIs, but the HPET
hardlockup detector does.

Cc: Andi Kleen <ak@linux.intel.com>
Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>
Cc: Stephane Eranian <eranian@google.com>
Cc: iommu@lists.linux-foundation.org
Cc: linuxppc-dev@lists.ozlabs.org
Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Tony Luck <tony.luck@intel.com>
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
 arch/x86/kernel/hpet.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/hpet.c b/arch/x86/kernel/hpet.c
index 3563849c2290..f42ce3fc4528 100644
--- a/arch/x86/kernel/hpet.c
+++ b/arch/x86/kernel/hpet.c
@@ -618,7 +618,7 @@ static inline int hpet_dev_id(struct irq_domain *domain)
 }
 
 static int hpet_assign_irq(struct irq_domain *domain, struct hpet_channel *hc,
-			   int dev_num)
+			   int dev_num, bool as_nmi)
 {
 	struct irq_alloc_info info;
 
@@ -627,6 +627,8 @@ static int hpet_assign_irq(struct irq_domain *domain, struct hpet_channel *hc,
 	info.data = hc;
 	info.devid = hpet_dev_id(domain);
 	info.hwirq = dev_num;
+	if (as_nmi)
+		info.flags |= X86_IRQ_ALLOC_AS_NMI;
 
 	return irq_domain_alloc_irqs(domain, 1, NUMA_NO_NODE, &info);
 }
@@ -755,7 +757,7 @@ static void __init hpet_select_clockevents(void)
 
 		sprintf(hc->name, "hpet%d", i);
 
-		irq = hpet_assign_irq(hpet_domain, hc, hc->num);
+		irq = hpet_assign_irq(hpet_domain, hc, hc->num, false);
 		if (irq <= 0)
 			continue;
 
-- 
2.25.1

